Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133A152CD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiESHmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiESHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:41:50 -0400
Received: from sonic303-20.consmr.mail.sg3.yahoo.com (sonic303-20.consmr.mail.sg3.yahoo.com [106.10.242.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E92FFE1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1652946102; bh=KFQJ4TCx83Yzf8f1QZbIar6Bez2FngpEsoK+1YSWJPI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qHiqp2m8MbbEJaXWFunsLC78dtjOm4dayf9cnjfAz834T3gquASFpYPCf5btX1RL9IhmKWnR7e4o3aWwJHDow5P2PwBM6plkeeZpBuQRlmLTNxi5z66zLy1XtOF6njP7XjNhtbnqwqDomSnTsdhUAa9XVDleacrKFa/mtdejBk1CmCz6y68F8oFNs6RuacWirD61FAODEnovMDLWsOc3Ydukof/94KhxDz0uJJZ0BuiqL+K8ia0Kw/RtcAjXkfoGLnJl99QdpMXooiixiWxSkd4m0XxjLhaNIDVPO+vRRz0VhCZRcOHamQqEmIAxFEgVmFBgtF/BtYNtO4PwW8qErg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1652946102; bh=4NYapRmeyc3dEMMdJ55NqAq5KZ2BH17GqvMK+0KDSJo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XMPJRIJgVAsHDg4LDf1qXUn8cdfSeQnjbOaKfIKUqHZhXaBywHj2UJOi6a+FDzTwyCzamC2996kbc8jxmR1LMkLyKnjzL1RQji1Lx1d4Wm6KEwrrE+oSJlQ5bmSZie4ukVk3pg98OKgwUwkExzHbMGG2zO7NKh1N47LVIVjjPPY/3yv/G1BFwRrZLmCvLcCPG9/TAGa+Kar5wjT3HQfK4s8n+TZsw6iixs3xEkOsM1ua+xQP7/LmZSGuzPQEl1JAWeJiGv1rB66WRmCkF6xIHe6NaWK66PE9ZXLPNvRIW8ipNSZ2UYbJhRjgKMWV2vPN42NHWsfyy56CkJ7NtaiovA==
X-YMail-OSG: hKBfT4sVM1l0nxhozhQtNUAh0GgN0hVs3L_Go_UUoiPUojGfwIoxTzZihtwih11
 kGL4IpYRYfqLssT2AY.zzPmX13TrPYq9UrrqQOEk9fl_FQFQi_PbFXvvKq5Amyi_O4v.Id9vP0Tv
 r5ENhNybKXsTuXPFPda0FafwLBz88WBk8csNpFlUsK2si5Fvxeimi7GUwOUW3LHviFTUcqqzRAvI
 ZdaT25RuY66vpqqOfIOcx4PKCL17YtwBjURXiZY9mpoLg8MR56bQMXArVQU4rjTxU8Avsu1UOLRo
 Y9YJUEoL8yALAY6aALLzDCCDo_7w5fzabt0JHXj2d1TNSIIjdQUQ.c0u7mfRe99dA8vExgK93WEN
 KGtPqMOZ_J7CL_Ef29..5r_Hcz93gQjB_9jeWoAKvDHk6un3KNz_MLrHrrNhxgVsEYFF5yALkaVE
 se5sqKfv.Wb.nmNvH48neNKVdWWNqF93dQzwIMFPIl4uh5goYvTW0Wg6fRQLaInYQraylRLt._4A
 nCFU4EEFEi2USD4kwDkr21lA5HbOSF0mnNsMDmKJme.AQVLiTj.ailsF7JlZR74Qx.i_1LWxeg.y
 zEU_xe2iVyYpYO.JlS8PgX2W.UqVTsVbkr3tKQqPepzwfRvUkMi4_ASXyMVgvTUCD_PK5W37lQA7
 aOPlRV0j2zJ20h2.GRTKltBOD9SkAaF7xxphIlIvbLd_9usn.zZcL0JXfvAGsQwIK3KonIB7MhZl
 oXr7Rae65irlEzY88XDpZgvFsVrZ3yH82b1R5Wqp5khW93Qp9Yt6eGF8zKmwkibslZYrW1KL9dQh
 a3VMYZhNbsawriwNsW2Uj8_rNwAJ8.kIu8DpxYzEoabNb5jDE3qW_b0knZblLU1zgCajZFJiwATN
 tHdeDm4W5j3yOYH.4.wRUvTlJTNDJ8MGzMcQIu5evVcLI.PKApFWbJT0DDyNuUOE3esuoVu5NunT
 1xFmc6iSq7RqhZLkm5PJWBbCHK.AMswm9WQ7PltyYSCBzrpBDCCjSFkWfWbmEBypxPIHj7fE9UP0
 BCSgVY0AH.GvLCDJQJ2eB69M.uysT976hJYRpw68Lxx04xydqSoEE3wtuzfUBxvCo8Hhz4HEyuSd
 ttbIbednE8yorw0FGTe4l2s_VYY5b2mCIxd2vk9c4fGB2teg.aTAHzhm.357e_wBQ3hnQh03goGZ
 Ld9zeat21sMETnLZ8m1JT.2s.7qNhYe2bC5.UQJiDEhUzqZlyCkdy0ExMlT5FdnVUFIVDDse7gDG
 FtXB7KNYGrPKm55Igtsg5VAkHtOzyyeNv5JtmX1Oj_n2jdlIJ_OsQTjZvniOvRUMx_sW.P3QylPV
 S.5ujbsxGnSS4bDmiDa1bakXLb29Z6CBDuDt8ipXY0wGs12zjX3Opd9PkStDVO0JJs8ck16olgU0
 OnjEWIFJKL4MeI7X9wwXNNWN5p1s4APRYmgPsJYJK9up3pbvT_Fg85SG0smXOdA1jveq.RiE2F_j
 9Xfg.Ezhpfneoy5W_MJOmwJiWk5FNi8vplq_dxJfH4Ex5r.85saSOWvM6cQmA2H.RcVYUDxMfq1d
 TywdDVDKpuQspuCL_xJ6roi4TeYE.HzhWvsv4yZebkKFfz8CkuHygDEBP4sHoxIVLksNi8tL8Crp
 SRnKycQdsBdSTy2MzX7FZOcBI9X5WRKnWtj6dj3DGXRmMkmEBDu2oHI8ABvvHmfN74E6uNV1u.EY
 wV27_AVvHn8utyvdTjc6KfG1OQTHZo1lh1aNPx3oSx0cuerQ_6_892xgAmFHuJ1cXtMireTEsdHZ
 gC7LKpIjLnGrE3259PDtMfH.NoZYqGCceWQR87JGD6VRCRzEi8GPUzhJQ0stFo7OKIdulABYmCtK
 FbNA6B8tD81gBWgokmGCtR7A4eBwTT88RBhebiqXcMFUrnNZXb.PD07xeWrfwERdx1mQhKNzyu.t
 C5eRAOqUsBaE4.Se7kq5PjskqSWzLgUeu.pHNroNC2ZpXzGAtOgZgVnqGMPKETXVk_Ot._m2e7It
 P95yspLIToiEOg9NJOl.W3h8QfUzq9h4EK4kGsNkpEALuk_mDY7k42wNQ4bxV1NLPM5E9TAsS7Yo
 icgfbmi_eaZAtyginUpj0nhwQ1SdFitgiqsB6mbj5NtqJb4cD7E9UbP3W0VpGM2vHjeWZr425PGL
 TL.5wqnTNQFJdn6cYtfLCnsQ9yV815c_SrbjfOsc24la2WSwFld.Z3lYA5cRTNrufvWHwLT8rtHN
 l7eMUxeS1XQVr51HjIXjPJzrR2nG2nVXi4G7NE9Zg2xdx7VtasrFi2LhzCQOalv79q1pzVmemW8i
 qdBQe0w--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.sg3.yahoo.com with HTTP; Thu, 19 May 2022 07:41:42 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-9z8f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ff485e39d08ac88db91aa318bdd89cc4;
          Thu, 19 May 2022 07:41:39 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH 2/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Date:   Thu, 19 May 2022 07:41:12 +0000
Message-Id: <20220519074112.25600-3-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519074112.25600-1-ae40515@yahoo.com.tw>
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Xiaomi Mi 5s Plus (xiaomi-natrium) smartphone which is based on
Snapdragon 821 SoC.

Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..7ee852079d13 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -190,6 +190,7 @@ properties:
               - sony,kagura-row
               - sony,keyaki-row
               - xiaomi,gemini
+              - xiaomi,natrium
               - xiaomi,scorpio
           - const: qcom,msm8996
 
-- 
2.35.3

