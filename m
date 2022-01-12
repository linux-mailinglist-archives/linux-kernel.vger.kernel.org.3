Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8F48BF91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351450AbiALINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiALINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:13:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C4C06173F;
        Wed, 12 Jan 2022 00:13:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id e3so2541981lfc.9;
        Wed, 12 Jan 2022 00:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ui0cHnkj5I0HD2fe+MzyyLDDYFQT+ppgbg9aYqgOGaQ=;
        b=PK01xfrMmh5kecd+m8mNSyqTT/hhuRPndmcj70so55KnrdpEXwL/6KoItu7rAZL/XF
         RaSCIa8OkGbCcjUUaLcWfiDXQ+mzw6SxdTQJSmYPC4H/spPzuwMh+cIiy4B9lFaLIap9
         ASo4kJFV/AsFC+rBGLtIDCClJUKOUQsxcKueaQ224s1SCZXGqx6dk8rNWROY9JHxHQYz
         W2DXn5kho3mqn2iXb3761ZaurglP9kmoYYLwaAMirF7FE2Ax62r+nznsvR1AMy8WVJvr
         B7rcnUEkYcqNEGSpG3owyBKnH2waME/mbVJ3hk/uHFVdurpkpDSZbCadDDR1mCOlu47m
         IOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ui0cHnkj5I0HD2fe+MzyyLDDYFQT+ppgbg9aYqgOGaQ=;
        b=JAHPE8MKY3Xj1rSWOXkV3sq0kf0P9wMWEHo9q9mXZKo47PqjVXN4HWeHdlmLji8wTG
         OU6vHdkprg+OMDxdKC7u6gsm86eshyBBe59VnCBTfGbZ/sNYCqUf8Ll50zorfsnk+KZO
         iU/rTNQrLZVZPh6uKbxi/4uHth6Q60dp5ofm7JlSWbuaBv3cwhiR+GmV/FW/UFh4CZCk
         B2sSx66wE7KVpLqwU/TYKXtno3R87ozJFVUSi/QJxKpAK9CDsrsEDI+3TbTz2uR7k0J0
         uJwFNCQ1jxIC2o7CmyHH2FQuJnp97QffWJnfFAdUa/x2adxV6aFQ+XcavKwa7j83s4ZK
         r8ig==
X-Gm-Message-State: AOAM530ejzck5rnUKoiDKsavurbaLgzomxQAPcgqWZM1+GjaURvn8dLW
        oqfyRwAF1TVunhD9721iQ48=
X-Google-Smtp-Source: ABdhPJyj7lXG9CASnnt14HBgHRh1fruIOO6aEFTwylkhyvTmZwgsEJSPtZR4Qjp3V4kzM4QEnbP/Cw==
X-Received: by 2002:a2e:9581:: with SMTP id w1mr5744510ljh.36.1641975188762;
        Wed, 12 Jan 2022 00:13:08 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id a6sm1519757ljm.136.2022.01.12.00.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:13:08 -0800 (PST)
Subject: Re: [Patch V1 1/4] memory: tegra: Add support for mc interrupts
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1c2dacc4-566a-929c-2100-37b6f9bece98@gmail.com>
Date:   Wed, 12 Jan 2022 11:13:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.01.2022 21:45, Ashish Mhetre пишет:
>  
> @@ -765,16 +768,21 @@ static int tegra_mc_probe(struct platform_device *pdev)
>  			return err;
>  	}
>  
> -	if (mc->soc->ops && mc->soc->ops->handle_irq) {
> +	if (mc->soc->interrupt_ops && mc->soc->interrupt_ops->handle_irq) {
>  		mc->irq = platform_get_irq(pdev, 0);
>  		if (mc->irq < 0)
>  			return mc->irq;
>  
>  		WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
>  
> +		/* clear any mc-errs that occurred before. */

s/mc-errs/Memory Controller errors/

> +		if (mc->soc->interrupt_ops->clear_interrupt)
> +			mc->soc->interrupt_ops->clear_interrupt(mc);

There is no explanation of this change neither in the code, nor in the
commit message. Please always provide detailed descriptions for a
non-trivial changes.

Interrupts aren't cleared intentionally by the driver, otherwise you'll
never know about early-boot memory faults which happened before the
probe. Hence this change is incorrect.
