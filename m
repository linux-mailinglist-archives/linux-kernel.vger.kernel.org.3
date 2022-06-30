Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AEB560F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiF3DDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF3DDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:03:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DF2FFC8;
        Wed, 29 Jun 2022 20:03:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1490521pjr.0;
        Wed, 29 Jun 2022 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cYw3aiKeUWBcgmeT5pS9kKfrmKw4uYd7xdDVkalIxnM=;
        b=kEOh1fcQhG/jNogP65aBxX0GVyiwpH+2MSz2j0sc/pUG8A5NC0rF9ENn5ETZwPKdn5
         jtyeeQThYJkrtYcbgzydzdOG+9tV/z8Lliq7Rb/ncYgk191Z+cFhIbY0wxN7VVTSVMCM
         d+kDu8KUvg/+t7GHiQWrMZ/RYiQ7uVqxZQ3ihi71HusJtLSeTXfZ5sFO7XMBXw+MfOQv
         UhcRdFKWzr8ZL4CcOOrFLr+YAHGYLLXIykqXqbNQlAgMFf8ZbnCx9j5Z/7RoyGxBLOgQ
         BWJuz9zjqnvVdS7xm9vrQ7OcIUMyHk6UFtuWGtX86oM8NXeH3TembDteGseTL8sghT7U
         2l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cYw3aiKeUWBcgmeT5pS9kKfrmKw4uYd7xdDVkalIxnM=;
        b=e/4bryeVvyxhZXaEsxcUxYZXcUIiiBULR1+FcYBrUiwZ2xgNKua57rJYlqQ8n/aAea
         DMnwKOhVwfeRs6M3fFNJ85mnAkYtiPS1ayogrEbDo1XxdbFrxEeDW8Df5H6e2uylZNRc
         YG5uF9isOettVcOZT41LSqyjNomVocIKCNXCT5IGjZuoNi3VMp1zti/FX9mGgKM1HaI4
         ijeTpsMAu1CSOANDdnp44zfKqxVNTyunSjvgpMdLuzQPCsCz2CpwdAhz386mJU75uUkf
         2Ch32IiRoMk3dSTr9bRvwXCGOA0H0MaeBztl1z1fMRvRUZThJA4Qbce40agZ9yIPSex1
         x0OQ==
X-Gm-Message-State: AJIora9Its7ST5AGh56vvFjgOvaUfnAa7SeeDxsc+6FVXJlSKJ7NM+m/
        Lpou03omfv0cVqGttei9xDw=
X-Google-Smtp-Source: AGRyM1uHjQ8/11ewRBkPe7/6baTese5ertCgya4DAOP8m29M1jOz+F+PDXLMuKBpM7WHj94iBJ8kYw==
X-Received: by 2002:a17:903:1c3:b0:16b:a8f8:882c with SMTP id e3-20020a17090301c300b0016ba8f8882cmr2996743plh.158.1656558213237;
        Wed, 29 Jun 2022 20:03:33 -0700 (PDT)
Received: from [192.168.43.80] (subs10b-223-255-225-235.three.co.id. [223.255.225.235])
        by smtp.gmail.com with ESMTPSA id ml22-20020a17090b361600b001ecb29de3e4sm442990pjb.49.2022.06.29.20.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 20:03:32 -0700 (PDT)
Message-ID: <8607c3ab-ef68-a782-e53d-86f5cde70559@gmail.com>
Date:   Thu, 30 Jun 2022 10:03:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, dave.hansen@intel.com,
        len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
 <20220629224235.20589-2-chang.seok.bae@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220629224235.20589-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 05:42, Chang S. Bae wrote:
> Explain steps to enable the dynamic feature with a code example.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v1:
> * Update the description without mentioning CPUID & XGETBV (Dave Hansen).
> ---
>  Documentation/x86/xstate.rst | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
> index 5cec7fb558d6..c439901419fb 100644
> --- a/Documentation/x86/xstate.rst
> +++ b/Documentation/x86/xstate.rst
> @@ -64,6 +64,48 @@ the handler allocates a larger xstate buffer for the task so the large
>  state can be context switched. In the unlikely cases that the allocation
>  fails, the kernel sends SIGSEGV.
>  
> +AMX TILE_DATA enabling example
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following steps dynamically enable TILE_DATA:
> +

This should be "Below is the example of how userspace applications enable
TILE_DATA dynamically:"

> +  1. An application first needs to determine the feature support::
> +

Better say "The application first needs to query the kernel for AMX
support".

> +        #include <asm/prctl.h>
> +        #include <sys/syscall.h>
> +        #include <stdio.h>
> +        #include <unistd.h>
> +
> +        #define ARCH_GET_XCOMP_SUPP  0x1021
> +
> +        #define XFEATURE_XTILECFG    17
> +        #define XFEATURE_XTILEDATA   18
> +        #define XFEATURE_MASK_XTILE ((1 << XFEATURE_XTILECFG) | (1 << XFEATURE_XTILEDATA))
> +
> +        unsigned long features;
> +        long rc;
> +
> +        ...
> +
> +        rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
> +
> +        if (!rc && (features & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE)
> +            printf("AMX is available.\n");
> +
> +  2. After determining support for AMX, an application must explicitly ask
> +     permission to use it::
> +

Shorter is "After that,..."

> +        #define ARCH_REQ_XCOMP_PERM  0x1023
> +
> +        ...
> +
> +        rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
> +
> +        if (!rc)
> +            printf("AMX is ready for use.\n");
> +
> +Note this example does not include the sigaltstack preparation.
> +

I guess "application" here means userspace application, right?

-- 
An old man doll... just what I always wanted! - Clara
