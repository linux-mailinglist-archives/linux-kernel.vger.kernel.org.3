Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF657A061
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiGSOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiGSOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:04:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19488528B3;
        Tue, 19 Jul 2022 06:17:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26JDHYjX121476;
        Tue, 19 Jul 2022 08:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658236654;
        bh=aPX5TwnWSboRHZlPa+mgL6xIPZGuuYIuLSH6mihWqWs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VHoxAvcwfJxh3IbBn0YZGId/qEIjPohwZZMwX8Mknup56z3DkLWCK4PHub8OZ9i92
         kyjfqzG1SC9Lkc6tCG205KrFtZ+rNxecBtxuiqC8WibyZIgj2TM2vgaUDH97OypI01
         CHWqI7Z92xHlSPO+ywCjl5+weF7m9uiTAN96gimw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26JDHYuQ119962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 08:17:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Jul 2022 08:17:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Jul 2022 08:17:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26JDHYKB070254;
        Tue, 19 Jul 2022 08:17:34 -0500
Date:   Tue, 19 Jul 2022 08:17:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     =?iso-8859-1?B?Suly9G1l?= Neanne <jneanne@baylibre.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        <j-keerthy@ti.com>, <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 11/14] arm64: dts: ti: Add TI TPS65219 PMIC support
 for AM642 SK board.
Message-ID: <20220719131734.q7c62fgqmja4ugjv@subduing>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-12-jneanne@baylibre.com>
 <20220719130049.hxn3bmhd3lmxxzgt@overview>
 <CAOP-2kHgEhm+Ym8o7A49qP-oabO0i+89PGoWO0c9_2xz7oU89w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOP-2kHgEhm+Ym8o7A49qP-oabO0i+89PGoWO0c9_2xz7oU89w@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:11-20220719, Jérôme Neanne wrote:
> > > +&main_i2c0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&main_i2c0_pins_default>;
> > > +     clock-frequency = <400000>;
> > > +     status = "okay";
> > > +
> > > +     tps65219: pmic@30 {
> >
> > Am I missing something?
> > https://www.ti.com/tool/SK-AM64#design-files
> > https://www.ti.com/lit/df/sprr432/sprr432.pdf
> > Page 11:
> > I see TPS6521815 at address 0x24, nothing in 0x30?
> >
> TI provides me a preliminary spec for TPS65219 where it is stated:
> "7.3.8 I 2 C Serial Interface (SDA and SCL)
> The TPS65219 hosts a slave I2C interface that supports I2C-bus data
> transfers in Standard-mode (100 kbit/s),
> Fast-mode (400 kbit/s) and Fast-mode plus (1 Mbit/s).
> The default I2C-adress is 0x30, but can be changed if needed, e.g. for
> multi-PMIC-operation."
> 
> Don't know when the spec will be released publically
> 

Please do not top post.

https://www.ti.com/product/TPS65219 - the PMIC is public for sure. I am
not complaining about that.

What the I was commenting is that the AM64-SK device tree you are
modifying does'nt have the said PMIC. If this is a custom board, then
lets not upstream such a board. If another board is supposed to contain
it, lets enable the PMIC in the corresponding board.

That does'nt negate the entire series, just the device tree patches as
provided in this series is invalid - I have no intent of picking up
patches that will break everyone's am64-sk boards.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
