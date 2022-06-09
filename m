Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4625457C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbiFIXDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiFIXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:03:33 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F83A81EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815811; bh=LUFIpniHEubw/UJBpNoNxCHC5jm+azAbJSIYaT8B6Rw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bMhJ/fCtlogczUvUFvppgBH7zj5qcW27Kmcqgnvja0MJODlom/8JGGZQqt/i0veDGUz7CAMCt/Vx/fDYIC/PfYF4Myx4VDwQerwFN5yjyIR+aQNa8yQfCQE+87vToi+Mdahk4OYR8enZcOChB312UwX+c6RQQT4fmVHVcc6Nk+Z3IepeG4ath6Gcy9yV825fKMN0YQLLSjzIBlbagiFWcazRf8fSio0p9Wgs46VKbSZlMD0HH0whU7a6lXe1tZT6rVKzoDu/X7VAm5HeSD4L0/tIiigQ6hxV3whh5tZ2l+m/21We2TwmfmTAgQNetpepGEefCydjtwE4v58sbiEeRQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654815811; bh=fbL0jyICuTPLu1TaQT7wB/v/fNntodTxRxmaUpK2ziH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s1BjF5S6K21m1016p3DyIEhgIkcRKYk9dSBvnarufgQEaARd9MuAIyF8mc29Z17iMpNoD4OQmgVeqpYAIpZYZqYojfOyf6aYDn5R9dyv8Y+XHMyOnRYq+WYMjLFixzpo72ESNdju6071IUOTMMEIIx2zczBjLuNm4EbSQOnYbiV+Ywvfg/4WzBNTTv13n3j2tzRxRsXCkrnFDE5rLikza1QZOWEIFQ9NXsrq0YPXpOjJlML/kj3sewYwf1M+sqnX4u+NcwjZnQvr0SCPP3lYXJPPDJy5sKjQ9Ww+yVnzDkTA9i0m4pRq6bz8yvgAUjaurGE/6cmTudOmn8hpkV4/ag==
X-YMail-OSG: 9eC20xIVM1mEC5rS0OxtQEImcdXx9jDrCR_0UJiq.B9jFyog_wmsSmsbOgE_IFM
 5l6MyRgsigcbyHdj.aRnffD2w0JGsvN5zxpUljBDewEn_V0nxbkG1rNeEkvwOucex5Nw1j3WBSVx
 5Sb2fXfScPanyoEhO.HDQDEvdFShPoA8ez1wCOG62QkDk5J792JdgZQi6.QVP4.HB9SjusnyMlYw
 VE8chEaCQQg33HOZede5ywidHGpMOOjYDRzCWDiNpkdPcGq8dnlROtxcn.6R4oEzMc3Wv5cmeHd6
 ZsIHRe7AXooSJk93l.sb55FHMuXAe.iqE2CB5qjuCd2sTEhqw26z4hzp3MIZnVuHaXptepdpH9l7
 QtChOyrC3d5PQ7yHpdDCTnSysVddXfEDI_JH8_MFh7NxJmTqyBQ9RANmLWxrcp67ifWI3DaqXSKH
 .fmWfIkKYaZAeF7QUhYnTOR58KRe12KA9IW2PTzKM9yQ1vr8vxBvAE8RFRDeqryjVyXwh3YT5nh5
 d27DYxS87Kye0AuI4935XD0LSRIpT2auLanVjvhP132tGRTVlXRRyhvlScNqG5XVSuHs9NL2KV_r
 Jp3ho7ZDUT9Mgu.R6I3Y4b_tOFtrY67Ow7NfdYKDt9LfOwzGXwJ_Lo_UzGn9vnXEUs4t_qvjUWpo
 Nk6QrNi4d1r8Q4M_Fq.gfAVx1O8b2Wb4BNI6BQH6eG0WtcducRml6HeDnrmRvXKxKBWVFh1AsGg5
 njN82D4AdTioMCvzhm8Wpe.CjzoxcAaCovuZ5upqug6qUdwQTsFOaMBH3uexi10yzZ6sGu7zyMnH
 Z5cHDhkeNZlTzh3K1GcYi1Mho0rbSX5sE2xNPQt7nAMMcq.nbPoVYjJPLJsy1Le9gmDfQOPJwfMm
 qeYmLROP1RxR6O9.JxSQKIcwT_y99nDXhTDnyrmGdoPur8ZngeMweMVxvujGE9riQyh8Wdk0AKYI
 4C01r8u_2WPUMQ25E5QujXexqLBFyxfR5iYckv_F_sgXALaLeV5pXcG9WrcGl2jkxt.P7B7KQdyG
 67H5C_77jUNOqCEIJBLypcZsEGW7dzA0G6Zdu5Qpdha7CPp.olAYQlD1ZYeqZgW1eDq.F2qIUaRQ
 IcUS.x2R53mLRbCf05jeGBhfCrlt1DGGyyHl.uikufHHLfrNKSCZkYlmu..bGMq6J7KjLN736F1M
 RCTJaGGN5ejefNQ7L7hZ0mbrKG9qnMctyiI.t3zNQQVyE9D7Usgf3.8XZSgyyrIgDZdlJStbcN2O
 DYKpb00EobkKgX.aLDWKcg.qRZD.l9UOHjRyAhUFS0vAEWjvOtKHKiBoNxKoHgZkXsEnZt0JZ8r0
 uiDA7i3.6oF1ipm2Sd.wRAfHA52fx8XvImmKU0vGW1E4i6FHYwC343SX3s33_mvW13gWZH_a9FIX
 joVBkgCZUjQZfBrlE9VfIjWv9CE0j8OtbJIvGSicuBJV5zWmv3T3x10pTSuRfpr1g9vIaElEYRyP
 XQKx_zi9s0A8JbjfHsZ8bz2kjrQWOznmwlLagK.baYNOCqMiFw0V1KWBbGyXpvv0tVxcXy4Zbp76
 EtBxskxQsRbu6RLAQpf7bulArm__.yHFcZ5vsWzf2_al.eqxXye1nXychgxrw6oWNxojsxTfxcX9
 LaONUeSCOChUSpnvxynBP0fBVhqCM92qO.sGqj.w9245cJGjqPwTcdSpJ2dQDUiu7.tqNVvflQI0
 N_jFvNPhR11GhG8GRWKAYdBqnCLWit3H8yUKoDR6KE52G9m5nppV2BxBqts7b9I2DqPQ_JHUe2M4
 ZDoQtHWLpAUS10vVRsMGhG6Yy5MX3hhJcBx8owyv4f.RSK8TGlzRrKYkUB59q4khjetfyItxkQjA
 SNKeoIMKIPbpo4sOHR_fixwqE9nV_eiOqcRIj1SkI5TWj10SrTO9JS4FTrDDNQM25JHp.Gi.16eL
 XuXAxO2T6eQCnsJklhY9BffJDcPvpiWTJpg1nhIBvD97Z803rYhL.nacxUTIhmcDx0aHq3uq.Z0g
 ifE7XvXxWWhJCn0JJQsySjDe2WjuB_ZCsNK4HdlR9AnraNzZTjU9FlxjlPJxWhN54IlQQC5XkIQG
 91viOUYBPZdZFFhbQo8025E3jyxpaZOSWa.OAb.HrLcKyfsh_ROGRk9l1z.hEMHw8zRcaYEkI0Lo
 I3SB6bEAYzMrOLvVehV.HO4IagjFQJ5vMa06ql_XVpIH2bAz7b.xv9Ni5wX3TCq1367ATfyVn5uJ
 8l4eanEVylJMvW33ZJytzRU3JU_4xJssELjWKC7A338XA7F32B4QhcaEf7eomCoehB0GAfIObX9b
 ImB4pXwsm8_emfyA7TlYB9BthzXWCMilHATRt144tjhuUStW61ILS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:03:31 +0000
Received: by hermes--canary-production-gq1-54945cc758-szwwf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a765eeab66d702832e1d09e1945c0ee1;
          Thu, 09 Jun 2022 23:03:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 04/33] LSM: provide lsm name and id slot mappings
Date:   Thu,  9 Jun 2022 16:01:17 -0700
Message-Id: <20220609230146.319210-5-casey@schaufler-ca.com>
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
index 835fbb86a2bc..5b7a21237fea 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -197,6 +197,10 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
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
index 8fdf046fc749..37c14572501e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -478,6 +478,50 @@ static int lsm_append(const char *new, char **result)
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
@@ -499,6 +543,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.35.1

