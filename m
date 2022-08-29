Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705D55A47A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiH2K5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2K5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:57:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5959E5D110;
        Mon, 29 Aug 2022 03:57:02 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oScRv-0007z6-1j; Mon, 29 Aug 2022 12:56:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add vcc_cam regulator to rock-3a
Date:   Mon, 29 Aug 2022 12:56:57 +0200
Message-Id: <166177061356.1804690.5092608099700382034.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
References: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 15:32:02 +0200, Michael Riesch wrote:
> The Radxa ROCK3 Model A features a voltage regulator that provides
> a 3V3 supply to the MIPI CSI connector. Add this regulator to the
> device tree of the board.

Applied, thanks!

[1/3] arm64: dts: rockchip: add vcc_cam regulator to rock-3a
      commit: 2fd8bd005897436c5a6d2d150d7b1ae2907f8b06
[2/3] arm64: dts: rockchip: add vcc_mipi regulator to rock-3a
      commit: 7a3eabdcd0fdc344d31b18e78e4f4b5d94db8df5
[3/3] arm64: dts: rockchip: specify pinctrl for i2c adapters on rock-3a
      commit: a233ea1e6268a779d5c8c427eb14a2a89f95f4f9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
