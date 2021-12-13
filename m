Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37B94738C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbhLMXpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:45:11 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:35214
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244263AbhLMXpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439110; bh=lac83L4e5zt6gbRTXcOVn+b4xFE7sEfnnV3rmYMW6GY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=t3vjygkBO83qOZpQOqDn9rfbHPvogXTSBAeCivzktk+EPdrVrhMbzgtehb6RPiwbitHXnQKge68Y5K6bposXDzhieRAKo1a4Xci4rd0ZEyz+MGWxmkQvaw00v4dXMGjb6l7YLkUAzEWHiQjypDlEZj3YVhN68OwFselFZku8kRPsCoYOyKKWlruAIHnTv5/l29rLrLdj2T5JhfcztBQFjrzY7plSenKqQT0RiH+q5MvnT8alwQIkRQi6HxklSyFJfeCIIiuCzAfbl1qDcgSiL+d2sdkYqLlo0zFFnlsDfN1DBpTmhMppabyDBcRo6YMoBXU6FFatwMz725GI4IM1uw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439110; bh=7BIx518cae4jJh3aizKr+Z/QINb1rswR6Rz3v3nCBdZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=O4Z3LWDaoIPrkzrd9hgicmjPuO6pQ25kZeYYxG4eIfPv6dgnLvv2Fv7W5rxMyhXVGU2yhQgFNAKWxc4RX1TXBM++wF+NfnAA8cb8Zl8APo9WW9DwdR3iGBlq8nNDCeS1GWMIjNg3CvXCw/gDUf2BFeg8fDPECP/wDPSvRgxrs5OHQ16J8LhRP4MX0YDMv1qxsoBEYUzDQw20Z+tu8UM9t1n2FzyJK4FADub1hBLzIUcmnDZM0UddAZnBx87Q6giiuXxzDK14BXIpJYPYbg2HVADQYtNgBEGulx18ks8BTCV+saKuYMhZctEhm0hVONeFKawttHf8kcRVAHSXiMzrwg==
X-YMail-OSG: 0zykDv8VM1lXIynS86MfrNtvjtiPjfIVb4nELgQ0wnrTgDK58zStCJAqqtCSUQI
 kqFQfW9.nvanQpNykqkS3bd30T5eVaKTBycuA6W4sGgn1rT8ISldk9TvooN1TWLWGBcaHlJE.WZP
 ffQ2KgYFrXhiiRrTRD3TPVXUhnuE5HJ920XEkiLvJiHEFah6EXpil4wt0ACQcQELZCUidIeSMxpp
 VSlYl.ZRveSZgrbOYIdIbIoEWXdBOT2xZRZCdAybnWq.Vj0JrGngnsTr3hHaOL1nYwJkNCBCL_E3
 fq3_4qwZ0hC1ARD1RLwqhxpSQmeSqTqD56rDjSfPavQn1hk_XA_0eybHKSIvyA8gw.H0Kzq6Bwd3
 iJtSPEmpZ5fNnZdzAReG3IFbJ6TFUIQiGbrPXsVhXi2GdNs4U.GWCDzjGiQPHmEY5cc55kHubVBu
 yjAZDR4hfPijhhZG97xSH5OMkyzvt_EmQJMMR3R7wqGo9FzUFmQFhmo7W.TKvzOY52Q.o3EMx6gP
 4fedltXWLLCBbKTihdElDXMnz.MdcY8ynwH50FZ6zEbfUO_LK3lfvV816OgpILx0gE7ZM5Ilehjo
 yXGyGUeLFdrSYnpnIwL57B2hTHWtCc0VzKASzS1BY_KfhJHoTVEp_LZhKIfEUZMaP3GKsBXWDRvO
 vSv7ti6mmoHygXIi930pUumqlENSkRI8Lzem6_DW5eYwMc0RvWGchxD.MIR9POTDEwaBTqS8Uc6n
 tGDQoj1nSsVi9_OV1NFMTQrfxj_L9WO3ncMWWXdgMVjvfzXVMNL0_BZrvgsgwPzhppd0n1nV0g2Z
 a_tXEFWrPjTOpRBnk3JXBIfDJQpvYCJIsGzpAXemE4i2wsQC1y5Vk6aMu.RmzbWQrPudkpE9Ru7H
 nfa7gx9JbY2cGr_G.JhNJH.QiYfQL8lyjItv5OfJG.3i5GM9UxLwpLYRmgi4Tgt0IYNS1XPOpmTb
 .otMv682JcLzDU7ceWGW41bsjjEna.byNPU.5h4bZgwW5Y9tz.8w7RV_Xq5FCISztW4JaqGMTITm
 dtheDUZvzfGXQMZb6_n5aLQQYASWXFxqJLozO8NcNIs8YmzNm7kPf6EAbdbwflj3ThqmuTBijlJl
 2_skF8lPGar93sNHRgUJlA8KdiiVkeVjFnLQFzlrKhbaQ4qEMab3Dbcq3HMDWqUOe7b4oOprNopL
 Kqr_r4fnNZ4Kwu0r8puIfe0dMCqAZFx3XG8sFR5qpPmHm4dO7Ig0NtgIik_fsFKYRLBPD3VLMHYC
 m4PAOIkigg0mm_s1Skf1knTBYkhXumTqeEC7XC.PbaUPwdDWs64JNVkFki15r9XbFO8BzM7CGbPd
 DwUL36s8Lmvr9m7ouXkQy49pyCUaT1a0Y4cQH95gbGucsYS752kPtTufh5JKyO4lEXYxGCEn9fNV
 hmXasiiWjZDgxUp5cahpAmf8T7jSqJYP_TbW5zOg1y9novRzbS6bwbchEwhI2dkXv47qeWqGX1uC
 f6IT2MFs4rYXU5IbarSMbxXlNHu.b2wqLIUAFN9mgJYqEHC_btBSs968MXujC94HYQo5EGAipvms
 IpP6J5.y0XJk9HpLo_govRmkjs0kWPNJM7zSL_EbG1vQ2._tHX_H9nX8lv613NHHVLcDZ6q4ZWSG
 eSKbQAR7bVb_Lm_YD4_t9V1inL8MVds6FvjhKKNP_dV1b3umDKGNNnG4MUJHyx6KqlGEtWXrXyZV
 uU9p6mXK38oa1jmIhVRksIOKa6wfSDMgpyYflqWoVOZexk54cg0CL5Ov_PYl6n5Fje8QSscrb3Ti
 bTJ9IxIddabwxrF546mqvYyf2bOKomyuyr7SoPHxTXbrQ8y6GzW5HJBddfzwmnvZIAUIgRXLHlkk
 XCHC3r8L453mRlLZsc6DahqHLd7eSlOyqdgXVNIwejF2COx7woGIfoq3fxoXhLvj6DZrCD37nMPY
 G1m0yUHDyB5aZGaXRjZ3PvkPsZfOXuQmpCzAcSzt_uB3XUQM22xxn1ibk8.J5IHjdOkPH8WKiF4v
 VwooCiLdtuemerKsmjWc.LC0Dal.ctXvKKkufQb5qTMigFtzZwK.URTPcdX0ZCTioWOOy1l_p_0_
 Vptt10A1GmrpwmaBdW.FAyJ4QGJC7u2wbjbKNol6Vg4sWwtFozl85MSWZbdEg9mUNep0fiJQQe_n
 vjJFDIlZlffsI.3oyzDc5j1ULc6_kIlp.OS5.DPFr2Xv8dAwSQEL1y4Gb31APozZWzSva89oKPKV
 3XbhH5aVrwk3ltC4bYU5EbYTdB5EWb7c-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:45:10 +0000
Received: by kubenode545.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 83eeef32ece3304efb45e12e25148509;
          Mon, 13 Dec 2021 23:45:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 04/28] LSM: provide lsm name and id slot mappings
Date:   Mon, 13 Dec 2021 15:40:10 -0800
Message-Id: <20211213234034.111891-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide interfaces to map LSM slot numbers and LSM names.
Update the LSM registration code to save this information.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  4 ++++
 security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 96afea94938f..1bc00edd3a32 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -194,6 +194,10 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 	return !memcmp(bloba, blobb, sizeof(*bloba));
 }
 
+/* Map lsm names to blob slot numbers */
+extern int lsm_name_to_slot(char *name);
+extern const char *lsm_slot_to_name(int slot);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index f5acb607e251..9f3a467fb992 100644
--- a/security/security.c
+++ b/security/security.c
@@ -477,6 +477,50 @@ static int lsm_append(const char *new, char **result)
  * Current index to use while initializing the lsmblob secid list.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
+
+/**
+ * lsm_name_to_slot - Report the slot number for a security module
+ * @name: name of the security module
+ *
+ * Look up the slot number for the named security module.
+ * Returns the slot number or LSMBLOB_INVALID if @name is not
+ * a registered security module name.
+ */
+int lsm_name_to_slot(char *name)
+{
+	int i;
+
+	for (i = 0; i < lsm_slot; i++)
+		if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
+			return i;
+
+	return LSMBLOB_INVALID;
+}
+
+/**
+ * lsm_slot_to_name - Get the name of the security module in a slot
+ * @slot: index into the interface LSM slot list.
+ *
+ * Provide the name of the security module associated with
+ * a interface LSM slot.
+ *
+ * If @slot is LSMBLOB_INVALID return the value
+ * for slot 0 if it has been set, otherwise NULL.
+ *
+ * Returns a pointer to the name string or NULL.
+ */
+const char *lsm_slot_to_name(int slot)
+{
+	if (slot == LSMBLOB_INVALID)
+		slot = 0;
+	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
+		return NULL;
+
+	if (lsm_slotlist[slot] == NULL)
+		return NULL;
+	return lsm_slotlist[slot]->lsm;
+}
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -498,6 +542,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.31.1

