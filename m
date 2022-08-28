Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848C55A3DDA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiH1NqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 28 Aug 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiH1NqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 09:46:22 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8572CE12;
        Sun, 28 Aug 2022 06:46:17 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 6C53CAB493;
        Sun, 28 Aug 2022 13:46:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 3DEF520025;
        Sun, 28 Aug 2022 13:46:15 +0000 (UTC)
Message-ID: <2e158f8dc433b6b78d47d209495bed678d92369a.camel@perches.com>
Subject: Re: [PATCH v2 4/4] pwm: sysfs: Utilize an array for polarity strings
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Sun, 28 Aug 2022 09:46:14 -0400
In-Reply-To: <CAHp75VfY5RgAju5ASvAp565oF6VmYYiuowNsPTGSm=+1iFJ98A@mail.gmail.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
         <20220826170716.6886-4-andriy.shevchenko@linux.intel.com>
         <5ba98dbd91dc981ec7384484b2a498805abef6b0.camel@perches.com>
         <CAHp75VfY5RgAju5ASvAp565oF6VmYYiuowNsPTGSm=+1iFJ98A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3DEF520025
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 76zegqeqc9tix8aj9gskfzf6b7iatym8
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX188JZ8rGYJxzNHOxcSKe4yGHz+58IHEFbA=
X-HE-Tag: 1661694375-255221
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-08-28 at 09:40 +0300, Andy Shevchenko wrote:
> On Sunday, August 28, 2022, Joe Perches <joe@perches.com> wrote:
> 
> > On Fri, 2022-08-26 at 20:07 +0300, Andy Shevchenko wrote:
> > > Code is smaller and looks nicer if we combine polarity strings
> > > into an array.
> 
> First of all, please remove unnecessary context when replying.

I am _very_ aware of context.
I specifically left the code in.

> > It's less robust though as PWM_POLARITY_NORMAL and _INVERSED
> > are now required to be 0 and 1.  As the only 2 values in
> > an enum they are, but that's not really guaranteed unless
> > you read the enum definition.
> 
> So, what do you suggest here and in many other similar places (yes, ABI
> implied) in the kernel?

Leaving the code alone.

