Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63FC530D64
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiEWJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiEWJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:17:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3FA46B38
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:17:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so1762089wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=fknSi264o7qBFU+mKXKs+ULl0PGJ9Uk3UVmgUcwT3vA=;
        b=pbXg9nP7DjuQymyNn9qeqRfneBjGDtgMzq8HJoy9FbokrozhBRThzvAE2KP1nNu1RL
         yIanglxcT2JBY1BAz5KjCOlJ05eTtAL1ES0fzFz2vwoj19XQrApxFnvaWn5eDu8rZIaX
         OmeyiIs6BetOMpsm/JPqk9h3MSXbFLwPdcWPNRwkEtMw0+YT7XxeVcTj3z7yRIynhhRO
         oKv3LGU7/d8aEeN8yexHtz3fXqd7OYE6u2IHPJ3bK8PaztyUjZQJmuDH/aenyL1dMcGR
         TyvaxBGwowbaOERqI4o2Yzt10xUeJakqZJCdld0h1kQ2GAJV6r+aquKvHzy4/vHX7Thd
         /t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=fknSi264o7qBFU+mKXKs+ULl0PGJ9Uk3UVmgUcwT3vA=;
        b=0DtEpObSgG1bwlrlyaKYU1r/9yFcHKxJRZ30MG/380qGhPB2oBKLYD/s2lQtHU7WLR
         5284Ou1S8ksHxOVI5hh468/g3Nq5++PHjJWlRxddpWygi6h0epDVNvgxd/bV/7LsSSHj
         lB7f2tt72JwL6OPrG2eLAu8NNC6kD7hxs1cV+5owL1Q459e6v/S3Kljx8bbeGZOxG8dx
         RUrsATGS6FuTz2B5G745/E1nGddlrVIY/0yp1mc37hpA2htgq/41ocGFYdyH+GaFX0np
         857cBg0kK/c7udUl66eUtmkW7wZ9kGfY54I5tPKfKIWA/xEuylMwxotQJWeCes/y8QLf
         4CPQ==
X-Gm-Message-State: AOAM532AIMocHY7JbNvesNDIfT3erhtqt/YFu15t5raZAp/bvP4omQhn
        f7KaMorm3UXIifflW3Q1Xzfsj1SwrMXBtnOrb20=
X-Google-Smtp-Source: ABdhPJyVKItccXJydqetCJd5u6J4JdyYPhgczv+pV/+FeWcIo/CTBC4ssuuO36m6h0benwOZDQQlDxgbdHj8DGU4r8Q=
X-Received: by 2002:adf:f183:0:b0:20d:a92:f244 with SMTP id
 h3-20020adff183000000b0020d0a92f244mr18287994wro.431.1653297444679; Mon, 23
 May 2022 02:17:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: 2091y00000@gmail.com
Sender: irishcamilleharringto2014@gmail.com
Received: by 2002:adf:ef03:0:0:0:0:0 with HTTP; Mon, 23 May 2022 02:17:23
 -0700 (PDT)
From:   john white Robert <2091ya00000@gmail.com>
Date:   Mon, 23 May 2022 12:17:23 +0300
X-Google-Sender-Auth: 6cNPltnBiw8JEfIeI6--CM4jJQs
Message-ID: <CAAgT-U0_tL1fqSCBk4_r=LLh6HJWErX_EYUmpAgakj2h6UxS3A@mail.gmail.com>
Subject: Please get back to me urgently
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:433 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5036]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [2091y00000[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [2091ya00000[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [irishcamilleharringto2014[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you doing today,
I'm capt john white Robert of the US Army currently serving in  Syria,
I need your urgent attention for a very serious cash deal that will
definitely change our lives for good.
Do get back to me ASAP for further details if you're willing and
interested to know about it

Best Regards
capt john white Robert
