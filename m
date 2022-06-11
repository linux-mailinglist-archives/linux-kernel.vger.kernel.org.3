Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D65547603
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiFKPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiFKPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:15:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5743146CB6;
        Sat, 11 Jun 2022 08:15:56 -0700 (PDT)
Received: from p508fd9f0.dip0.t-ipconnect.de ([80.143.217.240] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o02q5-0004vU-GH; Sat, 11 Jun 2022 17:15:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/2] HDMI Audio on RK356x/Quartz64 Model A
Date:   Sat, 11 Jun 2022 17:15:44 +0200
Message-Id: <165496044123.1951281.17858284746435155251.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
References: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
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

On Sat, 11 Jun 2022 08:52:58 +0200, Nicolas Frattaroli wrote:
> This enables HDMI audio on Quartz64 Model A, and the RK356x SoC in
> general.
> 
> i2s0 on the RK356x is connected to HDMI, and only has one DMA. I've
> confirmed this with the TRM.
> 
> To test this, one needs a video clock, i.e. there is no audio if your
> screen is off. The framebuffer console or something else needs to be
> running to get audio output.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
      commit: 697ee8546e241bd5fc175c0cfd5d8b0c8ce39697
[2/2] arm64: dts: rockchip: Enable HDMI audio on Quartz64 A
      commit: 4188962d993ef3633a61f66ba5afe9e43088f3c5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
