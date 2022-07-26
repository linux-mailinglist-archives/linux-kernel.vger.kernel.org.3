Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AF581477
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiGZNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiGZNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:49:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC601E3D2;
        Tue, 26 Jul 2022 06:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC14BB80D85;
        Tue, 26 Jul 2022 13:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442B5C433C1;
        Tue, 26 Jul 2022 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658843355;
        bh=UeTNFIavRYlNM6ImztWf2sDr28qDh+uBem0cAPu6Ujs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyODEtk/FlqUR05C5bJZenFog/1aWw9nWqVtbJMZxdCXEqhY2W0iVIr5bQH+gWEdI
         jf7T/+f5IXl1EDDjD8qEjJntJ2IZ71HsF2l3Ojkfd1EO4J5jEDFRbw1POjYUfFndAG
         3DpTAgbxuoIDXFBrv3XYud/DbmgJMzYD1eNCpCeqvqXAZqF0W1SFrP8/Y9Sh9zw2Ao
         tSVX4XkiKMeVVhRWTfRv42481B76ESspRjbjn7wObyJvafhzzCOkjxebwWctDGQxJT
         jm17eFBiA+HvaE/TQjAGsltHfW3ILy80FFtiL33PX+Kj32hyTEhkzlAg+b2DkSAOUy
         hLRz95JbSiTwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oGKwA-0001ul-RT; Tue, 26 Jul 2022 15:49:27 +0200
Date:   Tue, 26 Jul 2022 15:49:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Message-ID: <Yt/w5lvPQF2pKlmY@hovoldconsulting.com>
References: <20220722143232.7903-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722143232.7903-1-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:02:32PM +0530, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes to sa8xxxp-auto.dtsi files. This will be base for many ADP boards
> to be introduced in near future.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
> 
> Changes since v1:
> - Add , after year 2022, in the license header
> - Rename the dtsi which is suitable for common to many ADP boards
> - Split the patch in introducing common dtsi file, and adding new board
>   file
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
>  .../arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi | 385 ++++++++++++++++++
>  2 files changed, 387 insertions(+), 376 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi

Not sure about the name; sa8540-adp.dtsi seems like a better choice, but
I'd need to know more about how these two relate to each other.

What differs between sa8295p-adp and sa8540p-adp? That should go in the
commit message too.

> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 9398f0349944..3cc92162ba02 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -2,388 +2,14 @@
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.

I'm pretty sure you can't claim copyright for just moving code around
(same for the new file).

>   */

Johan
