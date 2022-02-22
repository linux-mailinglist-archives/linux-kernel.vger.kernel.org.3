Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC864C0410
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiBVVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiBVVs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:48:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7D74DCD;
        Tue, 22 Feb 2022 13:48:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id A00891F42DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645566507;
        bh=AgYGHjexhKTkzbHlv7iW5IsUbYss5lL+060iqAyLlvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIcY+qfugfCKqmY96XmKSLJ8t3CWTMJ04f9BSGhLdx2wGJr8JiSFHIHYA+tNV9itK
         i/lz5Ll63lB5o3lxPPk3RvoQTBXgOg/EjyC4GcwRdCJifG37P3idfDtjIShLhOq7Ac
         WYjA7pOBmBLQ5t2aKEw57Z6Ab4oYlz4Vyr5pQBWAxDc9/RSDzzZpWcuITE4ZCS3X3s
         tmEu8wJuuydJhI29smm3Kyfrk6Ct8CGGcCuSptf5iLMZddoGdJJM3ozqOr+L6kNbc/
         TnDglFIW/hiw9+lPlZ0LPlnFU5dBKCpI2CqfKFI0LqCJ3nfYEfenJ+ejqZniSQdTDC
         hwK5I6SeWFLNw==
Date:   Tue, 22 Feb 2022 16:48:22 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 15/23] arm64: dts: mt8192: Add m4u and smi nodes
Message-ID: <20220222214822.3sxsbjrtm6ild6rx@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-16-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218091633.9368-16-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:25PM +0800, Allen-KH Cheng wrote:
> +		larb16: larb@1a00f000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1a00f000 0 0x1000>;
> +			mediatek,larb-id = <16>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&camsys_rawa CLK_CAM_RAWA_CAM>,
> +				 <&camsys_rawa CLK_CAM_RAWA_LARBX>;
> +			clock-names = "apb", "smi";
> +			mediatek,smi-id = <16>;

This mediatek,smi-id property isn't handled in the driver or mentioned in the
dt-binding, and seems redundant to mediatek,larb-id. So just drop it.

Other than that,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
