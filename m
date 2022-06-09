Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C554585A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346036AbiFIXQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346019AbiFIXQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:16:45 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569F3C2DF7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816596; bh=nRFZTXyIqrr+BZnegUOXOgpXbav22Zr0lj00nScKgr8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VnI12e4BZsscREeXkc/BP3/GbELZh5T83hnOe0CBkwzV7D8hONHmPobwkHp4eGFTMj02/GciSKHFj/fKcoUDLG2ULu1pwts6rRC3NnWzy2iCWh6Y+QFNUR7oBr4+4FWzXJJ73+X9+okS4G5sJE1MwoaWL2kGNIXJZOJcOccvqVc1VeBj084W1DIU3/ReeV0fz/qvu5f1/C1N5veuOs+d/7nI1l1qrQq77FY1D6Bos5TI2VqZeuIjQvKp/4MJZO8dysMm8Sd9MUdn0spyWMRhlmVbwqJ82ChmZqJG6sJDGdUE5u6BqYzmLyeFTUL3BoGyeEiBlfyGFPtAzJgvjPU9jg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816596; bh=bXkyKIYf71OGeeF0ApxVhWpxXuQDIe0iFUVxhD0kb5U=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FZu3XATlYj1+4lYfWGkqcAQRdfKgr6DmW+z8UrAmDyHSsmanFAjBts9EK9QzmDg35UQ3lWw6jdVQ54SnUSwmFD9w/PATCsWSN7bMzC0qHuwvVQL6zl4YcI57CEsIcXGkSBUoGTDWOYi2sKMYSMar6NBkPQc8Y06uAICKXh4opOfcah0daXQRAbBSHYv8AVUR9avgjkIh4Cx+NRYdbUg0geTLbBFxA6WDEMww78U/TkcFCtC6ZLiVp4HWP8wAYPt1eMkABIUtXB8/C9Q1boWEj6XndaK81+i/grWWipB2b1Ho5T4a3zS3YF3FHJ7fOf4nDzQ50l20qimPQjK3YN5igA==
X-YMail-OSG: fUCF0FMVM1kzVm05geLlRy23AO2xpK1nnPParE0vvpawcAoHkbzr4Ahzimv7Wxx
 QEZi_sipHIri9m6EfEa.gsX0NscRrFuORPHXiUeTgOZZbUOR5jr7pBpsnykmCLQ900fuboDwDOQg
 PEMklR7moOifxwBpPTI5CEugqPY5VaMNZqFulhgiDzvtIYVyRs7M1YAejBp1l1bxwqLtUWqNAC.m
 qz98l0b41H_kY7_TXnSqnCM1KTWGMqYVW7WOYb2Vad81TpF1jEbfKFRLl10iQX5iSnks7VnRISqT
 tiBqqLZOkaRW4SV67b_aZ7Qxp62SsEfA1yQlGCiNHZ_omwJxgF1kEgxxlQixrSY5rhVBuh2LSqb1
 9WtsRCW5mSqnywZpvARrtLiTHm.uLHxSI50rE6T2SjbbqJfKZ_owh6O7d_NwmMt6LYEKTkS2.Qba
 aNR6Kb5FUx1rDQdGnMPfSvw3wyinpERiy0SvwpXJC5ZLh710BrP2tsuftZomLrtfyrdNQFoguePw
 Z5jtwXfq42jLTOPzYny9iDNL2SiAA30TsJYPOpbGSAm2VX9EjjoexzS1DHMR03pYo4hS3ZR0JEJZ
 1VPf0VCC5XvY7jn_lGK5jFzJu9bU_4G6VzPD1Bmlvu1ux8td5kHQHzxmzN3Vw8nLushUisza2XXi
 wW18mzUc.5Mkl02uSkYMu_gcPL3IjEdPwdcFf5MA6sSji3LrnstxszELTlHX_Dzy_InjMY5UBwYo
 jkd6zyNruVl80FNej7L7kB05l7GUrYZFhzcY6ZTrvFNbYjx4dOPmsIfmKunAt95uxi8fzUI5W0rI
 RtCftioS0rYHGnXDMIFaYCKiWlMourUEJUk_mS.rzcShnFlL41RidA9.GqSFNQ8JgdZGO548SR9A
 m7Xq84pD1QxF.BmHtiSc.2F46hS9nfmzpsYg3BRPKZs0WN3ZS3aSPTLF98u3MXWvDqaZ0BnnDeUn
 bya_zg1HLclwNW3h_7Z4sifIk1.uoTexrPbRJAnAm6FVNeGHuyTC4Hns83Jr7a7NT4X5t7uJ_T5Y
 V_CknV5GI9j5TsgU7gQXcWj3xr4jAWH3PwIVj0i9J9zf2.HA4BP1TKntvRuLue2du_._yzir7m5f
 XLYXIdy9PCtdng6aOVTXAyKRSva5dYhU4PKxQqbAdGCuurpoUe77TkhdSstLd8c0t01Ezvgix1aT
 9xQCImJcc0V3wJQWODK25x_sjLwA1nSJdO5Wxm6xIYIHDqr6XAbHFNsL3KOz96SeK5m0.5.UyCyo
 26u3eWhY.OA4WHDEtD4lJ3576vre54luDmzzYeQsX1Grs1.te0jyDVWXIXMTK2Q3cmZR.qJ316Xi
 i2rfvFurRM.0xlOiOTeek34BuFolYAeM8FKT3Z4VfTkwjOtqRRCRHAeUB2JT9Lran3.6AWXx6xr2
 TpP_w53l9eYS3jsanvuxuLj0pcwH8nI6Rs66UkMV5wUulpCt1I5EtnpGyj.l5J8Q3vziJ79SUAwv
 eWd6y7JCcTiAPdB2U.jk4D67LrJqWqHo7b6nISfGgKzprUFLuWu8Q8G12WT.V5gRk2b7wkMiWGJd
 NIrwKIFYlfahIg.YzNvycecXoFnunm7HcrsgyQXsD_ORFci976pnfSJc2qk214GZAOnaqwU.bYLF
 fibBUZJVMgd4rP06DxIZUvAJO2DVizVhqPXbH2H_4QCiXayKcLeE2jpEkmtewGoiy246ViVn6Ebo
 BfDJUv8mXYdqZ0UuEboKR.PlItAHVSGy7EH5Al4i_6LZCVBrqQuZ4XUVcbCJCLazsRg4C5kjHYcw
 Tj6DzJrIcsBNESA98JgxEKJrG4L1yNfucd1zw72JrYl9O810inkms1_8ME4O8hgJkYKviZ61wh6t
 ONyOvWJe1HLvFUbQB26FiXs5iibiCIJ6y_geSnFYgCcomAW5g8sabCZFslY8s5HGSJHirdcKJP.e
 Mj0Hp895j4ej_G6Z1snbiGP3JzowaqIe6AG45ej17Yc5kknFvjaIupWq1FQBmIV0p2gVY0FIJYEz
 bfF1tUiAeG.FxSpGlb47oIX.T5sdSG9ZlbAkfSwBpcwGSg2zF9KPuUJrmIwbUPdKM5.0tlUm591y
 mJvpZVErCPOpFk8FqWhoQAqGEL4BLG5PSs4OFfkrtkPNeIKcLaiwv7OvIllRE3xEv3H4mtchNAxx
 qGnPm8tywAkPcgBFGFvZZItOsFsQFpDnitAkqFpsZgf.TVHpikJlamlcCacWAfMQfBFJd8cGfGKW
 yL_r.JIepm2A1dKASQi2GwEvWasvJC93RgLFmPb2ENARbjmR7fGV1yz9FLJIxPbr0H_XFaeusDPP
 N6A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:16:36 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7lvgk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d9a335cac260a86aa8227596f2c755a;
          Thu, 09 Jun 2022 23:16:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 28/33] audit: multiple subject lsm values for netlabel
Date:   Thu,  9 Jun 2022 16:01:41 -0700
Message-Id: <20220609230146.319210-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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

Refactor audit_log_task_context(), creating a new
audit_log_subject_context(). This is used in netlabel auditing
to provide multiple subject security contexts as necessary.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  7 +++++++
 kernel/audit.c               | 26 ++++++++++++++++----------
 net/netlabel/netlabel_user.c |  7 +------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index a7226989d77e..de661c571401 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -190,6 +190,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subject_context(struct audit_buffer *ab,
+				     struct lsmblob *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -250,6 +252,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subject_context(struct audit_buffer *ab,
+					    struct lsmblob *blob)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index 2333d7f59285..4ec86d696753 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2226,20 +2226,17 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+int audit_log_subject_context(struct audit_buffer *ab, struct lsmblob *blob)
 {
 	int i;
 	int error;
-	struct lsmblob blob;
 	struct lsmcontext context;
 
-	security_current_getsecid_subj(&blob);
-	if (!lsmblob_is_set(&blob))
+	if (!lsmblob_is_set(blob))
 		return 0;
 
 	if (!lsm_multiple_contexts()) {
-		error = security_secid_to_secctx(&blob, &context,
-						 LSMBLOB_FIRST);
+		error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
 		if (error) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2254,15 +2251,15 @@ int audit_log_task_context(struct audit_buffer *ab)
 		if (error)
 			goto error_path;
 		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
-			if (blob.secid[i] == 0)
+			if (blob->secid[i] == 0)
 				continue;
-			error = security_secid_to_secctx(&blob, &context, i);
+			error = security_secid_to_secctx(blob, &context, i);
 			if (error) {
 				audit_log_format(ab, "%ssubj_%s=?",
 						 i ? " " : "",
 						 lsm_slot_to_name(i));
 				if (error != -EINVAL)
-					audit_panic("error in audit_log_task_context");
+					audit_panic("error in audit_log_subject_context");
 			} else {
 				audit_log_format(ab, "%ssubj_%s=%s",
 						 i ? " " : "",
@@ -2277,9 +2274,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subject_context");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subject_context);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsmblob blob;
+
+	security_current_getsecid_subj(&blob);
+	return audit_log_subject_context(ab, &blob);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 1941877fd16f..42812bdfc31a 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsmcontext context;
 	struct lsmblob blob;
 
 	if (audit_enabled == AUDIT_OFF)
@@ -99,11 +98,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	lsmblob_init(&blob, audit_info->secid);
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
-		audit_log_format(audit_buf, " subj=%s", context.context);
-		security_release_secctx(&context);
-	}
+	audit_log_subject_context(audit_buf, &blob);
 
 	return audit_buf;
 }
-- 
2.35.1

