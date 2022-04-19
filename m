Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E296B507712
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356196AbiDSSJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356181AbiDSSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:09:25 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7D3CA4E;
        Tue, 19 Apr 2022 11:06:42 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id t15so11324320oie.1;
        Tue, 19 Apr 2022 11:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NogA4FJZbtSCeI8+16U8rTBVRGQdHqkH+cpZLhz0hdw=;
        b=pu0KIzJjb7uSRDSnQ1Pvc8cDzpiw5CYsBll9Sr+HwX9MHi4WUBeASeSzVQtzHxrjOK
         5wGW0x1ZEQ+ARTbuAO9qKeVwWNm/da3dnHG5tgegMFqVjwW1Vaix3H2kzsq0Hikbc1n3
         ZQvv/Ijon4N2Dn7jgYtX19Le580td6mXX+6LTkHT7atZf4HiNyl3p+EiPdGfPutjcD1b
         6u1qeZ01qsZTqmpNx20GNyYvt4YS/3tjY1lKGKdvNuVbLDqlFgbnYFQTwhOsJqyqO5ei
         vL5PUxs2N3SV9DyO0Pz1+GTxx0ETjBYhCKpNdav/b6O9NJIGLa5TV8lUghhrXblB7sKT
         uK1A==
X-Gm-Message-State: AOAM533qG1ifednwCSPefVW3XCWh9KxSDpUE+rFU5PJgCrAyg37HXp67
        N5Oyoooef7LobgtOu6klIQ==
X-Google-Smtp-Source: ABdhPJznkadX4VcGahV0tlYTHvdwn0UVoyP9HpXdmVeY58eg7G177LR5W+fg7x9LlsEeDaf/B9ZX9A==
X-Received: by 2002:a05:6808:150c:b0:322:88d3:74aa with SMTP id u12-20020a056808150c00b0032288d374aamr5211548oiw.245.1650391600207;
        Tue, 19 Apr 2022 11:06:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k14-20020a0568080e8e00b003224d35c729sm4531755oil.3.2022.04.19.11.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:06:39 -0700 (PDT)
Received: (nullmailer pid 3071252 invoked by uid 1000);
        Tue, 19 Apr 2022 18:06:38 -0000
Date:   Tue, 19 Apr 2022 13:06:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Joe Perches <joe@perches.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com, Rob Herring <robh+dt@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2 14/14] dt-bindings: pinctrl: add binding for Ralink
 RT3883 pinctrl
Message-ID: <Yl76LnVX8sNd1Bxj@robh.at.kernel.org>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
 <20220414173916.5552-15-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414173916.5552-15-arinc.unal@arinc9.com>
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

On Thu, 14 Apr 2022 20:39:16 +0300, Arınç ÜNAL wrote:
> Add binding for the Ralink RT3883 pin controller for RT3883 SoC.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,rt3883-pinctrl.yaml        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
