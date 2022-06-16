Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17D054DF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359808AbiFPKnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376287AbiFPKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:42:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C105DBF4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:42:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l4so866695pgh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hgVCAkJ07oFv8/cEINUlyfPO5L+SF88mUJYnJuI7BR8=;
        b=BHE13kkqT0jFrSppZftRy2FrxRMQT/7UtD2wfpMW8LhGuWcdDri8Ws1acXHNnRRiWk
         6z8wyTaDG1AkPudfxPyRZzQxfUXIaKEDfRPHhLmiUT7G1mIHh3nxVuUusm4XHY+6+BfN
         FHw0hG/PAovoJSTmcSkCOXll5wIVMZYqV6p4/hL++E+KCjFtr6GnUrw3q8+Q4NQxT91z
         YDAnAYbR9tL/GJ5gfV2ABdhMwH5+P4+VzPsYbpD0jEs+cpaGGtdCQTZMMg914lcm4EgC
         bUByritkrGuiVIhRfDlg94WbTXftIykVb5zDVIU9kwTOOR8OYibQ9cmb6ixSapAHW2Gu
         rajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=hgVCAkJ07oFv8/cEINUlyfPO5L+SF88mUJYnJuI7BR8=;
        b=X+0Vg2xHeEHPzZIvvvm0Cs4OHhKDihx6EWbhIOplCE580ycCSn6ycUURHP94LXsYwx
         FtZN/xmQHMlXU1qTjtJvReOsxX4Shd4UPWVECWL+8ynya8FFuznM5THekmhNe/ODnPwK
         y09i5qpTEeYtLN8LN8p9pbxV+9dUMs3sRleWOs1PQxNVNCCIo9pL37OvntdmETlplNoR
         s0kGNDkq8AYPeMKt2jOPEBxZIThPjnE3ZrX7rERgRRElHlBTK/YND9I2PsX6cJh91scv
         +Y5bMyeXZYt3Awxj1fIZgSzlj8FxXxjSw0vPy3cd9NKKHqMqdvK0MmRpWQnkxiaxzuFw
         TT5g==
X-Gm-Message-State: AJIora9MZQ19fzIrwVz8DBJrJPB6LZyynJkZX962DZDPeq9MmN9pSJi7
        iUsnC9eVKTrsh9Amts5pLjNMOHbpgV8t2df13NCXJGyYAnOgsQ==
X-Google-Smtp-Source: AGRyM1sXK22rjP6XGW1xegQIq2QrJrBmsmVHkPlmMso7CjoTgAfVd5ea/0iHiJ9ZPVNkF+Mu2WY5h64FTGEA9koTY+8=
X-Received: by 2002:a05:6e02:17c7:b0:2d3:c741:e1eb with SMTP id
 z7-20020a056e0217c700b002d3c741e1ebmr2292362ilu.87.1655370347920; Thu, 16 Jun
 2022 02:05:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f8ca:0:0:0:0:0 with HTTP; Thu, 16 Jun 2022 02:05:47
 -0700 (PDT)
Reply-To: mrskumarprince@gmail.com
From:   Aisha Gaddafi <chigboomorocco@gmail.com>
Date:   Thu, 16 Jun 2022 09:05:47 +0000
Message-ID: <CABFiV5d7d_MCFxT401FERS327W4j7307KFcmPZMrMzm+VJrpig@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5008]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chigboomorocco[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.4 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Dearest One,

This letter may come to you as a surprise, but I want you to
understand that it is only through an opportunity that people can meet
each other and become friends and business partners in life.

I am Mrs.Aisha El Gaddafi, the only daughters of the late embattled
president of Libya (Col.Muammar Gaddafi) I am currently residing in
one of the African Countries, unfortunately as a refugee. At the
meantime, my family is the target of Western nations led by Nato who
lead the death of my father at all costs and Our investments and bank
accounts in several countries are their targets to freeze.

I have no option rather to contact an interested foreign
investor/partner who will be able to take absolute control of part of
the vast cash available in a private account that my late father open
on my behalf here in the country before his sudden death by the
western world.

kindly reply me back immediately for more details on how to execute
the project.Please one more very important thing here, is that you
don=E2=80=99t have to disclose it to any body because of what is going with=
 my
entire family, if the united nation happens to know this account, they
will freeze it as they freeze others so keep this transaction for
yourself only until we finalize it. I want to transfer this money into
your account immediately for onward investment in your country because
I don=E2=80=99t want the united nation to know about this account of which =
you
are aware of my family problems.

About me and the reason why I am now in BURKINA FASO as you can read
more in the linked below Please inter the link to read and know more
about me and the reason why I contacted you.

http://www.telegraph.co.uk/news/worldnews/africaandindianocean/libya/996720=
3/Gaddafis-daughter-thrown-out-of-Algeria-after-she-set-fire-to-presidentia=
l-residence.html

I have the sum of US$ 6.5 Six Million Five Hundred Thousand in  Bank
Of Africa (BOA).

Therefore if you are capable of running an establishment and can
maintain the high level of secrecy required in this project, kindly
reply with the following information for details of the project it it
interest you.

You are advice to contact me immediately for more details if you are
really interested. As soon as i hear from you, i will give you more
details of this transaction.

Best Regard
Mrs.Aisha El Gaddafi
