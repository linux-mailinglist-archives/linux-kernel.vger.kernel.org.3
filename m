Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3F4BC849
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiBSLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:47:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbiBSLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:46:57 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E9BBC25
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:46:36 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id bt13so24552734ybb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=C3Ganb7mzGkesp2qM5finmqUl+DcP/JuUu5/dznXtFQ=;
        b=VEd3eJvBJ/kgvsVeAXPR+Jmy6bwZq3V2wbiobo0EZumVYaR6WkXsfzgsCX7pjnS+Qp
         ZLrMYGv6HhEMFq96+umvi34IQgZw4irWOroeOv9QOnIbCojnSiALHp+azhtJ1oWd/4P3
         IASGXaQ3/H2VTqSj1qLttyQf5pZI/3i+ddgf1Exibfi8RIiHon7A5VUg9Swy2faPBkvT
         VY3Z9QTh6hgJCIZQO+mkJvP/SGgiEutDgddab5Xh7j6iQnz6ILpJkkgmr8qK1yMu6JT/
         OT34INqelDlMQdYYZT2fIXGRb3wDp8S7Tc0bk2o6MMex0TSQwIsywJYPgH0V3v1nKh9N
         NxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=C3Ganb7mzGkesp2qM5finmqUl+DcP/JuUu5/dznXtFQ=;
        b=g3KFXcvM2bMLg4razhstXWxhok1DFBMlvbrfjI+gJpamiaVPyE38Ea1E61nWZPb58D
         FQuLf8UNAYHhtnSdnqdS+IF6K2bZb3UwjnyXMg44V16LmTBHqHR7mPd2KguSEgEDBFxx
         tiBVKKL6ElumLKskzk2rJpncHwERXlaRzWPJZIjIWtG2SoTBEStHsNVw35L8vFYhQphJ
         3uG4EaCpIKyMFv5ArLFd/5LhFYoH+lVBhaxzFMpOpyI+GNBCZJawOrsWlM3PqUeiAmcD
         jxabAg3qZxMhBXNAtCFydDExBQESZ0afr0WbQ4P7IYUZbZ/2Vh5Qd3NqCGzinCdLHKrr
         Q01g==
X-Gm-Message-State: AOAM532/ry7AqbCSSWpu/8xcdPVnwKKk1xu2n/VNUrOrnFQOBEwqZGKS
        Iht6CYH9UzdZp0x0ZUW7wZGm1slWOm3yICi9E8w=
X-Google-Smtp-Source: ABdhPJxl/a+gXEz2FkkB6R4CDRVmPAQ7YMHlS3HqTHaSMnEAKz0ozyL4UH9YLuLpMlX/9tASngNw9z8bgnfT3yNUD+0=
X-Received: by 2002:a25:8891:0:b0:624:689e:cf27 with SMTP id
 d17-20020a258891000000b00624689ecf27mr849327ybl.551.1645271195418; Sat, 19
 Feb 2022 03:46:35 -0800 (PST)
MIME-Version: 1.0
Sender: ifeanyiomaka1@gmail.com
Received: by 2002:a05:7010:1786:b0:210:9d05:b5c2 with HTTP; Sat, 19 Feb 2022
 03:46:35 -0800 (PST)
From:   Aisha Al-Qaddafi <aishagaddafi1894@gmail.com>
Date:   Sat, 19 Feb 2022 11:46:35 +0000
X-Google-Sender-Auth: sFm1R5H1DKqDpw0VXebIiiQV3aQ
Message-ID: <CAO-KV1_V-7bu+cRukDXY+XsZXGAOeg6QJKnEjDgEQG_cpjytjw@mail.gmail.com>
Subject: Investment proposal,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ifeanyiomaka1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ifeanyiomaka1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear Friend,

With due respect to your person and much sincerity of purpose I wish
to write to you today for our mutual benefit in this investment
transaction..
I'm Mrs. Aisha Al-Gaddafi, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia, I'm a
single Mother and a widow with three Children. I am the only
biological Daughter of the late Libyan President (Late Colonel.
Muammar Gaddafi). I have an investment funds worth Twenty Seven
Million Five Hundred Thousand United State Dollars ($27.500.000.00 )
and i need an investment Manager/Partner and because of my Asylum
Status I will authorize you the ownership of the investment funds,
However, I am interested in you for investment project assistance in
your country, may be from there,. we can build a business relationship
in the nearest future..

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds..

Your urgent reply will be appreciated if only you are interested in
this investment project.
Best Regards
Mrs. Aisha Al-Gaddafi.
