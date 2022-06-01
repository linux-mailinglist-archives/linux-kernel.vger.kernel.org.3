Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5853A4D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352334AbiFAMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352193AbiFAMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:23:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591A3E5F9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:23:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so1905347pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=eE/RQgZbAsioeXGGDhy3YNOxe1f8/kg9fI5Pln+oa7c=;
        b=Z5Bxt2UsMbfXUsxvbJm9ljG3YeKEKbr9TosAoG4UPi0JVK0tRKPEhGaxUmrzLr1B8b
         6ZxfKNKH0nHwqmWlj25fI1/vBjKkt37HiQVan0O2eR7z0McEr8N1I+by+eLMqASOeLim
         eGgefDQfbiUHszqDnuPqjZp1ByiFc1eBQlEw88xNvP9U0cAVGUpx0Ix+ZWcrR2iPiykT
         zrPuyhXI8AwZwX/rBUdNZUvKvNzoEdMeof/N6rmcXU/G6/VmJvMFt35beeJ2QfF26HU+
         SOzOIUP3ImI3scmHr6WyvtBPx8po5YOMcfnonGG5OUI6o0+FRoZITzEz5qeik4Tr3mbw
         mMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=eE/RQgZbAsioeXGGDhy3YNOxe1f8/kg9fI5Pln+oa7c=;
        b=xY7doh5aVAARw+QFxZTdU+P6uQiM4x8BGl7zr4SbTd6Y6g2jjsdKPiByIsJhSi6pif
         WrpEtfgqvrWpWq5Ar1/VjS/+V44lm45A3bEqcItCmTFGOkPscIQfHXQ8auj/npOnAkXC
         LOdQKaR2Ae4/WVZsZomIJcsq6by7cm2VaMUQ9bOHH5uvJS7iCgBg1/C083UIgYgwEqQH
         tsMx87YhX7gMaHGfJkStx6G6Gkz7Ys+IyQEXzr/AJzp5i2poZ0Ye3U/tOrnv3rUH8g84
         qz25ts1+p6K0oSl2JVxCbqSX6vQ2kNXAzWUqO9KX7QijmAH84pPv9nuGpYkpZvrHBxLp
         XiNw==
X-Gm-Message-State: AOAM53396bhyMq1WbDrj3BXIQ9BERJdzSSyHHDhfQ2eq8LoXPQ+PU4qp
        JN9fanNhOYTxXTXXe8r7O8s741IRFTLEKJZ8EAg=
X-Google-Smtp-Source: ABdhPJwyecfdv1ZmTLbvb1N7aEx5LZEV/YyudSt+F5/QZLgnyaUMzTf+KyitPNuAmgJxvxq7ih+lcZtWbJvGbtGqUvs=
X-Received: by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id
 n12-20020a170902f60c00b0015682c9e44bmr65994468plg.106.1654086216532; Wed, 01
 Jun 2022 05:23:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:6282:b0:40:5c05:c05a with HTTP; Wed, 1 Jun 2022
 05:23:36 -0700 (PDT)
Reply-To: pau1deedee@yandex.com
From:   Paul Deedee <deedeepaul21@gmail.com>
Date:   Wed, 1 Jun 2022 14:23:36 +0200
Message-ID: <CAL-_JaEGRJfhD2ztG-1zPSaxz5ycAHo6QwerN=TE-5V-XXEE5A@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FORM_SHORT,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [deedeepaul21[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [deedeepaul21[at]gmail.com]
        *  0.0 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear email beneficiary.......Your email has been selected for a donation.

This is to officially inform you that we have been having a meeting
for the past Months now which has already ended with Mr.Antonio
Guterres Secretary-General of United Nations, Mr. David R.Malpass the
World Bank President and,  Your ( e-mail address ) appeared among
those people to be compensated.

You have been compensated with the sum of ($750,000.00) by United
Nations and the World Bank Group because of this Coronavirus pandemic,
which has been terrorizing all over the world.

This money is to empower you to start a business, the payment will be
issued through ATM VISA  CARD and sent to you from our representative
Rev. David Wood, we need Your Full Name Home Address and Your Phone
Numbers.

Contact  Rev. David Wood with this email.id ( davidwood2019@yandex.com
) or you send your details to me. I will be the one to send your
details to him.

Thanks.
Tel:  1 513 452 4395.
Tatiana Valovaya Director-General of the United Nations Office.
CC:  Mr. David R.Malpass the World Bank President
