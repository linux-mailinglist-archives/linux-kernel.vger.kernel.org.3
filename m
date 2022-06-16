Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8E54E034
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376915AbiFPLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiFPLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:45:27 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF058390
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 04:45:26 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id x187so1022702vsb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hgVCAkJ07oFv8/cEINUlyfPO5L+SF88mUJYnJuI7BR8=;
        b=FokELiC4cRXxkqTCsMQ617t2jB+dVo2x09dWGVUt9P74Vz4qVC1UR8ST8uAd/6MyOK
         4OXgEVG3uEZ93N9dULnQVm9s8ibWONY5yglUo6t1pgr+yiQFpm1UPVOk/MoVqgFdFVrv
         mKwtwP0blTlmJ6H1NhK1/HwYkfUSlc2a7FIOe998BOkeD1IYaFzek38m9HOxi7GAbRcI
         Xq33nr5xJhIK+p0cweHB/X9LKtuTOYhqd/wfa5j3N3/+ohNtbcD8NwB08lvISEfY4+VM
         axegtxiP3KUBmibfvpkLmX8EvH3LHIKw3D+gOuv04ziYCUotLmpLZ6RFjsqysrDogqrG
         IRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=hgVCAkJ07oFv8/cEINUlyfPO5L+SF88mUJYnJuI7BR8=;
        b=wE4Hz5z6jcIRWCiqbjZGvuzlRU3vh4BsWe5Tu9xbdHALetjCP1M0RmSTUYDY4YK6CZ
         Ihn+bY7LjxhnC7ee4pxFxYoRgF4odmysTIgeBvM1479zOo8vC4hsv6alGmHTfAFwgLiP
         uSmLMtORFQC8/vPHi8o0rZPNgGCZmohMo0Ig/b54T9wO+0qKFG6FiBR+/9DL4XE+Xgwf
         DQ53lYFWYtBHE5oFASetbou+PqMo08NPfLgCyhp6ksL8BAVEbJxGaqMQngJREQQjr++o
         Wi/QGL9gqaLYbVbPJdLpgJ4mQKKYZl/fUac4WH3+3zPGN2wtOZiTAeUBpsgDs6MIDAAV
         oj+g==
X-Gm-Message-State: AJIora/qcFfidBNxf3RXkTTB2TD0R9T56qOalCZBpXHuXkDnwUjoBjpu
        ZhAAneL841STkiZWNZu30Nt0aw9zomvPRsXlv9A=
X-Google-Smtp-Source: AGRyM1tr57/awTVZlQNlO4K54iXe8iAmQV5H05YSQFXv7JQIWYDFXD2f2WMsn0YUTsCcEKtG6KhzbbFQYODGWLymYJ0=
X-Received: by 2002:a67:f302:0:b0:34b:c205:b950 with SMTP id
 p2-20020a67f302000000b0034bc205b950mr1801500vsf.9.1655379925746; Thu, 16 Jun
 2022 04:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:1490:0:0:0:0:0 with HTTP; Thu, 16 Jun 2022 04:45:25
 -0700 (PDT)
Reply-To: mramadoukarim221@gmail.com
From:   Aisha Gaddafi <willsdaniel94@gmail.com>
Date:   Thu, 16 Jun 2022 11:45:25 +0000
Message-ID: <CAKqXpkoVZqBD=PxaG5y+K-zpdO6RoDBYgttCECnQc92aWfGOqw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5613]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [willsdaniel94[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [willsdaniel94[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mramadoukarim221[at]gmail.com]
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
X-Spam-Level: *******
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
