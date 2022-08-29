Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176445A55E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiH2VEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH2VEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EBD7E31C;
        Mon, 29 Aug 2022 14:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645AF611F8;
        Mon, 29 Aug 2022 21:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8FCC433D7;
        Mon, 29 Aug 2022 21:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661807051;
        bh=BDArk8/2LJG4f0JlM21frot7U4ElFgCGdWkTcw+GNrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLNBIu9Td+/t9fmiuV63RFNrmX+4JMVfBhrmcGSE96BFapYdzIYYh8RcQphz7k1iz
         CZ3SuEm/suUhALwjEkfNYk9eCIsLfXy4Z2dWolV85Hdm5M71fCn0NyWZ2iu46Gaygp
         N+AmdNp/oPGjTH5H4w1n9rLNe5wGuXKrANyj0EOcypNEG33T6SfexYjsbR4iItQjUc
         mbtefgnDmoBjH0sa46lAl5qiOPupyhdF+SOqlIFBkSg9EiMTWPcJfU3sBcuYHKia/e
         HN/kvHCZFfXusXi+zMjQ0mOxvlZlXq0gk9kCHX01FYPSnIOb3EA1jYxNTFqUwBwlIb
         gaiGx0dDJ8f1A==
Date:   Mon, 29 Aug 2022 16:04:08 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,rpmcc: Add compatible for
 SM6375
Message-ID: <20220829210408.gxbv6szxfwiiwrbv@builder.lan>
References: <20220716192714.454031-1-konrad.dybcio@somainline.org>
 <991f085e-ae79-bf67-d063-51484a0ba344@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991f085e-ae79-bf67-d063-51484a0ba344@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 08:30:13AM +0200, Krzysztof Kozlowski wrote:
> On 16/07/2022 21:27, Konrad Dybcio wrote:
> > Add a compatible for RPMCC on SM6375.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > index 9d296b89a8d0..f22febdfdce7 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > @@ -43,6 +43,7 @@ properties:
> >            - qcom,rpmcc-sdm660
> >            - qcom,rpmcc-sm6115
> >            - qcom,rpmcc-sm6125
> > +          - qcom,sm6375-rpmcc
> 
> I am fine with it, although this contradicts a bit
> https://lore.kernel.org/all/20220705161301.493364-1-krzysztof.kozlowski@linaro.org/
> 
> Would be nice to get Bjorn's opinion/preference on this.
> 

While global consistency is nice, I think we should just stick with
qcom,rpmcc-<soc>, to keep this binding nice and tidy.

Regards,
Bjorn

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof
