Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72FF58073C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiGYWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiGYWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:22:14 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97971D0DD;
        Mon, 25 Jul 2022 15:22:13 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso9685153otv.3;
        Mon, 25 Jul 2022 15:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usnmbR/AmFXf0Qdhxn6n0uStsPRrPklSyxofovA7ixo=;
        b=xTSqRVqD2cgWiXMza5WUYWckF1BdgjaX+8Zdrlxz6ckOOCJGlqO4lGzo4lsOmeq7Lf
         m6ssv8xslq4Z0DDPyKdraApgH9QxMYbRc0Ldy1JXU7gH8uUaAWHFii20VR54HO4ot7wo
         1XC83ErSQx65arAoudFCnEXOEx2Zy4w/R5WEoESoB78F5MK9cWP9Tx99eiQpCOMt2tBW
         3wV43aNdbkeI5Gkc4PPD5Xj1e4qBKX6uqkXjqm9w6GFK8UPv453cj2BRksuec2uVZB/K
         XR698pOo2qc49UJBJ2/VtDoShlp6GlPn4HbpyIvCAdewQWO7uhkewyWJZwLb6xiqcM1P
         sJZg==
X-Gm-Message-State: AJIora9MAGj7NnZzMADwMQRAEVMQ8qvBWNo7rKGXPH0E8JkIgFc7++1a
        AslMsmEBUUFFEDVhqhU5/A==
X-Google-Smtp-Source: AGRyM1vN8EPdmzVTTKufoNx4fMFcuAy/FFxvpsZpHOw3pLDW7a+ZmZ+FUbbvHDo2ZRb7xwrcjSXdpw==
X-Received: by 2002:a05:6830:600f:b0:619:1d62:60c2 with SMTP id bx15-20020a056830600f00b006191d6260c2mr5553879otb.11.1658787732972;
        Mon, 25 Jul 2022 15:22:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v188-20020a4a5ac5000000b00435b646f160sm5316984ooa.5.2022.07.25.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:22:12 -0700 (PDT)
Received: (nullmailer pid 2848618 invoked by uid 1000);
        Mon, 25 Jul 2022 22:22:10 -0000
Date:   Mon, 25 Jul 2022 16:22:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: add compatible for rk356x to
 rockchip-inno-csi-dphy
Message-ID: <20220725222210.GA2848546-robh@kernel.org>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
 <20220720091527.1270365-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720091527.1270365-2-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 11:15:25 +0200, Michael Riesch wrote:
> The driver for the Innosilicon MIPI CSI DPHY is compatible with the variant
> in the Rockchip RK356x SoCs. Add the compatible string to the binding.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
