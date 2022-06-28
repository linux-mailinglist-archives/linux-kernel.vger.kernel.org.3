Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1B55D4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbiF1BMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiF1BMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:12:18 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F7C237F4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378736; bh=+syZOcwBmdwGcbnbdg8y7i9ieTrX0HVN3F2iD0fUTrI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JVwzARAgeFTzRBUF/GDuQz73czbNdmQkD3f+9DRhWCN7Q/yhzXxE9zVUOv6yfneXY4whZRmfjfy/satz2b/X1AY7f+yB0kRU9HOX+RGVXgv21Umgsa3JAYnrVyGjY9xYmo2+jwFvBpv85K1rHEBsnu0F9wuL9GOdTaRz/qWkEXtzIyA378buBe18WxAYr7oXIaSKJdiEH7XVh2a+rmc0lUHKGzzlgR5g7jEMmhLRJmLtTlXTBiOd0b5OAYj/dLntv76bNJb5D4owTH4wdTl0VbDaJJc6idOB4UjZIWsL7ZT/y5fWYa0PDnOdbYJqPYIdWu5DZWo7x2AKYTGKFPeogw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378736; bh=4ft9wGTnxjutl7x1hW89b2sMH+5gk4GzLBbv25534D6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xk2Pe3it55U0fq9bDFLYxw4kedCA6u7lSUCIRNqFbWRKrIFN2ZnFS+HRanKE+w1FOOhWYSw1HjegT8w3Ks9IAnTzurKNSatySWgLSR2I/LJyJFJHlpA/D0BoDoZOHNIbRs5G5Z7VCC+1WVfeAK5JFoqJehXM0DvU+nDiGSwuX02+M3TWAFf3PH5mfTPP3F50npg0tnTLlcaI1Xf+W63Y/VJt2+07lwnuQmaifIky3RNXRVT1wa5ldY2GLS+OHMad1htvkgeAiCXUECMaE1PU/Ox+sT8QYR8+KU0x9tqWp/wgHvVa8nLqXQ76zjH3XdPZDq/Vayq+CwKQH7yiFDtYBA==
X-YMail-OSG: s_Z1mJwVM1kAy3THo1Q3IaxjEunDl3yVjgDK7jS7KFd5EMyO9eE73AO__PmWlQk
 yIQKPrpn2ovobBOoDDp0GreFqh7jGXJnPCOXdGCd0m3a1eqGxP0Pw6hNhPZfBi9FJ2PIEd4mSMcH
 eDdUJc23qt3hFtIm430V6GLz6nrWYrUP5xh5LLCO4rjDCyAtvp3PJlzCktcO8vPrMXpo6XSyefcq
 TXRP6kp0SS_SG2zvbNhXcaYB42Ygs.vNfGGUhK2ECL2WfmiSSPRU6HMo0NYDq2QERM0Ahea9k3jA
 8YdOqqvvMF8e8kg04T6rI6s3SZxTi8gxBKEmKki83fT5R_smcFr2isKwtNElMtcb.S2ZGbail2l0
 qdpGB2GeKTEXenTZgJqmWIzm0XoGVV9GyEQlLx4E_eOURLLb5e7OuFRM7VX1fiTSosnxNQDeASdB
 5sp9SFG51kDimsgbKv2Mu62D0dJ.f2F0r1gIu.d1fMIy.K.XdZ1fvty9wgsZgTqaF4kRJ4v1PhNt
 8nm.s5CV1bUvHlVWJBbnDeYQZzMB9zm6z9bo8FGCAc0.l4gucN.nrCSa25Jna9acLbu6aj_06lqh
 Ltg5e8MQJuJxdbapDHpwK4onhQfMfMKYM7EuGNVeKSox_iaHnPemQxJUbw3U8QvDuQ5mYewgEeJI
 D2k_nOh5TWbJz3NNxnmDAGCypmtCuWGNs.b8adByV.EcL4a9m8gbuE4DdOhaH5aOx9UQrbIlbQop
 2JP2VQK_jcg2hsv3vY_WJMYp3zY5mAndKNOldGKMIjz.VTSiEaMAvfl9zS5aOVIKlDLBpA07MCuO
 Zilq4FF27ZZGrHmt8z2vh5cEMJawmz31pyMq0qC8QtQV5ykoC2P6H6KipdsQ.kw3tdUOYDUkaVJ4
 E1KC8v9Tbui2drD6xcitoc5RQuY4Q1SG5Ip0vReuaUqvfi9LBLjI2SyoDGyL9Jj2PH2Pb2paUpUQ
 kuL2XNJoTcHIH3.q.6g7JSTQrChog9_K4WjTC1Igd0Eo..ryFDtktyttdHIsXhMoeIfg.SeDgOsz
 8DsNL_jwno.XxVl_VY3or2XRpsbejyVil2pCMw.j0k68pKQ_CqRDvXX6QTYzVwZKKmUWLmJsufRu
 Sq7bEa8kG_VJBOdqKwZ5xVobk.ob_Z3zgFheRQ6H4lUP8v_OKGWb.1SwVElgYMkyxxCG3y8rKa9k
 vb2hh2rfH2ti4orvx5BmifrmJnwdi290PztYA8EvjQv9IRvW3CE6wG.5WBAt6ufeqR3MQaZKwC1f
 dMuqvoL.x9omxHZD.DMotZ1gXvlQoO_VWkwG.YZgrFyx49EXaNU63PazqqMeY2Co_7c4IU4KCX79
 4CqDzQmpl_z8o34B8R3lgYHjipNcaWNWKILKT9lSA7BIg.bbL2hXuw.XNB9sysAGDIJlll.tshSl
 u7TEeSfyyiqjLZ04XblryfiAl1TcYvlEEimvzfVY0pBuebdig9xBE7e8WsTsFK_bL0CfqnulTSGX
 cIIy.dj73uKgJCI8FKq75C9Peqdnv1Bb_HjHOsfLQb4RkNAiAuFBY2SYcptU7lAUNJ99xuMXmdur
 2zrsz0B4bDmm94ppQL7DkuEU4BdEz4ND1HlpDiWx.ynsfSLE_rfx6OOsg3oNLPn2QVLeMEwXhiLp
 .4at1SCctPS1U0wDBWcB4qBJci33HziMaVA0XirgiiMVpEaWa6MNt7hPHXQ25ps8fOw.sHy9Kc7J
 aGDEuzIC9gL3SfNO4Vjkf2hJYxEUKEs8b01UZH5LCv3jl7MZNGYmV_OUp3Yb0.il._mkwNCfizH9
 IrazX8VSDmX4.ay6qZB.O_WLcm3c9iNztelrgUt.YDHMp1DiKJ6LX6au1206.8zoAwtKTZK60HHi
 Z9sqXRJdXs66EEHO9H0mMPSwYIc3IDy3Iwka8b3Ktal2_L72mpq2zzXObOs9E1EDuuXYhWBsEohb
 isZ6eK.WCfydYKljuiBhQCPr_sGMBDfwoj4lAlJiIM8kSflfSMxGyoqdyDu_j0LRyE59NH5YiJ2e
 7yHkMA9w1RHQndvVhOQYmA5HnavDDUD.3YE0f5gtCM0Z69cAXLU9npkUH1kGJNbb6Kz_P4TqTCrH
 9gZi67mtAA1xQyd8bA2AzYM7rsRfezWVXlqr8_sRFu4Oxqi2lRmHGAlKJ91MMYNZcrXdTbsB.95g
 7PWcReM0A7TJYZcETE63ezk4LHue9i3cwVBy9RyRrL2tfgC0MCp3qM1.WTkkgkk4FbMBL5tDkRcb
 bevmr_hL_70nKvQ_SVwvh3OFkL2UFyWx9qpoJ1wWkPC1EZntGhDJFEnOFzA5gOhxY53ltTzMJnOs
 3X62pHQxerKtPl41sGaTTpl7XK_ATyPX5NgH5
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:12:16 +0000
Received: by hermes--production-bf1-7f5f59bd5b-zv7ms (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1d422e5118ed4ad306a52cf19212beb;
          Tue, 28 Jun 2022 01:12:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 25/33] LSM: Add a function to report multiple LSMs
Date:   Mon, 27 Jun 2022 17:56:03 -0700
Message-Id: <20220628005611.13106-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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

Add a new boolean function lsm_multiple_contexts() to
identify when multiple security modules provide security
context strings.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/security.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5ebc3ec6948c..890a5f9f043c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -245,6 +245,15 @@ static inline const char *lsm_slot_to_name(int slot)
 }
 #endif
 
+static inline bool lsm_multiple_contexts(void)
+{
+#ifdef CONFIG_SECURITY
+	return lsm_slot_to_name(1) != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
  * @blob: Pointer to the data
-- 
2.36.1

