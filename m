Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C855FDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiF2K5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiF2K5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:57:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD223B01A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:57:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l2so14156056pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KgfgG3PfRIgE5HTrPFX0mX8z0Duoae13hcb6dz1y3jo=;
        b=bqAzKNlwcwGXLMCWV9yPg4atbapezZLTr+wtexhZGmMayzArJ4W3G4XCffvc78LONZ
         EBPueFqzqAgoJZVfUiTZfZ51W2fQSDrierSe/StR81UUo1TIn4bcFsrcvdSUTz8IKwjH
         4c36WxrmaKf+jGmSpMQ8lm6vseDr5+cvO67r+bV8nXYkmAwNzFNofsxCJ9VXXSn8jeyn
         0Uf7KDlHkwBwGtW1t1AvZGj9f818RcmiWWUtN07xP5D8ZukwHS0FNWsqUIuv8D91YDnw
         r0gJvLeeL+b8AVUnsJcL3O1VvfhSsmPbFbYQT2yJiOjgd8IGWa+fa7xngH/OhAPqax7/
         kNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KgfgG3PfRIgE5HTrPFX0mX8z0Duoae13hcb6dz1y3jo=;
        b=HWj4XWtEcoRqiL0iY7VvMR+Pt6umjaMOkm+DVKZueBsr42+FnxlUfD0yaEQDJJceKl
         rW4TaFWvs8ZBTsn7LF04OcTNgePnC8WK7MJOmgjUGO+hrA3SVxAKFfO720ozrmA+G5QS
         vYJPQfZhUy/fUvS9KEOzR1ffl8JtOqqUsbzqY/yYDj84VEQ3zC0E0ZMg+PjtN5Mhz83S
         9d1Sy302WjCndZ2mhBhTLccV8fmehxnSokvHl4n/1jQscnI4PTVM5a1u2g9iFRxFJxFG
         YyPwHADqTkc1zaz/fxVW1cqK+hHciP5gPORHDo2+08Dtrn29YM+bX8nUtmAYIO5HRwnR
         1Jew==
X-Gm-Message-State: AJIora8v9IyywXcRzviBkdr6FRUNi0v14uuk9klPdZQ9NL9Up52FQ9GR
        h0Z/wOwbk6kPrOYomFhWfSsmNAehrdvng5KZoxQ=
X-Google-Smtp-Source: AGRyM1tDSO6qmh9uYxWXwlKWdwo6tcu0/+wv1TLJnbGR9etzEDPvyAlLuR2Z+kkp5HdOFGLlt0fdfvhtf4C0w+tssGE=
X-Received: by 2002:a17:90a:780c:b0:1ec:d94b:2f93 with SMTP id
 w12-20020a17090a780c00b001ecd94b2f93mr3192228pjk.233.1656500262409; Wed, 29
 Jun 2022 03:57:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:2210:b0:41:ede4:4cbe with HTTP; Wed, 29 Jun 2022
 03:57:41 -0700 (PDT)
From:   Mr Cheng Dasha Lee <mrs.aishagadhafi@gmail.com>
Date:   Wed, 29 Jun 2022 12:57:41 +0200
Message-ID: <CA+rtw+OKfYRxtde3N86PSGQ99kO4J4za0BxngV7CFZZjiM5CsA@mail.gmail.com>
Subject: GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.aishagadhafi[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 HK_SCAM No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Assalam alaikum,
I have a proposal for you, however is not mandatory nor will I in any
manner compel you to honor against your will. I am Mr Cheng Dasha Lee,I am in
partnership with former executive director of Arab Tunisian Bank here
in Tunisia;

I retired A year and 7 months ago after putting in 28 years of
meticulous service. During myhip days with Arab Tunisian Bank, I was the
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
From:Mr Cheng Dasha Lee.
