Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2064F2176
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiDEDIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiDEDIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:08:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF1137B37;
        Mon,  4 Apr 2022 19:56:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z7so13697536iom.1;
        Mon, 04 Apr 2022 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3yv5M0ISj3OX+DOMKzeUfYigLUei4YvBEe35BUC17o=;
        b=Iby+H9vRR0KxP8wmPtDjQoteNOmv+p844+8qA1h05FUmIW6offZ4WiuaCgWKkD5786
         2K4vaN0cJBuUjjSWl4P0i7kOAFoRFmzBZi5iSeXJNLZhQJ3vSph+J4pah8CZ+AOrTlkH
         K6D3s7I0Pct4kOQo8T4buUuUp2vy2MPMFLRUC809BtNucg4JQdP/qpNuzDgELI0QAjLu
         W16Lj6UvH+BhREZ+6vlIy+yeM6/n3URXWQHaPOxA99v5Ly9x09pe/og6JFll6Anhcefo
         hTxxzRcRxVlPUKvgeIw9jynwNv3OaL0dT6bLAoipXA2R/wXCgPjSBtEJHg3OtHVO3jGS
         AcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3yv5M0ISj3OX+DOMKzeUfYigLUei4YvBEe35BUC17o=;
        b=4Sm/31DR26C+DCb7aHc64fa3d1tZ0QUl7xtx+3IFfoXXniTLdwDMIbOhO2+XwLzChC
         CXEFtwR5bBgszOUtTnS8hV6jB9JyAhbd8RGaGgkXFqp0qtYaCrUyEkpiudo/ORINswwu
         IWxWlnEGarDMIJCIoCPygN+HeAAijXdEHgs2dtil/s5W8CNzdrGGj1f+s+nkEFhvIHpi
         rB9+h1jDBtED0DbjRiKiNFaiYmiBiGQJEz6i/YtLURORUoCwqGbnuw3UGuCbcJUKMPNA
         ITDRidph+Tav7avHzcL6tLB9PMnzkZfBA470xlb4nxm5AKn/Sc70qJf0MPbCRqMquMWk
         ujtw==
X-Gm-Message-State: AOAM531auA+VsD57DbWjKSry3QicDwK+ufDcaikgIegrwmgzpFQMNlUO
        gByYMpLpo/lz1/RyzyJA0y788pZIoIZ4J133vIk=
X-Google-Smtp-Source: ABdhPJw5IPJXC5+wEEp+ZE5Rd8BQ1UNxzVXfXqR1Eu2OFd1PaDiIVCwKZaHIurGuhLQhMFWhAJtYSP96dKLBe+/HEWo=
X-Received: by 2002:a05:6638:d16:b0:323:63cd:c144 with SMTP id
 q22-20020a0566380d1600b0032363cdc144mr841464jaj.76.1649127362523; Mon, 04 Apr
 2022 19:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220404131818.1817794-1-gch981213@gmail.com> <20220404131818.1817794-5-gch981213@gmail.com>
 <1649088538.050456.1436949.nullmailer@robh.at.kernel.org>
In-Reply-To: <1649088538.050456.1436949.nullmailer@robh.at.kernel.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Tue, 5 Apr 2022 10:55:51 +0800
Message-ID: <CAJsYDVLaXAoL=TcPun6rckcA_cdUS-zFy_7M6uCpfzX+jbQEag@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Roger Quadros <rogerq@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mediatek@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob!

On Tue, Apr 5, 2022 at 12:09 AM Rob Herring <robh@kernel.org> wrote:
> [...]
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.yaml: spi@1100d000: 'ecc-engine' is a required property
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dt.yaml:0:0: /example-0/soc/spi@1100d000/flash@0: failed to match any schema with compatible: ['spi-nand']

I ran the tests myself and it's only complaining about the ecc-engine name:

/home/user/src/kernels/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dtb:
spi@1100d000: 'ecc-engine' is a required property
From schema: /home/user/src/kernels/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml

It says nothing about the spi-nand part.
I'd like to keep the flash@0 node in the example to demonstrate the
nand-ecc-engine usage. What should I do?
-- 
Regards,
Chuanhong Guo
