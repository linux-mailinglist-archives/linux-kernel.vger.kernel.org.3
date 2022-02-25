Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37FD4C49BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiBYPzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiBYPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:55:01 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A871ED4F2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:54:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g1so5041289pfv.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=SEcNjOSXP8wGpHSIQOVacqlW5iquJAh9dHc2B4bb5SE=;
        b=JZYazTmrFxOJMIRkwJ+0xl4e3Rf0Gu8S9KSgkkbMOupJ+4lscX4RRoWeklFMuciRuL
         zVXY/uT3le1h7GBBd7qr/u+bhgY8T3nZqphY2oB3sBMF874u5UyJMB9Qsxfn40v/M6aH
         wzDlJD+0RqOYtWqQBcbC6ke/FSI1sZUI+ErgI3lt9Ymll3cxHxoiuD5+gdR339ru27/c
         /3yRxxV15t5VPFqluKLxLC9qBeRFZxxZPF2MZeXCCb2hNQONARwKjpAVy17pcNZGjxiT
         0KJJ7SEY9kJt4Z4jSNjdl300JHv+9llm140QNbtossjvCKBD+1RykQlK7rSQ5Yl3DqqO
         3GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=SEcNjOSXP8wGpHSIQOVacqlW5iquJAh9dHc2B4bb5SE=;
        b=kaPg8FFJp61Fsvg2TvI8HRGwmE1qS+sLpcSIFlxm7tanlRe92ABgz6UWOxmUVQp0iA
         uPhNG5evzja52fNzNdkf/9aOHmbdEY3+84ES8fWmCtoh9oOe3QneVueb4iE1J94b7Tmd
         PTsrQOZLNZnQISpkgllprNpMXa5ZNHjRpgzl7Yi3AX8tv+FU1PG2u3/424SwBhXbxUDw
         TEs1kTJID+drcxBqt6Ye0pCt+Du3v+wuSuMbWJ4KzkcmfmJcvBgI0PIHoTqJFSrOF760
         EjpyF2GAxwHmZK5r5us8DS1gN11hMhAgFFlU3LGI6HaqryE+NHW4Z/DMypTVtgbfGNX4
         EDEA==
X-Gm-Message-State: AOAM532FyHtEgIoicoIqBbY3Bc41I3SRdU8hXbJp568CTBFJ9OtFddcu
        qyESmFd34JCTzVaTed83xMzNP0AnXRYTI03s1SA=
X-Google-Smtp-Source: ABdhPJx4/svmazwgxWdBeiy5KhyZ4o9KC1bJcWd9oBo8DIHA42/E6xIdLx07kxynxMFKjmDsu1hcIJt4NJ7/wn7bEHI=
X-Received: by 2002:a63:7d5d:0:b0:34c:17:6174 with SMTP id m29-20020a637d5d000000b0034c00176174mr2930466pgn.133.1645804459550;
 Fri, 25 Feb 2022 07:54:19 -0800 (PST)
MIME-Version: 1.0
Sender: jamesvic221@gmail.com
Received: by 2002:a05:6a20:2d23:b0:76:74b0:439a with HTTP; Fri, 25 Feb 2022
 07:54:19 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Fri, 25 Feb 2022 07:54:19 -0800
X-Google-Sender-Auth: mqSXNtTy6HmRyD62XpJW4Aa1r_k
Message-ID: <CAHpZNyWgd6S5m-GugMdebGZteaZZo5RKH+ODyD4L_LyAORwc1w@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:434 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jamesvic221[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jamesvic221[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.3 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh
I came across your e-mail contact prior a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future.
I am willing to negotiate investment/business profit sharing ratio
with you base on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgent to enable me provide you more information about the investment
funds.
