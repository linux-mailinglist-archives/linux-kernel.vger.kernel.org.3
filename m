Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3255477D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350092AbiFVIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiFVIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:47:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F1E396A2;
        Wed, 22 Jun 2022 01:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DCA5B81CEE;
        Wed, 22 Jun 2022 08:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD63CC34114;
        Wed, 22 Jun 2022 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655887631;
        bh=9Cic3CRnN/+87wCqzwhlvsAQjVOpaTeW1l6o5THs8CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVkLQHWzW3Yw9TVz2dzzKzeR+QnUq7x4+bB64283XnsAVsrEODYwYX6FfUrgY6xrH
         nutrHVc3eirGnmejV5vkOXo90XofpO/yl0Uj3Kaqn1ip/DQJU76WjxQtCj+4DrQQ0n
         G81OuSPJX0C9G6bABNgG6GrkH3f+4cAjBS3l7tGWXHxKzKlo9MwjsDe2SM5YFp7Cqt
         iBHl/ezc/P6nuNMx312+xM2QzF9gSNAnj4aw8Lu4XIqg0PWcLad7EskZK8x4obrTXc
         Rm2ocVRqmeukupGMAZEPk2zTFv1VGor1JiiXNfHTEQtCc+kURThcfDNSdxo/xn56p5
         F79Cz7Y6CW/4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3w0x-0002Su-Ct; Wed, 22 Jun 2022 10:47:07 +0200
Date:   Wed, 22 Jun 2022 10:47:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: qcom: Document additional
 sc8280xp devices
Message-ID: <YrLXCx90bn7Id4Bn@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041224.627803-2-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:19PM -0700, Bjorn Andersson wrote:
> Add the CRD (Customer Reference Design?) and the Lenovo Thinkpad X13s to

Qualcomm refers to "Compute Reference Design", for example, in commit
427b249504ea ("arm64: dts: qcom: sc7280-crd: Add device tree files for
CRD").

> the valid device compatibles found on the sc8280xp platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Added the two missing board compatibles
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 5c06d1bfc046..6ec7521be19d 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -238,6 +238,8 @@ properties:
>  
>        - items:
>            - enum:
> +              - lenovo,thinkpad-x13s
> +              - qcom,sc8280xp-crd
>                - qcom,sc8280xp-qrd

I believe the "qcom,sc8280xp-qrd" entry was a mistake and should have
been "-crd" all along? Perhaps you should remove that entry in this
patch.

>            - const: qcom,sc8280xp

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
