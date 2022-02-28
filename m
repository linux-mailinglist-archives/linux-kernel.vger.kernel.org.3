Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A624C6DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiB1NU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiB1NUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:20:52 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178F5DE50;
        Mon, 28 Feb 2022 05:20:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CD54CDFDF5;
        Mon, 28 Feb 2022 05:12:36 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GugxwpAdyN5u; Mon, 28 Feb 2022 05:12:36 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, krzysztof.kozlowski@canonical.com,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, kernel@puri.sm, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 0/5] arm64: dts: imx8mq-librem5: phone description updates
Date:   Mon, 28 Feb 2022 14:12:17 +0100
Message-Id: <20220228131222.917137-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn and all interested,

This is small updates to the Librem 5 phone hardware descriptions we've
been using for quite some time as part of PureOS.

thanks,
                           martin

Angus Ainslie (1):
  arm64: dts: imx8mq-librem5: add a RO firmware partition

Guido Günther (2):
  arm64: dts: imx8mq-librem5: higher boost regulation current
  arm64: dts: imx8mq-librem5-r4: add the correct panel

Martin Kepplinger (2):
  arm64: dts: imx8mq-librem5: make the volume buttons a wakeup source
  arm64: dts: imx8mq-librem5: remove description of CHG_STATUS_B

 .../boot/dts/freescale/imx8mq-librem5-r4.dts      |  4 ++++
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 15 +++++----------
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.30.2

