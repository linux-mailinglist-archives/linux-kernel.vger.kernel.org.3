Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85E4BDE29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358823AbiBUNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:16:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiBUNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:16:17 -0500
Received: from sa-prd-fep-047.btinternet.com (mailomta7-sa.btinternet.com [213.120.69.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E61EEDA;
        Mon, 21 Feb 2022 05:15:50 -0800 (PST)
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20220221131548.JVDQ16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Mon, 21 Feb 2022 13:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645449348; 
        bh=LsQkjPur9s6lfrXPc17vF8122/BSlTkt2PIKZJf+o9A=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=E/JiDTHJaU2tWpXNIE/w6ZYw+VbzX56ruXbhRtOawrnuUhF1pflk9lBlTNrd8ZCu7FTtFIg0WudeHkwjW0+HNnEXAgfm8iTv5WE8w9xM/P65HAysS5YZ0lCdAyD29aANmtAbMR5ax7E8zzKPM5nYI81DsY6f/cdyOFXJ7A7ykKl4x8wkfJyTL1B9VqxuDp4kMy7+GBC3WmtHS1hgsf566gEy2xW1zDOR+SpL5aRdAhq8uSb4XTOMjYsV9A9EGoCkQqDRQqJ4NEs9sLsMRexek8lY/NiTljeB4MpPFc7lzdWlOtxHdhWpX6LkVlKHsylicq0YV8ZonE+j33mGfdFang==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139429016674C65
X-Originating-IP: [86.184.61.59]
X-OWM-Source-IP: 86.184.61.59 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepheffledtuefffeffvddtgeevffetffekveeggeduhfeghedtvddvhedtkefggeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhigidrshgvtghurhhithihnecukfhppeekiedrudekgedriedurdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdeiuddrheelpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghprghrihhssehprghrihhsphhlrggtvgdrohhrghdprhgtphhtthhopehjvghffhhvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
        phhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigqdhrvghfphholhhitgihsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.61.59) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139429016674C65; Mon, 21 Feb 2022 13:15:48 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, demiobenour@gmail.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org, jeffv@google.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
Date:   Mon, 21 Feb 2022 13:15:33 +0000
Message-Id: <20220221131533.74238-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
always allows too.  Furthermore, a failed FIOCLEX could result in a file
descriptor being leaked to a process that should not have access to it.

As this patch removes access controls, a policy capability needs to be
enabled in policy to always allow these ioctls.

Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change: Control via a policy capability. See this thread for discussion:
https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t

With this patch and the polcap enabled, the selinux-testsuite will fail:
ioctl/test at line 47 - Will need a fix.

 security/selinux/hooks.c                   | 7 +++++++
 security/selinux/include/policycap.h       | 1 +
 security/selinux/include/policycap_names.h | 3 ++-
 security/selinux/include/security.h        | 7 +++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4f..030c41652 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 					    CAP_OPT_NONE, true);
 		break;
 
+	case FIOCLEX:
+	case FIONCLEX:
+		/* Must always succeed if polcap set, else default: */
+		if (selinux_policycap_ioctl_skip_cloexec())
+			break;
+		fallthrough;
+
 	/* default case assumes that the command will go
 	 * to the file's ioctl() function.
 	 */
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 2ec038efb..44d73dc32 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -11,6 +11,7 @@ enum {
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_IOCTL_CLOEXEC,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index b89289f09..ebd64afe1 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"always_check_network",
 	"cgroup_seclabel",
 	"nnp_nosuid_transition",
-	"genfs_seclabel_symlinks"
+	"genfs_seclabel_symlinks",
+	"ioctl_skip_cloexec"
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ac0ece013..8a789c22b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -219,6 +219,13 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
 }
 
+static inline bool selinux_policycap_ioctl_skip_cloexec(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_IOCTL_CLOEXEC]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.35.1

