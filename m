Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8859B176
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiHUDhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 23:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHUDhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:37:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD171A3AE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 20:37:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bh13so6686797pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 20:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=7Cy38S/v14iSpfXg6lDZSkM0E5IwTzepWgNPaT88xr4=;
        b=VZ+2EywCChAz0b+LK+wDm+d7YZhQpYUKC44xZiVQP3hzAXySgncNOpQfBQiZbWCguW
         wzqwRQ7os/YAujuV+OKY+mug0T/BtYdJ6xhV3kEKE8oO3tgi6cW3HRMTPC3bHWxxa5l5
         CuALZ+PQuVJ15I/t2NU0Zc+hW8oLrGYP6LgTCPOcrRQlLGNgli4HhLZeUXVZ7b9DRTpA
         OxZdIvydhyov+NPKud8TTJJyYZo1CKiawAzguMINa/VgaBqoBRoyP8pohp94xW+OwJD1
         vbtnAI6cnLcsxXqntqFpziWm4mgUJMf13exHNM3MIFGs6riV+ZYi+aWxbUmruM6Kt4ol
         MxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7Cy38S/v14iSpfXg6lDZSkM0E5IwTzepWgNPaT88xr4=;
        b=LEdePmn3/LVxpTuYeiftz6e6+Zr3UWvl3Qx4bkQrSJ5MdV2J02qb/fZRVO7Sh1L/dI
         v7u8+8bbQ9S0Syzhr6ttOpCMdD7yJQuW3e0Gwdpdo0ByUxu8uvxYaBJvZnIwKE/Bc2gj
         20VsudTGQl5HxrVH9fj/coHDfDOho1P2RkBZVxHE7R06kboBT2m4B6IKHCw06b/NMHij
         PhhSfKcMUvySMQ6UgfoCRE8d0euwLAeFsgswWWe8z3wMXFE19i6C/oTgLmniieIq28OG
         YOxMjGdb0HaA7oMtWUxbJpoZCKosFIFZv/R6200NJ/9cmwN3DCJCrH2aTwfhavVcleuE
         WLKw==
X-Gm-Message-State: ACgBeo2RGdXnIqJSgZIeJ8STIrNYUpC7p4V5BEYSeVFL/x3lnQ88zZqJ
        LJe7p1uVGMPWA2kVQDIaYLAb1c93QJYVezekQjc=
X-Google-Smtp-Source: AA6agR69LRhiQUL8xm9Nr4LnlQ02o1LiihaU6rNGrLJ5hxbGA9LvgwXReklCJX2IrHhzgouA4hEZCWHUlvONU7/nKw0=
X-Received: by 2002:a63:1c64:0:b0:429:9ceb:57e with SMTP id
 c36-20020a631c64000000b004299ceb057emr11820963pgm.429.1661053036205; Sat, 20
 Aug 2022 20:37:16 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.carolineedward@gmail.com
Received: by 2002:a05:7301:3714:b0:72:aa92:d367 with HTTP; Sat, 20 Aug 2022
 20:37:15 -0700 (PDT)
From:   CAROLINE EDWARD <gencarolineedward360@gmail.com>
Date:   Sun, 21 Aug 2022 03:37:15 +0000
X-Google-Sender-Auth: ShtJvg2h0GYMwsk75LNoLM0CXjo
Message-ID: <CAFGwH=mt66LKt46j9_Ehywmfh4Sj+0jRF39on9A-C1nSun6h+A@mail.gmail.com>
Subject: Good day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FRAUD_5,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:534 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9341]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gencarolineedward360[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

Am Caroline Edward, a staff general in the US Army presently serving
in Syria as a combat instructor, I sincerely apologize for intruding
into your privacy, this might come as a surprise to you, but nothing
is more distressing to me at this time as i find myself forced by
events beyond my control, i have summoned courage to contact you. I am
a 45 years old lady, I am a widow and I have a son who is now 16 years
of age.

Some money in various currencies where discovered in barrels at a farm
house in the middle East during a rescue operation in Iraq War,and it
was agreed by Staff Sergeant Kenneth Buff and myself that some part of
these money be shared between both of us, I was given a total of ($5
Million US Dollars) as my own share , I kept this money in a
consignment for a long while with a security Company which i declared
and deposit as my personal effects and it has been secured and
protected for years now with the diplomatic Delivery Service.

Now, the WAR in Iraq is over, and all possible problems that could
have emanated from the shared money has been totally cleaned up and
all file closed, all what was discovered in the Middle East is no more
discussed, am now ready to retire from active services by the end of
this month, but, i need a trustworthy person that can help me take
possession of this funds and keep it safe while i work on my relief
letters to join you so that we could discuss possible business
partnership together with the money.

But I tell you what! No compensation can make up for the risk we are
taken with our lives.You can confirm the genuineness of the findings
by clicking on this web
site:http://news.bbc.co.uk/2/hi/middle_east/2988455.stm

I=E2=80=99m seeking your kind assistance to move the sum of US$5 Million
Dollars to you as far as I can be assured that the money will be safe
in your care until I  complete my service here in (SYRIA). The most
important thing is; =E2=80=9CCan I Trust you=E2=80=9D?,As an officer on ACT=
IVE DUTY am
not allowed access to money, therefore, i have declared the content of
the consignment as personal effect that i would like to be delivered
to a friend. You will be rewarded with 30% of this funds for your
help, all that is required is your trust between us till the money
gets to you.

Sincerely,
Gen. Caroline Edward.
