Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3644FAF37
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiDJRPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiDJRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:15:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14434B80;
        Sun, 10 Apr 2022 10:13:03 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndb7S-0006hD-L1; Sun, 10 Apr 2022 19:12:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 1/2] dt-bindings: pinctrl: add rockchip, rk3036-pinctrl compatible string
Date:   Sun, 10 Apr 2022 19:12:53 +0200
Message-Id: <164961074165.23152.1000043865716851789.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330133952.1949-1-jbx6244@gmail.com>
References: <20220330133952.1949-1-jbx6244@gmail.com>
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

On Wed, 30 Mar 2022 15:39:51 +0200, Johan Jonker wrote:
> Add the compatible string "rockchip,rk3036-pinctrl" in already
> in use in rk3036.dtsi to rockchip,pinctrl.yaml.

Applied, thanks!

[2/2] ARM: dts: rockchip: rk3036: rename pcfg_pull_default node name
      commit: e0badfe359ef4d01ca74261093e65f742f321da8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
