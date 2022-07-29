Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF085856D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiG2WVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiG2WVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:21:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3EC10570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:21:01 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-32269d60830so64060167b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=6d5jMCrauedgyT6F3RzrXl4yXsf77OwIiAgFmSDNs60=;
        b=KND3DX2oNAnvBZSYAP9l0+wMQn4NM1c8v+cm6KmmOk5YgsenBcGER8LTTVidfdvBVz
         wLmZgm7JgZaXR3MLfLW6nA3DhBoULSckK4/YBlGSuJp2OaKzrMH6NC3IOt5bi4ax/Sci
         4JAUkA97QPjqcKhea/qNKO7v+OGDmrH48oXqmfSbGIAmhcjMvFOugl/tQyDhOe8GINE7
         lfwiBMQbl54sXQlj80BUynK722Zbc4bHLiJDZXEpAZJ+LdjemqvPZX0yFkHSTQziHTmO
         qOa489xnknNxYXeZy3x37/uU2HxZNSgvi5jmwe3bplgCIOUL2i3Hz2lJJK6ixPWYY4W+
         +J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=6d5jMCrauedgyT6F3RzrXl4yXsf77OwIiAgFmSDNs60=;
        b=mZMBV8+0XJ3KIVxEwZaIYpmVOLKHFonAiMSXkgwTp34DriB/pwU580JfGscYTAr8+1
         QLme6rRM8gZ2SwMltCfGUegTV885HJYr4xSrciGtrcAucCX2NtkvKHf7N8v4cvv542Km
         KnVz2e+PX881Pg+vXUudDXJ3+1VNxBvh/bL822o2G9nVKbypF7N+iLa4eE6Fy/D7JlFR
         PWQfugTY1j79wxlGrj9bPZtcL5Kv3xZi+mcA9IuTN4QMYqGpO2Ix9XsaH7Axmibctvvh
         8pweLbEoyGd2QB3di/OnTsGdCyz0D1x4o/W/v7lsdMVTQeip+VfFQD6lozwWYH0LDcMC
         1QCw==
X-Gm-Message-State: ACgBeo1Z4pYY4cFhtVSH0ONIGoccwtXcn1gZUrMnvVmeRnhMleWAmMjJ
        jYim80g/+8w6HVhG7iR9WcN8K9/nsfbqQeAmZ3E=
X-Google-Smtp-Source: AA6agR7txTsTRXtBYKOmUw4MWDkbmdn1opjTDbXw9teYLPVNY6GsyqR8MBJkwCF/oBQCvHHq9G87ABE1sCj339GYlMg=
X-Received: by 2002:a81:178d:0:b0:31f:5b19:6f1c with SMTP id
 135-20020a81178d000000b0031f5b196f1cmr4844374ywx.116.1659133260155; Fri, 29
 Jul 2022 15:21:00 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.musa.ahmed7@gmail.com
Received: by 2002:a05:7010:7208:b0:2e8:68d5:94de with HTTP; Fri, 29 Jul 2022
 15:20:59 -0700 (PDT)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Fri, 29 Jul 2022 15:20:59 -0700
X-Google-Sender-Auth: P55Cj0d5-sZnbG96jgBG9ZJOnUc
Message-ID: <CAAz8YJ9rPAZC17nxjYNAkTQQr3gwu+BJ_A1OGyYW24PFJmCrNQ@mail.gmail.com>
Subject: My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112f listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8907]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aisha.gdaff21[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.musa.ahmed7[at]gmail.com]
        *  1.7 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I came across your e-mail contact prior a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future.
I am willing to negotiate investment/business profit sharing ratio
with you base on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgent to enable me provide you more information about the investment
funds
