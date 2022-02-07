Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAE4AB6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245297AbiBGIbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiBGIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:23:37 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C796C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:23:34 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id v186so37734931ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=D8wEsUshu+MXbWyBd7OReGZjXbMOkMJppcURGNQbWJVdrq9YtG4pIgx1S+VYMDDYwr
         kd9/VZvyfo6Vp/NBPU0crRvSDg9NkBrYnss35/x14Tr11a9Z0SyT5XyoHWWwMAfxTFKE
         Ab2R4KPF77WxJpcM3Y8Hs77JiCzR1t6vfZQTbNK2Vab9vDDkoFp6FFG2+BRZmw8CZYaZ
         6Ulg7mvwqmTcelVVL6o3OMc/y0lR4i5NbdRd5FOe9M6wnIBFI3ASI09cppYTRiBcJhX1
         ji5xOD8nKPQe2kpbS701EeD+70lgmHhFsqu/7omXMsY2fuvXpK8ZO5xBx+Kh55V5gtXu
         n8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=g04WP4dI80AFw8lfi9YjcC3b74J3YIDfaK3KD8mtXX/qG/gNhYalDsd5ulVq8ktkgh
         n4LYb6xnZ1GPKEnSctf6bN4rkvjd8dJbqYvBHCajx+7E5Iz6cMrN60OLE3llB3MpoPwe
         zODi9PhD5mSKdhR2RABeJTzaWoA7lz9Knx+fCqLpDypuUtDHyLo0m6UoJT5N4iCVvHMi
         S7oWtfiYGuU/w1Oz5vpYkJni5WmfIdumIRDM2SXGDbcSD2ygRXrem2FrUe0LNYYkGpbW
         2M95PeGuMITtqxrCgfgkQ+SCjEVnd3ZInUKOhIunMdDNjjSrzNDckbq7ur3ItuWYXakj
         y8Kw==
X-Gm-Message-State: AOAM531lnI8V9qtZQHAik5KmnW6GNhCmJy1xB6YF3fDRQamTOlaQdPq5
        s1N6Cf8XpayKnIWPeqLgaQa3oL7Dlvn8AlAuGik=
X-Google-Smtp-Source: ABdhPJwlPED2ys9mXsK+RU2NHbh+bWJ2JkjnIr/BzVj44DEbbYVcmo4FwpFnYRLVvsnz05yk1/sWPgkzZm1o/Ab1VR8=
X-Received: by 2002:a0d:f0c7:: with SMTP id z190mr9865471ywe.61.1644222213733;
 Mon, 07 Feb 2022 00:23:33 -0800 (PST)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: isa.ongo@gmail.com
Received: by 2002:a05:7000:64cd:0:0:0:0 with HTTP; Mon, 7 Feb 2022 00:23:33
 -0800 (PST)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 7 Feb 2022 09:23:33 +0100
X-Google-Sender-Auth: 9YfxrKY40o7j93VKR3QmTDU54pM
Message-ID: <CA+_CzdMtpAs1y+0H3O+WrFEnRtD41iAvuybaYdcSbMQX5T9Drg@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_8,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5029]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [isa.ongo[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  1.8 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

Thus i humbly request your assistance to claim this fund. Upon the
transfer of this fund in your account, you will take 45% as your share
from the total fund, 10% will be shared to Charity Organizations in
both country and 45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
