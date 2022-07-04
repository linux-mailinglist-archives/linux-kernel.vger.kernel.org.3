Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A117A565F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiGDVwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiGDVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:52:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28817BC2F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:52:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y8so7343617eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=EuOxHexXG2dgpCIsfZtMoZ2Hz1a9C7LetSF+IPd77+0=;
        b=ITM1y05FWNTerEiM7vg0S0uMN91SFRUjGKK+yboCMKP/w29t7F6q8WWgp5NAtY792H
         IN6NT2LG1BPG9uvyAj0xN+bcqeSP+fuH693UgU2/XDkmnc5zzcEcKdfqPDVBOofeBx6q
         sQo0seeQvAYr9fGeAae3EwLvFSxZD9Y0gMb4ZZeiPxN6IHLrpiNMvRCYyHYQA4cjvsy2
         pGiPzC2gRevsRx0ZH7AIWzOz08vyNmEmAovWpYi7/+/Whvq3DrdaAFKrjX6uL4VYCNxr
         A/ArSlEyka0xa7sIJvWO96XQNehSKgT1IO9YWDQlI6bcU9shW3QU77ZBMtroG2wFzTvw
         C8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=EuOxHexXG2dgpCIsfZtMoZ2Hz1a9C7LetSF+IPd77+0=;
        b=Vja6SxUvgeJdfrckX+sTypwCI7B0LJYOfXJa/ujhnKj7iXNfvepyAXBZPr9PZx58jS
         FaJ9F1x43q/MIkNtY/5wYbpesbJ2HZQ9PMp08FX/IrZ/lj9yO7htRIEomtQuEWNIqG5w
         wkSHE9dWTfHe4PbZ5dRjqaWgEI0W2SexI6kueKNxLHTWYzgUSD4OWRhgper9iF1rMnah
         XJUPaAguhIZNmTKCwkZU0C6tfmyMgBNri2+xTzPSpbxvD+/Xjl9afKlAu7hNaSTIHZ83
         zsFYwLZWnHE4ma8ecg83iIFPgOji+/o6GY38tXiJEfgyvv7NuqTh17ArsreAbpzyU0MJ
         p49g==
X-Gm-Message-State: AJIora/XqUVAk8QWy30JGwVJDBFbL3x76JTf9fPI3rQ/22uEjttftqn6
        zS++y2rbzarMJzyFl1zwM2k/jAJRKVSur2S2Xcw=
X-Google-Smtp-Source: AGRyM1vkqn1jO8t2ihX6q+SU4BBnjt4ihYv+C5YQ7er1rurk6PQRjdAy2rLxozQXNHjEaEz34xnjHv87D3L7vDIv9e4=
X-Received: by 2002:a05:6402:34c8:b0:437:74d5:f8df with SMTP id
 w8-20020a05640234c800b0043774d5f8dfmr41359720edc.274.1656971525599; Mon, 04
 Jul 2022 14:52:05 -0700 (PDT)
MIME-Version: 1.0
Sender: reymonddennis@gmail.com
Received: by 2002:a17:907:c03:b0:718:82e3:2298 with HTTP; Mon, 4 Jul 2022
 14:52:04 -0700 (PDT)
From:   Mrs Carlsen Monika <carlsen.monika@gmail.com>
Date:   Mon, 4 Jul 2022 22:52:04 +0100
X-Google-Sender-Auth: bO5tTGF7bGOA7cYcPZNKgxb2U60
Message-ID: <CAOOE2sEJ8kOXUFJ61SnQTCncBMXau_WMJQsTH6+06rLfedP3hA@mail.gmail.com>
Subject: Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5009]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [carlsen.monika[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest One,

    CHARITY DONATION Please read carefully, I know it is true that
this letter may come to you as a surprise. I came across your e-mail
contact through a private search while in need of your assistance. I'm
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through Internet because it still remains the
fastest medium of communication. I sent this mail praying it will
found you in a good condition of health, since I myself are in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day.

I'm Mrs.Monika John Carlsen, wife of late Mr John Carlsen, a widow
suffering from long time illness. I have some funds I inherited from
my late husband, the sum of ($11.000.000,eleven million dollars) my
Doctor told me recently that I have serious sickness which is cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way I'm going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained.

I do not want a situation where this money will be used in an ungodly
manners. That is why I'm taking this decision. I'm not afraid of death
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincerely and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I'm waiting for your
reply,

Best Regards
Mrs.Monika John Carlsen,
