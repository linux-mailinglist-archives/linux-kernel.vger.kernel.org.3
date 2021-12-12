Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B08471A19
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhLLMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:40:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60758 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhLLMk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:40:58 -0500
Received: from ip4d17a2ab.dynamic.kabel-deutschland.de ([77.23.162.171] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mwO9w-0004Fw-1K; Sun, 12 Dec 2021 13:40:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/3] RK356x/Quartz64 Model A SPI
Date:   Sun, 12 Dec 2021 13:40:53 +0100
Message-Id: <163931280631.2862987.5299564340042039820.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 15:19:06 +0100, Nicolas Frattaroli wrote:
> Changes in v2:
>  - sort properties in rk356x.dtsi correctly
>  - remove pinctrl-1 line from rk356x.dtsi as it refers to
>    non-mainline stuff
> 
> Original cover letter:
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: Add spi nodes on rk356x
      commit: aaa552d84580e9213d0e2bf0f9243477d1227bdd
[3/3] arm64: dts: rockchip: Add spi1 pins on Quartz64 A
      commit: ea1847c09c34234c2980b99b6bb732a55447c33f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
