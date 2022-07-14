Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F3574D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiGNMZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiGNMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:25:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1C13CDF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:25:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t1so2509081lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UAISHAEdFVrlD0jxKyM5zQLMrlcB/02LXtemSFlb+NA=;
        b=lZ4oPLkoM0XsCmrt2j2WvAGHL1dQG/d3o57V/EVGyuoIlE2nhCF7MQl928MJVH0Jco
         B1uGn+wlRSpHrdqwqT1YXoqQbuxsnaxfhxMwVzP+/LCIQkCLUAVEPGhIrmsp5Uvlf2VS
         Rer7OiIZaWVdhutyp72kufBp5jIxSn7EGHoDvjRG+wJFOUE/YmW/wI/7WUTKxrKzehjN
         mHATs9OZp3/JyUGouFPMx14VyCBtX9VbQfXcdkEYVQoKqTIW3WzK2Hq8wtRwT8SrV1FG
         PTi0Fwv/CqLR8G7G0mNrtIB2up9Hl1I7tDTKYsS/7zkjdM5B4Y/tou7OLR7Z9hVEvLgv
         1xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UAISHAEdFVrlD0jxKyM5zQLMrlcB/02LXtemSFlb+NA=;
        b=EvMsh4HlB/ukyy3ZrSWA3pcI2Ncfx6sk91+229tW1UdnIsbM/n+81sz+LUXs2b1Xap
         2XM6QjV5Vm72ucA5eSfDzxDlnuD04hqfX63/VcWEe3Ld7ka5YNYa27xGd5hzlRA4Xe+m
         OFrx9jv8O6wWBVoGSh0MWDUZvRouhsAQkTA2IYNJKtWAdKtB/fF76FreTcBvZM1/Jo7U
         iCY9gkCMoxwYYxTf7/evBLf+V91bSaZfpajGb5aT1tn9wBY5bDwZa7ZYNV8stKk7r5dy
         uWY+19QpUkpJma+c7wKi0/GSa/yDF1ASroLmjCepnalcsRDwRcv0iWa26lEDCGa7bu3R
         GJYQ==
X-Gm-Message-State: AJIora+/f4DTGaQE//lO/wwQg35xWsdb9L93PNEgph0HKZSsYT/YNWEE
        ucLC391GNJWJF+8istacBSgVQw==
X-Google-Smtp-Source: AGRyM1tgVAG2WbRC05BYv5gYDhp3L3f7Xdrc/NVH4u3GitjcJDD4Nji3mEnw/+wi1a18EfPoBWHSSA==
X-Received: by 2002:a05:6512:398e:b0:481:154b:a92 with SMTP id j14-20020a056512398e00b00481154b0a92mr5535358lfu.110.1657801517877;
        Thu, 14 Jul 2022 05:25:17 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651c118100b002554dce4048sm262276ljo.53.2022.07.14.05.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:25:15 -0700 (PDT)
Message-ID: <b6a0abb7-f31f-0c8a-f65e-8d61b9e72f48@linaro.org>
Date:   Thu, 14 Jul 2022 14:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO
 driver
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220714122322.63663-1-tmaimon77@gmail.com>
 <20220714122322.63663-3-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122322.63663-3-tmaimon77@gmail.com>
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

On 14/07/2022 14:23, Tomer Maimon wrote:
> Add pinctrl and GPIO controller driver support to Arbel BMC NPCM8XX SoC.
> 
> Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> period time.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

> +
> +static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct npcm8xx_pinctrl *pctrl;
> +	int ret;
> +
> +	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> +	if (!pctrl)
> +		return -ENOMEM;
> +
> +	pctrl->dev = &pdev->dev;
> +	dev_set_drvdata(&pdev->dev, pctrl);
> +
> +	pctrl->gcr_regmap =
> +		syscon_regmap_lookup_by_phandle(pctrl->dev->of_node, "nuvoton,sysgcr");
> +	if (IS_ERR(pctrl->gcr_regmap))
> +		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->gcr_regmap), "Failed to find nuvoton,sysgcr property\n");

Please wrap your code according to Linux coding style - @80.


Best regards,
Krzysztof
