Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5F549A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiFMRtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiFMRtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:49:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646971DBE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:35:28 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y79so6081863iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hgVCAkJ07oFv8/cEINUlyfPO5L+SF88mUJYnJuI7BR8=;
        b=bkXCxeueNKXIrkkLIRNvb4tKlMBkZhgHFbn5IbbRfuxZFz2nJ2TYpMDB8F5dqlpw6x
         K5ccGTNANZdRErsnKsU381r6D7dvlB3/ZCHSDa5er+8tIBj6MuQQ72HMLEeh4lILmWQE
         15jN22N0hH54oDLhUiPrS6uHvl5IUiytzM7ynUTdubeLfLc0GpKc6eRKte4tYAPiu5PS
         PNJQKuVY7IVhJLjFg3gkz/aqlQ25HJvJ86Ozqochr9QAfOAKUzWv0V9CIqyQWgRn18Hk
         Dtme9gsmSFNT5HaoXNDyr36ORtg+5Bt6Wfs2mleGuwkwD4r51VMNju6+SYhF/Taxln+y
         WGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=hgVCAkJ07oFv8/cEINUlyfPO5L+SF88mUJYnJuI7BR8=;
        b=Q2aUdciziUSwyI68Jpn8wMASu4SqXwCUc+HU9eFMLJ5/LKFHHguU4KMtAOtGBbDkhw
         M8GB5+r2+YNgwKn3QM+PQwCHbVuPzE/T3q/7ltr9kX7DEl3/w+WmOMrsH8filuiXEYfP
         Z97HIIQHtGi+KZpdMncJNgTdKqZ4UQMgtmVY7zzeOu7OqQc8xkTxCXma00/W+24j6XNA
         r9kHwKoL4pF7YhFENfmbyA4rQtwUywEHzhJj+cpi8gchHKn7RTQji6FiaJ9VJbEl8exJ
         4kOpibzRHs1H3Sq4ZWDuc/N46apqd0pPyIk7/QDSp5a8kJ+oBPA7eobgpqOpSVYSbD/G
         to8A==
X-Gm-Message-State: AOAM531/vQMCgFJzMJpd0b6Fo50qjQ8vviGzgy9kvicZlu9HSJ3PVqNa
        jm+bRubxvbuMOChNIYq8zH61EyOZeuabisZtGQE=
X-Google-Smtp-Source: ABdhPJweCqNTwcHDewhNJNp0HD8YmHOApxs4+VMlQYYRZktcBzHkaA7zEIYobZefwwXRN7WUZJesHh7S4eXzQLYcyMk=
X-Received: by 2002:a05:6638:3b8:b0:331:6e8b:990c with SMTP id
 z24-20020a05663803b800b003316e8b990cmr30243832jap.308.1655127327120; Mon, 13
 Jun 2022 06:35:27 -0700 (PDT)
MIME-Version: 1.0
Sender: agaddafi917@gmail.com
Received: by 2002:a5d:83d5:0:0:0:0:0 with HTTP; Mon, 13 Jun 2022 06:35:26
 -0700 (PDT)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Mon, 13 Jun 2022 13:35:26 +0000
X-Google-Sender-Auth: BUprGNC0avOxSecjtLEhN4FB9Q0
Message-ID: <CADBFX31U72f4X-vC1fck3i1CaUfn77yc+Nm0mz+85Zfn-adP-A@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_99,
        BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,MILLION_HUNDRED,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d36 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [agaddafi917[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yunnanmrsyuging[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.4 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
