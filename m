Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020A504C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiDRGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiDRGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:24:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9318389
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:21:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e4so13931501oif.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=gT0qunonoqmQDH3Sx35AGkd9jYv/vMqV6NEmgNMh3r8=;
        b=CQWwoX1IxE8b+uF1gIBaZkweamlPS68OR7HgJzH9bHVUvSqZtyTLSitK8nZ/wkyxz0
         55gSUwA10DEE4uZ2Lsg6yfVtlhKIcRqv5iJVHujCsLLknoB3Frd2Q/C7pCFh54Fyry4T
         nixUVMj8/QRwIn/SoMgEIf8RiwgI6ETuE8qeiv17wSAUwW49MUVLgXcvplEKz8JZJ52r
         K0OXuR2zrmPaoskDeEFD3+vUC5JLqNChRL/sFlh2IJMlY2c+3SSxO6evmmLY0GtvN8w3
         RYXW+XzmyUrbZBpXv9ms8LLErA7AZzUWXzghnxtCUR+t8fZMKgK6FgpFgEdS2y13teTt
         GXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=gT0qunonoqmQDH3Sx35AGkd9jYv/vMqV6NEmgNMh3r8=;
        b=n3vW+I68TxipVc8cCbnQ9byUVNlggXDg9tFH1yp/TA6g64Nvc7GYa4gvLltOR2SIYe
         U/ZrtLWYNmoxQd++3xPSG65UI9Og9badBEsMB4twA3xig0EuUPTXTfuVNNV/CWfov2j0
         1PMW25zUA2X8U2lfAB0979PM2bWtNtwtLwsKqWJov90MWPlt53HP9WQmKMWdhbSZq3RA
         0yKRcsR3e9yRPEKXY6rzPcRYlJVBxKpyu7P3MhbO1L/7ALrtOvmEUAbztCSNQSH/21if
         TBmO9mgN2xr3cPm5HPoS7pMoHMl6jWil/2fVTsDRm6gQqrxhy265C9Dm+iUG3ix68TrD
         cWXw==
X-Gm-Message-State: AOAM5332tE85iZO3FS+aTOLA6/iT3H8bEIfby9BFcMKYahMS/fAG/AQn
        ysQWfeVRvOGUkr4b6HMuiMfoiSpKGmypY8708wY=
X-Google-Smtp-Source: ABdhPJyqxmX3/TuBoA+q6CDJ2Dkv2Lx64mMRNkmgkQDbwI5zR2zafXvlsrzhQQukU6210L8FdbpmiJDW1XIIaXB3iPM=
X-Received: by 2002:a05:6808:23d0:b0:322:781a:65f4 with SMTP id
 bq16-20020a05680823d000b00322781a65f4mr2584700oib.263.1650262899352; Sun, 17
 Apr 2022 23:21:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: nafi177z@hotmail.com
Sender: g.prosper001@gmail.com
Received: by 2002:a4a:978f:0:0:0:0:0 with HTTP; Sun, 17 Apr 2022 23:21:38
 -0700 (PDT)
From:   Ms Nafisa Zongo <msnafisazongo@gmail.com>
Date:   Sun, 17 Apr 2022 23:21:38 -0700
X-Google-Sender-Auth: LtRfpaxvzhc6LGYcxsGvVA4JLl0
Message-ID: <CAL_6emfx43_+FNkoQUoi0dC_kPHgGYeVawh5U+XBnQctvwVSvA@mail.gmail.com>
Subject: RE.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:233 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4727]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [g.prosper001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [msnafisazongo[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I seek for your partnership in a transaction business which you will
be communicated in details upon response.

Best regards
Ms. Nafisa.
