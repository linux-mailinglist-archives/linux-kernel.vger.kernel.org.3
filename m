Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48A4FB274
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbiDKDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiDKDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:45:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22940377CE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:43:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x200so1513891ybe.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=GZhe697/HvKmHr7ntqH6OYJuaAm1dy3g/Lk5HgBeAfU=;
        b=Bf/3uRC3a/bwx7+tbSpefoY+6oNTuPpCsIxV6Bwif5c8tX/I8S/ILWgLF7UBGxV538
         18wHEmmH89kh93o1ZkWITXkGmn/r3I6xzKvS1cC1k7Fj9DdT1mXdrA9OpIFaG6QyKck9
         ytc4eA3+QIMwx1Jv2vQ1znBL4Sl2uLQJifDcBM6TujeqGqlJwVeyFUN4/MplC8k7ed9Y
         Edq0H+BV1hFz2GeUs1SN77yMjN6Qo1WygPGPFPMOG/lssc9oIM2e3ZjpXdjemLMHiXi0
         dqaUVh+r3aIb7griJdJdmEJ3DJf8LqWDHsJ8jw2ZioyuGiiGiDGmK1RcMB+qtc4VjsN3
         O/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=GZhe697/HvKmHr7ntqH6OYJuaAm1dy3g/Lk5HgBeAfU=;
        b=cpdms5giavrkOtZxkpZCpPno/nUAbymkNfZ4V6PVbBHeUzFdiAMVpoJkRfQX5xN1fG
         RhlFrFj5/+Kb13tBnR/l+OkSqlYrh3AzyNpHGyfVkCpP+XT+ns9nsKBOcmDohKmTkHc4
         dMD8wfXgbfGp1iYdU0pkHBueNu+uoJKwrr8LOv885YprbXPu1KtTR154x7fsvn3DCKNJ
         jGUtpX7YfbbTGu26uW63zLBvGOF4etZwlbjdyw+JCBYyITCGuiYG7Qw39v+D//RyTJSL
         kMnQ1/4hPZz3Lb9h2TcjuccILWSmWLgS88uUez7YMa+RbDJ97xHZQo3/xtGO0wieibp3
         WREg==
X-Gm-Message-State: AOAM532kUQYv98sdepRhenOe1cWljflMBkpeg7bgTU5t4aO0S72n0uu2
        va/rU57lG7HPv7oiQ5OqUcmTNqf3csdeaxJ/1fo=
X-Google-Smtp-Source: ABdhPJyfGV0aJA4dugz4g4/Z0qE0ZrJBR68iSXF5sM/hq9xTmxNuCEsp8kwO27IUeCdkDIyRf7UyQpZmzatXjfGIFf8=
X-Received: by 2002:a25:2e02:0:b0:641:3772:6f7a with SMTP id
 u2-20020a252e02000000b0064137726f7amr4012597ybu.526.1649648593229; Sun, 10
 Apr 2022 20:43:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:ad9a:0:0:0:0 with HTTP; Sun, 10 Apr 2022 20:43:12
 -0700 (PDT)
Reply-To: ahmednasserkhalifa001@gmail.com
From:   Nasser <wernermrthomas@gmail.com>
Date:   Mon, 11 Apr 2022 04:43:12 +0100
Message-ID: <CAB58LbXZksOFOrZCL+g5Rm0XSMeN_yENZSZVur9U_g5xSiZ-Qg@mail.gmail.com>
Subject: Hello sir
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wernermrthomas[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ahmednasserkhalifa001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
My name is Ahmed Sultan Al-Suwaidi from United Arab Emirates, i want us to
be partners in business.

What did you think?

Best regards,

Ahmed.
