Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6F48A550
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbiAKBsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:48:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50446 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346367AbiAKBsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:48:53 -0500
X-UUID: ef557eaa453146d3b37f871189d29131-20220111
X-UUID: ef557eaa453146d3b37f871189d29131-20220111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 784400594; Tue, 11 Jan 2022 09:48:51 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 09:48:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 09:48:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 09:48:49 +0800
Message-ID: <f9ee59dab63c33001b196e56fd55aa890948ddcd.camel@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Convert spi-mt65xx &
 spi-slave-mt27xx to json-schema
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 11 Jan 2022 09:48:49 +0800
In-Reply-To: <1641833339.690847.1067453.nullmailer@robh.at.kernel.org>
References: <20220110053744.30323-1-leilk.liu@mediatek.com>
         <1641833339.690847.1067453.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-10 at 10:48 -0600, Rob Herring wrote:
> On Mon, 10 Jan 2022 13:37:43 +0800, Leilk Liu wrote:
> > Convert Mediatek ARM SOC's SPI Master & Slave controller binding
> > to json-schema format.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../bindings/spi/mediatek,spi-mt65xx.yaml     | 96
> > +++++++++++++++++++
> >  .../spi/mediatek,spi-slave-mt27xx.yaml        | 69 +++++++++++++
> >  .../devicetree/bindings/spi/spi-mt65xx.txt    | 68 -------------
> >  .../bindings/spi/spi-slave-mt27xx.txt         | 33 -------
> >  4 files changed, 165 insertions(+), 101 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> > mt27xx.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/spi/spi-
> > mt65xx.txt
> >  delete mode 100644 Documentation/devicetree/bindings/spi/spi-
> > slave-mt27xx.txt
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> mt27xx.yaml: properties:compatible:oneOf: [{'const':
> 'mediatek,mt2712-spi-slave'}, {'const': 'mediatek,mt8195-spi-slave'}] 
> should not be valid under {'items': {'propertyNames': {'const':
> 'const'}, 'required': ['const']}}
> 	hint: Use 'enum' rather than 'oneOf' + 'const' entries
> 	from schema $id: 
> http://devicetree.org/meta-schemas/keywords.yaml#
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> mt27xx.yaml: ignoring, error in schema: properties: compatible: oneOf
> Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> mt27xx.example.dt.yaml:0:0: /example-0/spi@10013000: failed to match
> any schema with compatible: ['mediatek,mt2712-spi-slave']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1577767
> 
> This check can fail if there are any dependencies. The base for a
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

OK, I'll re-send it, thanks

> 

