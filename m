Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3544D2E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiCILvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCILvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:51:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42BF8574B8;
        Wed,  9 Mar 2022 03:50:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C2661650;
        Wed,  9 Mar 2022 03:50:20 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973113FA4D;
        Wed,  9 Mar 2022 03:50:18 -0800 (PST)
Date:   Wed, 9 Mar 2022 11:50:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     liviu.dudau@arm.com, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH RESEND 0/1] arm64: dts: Juno CTI device tree additions
Message-ID: <YiiUePW2DESezPLo@bogus>
References: <20220309113117.1126-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309113117.1126-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:31:16AM +0000, Mike Leach wrote:
> This is a resend of a patch from some time ago (04/2020)[1] which seems to
> have fallen through the cracks - most likely as last time I mistakenly
> tagged it as dt-bindings: rather than dts:
>

Quite likely, but I vaguely remember this and I assume the bindings had
on-going discussions at that time.

> I am planning a release of additional CTI configuration examples, which
> include some for Juno - so this is now needed upstream to support that work.
>
> Patch unchanged, other than a correction to the subject.
>

That may not work. I haven't tried applying but it would be good to
post it rebasing on -next at this moment or after v5.18-rc1 is released.
I have already sent v5.18 material, so I need to queue this for v5.19.
So preferable post the rebase version at v5.18-rc1 in 2+ weeks time.
We have had some restructuring including the new scmi version of DTB
in the mainline or queued in -next at the moment.

Sorry for missing this last time.

> [1] https://lore.kernel.org/linux-arm-kernel/20200415201330.15894-1-mike.leach@linaro.org/
> 
> 
> Mike Leach (1):
>   arm64: dts: arm:  Juno - add CTI entries to device tree
>

No need of the cover letter for one patch, just post the patch next time.

-- 
Regards,
Sudeep
