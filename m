Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0032E501AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbiDNSN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344363AbiDNSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:13:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED6BD7DC;
        Thu, 14 Apr 2022 11:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99511B82916;
        Thu, 14 Apr 2022 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1598DC385A8;
        Thu, 14 Apr 2022 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649959857;
        bh=Vr1/XjezD3NvUbJqxkjZrZy8vhNpQh4QEIa1/5F2CfM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ACiMB9Yftk9UHhPUFqcBPZ1tkIzKUWtYU0lqQBzkTVEbJbISaqMDKjXFETqqEynXB
         uccW0B3Kya8PkQIPD/52rgNOzLfpDEh7PMcIMmeMtSoj/uvecY7AirsTLHSOnur7u+
         Nm1i2rQ0GEHj3DgLTXseZphJ61c1TSiKz4vqBuyFWHikTK40d72ccV/5E8yJwvUorA
         xhkG4HtKEF3C/biBG3ETPT0dxw8RDW+fCTPrw5o/udGdXwwW9mAgoWqiGPhcUf3Bow
         ELNWpLBn7aMPDlRJPy0ge2TywQpFJHOudWhJuBv+4XfhyvqzPEsudFrcXskGftaFmU
         uXSRym+6FZpag==
Message-ID: <be8ab691-98f1-5fb9-fec8-7213a2288d07@kernel.org>
Date:   Thu, 14 Apr 2022 21:10:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Martin Kepplinger <martink@posteo.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414083120.22535-1-a-govindraju@ti.com>
 <20220414083120.22535-2-a-govindraju@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220414083120.22535-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/04/2022 11:31, Aswath Govindraju wrote:
> Support for polling has been added in the driver, which will be used by
> default if interrupts property is not populated. Therefore, remove
> interrupts and interrupt-names from the required properties and add a note
> under interrupts property describing the above support in driver.
> 
> Suggested-by: Roger Quadros <rogerq@kernel.org>

I did not suggest to make interrupts optional by default.

What I suggested was that if a DT property exists to explicitly
indicate polling mode then interrupts are not required.

> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index a4c53b1f1af3..1c4b8c6233e5 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -25,6 +25,8 @@ properties:
>  
>    interrupts:
>      maxItems: 1
> +    description:
> +      If interrupts are not populated then by default polling will be used.
>  
>    interrupt-names:
>      items:
> @@ -33,8 +35,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names
>  
>  additionalProperties: true
>  

cheers,
-roger
