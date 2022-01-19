Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B903F4933AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351334AbiASDjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbiASDjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:39:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC12C061574;
        Tue, 18 Jan 2022 19:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EiVf29ZWa3UvVQ+Z++r4y2NqjonXxCbIKpWNeyKw/Ys=; b=mJVKtwN7WptoTQ+4Md43Z9gq7K
        bPrzGVkt12QjZyl0S6tkMhYgZ2E+qtaIFUjlY0ugCmdXU9V0VJXGvrzudF0SOO+hhNwin72tuu/Ky
        H6eokKlaShlOUBHYbZMycdhswkgNTvU6PwgL7yYEqRBEkXHcqKE5epcfEI8hhc5eXst+mvY//QrTw
        CZjRW5C++mtHUAUj/JEIwbHexZgnh/IqnSUGn3ct3ZiViaLiN/vqaPqiD9i6+P5JIAkDjaQIoEW6e
        i+arJziPge9IWig6oVqUctNlpUa/ltlmsK5m38Uij1c1SyzqXOVI4Mg5S+qdn2LOttQrLuWVc8vE8
        5jt0fDkg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nA1oQ-003gb6-Fw; Wed, 19 Jan 2022 03:39:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -next v2] Documentation: fix firewire.rst ABI file path error
Date:   Tue, 18 Jan 2022 19:39:05 -0800
Message-Id: <20220119033905.4779-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the path of the ABI files for firewire.rst to prevent a
documentation build error. Prevents this problem:

Sphinx parallel build error:
docutils.utils.SystemMessage: Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.

Fixes: 2f4830ef96d2 ("FireWire: add driver-api Introduction section")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Tested-by: Akira Yokosawa <akiyks@gmail.com>
---
v2: Add Tested-by: and Fixes: from Akira (thanks!)
    shorten path in error message;

 Documentation/driver-api/firewire.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220118.orig/Documentation/driver-api/firewire.rst
+++ linux-next-20220118/Documentation/driver-api/firewire.rst
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
