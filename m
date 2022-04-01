Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3644EFAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351791AbiDAUQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiDAUQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75A2560FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F4161800
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3901BC340EC;
        Fri,  1 Apr 2022 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648844064;
        bh=P8DlEnw33zBpitlgH8xwxIkpEbNasZsEeanZCbjhjtA=;
        h=From:To:Cc:Subject:Date:From;
        b=HO5L5PtRrU5/tc+G0RnuMcXonjj7DtCw4Ro3/SvoNPUXww5vNuWc5SxWFZhBKZQ6+
         846CADk4UrrLizfdUub8e/vR7oFp9xFCTFDWPVR5QRkJTnk2O5pAMKtfntPxn5ApdV
         RvPPBEWP3OaCXlE00j3c6qVaSFSTRlumhAUh8VFgx5onUF/PmS0JTfZVVN+oaEbXZn
         KkZeS/YM69WlY5V/h7BQQm7wLCcuN85TECUXc2Rv0F/LVxgI5bwrWmZlG0cJC+R30h
         ObVv9f+TwPI7uUgF6ZwfVIrpbbKqxTpMnto9tFzWo2/8aiWoElXFOQ5r8YKwhK06FI
         8nGJErME0sQsA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Date:   Fri,  1 Apr 2022 15:14:17 -0500
Message-Id: <20220401201417.126664-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
as lore.kernel.org because they use different styles, add advertising, and
may disappear in the future.  The lore archives are more consistent and
more likely to stick around, so prefer https://lore.kernel.org URLs when
they exist.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

Thanks to Joe for fixing the quoting:
https://lore.kernel.org/all/3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com/
Sorry I totally dropped the ball -- I guess I was scared off by fixing the
perl quoting and didn't notice that you actually did it for me ;)

Sample commits for testing with "checkpatch -g":

  bd82d4bd2188 www.spinics.net/lists/arm-kernel/msg716956.html
  fdec2a9ef853 www.spinics.net/lists/kvm-arm
  1cdca16c043a www.spinics.net/lists/linux-mmc
  48ea02184a9d www.spinics.net/lists/linux-pci
  f32ae8a5f131 www.spinics.net/lists/netdev
  b7dca6dd1e59 lkml.org
  265df32eae58 lkml.org/lkml/
  4a9ceb7dbadf marc.info/?l=linux-kernel&m=155656897409107&w=2.
  c03914b7aa31 marc.info/?l=linux-mm
  f108c887d089 marc.info/?l=linux-netdev
  7424edbb5590 marc.info/?t=156200975600004&r=1&w=2
  dabac6e460ce https://marc.info/?l=linux-rdma&m=152296522708522&w=2
  b02f6a2ef0a1 www.mail-archive.com/linux-kernel@vger.kernel.org
  5e91bf5ce9b8 lists.infradead.org/pipermail/linux-snps-arc/2019-May
  3cde818cd02b mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
  a5448fdc469d http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..819e0dece5e9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -698,6 +698,17 @@ sub find_standard_signature {
 	return "";
 }
 
+our $obsolete_archives = qr{(?xi:
+	\Qfreedesktop.org/archives/dri-devel\E |
+	\Qlists.infradead.org\E |
+	\Qlkml.org\E |
+	\Qmail-archive.com\E |
+	\Qmailman.alsa-project.org/pipermail\E |
+	\Qmarc.info\E |
+	\Qozlabs.org/pipermail\E |
+	\Qspinics.net\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -3273,6 +3284,12 @@ sub process {
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
+# Check for mailing list archives other than lore.kernel.org
+		if ($rawline =~ m{\b$obsolete_archives}) {
+			WARN("PREFER_LORE_ARCHIVE",
+			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.25.1

