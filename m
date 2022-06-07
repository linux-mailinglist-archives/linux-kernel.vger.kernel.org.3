Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90D53F96E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiFGJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiFGJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:19:34 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C3E5287;
        Tue,  7 Jun 2022 02:19:30 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nyVN1-0004mn-U0; Tue, 07 Jun 2022 11:19:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fixup! arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
Date:   Tue,  7 Jun 2022 11:19:25 +0200
Message-Id: <165459351568.925770.13686160465924068647.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220606152204.3671113-1-pgwipeout@gmail.com>
References: <20220606152204.3671113-1-pgwipeout@gmail.com>
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

On Mon, 6 Jun 2022 11:22:04 -0400, Peter Geis wrote:
> Having a gap in the address space leads to read issues with NVMe SSDs.
> Fixup the address space.

Applied, thanks!

[1/1] fixup! arm64: dts: rockchip: Add rk3568 PCIe2x1 controller

    I've folded this fixup into the original patch while rebasing
    that branch onto 5.19-rc1.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
