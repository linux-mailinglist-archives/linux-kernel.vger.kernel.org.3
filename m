Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214B853DFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352225AbiFFCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbiFFCrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:47:23 -0400
Received: from sonic308-21.consmr.mail.sg3.yahoo.com (sonic308-21.consmr.mail.sg3.yahoo.com [106.10.241.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88763F4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1654483637; bh=QXj6PURIQUaCdrfr15xm4Zh9/UDEJ2ARKkaiXl6akD0=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=WicVmVkGzPhd9hj2CMA603BqDxOdJt0h9aSntiI2FGSmDK31W+WvrACnxwh4bzY8YjcUFju16elcmTm/2PORZwtKtRLjXSTF4zzGzwAEiZf+fK/JTxt9NiflHc9a1vlxtSUoG665rnhUE94Cl75YeUw3FgSl44mtR6Tah0tOqU/hrANBWE2tkoQIVt0xQcgV+tljf3IAVqBMDGNs9oyX/6NvX0ClSL19U1BgEkG9WeJ1J2iiTDJW9zMfcWS6WCxg2uebGvttO0XroFHLh1rTrdnwgAWKBtKq894aeQhNCvgz/FCyeMBB0lcs9rIm2ot/6QfurojLOuAVO2NOEwyIog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654483637; bh=L1zxY4efVVZlwmSPsVIBtRqKcEZjyysK1tCCWYMltmh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fxPjkqN5S/EEQqhOsxkG3E+CUBfWg8yP7B5p7rnONTHGemLyU0bZM6T2ma0pQHGlq/T+CYga6i5odL0qfiwhONLM5wC2NL6JJ2FjQszeZDY8+uB9LjXiuc0Aw6EKI+wqoXba+5zgZ5MxxyTRw7MeoYHiK8UFnXeIc7iYGblMLY8O4LxcXDVogiF48aCWOt/8M021JBYrdkhKxdWaF0M1MBFBXfDESvpOVtetpsZgAkIvtI888yJqBzF6hda0B7PEVuoJBrWXHynfiHZumsx0rDO25bE+iggg51KKTXoWCy8RmkrwLVol0BfebRRazzyJ2yG4BmwrORKlPoFo78dTfA==
X-YMail-OSG: _iyoQs4VM1kXrGhcDqDev5I1b0aJbFIeeAglBQJF39Sj8sJm2c3x0QoiTWVo.iS
 6Vecz4gDEPzurWSHWdR.9A7HAq1tsGP3lpHHLZ2.xQ59NyjwW3X13Oo_vBZnja26ubom.azK_PRZ
 eZRaiHAlQGfER0e2bUqk_zpwFAx8ZWlUkaJPhs4QW2kMrLLa6hTpHeaTGA2ydIH5PYG_OufeAYKJ
 2E_LdmRYUjzXF80DujlbZsGEO_TBncnHcPuaKaipnPe10VyzAYV8BzDLwRA3XN_Pdb5lWRTUOcb5
 ajC4L876g.RjXnpRZIgSk1LxlwWm7n.kI.fFGauExIP1SBWcqdTTOuX626jlk_CxyzEoOS2fR9qs
 .PEn.LnzlFma8SOQwsAktoQJ0UV4NDsWN6WBgPkXut13kMyte2SY4vW6sF1DytiXIMWMWKNFva77
 bKMxMjsKEjq3yBYznsGttvVzTI_ZUrIWRDFUKekdqdfqihzC19nLrejLz7tLzZRg.shljuesveRk
 tcbKIdiHkqyca2qoBbxy_GldNQmM_be.bT8jrb8eHL4D.o77ogrfh3l3RWo96C9nZlrlktNX735k
 wprxwT_FpPyxDKm9Rf9Okv5feUbcNG4i_Hpa2M.lIVw_nxMFOLwnGFQOElSXOKsS9lruy9ogBU8F
 oP1NicuUh.QrkL1wBtirNNOPsUNu8KnFElr7sgNmOHCL4UVBT4pm6avEU9JBXEt6NejlUNRi1EDF
 KTC0FPaqyIZVHCPXMgvnRKDGzp9j.gci8wlQhElatIiBwz9yq4H6rHquigWBsMKbqrDeYw5HrvYK
 MzPI3OuNnGxbmwYBZX23mAgQ._nBB6kNPK20FBFEHV6AoMehvO6ATa3gZ2_dhhOShqw9JllsfOHT
 T4ixgCEHRSjvw0h.DCSneZruzC1PcuC0VCLIFRoePk3ErVdSN_MU6aNE65bQRHT1KW6ygDrREJKn
 70g96T_m2SGSQsgek9tdvcDI1MGa1IZ18OlPA6hoLl9R_abedPxjITyUZ23qPxJUeM.ZaWDLRp_G
 JnBbxQHff6P8Y88Pk.aoaOAERoBpep3lcEdWAUftXX28SRNEAzh2ejAnRF8lTs6YqOjynKYCfsrj
 bjMP7WCwjJc1_8OcyWgbhQRqflLh0rZjCBOgoeRrsHE5HCPRMHhDZGUdWhqiQFsthq129B58U_3_
 u_8K0I4VbTz85nAVaYRu4xysgwOnmx2vlkKsiDuk7FcKao2HCKAa6gpOUyq0FKMYY3s4o6OupbHo
 28kgAFz5RjW8LsxKkQuCY2pEyBVq8kN5twHXx0mUbudNjghFHqq91n6QHK7pfFxxFiaPU9RMklon
 9WPgCbzh4mr1HPnZ3mf8H4PLVgrveaVDZUG8KkYZHa3g49QkF45B9WwxSqWEF3q3YdOtfOE.mx8K
 s2nWtypPBNDxRWkasfOeORC_EP2dHWy8q6YywpDVG_wlS09513.Db5EJcT3YJs9OaJ_f3ESsWc2x
 BeDMyofDlKEc56TjvSjK_R5gXrFAasbA0YTlquaJqyrggd67KloHXEHl5Umk9FWvNdzkY0fHeqgf
 jxm6JEy.mkw_Rl1HKgvkPp9ecE7bJQ0czIgl3qrAVO7ZH5DNFMiRcefnXjj7.DhuaO.l7kHoMSER
 LjtjmRBujijGfq61UpvG1TonNWnch7S0VDn4lmEOJtdjXgjCwE2VmogJvxMkaF8DuUuaADi2q8sN
 X54IWNEwdpBAXaa_KEpaDqQnha7qPTJtYoyLIaREgMQfemyudgcOcgYv.AT7aFqDuNJGQwCaUL8R
 bfVO7PsPmPfTqRLWqcXXgWBY2yOAWXURCT_dMQavTfZ2qn9FiaGiD5I0Fek2CfHZw1Bw3V_IGQZo
 p9vwwiG1mUbuSgTBKBmiEagK5XhWT.X9Uyl6NrzrR.9J10BN5vC5j35Rgx5oyKmBc5TfEmTEUuYY
 uAZKGPCtyVeXHMiSx8Q2K6pq6TyZBVDh4b3SYZKQxS0.Bg_T6NOZWOcNk.Qo5H92vNkJC1JF.Zc4
 5djF2Xcz7bvZHC_9Tzb5ll0vZRcGH3tY6fwjB4O6roLvrVdJ3kNyGAdOOo36UtZZALrX7xt6gQcw
 PS3JLKJNHL7UObMONXIRwpFPeOb7dUhrCvalSmf15rCUl4kwqKsDuWvN9LO3kD86OTrPWeixyoRc
 rl9u7g0vcAiP8yWIofnUhwZTcNjc2exhaDHQFy1IoapkDPv9gSozljlDzCFOmedZbSwFI_UrI_aa
 KGtBizokxHqbJzcWpdOzlwGiSIG_t1aZDOzlfqBik6kmpvnRl0e4SFitpvSuX2.0Utshbtly9MQz
 X
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Mon, 6 Jun 2022 02:47:17 +0000
Received: by hermes--canary-production-sg3-5f7658c994-q45vr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a7a87dc6523ee7d3426ceda942b505a;
          Mon, 06 Jun 2022 02:47:16 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH v4 0/2] Add support for Xiaomi Mi 5s Plus
Date:   Mon,  6 Jun 2022 02:47:04 +0000
Message-Id: <20220606024706.22861-1-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220606024706.22861-1-ae40515.ref@yahoo.com.tw>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the device tree for Xiaomi Mi 5s Plus (xiaomi-natrium)
smartphone which is based on Snapdragon 821 SoC.

Changes since v3:
- Remove the unnecessary properties in the device tree.
- Correct the supplies in "dsi0" node
- Add delay properties in "touchscreen" node

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
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 414 ++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts

-- 
2.35.3

