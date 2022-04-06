Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B544F5B14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbiDFKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbiDFKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:00:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD64B2CF6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:28:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t25so2315685lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uM+FGcsj8toEe5e+GV8hGulxG9f/x9ohvcn77yjffaQ=;
        b=nPnvk+gLWY4FreVLqy+JjDoLskmgD6AC2i+tUM8SSqrD0t4g8KpVCisAN/F0Ngp78P
         C3wfFX2kN2XQln/OPWeuer3Er4LpinEgiZ7b3EkOLSUEaaaUST/FJMlrmdU2Qbtscnm6
         AUtf6MNKJcojp7RJ0TKTe1Ze7wMT+2iME4uI8/Y5vYOUQJqSlPcL2xlhr5YkkymWDITz
         mUvqIgQbBhNM7380xfAlesgmXcE71NmqojhqbcYg+ivydZ+pIIHLPrasDB249IC8alv4
         WzyIuEHWNb5YPFWU9gYA9+YeUsQw/izBvmF5nLF6itvbe9EUP3X9OEuIU8mIGS16M19+
         wOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uM+FGcsj8toEe5e+GV8hGulxG9f/x9ohvcn77yjffaQ=;
        b=dmevTDuj6/AHahcPqKN44VQKWCmMbPnbbwced6e+SfMZjwyMfvW0Rg+MPxA04vCAKm
         DM5MCjdqCrkGZ/3IIAE8eOvLkerOG2KKKJ8GH2Cusw9R03tmbyPgTNJ8Rx8siPBfy1kp
         3mSzHsaVurXmZj35WtN8SDKWA5xFEvZsAUxU6W4ieR2l9AmdYrxlE04Qqak+9Dhp0d1W
         Dlrj9OjU0MRHIgPuR9PaDNWc17cdOV274yAHicOuappxVKmUyv9GB5f4zKYlEMiILQrV
         UyPI1nU5i58COHbgZ+bb6xQIv4Xt4ZPKiICRkVs9YLMPSYZCz3kmfustKq8lbusTee9m
         L6pw==
X-Gm-Message-State: AOAM533ElNVPg2ugHo7NEJ7ZNE59kAyWAactLSe5X15Rt02x3jEqfrV/
        WbLEHi9Xi/L5Yw+a61MvWja5kx82L+IBpRHHOeA=
X-Google-Smtp-Source: ABdhPJzUU/SL0qKM5eslmQcRxdbfxBcb80m040TrIz1gquC0yGV6AMT6CdF7XUX8ET6sRrlag45jueDAmFEfplN1RkE=
X-Received: by 2002:a05:6512:3089:b0:44a:8077:c197 with SMTP id
 z9-20020a056512308900b0044a8077c197mr5053293lfd.340.1649226526654; Tue, 05
 Apr 2022 23:28:46 -0700 (PDT)
MIME-Version: 1.0
Sender: rolandcarson343@gmail.com
Received: by 2002:a05:6520:3423:b0:1aa:e3a5:b818 with HTTP; Tue, 5 Apr 2022
 23:28:46 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Wed, 6 Apr 2022 07:28:46 +0100
X-Google-Sender-Auth: 95T4606RcNMbWKta9ETWfq2pZ58
Message-ID: <CAKa+mTvNa5-2rtPtdux-HHUeY0MFGUQ60Qxm4Bzyqfwin2RLjw@mail.gmail.com>
Subject: COMPENSATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,LOTTO_DEPT,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8103]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jimmymoore265[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rolandcarson343[at]gmail.com]
        *  0.5 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.7 LOTTO_DEPT Claims Department
        *  3.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$10.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with UN, IRS and IMF that your total fund worth $10.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have receive your Covid-19 Compensation total sum of $10.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email on:(
mustafa.ali@rahroco.com ) Your consent in this regard would be highly
appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary General United Nations
Office of Internal Oversight-UNIOS
UN making the world a better place
http://www.un.org/sg/
