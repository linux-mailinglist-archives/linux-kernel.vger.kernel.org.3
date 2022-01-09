Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD485488A9D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiAIQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 11:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiAIQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 11:37:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55372C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 08:37:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 18ACB1F40359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641746230;
        bh=Bpd8xUWxmA4RJkcYDjsNYwzlEV49TfkepVOznECnw28=;
        h=From:To:Cc:Subject:Date:From;
        b=IwHI5SxXa6IK50lOAd01j8xpiNxe9ME6gjZKJB7s+Gdoy5w01gG4TLecGFhBPh5BR
         5qGULy+bAlSoDWMPiV9/5eg+24Crk383DkbJpUn5e/90KFSZc/ywIeZSbFOppZEOm7
         X7GdEapzd72VqfOVLPMM7JsTugxLnzZ7GdBtbsA7Bd2Gf3pJCRS617EzIfVQ5z3CSq
         DirQdnwO6Xb+2Avs51HpdkemVEjgvuOgeECjeHcdA/Swiijy13ww4Kj5Th3GzVK/ww
         QDZdqgv+GgbiFpPejtfUDvCeX1c+7R18LtzGdZoQ28yP7pvxfsw3JIJ5PxUnNFsbq6
         6YG8u/c/VT9fA==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Update create_bo flags comment
Date:   Sun,  9 Jan 2022 11:37:04 -0500
Message-Id: <20220109163704.2564-1-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update a comment stating create_bo took no flags, since it now takes a
bit mask of optional flags NOEXEC and HEAP.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---
 include/uapi/drm/panfrost_drm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 061e700dd06c..9e40277d8185 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -84,14 +84,14 @@ struct drm_panfrost_wait_bo {
 	__s64 timeout_ns;	/* absolute */
 };
 
+/* Valid flags to pass to drm_panfrost_create_bo */
 #define PANFROST_BO_NOEXEC	1
 #define PANFROST_BO_HEAP	2
 
 /**
  * struct drm_panfrost_create_bo - ioctl argument for creating Panfrost BOs.
  *
- * There are currently no values for the flags argument, but it may be
- * used in a future extension.
+ * The flags argument is a bit mask of PANFROST_BO_* flags.
  */
 struct drm_panfrost_create_bo {
 	__u32 size;
-- 
2.34.1

