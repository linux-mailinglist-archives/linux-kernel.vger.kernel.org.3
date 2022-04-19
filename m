Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED55079B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353633AbiDSTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357454AbiDSTDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:03:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C840B3F8A3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:00:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so2738629pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N50QQqz5FaWJg12DahJJLBGEw2d+0vPFzhUnblUtOq8=;
        b=fHwxwjlB7ACE7zsTaGo1w/yKNLBugj5nc0rALFLDlfTXzibXepa0LAgip3DsYCkINr
         PlmgfmcoyRGTKBP6R28N1b9i34RdS2JvfhAczISRxxi1ywV5vvxmFBDgwrw8qB6ZMGKE
         hj+bbizJPpfPrfh7EyYlcM2fQLkG1hSFBbf/pnMsOFF21FkqHyy+FnoAaspBytL9Hn1e
         /ubGiiJB7QCT/Xjyfc/zfTO4u7mbS3j4/BvWPrqjvMG1h6Qa6ydHadbY9fC+RNORVzcU
         jCHDUa2BwzyNEd7M8P80TRileSNV6zCvfVjPPA8hvrSYG6pdRMI73qe4mIHsDKff45hz
         jsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N50QQqz5FaWJg12DahJJLBGEw2d+0vPFzhUnblUtOq8=;
        b=OS7d99nH6kFCwV/Tx7cIqYwjZhVleFF2hsZfhRA+v6+LJfbYHsZFryAkhCtZTkNfWq
         gdrFeMHHXlNHEVlMg+2e70oVyC7zX+eqpOo5oA4PGU4HxGmrjLJAKRobRICafhP3hLVx
         jwGCGNGrWZpBmYTASyhusHLd+FEYc99nHlC1r4xor1od3gjMdplzredqxv4cO91v4nrg
         3JxK8Gl0FkVO43yXm1aVbt2c0qCNkzMgcj1tzFPJ1UH/MJzXSqf5sagEtlxB/voP4+f6
         j7HjgQ8yjXI3f+jd/70m9tbnsngEm5fy6QzF0o1QWZmHZWsmNuDZsrKRjcIYaMjYbRj+
         PVhQ==
X-Gm-Message-State: AOAM53268cKerLtkZdACEK6vO2OZ7XmwgdSZQi6tvvJ1sPQMmzeTtXbU
        4lEx6QtBM91hPlOp+k3O7xo=
X-Google-Smtp-Source: ABdhPJw+14nnBa9lCLpvaNhG72qqpXW59VQYwNeMf2hFtt4MCpYscteVglVUKfMkHVKPCMua3yTDJQ==
X-Received: by 2002:a17:903:234c:b0:159:252:68c1 with SMTP id c12-20020a170903234c00b00159025268c1mr10264438plh.170.1650394854258;
        Tue, 19 Apr 2022 12:00:54 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a7a8400b001cd4a0c3270sm16514022pjf.7.2022.04.19.12.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:00:53 -0700 (PDT)
Message-ID: <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
Date:   Tue, 19 Apr 2022 12:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
References: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2022 11:34 AM, Joe Perches wrote:
> Convert the broadcom internal list M: and L: entries to R: as
> exploder email addresses are neither maintainers nor mailing lists.
> 
> Reorder the entries as necessary.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   MAINTAINERS | 64 ++++++++++++++++++++++++++++++-------------------------------
>   1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47d9862b21a95..0278782c14e19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3746,7 +3746,7 @@ F:	include/linux/platform_data/b53.h
>   
>   BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
>   M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
> -L:	bcm-kernel-feedback-list@broadcom.com
> +R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>

There is not a "Broadcom Kernel Team", the description of R: appears to 
require some kind of full name, hence the choice of L: instead of R:.
-- 
Florian
