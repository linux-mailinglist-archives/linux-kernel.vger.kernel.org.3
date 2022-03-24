Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F294E5DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiCXEBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiCXEBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 00:01:13 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 20:59:41 PDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.4.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE37CB0E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 20:59:40 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 74449400CDA3D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:36:24 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id XEGun4Nor9AGSXEGunyJZy; Wed, 23 Mar 2022 22:36:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YY7UYODrYfO6ZFztsolGDQLqpCq4yPVE6i5YAfHYLoI=; b=Lu6DKMvESPCdgSTJ80ut4y2GR3
        nI9Sd3kX26GC0KMddmbyXOkSrwlSGYeWxLJqMgtxRN54PhZGniVjoDaxFO5+0hjXH0Dj4+UxxnUyB
        PJEOh6US6naSa4YGzH5OSZJf0O32wh5hmcpOwU7KFKQfSUhMbz2ZT03tNUqaSFm4mrNXT9dU7ELla
        IhVmQ6V3D66/4sAKYWioQQdDr0fW9Bm/APeoqh4/VVjUSl4q8fJo059vKRpudunBjXyPJOo0X4281
        IK2lZMEs2dp4wLkBLHNDS4SesyUBzREeaNozE1q3SND5hlBuzCSJZtoTDyU/TyYpIkkv2vypJwB9T
        sDVXStJw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54414)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nXEGt-002d2j-Qp; Thu, 24 Mar 2022 03:36:23 +0000
Message-ID: <920c9f2a-77b6-4d68-a7c2-08967fab70cc@roeck-us.net>
Date:   Wed, 23 Mar 2022 20:36:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 1/2] dt-bindings: watchdog: Add watchdog yaml file for
 Sunplus SP7021
Content-Language: en-US
To:     Xiantao Hu <xt.hu@cqplus1.com>, krzk@kernel.org,
        wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, qinjian@cqplus1.com,
        Rob Herring <robh@kernel.org>
References: <20220324031805.61316-1-xt.hu@cqplus1.com>
 <20220324031805.61316-2-xt.hu@cqplus1.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220324031805.61316-2-xt.hu@cqplus1.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nXEGt-002d2j-Qp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54414
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 10
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 20:18, Xiantao Hu wrote:
> This adds the documentation for the devicetree bindings of the Sunplus
> SP7021 watchdog driver, found from SP7021 SoCs and newer.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v8:
>   - Addressed all comments from Krzysztof Kozlowski.
>     1.fix the title.
>     2.fix the lowercase hex in examples.
> 
>   .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 47 +++++++++++++++++++
>   MAINTAINERS                                   |  6 +++
>   2 files changed, 53 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> new file mode 100644
> index 000000000..d90271013
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/sunplus,sp7021-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SoCs Watchdog
> +
> +maintainers:
> +  - XianTao Hu <xt.hu@cqplus1.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-wdt
> +
> +  reg:
> +    items:
> +      - description: watchdog registers regions
> +      - description: miscellaneous control registers regions
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    watchdog: watchdog@9c000630 {
> +        compatible = "sunplus,sp7021-wdt";
> +        reg = <0x9c000630 0x08>, <0x9c000274 0x04>;
> +        clocks = <&clkc 0x24>;
> +        resets = <&rstc 0x14>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0f68d4a..efdc618a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18544,6 +18544,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
>   F:	drivers/rtc/rtc-sunplus.c
>   
> +SUNPLUS WATCHDOG DRIVER
> +M:	Xiantao Hu <xt.hu@cqplus1.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> +
>   SUPERH
>   M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>   M:	Rich Felker <dalias@libc.org>

