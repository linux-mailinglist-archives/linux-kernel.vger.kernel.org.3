Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E005ACF6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiIEKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiIEKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:01:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570E53023;
        Mon,  5 Sep 2022 03:01:29 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oV8v1-0005Fc-CW; Mon, 05 Sep 2022 12:01:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix property for usb2 phy supply on rock-3a
Date:   Mon,  5 Sep 2022 12:01:26 +0200
Message-Id: <166237207205.2457878.7965584003024415305.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905064335.104650-1-michael.riesch@wolfvision.net>
References: <20220905064335.104650-1-michael.riesch@wolfvision.net>
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

On Mon, 5 Sep 2022 08:43:34 +0200, Michael Riesch wrote:
> The property "vbus-supply" was copied from the vendor kernel but is not
> available in mainstream. Use correct property "phy-supply".

Applied, thanks!

[1/2] arm64: dts: rockchip: fix property for usb2 phy supply on rock-3a
      commit: 43e1d6d3b45c4e7e25171ec04a10d09969b0f889
[2/2] arm64: dts: rockchip: fix property for usb2 phy supply on rk3568-evb1-v10
      commit: 1988e3ef0544bbe54cffa4ec30a5883e5a08c2b6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
