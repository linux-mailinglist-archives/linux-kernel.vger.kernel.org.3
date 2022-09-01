Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2D5A9ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiIAOpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiIAOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8653032
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A2261DAD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC69C433D6;
        Thu,  1 Sep 2022 14:45:29 +0000 (UTC)
Date:   Thu, 1 Sep 2022 10:46:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] regmap: trace: Remove explicit castings
Message-ID: <20220901104601.01773fb8@gandalf.local.home>
In-Reply-To: <CAHp75VcrBS=+bxXz62HB6joB3+6meVK9YJtJOYSS3PNrY13AVg@mail.gmail.com>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
        <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
        <YxC0SYShl14TSw2o@sirena.org.uk>
        <CAHp75VcrBS=+bxXz62HB6joB3+6meVK9YJtJOYSS3PNrY13AVg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 17:18:01 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Sep 1, 2022 at 5:15 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Sep 01, 2022 at 04:23:35PM +0300, Andy Shevchenko wrote:  
> > > There is no need to have explicit castings to the same type the
> > > variables are of. Remove the explicit castings.  
> >
> > IIRC this was an idiom that the trace code was using for some deep magic
> > reason to do with some fiddly preprocessor stuff.  
> 
> Perhaps that (dark) magic disappeared a long time ago since in my
> practice of adding trace events this is the first (and probably
> oldest) one which has these castings. Perhaps Steven can shed a light.
> 

There was no dark magic for those castings. The trace events never needed
them. It was added from the original commit:

fb2736bbaee0e ("regmap: Add basic tracepoints")

So, I'm all for dropping them.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
