Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC5516B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351879AbiEBIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiEBIGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:06:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079634B9D;
        Mon,  2 May 2022 01:02:29 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241LoNtB030224;
        Mon, 2 May 2022 10:01:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=tj8rMg2anSNrkXmaoqsySNf92r1jyTKtJTMppRQhTPU=;
 b=WF0I5L2w7456WlL4ftWLf7Ckx4EjnJ2VqbJv35SoHQ4ztlxr0uu5OdKuX0KwkRZ9XnwO
 6vhubTjHQveRxmNogvQNdpvYGf8M8DMGr8BnUSfkTDp+QtOk4vMwQsAU8IFuNn04Vc0S
 n/LXvc+Gv2ZXGK8XYJtZBxmR2k9g69hYRBrVrUg+NTSDcJO69OkYr0ZxroEr2ja954oi
 R7tPKqG614Li60kDqBswSrlMJ8rHm9a2+0LzWDt6IygNq3SfI3xa5EZAR9TGSAPtp52D
 PTax4AOKatXXDkfW5qSswybnlVAoVHBGwM6HEXvDKIlVWJMl/NYjkevYyHdqk+GNWIW+ Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt88fxsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 10:01:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B641710002A;
        Mon,  2 May 2022 10:01:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACB02212FBF;
        Mon,  2 May 2022 10:01:53 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 2 May
 2022 10:01:53 +0200
Message-ID: <0018dfe2-8279-fbdb-1c99-7c73570e2000@foss.st.com>
Date:   Mon, 2 May 2022 10:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: stm32: narrow DH STM32MP1 SoM
 boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Oleksij Rempel <o.rempel@pengutronix.de>
References: <20220425140436.332467-1-krzysztof.kozlowski@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220425140436.332467-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi krzysztof

On 4/25/22 16:04, Krzysztof Kozlowski wrote:
> The bindings for DH STM32MP1 SoM boards allows invalid combinations,
> e.g. st,stm32mp153 SoC on a dh,stm32mp157c-dhcom-som SoM.
> 
> Split the enums to properly match valid setups.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/arm/stm32/stm32.yaml  | 37 +++++++++++--------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index fa0a1b84122e..2f83f2760e6a 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -14,21 +14,6 @@ properties:
>       const: "/"
>     compatible:
>       oneOf:
> -      - description: DH STM32MP1 SoM based Boards
> -        items:
> -          - enum:
> -              - arrow,stm32mp157a-avenger96 # Avenger96
> -              - dh,stm32mp153c-dhcom-drc02
> -              - dh,stm32mp157c-dhcom-pdk2
> -              - dh,stm32mp157c-dhcom-picoitx
> -          - enum:
> -     Applied on stm32-next.

Thanks.
Alex         - dh,stm32mp153c-dhcom-som
> -              - dh,stm32mp157a-dhcor-som
> -              - dh,stm32mp157c-dhcom-som
> -          - enum:
> -              - st,stm32mp153
> -              - st,stm32mp157
> -
>         - description: emtrion STM32MP1 Argon based Boards
>           items:
>             - const: emtrion,stm32mp157c-emsbc-argon
> @@ -65,6 +50,13 @@ properties:
>             - enum:
>                 - st,stm32mp135f-dk
>             - const: st,stm32mp135
> +
> +      - description: DH STM32MP153 SoM based Boards
> +        items:
> +          - const: dh,stm32mp153c-dhcom-drc02
> +          - const: dh,stm32mp153c-dhcom-som
> +          - const: st,stm32mp153
> +
>         - items:
>             - enum:
>                 - shiratech,stm32mp157a-iot-box # IoT Box
> @@ -79,6 +71,21 @@ properties:
>             - const: st,stm32mp157c-ed1
>             - const: st,stm32mp157
>   
> +      - description: DH STM32MP1 SoM based Boards
> +        items:
> +          - enum:
> +              - arrow,stm32mp157a-avenger96 # Avenger96
> +          - const: dh,stm32mp157a-dhcor-som
> +          - const: st,stm32mp157
> +
> +      - description: DH STM32MP1 SoM based Boards
> +        items:
> +          - enum:
> +              - dh,stm32mp157c-dhcom-pdk2
> +              - dh,stm32mp157c-dhcom-picoitx
> +          - const: dh,stm32mp157c-dhcom-som
> +          - const: st,stm32mp157
> +
>         - description: Engicam i.Core STM32MP1 SoM based Boards
>           items:
>             - enum:

Applied on stm32-next.

Thanks.
Alex
