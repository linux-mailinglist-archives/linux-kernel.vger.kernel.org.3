Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8135A0C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiHYJQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbiHYJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:16:15 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AF4CA21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:16:13 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id w129so9892249vkg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=01gL4+t3up0n3YaVmNIclgohHRPaUWvI7fAUf1IOa5c=;
        b=ScETR1HKVq+IR22ISzHczfRvniVIIt1/PBM91HCUo9iL4OQlZrwuu+X5ZJS+Px8eeM
         vWK1f7WO4XlAo/hJoXFY4Pl4CRLz9ao0H4pKHcld2zNjIVSBRnufM1UHuCkjZ+7+GVDk
         JVYv77e8xwK94KolmP/pQu3jhMxILc/4ykuTOTFmjoNsI5OG0WvAO7yqLl8ueGBbjRIo
         3izrrauHJvTkzV9qLswci2jx8jr1S6eVKEFMPH8Y5aVl/KUbQ0801uNR6fnExJc/6UTy
         7z819eMslCxv/zMvIMpr/JSBtSOYdR5ExFo7fRzdWisaZNlwYAnKpKjXnHuBcWFKv5/8
         cNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=01gL4+t3up0n3YaVmNIclgohHRPaUWvI7fAUf1IOa5c=;
        b=7uwvZRiXThAX4Z2G24LiTKaXuOTJraWaYQQ/o2HCVhlV+3JHqaFUW0dJrAZg7ihiuy
         Q9N1MO+J82J4PoWnsio6gmQ6fWGapRT4qxQTplYqS0wQrRy5AoE11BFLF1Owby/8CUk5
         ZlJ+h1nIgzZfEkDdlneMNOCE/K8c5ATx/9DCAbos9G4iCSgZ545aPrbtXaR28cxoYGuw
         uQlHI9lJyawa9+4a48mqvJ50hiSRDZBo7ybVfgzykMQaBWV01rDFMNaqyYIN6qp1hcOu
         WeylVNZvWiyfKn10RzEkl0N3L/Da2mbs4O/lQ19zxi5nlqyXzDZn9w+K0ZgsvXYigHfI
         7fEg==
X-Gm-Message-State: ACgBeo0r4+nH5MRSSfJUHjYzgWUZEARPQn/ptHEXwp+VBtVoARZdJIT2
        jDBVnhVWVPEEbjJNqHpXn5/OjVJ2Xq8X1f0X5Bw=
X-Google-Smtp-Source: AA6agR6L5ielWa+Z+7mGVATkxA0iFHFCnHaDt4NADZcCtYLwefu1tTsfFw6gIa7D1xQPrQLVfRkiZQXhh78KL+QYt2E=
X-Received: by 2002:a1f:30cb:0:b0:376:486a:7cb6 with SMTP id
 w194-20020a1f30cb000000b00376486a7cb6mr997526vkw.29.1661418972357; Thu, 25
 Aug 2022 02:16:12 -0700 (PDT)
MIME-Version: 1.0
Sender: gaddafiayesha532@gmail.com
Received: by 2002:a59:d9d7:0:b0:2eb:a171:5220 with HTTP; Thu, 25 Aug 2022
 02:16:11 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Thu, 25 Aug 2022 02:16:11 -0700
X-Google-Sender-Auth: ffL2YbmJ6KmqBXUK4SDlqEvzNVU
Message-ID: <CALeZTrfy7R0+4xETpmY5PQ1E-29dZ+giswqP5o_GY46HRQzgeA@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8588]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2d listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gaddafiayesha532[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.doris david, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of ($11 000 000
00) my Doctor told me recently that I have serious sickness which is a
cancer problem. What disturbs me most is my stroke sickness. Having
known my condition, I decided to donate this fund to a good person
that will utilize it the way I am going to instruct herein. I need a
very Honest God.

fearing a person who can claim this money and use it for charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs.doris david,
