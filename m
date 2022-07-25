Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0A57FE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiGYL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiGYL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87217E29;
        Mon, 25 Jul 2022 04:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B68A560F6E;
        Mon, 25 Jul 2022 11:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE8C341C6;
        Mon, 25 Jul 2022 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658748422;
        bh=gyicn1Y/kmjxjCx7a/buwlQV+yyFDW2xvCQ1SbmZ9oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJZlq4rAbjvUwDrXAFY/7JGMJEWY5DamG5XCPq34ooyrnb4HRXZKtgbbH7VtCO/XX
         R59QlTqZ295hepmzCZyY1lipYYw5yBUkDSYJCD8M8++vSY6OFkZK4zsHO4lcFKTLtj
         iw/4VHovPjWdeyUlZuYJwyV55ohq0zrrVtyjq46OSGlGi0qijLqjcoM8/7IA0AhCbf
         hwA8GKXR2JM8O2PwlgTL26E/cKu2hI4nTLhLUJW87uynNJnzMZkjkTGFWTT+ZwThFi
         CMDKT6KFp9TJeZgmCcRhs0pV1F28s9cqq5m/cOtsnutUeWsCiiVqb3pTG8anConmNe
         7W9takm832Lsg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFwEz-0003mi-2P; Mon, 25 Jul 2022 13:27:13 +0200
Date:   Mon, 25 Jul 2022 13:27:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: qcom,ufs: add SC8280XP binding
Message-ID: <Yt5+EU529KriiAvE@hovoldconsulting.com>
References: <20220711101441.4896-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711101441.4896-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 12:14:41PM +0200, Johan Hovold wrote:
> Add SC8280XP to the DT schema.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Rob,

Will you be picking this one up?

There doesn't seem to be any other maintainers listed for this file in
case it's expected to go through some other tree.

>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index dcd32c10205a..f2d6298d926c 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,msm8994-ufshc
>            - qcom,msm8996-ufshc
>            - qcom,msm8998-ufshc
> +          - qcom,sc8280xp-ufshc
>            - qcom,sdm845-ufshc
>            - qcom,sm6350-ufshc
>            - qcom,sm8150-ufshc
> @@ -98,6 +99,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,msm8998-ufshc
> +              - qcom,sc8280xp-ufshc
>                - qcom,sm8250-ufshc
>                - qcom,sm8350-ufshc
>                - qcom,sm8450-ufshc

Johan
