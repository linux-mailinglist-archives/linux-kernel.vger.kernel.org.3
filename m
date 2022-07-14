Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EF574FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiGNNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiGNNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:50:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511261734
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LBBAH8XdZRmaTV7zM6ta6Rvn55sV/KRTIAedB2vOTEM=; b=RhwQHoUYE9gZWHnvUkGvmtvFal
        gFg6JrNCgbyTmPYFF9ZSfeYGXpZKKBKr4Wu2qFzVKcjVsMomKNG04FER2FN0grjtDxMs3BxuV/M6E
        Dk65SFGsqjvMwIGV3FVYU5ReG6hDR7IPvwQ7Yo6miKha1LHsNUlp4e0h3LFIX9FgvHnYaxfHR+SE8
        9yXiW7rjeUSH6qFes+6+FePHtMzzx5+v86lylV+10/Z2RUzUyYvOgkAcpg7t1/uby9b4LZLXVgHUp
        VwzL0KahmTJN0L6xktbavY4vRs1XnmuWcViJrP3026pE+62KnwexusCleckmDr5etzQk1/7vTkCEE
        8XiHv01w==;
Received: from [177.139.47.106] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oBzEL-00GQUY-WE; Thu, 14 Jul 2022 15:50:14 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] drm/amdgpu: Clarify asics naming in Kconfig options
Date:   Thu, 14 Jul 2022 10:49:50 -0300
Message-Id: <20220714134950.9564-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify which architecture those asics acronyms refers to.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 74a8105fd2c0..7777d55275de 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -4,7 +4,7 @@ config DRM_AMDGPU_SI
 	depends on DRM_AMDGPU
 	help
 	  Choose this option if you want to enable experimental support
-	  for SI asics.
+	  for SI (Southern Islands) asics.
 
 	  SI is already supported in radeon. Experimental support for SI
 	  in amdgpu will be disabled by default and is still provided by
@@ -16,7 +16,8 @@ config DRM_AMDGPU_CIK
 	bool "Enable amdgpu support for CIK parts"
 	depends on DRM_AMDGPU
 	help
-	  Choose this option if you want to enable support for CIK asics.
+	  Choose this option if you want to enable support for CIK (Sea
+	  Islands) asics.
 
 	  CIK is already supported in radeon. Support for CIK in amdgpu
 	  will be disabled by default and is still provided by radeon.
-- 
2.37.0

