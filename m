Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610E55DBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiF1BPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbiF1BP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:15:27 -0400
Received: from sonic313-10.consmr.mail.ne1.yahoo.com (sonic313-10.consmr.mail.ne1.yahoo.com [66.163.185.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB522B21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378926; bh=Hk0WBtK4D3OqOZvCSB9KeYrgeUYKdkB15gwFKpd8t2g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ve7AZaXKqeCWtxPunpmuFqlVy+L1WAnq4ALGZkALTWt8FrO4sQ+lnnghPC4YUo2JnTmu/xaj9FJJN6MAAGmVKWklChYli3h2Sr9RPMY50lHTkhGGNwIRQdWPj0SHJXuXzDvMiWI9hUWvv2wONhOCdUhrmkxMuvDZb86bpNGvFRtc9PAUBul5BPfv2ihARPgG3dj1rvwc8yVpMIMu6a9fkOh5/k4py7DS4S7TJYly8yPetTPFEXWi+JRZHyIW8aoJvXBYgW9DIpBuG+tAHGmiD9OeIJFmcLHGtS4ETgi7+LGMa+v6+WIy/8m5cdXLOUXDO5T0F5pCA0kKUz/xGhcR2g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378926; bh=RBKna2kxczitdZlkaBiQb+Of1DJWN0RQfMBfHrJ4vEG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OL4jLjiHae9lFIzhr2JIrbfmk7X+/fjI9ph4pi8Ta18XhUnPJECJMbpD/mIPMblwl4p6jOJjQfDG6PC3Wb0/uQKE06B7oQ8NnlZRCQ22GL/ST0ycXvaygzq6kbO57Liim7ivdBFZMSQZoAHgzcJ7p8EAtRzPFvCXVIpeaphKZ3yPzyXFcpS367eeXxpe9aUAg4dXF6xcgJSBiSYgLvMMVf4ltBq7KWWYlGaJVwpiX290SqRJiLM070XeWVENWC9/jIG40d/VDcVIetVeW5mHH+gwy0Gfx8Joi8ApJffugxPciNQRF2CGbF37ee+dgarviPdqeCVippyzBGfXvLSa0g==
X-YMail-OSG: pSBUOE4VM1kDLbWf.pYtrweVKEBdxTO9vT7wGj5_e2miRYjEyRk.uAzC5lVCP6R
 KWXmjHQKyt5C.UmWN2XphFjdKZNogYoOZ0VDsD7cbi51K3Fj4UYV0zNBFYI75TKavqUPyWyNV1Sz
 j25LRr_Z_izP1MqUzXwe9OlwtT9iBkBgfwIdPmz2vyEuDnG76Fjs2zO.d.4GzbCB38OEYUYoX3_v
 BmeUnefyvAijwvExGIP5iuaKDrKGVhcsladNnkVXR_jzczoh2G2jfX._KiV2.0mojqy9cNWtE95x
 UKvlpjDazla0Faj4t1wKR7M_m2vYr4mE_4frKmzu5gTFzKRnNH7mIreX6Sahyb0Y2saY76XWThId
 dzkUcnK7NLyvK4LT9yyxhSU1JXg8bNzljC_KOIwMbGCni95XoNEiXioy4iUW87Spzk5gHlJIHd52
 Z5FrBIsvHvH4asFGpXFC_PuzFndX4p6gsFanxjxHcJgYgpEXB7sQrm38IIiUoPFznTyeccVuZG8M
 ZzeEKn8nXQZHZlPN7_rrGPWLrCtIfJirhnNYj_rwWAAVUcvfDI6Fz9G2NFnCaK4Je5_P6cCse8R1
 6Ei4eDVklqkbQfbuVKwS48pQRV4JZQWnyFnRFK4TuZlXv8YxLRJI5xgmMX0wej5kKrZUaJSqZt2n
 f_W6DqBwcRQcp5e517eyBuDK_Sa9DhGG3o1WAOrOAF1wNE_nYMIdnry8dpeQh1N8BJkDBDWPBVnM
 CkmY2gN0n7ljlYdKV96ICf145Ok3Vo.WYLLXxNxWBJuHkQ05BW17i3GlurJvGZsZHcf.h4LSn4c0
 0UgMBC380NisyTCuzhfMbPga2rOzuOVcOP3cSAo_xxXNPe2Xj8FLXPDDIxhnU559HTnG_O6lU6FB
 4qTTOkGqGz53uRnP6f34FJcx_S.DfKwqXi4VKgZVe3AVpn0LVeLb8WlNxxXWfwsh73TpGeEYFHew
 qGIn.YkzOBbavXnE7bCe2U_Lmcrvec11Z85Y1WI.bRr.IGeoxtVd4QTxiUkvr_0k.3fIrhk6gwu2
 gpoUX9_O48mWt4S1HtYKaIytEXQg.sV10QavQ926HAO2gTeTRjtwNUHTyv8Usz6kwlXDgE96c29p
 jtW2wReTob5Sjh4Yi3o31mjzw05tkkcEorGSLnSJJz1.VTh_x0.SFfN6XdK5t.sAK.mvW06Bfkn6
 8QBR.11qCQTw3IK5rxgEB0kZko8ILN.sM5u_0dPZH7RKh8p10yyM8OKq_r3YYZm5_1TubhnakUhX
 UpjCP78orshaNgF2G13..lLy1AsfUFAdKTQohzHYCw7FOTnUROEhMGTN8CUWeyAoAY.Z_5ac5IA0
 ve0ijIn1APZndajEWFbg46GCBkfyixHTU_NAYO2ulzjvvUZEW8UPSS3JYYtdUoRw_Bl4sQwEKLmN
 f99MJI2CcvHeulZEPoosMNBfG5Y8ybuuEUSK_1NiT7YIWFh5veGMiVZ6NeAqEtxBuGyMI6MeaY5z
 XNm2kLDs5wpV68dxiO2dLHwlRAwqa1nxRi3XJ5SSmocStJwiSz0ZPOHUeUt1rFZKBtHDn5aLhA5D
 io4jRXmb_2c0ntRd8O2SnTUSpMJ_.Eyff1x6GQZToStLAnsNjw3D9ZflWqpJMGUC781KEoRvvdqH
 lOlmUN64K5BcPA24F7LnmpX3QpRy_sBopr39Xx1FOPC8PBQg72QWo_vQdkjG7sBrUA0dGwl2ZF2n
 FuQHdvcrmtdHACYeFSMymhnkE2EYNEaK4hUhKKI2nyMW9zhZTLCoUA.VRFzLVLetMSdw2T9R4ITH
 fg90n6bHklOFpU6OcfmYAoqNeSL3LgJYAc5oEl6vmHYlnWnK_dOAg.UQugzBSAinEj9dmcV.hyQN
 F9.Dez6EFnR3VQXpO9BpLQRAq.1ux3BGFCm6UGYnYSP4u2RQ00WBVvr7aaqHbxP82TgCYajyqm2w
 EAHdkeQiexN2H5mRvP1NbMvAvnw7xI2GyAHeaVbGyAXKX.zSdj3EpPxjtsBZlMneG9g3vu0i.OdZ
 Em3_GRyvGzOjy.aj6lZQApi7Z86bm2F5j4vtHzyPDG6ZibFg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:15:26 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ec536e7148195aee3798b7fdeda5831;
          Tue, 28 Jun 2022 01:15:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 31/33] LSM: Removed scaffolding function lsmcontext_init
Date:   Mon, 27 Jun 2022 17:56:09 -0700
Message-Id: <20220628005611.13106-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scaffolding function lsmcontext_init() is no longer used.
Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 890a5f9f043c..a7154cc3ffd1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -149,25 +149,6 @@ struct lsmcontext {
 	int	slot;		/* Identifies the module */
 };
 
-/**
- * lsmcontext_init - initialize an lsmcontext structure.
- * @cp: Pointer to the context to initialize
- * @context: Initial context, or NULL
- * @size: Size of context, or 0
- * @slot: Which LSM provided the context
- *
- * Fill in the lsmcontext from the provided information.
- * This is a scaffolding function that will be removed when
- * lsmcontext integration is complete.
- */
-static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
-				   u32 size, int slot)
-{
-	cp->slot = slot;
-	cp->context = context;
-	cp->len = size;
-}
-
 /*
  * Data exported by the security modules
  *
-- 
2.36.1

