Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCC52E54F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbiETGud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbiETGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:50:27 -0400
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9D14D782
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653029423; bh=Bg0GyWkRQ32E40FTHxnXsOYSvnmFjGWIAVTZCNkrdwQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=CHLV1LhzxA4y2FSei4uUhy+69Mu0/zIWsli0B3v2BVfd5nZQQuA0y8qkHwRZDsXzXVwZWzDXaZKzT2bfcv9vNc7I5DUjz3J0XKjLSpNRnye0hweR1ELQOwqoSQsnWFpUWLB+oGCSMUUdJ2ABX7WiIz6EYPYscg/Z0eCgVXVtz4YpaIQLYdb3PrEBccEuRh7Mp34JjF3WO1R457jW6lkMOsKAFGZUbgo/Dp1nUWhNpo31TuG3uHfyGbmNSwHuLEIK3ju4YYh1bQmHCS0Ql1qHLaNFCaEvijI/V7q8nC9o5+koYO/tfVYu8KaIA+PXG6Jr3TxPSWXW8daYapY7jOk7Mg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653029423; bh=IslfAe35xkPKH5HC/1lKUO0bgGuSky7LDBgMhtUDCit=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hDB7wDqaWU3My/oyPEFJHy1eUGQOIe50lrLvUxTUxkpXUeEck6K0eEw3cIQ4Yb4aUo6rMZ47ZUOSeaWRDugMhezjxcuo6Z9KbO1Xd68Gq7E/zz8nGLih60GDuH5TGQKeHXXX5TxhVEP/BHvWUAKfKxPBW6+LHnVtVcxI7KUeg3XUAbtKUTPjxzqOoDd71e/vmP8F9I7LHrUwGNVCwvxD2uOS8SM0qS9w0+rJi7NTIU2mts59hWSj1+T+lhFqLwKk4GiR1ZnqQE8GGSSv4HHzhWesdzOhFl5kxpoITRmpqtiEuJp3kRdwgQ0ZZlzjBcSwa/VM6VC/kJ7ZMczclZ0UuA==
X-YMail-OSG: sUp5xacVM1n6C0gMSx2eQjzpQOj9yPQB3k01ga4JuEJIzFvHSAyCXYGb6grteXx
 h74QwQWVKzogZ8bmLUcwuBI9HPr2a7iqgxLStuvmLlkCD6L86k46lzcb9Rh_rWENt5JegZkXBQIw
 N6MEc0fQ4x.UEnIXQv5csRRFhDuzpJBxE8KsUtUZiMGmdUiu9cGJYf6zYwNEOll5VUK5AzopOZ3.
 UnwD76T6mXI2jGwsiuaiJDqJ46EZONCzvARNRpvbLElmke7789Q7WF4MbNx54j6jwTOza7E_yjv9
 boy75eNTaYbyuUlVbE7An3C6sn59mHF7oS59U979lFXrVLY1iO7DXKr3wS1AHWMU_Bcf7eXtFwpS
 l7WU_yXRQGEtqbclxVvnqBQnWWtEXELzeXMAgqCc4I0ZBXnydQ_dGy5gwATL_9c7QA1GK6st8m9G
 I6DQ_HCjJGOuAIsKmJsdvmEafVWeWCgeRqxUBGHA1cp357bDY2OiNFiZa7ippXGjRNZCdr9P3Dvw
 2Cmpae4tk3mvg.yx9wyEQYhd2a75bhn9q5P8oHABcfe9QoW9WyYiBhLKiq.9xYMrfDsCWFmhXFo0
 V4UnkB954MmIWXRzgiXRGTfd15Iey8Z5Md3Yv01JAx.803T..jk.m0Yu6ID9.xKXqsw5MbQ7B78m
 VJdZYML.XK0Rt1ZiX3Jm5zvAueG_s4NA.LLlPS11qOoYwVgEUCjc4IcFl5o9efIOAKIkGJZDXlp.
 nAX3q5oTfOobo0zTgUc7VcqmmNClEkgqXD9yqfubnbRJrGY0zw1TCXlfzQc9BlJcCDm5PMVpALh1
 nO1OPcX4HiKsHtQ4CHHb3h0C4oGBBp_78wzTnG_ok8eyVcbZzfYXqF796Saq.3NvcEdg1IBIA6AK
 z1pzPEHzeTJtlFJG0Z7ylLWcpOFAF40mnLWPGhf0Od4ytZyAXt1n.I3zVv5zh3Ni2wlXueNeQddw
 I4NFhvhoOvi2.lOjhIGdlUHFD0A7bJKgVmOh0gVXyyT6avuf61HkMQjrlZwIi_OwP432GCIYMFcZ
 wwdmLfOQpa_X3i0H0w.psf.YF2.j46J2g_K0u_FlJpCbJqVJtdVRY.Hds3YTVQjJb_vUc9oA6V9d
 ULZO7.6d63vgEyNj_usG6zjfHPGMwIifXIZUoCPs2mMPtFr8dYh8dgueyOJUDYOYszfa2oOj99wq
 s1hChaISXsQeCl9qStROKnLbsN3qB9NU8kOfNIVRudlXkyJNgJcMmjel_z4WLACuVogzG6bCbutm
 pvcJxRVNKl4hnfZvX19_7VqgQ2r13GTSYjRo_JTR_Rg4ZRuFKfe8AaNw5qtq6YhvsNjHkq0WTSnS
 tYGGmv6GArpXOhmyJSDcHC6po9vTxfcJhrSYr3I9kiFtbG1UFwFANnMahh.OTxOOOknAwxPf1_Il
 K_oadIr1sfcfdcg0hYHFyQaEsFuslw5F5qnWdqWor7i29ymDCgomALjBvloadDVvr_SixDAJUfw2
 _dB6LShESWYdg34PR_kQouAJoWmAPWRpxlLkkl1KG_ONdMIPEzUjUMWIcE1MaevNfgL4bSWFUJ00
 smtJRXD.0pk3eNPSBdp4i2KdWzuAkdIa3am4DXP4P79davaLTBNtOofeJcchXHgEsCDMcsgVklYu
 RjM0EL_BWJ4i49Jo7ZEdL3m2_lCwCB6_lP5YJ_CJaZZwO.NMfcIGpraC9xJuNlC3cMBcPAQqeRSe
 pz.B67Eyc_Wb45yso2TarJOLLBZGRhX95nRwumUYOXyfeE4NYZBxBsqF6sVb9genUtdAKXCQVMVP
 rM6lC2wqVtlpxE2g2SWAwme4f5WKxdUIm1seWG6svxczoGYM2sjn5Np5HE5_72j9zO3vXsLKj1o.
 Xwms0.EnykdRJo0fcJvxgTJoPwvhfJKokfpMaCK.ok5Pxl2mVEx0O5BUoQe2BpST2CxTpYcgQ6UN
 m4WWoCfmjBJ9eH1Liklw6ZvxV0MCw.1qWBhnwZjhh0Zpuc0L1.vmi1BAmJRFYh1kqc1waPhjTNj5
 BwekY4Ag68H6w48yrmVdcxHWaJQwMRpobXzWGg2oZgoyBkG7U3o5oISTYcFSSnp6DEm046RxZdXu
 DMzOi1Y0E.NN_yE6w7_zoJPf77f8q2.QMJg0E9xw6FEWX4rQ_8HjscGt9wsui7x.yiePlesjoL3j
 oaulUTDprOOo_f8xJIsU6grE7WZA.PI4LMHQTOfuKhz2Hx9nAVRI84lhp_KTyBCxlmUOqmXPO0xg
 PoWl05cjYUsaQTYTBIqicUJyXZ7MsxLcA55QVOM.wxr2lmAJ9IRHfxl.EeE6socpTteM9HrHA.UY
 PpUeFLy0t
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 May 2022 06:50:23 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-9nmmr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5604052a25d99ee7dc2ed819d2227320;
          Fri, 20 May 2022 06:50:19 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH v2 0/2] Add support for Xiaomi Mi 5s Plus
Date:   Fri, 20 May 2022 06:50:11 +0000
Message-Id: <20220520065013.25808-1-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220520065013.25808-1-ae40515.ref@yahoo.com.tw>
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

