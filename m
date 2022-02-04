Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E514AA3EB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377828AbiBDXD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:03:27 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42500 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbiBDXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:03:23 -0500
Received: by mail-oi1-f171.google.com with SMTP id v67so10231448oie.9;
        Fri, 04 Feb 2022 15:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRBN3drX7LNP2CglYfthuDAO2TQ4Y16kM+T6H92Cb6k=;
        b=RDdRTTxrrG/xYaW26F3C9Jp2y3+/RP0vjy/lnACC/8IlU4fDzHnna3B3Yi2SB9POMd
         1imlxgIIglbs15HDgj2bt69B6kByw7t8kh3xM5x96vgYU3cjoWx/ITsfLg64pDlrK66+
         1U0YBSQkDPnE0ZvgWZekTJlJ07sPLr0KKz3bnN3LWHKu+ehPaNJU3vBh8zwV6+utTYE/
         8OAseSChtWEQebAQwRqCizpc3x77rgfCSVGauwaXNlkYrSc0su59jtSldP+rJZTl7FGu
         +VeFquL/A1n4M62wLRy+xlDRY8kyswmag3MpyybIBA/DrUg4/zCE+yqoUrFXkMBXEaAS
         SeUA==
X-Gm-Message-State: AOAM531u9F+eP/2BvKYKJ/yp5MJZiiaQCpnaNcPAZlJQU+HM3MrB9Hbg
        KSMzO+CmzT9oMV7cghQld0CaWZHlEg==
X-Google-Smtp-Source: ABdhPJxZGN8zUGqe8CCQFcnofv9zbGm8GHdE4O+DkLg3DuLzo4Ke7310tsAgwmT4loZ02k4nEVDyQw==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr2519227oik.268.1644015802559;
        Fri, 04 Feb 2022 15:03:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l4sm1289993otq.50.2022.02.04.15.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:03:21 -0800 (PST)
Received: (nullmailer pid 3347992 invoked by uid 1000);
        Fri, 04 Feb 2022 23:03:20 -0000
Date:   Fri, 4 Feb 2022 17:03:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 1/3] dt-bindings: spi: Convert spi-slave-mt27xx to
 json-schema
Message-ID: <Yf2wuML7yqiSUKqJ@robh.at.kernel.org>
References: <20220125012330.13449-1-leilk.liu@mediatek.com>
 <20220125012330.13449-2-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125012330.13449-2-leilk.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 09:23:28 +0800, Leilk Liu wrote:
> Convert Mediatek ARM SOC's SPI Slave controller binding
> to json-schema format.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../spi/mediatek,spi-slave-mt27xx.yaml        | 58 +++++++++++++++++++
>  .../bindings/spi/spi-slave-mt27xx.txt         | 33 -----------
>  2 files changed, 58 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
