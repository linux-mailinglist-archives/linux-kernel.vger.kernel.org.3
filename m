Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2E557ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiFWPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiFWPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:46:06 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691D37BDF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:46:05 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3185f5623edso38090797b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MCdBPcvc3aKS/nhtwFdXptVodbMIYgt74UixyLgUydo=;
        b=f6goSR6ZbdZjXT1FK0Snv2VFi7Wx1RINfWlfDPBfP6R47/NWgFTESA0vsi4yBfKq70
         8y/kErk4H2XFpSWBNzTl5ULkMz64HgDKLeqyliFYhSHjORgkDRmapzsBlneZg62AJ032
         wyuu3J8wMyMg5ltYmZ9f9wY9onUAQy15tCZrKsPUj7I47udvcYToxOLPzxXdbxxnnAjk
         NCVvBXmB6KUg4jfipWp2XQfjDqYEBIPjdwfChK6rwSGXPaqxbHZXBoXuGNqtyQBe40yZ
         svVHlZPqJ0DmmzgHr9wBpoHOl/mTAAYhVkTaF3oZ3ybLYQyU9Y2x5BeNhUJx3nEUx54N
         S93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MCdBPcvc3aKS/nhtwFdXptVodbMIYgt74UixyLgUydo=;
        b=evd5HDl3FZjLRdWRIrjda9IemQ5hMuq0M0/YZlrZc0+0taXwtZAdA12bQ72ReOMBWF
         NNK4Vu3C5VUY0+i4nCUDE4f+ZJ+hNviWWAsU6NfIVch5EAcA0T45BFfFPbmhFBlXIn7J
         lbZj0vc59Jlx7GtBkfJ/qZMiKEtNsznD3peeQJ1Du2F+r81o6LmzcSx2XwY84+sMoQXO
         t4njAmuTqyLoA+EWG1MJ0SvOeQCMNHi682dSHn5AkNoGv6CiF5Ywo+QT6nAIJ5Udgm0/
         iqMT1G23s+TYxMJRZdpDN0uxIvtc3AP4I9m07hM7WOmaw52Y2KU5g7dlJQ4YYUeOBwjb
         129g==
X-Gm-Message-State: AJIora/zaXEKXfiL4fKOCop56X3cMSeXtXI7SAReVSO3PSpgeKVwXz8M
        2UIcQE7qVRO+FtryDKjovw8fHNy1mOq3o9wysCQ=
X-Google-Smtp-Source: AGRyM1t6l6W52kvaF9sz8G5Mdwg3kARVYc3tn+JEaAZlVmp7aIIP3MZGntjMhl2lV8qE8i9Pc1xMOMvFoOzd32GpXLM=
X-Received: by 2002:a81:1001:0:b0:317:d614:c3d6 with SMTP id
 1-20020a811001000000b00317d614c3d6mr11262541ywq.164.1655999164618; Thu, 23
 Jun 2022 08:46:04 -0700 (PDT)
MIME-Version: 1.0
Sender: robertroland0331@gmail.com
Received: by 2002:a05:7108:6913:0:0:0:0 with HTTP; Thu, 23 Jun 2022 08:46:04
 -0700 (PDT)
From:   MRS MARIA ROLAND <mariaroland74@gmail.com>
Date:   Thu, 23 Jun 2022 08:46:04 -0700
X-Google-Sender-Auth: HXN4nGNGTkgF1wPpoiEZzDuRpDc
Message-ID: <CAKnR+Cc_wM+WHRW8KqqstSek10JtRbsYxvv0MZWQ5ccnPY=gVg@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5195]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [robertroland0331[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mariaroland74[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings dear


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god's mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Maria
Roland, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,000,000.00, Eleven
Million Dollars) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

I am waiting for your reply.

May God Bless you,

 Mrs.Maria Roland.
