Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F4563BA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiGAU5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiGAU5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:57:46 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5068A01;
        Fri,  1 Jul 2022 13:57:42 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id l24so3346875ion.13;
        Fri, 01 Jul 2022 13:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wrd1tKb0ukMGehVRD4HY6PzNoWhwwKiujKNhXqXrfTA=;
        b=xUr6Gu2rybQEZL/1nDSbOlmkhuX/uDaFUVigtxtb/98bBBmfbykV8qNioU2uaseRas
         NgiqpsbM4+9phmlKDorTDTZmVzZ08UhWKIKHLfCcNK5glto0Id+1GMwH92k6AyVVc7ae
         s44QVYqJolYuMlsOpXqx7O/vksv4ry5XRMPHAbZQHKp//yZdDvkcX5xvDb4QoqxIaheq
         6/S8N3abdn9bD0greap0FAjWoRDrNaTYcVgxQR8/0HixtqgcWep2uoMg4w9Y0zY1lbv/
         KUau5OLzLTtMzVedCZDa+1ddF54hM0Dsja9ffYQ0y1HDP3/JhmDa3cZgm9nrYHca2bbZ
         oB7Q==
X-Gm-Message-State: AJIora/qWLgMGoBHXHBGvbi/dF4h+t1Wg9Ct7V8xjg0UdVbn4htQVFVG
        5DL3lDbopXl07H6To2JPjX/bcvw4oA==
X-Google-Smtp-Source: AGRyM1s2nL+i/VRJ0Dif3mbz/sX017+1VfxaQriSwMdUDZkqQQXwePTOLUGfM2JFY4es+43x3Vm3fA==
X-Received: by 2002:a05:6638:22c7:b0:333:f684:ccc4 with SMTP id j7-20020a05663822c700b00333f684ccc4mr10019992jat.57.1656709061730;
        Fri, 01 Jul 2022 13:57:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x11-20020a0566380cab00b00335c432c4b9sm10209572jad.136.2022.07.01.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:57:41 -0700 (PDT)
Received: (nullmailer pid 1517008 invoked by uid 1000);
        Fri, 01 Jul 2022 20:57:40 -0000
Date:   Fri, 1 Jul 2022 14:57:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 4/7] dt-bindings: pinctrl: sunxi: allow vcc-pi-supply
Message-ID: <20220701205740.GA1516792-robh@kernel.org>
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701112453.2310722-5-andre.przywara@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2022 12:24:50 +0100, Andre Przywara wrote:
> The Allwinner H616 SoC contains a VCC_PI pin, which supplies the voltage
> for GPIO port I.
> Extend the range of supply port names to include vcc-pi-supply to cover
> that.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
