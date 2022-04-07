Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1C4F8A19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiDGViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiDGVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:37:47 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D53D0AAC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367346; bh=s1tbTejuxOu/lam7b4cMnSGO5wWBpi4ZK3vddXbJyRI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cUNmdK8q7IURdofpIBFsu0g1ftka0gvnrSHO2esbeV+Us2aOd918TviDUMXEBLVTINbXSt+IM93pm6OLORvrazWUQytjNs2ucPrvLfNx2NsQ8yVqgvWy1gYL5QmNrMqPmK8RYe4GgdL0cNj7/xaNzbqXqmxsG/AQsbKj6rrnXGCI8o3HcOakJYQubtCVJ6n3iAnhsIbMbOZtoKPL3a0lyzgQQlpOSGzDJ1q4z1IDuYYqu9zYphex0KoEgC/9bMEO50QeRmFlrwbb1E2mIiKusErIX1kVWhdTYSQHBwY0M8jl+SxDofa31l9SZEOBHfB+6fsqoxqjJv3uPjEr2YL7SQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367346; bh=fKaUpCEP48TjVzQyfQSkxjGUU+/GmwT4kDCeQAEaYtr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=boICMon9rSPoBJeXBh/VpM8kd9ep+DzW9q4RDIR4Z41eSWemZUoLMvn3kgccYZQj+ZnhoTmbJP9VUpIkktIGu9rNPxAFmxPKhqiToKpgdZktbPXm7bc8teHBuv1VhaPx7zG+nZuHUUoPitnKDWbIEbAJetfvxxESvDKFOZt7Yek5LqRM8RCAzG7vC/fGEL01qcZm501r1f2LwQpYHgjs0auaT6fzSEyCEWhAwe2U6v4YrnlLOh443lgSoV3SgXgplRyQiFEo0PuC9RfH4GkxsK8MIiSeop2x1t9Hzr5ZFcAGuptu3GvBuC5kKGqR7IWPZAX9zEPxAAwYxWwJzCf6jw==
X-YMail-OSG: .WSANpwVM1m0b7abDVo1TuLxNXOEV729QjzX5yE2t2GTab8iCCijgdJ1Ge7uUS1
 A.o3_XP..wjL8wfr_3LYOhAwONBgm04MNxPnJTF9Dokz49SpoK59sLWz3u2_xpqfYy112.yIOww7
 t4gnQ6tlzmSYVYRdUWTG70EVXdcbMD3EQn_zU3iI3ME9BhbItYJJSuKRNsE_HFP1PYlJIywTQxyM
 mM6WiJCZv64ue7i5dgiszWiK3AH41Wv559_PmNIgxTYTA_0tyPBD8LpppQtCpmqKBiSV5_mtohWu
 tq0gAI5h6AScoPSgMxlhJfAUl3NosOHhMGtakEW9wyeUfKLdVZ8W8OcxHEyyFe0j1GZY9snp8ore
 B4UPVi.M3JrcKWze.gNXYsUrdcYXf7N4sYIB49UL9ZmLSaOfJbhy18oqUO3tlDyo6J_okhcNhGUq
 .Yz1szJo.tuWln8HwWWiQ.JOY2fj8sJzEXxnCvNe7iadk0Of0eFrkJR93Z4OYM91ThOv3gMWpa3i
 lQsVscQxd2R9QF6I6ZaP6f69DC16tC2IwZJYr8osT0xtRy.d_wEE4J_p_J0cjwQdXAEht83d._sX
 4sDWkEh22keB1g6HOvu4IPz6hLu2J6ktmo1EtTpNY0U_3_FB6y2DsSa_sRBEasqr1_rn6R0WWsqd
 fMslFCklRkLVs_GxSlPGgD0UhkySBDQoE7skfNCWQcA6eZ0SxaPT6PDNTWRzqimaqn.MhttCquZg
 rFQjK2WtkLdUEBrgIs8UCyAgfXucACQAVGATDq6CAdNeBvh0VJga3Sm48wVN1g2RIYoymezZaDvi
 .zNDYKaRMM1TPj0ml9nBahoMDZaaql3r.OnMyPBRwP9dRdVZ_gi97ZSPQWDgJ6MsxNtKOljCwSrW
 Lp4lzGzefF6xYpxJ0TbAJsJ2DySLyGQ8YKigIuFwzTp0dfZncCy6ukmjV4rnesqdT0.rKYlkXWkY
 lHTQ82c63RrJMoVRftERqAzv6uleRHzjEOhdjZ8r.lwQ5tPg6Pvk4qqwOrT43dBAdjTWcTo9q2mg
 ThgsLCibZMDTqX1x74BEv4bmirPAqOis.WCNFXU9GEPiyU5h2GUZRmyLSmb1rDMW_bjhEQ4khnyU
 Tvnyy1ViZ7ZLxpe3phb4JDE2ur4Uzn1Ijqt.acRP0uuAGmC5ngVDfpoIdER8SMyCub954JCynfr6
 Pdm8wwkoLjCCiuu2UHYeBO0pdG9xlEwyuK0wQZODcIRMvIU1rw0weVvhY80nHPHE9DvhFTwqSBr9
 ws3MdnKEpZwzBsyEX9jl32_5BY.IL78n1A8srAcvcwyutWQfIvLEerEnoQrZWP6N_zUg83LEXhd5
 ZTMnMVg5.PV0VlM5fwpLEIwY02cX2O3DkPi7L3nkD.OjH8R9arlOkxYiTqtZT_ICzFSLBsMWIrw7
 oxoNSlqTJ0NG.pZne5VzeSPBKd6nRLr5owsfR5ugf4pUUTW6yBUbCL_q47hNqjc3UJHyOymtkjea
 lhFkUNexc9lHWthSCvgLXs3YW7eHb52gOE7Js5.xaDAYz6MKvSd5ZI4FnOB59bxcV82nXt7Thwpl
 4NfZXju_0V_9AE1kZp741Chx2qPLQiGWOZ3IDfpXa2lCo34niR2ShphJPwUtfbLH7tumBZeLZzYD
 85z2ncRfJCjKolqYczL8HTPnkFMuac2bSqDrYpziYB0yJZ1mAipXPihF.UK2ai_C344Ux7ed5lmb
 qpB_hNspFRoJKzF7pOLe61DZTcLlhURkJ9DTT.H7D_0aCJQebmrqWiWefK5zs7Pvngs.O09dXQFB
 eK8fZUmjszhAf9VZl2PDimzXA2vdSAE_acDzTXavLK81Wy9Pd88EFbwKBWx3QvZM_xN6cYBMtsVi
 ohmt7AMFscQ2TRnew7hlEVQbLoq9HaaAMjtuVKiA1RT_U8GHjsOL5CLk0.LqHDujMqv4j5ilt.Bh
 Fjm8EM4MfIgntuyVAn3qLL0dytW4Fe9mvYNfTUeiKraTN5UScT70.z6xPQljexvxADpgu_GAR494
 0h3NSBllx4BkYIDI3BsLutvdm8PLrPXAp7eTPClY12UGqPzGARtnqG6dSfGILAy4Ptgjd0nvBEWJ
 QSyJVAVI_Kcn8nfLKIAcm1oFHwA7IVPHa.BRGO7ErJblamAHJKWYG9dji4VWQxu2iRwXOSwrJusE
 vcYvbQwo0ZFTPrG4ZzymjytInK1mM8r5_hBFJPHrC9NtF00ylGctna5z1fvy8M.gN97Xn3BaN6Ht
 a7oJltsPZ2U1x93u4hs21IhlACwv3rq7TFj_i_txfRWlhEGL5rfKS2GVvqA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:35:46 +0000
Received: by hermes--canary-production-bf1-665cdb9985-zm65g (VZM Hermes SMTP Server) with ESMTPA ID fb411508bea18f2038d235ae662d3bf0;
          Thu, 07 Apr 2022 21:35:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 24/29] LSM: Add a function to report multiple LSMs
Date:   Thu,  7 Apr 2022 14:22:25 -0700
Message-Id: <20220407212230.12893-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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
---
 include/linux/security.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 0d3931723361..52b5046c0956 100644
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

