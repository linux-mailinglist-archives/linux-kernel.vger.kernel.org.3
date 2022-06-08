Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEA5431E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiFHNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiFHNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:49:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91AF5402D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:48:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r3so2433028ybr.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=o2N6n1QI6lKWmUqjcr5ruL3cH/3TRrrOQgCubIGMFxk=;
        b=LdmQq6WuoOtydWiv8Vf5z+gAmjGuju0Z6/BE6V5H5PVHkSSB+cYyV7d1sx67KXNiih
         jTcurnXYzKws1GghtlGuDnjeV2ZUTaMC7GpiyAqXGSqlBYfqxSu3UvfLOQ3aUihXAj8k
         K2UvrT7cHoglbaA+RQKfPsBsJbmDx+wcozZr/r/jyNkCxNzNmFOezfTJyrxRLiwvXt7X
         T/KJRh+/gQDT6RwZh6J8YCI7AdLOPSSW/dkLufouSRx+YGVPWPsPtVUlozMh2M8FqZWF
         BNIU1XWLTCz9xKD03pn50+kxPe9MvBK/0+HJBoRfMmiLFUsHGRXLIyW7J04Lox/d4ily
         mP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=o2N6n1QI6lKWmUqjcr5ruL3cH/3TRrrOQgCubIGMFxk=;
        b=Hb/yOmhwv+p/V+qJbkxAqsF4YbDEtsKBrCB9ick+Erpd1rNNZphQhGYkyUjrqINAWE
         Mv48pFo9Wf709gyGxYE3Yid5WH/jnKj48GqJbhti08h2dfQ6mOrz511YWipN50gl3J4J
         5QKz993gKkWi3Ij4XTIPSZEGuyQl7cGVZkgvtPqn9JupuV1Wd8u/WjWIIGAXDfVclEpb
         nhEqCDLR/rfSAmrbwmCV2sVmiuIka0qJf+CUEPEP5SZ3d3xyFJoNpreXomEA1wtagtYJ
         +5mhskfSfrCgfWkiaQnhnQNpuwnmRYE6VDvbB242kSNxIN/U1l+p1Em/1nSB2WB/SNbc
         veZA==
X-Gm-Message-State: AOAM532F3fgyXHPVxPa9BFRshGMd1zLMfSDPXO2UhH0gjKC3dhBD74O1
        KWuopv+S+ZOKciwzDtuue4bw8FB1S+j0LrcQBAM=
X-Google-Smtp-Source: ABdhPJxvU+v/kZ42MYgh01P12r181bBrf6iF1nSXir/imh+e286R7ii/h2w4cnwuDQCLj2Psh+5+AYyFhZwF7ckhfx0=
X-Received: by 2002:a25:542:0:b0:663:aa09:4525 with SMTP id
 63-20020a250542000000b00663aa094525mr12925292ybf.591.1654696137744; Wed, 08
 Jun 2022 06:48:57 -0700 (PDT)
MIME-Version: 1.0
Sender: samsonka22@gmail.com
Received: by 2002:a05:7000:a50c:0:0:0:0 with HTTP; Wed, 8 Jun 2022 06:48:57
 -0700 (PDT)
From:   MARIA ROLAND <mariaroland74@gmail.com>
Date:   Wed, 8 Jun 2022 06:48:57 -0700
X-Google-Sender-Auth: BOltr2-cBAdAQnjjSQY_0u_6xMc
Message-ID: <CAKY8iZrM0=W4WViGFzgvHjv-W=+pqaB8wcZTYT8Sqbq8HKoHQw@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_95,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9813]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samsonka22[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mariaroland74[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
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
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Maria
Roland, a widow suffering from a long time illness. I have some
funds I inherited from my late husband, the sum of ($11,000,000.00,)
my Doctor told me recently that I have serious
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

 Mrs. Maria Roland,
