Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAB4AEA6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiBIGef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiBIGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:34:32 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD9E066E1B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:34:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z35so2655781pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 22:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OwHnp+CBrpknipruebBheU1nuu6L2xS3iNwKkt5hzSc=;
        b=fHiYoWvoB+Gab19/vejvHtO0ZlTBEXUK3diJ0NhY8IXdVk/N0v+UGR+BlOtuSa9LMH
         fV8Q4OxIzP0WK57293UqNQiTScEFW4NU7YCmlHlVonAFBpC1IMUIq8FKpG+r/5uIKwP8
         iH+KcXAO1PZ9fOAgd6HRYvN+KAbfzC7vMFtfY/HGQtiNGDo/QlDrdsbnRufYiS4EA+r1
         D8t2lXa0zwhm5wi0J82hk0F5cWF2gsouXwoXDSo+HJTSTLfm9fM2t1BQYhtkvM1Oibs1
         Y+8F3ZcX3v/exjMqf5iK0xa7M4tY+kvbGNUiAAMP5pOzFFfo5CxVKcjZ72+T1k7lOuze
         jDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OwHnp+CBrpknipruebBheU1nuu6L2xS3iNwKkt5hzSc=;
        b=G1xXHP9Z91D3NWEJaRA7LHZveuU9oRZNBHiTp7QTKIM4yRSzgU1wpha4Yv/j++oYJk
         Guj6B55JlW4u6dk15gPaw/KW2hWjh0iQKnnGlhZ8bicd0IX6QzKWq84ZSoO+OWpT1mm6
         IiVh9ObngZHnPfXEKl1vaYZy6s7ClyAd6ulPp4acUtZ5BmHgi6paBakupSvpF40Veh5v
         xJZgFfME8hsRmoch23H+RqV3glm8cJOz0fesgOYcCziO7nzdJqNXCJL9w7H9rkv5ODqR
         PZwUXi0RkSE1oP6XjNcmns+jgwB8CpfzyiWorlxqDmDScjySgAsmIOUcVKhghLlnBlT3
         R8iA==
X-Gm-Message-State: AOAM530kiC/IC75bF4pcY0qzGt/rMAL7c+Idp7vUq5vKuA6jt3bLdwkt
        KP1IgnrK2cjBC0lIIe5ksGDDSA==
X-Google-Smtp-Source: ABdhPJx52+9Dw5Vu5Ayd4PAzN+hfjEFuihoosOnlAsFNrrdNMnMsovfyUzU9vYmhNYbMXE+jGAZnmQ==
X-Received: by 2002:a63:3d4f:: with SMTP id k76mr749057pga.389.1644388468680;
        Tue, 08 Feb 2022 22:34:28 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id il18sm4889019pjb.27.2022.02.08.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:34:28 -0800 (PST)
Date:   Wed, 9 Feb 2022 12:04:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-nvmem: fix reading of PVS Valid
 fuse
Message-ID: <20220209063426.ckefdtpfroj5zsad@vireshk-i7>
References: <20220130114535.1570634-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130114535.1570634-1-luca@z3ntu.xyz>
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

On 30-01-22, 12:45, Luca Weiss wrote:
> The fuse consists of 64 bits, with this statement we're supposed to get
> the upper 32 bits but it actually read out of bounds and got 0 instead
> of the desired value which lead to the "PVS bin not set." codepath being
> run resetting our pvs value.
> 
> Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index d1744b5d9619..6dfa86971a75 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -130,7 +130,7 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>  	}
>  
>  	/* Check PVS_BLOW_STATUS */
> -	pte_efuse = *(((u32 *)buf) + 4);
> +	pte_efuse = *(((u32 *)buf) + 1);
>  	pte_efuse &= BIT(21);
>  	if (pte_efuse) {
>  		dev_dbg(cpu_dev, "PVS bin: %d\n", *pvs);

Applied. Thanks.

-- 
viresh
