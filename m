Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AC4BF26B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiBVHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:08:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiBVHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:08:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B564B0EBC;
        Mon, 21 Feb 2022 23:08:18 -0800 (PST)
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2qrz1GCDzZfbC;
        Tue, 22 Feb 2022 15:03:47 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.21; Tue, 22
 Feb 2022 15:08:16 +0800
Message-ID: <62148BE0.7060501@hisilicon.com>
Date:   Tue, 22 Feb 2022 15:08:16 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add second HiSilicon
 prefix
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/2/21 16:22, Krzysztof Kozlowski wrote:
> There are few boards DTS using "hisi,rst-syscon" property -
> undocumented "hisi" prefix.  The property will not be changed in DTS to
> non-deprecated one, because of compatibility reasons.  Add deprecated
> "hisi" prefix to silence DT schema warnings.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: David Heidelberg <david@ixit.cz>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks!
Reviewed-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> 
> ---
> 
> See:
> https://lore.kernel.org/all/61AF1E3B.5060706@hisilicon.com/
> https://www.spinics.net/lists/arm-kernel/msg887577.html
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ebe294516937..79a172eaaaee 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -505,6 +505,9 @@ patternProperties:
>      description: Himax Technologies, Inc.
>    "^hirschmann,.*":
>      description: Hirschmann Automation and Control GmbH
> +  "^hisi,.*":
> +    description: HiSilicon Limited (deprecated, use hisilicon)
> +    deprecated: true
>    "^hisilicon,.*":
>      description: HiSilicon Limited.
>    "^hit,.*":
> 

