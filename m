Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE15472C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiFKIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:10:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE641167
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:10:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o6so1092943plg.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Xdmi5qWYOhZsQOyZGBfH+vQOujfDSnvCoY7JRpLmrLc=;
        b=S70MPRg4USexJF7NybfHc3jyQq+dGlkjkSxNHKeWapEKUFlGiK2O02DDzHrVInETJm
         lVisnlj2qXewebxWFeMTXcwFiPUd2shNlvLyMaXywGnBxHVPFeAX/KkiySM6vxO1HAD1
         Bea8MT1Mt3tMaUGvr9A8C6AUYepnxefRuUPcdi64qEIr3gXKajA09zV6SCAJlfcLKOfR
         GS6Qkh0XxbTch4KOGZEsL9UHBdSevgAw9QzV88XHCACzFV8yAchmxD3zmeHQjkgnTwae
         1aoxsSsjexrEd1r98HQhCklGg7c6uxr/J32GS50HMH4LT8eM0nOsDKeW6SU48MFacG9S
         RhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Xdmi5qWYOhZsQOyZGBfH+vQOujfDSnvCoY7JRpLmrLc=;
        b=XTDOzSUSmImTDzCKksV+GEZ2wtOG4FMEsGrqYEym5Uolb3Hd6ipZpPAYuyr3/Y7vaz
         t1+qhRgoBQFREkq1q9kUQEnFmi5BPumyUkFqVZWupNvkTXBb8kbnOOUzfLKeVrKyoRQK
         d1D+TiTVGMjXLti9DkjfNJ0I07AQBNQeGGurYBmDLn9QGUm33M8xG5Yxg0rqcJE0HyAa
         UdeZ6pR6LSV0L8+N4k80VpntyXqVh2hiGGtkvnud8jE4xHYqtVZ6zshzkb1PeGmQV5pF
         VBPC5K/ceOzBkGoaDXgMl4xYC5q9VjlpeNIuiO01qj+waRupu0ZXvDH6Czhwdn0NrdEU
         4Hfw==
X-Gm-Message-State: AOAM531wschFTt88A28Ym9YJyO802DC7ho2FqIVyGb8/i25tHNSWZDU0
        msIzVh2187rDTCRjPKZhEVS2Yo0r3LioFsediuI=
X-Google-Smtp-Source: ABdhPJy1NmMPAENWSPH386W1qI/1ypKm6XffHtbdO55ll12985KowgSOsXsOQoP3oM9uBc9y4uMPJ7+rmDBoGbJhUFE=
X-Received: by 2002:a17:902:db06:b0:163:e89d:622c with SMTP id
 m6-20020a170902db0600b00163e89d622cmr48704426plx.143.1654935044245; Sat, 11
 Jun 2022 01:10:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:a2c3:0:b0:4cb:a952:1459 with HTTP; Sat, 11 Jun 2022
 01:10:43 -0700 (PDT)
Reply-To: giannini_amadeo@outlook.com
From:   Bank of America <1001kuikui163@gmail.com>
Date:   Sat, 11 Jun 2022 09:10:43 +0100
Message-ID: <CAPK65Xmem9ebbBemug_c4UZogxhwaRpB9EkQMFo4=h+Yc5s0Ow@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [1001kuikui163[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [1001kuikui163[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello loan applicant, do you need a loan? How much is the loan money?
And the duration period? Contact Amadeo Giannini, the loan director of
Bank of America a Private Money Lender and a corporate finance for
real estate and any kinds of business financing. I also offer Loans to
individuals, Firms and corporate bodies at 3% interest rate per annual
and 0.5% interest rate monthly base, loan terms determinant.
INFORMATION NEEDED ARE: Full Name: Location: Age: Sex: Country:
Contact Phone numbers: Amount Needed/Duration:

Best regards,
Amadeo Giannini
Bank of America
Website: www.bankofamerica.com
