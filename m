Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B99524741
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351148AbiELHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351086AbiELHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:46:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3533363
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:46:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s14so4127033plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JqKmOBdyvSAB2RQPk7pfmb7qvk5aEFRk658+MP9/8GA=;
        b=X4zHvSs2OtqDypNXNfmaomwFgwxRLmD9XFu2ESdk4XQ3Uo78qZHFVISztp97Ta0n5C
         zUvEnltHgHmaGdFZuMmZC4i1jGM+WMi80vrB6Vm7t3uylzs0fyVNgSsiyfuhb8ZSW4X6
         c0sO9TyaPmS/P1YxVxgltuTIUOiideMbzhVdsJLHSkqYLoryuttMYunBYcna1c0UJwtH
         cCsR/TuKr+aVNYoZCAszIiEnjCR58xTRjK7W0p/kFsxnxIfktE4pJmvNaRGj8wSfKYv9
         mWMRe6RySEHVF+qBMm7MZvYjpgOtR164GYbLAE4He+rsh0CQ1XzMfh9Bou6AgBrOh+Fk
         zQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JqKmOBdyvSAB2RQPk7pfmb7qvk5aEFRk658+MP9/8GA=;
        b=IWPczXIE9gKf9NnYepBtUwRXExMoyy7JC0u3BuuL7SEby5Q5mpSKLM3W6Y43X/5Cue
         iYYQnVjaBQEgavCmqAg8z0Qa4tTMrvs2ruZpHYtl7AN+CKMEjZ+1Kjr6POKvCEyTEUbR
         CRueTh00D+HtJT2i/A58rSb8j1lNhCtB0IITLJdNaYRk/2OfdsLHHVtUPR+gmZJtcWz+
         yzYauaDUrvWBy9pNWS0Ihod2CkLDG0zfu0Wx6UeZg1+qabDhLdZMJyz1f1Dzh0bD+1Xt
         /bVJvxquzj5VaVmYpB6m+i4EKWCO2kTBB2psAjPUwFV6b8l6SY+VJ0msf4I8jPKZbIff
         ZZ7Q==
X-Gm-Message-State: AOAM533PBjRsCxuMQvCIl27ReeHpVrOcHRu9DWixHBS3a0yU7WijPBwQ
        wiQaaeENM1PoYc/uaTqjq3/4cA==
X-Google-Smtp-Source: ABdhPJwUqx1pbyIyvspuWNontshAmCuEcq5ZJyBlMDjfIBLljoOQH3ZGhCvC+DWmIKArMfbLLu2iAw==
X-Received: by 2002:a17:90a:4d04:b0:1d9:3f18:f4dd with SMTP id c4-20020a17090a4d0400b001d93f18f4ddmr9482641pjg.111.1652341592056;
        Thu, 12 May 2022 00:46:32 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w8-20020aa78588000000b0050dc76281a8sm3009761pfn.130.2022.05.12.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:46:31 -0700 (PDT)
Date:   Thu, 12 May 2022 13:16:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v1 4/5] cpufreq: CPPC: Enable fast_switch
Message-ID: <20220512074629.3cewdk4pu3oydlfg@vireshk-i7>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
 <20220511134559.1466925-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511134559.1466925-4-pierre.gondois@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-22, 15:45, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The communication mean of the _CPC desired performance can be
> PCC, System Memory, System IO, or Functional Fixed Hardware.
> 
> commit b7898fda5bc7 ("cpufreq: Support for fast frequency switching")
> fast_switching is 'for switching CPU frequencies from interrupt
> context'.
> Writes to SystemMemory and SystemIo are fast and suitable this.
> This is not the case for PCC and might not be the case for FFH.
> 
> Enable fast_switching for the cppc_cpufreq driver in above cases.
> 
> Add cppc_allow_fast_switch() to check the desired performance
> register address space and set fast_switching accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 17 +++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 24 ++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  5 +++++
>  3 files changed, 46 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
