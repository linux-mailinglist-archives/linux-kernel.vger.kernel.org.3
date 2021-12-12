Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA8471A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhLLMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:41:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60760 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhLLMk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:40:59 -0500
Received: from ip4d17a2ab.dynamic.kabel-deutschland.de ([77.23.162.171] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mwO9v-0004Fw-L8; Sun, 12 Dec 2021 13:40:55 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: rockchip: Add missing secondary compatible for PX30 DSI
Date:   Sun, 12 Dec 2021 13:40:52 +0100
Message-Id: <163931280631.2862987.430237761887020251.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211211233818.88482-1-david@ixit.cz>
References: <20211211233818.88482-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 00:38:17 +0100, David Heidelberg wrote:
> Add second DSI compatible to comply with DT schema validation
> comming in the second patch.

Applied, thanks!

[1/2] arm64: dts: rockchip: Add missing secondary compatible for PX30 DSI
      commit: a39891a6e420daeb55abc99cde4278511ac861d7

I've picked the dtsi patch. We'll need to wait a bit for
a review of the yaml conversion.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
