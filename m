Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB0554DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359006AbiFVOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358820AbiFVOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2DE21E38;
        Wed, 22 Jun 2022 07:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7783461CB1;
        Wed, 22 Jun 2022 14:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B0CC34114;
        Wed, 22 Jun 2022 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655909073;
        bh=DvOFF7F0A27YyDsZqMZhQnsZrCWCC28sBjO2oOSKtFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqemJjh7RAzid6Eqe2FpJ0pCHqf7rMsnpT74Q9lSTjNClC9uho60KjLHoNXGrUXSW
         wPfcbw7H1eYAC5IGAU1mFt/rv+g9Fn30E5DdMV5Kxg4iFi6xWiX4T83zQ+ucdX6KU2
         B86KfyHhGp95kdrBV2xwvySK6fjT3aKDhcEHiBvXe8AUl+PM/fWGtGHpsaMGpKbkHY
         cuxjN6Z/o9CL76CFInCmxfacK+GDcVlmh5ABben+Px1Fozmx4XnQmIRYBn5Zf6rvFN
         b/uGlfUN+urr0/nEsXl/gsVXG/IlfnvCUQlldKvnxxSOEN3kEa7Tv0aBhMNrEmA7Yt
         BhRgiT+48XBsA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o41ap-00071I-4d; Wed, 22 Jun 2022 16:44:31 +0200
Date:   Wed, 22 Jun 2022 16:44:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Message-ID: <YrMqz4P//iTfx0sz@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
 <YrMccQXwsz/zC/gl@hovoldconsulting.com>
 <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:36:35PM +0200, Konrad Dybcio wrote:
> 
> 
> On 22.06.2022 15:43, Johan Hovold wrote:
> > On Wed, Jun 22, 2022 at 02:33:02PM +0200, Konrad Dybcio wrote:
> >> On 22.06.2022 06:12, Bjorn Andersson wrote:
> > 
> >>> +&qup2_i2c5 {
> >>> +	clock-frequency = <400000>;
> >>> +
> >>> +	pinctrl-names = "default";
> >>> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> >>> +
> >>> +	status = "okay";
> >>> +
> >> I think all device DTs generally have 'status = "okay"' at the beginning. Should we change that?
> >>
> > 
> > No, quite the opposite, status go at the end.
> Then all other device DTs should be updated, as in dts/qcom/
> everybody keeps it first in non-SoC/PMIC files.

Seems like a lot of churn so maybe not worth it.

Johan
