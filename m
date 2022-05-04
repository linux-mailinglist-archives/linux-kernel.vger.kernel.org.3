Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC85197E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbiEDHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiEDHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:15:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D822BEA;
        Wed,  4 May 2022 00:12:06 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm9Ar-0006s1-Gb; Wed, 04 May 2022 09:11:49 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org, Conor.Dooley@microchip.com
Cc:     Cyril.Jean@microchip.com, Daire.McNamara@microchip.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        palmer@rivosinc.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mail@conchuod.ie
Subject: Re: [PATCH v3 5/8] riscv: dts: microchip: make the fabric dtsi board specific
Date:   Wed, 04 May 2022 09:11:47 +0200
Message-ID: <1814908.tdWV9SEqCh@diego>
In-Reply-To: <872a2d30-89ad-b66a-7d03-90d3de85c51b@microchip.com>
References: <20220501192557.2631936-1-mail@conchuod.ie> <1892011.PYKUYFuaPT@phil> <872a2d30-89ad-b66a-7d03-90d3de85c51b@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Mai 2022, 08:48:24 CEST schrieb Conor.Dooley@microchip.com:
> On 04/05/2022 00:47, Heiko Stuebner wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am Sonntag, 1. Mai 2022, 21:25:56 CEST schrieb Conor Dooley:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> Currently mpfs-fabric.dtsi is included by mpfs.dtsi - which is fine
> >> currently since there is only one board with this SoC upstream.
> >>
> >> However if another board was added, it would include the fabric contents
> >> of the Icicle Kit's reference design. To avoid this, rename
> >> mpfs-fabric.dtsi to mpfs-icicle-kit-fabric.dtsi & include it in the dts
> >> rather than mpfs.dtsi.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>   .../microchip/{mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} | 2 ++
> >>   arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts               | 1 +
> >>   arch/riscv/boot/dts/microchip/mpfs.dtsi                         | 1 -
> >>   3 files changed, 3 insertions(+), 1 deletion(-)
> >>   rename arch/riscv/boot/dts/microchip/{mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)
> >>
> >> diff --git a/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> >> similarity index 91%
> >> rename from arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
> >> rename to arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> >> index ccaac3371cf9..0d28858b83f2 100644
> >> --- a/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
> >> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> >> @@ -2,6 +2,8 @@
> >>   /* Copyright (c) 2020-2021 Microchip Technology Inc */
> >>
> >>   / {
> >> +     compatible = "microchip,mpfs-icicle-reference-rtlv2203", "microchip,mpfs";
> >> +
> > 
> > I don't really understand the meaning of the added compatible yet.
> 
> 
> I added it for informational purposes more than anything else.
> The contents of this file match the 22.03 reference design for
> the icicle kit's FPGA fabric & an older version of the design
> may not have the i2c or pwm devices.

that makes sense, thanks for the explanation :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> > It will get overridden by the compatible in the dts and also the
> > fabric dtsi for the polarberry does not contain a similar thing.
> 
> I did not add one for the polarberry b/c it has (to my knowledge)
> no versioning scheme nor fabric peripherals in the design given
> to customers.
> 
> Thanks,
> Conor.
> 




