Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8134F00E3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354614AbiDBLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiDBLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:02:51 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E95BD32;
        Sat,  2 Apr 2022 04:00:58 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 4D71A1012AB;
        Sat,  2 Apr 2022 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1648897257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AzwyT+mHzC7B+wiMi8w60y3FU2UPOMZ1lb1gM889PVM=;
        b=CuQ/AgBl9PPPDb+yFe4jDBtgKKbTdvqHxbCd/Fb54e7J3hPLno9VY4LNdGzQ1TIxoerzvP
        xR9ifnMmuEjvVdgGjyEjxlRf9OrPfgDOtC+O3wbql08KiyNrKutgpY7zEyZmwNfjNyJy23
        oSKjR3YP0G72L+h6ty5HQG2HUFhARis=
Received: from localhost.localdomain (fttx-pool-80.245.79.107.bambit.de [80.245.79.107])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 7E6AB3602D1;
        Sat,  2 Apr 2022 11:00:56 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Change Bananapi-R2-Pro board to match V1.0
Date:   Sat,  2 Apr 2022 13:00:43 +0200
Message-Id: <20220402110045.104031-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 43103d1d-1e1a-412a-a386-c44869064607
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Mainline Devicetree was created for v00 prototype that was not in
public sale and only shipped to few developers. V1.0 of the board
has some changes in io-domain and gmacs are swapped.

Change mainline DTS to match the current hardware.

Frank Wunderlich (2):
  arm64: dts: rockchip: Change io-domains of bpi-r2-pro
  arm64: dts: rockchip: Add gmac1 and change network settings

 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 40 ++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.25.1

