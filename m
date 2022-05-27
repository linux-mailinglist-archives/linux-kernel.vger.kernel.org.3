Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A704B535FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351785AbiE0Lnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351473AbiE0LmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:42:08 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B213B8D3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:40:24 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f5-20020a4aa685000000b0040e7e819183so762322oom.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DsUpTMVy3AnG06ab2HPPYE6VPm25Tedt2mleq6KKBcw=;
        b=UML1lhyckYSy+PFMFGfVuBidpPGB8wStQQlVuZKq6jBsCQ0qcnjGcUnePpAfsoMq/c
         74P7nwGN/LU8JYydeuv/PRSvDTxyLZ+Ml5oyx3UiLXfRshxhrOViTAGsEae66TfNk+MU
         ra6GSyrkA8aRyruoVu8mqT0LA3ikybaRzmSLjpml9OFRT5yq6cyagrB/dI4baHwWRHB0
         bqWe+0larSW9biRBxc0K5MI9hR1vMzZuNRs7YRM3zayvT7kq5MoZH9JHsZa43ueSMY9z
         Tsfn+SHZgmz/BV8p5+xvw+OKh1MjGx61OFmAQzTfq0eRqTPog4hHxkS+1C/xWpyclekO
         7XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DsUpTMVy3AnG06ab2HPPYE6VPm25Tedt2mleq6KKBcw=;
        b=pg+qXkDabjjA4Lj2A4qPuWz1LVmnY8i3aBTuSbtVbiEq3rlnR5mBT/gtpArnguWs7O
         Uunhqh+ENqR/M8e3k1pgV9bfibI+wNDGYNC6OQOdmmpKmxdehy7zPpcuKXy8pjrRPvgt
         JCon49DXfN0vBEmAq5JCb1Gbw2ey8jekqXmuLZc5Bb8JjLZe97g18WfAUXQhIpAU/MFr
         B2cY4u5MgH+54AEVOhNx8+zJ8pqSfWZ/rm4ANvFvR0uUMBWUlt09gRHK+h3Ji1y1M7Go
         oL1Ik0kr5eYQnb2147lcrK62rxzsHDFr4SY37c5DyfZqSSoiS9Uz1hi5B2ymGeWif8Ci
         Ud7Q==
X-Gm-Message-State: AOAM531MN8CQUvEbvScnM6sVqPQMX4fAP5g73O9JCpv48FgfGrmU+dfm
        LO6T6elIs1JZp/gveRkIYEQOKbexOJp/AvAqDGk=
X-Google-Smtp-Source: ABdhPJymNF1QQ9ebzYsx5GLSeAx+eYmLguulm09jLewWXfRzMChGYpdzcTF4O3Wjz77wQMilzoCghly7eB1li5EJKCw=
X-Received: by 2002:a4a:4b06:0:b0:35e:e790:1f1e with SMTP id
 q6-20020a4a4b06000000b0035ee7901f1emr16760060ooa.3.1653651623362; Fri, 27 May
 2022 04:40:23 -0700 (PDT)
MIME-Version: 1.0
Sender: mrslila88haber@gmail.com
Received: by 2002:a4a:d541:0:0:0:0:0 with HTTP; Fri, 27 May 2022 04:40:22
 -0700 (PDT)
From:   Mrs Lila Haber <mrslilahabe2016@gmail.com>
Date:   Fri, 27 May 2022 11:40:22 +0000
X-Google-Sender-Auth: eG7CN5jIv5U9Li9AO-0n2jjpXN0
Message-ID: <CAODWenY4Sf0Y96tSK5cJE6ye59kjBmzB+P9bKTLjYw1uMa-Sxg@mail.gmail.com>
Subject: Dear Child of God
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c41 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6417]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslilahabe2016[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.3 HK_SCAM No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  1.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Child of God,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS
CHRIST the giver of every good thing. Good day and compliments of the
seasons, i know this letter will definitely come to you as a huge
surprise, but I implore you to take the time to go through it
carefully as the decision you make will go off a long way to determine
my future and continued existence. I am Mrs Lila Haber aging widow of
57 years old suffering from long time illness.I have some funds I
inherited from my late husband, the sum of (7.2Million Dollars) and I
needed a very honest and God fearing who can withdraw this money then
use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR
CHARITY WORKS. I found your email address from the internet after
honest prayers to the LORD to bring me a helper and i decided to
contact you if you may be willing and interested to handle these trust
funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will
inherit this money after I die. I want your urgent reply to me so that
I will give you the deposit receipt which the SECURITY COMPANY issued
to me as next of kin for immediate transfer of the money to your
account in your country, to start the good work of God, I want you to
use the 25/percent of the total amount to help yourself in doing the
project. I am desperately in keen need of assistance and I have
summoned up courage to contact you for this task, you must not fail me
and the millions of the poor people in our todays WORLD. This is no
stolen money and there are no dangers involved,100% RISK FREE with
full legal proof. Please if you would be able to use the funds for the
Charity works kindly let me know immediately.I will appreciate your
utmost confidentiality and trust in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish.

Please kindly respond quickly for further details.

Warmest Regards,
Mrs Lila Haber
