Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C050C480CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhL1UGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbhL1UGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:06:39 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5AFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 12:06:39 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 65D1B58731D3D; Tue, 28 Dec 2021 21:06:36 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.5 (2021-03-20) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.5
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 2A44058731D2D;
        Tue, 28 Dec 2021 21:06:35 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     gregkh@linuxfoundation.org
Cc:     tkjos@android.com, linux-kernel@vger.kernel.org
Subject: [PATCH] android: use "menuconfig" menu entry type for CONFIG_ANDROID
Date:   Tue, 28 Dec 2021 21:06:34 +0100
Message-Id: <20211228200634.18968-1-jengelh@inai.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow disabling the Android driver section from within the Device
Drivers submenu, without having to descend into the Android drivers
submenu first.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 drivers/android/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git drivers/android/Kconfig drivers/android/Kconfig
index 53b22e26266c..dc0a373ab879 100644
--- drivers/android/Kconfig
+++ drivers/android/Kconfig
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-menu "Android"
-
-config ANDROID
+menuconfig ANDROID
 	bool "Android Drivers"
 	help
 	  Enable support for various drivers needed on the Android platform
@@ -55,5 +53,3 @@ config ANDROID_BINDER_IPC_SELFTEST
 	  alignments.
 
 endif # if ANDROID
-
-endmenu
-- 
2.34.1

