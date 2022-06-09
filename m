Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5E545860
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbiFIXQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbiFIXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:16:33 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947833C07AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816592; bh=cBeq3BToS78YQzCrXZFAmUOIFWSCb0nS9KQytA8Jzwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nfs0vi6cNUXpUIJslWg5wkPtwfHmLuZhfnMb1EUare+LSwnfFyJv7akIvF0fG+CAC+EF3qa+3AkpQBArbwcBUuOdfARm5A0ArtMYAE17qWAATLhRoDx88OUuCOfEroKuBS25hWXfDMiJbn4qQ68gSjnH/jqGHW5gYqM9woOIJeM0LZw2awK6XlH62Pyqo+Ixbqj0V1DIOggKxRpzi4YQo316LXQLflbGlRIsx+UBnZfJI0mPjkVUMuqGNJSAJ3eltUd4OEBF+9mbxLvWyQAJWFb8PScJ25RhGYfOh4U5SSA9w0sEXFK2SxkO1FoiAV76TJs74qgzySRVzcx62z75QA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816592; bh=J8FQ2jN+hPobwKYgf2oXikq///ms0Ed5mBOV1IRf19N=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HMb7p01iFvoUgU/0b4W9ZNtRD3tGyvOscYL1ncQ+RRc3PZ1d/09lIH6HCTAU45LOGhd40t3uR0Yfj+N8/b/snvLyCro4tUMZX+RMP3y5glRe3bz+tB80rGI77uFiAQRZe4xSB9AP50+YriPqZwcN1f0hUovTIMX0F8IwWb9ilVBrFc6QTooXyBsmfDzwlijk89johigFdxkVntcFDUjQJEDRZ49aCo1SENA5dk9LU/5Eja3w/oROWS5wMu5I+TQH6813P/wRpZlYmFflvifAQc9qEa9N5bsixyHtIfAgRn03UUxLu4vd6p8nkqnLhO/v8jGDOcfGpPaKeAiS2MZNPw==
X-YMail-OSG: O4U39hMVM1n29oz9Gf.HQwJUMVXvcTva6ELmx6_zs.JnsM0C.3OGdbrP7T2suVi
 y3zFlPek2vOd0J1Xk3WnQ56K6vaWWROmrf4daqosfSN88hFRjwyduNwFLQ3XmObK.7fHg89NtUpp
 mK7Dyj0aB.BqZBqnGHc8_hK1_vHE6RQ9u.ratmXwS5whpIyypREiCKLSsSxOsQ13yE.do92L2zUH
 EjZtOLGI28UqoqAHukVcB.cYl4JBAFg0yfnfDoQb8TnqkSHoY97XtaXzJURHQAPN1mItI_uUUz7Y
 3CovyswxRd0ZSCjUHVUBZyjN5Xqx8zAn.5i4jjtl8_pX5ezH28T.E6pe.GXfHV5jIw6CJ_Ezh6QZ
 PCvxZmDq9q5qMgJ_61a7_6EBj79tNTk0vObZRBZze5C4s4PMu04HVLqhWBLJFs9aN6BXMzwXOWFw
 oPyiNWa8BdFC9zTYWA.13UTudJ_8IUyr_raJJ6LT_txDAqkOWr2m6K_e2YaiO3MtJeALPlQzTA6_
 3Etkc1X6eGrgP1xzDuBXKdjnxCGR3BMlKbLxnz6Kylp26HJgY6PQfwWb65oeemE7c3jQo_q5kEED
 DQ6IGNEsY2SeGjtSQauG9Ew9yVxDjsvSQhPk4D3ShwUatPrJqhCbJMtAjipxIU.zcnthALNJPXOD
 3pSIZt4XOoDfeJ9.6KP90zb9y7D1L..rg0t4GhtCTUZU6RfIoIPSIoVOmRoJTdfn.gfEkjuraCJ3
 7ogT76bdCO5w4830PFBsRXbSOOeAPH7fjQlDpM2dUioNqI3DDUaZ6_69wP_R39Sup_Ybq.ddwoVQ
 frw1C0ZN5lZaCru065a13eWx6Xe__NvnN25xmalq5l_RYmMtqybeq_kaSRlIA7MnLqAl3G5fRloi
 xbNEX4Gz007hSJLEN17va5eeo5Lp8gNAMxl3T1DV5f_M7gtbl.zo9eIS0nPQZDiMP0WdN4qW2Ps2
 wbcqF2feFAd1bz0gxawac6NCpgeC9PTY4GUT.40NZjo.8fFPAbh3KsXjL8edFm0E3yh5iDFdIboR
 XtOmcMxv7EFxrtgeTHhy8UcA279O38DI_4VoiVlJKFLY2LqUXx8keImaALazwhNbFJovQ40tkSXC
 MpBwbrFsQoUgDY0PPEPxGbd_mq82PBudyuAGVJk8OAOhSWiYAqjPUXz.b12rL373EcWpp83r7r5A
 IugKEvz137u.la.2LHBu3esptnTI2hQ4DMMXaMRyJF5elbyWVLoOR20VqUebvhDE.5iHwOfDTRfx
 mD1A2Ty8XVMsOO7pXiKrAwf5IOvpKRT8Tk.3yMjuNFxS8tR4T6lRb_SrZTPjz.vohzFdsBlGw39O
 KTq7XknXw0iS0npoQl3pdMaUPAcSvuvDw2Tmo6_NFNnMNv4c_CcsJ.f3vCuVsnY1PO.sX7xIbxKS
 WzUSBYgDbvge9HceMMVd5x0bxA7qeypYfJ86Ig48Dg_JFX1ATLixA75ZM1eXRPnQs.SjVV0eKFah
 6aD802fC7YP.TPZbMaONKvgXyWM0W8.xPdiLUCSPOg4WBGaozexxkPYvPeGO0NJntJYZRTuXcal6
 wytrMtHtW9nZuAJJ6FdsV4o1qUFrEft0lpWlWPg5bh8VwXW5V.wXBrVoyPazKAIHt5ZcjcVkwzky
 jnoWJQPyAITOfHW2vRnpAxfEkzY3kIjatGMd81S0da8hJ2adZ9_d8nycp_swoAdTwpZ45rKEHvht
 5JqfXWBvcVvPOBium_lTZuR8R.6wWJQElcuF8MrdbYStiY0hjeq5YEskEckFnB98sw1cyx8qAQ2c
 5MBIKVsGohU34fdgbQW7PPwQTyZHH16OrEKZvEfDELMc2U3HsJP4JQjz8mENDwCAlVaHxrIknVCE
 rWz3gt07w_uYwf2P4TthKApv9TIgsgx83ruAfvKAYZPhm8JOlvStefIFBxUE5l5GXKM4TTlHOvtJ
 KhmhiF5wnaccO1Yp.ZDDG4_Y3rfXKO7XYT6u5aYKuKYi..OgzIBuY0n6nSrzbpb7SqGYjdbrHJjG
 yRyITG..qeMirFB.pPtjkXiSW6w6xbggWNsricb607zvCswAnxFPFRtJ8S0DsJL4jrabkWQO07Iv
 1Mt4tqwuFVluOm0DjnnIFLUm3Car4boqFUcyb_xGSW40RMoQTGaKtPt_fAVSCdm0ib0iCUgQdj1_
 DEXlYHvYT5Cu6wNs0bx6prVKYnbiRq7gPx7GtTW94N6PmslRCPo1K2Y6vGpWvZkJBjCg4uZtGju8
 65VEN1J19weOY48fshrL01kEE0f.nEbRwL.fIKa13agEDBeibarxJb3YnpBKc4xDrsO3pc5XDtJF
 MpA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:16:32 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7lvgk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d9a335cac260a86aa8227596f2c755a;
          Thu, 09 Jun 2022 23:16:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 27/33] Audit: Add record for multiple task security contexts
Date:   Thu,  9 Jun 2022 16:01:40 -0700
Message-Id: <20220609230146.319210-28-casey@schaufler-ca.com>
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

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=MAC_TASK_CONTEXTS[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 42 +++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 7c1dc818b1d5..7a5966b46f38 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -143,6 +143,7 @@
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
+#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 987740374dfa..2333d7f59285 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2228,6 +2228,7 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 
 int audit_log_task_context(struct audit_buffer *ab)
 {
+	int i;
 	int error;
 	struct lsmblob blob;
 	struct lsmcontext context;
@@ -2236,16 +2237,43 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
-
-	if (error) {
-		if (error != -EINVAL)
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(&blob, &context,
+						 LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", context.context);
+		security_release_secctx(&context);
+	} else {
+		/* Multiple LSMs provide contexts. Include an aux record. */
+		audit_log_format(ab, " subj=?");
+		error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+		if (error)
 			goto error_path;
-		return 0;
+		for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+			if (blob.secid[i] == 0)
+				continue;
+			error = security_secid_to_secctx(&blob, &context, i);
+			if (error) {
+				audit_log_format(ab, "%ssubj_%s=?",
+						 i ? " " : "",
+						 lsm_slot_to_name(i));
+				if (error != -EINVAL)
+					audit_panic("error in audit_log_task_context");
+			} else {
+				audit_log_format(ab, "%ssubj_%s=%s",
+						 i ? " " : "",
+						 lsm_slot_to_name(i),
+						 context.context);
+				security_release_secctx(&context);
+			}
+		}
+		audit_buffer_aux_end(ab);
 	}
 
-	audit_log_format(ab, " subj=%s", context.context);
-	security_release_secctx(&context);
 	return 0;
 
 error_path:
-- 
2.35.1

