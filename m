Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A29551F615
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiEIHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiEIHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:46:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E191CC9BC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:42:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso5618780wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=u33bLPRdxARRGRPezs6qQuUbqXt0FX2OnInzgW6/Vb8=;
        b=kyPihqDNRV/DVSHyohJ9tqDwrLHzu0J/ExQsfme6xXmb3HuH36CuJvdpsJGju9FL6L
         A/nuJL8qt6ViTOJ2jOjSjQQn3RgVLOGuNnLrIKP70q1PF3E47ZbA8evm4rLAYgnxni/3
         Z6l+O0hYnTRMaT1nY2F1leC92xZi9xACSG9RA05Pi/AKzKNl4mqcffVldwaEUE/1/c+9
         5PdPxJAKOp6dpKmeo+Su3wLvP+Cf/2/6OmFWvoTFROMxaN33YveO0CSQz0W6hs4rqH6X
         6/XTPsws1BWj+g/ycbh39H2o/0dAQFdZJg6kfvR7GgHyoZmzn1n2P3zzFv9O8usiVCUf
         BJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=u33bLPRdxARRGRPezs6qQuUbqXt0FX2OnInzgW6/Vb8=;
        b=H/RnUDBfKOe/N7+qdRqEZHoRsgweYzumkzgtqk52qVzqTn9eFA2G9+dM6UNKOKmfw1
         Q5/zlKN71tUYISAK8lgjWNbTzL5r0mVuCl7HTcHLGq1O6h0S5uLzp9PP8E8hp0TZT3uV
         IkPsP3omOztMCMUlg3NER1TfNWne5Ox1CxRqjmYoFjXmZePalTs3Ld9B2oxLRRg8uurs
         GZUijmwZ8+niKFPbYBuBkTjp/k4BN4WO/WjP3rfgEIu9mw6mD66O3sLAbHBNW2KZCxUO
         RK4pa3d3DQAU5iz6sbmuvXpmUqfiSErXGEl/3dSN0zatE9jFlv8wfkhBxxEjcrVOAhGy
         ee/Q==
X-Gm-Message-State: AOAM531OU/6fmLxWya5wfIGBDWFdKfeJg+MGH5hUSRR8ntfyiZNOMUBn
        uNu0wNZ6cdVFcHnw29j+TLMvlz4Jrkq20HpMVzo=
X-Google-Smtp-Source: ABdhPJxUPbWw9pzav3szPWSRMtg6h1Fm9wrro00KOw6R7h8JcNvLHa6Ewe/v4u3y+VU9ga8n6UI8IsqAKGu/C5PFcHQ=
X-Received: by 2002:a05:600c:1c1f:b0:394:6950:2bda with SMTP id
 j31-20020a05600c1c1f00b0039469502bdamr19632487wms.52.1652082115602; Mon, 09
 May 2022 00:41:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: wunionofficedept@gmail.com
Received: by 2002:a05:6020:bd8e:b0:1db:687d:d05b with HTTP; Mon, 9 May 2022
 00:41:55 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 9 May 2022 08:41:55 +0100
X-Google-Sender-Auth: 3lPtUXKVrzpUlUhhsmyMsbHBAEo
Message-ID: <CAKheY8cVovr_SZbhaTxPpnQ1QHwHFgA7_CHMDR9+gAv6tXUCzA@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,
        MILLION_HUNDRED,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [salkavar2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.7 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, I have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

Yours Faithful,
Mr.Sal Kavar.
