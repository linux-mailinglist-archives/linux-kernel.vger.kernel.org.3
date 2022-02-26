Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB64C54BE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiBZIwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 03:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiBZIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 03:52:24 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE81B98B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 00:51:50 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q4so6470761qki.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 00:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=b/fELAjGyzmcc44BH6vScFTdVqaSKOXFtouqrae45iz26jYGdbCORv4zAX532rZsXm
         Jp43nZwXSHSxFWVAd1nkHmNxzdlOHn33WuawREKcASjcm5SqbKQv9nufmxgcCjMSwWHm
         vUmdSjWWHEbXDwu8F05rYEqrpcHzVFdlxNo40+IPtGFCI5Jcpq6Oey/G7fZsSX3lgoxe
         U4dAZfHVOc834cJkU+ILIrFpBBvbAYsLMZ5h9Xg/K7solaT8qGA6llIc0CzIS3X4ODyM
         IheewWRQBMAXrgQ5a45nLPlzTaGU0VolZ/nETAGEQc01ooLXCz3hHg9MuNTS9F73Xdt3
         VKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=ikkkViFj3Kl79F4K0/jF0QRHwJHl4BU6FzHP9cMInt5ZJ5KHlMoo7QiNLUZ6OE330T
         SqYqhERCFCdn7g0A3pz0fDBF1DCi6wAaos0mm1Adu99H4EiLToUy+lLcgc7wGLn/Raks
         8m1Sbs0eRvOalxh8ko0lZJ1177HgV2xoUD5eGyIcv+IL9v7ReysQoUJXczav/mDPmx9S
         HGlBP2B6VTHx6RRiJ4qY4VQN++/mglG35CGOSKyqqf8XLYuU7ZuETZ4ssnSaBBstWwx4
         4MOV0JfUZ4P8+WWHzyBJ20+Nt4yfz/yeDDHpCQOz92jw43g3V840VSphAlWqhaqtC9rn
         x63Q==
X-Gm-Message-State: AOAM532GXIx1TBBH1YmM/R2gFH6jxQT6A6/KUnIWN4E70oHnIwXMQ8Kb
        sdtKo1Zqrm5Hcrq107P2OY5Fy8ffbQn6y+/NKgM=
X-Google-Smtp-Source: ABdhPJzJC8nR9FoCsNt5lGada2lCsZUW82QaikhUCxYy5AXtVXOcTNKp5Iyn4CJFPxKyHDqoapBYQInSI1RUE+4dvyM=
X-Received: by 2002:a05:620a:2048:b0:648:c78c:373e with SMTP id
 d8-20020a05620a204800b00648c78c373emr7051369qka.189.1645865509121; Sat, 26
 Feb 2022 00:51:49 -0800 (PST)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: carolineregt@gmail.com
Received: by 2002:a37:654:0:0:0:0:0 with HTTP; Sat, 26 Feb 2022 00:51:48 -0800 (PST)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Sat, 26 Feb 2022 09:51:48 +0100
X-Google-Sender-Auth: PX9GEd6GArkqnENe9Dk8tIgmg8Y
Message-ID: <CA+sSZDKmeLd4YGZaqiUsr=L18D2+p0bdsjjp6KGxObyzuTxDhQ@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_8,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

Thus i humbly request your assistance to claim this fund. Upon the
transfer of this fund in your account, you will take 45% as your share
from the total fund, 10% will be shared to Charity Organizations in
both country and 45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
