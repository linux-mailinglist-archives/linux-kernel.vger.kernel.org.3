Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92152799E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiEOTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiEOTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 15:47:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B232FFD5;
        Sun, 15 May 2022 12:47:51 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nqKDV-00064B-PE; Sun, 15 May 2022 21:47:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/3] add Pine64 touch panel support to rockpro64
Date:   Sun, 15 May 2022 21:47:47 +0200
Message-Id: <165264375744.2524444.9780498055058874635.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511113517.4172962-1-pgwipeout@gmail.com>
References: <20220511113517.4172962-1-pgwipeout@gmail.com>
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

On Wed, 11 May 2022 07:35:13 -0400, Peter Geis wrote:
> Good Morning,
> 
> Apologies Heiko on taking so long for this v2.
> 
> This patch series adds support for the Pine64 touch panel to the
> rockpro64 single board computer.
> This panel attaches to the dsi port and includes an i2c touch screen.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: rockchip: add pine64 touch panel display to rockpro64
 ... for 5.20 .

The binding- and driver-change most likely won't reach drm-main and thus
the next merge-window in time, so I've put the dts patch on a branch for
5.20 instead.

I've also made some ordering changes and dropped both the "force X to vopY"
parts. DT is a hardware-description and not a configuration space ;-) .
And a devicetree should definitly not try to work around implementation
deficits of the kernel driver.

Both VOPs are capable of driving both hdmi and dsi with their relevant
deficiencies being in terms of resolution or clock rates I guess, so
anything related to selecting a matching VOP should be done in code in
the kernel.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
