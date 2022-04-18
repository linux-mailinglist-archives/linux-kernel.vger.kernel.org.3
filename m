Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B80505B46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiDRPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbiDRPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:39:01 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F2F1E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294089; bh=h4uO5wfKE/cDGnftdi/csMqvrdQfPZIUSP+JM76GUTQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UitKE2gzvIElNrdwR1bhYdlwI3BQTZDvtHTcfbH3tPKjR5wY6fSe8KndSc3XNJF6hUf3RXImo2JOyx2BWaZ748jxJJh81+6C+vflJpP7daNq58gtPpa/p7QCxIB9Aqi5Tao350A0kxB2CEfskkfezpiDWhGglOQpXdNUYMz5TjF9dTEG8QP+JIZBvt/nPRMWZacjw3waJ9Ru4+vuSVbbF0iZofJTXR6V9obr8RbuZnak8ZVVmhEFjceZJQPPTmcUiyDXhcpol2OspoLue13ch2PanrrPTs/pjavIthnzmMLyZYcJNN3RghKiajXlOXN3VDHubHfEcPTL4QAF0KslYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294089; bh=7RDt25DgO/1jehz2/1JFYx74yTwn7B4EZrihbypNMS3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D9cWQeOTAkfNFb4US45suVsipnFinPqQ+0S4NbZFYT/+bUtm0VdWy+jrjtAwOJ0t2xFUXOB2WbTgXW0z1epV87K3by4oOlNhr3sawXRQFm3iXeI3RiRmtfsqO8yf0dngKBXf8vTtsm4h9eWJ/xxt9Pe2sk9MDSKa3IKV6Q7DhO8unrgqRL6NqyYhx6MjPKc05KHCN5DLP7/BW6fG2lLywh0x2EDURr1TLXvHayJlWdd3g0pmTCyeCtuZHNRlvcvAorG51ULSv6pfAdOCkM8LpaYi9uuGoVfKK/zrMyYlBECPcsIqw2ghheN81OTAhrj9MJINRii9oc3TSaWU7hGnIg==
X-YMail-OSG: 71NRkb8VM1k4_YGMFl9rqttulA6RIHKY9eQIEKpe1UEyjVep7cVlGQjTkqQenEK
 dFiwL0F0HCrhBk1IQrtb6ECCMPMrdzvggQY9x.7Ct8UOs2jUFaQJiia7ow.wCS8V8wf6LZ4PH1L2
 HlmUKGaZM4phvoZVybTUQ4O98xu.DcG.mi_o2F2saOHbNWaWDmAMI1x.kzpiiboZwNFiy8YoQjkR
 tSM4c7LPsE5Zof.zBh.b21cMUrs2K9IvbXzlpKPNkZnqG7rxn0dix0683FYupYWV7SOJbpOAgIOt
 T72IMW2OrDXpKQWXO_obgLHVdeg9dbWiw9mufH5ey_iMgSSqBpqk0O.jgJiVOd.gYZuvsf7B9eKj
 33wwcsUBu0YbjDrh9XiPqRi4JqhQdLj_u8jdB7BuVIa.cYKFDi9ivpiK9YlOrQyx1eayoTRm6AgF
 rnBY.W8sZ5qmRB0fD130ydBJflLpKUwwWst52L5iwZPXvpV9qRSH_pF25l3KIk1.G1fQp.RVQxoq
 IxwsVV3tg3srmuOBdL_x2g.d3rQTDO1Qf0jzhXOUlEA7CS4H8vMuLyrM1AJnuR6xEkmkpYLo2YEK
 CoGsDzYKHC6nGZTdqmaKhcRLdUq6D78jy7cpTIJu2eUVcuH2FU_GQMW7mP0.2ciHg0jCN5q.p_wi
 BIKtz1ew1MEL2Okn1F0Rcxftu5PjBwpRB3dmyPh2yK0w1QAc8EmV7k44oe6qiqcvkxBpgRoZa8M_
 I54w55MQdGNAOfLVUW2iUDgzzRrlbZM3kTn_bF.Zoz91y0QNgBCQmxdMejgiqR0dzBZfVSYhdZzY
 OMPWQJLLNuSu_IAG54BCZgN8toPAPv8zhmFMT0CvU2xVZ_aa7uokb7CAfma9fEFr9Sv_8EofuwRN
 .a..cQ4P3jAXMRZap93o4fSA8_KqxDOreC84CRkP8c6SvFLNm2MWNByvpDc4kvkUKBQfcctn0BLO
 ca51EKOLRDAlLYAig9B0e9eV3_OgAwid94lqANPCweYHRiILrikPvTSAQusaX6S5UjxthIUpoqza
 Rw.8Kem.QmAgXG6_mHfRM_inJASUaqEyy2CCdCGN82APb2ikkm4qlD_PR7Y6SaTDRQ_XjCPH92tf
 10dwROiGg_vzlMsEboYm2ed7fBZWMWR.OL6O176.Ov95s2xHKXlttFUJ9zeo777IzQxcXfib5Dat
 uZnJTo8_Qlu_5BbKAaDd91NDJD.iUNCvedyoR40K3ziIBZDUgrkYrFDX6urmIDYMGt5HRFi9cJZW
 ZgZXPW5JypN5YRRpBg1nmnAfltB.Kj3WAjUazUSVSyXeXPeg0.1jFpYmTRYS.i7np9gtT56awkem
 usmkThnUNTtmx7vcGO2x8d7a_v.2JliQ4q7xFZZAY0k9BDjIJ65XFVGOkqdbaFVq6v.n2SOicvGZ
 4PyG4YgzlfC9QnhHBlCVbwpS.hEKLHcmxOxUTdruHQ9ZLNZDSyBJ6375q6a9bOxChcPPCkygMFj9
 cDz6.fCAMJFLrxVQGcVMGWwlhUItbEHrQMknV8VSu5m_QoR31hJeXEc1mTHau0aXllDy8sLmKcKS
 wB94QGY688nNrVpzNQEQNztpkkknvbU6ZrWaU3gcepZq8QSS.RiaHvuyOZ93QX3Bo5sbP6Z3DaLW
 5WFS7DVoQWAmHLiSnbXLUO9u_uNgUTAxlFwBiEFwA8ESmufs_NT3j_f1yKghxybzHwkDvsoQjCaq
 YWjbFbh_kO1DHxNmciGyV8cWlWz4QvyltTYHVY135Bgt8I8VCsxpksBhIpqsH62HBESpbNdRCOfb
 fGfrd2smPzccELVEGyeetPyUE7IQqH5FIlFvnvuoGRgStiVKjFtjdusG_LGgnYhgZrKa2qmMRuET
 FpsKI7MozkCF5cinpx0AkXGpAyHhmz1aRyvC0Y5O.6IMoNOJLf.9bXj5ghK5ct_9MRGduMnfx0SK
 V3oqEUC6ID8ex3eXMr1Ke5Oy4GW.DG5rbceUjzIHLR2nvuv1p.079B5L7CN6xzhgv8ACV694w3j4
 2jgmMa9ydELMDHqMyVsw82gYgEDzlJClNjb29QxAmzQs23T.IoLIfuNH_Bmu6e.fzwCgAx3nfa7U
 iZEVyHUuaeAclWlY4fGQBQJ9hKVbtT5YHxCGMOimlLCivaen3xihyL7CrNROCC9nLkk5Os2u3CMn
 NLZY86DDjHcn7lN.URQ3mfI3XR4kxYSRQduRRSBCsVjg_jgyAG4Iu4tGPmNM_K5mS1kmE4X0uMH3
 9VNYD4wd_4h3LgGhpEBcWlLkni.TtsnFbPbbmBqxliaiK4Z3bX1bY9bERpM7DKLyk_ZeSfSWG05l
 KY27AZ_u0ULSg4qjqTNU5sFwik49q42C14ox_t1bo7XryEh4TGw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:01:29 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID becb8feefeabb669980d2a553c076f56;
          Mon, 18 Apr 2022 15:01:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 04/29] LSM: provide lsm name and id slot mappings
Date:   Mon, 18 Apr 2022 07:59:20 -0700
Message-Id: <20220418145945.38797-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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
index ed51baa94a30..d00870d2b416 100644
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

