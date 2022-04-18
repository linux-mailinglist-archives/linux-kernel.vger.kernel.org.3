Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F35505BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbiDRPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiDRPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:45:46 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645CE5A0AD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294767; bh=kMLscTMxM/e+jgLbdd4pjlWQBT9hBPTadnVTTCq3dTA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=i8tHt5fXSmbXoiXOTZOKiHASi/pNm4bTqx1Rqd+K7ElZ379SV6mvG/qeTeHmwVRECbd7JlGlToC/utfly3YGdsJtfr8ovnV1auUHHGOIu9ZuMLa1pKZLgJcgaE/aG/KwZqRgOa4VV38O1Pm0F74vWHsyTsb1X5vBJWQXep321JBO2YCwUC+Zcsk52vMD7iqyPGvmOC/hlyhdm26pImWqc5iyiTVe4iBlXAWlwjqX6cWl+O1itrMJyjJy16ftvaSIggtMuWHetW6RPigHRp3Wcs9vCt7IoMAu0hyp+Jk7VX4Dce3ULfs7MYYa7NIuVDCTKunjAWmtIwfNKejty1n69g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294767; bh=gHucft5FSsROnsYX433jHd9Ha4PMBW4b/VZJY4fJdFJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WUskznrQAXHzyra/1lR7E3zUao2TMbsgb5+qiMXIS7jLsavjId2/l+XUUC9Nd8VuQ3xo+Pnhl1jNT5QBn4WuBC7m7o8r1f9jWaihngwndC+nVUXugA/p7egvmklnYUKAItUSJQiC76T5WSfYxcgiZKVidHwUTZhFPIQ83KyhYKwFjVCiAM0oPyAEfTq3ZYeN+UMhW+icHuDhhjhReP+mSL+lIRDhluc8c9Z0MPiFh1l7NgaOxAqUO8awLhFCJroL7zVqWdsCGb/84h8sJbvQ4F27JhlRI4T+2OEXXyxyGYQFuuH9z1am1cGZ7d4vJ4YwczfLVmWVqMiqsBXKGT8F4g==
X-YMail-OSG: 8pXSGJAVM1njKlorQwrOCZKVoKcNDSOTew6QsUJcpN7glA.ILBQ51KXx8PIwsgn
 uAl7wuztEnq2tE2qljeAfW1_ygDUMvv7JwZRPCmyHy6iC5d2E5FXfTfnbBCpVBNEF73DwszmxiXi
 PJp9GWYXKrR6ECheFSU1GzsjN.yweKHi72aI.Md7LBbbJrGu0LjmPKIUnt9n5kDWPvEQnEhZSEi4
 hIX5.FIlyYPPSC44g07eH0fm1UJKqvXOymyQIOica1VORAsVKTNthXuiDkLYV6k8aGb6mb5L3ykx
 abpuE80_f7i.rc_vqMUigcsfxOvT.jBelAeUlw174VsCc4KQrKr8lzJOBHvlgbPkMkzL9VT6ZsSC
 bho2ZB8vcFigJ0SZtdK8.b3LRqpFsnSGChxmy5vgehjy8.FXSEkjmbA9esOJGiTw9UzSfrBMe6QS
 keY5KuK7H2Ntz9bWfL2W1_HwK6__udva3a6WPItjCH3J75B14ePyeychdCfwa5wWmPISg0hETAU0
 BtaWz2X5nw7fvQJpflwWAFj1RGk_G.OKJ9lArYxVmMB3zdEBSkuZSybT.nkHh.YpRboiNWJBqjtm
 s0vNTw41Y.Knh.Z0XAPByeliLf7CYOw5Ox6SJtrJCApIgkPKRY.JB7EVU0T3ldW11M722cLSejaG
 8fm3VhF5_RGlKNgLhekmUcfX17hxCZy9_E8JmXi_UGrpIos8HNxyJDOpYrdnTREu1m6YFjPK50TW
 Xg.WCjyw6CQG.KIyAmwfmssPPzbbeX0pvDYmexhP0zrKTLkT5udkyVDuYQH2Q09UjO.Buu2Tk.Ba
 JTirU7ig5GzvF92hmZnb36zvsVAfUOoJeibYjLI2VB0e1NrPHYVIukuYk_BO7nChs_1pQJktIsmE
 lGZVFe95RFdypMDTR9EOYroaOrugKTXIJN8b3NInXfVgakZH2zdWdZDtkQfrtJLd1Gtv7NVDDdxM
 cBx1bipw20ZA8Th98mDDaaYkB8YYeB6SR3f7NUS.8.2nfJt7TC4YZg9Jdq2i.ecBTQ.VO7qD5pL3
 CUeQBSCMVqga3TE81YglpbAeW8MamZ7ZL74aYrkjGx4_x.pF2UmlsE5gRsB2J2f8QkSXpP6k4ZfL
 bTuPd8amG1TCuGSVFoS5pNcf2NjKSo0SAorWoBhXj87XPCcr1jY0eNuZq.hx9rdKuZJghKcJgDL4
 Mipu_uFyW.fnoXZfnjC846d4c.fjlRaOG11ZUHDUDWOfQxmbtcR.6jwaU75ULRr1wbZjOb2NWReO
 N6czSli1iluF_YmKJGPbZgNCssXEg8UBR9txVj_QB_1qq5UJX2F3vLxB9WjGoq5y9whJ1tJfKAQI
 44iLwXXtXaDDRLWyyaFXfmcE.HDlH3bc2IqPFjBipILQCKZV.i.lDrRto20cJ1XpvKwK9hkXLYq5
 AwA65MaKGxNoCFx9k6KRDABzNMO48mE0kbkdXVH38pMc2sWjjzeC1G4q1Xr1_Bf8_35AOGqud3Sr
 HnRZ57em8ckTjylBrVbDVW6mjkkokRRoY2i_j8RJL9wpKV3.BsbvyvyTcS_MwOgwPP2EVVlPVS9p
 1dl7hsKKSN6bGAY6ca2ChK1D5wXWvH1zKOMWp2yPeoty_PGOLfDUbkreBz1DVfe50Li5qeRCFOFp
 L2v9cqMV46aaiW8C_QqoN5bW0_4Ya3pBWALjRG._VNU9KeHhNlUr2PC32tPQsF0dT8Z0esE71Wr5
 e_NSjZ8eGo1Hre9mCx2F2KZfGEaTf8ZmY3NhcPwf4q_wpciYFKDy0qNxq0pBRTV0yJ4hUS.yv6rV
 h5rrTnvjz_E_YRY7HgiwWuIgT2nqlVN33Atof1BSHSS0k8K92E.KHjlGVb_7433fQy4BkXfiaht_
 nfso9I0qQfdSVOM4tYUTAAKfuyySU3JIDrUnx66QM9AfwaQiAyY1sfbChEHvrNtVvfdr69yJ6Bsc
 3ShjtVFM0f3BVSuaUd9YltLN7eGocgal1elYu_IXRFWmoHkpBLTJ.rDt.4Cu.YvmkuQEIMxNX.ag
 zd8eVhU4uFzLsGWXi6DboZ_Wr2.oKmxwn30gpK140zqpMNZ5mRlnYAKkgs6fUlg7vjWiPoTuQd7M
 SPZ5f00Gudhoqi4lFsjZnZ39uKcDTILBPPlTRIORgtMFYYBuQkLSa6MCVWXMF70eO6EWJsNmjzOG
 wKhDJNclnGu719F.icSlbwYHskKhbJXoR4i9clowTGvyCjXw0uSG5KjeGcRslPvLonXG9LfvuPog
 7YLR5NaiAMdkjT1ud0BzSTvQTFusMS1zMR8sd6vfXK_aH1UDKfH5llgmF5hrxhxy7Os0Q4b1tORo
 KF2VLdq16tYAc6FE7uc4uPZNU7ljxUr7hy_MY.PHVm8LeaM.mpaJUT9jDrA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:12:47 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID ee952e2418b7fa05874502fbf35997b4;
          Mon, 18 Apr 2022 15:12:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 24/29] LSM: Add a function to report multiple LSMs
Date:   Mon, 18 Apr 2022 07:59:40 -0700
Message-Id: <20220418145945.38797-25-casey@schaufler-ca.com>
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

Add a new boolean function lsm_multiple_contexts() to
identify when multiple security modules provide security
context strings.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 2150016492be..3fab84220f88 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -232,6 +232,15 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
 
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
2.35.1

