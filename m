Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001354B02DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiBJB7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:59:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiBJB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:08 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1482B6AE;
        Wed,  9 Feb 2022 17:45:15 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso4668305ooi.1;
        Wed, 09 Feb 2022 17:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lop+jHQ6bLpYVQ/iRKAgjmWolqUKphRAvo1ndJg1zk=;
        b=MGGpu60bKpZnbvydEdxwHuZXqtfIXPuYVPKc4oFfv7FIDMaA/DM/1bmuyFEVGMPmQc
         kaNhBMO5dRS3756KBdftcXUtED/3quGbfYy9h3uEYdfbEM9vo5DJJjWdtwOz+td64mLY
         jU6m3xF2hHrfa8Ft4E2mSCZ127tXBBeX6O3IvHiwJkNvvRnRIQv7McfjPzIIqYwS7NvI
         zUteuRHSD7EsOnHiNlxGdH1plQubftyjCbXhF4U+dveGUJWBHjXOALfXpR6OyJFW1xiK
         xsGCm1xIPVkqExwK5sm/AxG27wMDaF4wZmNofvMWj44Iht+ef7sTjDwcb+7Vr765ZgLr
         GjqA==
X-Gm-Message-State: AOAM531PrDf9/P+05rk7IRpbvXOBfKCuiEuaqPVWIeX+u2IhRy/6OXSd
        /+0dvtChjw3KHZE8g+w7ZbcZmUCC1SRD
X-Google-Smtp-Source: ABdhPJzCkAHc8o+aWAlGBDAiek96chtpXWuc1LpV9c0MFHrH/mpvAHtDn+fItGOZtT6t6D7qolCxQg==
X-Received: by 2002:a05:6870:b1d3:: with SMTP id x19mr1809966oak.101.1644453291094;
        Wed, 09 Feb 2022 16:34:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q11sm7338809oti.3.2022.02.09.16.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:34:50 -0800 (PST)
Received: (nullmailer pid 1264695 invoked by uid 1000);
        Thu, 10 Feb 2022 00:34:49 -0000
Date:   Wed, 9 Feb 2022 18:34:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] of: unittest: print pass messages at same loglevel
 as fail
Message-ID: <YgRdqe0+8fqSYi2T@robh.at.kernel.org>
References: <20220203211150.2912192-1-frowand.list@gmail.com>
 <CAL_JsqKMZWMtvdTvYHmWkd5CmehKJexJVv_BUBENrMPOf002+w@mail.gmail.com>
 <24652725-91d8-9db4-e14a-e1bb5ded87b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24652725-91d8-9db4-e14a-e1bb5ded87b1@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:41:45PM -0600, Frank Rowand wrote:
> On 2/3/22 3:40 PM, Rob Herring wrote:
> > On Thu, Feb 3, 2022 at 3:12 PM <frowand.list@gmail.com> wrote:
> >>
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Printing the devicetree unittest pass message for each passed test
> >> creates much console verbosity.  The existing pass messages are
> >> printed at loglevel KERN_DEBUG so they will not print by default.
> >>
> >> Change default to print the pass messages at the same loglevel as
> >> the fail messages.
> >>
> >> The test community expects either a pass or a fail message for each
> >> test in a test suite.  The messages are typically post-processed to
> >> report pass/fail results.
> >>
> >> Suppressing printing the pass message for each individual test is
> >> available via the kernel command line parameter unittest.hide_pass.
> >>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >>  drivers/of/unittest.c                           | 17 ++++++++++++++++-
> >>  2 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index f5a27f067db9..045455f9b7e1 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -5997,6 +5997,10 @@
> >>                         Note that genuine overcurrent events won't be
> >>                         reported either.
> >>
> >> +       unittest.hide_pass
> > 
> > Can we rename the module name to include 'dt' so we're not taking a
> > generic name.
> 
> I got most of the way through writing a reply to the various questions, then got to
> the point where my answer to a specific question ended up being something to the
> effect of: "this line of code (where a change was suggested) will end up being
> replaced when I convert the unittest messages to KTAP format".
> 
> Then I got sidelined by going back and re-reading the KTAP specification email
> thread from August, then discovering that there is also a patch submission email
> thread from December where a KTAP specification is accepted into the kernel tree.
> 
> Being KTAP compliant does not allow for suppressing the individual test pass
> messages, so I think I should just drop my desire to be able to do so.  That
> would reduce this patch to a one line change to print the pass messages at the
> same loglevel as the fail messages.  And I would prefer to not worry about
> whether the pass message is 'pass' vs 'PASS' since that text will get replaced
> by the KTAP syntax anyway.
> 
> Would you be ok with that one line patch?

At info level, yes. If not, how soon until using ktap syntax?

Rob
