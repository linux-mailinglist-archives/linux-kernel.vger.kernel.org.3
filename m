Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA63A4A3148
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 19:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352932AbiA2SBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 13:01:17 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49078 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244848AbiA2SBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 13:01:15 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDs2E-0005gc-8i; Sat, 29 Jan 2022 19:01:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: align pl330 node name with dtschema
Date:   Sat, 29 Jan 2022 19:01:17 +0100
Message-Id: <164347927007.1475317.12886729868087154113.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220129175429.298836-1-krzysztof.kozlowski@canonical.com>
References: <20220129175429.298836-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 18:54:29 +0100, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>   dmac@ff240000: $nodename:0: 'dmac@ff240000' does not match '^dma-controller(@.*)?$'

Applied, thanks!

[1/1] arm64: dts: rockchip: align pl330 node name with dtschema
      commit: 3d7eaaa2fda44a5d11efdb1069664dba6ee49ee0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
