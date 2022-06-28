Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5155D8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbiF1BPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiF1BP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:15:29 -0400
Received: from sonic301-36.consmr.mail.ne1.yahoo.com (sonic301-36.consmr.mail.ne1.yahoo.com [66.163.184.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104022B36
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378927; bh=6WnjASuwRDLCl3bp9LPJxgHa4Fn6SO2x9sYEz6xz6ME=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KzXGIeAXsc52zxO1wt2+ON3FCmKX653EzOh3NQkbDbvXelU6WgZyLP9S3SrSO92Q31SmHL5lQZBnQuio6JzmjCFU0GR696K28/9Z/fr4F98o39cjI+4Xj5v3cWxhkn/fL6JgWicaHUI/m0nuB0BjD0qov+LSyarR4aAXVCLtyMSQ/pi70mkTejSNGinbOQDdM4VKQ8Ccg5HeVAWoga/jcbyy2f7TVOdykvBbqJHtStfiXWCgw1anJyZxCgSu7hBxd+GhvGPPYqp0yNzJ5ABfaSkWkVjP4aorpa7zxeCpUDwzLhW5OvKhoJLnoW5d+bSN1B/QKKcRN8j+8jSUNfvpWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378927; bh=Kee1lpu7boXS5ffDKR2+tNCzYCwaWd7jJTYwZGNShRk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HntXb+CieUBWx/urEkrDh6epQu9t1wOoSPR2+1+yPKo+qcszvCBa7JnVxDL+WkcbdG+emZR5D8zes1XuDteWHcXaaRH4xfhYT2jkwFz07XVA3ctLC0aH/aiORXdzJTS+MWQbRv7A/FE/7dzRFVyZCbdGieDBiJkFAT+oirvt1lRcHVS7gNcrq946M9OoQ4amQH9aQaSw3HPxWqUNI2e0yXs2sWC72h3398gd8rds/f6BG3fm98q8I4CctAbuCzTlAItzWEohwU3VjjfmSaYObDoCu49GMXqkIDzZ0l9ma2Gs5boYNWHJfeU8FVtlyicaLqUSnH5woPUhsOPo9BI53A==
X-YMail-OSG: 34I53hsVM1mRnO8GRdqLigtuy5woFJy5tVw6JMTqGphkuVEQ55mu.KFtTFPaTh5
 RKPC5LwJ2gbvphfQAIDVvuakvIaP7..YjtWB3Q9XMA2h0Ox6coKIfKFo0EYSDVKYFYxC.xtLMwUY
 P9b7DSc8OQLOz6jnhksAaEikR3McBOsOoLLaOX0Tlm8D.uLfdnh854li2L0BiNZpHFmCXkiS91T_
 O9dzDfxIJV2M1uOsFq8KH3.VTTDuRgyRy_d.xSkCLhxwcvcfVt9MwwQNNOQtdA3QP6t5kQ.mcQ4M
 kn2UqE76S4IStY7u_6Mf_5jfRBwqHaqK_54sTq6Gwvcb7ssNKzpxSbGI6CZ2JdkgrkZwBWG.h1H8
 nT0v._IkzwW94YoqVvCODxI6NDLKLmMJ8pwhsO4LnYOburhzI2xo3k0QeFqPvegmxwWQTwuZlHFV
 v6O.xY4qGUKjt73aSyNb1iaynzCfDse1h7ymEELKlLYOcDYCCjSimsx8cPJc8yTYUOk6h1VAlUkn
 kWLDibz7vqAg_oxtIKhzprLF1q7wJ7y798cDhyytnoRIoBSP8k42lFFkVi4KQRNiZi3MV2yULjjw
 nOtmBdmgqddLu1RSQ6IEuSy5EZhInYy5OLGgg6vhTcxIOGnW8oaoZXAoHsqkMCCGgGjCDTl7yilp
 ZeWLlaJdZMmgc_90aaItpSLKoZ1paNUasDSD9IWGLfkST2dU7yLp2rYQzdzkH6qgjLO3HSZ0O0Zw
 AfQFh_jslnjcc3nhinx8rU1mUantSIEBmPuD48iUM63lYxrWsawk0ZB8vVH3jyw5VO7HHCjR8BFT
 hUm.aSTrnkg6K8E84BJ_bb6Gfw11n3aF.QK8Gvvi1u.OsYnrFK4S9dRq7WFUdc51dUuDslqAzQgi
 zWeO9sRjDKcIzqSjcUw4VcXb_s_oEfV5uAbox2AqkrBC.WjDBPKzrHSHDelQm5L5KeWY62.n37Ml
 y3VKGXt24GOPE65L_rF5oE2m1KWWPw1CXyHpUiiS5cEEJgF6YolI3wUgsitGzJ.NjoQ3paP.rg2Q
 yV3JTIFfWcWUuSvj0shuxQV7I64xOEKRHNFaoZSqcXHHelKJykq6EKaaAbgxtqjI0V55B4H5zrKc
 h7B7eaA98q2cfTVlHHc7.LtaYYyvx1ixbOc7kIicfnEei133D.v2nGFp2gQfjap3P0U9Qv7lnFwo
 ybSluqv.oo0f3cRtxBhyKRJO3f3j622fOF.XGNuqOhY9I5U_oTm2UTC__FTzQ1NxyoIP_05amFNc
 _WLWPYwXm5MUg.yervr3meGhIGU0BhdqfgBZGqYjv2YcBkmv_Gj46aa7B.0ihiLvYjlSSypbMVih
 topODSSvKsBS3lvyHTNWLPykKmf3tiktbvSnC_DFtCUNQ2IKBAhWTnWczRa9mNYogKgDiCVuQzkB
 4Nfaq13R0MTDFxZSWvp2TC2x7Xds1.g1ioRXWLMDt5rmu_DMXKqjNFWixkqrH6LbjfTnjKuWHzEs
 KlCQV8g8V5AWn7SQWn4cGC_wx4hc.KzQDjsjkerL.0jzYmL4ddJVw9plcFQvOqdsIrbgonwtnSX0
 5ATSbyWMu9GtnzqQ_tBPK4HckDYtN6UmpjfuaAVztjWpuj.xWMJ.m3sETN_v1GWsDVfENqvHJkb6
 AAywc9bYUmsFPgkOyflO6dXSqAMV1yA48FfeLlK0pmMXPM0FiKYn17MThfsVXdjJjSWuWBbmvNv1
 u9CGEzGSaP0vYCAOWGhPnO57N.slHjG6CU6auiOscmie9t9BrxNLtoFkmVN5GV.rwtslQ2DXE.aH
 yOoRQyCc7EqP4oY6pytokhctUQwUk8mNHtedEuZDWB_iZOIqRJ5VshSZ.wUgDpkqv4C4U2SZjqlA
 3BPUp9elLO2sHh_lCzE2WVKREbuJN_krYMeb5U4GH.BExvslg66omlXN0.MgnqqEBxLKwSTrpin5
 bZpPnFax0zdqH71lR57ffDaJvX8gb3hn_Y9.hBCk9UVPsQAQ2L5DNBnxxIWqO6VLEcuSlDExpvDp
 IJA9my856Czp.HacpX3nnRWip5H5bQ98Dld1iyq3pJp33KX64R9AmxCGf8oMALnsXBa2HYkIjai2
 IqMDD15GkLMs5jqIO7eoFUZOy4L2AYwSBKY.8CyB1KN.a5s9BFtFgngMLxJEv4eLBt4g7nB4RWkJ
 zK_MPhSi5rachc6dUIiMmy382mmYlWnPECRt6yy0BxtZaVO1iIx0e8XlB8.cduJHFC2noDVYTMQh
 2LEwgsjhOzJFt5U_MAGXPqv8zVEadbQ5hdYmbRCg9AM.GXYi1SIZs_ZX3VVn6xZEMibys.DSIPLy
 pQ6J1EAhgvAOuAsXecMZ5SLe9L.0bk7cSq2tj4NYz4hXqg_sH
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:15:27 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ec536e7148195aee3798b7fdeda5831;
          Tue, 28 Jun 2022 01:15:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 30/33] netlabel: Use a struct lsmblob in audit data
Date:   Mon, 27 Jun 2022 17:56:08 -0700
Message-Id: <20220628005611.13106-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove scaffolding in netlabel audit by keeping subject
lsm information in an lsmblob structure instead of a secid.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h            | 2 +-
 net/netlabel/netlabel_unlabeled.c | 4 +---
 net/netlabel/netlabel_user.c      | 4 +---
 net/netlabel/netlabel_user.h      | 6 +-----
 security/smack/smackfs.c          | 2 +-
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 73fc25b4042b..d9aaa264e29c 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -97,7 +97,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsmblob lsmblob;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 8deee7e176a9..9277c6dd79f5 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1529,13 +1529,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getsecid_subj(&blob);
-	audit_info.secid = lsmblob_first(&blob);
+	security_current_getsecid_subj(&audit_info.lsmblob);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 42812bdfc31a..e72dfe2da77a 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsmblob blob;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -97,8 +96,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	lsmblob_init(&blob, audit_info->secid);
-	audit_log_subject_context(audit_buf, &blob);
+	audit_log_subject_context(audit_buf, &audit_info->lsmblob);
 
 	return audit_buf;
 }
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 34bb6572f33b..56a634244a6e 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,11 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	struct lsmblob blob;
-
-	security_current_getsecid_subj(&blob);
-	/* scaffolding until secid is converted */
-	audit_info->secid = lsmblob_first(&blob);
+	security_current_getsecid_subj(&audit_info->lsmblob);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 314336463111..f74207f6c71e 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -186,7 +186,7 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->lsmblob.secid[smack_lsmid.slot] = skp->smk_secid;
 }
 
 /*
-- 
2.36.1

