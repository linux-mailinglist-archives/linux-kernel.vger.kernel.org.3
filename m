Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAD501AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiDNSE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiDNSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:04:55 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26085974;
        Thu, 14 Apr 2022 11:02:29 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-dacc470e03so6032894fac.5;
        Thu, 14 Apr 2022 11:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kQY7KYrORAXRdj8BS7CtbvQFtLXKlCapss2LUGGejI=;
        b=c8PYoXzbecyFSTn4hc9onZzN6TAVpvknh/77qbaTtRdVZV0/2AjHBKudu75x9iAf7Q
         JkEm2f513e8Zq9oSfCMJu07c6YC4XHqRv67cGA0/EvyXfBNVwH5T/1riA1S04zOrgU0E
         07zP/0KUO8wVS6bNhu1wLwIXAtwyvTBcxyXzz2UI9RUUDM5a/Nfel3X1QfARxfgZ9yWA
         3XcYxmoH5Yye4P5jsKa/ENb5g6PEYBnex0cryVfvZSXkBGXR0vmhBcErbZl4vFY0QFu1
         pfsMUnNe9TTElVj2X8v1dytjf4EcybN6CCCWgv00M0oIQ4QS3Zyzy7+Ih4ycLUzXPDs3
         dZbg==
X-Gm-Message-State: AOAM533rkZcWzuqcflzn/kGItqBSp3pON5n05xL1svkg4t2BFqmKfONs
        GiYZbGj7EG82RHSN6vpxvA==
X-Google-Smtp-Source: ABdhPJxg/IzXLr9/pK68rl/yhXiL0WZz7ZwJQGzyFx0L13S4P88U4n2DfT3AFMuvduEA0czJc4UQrw==
X-Received: by 2002:a05:6870:c892:b0:de:5f75:d8 with SMTP id er18-20020a056870c89200b000de5f7500d8mr2133742oab.133.1649959349136;
        Thu, 14 Apr 2022 11:02:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a056870239600b000e2f0c69849sm940449oap.11.2022.04.14.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:02:28 -0700 (PDT)
Received: (nullmailer pid 2320842 invoked by uid 1000);
        Thu, 14 Apr 2022 18:02:27 -0000
Date:   Thu, 14 Apr 2022 13:02:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-media@vger.kernel.org,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-hwmon@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: Fix array constraints on scalar properties
Message-ID: <Ylhhs2hgbQg8Ugeb@robh.at.kernel.org>
References: <20220413140121.3132837-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413140121.3132837-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 09:01:21 -0500, Rob Herring wrote:
> Scalar properties shouldn't have array constraints (minItems, maxItems,
> items). These constraints can simply be dropped with any constraints under
> 'items' moved up a level.
> 
> Cc: Agathe Porte <agathe.porte@nokia.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-hwmon@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml       | 5 ++---
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml      | 4 +---
>  Documentation/devicetree/bindings/media/coda.yaml            | 1 -
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml   | 2 --
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml   | 2 --
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml       | 1 -
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml | 4 +---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml  | 2 --
>  8 files changed, 4 insertions(+), 17 deletions(-)
> 

Applied, thanks!
