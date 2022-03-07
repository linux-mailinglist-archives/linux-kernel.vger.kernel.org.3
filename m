Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808454D00A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiCGOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiCGOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:05:21 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873E580C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:04:27 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id yy13so23327659ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kvhZrpHBK0kPy/iKTd/Hcailtj+KjaeLTS+rPhszZPs=;
        b=XelXQGMZ9koAvPqEJcZYr66OpmZAWUy1bhDVzr24QQGycjL9psG50v7ZQaRLy01uaM
         3q0hJyJpqCcYwBRcTPih/9KLwTRWECK+XMT2UPcnIY71LaZjZ6C0+ByWyJnTmGGHhYtW
         z9ej01VuV4tmxACYDxHJI3MG4n8Gxi/NwPdjB/bCgYqNg/F6SDNe10rPKRIAITgaaemI
         Vx1In97kkn4wnJDLnd5t6IrXNuz5e5lHY06TBfOdQZ2BiFpPbLmW9+0ctmjWMk8WbLmY
         t24EtVECrB6+lvWShVMYsK7EGULoZ5IypJ0Udwm6ClmxoVjSPxcOuSEj9i92UHS9wbHH
         6hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kvhZrpHBK0kPy/iKTd/Hcailtj+KjaeLTS+rPhszZPs=;
        b=PExobiedIWC0H0sKWrFcfRRPgiuAVTYgOePuOH16zampakORSapIi8wIFwLnJvbpuO
         IaXeTjONmr1DfNvEpaKpS36nts+xdsqucRQ9pvB3y85//P6I9XFBK0Fw8wRoRxYt3Ma5
         zJwDOYw6pwnI9DoUnWE03ENcHLaLFrvYFRdxXvZxHpO0Xj3eBI1CZeODRSULxBBiP73I
         hYmr1UATfWoFtNc+dMPgTR2KOG7BFAPN7BFu1bLurXw1wqj+l6hK9mpJp7mqAT2o20mD
         3YgrCrcT6UgdvK7QtXpMXFg+/Zj0FcfiYbIYrsKyJfd7Kx87cz1FUl3z9ycSVBZtyJWt
         FrhQ==
X-Gm-Message-State: AOAM532RB0QyTAg/ig3EmSRfDS/4aEeQXFrvfqOcnmrfGQYYqFnxqwbm
        uFIUJ1NTw7KWO5EP4cyLqXKbLM1kAnMt/BV5xgs=
X-Google-Smtp-Source: ABdhPJx1xS9Y+AOq5EO7SQYJfoPU6k1gph3GkIeYrgAvcH02pmrfZT1Scb1R4q3jG7zeissawY4L0BOnyGt8CqMYZSA=
X-Received: by 2002:a17:907:91c8:b0:6d6:e98f:8342 with SMTP id
 h8-20020a17090791c800b006d6e98f8342mr9175043ejz.590.1646661866040; Mon, 07
 Mar 2022 06:04:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:cb:0:0:0:0 with HTTP; Mon, 7 Mar 2022 06:04:25
 -0800 (PST)
Reply-To: mrsnesara@gmail.com
From:   "Mrs.Noah Emily Sara" <matatajeol1@gmail.com>
Date:   Mon, 7 Mar 2022 06:04:25 -0800
Message-ID: <CANkx+YZ4V2FUKbA1wZMggzMz9DP0iVWAxy3tvS7d-Hd9-Tj4Ag@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [matatajeol1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [matatajeol1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
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

My names are Mrs.Noah Emily Sara I'm from Alberta Canada but stay here
in the Bradford United Kingdom. There is something

very important I want to discuss with you.

I'm a very influential and wealthy woman but I'm sick and dying. I'm
suffering from severe oesophageal cancer and have a few months to
live. I send you this message because I want to make a donation to you
for charity purposes. I would like to donate funds for charity and
investment purposes to you.

Get back to me so I can send you more details about my donation.

Warm Regards,
Mrs.Noah Emily Sara
