Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF748A908
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbiAKIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:00:19 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44204 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiAKIAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:00:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 76914614E2C4;
        Tue, 11 Jan 2022 09:00:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u7Ek8Ybj6hVR; Tue, 11 Jan 2022 09:00:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 13819614E2CB;
        Tue, 11 Jan 2022 09:00:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MnDfqMAWnTUP; Tue, 11 Jan 2022 09:00:14 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B9DFB614E2C4;
        Tue, 11 Jan 2022 09:00:14 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-kernel@vger.kernel.org
Cc:     linux-um@vger.kernel.org, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, Richard Weinberger <richard@nod.at>
Subject: [PATCH] MAINTAINERS: Update UserModeLinux entry
Date:   Tue, 11 Jan 2022 08:58:51 +0100
Message-Id: <20220111075851.12605-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Johannes and form a maintainer group with on a common
git repository.

While we are here, remove inactive developers.
Jeff, thanks for your great work!

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c1260c..6d095b5ba326 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19896,14 +19896,15 @@ F:	Documentation/admin-guide/media/zr364xx*
 F:	drivers/media/usb/zr364xx/
=20
 USER-MODE LINUX (UML)
-M:	Jeff Dike <jdike@addtoit.com>
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
+M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
 Q:	https://patchwork.ozlabs.org/project/linux-um/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git fixes
 F:	Documentation/virt/uml/
 F:	arch/um/
 F:	arch/x86/um/
--=20
2.26.2

