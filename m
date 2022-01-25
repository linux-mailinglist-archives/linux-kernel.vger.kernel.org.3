Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412C949A846
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317307AbiAYDBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:01:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56824 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S3415295AbiAYBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:39:05 -0500
X-UUID: ed62f45f87e34dfd8c932a2fd279f6f8-20220125
X-UUID: ed62f45f87e34dfd8c932a2fd279f6f8-20220125
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 136281167; Tue, 25 Jan 2022 09:18:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 25 Jan 2022 09:18:52 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 09:18:51 +0800
Message-ID: <184823d40e24166246b2be1fc823a18d413e341d.camel@mediatek.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: spi: Convert spi-mt65xx to
 json-schema
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Tue, 25 Jan 2022 09:18:51 +0800
In-Reply-To: <Ye6nQIVoti5TKh+k@sirena.org.uk>
References: <20220124061238.7854-1-leilk.liu@mediatek.com>
         <20220124061238.7854-2-leilk.liu@mediatek.com>
         <Ye6nQIVoti5TKh+k@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-24 at 13:18 +0000, Mark Brown wrote:
> On Mon, Jan 24, 2022 at 02:12:37PM +0800, Leilk Liu wrote:
> > Convert Mediatek ARM SOC's SPI Master controller binding
> > to json-schema format.
> 
> Please make any YAML conversion patches the last patches in a series
> -
> there's frequently a backlog in reviewing them so having the DT
> binding
> patches first blocks any progress on everything else in the series.

OK, I mistake to lost " dt-bindings: spi: Convert spi-slave-mt27xx to
json-schema" on V3 series, I'll send it again, thanks

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

