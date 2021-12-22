Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50347D263
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhLVMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:46:30 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35383 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237086AbhLVMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:46:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F05158049F;
        Wed, 22 Dec 2021 07:46:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Dec 2021 07:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=eqhk7Ic8pZPJY
        dazb8fewxiM8e1R86oONtKWbPMz2jg=; b=FGp44fR4ZjdVa4dqHnE7mobEkNauE
        /20bax6QoTREZ7++gHKFNymwXa2S8vFIo/IKEnTIFdxX6xE+EUH3/gHdwPq2OH0B
        S5KrgeFw2vU/BDzHQhIKsNCz9qMvM2SL0n8ueEQER0t+FtCwzJ+rdEJFCBKNVIDx
        KlvMwk/wFFrwQq85qOpU+OQQguSRpCsPAkNZ3YM0mH4lxZHNeHZDmWG5IIN6RPPC
        yjolf1XMhTV7Pd4TGidKO6aMdBY8eCm12gyJiPwmxEHzUldk3E2wjL6cDr2KziaJ
        8zS5MpuYmuSZ6VDXz/W3si7RTKYHbM6e5pjNemzwDCfYO6KMcQxohpJrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eqhk7Ic8pZPJYdazb8fewxiM8e1R86oONtKWbPMz2jg=; b=n6f3vfPz
        772cwqKjbTWYOT4JPTRl36ChgZ1MaLaTdAnMOT8QMOWu3gNUvzBDn/cZ3B1794Ow
        weejJaIa5R21Sum/AiWjEdipr95faW6QM1hHjX5N0ImUFa2QLBK/mVrsdKE/hEle
        flwAW6uq9+x8rEJg2vIT2Dhed5yyncWeoH4ziU0TKl8bVZsgzjDlYUjoMUAIzxva
        idGRAoQKKOdr7B/HwRDD+BwwQtZ8Iv8z5qE7tQaQ37jSfZr+Ebnb67AgPtcxudaU
        VJAB2FUp02pBvhIXeHZMuajHwYOjDieGVTOXptLqjoeHPmZKz5bYtxGPdmLAYrFt
        xNtlFB/mZIRSsw==
X-ME-Sender: <xms:Ix7DYZbpO272YQmfII4DHs4mCgdq07FZn7eRpEJqgnLe7jkasVq89g>
    <xme:Ix7DYQZVnXVDGZVHuurfHzIWGSnySCuc52giMBVM7qtw2fVz6c8z6jr2iE7cxQyDu
    4sm4z3kb4btRMwSPYY>
X-ME-Received: <xmr:Ix7DYb_vSPts4ciNO59ENlGFmCK6UUKbEE6RnssDfA9yYg7kJjlx8kAJRpbB_L-Pl7guFq1kJ_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:Ix7DYXoaa3CWpeIbOOHzwHbP6RI64TL-Sg2PYEntuSkffrcI9kFSbQ>
    <xmx:Ix7DYUqmH4iDW8lrXw5i7xw5rby8P3XYCJgheAvJE9GGL3sTJURW8w>
    <xmx:Ix7DYdTl_l1tiiCOxatzXPLAh1XjzEaBWVCu6ztpzK_2QFEX0FW7BQ>
    <xmx:Ix7DYb3Nwz3e2E4zsDA6ib_T7pcohOG_SlUqx87ujCEv28eXlBwfWQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Dec 2021 07:46:23 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Wed, 22 Dec 2021 22:46:02 +1000
Message-Id: <20211222124603.326920-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211222124603.326920-1-alistair@alistair23.me>
References: <20211222124603.326920-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1fbb8e45e604..5326bf4b4c43 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_AD7879=y
 CONFIG_TOUCHSCREEN_AD7879_I2C=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_CYTTSP5=y
 CONFIG_TOUCHSCREEN_DA9052=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_GOODIX=y
-- 
2.31.1

