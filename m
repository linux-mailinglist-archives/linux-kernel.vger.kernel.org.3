Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD77259E6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbiHWQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiHWQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:15:48 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7E9C230;
        Tue, 23 Aug 2022 05:37:06 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQT9P-0004gV-Or; Tue, 23 Aug 2022 14:36:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Pull up wlan wake# on Gru-Bob
Date:   Tue, 23 Aug 2022 14:36:54 +0200
Message-Id: <166125820547.1301371.1322298142251886023.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822164453.1.I75c57b48b0873766ec993bdfb7bc1e63da5a1637@changeid>
References: <20220822164453.1.I75c57b48b0873766ec993bdfb7bc1e63da5a1637@changeid>
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

On Mon, 22 Aug 2022 16:45:04 -0700, Brian Norris wrote:
> The Gru-Bob board does not have a pull-up resistor on its
> WLAN_HOST_WAKE# pin, but Kevin does. The production/vendor kernel
> specified the pin configuration correctly as a pull-up, but this didn't
> get ported correctly to upstream.
> 
> This means Bob's WLAN_HOST_WAKE# pin is floating, causing inconsistent
> wakeup behavior.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Pull up wlan wake# on Gru-Bob
      commit: e5467359a725de90b6b8d0dd865500f6373828ca

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
