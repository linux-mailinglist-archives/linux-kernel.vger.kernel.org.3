Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90C48BD99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349134AbiALDSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348321AbiALDSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:18:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4FC06173F;
        Tue, 11 Jan 2022 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PVoVl6PR0n0Bk1pat/DgH/rPJNu9igik/VHMYACb0+o=; b=CckRcoL5Jw27ipPDuFB+UJdn4N
        N1MSn2QxzYK7eZ3nNjsYBhbnVFcTWIEn1WL2ZUDUyg0Okj9x19FK4kV3Vi+9a6qEg9DkS1rcG5L9O
        HEAc7QN6mOzkJgUQ8zCs04XZCMQNvFkDT2Iho9GhEarT0h/gR5UUSX3tdtCA4nymcn7I2bXj5yMJ/
        Dr4yvhZQhpdRIcOEySBaIo1rw1bFmaTxMLJ7guz9wQ4ECxON8OlgXfJtj1BeF8bT3a2CDRfvH81wL
        WQIPbNgtyTXj3cXBOt0AKPK4RLV8YtdUoZoTI+nQBZaEvOq7xk4P1sYmpJZfAzSUjG+tyISlOtq+5
        bB7/OAwA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7U9o-0010pv-Ul; Wed, 12 Jan 2022 03:18:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Cc:     jeyu@kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: add mailing lists for kmod and modules
Date:   Tue, 11 Jan 2022 19:18:37 -0800
Message-Id: <20220112031837.241476-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the linux-modules list for kmod and linux modules changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47a541ef7ba0..acd112c42255 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10681,6 +10681,7 @@ F:	samples/kmemleak/kmemleak-test.c
 KMOD KERNEL MODULE LOADER - USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
+L:	linux-modules@vger.kernel.org
 S:	Maintained
 F:	include/linux/kmod.h
 F:	kernel/kmod.c
@@ -12970,6 +12971,8 @@ F:	drivers/media/dvb-frontends/mn88473*
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
+L:	linux-modules@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
-- 
2.33.0

