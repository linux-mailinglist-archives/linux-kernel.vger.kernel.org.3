Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3242548266C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 04:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiAADjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 22:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiAADjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 22:39:52 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD095C061574;
        Fri, 31 Dec 2021 19:39:51 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t66so14947754qkb.4;
        Fri, 31 Dec 2021 19:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cOmwaF/tJXP/5+yfkJDU/5HkcnePK8N/zdTNdlwYIvk=;
        b=MJRNuSA0i5e9NdJjfEcnlEdXR2SSoQrG2WitCEqfv8Y7W6AKBEWWPkAcCrBUlDv8se
         4D0jKcQaaQryoTpwCoGZRjyVwDHdv9TOyQwPAQYyMsNwiSekDqJB7IP4bHSNrgUAIyjr
         OTcV/0n8rQI30cnVwpmZefoF1yfZn9rFOvd/gnzbfvD81tRAHzNEOs3xjETeB11QrMa+
         mYmVRsIlQSN0h2D6lYv+W30i8gW7cuHMlf/47A2K7YGr8bT9r/NfUppLYcPMIGePUAqv
         GgaUKVvdHbcpkmPSh3soopi6Hjwh4NhoUxQlAoHxz5Caf1NuR8V/02JTfkVIzIHFzmAT
         yBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOmwaF/tJXP/5+yfkJDU/5HkcnePK8N/zdTNdlwYIvk=;
        b=FyjqTE7dT14nh85qprpG7ucx0LLFQjrrxs5E42vrbCPIkBpD8PhgCxhVYF2KZk7Izh
         90sNDsh8zy4fGanhlMRSHUxgquz4ILi3MrFmT4qZQI8FzMofUQ71jhITnYIw6nVjqOHo
         lLqmm81PPg2yshDIOmFQ+ALebNoxkTh0CDzo01QtfxOUf5VuwQ6SVhP1l+MiHJ4GoDpS
         rnBOErL7MDyVm95M3MarHk2CzWmiXhzxPhP3r0H4wnRmpCmXZ03D0LLJJF6vTlE0qGBQ
         2IxCJ/5lS6/nzucp+EVfSuUaoJxRZAN2QUR1nb16RLoTyUqKrOBO+IBOj0UfPsqz3FPb
         X1nA==
X-Gm-Message-State: AOAM530zjnZ1YiiQpZJgGUEc1UOpA5qn+MZdKhK0dwijFQv9AUEnoBje
        CoR0Z48ddZ21kDZttGsQsrydVGSMSkE=
X-Google-Smtp-Source: ABdhPJxnyakU3jWiWpdSGLZH8xc65waj5hW1rfqMQ99BXYlxqOO8Bw/rHUzOJx2D8SgEpgAr92es4g==
X-Received: by 2002:ae9:ef52:: with SMTP id d79mr26729925qkg.356.1641008390926;
        Fri, 31 Dec 2021 19:39:50 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id w2sm24433942qta.11.2021.12.31.19.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 19:39:50 -0800 (PST)
Subject: Re: [PATCH 0/2] of: unittest: re-implement overlay tracking
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, erhard_f@mailbox.org,
        yinxiujiang@kylinos.cn
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220101033329.1277779-1-frowand.list@gmail.com>
Message-ID: <d1af4cc8-eb7e-ec83-0e15-11d3d4791a29@gmail.com>
Date:   Fri, 31 Dec 2021 21:39:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220101033329.1277779-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erhard,

Can you please check whether this patch series fixes the shift-out-of-bounds
problem you reported?

-Frank


On 12/31/21 9:33 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Some overlays are tracked when they are applied.  The tracked overlays
> are later removed after the overlay tests are completed.  The old
> implementation makes assumptions about the expected values for
> overlay changeset id created by the overlay apply which result
> in fragile code.  The new code removes the assumptions.
> 
> A symptom that exposes a problem with the tracking code is a
> warning "UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36",
> Kernel Version: 5.15-rc7, PPC-64, Talos II.  This results from variable
> "id" value of -1 in the final line of of_unittest_untrack_overlay().
> 
> The first patch in the series cleans up the inconsistent use of overlay
> changeset id and the obsolete overlay id.  The id is a core concept in
> the overlay tracking that is re-implemented in the second patch in
> the series.
> 
> Frank Rowand (2):
>   of: unittest: change references to obsolete overlay id
>   of: unittest: re-implement overlay tracking
> 
>  drivers/of/unittest.c | 154 +++++++++++++++++++-----------------------
>  1 file changed, 71 insertions(+), 83 deletions(-)
> 

