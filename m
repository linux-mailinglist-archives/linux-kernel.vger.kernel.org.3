Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991F567580
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiGERWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiGERWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:22:46 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD801FCE2;
        Tue,  5 Jul 2022 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657041761;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HFYLwNx1H8mjeDZMNkwynQXaKLcSPoHxU5fEPC/aXCs=;
    b=RwfwTDgJhnm3cucVgXUdFD6HkllRAJSb0TRzees0NoNV1aUDKowYOeFBGPOMzGjxuD
    uwgjWj0pTFoesUCzGIjFiUpONMvEwxpOu28CMTNUkp8KoUFX877OK8GzQ4u1A4JNTS9g
    wM3N8BnsZecYypOIooAhAUlwBpQRQKuEbTTZxIL7rVlTO1+9RcNHsaFrhgCNAHGYbuQ7
    bTX66XAAyBxwccZqpFnIopcujY+7ICZRiejuIMDtEdu/gtlG0ZD74qMCsvNv38h/VYAu
    fKbPcnxIlG5I2I+v/wyOB5G6fsEIJcFcmEG3ArdyxJAyTc/b/LZBEKa3llzPekS0X7dT
    57Wg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id yfdd30y65HMfJ52
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Jul 2022 19:22:41 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:22:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,sdm845: convert to dtschema
Message-ID: <YsRzYKAjA7LBVf86@gerhold.net>
References: <20220704153824.23226-1-krzysztof.kozlowski@linaro.org>
 <YsMaW6cO2fEfTGPz@gerhold.net>
 <61708384-6c29-6bb6-aef0-8bad061c1f7c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61708384-6c29-6bb6-aef0-8bad061c1f7c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:32:07AM +0200, Krzysztof Kozlowski wrote:
> On 04/07/2022 18:50, Stephan Gerhold wrote:
> > Can you check if you can just add the compatibles to the existing
> > qcom,sm8250.yaml? It should be more or less identical given that the DT
> > parsing code in the driver is shared between all these SoCs.
> > I already added the MSM8916 compatibles there a while ago.
> > 
> > It also documents some additional properties ("pin-switches", "widgets")
> > that are supported for SDM845 through the common code but are missing
> > in its binding documentation.
> 
> I thought about merging these but then I would have to disallow these
> properties, as I assumed these are not valid for SDM845. Are you saying
> that pin-switches and widgets are actually valid for SDM845?
> 

Yes. I haven't tested it but it's implemented in the common DT parsing
code and I don't see why it wouldn't work. These are optional properties
that are only needed in certain special audio configurations. There
might be a SDM845 board out there that needs them. :)

Thanks,
Stephan
