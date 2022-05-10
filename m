Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264795211B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiEJKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiEJKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:09:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465E2AACF3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:05:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a21so19372169edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Qi36duAyE1gOy8psvq42cYXYElISnLMfmmvYA/hLUTKndbkzCBSXHHrwmO2vC4IXty
         mNLKeL8yTsRFqYz3GlewAQHpYkuBf6TkqndAkVrlj58Uswz5C6x68M90rzV8Rl/k0xBB
         XIUWLODiXpYDmeRbvvFYZWLUTwLjS9E4TGMKMi+0ubTH0bh0oSZu07ZzlUBO0cX70XZE
         xbASZkoJHfITt9mihYckrGw7gHP5RSU9mUM/TGEsCmYylLrM+63UCdIA3a3FX1KS5Gid
         cpzhTmO2HW8153KJNeOL7hueg183zv0r66E0NGtz9qmZYkARKuGLLabD8coaK+1+zmMC
         S6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=4GOGUgozyVFuGZuQ0zwYYN9sxcET86127bwBrHbGOI3/X6L1FMu2nGA1tE7pnbdsi7
         uoKmaOAz7qcs+ZdKO3kk6ijI35s4rOLL4Fi7EL42J4lAE5rvQTDHJYs0Js4LfALDy7dE
         3wpzqhkn5MnCQ0jF6IGGp2CkW08dPaoIb28BE4zDwpvkZ1JOWlOATihgUI1aKMSI7y4H
         mViinb0lXL5uKkrhP32C/xa1DftRK+XuswqceQcZy5cfR7Q6C/0jQR550klTAPOPU/aB
         2AUvNgTkhTvDaUFHteXLdPWfBluiKg02KmmFeZzPt4QOGv5Ds29MFXbP7QYTFilaR7Xr
         FqAg==
X-Gm-Message-State: AOAM530GusTYmIoOHdqGK5olCeh62oNAFQSFtg4GWH2SqoVUS6Q5ZgSU
        K5bb+wCWy2hVzPxxEcDuxqOykNLtn+qKGlGVqLQ=
X-Google-Smtp-Source: ABdhPJxkBG5oyHSAwqBnc8yNP9xdB3DAaj9s6SxBer/ptLcSgcCVTbrKi2AqoZIY1J0m8uxlWruVTbXulzDNS+ftVbY=
X-Received: by 2002:a05:6402:1d90:b0:425:dd36:447c with SMTP id
 dk16-20020a0564021d9000b00425dd36447cmr22402658edb.347.1652177124853; Tue, 10
 May 2022 03:05:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: www.ups.usa01@gmail.com
Received: by 2002:a17:906:1189:0:0:0:0 with HTTP; Tue, 10 May 2022 03:05:23
 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 10 May 2022 12:05:23 +0200
X-Google-Sender-Auth: ZjrciUjQFrD9BnHsS-hOeGEOKkA
Message-ID: <CABpS9gZAXj3bEbstv+AFUPZpSi+VxQK0hs=V_=9BhYaG1ERffw@mail.gmail.com>
Subject: I Need Your Assistance.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [www.ups.usa01[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zahirikeen2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
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
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
