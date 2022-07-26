Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC2581A01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiGZSwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZSwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:52:16 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC7232041;
        Tue, 26 Jul 2022 11:52:14 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id i14so26839786yba.1;
        Tue, 26 Jul 2022 11:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pcjYEUbbWVI1GJYsR1aZ5S/FEswLJ2d18rHjErvNim4=;
        b=556IzU9WEoA7J7ft8963Cmy4wbwW2uVgwhP0MtCtAXSHUZZt2WwfwWQa9ZyfuXmmfp
         4lBStsltJoGpR7BcGxw77KE270R51VmwIeZiu7I4rO3D71wU4QUKxMTxEqCaze+Jduww
         qgk1jPJiwhgDJyWoHwET9h54BJu628tiioVrCfa4805iWf9eeaIMpVce2i5OpZQR731e
         X4V8kucLLg44r+biqYzHdqzouWy0+bYbu/v0TPOunCZWhLw3QMP23TBg1WflYLpKBErg
         Su4MYE/hcoPuI+UzYDC3pD1qJkX0HbgQBC9epwZlMgRDmn6vWZh9/lyi2A0jwWYhe1GN
         6eSQ==
X-Gm-Message-State: AJIora8OZNjij3YQKrlB/5j9hfQzgvJVGrN9OaMaUHkDiTERLMDqVy/g
        3vwp8ep/syQ/YfTJJ8tuilVm6AO9//rr2knnEXmjdoSv
X-Google-Smtp-Source: AGRyM1vn9XmR3NNOgIpseD9FrGKjFCqkRznLuSAtb0uXk418BAR8v9Ei7u7Dq8XoVdYwxMc8oVj6tg+Nv/bTPudqQgw=
X-Received: by 2002:a05:6902:1541:b0:670:ac02:58c3 with SMTP id
 r1-20020a056902154100b00670ac0258c3mr14574527ybu.622.1658861534018; Tue, 26
 Jul 2022 11:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220726130229.24634-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20220726130229.24634-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 20:52:03 +0200
Message-ID: <CAJZ5v0jkM4oMyPOR+TWZnG2oj43PAPm7dEckwzeepJMROdgt=g@mail.gmail.com>
Subject: Re: [PATCH v3] powercap: RAPL: Add Power Limit4 support for Alder
 Lake-N and Raptor Lake-P
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 3:07 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add Alder Lake-N and Raptor Lake-P to the list of processor models
> for which Power Limit4 is supported by the Intel RAPL driver.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: Sent v2 without v1 i.e. first patch itself sent as v2 by mistake.
>     There was no v1 sent for review.
> v3: Added the backstory of previous versions. No functional changes.
> ---
>  drivers/powercap/intel_rapl_msr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index 9d23984d8931..bc6adda58883 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -140,7 +140,9 @@ static const struct x86_cpu_id pl4_support_ids[] = {
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
>         {}
>  };
>
> --

Applied as 5.20 material, thanks!
