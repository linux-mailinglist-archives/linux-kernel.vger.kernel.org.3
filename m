Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F61515E05
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353178AbiD3OJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiD3OJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:09:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C545F66225;
        Sat, 30 Apr 2022 07:06:04 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknjS-0001Wl-7m; Sat, 30 Apr 2022 16:05:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Rockchip RK3328 VDEC support
Date:   Sat, 30 Apr 2022 16:05:51 +0200
Message-Id: <165132754298.647302.5036814718557764083.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425184510.1138446-1-chris.obbard@collabora.com>
References: <20220425184510.1138446-1-chris.obbard@collabora.com>
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

On Mon, 25 Apr 2022 19:45:07 +0100, Christopher Obbard wrote:
> This series adds VDEC support for the Rockchip RK3328 SoC which
> uses the staging rkvdec driver.
> 
> Testing was performed using both v4l-compliance and (mainline) gstreamer
> using the fluster framework:
> 
>     $ v4l2-compliance -m0
>     v4l2-compliance 1.22.1, 64 bits, 64-bit time_t
>     ...
>     Grand Total for rkvdec device /dev/media0: 54, Succeeded: 54, Failed: 0, Warnings: 0
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: Rename vdec_mmu node for RK3328
      commit: a2fe0f97fd4a5e482123fc207a48bde844b161a1
[3/3] arm64: dts: rockchip: Add vdec support for RK3328
      commit: 17408c9b119de4edef9ea57ade7e97d4a1b8b632

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
