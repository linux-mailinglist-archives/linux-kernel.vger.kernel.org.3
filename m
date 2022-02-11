Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC44B2262
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbiBKJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiBKJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:46:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D81D10A1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:46:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB012D6E;
        Fri, 11 Feb 2022 01:46:18 -0800 (PST)
Received: from bogus (unknown [10.57.3.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 343323F73B;
        Fri, 11 Feb 2022 01:46:15 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:45:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 40/49] firmware: pcsi: replace cpumask_weight with
 cpumask_weight_eq
Message-ID: <20220211094527.kmcnvz7iyiwkxtbc@bogus>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-41-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-41-yury.norov@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:24PM -0800, Yury Norov wrote:
> down_and_up_cpus() calls cpumask_weight() to compare the weight of
> cpumask with a given number. We can do it more efficiently with
> cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is (or can't be) met.
>

Nit: s/pcsi/psci/ in $subject. With that fixed,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
