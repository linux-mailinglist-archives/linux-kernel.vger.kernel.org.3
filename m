Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446275645BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiGCIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGCIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:16:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF18F65D0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:16:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e28so9156766wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2AFvyrObCHkvwVcACFedAi4cW+Lxc7JfD/cB4klOo0k=;
        b=AhJx5AZkkvjmFjU1wrwpoyKILYYCIS6fvg6rVPNH3rMIU7ff4TQrmuRfGYihfxKHHd
         2S53wWYKEuyl3vm0JnDDclW28wTYPGTOUy3WERcA303iYk1LG9kKpme6lc4HhG2q3egR
         7FM8FaFz7AxresY4cuEH16wLK2Et95PEy+Pp5CNcgNGM/xtJWLZ+hxBraMouclATCSf3
         e7+r09dOzRw0ZTJbAouiNoolJZforTUXPrCc844IHMny6W1rkCSomKSU6GB+zQMQKaMg
         u6e9fsdbllDTW/INZcTaz0I9efpc6590xAyOCbZOJgdfplIpal3yuPaeLnHJL02fiTrH
         V3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=2AFvyrObCHkvwVcACFedAi4cW+Lxc7JfD/cB4klOo0k=;
        b=YDwSfLjqGxQ09tcTwG2wtwy1tBEfN8fd+iGMKwIbxTkXGjVoS5O04aPO4mHUPp1M2F
         4etVq/rDvcDnwiZjjQ4W9n9g5pZI17p8Ir0rjoaoKjTVgp7Gdx2UGDLTxc4w1P1U0Dgp
         R8sxwWtJY4hyO3vpiNnnDcPxRoQXzTcki8oshAGaaHst8wt3D/PeOb3uE8HG2UG+KHe4
         Ex547ExAUfGuyLfwnYXsy1prggSqfAJMFmQHBL/AGLryy+wlldTnVqqWUMsUgSQs4Dus
         tAph0xxPmJJUT1qNvx2tv+TieKc8ga/5DJagKOc+WHcL3AuJS2SJOq6CF3HvcV9wOiPb
         h7YQ==
X-Gm-Message-State: AJIora9x+YP3Ox5cjaRTzRjCnl7/98MPJIF02oelLP4z5p9xkTHd2apm
        DFJTkkMQrmjZ72yOArIioIOh7r4uaxDyXXrm9aY=
X-Google-Smtp-Source: AGRyM1s3wIPXXGQ1PvOXhjXk5yzUeyKC4KCsl6kC3ZTYZ6s175d7EdjohyEjB74X9ZhIZVUeM3i9YdH+eeUTXXGR+k4=
X-Received: by 2002:adf:d215:0:b0:21d:689f:7eb0 with SMTP id
 j21-20020adfd215000000b0021d689f7eb0mr1131772wrh.542.1656836193217; Sun, 03
 Jul 2022 01:16:33 -0700 (PDT)
MIME-Version: 1.0
Sender: smithwilson780@gmail.com
Received: by 2002:a1c:6a17:0:0:0:0:0 with HTTP; Sun, 3 Jul 2022 01:16:32 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Sun, 3 Jul 2022 08:16:32 +0000
X-Google-Sender-Auth: WPwUv0S8uvyze6tWAQj4v7h-7sU
Message-ID: <CADh0myvCu6hVimr78crL4dEpdYstUvUuoOZ2WVug_iQEBdg3cg@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:429 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5009]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [smithwilson780[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear,

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I found myself. =C2=A0My names
are Mrs. Dina Mckenna Howley A widow and am suffering from brain tumor
disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any child. =C2=A0My husband died
after a brief illness that lasted for few  days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($ 11,000,000.00,
Eleven Million Dollars) with the Bank. Presently this money is still
in bank. And My  Doctor told me that I don't have much time to live
because my illness has gotten to a very bad stage, Having known my
condition I  decided to entrust over the deposited fund under your
custody to take care of the less-privileged ones therein your country
or position,
which i believe that you will utilize this money the way I am going to
instruct herein.

However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible..

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.

Regards,
Mrs. Dina Mckenna Howley.
written from Hospital.
