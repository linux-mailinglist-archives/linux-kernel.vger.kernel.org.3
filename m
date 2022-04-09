Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D629A4FA73C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbiDILYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiDILY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:24:29 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88D2976EF;
        Sat,  9 Apr 2022 04:22:22 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id D0506100882;
        Sat,  9 Apr 2022 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1649503340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MoBcFyxZH5F3K6/1Qwx4YfPqvgEHyd+hh3DO+ePPX14=;
        b=lIPpW3xGqPJw1PQXgHgZeJYgQOZQsY8pnhgxVV67BWhncGFKLjVfgwugsdcnBA3clUz97H
        XQl+lZA6FTjZlDO9343VAXSVz1nIEcAauHejOLoyxE/AdiTFijgnt1pbakCJ/5JR5qYDOu
        eBrQXv1iqDDiCiqGI1Nxksq2KoGncsw=
Received: from localhost.localdomain (fttx-pool-217.61.154.105.bambit.de [217.61.154.105])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 038F1360624;
        Sat,  9 Apr 2022 11:22:19 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add SATA and USB to BPI-R2-Pro board
Date:   Sat,  9 Apr 2022 13:21:34 +0200
Message-Id: <20220409112136.164481-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f03681a0-a55b-4010-bec5-e2c59b6cf21f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add necessary nodes for SATA and USB-Support on Bananapi-R2-Pro Board.

it depends on "enable usb support on rk356x" series from Peter Geis

https://patchwork.kernel.org/project/linux-rockchip/list/?series=630470

and a fixup-Patch changing clock names which should be squashed into
above series in v6

ref_clk => ref
suspend_clk => suspend
bus_clk => bus_early

Frank Wunderlich (2):
  arm64: dts: rockchip: Add USB nodes for BPI-R2-Pro
  arm64: dts: rockchip: Add SATA support to BPI-R2-Pro

 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

-- 
2.25.1

