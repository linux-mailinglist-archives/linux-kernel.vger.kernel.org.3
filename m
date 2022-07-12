Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC05718CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGLLph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:45:36 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F55ACF61
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:45:34 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31cf1adbf92so78108987b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=oslTq8Z7mBSpt+X5H9Q37Nxd1ONulQCEf83R9cxfg5c=;
        b=GvyQMDr8kuHWKKnQu43mVwP3PFW+ufsZx4OSccq4s8TL68AqqTxluvQdDXvURx3qVE
         Aui6kwcAMTS3303H8dMDpLdSVcNfdCT+7Jcvcrf2dLaLmcC1Prfvo5UAeIUe7Il34EW0
         wirWuLEKagX/PmkV3ipny2IQyVGaXMbvCg204dKlvW0yfpOT1GOKZmgSa/Jyy6RkiScl
         KT9ZuysMZ8y5Q6QU+4MG8vs3OneFywcL/W4olapfEq6KKxQYkUJwOS16V4f610HZSYKB
         kNjnJo1tUkmeL8IEKMabzYJ/39RQ/aS9btBbO025/budPm/vocsH7BYLpHZlwqVqqVu5
         8UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=oslTq8Z7mBSpt+X5H9Q37Nxd1ONulQCEf83R9cxfg5c=;
        b=sLedB7gN1DCk7nm5z9DJPXuOCmEglTZPLd4/DEXqBOYIMX9Hy1b4W6fockPSyOJYdi
         Zik+Gx1f/z3frPKfBTjIkq2NCScGJ7gUk6xJQuDBKhSMfICbWMxsxM8ktk3amekS3HU5
         2MIytnl0HPUgdvfLOTdMYVZ8O+1RgG6fDYGj0AsnP2RBlpJtI35wbOVrd3fxAkjjGuBX
         oFhRLlcZgRHGaf20i1NHdk79MR2iY0kyoakZvbWeDv7YnHOe3QwjQ8xHnW38vYFUIVg0
         bUjdo/PONH1tyT1+H68uQeLaDXkhFQuQlNDzGkqPZO7UgkfQCYYF7BrQqAw/yCSxoIvh
         vW9g==
X-Gm-Message-State: AJIora/0JI3l8BUip6J5QQv/j6CJxCZNVlft3MYnrSDnN1f6Rw0Xb9Yn
        x16AG8DqZjRMqgMfh6CcRQS6BFi9+qSUVZBZs5s=
X-Google-Smtp-Source: AGRyM1uZMs7VTMxVGUBZp7TylPJ7DyLIkuPBgim12M0wIAwcbHUewM7EvTEeeZ/JOkCRgUIQDpRXqU5eY3HAMnzIUKQ=
X-Received: by 2002:a0d:dc42:0:b0:31c:7b70:1f31 with SMTP id
 f63-20020a0ddc42000000b0031c7b701f31mr24479528ywe.513.1657626333935; Tue, 12
 Jul 2022 04:45:33 -0700 (PDT)
MIME-Version: 1.0
Sender: ireneraya0@gmail.com
Received: by 2002:a05:7108:909f:0:0:0:0 with HTTP; Tue, 12 Jul 2022 04:45:33
 -0700 (PDT)
From:   Mrs Aisha Gaddafi <aishagaddafiaisha20@gmail.com>
Date:   Tue, 12 Jul 2022 04:45:33 -0700
X-Google-Sender-Auth: xMAc1A59nWVlaMTcF98747Tpro8
Message-ID: <CAOGarBK1cSA+vUG_E07iZw=PAzdCE6M-0EPd8s55cPyrKfan9w@mail.gmail.com>
Subject: ASSALAMU ALAIKUM FROM AISHA GADDAFI.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FORM_SHORT,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9998]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9998]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ireneraya0[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ireneraya0[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May i use this medium to open a mutual communication with you seeking
your acceptance towards investing in your country under your
management as my partner, My name is Aisha  Gaddafi and presently
living in Oman, i am a Widow and single Mother with three Children,
the only biological Daughter of late Libyan President (Late Colonel
Muammar Gaddafi) and presently i am under political asylum protection
by the Omani Government.

I have funds worth " Seven Million Five Hundred Thousand United State
Dollars" -usd$7M.500.000.00 US Dollars which I want to entrust to you
for investment projects in your country. If you are willing to handle
this project on my behalf, kindly reply urgent to enable me provide
you more details to start the transfer process, I shall appreciate
your urgent response through my private email address below:
aishagaddafiaisha20@gmail.com

You can know more through the BBC news links below:

http://www.bbc.com/news/world-africa-19966059


Thanks
Yours Truly Aisha
aishagaddafiaisha20@gmail.com
