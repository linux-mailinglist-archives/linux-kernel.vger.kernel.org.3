Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610484972A5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbiAWPky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:40:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46994 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237932AbiAWPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:40:52 -0500
Received: from p508fcdea.dip0.t-ipconnect.de ([80.143.205.234] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBez1-0005OB-Ci; Sun, 23 Jan 2022 16:40:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "quentin.schulz@theobroma-systems.com" 
        <quentin.schulz@theobroma-systems.com>, robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <foss+kernel@0leil.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk3399-puma-haikou USB OTG mode
Date:   Sun, 23 Jan 2022 16:40:46 +0100
Message-Id: <164295214821.418606.138757821449348671.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120125156.16217-1-quentin.schulz@theobroma-systems.com>
References: <20220120125156.16217-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 13:51:56 +0100, quentin.schulz@theobroma-systems.com wrote:
> The micro USB3.0 port available on the Haikou evaluation kit for Puma
> RK3399-Q7 SoM supports dual-role model (aka drd or OTG) but its support
> was broken until now because of missing logic around the ID pin.
> 
> This adds proper support for USB OTG on Puma Haikou by "connecting" the
> GPIO used for USB ID to the USB3 controller device.

Applied as fix for 5.17, thanks!

[1/1] arm64: dts: rockchip: fix rk3399-puma-haikou USB OTG mode
      commit: ed2c66a95c0c5669880aa93d0d34c6e9694b4cbd

I've done a bit of reordereing:
- extcon comes alphabetically after dr_mode
- extcon-usb3 before external-gmac...


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
