Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1352ABAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352649AbiEQTLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352591AbiEQTL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:11:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709B34BB9;
        Tue, 17 May 2022 12:11:25 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nr2bL-00043L-Dc; Tue, 17 May 2022 21:11:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     zhangqing@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
Date:   Tue, 17 May 2022 21:11:17 +0200
Message-Id: <165281458742.3119039.6001073112937084261.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329113657.4567-1-jbx6244@gmail.com>
References: <20220329113657.4567-1-jbx6244@gmail.com>
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

On Tue, 29 Mar 2022 13:36:56 +0200, Johan Jonker wrote:
> Current dts files with RK3288 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3288-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names

Applied, thanks!

[1/2] dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
      commit: 03339ecc41201218eb2e9fa191bfa84b86cf26fd
[2/2] ARM: dts: rockchip: add clocks property to cru node rk3288
      commit: 1b36d43799187791750aa73286f0e2530f67f003

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
