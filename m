Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E1529E46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiEQJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbiEQJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:41:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC090403CE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:41:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id fu47so13889164qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=DVa8huQTtD9H6MhwPAeCvKZaQGQNO+ImVqUTVhbFLhNTdrYx9EQaHaE7j4LoAJMcYa
         3F18jFbjHgZnhcd6Qbq03eyfoDZGOKXJRHIeZosGDccMxtyzCApxel6THt2B6ngX5vXr
         XYMwQ3XHDtyazNqiVxNTf9U2sT2cVNEWJ+naD695DX4juUcO/EEYS5lg3vSSBkW0sf32
         n7LtK2tcbHP4mYmbX83IGwvUwpTy+mvQ9UTIrJ4fbvH/yVnzZXQLVi2HIanVgSUTWa4w
         1vHEZEGKlJcgtI5QEGjMRwumGcN+66KIc6ojpkq0JJgEnFbERnPwDUvKg3HwDgkizhU3
         BTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=cQXZjyQvQyDzBw8m1RUbI/H+REtKvSgJolopBvSmT3RpLYq7iAlPi/jE3poSiI+RKL
         1/vIiK4imDwq0R5HE7MrCfsHAKDBJBFUJt9mEavfxD5h3gEnjP7npakOXd83rXMpDLzc
         pUfQzuo72dWtO2hl8mObuBBQyj3ELXzAZ89Tg1ifHP1LX2JfZgA5We2rPRJ8pHjD75PU
         o//ra1ESIgekoVOqQAj/00/yYrEvTVEwJDJBNwxFfAXSN9GimHURMwSqB29p18uzyUb9
         +UzRQUL0YWiU5s5zJpWzz5XrJbP+TI30Twb9t38VelHouon9G+ikcwmHhpPd44R+rPFX
         1DRQ==
X-Gm-Message-State: AOAM533Z31E5URZ1FUplxM1Kq6/g1GCKPkqN0zBkSPGw66xA2Ukm7Btn
        HaRoE/WjORUkue4sZoxY1kD+KT9UuKyDvXo9+a4=
X-Google-Smtp-Source: ABdhPJzcXdPqSBS6pwH8pXt8721Zrcj9dXMf77AEDVCR4XSQ2cgNqTR7yGiIgxc2avWSraijhz48W3/rKmy/n3IkrNI=
X-Received: by 2002:ac8:5886:0:b0:2f3:c574:811b with SMTP id
 t6-20020ac85886000000b002f3c574811bmr18939383qta.26.1652780493015; Tue, 17
 May 2022 02:41:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:c4a:0:0:0:0 with HTTP; Tue, 17 May 2022 02:41:32
 -0700 (PDT)
Reply-To: peterwhite202101@gmail.com
From:   Peter White <kkmanana125@gmail.com>
Date:   Tue, 17 May 2022 09:41:32 +0000
Message-ID: <CAKd6CoB=SnpEtmauX_0PBe3r14OB8GGZ_2APR81McSALe9mcBw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:835 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4984]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kkmanana125[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kkmanana125[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [peterwhite202101[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from here.

I want to know if this email address is still valid to write to you.
There is something important I would like to discuss with you.

Thank you

Mr. Peter White
