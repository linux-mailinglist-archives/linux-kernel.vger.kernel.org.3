Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF60543A60
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiFHR1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiFHR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:27:03 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E584AE0E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:24:53 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-30ec2aa3b6cso216144447b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=t0OPJRsXm340DuEWYA6niGSgI4EU80tAiKfqxKYuLpU=;
        b=GIwdSPabpFie4+mzWvF9NAAZEFKlIC3DWBeSyIUbxU3TqzMyW928jPoTimAPgnx0q0
         /qYkUSclGMtQyz2lVoSIkMN5yCYPMZ8luzZPLW5rOMMv/IQO6FT19uEeOEBTtBLJVXV6
         EyBs9/WmxNeL+0rQ89PAqAqpxuX0MK/y+5PKM71Nqq07oSGdYDcp+g+N8B2kOdtoAJlN
         SoIvwLOBGTB//h+6J7w7SbfJTkdvMp1yaxLY+f313qtvMzTiUn4Gdd2Fxdbg6NtzMyVl
         3qsO1sJI+H7OCW8qyfaXzmr7P/j2TvKlX3S1iNE8TmIXtbtAqTuADitazsRmXUgiPaZh
         7ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=t0OPJRsXm340DuEWYA6niGSgI4EU80tAiKfqxKYuLpU=;
        b=Bx4gR/sD7QKj92xHJ/GsQhovuzVG/PvrCC/5zJe1p9nfPd6jdXCQykKlmEq7X4x+wL
         RmEwSLiVua75Seltx0O9D1nxQpFey3DeLmX5F1X/iiA6nAQTrljE5H7so4H+c1Tvjbra
         jDrk7usY2xov3bg2m0ynrPciqQoOFmAW9ebLrq6rAK75jGPRI1CxVJuwPutX8HSj4mAa
         e4BDmhXiVssisvft3zmEWpUkOidktfvuslBtr7GYNhSHre1UUdGA6lr+MQu8RmOM86OI
         DvA++YQeE1AwcAN67wJbmFtayqFqmYn3kau3v4e/A28qJsbsJPUnrZOf2ueOX7vVGWXg
         SlKQ==
X-Gm-Message-State: AOAM531jZlJ2Ol5rO9wdEuBi+MT50ft0ZBeBGBw6mMMpai/4cA2wq2Sq
        KsZ716+oVZigxjKz8eq9/bNdMMOUIxvn5Q6wNULG4gfc0/wEb+Hd
X-Google-Smtp-Source: ABdhPJwmDCHiJNQHq3Dw73vV0bSKp+mt56+nz1QDRGIRANE26Fo8nuXI0q59Yw/ou9mkrFt2cRc9Mb4rWMNpuG5V4xc=
X-Received: by 2002:a81:3d09:0:b0:313:6a95:d84a with SMTP id
 k9-20020a813d09000000b003136a95d84amr4392790ywa.277.1654709092677; Wed, 08
 Jun 2022 10:24:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7843:0:0:0:0 with HTTP; Wed, 8 Jun 2022 10:24:52
 -0700 (PDT)
Reply-To: Giannini_Amadeo@hotmail.com
From:   Bank of America <equityloan050@gmail.com>
Date:   Wed, 8 Jun 2022 10:24:52 -0700
Message-ID: <CAC57QhhxMer+fA12AXXV5q_S_xu-wKJXfANU92XRrh_T0Y4nwQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5242]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [equityloan050[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [equityloan050[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello, do you need a loan? How much is the loan money? And the
duration period? Contact Amadeo Giannini, the loan director of Bank of
America a Private Money Lender and a corporate finance for real estate
and any kinds of business financing. I also offer Loans to
individuals, Firms and corporate bodies at 3% interest rate per annual
and 0.5% interest rate monthly base, loan terms determinant.
INFORMATION NEEDED ARE: Full Name: Location: Age: Sex: Country:
Contact Phone numbers: Amount Needed/Duration:

Best regards,
Amadeo Giannini
Bank of America
Website: www.bankofamerica.com
