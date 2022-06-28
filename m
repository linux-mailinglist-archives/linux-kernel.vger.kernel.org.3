Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A6A55CC20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiF1BE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiF1BEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:04:14 -0400
Received: from sonic301-36.consmr.mail.ne1.yahoo.com (sonic301-36.consmr.mail.ne1.yahoo.com [66.163.184.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45E23157
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378242; bh=K8xi7gp5M8pAmE3PRl0lN01LpeF0ik++w9GdYI+Fn+Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lr2Axwq+TGtqUeZkGzlse/nk++P3Bc+IIxleu89pHS4W3FSLOwMSm+ySiEfGvWb5cjBaWeCK2mO31vMLDZFZpGtxki+5MfhsCiwdKiKa7agfWFP1ewjEuqotGqTT/ZU0mP1qPdN0GZesn46NwpKg9RxIM4O/6F6X0GQE3daVOYeawoYkpghvHoi9cAiOj8laJjZTmtDpTOn/HQZle/5VAYExRuXHemUBWwvcBn98yNfjBj5Ee/iWq47Q7aWyafWOqIR5a/mU4YXLAQ12Cw2vSZzNM8HL73B18Bmv/L6GWoEWoOz3Sw+akzc6qXOMvJu9xsNgwixsOECFMTG/gfc2gA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378242; bh=2B1rYmJl4N+Nm8yOhgrPK8zBOFBHrc/L7H3Qx5zTfG2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YM2oPyhhCUEiSormgMZiSRE4a+/Y4HH1nQAH6jWUViDdJcBdNot9hf8AD3mJ6xoR8YSYpFi1fSCXDF1bCEbZfPTrWqJ7qWc9L/mdxQE3SvmJuWpmNuW0/AkyxcfnunrzXfI2FEiWNEYkc1gA3Mi7lk8ECHUvJzbC3p/qFQ6R5/46kN9FwMllemA59eqetPy0QEZWk5zgCUXfSU400Bt4q2f+tPgiHAm8v7tyim0xUXwXI/Tjjl7QA6uVzHQK4RVedwHOJFLkwmEVSL+2WHUTj+h5uulLCqZtfM1THVbUX10oeT+IZp8e/vQ9JSqYrLvFp6OkyssvVWHZIGuWMJTHoA==
X-YMail-OSG: M1xVGCoVM1n6dfteoX9V1izjn5HkOXDfGinY3b15x7_.O2PVCG7jwIX5_DEReOr
 .LL4bX_c34sX7DJczi4htMkDd.NRrQEIXla6ePV1MN8n4gzZ7EmH2vXvCgkz8WHMmokhflUea4Az
 hXHf2zSwDm4F1.E2l2tgEDbmgDtk2L9UOQ9SDHNMYCXB6UwWj9o60CIYx0Ft4nH188TBSU.J5gx5
 pQ1sPmCTZvqQQ.W6svjgj3hg0QLmAF7oHNr8iEvSLYwxdFtgBHCGASs7z0U3vfRSB9r5mRXb5Wxx
 a_tBgUTq4yUx6m5FPrwm_uzPRoUDuNn2.yVcagVPIWlZistvDTIuD8pE4yZ6JPxQMckLy198Kt4q
 ItC5z2JUPKOW08A2nCjofT1AbLWMg7hJiyIStxfIOVNQZ74EMvp44Ypajt_bNnal_.wTaC3HoTS1
 Il4sSNa8JIb0fNOVJ7G62Rd1kdMYK94s4lg7NXw36nymwYAXdh.hmfzZL0KzgBYVhR3GTs6FW1Zr
 hnTwB_I2aLEtgDc7myQOOfjJO4LGFLlrYOBzv7CnF7huENuwYwa5SSTCNhBAtVhkT1_y4WkwUX86
 oscODwo8tq2QbfXWDRb4LxJBTO4mnIlJzh.cHDXY0S5SADi7v1DqWLbdSvRk3HF7wIxMFEE1ipy6
 b7H7pmf_MlPvvzpua3lS5WYy0jusxG0PBDsC1BajsvpZWa1zsVS2XL37Edy7Vhxcf8zzLQ81t.Qg
 IHRwk7w7lw.wAfSlt3TQI.vFVp6x1ovQzfXkoyEcNLcTOO8GIpG9ujnOoSdKGLB7uYBvKbV_r.Sm
 vmxAjNLFwy.EMYzFM.OEA2kBxm4bZIl9d9mX..oy7YI8D5cHAXssT3mZoqSwXy1G_9cDr9dgDWSJ
 SHEhUMMUS0xVYwEdp4JTNWN5MpeFHlWhynhFBGL5o9lS8kTuq2GgzyQrvB05AlX_ga99PJagB978
 g_6WFCWdNvJ9VxChWMNM3UDGY31m56V95sG9RA0C8.tPapIB_Euw7kqMi.u1IVNFIz9E1cybPpCd
 Kq_b4MfXQBfwOkc4VQIanklOGjEyGiBVHn8TZZOgDcFeLvIpcsrbvQPuX8vVbzyZaDY_jpf3D2T6
 P31laBSqwv49zNqp1SJKBVhGnChY13VjgHP2cOgwOQi1RBZpiwQyIROc1xyfVcnx3o4SrVGxiQkV
 TDb5OUBiNmgsf63IV4zBNb3HiP3qjGl3e8o9Ey22POEVOyciK_fH3HUZ.KHHwf6Oc7bLm9ZbS8oR
 uYBnYN_u7yY2juQzBe76O3SX7jeyLBaWCvuaR4dbQtZEya5QMbMsq4Ovc1kyNCXA9ioWflaSqw.l
 qLKMiFo2GbjstaPYb9NFw6apSDA9sDNqwq6nxpDaQJbmgcP1SweDgd.esgJD9iqK3qg6e3iO0via
 YVmb3F2IF4nHfVqHidLUlppHm9nyf3VO5ZGFphqqZ2jwAIxVWRbba2B1We.1vmrRl7IVGqBWDpwJ
 IgbPdVsGpTzMhp.JsWNXiKJLPj8qKEgQ77Tzg99UBytViFklj9VPG51o_FaYiYsqQKZf2Ha4BI3w
 7ep1LFadvfDx92HMkboAPS6nNDGrZxRkx2NW5BjcmIE0XZMXR76y4NDB6t2LLNk2GR36O4wxA2zo
 oxNi15qQNg8lUAL_ifNKx.5QrKkdYxNHV_2r0o_Ei49Gm3FbzNjA_CWEUIZIjNqnr1KSVhgEXk_E
 L7MLivzqC4Puo82vykhQa1oiOaFpGhoPZWCca97zAxZmD4uNjVPWyGNfWLKOD6WfCUOWoLE26fXe
 Ghv7nDMjd1aWoM0VBvWChjJp33PEIoBpn6gulQdt2Zq1a7H8JHf0tZW7hl.4pyL5s4GvTaC66aXC
 cpDVUycG08fQhjyAEpdRPvljKc_njgaZBbJYMVDsSSWSAkf4ktscXGVQJ0P6kZAcj0iV1Mb3bLhQ
 jefDHMDbg23BdvhXO15yAT4ccWNe4udTW5nsJIo7vBxZtJgxmToUkOSmDZPi0hu54SRzWOmioHbg
 u5FVEnZcOspJV.JEcTj.mGcaZ6ZgPZISjM98PItEru7_6LyM5.wYxyci8sX0hgb4GEvtwDl5PrpS
 m2CD7uWhdAeDi799MbvxlMgC4PXHe.HY09t9VHYg4G9YzmLzDYG_PMd6_TZeql.hzfKnNBph1q9v
 mpblKBWqKFrALYMo.DCQ9UMN9MEVAJyD0ONJDcystSyVieKmL6AO9hB31vlQRluKGFIzKt_ayvDz
 qdiU6sCbk0bfJ0q7j.HP4EkUzgZWaZZpOQDN.8IZTRh5sA_oP138ONgG0
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:04:02 +0000
Received: by hermes--production-ne1-7459d5c5c9-fdkvw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7521274ed3fde3701c40279c1a2b59fb;
          Tue, 28 Jun 2022 01:04:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 10/33] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 27 Jun 2022 17:55:48 -0700
Message-Id: <20220628005611.13106-11-casey@schaufler-ca.com>
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
index e8e4a7a1029b..029c23719a5c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -522,7 +522,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1279,9 +1279,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index f2ba966c8838..94537d1feb9a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2668,12 +2668,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 552a08750843..1e9c06607c39 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2006,10 +2006,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.36.1

