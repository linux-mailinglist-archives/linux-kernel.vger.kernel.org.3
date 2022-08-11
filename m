Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D884E590607
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiHKRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiHKRkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:40:47 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401109D103
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:40:36 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e127so29326574yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=s28WbfE0GMUuXVEkO0uMcSlYqpulGrxWW0lzIC7Mlvo=;
        b=TuYl+oG7k/mw0m7CtPn5t34M4D7v3x0Syz+ye20Q9DuwoLWsj+J4kD/KURFwMRznwr
         ZGsHmtJPJEwxRZnv8yFarkkUtNtZHiRJNU+XWcG9UKPUdPaMKgSMgbHgTfAoFcvhJwAr
         f27/TJfqKDz1qPmw5zUYyR6Z/PwooWAXS+uI1Poygm5bGNZca+/cq+k5lLmXRBldBjyO
         JIvp8CYNJN4nlndHBGbudvMd7o4ytVLKPth2uOGedGNQwrCRaZfzkKpGsi0vuWmARJhV
         nRTJKeL/4DsWWyoIuQUoQdWwJUSgXy5/vHoJBr7B2+Um2RG6aX5DsnGENRwgXAl2/tXx
         QRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=s28WbfE0GMUuXVEkO0uMcSlYqpulGrxWW0lzIC7Mlvo=;
        b=Yb1PGttUrPDTRl/8VvVvzHU7RAiA3S7Y/vgHHKrKdFV6E/rpvNpAnx0h2efqj2sdn0
         /qY8MgYlHAfuzL6QSPKtmaTKxlXvpJVGU3ADRPSmhrlC9g3liN7d2jsV1BU2wcW1/Ioz
         uRiLMmFG3+jwXI0HWFaXTmj0FB4tVdKZHCsnqCxk2p7pBMCxPYUuMkOt6MbqkFPDIyjk
         OZ9dR35RMoQgM5mjx5S76lytCluLe5ju3uNlkZ9+AqQon82Baq8Rd4AUyFfL4oa5vQXv
         wACtpHYsF+CrUPFwNXvvPCDnxzqx8xmb61fwbUcqAxi0rM05siZ5KDDgfseVK2E0WPNy
         4YRg==
X-Gm-Message-State: ACgBeo20L098rOc33tVH1jasog74NveTRgJs6904JA38r4QnyDL3NtEl
        mok1TaY/rTMUfTTln9UwF3nGSC1WWukDMHGsgWQ=
X-Google-Smtp-Source: AA6agR7V/N2Rd8tUVIGeR+K3zSRaphXMZFQVGLjM9UalAj6bSYoRdjs4aaktqQRvbyDu+gYGj/HchtHNrFEGi6EMWfw=
X-Received: by 2002:a25:289:0:b0:67a:85ac:dfa7 with SMTP id
 131-20020a250289000000b0067a85acdfa7mr361810ybc.25.1660239634542; Thu, 11 Aug
 2022 10:40:34 -0700 (PDT)
MIME-Version: 1.0
Sender: congoibrahimsambo@gmail.com
Received: by 2002:a05:7110:b096:b0:18f:ca59:4eb9 with HTTP; Thu, 11 Aug 2022
 10:40:33 -0700 (PDT)
From:   marilyn carlsen <marilyncarlsen008@gmail.com>
Date:   Thu, 11 Aug 2022 19:40:33 +0200
X-Google-Sender-Auth: uJpEonpz22q5o6lkGojH-FSllTs
Message-ID: <CALC73VUPsQ=dN3ysk7vms27vs98DOAJwLfxdVenVs5tbdmAwEg@mail.gmail.com>
Subject: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5012]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [congoibrahimsambo[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Marilyn Carlson, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 Million Dollars) through I decided handover the money
in my account to you for help of the orphanage homes and the needy
once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs, Marilyn Carlson
