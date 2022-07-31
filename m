Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A23585E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiGaKMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGaKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:12:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13787E006
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:12:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h132so7308014pgc.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=w/6IUKEQzPR0YWslKj5EpT5t//tkuEmuTEP68HiniPY=;
        b=JnasHyit9TMI/dQ3agXsD2FoRHNzGPrq1C7sMRz2fkbDIFoxQ6erJ0cuCttvEU+12E
         QzldmA9pe9rDgaVu9fdOCQeWmVGcFZo4m1E1TdS/VOQaS75cXUBPXPGITuJXEFPXS8N7
         rKWY6gEWZoDb6vr9wW7vzgRUqpNLnZb2SgVdJUT+t1xLJ6/3GL3pqaNjOsNH03tHDg7q
         qdiyI2C2UtWoLB97ekVuOswl9ncgu685KFBHjYzJYrDNc+0Ad828tT/JW6et0NSMpIZ1
         OBiSFfrkUjx+tfw/F/AHy6gSn0bpfhP0MpMW/OU9cbU1PIgSmtokBTFhlGPW3xW5rZX1
         dYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w/6IUKEQzPR0YWslKj5EpT5t//tkuEmuTEP68HiniPY=;
        b=SPkSvFGoiQIPQ+5T1+aFYlsypMUDASUXXmU5rcGfVKxP/H4/rXVjQ0GWedjp9ZLRoD
         jGSwrlvhXwpTXVRNZ58R6cg5SvWB2UCUbGfwxQcSXWJgjSHFWMsX8UQvy2i8v4N23S60
         6pwQS/9m66Z7tR5ojpGATFMv1J0ckFqKOOFtFtDQlmpm3dsRQ1UQsMGvVq6gVef5jtJL
         aW/ygUctN4HUDm0UPUNCJ4zySPVjIOPsAG7/mrajClc7qqrTitxT54pbLal57g5oP487
         j5nE3GF2mac7WJBDAFeG8azs77D/xE//wFvcSV4t6Y6etJLK/WkBOgSzxlxgJ9HstsaN
         4F9A==
X-Gm-Message-State: AJIora8mbuD2hUbzX9CS0fLKVz0KA4V6vNyaXgxv402ReMtd+hdcBdMS
        gsQK0P1MdJF9FyGOffbiE66ZcuEhFYpzRCdWjGg=
X-Google-Smtp-Source: AGRyM1tUpyRNmGtd4m5DTT9gGA4kdo7Rx2Vm4L4x44zK/XSR9cw7uTh5eWV3f2JqbADQqL2n9Eb7str8KOWY/fflDyo=
X-Received: by 2002:a62:ee01:0:b0:52b:bfb3:6fe8 with SMTP id
 e1-20020a62ee01000000b0052bbfb36fe8mr11605195pfi.28.1659262320631; Sun, 31
 Jul 2022 03:12:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e254:b0:2b8:db47:6b92 with HTTP; Sun, 31 Jul 2022
 03:12:00 -0700 (PDT)
From:   Frank Hughes <fedcreditunionbank@gmail.com>
Date:   Sun, 31 Jul 2022 11:12:00 +0100
Message-ID: <CAAo9Pva3AdeOUSPkZ6xMUDYWbNamd=O8Key8dW9yh2sEmgO8jA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:52a listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6486]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fedcreditunionbank[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm Frank Hughes. a former commander during the United States War in
Iraq. Now that the United States has completed its mission in Iraq, I
am currently in Syria for more assignments but will soon be assigned
to the Joint Multinational Readiness Center (JMRC),

During my 6 years here in Iraq, I was able to make the sum of
$25,000,000.00 million. this money came from oil deals I was guarding
oil fields from ISIS with my team. I can't move this money to the
United States because I've been in your country for years. Second, I'm
a uniformed person and I can't parry that amount, so I have to present
someone as a beneficiary. I am an American and an intelligence officer
for having a 100% authentic means of transferring the money through
diplomatic courier service. I just need your acceptance and everything
is ready.

The only way to be safe with that money is to invest it there in your
country, considering I will be there for some time. So I need someone
to deal with. If you accept, I will move the money to you where you
are the beneficiary. For your help, you will be 30% of the total fund
and 70% will be for me, from there I will invest the rest. Before
leaving Iraq for Iraq, I sealed and parked the shipment at the Red
Cross office in London with an agreement that I will provide with
details of my partner and recipient of the shipment.

When we agree to work together, I will you to the company ion London
to complete the shipment formalities and introduce you as the partner
and recipient of the shipment. Where we are now, we can only
communicate through our military communications facilities, which are
secured. Please send me your personal cell phone number so that I can
call you for further inquiries when I'm from our military network. I
will give you more details when I get your reply

regards
commander Frank Hughes
