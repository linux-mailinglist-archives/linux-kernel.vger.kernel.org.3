Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3407573910
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiGMOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGMOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:42:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1AA33E31;
        Wed, 13 Jul 2022 07:42:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4631424;
        Wed, 13 Jul 2022 07:42:47 -0700 (PDT)
Received: from bogus (unknown [10.57.7.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932AB3F73D;
        Wed, 13 Jul 2022 07:42:44 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:42:41 +0100
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
Message-ID: <20220713144241.mmtc4nagzzthpzh2@bogus>
References: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org>
 <20220309151541.139511-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309151541.139511-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Thanks for picking this up.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
