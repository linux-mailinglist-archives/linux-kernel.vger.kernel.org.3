Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9774A79CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbiBBUzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:55:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56966 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiBBUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:55:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212Kt8Pw017489;
        Wed, 2 Feb 2022 14:55:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643835308;
        bh=TSgd+xCGzaaE5vue8g+IcUiNAO25KhYriLW5DLA2pPI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u8mqbfANm00fkjhdPrNjsbO6Nk+m06TpQ1kbP7Lq342oHBmtWiz8ESzRwICemdG21
         x0mRGffLmI0rnnAHj74k4yrS2I9PvG1ZqbuL+E4pX55ILQJHLUrmOPZXJfSGQqCPBC
         qSyQyRknxXF9iqoUKH0BfK/cUJBlKnp9j/pP92pw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212Kt8JH044381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 14:55:08 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 14:55:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 14:55:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212Kt8Eh025309;
        Wed, 2 Feb 2022 14:55:08 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: add RTI watdog nodes
Date:   Wed, 2 Feb 2022 14:55:07 -0600
Message-ID: <164383529402.22839.4290486437592010268.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111134552.800704-1-christian.gmeiner@gmail.com>
References: <20220111134552.800704-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian Gmeiner,

On Tue, 11 Jan 2022 14:45:48 +0100, Christian Gmeiner wrote:
> Add the needed bus mappings for the two main RTI memory ranges and
> the required device tree nodes in the main domain.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64-main: add RTI watdog nodes
      commit: 41fe04c0d76bb19114ee9f09ae07e2884cdcd75f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

