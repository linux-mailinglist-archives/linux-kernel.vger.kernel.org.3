Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CB49134D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiARBFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiARBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:05:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45EC061574;
        Mon, 17 Jan 2022 17:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+D+1Fa35JempJQJICO+SIPds0O/uLmaQUC0VXum/YyM=; b=NZxlFVrpBRLAUL8dK/V1ZuRh14
        wtwbRLnL9kX4xDJMiXH4H/hFpXUxIPzuIieedpPy/gCG+uAYH/ivsycWcwEVu96WGNZCXoqZRpAlQ
        adL4GXmJ7+gdpxWQolmfG/EquZPy8RaWgSfx3wP9eYTaW0iNDfzLMh5M+TZ929R4sFS754759VnFk
        FuJqjfKG+QBCE4GnBq07FnZZDWFFhSRGReKsYSR6AlYKKvyOaS0x0cRnM5SQPvKqV1zT5KjybsC7N
        rSRWI2ht86hpDaLvM5Xu84NzM0ULUu3AlH4EW3Clblklk3h9osbW60NEHgNui4SmIAN59Lv9xGkCI
        lzT6YeNA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9cw2-00GkoG-Gf; Tue, 18 Jan 2022 01:05:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH -next] Documentation: fix firewire.rst ABI file path error
Date:   Mon, 17 Jan 2022 17:05:17 -0800
Message-Id: <20220118010517.20826-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the path of the ABI files for firewire.rst to prevent a
documentation build error. Prevents this problem:

Sphinx parallel build error:
docutils.utils.SystemMessage: /work/lnx/next/linux-next-20220117/Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
I don't see what is causing this problem...

 Documentation/driver-api/firewire.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220117.orig/Documentation/driver-api/firewire.rst
+++ linux-next-20220117/Documentation/driver-api/firewire.rst
@@ -19,7 +19,7 @@ of kernel interfaces is available via ex
 Firewire char device data structures
 ====================================
 
-.. include:: /ABI/stable/firewire-cdev
+.. include:: ../ABI/stable/firewire-cdev
     :literal:
 
 .. kernel-doc:: include/uapi/linux/firewire-cdev.h
@@ -28,7 +28,7 @@ Firewire char device data structures
 Firewire device probing and sysfs interfaces
 ============================================
 
-.. include:: /ABI/stable/sysfs-bus-firewire
+.. include:: ../ABI/stable/sysfs-bus-firewire
     :literal:
 
 .. kernel-doc:: drivers/firewire/core-device.c
