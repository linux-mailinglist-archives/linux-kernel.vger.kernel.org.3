Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B851DE64
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444227AbiEFRhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiEFRhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:37:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A311451E70
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 10:33:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so13800550lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=TrheegTAcQ3N+NlErxWYk+mECiW+V/jPorPK228U0NB5VOOYxEJuOyLczZt41CvZbG
         IiNhBzQfeGCKcl+tNvoWWW25ntMY6J040Z54jQwfj22fj28f+hnb+5eCFvRIPicjJANq
         ++uneqe3uownIq/LpZq6IOPZY/u+112vkrsblj4ZUg4XQWQsmRY4MFYRkwd1BgbJD03t
         P13nFbb0Rx8jqVT29GFyWl6L8YMTtFqN0Cg7eaT9zX5YPnRvJ6p5Stp/3TQQZWbLoLyh
         Ru9bsD9SLDq3AokXsHbkpIqVoRboZv9h86oOHkNbas5RuKQwnAUlESZnR/RmLBTESmq1
         YMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=UnkAPQtoZ1YmF+7WswQAOvdarSWFPF1cTpSQOzug16SC2yMNdkOkTioFuYdIi9REqf
         US8CORQZJaGZ1kOOwb8g48UI8QAeURTC0pbg8ISqbVnm1o3MACSCotJrVMZaFIEEKWDk
         LPp74oFnH8DmcFzdVGGP7HVOgUf5yFh59+gOV3oSFpwUZJbeFQT5lKtQTLYLWfBaVyq2
         4pAwLlNwUd/h0Qq4TQQl4OYlztN74QiZMvTAMl608WMfgKbGWzHJaHxwGnU0+K0ChWsu
         4gZhRxgHblDSBc3e4Zc8SkU1PvR8ldt4eUZUN85diJ1/vyMZrpj4K5I5FWrL15nje+1o
         Hinw==
X-Gm-Message-State: AOAM531cySMdgn9iY09ucMx4Lg0/BAvXwVzAQQbqWAE7qYYAXd2h/mko
        6LuOFLStIxxIDzqWQSp8tO9PRUknXbOGs1mcMSY=
X-Google-Smtp-Source: ABdhPJwb2di7DmbAynLcvVcyrDAwD/qAr+uJAQ3xu/EqJRNubI4tS8MU2FqNFTk6VjD7DhUy7tfCiVMELMhlHYcplTw=
X-Received: by 2002:a05:6512:25ab:b0:472:6041:d39b with SMTP id
 bf43-20020a05651225ab00b004726041d39bmr3138581lfb.40.1651858416009; Fri, 06
 May 2022 10:33:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6591:0:0:0:0:0 with HTTP; Fri, 6 May 2022 10:33:35 -0700 (PDT)
Reply-To: richardbowles844@gmail.com
From:   richard bowles <zamba19999@gmail.com>
Date:   Fri, 6 May 2022 17:33:35 +0000
Message-ID: <CAMsQSZm5jt4TYBmSDxrVQKQ9cC6s9V0XFjg2jBsoZOYjbEub4Q@mail.gmail.com>
Subject: My name is Richard Bowles; I am a partner at Friedman LLP, in Toronto
 Canada, I am contacting you because of my deceased client who died leaving
 Payable on Death (POD) Life insurance valued at the sum of ($11,550,300.00) I
 want to announce you as an heir/beneficiary to the policy since both of you
 are bearing similar surnames, For more details please contact me via: Your
 earliest response to this matter would be highly appreciated. Richard Bowles Partner
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zamba19999[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardbowles844[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [zamba19999[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.3 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


