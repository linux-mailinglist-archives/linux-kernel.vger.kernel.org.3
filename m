Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AA55131E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiFTIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiFTIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:44:57 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C8E9A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:44:56 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 15so1159680vko.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wmbiGL9iOa5y5x27MKgGYUO4KhU8OxfP5CRX2AvU4zY=;
        b=hVz7aOYL39sp7cKEj9tP3uxUCMyP/wc2pLboBtPjUSWfmeQbtpuvFFXiyQ7/8/U5sN
         8DlJIxc90osoUmTjo0e4SEu0srBd9zZNkDIsXeQF7wr+uHGXE4ANog4fYUb7qYL9FhrC
         u+craSXtDLyvaMflE4Zjxy2XxQcfxTkmD4mG7TSic5go2O/zxLDZ3sjTUCPvZteQShf8
         fGRWhX8u6dfkgQYZefkb+2qBeqUN/BjohJ/3ZXPG2gRRtOESxktbkt64AA63gi8d/RGJ
         Jrm44Q2mMmkMvFyNRnBvA10s0duWWqkpUEoQgqW9YK2SJXiNLoiEc32PULS7TniXKJ5U
         V+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=wmbiGL9iOa5y5x27MKgGYUO4KhU8OxfP5CRX2AvU4zY=;
        b=1WIaFNZZWDMvn6AVR+/CT+HOk5ZU+TIsisFn/WhdSvF93pwoT80MW1RMH+Etj+6mFv
         7R75ZsfkV0EcPqQLQUUHsigJRErmRHXeoHMT8oRR0A6aJ14T3gbIHP42zbR+Cbl3/rXK
         BQCKPuuHo5ssc9k7C/dCBGsqKWa+EVdINeGQ4cLa+iGtOakJpaOBTaXdCm+V67GrzugT
         EUKPZqsZqfxAUe09qse6IYUP799S7d6Sa0mWYLyOJ1S6bxtdUXzdPwbqxTa5gQqiqL5u
         7kWCXnDT9UVlorY6Loumt/lVwGVuP35gTelQMwuvtcZyDsee/u+vmKCT1ytc5EfCN0kP
         TTfg==
X-Gm-Message-State: AJIora9gXwrxKAoteWn81Ci3lIWDpvg98VCH4rOhI/XqfQip86o1dQMq
        ywjqt9oz/ECBzriEEeOUxkqB9v9W8HBi2ded0V0=
X-Google-Smtp-Source: AGRyM1sY0zXM+p0+YsryZfYRq8tPR/AG1YDovEEyFO+quuSiUm5QzZMlxb2qrcPx6BZWzRfi17WCjkqeF/Ti7iUDGKE=
X-Received: by 2002:a1f:724a:0:b0:36c:309b:9a08 with SMTP id
 n71-20020a1f724a000000b0036c309b9a08mr473183vkc.7.1655714695294; Mon, 20 Jun
 2022 01:44:55 -0700 (PDT)
MIME-Version: 1.0
Sender: missaisha.gaddafi2014@gmail.com
Received: by 2002:ab0:3d0b:0:0:0:0:0 with HTTP; Mon, 20 Jun 2022 01:44:54
 -0700 (PDT)
From:   Mr Ibrahim <ibrahimidewu4@gmail.com>
Date:   Mon, 20 Jun 2022 09:44:54 +0100
X-Google-Sender-Auth: QCm_lDhbWepUODZkvU3XBh3S2IE
Message-ID: <CAHnzjr1XBJEXE=Xdrjvs6X1BG9nLn2hMtCgJTcAJPtOmVjX=Eg@mail.gmail.com>
Subject: I NEED YOUR RESPOND PLEASE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FORM,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_LOAN,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5013]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [missaisha.gaddafi2014[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear partner

My name is Mr. Ibrahim. Idewu. I am working with one of the prime banks in
Burkina Faso. Here in this bank existed a dormant account for many
years, which belonged to one of our late foreign customers. The amount
in this account stands at{US$19.3 Million United State Dollars}

I want a foreign account where the bank will transfer this fund. I
know you would be surprised to read this message, especially from
someone relatively unknown to you. But, do not worry yourself so much.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information if you are interested
in this transaction.


-Your Full Name:
-Your Contact Address:
-Your direct Mobile telephone Number:
-Your Date of Birth:
-Your occupation:

Best regards,
Mr. Ibrahim. Idewu
Email:ibrahimidewu4@gmail.com
