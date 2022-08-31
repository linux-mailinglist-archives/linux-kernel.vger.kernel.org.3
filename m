Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5055A847B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiHaRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiHaRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:36:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4BA7A8C;
        Wed, 31 Aug 2022 10:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B99DB82208;
        Wed, 31 Aug 2022 17:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C83C43470;
        Wed, 31 Aug 2022 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967391;
        bh=yJab6UBBzoP5rTwF37tjjwA+4IJ1+TuOLBp6YmYoMMM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rNuVikaxps84sU1IM55mD06HmOXr7hFInyNzWXmrmQLDA0g3Q+phCmeOWCBK+3Gxl
         Gjp6tqTOptOUUKsOB7aZA09F28tCwUC4bwaS8N3+HGl0mHNlRGpZ9tktZGF+ApB/2S
         CjYd48kDu1xhMIPgdEFDn9PIif8YTfdKJumS8VSiUBHzHtj++1xm62apEZGNyGwPEM
         VZ/S18tiCKB/5P8rl+ho+eeb2MROWXyBVaUj7xytk9tYhZudRc8/MCMvAFGAF0dpgw
         Uz7hRINOerE/E4gu+ukB4TG5RgIvHnqx87HQ7qWfjooR0thnwwrWdTgZBNRyxUAdEV
         0688vxKWqw5EA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-9-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-9-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 08/10] dt-bindings: spmi: spmi-pmic-arb: make interrupt properties as optional
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        David Collins <collinsd@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:36:29 -0700
User-Agent: alot/0.10
Message-Id: <20220831173631.25C83C43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:44)
> From: David Collins <collinsd@codeaurora.org>
>=20
> Make all interrupt related properties as optional instead of
> required.  Some boards do not required PMIC IRQ support and it
> isn't needed to handle SPMI bus transactions, so specify it as
> optional.
>=20
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.ya=
ml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> index 55d379c..fee4f0e 100644
> --- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> @@ -88,9 +88,6 @@ properties:
>  required:
>    - compatible
>    - reg-names
> -  - interrupts
> -  - interrupt-names
> -  - '#interrupt-cells'

Let me clarify my comment on the next driver patch here. It looks like
we're making the properties optional here so that the driver can choose
to create or not create the irqchip based on the presence of the
property. Are there PMIC arbiters that don't have irq support? Or is it
only that some board designs don't use interrupt support of the PMIC,
because all the devices that use interrupts on the PMIC aren't enabled
(status =3D "okay")?

We shouldn't get into a situation where we're removing the interrupt
properties because we want the driver to skip creating the irqchip. That
makes the binding too loose, where we can't validate existing DT files.
It also makes it confusing to include the DTS files when the device
always supports interrupt capabilities, just we don't want to use it.
