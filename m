Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6044FAF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiDJRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243709AbiDJRPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:15:19 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C434B87;
        Sun, 10 Apr 2022 10:13:08 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndb7S-0006hD-7o; Sun, 10 Apr 2022 19:12:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/15] rk3399: Clean up and enable DDR DVFS
Date:   Sun, 10 Apr 2022 19:12:52 +0200
Message-Id: <164961074166.23152.15908748993701910543.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
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

On Tue, 8 Mar 2022 11:08:46 -0800, Brian Norris wrote:
> This series covers 2 primary tasks:
> 
> 1) Resubmit prior work:
> 
> [RESEND PATCH v5 3/4] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
> https://lore.kernel.org/lkml/20210308233858.24741-2-daniel.lezcano@linaro.org/
> [RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
> https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
> 
> [...]

Applied, thanks!

[11/15] arm64: dts: rk3399: Add dfi and dmc nodes
        commit: 1b3f36854ab74839693582bc957930f4416ce8ff
[12/15] arm64: dts: rockchip: Enable dmc and dfi nodes on gru
        commit: 80bc6f34c559c97069b75d6eb453d4218c3ed017

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
