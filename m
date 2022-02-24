Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103FC4C38F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiBXWqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiBXWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:46:12 -0500
X-Greylist: delayed 1539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 14:45:41 PST
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADACA17F6A7;
        Thu, 24 Feb 2022 14:45:41 -0800 (PST)
Received: from [128.177.79.46] (helo=[10.118.101.22])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1nNMTR-000HIw-8a; Thu, 24 Feb 2022 17:20:33 -0500
Subject: [PATCH v5 2/3] MAINTAINERS: Add Zack as maintainer of vmmouse driver
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     jgross@suse.com, x86@kernel.org, pv-drivers@vmware.com,
        tglx@linutronix.de, bp@alien8.de
Cc:     Zack Rusin <zackr@vmware.com>,
        linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org,
        sdeep@vmware.com, vithampi@vmware.com, amakhalov@vmware.com,
        keerthanak@vmware.com, srivatsab@vmware.com, anishs@vmware.com,
        linux-kernel@vger.kernel.org, namit@vmware.com, joe@perches.com,
        kuba@kernel.org, rostedt@goodmis.org, srivatsa@csail.mit.edu
Date:   Thu, 24 Feb 2022 14:24:36 -0800
Message-ID: <164574146977.654750.10918397477833459687.stgit@csail.mit.edu>
In-Reply-To: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
References: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Zack Rusin will be taking over the maintainership of the VMware
vmmouse driver. Update the MAINTAINERS file to reflect this change.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Zack Rusin <zackr@vmware.com>
Cc: linux-graphics-maintainer@vmware.com
Cc: pv-drivers@vmware.com
Cc: linux-input@vger.kernel.org
---

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9325debf5365..72771881f159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20690,6 +20690,7 @@ S:	Maintained
 F:	drivers/misc/vmw_vmci/
 
 VMWARE VMMOUSE SUBDRIVER
+M:	Zack Rusin <zackr@vmware.com>
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	linux-input@vger.kernel.org


