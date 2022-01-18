Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1B4913F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 03:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiARCPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 21:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiARCP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:15:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA082C061574;
        Mon, 17 Jan 2022 18:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nrC9v5TH5mhwcYLw5MQgkFk0+L190zpoOd9ftRKCwRI=; b=fiA9taDxGDlpNEyMgBxG+r8mcG
        sQqY4MeaBicL8wGkJpLgSa9oIDEteMyNcCIGKzJU2+HQKxuRtgsj+Vg2DxQEoRt+dEe2fnz+zw3Zk
        yIv2SIstLoUOep60Xv3fSXA91Dqm7V9EioiPdMFiCD9em4Qqk+a4vcLIQ+CqDsalnt6dFeTGB5kb0
        6V4NAHDGah8IZuFUtAwUVWoDmwf9eCVfaxz3ci5Bev7AYOaYeuu3razOLnK93WsTNpCcpN3enmn2+
        K8rgbg5v98w8WNzL1xxPL6vEE/69XSkVv/dQmMwrtvFvJCDldO9Mjrm455jY3TQ/1UwwYc5eX6E3J
        9DL1fSMA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9e1r-00Gs6a-OI; Tue, 18 Jan 2022 02:15:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -next] power: supply: fix table problem in sysfs-class-power
Date:   Mon, 17 Jan 2022 18:15:22 -0800
Message-Id: <20220118021522.1672-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bottom table border to complete the table format and prevent
a documentation build warning.

Documentation/ABI/testing/sysfs-class-power:459: WARNING: Malformed table.
No bottom table border found.

Fixes: 1b0b6cc8030d0 ("power: supply: add charge_behaviour attributes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/ABI/testing/sysfs-class-power |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220117.orig/Documentation/ABI/testing/sysfs-class-power
+++ linux-next-20220117/Documentation/ABI/testing/sysfs-class-power
@@ -468,6 +468,7 @@ Description:
 			auto:            Charge normally, respect thresholds
 			inhibit-charge:  Do not charge while AC is attached
 			force-discharge: Force discharge while AC is attached
+			================ ====================================
 
 What:		/sys/class/power_supply/<supply_name>/technology
 Date:		May 2007
