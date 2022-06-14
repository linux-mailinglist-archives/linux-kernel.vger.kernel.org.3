Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05154B509
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbiFNPrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFNPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:47:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F315427C4;
        Tue, 14 Jun 2022 08:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5663B8198A;
        Tue, 14 Jun 2022 15:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392BEC3411B;
        Tue, 14 Jun 2022 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655221628;
        bh=b22lZ+UrnJsF1tpdplHnqiydkGHLnNC8hvVtKauyzZA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q63HgsPDtKd771Qakfg55DRXv9QuQDcbBFKAtabwwr+5ACLM2YwdukCE26JceWJ6+
         DFE6szJKL0C61c5CZIOHvyTFliIamiivv4Ozt1+JmqGCsVG8YzFUXcPO6tFu2ycBsq
         erSzEvcBTuCpvr0I20ApwhIB7DBlGBove1g85QJPqoU5Og08irCaLdOJ/I7PGBt2Al
         b8fXZb5fnzbmYwbtxQqtdejJUAI+c2WxSYMAWHBhVixALvKeStL+NZaNZ9x0WyFKEw
         Q66gSRtY9owZz2Gy74+Sk2l5J+sUbcph8lxSEbNb3QHyPCBsM+OjFejxDrci/wd+ui
         zw5vFqs5wY6ZA==
Message-ID: <dbbcb0a4-e777-db84-b3cd-0a3659dd5092@kernel.org>
Date:   Tue, 14 Jun 2022 10:47:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] Add Chameleon v3 devicetree
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com
References: <20220603092354.141927-1-pan@semihalf.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220603092354.141927-1-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/22 04:23, Paweł Anikiel wrote:
> The Google Chameleon v3 is a board made for testing both video and audio
> interfaces of external devices. It acts as a base board for the
> Mercury+ AA1 module.
> 
> socfpga_arria10_mercury_aa1.dtsi and socfpga_arria10_chameleonv3.dts
> have also been sent to u-boot:
> https://lists.denx.de/pipermail/u-boot/2022-May/485107.html
> https://lists.denx.de/pipermail/u-boot/2022-May/485111.html
> 
> v4 changes:
>   - remove enclustra,mercury-aa1 from Arria 10 boards in dt-bindings
> 
> v3 changes:
>   - make seperate group for Chameleon v3 in dt-bindings
>   - add blank line after copyright header
> 
> v2 changes:
>   - split first patch into three
>   - move sdmmc-ecc node to socfpga_arria10.dtsi (instead of removing it entirely)
>   - use generic names for dts node names
>   - keep the enclustra,mercury-aa1 compatible
> 
> Paweł Anikiel (5):
>    ARM: dts: socfpga: Change Mercury+ AA1 dts to dtsi
>    ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10 dts
>    ARM: dts: socfpga: Add atsha204a node to Mercury+ AA1 dts
>    ARM: dts: socfpga: Add Google Chameleon v3 devicetree
>    dt-bindings: altera: Add Chameleon v3 board
> 
>   .../devicetree/bindings/arm/altera.yaml       |  9 +-
>   arch/arm/boot/dts/Makefile                    |  2 +-
>   arch/arm/boot/dts/socfpga_arria10.dtsi        | 10 +++
>   .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
>   ...1.dts => socfpga_arria10_mercury_aa1.dtsi} | 48 ++--------
>   5 files changed, 117 insertions(+), 42 deletions(-)
>   create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>   rename arch/arm/boot/dts/{socfpga_arria10_mercury_aa1.dts => socfpga_arria10_mercury_aa1.dtsi} (70%)
> 

Whole series applied!

Thanks,
Dinh
