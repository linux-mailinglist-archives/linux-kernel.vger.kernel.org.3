Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3762B53E5FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiFFNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiFFNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:40:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA88E1B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:40:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso2102078wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=94FE0xqKYNBQJ8bbUNfhKNNPOc38KM25jE5hqWXLeJ4=;
        b=VrYr5Q0tbGuZmplgrj7rj00oDDtXl8EgiKGnqAv8U714ca7+mCBHgtnSQN4/PyqI7F
         QuZIyqTouM3V7oOVzrrycAElg5oGPeH5u0l/7c4gF4c+4UAXPGqXKHIE2Dg3DSRH2W7k
         nbP8eSZcScq3UOWh/gp/rEYMsFb1dZirWiGri8rypuYb6WM2HmjnAmFWulJRcls31rJH
         cB3Oe73GHVD7q+xJHqmFiuyHlFFLrcwaz0mVy+/5VFtutvhnt8JEOLqzAX76LNN4TjwW
         +e780fpesJYIVd8G8rUZyhyp8+GBF5R3Nrp20L//FyT+9j3hQdrh1Ow0uwyRVDERkwK8
         GiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=94FE0xqKYNBQJ8bbUNfhKNNPOc38KM25jE5hqWXLeJ4=;
        b=f5wKlXY3M3i3KhToI/kVAjAJ0i7WHBKnrBMz/l1z3I5KiS0GyO+TOQBYnatS/Xr3OP
         wrZ53Km+feL+sgVNLDGdygB7RKYwNPu/JZqa6AyKH4TIGxyhyHusy6Oip8iifIVQqG46
         Nu4dDqwcS3teuBTSkdSAgtSZJ/dgwtNT7IwrnWxqxHvDBXf8we7GxKwaycVJlVwDa+BQ
         Y1kgbXwp7EJe796M0LtkJvXu2afZzBfN8TG6ZGmclw570oPVaOIJ6b0FgAS9lULK+02C
         8X0zppvknOjJuzoOeBQk4AchRXJL+vsKOO7T1qLHero1l2n4H+O7LzL/xDXALG5d33dr
         4qUg==
X-Gm-Message-State: AOAM533Qsd2nb7wKkCDBwSsmgp3/pJyaOBqtOXar4gKlFDXHWPu38LsC
        QFH4vMLlKfpA5LYkLn6NgosEVt0VTcj1O1Ck+rw=
X-Google-Smtp-Source: ABdhPJxzNVfHC1jGUwT0sqEv2G0thos5P9r8fMaQS8c1WRn74reGkvYQUn4co293qIEPIELweEz1M98Mxcw3mQ7UFes=
X-Received: by 2002:a05:600c:3846:b0:39c:360a:9ad9 with SMTP id
 s6-20020a05600c384600b0039c360a9ad9mr20508938wmr.179.1654522828289; Mon, 06
 Jun 2022 06:40:28 -0700 (PDT)
MIME-Version: 1.0
Sender: smithwilson780@gmail.com
Received: by 2002:a05:600c:4988:0:0:0:0 with HTTP; Mon, 6 Jun 2022 06:40:27
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Mon, 6 Jun 2022 13:40:27 +0000
X-Google-Sender-Auth: lZPim2gTZk7AB4JvvPLb_eY5JPI
Message-ID: <CADh0mysyhvXWo57Es7YXP4VE8ZvhmXvBnFjRmjpf87y3QWJGEw@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32a listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7345]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [smithwilson780[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [smithwilson780[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear.,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for..

I'm waiting for your immediate reply..

May God Bless you.,
Mrs. Dina Howley Mckenna..
