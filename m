Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D04F4526
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiDEUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457464AbiDEQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:17 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3225B;
        Tue,  5 Apr 2022 08:52:21 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d39f741ba0so14787462fac.13;
        Tue, 05 Apr 2022 08:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73sr+mzCEmuVDVSdm+EpGuiiOfdHmYopaGe2xWN1rOQ=;
        b=LOHBsIs1i8+vXoe7aUERRl8rO0v5Ha7HFlOiKBzy07QYiVC/Byherukzji78/HnEwM
         siH0hRUUZ+7DxL0/OLHSoiyVGdZe5Y5TGO3Tp4Lfb+aCg+kLvJdZ2CgJ0lnLqDTgx2F8
         JAVOpHbc5obkKFy8gqq6SNPe/ld1Qh5SLv0bsKg8BO20xiIh5F8nUAibDkDjQeVU3IsL
         a8RRGZH0tdUXTR86SSW1DHSuGxhYMoCAPkQW0pGFEc/4VIsHaRspwyb+sPBCkWsPCCxb
         mEdp2ThL+hQj98Mte2MtX4pY5nCiZNHoNGhiKRWx/9pJBZX3Xur2j1ODsH83yxdcJoPF
         UBCg==
X-Gm-Message-State: AOAM531Z+Ym25rp24zeeb9P5AQiTRTt3Ud+M2sXFxWFwQeYZgdVRUi4d
        U/Ttriw3NYWHzQ4isTImuQ==
X-Google-Smtp-Source: ABdhPJxNSzVmokJVTPd1XNB16cHa14S7IaMy1MJZPXDKNndI7oIgOU3kFQsdma7sT8pY4vAAcBr/KA==
X-Received: by 2002:a05:6870:f149:b0:dd:f3b0:986d with SMTP id l9-20020a056870f14900b000ddf3b0986dmr1904739oac.148.1649173940623;
        Tue, 05 Apr 2022 08:52:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 2-20020a056870124200b000dd9ac0d61esm5524206oao.24.2022.04.05.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:52:19 -0700 (PDT)
Received: (nullmailer pid 3284623 invoked by uid 1000);
        Tue, 05 Apr 2022 15:52:17 -0000
Date:   Tue, 5 Apr 2022 10:52:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Roger Quadros <rogerq@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        linux-mediatek@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
Message-ID: <YkxlsU+P33ip2oWH@robh.at.kernel.org>
References: <20220404131818.1817794-1-gch981213@gmail.com>
 <20220404131818.1817794-5-gch981213@gmail.com>
 <1649088538.050456.1436949.nullmailer@robh.at.kernel.org>
 <CAJsYDVLaXAoL=TcPun6rckcA_cdUS-zFy_7M6uCpfzX+jbQEag@mail.gmail.com>
 <20220405092024.25d97c33@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405092024.25d97c33@xps13>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:20:24AM +0200, Miquel Raynal wrote:
> Hello,
> 
> gch981213@gmail.com wrote on Tue, 5 Apr 2022 10:55:51 +0800:
> 
> > Hi Rob!
> > 
> > On Tue, Apr 5, 2022 at 12:09 AM Rob Herring <robh@kernel.org> wrote:
> > > [...]
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.yaml: spi@1100d000: 'ecc-engine' is a required property
> > >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> > > Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.yaml:0:0: /example-0/soc/spi@1100d000/flash@0: failed to match any schema with compatible: ['spi-nand']  
> > 
> > I ran the tests myself and it's only complaining about the ecc-engine name:
> > 
> > /home/user/src/kernels/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dtb:
> > spi@1100d000: 'ecc-engine' is a required property
> > From schema: /home/user/src/kernels/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> > 
> > It says nothing about the spi-nand part.

Did you use 'DT_CHECKER_FLAGS=-m' as it says above?

> > I'd like to keep the flash@0 node in the example to demonstrate the
> > nand-ecc-engine usage. What should I do?
> 
> You can try including spi-nand.yaml (like you do with
> spi-controller.yaml). You should no longer need to define
> nand-ecc-engine then as it is already described there?

Including spi-nand.yaml is wrong. If that just landed, then this may 
have run before the base moved to v5.18-rc1.

Rob
