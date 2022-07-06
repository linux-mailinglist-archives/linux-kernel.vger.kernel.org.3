Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFEE56835F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiGFJUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiGFJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:20:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DFD11581C;
        Wed,  6 Jul 2022 02:20:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753EC15A1;
        Wed,  6 Jul 2022 02:20:05 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9FEA3F66F;
        Wed,  6 Jul 2022 02:20:00 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:18:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Daire.McNamara@microchip.com,
        niklas.cassel@wdc.com, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, zong.li@sifive.com, kernel@esmil.dk,
        hahnjo@hahnjo.de, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brice.Goglin@inria.fr
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Message-ID: <20220706091850.deealvovinkzjrml@bogus>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:33:39PM +0000, Conor.Dooley@microchip.com wrote:
> 
> 
> On 05/07/2022 21:19, Sudeep Holla wrote:
> > On Tue, Jul 05, 2022 at 08:04:31PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> It was reported to me that the Hive Unmatched incorrectly reports
> >> its topology to hwloc, but the StarFive VisionFive did in [0] &
> >> a subsequent off-list email from Brice (the hwloc maintainer).
> >> This turned out not to be entirely true, the /downstream/ version
> >> of the VisionFive does work correctly but not upstream, as the
> >> downstream devicetree has a cpu-map node that was added recently.
> >>
> >> This series adds a cpu-map node to all upstream devicetrees, which
> >> I have tested on mpfs & fu540. The first patch is lifted directly
> >> from the downstream StarFive devicetree.
> >>
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > I would recommend to have sane defaults in core risc-v code in case of
> > absence of /cpu-map node as it is optional. The reason I mentioned is that
> > Conor mentioned how the default values in absence of the node looked quite
> > wrong. I don't know if it is possible on RISC-V but on ARM64 we do have
> > default values if arch_topology fails to set based on DT/ACPI.
> > 
> 
> Yeah the defaults are all -1. I'll add some sane defaults for a v2.

Sorry I didn't mean it to be part of this series. This series of DT changes
are just fine on their own.

-- 
Regards,
Sudeep
