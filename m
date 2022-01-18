Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C841D4912FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiARAs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiARAsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:48:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844ECC061574;
        Mon, 17 Jan 2022 16:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GKFv+rNBUgP+uemMExRCemo1T5lz+hJjEuBQFmv6aMw=; b=J3VhQ4xSElaK2untFTsfWu91iZ
        XmsOnj/KodXByQhJCxeiTaykyxPNK+VntLgOxk4iLDzo3fYLZkyukn4EoaxoQnvzwSy1E83CDZP3V
        MyI8j/n2Bf6mg5qe+ox6qJ4fpX18jU/3n0k8PVV3wDsNpH+XBYZyvuROisjh1sCeKjRbJdcziVkSi
        lUMND2LrxOcflhcWlEVE3YP5h6PRllRUKEfhkxXAKFVvb+la5AEkp+Tk/PREjhn3uSP4kRDfB19Ky
        YzreROqtWUjxALjR7ks9pNKilyz07oPLd/+Z8xQmqQT6uJbU9c+AnCuIPXawBXFxKZR4oPcnkt0B2
        iP1GzmNA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9cfe-00GhFw-Iz; Tue, 18 Jan 2022 00:48:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH -next] thermal: fix Documentation bullet list warning
Date:   Mon, 17 Jan 2022 16:48:21 -0800
Message-Id: <20220118004821.27408-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bullet list indentation formatting to prevent a docs build warning.
Use same indentation style as other files in this directory.

Documentation/ABI/testing/sysfs-class-thermal:201: WARNING: Bullet list ends without a blank line; unexpected unindent.

Fixes: 80da1b508f29 ("thermal: Move ABI documentation to Documentation/ABI")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-class-thermal |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220117.orig/Documentation/ABI/testing/sysfs-class-thermal
+++ linux-next-20220117/Documentation/ABI/testing/sysfs-class-thermal
@@ -203,7 +203,7 @@ Description:
 
 		- for generic ACPI: should be "Fan", "Processor" or "LCD"
 		- for memory controller device on intel_menlow platform:
-		should be "Memory controller".
+		  should be "Memory controller".
 
 		RO, Required
 
