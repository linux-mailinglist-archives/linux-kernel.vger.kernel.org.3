Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDD4FAF39
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiDJRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiDJRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:15:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF85034B8A;
        Sun, 10 Apr 2022 10:13:04 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndb7T-0006hD-1c; Sun, 10 Apr 2022 19:12:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     zhangqing@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, krzk+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: fix some conversion style issues for rockchip,rk3399-cru.yaml
Date:   Sun, 10 Apr 2022 19:12:54 +0200
Message-Id: <164961074166.23152.14936570481603649083.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
References: <20220329150742.22093-1-jbx6244@gmail.com>
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

On Tue, 29 Mar 2022 17:07:37 +0200, Johan Jonker wrote:
> With the conversion of rockchip,rk3399-cru.txt a table with external clocks
> was copied. Make it a bit cleaner by aligning the columns. Also fix
> a description. Phrases start with a capital.

Applied, thanks!

[1/6] dt-bindings: clock: fix some conversion style issues for rockchip,rk3399-cru.yaml
      commit: 04d3e427148f8ed7322f70e324731c81460671df
[2/6] dt-bindings: clock: replace a maintainer for rockchip,rk3399-cru.yaml
      commit: 50cfde33494072c74bf39a0c281cfa0c3289bd57
[3/6] dt-bindings: clock: use generic node name for pmucru example in rockchip,rk3399-cru.yaml
      commit: 91154f0cd889ed3772a0ac0e24ee363f93fe784c
[4/6] dt-bindings: clock: fix rk3399 cru clock issues
      commit: 7adc1b98bb6e6611bc9122de77737b193b693122
[5/6] arm64: dts: rockchip: rk3399: use generic node name for pmucru
      commit: e03774ff21493f4f82ec7853b33fb3ccc35e4363
[6/6] arm64: dts: rockchip: add clocks property to cru nodes rk3399
      commit: 14fc86b9aa5435bf7dd75839c9a73d9a85a98396

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
