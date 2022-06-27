Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE4955CFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiF0OH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiF0OHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:07:53 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901312ACF;
        Mon, 27 Jun 2022 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lo8YsPDdBOH9TT2g4EDcAKIrZ1oPIx9jlxewAjSpJR8=; b=GwztnKaqgVXNeLdjQ27GbjeQig
        7IEjBiOFuO3QpNOJuRRs3caLXOo+ebAc77h1pDdN08p6caEyYaNPGznDtFiRCYh71WveiypxHc1ck
        HwRHLzSD9q74rgZSmjJPIQa5EDbRWXuiYnhRL2RYgSTsQaWBsdMfEZf5FeStlEKepEY2GL91+Cvc9
        5PAD5shGmKsn5yX+Q0MQpLJ4wKwm2NE0PtSXyzdAevrwN3gJI9qMW5l2k4ePRwoUO3+qp+yud/m4O
        +Wzafhf/CHT/pUlcM/qhxWraqs/SRpvF9FZnSPKsZ0HrUW3MDPOR5lrfOJXwy+kxtp7muOMo24k2q
        j+whfl2g==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o5pP0-006DLv-Bc; Mon, 27 Jun 2022 16:07:46 +0200
Date:   Mon, 27 Jun 2022 16:07:39 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/3] regulator: dt-bindings: qcom,smd-rpm: Add PM8909
Message-ID: <Yrm5q/2giqUDd0oa@kernkonzept.com>
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
 <20220623094614.1410180-3-stephan.gerhold@kernkonzept.com>
 <1656091594.427255.146351.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656091594.427255.146351.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:26:34AM -0600, Rob Herring wrote:
> On Thu, 23 Jun 2022 11:46:13 +0200, Stephan Gerhold wrote:
> > Document the "qcom,rpm-pm8909-regulators" compatible for describing
> > the regulators available in the PM8909 PMIC (controlled via the RPM
> > firmware).
> > 
> > PM8909 is very similar to the existing PM8916 but lacks 3 of the
> > regulators (s3, s4 and l16).
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> >  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> pm8994-regulators: 'vdd_lvs1_2' does not match any of the regexes: '.*-supply$', '^((s|l|lvs|5vs)[0-9]*)|(boost-bypass)|(bob)$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
> 	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
> 	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
> 

Thanks for the (automated) report, Rob! :)

The failure is unrelated to my patch. It seems to be a simple typo in
the device tree (not a mistake in the DT schema) so I posted a quick fix
in a separate patch:

https://lore.kernel.org/linux-arm-msm/20220627135938.2901871-1-stephan.gerhold@kernkonzept.com/

It should land separately through the Qualcomm tree so no need to wait
for it to be applied. :)

Thanks,
Stephan
