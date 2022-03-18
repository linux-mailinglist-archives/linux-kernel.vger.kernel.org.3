Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956594DD7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiCRKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiCRKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:09:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31327B0D3A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:08:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w8so6596476pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=24ALj6df8DadrbfGiBDkQyMLABxJ1K5rvoSZDpzRXys=;
        b=OdEFdMqN8nhoFp93J+fDW9yqJlVR+nfEDoVZre50QkgtBpj+QfKr+EM9GT0ovR0RZr
         FELdQ1uxl7urZ7O8nUR+LfG7X5zB6UBXJWPsmtXNSU/vINdjs3nLMCisPChIdalFZ6R+
         WjG0fSd5vzZWW2E7af68pci+e9bhuHI3J5R4qBnaoYgr40uD6NDX5tSrbadYyAQ2Mlq/
         2qjxYjdAUx4zVLAmndYzTlkMdcDEsOnrqtZV/6SA+25iy3ZuIJTQKJA3x5mVoUId9PfA
         UIDtGZaiOaXaFe7DseQSiams1zTzZPbsgmVzkQKBtDfk0KqNeBjdrpWGkaatnzOu+yZw
         BYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=24ALj6df8DadrbfGiBDkQyMLABxJ1K5rvoSZDpzRXys=;
        b=OzFAnJfuK4AhVPS85Ki/I+mjDPUrkASkFhliaX7XgJRD2h7jtaINy7OCu1v4NIcjMK
         XNGwBHkAb08bMNrkAVtmwaB6Az3em8kFsAk10y5xbXF3JZl1akN8fmsYPhTNtctSxqrS
         mm6/XlcO2lN3fXDkgTuzJuaMaOgkYrfDZNQIPBzIwHwSVMVa5zZa9/gyuNUTp6J5t7KS
         8+b82Q5KEM3mjxdleVNdqBaUgpQSrGmWbwsYQxfY1aFM4INvo8/h3YPZ2ck7tJlrP8oA
         wXPrUwfXVUWXvpXDeuDnCOUqyCoBuKUHwo7MzPy8Aai2qWVyJL8ZNOGbIjZxmp9z3bM3
         CM9w==
X-Gm-Message-State: AOAM5337iBrWydNPoHYJdw/kzlpVVnaqCDO2RNt8zIQTlfhRhI3Y705r
        oY7Vl6iEzpC/apCrcu6hn9k8zXoSX7ttClSE4PM=
X-Google-Smtp-Source: ABdhPJxSfL0mL/Q5qyTGi1CMdeRLhwA8L+AbtRkzGiyKU6poysKP4fjoZJwBHGr5UGqSlZgmDB5R0MMx0a8QcW5Y8EY=
X-Received: by 2002:a17:90b:4d82:b0:1c5:d65:9a3a with SMTP id
 oj2-20020a17090b4d8200b001c50d659a3amr10342652pjb.112.1647598093603; Fri, 18
 Mar 2022 03:08:13 -0700 (PDT)
MIME-Version: 1.0
Sender: kadijat.ibrahimm@gmail.com
Received: by 2002:a05:7300:8427:b0:59:3438:53ee with HTTP; Fri, 18 Mar 2022
 03:08:12 -0700 (PDT)
From:   Majid Khalid <khalidmajid576@gmail.com>
Date:   Fri, 18 Mar 2022 03:08:12 -0700
X-Google-Sender-Auth: 7V16hSOzexj5jXm_CNczFKdsgGc
Message-ID: <CAHzY5sORPOB18+QBYovEORevNS603KfWENJiqZJozaLUu245hQ@mail.gmail.com>
Subject: GREETING,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:636 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khalidmajid576[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  3.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting my dear friend,

I am Mr. Majid Khalid from Damascus Syria, and I am now resigned from
the government. I am a member of an opposition party government in
Syria.

I need a foreign partner to enable me to transport my investment
capital and then relocate with my family, honestly I wish I will
discuss more and get along. I need a partner because my investment
capital is in my international account. Am interested in buying
Properties, houses, building real estates, my capital for investment
is ($16.5Million USD), meanwhile if there is any profitable investment
that you have so much experience on then we can join together as
partners since I=E2=80=99m a foreigner.

I came across your e-mail contact through private search while in need
of your assistance and I decided to contact you directly to ask you if
you know any Lucrative Business Investment in your Country I can
invest my Money since my Country Syria Security and Economic
Independent has lost to the Greatest Lower level, and our Culture has
lost forever including our happiness has been taken away from us. Our
Country has been on fire for many years now.

If you are capable of handling this business Contact me for more
details i will appreciate it if you can contact me immediately.

You may as well tell me a little more about yourself. Contact me
urgently to enable us to proceed with the business.

I will be waiting for your response.

Sincerely Yours,
Mr. Majid Khalid.
