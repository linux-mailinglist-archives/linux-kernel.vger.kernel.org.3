Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E54F8977
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiDGVZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiDGVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:24:50 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC016BFA0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366563; bh=3d387zZWuQIpaibCYSztCqIgpNlthrLh1n5KR0d6lpU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GypohnNCi3C+iEfuTieL+6qe+hUGc92L7gxFOYPPCPzMnA0lPNiVJsAKNDqyyOKPSijLGFwrFfr7r3wcYWYoYDbJsQTkDMXAOmwzAe/CeKNWUT8iLkowBxZzbAYgvTD6e1KV23hnBLwoeQWORn3T6c0E0NyHjZ/4giXOY7uzgpI1YHXsg9p/+a6ZajjaAzNaksDTqtCi/gRuT7/OYZZmG83n2D2kpJiyJ1T8tl8p5qDu5k0xcIUlVj6elnRLIgh0lpZft0rEp3TJZMhemDRPCnm1vweYsw2oz+tgQLrUHO9Ndyl5tbMe5hXIi1xp/xV34VBOBB3BUThL38IoZUL9FA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366563; bh=NoK1wYbFjNLhx01rpAAwCIW4gH5lnNtl5XkzZx4thB3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pFmdeFKByXj/5FTyglccffec+V5u+PeIEDwO4Vj96bgSovs73CmTautQAWsDUV3myQGzLRfCGvQeIKGKLLzczyha3bAa7mUGkPz2U18RsdiVv/vm9HvNWS07FwIuGwIbfw+b1AzPE1aaf16Dh8TPUsLkN4T2QB8i/v4sXwdFbiJ/afO/YtO+vx6SErkZvGUQj+c8G8ehWuWxuAt8d5b0F9QqXquKBZaFvRg8V+zKK4E6NcngHUAfD3zyac2cEWfVDoRF8Upw4gQNTimRMF3qLlRMLrzL7SV+gNzZTsT84bY/BM4QO6XEiAe5UfKp9TS0IJzzLdlI5PqveLQ2mbBrtQ==
X-YMail-OSG: VZN10.8VM1l_vcAnMEOX.PRD4LllQeDLub2tF01niKCoWg_dhwsFf892_nAVHJa
 RQgXRVIDRbGclje.xPqXMnmvlR27qO_dH1PY9cnK6dDzxXR47vtY0t2feANJ56m6TKEq6zCP1I8z
 A3F.xbHgog8ufdZNw9UpSXi4QWcbbH_t5dV5fkkih7xMFYJS_259Wlg6PrCgxNMxJzGaiqCzfx2M
 9.FeI1YWT35_OjhY2Zg1i1JW9J9NeKomfPNWFHEViIMbNMofDp2EZdS3uffpAp7r0Oz4C27vwC1r
 CIRG8JNjN.qEPK_7urmLAhzIA4WE3i_U59RvnoEl2.cj2cfgO8XREDq2pCiI.CwvtDaFZVxXG7b8
 GScCuX5B1raDEgZfhIvtpAqaTyHRRFbOyd3R0QYVgul8xb9XqmmkMkMM0KU3h7Kz1y5y76yCE7tr
 MFGhnWK4IjrUpCg0pWJ9IRKEWhxIfxvTODZkhfLPCHF56tZjwGqJHgDJ7tmDBGKrMf0BBmhvkhAL
 ejY3w5LxlyfNevy8NT5venlkp3MXAfF9A4W3XVS_DtqN8NuxTyu7n7Odnlq.9GWp.bo_2I4.a48P
 e2F93KwU7nLb2Kbqcmwyk20m1GlBPN.aq0PCL.MSPdEW08XPq4ZIE.nWH5WRzoJSipDAYUfDGfVH
 wgHQbPmooaGyoSMJKYq7jwHS.xN8ofXMYEAbjsBVW7.OFr.DgxZ05lSTKyBmfVQMkuAPLjUXaIVM
 EJtLi8VcegrUZEF954BkDVDCSUHKXYqyqDytJGpJhzKwKLg1MiffjkR9rQtdesMoRHoeIwFYcNHF
 g0hWOklkVZ6ae85OGHz2rz.5z2sj66DyCnT5uxCwxU7zvvmOg8.RaIV9kBKNmI1imhyEzjiBmez8
 lwV_.nXo4ZA6snzQFTS0rRh9WPyTIrRsNOd3TDaFk2.8jTKCWhnsW9awojmeFmrDu_XzJjEEdeWY
 77kv5sjTf2qaKgOVlJcP1huaEelOI0GN1uOuElP.lp.qCRv01yTL5Yd9z2ABLyFGJg1GmFXflm09
 GOgsU7mKARnBcjOnji1BwKTK73lvsnpruinnERXkVT.lElXNBfnOk4nUK56HtPGTAhMUE8ZiM9zL
 K7bK1kT_3TsHRP1pCiQCu8k87AF11PYFoGT9YsxeTz3S7ojssGoXFu5bHWRo5PZ_46oVoDwyvONQ
 .B12GQp5kquwrdrkKJMmF4Hf6fsB3c7I_6V78NkJmk_.bwLxsdLyjW8WbTvcgGWoNnnTlgXNENpq
 XyzdOyHD2wVPFwBkxabvNYCM.NnisymeDPb56tBJ_mIKzfKrPxZlxfOPrkprZGlPgJp_W.naQI4F
 Zddqf9QWRZAK1Gfov7XLPwxvq4.YIqXEx0mzan6khMdBbvJF7N1AmFkjqk24G_tbb6yVh.4_zCTi
 v_SSziBg5Wbs4AxtRHZ.JjvT9W59XQ658gtFLCWkak55LLun9.8v2GayhquZAYJpevprsmMNdfft
 FIOH9RCLUjhg4sDgYYKnvJToBTEAGGZSO_Ce135OVwts.AxLI5e4PYUrQjbzU5aMVGLeXktwBW_.
 .tQAK6wuUvLjoVqeV.QIfSC1WgiPegkCdJMyzo4gV0jUFlW0771QA3GLzM5DHCj6.vZYv829w22N
 _ero2VBB7doy4hDWWMTt.up1a13Vy2IN7hvxLqqGfqc0Hp39OfHQlM_mxAVbV_iON9R_QKNBi4A5
 Uj9ysBQ5DxMpuiIYOAFR7DUZH36MGnxtI41QH6KthZmHXtmKCMhRHDH81EM4FKwuiCDam1.zhj7.
 JZlZcrOIUT_CaVG38PIeLxIPCdsir2ib4tNz39AJm3btNGDXjrZVsRatRUEqf5Cvn17sJfoMMvJv
 QRntCBDxtFC1cRaP31kgFBezpkOUgcFcuX3pjbie421vxuKdkqG.zjILS8JBh2JpN_yKGdyMNCt6
 0kyU99JXAq7GOFQD7yCEoqVV7gd5.5VEqQV6ukBGPmBTgUgYYTBqgDBeK3OF3mF8xuh1mMK3HrfM
 XIOhyxiKyF4AKR1aUKCV1u556C6jo.yyUGTVNjTcYsvXsl7ZrqtsS87vi6cuqXW7vzF7GvdzjsM8
 G0kfpWSMTW0csIAYkLhv6gruOSp5cZSzZTaUV0xqJD23QHw2c5uqmWJ8yyaFZqVqaMBe02u2pBVt
 7QINBGkZYxZZ0mNhV2NN3AMyp4wXnkA3q8ANao34n8WML_7AD32qfX46jv88SKujs6jCau1BQ8Re
 xp1jh1AA6Jw9ijcDLsIVHla2VuAG.CGYC_LxuVb0LXCoBQEBg
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:22:43 +0000
Received: by hermes--canary-production-bf1-665cdb9985-4zttc (VZM Hermes SMTP Server) with ESMTPA ID c3fd120c1e9e5b5f616b40cd2f1101b7;
          Thu, 07 Apr 2022 21:22:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 01/29] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Thu,  7 Apr 2022 14:22:02 -0700
Message-Id: <20220407212230.12893-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new fuctions are put in security.c because
they use security module registered hooks that we don't
want exported.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h     | 26 ++++++++++++++++++++++++++
 security/integrity/ima/ima.h | 26 --------------------------
 security/security.c          | 21 +++++++++++++++++++++
 3 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 25b3ef71f495..1e94c55e8e32 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1917,6 +1917,32 @@ static inline void security_audit_rule_free(void *lsmrule)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+#ifdef CONFIG_SECURITY
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+void ima_filter_rule_free(void *lsmrule);
+
+#else
+
+static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
+					   void **lsmrule)
+{
+	return 0;
+}
+
+static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+					    void *lsmrule)
+{
+	return 0;
+}
+
+static inline void ima_filter_rule_free(void *lsmrule)
+{ }
+
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_SECURITYFS
 
 extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..1b5d70ac2dc9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -418,32 +418,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
-/* LSM based policy rules require audit */
-#ifdef CONFIG_IMA_LSM_RULES
-
-#define ima_filter_rule_init security_audit_rule_init
-#define ima_filter_rule_free security_audit_rule_free
-#define ima_filter_rule_match security_audit_rule_match
-
-#else
-
-static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
-{
-	return -EINVAL;
-}
-
-static inline void ima_filter_rule_free(void *lsmrule)
-{
-}
-
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_IMA_LSM_RULES */
-
 #ifdef	CONFIG_IMA_READ_POLICY
 #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
 #else
diff --git a/security/security.c b/security/security.c
index b7cf5cbfdc67..22543fdb6041 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2586,6 +2586,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 }
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+/*
+ * The integrity subsystem uses the same hooks as
+ * the audit subsystem.
+ */
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+{
+	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+}
+
+void ima_filter_rule_free(void *lsmrule)
+{
+	call_void_hook(audit_rule_free, lsmrule);
+}
+
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+{
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+}
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_BPF_SYSCALL
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-- 
2.35.1

