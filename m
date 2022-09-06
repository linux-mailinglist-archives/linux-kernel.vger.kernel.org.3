Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C765AE90E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiIFNGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiIFNGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:06:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FBB1EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:06:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so23061679ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=cswpG9iwOTUnnU6xyH5R+5rqbDW1PNgJFzkzNTjZd9Y=;
        b=GJiwsr9cfX7q9h7p9Bc+5kKZQdgJVGvOmO+GWJBDKvsbY+zAq/Kem7Y4tFTzfYn77c
         Ghj/uvb9txvtXjxoRwon+XadJ+7S97HEha4GUBFIde5tstZ5kBjJpzeaZU5oEzBG661Q
         7SnCSUTOGa22uWW9LCIcWoLwGnr9Ti5BrTtUkC3EbcspY2zXtXPeGWlo0KfcUZ1R74V2
         AYP7UzCYpvfYKWsAv4XWozWnbfQFbvRI8qczmfekk0RswcrFV6iPlWNZmJE8SmGwAA+q
         4eFZOsocfUI5hj3vz5SgFGSlKEPYH7HYG1vlXtgkR8UFkSPVCBRrMcjhQDxUoPWlURjO
         3o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cswpG9iwOTUnnU6xyH5R+5rqbDW1PNgJFzkzNTjZd9Y=;
        b=ONgUjPq7Q+bv8VebRi2udUvs5yxpyCGYm1IecPfEEKPOWv1coykkYxhywWRig8f40P
         RjZkVObihSY2bxkzvd/XIT3zuzMFKtKo898PEjcWm8VQfJefQBUnkfKw2HkBH+k7bLjM
         lw3BrVQE87WhBoBSS0Q1aiMp2HKsfa5szDGxzheAvZPj8+jX3uyFJdeXXPjjc4RA73lQ
         trwfuvsm4O4iJVRq2rL2vOzi3JU79Lt288MnvUqwNWxVUPZ8xGUPTK+uLB8IngbFFQ20
         Hfl06lvkLex1V7x0x0ac7A5r+L/tSIhz+CucC+Hv5ZZZ3VjdtkXh8ueoW2RPu7hmW1zZ
         4x6g==
X-Gm-Message-State: ACgBeo2B8M3+DYL9bYdd9R/d+B0ipWqeeiB/q356UiRUAkhPT7fzt03G
        a/WmQ8kJ7ieE+JJcXdMTWCkS3UtPeLcwVfY8+4s=
X-Google-Smtp-Source: AA6agR4ZS1GyCwTDKilBaKzNEPCWTx3KRVMbAYgSl0t1RFUOkJ5of6EQ9OLmkfe9j2sUjzoxp9CLYwnNosOhlRsPXVg=
X-Received: by 2002:a17:906:68ce:b0:73d:ae1a:7803 with SMTP id
 y14-20020a17090668ce00b0073dae1a7803mr39305094ejr.618.1662469558908; Tue, 06
 Sep 2022 06:05:58 -0700 (PDT)
MIME-Version: 1.0
Sender: dhldeliveringcompany.bf@gmail.com
Received: by 2002:a54:388c:0:0:0:0:0 with HTTP; Tue, 6 Sep 2022 06:05:58 -0700 (PDT)
From:   Aisha Gaddafi <aishagaddafi6604@gmail.com>
Date:   Tue, 6 Sep 2022 13:05:58 +0000
X-Google-Sender-Auth: RlWOJ59AdGWVAMay4QvzII5XoYs
Message-ID: <CAGPv-0FOgkG3whiy8FN9osiBWKFD02jqaW9ZAV3zkFqoqA4aiA@mail.gmail.com>
Subject: Investment proposal,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dhldeliveringcompany.bf[at]gmail.com]
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

Hello Dear Friend,

With due respect to your person and much sincerity of purpose I wish
to write to you today for our mutual benefit in this investment
transaction.
I'm Mrs. Aisha. Al-Gaddafi, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia, I'm a
single Mother and a widow with three Children. I am the only
biological Daughter of the late Libyan President (Late. Colonel.
Muammar Gaddafi.). I have an investment funds worth Twenty Seven
Million Five Hundred Thousand United State Dollars ( $27.500.000.00)
and i need an investment Manager/Partner and because of my Asylum
Status I will authorize you the ownership of the investment funds,
However, I am interested in you for investment project assistance in
your country, may be from there, we can build a business relationship
in the nearest future.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds..

Your urgent reply will be appreciated if only you are interested in
this investment project..
Best Regards
Mrs. Aisha Muammar. Al-Gaddafi.
