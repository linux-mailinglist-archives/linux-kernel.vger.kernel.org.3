Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD265457E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbiFIXFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345864AbiFIXFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:05:21 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D13BD4E1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815915; bh=ox6KyoFKwRBjYYeQWJxjGB0eFti3a4PteTAVNJk7fGc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NsAnW3PWWsiT8slC03QcSRIOoDUNYO3mr6TvcV9Xuh4vXOhWn3iNs48YBBufAV2d79curifrlkodgfQCOqIJqBn/pChCXZR+y8kGi6EXMUHqyXpRFGusCOtPPcc/FxvtWu6jZPvuNVg0rigzND5SMbVWQrYoF0IZgHGIbGamOKCdUQHF4z8fTN8s5IH/rDi31UmbNujjVMUgtnEayMpY1DbGBU6K8BOtqA9LKhGiqBsE74wUc0T+vJUxQ1gLn2mpep377rAaGEUefLTocvabKnDpkyM71aC2tRUnINQdH9aQ77YPCXSnAoNibNO12ICJqwk/8n/Rqt4kb74v77h4DQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815915; bh=+SdvdcJtcdlQl5yGtm2buXBz25vDgp5UL6/Y1nOeQnU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=o2W8uufwVY5bSdKozMWQRHydFgvfmy9gPJBK1xbmR7sBGw/jMQcPfNG07vdDs5rYMMfRH2oSbi0J+1cYyMCf37s1Qj8GSBmGirsAsm/fdzIjH/eNwwXnOKbokVXDbaVDduf3eLmxDea2vLIKEXLeBlYVf9WITLld5rgwEPzGqk2T6JIDOvjjmm9KI3BRSyqCTKHd5QjqRWMkqf6+rpnQgtc2ewNizmBYaS+PRcVE4Y9kchqNK4qAVXEP9xBsHPD312j2sJEJPj2mIWq3aidfOy/v3AvRRTsV1GB4dL5356inUDYcJyA0ZKgbEQVzJlD/Qr1qpBS3hIF0eWMEXnswUQ==
X-YMail-OSG: 3CjVMmIVM1kZtMQdH8Hn9JtGGPUCHICOB3sORTBqhFXDJmKtV_hMihUBgJVHrTG
 f1vLJkE3o.vg5K.SYKdzEWcFxr76D4bdjWyLImRUzrHvnzOkb9Vl_MqkXZdi6oKnH3LFOl4Xxlv6
 pVCow76GF1AxOQyKtdfLvhMRXV_wRFcORzUPb4RK6PX5mdjv2hJV7qjtd_ck7szcs6OyNCrFPFbB
 LPJgpbHpeFTwdI114Sf4Kxw0PUblZgG4IXlPof92RGR5edNGoD9MeEXBqpONtrigVgp99y9x1i1M
 zzlBkEq0RDFCDlLEl8xUI6jBMrauFh.e.vaLaDFxBlQZtlrC9_.orGJdYYfZE.Fmh9NBmnmol3dY
 189C1DfLWx.7nf1mhThGBD2j.sKlm7t8oCBi3oirbG6qo0MXeaRZ7nvD9sjSShb.yB18JpoJW5Yw
 gGQr6imvuSV1G_ocEcf6tuGSurJ6.WHfbKpC_5t7QGXhUUbSGyAbcXOvTob97U3RhlVwrXb6t3MM
 uWxKHMy8vYbuE6iyhU9QNpX4ULi681TEU0aJINC3kOHbYQrz4iW9FLVqUaWkMqqt1OaRjPfiHah3
 qkMx9coLRRalAVv1Hf3K2QyVxdABirFge1v8fsa8xx7jdYOjdkiTC64np7FmnTP0XVPJ68CFWpOI
 0Q.COywTl6QAa1G6LmAGdnc5NuGkPWqI.Rj8phsH3FhEQzyMBVzaCBa1xW1e51S8mrEfxky42NWt
 bdmlk4VYODele0EiLjs8KPp1wftgFe3XJAH.Qrh8TQiMdQoJPOTibtadG6XlskK5wEFwE5OQFYK1
 TxWVgw1oL1a5puqIl4J.nArW4QZu_hViXkQHvekHtwFnCjzm5RFvKpoFF4xUdi9hmN8hvpp6nFxR
 10sMpimIFZd.pTCbC2ROu4KP0oV_CR_OAgzdFw4ju_9A6KJRkZTbbb3BpKlsneYQNmkiqaj_FFAY
 ids0gvsZKzuGRX7IuchK8fbAis_Cv71uEutB5FrglBusSHTxPMxJRzaMXYUWLAZmk7CE5AoDpp5C
 7q4LfcrjstpepqpPCLIvxiXK77tv6s3sRLkAAWUtnsLISmHOfacclq.MITSXPMR8StUb_4R7vC4c
 FOwQBH6MYXpdUKjKfEUTBgkwyFU61th0BUI3CY9cXgU02TRiv.ylv4Ps985fITMr_2wOjMed4TEi
 bv4Ja5CiXD0j6I4Qz72LkH6TLh0RcpEK6QkIlUXBEeQQujBvZS2hEJzkIa6bXH1Q2E1GrNRFTVPU
 hNIFA7wJ8p3cmqBXhNTihQuUFJJJZK_r6kr6CAO4Z87FY9akoo64cJIrSV_u3iPAo3sj3RRoEsCO
 yyB1tM8PFIRDpm.ZY5aNG31sEQenoDAMr.ift77vSyh7iRGrY.BNZ7AIu_iXStAxi8giiZEUr1NE
 5e7ERPw0FbZ8pEmwzXmwpHewdcWuDIhXWE4TtmVW48M_UzdZ0Ic4h.LTn_rG4LFHCWAbEnarMSz1
 U8BfKdApo1WQdooZG.psdy4xwlr_tXjtXyyqlokK9H2GPtVvnV0NI9YKEyH1smDx47WmBn1lfUif
 zjK77VZadtPOjbYmFYsEDFDGGLWtf1t9CoCJuUx2puH.f8LYjH6vRbX9YUkh3Oto3EYpBlr7EEMw
 b6bGkv_ShloTbn4MYwp8jGpg0kn1EgCL3HxvA2akUrVrlUI0qmtp3xfpNRD2YQLyAJEP4I4Y9XMw
 2a2HLzws88hHkQM.ZAtbtEUcXgXpqXmVHHENJXlvVwCeDbZzaHWrzSP6OtKrD9LR13zqnsmWJIcs
 zOGgwMOWsGPXizbHkrO49nN0kSm7UcgKHkDOydlyA_CeQfRq3JxCpMAWjakeD7qleGk7rLDwIwHo
 tCut0cijvX7KEn1nFh9_RN30VnhB6mKsffyyv3ZQ97ukekd_khBVGtnbx.WRKTpIRy6G2WR05DJJ
 sjCWWgvuLHe_YS7zi39q9ChPjSAavTOQDrlvx_ATOsYPADtttGpTQk_UKhBwpC5izsmzmakN8FZK
 MqFvp5R03BuUqCfixd4rpuT4XQ8C.uRNia4p1gs9rdK1JP.pbTlCLxFBn5PadFDXVt.R6x4.Msmf
 krG_gJvGdzSEpnrIdxfcseaRTXAs2mH5DLZuT7hyIZWe99RqstZeylwQB17NfygVKzQUk8kAV0uS
 bo6UDJsE6mvSn9.AOBweC90DdnfkDvpEonjkJykdzpu2My7NSP4hFfzpxKorzfGqrpimaN_65uhS
 Sv.bm96kV_n.tYIKbj4qUt651IqdfZ2_CGFwTXJGJTUq0EPfv4NDQZu_E0lqlN5eOeIKGgwUBikW
 mlkAD1Ibl.AcShssL2XZaC1tOw0UUdYFUa4Eb_EJAWmTOzHaSS.BiKPom
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:05:15 +0000
Received: by hermes--canary-production-bf1-856dbf94db-mq9q8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a994d58746f340bf5c8b571efdccf4f1;
          Thu, 09 Jun 2022 23:05:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 07/33] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu,  9 Jun 2022 16:01:20 -0700
Message-Id: <20220609230146.319210-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is updated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: David Howells <dhowells@redhat.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 9ed9232af934..610f70a99f60 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 95ba8c223e0c..823880ba613e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -465,7 +465,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1107,7 +1107,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index e10c15f51c1f..3925d38f49f4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -767,14 +767,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -790,6 +790,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -797,7 +798,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index ade59e3638e8..d3b28a6b9248 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1810,9 +1810,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.35.1

