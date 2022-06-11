Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128D547602
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiFKPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiFKPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:15:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050146CB9;
        Sat, 11 Jun 2022 08:15:56 -0700 (PDT)
Received: from p508fd9f0.dip0.t-ipconnect.de ([80.143.217.240] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o02q6-0004vU-Go; Sat, 11 Jun 2022 17:15:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: (subset) [PATCH 0/2] Support RTC on BPI-R2 Pro
Date:   Sat, 11 Jun 2022 17:15:46 +0200
Message-Id: <165496044123.1951281.5949478945237694774.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220608161150.58919-1-linux@fw-web.de>
References: <20220608161150.58919-1-linux@fw-web.de>
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

On Wed, 8 Jun 2022 18:11:47 +0200, Frank Wunderlich wrote:
> This series is updating hym8563 rtc driver and add devicetree nodes
> for Bananapi R2 Pro board.
> 
> Frank Wunderlich (1):
>   arm64: dts: rockchip: add RTC to BPI-R2 Pro
> 
> Peter Geis (1):
>   rtc: hym8563: try multiple times to init device
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: add RTC to BPI-R2 Pro
      commit: efaa0c1378ed800abd1abe0aa51ffd30002efdb4

      I've changed the node name to hym8563: rtc@...

      The node name should be the class of device i.e. rtc in this case.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
