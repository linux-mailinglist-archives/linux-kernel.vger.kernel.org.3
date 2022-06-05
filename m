Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169253DEF6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351825AbiFEXdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351819AbiFEXdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:33:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0926AE4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 16:33:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so17740968wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hzqCG52SPEe4tQY/Tt070sXpLEE5srR/6HSZh6AwAPo=;
        b=kYqyTELNv74MY0+Xtsf1lfj7zVGpOEbEQXrg+C/90Mms9oiDDoR1tAGfsH8wjin1au
         YgEibdYFsC3ZX5fD3ZTrbFmbUnOpr2QIubv1+FRg642AmsgEU7LFuDOzvCU8SrQo9uVc
         ANsX9cHR3AzEewxi1sIvXUoaPTeYqv+2Rr+WwQ4SIg93A7YMlS/dL93POpl3GQL8wbq0
         PYcTfhT2s+YV+U+JG3Ased41N76s52gmJ8jiCBg7Ax2sUve8NNNgMFY+pegOkd1ur6+T
         LdPia7q6wNFPzAz/tX5zACpBCXsVxa66UTUf4H0pWTFHakZKiEbv0L32pINnRW88WSQ1
         6gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hzqCG52SPEe4tQY/Tt070sXpLEE5srR/6HSZh6AwAPo=;
        b=YoDx+kqHWhZJxM6+Qm/07BOJqJSKR0ap4j0NSr0tALf85RNZTpHVWfU89pEijE4GaR
         MpJXZNFvTZUjVVTJ40A1J9zrIGM4w5JuZk05ch1XM/zcJw8a+dw5dMFPJxz0X63SavkE
         nxp6iz5GMG2CWeMCVy50b5bpnfBft4GuzXHzcNueWZgpnI0fsDMMlClbY+PGuIf5zCku
         ZSlkvVq5igzKl2r1mGwqa9O3QYVKK1X8bIqk1xACZ2OovoFt+pYK0rCEVgXnYM1qyz1h
         Gz8HL2JMznVtwt1ffRKmcV0vs12S7HLsN3DmaOXtXhqpoo9d+wYzlrY0EKUCqeSujyf3
         i/wA==
X-Gm-Message-State: AOAM532vuygZYbTE4nIHF+sibNAVvEpgdEFddIwTQuqHfmDkzRaEbV8g
        /J1SiO42AiG8WmCiamWZ5vUhGgvuMOlerCkMys8=
X-Google-Smtp-Source: ABdhPJx05vkg/25slKFEQFCOcyfbvjg4JjNZFII0Ku3f/Gnu+Tw5+Fxv0/0emaesTDl49gfm20FsSYTWpw96OZmltzk=
X-Received: by 2002:adf:dd52:0:b0:213:bb11:2fde with SMTP id
 u18-20020adfdd52000000b00213bb112fdemr14778741wrm.467.1654472008195; Sun, 05
 Jun 2022 16:33:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:5b8d:b0:19a:1ddd:b4f with HTTP; Sun, 5 Jun 2022
 16:33:27 -0700 (PDT)
Reply-To: mrmichaeldoku@hotmail.com
From:   mr michael <md22334d@gmail.com>
Date:   Sun, 5 Jun 2022 23:33:27 +0000
Message-ID: <CA+6A211ud5NH2G_+uu26KkANKe6w8HCvQ+uyrrd45zBvifEkSA@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5148]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [md22334d[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

With due respect to your person, I need your cooperation in
transferring the sum of $11.3million to your private account where
this money can be shared between us. The money has been here in our
bank lying dormant for years without anybody coming for the claim.

By indicating your interest I will send you the full details on how
the business will be executed.

Best regards,
Mr. Michael Doku.
