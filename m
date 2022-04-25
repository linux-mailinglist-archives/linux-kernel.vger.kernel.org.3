Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF350DB48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiDYIiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiDYIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:37:41 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7760DBC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:34:37 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id o132so6859418vko.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ne4nCROhkxKJrdE9pC7plEH8pzfN/89r3lcrx3Uzkp8=;
        b=AV3Qj5IHOmhCVgjFPFMFkQDdGG/zKzm7S6x7ulvXqEmk4j0ahICfOVqD9fjtroIAY7
         sIjWuJYVOvNtfh60hE7aNm5rKGuLffrB37oLjQmN8R7TFwjF1htHyWG03RYggigQs4Tz
         eJc6EB80LUcnSaF2ysk6XqC9n2Gy1Hg8+lQDiFyZYqPSLY0w3MazaTk+CRPYejuKzA6C
         i1+r+bN0v/rSZBbwAXPtBuLNKa9L6N0PX8ec6/YLuMfojlwbQYRtkltWytcjGpMgEb3R
         E0ZFgAaPCuvhT6XQmZX01KhHypu/n30bEn5OcFl4cTmqUqaPmn6qcvTSg1H6oPBMjDKq
         FIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ne4nCROhkxKJrdE9pC7plEH8pzfN/89r3lcrx3Uzkp8=;
        b=GynvPmoxUrY8XpAGa+oh1Cq/b2mNLRubudXVsMost9vH8tFCTrRaAaRBi8fz5FXwoH
         +kr/YuzNp1rQvNSZLmsx/UP860IuY6i51iLyIKRnukIYcTxp+GGtM3hGhz7xchCslA68
         +V6W0snVbtsxUj5Ux1UV7qMPkUVvjR2SXUh+bQYE5TmX8AYECvErtKFQOrIRVZGQEOZl
         ZiBP5tQ2yolD6GbIbsGH0xBFl7cYUKOi3gxL5qRHyMz0cReN+EN+gOHWGL1vtBJc9SzV
         L3uW99fGl4U9vmV7F1lbHidbZgS+YrzF71Oj3rZCZqEDi/HZ6f4/RtdznzyQ9xsh/wVf
         Z0sA==
X-Gm-Message-State: AOAM530P0MrWbcFTquML7jxEGoHZhcZecsHtZbDjdGpr9xo0Wu3ued9u
        G39a87w4QoB3qu6fU5RU8dJ+FiZ+s/QHO5JvO2w=
X-Google-Smtp-Source: ABdhPJwDh1UBBB0RxSKEkxVjBAPx02sAWfmJpEAatst/xTukjcdupPGRxF/rMm2MEuY1b+RYkro/MegBfhad81F67Yo=
X-Received: by 2002:ac5:c546:0:b0:34d:5744:245c with SMTP id
 d6-20020ac5c546000000b0034d5744245cmr1429650vkl.12.1650875676507; Mon, 25 Apr
 2022 01:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:270a:b0:29e:f7e3:2452 with HTTP; Mon, 25 Apr 2022
 01:34:36 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <anantonioma@gmail.com>
Date:   Mon, 25 Apr 2022 16:34:36 +0800
Message-ID: <CAHx=juQehb8SSkzc=FamFvGWbWgmewa-tp3HidfiOtRfaEVedg@mail.gmail.com>
Subject: Greetings from Netherlands
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anantonioma[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands
Call:+3197005033311
25/4/2022

Atten:

RGI Genealogical Investigators specializes in probate research to locate
missing funds, inherited funds around the world. We can also help you find
wills, obtain copies of certificates.

Recently a woman from the Rothschild family, one of the famous families in
Europe contacted our company that we should contact a business minded
person who is capable of investing her funds in a lucrative business.

Our service fee is 2% of the funds and we will be paid after you receive
the funds. The funds transfer process should take just a matter of days as
we have the mechanism and expertise to get this done quickly. Please if you
find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr. J.T Woods, CEO
RGI Genealogical
