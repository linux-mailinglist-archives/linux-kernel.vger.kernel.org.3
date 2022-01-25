Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497C649B49C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356878AbiAYNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575373AbiAYNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:04:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD96C061779
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:04:51 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p27so56709799lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gnqs583Y3BfrRG808xRqv/vPmRDdR+9lKZ1Lg2jQfbI=;
        b=BsaZ4GwHyazWq9JVPuDeG1vlH2x1tBbDiP475fIiL2IdIrJRDyXLfC+W8VEZgSYlAb
         Vp9etEz/6tJ+DOc+vzVEQeMboHuHVGBZiYFbSnGsRAGCdEMdV4JzYS1vXhsjZOBZNhzS
         b7tiENehrDtN465pMUWL4f0PDVmdtIKkKH27NEiEmmAQZsTfhnNhlix6PN/4mxkunLPy
         0gxSYF0ETZtjJMeIhxqNvYGMUzycTXbkKKoSRJMHNmoGwCkvYrtHnysfgNnvskR68yqq
         FlFpxvgRp5YNjRkqLMkclBX79z/nwhX+A0LQNzUMRjrqxv1rjqz1Q/i4SQRy4yivJ/oZ
         7d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gnqs583Y3BfrRG808xRqv/vPmRDdR+9lKZ1Lg2jQfbI=;
        b=W6Ls/rAFUJ2VW73xg4cxY5kpYa5siI6FFcTH+uapY0ZMd0KtJIHEMEu5smM8xreFVF
         19idL6cqgYox2U6TGLF2FzahnIc5WAWMDUzZ7qdYwdu5t44+eiD5plZG4kPPL070uZ49
         R3gRPlHCmcVant3U9B7i+j7Wt+IETV6MtZ3cXDts9/8LtkLMDNY+5q9+XllvPMxOEDUC
         PL84yRk5dfXuR9cnJk05RveZ+vvW9YWunYLrBQrCoYYsM6OzMtce1Ywx4lH3dimXbqZ2
         0CYk9ENidpfE82XaZrF0srSUs2nK3W31LrA/TT/AgZjp4Jdz913N3Y2UHJayM3EpTs1H
         hMwg==
X-Gm-Message-State: AOAM533qP2LxEo6kQGXIKebGpla65+M3Ey5A6KPJLexVl2wP/00ovvC+
        aNWiTluSn/XVXly0fEoiE7M=
X-Google-Smtp-Source: ABdhPJzvIP3mbjCdT8pZEuhEz/3lHXJySNRPwqv2bHS10OOs2JPOZZGxLqBJw/HAN/JN6I3YiC0v+g==
X-Received: by 2002:a05:6512:3ca0:: with SMTP id h32mr5383923lfv.244.1643115890029;
        Tue, 25 Jan 2022 05:04:50 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id f20sm1202719ljk.73.2022.01.25.05.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:04:49 -0800 (PST)
Message-ID: <fa0a2717-aca7-a323-2e57-93a9f7b8c371@gmail.com>
Date:   Tue, 25 Jan 2022 16:04:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from os_dep dir
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-6-phil@philpotter.co.uk>
 <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
 <20220125125942.GS1978@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220125125942.GS1978@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 1/25/22 15:59, Dan Carpenter wrote:
> On Tue, Jan 25, 2022 at 03:48:32PM +0300, Pavel Skripkin wrote:
>> Hi Phillip,
>> 
>> On 1/25/22 01:44, Phillip Potter wrote:
>> > Remove all DBG_88E calls from the os_dep directory, other than those in
>> > os_dep/ioctl_linux.c, as this contains almost 200 on its own so will be
>> > done in a separate patch for ease of review. These calls do not conform
>> > to kernel coding standards and are superfluous. Also restructure where
>> > appropriate to remove no longer needed code left behind by removal of
>> > these calls. This will allow the eventual removal of the DBG_88E macro
>> > itself.
>> > 
>> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>> > ---
>> 
>> [code snip]
>> 
>> > -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
>> > -	 * suspend influence */
>> > -	if (usb_autopm_get_interface(pusb_intf) < 0)
>> > -			DBG_88E("can't get autopm:\n");
>> > -
>> 
>> Didn't you make a function change here? I didn't test and also didn't find
>> any mentions of tests in cover letter.
> 
> It is obviously a bug.  Please avoid ask rhetorical questions or someone
> will answer them.
> 

It isn't so obvious for me. Might be Phillip knows something about 
8723AS-VAU BT (whatever it is) issue.

I prefer not to say "it's an error", when I am not 100% sure :)


With regards,
Pavel Skripkin
