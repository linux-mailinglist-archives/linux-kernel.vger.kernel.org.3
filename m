Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1874F5030E5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354429AbiDOVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354306AbiDOVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:33:51 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F4D9E90
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058280; bh=s1tbTejuxOu/lam7b4cMnSGO5wWBpi4ZK3vddXbJyRI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TGbVMIoZ70jeHb/ftmhMWxdk2si7mjUhEMhduiCBPQ/TEiqN8kcTWdWAUxJcxtye2ckkDaElBVgkbTQkpIVUe0fIm7uqHOa/ISmLitW54iAZ7N8gMyggXuReurzc1z4AJFqb8kTGYLY0qiLWq+GD1Me3x5ODPHfHiD7cH24GvaXVMfLEnFdZRXM04arb0yvIGpuotpR1zXQlZwKT8eobOQvjcXAjgL1tuP94ME9A6sKC4nfu0ZscvCCVx9N77H3GF2xbRquIgCbF6QY0zG9RJngl27QPAXMFL8l7d0io2ts3aQULhZ6UTK+SN6ukqS/cQ8qZ3GZtGBySyz7iEs4FLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058280; bh=NBPxB3QGX+t1fIt8ZXWiboiuDtVGS3TPb79aVJPmwE6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IL9TlMVzsFiaLP2nXQH88UgXWQGu+KekeT7I0IT9p19gyzaRwlwFYIoybV5n5l+REl6zJb3SA/TtRgiIeq/bc76pf4hs8sArCtjic26dPDV9klagic+addDDCnxzSlpX2s/2Fp46O4vcLcX4tMF7+3qvXwiHrVUa4z27YcNKG0GJxiu1SOv8E7GX9u9i6Umw17NTHo6cda6SuIxNRNrjgPTKjJ+GfIPnHMyZIcPzVymQq8Znfd0BvCm7WeKQgknHTSglijfi7qk/5cYAhhPDvWxq189+CttrcvBkYEOwP5k1+aU++Ff2isYm59L37kiA+NmkESxuxL/48ecsXZ7Mew==
X-YMail-OSG: VsJf0lUVM1mvaon6rkMzVpQ9d6jmaHGfmz2H5u58L9Cc8l7zhfmq4I4aA4RWi4U
 BsFAgDiYXfQcfc2ZdsfUv9ldahXDCUtQwbdtllgdXwSOG8KYDoMR8UYc7yp4vBbdRsu.k.fRpP8A
 lwdSBZNyxoi21iQz7W4qgrrnPkIzznV8RG.36Jl1wSn_dtGsoQB4UiNENo7eNGIOk7kny.opU2Cz
 ddUwT9pFZ0Yj2S4o.ytnIaputxfAdMKjmQlOqTDwClQ4LhkRGhrdC0Ma2R0g67ZVmCgVH1A6WRmN
 v2E72d7TSoY1LBmflKehFNy9ffOkxJC6.jS2tvdl7INQyt4L9shDLkBs0Fl0p8PfrsdN39BzQrLO
 iYH5J4Vk5wXWOK5t9Pz4qozQDK4IEgydJ0bwA8qP.EDAo2KfmHKPgulqt9ZfvFtqLSjVlxdq3Ngi
 w5NFWelqCVsrc1N3Hb1mZwdTYyGkBWjGRujole0mktQxH33z6TB0p.yv2sI_Q4yb3c7hfx98Jfdv
 iiLJ47qoyM7CcRG5GU._SCe2wTCqk4lnmwctmealOS_XpHFFOq1wL7xNzB8Rmtjrywr7ScBGH0C9
 IQH19T9SPhi3UfRzhLIOfeJIdVdm1jnjQuJmxPl0z0NE0SdWnvaIaoe2kUk44ZfyOn.hqJVmHyCe
 DaoNuWsadyMZ.crekz9_O3Nsyq4e0qHlB3Ju7VCQRqGiu4.lpLEg_2pzjiIo5ORsEsmYiP690JnV
 PXJZYm3.HCFuR0F4WOx9.xZzYbY9kxQralnjfNlrZX_FET.gvN0bgD7qpWWiYD1OqefMHKtVKYrx
 GWroMWKRZ_22Fk6X7rCxyFKB54Tjv2UtQ0KABfiKjM72pr3gJGz6KF9DcEoOVTQjMY0Pzq8Bz_Qk
 9L_x_F3t8A9p2yyuhSOIelwpQjAVRaBk0bWTkI0LtTtWuTDx7EBCsdLzv3kDI5chkVYyZH1Iztyh
 L9k7xDZuJcs81ztSiIUu_gb_yNxeYz1SRiE6K6fD8PZm4FsuNRD69NXqkkVH8Mkjia8qiVFBjKAY
 lYzie1SKYPJPNVymfURB7qJrZGZXOfQ9dEXs5WYcOPuG7c9iOm8tk1qKzrdoaSnEGRvIfEvIxeDa
 DcyETA8b0YeENsfLrQ5dLpM3Qazxzj7HYR.ONWcLTI6DOOXFSKM.DkEwEIWFqfCnR.kZII0ncVaS
 K9qZ2AE8Re45AE4n6wSjr1wAXRkfZ7E7JJFheLqE1KZjOxACJQrJOPODTSc2m63bU07QDAErG0C0
 fkRS7D4h80ik2PtmjTP7v.zxOuH53wLFqXen5_FnjHznvyxTt3KAygy_LlawmvJcJDuxR9DAKeiU
 VgJ8Cvy_hvaTyX65tgT3z.KCCpzG0QFiZljDzLZxsDERYHihGnMJvg58p9kLqlZ25BGwqM2MAIqO
 qARbOlkGgZzDwEPdAnPgQqqoO0tWwki5EVmI.nOc23BmIaCAf.xIlXBjIKOH3ACSDqVd6UhlctOO
 YRuLx1lCjR.6X58kT6C5beYvf6h8jOIjdoZBDiqfYgQI_jzBfyV9I174p1bsB_dLzR.KwfgO.ctp
 aldQr6Hh0zOS_I9l7NN7akKokR8TO6._0KHVr8EhtS1jFzk4XyhtmjJETNfbUIrOXAYvRl3kucsL
 HlfA2h3ZphkR.li3vy192G7eAGdJd.EJtQdUvJUazBRpYkubnkBq.bnCS741IdOUAIwE0XvEhQFE
 NVj1trpL4sBv_5zuwyFCrKj7bL6fvGptmDxcYy9Pf1YMM3JmVe_8N_SDSEMMLzpOBacGT49C8xeC
 07V.mSx56tucvrPwvlfmNbmPj67YZ88FLs8wE6nHsI.LrxTa5BfMXb.MMKP20bkpNTjGnh3SE9hd
 Exy14s1YY3982VNrPs_mcvKyNy2218Pesz9mJh5bD4_iIkWF3IL7PqzhzoTBbN8oikhVeJmuzUqY
 qLCerh.m0kTpIeMaj7njebHRha1zpBtJosG86lF_8QvjSoZYlxRExdnxza5irxpovGAPuqvR6dKu
 iG.9cAw4mkPSAI3Y8b3JavPHWMraV.C1RFbk78AMTmBqnVx3TLR5tQN1X9Y.jLsMuQJGCmcEjQb9
 Z9dJZTQCT5PyGVlXA.EIroCjKtcizxjs2nQdvxhwS4mT.XdlndpzWUF6Cq9RJ8etwHgJw39bd6yC
 .zrORMLhlD_g6zaXBKPtR1r4_Ji5vlXzZoISJ_.2fWtD4uBre.6OCWvnkCWUCmYvjsvu9OMJHrls
 wesl1m3JLWP7k7m.1A1KVZKrwUOvx3bjOz97n2VBYoQgr8RUGXU.VltpJd2F5yT_Lpf3kX_B3PRv
 OXS8C3.yc2kmS.bS8j3keONFat6a5OGVtxOOBQjj3hmf7Sf.baLMrNg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:31:20 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-hf9hx (VZM Hermes SMTP Server) with ESMTPA ID 13670bbd638f1f6033ad5ba33b62894a;
          Fri, 15 Apr 2022 21:31:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 24/29] LSM: Add a function to report multiple LSMs
Date:   Fri, 15 Apr 2022 14:17:56 -0700
Message-Id: <20220415211801.12667-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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

