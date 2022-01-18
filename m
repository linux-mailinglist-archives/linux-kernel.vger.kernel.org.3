Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29420492BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbiARRHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:07:32 -0500
Received: from forward107o.mail.yandex.net ([37.140.190.210]:39014 "EHLO
        forward107o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbiARRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:07:31 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 12:07:30 EST
Received: from myt6-8f57f8b29865.qloud-c.yandex.net (myt6-8f57f8b29865.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2c81:0:640:8f57:f8b2])
        by forward107o.mail.yandex.net (Yandex) with ESMTP id 4E7156AF9BBF;
        Tue, 18 Jan 2022 20:00:48 +0300 (MSK)
Received: from myt6-9bdf92ffd111.qloud-c.yandex.net (myt6-9bdf92ffd111.qloud-c.yandex.net [2a02:6b8:c12:468a:0:640:9bdf:92ff])
        by myt6-8f57f8b29865.qloud-c.yandex.net (mxback/Yandex) with ESMTP id TIqon8tWko-0leG8KHX;
        Tue, 18 Jan 2022 20:00:48 +0300
Authentication-Results: myt6-8f57f8b29865.qloud-c.yandex.net; dkim=pass
Received: by myt6-9bdf92ffd111.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 5awJUD2gQt-0kPeBMo5;
        Tue, 18 Jan 2022 20:00:46 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Yaroslav Bolyukin <iam@lach.pw>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH] drm/edid: Add Vive Pro 2 to non-desktop list
Date:   Tue, 18 Jan 2022 20:00:37 +0300
Message-Id: <20220118170037.14584-1-iam@lach.pw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 12893e7be..fdb8f0a6f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -200,9 +200,10 @@ static const struct edid_quirk {
 	EDID_QUIRK('V', 'L', 'V', 0x91be, EDID_QUIRK_NON_DESKTOP),
 	EDID_QUIRK('V', 'L', 'V', 0x91bf, EDID_QUIRK_NON_DESKTOP),
 
-	/* HTC Vive and Vive Pro VR Headsets */
+	/* HTC Vive, Vive Pro and Vive Pro 2 VR Headsets */
 	EDID_QUIRK('H', 'V', 'R', 0xaa01, EDID_QUIRK_NON_DESKTOP),
 	EDID_QUIRK('H', 'V', 'R', 0xaa02, EDID_QUIRK_NON_DESKTOP),
+	EDID_QUIRK('H', 'V', 'R', 0xaa04, EDID_QUIRK_NON_DESKTOP),
 
 	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	EDID_QUIRK('O', 'V', 'R', 0x0001, EDID_QUIRK_NON_DESKTOP),

base-commit: 99613159ad749543621da8238acf1a122880144e
-- 
2.34.1

