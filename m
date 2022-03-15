Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB14DA0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbiCORHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350433AbiCORHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:07:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAE580FF;
        Tue, 15 Mar 2022 10:05:58 -0700 (PDT)
Date:   Tue, 15 Mar 2022 17:05:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647363956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBKZ1Hf83nK/+77JdjxTSDellD10GuwSsSeLQmiq5dM=;
        b=IKPErZK47AnYZKRm4gb1ndr8GtTAq9YfXYu84T7xY48jUKm+I35Y/NAtpUFgYpIZ1eeNPo
        hbbMhmVZjSKxw6BNtthQij3TWzXe0Cvhq4mlfFwaZn/PD8hHokKWb/kdnXyS8MCOkT4zBv
        g9bz4MbjIzEx5slx5WKntW29syTseI/jIfCvkOyU+YWkQKKVuMW86xI0/hD+MwJKVFucRQ
        gFVmZHr4XS5fi7rI89OaM6HxfWaa+zXmN931Aah5Tvz4oVm27YDAdK7r8gY4+FjAyLvO5g
        HyeCLrJYrsJKDLtwxatfVsTSCpbZt5ze3RM6IQtWWQ+49jIJZPBBDZmZoQArjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647363956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBKZ1Hf83nK/+77JdjxTSDellD10GuwSsSeLQmiq5dM=;
        b=spY+lOpjDxRcVI3FbIskMtc0GjME/NDeLsWmATzKOcq7ISkiDtf+s2uN33hhv9XD1ocjYR
        OTgxhf299lOLPAAA==
From:   "tip-bot2 for Srivatsa S. Bhat (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Add Zack as maintainer of vmmouse driver
Cc:     "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Borislav Petkov <bp@suse.de>, Zack Rusin <zackr@vmware.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <164574146977.654750.10918397477833459687.stgit@csail.mit.edu>
References: <164574146977.654750.10918397477833459687.stgit@csail.mit.edu>
MIME-Version: 1.0
Message-ID: <164736395551.16921.7583674215670127206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d69079d04f9319bfd4e90b788f19927142c55901
Gitweb:        https://git.kernel.org/tip/d69079d04f9319bfd4e90b788f19927142c55901
Author:        Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
AuthorDate:    Thu, 24 Feb 2022 14:24:36 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Mar 2022 17:45:21 +01:00

MAINTAINERS: Add Zack as maintainer of vmmouse driver

Zack Rusin will be taking over the maintainership of the VMware
vmmouse driver. Update the MAINTAINERS file to reflect this change.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Zack Rusin <zackr@vmware.com>
Link: https://lore.kernel.org/r/164574146977.654750.10918397477833459687.stgit@csail.mit.edu
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f81c3d..630ac98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20628,6 +20628,7 @@ S:	Maintained
 F:	drivers/misc/vmw_vmci/
 
 VMWARE VMMOUSE SUBDRIVER
+M:	Zack Rusin <zackr@vmware.com>
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	linux-input@vger.kernel.org
