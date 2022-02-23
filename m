Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46704C2034
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiBWXo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiBWXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:44:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75FA4667D;
        Wed, 23 Feb 2022 15:44:16 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nN1Ir-0005mN-O5; Thu, 24 Feb 2022 00:44:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, frank-w@public-files.de,
        Rob Herring <robh+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: rockchip: enable work led on rk3568-evb1
Date:   Thu, 24 Feb 2022 00:44:08 +0100
Message-Id: <164565984101.1356028.4981586346529851167.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
References: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
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

On Tue, 22 Feb 2022 18:50:03 +0100, Michael Riesch wrote:
> Enable the blue work LED on the Rockchip RK3568 EVB1.

Applied, thanks!

[2/2] arm64: dts: rockchip: enable rk809 audio codec on the rk3568 evb1
      commit: 3e4c629ca680785af2cd6bfd688e958b03db921e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
