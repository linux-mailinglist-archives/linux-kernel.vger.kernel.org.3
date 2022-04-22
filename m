Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7182950B084
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444349AbiDVG16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444354AbiDVG1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:27:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB080B858
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:24:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c12so8722079plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=pcOIqjfOGD4mtjARe3uelHp7io5D0VG5aulAy4XSsSE=;
        b=iSw7scZmpN1yS00oNmkoRLBgVdLKVu/8XO4WAhSfELceL4QiWHk8kEs1tuzanIBBtK
         3RJLLf3qc3HoR+pNp4G//DLw3LW+66J6YyiQWwNIuLoJ85wcWE/n9vnqbneMxqtLyQrc
         KAR1hmaBZBF5S1TKWrK85HeAYg6DKjygMj7/vbVaTzTarPViQiwliVGO1kFiWHj2qgfV
         8Hr7Omn3bDke2UTP78IQfOo5N+CBn7jWAvYlYy2+QZxFqQWWOQcmswYqaxTwM8c8Yf41
         NstHjjUhvkXuUT9udYEbYf4z3ijAQiFk151zQSOQu7ByLIKlYCwjny/BlN2c48wDHYX5
         EQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=pcOIqjfOGD4mtjARe3uelHp7io5D0VG5aulAy4XSsSE=;
        b=L9adlxyoslyAfFt1VcGHtAuv01lGZ4puOqbeO1dwJ0HTGLzZSWSAvBTaakzZ1UPTic
         FU8fT5YOwUc6Imqw1tMqdgVV+nDJuaZcce0I9vFGxatCMi7icQ56MS1++qPrePjyfgfs
         mD86IuJIi4XKWp9pyigbcVyQRKGvimwfBHkOJ/pSw7ZH3P9s32ngBLJGeaUhhuMYmhhl
         vMa+0Y6NSTg85MYf8KQC+JRz9sSi6TVg1JYycaUsfbZHQRlq7HrReS6yZSNuZMBzhxQc
         NDMow45EAp7uoIJg0yixg2ZCG3+ixqwMk61MYS9N515vRGx/nAHqS3pP34keJfUoPZC7
         6YBA==
X-Gm-Message-State: AOAM531qRfaPVrv/UMAUxiuIKtT5llOLvKwW9Fdf0q+VwCqHTh4aT2fT
        +U+1iXjTNdSbdd0kijGTi3V6wTXjrcd3uIC0AVg=
X-Google-Smtp-Source: ABdhPJxgjTKjX02AU4qoDOQ4iPeAv6oYy6dqvh3c/+N4dZo5K+DM7GVlYapo0TClXhE9t2myAwLzP0H8ZZ7F7vXbrQA=
X-Received: by 2002:a17:902:ab43:b0:156:6f38:52b3 with SMTP id
 ij3-20020a170902ab4300b001566f3852b3mr3055238plb.135.1650608699331; Thu, 21
 Apr 2022 23:24:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mr.a.manga99@gmail.com
Sender: mrsannahbruun605@gmail.com
Received: by 2002:a17:90b:3e8c:0:0:0:0 with HTTP; Thu, 21 Apr 2022 23:24:58
 -0700 (PDT)
From:   "Mr. Amos Manga" <mr.a.manga99@gmail.com>
Date:   Thu, 21 Apr 2022 23:24:58 -0700
X-Google-Sender-Auth: 3yCcF59hatPIkSD8OOELuv_ZRPo
Message-ID: <CAEyYVPHw8OeFnn7aaAOvPQ94H93e1BmrYARKMZymiYCBfR6KsQ@mail.gmail.com>
Subject: STRICTLY AND CONFIDENTIAL:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FORM_SHORT,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_SHORT,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        UNDISC_MONEY,US_DOLLARS_3 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I know this means of communication may not be morally right to you as
a person but I also have had a great thought about it and I have come
to conclusion which I am about to share with you.

INTRODUCTION: I am a banker; I hope you will cooperate with me as a
partner in a project of transferring an abandoned fund of late
customer of the bank worth $18,000,000 (Eighteen Million Dollars
only).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright for you so that we can enter into an agreement before
we start processing for the transfer of the funds. If you are
satisfied with this proposal, please provide the below details for the
Mutual Confidentiality Agreement

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,

Mr.Amos Manga.
