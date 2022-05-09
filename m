Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D3D51FAB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiEILCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiEILCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:02:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09460134819
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:58:56 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e10so13455371vsr.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=LXo08+TD/q5mkRf5vNGKogVnr637jR9Ua+By1H5XbnhHsCL92j1rao8jehJYBFhsIq
         ma617lT5Ig6BmNHLLwYw8RQydzbj0NC1wzhyk5NFUH2eTaMXm6IxKxGGGNjfQEtO8mTI
         8WQvj54k0T5Q7oUste8wkfr5W2leiyra4UGHbDog/yAG/56lAQPEitjRLyvg6XOIvEp8
         Ev5eUYfuZbC9Y/UGSugMurwCfRW0fOqPzs/H+AGyKNJaFHuDh/LN5bijZ15AN+S0Vxni
         gVUURhww3Xwx/Ocy1GjwM/9znn0RJQS6UXQMTBRooPLPQcz7AWwvmlaDtxxQPuRiDjvb
         Qt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=LueQrtt2NmsBgt4N/d9IGvhQ0No67t3iikWrUkudqMbt9gA+B5s7NoHCxFXWrHpFgX
         +7P0PcdZFQ1ENqM0rGlzVjl6CLrYibMeLir9UyZMpPvmuRdRF/a8cpQ3Z2grDvFgieAu
         irc3+u4xJ0WOKJd+WjlVG3TNzKtrC/S4WGiG/2h9CvQjhhJ/ZCZyiH7vd5GJL6tEXKlo
         OEb+Q4rUi71De3fBIPQJm2KzM8RzNcER4durabxIwIP6j5qU5V1Vf+fcbCBqf4W3Tb4q
         dXWdf4GPIXuvpes/AWnV4lYAWhlek2in1Lpb1EbgLX7Odx0a9OQPmR/I2fZOLhlV1BZT
         4jDg==
X-Gm-Message-State: AOAM532HqK6JTborYvsTyziURxSuyFkjQKyV+xG917/5+B9zEMxa4l2W
        L05LBU7Pt8eBKJGF06RIHMIyGtdKdDhgQJqIr4c=
X-Google-Smtp-Source: ABdhPJwspcVY7XHTgRdnqVzQjggSh3CsWAN2HqaVIQgBKhRO6/yNq5TYQqJXrsZGebnZChtaKaEuhIioR/zKWK42Euk=
X-Received: by 2002:a05:6102:2052:b0:32d:162c:2663 with SMTP id
 q18-20020a056102205200b0032d162c2663mr7065002vsr.52.1652093934822; Mon, 09
 May 2022 03:58:54 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsnicolemarois8@gmail.com
Received: by 2002:a59:ad29:0:b0:2ba:1a7c:5596 with HTTP; Mon, 9 May 2022
 03:58:54 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Mon, 9 May 2022 10:58:54 +0000
X-Google-Sender-Auth: EEg5yUDYeTd_qjJ2CHj7CnEY8c4
Message-ID: <CAAadsjtbdKwFcb91LAnyjWc=9rCYDfadaBQkYQyVrgfB-Y-0uw@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsnicolemarois8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsnicolemarois8[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.2 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow. My reason of communicating you is
that i have $9.2million USD which was deposited in BNP Paribas Bank
here in France by my late husband which am the next of kin to and I
want you to stand as the replacement beneficiary beneficiary.

Can you handle the process?

Mrs Yu. Ging Yunnan.
