Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8FC515E03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377035AbiD3OJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242174AbiD3OJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:09:24 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C830765D2D;
        Sat, 30 Apr 2022 07:06:02 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknjT-0001Wl-2J; Sat, 30 Apr 2022 16:05:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
Date:   Sat, 30 Apr 2022 16:05:53 +0200
Message-Id: <165132754299.647302.7977397851546544762.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425133502.405512-1-michael.riesch@wolfvision.net>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 15:35:00 +0200, Michael Riesch wrote:
> This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
> device tree.

Applied, thanks!

[2/3] arm64: dts: rockchip: add usb3 support to the radxa rock3 model a
      commit: 254a1f6a29e7a273adb1a1d032305ec58ef83a69
[3/3] arm64: dts: rockchip: enable usb hub on the radxa rock3 model a
      commit: 160f126b89e10bd58491e10067a44c7e3f85fa2c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
