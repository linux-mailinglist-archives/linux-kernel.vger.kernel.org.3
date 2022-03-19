Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2A4DE92B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbiCSQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiCSQBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:01:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CF19A568;
        Sat, 19 Mar 2022 08:59:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so14787741ljr.9;
        Sat, 19 Mar 2022 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b/2h9Zjao6ViTWfkUi2/axXfZU/JCbLXesxyPFxXxJk=;
        b=gkNJkBBmQjhR7zJ5vwj7Reqvp1Z6uKl8FQjiVb4wMJKnajfdkswM6W1jLII2JtDzy+
         lxdT8291KYrNYI4b0t2nJkxlu1ziyQ2bjKtY5mRF5gsV/i+YvzVeANE3E6GqPdyCQL70
         I8jY9V8xKJl5ofrXwZ9r4yiVNH9g4+gTZw3dNRu9y4/PULX/1r81vE4458p0FJ/5AZT/
         RlkUvjmJydYhl/9fYXoP1zhY+xCmqfbzahK1Y04mO0/zP/o6+G0tqSDssPf4pdctbEHu
         ycrl2LbSsiZ2Zr2Op7ilwVl0uUjZ7Md4EJRQz3dkFhPkegWIFCLlccHT7EMjl40WU1kQ
         6Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b/2h9Zjao6ViTWfkUi2/axXfZU/JCbLXesxyPFxXxJk=;
        b=v620xQBpeItbd8VEhXZEBjNUdEgq5Pr7mjdyb0nMekGLBw8DKB9/t39ephFbZ9XeET
         7seUBy5ULO1WxtN6YyOAqtk4XOdE/yEMlr/d+IzsRj3MHWz8tieqa2GzfUVMtyfj2lQe
         2fHgmhRs0/N8yL2kaA2h0fquQ0dSNiLLwx4053z9F9c9zLK3prWVNppqnDeW6FiAmi5P
         CasKvzE4xbhQSwx/pg2cs4B3u8fSGDbdgNrSP1sosGvEBCvRKEN4SGM0FQ7/s0j4zrJh
         u4Auaisx8S7yge3YNjxC9f5EPAuME3GM8mxIwWY1BcEBRyo0UP28Qn6ZW8cpGbTuv1eK
         dSLQ==
X-Gm-Message-State: AOAM531Wg+G/3VxTcyHb2ZB0cnQYNI7FgluJ70uKmSic/63kHpZ7zSze
        00B1bkAV8I9C5gYhv2b5Amo=
X-Google-Smtp-Source: ABdhPJzBeqnap3apYCM1GG7Qr4nAZE22RlFw4xs/qASK1p6n6/Fnf1r/XvEH8NSDOSYU5eIlZYTMmg==
X-Received: by 2002:a05:651c:2cb:b0:23d:3168:915b with SMTP id f11-20020a05651c02cb00b0023d3168915bmr9255945ljo.22.1647705579751;
        Sat, 19 Mar 2022 08:59:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id f12-20020a05651c02cc00b002495ddc58easm1330792ljo.32.2022.03.19.08.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 08:59:39 -0700 (PDT)
Message-ID: <168cf065-bc17-1ffc-8cc0-75775c7f3bcb@gmail.com>
Date:   Sat, 19 Mar 2022 18:59:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220316092525.4554-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.03.2022 12:25, Ashish Mhetre пишет:
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index 92f810c55b43..6f115436e344 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -203,6 +203,8 @@ struct tegra_mc_soc {
>  	const struct tegra_smmu_soc *smmu;
>  
>  	u32 intmask;
> +	u32 int_channel_mask;

ch_intmask

> +	bool has_addr_hi_reg;
>  
>  	const struct tegra_mc_reset_ops *reset_ops;
>  	const struct tegra_mc_reset *resets;
> @@ -210,6 +212,8 @@ struct tegra_mc_soc {
>  
>  	const struct tegra_mc_icc_ops *icc_ops;
>  	const struct tegra_mc_ops *ops;
> +
> +	int (*get_int_channel)(const struct tegra_mc *mc, int *mc_channel);

This should be a part of tegra_mc_ops.
