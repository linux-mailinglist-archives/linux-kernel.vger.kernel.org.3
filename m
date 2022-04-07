Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFC4F8932
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiDGV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiDGV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:26:25 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB3195306
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366663; bh=3RLBS8CrIdzx+91VdCCgk3y7gT/slr8sqP+FVnzX5L4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oxWhiKnjxPopCIRcY1RkneJHoKwIgdDcFb+Oe8mEmagzoQRHAmFo6Wug3jq1nt9B7LSD/ulgvqRufkb9PdxMZiWTEH+HGiiH4JFCqPT/wElJ66gQ9dAzPtXdggVHDJPOLTeA82/w6mQVbKiPtv1sZS+iANIwdyNR6XbLMYz5ihFuChKqnVmPZLxr7/j8g9iDpJfs2gCPahdV5H5nYS7nl0iJ9bnbIB1RQIbHjSFsN52nx3FyKMOqa2JQQlI3GfC1zEXibyaktS1zUyx9THpsiiH2duwt4Fl4W0Dukn3GIPlFVj9bcfZ+UpWwAhUFynX0p4e6PO2Mxk8qXKzqB5D2vw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366663; bh=YlPjpIpl6mUa/bOVouZXvx1+EIqITZb1LkD9pmJeMH0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Cz2FxCSkhx7NhKAU1NKf62+yTVocwEHSAJx6v9GQDVen1PmXNa12XlvHoEtbvknMGT0j5m2viBrNxyk3U2I3EL/6E1DhDVbEpc3PDGL0HLBw86XNafwtVNPbmmuKjSl77PA/uTG5I0X8aCJd6B9nlJ1opwwXg3ezauSNoDLPOFffN7d5RvPLhdPPkNDTn0JYYikA+hAZBF1kEgt69mgNWfsiRCprcSLhvmwBooZ7SzNfwWsgYEQFr6W+qzZ2mKYBpyfbJSd33tNalg2YrPyxzn4dWT7gCFnGwV3F2DMu1BMFaYVjWv2U0TEwz9A+4V77a4qMZO5pE6EHlJAKd4Malg==
X-YMail-OSG: tdzIIacVM1ko8kHIsxjRxT33xlzsNysqNJdXFlqrXSfmpvL1Ax7VGB9A9eEI6KL
 _jjanxhay70fPPqoZa6h923oYnUvC..PCe.0mIGTDH.8cUowkeCDc6RS.mH8rXg0TTqLd._cDGgN
 bwpn_mYjr_8uKFBAj7dk2rxyWppMfzpNoHFSMkZUXMYhy62yX_c28OYWjYnRvzyag.YylAWZKMdA
 hEsInkZYpRW9COVmLXrQJwtdVZ8V7Z5iAvxWgQLiTD4OTaUJpBXRKYJLZrszl6r7pZlmz0KG4pwA
 WvnC7RDC38daEMwjVSxy0s9K.d9wu69EFZIjE5YU2d6PyTxZ228LEFcNJ_3I1G7e4.nsGKfYktvv
 M5krdXmQc8fsTgKjf55AyFEQRKdD3X.hOoS.OYlQ9Os1R.3YTbcz62njog1QPzWXOVNm3KC8diBS
 R_nzWKT4o3ubeddLzHOA5ptyvwEfU7Dewj_4e2LDyaNkx4n_IHh4HMCY8Kwsh_t4eeNqZs97nWvF
 vbs23j5FOa4BN.vPvOcsRHkag.HNvrtDfldURivcLB0Q24U5BETze9qq2fllTRB47zYRP2ME.R3x
 ywILjbvfjnwG1uSsCTKM_3SebDhWJveSdMorispK5o1ldecgFOWLVaUlVZtGo2zhiOH.jkZo_aVs
 QpjmfmQScQdWKgfECNYrAJDaRjoxozGXglik39SepfCHF20taSziTb9_X5Ksq6WoQg7D9bW_wImv
 MDjF8z8Iaz0n.IX6Q40Q5Jx7JYsktsbovG42hNJBsQJcb86F96tp35Qn4kyGJhk_2P6kcpkOLwyv
 hYW_5lzJL_xEZkXjPdCocpWjijU3zD8.64APKJWSeQ9iNagqIr4caW.QehB_QwFWwagHiLFG_S6f
 MEvYxB3cexDA5UGyDJIndwNZBC.6Mjgv64YuXBHQ0PRzj8yWjFs2P05QN2I0ywDierl_wOGljQPi
 nXq8wA4AXRJSON10SBbBGvp_JHF6oBem.8Cu9HETJDEQqTOlPhh4omupDD1oz0BJNdsll8SHGVmX
 Eq5kh.cF_5qSX8agjS5FPUl81CEOy1WDutu23mMrDPCLVtzc6bcobJNaS00yfhJCr_T31P1TDnse
 i7vrKZ.OLFkVGceuCREPOn7cJ2GjdEbsiFTK47rOlV5OsTH870nuyYt7MSW0omfT4XWMTV7T0DZ4
 Mbqfj9ZMKyfqRlqS5MBhpKeTZP9equpuW1qWySPRcTBIg5exSftqsr4jkGe7ABq5VdHj8nVbCWd4
 6U8mfUfgpQIqB4brOf0ZdeCaQhpYgto7ikw2liRic2WLpHKM7CqUrf.zcNchnt85_NfqPssILLG7
 fjWN90dNiln43wkiZSg5_9ajcc2R89DfqKTNdi19Mq3aAJNvqvLpAgxmiGlnDI.bhmTAFzsMKmMM
 jXx1_R5teHIXCnHfgsHd4arOAih5b5xeS4OJ9V_AutqgPM78C88Qcesbh54hyXim4S6pbzSbxO2K
 07.fRGt6Zxfw6dmiEO5sXnZGyomokgZfE481UjqJonHQAhu34l0V20i3wGjXMvouhRXpNZXuyr8o
 iLNbDuGoxyP5J73LIvCYnspfRyTp9goCiIHkVjv9m4tB_xNFQ0sr1DzvQRcD3yjyUOnOMy8fNMAW
 jhj944gp86C4RXu7XLC3fnMDkL9obfJfDWrNMW0GbcaBlSgA_8htEwi8eAEEZrGM48yS_R234YsW
 4OccFSTkBkML8iSvl0TlUvSv0TshmCDZwPT43KrOoS_NdmJb.Ys9Z1tBNmHdFaWUdfrnuefSBv7E
 d2GkW2cQK8mpfh0NN_Pc6KykkYcJxKT9jRno9gl_WJdI7W96BQgiLAL9qMoZ5VhzKMpD88cYr9v2
 OD9UC0uCelswE7Fn7AAh78eGqzlisUBkasHzRq84JWw6EA93DsD4S0MIMbGuiyksk.V3PY8mQkYR
 c5m43_NYRMfg55QmDiyHgx_VPB.zfEpFfVuCnuzEbvC.BF45gQe2OrC.86gdaSjP69G7D5vYTiLF
 y8dn66u3X1MSxruTMvDuQL30WNWlqLcVSGpmWO.zDOxzvRU81rpHik5D0WwRF46fAMRowIbnfd94
 OlyJ007EPR1owLlYBRpVDdYI1iw5l1X.pU7.XxxvpbWFJvm_2q.Od4eoTkkiL7q0z2KnMPOSuyNi
 gfqVualVg8OkciAZ00Jkldmnmb4u4_2BKxQt5GtHlHxHMKIu70xVVZ.BcuB8Q0mebT69kzthTPSv
 B_fml1mgZ0TEk.DVHfSbC1O0MqGGM0y04MECjY22xO8PpS4xg9uxg
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:24:23 +0000
Received: by hermes--canary-production-bf1-665cdb9985-6hz22 (VZM Hermes SMTP Server) with ESMTPA ID 7b3eda77d72d772e8386b3c1f765a2b9;
          Thu, 07 Apr 2022 21:24:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 04/29] LSM: provide lsm name and id slot mappings
Date:   Thu,  7 Apr 2022 14:22:05 -0700
Message-Id: <20220407212230.12893-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

