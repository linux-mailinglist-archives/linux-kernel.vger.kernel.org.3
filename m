Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C44DE8FD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbiCSPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiCSPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:19:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D412714F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:17:58 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v75so11917664oie.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=7MR/c1c0HoGO/HVVoYlYmh/1TEGUfmBelnD0hQ6ZZJc=;
        b=BNSiWTzZ874z1n9Dcu7WeIwXWz0L97gfCrahL3tsUy9lh6xmo5WG8lFqlD6BOasI3e
         HNLL8Pj+M17Pct55KjCrACk1uS125b80eC7dMEKcLMBlMLqbV4FMgsVvH2CXhxY1P8M9
         ryH3gcN1xhJWdfuOBqb4yRxW/mjiyGkj/gDe/n49uDqza6h+yUry57XW8izaGKpWwmIL
         4G4nY/oFB6Bn36mrxcsr+Fg1kTJdIhPiDnNH/gEwz1t7HpyO6gtTBx+ot6lb2HXFmHoi
         VV7g7W5FV1NglrDBK1yKWnopNbcnPsVLQJzkREq6NsX2KkzgEfFst+QfQEaHbsCoEidb
         siUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=7MR/c1c0HoGO/HVVoYlYmh/1TEGUfmBelnD0hQ6ZZJc=;
        b=BgiZClvXiu18GM5/Q8B0SBMGZwSN6dcZwjrL70UysQ7LMzBtr7eWTyoBsvAurslNSq
         2vo9TOGJPtMIWQEwTDuJRhK1PAbZppXkX4wlI9lWvAqg6kl6Ct3q8H+1NxYoWwUwESvg
         qauOCHM/zjuYRjaN3y8xdJWdpjPhSprTycWH1eHevDlf/cD7ipL5ERoAtUz0ObjbUaic
         wCoF49PjB4ysvdGYj/NyD3FWN4K8BrdYj2K1y6If6mIIwjU7BFdKWHaLfGtbXin/hMx3
         JP7mcbVosFRl3V+hG1JAO5exW0/YxoiuMbZdXkaZpq1PthVqZFRHy1nXvl1KTSqi6L9Q
         rdeQ==
X-Gm-Message-State: AOAM533y6V31GD0RIbuU1D5fGVW8iPKKMWsckzGdvIpMj9uY3Ly+9f2w
        FXNL9O9N3vQ200ABZcNabt5x8fZTaYi7T7H1GhI=
X-Received: by 2002:aca:1e18:0:b0:2ef:310c:2c30 with SMTP id
 m24-20020aca1e18000000b002ef310c2c30mt2958927oic.188.1647703077970; Sat, 19
 Mar 2022 08:17:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7102:0:0:0:0:0 with HTTP; Sat, 19 Mar 2022 08:17:57
 -0700 (PDT)
Reply-To: lisamuna2001@gmail.com
In-Reply-To: <CAA4TxLC2E_78SVkJEtWqC7A9Uz+tcdgT13bFvD2t_AY--oJ9KA@mail.gmail.com>
References: <CAA4TxLDQhQA-37gAZAQ12C-dpcY0XmrSMneTi4fDL7zqvQUZTA@mail.gmail.com>
 <CAA4TxLC2E_78SVkJEtWqC7A9Uz+tcdgT13bFvD2t_AY--oJ9KA@mail.gmail.com>
From:   lisa muna <kristengriest098@gmail.com>
Date:   Sat, 19 Mar 2022 16:17:57 +0100
Message-ID: <CAA4TxLCPZ9G-oOQ=MRX0SH0drf0hh56VeHcZYki1yOOmVHqP6A@mail.gmail.com>
Subject: hi
Cc:     lisamuna2001@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MISSING_HEADERS,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kristengriest098[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kristengriest098[at]gmail.com]
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisamuna2001[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I'm happy to inform you that i finally succeeded in getting the funds
transferred under the cooperation of a new partner from India,
Presently I'm in India, for investment projects with my own share of
the money and also on charity work to the less privileges and the
orphanages. Meanwhile i didn't forget your past efforts to assist me.

After your inability to cooperate I found a new partner who helped in
getting those funds transferred for charity work , please use this
share of the money for your self and also invest some on charity work
in your country.

So i left a Visa Card of $850,000.00 US Dollars for you as
compensation for your past effort. Contact my office manager and give
her your complete address so she can send you the Visa Card through
Courier Delivery Logistics

Her Name is Miss . Lisa Muna

Email: lisamuna2001@gmail.com

NOTE; The Visa Card is an international Visa Card and you can cash it
in any ATM machine in your Country.

Regards
lisa muna
