Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD48C4B2D89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350919AbiBKTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:30:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiBKTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:30:32 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D43BA4;
        Fri, 11 Feb 2022 11:30:28 -0800 (PST)
Received: from p508fd6b0.dip0.t-ipconnect.de ([80.143.214.176] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nIbcg-0001n3-UG; Fri, 11 Feb 2022 20:30:26 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Alex Bee <knaerzche@gmail.com>
Subject: Re: (subset) [PATCH v6 0/5] Add GPU for RK356x SoCs
Date:   Fri, 11 Feb 2022 20:30:24 +0100
Message-Id: <164460777903.839530.14036676510603904155.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209215549.94524-1-michael.riesch@wolfvision.net>
References: <20220209215549.94524-1-michael.riesch@wolfvision.net>
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

On Wed, 9 Feb 2022 22:55:44 +0100, Michael Riesch wrote:
> This series aims to bring the GPU support for the RK356x mainline. In
> conjunction with the VOP2/HDMI TX patches v4 [0]) it has been tested
> successfully on a RK3568 EVB1 with weston and glmark2-es2-wayland.
> 
> It should be noted that on the RK3568 EVB1 the supply of the GPU power
> domain needs to be set to "always-on" in the device tree. There is an
> ongoing discussion to provide a clean solution [1], in the meantime one
> has to apply a hack.
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: rockchip: add gpu node to rk356x
      commit: 810028668c6d9da25664195d6b906c98a8169f72
[3/5] arm64: dts: rockchip: add cooling map and trip points for gpu to rk356x
      commit: c0a7259fad2df72469b602418083516c2cb3a7af
[4/5] arm64: dts: rockchip: enable the gpu on quartz64-a
      commit: 6ac383456452378de07e55fc687069d1898a567d
[5/5] arm64: dts: rockchip: enable the gpu on rk3568-evb1-v10
      commit: 679f048a10d8322d79010e0e52f18a6c17bdf306
[6]   arm64: dts: rockchip: enable the tsadc on rk3568-evb1-v10

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
