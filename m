Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE55842D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiG1PRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiG1PRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:17:04 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CF52FF9;
        Thu, 28 Jul 2022 08:16:53 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id y197so1582217iof.12;
        Thu, 28 Jul 2022 08:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JrlKPQ4z+/eb/LwH7+hyMBFCM3G+u1y3FbCWjxfRWs0=;
        b=c9zDFxtVgHQH4mlP2LqzUZUBvZBebrtUdUQbSfPbjayElwUKasqtHBvXK0OPLWWO6/
         e8juRC2fOFQg2Rvk4H1CCNyrYr9Auvw9bsRakQZFcYQNqQRKTgdL76bbgcb9RVdy4BAP
         GRQYXesoHpdBy97Bh0CaByHy1VYbPR+QrfQUgjvgaRQdAxxEfcwI2/O95YEMcs12g8rZ
         DqgqZtqYZem0AoHB2c9o6xX0sY/yMByGfbEfvpp1S/WbdfKAt+YpaWX3LXtc3bNiGVCK
         yE9jOAKAzMK6FW0X7zxjlLj4rMPEN07wx5XkADsMiWGygSAeZxmGefr0WbQAI1QastMO
         uyNw==
X-Gm-Message-State: AJIora80PW4rnd9WClBiThP0T9EDn3cAXOkKTvKlCP703xCaVkNxLhK3
        sQITYUSyFtc9RD0egwsfjw==
X-Google-Smtp-Source: AGRyM1unOndFqwJ/QxZY7xMrXPhTBF5duUZYZLQcuDRiBpPqUp3gM2q6daVUcFNXpNNq9PA/nFbCJQ==
X-Received: by 2002:a5d:844d:0:b0:67c:a76d:85cd with SMTP id w13-20020a5d844d000000b0067ca76d85cdmr6791200ior.191.1659021412634;
        Thu, 28 Jul 2022 08:16:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y11-20020a92d0cb000000b002cc20b48163sm466960ila.3.2022.07.28.08.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:16:52 -0700 (PDT)
Received: (nullmailer pid 899149 invoked by uid 1000);
        Thu, 28 Jul 2022 15:16:50 -0000
Date:   Thu, 28 Jul 2022 09:16:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,am3359-adc: add ti,am654-adc
Message-ID: <20220728151650.GA899095-robh@kernel.org>
References: <20220727155203.320929-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727155203.320929-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 17:52:03 +0200, Krzysztof Kozlowski wrote:
> Document the ti,am654-adc compatible already used in DTS:
> 
>   arch/arm64/boot/dts/ti/k3-am642-evm.dtb: adc: compatible:0: 'ti,am654-adc' is not one of ['ti,am3359-adc', 'ti,am4372-adc']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/adc/ti,am3359-adc.yaml    | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
