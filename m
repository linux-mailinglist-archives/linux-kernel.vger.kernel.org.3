Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F44ADEC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383625AbiBHQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352379AbiBHQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:59:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4433C06157A;
        Tue,  8 Feb 2022 08:59:25 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHTpp-0002ya-Pw; Tue, 08 Feb 2022 17:59:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rename and sort the rk356x usb2 phy handles
Date:   Tue,  8 Feb 2022 17:59:17 +0100
Message-Id: <164433936977.231183.18016907224381474829.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
References: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
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

On Thu, 27 Jan 2022 20:04:55 +0100, Michael Riesch wrote:
> All nodes and handles related to USB have the prefix usb or usb2,
> whereas the phy handles are prefixed with u2phy. Rename for
> consistency reasons and to facilitate sorting.
> 
> This patch also updates the handles in the only board file that
> uses them (rk3566-quartz64-a.dts).

Applied, thanks!

[1/2] arm64: dts: rockchip: rename and sort the rk356x usb2 phy handles
[2/2] arm64: dts: rockchip: add usb2 support to rk3568-evb1-v10

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
