Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08566534264
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiEYRsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbiEYRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:48:15 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5143EDE;
        Wed, 25 May 2022 10:48:14 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3003cb4e064so50148747b3.3;
        Wed, 25 May 2022 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=j2JUsEMh5hOyegzZyZUxJxVUxQUsXmJ/ErLMrTCdGGA=;
        b=b40fdQ3QnfjUiOZ/ZnBRzImhI0kuPnDRbuqM4qKrZO/vm9cknubxRB+k+LYgr3o5pc
         UXe3Q1klrjgCHlswH5PSbrmASEcO+oeNSHlprKBIAnQEa1lZ7rThgVomyxmiTq5A5iOM
         5MIsFjBz74qXh8u3Y7HLmPEHodX9XSvNlKx0R2GQqXXjWbO1ji9Iky3ylszINc5jwZYs
         5vmSNoPT/GlgjkraZhr9DoERDSuhXzgnh076peIUwGKjluIPJW+n2CzqHJUvfcT82hpF
         P8i6mOwvar6uj88hd5WVWC2Wo733qIA3JYvu+iRB0kKugUtSl2U/znfAuWY9hA5TiyEI
         evdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=j2JUsEMh5hOyegzZyZUxJxVUxQUsXmJ/ErLMrTCdGGA=;
        b=ecFtDvVL1iwd5TbqR45Z8Qz2fRDB+kwhW5u3rIYsMEb84lgnITYo/PgUluOUDzeDwv
         HM9kr14qwQlFywqt2HTbYSlIO55KBfLwraGIq4Y5dXstdA0V8r+pzUczCmBniC0snS7W
         yvS89P3Vj5gP/WCMpofOw/C5Lw8sEzgPqhA94vpZLAHO/hvQJBFPhE4HTwopvyNXjD/B
         BogmaJKBmfSq2QVsbOrg9Wvffatif4vxMIXvwbTC8qcZh+mNUmhxOIsLC3umQeS04Ix/
         8o1UUZtpsbb/UqU2QXqhRX3Sqf8ojNMTYbRKL1c7yQCAucpS7ZbGoEqzX6kMPbGIeSba
         SLdA==
X-Gm-Message-State: AOAM531R6EHvFVdskNtVbsK8OfQ6LRFILqRAj+ZGdfEdcI21FX4Kvlc7
        VBc30Rptvx9jbCqAWeWE22RfZajzuwazhYAbIWxxuRK4yGg=
X-Google-Smtp-Source: ABdhPJzMNL4nDBfqU94XC7qe7W7TLRd4tfmEk8MhM8qxaKCXoB+SbhkG8lO5iC9oOVk7FsRISDBD7zwX0BlkNczVp3U=
X-Received: by 2002:a81:87c4:0:b0:2ff:c5dc:72b9 with SMTP id
 x187-20020a8187c4000000b002ffc5dc72b9mr20757239ywf.19.1653500893574; Wed, 25
 May 2022 10:48:13 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date:   Wed, 25 May 2022 19:48:02 +0200
Message-ID: <CAJZ5v0hjp2-yLN_UyQvMwhoPreTkA3xU0g3boYtxgLi6TWqabA@mail.gmail.com>
Subject: [CFP] Power Management and Thermal Control MC at LPC 2022
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The Power Management and Thermal Control micro-conference:

https://lpc.events/event/16/contributions/1158/

has been accepted for the LPC 2022, so if you have a topic for
discussion in that session, please submit it through the LPC web page:

https://lpc.events/event/16/abstracts/

(please choose Power Management and Thermal Control MC as the track).
Please also submit topics already listed in the MC description.

Please note that the LPC is mostly about discussing work in progress
and development proposals, so make sure that your topic falls into
this category.  In particular, please avoid submitting topics
regarding work that has already been done.

The LPC will be held in Dublin this year, but it should be possible to
participate in the sessions remotely, so it should be fine to submit a
topic even if you cannot go to Dublin in person.

Looking forward to seeing you all at the LPC!

Cheers,
Rafael
