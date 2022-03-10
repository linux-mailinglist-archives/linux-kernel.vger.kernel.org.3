Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE14D55C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbiCJXt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiCJXtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:49:20 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300FE0AF4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956097; bh=85+a9+wZHrZpcTfi46FGKjQFvpoABcpzHQd+WTr3bkM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KbYDJtB0BNnusHtF/zpBhFUvU24wrEcMy17ykPuK3h/Iz0fVt+DIFlDBWvPu/cRSUziAuNgyT2/teSnuJ8XwaZafrSSArd6A+57u1NdPAXpSxMWuMLRqucDKdPNGKg+sw8qFmR50dBDins4GIbaFGLWiTXqN9nvnKgvJFLWZBBes+yxg5nQgUBDX+lLd8WavG48y3QFNhuL4509E1N1lzRD709c6sDYMp8+7CvbMhmLHJUE316FbEt0yc3Sf0MtBEoS9e7YpJpZpt27mYUORObTHcesd5ZYkA7jzsWPsBBgFJo3zQFThuPTFg2YE8PRhfq0kRMleL6ndMPgGdo3x7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956097; bh=5zvk/+9QB6r7QseCLA0iHQVN006jz8FDVYCtpKsOyAd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qP74nm79+xg4Y/wbJSV2Rv8SCSEFC+27+AqlgN5b33BaSTdroWHWNgMr+bEUK1Br0kThwMqExYrx+JeJxHKDRftwHb0201grP1ilJt/F6+11LSDzjVNHe9bLw3j8K/0zLn88TnAmgbQAN3AQ3XHue8oG8h2/xmgZhHberhyIC23ebRiByZ1vaQGMPGtoWA7thFsPheehzcwgHnu1cRwtFtVMdUwX6eZPoV3PXQ2rbsTtn+6KoIYK+mi+VKo29zu0ka6SOLV1kA4dckuc/fiaKWxNoJj0VwuPI523fsg0CVXi9cjCPp5qOGpJvJc8EV62asV1gYBBy1Xx6kD43L8tXg==
X-YMail-OSG: AhTnkQgVM1lmqLMsO018kt2hn3QFxLVS9LWrPil7ITecV3Jbeg2gtEUApK4MSXT
 Va9EJ744o8eNbvf1HSzsYuj_OyqnanaD.hejB9cwzdwPsoDQzWymrVKLjfzuq.XgjMz9hGb78PVM
 MtzznTb8RpmGm8dFsnvWjV2u_xwh7dY9z6JyoT7ik0FQtLcHWwBhM.t3Q_dgPGq3u7xaCLUozXJt
 tzIfeDZZrAj2mpbN_sOyQba6gY1tf.9JQnakxFVSmrtH77TqSdhQRIixlv6MRrWK25Cxgrot8i.s
 QdnSw5OEG.Vx6zlRMrzliX7SpFBneKvtpxur5.X7tyg.hWzueN9D3GGddvcXyl1E3igzW6D4dlmY
 PftZbdB0hQacY684RoasZD_XL6zTar1Px92lZLlXx5rdW9XyPZBNShEpi8ulbC_1TjEnhbZOETGa
 bLLBFmVDxOWjaN0C4NN3ZKnZyBD11mDgE9u1Yji6clg1xaBiE77IIf3gUlFQHPoO_BdoW8f0JZOv
 e17m0Wrn30f7aTId1flvBbwBMIDo2Ogy7CzgArr.kfNt2fwsP1wRwfDia_lHZKCKtLhSjL1cheb7
 vSK9r3_JS_hLHRA8ub74CxqKxKZZbrC4WVDKZ.4J9_dwbX2ODL5P.6wl8gjOBY9jrWUrZiv64pH1
 kdebISDV8qN_vjgsv.t3XhxHzjcTyVAY5jLp13uZuYucRD.ZH8Hhw6289cacgaSwerGX2KbLYa22
 AC7cIOP_UWj5BkuzK.WhcPrFE5mw_jUtrcSH5NvZmFjbTdQKQ0dC.t17F4mIzcLa5_or0qrQk6PN
 y50_IKvl8yvhwwhNj5L7i.Bmm_vAy2wYMVi5ZZfg5bKTEmNmqTXS8ocJCPszKos.qHHTFet6cfNr
 pfO2_Bc8ruDM6a4cbRobpwpMcFoVRqCmiNAPzGFHA7kC_.g.BjuNtgN_0p0rUigjYYglJBk_nJqq
 YkNs7Rh86g22_kF.lf1Y2LZySIIEmBtkbZRWNqdsYtJvuJ3JHmj15wL6pHTdHsiBMrpMPYuz30h1
 Yd418RtKQjHhWjpaIlHNdIT6KyDHpdZnDEML0PaGQpJ9uLIAIWlCNSa0tSUo07fViGPvP0Tng3LX
 MGP8q.D6P9okSTkYmop7Aabbl7gg0hUekSH3DlE..ilgl0NuziZcS5GbnquGfaCi_7XJzRsPf5h4
 VWN295CgxX5vPgDdSzLVKseceBaZxqhVYcHb12P0UQ_VH2Lkl8.PXRiZJuDdR9KG2ETDvxQT5mYr
 IUq0NLfV91I1377iq_uhCAvNRocSejSpE2hjszPvn8VCBRebH_YxgHeS48dt2D8uK1SwEaqYTllH
 _lkLjfpSkwQJtmUuDThNuN7Rk8QC0ln7Bq1AFLPlbFQqTM6JamboA.xtbDpIQk0QFLFzZaYYVmhF
 4CiZ44wIhkOU9JoebY9JuF89frXmI9wuR5TYOiAEiMD79u3rEq_KvKiN.d3ug3Z2vWdOlbT5a_al
 GBROKaoRJ6ojTlum8wDS6JOQEjYA.sKwz016gcHddnv5B7ahU3ea6VdfdARvy8Ks2MSgDRtqBWld
 NI2oqUwzRjmqKvfH3uLyn_SmacF_XHvUdiSt7EI8QwHbaM4Wuem70TVJ1tZr1BHKhtpgNj2Tsyrg
 kkpwtRWjeVUiOG3WYeg2.ayQEn0SuQv1zH0XaG_MrozfdmLwEQvdX9E95SAWQmSI7uWUJlx7glAR
 eSOCDMV8cFZTLtMxQiBjgVVGLgTxt6YbNvrvW1Xo.BYI3ziuir_PFr0qzI5JxmZVD2N.e1JWMX_h
 tsgEpcZys.ypNaeq8krUIt_fkElK2a0GWJjeHXwIsGLIj4435lgvIXezUBV8v5_GOezmP8HGVrFp
 jONemCmSuFs9kotWji5XVz3Xsj9z9yu8wTX1k5cFGUcH3_oYJkmVAbMkxbkEJVq9JuAmx71s0m1k
 HGCWdMQx4UpTp5KrgWi1Fyu8lxUTUlT6dUwOekGvdBzdY4e7xP6hXINMqPiKl0rs4LJ7.CFYRwhz
 I0SVd0PWTvWSkauvp195Xqf4iugpzLll34X2iPYDl.sBMCIk_GXYLaoYCg2arLiBAPdRya_Bn_Bb
 z9UjCIATh.miq1CHTT1pjgSCY2OhexObAHUAlh68xVohv16NsuWpsIiWl32kcp2OiHHJkQhkYqVj
 kTTbkW6VGkRcTVLVUu3YOS88OoTpn2E.RSN8ubISs1o8HBsIDi3OgTVHncr21Y.V4pBN3OEJhZS6
 5G2kA6dv_2A72B7j9LuBkBsAcIewSBRu.Cm3xi1Shk5r1
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:48:17 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 83925d611ffce7fcc78508743dd1e1cf;
          Thu, 10 Mar 2022 23:48:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 04/29] LSM: provide lsm name and id slot mappings
Date:   Thu, 10 Mar 2022 15:46:07 -0800
Message-Id: <20220310234632.16194-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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
index c53bf67c4d9f..882e0d50e5e3 100644
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
index 2bf21c726ba0..03a0af7e9e81 100644
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

