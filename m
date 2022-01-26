Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1EA49D090
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiAZRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:19:03 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:39718 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAZRTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:19:02 -0500
Received: by mail-oo1-f51.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so68946oos.6;
        Wed, 26 Jan 2022 09:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Mpzlir6SdqG4dmvTdqzzIWhZy40hzNNvzFlysAcgEo=;
        b=cTZa7OBRRbnpcBPHyGqLWCNhGLldOA3yZVWhYdv1uT70PIH1YgO6ZZLnnxmXmtXaX7
         N6RAznD+Hk+qjSvyWy++PdCAswnC+Pg1kZufbr9/WRlHYwG3eK4WFBmrq7cdgO7Abqkh
         N8GKNcQzyKRUsRqzuqd6k/pG6ToGhEk3rBsFDEvP9lZv4Aqi67vaIvNZ7Ns/n6FzIkaY
         TlrHHdCFo9cySRWyIcA44ZYrW96/vc47s4vC5v2zu/OyFelBVg8IdRNGAkMZewMIn2ug
         EP9MFhaKNzimrGZ0O8agc5ZZ6dkP06GVgwqljvYfSeH+4oJunp/W+zIG0o1YK6X5hbH6
         7GPQ==
X-Gm-Message-State: AOAM533Gg15FDBy6bdTjdjAJ4g3vOuU/2XvoRwV0QoYj5finXbiZRPWY
        mRQphFmHuvMViVwGh+9oAp7L+n4eug==
X-Google-Smtp-Source: ABdhPJyG2I4hTLw+49PdCXukWfcyYMXxvipT317bX9TkHxSH1ngsOdYI+seGe7/TEKrCnlLtNRkF6w==
X-Received: by 2002:a4a:9866:: with SMTP id z35mr6372ooi.61.1643217541497;
        Wed, 26 Jan 2022 09:19:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p26sm5677731oth.14.2022.01.26.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:19:00 -0800 (PST)
Received: (nullmailer pid 994404 invoked by uid 1000);
        Wed, 26 Jan 2022 17:18:59 -0000
Date:   Wed, 26 Jan 2022 11:18:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC V1 05/11] arm64/perf: Detect support for BRBE
Message-ID: <YfGCgwlk6wHS/OYe@robh.at.kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-6-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642998653-21377-6-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:00:47AM +0530, Anshuman Khandual wrote:
> CPU specific BRBE entries, cycle count, format support gets detected during
> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
> later helps in operating BRBE during a perf event context.

Another NOP commit. The subject says 'arm64' and that we detect BRBE 
support. This patch neither touches arm64 code nor detects anything.

> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 513de1f54e2d..800e4a6e8bc3 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
>  	return err;
>  }
>  
> +static void arm_brbe_probe_cpu(void *info)
> +{
> +	struct pmu_hw_events *hw_events;
> +	struct arm_pmu *armpmu = info;
> +
> +	/*
> +	 * Return from here, if BRBE driver has not been
> +	 * implemented for this PMU. This helps prevent
> +	 * kernel crash later when brbe_probe() will be
> +	 * called on the PMU.
> +	 */
> +	if (!armpmu->brbe_probe)
> +		return;
> +
> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
> +	armpmu->brbe_probe(hw_events);
> +}
> +
> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
> +{
> +	int cpu, err = 0;
> +
> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
> +		if (err)
> +			return err;
> +	}
> +	return err;
> +}
> +
>  static void armpmu_free_irqs(struct arm_pmu *armpmu)
>  {
>  	int cpu;
> @@ -229,6 +259,10 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>  	if (ret)
>  		goto out_free_irqs;
>  
> +	ret = armpmu_request_brbe(pmu);
> +	if (ret)
> +		goto out_free_irqs;
> +
>  	ret = armpmu_register(pmu);
>  	if (ret) {
>  		dev_err(dev, "failed to register PMU devices!\n");
> -- 
> 2.25.1
> 
> 
