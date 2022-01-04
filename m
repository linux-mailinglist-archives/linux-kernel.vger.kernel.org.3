Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475B1484AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiADWdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:33:11 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:35609 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiADWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:33:10 -0500
Received: by mail-oo1-f53.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so12045473oog.2;
        Tue, 04 Jan 2022 14:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyp0ZlymfUBJlUAVtIOpIrm/4K+CwyVLR4ySvnMgQQs=;
        b=xkLlXcu3vHLbPNC+qowedWT1g8V6rcl+dpQ1BfeBj+ZSOWkS3fehu56c2BX71MiLKV
         STV06ldvQ0aJ6E34DafArY1FPS7HfBTQJ/e/6kwhO7UAv6tp5McotGTZ3EChzZhXlGYl
         rqHCn8G/Pc9NLZPaP6SRAYjkeTevlQlOR4rs4kDpSV5Yt6wfL1gjB2mXrF5aAFUT53HM
         AzM9KTBYn+UYjOWBvIcYL20mTYML0fhy+W7xM7UHIBsSVGuQs1b2YYF7lQQrjGeddQEt
         ePCJCG2klcDB3fgRSkfGF3gsohV1lvC2Z/o3E3/ggeclopTCpqGgbj7qlkiGaB2oZT5Y
         QTWA==
X-Gm-Message-State: AOAM532bPXLNCk0nXK+VkPVDyqOUShHYv9Yn5wnEOstGFjr6/xTdpOVk
        TPNz94fpOiFiE3Pz8j1M9g==
X-Google-Smtp-Source: ABdhPJzNpFrcI/rkXMcHtDq7VDwS73qIpjhsYqKdPBLPM3cpBiZjkTX+V0DOvCWOkIvFUhaA/aESKw==
X-Received: by 2002:a4a:cf09:: with SMTP id l9mr31402830oos.89.1641335589318;
        Tue, 04 Jan 2022 14:33:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g12sm6073845otp.45.2022.01.04.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:33:08 -0800 (PST)
Received: (nullmailer pid 1569633 invoked by uid 1000);
        Tue, 04 Jan 2022 22:33:07 -0000
Date:   Tue, 4 Jan 2022 16:33:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: add cap-sdio-async-int flag
Message-ID: <YdTLI/Nms4JiNutt@robh.at.kernel.org>
References: <20211227083641.12538-1-axe.yang@mediatek.com>
 <20211227083641.12538-2-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227083641.12538-2-axe.yang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 04:36:39PM +0800, Axe Yang wrote:
> Asynchronous interrupt is a mechanism that allow SDIO devices alarm
> interrupt when host stop providing clock to card. Add a DT flag to
> enable this feature if it is supported by SDIO card.

A card property should be in the card node. Is this not discoverable?

> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 25ac8e200970..7230421583c6 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -165,6 +165,11 @@ properties:
>      description:
>        eMMC hardware reset is supported
>  
> +  cap-sdio-async-int:

Perhaps be consistent with the next property and use 'irq'.

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      SDIO async interrupt is supported.
> +
>    cap-sdio-irq:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -- 
> 2.25.1
> 
> 
