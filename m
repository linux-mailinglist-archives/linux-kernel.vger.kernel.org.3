Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A752B92B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiERLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiERLxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:53:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505E3616B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:53:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b7so1758194vsq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=qOGmMpU6cQSpl/71fyCpHtzhIfiFKIUXW9dc0ENItMw=;
        b=RP3kANNyorhW73/KV+owDdtw/DjiROVQuuaKdDh2Z96/XU8cAN1cbBzoclT61ZKKRu
         LHVpJKFMFeQ5W2kTLxrsOYliL1vxPj0qMVfnoZ+3KvLS9M+hJiiv6KTEOcTHpHoctGCc
         CyRy/j40dQw3q1gef1rshc92kkyJPgocY/F8mTqeowvlPbUjJR0Ip2YkvvFK/figMiq2
         oAUkhvV26Sc+YJcyVWnTezQ0T2UvfpbWC61B3E9MUbAsfYgzbX7KD85hoSQ3V87apAR+
         hW6vjHou0lI4LKm0EIVufx0cI0t0sdqmR1gq+giS4AILm0LTejO8x5a+8/pcs41u7lyD
         FN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=qOGmMpU6cQSpl/71fyCpHtzhIfiFKIUXW9dc0ENItMw=;
        b=tZ/rD5wLG7vsEZNdsy7NzloxM/9Fd1wCysJ+1YmECzlXAqdlihpSYXvEBNtzruGoO1
         N6Zt9CBXxj42eLYAXw6vtuV95TlmovqPJ0RcrikLb/e6mNnxAXGbyRh/J3x0geQEcPmR
         q75EWFgCcZzYbPhbvVHo75/bwvhZ2BIyaigQ1Yi0/mXnfM6+Zw93ZS238inAwJLTq7RE
         u1gMIMK+wh0aGf/Q7Tii5rrwla+3itrgs89cZCUY/RCGzn5TB+M6knoU43muxKy2w5IN
         Uof+nY8VEcz9EW5gxNPMs1XgbmMTEkB7Ej0tW3Mdt5UwAF6luT+zz4hp5wgTJLlbwtMg
         P7IQ==
X-Gm-Message-State: AOAM533nsI366O7yzJBU++xjJEHxqnOi4FsJaUWl6nJR7Ie53bVkno0W
        vVqMrP+vtksmT5DOMT2jJYMOPXlveWQscgtv2i4=
X-Google-Smtp-Source: ABdhPJzE7QvU7h8WJTlXrKDpfo3ZoOuKk5tE4+9Egz+MeMbMUgjYnd+y4Ll5FeDFKSbJQ9ciO2lfKtHOhDCBtxg4sg0=
X-Received: by 2002:a67:b746:0:b0:32d:690c:5714 with SMTP id
 l6-20020a67b746000000b0032d690c5714mr10745300vsh.78.1652874817219; Wed, 18
 May 2022 04:53:37 -0700 (PDT)
MIME-Version: 1.0
Sender: gulzarpathan01@gmail.com
Received: by 2002:a59:cde7:0:b0:28c:ce4f:42c0 with HTTP; Wed, 18 May 2022
 04:53:36 -0700 (PDT)
From:   Mrs Aisha Gaddafi <mrsaishaay798@gmail.com>
Date:   Wed, 18 May 2022 07:53:36 -0400
X-Google-Sender-Auth: zbD-73ft-hYfZVtvxzn14Km6Z8o
Message-ID: <CADx28CAhGaOcw4u2GQyryqiTJchKmKjFmD8pVMYkmRQqzdZNow@mail.gmail.com>
Subject: Assalamu Alaikum
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5763]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsaishaay798[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gulzarpathan01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend

I have investment fund worth $57,500 million dollars deposited in the
bank which i want to entrust on you for investment project in your
country or your company. as i am under political asylum protection and
as a refugee in a foreign land together with my 3 Children i am not
allowed to have a direct access to this investment fund to handle this
project myself therefore I need mutual respect, trust, honesty,
transparency, adequate support and assistance, Hope to hear from you
for more details.

Warmest regards
Mrs Aisha Gaddafi
