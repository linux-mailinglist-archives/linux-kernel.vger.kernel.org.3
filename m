Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049CA46B627
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhLGIkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:40:40 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53006 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233093AbhLGIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:40:39 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B71xGYE003241;
        Tue, 7 Dec 2021 09:36:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=H0RdRCe9r35PH+cGUXxi9Pl2iNpVWrQNSlKDf0Qq5Es=;
 b=NvG3SuPeVcHYMcUeywekfq3HEmNKckXki3QFqjwo5j2iCxmHh+ejD0gONJP3i3bhIgSw
 PGmdB7kd3x8Ky6l0jdO8skFJBO6NkrxthUb0VDUv2Nuu6IvvmuBySHpG5cilXczGabTV
 FpODdM7kCWITkNDme980XZl+Xlf+VXHxqydS7IY2AwlB7MNNxEPOInZXm7d2+J3/mdW4
 9vAxrj7aKuJskNutuKpIv4JySZZ80LFH3JZhMlXtMMm6L8TtO5BDhkJJdq3hZ+WJOvoT
 ZYK4OuurVc908Q59eB5aTLNLeLcehGABMLqWBpNAwrWq/IuzyS3HgukkeV55uz/2/vza LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csmx0kuf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:36:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 090A610002A;
        Tue,  7 Dec 2021 09:36:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2ED62265EF;
        Tue,  7 Dec 2021 09:36:50 +0100 (CET)
Received: from [10.211.7.5] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec
 2021 09:36:49 +0100
Subject: Re: [PATCH] dt-bindings: nvmem: Add missing 'reg' property
To:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>
CC:     <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Patrick DELAUNAY-SCND-02 <patrick.delaunay@foss.st.com>
References: <20211206174133.2296265-1-robh@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <0bfd3425-77f6-e00b-e7f9-581917c6dc99@foss.st.com>
Date:   Tue, 7 Dec 2021 09:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211206174133.2296265-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 6:41 PM, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the following warnings
> are generated in the nvmem examples:
> 
> Documentation/devicetree/bindings/nvmem/st,stm32-romem.example.dt.yaml: efuse@1fff7800: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/nvmem/rmem.example.dt.yaml: nvram@10000000: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/nvmem/brcm,nvram.example.dt.yaml: nvram@1eff0000: Unevaluated properties are not allowed ('reg' was unexpected)
> 
> Add the missing 'reg' property definition.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Rafał Miłecki <rafal@milecki.pl>
> Cc: Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml     | 3 +++
>  Documentation/devicetree/bindings/nvmem/rmem.yaml           | 3 +++
>  Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 3 +++
>  3 files changed, 9 insertions(+)

Hi Rob,

For the stm32-romem, you can add my:

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 58ff6b0bdb1a..8c3f0cd22821 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -24,6 +24,9 @@ properties:
>    compatible:
>      const: brcm,nvram
>  
> +  reg:
> +    maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:
> diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> index 1d85a0a30846..a4a755dcfc43 100644
> --- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> @@ -19,6 +19,9 @@ properties:
>            - raspberrypi,bootloader-config
>        - const: nvmem-rmem
>  
> +  reg:
> +    maxItems: 1
> +
>    no-map:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> index a48c8fa56bce..448a2678dc62 100644
> --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> @@ -24,6 +24,9 @@ properties:
>        - st,stm32f4-otp
>        - st,stm32mp15-bsec
>  
> +  reg:
> +    maxItems: 1
> +
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> 
