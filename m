Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7705ACE0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiIEIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiIEIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:44:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E73B7D1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:44:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p16so15581370ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=gDjJ6f+EqOf3+s2xOZvgyo5hR1EOdTkNuodhzD/aDDE=;
        b=ALynRSxs17rUOxxy/98HwBGraucE1GRpKsdFs/jUX0k6KTFGW1cJ4Qs0/QDEgjT2of
         9hc+Wioj4LfodirRzuaTHOD65bEe4BcTDKk9Zttpg0u6gKgVEfVn5/+PwxRT8cnoYky2
         Ld5MafrfdXxBV2RqLMuXVRggRt1b1aF3twF6jnIaUANqCOzwfchOkZ2epqaW1NjBPxsF
         xdoSnDzpUIxv3va8F68sZARicFhbu76cjGiQmFvFrS7L+xOr8SaGUul5wcId0n95x4Ib
         Mr4J15hopTA+bof7r40CcHMe11gsVaAh1yByujeztafRQiV2YA6CCdNhibCBXpQBzaZ7
         DH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gDjJ6f+EqOf3+s2xOZvgyo5hR1EOdTkNuodhzD/aDDE=;
        b=yMQ/PuqOWYcqYLCBqcNjOpVlyGXR5RLaltmnkibr3vYSxlZOD3DIBeB+2urMFYQBQY
         C8nICz4GKySPfKKpkqpyyHuCSgSkbAL+q7gOsCkaSRR8w1nrszzMtiPJI41nyfVmxX/G
         +jxgq2aAP4ZefqajDXYcHHxIrjviWcm4SK3r6bsFMsd4Eeys+F4Uy+BbuVjLFM03Ji8D
         XfBgA1W326Gkvt8II8NuWXMF5jw0pMDDeCbs5l9AFpMHkPNP6fKvV/0bzuTqX37zs1Px
         jCKUWmiUEe7TS60IoiWBh40gldEWj/haLnqIqbi7Ck/U3XLaGguCpUrQexlz3n5fkvr+
         HiMA==
X-Gm-Message-State: ACgBeo3mMfDJq6dcrVMdM0LovPfxv3Li34YnH/gMtkHIJru211b6/6l+
        I0NZ4uUbZt1loaB7LnZe/xtVyptqXe9KTiEQ4WQ=
X-Google-Smtp-Source: AA6agR4LWekODkdtjFEuTideKy49q6U05sk6xHXma2sY/hvY9yoXk1B17C/bvtgtSYIhb4aFhWGOllBWwXqjBKDR8zQ=
X-Received: by 2002:a17:906:794c:b0:73d:b881:e3fe with SMTP id
 l12-20020a170906794c00b0073db881e3femr32876779ejo.570.1662367491762; Mon, 05
 Sep 2022 01:44:51 -0700 (PDT)
MIME-Version: 1.0
Sender: poygapatrice@gmail.com
Received: by 2002:a54:3603:0:0:0:0:0 with HTTP; Mon, 5 Sep 2022 01:44:50 -0700 (PDT)
From:   marilyn carlsen <marilyncarlsen008@gmail.com>
Date:   Mon, 5 Sep 2022 10:44:50 +0200
X-Google-Sender-Auth: qJ-4CHDZQXJALLzXMAMZFwuW3f0
Message-ID: <CAALAwvw7xBODYHouBGLGPtuM6z9B+ZrfN6MX3r=OoEVU3e3n-A@mail.gmail.com>
Subject: My Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [marilyncarlsen008[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dearest One,

CHARITY DONATION Please read carefully, I know it is true that this
letter may come to you as a surprise. I came across your e-mail
contact through a private search while in need of your assistance. I
am writing this mail to you with heavy sorrow in my heart, I have
chose to reach out to you through Internet because it still remains
the fastest medium of communication.

My Name is Mrs. marilyn   John  Carlsen I am native Denmark, wife of
late Mr John Carlsen currently hospitalized in a private hospital here
in Ouagadougou Burkina Faso as a result of lungs cancer I am 62 years
old and I was diagnosed of lungs cancer for about 4 years ago,
immediately after the death of my husband, who has left me everything
he worked for. I'm with my laptop in a hospital here in where I have
been undergoing treatment for cancer of the lungs. I have some funds
inherited from my late husband, the sum of Eleven Million  United
States Dollars Only (USD $11.000.000).Now it's clear that I=E2=80=99m
approaching the last-days of my life and I don't think I need this
money anymore. My doctor made me to understand that I would not last
for the period of one year due to Lungs cancer problem.

This money is still with the Bank and the management wrote me as the
true owner to come forward to receive the money or rather issue a
letter of authorization to somebody to receive it on my behalf since I
can't come over because of my illness. Failure to act the bank may get
fund confiscated for keeping it so long.

I decided to contact you if you maybe willing and interested to help
me withdraw this money from the Bank then use the funds for Charity
works in helping the less privileged and also to fight against
Covid-19 Pandemic in the society. I want you to handle these trust
funds in good faith before anything happens to me. This is not a
stolen money and there are no dangers involved is 100% risk free with
full legal proof.

I want you to take 45% of the total money for your personal used while
55% of the money will go to charity work. I will appreciate your
utmost trust and confidentiality in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish. I
am very sorry if you received this letter in your spam, is due to
recent connection error here in the country.

As soon as I receive your reply I shall give you the contact of the
Bank. I will also issue you a letter of authorization which will prove
that you are the new beneficiary of my funds and the documents
concerning the deposit. Please assure me that you will act accordingly
as I stated herein. Hope to hear from you soonest. I am waiting for
your response urgently.

Yours Beloved Sister.
Mrs. marilyn  John Carlsen.
