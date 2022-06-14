Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60E754AC35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbiFNIm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355816AbiFNImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:42:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18E224338E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:42:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F411515DB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:42:01 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A36A53F66F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:42:01 -0700 (PDT)
Date:   Tue, 14 Jun 2022 09:41:49 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm: adjust whitespace around '='
Message-ID: <YqhJzRYdgwn0i/wc@e110455-lin.cambridge.arm.com>
References: <20220526204350.832361-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220526204350.832361-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:43:50PM +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the cleanup!

Sudeep, can you pick this one up in your tree?

Best regards,
Liviu

> 
> ---
> 
> Output compared with dtx_diff and fdtdump.
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 44 +++++++++++------------
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 16 ++++-----
>  2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 065381c1cbf5..8d0d45d168d1 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -581,36 +581,36 @@ cti_sys0: cti@20020000 { /* sys_cti_0 */
>  
>  		trig-conns@0 {
>  			reg = <0>;
> -			arm,trig-in-sigs=<2 3>;
> -			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
> -			arm,trig-out-sigs=<0 1>;
> -			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
> +			arm,trig-in-sigs = <2 3>;
> +			arm,trig-in-types = <SNK_FULL SNK_ACQCOMP>;
> +			arm,trig-out-sigs = <0 1>;
> +			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
>  			arm,cs-dev-assoc = <&etr_sys>;
>  		};
>  
>  		trig-conns@1 {
>  			reg = <1>;
> -			arm,trig-in-sigs=<0 1>;
> -			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
> -			arm,trig-out-sigs=<7 6>;
> -			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
> +			arm,trig-in-sigs = <0 1>;
> +			arm,trig-in-types = <SNK_FULL SNK_ACQCOMP>;
> +			arm,trig-out-sigs = <7 6>;
> +			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
>  			arm,cs-dev-assoc = <&etf_sys0>;
>  		};
>  
>  		trig-conns@2 {
>  			reg = <2>;
> -			arm,trig-in-sigs=<4 5 6 7>;
> -			arm,trig-in-types=<STM_TOUT_SPTE STM_TOUT_SW
> +			arm,trig-in-sigs = <4 5 6 7>;
> +			arm,trig-in-types = <STM_TOUT_SPTE STM_TOUT_SW
>  					   STM_TOUT_HETE STM_ASYNCOUT>;
> -			arm,trig-out-sigs=<4 5>;
> -			arm,trig-out-types=<STM_HWEVENT STM_HWEVENT>;
> +			arm,trig-out-sigs = <4 5>;
> +			arm,trig-out-types = <STM_HWEVENT STM_HWEVENT>;
>  			arm,cs-dev-assoc = <&stm_sys>;
>  		};
>  
>  		trig-conns@3 {
>  			reg = <3>;
> -			arm,trig-out-sigs=<2 3>;
> -			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
> +			arm,trig-out-sigs = <2 3>;
> +			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
>  			arm,cs-dev-assoc = <&tpiu_sys>;
>  		};
>  	};
> @@ -628,24 +628,24 @@ cti_sys1: cti@20110000 { /* sys_cti_1 */
>  
>  		trig-conns@0 {
>  			reg = <0>;
> -			arm,trig-in-sigs=<0>;
> -			arm,trig-in-types=<GEN_INTREQ>;
> -			arm,trig-out-sigs=<0>;
> -			arm,trig-out-types=<GEN_HALTREQ>;
> +			arm,trig-in-sigs = <0>;
> +			arm,trig-in-types = <GEN_INTREQ>;
> +			arm,trig-out-sigs = <0>;
> +			arm,trig-out-types = <GEN_HALTREQ>;
>  			arm,trig-conn-name = "sys_profiler";
>  		};
>  
>  		trig-conns@1 {
>  			reg = <1>;
> -			arm,trig-out-sigs=<2 3>;
> -			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
> +			arm,trig-out-sigs = <2 3>;
> +			arm,trig-out-types = <GEN_HALTREQ GEN_RESTARTREQ>;
>  			arm,trig-conn-name = "watchdog";
>  		};
>  
>  		trig-conns@2 {
>  			reg = <2>;
> -			arm,trig-out-sigs=<1 6>;
> -			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
> +			arm,trig-out-sigs = <1 6>;
> +			arm,trig-out-types = <GEN_HALTREQ GEN_RESTARTREQ>;
>  			arm,trig-conn-name = "g_counter";
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> index 2e43f4531308..ba88d1596f6f 100644
> --- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> @@ -96,24 +96,24 @@ cti_sys2: cti@20160000 { /* sys_cti_2 */
>  
>  		trig-conns@0 {
>  			reg = <0>;
> -			arm,trig-in-sigs=<0 1>;
> -			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
> -			arm,trig-out-sigs=<0 1>;
> -			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
> +			arm,trig-in-sigs = <0 1>;
> +			arm,trig-in-types = <SNK_FULL SNK_ACQCOMP>;
> +			arm,trig-out-sigs = <0 1>;
> +			arm,trig-out-types = <SNK_FLUSHIN SNK_TRIGIN>;
>  			arm,cs-dev-assoc = <&etf_sys1>;
>  		};
>  
>  		trig-conns@1 {
>  			reg = <1>;
> -			arm,trig-in-sigs=<2 3 4>;
> -			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
> +			arm,trig-in-sigs = <2 3 4>;
> +			arm,trig-in-types = <ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
>  			arm,trig-conn-name = "ela_clus_0";
>  		};
>  
>  		trig-conns@2 {
>  			reg = <2>;
> -			arm,trig-in-sigs=<5 6 7>;
> -			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
> +			arm,trig-in-sigs = <5 6 7>;
> +			arm,trig-in-types = <ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
>  			arm,trig-conn-name = "ela_clus_1";
>  		};
>  	};
> -- 
> 2.34.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
