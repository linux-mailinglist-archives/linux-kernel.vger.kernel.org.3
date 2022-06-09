Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA454586F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbiFIXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiFIXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:18:15 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9892228D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816693; bh=24rji6yhLM60tKiaW3koqJxEUprVyhNR7W0FtoSk84M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iZgFtghnxA8EvMbF97FRXIzb3Cz0ml4FGXa3KuHjvVzfBMu26mBW8o+ztqX/qcQlZCnhyKqtHvQ+aqqn7peXepwXayhMGKz/vUOJmNAPnskiqo9WxAOgVnEoUS+YP7gtKsnSBvOo2Lc99FN9p9BxnpfGQIqdHdov8H/PB4NL4lt+tMo+SGjF7auhKquTHCCyqQaroIFkUAlfpBsru19qlmRWLdtjauPLwg7v+tK1gkikdeBfafXfzrBC8FCYreFbdxcTtKL9mQOFwOkOnoKwqndnXnzBFB1bLt4UCwyqoW//BRnVQADPU9e+JOleYKk3xYpB0y+B2C/gKvSGAyPhcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816693; bh=vcr+npHmOBkkY3RAnj7uNcmp7G/luaJFOphqqZG9B1S=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ObUryDeoA93mp+GOu62cm+LU/qhVvNWLUUjaC3vcjaulCZYj65rK3NJudDz5vpyuyA8F/WMrn1JM0bN2pMSyDqBE9bm3tUmvVoGsRBwtmTzgkNbJPmTXUn2tOTfdo6Yo+syQ3GDzagRb+fsLVDnm8SNupESKPgn986kdci0Ultd/2yYpPDr0LMWrk7PuXRta5Kr7vVXK9VDPA1KjuGxehNFGUJjaIiJ5xoAie4WfLjFZrZlLmj4tpVqmm37tNrg6xktRDH/2uiHVPLax7THPnfI11w58wVWHuldhGlZE6UI3E3JIPyEPdeOG5wWmxM8PuMU2LbkihRA+W0I11HsD9g==
X-YMail-OSG: TwSCrlIVM1lN8fjay3zUrpP_zTnxvTq2f6nqnoiaXBDIxnaajuMASTCr24t._zc
 0_tViRc4aCprVaoz8aB8zWGI2609N6MNEHPKWePTdnZbwoHTDCDgGZl84fFs8gKNIzVbGSgK_xTl
 Dfp2S6D2i8aO3UCZrzruQDkirb6fKNYE8dePDevfgX7EQzOOI21x0teO_uWxMpIIqCE.cCENdolr
 JKeIW84OHrJr68jx4W.zInr3Q6zdA.Q3Rfa5Q.0TVQBAIzEh3tCXtH_2ZHJqywO_S2CDUJIReoYQ
 4GwQZwMUpiHzHgTKmsPuvo3DRa4dObPiqHg_xPQtVdnjju.VAB9VRQpPMOc.0REx_dmPcG8WaK08
 9KTcT0gfHbHO5Ta9UZ2JibZwJfkvTvKsGLNeS6ThRpIOgVpZnvE3fvnn.9dlI5.MPhZ4xREpeYzv
 pzPKCzvk32MbO_GCelTyzIwQBQQE7dMnthGoNgq6qVMINaeOSdabAPv.46UZy8OYEEY_1YO6BMYb
 yPQvITfyBN9gwKb6PD8wnA0pPB47ds4Ks4PczipuiucCnn_JFbgzTatjZLShh27rYPiTEJ.zWw3Z
 I1dUywItaw2A85IksTm.nFJLe53O.KJ7kmaLYPtSqWHTPMYtrRhb8bbP7L4WsoPeZYxO.pvm05Nh
 4P1mmQspeVo7FofTfymO8F5OZ8DTTCSMVgmEpKaAMnDwy0mAzMHZSsx.RbHryZmscyNFTqZL.gBN
 wqD06aiLjCNuFd19NAD3kZWFGtuurFWmiglzs6HnrKHefs80XE.3gR.R8CanjE5Jum3uFGZTSRxH
 EQD8eUmbIvID7YrWq7N2kesg7.sHi79irDPrluc9sBxdQyQUO8guUhRpEwPX2MBigk9FHqsCXHjw
 x9xz3ObVLWoZlDz6LlwA3yJ20CZ1aKXRrbzes3ExUKA3A32rRvMVCxu8P97PiZGWG0EqWEFYoQTf
 AMJ.lfOI2AuZVfMpsQTVbMLR6NOg24EPt1iJ20ttZPG4GDbxsiYMshUnb087njkqcv_Cqgayni2m
 wdd1Pb9CV5eQwlP1hpuZBULNd8gzKXg29zk_5WoplmYHdXwJcV5xQYuaf4XQW.prddU5VHCR3SZE
 HHUd1YjE5PNI_uPCwMKNx.fLFvYJ3TUGhQHF5ymRuyyeWsZqni5OiJBQIqv.34m1fXWGrLIyFPGL
 ODqLBKFvXWvF6gsVeaxq_Z9hY.k8Lw7OLaEWrRyHZztLP891fwu8CYZ.4zZrPjvgDUDaUnOEZJ74
 ifkJqTkpPiVgVNS1OfmWQm.hEBr6IKAWI2Zx8XZklk1.6QIw9TuYWgjwz8wO9VxJc_clSVPCLdv.
 s2x_xYo2585PTO9OQj6Cz3sh3AOGb890vRqei.sydRPL5HtvEJXZyzXSaGvgoL06_91YzJ7.KxUq
 ioALxbVXH0B3Kdcq9LFV23KcqjHoFRiB5T9p0tN56IuLD2vMWtbBYk7iO7eagqnBDudfVZlwQADv
 brnU6oUQcTNq3mLKwdb0QeUY3Yqs5WVWuSLubdEsnsYHGZkEFoRPzopes4srHzyw0zDtU3n2rdy.
 ADZg1ujepKOYb8yErduaVHUoovUY7Qg4Q29gG0L.3nreZrToBcwcFcMicDyOte5fp_zT9XWB4eRX
 de1jyolC8fEEuqTRz.ieEsFF1TeValeWsyh8OVNxpxHNtN6rgPefCHXxxwC4PkZSqdcbYtoCmeTT
 EJMrT94kk1lXqHMErJnUkw72rJrzFjK9dDScZ2PhtB2ijnozJTqdGpaOUxdPnmtikA9lydQh1W61
 UTA9TU0CeBwaqMDYt0iW.ic2a0bSy6BJUjVlIG3BKfpewgdRas10Zbmt5xw1m_okOtHA_UQ.xJMW
 VwZZaoGse31QC.FB6vSgHAO8xdKseZ.eIfe8xuQv5GRhYOO34jf5Ck8sISfbWANzXMQLMxR1kNzT
 5Yq9wAM0Jqxylc4MmDSCB6X_uSolUTwkdIApdOQBFgNbyPirMChs16m7zt6KTJG0u4HfBWgZ0G8f
 MPP8ROssTIMj_h3iULazbuJQTrwutBfm792QEyBSI7n9eCTuZ5JtEi5heAvk71D5Y4mLRg0qB8ug
 95qJUKlutuCCPiyQWmEjany_cZuj5chqrlrSlh0WOY740tO2mlGILmYxQ7WKteycFAVJkkHhhhIF
 W8tlaxZoyStTPG8Y0yXkETwpoypiDscJ_rbAu2Rm9a4voNA4LjWvS8_s61t9NVxIobmscwrYAyh2
 KUQBvNMreM19VhnNzYi.A6ieVjCPSnARZA4qIKlz9scInm.P_XrFi5Nkdj.jLBsWm4sSavlN0lXY
 .TtTl2VFz33dpldQfls9RmpxCH1BJCTkjDZX5eBuMVm2Ml8YBiN0ZW5HC
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:18:13 +0000
Received: by hermes--canary-production-bf1-856dbf94db-ld7kl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8bd0cd8ed239bc60f51b90fd11ae18df;
          Thu, 09 Jun 2022 23:18:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 30/33] netlabel: Use a struct lsmblob in audit data
Date:   Thu,  9 Jun 2022 16:01:43 -0700
Message-Id: <20220609230146.319210-31-casey@schaufler-ca.com>
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

Remove scaffolding in netlabel audit by keeping subject
lsm information in an lsmblob structure instead of a secid.

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
2.35.1

