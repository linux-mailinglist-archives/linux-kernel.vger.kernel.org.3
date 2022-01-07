Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB05D48773A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiAGL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAGL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:59:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97BC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:59:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1n5ntc-0004Qo-QE; Fri, 07 Jan 2022 12:59:00 +0100
Message-ID: <8fa36ec0a6252db4b0c7fbbf09de5e816d634206.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
 jr
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        alice.guo@nxp.com, agx@sigxcpu.org, krzk@kernel.org,
        leonard.crestez@nxp.com, festevam@gmail.com, marex@denx.de,
        herbert@gondor.apana.org.au, horia.geanta@nxp.com,
        daniel.baluta@nxp.com, frieder.schrempf@kontron.de,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        hongxing.zhu@nxp.com, s.hauer@pengutronix.de, pankaj.gupta@nxp.com,
        robh+dt@kernel.org, thunder.leizhen@huawei.com, martink@posteo.de,
        aford173@gmail.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, shengjiu.wang@nxp.com,
        qiangqing.zhang@nxp.com, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        shawnguo@kernel.org, davem@davemloft.net, jun.li@nxp.com
Date:   Fri, 07 Jan 2022 12:58:58 +0100
In-Reply-To: <4ed84dc354eee36067ade567097ddd68@walle.cc>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
         <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
         <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
         <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
         <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
         <4ed84dc354eee36067ade567097ddd68@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 07.01.2022 um 12:47 +0100 schrieb Michael Walle:
> Hi Rouven,
> 
> Am 2022-01-07 10:46, schrieb Rouven Czerwinski:
> > .. since AFAIK i.MX8M* can not be run without TF-A.
> 
> Are you sure? There probably aren't any boards out there
> without TF-A, but why shouldn't it work without it?

PSCI, i.e. the only means to start the secondary CPUs, is implemented
in TF-A, so it's very unlikely that anyone would want to run a system
without TF-A. Also quite a bit of the lowlevel SoC initialization is
implemented in TF-A.

Regards,
Lucas

