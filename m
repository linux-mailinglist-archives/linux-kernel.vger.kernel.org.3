Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EB4C2032
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiBWXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbiBWXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:44:49 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8959A59;
        Wed, 23 Feb 2022 15:44:20 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nN1Ir-0005mN-E3; Thu, 24 Feb 2022 00:44:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     mturquette@baylibre.com, "cgel.zte@gmail.com" <cgel.zte@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] clk/rockchip: Use of_device_get_match_data()
Date:   Thu, 24 Feb 2022 00:44:07 +0100
Message-Id: <164565984101.1356028.2147177678382522685.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221020103.1925026-1-chi.minghao@zte.com.cn>
References: <20220221020103.1925026-1-chi.minghao@zte.com.cn>
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

On Mon, 21 Feb 2022 02:01:03 +0000, cgel.zte@gmail.com wrote:
> Use of_device_get_match_data() to simplify the code.

Applied, thanks!

[1/1] clk/rockchip: Use of_device_get_match_data()
      commit: 9f565399ad0739dbdeac868e40e86e80f54dc77b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
