Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFD55D5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbiF1IPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbiF1IPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76972DABA;
        Tue, 28 Jun 2022 01:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E220461216;
        Tue, 28 Jun 2022 08:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A4C3411D;
        Tue, 28 Jun 2022 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404091;
        bh=xvgZ1Ec6k3SupDcAFTwZ0lBCn8TgbhhysOEQ6fUSeqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bn2fgRq3fgZptJFEmHELWk/tn6FYJsb/BryI8iqJJLFqyUosjq3RCPY7QluipJjWz
         0euGkekE2Ls3NHwnmZv+37t8lZt2SAEkUnYfqDiqb4z38bP/JlN/EN8AFDepxbKH67
         UHCgPl2MUH54U3DxSbqzlog5L7ZG/rCXcT2atuVYADzX/NagGjpb32C+mNdi/l5uvD
         eSRWO+NjTGZ5SKvgFY4f/GW7YMkT8NHhJ3lWVjeAYir7NDi6tdRbsEL15e+A2a7YDG
         gofdtA9jcaIVkKlIrABIL2UUSlBE/uCzmbztZQVJGvwW1TfuMq83tIvz1mjGlpVxPd
         OItm5tXc/c8Dg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o66My-000662-I6; Tue, 28 Jun 2022 10:14:48 +0200
Date:   Tue, 28 Jun 2022 10:14:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s
 devicetree
Message-ID: <Yrq4eOWAeKyGrQPo@hovoldconsulting.com>
References: <YrMVqifgV4kZaP7F@hovoldconsulting.com>
 <20220622132617.24604-1-johan+linaro@kernel.org>
 <96394aa2-aefc-63c4-d86f-15c06d092d75@somainline.org>
 <Yrq1FAscp+jE7GQs@hovoldconsulting.com>
 <00aefa9b-5d91-629b-9fa6-fadd6df5a469@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00aefa9b-5d91-629b-9fa6-fadd6df5a469@somainline.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:09:57AM +0200, Konrad Dybcio wrote:
> On 28.06.2022 10:00, Johan Hovold wrote:
> > On Mon, Jun 27, 2022 at 01:38:47PM +0200, Konrad Dybcio wrote:
> >> On 22.06.2022 15:26, Johan Hovold wrote:
> >>> Add an initial devicetree for the Lenovo Thinkpad X13s with support for
> >>> USB, backlight, keyboard, touchpad, touchscreen (to be verified), PMICs
> >>> and remoteprocs.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Krzysztof's tag wasn't here in the version I posted.
> Patchwork recently started pulling them in automatically when
> downloading a mbox file.

Please consider using b4 instead if you need to reply to patches.

Johan
