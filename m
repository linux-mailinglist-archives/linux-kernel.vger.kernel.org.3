Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168457DFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiGVK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGVK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:29:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C37EC1086;
        Fri, 22 Jul 2022 03:29:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69521063;
        Fri, 22 Jul 2022 03:29:45 -0700 (PDT)
Received: from [10.57.41.17] (unknown [10.57.41.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F9393F766;
        Fri, 22 Jul 2022 03:29:41 -0700 (PDT)
Message-ID: <d73801f6-8476-074e-6af1-1b8cab95b817@arm.com>
Date:   Fri, 22 Jul 2022 11:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: arm: juno: Remove legacy Coresight
 'slave-mode' property
To:     Rob Herring <robh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721212952.1984382-1-robh@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220721212952.1984382-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 22:29, Rob Herring wrote:
> The 'slave-mode' property is not valid under 'in-ports' as it was the
> legacy way to find input ports. Warnings are generated from the Coresight
> schema:
> 
> arch/arm64/boot/dts/arm/juno-r1.dtb: funnel@20150000: in-ports:port@0:endpoint: Unevaluated properties are not allowed ('slave-mode' was unexpected)
>          From schema: Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> index 2e43f4531308..fbcdf63ad56d 100644
> --- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> @@ -67,7 +67,6 @@ in-ports {
>   			port@0 {
>   				reg = <0>;
>   				csys2_funnel_in_port0: endpoint {
> -					slave-mode;
>   					remote-endpoint = <&etf0_out_port>;
>   				};
>   			};
> @@ -75,7 +74,6 @@ csys2_funnel_in_port0: endpoint {
>   			port@1 {
>   				reg = <1>;
>   				csys2_funnel_in_port1: endpoint {
> -					slave-mode;
>   					remote-endpoint = <&etf1_out_port>;
>   				};
>   			};



Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

