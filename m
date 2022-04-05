Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183EC4F2497
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiDEHXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDEHWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:22:44 -0400
X-Greylist: delayed 84052 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 00:20:37 PDT
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F01D8;
        Tue,  5 Apr 2022 00:20:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D202024000C;
        Tue,  5 Apr 2022 07:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649143234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpvfYdyA2PB7667ZTFEYC37nx0xbGndnvQLkh+GtoUc=;
        b=h7hY9Jo6S5R/X/FMHAFNGYaEyyD9HrfcpGcmAW5frfsecCC8u0xeUQQZ7JJb45pOrHonQB
        5BUPWLjFDMmnXKq8WFiKDZ403XDFDD3uIdBDZGdjYfUK2vA9d+Kl12efhuNWtX6uUBeAD1
        ZagFg9uip+bqYD9yNMQuWKLcKDvGVechHM2qXYq5Z7w0TZ7+vA4RMnPoIGlT4x8B7KblfB
        V24FmKwjDy+xZkws3pak/3FMAGk01NGyF9vPRPS4j6lir8BcHO7X57ZJqSo0K/d1ua1lm8
        udxlvKJRsxYPs3EMlnJ/PgeLM42VMwMEJGAUGncNYDAaN0Gxb83tniqf8XtcTg==
Date:   Tue, 5 Apr 2022 09:20:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org,
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
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for
 spi-mtk-snfi
Message-ID: <20220405092024.25d97c33@xps13>
In-Reply-To: <CAJsYDVLaXAoL=TcPun6rckcA_cdUS-zFy_7M6uCpfzX+jbQEag@mail.gmail.com>
References: <20220404131818.1817794-1-gch981213@gmail.com>
        <20220404131818.1817794-5-gch981213@gmail.com>
        <1649088538.050456.1436949.nullmailer@robh.at.kernel.org>
        <CAJsYDVLaXAoL=TcPun6rckcA_cdUS-zFy_7M6uCpfzX+jbQEag@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

gch981213@gmail.com wrote on Tue, 5 Apr 2022 10:55:51 +0800:

> Hi Rob!
>=20
> On Tue, Apr 5, 2022 at 12:09 AM Rob Herring <robh@kernel.org> wrote:
> > [...]
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sp=
i/mediatek,spi-mtk-snfi.example.dt.yaml: spi@1100d000: 'ecc-engine' is a re=
quired property
> >         From schema: /builds/robherring/linux-dt-review/Documentation/d=
evicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> > Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.=
yaml:0:0: /example-0/soc/spi@1100d000/flash@0: failed to match any schema w=
ith compatible: ['spi-nand'] =20
>=20
> I ran the tests myself and it's only complaining about the ecc-engine nam=
e:
>=20
> /home/user/src/kernels/linux/Documentation/devicetree/bindings/spi/mediat=
ek,spi-mtk-snfi.example.dtb:
> spi@1100d000: 'ecc-engine' is a required property
> From schema: /home/user/src/kernels/linux/Documentation/devicetree/bindin=
gs/spi/mediatek,spi-mtk-snfi.yaml
>=20
> It says nothing about the spi-nand part.
> I'd like to keep the flash@0 node in the example to demonstrate the
> nand-ecc-engine usage. What should I do?

You can try including spi-nand.yaml (like you do with
spi-controller.yaml). You should no longer need to define
nand-ecc-engine then as it is already described there?

Thanks,
Miqu=C3=A8l
