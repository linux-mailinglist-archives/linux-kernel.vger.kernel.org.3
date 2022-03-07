Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA94CF188
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiCGGDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCGGDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:03:51 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4C340C1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 22:02:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g26so28786401ybj.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 22:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=c1bDG9VxRM0GGNj757DrmXHfFRpAS5nkQXMs+Oj4aPTCkzXBOFbj1k5qasjuP7b7w1
         npZK8ypTFGHQkM192ZbB3h70SclmR/FmMnE+o2NAlsAka1vqxjsPQeWInjwcch4TWwgd
         4QVOYWL8dQqZPl+i4iCJaqArfPnnv+jExWbuY3eVqEjcJc1aSHg3Lcx3lIOQXDek7wFm
         t7MzZLz82GBobHT7mDif3bTdRhxbaDoNrhirZ+qnUTn6EuqEMnP6dAqdpJ1F4dkR6Svp
         iHP0XtJsVxroeHH+7LQk43FT7RNNVvr+5ATFXMTuMadcULQyJpXd23Q2U4Bv/EiS3fq5
         idng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=4RUC6Fcf7Id46ciVkHM2pziGlnhSIu9o9Oe8REowg/5WdOXWXc8xfUv0Xx5yvzOesa
         W3wCJxXpco+VQPQRu1kPsLs62vYDbQdvluHh/ZObGKusFFxqaplD8c2laIAGmou+xkqy
         UALH5nv96CAJwDZcdk7CBL/lEvLv4qY/1xISdWdAjnZ/qdHA+AA+QEjKt2rd54kqdMw1
         OrOeU2suLvK/D18y+dmeHWDtzB6ZIapkI0EZ5Pi8L64TkncYVjqtbqvuXg/kp6fncUb4
         ZtaC3/B1aqi8vX6a/z1CfDOfg3jtAWvhkACuYSumLCcNPcBqb83JVz7TMhQiDuRqpaPd
         86rQ==
X-Gm-Message-State: AOAM531NP1IsOL8yxCFLofo/kOZMGTq1ZmxjdKHGTtg+mvrcSx4w6bAY
        XlJcoyYYj9vIzMiD/sIpZXNSTZokrb/vc4yp0xw=
X-Google-Smtp-Source: ABdhPJyAe5UnFIIefjeCQ7lyCJoaXg9dQlqs5YWp+6bozjLqI+f6cKyL2Z06ocEcRIxz94VzK8QoOBCTKjhmSTrR4+c=
X-Received: by 2002:a25:dfd3:0:b0:629:24ff:eab0 with SMTP id
 w202-20020a25dfd3000000b0062924ffeab0mr5097816ybg.613.1646632976811; Sun, 06
 Mar 2022 22:02:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:b986:b0:a4:b698:78d9 with HTTP; Sun, 6 Mar 2022
 22:02:56 -0800 (PST)
Reply-To: markwillima00@gmail.com
From:   Mark <markpeterdavid@gmail.com>
Date:   Sun, 6 Mar 2022 22:02:56 -0800
Message-ID: <CAC_St2-sdO6bqD=Ek0iLO-xK1-wW3yNcMoWDU3W-5iJ1Rf4Gsg@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [markpeterdavid[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

Hello,
Good day,

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
