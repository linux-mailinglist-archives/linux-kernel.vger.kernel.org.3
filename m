Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6736251647C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbiEANJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347329AbiEANJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 09:09:11 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8533E32;
        Sun,  1 May 2022 06:05:42 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nl9Ge-0006BV-1w; Sun, 01 May 2022 15:05:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] Add support for several new rk3566 SBCs
Date:   Sun,  1 May 2022 15:05:38 +0200
Message-Id: <165141025789.655760.7485683050420620213.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429115252.2360496-1-pgwipeout@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 07:52:45 -0400, Peter Geis wrote:
> The following series adds support for the following single board
> computers:
> - Pine64 Quartz64 Model B
> - Pine64 SoQuartz SoM with RPi CM4IO carrier board
> - Firefly Station M2
> 
> Patches 1, 2, and 3 add the requisite dt-bindings.
> Patch 4 adds support for the SFC to the rk356x device tree.
> Patch 5 adds the Quartz64 Model B device tree.
> Patch 6 adds the SoQuartz CM4IO device tree.
> Patch 7 adds the Firefly Station M2 device tree.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: arm: rockchip: Add Pine64 Quartz64 Model B
      commit: c37415f55bdadffe5b4c0e7981e9fc7e8b96beea
[2/7] dt-bindings: arm: rockchip: Add Pine64 SoQuartz SoM
      commit: c466828fb3ba8cb7f5c3bf28766da9b70bf9745e
[3/7] dt-bindings: arm: rockchip: Add Firefly Station M2
      commit: e52ded5543708e0382f236ce35372a63f4568341
[5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device tree
      commit: dcc8c66bef79befa6c9ebe7d7d62b0ce66983c20
[6/7] arm64: dts: rockchip: add SoQuartz CM4IO dts
      commit: 5859b5a9c3ac92d831bed164374cb837519524ad
[7/7] arm64: dts: rockchip: add dts for Firefly Station M2 rk3566
      commit: 30ac9b4e25d8cece00d32c7419f9d919f55421fe

I've adjusted the styling of comments a bit, also dropped one double
newline as well as fixed the node name for the ethernet-phy for QuartzB.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
