Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4355059A347
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351970AbiHSRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351163AbiHSRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:42:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B747120A7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:02:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q18so4052670ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=8srtPqHGa40CVslrURYXsHSOfQqBi5LmheASbuMqgVc=;
        b=jJ37Fk8GIH4JZCwpBidq4P0p8uYDVP83QsO7Kl+7YzYtOdwO3HdUIKjefD9FX11KLV
         rthljv39xhetKTDdR5IOwGqlPmZiBBgrZd24YwuednVpS/OLtDCl2l94NOr6GZ+KnSFS
         XedgQ0at1pZJKnf5mpqwCegrkZU96RpGFR0ymCCHRgWH/cPklPAchxbpL2LokGrfp1d+
         Vl13zVCCCrkAxeTnx27liER76xBGoo5Hov4Nbw/g29/tA2TLygHQQvHo24D1c8EiH1LP
         OnIKvjXfCWqkkS/iAXlgTZVWNAlPZ/ERFLS4OK9r8Mjd5GfJsmsD5sevUYAGndMbbEwX
         1rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=8srtPqHGa40CVslrURYXsHSOfQqBi5LmheASbuMqgVc=;
        b=Xe5FARX0SNPWPPYJ4QAjZJSyzGrY4lVD/4LulboGn1/Elf9liGxOoVzyQ5UGzCfGOD
         orxTzsB4xCb6b9qszBp7ZiboBRrjNcBbCotNQ9FioZBE16faHpKh9SKFPN0T6AJk22Ai
         pY1DEBTWJlfCNNFstCMXn7l8qiwyGGCWszuI4Xa75GpMthpljnb+enFFz7gxJaENZua1
         lXMC4cyS/SjqcrjydwqPahq3gTovp/3JWoxbdDQks2KiJcSfILZc2CSYe/y/lFykNKFc
         XZwkkgslyYF0QS39FWvMC/4XcPgiDO0i32XwZ4P+BB0uJEZG7jAS9a+i8WFJ3c7wK0Ct
         +PtA==
X-Gm-Message-State: ACgBeo1wraf5REuqLp12/MU8r4NKpjUsep5EttxsgMOLKc1WCC56+fO0
        efqmcRk59UWD3l/z/JJBWoD69xDt5U6ZknCFxut1/frnioxUug==
X-Google-Smtp-Source: AA6agR45oHyYTu2IkGYDDh0LaYi7NGrbn0axS3SPggOY+GDiWxOT0SylJr4aRqK4hXKNvudpq/fKEOdVPXvqXVN/0OE=
X-Received: by 2002:a17:907:2c4a:b0:73d:1d15:4a8f with SMTP id
 hf10-20020a1709072c4a00b0073d1d154a8fmr2139829ejc.573.1660927811209; Fri, 19
 Aug 2022 09:50:11 -0700 (PDT)
MIME-Version: 1.0
Sender: lila.lucass112@gmail.com
Received: by 2002:a17:907:7e9e:0:0:0:0 with HTTP; Fri, 19 Aug 2022 09:50:10
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Fri, 19 Aug 2022 18:50:10 +0200
X-Google-Sender-Auth: lYYDFiFObIAEXAX3qlxo4ogpQKI
Message-ID: <CAPvtrUeg0nTmk7DGY0zR6WC01mhDVUQ1bny_G-x2HhGPYCh-fQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearly Beloved In Christ,

Please forgive me for stressing you with my predicaments as I directly
believe that you will be honest to fulfill my final wish before i die.

I am Mrs.Sophia Erick, and i was Diagnosed with Cancer about 2 years
ago, before i go for a surgery i have to do this by helping the
Orphanages home, Motherless babies home, less privileged and disable
citizens and widows around the world,

So If you are interested to fulfill my final wish by using the sum of
$ 11,000,000.00, Eleven Million Dollars, to help them as I mentioned,
kindly get back to me for more information on how the fund will be
transferred to your account.

Warm Regards,
Sincerely Mrs. Sophia Erick.
