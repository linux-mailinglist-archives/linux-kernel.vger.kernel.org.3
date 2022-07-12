Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825F57136A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiGLHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGLHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:49:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AE9A69E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:49:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a15so6947976pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Eg1+5w2XabtQw6S7czM65cLqkc9eYr8NiitBRfdqEOuXbCgneGUaAWsP948s8IDc9u
         lqCoMZWrL0L4lpfowBfNnkC6eDXEfGSh3KcAYKaOa8euLkg8gmwQkM8kXq1wvnFAVuap
         WxuB2ZWcvXQTm7XrubGgSDMwXuajEkyi2aHaU2fJI6zU6rCvctm+JdfyS2AA2aWc/BNm
         wv48O0da1AKJP9tRbTwls74dUdI92Vb8gSOcaluc9xMxb0MX+AOMMIg6JA4JIRLDlffk
         HWVq5MV0kWv0hVCM7ia5i3U1mYWy4aV4T+SJz3aynvj0IKeYv5mVkfTWNVSGhMbIGxLI
         Kbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=76DeRt7jVmb/3fA7HDwrVfHogHo2W3x6zrspH/m8NHvLWT7aUeiK65nHnDFJSCZlES
         oyVBe1mnie/mDDrqX+OpY+sjl0bfdyI/18fxbyV25GsgBv3ZuSZH3+ETKTWMYMlK3BaC
         oetdQxDyWrFTYYSoeMIVcziK9skERIOJWZKweF8ALFSHulE6d1/R0IX7pqVrCOPg5OA2
         PSqBSjoluJgUD85F0qVZfekFBq132kyToFkKa6hBPB8SwPj5VdT6qdRSvuFhB1QI3R1U
         bFHqA9qMPgUe6KnQpG05GC2WmjlZce2EcCJwLSu2uqzaf3DKzhCLuVD0nl2yMz2nNYeF
         zEFg==
X-Gm-Message-State: AJIora8al+bQsrsaVKn5kYkxV2u14nEQes1w9hVbT3wbEq6/mSbgMhzy
        V0NGazYn04vjeYeeI4NeLEQM4UrJmkY1yMWRjvQ=
X-Google-Smtp-Source: AGRyM1ubNpTvTjUWIm2GqdHKmfNUG2OsMcRgItUdQ1fJbV+PdWAIw4m9O/973hLMNAwSKchgstU0GxlRb9gjDPV4G+s=
X-Received: by 2002:a17:90a:aa82:b0:1f0:33ff:d08a with SMTP id
 l2-20020a17090aaa8200b001f033ffd08amr2695565pjq.245.1657612158064; Tue, 12
 Jul 2022 00:49:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:98e:b0:518:33d3:a7a8 with HTTP; Tue, 12 Jul 2022
 00:49:17 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <tracywilliam26@gmail.com>
Date:   Tue, 12 Jul 2022 00:49:17 -0700
Message-ID: <CAKhG-81bE5Fdv8z=pJdSpp7-a+Yhf+rYTgb=7TDYyjL7ckqe2g@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracywilliam26[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracywilliam26[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
