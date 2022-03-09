Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31B4D39F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiCITUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbiCITSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:18:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 330E8108BF5;
        Wed,  9 Mar 2022 11:17:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 981B71691;
        Wed,  9 Mar 2022 11:17:24 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFD953FA27;
        Wed,  9 Mar 2022 11:17:22 -0800 (PST)
Date:   Wed, 9 Mar 2022 19:17:20 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, krzk+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Hector Yuan <hector.yuan@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an
 example
Message-ID: <Yij9QBWFe5z9Ze23@bogus>
References: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org>
 <20220309151541.139511-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309151541.139511-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 08:45:40PM +0530, Manivannan Sadhasivam wrote:
> Qcom CPUFREQ HW don't have the support for generic performance domains yet.
> So use MediaTek CPUFREQ HW that has the support available in mainline.
> 
> This also silences the below dtschema warnings for "cpufreq-qcom-hw.yaml":
> 
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: reg: [[305397760, 4096]] is too short
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clocks' is a required property
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clock-names' is a required property
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#freq-domain-cells' is a required property
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#performance-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 
> Cc: Hector Yuan <hector.yuan@mediatek.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Thanks for fixing this. It seem to have slipped through the cracks. I had
plans to push this once Mediatek driver was merged but totally forgot about
it.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
