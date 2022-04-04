Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE34F1190
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiDDJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbiDDJCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:02:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9892B185;
        Mon,  4 Apr 2022 02:00:16 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nbIZB-0008Ew-2i; Mon, 04 Apr 2022 11:00:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Anand Moon <linux.amoon@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vivek Unune <npcomplete13@gmail.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] ARM: dts: rk3188: correct interrupt flags
Date:   Mon,  4 Apr 2022 10:59:58 +0200
Message-Id: <164906273049.1398682.13221310139844668938.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20200917185211.5483-1-krzk@kernel.org>
References: <20200917185211.5483-1-krzk@kernel.org>
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

On Thu, 17 Sep 2020 20:52:10 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags without affecting the code:
>   ACTIVE_HIGH => IRQ_TYPE_NONE

Applied, thanks!

[1/2] ARM: dts: rk3188: correct interrupt flags
      commit: 7e5a7e39d767b60d8631792bd3d7820a6f4a43f8
[2/2] arm64: dts: rk3399: correct interrupt flags
      commit: 57f3b0bf5c346f73a848c3d74270b21ed110e530

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
