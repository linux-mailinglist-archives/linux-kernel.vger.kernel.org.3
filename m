Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF350184D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbiDNQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355238AbiDNP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:58:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B754DBD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:46:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 12so5787555oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KR/Wxn4SQ4JrdCT3cLRPKdG0x0HkSw7hlrSRgpKxYRQ=;
        b=WxGLEf6RY4Ooaba17rTS2bxOsi1wbArLPsvCGHueZ0EgeXSKI8ehlSomOomZ843peY
         MT99q2ov+J3Rtn4ISYH30xr3Fqbf1IGsbgowwpBIDPIQvgFnzUWNEuWywdaoAGAPT4uL
         hjKlgfvRRNnsfCBpmargyVQR5vZhmFI5OBkEE4wLrszAftAXofSKCQld/66XgO2DCTzt
         RdHJMW1EqEcEf710V5z7bovMgvXw2ghZFAhDl/dFmakku7S9OTCE0rp8sP+1XcjWQdUk
         RtYoMrRiKmRwVSW8GhJXnybLCwgwXRs8DxCsmkBZI9WovUrqv0NCVpQt02+LJAwNCNn8
         EyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KR/Wxn4SQ4JrdCT3cLRPKdG0x0HkSw7hlrSRgpKxYRQ=;
        b=Wi5u3KKjpv15MsMViuwbRCX5Bo/ZFyX+YfBbh5gxBi6n9OiEu34nK8YSEbPMTyuBRL
         frcfPXBvixepvsMaIiwKJKVa4hOvUFxBow9NqjhKgWnnVY35dMYR0LO6OcRbhJb6aHqV
         frwKRjIPy2dr+4gYOWRq8Lhf0ik61BAVKW623dniHtHUBr3xqYCoySWeWSy4HZqkczO2
         MLGhtUt67jZRQHqwrPqgDYWNmhB/IMHdIGhhG3t9vItkfFagu++EIacn/20Bpg8D6FT7
         PHJvfwXVDelet9GSgBrF3EfQhy5je0sp+6HejAy2rOFq+4FsB7wm36WwvO7jChGBsGOy
         Xyig==
X-Gm-Message-State: AOAM533l5eCA9go/pQb++2HXjzP1MH+FD1nG++CvcGF2eq+Q97XtTICN
        Ix1Cm0fefj4/4lKUkGQ1WNyYJNqc7beKeQ==
X-Google-Smtp-Source: ABdhPJzcKsa2KobE36DJzPycSbTLyQTt+rNh4aIE9O5a2+cQJKtrZ72LtxatOUPkgz5FF2E/PjnEbw==
X-Received: by 2002:a05:6808:18a0:b0:2d9:bde3:5776 with SMTP id bi32-20020a05680818a000b002d9bde35776mr1996277oib.29.1649951175554;
        Thu, 14 Apr 2022 08:46:15 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id pp23-20020a0568709d1700b000e2d876505dsm759641oab.32.2022.04.14.08.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:46:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8d067bcc-3405-420e-655f-ce97b8b5e798@lwfinger.net>
Date:   Thu, 14 Apr 2022 10:46:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: struct rt_firmware_header issues
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Michael Straube' <straube.linux@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
 <86a66ea4-45e3-cfa2-9130-f698ae212bfd@gmail.com>
 <51e706400b914552bfda6353020da17e@AcuMS.aculab.com>
 <a40a2a1b-a8f1-e720-be92-48858d4f6678@gmail.com>
 <74ff67ec85e14e16bb2e9f57a4fccb17@AcuMS.aculab.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <74ff67ec85e14e16bb2e9f57a4fccb17@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 05:14, David Laight wrote:
> From: Michael Straube
>> Sent: 14 April 2022 11:08
>>
>> On 4/14/22 10:41, David Laight wrote:
>>> From: Michael Straube
>>>> Sent: 13 April 2022 20:42
>>>>
>>>> On 4/13/22 18:27, Michael Straube wrote:
>>>>> Hi all,
>>>>>
>>>>> I think the rt_firmware_hdr structure in rtw_fw.c has some issues.
>>>>>
>>>>>
>>>>> struct rt_firmware_hdr {
>>>>>        /*  8-byte alinment required */
>>>
>>> Probably need an __aligned(8) at the bottom then?
>>
>> I don't see any reason why this is needed. Do I miss something?
> 
> Dunno, the comment might be wrong.

Actually, the le16_to_cpu() references require alignment 4 (I think I got that 
right).

Larry

