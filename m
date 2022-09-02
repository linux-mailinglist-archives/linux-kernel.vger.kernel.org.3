Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126AB5AAA4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiIBImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiIBIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:42:29 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6829BB6B;
        Fri,  2 Sep 2022 01:42:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id ABA96DFD85;
        Fri,  2 Sep 2022 01:42:27 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F4VVKcahdboP; Fri,  2 Sep 2022 01:42:26 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108146; bh=Z8NQnvM4CE3GkQthavouozUDfjffo74DWtzt1eBxpmw=;
        h=From:To:Cc:Subject:Date:From;
        b=kblbKHDINMmX4v4IjKrOBZYvKPPFTFbdoXfd+FuiZ5ZvJiR6OHdL+PZATJj1tpGAt
         MOJ/kyFDTDzMLfjrpZ1Q5ik2wqmpbxAc1AIlkQAmnTJNSZsiC7IXVONyDopHxq/jFK
         x3CBlS++W36BhsgChogDFpwX0B/81PVfeyCG7YZX4Bvw1vfpWnXoMZGi+sJzsTPj+J
         GSv4unDF9PTbQuamKJIYfscZVRZyvmBxCaD0zhm9BJeoQwbbvx/t/6DcSWSgxYhcq3
         u5J0u4nABcwbAoIIdJGsUCvade7qOzhk2adyQ3uNuUWoq/VAVjeUcKlFfkVBgmAMOY
         4Zpu46q0eaIjg==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v2 0/6] arm64: dts: imx8mq-librem5: phone DT updates
Date:   Fri,  2 Sep 2022 10:42:10 +0200
Message-Id: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Shawn and all interested,

This is another small number of patches that enables more devices
or features found on the Librem 5 phone.

thank you,

                               martin

revision history
----------------
v2: (thank you Krzysztof)
* make led node names generic
* add a mipi-csi syntax fix

v1:
https://lore.kernel.org/phone-devel/20220831080301.1092737-1-martin.kepplinger@puri.sm/



Angus Ainslie (2):
  arm64: dts: imx8mq-librem5: add USB type-c properties for role
    switching
  arm64: dts: imx8mq-librem5: add usb-role-switch property to dwc3

Guido Günther (1):
  arm64: dts: imx8mq-librem5: add RGB pwm notification leds

Martin Kepplinger (2):
  arm64: dts: imx8mq-librem5: describe the voice coil motor for focus
    control
  arm64: dts: imx8mq-librem5: fix mipi_csi description

Sebastian Krzyszkowiak (1):
  arm64: dts: imx8mq-librem5: Add bq25895 as max17055's power supply

 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.30.2

