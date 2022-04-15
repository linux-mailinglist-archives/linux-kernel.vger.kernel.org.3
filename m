Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F065031AE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354105AbiDOVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354306AbiDOVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:22:34 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AA44776
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057596; bh=3RLBS8CrIdzx+91VdCCgk3y7gT/slr8sqP+FVnzX5L4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EFRU9mxjoxy4QDQcmvzwEfSyGTzxiV1r/eDtytyPMIuvKMHFivmo03KM4yU+AHHWkJv3HfubHqGcZGjfrSX74WIcTYAPr22dJdsmZFyOHpLksg+71nHT89JbCHnkVOO/QwHTe0/1/tdno6GfeZXHgI6spXNcbCN2ECnkGo9BmxCW7bFiVauvCiV1Wih4vpybXk4F5MiWr8xbCjvwnqUV/r4ih4jIg9sV6W/bm+m746tweFforPJX7wUaQTI027NzMSBeKjhXy/5LRiun2dXHWvT1TQFUvhINUgq//StsGOB3mPYbwXMdBpWEZEcVyMDpcqWb874idXge+Iz5z/AbSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057596; bh=0NbuN59THT+1YSTMA+4qih5PHoetooK0yycoTT37ffO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fnXdSuUzKnLt5ePyVWh5UjVpbNt4DgdSB3ZZ6xpr1vVs/NdFC10jh3rDJe6BnRY8sk1cBKNU2wfxC+C5peovtniSPv6BFzJ3hlebxBxOFM/ckjCsImZKMhKqkIIKRzuudOL+nfC2Pp0HMCGI+PF3O0X4qz+AXTBUh1j57q5SBMREJWnjd9df9SpGIrgkQXYJ1WSLqBmUyZeHYhZ0+9D3Rr9dhtsBn2VzKtjfaBnsJdKTZa/LMKoKfr8BKDN9mAqqSQ/BbBXkzS+aBANJNQaofgs7oCuPR3i9CC51SM5lVaqSSMeT0d0m9XRZ7IRmGzXJ51qbwJfKjKIJkIOOCb2Yrg==
X-YMail-OSG: hqw_9PUVM1nRfELlkp9h0qfBKXKBz9ZHLnK1YF3kCmEQ82LD.x_CdlIYd_lUIK.
 ssPMq_vFDKlACBRrKcTfVssnimd.rcAlstPqOAhKSssLaFtfuQ_wCMLPWX537pnageLJ8JH_Pqt3
 X2Uqjr3ASGUGMdTIeW5TZJrxcBsIvsMFerI93dv6LxXNtvRsortlPtONkqUPlP6JY0TwlCScl509
 9br3rcNl6j8y4g0LofQyFPwtpgt1.967OOVhYO78dXQXe4eqJX95zFaLtTYDYvL4k3FM0SHqvWfR
 9tzvdrMn9fD4RRdcPOwpr0Z9zkFaO2UGtJfXIhaUhm.Ldx4jziF5UhOBjKi_emm7xGMWs0N.eTEX
 CCXD4qUjQq3zE8ZVLWywR_4wg9QUW8p.gSbyuqLTV8wZhhMPKj5KFGjDNmqGbFDcy42Et5yRSW_n
 6XBLZbVIGf3p16cw_CjVHA4zYdt0iXWBEPFEcor7Y5ImbQc2TlH9Rr9AWaU8eXbToWI9y1MS.W_n
 BB6PqXpE4nbRsHD6shJNl6hn5cP0rX_w5ZqCSEQx0ZXGdXba4XP2A2o7xlQcRkF1nWCJpf97NY8D
 k3w6zw_YSyoL3egraW3stuhP0BIUbz9PL6CFyiugh1cTNi74J3MmG0JNoYsjv__QraNkvV7mBJfM
 V3HBVx80jiMDo6QNilO.bHgKJh22xHi93NnzOFCWT5LE_uA0O0tab45w7GHuRCXuRguwgbqc85Ls
 CKSbW0ZPs8lQhAaWGA4eNjRSz19wzBdY65X_K1UJ.pv9IFwCbLtMiuSP_6vqwa8ohchywjgUVn5c
 MsqVNJ.j5PrbT6v8a3wIdkx0DSISEKpZh3NOaXU6NiAHhVrWtj871_q_1nhG_gGxEzDqJ7qAFkHa
 TJU36WWM9c5ICJ.EI1mxUvkmz__m6EaNLQeik1BT9a7fc_PXiuZCC9_M6c56dgiuuwV4VqZQ9Qxa
 E5nWrdLq2KmdtFl_QsU_96z4gYt3xm2R8Xj7eXvraJZqJW.FT6Xzlc5NQlX0R0K43VpnA2VyCC3I
 9fOdhgNfn7E_8q.3G0whwse9tnCdq6frxut_QG_GNeGJWUladUmh_lEschN3VSzHKuU29dyIcMxH
 Tq6AiBYDYg2zMy2NmQLsJEHcOhdaMEI515eGc7dogNKlB5O1idREHCvDi5BfV_XNIb9BCVq2AGlR
 WvDiNmGAhqnrMB_IUYIMKU44lXLVJWS52nRxUGjiJzvLaLGVyhFY0chWSHZ4vtpEPDO.gChWRLKk
 EcXzt3mQ1p0WnT31Do885FxD5rE5xBwBF30U6xyhAufe4h30gDiB_MzscQRE6MswXy7dr0NZ6jQU
 t9BMQA8AUW42Q5tT8zhZrJpJEvOC.dXOiyxcjZtf6EYyY4ss.wAe1NL7MS.brMbTjSrXn0sLF_EU
 inHzRiV.oZKv0AZDcrB7ueoOp4cgPqFYIZDy2XjmkzxBapY4JLFrLY6Sf6HYYSBddfIzLFCXAsAc
 e1Qxkz2BlSVOlXNY1eWt.ZzFJ.Wl3iV6VyNM7AHMrks.AhW4zmyEI_aAravcG7Ss_3VlSpSV2z_9
 ST3cYKAwjiRoj8uTLx3oIBleBiOeW0kCGiF82ZK8muxVaPfWvGn1W3LXBxakCVcGv4Uy1eLd9DL5
 TWPFUSy.nWkQZV4gAJKk6ZUhcOuvsQgHAGSVrmNgqyhfvSLHFuR36uC_n8xEVyHlZYh7jMHWYRmV
 fLaw7xJVFyBhK.8dJI1YRlSKA1Md17Zix2bmc24XzuC6NMCIz7zpbLdaXxGoC9rvlV1RpgQ5NGCC
 HAgnVFGsyztEZFOWvwv9k.WLMdCzlRRWeQ7.jzjPvRF4_6x2YdtjVoNZ8K7IHNwn3Yu.oghmsR1F
 RCyYO.m8L88aiStPZFT5iD6W0f3N8y4SMQC8Fxrv.uxULRkEEKE.LD1jRk3wz8slQuXijiDKdoA_
 LvhqPyVWltYsw9v9t2U7mf0TqK4R62TitcGGrq1Fmr8KMf4atNub2wQUMFQCwQqBgQs9dhCXTM9I
 ucdoCzNSp.Rn3.WE8iWei5PnvtZ0kncDiNb18RHDfqs6Kb2jDAoq2rWmBJGfsV.Ih4EaCE12NlQG
 MiQMVJvmKEcdaWQl8pbM_Cg3LliAFfsy8.CKkx76eVsP62vEwzCUicZ_OqchWcLw8mr88uOc_phb
 zzh04grUDxI5l6pdG3159oSJhr_DHAuoHP_Xw1LhCSuqC6htEWdxJDNXyN47AEFQc1AKKvv4pgeE
 Qnj5QUWAj5eYtTkxzW_WpzGVfsAVq5eNUCJMZw5xYgCKN2SK_SORA6EKqnQbWitu3mdS.
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:19:56 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-hf9hx (VZM Hermes SMTP Server) with ESMTPA ID e160565289e8323acb3cde95677cb354;
          Fri, 15 Apr 2022 21:19:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 04/29] LSM: provide lsm name and id slot mappings
Date:   Fri, 15 Apr 2022 14:17:36 -0700
Message-Id: <20220415211801.12667-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index e5f3eb9618e6..5400f68134e5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -195,6 +195,10 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
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
index 49fa61028da2..d1ddbb857af1 100644
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
2.35.1

