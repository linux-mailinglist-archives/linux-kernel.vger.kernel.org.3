Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54C5AE71E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiIFMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiIFMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:02:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F827820C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:02:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so2404785lfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=aKRAxWiZNMhBTOwXeTZTH7tvy0Fc65bHyDaPpF0DRvo=;
        b=NBfBfzaN0Z5N0WTEF8szrODng5xZ0noHaBAuSvVFSLzDhMhGGtN4NyXvxj3IoJxhPd
         RNU8Oi6r4bSC2mpGUoB0Oak+BVc8HkxqK5oRiIwC7ueu0DRI41czHh4Q2EzEl3vGVkBC
         qYiuWOnlDsaVvsMjP6uP+zuoAEYiIS03CeCv5pvXvNZIjhB/qf8A/z3mJTgHwm8nxljj
         Gl5KgqlQRXUxr24dnNVQ2Mq4wO6NTMKvnhliJ8fzwIeaHc1CZP8tVTBTssJVLOV6xao3
         oa5EZMoX7moIUQhkRQ3E4AeHbkIlCDB3XCwNpyrg/vnX1a9/S8MLg5fLP31SNhNrEs2+
         MZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aKRAxWiZNMhBTOwXeTZTH7tvy0Fc65bHyDaPpF0DRvo=;
        b=Vg4X/SOvTWNF3pFnp8Key0Iu8qrUpFZywwie0tGc7pAx18CoewS204koYFLzwdXK/Z
         X7plRDmtzGzcO2Gox4wtvtyV8466i208RYS5W/gZL/dNDUIjv8JnlqaHM5S37CpBVokc
         CR5esVf7gVCGejUYCdnCg6C1pfJEwAQOa4Wf5YUdW0ufMTXxwqTboRvfAUtGVAK8tR1D
         5FcxHIR9eLG/whBJHM7x7CpZndHYH9H2OYBUt8cwXJubkBUo4CoVVl1isLjbiqZimoEA
         s+eKR9pVyJp93m314W86MWzaLT1zzVhmPCfoNwSYWLWupf2ksNlTn5J/shwfJsg9gvYh
         Ojtg==
X-Gm-Message-State: ACgBeo0Up2Ook9HYJgeahiUfaLmqById8TMiFQkcZyvEoE2t/MhZ1c9T
        JfpfTwvQBiZa5FdLywxapDkQ4yJ8qen5HDubSns=
X-Google-Smtp-Source: AA6agR6VevdQAEMr+DlhREt3U2n5yyQ4W7Z02h6dvNWuxd59Rdr76rVKAPivd1qkpJ8rnREjOKO8cr7j06hnE8DRPYY=
X-Received: by 2002:ac2:4e66:0:b0:48c:e34c:69b4 with SMTP id
 y6-20020ac24e66000000b0048ce34c69b4mr17232022lfs.85.1662465723387; Tue, 06
 Sep 2022 05:02:03 -0700 (PDT)
MIME-Version: 1.0
Sender: donnalouise11954@gmail.com
Received: by 2002:a9a:5c47:0:b0:211:6caf:f9ac with HTTP; Tue, 6 Sep 2022
 05:01:59 -0700 (PDT)
From:   "Ms. Aisha Al-Gaddafi" <mrsaishagaddafii46@gmail.com>
Date:   Tue, 6 Sep 2022 12:01:59 +0000
X-Google-Sender-Auth: wDFfIw0pGbi78U_zQGPxRXwHszQ
Message-ID: <CADncvCumEw=zp=TUmpccFJ=sfUgCb_5ZLtZkDOmnnt8=BRcjyA@mail.gmail.com>
Subject: I really need your urgent Respond now Please;;
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [donnalouise11954[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [donnalouise11954[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning To You My Beloved Friend,

How are you together with your lovely family?

With due respect to your person and much sincerity of purpose I wish
to write to you today for our mutual benefit in this investment
transaction,


I'm Mss Aisha Gaddafi presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia, I'm a
single Mother and a widow with three Children, I am the only
biological Daughter of the late Libyan President (Late Colonel
Muammar Gaddafi) I have an investment funds worth Twenty Seven
Million Five Hundred Thousand United State Dollars ($27.500.000.00 )
and i need an investment Manager/Partner and because of my Asylum
Status I will authorize you the ownership of the investment funds,
However I am interested in you for investment project assistance in
your country in any business that will give us a good profit or in
your company,may be from there, we can build a business relationship in the
nearest future.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds,

Your urgent reply will be appreciated if only you are interested in
this investment project,

Sorry if you received this letter in your spam, is due to our recent
connection/network error here in the country.


Best Regards,
Mss Aisha Gaddafi.
