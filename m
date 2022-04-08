Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3124F9D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbiDHSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiDHSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D661D26118;
        Fri,  8 Apr 2022 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443082;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=x0kzI/Isg/dHTuXL9pr/4hUBYIzgC3UJIabNTaOuy8o=;
    b=TGSShNyKbNY3TnGA6u08YYHcc5Lb1TgNndcEpvxBpkjJqKzhlzKEsjYbHmNAzK7sUh
    tlH4RfMg/KoU8vSpndg5YejlRRRWGsVIxn8wIlLWPCoIgXQptlCkurhQV29LPurk4IRC
    VnN2erl1zNRk+VPGKLyVWtgY5MhGRWt7/5c1FW/Ym3Its6qutnpe7z4K86R76y0BPRFX
    mhYHBVVdjke/FKn0ztkSLB6S7rlx37q8GlXHUIYY6bjP2pNtXRD/iJvT7IX13o3OmmHl
    ULQH1sthDx6b3SbJQFzMKRRixb23S8Rw6P15eBdZ21H+W9VeWyjKHiVzF/Tk2WGVdUqn
    O7fw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic2snr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:02 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 00/18] MIPS: DTS: fix some findings by "make ci20_defconfig dt_binding_check dtbs_check"
Date:   Fri,  8 Apr 2022 20:37:43 +0200
Message-Id: <cover.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH V1 2022-04-08 20:38:00:
This series fixes many (not all) warnings from dt_binding_check/dtbs_check for the jz4780 based Imagination CI20 board.


H. Nikolaus Schaller (18):
  MIPS: DTS: jz4780: remove cpu clock-names as reported by dtbscheck
  MIPS: DTS: jz4780: fix cgu as reported by dtbscheck
  MIPS: DTS: jz4780: fix tcu timer as reported by dtbscheck
  MIPS: DTS: jz4780: fix ost timer as reported by dtbscheck
  MIPS: DTS: jz4780: fix pinctrl as reported by dtbscheck
  MIPS: DTS: jz4780: fix rtc node as reported by dtbscheck
  MIPS: DTS: jz4780: fix otg node as reported by dtbscheck
  MIPS: DTS: jz4780: fix lcd controllers as reported by dtbscheck
  MIPS: DTS: jz4780: fix dma-controller as reported by dtbscheck
  MIPS: DTS: jz4780: fix uart dmas as reported by dtbscheck
  MIPS: DTS: jz4780: fix i2c dmas as reported by dtbscheck
  MIPS: DTS: jz4780: fix nemc memory controller as reported by dtbscheck
  dt-bindings: fix jz4780-nemc issue as reported by dtbscheck
  MIPS: DTS: CI20: add missing model as reported by dtbscheck
  MIPS: DTS: CI20: fix fixed regulators as reported by dtbscheck
  MIPS: DTS: CI20: fix /memory as reported by dtbscheck
  MIPS: DTS: CI20: fix wifi as reported by dtbscheck
  MIPS: DTS: CI20: fix bluetooth as reported by dtbscheck

 .../memory-controllers/ingenic,nemc.yaml      |  2 +-
 arch/mips/boot/dts/ingenic/ci20.dts           | 14 ++--
 arch/mips/boot/dts/ingenic/jz4780.dtsi        | 71 ++++++++++++++-----
 3 files changed, 64 insertions(+), 23 deletions(-)

-- 
2.33.0

