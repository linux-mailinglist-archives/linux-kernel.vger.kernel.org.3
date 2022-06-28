Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56F55F1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiF1Xkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1Xkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:40:35 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FD32EC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:40:34 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p7so23493222ybm.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ecd1Q2yPx0A7W7K7jCuZP1F8wCmAYdVKX1aCc8pJ7gM=;
        b=QvNsVHWcwxDC0Ljn7LCNxtCUWV5DAzQ3PPXpGoHxkrgW+/voKwr44JOYQDkUJ3SbEm
         kAF+V6jDHT6StaDm0Y3fTy3Qe2XnBk0fE8RIX6LHeYJPkGVHqtxu0Tago+3gCnmqpgnG
         j4gphlk4w1fbsPd+xvESwhagVgTOJNjRUCSYskbwMZea+N+VtW0n1eexD8qCuZmW2uUk
         v9JbWWYcGjVkYXtNrHLF2zPt2k/MGoDMH/JO3ZUEQR/5eUrdFyiHwAPNXXG4/Jo14YZw
         qkI+ihHPqAGtT33pQTORhi0phBiJWQ8xitb3isY3OBcyYCeQDQsTkD926YHe2ZY5jwk0
         0jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ecd1Q2yPx0A7W7K7jCuZP1F8wCmAYdVKX1aCc8pJ7gM=;
        b=wFr63yXx5XFQMMkspx3BFYuZqNlCSr8F48/nEqNfOIgxtWRz4SBxT/TVJJAqQpkIMT
         2ifkAetM+RNFz2EHaB2NMvYCN0Hxya+GJIrNmss58x7wgj/BttfLocFhZNwim6xiO5pK
         LjNYQYolGLX6Mxt9GHdq1vAJJlOjS1LtnbRZo46To/uvVrkEQPA4pErIL1QPt2LtVK58
         ePMJqm/yo4eox54LL/bhRd+jHSwXxpDKgd8JznApioR+ru4J+mrgXHNfMBt7Zwwqpnga
         c0shOvMwXwhB0ARUPgNl6umpuwpepX+MSu3RLhIXpeQtjHCXmYq+/pcsTjLr4pvog3Oj
         dXKg==
X-Gm-Message-State: AJIora9xWZmRk47AFOjUxUKQPofMiLO8WPTkTnGZRvm5k9QbDzq2MxUb
        cOQJZNLSbzbhL/vTboqL4lLsYfhqNrN28Wrl42c=
X-Google-Smtp-Source: AGRyM1v8apNRY5qwfmEpxRjfh1Vv5DBYKpZs7VbnMm1KODl7Kg3sudOvj5Oxs0ws6KBdhaBJlgMjj/9IGy1wXk30Z7A=
X-Received: by 2002:a25:6f86:0:b0:669:22f7:b94f with SMTP id
 k128-20020a256f86000000b0066922f7b94fmr356806ybc.327.1656459633643; Tue, 28
 Jun 2022 16:40:33 -0700 (PDT)
MIME-Version: 1.0
Sender: d7372548645@gmail.com
Received: by 2002:a05:7010:1e11:b0:2e1:eb33:312c with HTTP; Tue, 28 Jun 2022
 16:40:33 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Wed, 29 Jun 2022 02:40:33 +0300
X-Google-Sender-Auth: B1Rq75kaNfm281ew3BKOuYfuR6Y
Message-ID: <CAGcADL_ANBLQJYw9RdrTNA7Qp6_Or4LmBOcmgzWskWzitGPNRw@mail.gmail.com>
Subject: UNITED NATIONS COVID-19 COMPENSATION FUNDS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$3.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth $3.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have received your Covid-19 Compensation total sum of $3.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email at: (
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS.
