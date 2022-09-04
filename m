Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7303C5AC5B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiIDRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiIDRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:22:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7F732DA9;
        Sun,  4 Sep 2022 10:22:31 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUtKD-0000tW-Cv; Sun, 04 Sep 2022 19:22:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     Heiko Stuebner <heiko@sntech.de>, phone-devel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/1] Add support for the Pine64 PinePhone Pro phone
Date:   Sun,  4 Sep 2022 19:22:21 +0200
Message-Id: <166231195330.2423948.5394487959576836993.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829050040.17330-1-tom@tom-fitzhenry.me.uk>
References: <20220829050040.17330-1-tom@tom-fitzhenry.me.uk>
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

On Mon, 29 Aug 2022 15:00:39 +1000, Tom Fitzhenry wrote:
> PinePhone Pro is a RK3399 based phone produced by Pine64.
> 
> Add a basic DTS for it. This is a working base that will allow myself and
> others to add more nodes.
> 
> Relies on "dt-bindings: arm: rockchip: Add PinePhone Pro bindings"[0].
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro
      commit: 78a21c7d59520e72ebea667fe8745a4371d9fe86


Why was the dt-binding addition missing?
I've pulled the binding from v3 now.

While it is true that you should not resend patches just to add Acks,
when re-sending a whole series that includes other changes it's still
necessary to keep all patches together ;-)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
