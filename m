Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA13B515F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355570AbiD3Re7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbiD3Re5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:34:57 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502242EDE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:31:34 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-d39f741ba0so10957069fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=rrdjG6c/2FeXm3rYw+FcEDfupq6ewXDDBRc/WzcU8PU=;
        b=LDZCDlSwVsC74oU3hxuO//uhVsA03p5hEUSLrolsf/FQD95Hrwme4S3h7b6F+VCX+7
         c2v4hpt7NTPXFdbzb6bmoix/QY3zftDHMbrhujk2yTrtlfF26PzNC57EcvlyPe1dQABI
         UlH9lsWF7MRSBYqZzB5ISShdnA8xHaQHoY4ZAQDFumi+DYD1Bx6LL5wcQlb/OOfBT22f
         amVItwJvKDcsUjBdo4bvgg2eqrCahV2DFkB8Wb8vEQZKdfGXqIv/PlF5N758Rt6gAn3e
         hPaJbA9uQyzLtzfOKIXrKm/wqnZs9ZJgZ03qYSgn+v0n2NhjdzJXQbGdqyxgNTF2K32V
         n1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=rrdjG6c/2FeXm3rYw+FcEDfupq6ewXDDBRc/WzcU8PU=;
        b=T62ECLuR+6316jvSt9lTjMd2j17neRG2bDpYrRnHLzM4PCkSCCDHmXNExFdwY9W8tu
         y+EmxRBFFdHdssM1JRJeMIhEB8lqWp6XESCl9NLH03f8s8IOsV+s/qUC8Kr1nn+R+y4I
         PvjhekKtsA3ntX/klksJ6SMzn4lzVbQ4upR5LuKqQ66tx7ytI3shr+FP+9BNNKk/jbZ7
         wq9360Ggo7QX7qUx6rzS9bbwqsYPj1kr1LSn3xU0zTEbjiw5o/Kw5iOl6rfPfSZ2HJWl
         9zwgTBTQQFG70b8i3TVDl78hVXrbWX3npDTI3aOf2dVdfN5ibPmUTsq2z+KRXJf7FC/Q
         t38A==
X-Gm-Message-State: AOAM531/pr5FFY4dyV02JrHbi3DJDKaXU9om8WWzETlMmLzfaFHIhFpr
        7t9kiCq9dOpw9jymlHHvMaGthhybbtx2SGpuMNw=
X-Google-Smtp-Source: ABdhPJwsPRxqXMSaQEyejwWjk5Jz6GkvLKlBh8pNuvsGmP/rQbRWkVgEffkmXqafoZgpX7xcc5AilMRLAvutf82i1NM=
X-Received: by 2002:a05:6871:1d0:b0:da:b3f:3210 with SMTP id
 q16-20020a05687101d000b000da0b3f3210mr2025721oad.192.1651339893050; Sat, 30
 Apr 2022 10:31:33 -0700 (PDT)
MIME-Version: 1.0
Sender: dd16978@gmail.com
Received: by 2002:a4a:315a:0:0:0:0:0 with HTTP; Sat, 30 Apr 2022 10:31:32
 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Sat, 30 Apr 2022 18:31:32 +0100
X-Google-Sender-Auth: ME-Fe7orV_tl_Oj974ZfRO2MWpE
Message-ID: <CA+qKLfcEGm5s4sZ+6GtUUMghMnOieTOp8LM2zD4_ZcT5vNpJDg@mail.gmail.com>
Subject: YOUR COVID-19 COMPENSATION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,LOTTO_DEPT,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
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

Contact Dr. Mustafa Ali for more information by email at:(
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Best Regards,
Mr. Jimmy Moore.
Undersecretary General United Nations
Office of Internal Oversight-UNIOS
UN making the world a better place
http://www.un.org/sg/
