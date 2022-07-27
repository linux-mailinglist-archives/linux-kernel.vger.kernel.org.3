Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07787581F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiG0FWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0FW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3C33334B;
        Tue, 26 Jul 2022 22:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC2360FFB;
        Wed, 27 Jul 2022 05:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D8C433C1;
        Wed, 27 Jul 2022 05:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658899342;
        bh=UWehIRE9q60XFILZMhHT7IsWYtVMdvIibhozslF4jrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRNtS+N+CUb5dAZx8Ijqf9EmFA1pYh4gX6BnTzhXRzOjra67D/TJaTmekkX6L+6Lu
         5oA0VfQuNOaffImYqp9VnqOJfwK6QGpPEdCEzrH1KroWygDZ/ZIV6C0hZ0wMq1zaFn
         0g14uYJbtRgCyG5QQ80bTfsuOd4AI63gRJhiAhX5b51uFDaLh0FF4dZs3D+xlDQN+F
         n5UlXVnIzFHnbHOMTRwd5xhorUH2grFR+ufvzgaaUJ5em+OSUthRkViBfnEY4i5wJG
         6NiS485janYtM2Y5Cuo6GtKyKQBVO960gaik1hhZ4Jca0Czz3sD/i6FpwA9+16XrUf
         KpdleZ7Q8PV/w==
Date:   Wed, 27 Jul 2022 10:52:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: reset: qcom,pon: use absolute
 path to other schema
Message-ID: <YuDLiZLCa9PK/XJo@matsya>
References: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
 <20220726120215.101868-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726120215.101868-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-22, 14:02, Krzysztof Kozlowski wrote:
> Absolute path to other DT schema is preferred over relative one.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 353f155df0f4..e8ecb75155db 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -30,11 +30,11 @@ properties:
>  
>    pwrkey:
>      type: object
> -    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> +    $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
>  
>    resin:
>      type: object
> -    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> +    $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
>  
>  required:
>    - compatible
> -- 
> 2.34.1

-- 
~Vinod
