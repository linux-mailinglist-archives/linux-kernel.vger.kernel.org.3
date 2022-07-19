Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22657981F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGSLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiGSLEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:04:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF372255BB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:04:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x10so16482287ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EX19RpTLgpzKcCJO8mDxPYr2eZCUlJJYLs40GJ/aDtE=;
        b=s3SRJ6/kPB9R99UVkk665l3uCz1jjAO4bxRMm6Mp1nfnXdVeb6zW6map6ov6BrtRCZ
         clj/jGjEay1UIEB1sXQgCKGLyOAFolccLC8dyjBzdoS8q5v0O9fmM6h2cdkLj/hvtpLt
         MrAHDSxWRVUBZwwnJ7sQCrnJSdNvMmu2xV89kRvtGFq+IZ9Q6uYqmOBRJ4d1WUQkkYPP
         WSBkkv8JHfyf0O887nmYU9G7zbMBaymD9ajnX6OprjEJi2PnNfVqr19PijTrcfPx0qcU
         PxeQ68n7NpjWOpI56FSSX04lOw9L8TZk+CuySjX3CbQY+BZrIQLkrXt8AWwhEphwa90R
         ti6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EX19RpTLgpzKcCJO8mDxPYr2eZCUlJJYLs40GJ/aDtE=;
        b=c+swYDXQg0s/fiDzBoFkhvkrl3X4yrwjl8daoGbqH9lA6TnbdKafXxyrXwNZ5QXGwi
         KsSmCkSIXDLdU45CZGq8pyko+S1OqEY4gm6xEGFtNKVNbobbf/ad/FV9ko/yX1AQJo/j
         3YZseGAlV5pDA/XQerqGrdgri6r3QE3LIJuRIdaW9njQvea74BRnAsmyxttmSrrVt7Po
         Nw4OOD+4FYLVw0TXA8p/ZQr2a3na5o8G1lqqKO9i6F/GiyZm2Rq9z+dD1KCDW8iWi5sz
         R4SQf92f8dstiN9dWWVVam1ZAw1+7zkZQs/fWk4o/k4ePp9nHQ5JKqp68uS/s7awUQr4
         pgmA==
X-Gm-Message-State: AJIora9b88uO8NRhr9ySJnsSTXY9caBm1ucHq8EaybW7OrdKi4F1Qzq5
        WmNoexZo3hMs0DW2IcrHv0X1JQ==
X-Google-Smtp-Source: AGRyM1t1ByyKQvuvfe41Tkvj/zYbbhsK14gV6ydWq1VeAlZ4j7rEjFY23wSBgIriw+qgh2nbPfxQnA==
X-Received: by 2002:a2e:a490:0:b0:25d:7609:1fbf with SMTP id h16-20020a2ea490000000b0025d76091fbfmr14767979lji.432.1658228692354;
        Tue, 19 Jul 2022 04:04:52 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id c3-20020a2ebf03000000b0025dabcba63csm1659273ljr.17.2022.07.19.04.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 04:04:51 -0700 (PDT)
Message-ID: <13fd6d44-c645-0935-9fc6-aeebcb96b9cf@linaro.org>
Date:   Tue, 19 Jul 2022 13:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] ASoC: dt-bindings: atmel-classd: PDMIC convert to
 json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
 <20220715162922.660859-3-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715162922.660859-3-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2022 18:29, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert Atmel PDMIC devicetree binding to json-schema.
> Change file naming to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> v1 -> v2:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
