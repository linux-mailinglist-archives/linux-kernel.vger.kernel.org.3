Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02554ECB11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiC3RxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiC3RxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:53:05 -0400
Received: from sonic315-54.consmr.mail.gq1.yahoo.com (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D514B9A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1648662675; bh=S9N6/sBVLY/JAPayLt7qbZOjEkabiJDDqpnxGv3U+bs=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=eWvDDKEWZriOR5XA9kBYjzxjWWcDA8lF+CQFy6UxdmKIlho8U6b9MWc5d50GrC3+NVGjD2AhLaDAWDPbkmXlkH83RejEzjlAiJQfhLjwQFWdCXxsm069AslT3p/Y2yJ8egjEd9jUoOYSFGxDKIA96gvBqJO1U857oE7zv5AY+4x+UIkrnaq1tg95toEMtQKtDROmpolx3Q9BksLMDbubDFau4LfTTOqnS6G5ViEN9rrl1uyfNBYLNaX35cfKLgfIa98gQkhOSdmWrZYIysXwc2BHMcRPBGQtrnZnNtKAsk65Yf9lqde0/vH25iCUB85iBYu9B2eOTvEjQV+Sdp3o/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648662675; bh=Ki+92tcD5zPlGTaNGnifnzB4BNx7gbEuvhCD2uTaf8x=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=LS2EpQszzDA6Gk/Au11Ncn6Hd9O8El+TKy2fPzvVvp6pMbm7Aj1lCDOGpDe9VwfRFQIZ3KPzLAoA0+cT8MiMRQq4OR4rdgg5NuqUqPI9GNE7xOCX1TWFrvh7Zu08UAJQYJmuu5vXcYwGLBmrIxXVNLkNFOpCanWvjfL8INNSy87ymQt3WSvbRqyf3S66KIZ4KAzRbgQYTT05fPRb/DJyCJ4ssjZP+jOb/L2uWaK5Pm5PKVJ5dIN+PA1WeVbTeDjyGOlP5rCUc8lAk2FrE4p6Q9CuF8MY4gOQEpeBjkGkfvn75BHCcByCHymybV7O/McwNjfh+muEvLLrGCQJpVqiNw==
X-YMail-OSG: QQbdEVsVM1k4R2Boazup.tObBxhfDZFeV9KJ4xvxBlCqx9j.SGPOSKU74yCbTiJ
 1jrdtYPhR4hVAOrFrq6JU2rt_v7LBwQ7CazExg22Ogvy4K0LsV86NqHpHHZ6T7CVgKNITynuakLM
 svflVxvT.DMtv2zZBPiwK6Pxbo2MrPTh0f5hivaFZIJ7PlzRDGPVugMnokFuWw54w75c.ff6r.sN
 Nud0AuaMJg1jBhxUY_1J5CMogbEIxQnnYs_NYi4JmAGY8svqsP7KwRYkEC0XkorUBCnQYoxhH.fA
 imhC3faLMSGBiBUleItrpAWPTR_nxeyhTob7NQ3zzzrzPJLarkKlFQDqQTeDyvQ..Rxw5LkdQwFg
 XLUN7NA6veAMevw5qJe4QErmSY1fliXBL.pSwF1urIcyrqV2uDWgYCVQoviv0we21Kca6dd5yXyg
 Md5T7s79v8_LGWx0TFJlOM7BhYsdpoW8fywZPNs8BiSeb9R4H88JOXPHw69nOj22ngxJJ2K_Ntnx
 hwjH7WLm2RpVvlF0OJnXp0yF8aBfFhaB6FkpIZTZMmiIvq6XOd8ohdGHJsLV1gYtSPYNJ_G9CM2f
 vUx5u.0KbpWLB8nOogPBx63n4QiobwamP8hbnfvN0m2x0qxM5qahcmgvVBE1HfgY70oD941EekK7
 iW4YL8cXjWOIeKTOLLhMwwvBE4aeV2w7lgxMqf4n7QOFr9LsIbb22jW2sL9RUCiY__rwG_mJlH3C
 vd57dO4mywiR0IkqvEz4TpJ2Z1GnvbyYmf9mv6gSJXKPKe10uw.LJEljT7ERNvrK05u2N1xGmhRj
 4Er7.C9xpqhE0DP5Gk2DISQYfKHg10g9oUv_0jZh4Tg1qeGPSyUEucl5OkMJeeKnRrvXHdkIXX3_
 C18kn445QpTBkhvhkgyAPlXsEhEWTGqTg6Cf8TEZt5yBF9oxvP3EdK4.ta.0jKHG79INsffzLy1a
 v5eeTuLUvbXdJIAr3l4ZHxz2xcKSgB2eJY8bEvWWF8P.qbOcfPq5TW36Pwlk717VFeIMMVlQdzJR
 bmNOMPA2i2EMUzUrnHuiW_eo750CkiGHPHh56pTMjW2j9cTNGVBen895FWqMOzVx4xkwKjYq6znw
 UP0VFXqBThjnFiNocpiDYrtQ8kpL_QfTwRsx0iRQWGRksqIjp6sGR8cKykFTDq9F1wgO.NPwPCaT
 ksSj_qgansF2dj5IBSlp2Bn6Px0t8OkqQKojIqNpAvNd8_4aPZo0DGYq8cZvphKzDTZ1QL32YIzq
 1MbYfo9cwyvMNJlSZyk9zWZ658xDgPzztt0euVEqfgPkdhgwgqW8L9ASFLUhCWNsGJxsxyZPOcnK
 .eG29_VEYWlbLpeLdiiDRetbQ.olJE3oC.9F2YXN_fddCE0TH1.aN83mllO2BK56tM5z1Y.O1BVx
 78kPuF4xsizdu8BeKzdi5qRhBMw86vWzl.yEX.yTzayL.tdVtF79p7OAutRTvVWbTvw7f.Uh6thC
 vuWTPd4r_UbW3MggUt0JiVLpSK0JN1rTwIPki1VtsIR3zWRFSMmgLE3iX8FP0FnIRVTdRniGldKA
 Jm7t25LpXGXCDBpnmiekjSIDmGbF4SDmwhAtrig8GRa3pUHk1lfiq02MLcl631YWWwn7Al956fP5
 x53LD1fGQSt6OK1DUrtmw1dzByoB7oJPOgm8QQUdp0n6OYyKDMqlWfEt8d2HAsfWPAITepxlgpyi
 9LweaJZrpZgWd3olCRA_ayvGhw11_6CFjjoD24h0Nf7oAkNDSxPsiGg2iIvC9nZzMJWUeYu6SB6_
 QeL_3y29vj5t1Je9wlBzbg3ciwjUIzF0FETIfmhthTRJLYVESwoRRoLb2fr6JoNYwgjcgpTy_7EY
 tR7NwgXGjkKdfAHnvULm._MUHri.P6T3Nuaos5a1LKI0w0UwP4cLgby41l0Tn_0jnyIQRKY8roKX
 kIoyKwlDqbDzWF1nvnzPm9DuEpyqSMljWFIyG9rWG7_rLxH1fWNF8aj3QKudaabbL66hcztKbdvv
 PnkClKyebtc42MeKtYkyJy4CGJmsPjD.sX_SwV7KLQGsftcJrAdgxZVoWxU5.Sb1BFbi0.Xnj6yP
 xi8RU83Y4MTsWzimXW72t52odekMjyCm30rVXxOEoNByIplg8G.ny8yn4zuGbjs.lsQpi1uC2cFA
 gbIo3Ch96c0wlVQiZkSiNCA6PsfJDmgQYGPpf7DtKfYF85RFy380ImOi_Zf3JnsH4ptu6xjM7.DU
 ddVd_FyN5UjokBJp33gzM_v.DFAl1cG3TMprPlLhgGwYsRzK.DZp7MIi2iDJAiZJBT6h0EDguULV
 eXvmyEq7JxDBY5Q--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Mar 2022 17:51:15 +0000
Received: by kubenode520.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3767e03bf643ceaa3a5f31bec6822e45;
          Wed, 30 Mar 2022 17:51:11 +0000 (UTC)
Date:   Wed, 30 Mar 2022 13:51:07 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
To:     Christoph Hellwig <hch@infradead.org>, regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
MIME-Version: 1.0
Message-Id: <1648659326.eabkokyuym.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1648659326.eabkokyuym.none.ref@localhost>
X-Mailer: WebService/1.1.20001 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a recent kernel update, booting one of my machines causes it to=20
hang on a black screen. Pressing Lock keys on the USB keyboard does not=20
turn on the indicators, and the machine does not appear on the Ethernet=20
network. I don't have a serial port on this machine. I didn't try=20
netconsole, but I suspect it won't work.

Setting mem_encrypt=3D0 seems to resolve the issue. Reverting f5ff79fddf0e=20
("dma-mapping: remove CONFIG_DMA_REMAP") also appears to resolve the=20
issue.

The machine in question has an AMD Ryzen 5 1600 and ASRock B450 Pro4.

Cheers,
Alex.
