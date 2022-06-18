Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C058550623
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiFRQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiFRQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:42:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBFD101D6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 09:42:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so5768690wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NTFM/4VkpDM2qI5OcPL5gWkEDJT/oSyHrioA8LlzOIU=;
        b=Y4QTo1plQ2N0ErlDd8u/c8W5nc/FlipwFRImoMWBlmOyHaRU0oH8YnnqEys+anTMuL
         8JL0x0mJy9b/q7sQnu7g/JCjr6055DNk96FpJ/PAmjTRKfQwB/JSSD+yN3c+WRtOLcd/
         k2r+Kmul2MWSFaTv9v2S3ZB3HEAArHb6M/uyOl74N1btvt1ykAzR7MbjP9z3qE4MPII9
         o8HHPPyoOvlBtW+hjGJByNuTZtD8IMz8kVUxSIiZzXnViiSH860Zl6m+zPLXxvO8hQyd
         0jpW9rkojAuGrWpSW6w9Leh17ZrwQUxcXuWsf4+C4a8MOSXXHrCAvmlqUMu4Z0RIdrOf
         CT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NTFM/4VkpDM2qI5OcPL5gWkEDJT/oSyHrioA8LlzOIU=;
        b=IRssbV8/PRNJ4C/mJFqf6hy8J4l6SBtx2Dfxu8HPOI/YiFQsy3iXYImpeyYg1R+Ayy
         OL3Rks7AxHAf96VtMTIVOPk09rR4c25kXCbfIxSRLof9F1fMEKa8TSUGj2y4/pRkjiv5
         Zkl3/UfAz8yhP3ehb8MvmYwvrdgrPf+9ZKA25bafW9JbTKFnJ6fXzFeo1VQ3pEqdfVoW
         R7q8T+KiLCINR6CuUJ4/JW2c0szHxZ9M02z5O3lw5u41ybnNhaaOO0oZXYNCKKP222cl
         7UD3DDW8ybXaUM6Dw0uSl68oQzeFUQFvOIAyLpF74F5xIdcgD35+W+cKrkGOlZ9eWcNF
         KHoA==
X-Gm-Message-State: AJIora/lJpPdfMF1/XwEv2TOAhqNicRIY2027k+Qq4vHMSKaxPgHky+c
        UPm84HiXdOQ8AOaj9Sx3fKuWkfrSsJ2JPtx0pYs=
X-Google-Smtp-Source: AGRyM1stQHvP/HnTb6LxtWIDpTxaD3mdATwE8K6XMxSGITVIjTemp99SDKby+zOPjbM1p7jWYsCTCNitPlJdjGRMCzY=
X-Received: by 2002:a05:600c:3b0d:b0:39c:4ee8:f7f4 with SMTP id
 m13-20020a05600c3b0d00b0039c4ee8f7f4mr16030054wms.129.1655570536644; Sat, 18
 Jun 2022 09:42:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64cd:0:0:0:0:0 with HTTP; Sat, 18 Jun 2022 09:42:16
 -0700 (PDT)
From:   nnani nawafo <nnadinawafo11@gmail.com>
Date:   Sat, 18 Jun 2022 16:42:16 +0000
Message-ID: <CAPhDfr1SFMnupMKnTYr9yQ+TB7bYfwv77CTPFNcPORKsabyMDQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=ADVANCE_FEE_3_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        MONEY_FORM,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:334 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nnadinawafo11[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nnadinawafo11[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.8 ADVANCE_FEE_3_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulations!

The United Nations has come into conclusion to endorse compensation
fund payment of six million us dollars ($ 6,000,000.00 ) to lucky
beneficiaries across the globe through the help of the newly elected
president due to covid-19 ( coronavirus ) that has cause economic melt
down in different countries and global hazard to so many lives.

 The United Nations has instructed the swiss world bank to release
compensation fund payment in collaboration with IBE bank in the United
Kingdom.

The payment will be issue into atm visa card and send it to lucky
beneficary who apply for it via IBE bank in United Kingdom through
diplomatic courier service company close to the beneficiary country.

This is the information United Kingdom management require to deliver
compensation fund payment to beneficiary country door step.

1. Your name:
2. Home address:
3. City:
4. Country:
5. Occupation:
6. Sex:
7. Marital status:
8. Age:
9. Passport / ID card/ Drivers lience
10.Phone number:
Contact our Agent email id:
name solomo brandy

EMIL ADDRESS (solomonbrandyfiveone@gmail.com ) for your payment without a delay,

Best Regard
Mrs Mary J Robertson.
