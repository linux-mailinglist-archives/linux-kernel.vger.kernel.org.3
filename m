Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3C4EBAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbiC3GW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiC3GWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:22:21 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF132054
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:20:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id f3so16129193qvz.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=eY1NvClZjMu/3uc4kGek7ozzl4hMb0taRg0LWFRwfmA=;
        b=o1wrwfYYRRM3S0c2pW3pDEIUKBPg5iHET9vaT4XFNIUhCiDGugas77WjK1imIeMn20
         fEspPlUIB0Ka3yja89R84aSxuuJgHEBcKRN0TPfpVkHq9v7d5l6E+UpjWjJn9h2XPSqz
         77h1R01H/vN391DIaeJ57YHZje9ppw1dmfpuxzLNqa7xk9MV7AKntmGZzHtRXqqjjPYA
         aH0ENLsZ5+aPdQesqRetlByW0N0we0SnknHPTafP/8tDNfZfLAp/J+xjB6pNZ06wFogs
         K3XXXvcIkLEywB1UiiXmRP+qHv0/ybpK3gNrkStlWipKbhQnkSNt5YC3nM6qcfvkFk8S
         kxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eY1NvClZjMu/3uc4kGek7ozzl4hMb0taRg0LWFRwfmA=;
        b=FkxxJ2khg2rhsK2CAHckVwe38NeE4wJnk2+gi6JMwqgr2g22fSXfS6S11FGr8ETCbl
         qs9Tq/oSaQgUSeeXHnuaHt7IZyejcXC46QFRoMPLk40s2gW9uwOuGeql2rXnNYb4lELB
         rMyOw+GNOu7gluvVJXvriT1nfw8hR5IELasLt16H0TsqKsFVP6yGlzAGFeZxmFAfMsfu
         CD2rhUgeyt2zbMd94yg3kAz0miIov0wcHQhURoZCPjGsmEYoUp/DeCvOTy1+FBZJ9+FP
         YZQCK1b3snixY5EcNEdsRacKkKrPUmm9w0W7TGOKluyCHJ10pKSpxNSJlWPlTUXCaBwE
         EjEA==
X-Gm-Message-State: AOAM531Nfk5r5q4z+Z+HqdE/zouulAErcTh/EtEjyv1qqmh0BQD8Chpf
        oERSGBvydJNfiA9toiOb6/e3OAWon/lR0rMmGAQ=
X-Google-Smtp-Source: ABdhPJwkdeWZyOOJ8EloKUXhTKoGctyT8JMYfxN11DgWo/dq4ZXuduC9u9FuBy46Pe+6rEzrioGV0UoD+TC8KZt+XJU=
X-Received: by 2002:a05:6214:1c8f:b0:443:8505:14b3 with SMTP id
 ib15-20020a0562141c8f00b00443850514b3mr1771852qvb.7.1648621235394; Tue, 29
 Mar 2022 23:20:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:21ad:0:0:0:0 with HTTP; Tue, 29 Mar 2022 23:20:34
 -0700 (PDT)
From:   Kevin James <kj825686@gmail.com>
Date:   Tue, 29 Mar 2022 23:20:34 -0700
Message-ID: <CAC-84Ry=EqRfRLtHoo+Us0eF_qkSsSTptE0+7_NiVHyFCCSPZg@mail.gmail.com>
Subject: Attn E-mail Address Owner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_SCAM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kj825686[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kj825686[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.4 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Attn E-mail Address Owner,

Email: westernwesternunion293@gmail.com


We have concluded to effect your own payment through Western Union
Money Transfer, $5000 daily until the total sum of your compensation
fund is transferred to you.

https://www.westernunion.com/global-service/track-transfer

MTCN#::8267439026

Amount Programmed: $5000

You are advised to get back to the contact person trough the email
below for more direction on how to be receiving your payment

Contact person: . . Dr. Eng. Bright Sam
Email: westernwesternunion293@gmail.com

Thanks,
