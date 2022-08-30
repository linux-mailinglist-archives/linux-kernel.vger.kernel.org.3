Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77B5A7163
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiH3XJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3XJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:09:38 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61379FAAE;
        Tue, 30 Aug 2022 16:09:37 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id w129so5985650vkg.10;
        Tue, 30 Aug 2022 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6CFAoGKYDzGBjgszMd6e9LnYGKGNXf7KN5eBXRvilVA=;
        b=PT2H/MKYT6kOEegQXkbdaXRUjU8N71sZpVx2c4MZI/ifyw9Mq5zeAoMxJDY8B8uK4x
         TN4bGYnX5ND+tuJPNgUw/LfyKnKp6EA//9l3UlIDWwfXB7cHP4Udl/x3S8k/+xuLpjXH
         W08l/EOoYHncs1qJp2Gm/KZM27nTRZ8Rzd9mzavb+oq616c2dgAwmpdeyPqC8+hSJOVd
         hhkt/gCymkm1pchYvSf5eERSahehFfmnf/O/h4rAJvmcs3pHIndTTjzLHD953E75wozD
         L8mtBTmXURkxEJhzdBDbTjx3BiCn7evDZwUzHBQYIPZecQ06jz8emkkWIRra3wL8PSp5
         ndMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6CFAoGKYDzGBjgszMd6e9LnYGKGNXf7KN5eBXRvilVA=;
        b=s+Q8B0zf7m95LLLRtDt+eBLfn+iyM3sPpBu9pGMLFJz1mgGmd2yhrm4Mjp3KqMEFWS
         gDn9cCkTpKDjIp4HA4VMZay+JVahSBKy/syQrXFzqDZoghym+dxFgRsoA0oe6c4aeBWH
         6hH0Vy4ajMNCNsaJoHC1mJhdJr1UPex5H/WaR4aZ6tPF/uJZ6l7KCezL9/ihDlsyLC//
         side4vGEUPFlhdVhl7kHhbttayy794+DXSIcd4iBLdXKrmd6zcNaB5aO4iLLM0AltSQL
         irem4yNG0ekC65/gIrrw0oii2nalnRL/0KRiuFtnfIJZGVA04A0FlS4V47ZOVMNd7inN
         PzsA==
X-Gm-Message-State: ACgBeo0TK5M6ey7JaoyA74GJbb2igFeofXtk922JPq1p38dUaSuWfBHq
        2nUtNJ++h4gATtLA+SrqNZ4XusoQgTalqoJfjtI=
X-Google-Smtp-Source: AA6agR6Ful3zPXjdse7qztDChtXGRX9ea+FkJen0/xQswBlDef7J57/8vQ1yc/W5vswZkGUGsyKUf+7LPTBqt3cpRZo=
X-Received: by 2002:a1f:2582:0:b0:394:617d:a628 with SMTP id
 l124-20020a1f2582000000b00394617da628mr4234325vkl.18.1661900976838; Tue, 30
 Aug 2022 16:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
In-Reply-To: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Tue, 30 Aug 2022 19:09:10 -0400
Message-ID: <CAE2upjQCzrFQF0B9hGMHb2LejrKJyJNNdYDjizQW2Yw=8pYMQA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86/intel: pmc/core: Add Raptor Lake support
 to pmc core driver
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

On Tue, Aug 30, 2022 at 2:20 PM Gayatri Kammela
<gayatri.kammela@linux.intel.com> wrote:
>
> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a1fe1e0dcf4a..17ec5825d13d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &tgl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &adl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &adl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &adl_reg_map),
>         {}
>  };
>
>
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
