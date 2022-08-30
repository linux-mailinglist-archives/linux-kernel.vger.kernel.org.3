Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459BE5A59F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiH3D2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiH3D2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FFDA2DA3;
        Mon, 29 Aug 2022 20:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05D04B8161C;
        Tue, 30 Aug 2022 03:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD77EC433D6;
        Tue, 30 Aug 2022 03:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661830087;
        bh=fpJVDoUPfAFFVyClIW/ENZvoBFYy+UmZpu9qtnrnB+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENeJ5dUPJZqcO8ez5TrCm8VqtdFQfGQ5oMdc7tIacKzfhd35GaGFAX9n9c8GVEuXf
         n9N7JzvSPsLoPS3NrwwfyXTLEQSjMRU3HYgZsauXjrXf0x5liRH+87/qYeBrNocnsK
         G8sEul0GH7EM/k3aeGje37YcUu9exj5Sh7NqlDhVuPaNHsTDv1EaiQFgjw8qkRV6A5
         tEMYw+zCXVhclcsLgUesUqY8KyQGWDy8aaTQvxtUImMolCsoSDb+kY8vaECrHNpi/0
         WdhnR5vKyCD72S/4JQ3jch1poConoRi10pRYm9jr9Y9mmIgBTfVGJrJqElQqlnVWcT
         IQ+o79wtvLJfQ==
Date:   Mon, 29 Aug 2022 22:28:04 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     vkoul@kernel.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, david@ixit.cz, sboyd@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     bryan.odonoghue@linaro.org
Subject: Re: (subset) [PATCH 00/14] arm64/dt-bindings: mfd: qcom: SPMI PMIC
 fixes
Message-ID: <20220830032804.wurwqwrvhje3qfld@builder.lan>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
 <166182996519.340873.11988950576516786131.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166182996519.340873.11988950576516786131.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:26:43PM -0500, Bjorn Andersson wrote:
> On Sun, 28 Aug 2022 11:43:27 +0300, Krzysztof Kozlowski wrote:
> > The Qualcomm SPMI PMIC DT schema conversion was not really tested and several
> > issues in the bindings and DTS should be corrected.
> > 
> > 1. The DTS patches can go independently.
> > 2. The binding change continuous work of PWM reg fix and depends on it in
> >    context (diff hunk):
> >    https://lore.kernel.org/all/20220827145640.3530878-1-bryan.odonoghue@linaro.org/
> >    Binidings changes and above, can be taken via MFD tree (fixed commit was
> >    merged in v6.0-rc1).
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/14] ARM: dts: qcom: align SPMI PMIC ADC node name with dtschema
>         commit: 662e305dfc29b96913a03dde1e89e8968da65238
> [02/14] ARM: dts: qcom: pm8941: align SPMI PMIC LPG node name with dtschema
>         commit: 7b357d3126226b7ec4810e26f4ded44b2286d197
> [03/14] ARM: dts: qcom: pmx55: align SPMI PMIC Power-on node name with dtschema
>         commit: 4bdfd92cb14d97ef58600926ea6b2788b31c719f

Not sure what I did to trick b4 here, but I also merged 4-12.

Regards,
Bjorn
