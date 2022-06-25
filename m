Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0555AD9A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiFYXlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiFYXll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:41:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD1F5BD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:41:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n1so7906677wrg.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oeG9/MntnZxSW3F+UM6mF8G+txKDXFuaJCmjLujAElc=;
        b=HaRf6j/uNXx/YH7QCUTXbYfh3VY6fgsQ2PAnux8JobTpuDQp6Z4OvKpkdV6x+x5SfL
         9FGy0B0q/hGis4jguc1W3oR65teZL7ZIly9WWe90pt6IdcvaYekqJiALPl7HxH+IX/3/
         vl30EG6OwM6BSH3k4y7Wh4g8TwM/J4k6XEe9wvPX4Tag63W5918deErqQ3Nk7Cg/TZpg
         cOEVlBusPkhMzBItrQZuoD7zGWyg0IQaTG18ijMCtk/QWVoyN4vt6dCFZOG7RpCE0hbs
         YUDF9dETOaGK4LHMtbE89DB/bOGM4SPxpwSLxr4SQOg+zVynUCGajMml2C44jMjUye1C
         9IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oeG9/MntnZxSW3F+UM6mF8G+txKDXFuaJCmjLujAElc=;
        b=HK/z9FqeJZ4v1WZJw9c6U4lkppeM8DoESzpOczy7h4Gpxf+yblxn7GfUy7+ekcdoKk
         wDbNcb1WDeggXy7Aw8PHkT0L7qMgxiE1HT0JmgrBwncDNc5/E1sjL3NZuLz8vqYelu9A
         J+Nv9hM5czYT8vTXeSvzttjgGRsS9LvU6hiLEiiA8CFaT33kE2+PXMMHWS3h4oT9uGWR
         QGKCM4Ke/zxpYpiNjIuVtLcJAplGi7kcCcKvLWUgxBpc7wdN3birMTWdJsyIA07Dn9kU
         TpSVOKlaIwXMEV1UcVDNeIByl8lOEz0YiWDwgDhCjbFRzJgWEqTgrq7LHEZpmg1FyiN2
         /urw==
X-Gm-Message-State: AJIora9UO6mJo2di0hAD/ISgb9KZlGUn4r6HF4PkmbK/g129yGMP9MZG
        cpdghQALr2Zq1FSETbtzWps+kxAJ2WcrPsYaffc=
X-Google-Smtp-Source: AGRyM1u+85lhVdNYy56saUgp3RbXP8mvBjbDQG24foRRxL0M72w8TyhCrNvSdD0UEJDKhxkUUamcYlRuRlI9mZA0rDE=
X-Received: by 2002:a05:6000:71e:b0:21b:adf2:c9ab with SMTP id
 bs30-20020a056000071e00b0021badf2c9abmr5700404wrb.153.1656200499169; Sat, 25
 Jun 2022 16:41:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:540f:0:0:0:0:0 with HTTP; Sat, 25 Jun 2022 16:41:38
 -0700 (PDT)
From:   Mr Cheng Lee <leedasha710@gmail.com>
Date:   Sun, 26 Jun 2022 01:41:38 +0200
Message-ID: <CACy=aTMSJKBsP0-W0u7om-QSybZn8d+zMYym3ZC43A6-ZdzMjQ@mail.gmail.com>
Subject: GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:436 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [leedasha710[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [leedasha710[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Assalam alaikum,
I have a proposal for you, however is not mandatory nor will I in any
manner compel you to honor against your will. I am Mr Cheng Lee,
partnership with former executive director of Arab Tunisian Bank here
in Tunisia;
I retired A year and 7 months ago after putting in 28 years of
meticulous service. During my days with Arab Tunisian Bank, I was the
personal account officer and one of the financial advisers to Mr. Zine
Al-Abidine Ben Ali the past Tunisian President in self exile at Saudi
Arabia. During his tryer period he instructed me to move all his
investment in my care which consists of US$115M and 767KG of gold out
of the Gulf States for safe keeping; and that I successfully did by
moving US$50M to Madrid Spain, US$50M to Dubai United Arab Emirate,
US$15M to Burkina Faso and the 767KG of gold to Accra Ghana in West
Africa as an anonymous deposits, so that the funds will in no way to
be traced to him. He has instructed me to find an investor who would
stand as the beneficiary of the fund and the gold; and claim it for
further investment.

Consequent upon the above, my proposal is that I would like you as a
foreigner to stand in as the beneficiary of this fund and the gold
which I have successfully moved outside the country and provide an
account overseas where this said fund will be transferred into. It is
a careful network and my voluntary retirement from the Arab Tunisian
Bank is to ensure a hitch-free operation as all modalities for you to
stand as beneficiary and owner of the deposits has been perfected by
me. Mr. Zine al-Abidine Ben Ali will offer you 20% of the total
investment if you can be the investor and claim this deposits in Spain
and Burkina Faso as the beneficiary.


Now my questions are:-

1. Can you handle this transaction?
2. Can I give you this trust?

Consider this and get back to me as soon as possible so that I can
give you more details regarding this transaction. Finally, it is my
humble request that the information as contained herein be accorded
the necessary attention, urgency as well as the secrecy it deserves
I expect your urgent response if you can handle this project.

Respectfully yours,
From:Mr Cheng Lee.
