Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E987488912
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiAILyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:54:01 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34195 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235391AbiAILx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:53:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6691058036F;
        Sun,  9 Jan 2022 06:53:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 09 Jan 2022 06:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=eqhk7Ic8pZPJY
        dazb8fewxiM8e1R86oONtKWbPMz2jg=; b=RcX3U/rvgP6oUKxcJlYVW8rJM07WA
        NYDX3tXsoSL3ZkgnPLIeuWNQYG19Be3jNv8HybmJiosBPY5PClMbKKRv2SsBzIyw
        r/QhbC8z5ogHffrwLUqL/9nxuBDdcbbu4yh0z0hUtbi5sQgZYQ0PoTT3K2hgwjrl
        l4sGC9By/GGmkJTcz6f8FIX3JgFDXgqj0xk3snyOyKo7B7fH9QwjQ3PID609GHTq
        irIBKsgW3Hd7JhmVJwMItWH++LsEgNhX6A3Ki3PKe3UpfOGDm1oIzamJpBOt3VVf
        7lPPB7qQOj3YIQ9EH0UiswcZvTCr7n1GfvDPaqoF6XszOLayGALB8nQ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eqhk7Ic8pZPJYdazb8fewxiM8e1R86oONtKWbPMz2jg=; b=G/ccF6yD
        CzXUosDpebMkGc2E6Boa8sRUMJium0nTKMpOthHfBAScBj2fJNqjN7VV+R2Ee92N
        sGvGNvN8ffoS9lES0sY8IDmh+ke7n4DjQNSyRv5nyGUjiybKjQsl1dvZb6V/uRpI
        bwWMSZckcSIUzyoIH3nEhjLsYyWUYKY6aI2hktVhDzJ3N9k/YNe0LTvk/0e6D1s3
        0i1BCTMW0NEzCegcfHqf1Mloucm8q7APOuRI55H9FNrEvDyuiGsD7fXsVcJQtmfe
        fouEVC1JuI7T7P/TfywUGxP8oe7mM4f2Ix7t5gGlYcNrGjI8K18Fty+p1Kd9lliH
        RqMPrskIHvQn8w==
X-ME-Sender: <xms:1szaYUccnzxSORQuiJxcxohtiNETOmfkt1NorqJ68MxItYvoi1ABEw>
    <xme:1szaYWPwkK4fc1jgC_KqfsIrPtktx0ksxHpGOEnUke2X4KZeZDdz1MXHuK_ozpU-a
    d2abFbwH_Xj5KFXP78>
X-ME-Received: <xmr:1szaYVikU_jxPJ-x5TvurRyKPACXS4ycHk10_TUA_krfkgP8T3vB43EQv0N2yIjqZJShkFx3UQ7t421fpAotqkZTJipKkmiSSp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:1szaYZ91R_dHg1Rb0F5Sb2-D1OI1NfPIWn-N_vguPsbeIW9ddqXNkA>
    <xmx:1szaYQuz8QlpkJhMz_S7eIkyBdk1ixt4CoQBsIsFCoNcydlBDhICRw>
    <xmx:1szaYQG6z3tpK41Ld82uAYqTUwpUn6RKI1QRg_iTrUB0mvQzDZ9asA>
    <xmx:1szaYSI8MWFLESt1D7fepJT4Z0Ua-PoQ4PcEYXvtxTakMTYgP4xaRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:53:54 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        andreas@kemnade.info, linus.walleij@linaro.org,
        alistair23@gmail.com, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Sun,  9 Jan 2022 21:53:30 +1000
Message-Id: <20220109115331.388633-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109115331.388633-1-alistair@alistair23.me>
References: <20220109115331.388633-1-alistair@alistair23.me>
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

