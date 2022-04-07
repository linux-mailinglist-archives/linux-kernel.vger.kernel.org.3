Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680124F7BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiDGJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiDGJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:44:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCF174B9D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:42:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k21so8664132lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=educarchile-cl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=6kRbRrXavnUyp99PJxXljVeIz1yfFl1ngoW+Cbvz090=;
        b=xkeXhLo30dxwkWt9766+af8015gAbK9wto8TTgsSCYdRcyREXQZva6zs1RdbhKwvTN
         8jcEhw+vYjkU32gjzfsWerNfe1h1g9lXGTAQuYqFuj8bowKX7IIOEBbEOvCuKvK6fTGm
         nbkaHj9iEeAeCMPgPT1tHCxcoS2A/SFJerhR/MnfIK+FD+3P3zEgvXO+m4tGEers5YGV
         wv9+FfG3sFUnpvPKUYmXexuxEV0BYtgF/5s4hg1HJB4XmxV6a/8NSDIAgkIvgi2q9eTb
         dPlmWperoDaY69yhbVVnAbxedvyvr1oLuXw00luS9ZkbigCoi0RDZiOdSC7ZuUMC7IfC
         k3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=6kRbRrXavnUyp99PJxXljVeIz1yfFl1ngoW+Cbvz090=;
        b=u3Z9S/uf+x/2gBcdp1OF5XbzJtndXmETADSw+N3p29potE+bqBErfH0p2UJE5SJNy3
         EyHxPSffSrbSvt8UuyUW3jBde/yTU+BErGa1obi5rFqihR/KN5qma+IFkc69jsJ0s7aJ
         jTzXDulWBP8hom5Cfsu70qSE11rvHUtoqyLqsezzgQ3NkgBnkD4YYDYZYBHuh/EGyuvk
         s092d4zjkFWcMaQqbiMK4qDO8zKrQ0DL9FPvmYl6sreDrYRJ05tCgG3hEHyK3caHDG5B
         2sMqsJ3YjKOEECX8/Ra41lSxjj4iH5OLy8vdS6up73o6uncOK8h0b3xMgRVJYMd43baD
         +N5Q==
X-Gm-Message-State: AOAM530qNRLJTvyrTU+M2UaGn+JVPcB38kxmQJq5RtuL/cnKfN3BLTnk
        //sQx5793G325USQOfC8uN4DuNYchPbjNlFj5MRGRw==
X-Google-Smtp-Source: ABdhPJwrFKrcJUlAZHTejNEIIGmOPmCfhrWml5GRCksRCTREFWrtATdWzclAIzHUxuZptBdtCFpHGpFJmnuR/D6YirM=
X-Received: by 2002:a05:6512:2292:b0:44a:43b4:4687 with SMTP id
 f18-20020a056512229200b0044a43b44687mr8894098lfu.450.1649324552229; Thu, 07
 Apr 2022 02:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:12cd:b0:1aa:c35a:e838 with HTTP; Thu, 7 Apr 2022
 02:42:30 -0700 (PDT)
Reply-To: yasserbroker1974@gmail.com
From:   Yasser Abdalla <andrespe@educarchile.cl>
Date:   Thu, 7 Apr 2022 09:42:30 +0000
Message-ID: <CAAGgGxdBTTAn=2wG=S+zCBD2fgbGX2mgmmz39KfUhOLpa9knfg@mail.gmail.com>
Subject: Loan Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MILLION_USD,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5060]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [yasserbroker1974[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I am a broker with a linked to high profile investors who are
interested and willing to granting loan as debt to fund any projects
and to all viable and lucrative sectors with up to 15 years repayment
plan with 1 year grace period and also can fund projects from $ 5
Million USD to $ 5 Billion USD.

If you are looking for a personal loan, large investment projects,
commercial real estate, small business enterprises, and government
contracts, etc or If you have a project that needs funding.

Please feel free to contact me

Yasser Abdalla
Bridge Stone Brokerage
