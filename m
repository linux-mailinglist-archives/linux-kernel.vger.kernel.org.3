Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E104E83CD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiCZTis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCZTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:38:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F114476A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:37:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq24so2628185lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=jwAFMoLBu0V5RIuTnqA/IzbNiW5S9qpDdaftcAWTpYA=;
        b=oJTosz73HyzKEmFanUJOFt/iJ6LZC5xnmN7eRPlsBWWRSrNtw7PStUB8Rm417qCbbD
         IsLHjURso3SXLyWdsZ+hC1pEcVXHfdxv/Jyvx1oMTnyOdTbgedptlb5RsqGRhGtWuqd5
         VZaDlmQHVekS3qXrJdI0MiP/RQXQ6nNO/hb56Nyf03ncxzbCMrRF89xJYKOeaRI0EVK5
         ch9eA07qpV7T4puzoIV+zyaWrBVCHsD3gbU1QUdgVDrQuKAgiEtr25NvSKCJnU+Og1zo
         nJI1wBSx4QsMIvqRDRM+NUO+kYMOoCEn+h/s6+Pk3exMx0Iorib12Z+0WLUsrFK/YUJq
         hu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=jwAFMoLBu0V5RIuTnqA/IzbNiW5S9qpDdaftcAWTpYA=;
        b=14P1Sd9D/b8DBHkItCbq/xtZIVecknMTMGECil7k4xJDc9L1MTNGRxxPxoHl6pTNY/
         xD2jcDmZb4Y/ocUjJYwa//9deN8aZxPEdFiC/0IxyarIDBjoQSagf7SsCD4aUHuqegem
         8xDWls9fFvyP+2Pit9XdmpW/gR+Lc0oBzeUZ9z2S3+/Rc6UjLL8jVTW/QZG+MOSsIgrH
         YgqurcxycSrzKjdkq76I43E7QT54rKeZWRCuzvLIa3aK6ccRS22idSr1ZhkCJV0bXTrt
         qVm0K+NEKWZBuVA0Sp1y8vO1FaIO06rlTyol6I5vaGIsM2Y/2ucRlNshM/3q/e0E1bne
         ESzg==
X-Gm-Message-State: AOAM530I6iH7MXB31IFcr8NTT0u/Y+E9l0E1jSd/TfmIUqyZUhc52WMA
        FVUt31xZ28ti0JlAcE8iWjU6vY2ojF2CWs0A9dg=
X-Google-Smtp-Source: ABdhPJyuhDsSjVE86dk45OOR4nHEGvZD7Qn5LIOAWD/g0y8AtEU3Vjwm/LAGH6im3Sm5tcm9gLrnZYlBSDZL6ZRM7zU=
X-Received: by 2002:a05:6512:b13:b0:44a:14a4:efb2 with SMTP id
 w19-20020a0565120b1300b0044a14a4efb2mr12936898lfu.570.1648323427751; Sat, 26
 Mar 2022 12:37:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:13a1:0:0:0:0 with HTTP; Sat, 26 Mar 2022 12:37:07
 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <drtracywills5011@gmail.com>
Date:   Sat, 26 Mar 2022 12:37:07 -0700
Message-ID: <CAHhC4aoneey5EbvF=HzTqkMM-wSNffAUz5zECuk1PkrW-MV2dg@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3801]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drtracywills5011[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed3[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drtracywills5011[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
how are you doing.
My name is Dr Ava Smith. I am english and french national.
I hope you consider my friend request and consider me worthy to be your friend.
I will share pictures and more details when i get your response.
Thanks
Ava
