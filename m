Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D699554FBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383167AbiFQRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiFQRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:10:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD83B2A0;
        Fri, 17 Jun 2022 10:10:42 -0700 (PDT)
Received: from [213.70.33.226] (helo=phil.intern)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o2FUM-00063w-JR; Fri, 17 Jun 2022 19:10:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sjoerd Simons <sjoerd@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Akash Gajjar <akash@openedev.com>,
        Levin Du <djw@t-chip.com.cn>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for Radxa ROCK Pi S
Date:   Fri, 17 Jun 2022 19:10:27 +0200
Message-Id: <165548567344.3407211.1662879009841453110.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614064858.1445817-1-sjoerd@collabora.com>
References: <20220614064858.1445817-1-sjoerd@collabora.com>
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

On Tue, 14 Jun 2022 08:48:54 +0200, Sjoerd Simons wrote:
> This adds a device-tree for the Radxa Rock Pi S; The first patch was
> originally submitted a few years back but seems to have stalled. I've
> adjusted it to sort the device nodes and drop duplication of dtsi
> properties. The second patch adds support for a bunch of additional
> peripherals.
> 
> Changes in v2:
> - Split binding documentation into its own commit
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: Add Radxa ROCK Pi S
      commit: 5a86111e9defa367499c932c8e23b03897a97a2b
[2/3] arm64: dts: rockchip: add ROCK Pi S DTS support
      commit: 2e04c25b13206aabb5ffa38632d638c340e5857c

dropped some unneeded double-blank lines from patch2

[3/3] arm64: dts: rockchip: rock-pi-s add more peripherals
      commit: bc3753aed81f6b4a81f3e8bbb32b90f9a8c7cca3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
