Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33A52A455
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbiEQOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbiEQOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:09:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6041F80
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:09:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g16so21927704lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VQ/tQhaBagrVvoxKym1eNDePBUWWDTsDmQsIJ7z9tmc=;
        b=lq3LyMXRIj9ws/e9xkK2Ftm/9JayeFvZ4LPe0TTBdLd1OlQqjlPHqMH8ljTrgj4fMY
         DzMlcvCXa7xCPNk++DAhkJm47mpiy+plW2AsKPZkCdwPRuoOlyhd9TrK8hOfHiWSV/MW
         vCTfGqduDWyM8SRYM5cRFsh+EvhMtlUANGZ5g2swOQFwBSKMUX6eTlllFC/2OcgLL8r3
         fBbnCCBLWgMyUks4Deiz0WkQBBiDMN0IHp8qBC+zmUqHBjTcW5/BMtzUC/zI6O+rAaj9
         Dmg4g3hW2IM6iBwqR2+Q1ma6JLwiKPnvjBsjZsLNgPf+dBP8vZjc6mtdDX5IQljF+d/y
         Qn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQ/tQhaBagrVvoxKym1eNDePBUWWDTsDmQsIJ7z9tmc=;
        b=YAcTQkpynz41OKPxlTz8dV9YMqDQfdpHaL1zb095XpZExUL2fyjCLkdazG+JvpdGFK
         dR1JH4jlDeFa523fLhTsW5dyrS5x4jM5odp4XXuFwL9idl7xVA8+h+2dTI9P3Rd24+5d
         euP744TMAywdOpzW9e9WQ4AKlcrCGdYCf1KQMacRMNtwx030f5ugFHzJWDGYJZZMQd4B
         qAwyJEOWj3SnKjgIPnMkmLGBsAeRardjaKmyUuvtOsJZi3n4e3ERavzoCelm186SUnGb
         x6E7CIuPgsbfrvLSSI0P/9vHOr6dY5qISBI2UC3K40IvpB5ZzKYx82WjP8n5apQVieMm
         9Qrg==
X-Gm-Message-State: AOAM533sQtUnRk1+rMfZTnbXuw6TaTOyZRe8MwDG6ruJ9CTzgu9IX8vQ
        XoGQJMvyjqXnTN2CEZ0HeuUCwg==
X-Google-Smtp-Source: ABdhPJy5FwGw6iL9PZmQwU7TuQNTYtWJUfOU1FklF2Xf+G8XgFNjrWljP/K3gIULCLHrapMqKdWnKg==
X-Received: by 2002:a2e:b0e5:0:b0:253:b5a0:e8af with SMTP id h5-20020a2eb0e5000000b00253b5a0e8afmr2304574ljl.250.1652796537252;
        Tue, 17 May 2022 07:08:57 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a197402000000b0047255d211ebsm1591039lfe.282.2022.05.17.07.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:08:56 -0700 (PDT)
Message-ID: <79dcb6b9-e983-15ee-709b-878c889bfe4d@linaro.org>
Date:   Tue, 17 May 2022 16:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] nvmem: microchip-otpc: add support
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220517125822.579580-1-claudiu.beznea@microchip.com>
 <20220517125822.579580-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517125822.579580-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:58, Claudiu Beznea wrote:

Thank you for your patch. There is something to discuss/improve.

> +static const struct of_device_id mchp_otpc_ids[] = {
> +	{ .compatible = "microchip,sama7g5-otpc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mchp_otpc_ids);
> +
> +static struct platform_driver mchp_otpc_driver = {
> +	.probe = mchp_otpc_probe,
> +	.driver = {
> +		.name = MCHP_OTPC_NAME,
> +		.of_match_table = of_match_ptr(mchp_otpc_ids),

This still has incorrect pair of of_match_ptr/maybe_unused. Either both,
or none.


Best regards,
Krzysztof
