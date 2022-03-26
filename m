Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA164E7FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiCZHw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiCZHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:52:56 -0400
Received: from mx.msync.work (mx.msync.work [51.91.38.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DA151D32;
        Sat, 26 Mar 2022 00:51:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1220F33EE6;
        Sat, 26 Mar 2022 07:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648281078; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=TiDvYnT5mfWN3g8TG1br43NkSPHQzI9RByoHV2yGevI=;
        b=W2Ub67EitP90ajivdcsRYinSlcm0iniIo2lnqZT3Irr5gqwsE4cnSOVhdYPxPoTFl7faZn
        9TdtyOxibZJ/+os5JX319ZWMO6agBmL6rgcSeftjsRc7UV5hfXgsW8JRjH24Abs1w7oZqw
        8dvXlLQMnsKJiHwEm7ZZmO+M5i9dRK7BLI877l2K8FU0PO3ccTXvQvmAfukNfsRvqw1yPB
        7lmWF1aC42RCSKkxgmk6+ESRWkJKG2xr8yQkXwGRX6yjyj4CoWBjY2bL3o/apC+h1rRRsb
        37Oec8m50bq3q7FOJrY20SCPqZEcnRHODHbWChH1qI+l3wSRKc6nyE79wHMN9Q==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] arm64: meson: update dts for JetHub devices
Date:   Sat, 26 Mar 2022 10:51:06 +0300
Message-Id: <20220326075110.1462301-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update dts for JetHub H1:
- add bluetooth node for RTL8822CS uart port

Update dts for JetHub D1:
- add ZigBee serial alias (ttyAML2) for backward compatibility
- update voltage regulators and SDIO config to match board's reference design
- update max freq for WiFi SDIO

Vyacheslav Bocharov (4):
  arm64: meson: add dts bluetooth node for JetHub H1
  arm64: meson: dts: update serial alias in dts for JetHub D1
  arm64: meson: update SDIO voltage in dts for JetHub D1
  arm64: meson: update WiFi SDIO in dts for JetHub D1

 .../amlogic/meson-axg-jethome-jethub-j100.dts    | 16 ++++++++++++----
 .../meson-gxl-s905w-jethome-jethub-j80.dts       |  6 ++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.30.2

