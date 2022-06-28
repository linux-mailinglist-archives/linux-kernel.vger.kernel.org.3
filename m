Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89055CE39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiF1BAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiF1BAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:00:47 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F92253F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378045; bh=bf5sJak6w78RJMogf08Z0F5P1ba3DHjnEa2+4ISjYko=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CTNrgo7/Iw3eoUmJNUbs91gNgCgkYxrTejjQGf69EcmdHTlo18MpCV9W+tK4VhFrvzkDvH4F7/FhyeJCE3+//6BU/cBgFs+747EEp1VthIx16C7NRAhfI8j3Fz1K9F393NTILAquyBF/7U+RMXyJDUJfVnKQeULDZ58Wsjb0/ZrKj4drgs/WPohXnZ3q44xPuzW9XKdrFlCeqKJxMTVAkfdL68j+05AX16iG7+RfGfpT/hTp///TTc/JcgiJykqdD5QkyZAI/SKNecxpkVvlKWCs/Pv+397tuR+fKkfRMKS4Sq94VRCVYItQoiGxhSQGHmhUkRYbKUQ7HQ3JbfZUNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378045; bh=rMUIqK5xfFHtmytlNaSYqwX1glCHwGhf65Seq8xRYlr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MkxBgEYuFcob+6e2kZP0E63TcfoxaMN0mF8kkHLni2vn05CZD8Da525ItXq0gzX44fAsow+GW9FsepU+8B+kV2r8oNGLFtZYtXmKbpWmnaxQzLil5+FUGr+WbC1ObUgn6QyZsTW2/aBKxLFfZLsr/ff4NpK+xpKKkCOomjBOasd7xu8thsws1JsHfQZ1fFZ+tRhUI2lHfEgIruUd1CVthAksP7yy5r1EXTdGK/3CNFy6lhHel+12Wv/72UqvOTcXwH2q7spdVVraZFHa+GEBLMfbJQtRIfgU0StZrd7UWa23AxN3yisIayPCZkf5oqx4vMnda3/oJjGig1ViC62kNA==
X-YMail-OSG: FdDUwOsVM1ngCAgPfyvYLDVfY6GwmCd74D9MnbviIDNgHsuGimcttALpm_blp.5
 vlj4rJIfeTyNI_K_kjNwfVB5.3bHMKYnbAc.JkYrtkJ9b7.1Zt_LrzZA3Ua295EQ_SnoYfMh_P0O
 Hwq0leS5P82c4fn_Ua7dtI6wItCXbrefN5UvcGJRMnmrbyjcZ3xQmE2tXBAhIVUAKUXNtof5cC5m
 Euh6ERshVBRu_HAq6wJ5Xg08j7ov.m8VKIesHbLqMzFd9kbHcMqrT_YIUt74kJqZHhJBe34oYs3_
 BF1IskJXX8TvF9YfSjbfoNaGQ_5WaMdYrbQNBGWPdmIDvQEJ.OppCOG5csk9I4IaPzzGc.c5xPmz
 YKLNnVahclH89Jx69E8_Mvmu4oir0MbdteU_ozeZCctYi9P0Vz.9S8QCcQcbVRoKMOP1SwBbu8yx
 oHQ_RakF3_PS31lEtEPY_xCujfIDsMfa.6xQMaMwGXfUiMBTBxiCw_LiisrVLuDVJuB1V7KvFq5r
 rwExSwQUeH9M5z1QJJPqxHrG21EgyfmZ3r2MG0PziKP1Y38K4fFAb9a9iTmkfTiLjmnemlp1UKfK
 3P6rSQ7vq.G16f.5m5njvrL26EKtRaqLrl3UiSLIyXseYcCDTtONsR1xQJXKYDa._bYvDKA.Fb_j
 82PcehnEytMz8.e6EfpLcDgKLBuUEWCJdl_epvQZIU0.unQB3IFBaSTOCC0mJD8b2iOLxDdgdsnh
 v6pZDjabcKuAY0YNIOLfvM56NDbKfgNpMx.kaF7LqhcrWj0I.p1ue6hRF1pxdXJsDSepxSyTwXBB
 8yuEK0B.uSdSQ1NRXVBHwy0fDJpUha3RaYWJLe7RqXYXIosugR14tFh6jUu9Kryx0twcDoNwEm4I
 CIN9YrqlP9qi64g31TvFFo6r3eA.9MaESnG8tBvYd2CbvsmzttWQXyYdnnaehOhFcXjbus2jF0w_
 cr5mDU9FsHHChItf2AP7hltUglx8SxX.TAFEWNpEuiK5jDBPh1e4BuiC9vkHr7zFzeINI8FxzHHt
 JV3_4PgEx_2MV6qSVshpn9fkvpIOVhqXtRb6.NKw081Iq.SGfTWV0PV5Q2kZ9439HAM22qR_S4CS
 vV7LLC5.9lvW_Wb4KdTEMdPSX31mxUPkXXvgj93sdekNFtwZ_d7.wy84QFUiwKqu.zTkYrFfLFYx
 Y.oexMMKpeocQYat683MNAeLVgrsc72zWTKIr6QhDZcKZH58f5lqdO598ErvzOrC46soFUQdZdxt
 PV6NszGvsbccSAwLRnCXTYfh3bPAwMS2ubbCTfrjUW7f9voSBfcbYwLhzSt0vKkNrd36AfSIRh9T
 gHWDbBKIDk340dZKXHMVh8ld80WqM4jwgEGe2gJWKrG8P7xODpa_NfSvCAf5pGsEo0tpJhHTp8yV
 kFS4abK4cCUutA9Sfi0PpWGPJVf1bQIsmH5MaG06ZO.Y_dq5CblHbCaGkDjHNXngLE8GRxxKYt9K
 TEyJG_.WOHIS3Bp4qNaQEm_A01kcyjaBAyKh_71Oy.16hUeLx8qTyoRkeECBeN5YqidyjhXGi9Oc
 WjJfpDJHq4KqeI51rg_W8E.m8_QUvpLQ_cj8WdxWM7S6dFZnfJy6GX6_1wOm1re8MDM9oVm_kkPz
 6HJG1UWckNxMtJ22DBmHbG_Yw5fhPh8LC2i_dNSiK7xtGSMuDG.9YZEUJnfOUZRJP.Xd_PiPynqn
 Q0UCW.uUST7R82gWhj5a1wC5SPYzINtLFokjgcZr0r.8fIh.q.UXu1zsQQkTsuuRVhas2Y1.D85P
 LQMk5Lquqls2sZWgtuBzR6tzXX33HOxvqSVLQz25bfbz3sDjccSBDZxtb_0a59HWWJwR30OqGcsW
 GILoj.lM4VlKf79kjURPGtfaHIZQHLeRg1ehGm5j1N1zNh.wo_TbzsLJIMEvMJ0cibIZXXPvDwMM
 CD.ZmvleEsxaUVer0potz_Jw1dUAKpIvMhoqMePf77DvBtXICYFGGcgTSwYCmZLf22IIE.8f75Kh
 .gZzwZHX8tfjDp12TNlPFU5A5yPR9mdDU3aqLLAWCnmzh5JmcQuZJyQFbYICLdH7.oYlMmMiuv6w
 mvBVjpfcpjvLcThRpcM6N0mpLw4XqqITzYTI5aCacO_7J9j2sFdNtteGBpv6CvaJ7fe3pip3P0IA
 .pTSNFXans7PjQhQ0Em4jGkoz60gNSLrmQrNvCJ9uTCZccfaROPScuUgLPb9TPzmJkVJmZixohfv
 dPRfGPblnhl9nnyYZM0wF7P.z6Ms6OiPvL8rb00OBu65nEVc4hAGTFJY0Ok.Ttzn0SWoOAcWTUPX
 MEt6xraSXhcnyEHoxUS3M1bK0Vh._Kkr0TAox
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:00:45 +0000
Received: by hermes--production-bf1-7f5f59bd5b-wjb4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2eb209f35c81771290ca3d956ba58232;
          Tue, 28 Jun 2022 01:00:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 04/33] LSM: provide lsm name and id slot mappings
Date:   Mon, 27 Jun 2022 17:55:42 -0700
Message-Id: <20220628005611.13106-5-casey@schaufler-ca.com>
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
2.36.1

