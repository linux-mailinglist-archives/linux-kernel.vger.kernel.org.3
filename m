Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B54FAF3B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiDJRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiDJRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:15:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BE34B87;
        Sun, 10 Apr 2022 10:13:03 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndb7T-0006hD-D1; Sun, 10 Apr 2022 19:12:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add SATA and USB to BPI-R2-Pro board
Date:   Sun, 10 Apr 2022 19:12:55 +0200
Message-Id: <164961074165.23152.4103203935750255805.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409112136.164481-1-linux@fw-web.de>
References: <20220409112136.164481-1-linux@fw-web.de>
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

On Sat, 9 Apr 2022 13:21:34 +0200, Frank Wunderlich wrote:
> Add necessary nodes for SATA and USB-Support on Bananapi-R2-Pro Board.
> 
> it depends on "enable usb support on rk356x" series from Peter Geis
> 
> https://patchwork.kernel.org/project/linux-rockchip/list/?series=630470
> 
> and a fixup-Patch changing clock names which should be squashed into
> above series in v6
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add USB nodes for BPI-R2-Pro
      commit: f29ffce32b4e1204b67f82fd80584ec4173cca54
[2/2] arm64: dts: rockchip: Add SATA support to BPI-R2-Pro
      commit: 551e645fed5dd2ed4c81c9e3d3b4827862f51dc6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
