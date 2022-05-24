Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0053250F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiEXIOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiEXIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:14:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF377F02
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:14:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so8610121plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=z+v8ugHyK4Bi1bsAOtuex5rzJWIULuLfF++ZnJg6JJs=;
        b=o4KrMLngwTh2UKMFJQnBgaSqgdiffu0Ryx9845/2218AEVhG8SkbhUU/pW/9GhRJrA
         2q50u2f5tC7ykvn//69bpEWu90sZebxUNdAA7n+5UAIcnP/Mw+hUnFIx7LgnITqrvAD3
         nZCWG+GqW3Al3DfCwMTlNPKDCfJVLprVGd3KPU1InyxriJTjul3dx3Gm3WtdrwA6aMsl
         I8WhuayqzvAZQADk4+t00WETaYgFv6tj9Cwr2fqC/3X0D/4VKTQrnbfya2UOwtB5Y40m
         G9ELCVRD0ZnxkbJadPIR+PJDLtmhKj6x3kEOaL5G2TnE03WU/PBlAta7vBCth/eS85f7
         t6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=z+v8ugHyK4Bi1bsAOtuex5rzJWIULuLfF++ZnJg6JJs=;
        b=kXox3WYV3gEh5mli9CJm53dyMg6wJnOTLJeCk0X/ZcYoEUTEYbmfaffw740YZ3E6P/
         s1zUBdGXyeD5aLQ/hG2bP0n2GsjoFOkqLdiNhhfIMfyy/Ug26JSqdkECa7kmTwyrvwxq
         rGGRZB7CTujLdNBt2NlsZvidhdjeRKg0dPOACGw1KZKTVJScev6iQSuhuEFYTPHtcRje
         1x+gvzOcqV3V4N/PME9jdf+/k0YT4k3EpZKSiUC5VA68P/x5URyGyk94yY7U2X0NeRDF
         KnCE6NB6fMd0ITu+Y/Yu7kU+Rs5XmQBhtHi2Vb5lrU8JraW09px/yT0R82mP8BGdlnrv
         ifug==
X-Gm-Message-State: AOAM532pkWotKqYpF/MfM5RDZGY8AOMK877LXbFdirM7fgf4esVCKgId
        dJ1E07tamqTLeUQmLuYW1lIXH2Q5IsMEM1vsWFU=
X-Google-Smtp-Source: ABdhPJw6R9gqrbAItY8SZ/Yo/VMelZFNRdlGZQwab00SSMXRC/8JBk6Z7HdM/8XK8D3FHm70jr45C8MX6TQ9S9Gvfrk=
X-Received: by 2002:a17:902:d2c8:b0:161:bc97:2805 with SMTP id
 n8-20020a170902d2c800b00161bc972805mr27252636plc.4.1653380077159; Tue, 24 May
 2022 01:14:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:689:b0:3e:198:30cb with HTTP; Tue, 24 May 2022
 01:14:35 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <jameswilliams0j@gmail.com>
Date:   Tue, 24 May 2022 01:14:35 -0700
Message-ID: <CAGpaBj70tCeoJRFraKtOci=rxeZWc9h-TqZ9B-De0tpq-7-OFg@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jameswilliams0j[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
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
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
