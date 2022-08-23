Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76259E6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiHWQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243539AbiHWQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:15:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54609104B3B;
        Tue, 23 Aug 2022 05:37:09 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQT9R-0004gV-28; Tue, 23 Aug 2022 14:37:01 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix upper usb port on BPI-R2-Pro
Date:   Tue, 23 Aug 2022 14:36:58 +0200
Message-Id: <166125820548.1301371.18431687974347062281.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220821121929.244112-1-linux@fw-web.de>
References: <20220821121929.244112-1-linux@fw-web.de>
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

On Sun, 21 Aug 2022 14:19:29 +0200, Frank Wunderlich wrote:
> - extcon is no more needed in 5.19 - so drop it
>   commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
> - dr_mode was changed from host to otg in rk356x.dtsi
>   commit bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd
>     operation of usb_host0_xhci in rk356x")
>   change it back on board level as id-pin on r2pro is not connected

Applied, thanks!

[1/1] arm64: dts: rockchip: fix upper usb port on BPI-R2-Pro
      commit: 388f9f0a7ff84b7890a24499a3a1fea0cad21373

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
