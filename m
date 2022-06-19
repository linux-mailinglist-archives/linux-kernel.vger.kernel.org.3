Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924A5508B2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 07:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiFSFAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 01:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSFAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 01:00:08 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E62269
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 22:00:04 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id e4so1016298ybq.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=ksMB9PCymabvNoHvMuQJCll8pMJCdoRsg3uXtHJoFBWx37YDWTi6erEjvT3Uo2ERR8
         mkcrFGJEA53kVDFpSFJmSMu9cgrgIe+j1dBZVn8hwOAL7ahVn/XHpgO8LoCDUTuXTCb+
         v+pt+K11dBit3JDVQKR5J8oBYp2Z8m708AcKDG8BqNDSC4j5Jy9hXMqRKUg6CT24rv57
         sZ09BOPkiYczVFe0K/n9/1f5p4SF43A2MxkHF2UrSia4XfE1klpQpukmpPj1hNfUwd1F
         /bHu7ggvdUZKDgUGKPtQJ/f6lfcYTB8crzL6MKwvkW1UgyNIXqUi80wKKNme4A/fLSKa
         R2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=VahB+YXBrtPP7wKulPhxl2l/5CwOm9BH40F6TS6YIyt1vnoD5uu7jjRrwTwhUmWFrh
         cCCVbriwfpDOOZS730xYF0dBOQqkAh2XK3qnd4vIDytXGIzoKsQqLyDtVbjId+6xSorM
         CBW8DeKDQWYpsAo1T++vTZ3+DFEWRMnSN+W2Qqo37pJX/C1E3LzgK787MrFPg54xrc6p
         jIsXnuAd+sfiaEVTBdwhOmK2cxLOS2HP2bMbFkmsknnScfNu2CVj1wylhD7EbyD/aYkW
         lLUyGhgMpmI7ELVgdJ2UMdWI5VtWPYtYmNYhH8G8GTKTmAIx6XBAqjmKmqVCtk6eqv3p
         pLLw==
X-Gm-Message-State: AJIora+MHdgYfCfvkVm4z5oiKHtdNsuGdypBx3dWFJlQ2o6nfy1J0bwU
        YlhLmW41RI77blSlwjM+KwwCv4atFWeJZ+Q+jAs=
X-Google-Smtp-Source: AGRyM1vO1v2JdvUmfn8anHHJI5Ay3oTPfYueV5YJ+wsUIApymLvekSAKWiFufWEjxxgz3vSH2qo8BFUsE3U/feMFNdI=
X-Received: by 2002:a5b:ccc:0:b0:664:8c0c:f6c5 with SMTP id
 e12-20020a5b0ccc000000b006648c0cf6c5mr18514555ybr.537.1655614803088; Sat, 18
 Jun 2022 22:00:03 -0700 (PDT)
MIME-Version: 1.0
Sender: ailenn.samih8@gmail.com
Received: by 2002:a05:7000:35cc:0:0:0:0 with HTTP; Sat, 18 Jun 2022 22:00:02
 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Sun, 19 Jun 2022 07:00:02 +0200
X-Google-Sender-Auth: X_oHnhlfYRi45SrvHvQ4HMYplhM
Message-ID: <CAKCxh+rN9iesEx=78dXrxDeoY7zr20yTv-CT_vJG9mm5w+vAMQ@mail.gmail.com>
Subject: READ AND REPLY URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9981]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ailenn.samih8[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ailenn.samih8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear God,s Select Good Day,

I apologized, If this mail find's you disturbing, It might not be the
best way to approach you as we have not met before, but due to the
urgency of my present situation i decided  to communicate this way, so
please pardon my manna, I am writing this mail to you with heavy tears
In my eyes and great sorrow in my heart, My Name is Mrs.Juliette
Morgan, and I am contacting you from my country Norway, I want to tell
you this because I don't have any other option than to tell you as I
was touched to open up to you,

I married to Mr.sami Morgan. Who worked with Norway embassy in Burkina
Faso for nine years before he died in the year 2020.We were married
for eleven years without a child He died after a brief illness that
lasted for only five days. Since his death I decided not to remarry,
When my late husband was alive he deposited the sum of =E2=82=AC 8.5 Millio=
n
Euro (Eight million, Five hundred thousand Euros) in a bank in
Ouagadougou the capital city of Burkina Faso in west Africa Presently
this money is still in bank. He made this money available for
exportation of Gold from Burkina Faso mining.

Recently, My Doctor told me that I would not last for the period of
seven months due to cancer problem. The one that disturbs me most is
my stroke sickness.Having known my condition I decided to hand you
over this money to take care of the less-privileged people, you will
utilize this money the way I am going to instruct herein.

I want you to take 30 Percent of the total money for your personal use
While 70% of the money will go to charity, people in the street and
helping the orphanage. I grew up as an Orphan and I don't have any
body as my family member, just to endeavour that the house of God is
maintained. Am doing this so that God will forgive my sins and accept
my soul because these sicknesses have suffered me so much.

As soon as I receive your reply I shall give you the contact of the
bank in Burkina Faso and I will also instruct the Bank Manager to
issue you an authority letter that will prove you the present
beneficiary of the money in the bank that is if you assure me that you
will act accordingly as I Stated herein.

Always reply to my alternative for security purposes

Hoping to receive your reply:
From Mrs.Juliette Morgan,
