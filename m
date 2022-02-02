Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D54A7C17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiBBX6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:58:53 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:38434
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237715AbiBBX6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846327; bh=V9MYPYVW/ACLny4ll5w654GiSd+q+5r1VLoq2sGzyzQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XC7YMgPUxHzMpwoWMvda6cmjhfB8XnSfLIZKvRItk+MfzTn5bgtrfea3zjQNCL6C0vxLAZDy0WbldytrR+RGEgfZiIE++J6j4rJ6qR40nnKHCexp7RVtmqePwqr1/0cEIt5xMGKjczXYN9mRzEUXcd0GqAGET2lofzEG2rcPUO7VWrN85zScLV9m4llmwaERcc3owy+K9oUo9qfHnt8ImDTaZY4B/Rl6UyPQdz7IsVxr+9ggn0nSeIPft1O7FYVOSpdAZkZMVKgd+kFeJOA8PVxq0L+GiaofgNa8Q3AB6czVxk06Gr+DNKiSiBTJBgiw1mTpT00l1dohorpCZUyWqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846327; bh=yTrWdpAL3ZklNZe46HI3VTwsNEb+gHYwRcVAddqxc9S=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cUdWZNjcPadHLbLyXh0W0ZG0A42e2b+VAKtL/buwyQlW3pgnAkyKKVAzNmtft5PMVHgB9rdAnlMBWxTplJNzXDR/KWpzxLZ6zYo/C2q/SnZvFclxAXPO+Lka5cC+aGBJA8z9HTAIFy812J4s1N49J5YioFqbJBcSOIkoOmOdGTHgLj6Iv5F4qnXEgmiBtS3FoMSS2M3G9C0CSQe2mOeSCiT30qOtjOYk8uvchxEQUl+iMjFmbteQ+V6AeJ65BGkHkPwPF2Ay1jzaOlgpwWvfnCyi8xXlazzmvpgSnL9qYPa7W32rPR40Eo+bmTz8Y3qr8xyi9Wp2AXhbZolzKVKJxA==
X-YMail-OSG: QnQxreUVM1kjmwcoGFNJ_0C8DLxdnxbZSDwE5bpfVdoRnZ4zkdrzJDWf6zO.eyz
 3k9xdH.xiddrWAZ538.HC6nBpPOD4aOkig9AxBR5AyeEf7l3vAKNkCll.8YDGMyMhHonBypM37wM
 e6BskbRX7UD_OmTpXgIQ8.y5LMe1Q41amuJMfglUicOCVpxvfboNQxEy7CTpQkeHU1aKPaneexcj
 RDbDSmzXNV6WDurDqomEV975tKxZiaeGefm51xYyKARTPPPdFfPBk8YmQ93PVJ5RdKYSXyA6Zf2r
 .hHII4lH_LqPA82xzOvNJP4JKJmc.ut_bKTwAGJraMgt3.SKoXzQKK9AoSXZYqAXYVEE.t2bPGx4
 3x.XQQdJiDPBKI7dINafFkTlEkBtUkATZf5ZsJSE71eLBujNK7uGg6l_rAch8S3Y1HizZyhOL.y9
 1WXAZ0trWc5l_AmWj4qBhVrTnNgqAkLJ4RBAdypYeY_7wJB_D0KU6vPnDaTQn7IFI6WX45e5aTB_
 o0ArVPF3bwjHVUUYxhoRUe9sAIpacCmRAqNM78XrG04EWrziU_VCBPxldW8A0vUYCniFoEl3FC0V
 nyJwRiPiBeaYHnSk20fq7CumYlFX7t7gkH6vAldNYfTDwsTfy__AQ2QF4GFumQXCUqDr4PSEW1BT
 cfilhNzd5GiILw6otO6j1pZEH1Q339yHKy.BxMT24v3nv8j52rN8BO7LgUfavSm4VQ90M3IIRKTl
 TGZWvtWnmS7gmmNIJ1BhNhAAwwJrbGQi5G42_HkomHw_pgGODHGy.ZAir6vrps.QljsqZQLmWPo0
 37.NnbK2wj5KZNU6gBg8aDKSkqzuUQw6fTm4I1UcdFhBfl9fOuuS0DRHLxb.LhXCGNtimzqQGzzE
 NgVZSLb3xevhKFMNly7vIVSoS9ACjo75BuYtsraU90ZaMIDal_dLQE1zHfBgm37OW6l8d0kVwxEE
 nL5_rrrPooxab1Birkd8XnnZkSg2yGjIHz8q2lrLo5X7Dplb4C4c27TqXhG3QDn7tN4hXcHhvMf.
 AUotEXnybWICdVfRdW_cqGVTe7mGYeXY5NPRWdYcrazpgzHfGTr4v_09YX8iiC1IGisrL.LYCkDv
 L.1HlmHF..YhjGt.V1Encr3h94t6YO1fEzxMtYJf8izczNVf.8DypA5We55SM0EU3SlBZgFpcGq6
 mhanbugXcubDT8X8HrbAGHBpRoviONW40yiq0467i7eORr_8ZCL9VKrn40WaAVqGvcS1TG3JOdPA
 SPPpszknkCqo9QsgABOPai0hdb93Zi_KTEUlkwkYQLt5Vx17ytQNdf_zqpJHw40G1blKZSn73bjp
 eFIIu.c_yju0ylWm0Ug_8gmai7HxpjranVJ7bjWLn_d5vq0XRoyw44PB73hSupB4n9negtL1XO7U
 MUg24oDM0dycnS2R5u03Bmnb6E4sRnb9pDPo87uOfuWc19mBk5F9JL3aTVoVDejQHc9TlrN4KTQb
 GhCG0QiORadVe6inNNv3KlhlIFcf4_O9maT4izGo6tQFBY6_MVOUZ.Qnn6EKS1oJjXExyWS9yr3c
 dNgn1UK9m2yLzlnQporBYOmJId9WP3HzAukuc6dazUkVkkszNKPSeSpd_VetcDLUR6KDG.mEdU7d
 js7hilVvclGYyLzwLUaoJRY2bXLHRYWC3axcJO58u63RJqi.euV4UZIJCw8lmNPabqVeYDd3eJ78
 SeNXa3e7Mj22MPQkEfiuD1bT1c7WfbRFblEGq.czSbMck4YHGksGutv9kCE6Jzj6hVqQDNVfxiUH
 Z4q4UDj2UPny5vPUu3THcGhLdiOt01lQ5oA9RWSrPaKrLqJl1zwqpVwq2I8WqR31F5Kuk6lrK5js
 6a5bhY8ESOQaoY8Pq3mzM5vdHmPkfpWetlNdQPoD8Y11.Q30hfvFBBWyR4YQYEnSkpxhSnfU0Nxf
 eep0l31N3.bFwaXgrdETBcX6bTeoqtCHU_.f6NN6N6HTVYjbEF852k3RFMWkGpe8rLN.wevWQ.qD
 vDdf5WMMSEXsXirPHLSsQA42KqjxgZKVeHAgNz22QHnDA4Q3fj.zcc9ZLTVlKivTH5RarsVGSkrz
 MLvsT_ZLMb9aSl8JuZ2PlH2d5jwNJMtbA9hMC0PflimJD_ONvGGM2lsfRoOz5nG2bFLDgcTL.dk_
 uJnwIbwZhh21apS1TSIISlMWTHhrqYOETro9vCUU3v0uI.8DR6bWFg_NpoJFPwVFy_uJsiTGv8ce
 O4Won8YnRxb_rRW8tGq8Hedu64cS1U8VnR21aN5Zm.IcjXzaBeZfKpZlEq5B69qJnwHZmx8O3LvS
 B9XRGc39nIgpCCw5M_2220tY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Feb 2022 23:58:47 +0000
Received: by kubenode529.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cc70543db5d26ae35881f30f63a6503c;
          Wed, 02 Feb 2022 23:58:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 04/28] LSM: provide lsm name and id slot mappings
Date:   Wed,  2 Feb 2022 15:52:59 -0800
Message-Id: <20220202235323.23929-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 1a7e5bf36a82..6da0c12c9170 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -194,6 +194,10 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
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

