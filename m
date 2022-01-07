Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E204D48774F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbiAGMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiAGMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:05:05 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D8C061212;
        Fri,  7 Jan 2022 04:05:05 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F19302223B;
        Fri,  7 Jan 2022 13:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1641557103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYzcSUS8yvyk0FFz/CBJ9UzBPJSFoz+LxktBb7PpgvA=;
        b=Vnu+iGdr76U6X2zEQaPCWsKqZrw7uZ9QaTl85ShL3UTuO3+qJRNlat9FancNW0NiPftkJL
        g6Vg4Z1yJcwRZRGPpmigCnWaSu3U1nAO2QZM3d55p6BT2MFXJnEJiFGEcZY6i/nvDvO2Ox
        Awg3LEhCoEdyK4+D5ha7/RlvJer8QV4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Jan 2022 13:05:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>,
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
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam
 jr
In-Reply-To: <8fa36ec0a6252db4b0c7fbbf09de5e816d634206.camel@pengutronix.de>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
 <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
 <AM6PR06MB469100A5D7A069AF84A83EEFA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
 <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
 <4ed84dc354eee36067ade567097ddd68@walle.cc>
 <8fa36ec0a6252db4b0c7fbbf09de5e816d634206.camel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <00e083278fb4a8c96fdef564a2183600@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-07 12:58, schrieb Lucas Stach:
> Am Freitag, dem 07.01.2022 um 12:47 +0100 schrieb Michael Walle:
>> Hi Rouven,
>> 
>> Am 2022-01-07 10:46, schrieb Rouven Czerwinski:
>> > .. since AFAIK i.MX8M* can not be run without TF-A.
>> 
>> Are you sure? There probably aren't any boards out there
>> without TF-A, but why shouldn't it work without it?
> 
> PSCI, i.e. the only means to start the secondary CPUs, is implemented
> in TF-A, so it's very unlikely that anyone would want to run a system
> without TF-A. Also quite a bit of the lowlevel SoC initialization is
> implemented in TF-A.

Doesn't mean u-boot cannot implement PSCI; actually you doesn't need
it at all, you can still use spin tables. I just keep hearing the same
arguments for the LS1028A SoC and yet there is one board without TF-A ;)
Anyway, I admit it's rather unlikely.

-michael
