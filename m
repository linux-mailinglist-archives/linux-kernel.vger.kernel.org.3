Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3F4E51C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiCWMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbiCWMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:02:18 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC77A995;
        Wed, 23 Mar 2022 05:00:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2A6133201F80;
        Wed, 23 Mar 2022 08:00:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 23 Mar 2022 08:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=67atGgUSBw8jUX
        7eYhj353ns5QGeD6hSpEVQq+z2PS0=; b=m5FVksxFZ7N7ME370farG1KL3K+OYQ
        BkQmlcGUHXnfH3GKpla4/ZstfAFXT+UHE0outqT5esvBChxcZNsAOAnYQPXgS+zE
        b19Pl2TYqphlDkOGrIKngw1iTk263xn4pkOtQ9tH3uJESAGbb5AGYLtRcXAIGOhT
        79sQy1s3Zqt4b9yGWyTvIb/NbfZN/4wBqmzHSFc1sJ0nigxO44kozwtdgIIJLQMh
        0ARfvCKjNt5sPOuS+2/hsMZiNGMsMjE1V/8+PP2yelbUU88CZ0qTbVTwlyoAi4E+
        2bxMFnL5V/WDEQ8vR6elHU5hlPX1XDbzncTgXivmLQr5UoU1EZl0fG9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=67atGg
        USBw8jUX7eYhj353ns5QGeD6hSpEVQq+z2PS0=; b=bi3VmLe2XsBYsRaiFRpeL3
        Dx57CVln7fCFOWqHvqp/PFAErz2MzUUKBsQWGl1lh149zl/n9GZq5dONyEfH6JvU
        GGodiToP+VpAFJC0ldw3pF2TWK721kUO+4aL6P9yNqEx/lgH7w5ouAa6vKoftTLp
        Q0mqIh3yR7DEu/kb49sPRSvqiwlBYxV6HHWtevguah3FOJYZBRPLdFlommLO0Mop
        PHOEi4WwDqGoZi5HlF1Q0XB4Z5sNH1iSjOocw2VYrydYhaQ/KNAFoR/LUotPR8LB
        92O8rFQz+F6dP5yoVmQ9e/4dgIPmxFdl/x2+Zbz/9BW4I34YCUR9kplxBImcxwqA
        ==
X-ME-Sender: <xms:7ws7YmOR-qB18vDbQXBe_OiiEtlUvYrxFi16jtdTclW9am-vyKELpg>
    <xme:7ws7Yk_1iNIvkiNtdISUKyhQsMiSia9bltJxT8rql-NZpHmE2Zz2QKpJv8iUzONvp
    nRmBNhyn_4oU-71E5Y>
X-ME-Received: <xmr:7ws7YtTE6U45rWCmpqA6gO1D_CubkxmYKk9pZlkadVsk6lsENnTxjUcbaUJM4jj02ji4KlRsRyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:7ws7YmuysjDjIKn6OAV_0Hzd0ZUEL6x3kq9iS_GvZ3eFDObPwWfcfQ>
    <xmx:7ws7YufdScnCgP8J0lwkEDLJqduOGQnBlgqvkuGBViO25MBDew4XmQ>
    <xmx:7ws7Yq2hq3VQcKNlhpUlX8iQ6oViMmc7tPgVpgPpDzH-7bBlbquMdg>
    <xmx:7ws7Yu5DVdhlSItVd4hXl2SAsA5DF9KXk_PcNWvlc8eU2Nifu_bcOA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 08:00:43 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, rydberg@bitmath.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Wed, 23 Mar 2022 22:00:20 +1000
Message-Id: <20220323120021.361137-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323120021.361137-1-alistair@alistair23.me>
References: <20220323120021.361137-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 37ec95fce3be..dd864b7eb562 100644
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
2.35.1

