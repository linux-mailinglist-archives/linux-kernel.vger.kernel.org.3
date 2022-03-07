Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332294D0B25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiCGWei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiCGWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:34:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106E2981A;
        Mon,  7 Mar 2022 14:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D818ACE12AD;
        Mon,  7 Mar 2022 22:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF362C340F4;
        Mon,  7 Mar 2022 22:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646692416;
        bh=GAcZuxHRixO8hhPOSWw490YYSOw/DqU4Cg908Y4+1Gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aU6cYmHsMuXo4ovrjevkY2iIlY4MlbXC7BpViob/1rRgrX6BceCaY/p3YeH1hnReI
         q9lccNZAXnByayaEw3JFztiC5qKlrf1Z3DKXwMT9JIHAzqR5UJ+X4Hu0MzFufNetQq
         Tn0zEiRyibe1sBR07NuQxaaeqXv5TYCEdw8Q37iXbhnQvOPmydGJwc7/BJLS7NnjSI
         O7c6HmNfkm3ox3zEpfIBwK9vA1UeLT6GvN4Y+DB8F4Ac1NDm/lmBEhzhmmjngryFfP
         WMJGn4MYGiYQUcbkIlbjjwpB/59sFHaMjsyD0F5NtCxZtoEDpGG/EcXv43JVo3DkOq
         IlRsSA1eFw0OA==
Received: by mail-ej1-f44.google.com with SMTP id yy13so26326066ejb.2;
        Mon, 07 Mar 2022 14:33:36 -0800 (PST)
X-Gm-Message-State: AOAM5313Y81AK2C2WuTn29VaJR8DuTwZk6Pf6nWkH4OQpSZE+qk42yFr
        hCZ9rsCl/KVMFjm+AX7R/tWL46Ib9bLo49wPUw==
X-Google-Smtp-Source: ABdhPJy4A1lTz4Yu48sH7Gfd0fshRDMBU+B/3kDIajaCK1WcgU/fJPlHTwRDEWwXMFJfmZkosySHFoIqSel8xqZsNxk=
X-Received: by 2002:a17:906:a38e:b0:6da:a1f9:f9ee with SMTP id
 k14-20020a170906a38e00b006daa1f9f9eemr10242090ejz.27.1646692415062; Mon, 07
 Mar 2022 14:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com> <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
 <YhYa3tlTEcLct2xu@smile.fi.intel.com>
In-Reply-To: <YhYa3tlTEcLct2xu@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Mar 2022 16:33:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
Message-ID: <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     shruthi.sanil@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        srikanth.thokala@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        mallikarjunappa.sangannavar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 5:31 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 22, 2022 at 05:13:41PM -0600, Rob Herring wrote:
> > On Tue, Feb 22, 2022 at 03:26:53PM +0530, shruthi.sanil@intel.com wrote:
> > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > >
> > > Add Device Tree bindings for the Timer IP, which can be used as
> > > clocksource and clockevent device in the Intel Keem Bay SoC.
>
> ...
>
> > > +    soc {
> > > +        #address-cells = <0x2>;
> > > +        #size-cells = <0x2>;
> > > +
> > > +        gpt@20331000 {
> > > +            compatible = "intel,keembay-gpt-creg", "simple-mfd";
> >
> > It looks like you are splitting things based on Linux implementation
> > details. Does this h/w block have different combinations of timers and
> > counters? If not, then you don't need the child nodes at all. There's
> > plenty of h/w blocks that get used as both a clocksource and clockevent.
> >
> > Maybe I already raised this, but assume I don't remember and this patch
> > needs to address any questions I already asked.
>
> I dunno if I mentioned that hardware seems to have 5 or so devices behind
> the block, so ideally it should be one device node that represents the global
> register spaces and several children nodes.

Is it 5 devices or 9 devices?

> However, I am not familiar with the established practices in DT world, but
> above seems to me the right thing to do since it describes the hardware as
> is (without any linuxisms).

The Linuxism in these cases defining 1 node per driver because that's
what is convenient for automatic probing. That appears to be exactly
the case here. The red flag is nodes with a compatible and nothing
else. The next question is whether the sub-devices are blocks that
will be assembled in varying combinations and quantities. If not, then
not much point subdividing the h/w blocks.

There's also many cases of having multiple 'identical' timers and
wanting to encode which timer gets assigned to clocksource vs.
clockevent. But those 'identical' timers aren't if you care about
which timer gets assigned where. I *think* that's not the case here
unless you are trying to pick the timer for the clockevent by not
defining the other timers.

Without having a complete picture of what's in 'gpt-creg', I can't
give better advice.

Rob
