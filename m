Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51EF48708F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbiAGChY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:37:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59068 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344794AbiAGChX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:37:23 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n5f78-0006EM-9F; Fri, 07 Jan 2022 13:36:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jan 2022 13:36:21 +1100
Date:   Fri, 7 Jan 2022 13:36:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "alice.guo@nxp.com" <alice.guo@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>, "marex@denx.de" <marex@denx.de>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Re: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
Message-ID: <YdenJaDAVmJB2AGd@gondor.apana.org.au>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
 <AM6PR06MB469129E72ED6FBE0B33C693DA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR06MB469129E72ED6FBE0B33C693DA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:56:12AM +0000, ZHIZHIKIN Andrey wrote:
> Hello Herbert,
> 
> Gentle ping on this V3. I see that in Patchwork this series state is set to "Deferred".
> 
> Is there anything missing here to proceed further?

Please get the caam driver maintainer to review and ack the
patch series.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
