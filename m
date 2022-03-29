Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3774EB1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiC2QlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiC2QlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:41:23 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39506BF52D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:39 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-d39f741ba0so19289495fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=spxARUmNqGBlTZgd9n5I/xQFjZ1S50ykihdmpQqLJ80=;
        b=qbdXN4gFG/HW6C0G4SH/3lIc4W8Zg3K2guGDf11oW3U4jq12llMcTu7uKN6OQZGa4J
         3xSh01VN46HQC13R+eyycpwR1Z8O0lpG/FOvux733CUxjedjbmdrhMKuHXQSs8XE/PkY
         yKF73fVrkOyg7oTO5AGbHunILDG9GgkBROIlBrTHjMYaMlV5U7krri9TRE+ITBkI/rvW
         5Qh91LIu5MitEW7u7RWho3fajiTLTZyZMfb+iDmt/YSbpoB7AlTi2RT+a6i9gHk3BZb5
         x0FrNSimnnhrVK/3ErVb/OT48z62Nzrw87L+JXVgVGR2KtItN0bAcBqB2sV5BdaOKX2X
         jnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=spxARUmNqGBlTZgd9n5I/xQFjZ1S50ykihdmpQqLJ80=;
        b=gJ0WPbmG1IChmeF7LbrpIjFYuwx7ckDAEHGuAopE1IVHPayxg7IbiPuGZmAbsDzOzA
         E19z6JC6jbuDqaQfzcv5KXUcGAj6q3Lp0Fi7UjIupsKCO62tUaYZi1i0q9yGfTSuUD4i
         Db4eA9MM7Z/SwTTzcyS2k8mT8E0zizOrnrD/uQkmz0h6aR6yJylwR9RT10hBESdr4Uve
         NUNtmu0yMUOPkOHopxqSlHE2VbCiNTVwrdPN/ys6Uyr+5LYMAx7g0m2i4mCU5b8MpDqg
         XcXEtPDTXzCyM9swNXdeL27oFW+BlF3a0cIHXsLl/3TN3cSESIDHEVG5ZqxuCVLEm5gV
         mYyw==
X-Gm-Message-State: AOAM530E5L745Yce/3jNpfsgJR+hkjumwRxOE4Ym9buBop6x3MQWdKut
        +jDi80cI1CoWDpWqGpMYm+T2HJkv9dxC23U44hs=
X-Google-Smtp-Source: ABdhPJy2tymOa8H6PWZ2a0uD4q1S3pAcU3NgzmomXXdplDIjcDwGlnNKKfKicrRdjjMzVQwucjrfZQKvhsvGEn25vhg=
X-Received: by 2002:a05:6870:f292:b0:de:d5d2:573e with SMTP id
 u18-20020a056870f29200b000ded5d2573emr4126oap.73.1648571978529; Tue, 29 Mar
 2022 09:39:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:a293:0:0:0:0 with HTTP; Tue, 29 Mar 2022 09:39:38
 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <antonio36336@gmail.com>
Date:   Wed, 30 Mar 2022 00:39:38 +0800
Message-ID: <CAB3YzctdfqFQ4ukF0UvHn5vmwRZBVfBKwOxp7LYqpwnUE+bCBg@mail.gmail.com>
Subject: Greetings from Netherlands
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [antonio36336[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [antonio36336[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands
Greetings from Netherlands

RGI Genealogical Investigators particularize in probate research to reveal
missing capital, inherited estate around the globe. We can also help you
find wills, retrieve/secure copies of certificates.

Recently a woman from the Rothschild family, one of the famous families
contacted our firm that we should contact a business minded person who is
capable of establishing her capital in a lucrative sector.

Our professional co-operation is 2% of the capital and we will be settled
after you receive the capital. The capital transfer process should take
just a matter of days as we have the mechanism and expertise to get this
done quickly.

Please if you find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr. J.T Wood, CEO
RGI Genealogical.
