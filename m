Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B0554B96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351568AbiFVNnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFVNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:43:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298E186CE;
        Wed, 22 Jun 2022 06:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A977CE1EE3;
        Wed, 22 Jun 2022 13:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3617C3411B;
        Wed, 22 Jun 2022 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655905396;
        bh=jDB1Cmjv2ziK6j8aryAIRqu1467tjzlSp6wfYt0MFcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9T7cnqpV1WcPaC+DcszUY1WiRuvebMnlhf3ztL5usOyhUj45669V+TMotvdRzSlP
         7lzi5U4e5KFFtaYxQ/wXQ3AJ69QuY2S/3myFzi+CU+xPVvGtv13duHLyGy8dPsBuhk
         481Mh5vDgxWNSFl5HmYnj8a2h6V1Tf8PGzEv0iG2Y0bj4/erXlrPK8aJ2ht6uOnsY2
         fum0QCbgh6Dba32vUzJwy7jxesqCeiuzNo13MBYSWwjD6EFTnyuk03jVQER6CPJsmy
         Flt0CnVqSDjyabtcxKvtLs3t+gFqY9L4RQ+mU+WPZEYzSqXaPUVLbIn5x8+G/C3QmR
         8qVnRbymt79AA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o40dV-0006Ww-1e; Wed, 22 Jun 2022 15:43:13 +0200
Date:   Wed, 22 Jun 2022 15:43:13 +0200
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
Message-ID: <YrMccQXwsz/zC/gl@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:33:02PM +0200, Konrad Dybcio wrote:
> On 22.06.2022 06:12, Bjorn Andersson wrote:

> > +&qup2_i2c5 {
> > +	clock-frequency = <400000>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> > +
> > +	status = "okay";
> > +
> I think all device DTs generally have 'status = "okay"' at the beginning. Should we change that?
> 

No, quite the opposite, status go at the end.

(And please break your lines at 72 cols or so).

> > +
> > +/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
> This comment seems redundant.

Nope, it's a marker that explains why the pinctrl nodes are seemingly
out of sort order. We've decided to group them all at the end.

But sure "- additions to nodes defined in sc8280xp.dtsi" could be moved
since we also have PMIC pinctrl nodes here (as I just did for the x13s
dts).

> 
> > +
> > +&pmc8280_1_gpios {
> > +	edp_bl_en: edp-bl-en-state {
> > +		pins = "gpio8";
> > +		function = "normal";
> > +	};
> > +
> > +	edp_bl_reg_en: edp-bl-reg-en-state {
> > +		pins = "gpio9";
> > +		function = "normal";
> > +	};
> > +
> > +	misc_3p3_reg_en: misc-3p3-reg-en-state {
> > +		pins = "gpio1";
> > +		function = "normal";
> > +	};
> > +};

> > +	tpad_default: tpad-default-state {
> > +		int-n {
> If you aren't gonna add more pins to this touchpad block, I think you could drop this extra level.

You'd just lose information (what the pin is used for) with no real
gain.

> > +			pins = "gpio182";
> > +			function = "gpio";
> > +			bias-disable;
> > +		};
> > +	};

Johan
