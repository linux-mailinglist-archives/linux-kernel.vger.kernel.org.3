Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7748348D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiACQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:06:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50254 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiACQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:06:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B3D6115F;
        Mon,  3 Jan 2022 16:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7806EC36AEB;
        Mon,  3 Jan 2022 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641225995;
        bh=DKwn2a4a8WstTrBz3YaW8iPlQgOGN/W5/nC7S2XFzZQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Ynx9sCgtfBebo4tJlZiZKh0DkYZfGghQtMTz2vqmRzJbhuYU5Q2dSJMYKIbJ8i5sn
         3nDeJDMCXg/jmxxFz/YY7YUUbQ5XfLTq5u1SZBBGb4HGvZtiWOlfpiUkHinsp2p5OJ
         qrmXJsWNtkcTcgELDlHql50PV6PSfOnRynQbifGOXtK7GaLsUD6J8isnXK1ffazq+4
         HMNeueW1n/hCAK1v8ilC5EztFgSGVRQUcbQDnBCEhBaWAgC38G6qS2SsNB3VlzMWwZ
         c/QwuDjzZAxYrJzrbOaJsO/o2DNM11IRt17XGaaeuJOQk1Igtv2awQ5h+7QYmOEptl
         uTKl/1G+H3kpg==
Subject: Re: [PATCH 00/19] arm/arm64/dt-bindings: altera/intel: fix DTS and
 dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <32990891-1378-d20e-7caa-a807964aab36@kernel.org>
Date:   Mon, 3 Jan 2022 10:06:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/27/21 7:31 AM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Partial cleanup of Altera/Intel ARMv7 and ARMv8 DTS and bindings.
> 
> The patches are independent, unless touching same files (e.g.
> bindings/arm/altera.yaml).
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (19):
>    dt-bindings: vendor-prefixes: add Enclustra
>    dt-bindings: altera: document existing Cyclone 5 board compatibles
>    dt-bindings: altera: document Arria 5 based board compatibles
>    dt-bindings: altera: document Arria 10 based board compatibles
>    dt-bindings: altera: document VT compatibles
>    dt-bindings: altera: document Stratix 10 based board compatibles
>    dt-bindings: intel: document Agilex based board compatibles
>    dt-bindings: clock: intel,stratix10: convert to dtschema
>    dt-bindings: mmc: synopsys-dw-mshc: integrate Altera and Imagination
>    ARM: dts: arria5: add board compatible for SoCFPGA DK
>    ARM: dts: arria10: add board compatible for Mercury AA1
>    ARM: dts: arria10: add board compatible for SoCFPGA DK
>    arm64: dts: stratix10: add board compatible for SoCFPGA DK
>    arm64: dts: stratix10: move ARM timer out of SoC node
>    arm64: dts: stratix10: align mmc node names with dtschema
>    arm64: dts: stratix10: align regulator node names with dtschema
>    arm64: dts: agilex: add board compatible for SoCFPGA DK
>    arm64: dts: agilex: add board compatible for N5X DK
>    arm64: dts: agilex: align mmc node names with dtschema
> 
>   .../devicetree/bindings/arm/altera.yaml       | 46 ++++++++++++++++---
>   .../bindings/arm/intel,socfpga.yaml           | 26 +++++++++++
>   .../bindings/clock/intc_stratix10.txt         | 20 --------
>   .../bindings/clock/intel,stratix10.yaml       | 35 ++++++++++++++
>   .../devicetree/bindings/mmc/img-dw-mshc.txt   | 28 -----------
>   .../bindings/mmc/socfpga-dw-mshc.txt          | 23 ----------
>   .../bindings/mmc/synopsys-dw-mshc.yaml        |  5 +-
>   .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>   .../boot/dts/socfpga_arria10_mercury_aa1.dts  |  2 +-
>   arch/arm/boot/dts/socfpga_arria10_socdk.dtsi  |  2 +-
>   arch/arm/boot/dts/socfpga_arria5_socdk.dts    |  2 +-
>   .../boot/dts/altera/socfpga_stratix10.dtsi    | 21 +++++----
>   .../dts/altera/socfpga_stratix10_socdk.dts    |  3 +-
>   .../altera/socfpga_stratix10_socdk_nand.dts   |  3 +-
>   arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  2 +-
>   .../boot/dts/intel/socfpga_agilex_socdk.dts   |  1 +
>   .../dts/intel/socfpga_agilex_socdk_nand.dts   |  1 +
>   .../boot/dts/intel/socfpga_n5x_socdk.dts      |  1 +
>   18 files changed, 129 insertions(+), 94 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>   delete mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
>   create mode 100644 Documentation/devicetree/bindings/clock/intel,stratix10.yaml
>   delete mode 100644 Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
>   delete mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 

Applied for all SoCFPGA patches.

Thanks,
Dinh
