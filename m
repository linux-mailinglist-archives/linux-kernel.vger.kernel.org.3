Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D48545863
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbiFIXSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiFIXSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:18:12 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4669D222355
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816691; bh=6Nb0JDc/31qzPS4c4yxybIfJasL4YlAX+KIRxleXfqs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l3+FfLwTk9e66cBgQIhiKWmJsSLBaXb1jPWT03/zuIJRb7hB2y1gzkx52n7vmOSp0YAjHNmokr8duWUto+3qnpcVlXae4eHvnLNa9cBeLUONigKxtXVnwttvvpJSblTA4I87HuvngiQu/YkbvKsiCwDa2PGwdhA28gprFylHrKBGqtDuzDjmXLD55PEraJjOYR6px+DQv9Ndb/3Kcdi3VFQ1HRXpm1hL7LDWSa5uk2Uy/evAtu4oPVI7FbPPfslfeYSYLtPCpangDNsXLNcI+bPJoaqQRNwCerlhr9K+m2H6vRKfaZ3kOeVCEIIPnZNp704U7fTXUiUgshQnjbOcAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816691; bh=/AvR2TI2eJnLkdMX7ZmyQot2H6P59NTs9xyMhKic61O=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=b2XNVHkzeOhM1IjT+qdlsaH+MZW5DFIfDHbJ+z8qg9KqyUP27zkUmJJprTof1bBedOYTh1jnK4RCqpCw3vPfe5gDvbiiETcuJbUFLsb7PERPgeaCAhTwWRHFs+H2cbUYvBcMbdq/lCTZUL/n5M03FwYTaWR0OCuoX4yi3pOU+nG9jFCNblfa4I/CQ/TNIqYFQ525bBGmofQk/nAtgE339QYh+N2du7ESGqmcrZQ59ZdPeR16SskLMxRdiAJZWdvlRoYeQtDsdmDg9/p/foemOrrWXXWqplZvAy2mvCiKjoAGfx3OrEuoIlDxS6wmbCzj5AjU0uhCw4aR1fhYCX7vWw==
X-YMail-OSG: WbHUb.sVM1kJIgoeA8TxLHFp1DO0DNsd8FPuXB5Flqt6FFAi1k8ptd7x2r5sshT
 tJz8srgQaOzpdKWTOTgfzq9crobr3tZvyEEiIrFONv1SIBDPh1r_y.Rsy0Y6LIKISlfhQl5xSSNy
 Mrz2Ceg441eSKAWHb6ZewjIpEX8gO4MqUFHOnJSIcMoGYJk.3hls01KToM9NNNn45BjvLLRuMyCG
 4RzbDM_V9RDJruoee21IsmIReKr0Jmh_rcyuP14rNbtPXXTdYKeAqdSY77dEPIiOF41tYNARsuNn
 zlYO8mcNFnolTB5nOF6vx9aaP6vwYHh17Gne.WDrXVc7ZMqerp9Vz9ttYTgaKF7c5n_D1x4qH6_A
 Ha_VfE5nkgo.YrynCeGDwOlLENy2OZdZ.Prp._NPVZSM92lBPgK8cUD9l_AmOpqcMeIuFkRN431V
 xn.hDLQ3HpQd2NdzKlQDHzFUF9XsH7EWr5pAEHy8gFvamP3oJSxFIKqv4Hbvu2Biw5EzJDhTa6uu
 YuumZSZ93Sr3svGleGzjlK4pBu8_sDElkYwaPQDVlLkWnoTXWpXddA5aTap4Xm5b8qEA2.qbFH9s
 v0KTiqLLvc97W5nBrewgjfq5jLtuCYUnioptqkppI4d0P573Ik7k4ap4Lj4bkKKT12IdyzQuiLYK
 JJ5Zl65uj0gQg4gLKCzmcRXnXsWKpoZebGVI3DLIEbe0lvLvp7c1Gtv2qjk4WVGmbjOvRGkAgiAC
 JQ90nNBYc6r5L4rcXWALLH2DbDWVIn.yV8c1OxQieRKJJ8WdPcrGxkJ.j3rBSCjTfHKtm1nhbJRW
 79qMM56qU5l.nPh9icOAb64uvy8GvSXC8W62EsOvJKGnPx_t9YZj9lFmSUbAhTIkXfGMjDv__szY
 k1hDWQNEDh6616KwJ5HXer37teV5mBFwEIAm8WHbdK1T9GiPpKQnSnwNBm_vaLXT8.T4YGImr9Qt
 CyZVoWtpdSW9vShxgKN98snpM0Vfog8Cjecn_yGptRmyDaW2fruupIMvDb1iU2g2KfR0FXTnAWs7
 ScmzBLbFzYy8UmA6qoBaAyXuZa9bwLtsKdm.WhdMIAr5yNS8M8CR9vAlva9IB2vqsTKVUW4n.gwN
 W6Vl7X7q_w6KD6q06XfTzMNN8tg4J2Is4mBUWbSgJ.cZCHbj_D5qXwywvxQeiOh2_gt8EnXGaXgv
 9qQfLizUDviCmf8ybpkaYCY7IBEyYinKl0trukvs.Q7Sa.oDEwRK1dS.pKVFWXJKqci5Cejhi8FY
 t1o3W8V4uRX66vvw8aw.wFRmYOJScGA4zeZ2yrvLKYkmWQwoZmPNhWFrPnkUpwdV5jAigH9tVUfQ
 X_WUZxg6II1qtcao4WvGn15eTHuNftdourCpBhBhsAdGSZoSmLSk4Nj.7dnhK0JrA_EBQcORoeyF
 fcmfczj396ZPBFt1wOjtypre4_DiD_BLwyMPVvNUz4Xgywyb.Z3oDJlcA7im8CzCQ_Hnj2k8iMYa
 wOHCZFp.zMilNqyLgCOMyzhJiLGUSIubvvP0Bcm3Hdl78P3ZOF8tMK6tOC619Fia0xU3LiZC1rSG
 2m9ia5W1KMlARfC0hBkPPMwhufDf.WD173ka9xT1Bjr_5xuuP.zrM_Fz8YbzSYNTXUSnRRZgamal
 GsgA7WMTVMdjIk.WfwTIHiiabVpcfaBfV7UfEyfn0WAOO8YhvNMt8F2rdgAGqNdS8f9CkJfIjm3q
 StaXdbDbzb_Yiqt07MiabDYaSuCxWecML.pAKPxOwzr0WZXD7_6k8kk6.n4ApXlNBYsP7KuC4LE.
 rlIXiNB1fgR24BYJy24l9bhVfFlV_w.pqwYUXy6CVeTpN7F3xqOKhsga10qDXW_w7Vaiz3xVnZqn
 ctN2W6C0M4eKf0UOX_vgkIv1SmZRkXMK3dYyHjDpr5P9fbw31zLQp32WAb8uKXmAxr3c9MqP2nTP
 cz0MlgdCAlEvZMw6gtZuyLa798zz0gWfl9_I7Yxh.ec9BhyqOVWdhCqQB8KYOOCvHIlld59Dh8e0
 b6lE33I.0lVonOuyZWIlZRXgbeJMM.AYkzazPjmw5IIIfzQS3gWSdEAp9yK4bswcg8K6LdWY2KZ5
 tvyg02eqF0MtAoPIlADhcri7_TPJkfDTfoC1FXCg5EqZsZMTGqMOkK8UdQulu.BTEBXglKzW1RqG
 dEEparigSBMv90N5apQeiXNhq0BIbeqmXmzIom.YmqvmOmBE6C6l0BwtUMQZxq1jcDsIa1tHdhhI
 3_5lpMOwKDs58kxPtrKD.Ia3jo.CWL8lO4VHvqjbG8PgwnjrQmPUDIH.xTnLcWGZAnB1yH1oqqOQ
 9YJqxvwREcAdT2dy.MSZLC6NkkTCdjFfFYnzWRsNFa3NVJP8PGdgT72UzKw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:18:11 +0000
Received: by hermes--canary-production-bf1-856dbf94db-ld7kl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8bd0cd8ed239bc60f51b90fd11ae18df;
          Thu, 09 Jun 2022 23:18:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 31/33] LSM: Removed scaffolding function lsmcontext_init
Date:   Thu,  9 Jun 2022 16:01:44 -0700
Message-Id: <20220609230146.319210-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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

The scaffolding function lsmcontext_init() is no longer used.
Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 4cf551133e99..5ff363624b82 100644
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
2.35.1

