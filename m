Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829D34CA97E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiCBPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbiCBPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A9275E6;
        Wed,  2 Mar 2022 07:48:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7E05B82028;
        Wed,  2 Mar 2022 15:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E107AC004E1;
        Wed,  2 Mar 2022 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236101;
        bh=FPM8oLhYd2J9SAy75EjN4wmweoyxo+whfwBwWJUBtuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myPLF2jOHPfJ7wFo15FmKJiSOlPBb04iVcqudXs8T88MFCKgYVdaGOjm7j13MEsDl
         ad8YcetwU7+LvNgFa2NDbq62p0L9fjVhb70axCckQy7A8cNKdsLRyF+MXZ/DIF3gmp
         jRd0DRrOii+Ihe+TmX9omRZkK8CneEa2p/Dxotg6XMI03gqSW7E3l3fcxe0f8Xrr1X
         4eBth5y0u4eKnv/sfg81mv3eLIRfg6WRNdR6HKQXqL1I1D8IRYlJ+LueE/KrT+SnqW
         sZS/ib+p5PKKMIyoTUwcdpH5oMd9zPro5rPw+fd8n/GichDN3ymgW8OVma/tMKS0eR
         xQUN87mED8aQA==
Date:   Wed, 2 Mar 2022 21:18:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 3/3] dt-bindings: soundwire: qcom: Add bindings for
 audio CSR reset control property
Message-ID: <Yh+RwQS1Cyeuq4Jf@matsya>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 18:13, Srinivasa Rao Mandadapu wrote:
> Update description for audio CSR reset control property, which is
> required for latest chipsets to allow software enabling in CGCR HCLK register.

too many acronyms pls explain!

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> index b93a2b3..84c8f54 100644
> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> @@ -150,6 +150,18 @@ board specific bus parameters.
>  		    or applicable for the respective data port.
>  		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>  
> +- reset:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: Should specify the SoundWire audio CSR reset controller interface,
> +		    which is required for SoundWire version 1.6.0 and above.
> +
> +- reset-names:
> +	Usage: optional
> +	Value type: <stringlist>
> +	Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
> +		    controller interface.
> +

We should add these in example as well...

>  Note:
>  	More Information on detail of encoding of these fields can be
>  found in MIPI Alliance SoundWire 1.0 Specifications.
> -- 
> 2.7.4

-- 
~Vinod
