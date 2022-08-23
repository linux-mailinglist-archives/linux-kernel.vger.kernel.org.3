Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1B59E4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiHWOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiHWOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:09:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49718C002
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:21:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d8so6837291lfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WYHoBScee445mxmLl1VcAvUkOgEjYvy5gr7hD7QRLm0=;
        b=YtQIolGISeqSFordzcUfxNogHpxa4lLa5Wx4A7dpUHNV5xYw/hBM9462ca68gYp7t+
         XzKZg/iLeNjB10ghdeyFyO5jzB94qyAw8AY4hda5fXigTpdB653AHAg7mo47sApfk/H8
         WQVZyAJQf/SMZP7TdbtapR8lYla+bavWpw2/F6uxXx9CEaBvcYvso5MlXWi7a5I84D9B
         X6VN4vXSDBVgCtoe1p0RsejKbqZZAgOTvr110PAipdJFn0m2gPQPzvmphtHLB/ETk2Q6
         3lWVPDAK+vRekX/3+02RrknSBlU1AOgnHPJgnQjfTjYW73uBd34VHY6CGU/MS5wSIKRf
         QUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WYHoBScee445mxmLl1VcAvUkOgEjYvy5gr7hD7QRLm0=;
        b=qJ26Y9WyWNG8poFs2TKoMNogtYIIGqVmvHtR5oYtv84VNZ6uSPPSnT54jQUjD1ozST
         dJGy3kJrz9tmrGwIrSqjPuzpawn+6sEsSRZfj70+DGn9H5IY9dUIh1//F1UvI2gEe3Mx
         5Qn9vr4cSSEBnBizkqT98Wj0vHKtnmHzmTvkHT6aWK2ATcLuBKley8Sdc+mh4xj6FcUv
         sFXcOl7ydTw2chynb27szK7GD5UbZZvTuuLdtj3DqAtlZxGG34zYSPzBX0MpbF7U+5jO
         piKLnU5WyOS8iLNa2P3gsEa27DBi8GSLfcVJyd9Qmf5Oq61oAYR/u9UUTByX5xJV4Kjr
         NxOg==
X-Gm-Message-State: ACgBeo2m7wsgyl9+pPbYEBhbV4Ov3FwrViqr6N4Z6v0vbkZzoXkZ2rXH
        My2U4d82MCL+doR+3YzG66hKjw==
X-Google-Smtp-Source: AA6agR49R+6ju3SqvyM60OHEOqpf0+kU3Sl2+pRQacsafWqTW5kLXaINbzSO8R4frpFjkJfJfkfl7Q==
X-Received: by 2002:a05:6512:402a:b0:492:f879:e7b0 with SMTP id br42-20020a056512402a00b00492f879e7b0mr745797lfb.353.1661253637245;
        Tue, 23 Aug 2022 04:20:37 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id m21-20020a2e97d5000000b00261b21ea8a6sm2308242ljj.99.2022.08.23.04.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:20:36 -0700 (PDT)
Message-ID: <7eb3cca0-1be6-8f7f-a7bf-f0c9478e7080@linaro.org>
Date:   Tue, 23 Aug 2022 14:20:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2 0/7] i2c-imx-lpi2c: add IPG clock
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "wsa@kernel.org" <wsa@kernel.org>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
References: <20220816125526.2978895-1-peng.fan@oss.nxp.com>
 <DU0PR04MB9417E7BD5F1FB7A8E00BAA3F88719@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417E7BD5F1FB7A8E00BAA3F88719@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 11:46, Peng Fan wrote:
>> Subject: [PATCH V2 0/7] i2c-imx-lpi2c: add IPG clock
> 
> + Wolfram Sang I2C maintainer.
> 
> Krzysztof,
> 
> Do you have time to give a look whether this patchset is ok for you?
> Please forgive if this is too early ping. Some i.MX93 dts update pending
> 

I don't understand the ping. You got everything needed from us, why
still pinging? What that DTS has anything to do with us?

Best regards,
Krzysztof
