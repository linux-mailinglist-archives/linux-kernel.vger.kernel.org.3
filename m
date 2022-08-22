Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD959C2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiHVPjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiHVPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:39:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEAB10547
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:38:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y141so10694654pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=Bt5OnuHoLWMmd8kWNIJ/R5jWGGMn2gQUophJ4PVrMCg=;
        b=KAQ5JnEkiyPTX1ixRcY1lxe6w4tclkMk9JYoFuGzhXmLAv2YEsRuL+dmKGXKdtZHbD
         1nmetAEjUGP8B855hSW3fKIL79Eo2ehzywz3qRYZJa8yTbC88SGMS3FIsQ52d0lC4QZY
         qF+u/l0aUiy4npT6yhapnHb8ysXVKrTF9QSCoqaaklmLJeoAp6lVmmALcmyybdI0pvJP
         RSNmla26BXbyc5MlrpJHGp6DVWowopvh6x50+xfoii3xu9E1GFUwF9T7yKeBd+BzmxND
         mLQxfmoD9QdCXtd8t4WtjKvMAfb5V6twBa2wkfBRg+EuAs5XRP/wKtn1NRWCPw2FqZ35
         QZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Bt5OnuHoLWMmd8kWNIJ/R5jWGGMn2gQUophJ4PVrMCg=;
        b=FVnWkm8XdpY9+GYnVwa956ihnvKXBIwvGVxmN7f438xHO6rVSUs19uN9EZI5jQq6bq
         xLmN/pDhuAlOIC3v1m4rrRwYKfasUmJnDjt1FdtbJ7Pio0vTVkY1YbhZ7U84C4Mocwyt
         xlPgK1cDG3xlHPcbM/1Xt61zyG+OZJ2ZHK31hd0S/r82Akfimz222nUWEQiSAsy5/RsU
         n7XxpJWe2F7yTtOV5EnagRLkypgE9jgHsX1Ovsb9szOLfQpzf6NWBcJGRNh2bhC9NGIS
         44n1rZncV55QhLA6sJIOpsRecMr3ILougEGRdOC7RQpAYmey7voNFVOZgn10LINDBPmz
         EXKA==
X-Gm-Message-State: ACgBeo0zkNOXvE3PvbmZFAoixts67jwKL4d9jJx7RwXMuVi2dyue+XuS
        zNq4GbQI+kihKE7DolknUvapjHsbMQjmjc2cmVc=
X-Google-Smtp-Source: AA6agR45fSfuHXA18RCwusyg2CwMGA3ODaefpMQlrl8knjkqBPWr+gqZqgCfPeuhCqPqq5BQp1z5sjwd1c9ZNHFOmqA=
X-Received: by 2002:a05:6a00:2308:b0:52f:8ae9:9465 with SMTP id
 h8-20020a056a00230800b0052f8ae99465mr21046562pfh.77.1661182738676; Mon, 22
 Aug 2022 08:38:58 -0700 (PDT)
MIME-Version: 1.0
Sender: dvavsvsvsvs@gmail.com
Received: by 2002:a05:6a10:d142:b0:2d6:7875:e094 with HTTP; Mon, 22 Aug 2022
 08:38:58 -0700 (PDT)
From:   "carlsen.monika" <carlsen.monika@gmail.com>
Date:   Mon, 22 Aug 2022 16:38:58 +0100
X-Google-Sender-Auth: QVU8MPTQ422kPcOL_kc9RFXgGt4
Message-ID: <CA+hPWRNiWuUu-JWD1GMuvF8XUk7n37=jh9tFHexK6R-ZqQyuAg@mail.gmail.com>
Subject: Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dvavsvsvsvs[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest One,

    CHARITY DONATION Please read carefully, I know it is true that
this letter may come to you as a surprise. I came across your e-mail
contact through a private search while in need of your assistance. am
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through internet because it still remains the
fastest medium of communication. I sent this mail praying it will
found you in a good condition of health, since I myself are in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day.

aM Mrs.Monika John Carlsen, wife of late Mr John Carlsen, a widow
suffering from long time illness. I have some funds I inherited from
my late husband, the sum of ($11.000.000,eleven million dollars) my
Doctor told me recently that I have serious sickness which is cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way am going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained.

I do not want a situation where this money will be used in an ungodly
manners. That's why am taking this decision. am not afraid of death so
I know where am going. I accept this decision because I do not have
any child who will inherit this money after I die. Please I want your
sincerely and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. am waiting for your reply,

Best Regards
Mrs.Monika John Carlsen,
