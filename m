Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6550E4FF48E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiDMKTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiDMKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:19:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2EA57148
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:17:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so2916374ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+p9OhkRWnU4KvZxsWUOBOa1aYPgHNe796kCuZ/Rbemw=;
        b=KdMY7C1/bpo1NHLGrHjYumxcgSCzqO0LjpALLIq/biQ/fK9NL3DH4iiRCabL5kfCut
         DQnuyPXS61QoXZadQYFaswTtf6v3cuNR/0Imzm/eF0a6c0lQIPRjU9bNlOYCgCc/vJF9
         IQphk1UFmLXa3aeyftdTqOrpIiJwiM+XwWNP1EAlmuL5LoAQ8JvUh8uspC1nj5uXUmbA
         rDflWKiPP9/dX/7/2KhM9yQGOdLzDF7ma14UiqxUD+6NxrGj3uoV+oKFhsKGneci3dZK
         eqD1LPP9RdQSVnGcecw+UHepP8h+5wS/MLiG4wVhasAzNoj18VdoTJA8VkZydVIFXJO4
         i9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+p9OhkRWnU4KvZxsWUOBOa1aYPgHNe796kCuZ/Rbemw=;
        b=I1dI9W+sKADYS0BYEFHN7oTh6SyeqSYM7QjK58Mrs9J9ZbxvfsAgv6in1ttRmbFL5T
         UAJJ6zW41+E6+0WFUz7oNeFgEkK4H5G3eXt9lYgtFbOtbQS5UJ+4DpMVgYCftG3kNnFL
         lgNBmjiZH75hMNYjTzj6coxC7un8ZsZETaAx83cVUcN2rXN3ZNO9d897qSemmiYOeZiF
         ngFB5Xle0xzHN/r6EdORIm62oKqKldrgh5BTNNd6xOoxyacBIjUEFMR0HD6UbkVrYFbH
         0Hk6U3W4YHWU3YHup9xkwWtir7Y11kNSuDy7m7bBRTLBx3jgFlnmgOcNsLdw3Ca80/bx
         2wag==
X-Gm-Message-State: AOAM532n6/eVlnG6ydu0uhDTgd+ABr4/Qdd63t2HQZG6DHosCBSSRVsb
        gXQrsn4gLCWfAt1x4J7bktrdew==
X-Google-Smtp-Source: ABdhPJxHkJTh8c3ZBgS7Vn312uG35xCXzwXPNIs5425WDpbNuafB8mLuK02G5kzvi/vCtITLUNmHNw==
X-Received: by 2002:a17:907:96a9:b0:6e0:db4a:ba8d with SMTP id hd41-20020a17090796a900b006e0db4aba8dmr39539516ejc.87.1649845046712;
        Wed, 13 Apr 2022 03:17:26 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jl28-20020a17090775dc00b006e05cdf3a95sm14081100ejc.163.2022.04.13.03.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:17:26 -0700 (PDT)
Message-ID: <7ac04ea5-a797-de24-7701-76699d73518a@linaro.org>
Date:   Wed, 13 Apr 2022 12:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-5-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412101409.7980-5-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:14, Keerthy wrote:
> Add VTM thermal support. In the Voltage Thermal Management
> Module(VTM), K3 J72XX supplies a voltage reference and a temperature
> sensor feature that are gathered in the band gap voltage and
> temperature sensor (VBGAPTS) module. The band gap provides current and
> voltage reference for its internal circuits and other analog IP
> blocks. The analog-to-digital converter (ADC) produces an output value
> that is proportional to the silicon temperature.


(...)

> +
> +static void print_look_up_table(struct device *dev, int *ref_table)

Here and everywhere else in such cases - you do not modify pointed data,
so pointers to const please.

> +{
> +	int i;
> +
> +	dev_dbg(dev, "The contents of derived array\n");
> +	dev_dbg(dev, "Code   Temperaturei\n");
> +	for (i = 0; i <= 1023; i++)
> +		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
> +}
> +
> +static const struct of_device_id of_k3_j72xx_bandgap_match[];
> +

Why do you need forward declaration?

(....)

> +
> +static const struct of_device_id of_k3_j72xx_bandgap_match[] = {
> +	{
> +		.compatible = "ti,j721e-vtm",
> +		.data = (void *)&k3_j72xx_bandgap_j721e_data,

Why do you need the cast?


Best regards,
Krzysztof
