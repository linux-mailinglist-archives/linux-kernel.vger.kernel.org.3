Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14552354B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiEKOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiEKOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:22:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0255E62CFF;
        Wed, 11 May 2022 07:22:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD59EED1;
        Wed, 11 May 2022 07:22:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B343F66F;
        Wed, 11 May 2022 07:22:23 -0700 (PDT)
Date:   Wed, 11 May 2022 15:22:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, Dietmar.Eggemann@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v1 2/5] ACPI: bus: Set CPPC _OSC bits for all and when
 CPPC_LIB is supported
Message-ID: <20220511142220.sjfhikuf6fydnrkb@bogus>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
 <20220511134559.1466925-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511134559.1466925-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:45:56PM +0200, Pierre Gondois wrote:
> The _OSC method allows the OS and firmware to communicate about
> supported features/capabitlities. It also allows the OS to take
> control of some features.
> 
> In ACPI 6.4, s6.2.11.2 Platform-Wide OSPM Capabilities, the CPPC
> (resp. v2) bit should be set by the OS if it 'supports controlling
> processor performance via the interfaces described in the _CPC
> object'.
> 
> The OS supports CPPC and parses the _CPC object only if
> CONFIG_ACPI_CPPC_LIB is set. Replace the x86 specific
> boot_cpu_has(X86_FEATURE_HWP) dynamic check with an arch
> generic CONFIG_ACPI_CPPC_LIB build-time check.
> 
> Note:
> CONFIG_X86_INTEL_PSTATE selects CONFIG_ACPI_CPPC_LIB.

While this is work as per the spec, by not sure what kind of ACPI firmware are
in the wild. So be prepared to relax/constrain to original feature check
for x86, unfortunate but may be needed.

Anyways,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
