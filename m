Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA119557E83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiFWPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiFWPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:19:02 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2803ED0F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:19:01 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e4so23727457ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=HWfdSuINNohtisnS2qVOe06xpDSp3T61e4mpFZzW/k8=;
        b=nRxAVrpc3/Vq1qoVFAiIfEF5HO7VLpUhiJSb/LfgMWH4zNoyFYqvO0/63FzUtW8vTS
         cF4Djjxwyy/h4MCJQxJUi1jXFvyxtT4mLnw0tSLAg7OBEOd5F/aJky8ZIDLwMnFAmNKd
         eXYcstlEI1ayqEWcyBKKlnHGYidt9zttzVuv2rRIRCVqftY246dAGOJEVoKZ6b5Du9e1
         s0bPZuw2w86XGKyr0oc7nLXn+IenGMl20az4zUlBkXk+/E/MJ9yVA3k2t+1CPRxwWH13
         5TMgcqJkjQQg/tCug6uCsJCu4ep3PAQkD4+S17JnuE2CPPsjPXYH/oV1SUJF80siYzBt
         QFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=HWfdSuINNohtisnS2qVOe06xpDSp3T61e4mpFZzW/k8=;
        b=CdnC+mceqoLC+78s7MmGu54/zTDlksOwYmjp/6RX4ZDU1rRWf3j1XUpwuvs2Pv7O/p
         JfC6gm/+yU7nm0zRHxSFpdmsLvQiwvPF9c7dm8s7XF7u8s25kYkRqJVMe4bhhKfzgJIS
         9rObh+OgUBGZ5dlaGKJ6quSUGZRnmHnRgAolts9KCrC8AwQ5474lRYtdIqJSjPUEeNxr
         aPeQ2CEhf+uZwZU479DR7z101aqRXN5QmYHSydt6Jkyr3Sww0cO3gn11KZ6RcM6QfD+i
         x7E2FcNcY9BDBcdOpCqPr7zYtCOBen3MXLr3E95faNz/D5LL0q5VTvrTnhNR1q7vzjAX
         YqPA==
X-Gm-Message-State: AJIora+lXvkDCIRU+FW/qVnCkj19aZ10yFcDOfW8FZgnorXe9Xf/Z5iA
        Bqlp1zFbSuAlfrMb+MP31EP/iSbf68k64fCFmvU=
X-Google-Smtp-Source: AGRyM1tSQ8cQBSiRwC3ikGNw47UCNApjrTwrJV0kvSxs7qqfgez8ePqK1ehrwenyoDQZjX4UoylhnQOzpKuxLJj7kWY=
X-Received: by 2002:a25:b00b:0:b0:664:2460:e244 with SMTP id
 q11-20020a25b00b000000b006642460e244mr9763380ybf.19.1655997541007; Thu, 23
 Jun 2022 08:19:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: miswendygeorge@protonmail.com
Sender: mrsgadafio@gmail.com
Received: by 2002:a05:7110:7108:b0:188:5d05:ae10 with HTTP; Thu, 23 Jun 2022
 08:19:00 -0700 (PDT)
From:   Miss Wendy George <misswendygeorge@gmail.com>
Date:   Thu, 23 Jun 2022 08:19:00 -0700
X-Google-Sender-Auth: URoz1V4cTYm5WBM0ABnFKwfvs_Q
Message-ID: <CAAPaySP3AuNwjNkwfvZ6vpEA=WREZ6qK+suM7OvL7LOGh-GvRQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MILLION_USD,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5011]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b42 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsgadafio[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am with tears and sorrow in my eyes, I know this message will come
to you as a surprised but permit me of my desire to go into business
relationship with you. My name is Miss Wendy George, 21 years old Girl
from South Sudan, My father and I escaped from our country to Burkina
Faso. At the heat of the civil war after losing my mother and two of
my senior brothers in the war.
I am here seeking for avenue to transfer my inheritance fund of
$15.5Million United State Dollar to your position,
This fund was deposited in Dubai United Arab Emirates but I am in
Africa at the moment. Where i and my father escape to because of the
heat of the war in my country I will be waiting to hear from you for
more explanation about this transfer thanks

Miss Wendy George
