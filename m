Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3A5378D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiE3IyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiE3Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:53:55 -0400
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07927CDD9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653900782; bh=bE7ycUFjMXyS0QJTVnqGmNLjHrCu0aos+3338xL3DGM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=tqt/GwRAjddk8Smi+QueDeEgJhhndyUVpC4xS4Tv6cBpqaHN4wHht5FdMidJiSbUcLX59Feuq7W/lXa8mkYYi+wBZtZ5jk8eXlPHWOS/H2V7ttJ6EesjQtaqpD9fyp/kawFNtfBKCpfYavHds1yqW798DSAN7Zi7a9WVS2NsR3nFt7IVyfPeJP8Ee9jchCkUo0AA4qJKLjFGm8qsSJOtrzgH7pDjc/b3ZTGHckUSsLNlBMYqj/LMsJB4eGqmbnGQf79ntu0F92iy1nEBamjrDhL51ftDcQqAq9XlrijPqITW18/quUuecAZen0k2cGaSiOusn3Rdl6JMlcMGVfpb+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653900782; bh=NiNzekyvAH72gYUi/RD1nulxQuQaepB1P90jtm5tKF+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QKJFQYWoUTOMtNiPw/cugPj+6eruK5M4dkRnxl7+77sS0S0fkCxsvrrL77BEg4rmPmGwGrzr+BPCPfMZUx9o1qnC7JfBkBQ5ThDhRKatjMLqYFPXC1vsPOGjeRpKshc679ldzdrUQXl9t14nzLdP3OWf+F5aCLE/+cQe46JNmm/axr8MzeYlqk7QPSCCcO0RD7inoPhsrYGrc7qucGKd/lq+1WVrujMLw/KtUWSJ8Adt8tfNjItvvpXeS79LYkg4nBeFLi07yWnDGE0ujzrI7Ya5cUkeuZp+BRbowD0plA6wqphgo36YW7O+u4u4BDDw9qotVoWjy3LaIBP9hfpWog==
X-YMail-OSG: novOkPEVM1kyua0LHa5YEvG0HF9kp4bgA2nTslCiPka3DEE6w.UV2.j4gzZLHxJ
 je6V8ZeCSjiRXxl7NodzIrZZZFZReyD2UhuRSYTpdZZAcd.SK5AFOI1k.7r4LlsgHkYG3iqb5yD8
 7Ihi9nEf.RKWDix79atVqoohI7ifYYAu_mYvWDE5qwU3WBIgZcfJ190X7qM_NW7ZJQyQoMDDx0HX
 .3u5lJcL9RZ1.57ifMYWmH2hsdl.cFgMrtFSqR6h1P0teSK9OIcXiTB1g5sst3L5m3m78q4vRJEE
 eoK8K0VwLCsb88xzBHQtMk4kfKH64S0nfmShXgbjCudBvp1DDXQ2nRfwLT9VrXDfyosRf6ZYWLdk
 qJ5BQFxMGw0QaU_dwuS6hFkOjxdQgdkiNeNfjeXRqv7MyjgEm2t6x30vsNwzqpXqLJl7UAMv3ppJ
 tKBPFajpqcahdLDy9cCjwtLF4HP7zY9eqha6tHs1BHKw5.qMxr4X7gE_9_2KCjW_ftR7NZSslRfz
 5_W0pJGDBCFjLqLpbfStZHI1yTspRXiuSGdvJDijSiR2A4iAkY7BCpQ_d4CRZKBaPuia6b532M75
 wwrsaM8vEYw6ZaNnt06lyBZXBxSK0uNmhQtNA9BqOjeSQwf3qldmsfF42.Tq6jBBwMTvL6_tT2t1
 68899N5qofKg6uQVCRAnxzt7_kTZM2CYJUS9GLprupf5Ju4YeOnnouJ33W82GCWX.Sk_XCITNMAX
 k6GwFrGIGg..NouaWUvDzLJwwe_H_KUDl2Zut6Z4LAhPqsbjIPv4E74ltexkCxbDYAxJ.2xOSIbC
 6mb.sRCRmEZhOYNmUEVNfT.47Ct01hbl5ceIDmce26HuYX3MCqecCPoThEk6Ki4VdSDiFC2T6l5q
 ecZy2eOxv8PESu_DVknHJycg82VDYxNgBVdwlx.7pHwJsx8eICab08E6NwFPCYTD2g_eILFU25EF
 RQELM4viJLC9VODOw6eww8Z0iZx0SMMark2wDCRicNCp32wbyJ.K5isoPm1Wpemj4HwY4jvzUXea
 VkR34_ZY.KgbAL_3WTX.r0qMpLjgWe37yQuDbjR.7pufUsxqygVfp0RLjYyUznvL8WATG2.QZ5sE
 5nS3osktHxjiYD_bhq1YHjPj.DgKxUCBQ9p0ngQUQzOqQH7WAW3303rzIrm5M.5iikl46TDdBJTw
 W1Fef3EBGwj9Qz8p2zWOOZuafgmSPnjY0pP38cfHewBLNHv3EOHIY5b.wcs.jX8SosWy0r7jpuJ4
 6ecHRoSH3ACHba1T2E1tbRvH.3oNHwJUY9jpdfPq7v_Y9zp0hwRoMbmI3MxYx_Reqpc4IKadVzMb
 4EPaSPQ_xgABLDjxOwsKFi6ys8TdParYvHIPLuJC2fF7DJ6gnikt7dCOHOBgD83cbmoqv19VwQYp
 9RCUId25Rsc9KMhorYdUO9dBcCoVhj98B8nUiqtwH4WNlyeS1ETIW.7hr8lQ6KkPYpaDta2nGV1G
 YT9RtwNxodKMfpMXfYTXmc_Dk6HRqG44SLaLRvvSDnQkJ7581h5TR_NnHHL90m1ZLULl99IuVAJR
 1pg23WHrBM_goddQuWPYFa5tHLFfssjMEmKJPa8Pfasn.0whx.KlmSjSOMbvcCARod.f5IhUUjdv
 3FPqN7icWfYqzg4Au2nQmS6O488fF6WstumTbaj25SlkVhCe_lsxm.N5ca2IBXsczoqojbJqUpPp
 hwo7ul.tTKcrDl1VdtTo4jVBklPvrcUaOTCA7FVla_nipdmpqfbdYVYVSER3vpgDAkAwe0GBnCIF
 RZl7SepfjP3jHagYHcrst_r9P3QmgQXlNpnf0pbZVKnBzdUJsV5IM5Mz.8wA8MjnkMssAVn.vIxZ
 lkfmMB_EaHGphS4Bq2Bm8YsDIobJCAt7WhjCJ4skK8hWIIL4vdLBXwbbXe1vcl.mct9oEy3cYjbF
 EIgm8Y3_4h2Dixge1h0JsESZpCAueWfu6ESpXiU9xZxT97VAJNz3F0HW5JaymEzGZHWH8091e4Kb
 scg_OXRZbK2miPUuOuIlE9b5SRtsGRsQ2BlOLi.yuVEGueLhf69JLssgTGXvd3nhtP8byCpRjPvw
 mTPM74urDaWE0_7j0rn8I7i9hDw9v4BSHWF.lEMr.NdTkdbLEMvpScGAHTR7xKx4vGbjQcANlyJH
 mH4YxPv5lrFrYDRv7TxMzdoL8U8IW6HIuhdPPCWWBzwGpAys6j5jfyu02HvnUPZqRJdaMoWGKgRF
 5LKvuYLjBA9R02.2x0RMZMNxvUnI9rdRLcWAKw7py9rd0szy6rK8Z0J1RRohmwgCnt5UiZ8c8CBC
 Ivb71
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Mon, 30 May 2022 08:53:02 +0000
Received: by hermes--canary-production-sg3-5f7658c994-snt2x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4bfcb23823043c6a9188dedc10ad49b5;
          Mon, 30 May 2022 08:52:57 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [RESEND PATCH v3 0/2] Add support for Xiaomi Mi 5s Plus
Date:   Mon, 30 May 2022 08:52:25 +0000
Message-Id: <20220530085227.29264-1-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220530085227.29264-1-ae40515.ref@yahoo.com.tw>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the device tree for Xiaomi Mi 5s Plus (xiaomi-natrium)
smartphone which is based on Snapdragon 821 SoC.

Resend this patch series because I forgot to cc to some mailing lists.

Changes since v2:
- Rename the node "synaptics" to "touchscreen".

Changes since v1:
- Adjust the sequence of the patches in this series.
- Remove the unnecessary line and properties in the device tree.
- Rename the nodes contain underscores.

Alec Su (2):
  dt-bindings: arm: qcom: Document xiaomi,natrium board
  arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s
    Plus

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 416 ++++++++++++++++++
 3 files changed, 418 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts

-- 
2.35.3

