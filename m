Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54AD572FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiGMH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiGMHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:55:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF44E52AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:55:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a9so17744482lfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C5Ahe8CvJV6+IQFuNVZ6Ixp4DRWhIc+0zA/0isLezHI=;
        b=XUVo67Dw9xqvlJmrue7uzkCPHKs+bFRHK30wxWFnKLnwjH2P3G7IbvSCRzdrh7G3OW
         HlZEeDM9FC63nB+SaUZH53P3q7UIhjg3mjtfagduM4u5f4ut5vzJlBr/hrwm2OQbGoBN
         8U+0UpSwcACi3K2zweMsbpBBcurC8RTY5flBmApNIAXA1tS9KpMTbveKKISDIYdN9oa3
         S+B1LoMRSFbMft3ljWhQ0mKwZ5FznuhsfWpOWqDJfW4V6ZnbAJctK6d2Pyxs09A32JcL
         EwX/mrTd6Hh171ZqqEKJKI51UGwtpemu5tWLGeg9zglPX4dW1wzufPj5mCvojOW25wS6
         3AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C5Ahe8CvJV6+IQFuNVZ6Ixp4DRWhIc+0zA/0isLezHI=;
        b=iuiRgpK1WbB5Qg4ZFSTxHwuHkOYzo1h3fq8SKmCNRYAZmubqJCEwiG8HrVEHGOkmNL
         p4N5y2zKLS7lcg3c0qeT6UI9AVBqS9ZlxoSjlf4/ClnveFdp/NLcVtyjT5saUFqG7NeK
         YK0zyUlbvtcpPagVpcVIPeeR8Dop2pKU4wXWLwB/e5z4XYDi0456EJh4yQamccPXEODy
         P7Ctsk/AYQoJtqnDYU45SWsAgtUKy44YwxyUFkrl0st4/MIfe8FFblwOmJY2e4p2MBCZ
         Z/nivThFtuSn7IjCO3Ex3TPCfW786qp3BWtiROizPtyUMEnkDse+F+vybaGoOXwOMb3L
         rObQ==
X-Gm-Message-State: AJIora8NI7eVEBQ5AqpUeQolQ2YP+Io2ftUiW9PVveu7Z+/uMRkN8X0H
        jUnZMLXvnJwQ3rnA/+XNhG0crA==
X-Google-Smtp-Source: AGRyM1sJ+Aoga+YSt8y82rZb0WvZry1rJA8/m5aIOJMBVmqPrfEcfkdABOmkQm81VFS5o5twsFandg==
X-Received: by 2002:a05:6512:3b9f:b0:489:e009:ae0c with SMTP id g31-20020a0565123b9f00b00489e009ae0cmr1281654lfv.213.1657698942073;
        Wed, 13 Jul 2022 00:55:42 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id p23-20020a2e9ad7000000b0025d6f3f40b2sm1666017ljj.21.2022.07.13.00.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:55:41 -0700 (PDT)
Message-ID: <e8e0143c-88f6-95c1-7fa9-78cafa7a6d18@linaro.org>
Date:   Wed, 13 Jul 2022 09:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S
 board
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
References: <20220713074118.14733-1-frieder@fris.de>
 <20220713074118.14733-7-frieder@fris.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713074118.14733-7-frieder@fris.de>
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

On 13/07/2022 09:41, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add bindings for the Kontron BL i.MX8MM OSM-S board.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
