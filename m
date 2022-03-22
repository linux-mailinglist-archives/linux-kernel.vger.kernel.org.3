Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11FB4E441A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiCVQXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiCVQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:23:04 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AF22297;
        Tue, 22 Mar 2022 09:21:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 47A92C800A2;
        Tue, 22 Mar 2022 17:21:30 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1647966090; x=1649780491; bh=6E
        Gujr18vRFJUUAMJRfSlIIjXJH/g/+VNbX3GvlMa+c=; b=JAtlI4kOV6Sx1sFMTU
        WhbidSFuTg/v36hjQQ3OGhduVNzNVBTEaCIMT1qzcfbGLa61orhCH3f6mfu0fY83
        qS46nAL0IipZ/J1X39a4dOmKwqYiLupKBM6hk1AI6VYCC3bC26Jqgw/EEiQlaR/G
        6knUW2gCqoyp8s5sFh2A7Zzrs=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 0NUQkRVc_GaN; Tue, 22 Mar 2022 17:21:30 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (unknown [IPv6:2001:a61:6168:d301:4be4:641d:6061:c5dc])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id D7FE8C8009B;
        Tue, 22 Mar 2022 17:21:29 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] input/i8042: Move __initconst to fix code styling warning
Date:   Tue, 22 Mar 2022 17:21:22 +0100
Message-Id: <20220322162125.59838-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322162125.59838-1-wse@tuxedocomputers.com>
References: <20220322162125.59838-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move __intconst from before i8042_dmi_laptop_table[] to after it for
consistent code styling.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 148a7c5fd0e2..91c6f24b4837 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -791,7 +791,7 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
 	{ }
 };
 
-static const struct dmi_system_id __initconst i8042_dmi_laptop_table[] = {
+static const struct dmi_system_id i8042_dmi_laptop_table[] __initconst = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
-- 
2.25.1

