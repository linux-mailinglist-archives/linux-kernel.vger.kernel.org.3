Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F37515DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiD3OJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiD3OJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:09:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04765403
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:06:00 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknjR-0001Wl-On; Sat, 30 Apr 2022 16:05:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] soc: rockchip: Clean up Kconfig whitespace
Date:   Sat, 30 Apr 2022 16:05:50 +0200
Message-Id: <165132754299.647302.4728790940190347184.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426014545.628100-1-briannorris@chromium.org>
References: <20220426014545.628100-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 18:45:42 -0700, Brian Norris wrote:
> There are spaces instead of tabs, and other inconsistent indentation.

Applied, thanks!

[1/3] soc: rockchip: Clean up Kconfig whitespace
      commit: 9be1a9996ebd8da27cafc947e4578b2d419dc07e
[2/3] soc: rockchip: power-domain: Replace dsb() with smb()
      commit: 2ca9e472c70f15de768ab200571e2f6634f66394
[3/3] soc: rockchip: Fix compile-testing SoC drivers
      commit: add9f6f30e54b5c07e7a0260cda459ef1d9646b7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
