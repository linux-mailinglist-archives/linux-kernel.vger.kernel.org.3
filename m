Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF6E58A3CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiHDXL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:11:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F31902D;
        Thu,  4 Aug 2022 16:11:25 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A8376601AD1;
        Fri,  5 Aug 2022 00:11:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659654684;
        bh=d8bpUmqtai/1bwZEwBXzsGHcuijSaBnMTHwkrXO56tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFiM7Krsc/reEMWSfgyR+v9yvflTVqOWv5wp39o4YXTPMVH5asIxCFy3BdOPhMpM4
         r9/YWaFK9dWXErCotYCzZQNMrdBfOAB+RY5rdRXMwiz0FOuiiVWSHF/7uJD/uz27PC
         7ipDdVlWUjSuH0KPdnBysN2cqgY0hObckJsW+XSfXld4hJJ+6zXWAKRxj6FTT0sEI4
         cUrL1j6cYMhuMOd3TS1i9wsZ1Pj36c3e5Dg90ID/8XCcHBNsWLailX3koTLkRmr15X
         na3BlvgJuNS/ltnyJgFmAb32wBQBlM6Mbzdi1mMaQsxoYGTBEwG39ENrQMASnkPCSh
         QvxkB8Rp2C3Kg==
Date:   Thu, 4 Aug 2022 19:11:19 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8.1, 2/7] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Message-ID: <20220804231119.x6l2nl362rqvlk6u@notapiano>
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-3-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804130912.676043-3-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:09:07PM +0200, bchihi@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> new file mode 100644
> index 000000000000..53c44a73f3a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
[..]
> +  nvmem-cells:

       minItems: 1

since mt8192 only has one of them.

> +    items:
> +      - description: LVTS calibration data 1 for thermal sensors
> +      - description: LVTS calibration data 2 for thermal sensors
> +
> +  nvmem-cell-names:

Ditto.

Thanks,
Nícolas

> +    items:
> +      - const: lvts_calib_data1
> +      - const: lvts_calib_data2
[..]
