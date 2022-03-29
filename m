Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890244EAE31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiC2NQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiC2NQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAC639B;
        Tue, 29 Mar 2022 06:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20FE86154F;
        Tue, 29 Mar 2022 13:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04873C2BBE4;
        Tue, 29 Mar 2022 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648559668;
        bh=BUiGfVpPE2VIxewXuuuW8TDfj0IZzmLt4jyDJzc1e4U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PFKK2Ka2bFipYV22HyUJrbCDmogkwW+lH79Dg+PzXreiSriWdCq93ecnnzo89S/dj
         zrr/xhohQhOTYaTGNu5Nx8Wpk2kt1d+jnvUn1MvV2Zi2XYSEqmaRWjCBrCpdMstBXV
         PvwwDvXA3xOk+a7K8ardNiyCNM9VHkz7UPuERDZ26bCknQk38AKdO9B8DNYDHqgTDR
         Z6Oah3FflPvUgl0WdZm4yfaUOkWyS+wiMQxbz9camg5juIzOmjLcBlpDiTUvEohMm0
         sQsvTPlMTX2B4tIBJckvDK536G8BEDXT7wbXtc916DKWj6YsA0L3pWBaRiEpQEl2sE
         MqwS7XwTcSm4A==
Message-ID: <d4c477b3-0cf2-e495-6a54-5fcd0301cc14@kernel.org>
Date:   Tue, 29 Mar 2022 15:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, huziji@marvell.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
 <20220329000231.3544810-3-chris.packham@alliedtelesis.co.nz>
 <1648554629.870840.350362.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648554629.870840.350362.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2022 13:50, Rob Herring wrote:
> On Tue, 29 Mar 2022 13:02:31 +1300, Chris Packham wrote:
>> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
>> in-tree dts files don't validate because they use sdhci@ instead of mmc@
>> as required by the generic mmc-controller schema.
>>
>> The compatible "marvell,sdhci-xenon" was not documented in the old
>> binding but it accompanies the of "marvell,armada-3700-sdhci" in the
>> armada-37xx SoC dtsi so this combination is added to the new binding
>> document.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>
>> Notes:
>>     Changes in v4:
>>     - Add review from Krzysztof
>>     - Squash in addition of marvell,sdhci-xenon with an explanation in the
>>       commit message
>>     Changes in v3:
>>     - Don't accept ap807 without ap806
>>     - Add ref: string for pad-type
>>     Changes in v2:
>>     - Update MAINTAINERS entry
>>     - Incorporate feedback from Krzysztof
>>
>>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 276 insertions(+), 174 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.example.dt.yaml: mmc@aa0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['marvell,armada-3700-sdhci'] is too short
> 	'marvell,armada-3700-sdhci' is not one of ['marvell,armada-cp110-sdhci', 'marvell,armada-ap806-sdhci']
> 	'marvell,armada-ap807-sdhci' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.example.dt.yaml: mmc@ab0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['marvell,armada-3700-sdhci'] is too short
> 	'marvell,armada-3700-sdhci' is not one of ['marvell,armada-cp110-sdhci', 'marvell,armada-ap806-sdhci']
> 	'marvell,armada-ap807-sdhci' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> 
> doc reference errors (make refcheckdocs):

Chris, your own dt binding does not pass it's check (example)...

After updating the compatibles, you need to check the example. The
examples are anyway duplicating common stuff, so half of them could be
removed.


Best regards,
Krzysztof
