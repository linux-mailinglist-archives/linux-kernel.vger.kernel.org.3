Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DBB532641
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiEXJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiEXJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D574DC6;
        Tue, 24 May 2022 02:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB486164F;
        Tue, 24 May 2022 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40DC385AA;
        Tue, 24 May 2022 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653383981;
        bh=CQoTVzWSYGPxn/PhSbq4IWD9fRMZJsmF2LJ5awP5PHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUS4ndvoSW4jDh9uLc2sMoq07gNQKuNlkXCVuvpm70SYFzpoFAVIw9+8bFTCS5nN4
         c2Vr7C0pSA+Z0ajJa7F653EIvX7VeAjvqA4Jd/0BPBXEQ8KgnsnDuK2tJDGkHkIhb6
         l848JIxyN0vasK+LwzRIdyhI5RwI42zCrF6xqRSyiyabinDErgtRRmPUS9yCpBHWca
         b68Et/UjPcwUZ9scNm9mVcKNByCcGx1XbhI/vGHTMWVWeTV6nbJhyo5nY2ZyMkxFHa
         sFYOVTSREW5+Scr5L4KD+ZL6Zxv6mU/VnGQkeNV1t5MOZ3lJpAqRcNcpG053nGMoXC
         e9WU0cYJ1UVcA==
Received: by pali.im (Postfix)
        id BF8C49ED; Tue, 24 May 2022 11:19:38 +0200 (CEST)
Date:   Tue, 24 May 2022 11:19:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/85xx: P2020: Add fsl,mpc8548-pmc node
Message-ID: <20220524091938.myq5pf4imaczgbqa@pali>
References: <20220506203621.26314-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506203621.26314-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 May 2022 22:36:21 Pali Rohár wrote:
> P2020 also contains Power Management Controller and their registers at
> offset 0xe0070 compatible with mpc8548. So add PMC node into DTS include
> file fsl/p2020si-post.dtsi

PING?

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/boot/dts/fsl/p2020si-post.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
> index 6345629524fe..81b9ab2119be 100644
> --- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
> @@ -201,4 +201,9 @@
>  		reg = <0xe0000 0x1000>;
>  		fsl,has-rstcr;
>  	};
> +
> +	pmc: power@e0070 {
> +		compatible = "fsl,mpc8548-pmc";
> +		reg = <0xe0070 0x20>;
> +	};
>  };
> -- 
> 2.20.1
> 
