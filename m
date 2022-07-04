Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728D56597B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiGDPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiGDPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:09:48 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65E11A00;
        Mon,  4 Jul 2022 08:08:48 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o8Ngo-0002za-3y; Mon, 04 Jul 2022 17:08:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: enable hdmi tx audio on rk3568-evb1-v10
Date:   Mon,  4 Jul 2022 17:08:39 +0200
Message-Id: <165694729081.1285444.1968110431454563852.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614230354.3756364-1-michael.riesch@wolfvision.net>
References: <20220614230354.3756364-1-michael.riesch@wolfvision.net>
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

On Wed, 15 Jun 2022 01:03:53 +0200, Michael Riesch wrote:
> Enable the I2S0 controller and the hdmi-sound node on the Rockchip
> RK3568 EVB1.

Applied, thanks!

[1/2] arm64: dts: rockchip: enable hdmi tx audio on rk3568-evb1-v10
      commit: ea452bc0e6cc571165649d4a80300f7e8891877c
[2/2] arm64: dts: rockchip: enable hdmi tx audio on rock-3a
      commit: 9eee552fd8c45ca3628317bc458d8ff9cd670fc4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
