Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB00654BF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbiFOBm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFOBm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:42:57 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1FE24586;
        Tue, 14 Jun 2022 18:42:56 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id f1so10661631vsv.5;
        Tue, 14 Jun 2022 18:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLlOpMMZLalQrrj3ld3d4c2TnADWloh8V/PPI75OtI4=;
        b=LZXCrr/DK6w6PNwU0LHVJqIcX3Il12vTffWTrzUT7SfLkrLQSOYFfxTAQJus91hJrc
         e7Ewu4BAaZR3RY7f5xwnKndoV4+WcGjtOPEb7B0E7pRisHM4nKnFOXnh6HmL2qr4Dri9
         UVlthychACLH7LFU9/hcsAUsXU15YckTZWDL2eMmxYI9LdFAIg9mqtIYfmj8joTJkOW8
         BY95iUTLWUilV+MdadPsJij9V6QVS7HIeZj4aWXs1NdMwe05mwazXaR6sWMlylAufK5L
         7pYHvaPXtB5HW1kktAx6Zz1vmXuMFyp9c6IcMo7g4p1BJTxUQa/yvddzFhzGRRyx5nk4
         sW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLlOpMMZLalQrrj3ld3d4c2TnADWloh8V/PPI75OtI4=;
        b=cXbUlI65dbNWrBVWJqoCiND45KQETFbqDICXccJGXxpCgBtj9lZUXPdQhyVurWkvbd
         4fN/nhVy3CF2G5fZqcmBDk8YEyw/KgYioaq+ZF+JMsT3KWPJoLZPzXHIFKiFHYzCqnzy
         tC+rSsSzU/bIjsVXhRfH3r3r7enwFRhCG1E3aqsZHNhyPAUNzl/EIo1EKDL7EUUK4x+A
         SQkdsOHPlrHYIOGS1sK+92o1vivmyP0xtLdMnpIBq4S/eixGoJtVpRy9Zp8P4VSYNRz/
         UtOTYgmJvFlvhL5yLZYawy9VeWV6nNEG5XrFfBwkgrHkGWBZXvFsdo0hP+S4U8y2bwqq
         7FCA==
X-Gm-Message-State: AJIora9x0uSLQk0JvpbSfoRnLXN0W55OHHH7PuS8MZ9TfJs/l9YHnXIL
        oOhpZKioKd6U5dcUuDShN+DKCLM3EYUME+JLKmnoBWPSboFSt526mWM=
X-Google-Smtp-Source: AGRyM1sRyufxWNbEmVTtdEMXBl+wkYBMp8LvcOojRc7QZCqct+liLSZgd4rtP+D9JNxR4i6zCM2zOEhDklLil79ERKw=
X-Received: by 2002:a05:6102:2911:b0:34b:dab7:832b with SMTP id
 cz17-20020a056102291100b0034bdab7832bmr3754974vsb.76.1655257375932; Tue, 14
 Jun 2022 18:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
In-Reply-To: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Tue, 14 Jun 2022 21:42:29 -0400
Message-ID: <CAE2upjTKF=rBympBM0sRUM1EWbFd7JASeyzkG1J-gic4co7fvw@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel/pmc: Add Alder Lake N support to
 PMC core driver
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
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

Is RocketLake the same as Alder Lake N? Otherwise, it looks pretty
straight forward.

Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>


On Tue, Jun 14, 2022 at 8:28 PM Gayatri Kammela
<gayatri.kammela@linux.intel.com> wrote:
>
> Add Alder Lake N (ADL-N) to the list of the platforms that Intel's
> PMC core driver supports. RocketLake reuses all the TigerLake PCH IPs.
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 40183bda7894..a1fe1e0dcf4a 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1911,6 +1911,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,      &icl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &tgl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &tgl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &tgl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &adl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>         {}
>
> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
