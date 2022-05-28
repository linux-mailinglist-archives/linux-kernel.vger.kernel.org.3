Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF65B536C80
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 13:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiE1LYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 07:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiE1LX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 07:23:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8518E2C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 04:23:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er5so8157794edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sLlIiVjOIj+IrlayL6I/MZBzwRGIE1mUMEt33xJvxRY=;
        b=X+zTtM82Oyh2IE0XTaZgCRceZOdikS62CHoEVaDi3fDTRskgR73v5SWs4S9teYSaJ2
         DQX8GVYDGYMy5LAsCXa/qhO8pcMBH9PLbdKIBSPSzrzpO+x9EecJpW5wZfGqUEMHXolh
         gXPi2XTDec8f4UC8/CfIcXn0MTk56F62lnH5QAC5xUO5oL8PurNxkZdN8qwXm7ycxquN
         WmPYBvTHntYNelJ4IIEC4/fP0EgtTjbwH+qWwaVSW3tQyH6tp6QhlRu3DY0cBsWA3teI
         vRn8i/ejnyBjy3sJewJnN0MPgLTPaLbloxhun6s8+EoMjDZvNarib4mSrSMpi77J+NOr
         zJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=sLlIiVjOIj+IrlayL6I/MZBzwRGIE1mUMEt33xJvxRY=;
        b=UOcpngilah7gg1jKZG3GcaUyk+PCdU4kbN94TyuStvitsoLEA8U3OoSsFeOjZZWNjz
         4qX63Vaky7uHQ34DRTtSyLP14c2hBhLpR0RGHaMTNfPOLmmGVwADA6NCwKfK88DLxx9Q
         S9dN5VqvOHn6P+HRkZVNOyzPbR1uTvedpnrQ5qCGQ3sgVN6U98CsK1VhYUWEKMsR6J9+
         RC5EoWxJPmjjkIxOJGcbsipqCOwPEbMbwR+VlbvRPMH8BG+NBXE+bhVIZlI9qm9Nyi0I
         fPVJD1nT+Om8h5RdF8KG1MOEUD+6n2HBepyfTPJ4l1NFFD0sJCY4g5oJZj4d3m++gYZN
         DO2g==
X-Gm-Message-State: AOAM530f53dL3oJjVYn1oAcU8+bZBpgvEE782f5xflRjAy3VhNepnZO1
        8X/Ji364BQ/r9K6U420CHIh6h4ngl+AwPaWrbqA=
X-Google-Smtp-Source: ABdhPJycgEm7vGC3fH54my1CXpMImjHCAoP67clI7b2O2Dy9R+C/DqPyiarFWXzEX3brNwkjO0kbVlTLiLlfb/xshl8=
X-Received: by 2002:a05:6402:1f8c:b0:42d:c3a9:5beb with SMTP id
 c12-20020a0564021f8c00b0042dc3a95bebmr769339edc.160.1653737035659; Sat, 28
 May 2022 04:23:55 -0700 (PDT)
MIME-Version: 1.0
Sender: mariajohn0331@gmail.com
Received: by 2002:a54:3986:0:0:0:0:0 with HTTP; Sat, 28 May 2022 04:23:54
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sat, 28 May 2022 04:23:54 -0700
X-Google-Sender-Auth: erN8FSBW8oOn8_pByAv8LpNy3Zw
Message-ID: <CAEmdD2WwqYKSnHdC17g283nvfVY-tcoJ+xk3afteDTaKEdiojA@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9976]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mariajohn0331[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  1.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
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
without knowing if I may be alive to see the next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some
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

 Mrs. Hannah Vandrad
