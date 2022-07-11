Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6869E56D72E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGKH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGKH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:56:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4F186C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:55:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j15-20020a056830014f00b0061c4d8736b5so1167640otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=q6o9JVRE687hr1p3UnsWW+UGjb7NYoGpQcgQLTRc/EA=;
        b=NcB3UWoeVTuWWYfvJO9tjkVrw3frvptajR4mjcMeGyPHf6dekvpbXb5CMnFL3QpEZX
         kphzplbp6KSSr0yxOZpTFG7PTT8wp5WLxNkbFbphzVoPdlUqHjISy1xNOEb3fqUv1P2y
         vgT1CQr1jNZJEgcCrd6lmkzRFM6AUz4nv5kzYHNIMpyAzxXJR7RJXHNQLpQ3869RazMm
         Zlzcj/SpqStyj3RgwqDAb4VzYs2Ec7sg1uDgvHZVXnUJ1Xw1Jpfxzucm1QHdQorhwHTC
         OnX/DP3OEh1U6k48Jnj2IJPwB7zmdSoRhvbHM3aB6Z+O0saMxmS87poHSXZrTvjKf4WY
         xGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=q6o9JVRE687hr1p3UnsWW+UGjb7NYoGpQcgQLTRc/EA=;
        b=L9HQT1ok6JftR/j0HfF54/Im50Tg9z1clEBOG5jV6sF1HJuKjLyDMcwOkAWCoONAdU
         u1ezYXsZQuAW7VtDZstkoT15xsnx27ZZsd5HFGtUVZaRDH7llNh7/dwUffFUY93E8Q3i
         AkXGxv58hDHxVHbWXPd1fNjTl9bD3f0nHVnSULlneNSnItxnd68f6V/Zfq/GKVva9WH5
         Bl+9ssgkKcClpY7zuEc5s6/+/CcDzVvi+ZQLTGWj2tpKPzOpH4aOjYRjvw9zTGMSsTSl
         vn4b1VZE5G7/XAQCkWZmp6efZDXfAnJMolHPWCc0bxDWsjKe6LoTcZys6OVnFeYAftXl
         I57A==
X-Gm-Message-State: AJIora9mknLxEXyFvroqWSyNVK8K7R8EAhXKXbX+hm/XKVnrle7cnSo9
        5si7ozI8w2NGgs0RRNJGAWfGcu4/b3qwPaZP0uU=
X-Google-Smtp-Source: AGRyM1vOyjTiq8QRa61DwTw/ayzCHAhd8qSwJW9Ev/hRl7untuLhXMC8MqGy3BlFnqIW6KvMSQ7uxudPaA7oxPsNKC4=
X-Received: by 2002:a05:6830:4489:b0:61c:55ca:ecf3 with SMTP id
 r9-20020a056830448900b0061c55caecf3mr121888otv.198.1657526158492; Mon, 11 Jul
 2022 00:55:58 -0700 (PDT)
MIME-Version: 1.0
Sender: dafsgsgasfsggg@gmail.com
Received: by 2002:a05:6838:bd4f:0:0:0:0 with HTTP; Mon, 11 Jul 2022 00:55:58
 -0700 (PDT)
From:   "carlsen.monika" <carlsen.monika@gmail.com>
Date:   Mon, 11 Jul 2022 08:55:58 +0100
X-Google-Sender-Auth: gdOU22b4ufiZ9yWy_FGoLmZhyL4
Message-ID: <CANR0r5OL1zuC0BCGRAQg80egaba07exbvUhktjkNPLyfM0sLiA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [carlsen.monika[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    CHARITY DONATION Please read carefully, I know it is true that
this letter may come to you as a surprise. I came across your e-mail
contact through a private search while in need of your assistance. am
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through Internet because it still remains the
fastest medium of communication. I sent this mail praying it will
found you in a good condition of health, since I myself are in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day.

Am Mrs.Monika John Carlsen, wife of late Mr John Carlsen, a widow
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
manners. That is why am taking this decision. am not afraid of death
so I know where am going. I accept this decision because I do not have
any child who will inherit this money after I die. Please I want your
sincerely and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. am waiting for your reply,

Best Regards
Mrs.Monika John Carlsen,
