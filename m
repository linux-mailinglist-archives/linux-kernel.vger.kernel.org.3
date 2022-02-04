Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E144AA41D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377994AbiBDXQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:16:07 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:45837 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377955AbiBDXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:16:01 -0500
Received: by mail-oo1-f45.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so6337666oor.12;
        Fri, 04 Feb 2022 15:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zT4cyu0nuwo5GooR+j/43ZxaYfcW5fEHuWFebSaPqMo=;
        b=i81n8mlmUJajNJDAkkd+MiSnalgHDZSRKLJksSPtmoMpMlU05KDy5a/jpsJLtdGzws
         5Nn1W97fRH3RmtHUpnmZj6BOySA1wPg2+jf6+toSKcpji8I2e87mAE+5K/nS6UUWTGW5
         jW2+z1Hvx4WN1cXr0QXzJ5rBD+GAkglkdcwLZ4HWmLCKJYnJLi0eP+OJdsJkAKEl2kNE
         0fRlNCRkmmFSFQZVmoEOsp04OTvm4jhibSjI/ItNpS13+CHELRNEMdVeXPWOiK5129if
         Dd7SYVeoTwijZqJZt1t1qRLlazf+h8nBvvgu0cSYZ6J7vlewk5xomjp/7nCdRWul/wZA
         WexQ==
X-Gm-Message-State: AOAM533l4e+2kZoqB19NOsVh1GznONBeFZnEo7bpQAzYT4Xa1U2LeGqJ
        +ylItSd+oaqm8IWx0Ck8PFEeDNKtaw==
X-Google-Smtp-Source: ABdhPJxMX2u19Ur5MXMFNpLJpdmQdNuRdoNshQhWGHeGMn6DpeyCUka6VxdcVfXwqXzL9DiOKznDLw==
X-Received: by 2002:a05:6871:542:: with SMTP id t2mr1379311oal.155.1644016561071;
        Fri, 04 Feb 2022 15:16:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s11sm1219857otq.69.2022.02.04.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:16:00 -0800 (PST)
Received: (nullmailer pid 3364997 invoked by uid 1000);
        Fri, 04 Feb 2022 23:15:59 -0000
Date:   Fri, 4 Feb 2022 17:15:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 2/3] dt-bindings: spi: Convert spi-mt65xx to
 json-schema
Message-ID: <Yf2zr956n04yUr1v@robh.at.kernel.org>
References: <20220125012330.13449-1-leilk.liu@mediatek.com>
 <20220125012330.13449-3-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125012330.13449-3-leilk.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 09:23:29 +0800, Leilk Liu wrote:
> Convert Mediatek ARM SOC's SPI Master controller binding
> to json-schema format.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../bindings/spi/mediatek,spi-mt65xx.yaml     | 101 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-mt65xx.txt    |  68 ------------
>  2 files changed, 101 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
