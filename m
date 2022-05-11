Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DC522ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiEKEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEKEOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:14:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01472228;
        Tue, 10 May 2022 21:14:11 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nodjj-0000V0-71; Wed, 11 May 2022 06:14:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
Date:   Wed, 11 May 2022 06:14:05 +0200
Message-Id: <165224242948.2009452.15532636093197566420.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425133502.405512-1-michael.riesch@wolfvision.net>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net>
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

On Mon, 25 Apr 2022 15:35:00 +0200, Michael Riesch wrote:
> This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
> device tree.

Applied, thanks!

[1/3] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
      commit: bc405bb3eeee4b711830ab569e7f3811b92196ab

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
