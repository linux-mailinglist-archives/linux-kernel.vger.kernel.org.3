Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28236505B59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbiDRPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245431AbiDRPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:40:32 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04610E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294286; bh=FxMOPietULejA91xLFMdB5OOrsn00dr6TKgqrlqPo38=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J/Hwp71dX42DIwJeGjm71xiV2GJx+EYuuZokmV1KZ/cz8b0RuhL7us9s3kfnFRY2HIRWLoayfSwXnAf9I+/pmDe0JmNsJKROJ/ux+yOPCNK3kW3MPhuqtzijMmWyY4LwzpPW0xFL9tIywlkkJBwwldixP7bWwn2W3pdsZ2WCjXr+oTV+x/ozjSWevU6m2R2gedd1j7FlZL8nzS2zl+h05eqNw1LlFXhnjfFsSqfKjNxoA1unpV7SnrmgTyEL3d3Q3xUr2UutWH2pK4a4t8TCmjySSPxDwFrrBRo7U6FTfCzgYiwVW//wsmwgJJyuzoJKDvXzTqKOw269pWUc8vPnfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294286; bh=9yIk+Qm6BIIHAxJFwk5rLSDGMqmmAKGk42vjiaaAjJv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ccOet5KytRjf5aIYZu/EKN8IniWGF2UKKuC2vPn8eZgaZP+iAkrqklZ2bH+xCA7FRGG+As+OheKJ3vdHfiPmgCCdEGyq97bHndPjY5HoaXR3+2wEo0Eiki30z0MhiVu1ojCzA0pQegnt67VnqcHp7oTQseQDDmyjnaNZqnaCxHWIROrWKEIPpqTlJP+uUhjWNg2Qk+KXvcEzJrrKhiY1nQpanBV58lEGhJ5eLrep89fUWW87PR3ZcGyzzuIqXoTPrE3YEtky8s4Q8w57gW8GKvHJee2GYOjye+SHuxeapZbmMivSI0JuURGZAgD2C6FwoBnantPXFsYkjsNsuMbBUQ==
X-YMail-OSG: ORks0DwVM1nKwA4xRD1Z3FuPluCcCMu1rKKOSz3onlb.tqJrC57EqCF3rRekn91
 iwhp7ylJ4bTCq2J5IvYaFf.RO83gWT8Xa0CH22Hp0I1UUnBlq.mzShqlViEmqSwYFUikBNWWr3BK
 NQcEwhGmS69LzUau3nsZxo6zBhGmBXgcpvk6Mg_fEmBVF6I0v2X0Am1dIJm6nUm3DbarjOOObtyo
 SwK7AogxgnlaaMylS78xjb3GhlLIRG_l5_cDJaxXADG46EXoykcTLXEaNvkr1R03obxCobjfS5aq
 LTvFaHk.qy_DW79IGqDZYXWmXJQxeJmluRa8YiGKMj9XUHIPOf3lAwVBTyQo0xq.iAIOhoTWMgK5
 MmJI0OGen6Aa9qgg8tahn4pKU4_KjD._IUJFEVBRYAvn5HQ728a13OsT4NPlHsl7bgC9nHf1XctS
 a6s03tzUWGIwTUwbVqkmIxo9rJ3xRUyvvV8vQAeiPWa63IHf_EK0Eam8qZA8rvaEkfc5I4yPON8Q
 IYpdre.uk6WepXOZXeQbVe.9qF.St9Rhhpp.g.Ub1iUhShq_vQsOG_E4UoivyFRvLvorOu4LiaKr
 8QMWYjKRK_Denyl1iYAJzOI2TP6iCw0Cje4SePW_NXiRqtvmSncvWTGriHKiW_KUuZcnjSRAoNBH
 C1gTH_n3u5MrT70CBbZWHl8mSpP_aWIi78oCKr9mT97PD7.KZnliqk1t1dqtzAzivHTT2k_yLZDN
 0Km3wO6w57s6clewte1VLkxiyBw9zTDP5dut1cBbG0PT.uMt9p8hv21dr7a.IP9McYkSsdcqAgCX
 XUTbbWqvFe2lwmN8HJlJm5sooLmchAwKZgixAXGvkR7kxtl3JFfGDHiKr1z8llqRDFHJXrKvB.fP
 Ju1ANczR9eceuSo85k88e_xmyD8amq7lnnqlj5.PHq.Fr1MBjxT2l2lmlANGqG1Xy0laN9hW8btK
 24_oUQO95z3opLAp.sgAQLbzn1U4hxbLCsu0qdFdRRlBWLd3g2iqrzMOJET8ZreRkYGEI4UnedeF
 BloQmUCCn67Tfz3VeEcapO1IigcD0pGr4BSF5TtFupyPUzdfo8cFYzfwsQsZfmbdZDEtoHm0BFZG
 svkW3p_8UosHcY5a.g1A_oaXpM70DcDL6OOCUr5uWaC6etVWUj_WqnWw0Lhg8Q7QmcXLxhYfBMgw
 FFASFe5JmcMwD_LqUkwHIvOxoIH9BWzIqMW5eJBhsUnnPFd2rmjVeIOtscSJNuOc4z0gSWWDBvSL
 yQ9E9TKkLH7YvXkqzjeBCH.BlqJNTQ2zisyrzbkgTkkMctZ0r9yY2cz6Hyjmc1RR_mIc6K5WgWe5
 0HcA2wVB1TlEuR53k9l7M8nyuezylEJ_W2Ry9kCZZGbCJ.znj7MFuza3enQGqo3Iy_BNln7QLpQ6
 qa4ExdGhFMF2KlVSokCzxVtk.zrcXsmZt5SV8ztBM6PzytHOYJ8a7XoseGWnD1IhqrbmUVpT_Lzs
 v7Sm_9inZqnVT5roD7suhPa7wjZcgCxGgN1uVMWVa3VA_e9NkMGwYNMSVyIBaBB6pKWafUgKC..v
 wCMLr4Vs7FMCx13mIVaTxm6rvf0kfX_uE9AxWaeFiOnEDfCgY7zqG3q26xcP0UTedmCRV32omzyr
 Bcqj_C8KAcfNygcfrJJTrozA4tDGX3LveiMWZlp2mX5kheGbX6MCI3kpVgOqNG2NLF0zHXv0gT.f
 Po5gIiUdt9jLxC2wBVwnPqeAQVBhlFTi3XIwR92eXBySUKqlrx2c6GH5hHMt.sC7_pZ5ME4CBcjS
 PfxQ5GimEWos7x23N95Vk3OKmyWuOv.5HyrKLiH6OzfVCZ9_vjDm1RM.oFmhLRFiu8QSNzSf1eNU
 HymuuWy.YICbFmUD6GIgNth_fiuensJbtJNQB51emh..MHP.RLfHb0jnk0j3hQbtbE3E_s81XXs4
 ZRb3ohyXgkr5X7Si_XB_JcHUyaVZgfOU7mWL3Vn2oJGj06_K1AUOfBQL4SSCleQik5s1vl1_HdGx
 RdpNXNYRUR9lnogWvE5QqM4d2xAKvOgBW2Rs4So2Rh4BYLrxTy0nQFxAVWkJmL_ws9S8MyqykwzW
 xfToWHrwsWxjyBrEesK3TOHW392PFKBN4b1SWWP2KwK2IdpUGrmpamKCrMv5ITByMh2cDvurWy1G
 dN20..KMgo_CUHegp6fChKnfR0AswTUkoD21MI_kji5OTTtIJ9mZg1xpHrGmNfHmJwQzn0Y6xedp
 pXhewZy4gs0BjZNPHzFkozE_f0lRVOIeOFx7EChbfb_66CFJAtXVc.ozoU2wC.2LKJN7FTyCMNsO
 Vryltb9KK0f4pG4b8O5yi2ORxE00zar3YpZAR6BiqwHA_BZrCJUgJ08RVqw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:04:46 +0000
Received: by hermes--canary-production-gq1-665697845d-ftzwk (VZM Hermes SMTP Server) with ESMTPA ID e42a5033a868ecfd55a4e02ebf801990;
          Mon, 18 Apr 2022 15:04:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 10/29] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 18 Apr 2022 07:59:26 -0700
Message-Id: <20220418145945.38797-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6ce44b9ae464..4cfeb5eb29fc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -520,7 +520,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1277,9 +1277,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 10b9dc253555..d125dba69a76 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2662,12 +2662,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 6e6e44213d80..131c851dd681 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2012,10 +2012,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.35.1

