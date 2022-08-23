Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF259E6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiHWQQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiHWQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:15:48 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4517C16BBA0;
        Tue, 23 Aug 2022 05:37:07 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQT9Q-0004gV-EY; Tue, 23 Aug 2022 14:37:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add analog audio output on quartz64-b
Date:   Tue, 23 Aug 2022 14:36:56 +0200
Message-Id: <166125820548.1301371.13535238054179966253.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721083301.3711-1-frattaroli.nicolas@gmail.com>
References: <20220721083301.3711-1-frattaroli.nicolas@gmail.com>
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

On Thu, 21 Jul 2022 10:33:00 +0200, Nicolas Frattaroli wrote:
> This adds the necessary device tree changes to enable analog
> audio output on the PINE64 Quartz64 Model B with its RK809
> codec.
> 
> The headphone detection pin is left out for now because I couldn't
> get it to work and am not sure if it even matters, but for future
> reference: It's pin GPIO4 RK_PC4, named HP_DET_L_GPIO4_C4 in the
> schematic.

Applied, thanks!

[1/1] arm64: dts: rockchip: Add analog audio output on quartz64-b
      commit: db7ad41538439a3dcfebd738959c7526b4e7d528

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
