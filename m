Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D55174E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386350AbiEBQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiEBQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:52:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB282267
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:49:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r9so13118708pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pMZ4chT6I/f3Jk5AKYOsdoQMhcv2o17LMQaLhnOXVk=;
        b=hinFYAiucdiinOlK5arn5v6mBgMF+zpJgW1TT9ZxROBsC8tD5/z3U695lPX+XFa6pO
         R2eL4z06ZrIqpXyXmcekpdFhNn7bPRTNkT+BSE3i0N2v/NEZmVhObdQTB50HBVh2teDr
         yJWsX3wzg+pY/elBuNTIJLLKmlO4rG+KNJdC/YwDQYAjN+IvtBlCWuFNE0f0umXbFVJC
         DVVO9ug6oxnR8hhpw6tD/nlnmONDxzcE4pXDUXa5loxxMbxk3HiTp66BBE6GLHOKXcS4
         vqDOccqgbOLkIYTUDkbjyv0k/ls9c0orp5jw90PRMQfbx5Qk6jhEsJETuDixAv1oh7ux
         r97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pMZ4chT6I/f3Jk5AKYOsdoQMhcv2o17LMQaLhnOXVk=;
        b=HQioPeiNPTsZWEJ/b9piSTq/kKLZoAWgi4LvEQxB1vVA6waKXmmtz9Wz0rkZEY42TJ
         lG3o1RHgpjOPLyWbJM9qgC2BTCT9SmgG0reGKdhaZ6JQ51/b+ttCVhw5S3ZBrmp9on96
         ZBYieV4o7KCcQ/2l/kVpsz82rWXyeoY2z4EIh68MlykHo8ANQhDvxyZDlOaR8tqY+kI+
         RB2aDionpQo1WQSzT0Wpxd0U1Sbu5x+saZTl7NObqg5iOElltiJK5PcVx3OsEWa51xQY
         YlHu7yw54mvVRb/JpUBf8KOrN3T0VA6WGJsyq/cMlQ31Ibmz9Th0hvFOw43Id0pYSLCU
         2NAw==
X-Gm-Message-State: AOAM5335NqFIBucBoxFqdtwQEMNwqDJwVtAQiwACpXt51Sxz7fhPonkb
        2zqNaw7GcRgb/Y5WHzFBg2Q3Ui2dy/nREw==
X-Google-Smtp-Source: ABdhPJwO0LnrbY4Zkvwvt567SkuKoTCwV12+xRTQ+hWfPwOQbPNwvvs/go45eTzJYSog8YYYxhFZ3Q==
X-Received: by 2002:a17:90a:af98:b0:1d4:67d4:d122 with SMTP id w24-20020a17090aaf9800b001d467d4d122mr54456pjq.166.1651510154259;
        Mon, 02 May 2022 09:49:14 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c136-20020a63358e000000b003c14af5063bsm11882556pga.83.2022.05.02.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:49:13 -0700 (PDT)
Date:   Mon, 2 May 2022 10:49:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        james.clark@arm.com, leo.yan@linaro.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coresight: etm4x: Expose default timestamp source in
 sysfs
Message-ID: <20220502164911.GB2498226@p14s>
References: <20220429123100.268059-1-german.gomez@arm.com>
 <20220429123100.268059-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429123100.268059-2-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:30:59PM +0100, German Gomez wrote:
> Add a new sysfs interface in /sys/bus/coresight/devices/etm<N>/ts_source
> indicating the configured timestamp source when the ETM device driver
> was probed.
> 
> The perf tool will use this information to detect if the trace data
> timestamp matches the kernel time, enabling correlation of CoreSight
> trace with perf events.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h               |  1 +
>  .../coresight/coresight-etm4x-sysfs.c         | 34 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 38508e507d73a..263a7bee06f9a 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -1146,6 +1146,7 @@
>  #define SYS_MPIDR_SAFE_VAL	(BIT(31))
>  
>  #define TRFCR_ELx_TS_SHIFT		5
> +#define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
>  #define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
>  #define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
>  #define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a0640fa5c55bd..c0c375c0cfde2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2264,6 +2264,39 @@ static ssize_t cpu_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(cpu);
>  
> +static int etmv4_to_ts_source(struct etmv4_drvdata *drvdata)
> +{
> +	int val;
> +
> +	if (!drvdata->trfcr)
> +		return -1;
> +
> +	switch (drvdata->trfcr & TRFCR_ELx_TS_MASK) {
> +	case TRFCR_ELx_TS_VIRTUAL:
> +	case TRFCR_ELx_TS_GUEST_PHYSICAL:
> +	case TRFCR_ELx_TS_PHYSICAL:
> +		val = FIELD_GET(TRFCR_ELx_TS_MASK, drvdata->trfcr);
> +		break;
> +	default:
> +		val = -1;
> +		break;
> +	}

I don't think the above is big and/or complex enough to mandate a separate
function - please move to ts_source_show().

> +
> +	return val;
> +}
> +
> +static ssize_t ts_source_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	int val;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	val = etmv4_to_ts_source(drvdata);
> +	return sysfs_emit(buf, "%d\n", val);
> +}
> +static DEVICE_ATTR_RO(ts_source);
> +
>  static struct attribute *coresight_etmv4_attrs[] = {
>  	&dev_attr_nr_pe_cmp.attr,
>  	&dev_attr_nr_addr_cmp.attr,
> @@ -2318,6 +2351,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
>  	&dev_attr_vmid_val.attr,
>  	&dev_attr_vmid_masks.attr,
>  	&dev_attr_cpu.attr,
> +	&dev_attr_ts_source.attr,
>  	NULL,
>  };
>  
> -- 
> 2.25.1
> 
