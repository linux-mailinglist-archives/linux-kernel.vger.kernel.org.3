Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72A4F7DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiDGLWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244850AbiDGLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E91B932A;
        Thu,  7 Apr 2022 04:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CF461E38;
        Thu,  7 Apr 2022 11:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9AAC385A0;
        Thu,  7 Apr 2022 11:20:32 +0000 (UTC)
Date:   Thu, 7 Apr 2022 12:20:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Rob Herring <robh@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] cpufreq: CPPC: Add per_cpu efficiency_class
Message-ID: <Yk7I/YMpNkVpVG3n@arm.com>
References: <20220407081620.1662192-1-pierre.gondois@arm.com>
 <20220407081620.1662192-3-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407081620.1662192-3-pierre.gondois@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:16:17AM +0200, Pierre Gondois wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 27df5c1e6baa..67243011279d 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -512,6 +512,7 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
>  {
>  	return &cpu_madt_gicc[cpu];
>  }
> +EXPORT_SYMBOL_GPL(acpi_cpu_get_madt_gicc);

For this arm64 change:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(I haven't looked at the other patches)
