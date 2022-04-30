Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C083515DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiD3OJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiD3OJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:09:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E00D65415;
        Sat, 30 Apr 2022 07:06:01 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknjT-0001Wl-A7; Sat, 30 Apr 2022 16:05:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] Add support for several new rk3566 SBCs
Date:   Sat, 30 Apr 2022 16:05:54 +0200
Message-Id: <165132754299.647302.14938632708434795993.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429115252.2360496-1-pgwipeout@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
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

On Fri, 29 Apr 2022 07:52:45 -0400, Peter Geis wrote:
> The following series adds support for the following single board
> computers:
> - Pine64 Quartz64 Model B
> - Pine64 SoQuartz SoM with RPi CM4IO carrier board
> - Firefly Station M2
> 
> Patches 1, 2, and 3 add the requisite dt-bindings.
> Patch 4 adds support for the SFC to the rk356x device tree.
> Patch 5 adds the Quartz64 Model B device tree.
> Patch 6 adds the SoQuartz CM4IO device tree.
> Patch 7 adds the Firefly Station M2 device tree.
> 
> [...]

Applied, thanks!

[4/7] arm64: dts: rockchip: add rk356x sfc support
      commit: 13e0ee34f39c01948a7bbaab0b3c225d9b00a5bb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
