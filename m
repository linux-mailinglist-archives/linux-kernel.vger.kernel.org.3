Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29CB52CD54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiESHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiESHli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:41:38 -0400
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35F2DAA2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1652946094; bh=eW/YbbxKXgMKLv8qo6OLJpG701kKXztxpEKQnU2JT5U=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=FG5aOSiQRQULV4XoGihuoIWHvEYd9vbIBQH1GtkNrEgwijz23DgF8gbEvAtMF8WnI7RpbUcxVJ8oJufYOW9scVQxseprvnmI06niK/IwWJePrDwsD/U/GXkgtJIG9NPKp3dAwVSdtY434zHqFhsgmBHBbEFKL8yMBC+LCVlntCJEzYiA/f/oWIjnb2Tf4A8jhqP54+OnCd+f5SaHc/jNoZZKcg1z/e26A7tNGN3LiAIICyZPx4q0pWX58SF5UegfAE0Fxyf9QYO3txKCjqYvCpDfflZe4doivI+496Yv3gzDkFbaQkpteAmW7uZ0VMzrqKGvfJTgnNpXwjp8QZRLgQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1652946094; bh=u6BO0Zd+Cy+gJtYWsHHPjt+FuwtHDwWuMI4NnFVBSHL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LKR+6F+ZA7eagdZ0at5gAcBS/tuVdPXPSSCyphj2j9Il2VKPDCV3n5DqrPSQJYd6kGw+uV+/NGVOEflPW6JY8S0E46F14rp2aautX/Gmsf4Yhgj/YZCSxEIhHfYO2ngVpEzxFgIBc4QLRqmEfwpAYygNm4sVJAFtqhvGYTgZRE6d1cYtiC/spglP4NU/7t9dJPhU8gi8WtTIAeyg+k81bKGajjIgVSzkKfwearPsRna8Ry5x7iRHz5+r7z7x8+75dDUkv8xO3Cr7+LFnbssN4J9aak/7iVJC8ZnCDuFYANrAgJMO9KBahW17HIy7T6fYUuwqtm80G0zweXhmf3BBiQ==
X-YMail-OSG: qgepAOwVM1nYi6L6nKnmHovj7p_hpQRErJbyUFIpYJNCZeMrFVFXP3T6KB9tvbB
 IkQUmfuyZc_sTt4T5z5J_3oGR0MhtPRYBXiVqpEWy1SLtjS76sXp7fgZ7DP09r6pkFHi3kXUpkhi
 KfZAVb82af_0GNjIoDnTkOiycU0.yV9z10fjb44bpaZa9gRJDOBgFCbNKHdVMYLu9A7okxZ5tRkN
 L0GQF9Y61gJfOiLzqOj6YtwqzB7C371D4vghQ5UOOTNOp.4MBxRT2J4gV7RRcSPMiip9kXX45KbE
 DXNwzH9JNbgDlH9bYPOy.nrrwNygJBqY._8ipAW5tPWOk1ZIoM1GiWU13Sc7GM3.iP0MLeCrub4f
 tKqfigMqjo4dKsXWPFG64w8NeY5i8BRJ3j5lvq1PdksQM.rz3URIJiCoovYX1zXlofbPloOW8tvr
 qv7sipal0bxJoA2HfVIBp6hIPcK2RNO1m_UFrFBHjQ01krZxqOcWCd.BM1XhHmxZd4xr364FV4iZ
 H5akvIcyBQxvgmhdkjN.Wx.20kC1JJUDoeBIbQvVWPBe7kXfnY28ViKz117sG1o8Glx6YK_JDnWn
 FyTm.Cyj1JxkGFuPfQ1hOKinXDqZTLYN7bvCwHqL37FR9XTiRGLeGdpUUs6Vh2qMwgl0w1MfYY5a
 0LaIZIla.0wc0KYVY1wBvP5kZiGKcAKyV9aeXQpTpHYaDIBM2.B6XpPpSbTG3W8OHHZfVfmRC6Ow
 ZUh75Cwvxp1fjb75Px2j6E2kr1f9XNJhaognhQgxGrEqrYMvFmRbGYGzlzdNFtE4DTcLGZz3G9wK
 Axax7DSka6sjpWPu1Wxyoh4GHYRaCM_pRF9mv8DXMBJgNYhRgeVK7AfHQPSKQ_5BRaHNBwjXvlhd
 prWWiGpzHYgHtfvjqeYDHHJ7Y301WRLWXiKkdZkidElftpNZaX9Y6IqjZjEPpyUKIaYurujYN8BJ
 BMFkfnD6_2TpGRB.UF9Ptp5TNkA7sIJLdE0JP9yndB8v7e8kRriiID.I4OwSALRhchzEhXLBZlc6
 Wv9Lk4tfEv8xjRdh8CARwZzKDpoKiRbg4hMWeRocFYFNnV8LIRB9EtpiseTYnUSo9Bb0Jyg.6stT
 HueID1lgEQb_m6qUD62fhr.jLtggVVUAz1lwBT5YMZ7hRt_joLwmPnbQAC23oUoaHLlCRfIs8bhI
 UtJZDCzXyX3S6T9ft5xlPFD6rskVQJmSzkFH2ua2MoJW3in1LMUT4bOtoFCe3W9HNgNXBU_Wh.8i
 tuN2EFIoKXAU0KdwTkV9cu_ckdP6Ni9o5nzFhJEsqnegnf0XfMX6UCKwMTm3guG1fDIEsOqSUQYL
 NSa7HKWfaiXUh5A9_MtJ458rKahO7Dz6A3Q7U27p.Yz7g6Xd.II_ZYUJiCbRyoNdrwKXPQFkwROa
 TkSs1GIep56Imph0SOT2k1sL_M0.j0IiYHOjg1VezFDM7WBgluVp1ozylssJd.fEyuJ.SMYRa7TH
 n9mkMXSQQCodFSyetbWzWxFJjtxD5jt3oyRrnK4X8xhGHn1lOei6DBhOP6SY0Vqhy.Sm57sA8Hs0
 6fxewaGEM9nN2T8fxfo4sB.sezyo5gHIVU9O3Lsz4wCsEp5RNrHm2EKQcvJ5B25SIE0.gS8DMmKp
 Z.py7R1BIIByhAh4xXKgEb2qkJYHP4PSNy5aolYP9QNENp.QnzKu1Fbm7yDntHnvCHa0gE4zUeXl
 p7_QbRiq4pPQw8_raUezQGtYRcsHy5UwsIMNpkZCIO47t3fMUhgxEB5PgnQgxSXmKhCyA5nDCwYh
 nPmhBZZcmk8WyTFukFNNj.Yr8X4am4lpRkbUcglwy0sabbNTeSMUWGZ06JmFSTtJhLQPgA2uLisN
 oxx6xbl6OqRjCbqpZ5yTL0iDQzj8TooM6R27Ykh8IOM2IrEm2Z5JlCtT5HBawIxdjbL.50H7fYNu
 MVpwnDv9EAp27uvJePZkPwLWfZqZf85pTcONFgazD2WkO9muiWzluIYm_D8fbeydkU4Hz7i3.A_x
 B4GQjRmtUExdgpcMdIvTbcqnXPFzx_H_4_S3xLIgzkWXRwniVlOq5EsHCgeMm4_QzEfOxKqSQF8T
 sRsuLB20aC32O7XBJzzitIU_AAsAg9ygVw8FAzxZJLMN6j1WsHkxHGXOILxoys5D6GLAvuVT10EB
 npmbz3VEPyZOrNSidHB6tfDltn7TFM7UM.ZBao3V0TImT_9EoH0ELU4xExapp1Ms.CkMAVEfoMAc
 M.4p_6hzzlbkXK9P7FqGy7D0dpqzgbGyFRCGYpxxn9M8vQFUTVR8fdbtjksXe4iS7elJVeg--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Thu, 19 May 2022 07:41:34 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-9z8f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ff485e39d08ac88db91aa318bdd89cc4;
          Thu, 19 May 2022 07:41:31 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH 0/2] Add support for Xiaomi Mi 5s Plus
Date:   Thu, 19 May 2022 07:41:10 +0000
Message-Id: <20220519074112.25600-1-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220519074112.25600-1-ae40515.ref@yahoo.com.tw>
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

Alec Su (2):
  arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s
    Plus
  dt-bindings: arm: qcom: Document xiaomi,natrium board

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 419 ++++++++++++++++++
 3 files changed, 421 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts

-- 
2.35.3

