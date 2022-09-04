Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC51D5AC5B8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiIDRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiIDRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:22:36 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F333342;
        Sun,  4 Sep 2022 10:22:32 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUtKD-0000tW-1f; Sun, 04 Sep 2022 19:22:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, phone-devel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, martijn@brixit.nl,
        devicetree@vger.kernel.org, ayufan@ayufan.eu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        megi@xff.cz
Subject: Re: (subset) [PATCH v3 0/2] Add support for the Pine64 PinePhone Pro phone
Date:   Sun,  4 Sep 2022 19:22:20 +0200
Message-Id: <166231195330.2423948.14614733347050654545.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
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

On Mon, 15 Aug 2022 22:30:02 +1000, Tom Fitzhenry wrote:
> PinePhone Pro is a RK3399 based phone produced by Pine64.
> 
> Add a basic DTS for it. This is a working base that will allow myself and
> others to add more nodes.
> 
> Changes since v2:
> * Used rk3399-opp.dtsi (+ disabled) rather than introducing rk3399-t-opp.dtsi
> * Removed superfluous comments.
> * Followed DT Generic Names Recommendation
> * Set 'From:' of DTS patch to be Martijn, the primary contributor to the DT.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add PinePhone Pro bindings
      commit: 23c5f10981474b44ce1726e3753cbb7ac20d6548

applied together with v5 of the actual board dts patch
which was missing the binding.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
