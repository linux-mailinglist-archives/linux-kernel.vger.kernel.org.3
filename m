Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551DF5432BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbiFHOhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiFHOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:37:43 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C353E0D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:37:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-30c143c41e5so211213667b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=14MaBjQt+p1II615KfzTZ+RuC4IjHc6GDWgRej5Jut0=;
        b=AgxvaOdcLM9in1DNdXeAJbcUmtfhFRYCejOfB0keepibbmU72t5H8smdekGrZ7yffK
         kNMUwXJQC4mrZyWm061lmWjLMnJA//1Xdn8Kmh3I17T3C8MOIwnCp0HOSdhwy9cB6ZF+
         AM0asvWo2k9JBmibXZDdkUAQbrtVej64EdEDyWEvy65m2h6hNG+MMF/H2PfG1qbRMQ2P
         qJWVLAab7yC3U6l0Cks2Zqf3F4WH3595354z9OzFcNWkO6pFpIIxjur/tZG5wBWUVfah
         nu2aPsOLxSzodHbqqcskNoVktBs52fCYtrCLh9IX/OezgjDFe+m+Kzt9b0MgaRZt4gef
         Qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=14MaBjQt+p1II615KfzTZ+RuC4IjHc6GDWgRej5Jut0=;
        b=ZnCg/ugmNEdMzXi45roVNCsce7bxbVu6DfHOriXo00afl6DNbOLmsPTQPb0vLx4yWq
         UNOwGjSr9TBia26CU76YbOl3CJ8cB1ldz1Ii2nmxWRjKevqAF9xRhptLwuAXKjtPCTkI
         PSCtcxhacEp9zCcHryb2hVnKLxbYIjXgsC1G3139GjoJjrVe55o9uuKTYABSnmyehu/S
         iu/7Y2b8WhOazZlU7jlIsOeQR3DPKrjhCJDXqiqAgVYWD990N8d/DyYHBc8cnhDzOD5u
         vuHbS1qPlt2FEco2sNZnuPtMQcoJ26l68P8I5eo38G1RlELQgJCAtduMiw0D0iN001kU
         sGKg==
X-Gm-Message-State: AOAM532fqjCIJuLn90Ll4vYks67oNltVKHf/EjaRMFRVGIQl81sRhKXF
        NxlZctIgBTIKF4YjZ9XgdF3TNLitM//nFKqYygc=
X-Google-Smtp-Source: ABdhPJy2rTK6+dQ06u64gkELeLV5iTkDEO3qPUxyKZqbcUCyr9lAbu6K89C8Z8SfkoeGCWqWlO2OKN/2bVT9SXSzHa0=
X-Received: by 2002:a81:4a82:0:b0:2ff:94b4:b4d1 with SMTP id
 x124-20020a814a82000000b002ff94b4b4d1mr37537312ywa.130.1654699054936; Wed, 08
 Jun 2022 07:37:34 -0700 (PDT)
MIME-Version: 1.0
Sender: thomson.james002@gmail.com
Received: by 2002:a05:7010:620d:b0:2d1:949:e881 with HTTP; Wed, 8 Jun 2022
 07:37:34 -0700 (PDT)
From:   Jackie Grayson <jackiegrayson08@gmail.com>
Date:   Wed, 8 Jun 2022 02:37:34 -1200
X-Google-Sender-Auth: sp_yChsDNoxYMT3qzrbDSdwzbj8
Message-ID: <CACy7ZiogYq-c6qC+fNjmMMKpueMFbXewJmKHmt72GV4m0xRM0A@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8968]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [thomson.james002[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [thomson.james002[at]gmail.com]
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
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gooday my dearest,

  I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life,I am Mrs,Jackie Grayson,a widow,I am suffering
from a long time brain tumor, It has defiled all forms of medical
treatment, and right now I have about a few months to leave, according
to medical experts.

   The situation has gotten complicated recently with my inability to
hear proper, am communicating with you with the help of the chief
nurse herein the hospital, from all indication my conditions is really
deteriorating and it is quite obvious that, according to my doctors
they have advised me that I may not live too long, Because this
illness has gotten to a very bad stage. I plead that you will not
expose or betray this trust and confidence that I am about to repose
on you for the mutual benefit of the orphans and the less privilege. I
have some funds I inherited from my late husband, the sum of
($11,500,000.00 Dollars).Having known my condition, I decided to
donate this fund to you believing that you will utilize it the way i
am going to instruct herein.

   I need you to assist me and reclaim this money and use it for
Charity works, for orphanages and gives justice and help to the poor,
needy and widows says The Lord." Jeremiah 22:15-16.=E2=80=9C and also build
schools for less privilege that will be named after my late husband if
possible and to promote the word of God and the effort that the house
of God is maintained. I do not want a situation where this money will
be used in an ungodly manner. That's why I'm taking this decision. I'm
not afraid of death, so I know where I'm going. I accept this decision
because I do not have any child who will inherit this money after I
die. Please I want your sincerely and urgent answer to know if you
will be able to execute this project for the glory of God, and I will
give you more information on how the fund will be transferred to your
bank account. May the grace, peace, love and the truth in the Word of
God be with you and all those that you love and care for.
I'm waiting for your immediate reply,
Respectfully.
Mrs,Jackie Grayson,
Writting From the hospital,
May God Bless you,
