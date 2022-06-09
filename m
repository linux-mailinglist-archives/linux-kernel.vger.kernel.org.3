Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F91545845
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbiFIXPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiFIXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:15:01 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE1114AA8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816499; bh=eDmXp3ZuBjTXOBmPYv4mZcQYx/eWv5XhoC0gtLTeZ6I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=U176/tiD1hgLfzbcS0eCNK/Ezuc3L7ufu4dnU5uNWon/zcrOUuArzMcYMhVQAy5qw5TzCUef1OhyO12SZh6MuBQO7tqNEpnno7KUzIG7rd6hpRKsKb407Vn3msNOyYrLOAXokExPtrgSFkwg87MKqYwwqL2miRNClFm48hftvj7uRUMqbqxmRT/DGPSga6StWE4m5ZQr18MIfm9K/19AHc3rzbwXiyGuKvyBIhZRIRHzK4oSrua7sEfHTtzPu4wKb1PbAn39rOdCDqOD4fXxjgTdGHust4vtMJotY1D2cI/cejwJgU2zIMsxpTjNr9KWXur77C+i+nfIoezW0apEzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816499; bh=xKe8wJlmbyQ1F9bDZPMHs0gTq3Ktfu2OM+++FszJqRT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hx1jd3UF6HohxVktu6kQAAiwMdX65sFHyjZ86NATd36VG0RBHAfm9nGebYCUzqlW7iG6ClR7hiD1dXxZOthA+VsUYWK4b2L6y2YIQ1dZDMkwiW0jEaxRi/jx59NWX9wtt8zRRUHrFyPETa+Of1JVXv5FkJaEVTQKKudem/aPSP4BBq8N36+izrnhFdS9lfhOQfgCjlhsr5QWOgXWPBPDn/5fTjPuZSUjjF242y3E7r9eFvn6eZ2dYHgy2hU00362suwIToQnL/kXqlndkzus5WZwO6RgAVLJ2Js2iA8pSmhkftbXvIjQ4jEl5/DHbMgz1c3+tA91H0CpIz+uUkFTug==
X-YMail-OSG: s7GCQBoVM1md9MO2CIbHFQP2m32Ea0bH39Fi5KwKNVQBDfbIJDQGoE0Cjaw_z1Y
 cm2wao2Eq3wbXfHFDQbnwPUi6Nm8W2Fiw31Xch2CNCgNG2RHNAkOuDB3eC.1x.g7p1u1l7ojJray
 bGoywYU.kTF5.ffmfcGYtYkjbeB5.WVqqTyyur1IRN.ZsFTeJ1_lYiKYbCdmKwokzrFCq6jUD0AN
 ayJvL5ApEYOF58e9GPUjrjKpPHgTrkoMVWGsJPNXitNBDHKdacsvmgyY1ylgtI6ti0dEjqy0PO9i
 .QNeYsObAglPQYjqIQW4_..KSSedgkPIXpfzfwKFGNU1Ekbystl_djv_5vJHKp.nyNBxz5s5y4Dh
 GMaZK304Lk_6Iznr.lQPpHsaf1hC9w.yhtsFSJLdq2Hk1Z91PVjVua_bZq4j0WgdGAsayY7BkHi5
 _yxYB3mwOf_HKtNYot4hzHYB_QcfB_Nu0bB0GMF0YRRSLwVqLQic2JHRM1e2jKt9GTaja8xxDgpN
 7xmvOgkUBFEOzMDSUeOF8yH1PzqUlNJxIXHgUTxMexnTH8IvheecNZv9wVx2p.3YfIdRdgp34Yoc
 v89dCMtyfkTxmb3o6jrTibw31bnuZxKrKHZohqkmXS0KPAWtMr9W.WNQYScBhWZym_42B2Hntmat
 O6Xuety_vPQl4jhTswZwEc2nqe76C.MRG3nFNn.O0UzaQoQur0vQ9alSneHN34fmeTZ.71yG_qRA
 WcrWYGY14mIhHgy0a05cMNyRFM0zfDCdPjwo8lPyJ5W0OaLkMl3GIOckmADJl.sFOYOXGmhFOwTB
 f0ryS0jYcZw3X20s4.XpcPsSpwe_92SHoM8Y_bLCR20ksDzCcMvA9_hqa7wdmBzEYVxRVqsVXE.q
 Mj9OZ4qNKIoMrgr5JUKimzAwGfPGiFJXvWgRR62fHkLm5cvd43KsfOu0cwF3EGpz_GHUYflONgLy
 N0qiYmB9AdO13rHggAzEOh8luBDfhqK2koi7uqwkK1gA5lAI3b_jucDYw2fh9bxBlxpAnlTsXcXn
 Q1SQIZpjFcFRsuFGBr7s_yiz6EUsm8bfGyCoyB7CPO6g50lH4E2V1Nr0f5GhUjeUEDSVRcZ7L7vv
 7K.P21n9.lynqxwrYJOtjSw1KO.lbod9A0mWnB72lk4p6u2xN750mPiA_xR3liKx1djrFGUt.fGM
 Sc_6m57zdf8GGtY6tY3ZjrdhZxO7VsnaBAuETXqPXTH2xfJk1dcdtornq_3g_bLPHtf4dLrNBpaE
 4DagOm1aggJzaI7XmLa_3kjKxWT4NC7v6AwNmKHgoT0eWJYv.2o7Cxtiyj4BZQlu2obV7OWrXZDO
 PjGznxNlAmWG7ZBSjyBMZbhW48R0Wm.QtXqJJbkAlzCF8hY2X0xeuTk3jnTFKR9SEj0eVuFAPIAI
 7YV1GXqinaZjcqcfsfkvMsGwKC05NjOqQRKdBvuwX0Kho_qcUvePsg07QG3J2Ntl.h56bs6ZCWhp
 6mBdallD3_QnKKr_xm0heCVhPcwCIWOsXbc25aszf_eHcWEasimHnInOycRR.CJNBEA16PhUq_Ca
 DKMwIoGCiLKLTsomAj2MyIagr4MNlvKEPsISutYjfJIXPh5aVpW7XN3Di3w8PQ0sb0N6M75_a_yT
 g35NrMoyyvM3fUVW2BAH32XIgl6tTqlLItlQQDRnc50psRBrDNXUfRF5OSORlI6yA9jd7viuyOe8
 Pmgn2Y6lCtlfaxi3T7AFbkcOwJuHrpAhUWtoemzIYTYz81oSEi5ZDYhRPtZCtdGy84oHzV6mQqpx
 1ENK96MM9my2VLrol_oDnBvZf67vlpp5.DTwwHGFF417JHvIXBHEoY.8wvsVrNHGNbPXy1Fk1Yag
 U69OEGrx.44wb.qo1XLGmJNlqpgY8TWjJPD0z7gT4PH1YxfrXE8jh4bRr1BBbGfunI27EcQ8ibhc
 bNQDO1PjsKPtc0uJKf23BCcyVZWjJ92AQxs064UrtDkxH.TSPm5UXIR3j1sr7rURf5rKIOzuNcHk
 1iHxe9liGQsgD3deO_IovExUtUdAGSfvT.LSE9CbRExS5iSoYngGkAo8ssFucUyYXty7DZpZsbQ5
 xiIP_QlQf7hTc9._HpZLT1VgT8Izh0mVXmldco3rsHKW4EzyqJx58gBB3IgZhDVBDSGZEtgIGIGh
 _yXPCWtunORWQyG2HX655PPUDFBYTMAVs1Kzs7l9dJ2iCN1A8WnifdTJ_ItLFdiADBeq.V87T2ZL
 beEPhWSfHU0fHBQwVrU_ONRXz2KaxE2jmJSkmvcwnXYq0VV0xLpYfCYxo3TrnW9haGDD9Pmscn_g
 avFCQIMnGY.d7eDRWc5Z.klsnoYNQdfS39N.j0ATJoGUGyzEHIpFLg.LQJA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:14:59 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8f2f82ea5c9f338d52d2410bae995cf8;
          Thu, 09 Jun 2022 23:14:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 25/33] LSM: Add a function to report multiple LSMs
Date:   Thu,  9 Jun 2022 16:01:38 -0700
Message-Id: <20220609230146.319210-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/security.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 1efd34a8f75f..4cf551133e99 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -234,6 +234,15 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
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

