Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57A56BA53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiGHNIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiGHNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:08:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389512736
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:08:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w1so303275qtv.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xHp6pFPauvUVGMaAi1JKSCFwXY5GCIPC+wlnxr52Wi8=;
        b=D9myR7Uh1CrtX6CWE5hONol/9tawcOMjqWZ7AvEt7tVqE2g3Hv2pmEKAJV70D+d3HT
         tcHuQuqAmyECj6T/O1mAwyQ/AZaCH9Mu3B/wjRI5Ljix0ctP7v7bXxgJkgt+CODgKdM7
         QQPjMIyay1SYkZbdCuNa0RY7FIYlaIGDuYe0OVo9s7tVor/384x7q2IFzMt8W7GYHbNP
         knPM6rmabTEgRtMU543qMW9GC6s2AFhLhLyL4xUekBRmLTimVyr4UBfZDSuh3j2ihJma
         bEWeh4xKmglvq2lWHaRFLJngU2QWNB9LMvsu2XGgibIu4D7u4ziAdY1xjy+di3+2Xl7U
         afJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xHp6pFPauvUVGMaAi1JKSCFwXY5GCIPC+wlnxr52Wi8=;
        b=PKumEUfc/svWYuhV/1AOPxQDDlloRvJ/ZO4s/aT+u+LTI/8bWog1CqML75zUzJQr13
         yk/jaz4PB1CQ8o6uLcXV3DuP3XCKMXnImp34h2wP14KJ2GiEIeGkfga6+ud4/goQc6tJ
         k6xaok7Pyiq26fQbWys0W/Pz1lrf49wYYzUIlxL1xoMXWNAHkI7ks0vrUtseAFw9eoj1
         1zkB3IjO9awhyPbcRgePHJ6pSLluXI9PK9imub+gqn1YTCCz0R2QmW2JxVZjjtwVPozs
         TUHS5gtFFsW6/AGX9HB4OKUEN1qx4a9JlVfgEKO9qQ6z/aiM68uCPigeoi1jbrPzaI1C
         chKg==
X-Gm-Message-State: AJIora/5JdcDsnXkQ3mc3L54sg1Hk68t67X50LIgV3n69VSHrH8Ckue/
        lq/2Inoi09XKHbosPcnjsKyVFCfNY/rJyfpjrXc=
X-Google-Smtp-Source: AGRyM1t9uuo5iv3j5IO6wQ650AW5YzATQNUJB1/PBQFzBaaexo38+kz1imWagFdHXbQsn2Igm3WXfyvpICax7XzY8lQ=
X-Received: by 2002:a0c:8ecc:0:b0:473:2fa4:df7c with SMTP id
 y12-20020a0c8ecc000000b004732fa4df7cmr2612436qvb.55.1657285706660; Fri, 08
 Jul 2022 06:08:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:1bce:0:0:0:0 with HTTP; Fri, 8 Jul 2022 06:08:26
 -0700 (PDT)
From:   "Frank Kliem Antiman[treat confidential]" <frankkleim@gmail.com>
Date:   Fri, 8 Jul 2022 06:08:26 -0700
Message-ID: <CAM45ac4daGjVwsz1sde3ZR+Lzb6e_eO9pBDBYuHXjc7APiyG6w@mail.gmail.com>
Subject: Mr. saLIF.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [frankkleim[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am Mr. Frank Salif Antiman, I am a banker. There is an immediate
opportunity of transferring  $9.3 Million out of our bank.  I would
like you to stand this chance that will yield both us great benefit.

I look forward to your earliest reply for the  details.

Thank you.
Salif.
