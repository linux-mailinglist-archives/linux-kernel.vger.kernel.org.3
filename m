Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D04B0B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiBJK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:58:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiBJK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:58:55 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193FFDB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:58:57 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so5893439oot.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=OwBatjmwFCUa5noa+GRU5Nqf9iv/ckA7ZR+G7okpn7Y=;
        b=h67cAoVo0UFM1wB1SHGZelIYQKwVcCf+GecCds/6ZSWDNebKcbWapPtZ7/VyVYsMld
         Oq0hBU7SoWTqStny8I9Pv7rsGDm/hL0ZsFxzTKRd6Qh7+BntOxBH2fp3hKo0FsoDAK04
         mHC3kld0G7rngC1exZCy82m/7AjTWsuHB2GwN8ZaR9i9YeKaj7CC8Y38CKEg0rpKR8os
         14OvyxXtzWYhJ9S1xsX1CPoPwRaBMV4TAnvqS4z96F36+P6qYfgtLMbqvIN8A5jakiJA
         WP3+Lc8hLDfS2h9AMfHtmbmQylgfRcmreIS09Wa6UIAfVhjJylFany9z7HyVVKUmQwgt
         d+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=OwBatjmwFCUa5noa+GRU5Nqf9iv/ckA7ZR+G7okpn7Y=;
        b=jq6AMfoLl/2nRrbPkRedOyqLJELTXN3OtVpbUiM+1E+fYAnZHm+2RSJvlxnmLt8hHJ
         Nx4P0lRDiOp+HU1hV/lVpPTmGLapMWyJKHkXy4/mHvNDQtL+agwJhFh7ZHiTIrcbiMSu
         Oug4Sf31tXIOXCejn0F/OdYAoGJcMz6Oz1wvt0zmmNXgiCjDcENjq32wmbylkR7hHhWN
         ajMB/jIjFXr3EGNhc06VisvUcEW7TuwdeYTaXXao4Fc4psNvCpUq1YCt6PrcDt6jzCtY
         OxV7oymhuS/4cZ2uBNGu/lnb7Ke0ysfceGMT6AweP7FdaLM4dk17SmjMuyBcqcjUvLXr
         vPeA==
X-Gm-Message-State: AOAM530qBKTGGEj9hbCTstV7GF3RZogiGw4lFeM2A5JcMU67+UcgvrHh
        ZbxqYD88TlFjnGVv4tSYVg7Vpbeemdxkpnwsas0=
X-Received: by 2002:a05:6870:3813:: with SMTP id y19mt650092oal.282.1644490736733;
 Thu, 10 Feb 2022 02:58:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:3d81:0:0:0:0:0 with HTTP; Thu, 10 Feb 2022 02:58:56
 -0800 (PST)
Reply-To: lisamuna2001@gmail.com
In-Reply-To: <CAA4TxLBOZAmo8bsVkBievLF+ma++aHi7z3Fbmv1077BHjdGuag@mail.gmail.com>
References: <CAA4TxLCHpFpN+2O=A=7kHbwx1ZL4o4mSufYPkVu358txGicrqA@mail.gmail.com>
 <CAA4TxLAE6JtNxReLAYpiLtAcp_nW7oaFORhz2zGaRHkHokfAuQ@mail.gmail.com>
 <CAA4TxLCd+1XMZNs10YB8-=FdgwjEHvdzKK=9Qcb15LKQ9h-gJQ@mail.gmail.com>
 <CAA4TxLBgHs5-KDLjkv6LN+YY6YequHpntuxb5-8+pYvC_ZY2+Q@mail.gmail.com>
 <CAA4TxLAB3b6ObDYM8bia+Fx-azuy0-G7Gfunai3FrmM1T5oRmw@mail.gmail.com>
 <CAA4TxLDfY-Zk71-fi1Hhx9H41nEzVojrY-KP2QxX7xxBBx70ag@mail.gmail.com>
 <CAA4TxLAeZfZ7ZMwN6KvRaDf1U2tcyLMJ3p2SJ9+TW0E5vMLFww@mail.gmail.com> <CAA4TxLBOZAmo8bsVkBievLF+ma++aHi7z3Fbmv1077BHjdGuag@mail.gmail.com>
From:   lisa muna <kristengriest098@gmail.com>
Date:   Thu, 10 Feb 2022 11:58:56 +0100
Message-ID: <CAA4TxLBx=P25CdC7Fco_k2fBD+94F+NAfQtw+VB6Bf6Y7xORbw@mail.gmail.com>
Subject: good morning
Cc:     lisamuna2001@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MISSING_HEADERS,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kristengriest098[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kristengriest098[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisamuna2001[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I'm happy to inform you that i finally succeeded in getting the funds
transferred under the cooperation of a new partner from India,
Presently I'm in India, for investment projects with my own share of
the money and also on charity work to the less privileges and the
orphanages. Meanwhile i didn't forget your past efforts to assist me.

After your inability to cooperate I found a new partner who helped in
getting those funds transferred for charity work , please use this
share of the money for your self and also invest some on charity work
in your country.

So i left a Visa Card of $850,000.00 US Dollars for you as
compensation for your past effort. Contact my office manager and give
her your complete address so she can send you the Visa Card through
Courier Delivery Logistics

Her Name is Miss . Lisa Muna

Email: lisamuna2001@gmail.com

NOTE; The Visa Card is an international Visa Card and you can cash it
in any ATM machine in your Country.

Regards
