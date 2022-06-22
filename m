Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE1554940
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356444AbiFVLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356969AbiFVLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:44:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07CA33C49B;
        Wed, 22 Jun 2022 04:44:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B05CA13D5;
        Wed, 22 Jun 2022 04:44:23 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE583F66F;
        Wed, 22 Jun 2022 04:44:22 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:43:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Subject: Re: [PATCH] Documentation: ACPI: Update links and references to DSD
 related docs
Message-ID: <20220622114310.r3vick2ex2kx4eiq@bogus>
References: <20220621150436.3303431-1-sudeep.holla@arm.com>
 <CAHp75VfX7ZbK67WhRjuw-s0VF5QZk+dvYEYrN+Kw1ucXofN=yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfX7ZbK67WhRjuw-s0VF5QZk+dvYEYrN+Kw1ucXofN=yg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:41:58PM +0200, Andy Shevchenko wrote:
> On Tue, Jun 21, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The existing references to DSD are stale and outdated. The new process
> > and guidance is maintained @https://github.com/UEFI/DSD-Guide
> >
> > Update the existing documents to reflect the same.
> 
> Hmm... On one hand I like the change, on the other the mentioned
> repository doesn't look like it is officially supported by ASWG (or
> did I misread something?). If I'm not mistaken, then I would rather
> see both mentioned. Otherwise it looks good, thanks!
> 

Sorry I must have mentioned that, I know and also I am told there was a request
made to ASWG to remove the outdated links. Hopefully it will be removed soon.

-- 
Regards,
Sudeep
