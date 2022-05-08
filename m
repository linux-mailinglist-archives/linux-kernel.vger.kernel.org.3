Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AFA51EAC6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 03:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387793AbiEHB3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 21:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387670AbiEHB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 21:29:36 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79876FD30
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 18:25:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c125so11891820iof.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PF1cKI3J2qY+qkEQ0Qx4QViHD+lV1w45Vz4SVngpaDg=;
        b=H5UMdFSjSDPFzq4IFPTbZHF37Y7Jp9CWLlxexXs7wTAg0dncBSEEvUzIxdjSfTnBP3
         H89imRBhH6YN7VoThhs0lKg1XA1pVd5a4lCmR4Kq7BwlVEGhgo23am079DuWskMoVtIv
         W+FC7inpgljyWB6fup4I6TeWV3XDWhRNAR8jpjUB6v+U9HIB5cx60PgMh2Dkr12ZJFjD
         ka8F5NB70yycoHqNtqwU8tUK/NcZ5x0JXw++FZr0jCKVXqBmoQ5KEsVo+Rfr7/iYacGb
         EJnFLcWvf0M4twSNt5gTdpF3CiwuDVYoKxMuN+42cZvHU58A5Fmhxwaz6Glo3sKGVfAm
         xKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PF1cKI3J2qY+qkEQ0Qx4QViHD+lV1w45Vz4SVngpaDg=;
        b=o0hjhbwcifWURmievmXbJ6nXvl5JbiCsRYWrRkfOcQ3UidjXJygbdN3VcKdFUHVPEb
         pcx8f5lehupQzyeHFBjoNT9RlNE0iM1z6gmmPo8ZFIaZ/2NqshmtJmeqHneCUdlcrLjG
         fASXO5+8MQdodmXbPR8cjcxlSxQmfgdT9O2w1Mlz+iWhpNKCQYE6nYNnZu83IGxLC7uY
         xOjGjB20wPSHSFO9Uw4yYSDKbVCk9BJdW4iqs3RbUDOLIFgJJinMDs7GYIUEd+yWHnBK
         ke1sXyJvItFNdGZzC4x89Cl9yp3Mcf48MP4XUivwr8cPZewuvyAF45xCCEbGJ6klLzL9
         Fgcg==
X-Gm-Message-State: AOAM530Oy/efXupZhhMm7+y+ZWFBt8p50b9cvi7N9lrXaqmhvYHrIMMN
        nAtulAGo8YQoanOYJwlS7VE1TYgEm/r9NcpIL8k=
X-Google-Smtp-Source: ABdhPJxRG4+Y8gq2y29o4C4YauJDtnxmX5RQsHY0AeI0im1CeRjnKSaWihgNH8JGv+Vf+X/VzAvb4UWXLgcVombC7GU=
X-Received: by 2002:a6b:3ec1:0:b0:65a:499f:23a4 with SMTP id
 l184-20020a6b3ec1000000b0065a499f23a4mr3977948ioa.189.1651973147740; Sat, 07
 May 2022 18:25:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:5af:0:0:0:0 with HTTP; Sat, 7 May 2022 18:25:46
 -0700 (PDT)
Reply-To: fundsrecoverycommittee@aol.com
From:   Geoffrey Bristol - FUNDS RECOVERY COMMITTEE 
        <macarthuremmy@gmail.com>
Date:   Sat, 7 May 2022 18:25:46 -0700
Message-ID: <CA+v+5815=PEKbrycVHx5Ow=VioWhWo4ETTi_2d3XGS1WZFq6dg@mail.gmail.com>
Subject: COMPENSATION PROGRAM
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [macarthuremmy[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TO WHOM IT MAY CONCERN

This message is from the Office of Funds Recovery Committee, a Panel
set up by the United Nations in conjunction with the European
Union,International Monetary Fund and World Bank to look into and
compensate accordingly all victims of internet fraud/scam.
In a recent report of a thorough research conducted over a period of
10 years,part of the findings was that about 30% of such victims
commit suicide after losing thousands/millions of their hard earned
monies in the hands of these evil perpetrators of online scam/fraud.
It will interest you to know that we are doing our best to ensure that
these culprits are brought to justice and prosecuted accordingly. More
than 10,000 of these scammers/fraudsters have been arrested in various
countries recently and huge sums of money recovered from them.
These internet fraudsters actually confessed to their crimes.
Against this background,we have been mandated to compensate each
scammed victims of these fraudsters with the sum of $500,000.00USD
only.
Be informed that your name and details were found in our list as one
of the victims. This is the reason why we contacted you through our
agent to compensate you for your loss.
You are therefore advised to get back to us as soon as you receive
this message so that we can commence with the immediate process of
releasing this $500,000.00USD to you without delay. Be informed that
your name is in the first batch list to receive $500,000.00 this week
as compensation.
Any kind of delay from you will not be tolerated as we shall quickly
move to the next batch if you fail to respond on or before 48hours of
receiving this message. We will assume that you are not interested in
receiving this compensation offer.

Regards.

Geoffrey Bristol(Chairman)
FUNDS RECOVERY COMMITTEE.
