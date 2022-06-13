Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE680549D13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiFMTLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351578AbiFMTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:11 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491CD124
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:08:48 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id w2so10908019ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kLf57Tpjp3cAr7DQ8FxGnPCa1UEL1ZCvBKa8SNzGeS8=;
        b=QdaF12IWJPb8iXESj+p+bq8Ipb9mq90eadTysAvh08qeAsZOpUu3lHRfNjryf4LMJb
         NK2Uioe98EPRsJWTIb0WMi8FHySgC7l0cqa/bAS5YtFebpUoP1Cxy+aiK83z/5R0L8V7
         opIrjNiNFfnWwhQSGawjG/kze4mz/lv2A+mz2l0XwOqQakbWcTlofmZpiWoqufFCo1Xg
         RYNNZ+0V3BPUFUtGrJKzOX2kpFnLRKyvI8DNWS0t9yQ5DwX13nF9v1/vOe23FhvPATix
         7FNMjmTAYy5vFUNtsH4IzH+g9jsnWEjAwD9Aq952NGgWSUEACmqRGPAmdtcWFWydDqJy
         vITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=kLf57Tpjp3cAr7DQ8FxGnPCa1UEL1ZCvBKa8SNzGeS8=;
        b=tg2aIzPJitrRmIkYkHDK60nNKZDdFWCp2FvbOs3qEA3a/BHxSYceUFYQgODjCf4LL/
         qQJdMTgv4gUXZ6b9PLNiGVgGIAt+Q81EwHBcAI31QWIxJo67CLhblnprEc5m5DqNKMvY
         lFKtB+XrXq+tyW5A2BE980R9PWENNQrK1Eg/Lw6YU5doz4aVvVw6CNOOYUUCe/r+jKcq
         Gldh0CSwgWwck0iEl+WRoOADYD1N47rH/dFk6B1EuDEsc2CGwLwhBPjMRNZ3tf8brZnV
         QD1JSxVJajWL7tVifRqrBt3HzhmC0k2OJ/O3ijDv4wPNPNcm8O+JPPjekgNqMulPR4VN
         v6Zg==
X-Gm-Message-State: AJIora8pW2dRI8kmX8JB7m0WJH3rmP7J5Z2/8SHmW7fY3LfO4Osk8Tgq
        fB92jw5/OJzZyr30GC6B4Y63oa5Mj5LygkdWYsE=
X-Google-Smtp-Source: AGRyM1tRsIJ5jaCyhpl8CgxQ4TM9f8FzBH+EY86F5dKMxqzlUrZWDBNLooyRNWz+8TDmv57vBl03Lgely6m6A+Np+Lo=
X-Received: by 2002:a25:d209:0:b0:663:e1c3:8b55 with SMTP id
 j9-20020a25d209000000b00663e1c38b55mr638777ybg.320.1655140127621; Mon, 13 Jun
 2022 10:08:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.christiana.and.sons@gmail.com
Received: by 2002:a05:7010:4349:b0:2d9:dc8d:9edc with HTTP; Mon, 13 Jun 2022
 10:08:47 -0700 (PDT)
From:   Jackie Grayson <jackiegrayson08@gmail.com>
Date:   Mon, 13 Jun 2022 05:08:47 -1200
X-Google-Sender-Auth: 1HYkm7jWGO93ikTXtbHd6LocE5M
Message-ID: <CANV73fAjR0zQFMq+3wETy_ygfNgBcVEa0B1crfTgi=TAegU9Zw@mail.gmail.com>
Subject: Greethings my beloved
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gooday my dear,

  I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life,I am Mrs,Grayson Jackie,a widow,I am suffering
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
Best Regards,
Mrs,Grayson Jackie,
Writting From the hospital,
May God Bless you,
