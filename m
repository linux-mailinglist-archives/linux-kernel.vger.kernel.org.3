Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE0505BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbiDRPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbiDRPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:45:16 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4295A0A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294676; bh=SEZ5yGN4WuR3EQqQcVrWwReXijssZ/504JFMBxTlkAE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kyLPaL4WeF7F2AiLwOcftuMtQNiMP8QoG3pG81D6aaybK7T6+sg8BLPGATx0rJWpOnba/s05Ib+vLMGEkCYROnoCBWATVt2ZxOj+8T1GXtjAKUFZEmmjnc2zUU6rcIo7Cgjq9C6lOXw4ee11Y9ZjbXvjRi6Qo4xl/qxAk9JqRxt1EuX5bYnkWoYUTyPgpbJf5AXJYCtgeXfGi2a1l2BO+B0g6aMdsI71MrMl3F6fpF0bTzvkFLRj0dIafAODcaFPA0t2zVCqIKokVPKZaoK9L3M3rYXZHCVNxNI8Zbi9vJyG8axWPuxpOdpzpccqJQ2/ESGwM+l4BrVoT8oybb25Kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294676; bh=GX05bKaWTQ6G1QuVuiX9cQQL7jCv+vajwL8haslE5F9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UgyfWZVwVxuYq9b4kUieHyR/yqDLpOS7dxfM03rSuyI/ebaxqavw6bC9EP5o+x8liSUMbkGogifi5xXEF77lEeQP1UDAtHlFZ5B9DeC2iH3pWP706vhLkWbasAvWENtw2O5Mg1gYUzwWcD/VeKXCIyqOlt+i9Vvt2UEsJtPaEkSVbLDhOz1rtrNlo2ER9PkR4KY7OFOE1F2zVV+PntT41+t/WSgUSK6pY5h1Fh6V+jVH1ZoU9O/HXOqD2NJAcJuEeg/5wdlTHq55eQI2yK2I6uVr8ZbRQc5Wv7z5ObBs2CCQrORALz39Zq0GzzWAq30Y+QfHFBjnGiiPkBO49JkUdg==
X-YMail-OSG: qCH712UVM1nyvCBnbiv3IIt8QeVbofMXB5wdpb.szoeoxNDKs7Nkh5CTW3EV.1n
 zzRfLQlf8Soi6.hsDFnF7HC_dALgqTmjq6Nx9etzIs4Za0ClkYCy_UhDoh0LTMe1MvE6PCroBbBf
 HJnb97azTFt7z3E957G_eFOXlmBlscoJ08ENHYXizkSc_2tywx.7wIvLag9s5262htiC.7gEezxs
 mHNATzUDPfxGGqYSVfphxhN17FmD4sdnmOH4HG.XlR1dGf4zNM5Ohpd2apLwmmPGhooXpJ2k.bd2
 NCjqpPJRKqEnz_cQ_vPbAZ4HvUo8KQIozp9MZAXemnFkxzxOoWR76RJhU7GdcsY16tEiSg72bgyY
 fEzF5zggqpigMZjeM1noiKJGD3Bl3DUGVOX3Mt9X0uSrnk_hR9ms0jmKw4wiQWqY6JVA07NifBUG
 ZWCLKlb8m8z3jk7vcB3go_6ppSfYaiMxtOCz99ni2RG4ERHFbQHMBzMHjrSDw2t8MQRLt0Rwlz8g
 vzGS_nIq84kW17CiBPeY9az6yd9h1LTfK69ry8jRcwGzBoLz3gOWAUizdqoyHlrR18Ko5pz5PpnM
 npV0zUtHNeuyPbantarBOWWIMG8r3cDhJ0cfvkEUiqPR01NiTRZ31WGmhK7K20VuZCvNcXD8reUj
 4H2pro3R6s445mcG8Y6vehc4lhwP0ApAe24imKaR0i46KgUtVPOZlJktiVRBLBhmlJ4MtzyqwGTv
 HxgQ6GIRjRu5tXRBqo0V2BYRGrHJwizftQ6ttuKX6yMK3MUPw0vhtinmyVzPV9uohKexjhR30VaY
 i540UdBMoj.8U4Gc.hraS7PH9egqtV1tBI5t26Yx95N1WuroaR6loyz8cFXAjI2DkT4x4YWWKQyS
 qvE1Dus2_tu3xSGlCTGcZfR5BMsDMeqia9u9UI9kyRNPL_hPiWl0t_hRhvn4mc9zbqCfghODQGCH
 5GYKjQnfW.BMqlp8StpONtuZz52CCx20I3xtxa_3isFpxPO._EMSNfTNQc0vKmmQG1uuTeiMWn0D
 tm.YChqb4c0XpUan2HVU7e3RLoEO8cI1zANOhk22klroo_zid1NnJ.qbR9ns82gkdz8qnyOES46v
 5L4VHENVZ0uQ8Yvf4721txvLD7BY0yTpqO4BklBZWmqERrCr4OoTNrxCRwbvTYzh8yxHF.EyFzyQ
 01.NxYsNBeRcrkiOu4skwT1QOEH3Witt7QBGkNJerKWxjCGhB4Mcqwq9TMmWfhx7FJZX9g6IYbRU
 .lGu7UdmYa59u6FeUvMYeMnbbfXghDf51SpHm03PJObP9UEjjhSN2ZYi.KRWrpc7R3ateG9r4UiJ
 tBz2rLJ6CDjCr1_TFcoYv77OHtaNOvT3ezNMp_01qtDluT4.MeEx.6_kg.jOYJWVMkBMoHbU8DA8
 DsASTLcepHCXqt.29ojVNilF8hH8U0QZAIFf23rsdyqID87Ewljj7ZOLkqUs0aijkVk3k9ehYSGG
 D2w2mrErx2Rhp6sUKo6DtokuiIsjyW1OkiCmfOO_FMplOUTPg2mpl0V01k.88cubls.ea8r5W1DD
 cjC4UpgUw6Inj.nLYyOwPr5w6NLj2D3GoSKZpHUkgbGL9ztIaL.9aT3r65IAFWWfX6LNaZqNes04
 3iZIw8aPaKjO0Z.mrZAOSozRrH5xc2ZkLXYUyKMH4aDqOmbZO3s16Cp.VTYgB.k1EFooFTFC3WVk
 JFlqw9uxT182XnUxPi2QdBCurUU8IDaDFk5tqOq2jNTKjW.DC_y4eLss4PlqGDyFWneUKNSOQISF
 xxoKN66kThtdje99eLSM8WLo3h3xM_x2yx89n52rUJl_A57cl_jAWm3XrN1zwo_4zsMwq77JbiW9
 UrCVeWoKjy1zuyxICpVT3KgyruVlS9q7tk6RuH3Wu7n3n7P.0Z4iM55E5Gs7sz9mjt.9gPAM5vfz
 IMtBUwidExBs3LusMonh1Ze.p02M75u6MFEHYSVOicm9z5NR7tIyj4MAL48PozDJdtCGIvxoItHY
 6J3aCD5Yo645RCm9mO3Fx.D7NBcfYjJ4UjkyO.IfiWg0VZOVr8lCrq1u49x2bD4AkmZv4gVJsPfU
 F4GTIBbCIFG_Azr9cl0r6NXtk48pB.Jxz6XtBk0Ygq65iSJ80T_QsbeK2qtsF8cTQNmlYuKZhl.D
 x.BPaf1Csb8B4wxh1gSjytAm.ZajKiHuW1Mk2loxrG4WDppVLTh_fOrQGZfyosBj0jG4jAQX_V7G
 n07h5l.3fuyx.GN1lK.5cmgjz0BUQEx5m7p5T8W_YuwnkEa7eOIyot9vZydrXUfeG90ci8W5tmr_
 .Ws6N2Cmd5aMgwzsrmTiB.pOZ0iufOEf0Zh8jmzwsAHhalwyEejnr4E.pKw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:11:16 +0000
Received: by hermes--canary-production-gq1-665697845d-2b87j (VZM Hermes SMTP Server) with ESMTPA ID 325f6f931fdc97e0cc6b332f80cb9e73;
          Mon, 18 Apr 2022 15:11:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 23/29] Audit: Create audit_stamp structure
Date:   Mon, 18 Apr 2022 07:59:39 -0700
Message-Id: <20220418145945.38797-24-casey@schaufler-ca.com>
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

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 12 +++++++++---
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 28ff7a5f90bd..6b6c089512f7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1822,11 +1822,11 @@ unsigned int audit_serial(void)
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-				   struct timespec64 *t, unsigned int *serial)
+				   struct audit_stamp *stamp)
 {
-	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		ktime_get_coarse_real_ts64(t);
-		*serial = audit_serial();
+	if (!ctx || !auditsc_get_stamp(ctx, stamp)) {
+		ktime_get_coarse_real_ts64(&stamp->ctime);
+		stamp->serial = audit_serial();
 	}
 }
 
@@ -1849,8 +1849,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1905,12 +1904,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_get_stamp(ab->ctx, &stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
+			 (unsigned long long)stamp.ctime.tv_sec,
+			 stamp.ctime.tv_nsec/1000000,
+			 stamp.serial);
 
 	return ab;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index 4af63e7dde17..260dab6e0e15 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -99,6 +99,12 @@ struct audit_proctitle {
 	char	*value;	/* the cmdline field */
 };
 
+/* A timestamp/serial pair to identify an event */
+struct audit_stamp {
+	struct timespec64	ctime;	/* time of syscall entry */
+	unsigned int		serial;	/* serial number for record */
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
@@ -108,10 +114,10 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
+	struct audit_stamp  stamp;	/* event identifier */
 	unsigned int	    serial;     /* serial number for record */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -265,7 +271,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -306,7 +312,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6fe9f2525fc1..557713954a69 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -992,10 +992,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	 */
 
 	ctx->current_state = ctx->state;
-	ctx->serial = 0;
+	ctx->stamp.serial = 0;
 	ctx->major = 0;
 	ctx->uring_op = 0;
-	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
+	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	memset(ctx->argv, 0, sizeof(ctx->argv));
 	ctx->return_code = 0;
 	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
@@ -1950,7 +1950,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2066,7 +2066,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2535,21 +2535,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task
- * @t: timespec64 to store time recorded in the audit_context
- * @serial: serial value that is recorded in the audit_context
+ * @stamp: timestamp to record
  *
  * Also sets the context as auditable.
  */
-int auditsc_get_stamp(struct audit_context *ctx,
-		       struct timespec64 *t, unsigned int *serial)
+int auditsc_get_stamp(struct audit_context *ctx, struct audit_stamp *stamp)
 {
 	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
-	if (!ctx->serial)
-		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	if (!ctx->stamp.serial)
+		ctx->stamp.serial = audit_serial();
+	*stamp = ctx->stamp;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.35.1

