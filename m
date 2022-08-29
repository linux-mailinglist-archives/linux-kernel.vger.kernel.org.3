Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468285A55E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiH2VFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiH2VFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:05:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A916599;
        Mon, 29 Aug 2022 14:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6812BCE13BA;
        Mon, 29 Aug 2022 21:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EF3C433C1;
        Mon, 29 Aug 2022 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661807096;
        bh=5hpPRHYf9qFbkrqFlXOdsCY3GcOVvhN/vwbOwXBIx54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKKdYB5der5YclBF3UKPnbMmC/whXqFq4RDgZMUqK6vdRHcm7WntBkJTg+oi7afcB
         P4Tnan4GxVVVGV8eNr7sfYgLoamJiqcT/fzL+DnaP89XxFC5b9N8heyeKjG5GHeIMw
         pV3KoFYeToglIiIE5zpeOSXMEqiEcYhnayem45yO0arE/ZsWTiWsTzXaSVDBN1JRKF
         3pb+hiUULFJU8poXbi1h5nPbuKbb/EQlwdCvHCn6rYCtxsbLkbde/105/rCwIQIpKg
         R2YPkKGJeYYttwOqPQXIt/BVRCNWoYHQrFs6zVx8DgzsgQ8h1ttf8vlCe4h/KLoWad
         Nj7i1fuOIYAJQ==
Date:   Mon, 29 Aug 2022 16:04:54 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: qcom,smd-rpm: Add a
 compatible for SM6375
Message-ID: <20220829210454.ffofiynm3rjgl2zj@builder.lan>
References: <20220716192743.454168-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716192743.454168-1-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 09:27:41PM +0200, Konrad Dybcio wrote:
> Document the compatible for SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> index cc1b35080162..3936654360d8 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> @@ -46,6 +46,7 @@ properties:
>        - qcom,rpm-sm6125
>        - qcom,rpm-qcm2290
>        - qcom,rpm-qcs404
> +      - qcom,sm6375-rpm

As with rpmcc, I think it would be cleaner just to stick with qcom,rpm-

Thanks,
Bjorn

>  
>    clock-controller:
>      $ref: /schemas/clock/qcom,rpmcc.yaml#
> -- 
> 2.37.0
> 
