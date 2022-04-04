Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0758B4F118F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiDDJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbiDDJCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:02:11 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA002B1AB;
        Mon,  4 Apr 2022 02:00:16 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nbIZB-0008Ew-GN; Mon, 04 Apr 2022 11:00:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH v1 0/2] Change Bananapi-R2-Pro board to match V1.0
Date:   Mon,  4 Apr 2022 10:59:59 +0200
Message-Id: <164906273049.1398682.587469799631775473.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402110045.104031-1-linux@fw-web.de>
References: <20220402110045.104031-1-linux@fw-web.de>
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

On Sat, 2 Apr 2022 13:00:43 +0200, Frank Wunderlich wrote:
> Mainline Devicetree was created for v00 prototype that was not in
> public sale and only shipped to few developers. V1.0 of the board
> has some changes in io-domain and gmacs are swapped.
> 
> Change mainline DTS to match the current hardware.
> 
> Frank Wunderlich (2):
>   arm64: dts: rockchip: Change io-domains of bpi-r2-pro
>   arm64: dts: rockchip: Add gmac1 and change network settings
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Change io-domains of bpi-r2-pro
      commit: 34fc952867aa2a2e257bf2bcbbaac97ac91f8bd1
[2/2] arm64: dts: rockchip: Add gmac1 and change network settings
      commit: 5c8e82ed3a4a5c8023b2959d8f3292f7291e7227

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
