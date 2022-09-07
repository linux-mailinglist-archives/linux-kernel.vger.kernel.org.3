Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB85AFD18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIGHHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIGHH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:07:28 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3748F94D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:07:27 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id B48921272;
        Wed,  7 Sep 2022 09:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662534444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bJnSKITTJqSfMiPTmKnKpRA3/RQbefyoBS0NJN5gKhM=;
        b=qWEvByRteGr2NI9UA2IILkIuwmVUuTt+v3ozh6PdUx91PNXe2GfA24aZECX0wKMu+9+q9h
        qRvUi390KwT5RQai27Zhx4tGfl1jsqrBmsEmdPfW91N8TzyUvd+zgGIo/mpdt6XAOyxV5P
        ucWLqmY+9LjQeuFF5YH1gc1WYToTuilz2tUUeyTiBDFmnQZSq6KGsbABb38fFXBKZ+OjeO
        rvl6PM2fCxbfUDacJ1VDZzaN+4Cb+yfbtKAWRWAXQX5s+OuA80+vTUJeFTWInyW7XHdRTg
        LXj+85ulE9NV+Ac40yXC05LFfvVlUSsIUtA6/J3i5BYjXk7YNF2WXkEK1MZAOA==
From:   Michael Walle <michael@walle.cc>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [RESEND PATCH] arm64: defconfig: enable ARCH_NXP
Date:   Wed,  7 Sep 2022 09:06:26 +0200
Message-Id: <20220907070626.2933998-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 566e373fe047 ("arm64: Kconfig.platforms: Group NXP platforms
together") introduced a new symbol ARCH_NXP and made ARCH_LAYERSCAPE
(among others) depend on it, but didn't enable it in the defconfig.
Thus, now the defconfig doesn't include support for any NXP
architectures anymore. Fix it.

Fixes: 566e373fe047 ("arm64: Kconfig.platforms: Group NXP platforms together")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
The first submission had a wrong mail address, so this patch didn't
end up on lore.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91e58cf59c99..07b9185f5937 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -47,6 +47,7 @@ CONFIG_ARCH_KEEMBAY=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_NXP=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_QCOM=y
-- 
2.30.2

