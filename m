Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD02572FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiGMHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiGMHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:52:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6123E683D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:52:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y11so11228780lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TSYN2gdQpkM8ivcnEa62WHr83AOeOKe3JbqByJ/nhsg=;
        b=eWSejaJkD1tOyO+uDXpezGFR+GAMaqW25mO39XDHuZQta+A0zTwjYqpY4l7dTGVz+O
         Gqe2x6qOJcz4CIXZD4IrWYdD3YeKt6uzUTxcKJyCsg7+LhXsYYzefrIlBqRnFRV0JvXe
         z4rquh67LnQIr/ZnsnjSeKwCjq5kpwtS/1Jb8d7L+lSeyfaia9X8KNR/r5HccU6sTnEO
         601O2lS9PIHVmg8VFIi+8fd0v0FQPet5yN4WpekLU19wH/XS0slt4f9l78UgY6p0RiiQ
         9Py+gQSfmfLE8D41t73XQNd7u85a9oIKQs7y1kfaLZPqYdXAaV2lawiKDEW9YjSOavSR
         HxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TSYN2gdQpkM8ivcnEa62WHr83AOeOKe3JbqByJ/nhsg=;
        b=FTls6fh0kaQZRCMnhp4hviCgvexk1Lmckm2g4FJjXkI5dYZdrtqM/ulBgPMagzxXjK
         j1EJMIrO1uQrtx0O5jKqRGRB+nFyARlKbdL14u3ybU42DoD1QwMYaY5iy7gUjdgFi3RG
         LitmIQiS9CBX+RAqgmBZ6d1vNTd0sOsDhPSjuRX1ovZKXvWebvX6V/U0Xmkz5jCojGyp
         JcTANYTPAlUJVg9qfvA9QXa6Pfw17GunkDmJIKrDiW0Xp6Sp9P7Of2XN7NLoBwpIILBE
         M2HsfLIdye52w+B1/TH90GlXtOldMfVngQeCwE5uXx8WnaPtghmFX4rZF6qTwCjC7Akd
         HWpQ==
X-Gm-Message-State: AJIora/Wau5VXEI86giFnuXv895h+OteBJeVsI0NPgFiwnoGT41PbqSP
        WnEzpAojLnfxdC+Rly0o86y6IQ==
X-Google-Smtp-Source: AGRyM1sFojOEg7WcBCFLFgZZYS5/GEG635aOgfwKGZGop91VqjM/CXOZt6sU+u6iDRoIZSN2xABIdA==
X-Received: by 2002:a05:6512:3409:b0:489:fd59:a78f with SMTP id i9-20020a056512340900b00489fd59a78fmr1179056lfr.654.1657698755188;
        Wed, 13 Jul 2022 00:52:35 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z5-20020a2e3505000000b0025d476dc71csm2850767ljz.106.2022.07.13.00.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:52:34 -0700 (PDT)
Message-ID: <be752ee1-3732-bcbd-4d31-6d6fe0bd251f@linaro.org>
Date:   Wed, 13 Jul 2022 09:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com
References: <cover.1654660009.git.lhjeff911@gmail.com>
 <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 09:30, Li-hao Kuo wrote:
> Add thermal driver for Sunplus.
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>

Thank you for your patch. There is something to discuss/improve.

_data);
> +	ret = sunplus_get_otp_temp_coef(sp_data, &pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	sp_data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +							    0,
> +							    sp_data, &sp_of_thermal_ops);
> +
> +	if (IS_ERR(sp_data->pcb_tz)) {
> +		ret = PTR_ERR(sp_data->pcb_tz);
> +		dev_err(dev, "Failed to register tsensor: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sunplus_thermal_remove(struct platform_device *pdev)
> +{
> +	struct sp_thermal_data *sp_data = platform_get_drvdata(pdev);
> +
> +	thermal_zone_of_sensor_unregister(&pdev->dev, sp_data->pcb_tz);

You used devm to register, so this looks wrong and will lead to double free.


Best regards,
Krzysztof
