Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B545438D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiFHQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbiFHQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB51C14F2;
        Wed,  8 Jun 2022 09:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9804DB828A5;
        Wed,  8 Jun 2022 16:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAECC34116;
        Wed,  8 Jun 2022 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654705493;
        bh=qbDIxo78te+eB8Fn0aTs9JNutyJfPowSyC5v29AtvOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUu0tt/0mQU6v+tmxBiIUwZXW+yAMPfobkaxbA+vg0lXh33oSaQjmPkMmt8cEs2mu
         LExj345EDd1J3l+eYVQipLav9LP4oywtRNJ6BfnPHPRuDziBJKQt7+fApAyQoefkTO
         nqsoXp4MYAIyul+l+bx5watENLV2/wVUE4CzTAoleUH90iUq+AVCOgsKGp8d6jVagf
         kTuiQnMX6bsUf/GDB31l7bFlOEleF29Rvt4TEfda3jQnY9wKvp4VCUb4snDhPu3Ewd
         l/r6AUpYznq3foHLBxC7XLi+yIrXs/VczoaQPuOQgRrGb38tDs8+pRF54Zm4cyQLkH
         1smrSE4AP1mnw==
Date:   Wed, 8 Jun 2022 21:54:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, kishon@ti.com, robh+dt@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH] dt-bindings: Update QCOM USB subsystem maintainer
 information
Message-ID: <YqDNUN7g6IVPMdQB@matsya>
References: <20220603021432.13365-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603021432.13365-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-06-22, 19:14, Wesley Cheng wrote:
> Update devicetree binding files with the proper maintainer, and updated
> contact email.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml       | 2 +-
>  .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml         | 2 +-
>  .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml  | 2 +-
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml            | 2 +-

pls split to per subsystem, phy, regulator and usb so that respective
maintainer can do the needful

-- 
~Vinod
