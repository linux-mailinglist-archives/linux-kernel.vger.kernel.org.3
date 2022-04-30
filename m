Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B549515E06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382782AbiD3OJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242289AbiD3OJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:09:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D366216;
        Sat, 30 Apr 2022 07:06:04 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknjT-0001Wl-JD; Sat, 30 Apr 2022 16:05:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: pinenote: Enable more hardware
Date:   Sat, 30 Apr 2022 16:05:55 +0200
Message-Id: <165132754299.647302.3726155341085702212.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413035614.31045-1-samuel@sholland.org>
References: <20220413035614.31045-1-samuel@sholland.org>
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

On Tue, 12 Apr 2022 22:56:12 -0500, Samuel Holland wrote:
> This series adds support for some features in the PineNote that had
> devicetree bindings or SoC support merged since the board was added.
> 
> 
> Samuel Holland (2):
>   arm64: dts: rockchip: pinenote: Add accelerometer
>   arm64: dts: rockchip: pinenote: Add USB and TCPC
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: pinenote: Add accelerometer
      commit: 8d411bebd4538a9750db175c030d6083d5210d7c
[2/2] arm64: dts: rockchip: pinenote: Add USB and TCPC
      commit: 87a267b4af09477721e9d2bad63555f0dc49d08a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
