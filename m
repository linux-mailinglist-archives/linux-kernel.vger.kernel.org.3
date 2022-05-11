Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910A6523453
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiEKNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiEKNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:35:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059118AABF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:35:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so1271715wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=z+v8ugHyK4Bi1bsAOtuex5rzJWIULuLfF++ZnJg6JJs=;
        b=EiovOijJTfMGCDuQtWNCS1HpJgAxVqR2PIvEbaZOd5BziJLxDQEhhEILPhNK1voNVT
         Uo/XjJj3xg9ppiyYsBeTMomVohXZvQJ1mPboz2xT+5/6q3RB6I5ItqoEGOl6dkeSl9gc
         PZtaHWGCA6tSvenQqfIIjwPtfOm2CxvcXJSdY6e3MxANNs0h6gKjz+3WHLSXi4gHA6d3
         Iyvwo4QclMvLvGnkaQbCP5nsGvv/igF3b+p2DzLTv3IphSUdwZomACtU3N5Tm+ak2nW0
         iQsAAQfScXra+6YmvtXB0KQ2W1HRfJsYpHy6ubPlUrAuQUheAe3VvJeEwgnO4qnxFfyj
         5uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=z+v8ugHyK4Bi1bsAOtuex5rzJWIULuLfF++ZnJg6JJs=;
        b=TaxQ+k9M365knDwpKu2sQAh21J2IBSrHZZ38mLrUeWKjD3lZ7mbHTP4ps0iVaNQLzs
         pF38zDGvz+C4sa02q5y+EgabhEotPf/K8Vd2zblvMWlhvs+8t0scxFSIIjjzuuch5/Bo
         SIjrVYQ6IIMx8R+a23iWrNs9xatPErOw18sByJDV0Tb7jd0Y+ZZdkNX5JMrfW8y6yscv
         /+vSk7ByJ7rqHiW+fcgZolxUthwC0FcxEgUyJW/8+skZXD+fc0k2tUxZmq7MA7NG25ca
         Ftsy0LuWipQjH6zepL+StcsxlaIfbRgCGa/zLe65CzSRPe9xrvOQIf46SEjSMalb79px
         yS7Q==
X-Gm-Message-State: AOAM533ktbiisZvnPt5tT8wP4HUFJZ94iwWP6a4oKMLgBwqsIh7rWSlm
        lSCD6uQXteNfFKj4pfP3uywumKCebcQVdHSGviw=
X-Google-Smtp-Source: ABdhPJxRRwu3KrrmYUBcS0KHUsRkHooGZIeeoSQRkB8cVpHiVr+thYoWj9phEIvhxGBJ806mI1lIO9i41bOkyZWAnN8=
X-Received: by 2002:a05:600c:3b98:b0:394:6a82:8d59 with SMTP id
 n24-20020a05600c3b9800b003946a828d59mr4953903wms.126.1652276120679; Wed, 11
 May 2022 06:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:600c:4ed1:0:0:0:0 with HTTP; Wed, 11 May 2022 06:35:20
 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <stellamilojica@gmail.com>
Date:   Wed, 11 May 2022 06:35:20 -0700
Message-ID: <CAEoCe3+qaZb5Kw5pR=15UzgMcnbiLQ5GqiPj2RQfLehxDndtCA@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [stellamilojica[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
