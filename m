Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4260353A48D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiFAMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFAMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:07:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F66A5712C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:07:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EA1F1FB;
        Wed,  1 Jun 2022 05:07:47 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3E93F73D;
        Wed,  1 Jun 2022 05:07:45 -0700 (PDT)
Date:   Wed, 1 Jun 2022 13:06:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 09/16] arch_topology: Drop LLC identifier stash from
 the CPU topology
Message-ID: <20220601120658.2x737nhyxmodoo7t@bogus>
References: <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
 <20220525081416.3306043-9-sudeep.holla@arm.com>
 <20220525081416.3306043-10-sudeep.holla@arm.com>
 <3860bfcc-a323-c031-0fdd-77001d338bec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3860bfcc-a323-c031-0fdd-77001d338bec@redhat.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:35:20AM +0800, Gavin Shan wrote:
> Hi Sudeep,
> 
> On 5/25/22 4:14 PM, Sudeep Holla wrote:
> > Since the cacheinfo LLC information is used directly in arch_topology,
> > there is no need to parse and store the LLC ID information only for
> > ACPI systems in the CPU topology.
> > 
> > Remove the redundant LLC ID from the generic CPU arch_topology information.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/base/arch_topology.c  | 1 -
> >   include/linux/arch_topology.h | 1 -
> >   2 files changed, 2 deletions(-)
> > 
> 
> How about merge the changes to PATCH[08/16]? I don't see why we need put
> the changes into separate patches.
>

It took a while to remember as I was with the same opinion as yours but
decided to split them for one reason: to keep arch specific change in a
separate patch(if that becomes a need due to some conflict or some other
non-technical reason)

-- 
Regards,
Sudeep
