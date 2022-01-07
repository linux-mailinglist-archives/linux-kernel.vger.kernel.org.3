Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF04876C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbiAGLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiAGLsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:48:00 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220F3C061245;
        Fri,  7 Jan 2022 03:48:00 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 428EF2223B;
        Fri,  7 Jan 2022 12:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1641556077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4p2nvLSi28IUF15b8Rsri9q/8pTR/coNz2dgph7kT0U=;
        b=NvwmnqY5W/+W0iOI3tSIXP6ErPH9ynsq3YKQBZqAuhLSZIrdWyoFhHrvoM4FgPAyeGQzMc
        anNpMPelKR9bVpTfPLzqZP0Z9PXBdFwzNB2BPHGsxtkdEnj1yqONCff1My2OrW1dsCUiDZ
        sS5BdbRDpIof1/OeUwoJMz6QJeLJv3o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Jan 2022 12:47:53 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
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
        l.stach@pengutronix.de, shawnguo@kernel.org, davem@davemloft.net,
        jun.li@nxp.com
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
 jr
In-Reply-To: <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
 <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
 <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
 <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <4ed84dc354eee36067ade567097ddd68@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

Am 2022-01-07 10:46, schrieb Rouven Czerwinski:
> .. since AFAIK i.MX8M* can not be run without TF-A.

Are you sure? There probably aren't any boards out there
without TF-A, but why shouldn't it work without it?

-michael
