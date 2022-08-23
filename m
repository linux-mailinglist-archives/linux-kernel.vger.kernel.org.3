Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310459ECB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiHWTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiHWTpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:45:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620CFBC81C;
        Tue, 23 Aug 2022 11:47:18 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 029976601E65;
        Tue, 23 Aug 2022 19:47:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661280436;
        bh=yvZ81keYhwI6G9e7JnIqRWODLEgNPMGKYnHuBSLuw5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOxcpNly5jz4ZfzlyvGKuCt/2JZYpTVvicwdFzsY8NSJP2fR5fEWwLVzSZPYP2dXD
         qQQYgIIqom+9AgdlxLQKBnefxPDWQDJH2AGSlhF5xrcrxwsQLXoOPNU7eWAh7Oz+p6
         yE82v1LU6up8+LSZ/DcXDZhy03GJ5+6T+g20A3eNVOKIGSAOVy+Z5SGgFNjt9u9LR0
         +sLYNGjNX8nqdS6tyORZGrvZpOt8Gis02jjDxXG5tuwUf0NFGtb9ugrEYKqXXKwB8Y
         +ajHow3J2rjrpOD/LKGnxsPrRe+0E0zevTcXqArW2XUrKOKdV3uylc5dQ2RSpISlVS
         xbIXEt2LLT7CQ==
Date:   Tue, 23 Aug 2022 14:47:05 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, eddie.huang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        fshao@chromium.org, sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] regulator: dt-bindings: mediatek: add mt6366
Message-ID: <20220823184705.6fdpczguait2la4v@notapiano>
References: <20220823123745.14061-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823123745.14061-1-zhiyong.tao@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 08:37:45PM +0800, Zhiyong Tao wrote:
> Add mt6366 regulator document
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
[..]
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
[..]
> +      "^buck-(vcore)-sshub$":

The parentheses here don't serve any purpose, so drop them.

> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
[..]
> +      "^ldo-vcn(33)-wifi$":

Ditto.

> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-vsram-(others)-sshub$":

Ditto.

> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
[..]
> +      "^ldo-vsim[2]$":

Based on the example, should be [12].

Thanks,
Nícolas

> +        type: object
[..]
> +            mt6366_vsim1_reg: ldo-vsim1 {
> +                regulator-enable-ramp-delay = <540>;
> +            };
[..]
> +            mt6366_vsim2_reg: ldo-vsim2 {
> +                regulator-enable-ramp-delay = <540>;
> +            };
[..]
