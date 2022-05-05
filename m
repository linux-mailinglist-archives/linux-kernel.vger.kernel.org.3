Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6158051B7C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiEEGNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiEEGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:13:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598537BC0;
        Wed,  4 May 2022 23:09:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24569RBA039067;
        Thu, 5 May 2022 01:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651730968;
        bh=chtKfKi9u7JhqpHsYOv3fc2Cp6hTVUa04Y0qSDCul9s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=J7968Gekoogq4yQZ/VFMVf9yKcMiih7fW0qpww3zY9mC6LFZ9DUdZNpQWRgrl9MoM
         FYnq21eg2vvoqDx+FZhiK08uuuGiy05VobcF8jpbX93dUNpkzCdL5WtH1lrwgLSFL/
         D9CJxK3Ehd5h2GWKYhhBR+jWAlKf8GLxbWnTdDjQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24569RI4016516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 May 2022 01:09:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 5
 May 2022 01:09:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 5 May 2022 01:09:27 -0500
Received: from [172.24.219.78] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24569N1Q009111;
        Thu, 5 May 2022 01:09:24 -0500
Message-ID: <80ed87e2-c987-1421-842a-1040f95279bb@ti.com>
Date:   Thu, 5 May 2022 11:39:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/2] arm64: ti: k3-am62: Enable audio output
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20220427085053.14964-1-j-luthra@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20220427085053.14964-1-j-luthra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/22 14:20, Jai Luthra wrote:
> This patch series adds support for audio output via headphone jack on the 
> AM62-SK board. The jack is wired to TLV320AIC3106 (codec), which is 
> connected to McASP (serializer).
>
> The same 3.5mm jack can be used for combined playback+recording, but audio 
> input is currently disabled on McASP until further testing and debugging.
>
> For testing, please apply this series on top of 
> https://lore.kernel.org/all/20220427072954.8821-1-vigneshr@ti.com/ and
> https://lore.kernel.org/alsa-devel/20220422054001.3738-1-j-luthra@ti.com/
>
> v3:
> Fix regulator, clock and codec node names

The series looks good to me.

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

>
> v2:
> Move out the patch for sound/soc/ti/davinici-mcasp.c into a separate series
>
> v2: https://lore.kernel.org/all/20220422060052.8548-1-j-luthra@ti.com/
> v1: https://lore.kernel.org/all/20220421132224.8601-1-j-luthra@ti.com/
>
> Jai Luthra (1):
>   arm64: dts: ti: am625-sk: Add audio output support
>
> Jayesh Choudhary (1):
>   arm64: dts: ti: k3-am62-main: Add McASP nodes
>
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 89 ++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>
