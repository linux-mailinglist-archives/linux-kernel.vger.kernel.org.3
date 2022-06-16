Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00DA54DF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiFPKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFPKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:31:06 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CE5DA59
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:31:05 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-30ce6492a60so9575657b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=26icL95mjlNGXkutQv5SK5DDaCl7048Q2xhMlZz4Sdo=;
        b=HseiVAecTgcAkB0wjoZYqUz2q9LZ1bvAWh6xI3jI1osvNKx8kdOwt5lNXCMMjlYOfJ
         gLLrIxO0EdGoo/Tk3nRK149wDGJHsepxTcxMmK66olR96MzIFpUVemTCq0gRHOAhqHGJ
         H5L91n8mAZX2pagXyFriMsmV6eVNdti5qXjQfosWD0BCX4HSzUqw1lmYHKmvFk2X0CFt
         Stp9/eDsrg2NVfLFngcMh/Mx4HfLexmn1SPkwJJaK7dx/rasDzvpG3Je7BsTMFaPyruU
         OpUXKK4FzdxUCwBRp2T2zKN+jGvnZvVHCvXK1uLNxEpECETcXOuWHgsFH2ZfiPOgyqXv
         VYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=26icL95mjlNGXkutQv5SK5DDaCl7048Q2xhMlZz4Sdo=;
        b=m2m04Y7vaSOt4bSvxizqPXUg8rVtA6ejhGbdB9pxnkdW9wE2JW/oal9YR9bC2TXKdL
         HrXzwQD3KF6V2i2OkovzQguc5HzExRcFILQ1sNnfgwDSMDLy6/QRO3j+nBb36H7YF1CE
         2nMqBhiJJafVYN1OO7GQUdKgDv8vBmp5TBiipHnMFa7Bg7qbuWo7k/mqiFTBUjRO3fKK
         ZO983eXIVBiQGWebrF1BI3tVS7s82kjKHYq7P9zLrxq2I545cSuzVUZdQQdELi7pxEh8
         T8Ay7XSqJIcs70HW62PY1PlRfKv/fMHYU5jOe2P4qP7vhY/4CkvJOn7q3B6kyri7WKjU
         T8zQ==
X-Gm-Message-State: AJIora+ohEkbHYwusnMN0cM3M7GsrPb6tdtfV802blxrGedUK5hi7Ni/
        jUjvzvGuCH43etConOOjg2GmOsRzF1jVIf8Z77g=
X-Google-Smtp-Source: AGRyM1sVZJQYOPln5Wt59ZsRsspyR3SNweziuPLyJ6DR8YYRSPPh3ttHeSXWI4qiRB2h2mnKBSkZYLoUXR6mj7LVe/k=
X-Received: by 2002:a81:8707:0:b0:314:1c64:eb4d with SMTP id
 x7-20020a818707000000b003141c64eb4dmr4836639ywf.86.1655375464068; Thu, 16 Jun
 2022 03:31:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mohammedssaaaad@gmail.com
Sender: umarbello2078@gmail.com
Received: by 2002:a05:7000:1d81:0:0:0:0 with HTTP; Thu, 16 Jun 2022 03:31:03
 -0700 (PDT)
From:   Mohammed Saad <mohammedsaadht@gmail.com>
Date:   Thu, 16 Jun 2022 03:31:03 -0700
X-Google-Sender-Auth: n0mbAThCVCVZqjTC7BP_U4wrtLc
Message-ID: <CAGwXm=uM7i61M5y6r=MA2SbcmSAZOyAVTbhszcNP4M66uDt3ow@mail.gmail.com>
Subject: Business Proposal .........................................
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_REPLYTO,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5145]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [umarbello2078[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [umarbello2078[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is a personal email directed to you for your consideration alone.
I request that it remain and be treated as such only. My name is Mr.
Mohammed Saad . I have an interesting business proposal for you that
will be of immense benefit to both of us, although this may be hard
for you to believe, we stand to gain =E2=82=AC 15 million Euros between us =
in
a matter of one week.

This is fully legal and 100% genuine. I need you to signify your
interest by replying to my email. Most importantly, I need you to keep
whatever information between us confidential even if you decide not to
go along with me. I will make more details available to you on receipt
of your positive response.

Regards,

Mohammed Saad

UBA BANK

OUAGADOUGOU BURKINA FASO
