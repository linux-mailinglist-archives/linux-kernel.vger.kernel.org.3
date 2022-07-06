Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77374568A86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiGFOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGFOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:01:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C1D1D30F;
        Wed,  6 Jul 2022 07:01:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8792D106F;
        Wed,  6 Jul 2022 07:01:25 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B460B3F792;
        Wed,  6 Jul 2022 07:01:22 -0700 (PDT)
Date:   Wed, 6 Jul 2022 15:00:11 +0100
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
Message-ID: <20220706140011.oow6pswbyct6cwrd@bogus>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
 <fb7be22c-cf19-0e06-f231-bb5b9167e179@microchip.com>
 <20220706092126.k6zaknwcwzyg22ak@bogus>
 <bcc3fc6c-1ff8-3db6-5aa9-beed2d0ea41b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc3fc6c-1ff8-3db6-5aa9-beed2d0ea41b@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:04:24PM +0000, Conor.Dooley@microchip.com wrote:
> On 06/07/2022 10:21, Sudeep Holla wrote:

[...]

> > Looks good. Again package id is not cluster. This is what my series is
> > addressing. So update the log as Package instead of Cluster above. The
> > cluster id will be -1 unless you can get that for DT.
> >
> 
> FYI I took that directly from arm64:
> arch/arm64/kernel/topology.c:L57 (next-20220706)
> 
> 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
> 		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
> 		 cpuid_topo->thread_id, mpidr);
> 

Yikes, that needs to change. I will get that updates. Thanks for pointing
that out.

-- 
Regards,
Sudeep
