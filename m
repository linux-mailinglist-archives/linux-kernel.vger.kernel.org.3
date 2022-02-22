Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16E4C04DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiBVWqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiBVWqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:46:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BDA128654;
        Tue, 22 Feb 2022 14:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB140B81CBC;
        Tue, 22 Feb 2022 22:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ED9C340E8;
        Tue, 22 Feb 2022 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645569983;
        bh=LLT4WrCWsAxdRG3oj5sQHASvi7mABVFlwiXiKTc9jho=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=e7aVapXzFksl9tIgPeJVBB8c7ZxIRPTBHu6sxPIAk8mHXXpne/QsuiIgx0XI0Devs
         GPfsinjjA7dvEYuWTbx1awvR4qoKVf1GT1Yu4E6otdfdD46OUkReKapV6Q0/WRA6w7
         PiUpQuW9F5MqV83XUiEBjVSBHbbkvIM1E0mcV2nOzk+kDE2V5tCqWuPB1MhtJweahj
         NtYZrLOo9eRxwd/jc51pfyRR18jWTmaRO0WRRUrSV76FkBS7svbUtOKmv12jQ51GyZ
         Jo8JHMcZx+MduRsobWD56wl+V1Re5vwf0LP+c2cf7Yo37Qe+JTL3mB6sc9PAfQdQpz
         BX8WeHD6ZB6EA==
Message-ID: <64cbe961-30b9-7833-2be6-0c9661f02b2b@kernel.org>
Date:   Tue, 22 Feb 2022 16:46:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: usb: dwc2: fix compatible of Intel
 Agilex
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

All patches applied!

Thanks,
Dinh

On 2/18/22 10:15, Krzysztof Kozlowski wrote:
> Intel Agilex USB DWC2 node is used as compatible with generic snps,dwc2
> (just like Altera's Stratix10).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   Documentation/devicetree/bindings/usb/dwc2.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 481aaa09f3f2..048e352c531a 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -41,6 +41,7 @@ properties:
>                 - amlogic,meson8b-usb
>                 - amlogic,meson-gxbb-usb
>                 - amlogic,meson-g12a-usb
> +              - intel,socfpga-agilex-hsotg
>             - const: snps,dwc2
>         - const: amcc,dwc-otg
>         - const: apm,apm82181-dwc-otg
> @@ -53,7 +54,6 @@ properties:
>             - const: st,stm32mp15-hsotg
>             - const: snps,dwc2
>         - const: samsung,s3c6400-hsotg
> -      - const: intel,socfpga-agilex-hsotg
>   
>     reg:
>       maxItems: 1
