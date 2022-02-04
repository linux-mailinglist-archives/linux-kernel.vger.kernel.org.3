Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04B4A9C44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376261AbiBDPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:52:46 -0500
Received: from smtp1.axis.com ([195.60.68.17]:59064 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359859AbiBDPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643989964;
  x=1675525964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7zmOHNIf3yGWYx96QvhBghS0wq+3yhqpRX+G3DifnQ=;
  b=mdLqc8j3JyJNT8DAvtss5w1t37jacxS0voVnims9IxqxB94HljXyfhi8
   k+uZy48M7rl9kNdkcLoT4lwczFFJYymoNxbLLgyeHzda3nnWOv3jmq/1/
   66V1Mlvs3l/yhUbW5ncCzQjUlhY+74iP0PhWLGWr76uhalps12Ndp02sc
   h08/lJUNanhw21kqeNWbODoIHudNCuLNdqUPsGn+QVDNE47lVuogu6fNR
   inkdNxLE9TgwxTYDbj7+oGnfm7livuY+WIlxyFFkaUTkKm3j3AKwyehAA
   8KBkzjm8CUmEunXOELnmsoXVx4sA9zHlcCPhlFKQmCBV4IEpXwRDgwxoV
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] regulator: Add support for TPS6286x
Date:   Fri, 4 Feb 2022 16:52:39 +0100
Message-ID: <20220204155241.576342-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's TPS62864/TPS6286/TPS62868/TPS62869 are high-frequency synchronous
step-down converters controlled via I2C.  There are differences in the
electrical characteristics and packaging between the variants, but the
register interfaces are identical.

This series adds basic support for these chips.

Vincent Whitchurch (2):
  regulator: Add bindings for TPS62864x
  regulator: Add support for TPS6286x

 .../bindings/regulator/ti,tps62864.yaml       |  62 +++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/tps6286x-regulator.c        | 159 ++++++++++++++++++
 include/dt-bindings/regulator/ti,tps62864.h   |   9 +
 5 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
 create mode 100644 drivers/regulator/tps6286x-regulator.c
 create mode 100644 include/dt-bindings/regulator/ti,tps62864.h

-- 
2.34.1

