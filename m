Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04675A786E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiHaIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiHaIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:04:20 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE197C58DC;
        Wed, 31 Aug 2022 01:04:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AC867DF501;
        Wed, 31 Aug 2022 01:03:31 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cj2-0ElMPAoj; Wed, 31 Aug 2022 01:03:27 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661933007; bh=MHyStthcjhUcL7NnUOW72DeU+Ft8w/aFkFP//9K6O7I=;
        h=From:To:Cc:Subject:Date:From;
        b=sqsVYsJamwbRBQCZq1yJ4ljmJPpfQdlSMQeMTy5/gJNCOhr64OyfM3nndnvzzrCYM
         voTo6ITgrU4uLRbnoll8ZTNsA+QxXn5JNiGrY/3S4q7hmGyPRfeCSCShpxU0FAm7Pe
         tYEv3YRf8MIGJXD3tuteLhF1ZriD06OCjEwJRDR6JIcAyuLYTbnY+1TzbbVYCy7cfK
         NVf4I9jgj1PrbD+8bvAV9JiB+rc1uAa+571FMSgch6TrmelAq29LB8z/s+Y4lQ0FBu
         Z+Jk5KDweSY+a15inEu95oF+sujYfi2wtOiZWC2Qw8SC+VUkvFD/E2PHNovG85t0SK
         SgFwlP6OHWw0g==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v1 0/5] arm64: dts: imx8mq-librem5: phone DT updates
Date:   Wed, 31 Aug 2022 10:02:56 +0200
Message-Id: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
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


Angus Ainslie (2):
  arm64: dts: imx8mq-librem5: add USB type-c properties for role
    switching
  arm64: dts: imx8mq-librem5: add usb-role-switch property to dwc3

Guido Günther (1):
  arm64: dts: imx8mq-librem5: add RGB pwmleds

Martin Kepplinger (1):
  arm64: dts: imx8mq-librem5: describe the voice coil motor for focus
    control

Sebastian Krzyszkowiak (1):
  arm64: dts: imx8mq-librem5: Add bq25895 as max17055's power supply

 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.30.2

