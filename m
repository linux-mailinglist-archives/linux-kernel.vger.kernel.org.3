Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B946550DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiFTAdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiFTAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:33:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CACE63BF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:33:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o9so3706203edt.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=p55hH6T7clwukBPSZ47upp2dou3M8Dr1IzQrPoB8Ojc=;
        b=mnXowVFlBTFnWSpv+wGqVNCchh8iNhmOYYcpKx7nuwSWo4UAiMh/iGQW1qW4f3VA+V
         teOeBe/wYNC3r8E+vmHWZd16mxfWRDhwOsPYrYhfNIdUmXmwRy37TVUe0ho+NjvQATEm
         eOVvmsq3dpHkLyoxmZnFAWccS8iwsOov2jfb2Kn3NGpasbAyBb6lfeMSiaA8pAzfvFbd
         GPNjAg1IajpW0MCeokfOSspnqvRlewXFgo7o4xPpJxqlG6d+auSwd3/MqrVmMbI8Wi13
         HdYqleDSufOy0+DQfTCvODESRrCxM1y0k2UaYW6KtiTaLBZnl7hTXO5k9RClY6UnqEj/
         OO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=p55hH6T7clwukBPSZ47upp2dou3M8Dr1IzQrPoB8Ojc=;
        b=Dvs/j1OVsutBaWr0F94mOi3s5pfgpNd0ShtT4e1O6YW7FzsppVwHfyYFqSYCrn3RfP
         X8LTsaSAVeP6UEuMIIp+178fCjP0nibb8plWeuKiJbW5mUX2633LARIeQ6DEdNDssxLy
         ercgUDCGxYnovyxIm8TGhRxvdpUhX4+TqCcoLFI5DJue9DsBaUWyzeMSe7dVPgwGXCdv
         CzYIfkIuLk4FpT8W64+c59hmWJsQDT/R4U5if5kY/42osflcyqU9t6x6R7Szb+KdvgYN
         XphSUMjYsA/s7kI0nWU9QQl53eRpJFyOf1VYrIeujG4zpZwIMHoABzh7RyX8TKobbm8w
         MFKQ==
X-Gm-Message-State: AJIora+woCQrlGrLt9o5Tg87UKlyNQoUC8cOsaVjHKvAj8zDDcK4qkOb
        FrXhQrJjrWLNiITZp7W96qG3Fbdnehhk2tvKdeQ=
X-Google-Smtp-Source: AGRyM1tvpQ5pcnN3779tjkHcm8mIvijraBtqp6pq/PMEpHTDvQ0HnRfa/4pQhD8bAvbnFEeuUPgeWo+tJtjv/2q0JUU=
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id
 r7-20020a05640251c700b0042df4ea0c09mr25981451edd.319.1655685195713; Sun, 19
 Jun 2022 17:33:15 -0700 (PDT)
MIME-Version: 1.0
Sender: usmanyakabu49901@gmail.com
Received: by 2002:a54:3984:0:0:0:0:0 with HTTP; Sun, 19 Jun 2022 17:33:15
 -0700 (PDT)
From:   "Mr.Ajebor Tony" <ajebortony126@gmail.com>
Date:   Mon, 20 Jun 2022 00:33:15 +0000
X-Google-Sender-Auth: HSsQK0VVFhwDYX1IesaPOMeXVM4
Message-ID: <CAG1_V3fAcb92g3HiQ5fNgp4z_oFLAszWYQ3vvZbwzgqEhjuZnw@mail.gmail.com>
Subject: urgent respond
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [usmanyakabu49901[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [usmanyakabu49901[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.1 RISK_FREE No risk!
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,
How are you today with your family, Hope all is well? Please, It's my
great pleasure to contact you today. I am Mr.Ajebor Tony from
Burkina-Faso. Please, I want to transfer the sum of (US$20.5M) into
your bank account. This business is 100% risk free. Your share will be
50% while 50% for me. More details will be forwarded to you
immediately I receive your urgent response.

1) Your FullName.......................
2) Your Private Telephone No........
3) Your  Receiving Country............

Thank you for your anticipated co-operation.
Yours Sincerely,
Mr.Ajebor Tony
