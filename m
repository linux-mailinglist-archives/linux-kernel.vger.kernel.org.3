Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC12E4C4CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiBYRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBYRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:55:27 -0500
Received: from re-prd-fep-043.btinternet.com (mailomta8-re.btinternet.com [213.120.69.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241661EDA2D;
        Fri, 25 Feb 2022 09:54:52 -0800 (PST)
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20220225175451.URVU390.re-prd-fep-043.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 25 Feb 2022 17:54:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645811691; 
        bh=39nmR0dbbIAChSn6/FB5eq6Ny9952x+7sRkKsOS0TK8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=C2ioAWuYtUSD7VxUoI2WnqpxCdBK2rQ/jtM6DqIdbQLnuxyxs/Jvg+MsckKYTjc+G/cCy43R3Qgky9/R8+YY40dOItlJELwKtFNWnHKWiLySRFOIhI1909O+b8iTsoAsAYpgkcb5Tj9VbopbDQb5cRJXBwJMA+Yvl4YVWLOiHDhkgs4CQTFQ6IMfcshMVhlfg2SyXLf0N77HjKTBg0DZNSfuxS7b4MfXdGVzmIi4LJG9zFeHBEIm8SxK86nY3MJPy1fz38VJ8CoCbOAoC06DKvLiSBExiblZgPpcmSLNRr1Dh9eeaEW58+7ItdSeFNaS5cD+DidxCdTCJuM/ZgQnQQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8CC316349824
X-Originating-IP: [217.43.180.152]
X-OWM-Source-IP: 217.43.180.152 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrleeggddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepvddujedrgeefrddukedtrdduhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudejrdegfedrudektddrudehvddpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepuggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopegvphgrrhhishesphgrrhhishhplhgrtggvrdhorhhgpdhrtghpthhtohepjhgvfhhfvhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgt
        phhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugidqrhgvfhhpohhlihgthiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (217.43.180.152) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8CC316349824; Fri, 25 Feb 2022 17:54:51 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, demiobenour@gmail.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org, jeffv@google.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V4] security/selinux: Always allow FIOCLEX and FIONCLEX
Date:   Fri, 25 Feb 2022 17:54:38 +0000
Message-Id: <20220225175438.302365-1-richard_c_haines@btinternet.com>
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
V2 Change: Control via a policy capability.
V3 Change: Update switch check.
V4 Change: Use POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC

 security/selinux/hooks.c                   | 6 ++++++
 security/selinux/include/policycap.h       | 1 +
 security/selinux/include/policycap_names.h | 3 ++-
 security/selinux/include/security.h        | 7 +++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4f..d369c2d82 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3745,6 +3745,12 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 					    CAP_OPT_NONE, true);
 		break;
 
+	case FIOCLEX:
+	case FIONCLEX:
+		if (!selinux_policycap_ioctl_skip_cloexec())
+			error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
+		break;
+
 	/* default case assumes that the command will go
 	 * to the file's ioctl() function.
 	 */
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 2ec038efb..a9e572ca4 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -11,6 +11,7 @@ enum {
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
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
index ac0ece013..c0d966020 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -219,6 +219,13 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
 }
 
+static inline bool selinux_policycap_ioctl_skip_cloexec(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.35.1

