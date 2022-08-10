Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C097758E680
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiHJFEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiHJFD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:03:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A9E61DAB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 22:03:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so16406824wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=0j2fNWlhqHDdR8vDkqVbAvzs/vaD31QYk8D65F418vw=;
        b=We0RhU1lcIv48f1w5h5Y9l4PrOYGQY3TKKATNvERuq7LeU6P6lyGki0TM0+XO8TpTl
         WDuF9kSS/TBWSSBFdHt6AR9bhqeW61Tv0/VnCaBFfG3jhfNguJhOvc4SNDH2oalEn13O
         Kz4P3pKJLIqKPefFpxQJ82HVbl3SqSPGe/ZclClz5cI9F4ag301h0zRQp9ZouzOE0hvv
         7Z9t6w40fu+nbKqKeuOtTmq2KfkQaC5r+ps/tAmJ7xCeHFY2b+HTrYiTvFoki92KiCX3
         bBhIganumcZqo/u3w+54M/V0yvIS7bDrfim6mHMHrijLJqV8f0KHrI8BKWxxGb9wgAC7
         hP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=0j2fNWlhqHDdR8vDkqVbAvzs/vaD31QYk8D65F418vw=;
        b=hCSkWQWzbqUwVv8l6guQJUvgbTZiq2UG1PaxzK5bTKU2JelXzaFjf68Aq4QEPGqrva
         AVi33xZYO0UhLiC8eDu3NkxpLLO2fQyIWuQRvOjrOX+pVclxM6zGxbtaD/EZUXqBK44z
         kH7ZjXjATvnHAWyo0SiTKQ0hiDi7dHknHbSUNmjfrMppWW+bZAt+RQcd+SMOKdrwSJQU
         KvJjGPDsEs48AITUw8QKU6o1HS+Qw3Ijb6ld6Th+ou1CoZtk5f5CwVhiKqidOdnkc8LB
         xCbWUOoNJXlyXnVG/U07IHqY7+GFohXte7Mhf56VSJ517EVd7CKfrkKGlIk72E9ds52b
         u9+Q==
X-Gm-Message-State: ACgBeo2PSQrGnvSXZQC0fj9oWBy/OJvRwSnoafUDEb/GAYoE2HSuG26Q
        F/78zvOOpqsU0I4TsomLsbJU573e0RhbtwwES0sY4jd90BJzWZU0
X-Google-Smtp-Source: AA6agR7LLMSViSMA5pMIoV/FSFSuI1SGGErYxCgeeW28jzqvR0nGCUMtxQWdDsreFk/awqOL+GxNryK0rgOyjU9uQYw=
X-Received: by 2002:a17:907:3f98:b0:730:cfce:9c0f with SMTP id
 hr24-20020a1709073f9800b00730cfce9c0fmr19688226ejc.475.1660107826762; Tue, 09
 Aug 2022 22:03:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:50c6:b0:43e:b824:d1cd with HTTP; Tue, 9 Aug 2022
 22:03:46 -0700 (PDT)
Reply-To: ausmann@inbox.lt
From:   Abu Usman <omosekinat31@gmail.com>
Date:   Wed, 10 Aug 2022 06:03:46 +0100
Message-ID: <CAORo+3c1_8-v+S1VccdeoiRQFk4gf+4Ni5xU2kjvT=VZu9xjQQ@mail.gmail.com>
Subject: Hi " Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:435 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [omosekinat31[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [omosekinat31[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  2.2 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting,

I am indeed glad to be in contact with you even though this medium of
communication (internet) has been grossly abused by criminal minded
people making it difficult for people with genuine intention to
correspond and exchange views without skepticism.

This is a private effort to introduce a partnership intention and
proposal to you, I decided to write to you. I have decided that I seek
your assistance in a matter that requires your urgent attention

I'm Abu Usman from Afghanistan, and I am contacting you due to the
ongoing takeover by the Taliban in my country.

I need your urgent response to help me receive some funds for me.If
this is something you can do, I will appreciate your early response,
so that I can provide more and appropriate details of the entire
proposal, given the fact that this is only a skeletal introduction.

I will appreciate if you could let me have the following information

1. Your Name
2. Address
3. Your cell Phone Number.
4. Occupation

Your positive response will be highly appreciated. As soon as I
receive your response I will get back to you Asap.

Sincerely,

Abu Usman
