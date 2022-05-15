Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5A5279F5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiEOUkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEOUkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:40:18 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9318B18;
        Sun, 15 May 2022 13:40:14 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nqL26-0006KS-GD; Sun, 15 May 2022 22:40:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     zhangqing@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, krzk+dt@kernel.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: convert rockchip,rv1108-cru.txt to YAML
Date:   Sun, 15 May 2022 22:40:04 +0200
Message-Id: <165264719504.2587306.15719505641957259296.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330131608.30040-1-jbx6244@gmail.com>
References: <20220330131608.30040-1-jbx6244@gmail.com>
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

On Wed, 30 Mar 2022 15:16:06 +0200, Johan Jonker wrote:
> Convert rockchip,rv1108-cru.txt to YAML.
> 
> Changes against original bindings:
>   Add clocks and clock-names because the device has to have
>   at least one input clock.

Applied, thanks!

[1/3] dt-bindings: clock: convert rockchip,rv1108-cru.txt to YAML
      commit: 5eb60b7bff3233d07e6a9e3328d2ba415209691e
[2/3] ARM: dts: rockchip: add clocks property to cru node rv1108
      commit: f36fed209444efe8ac6621900f407c6569c92dc9
[3/3] ARM: dts: rockchip: Remove bogus "amba" bus nodes part 2
      commit: 191800d40222ee920dab2e7a774ea2ae4f28c1c9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
