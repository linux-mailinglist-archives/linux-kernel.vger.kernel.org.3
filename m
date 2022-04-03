Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6984F0B0D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359334AbiDCQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351647AbiDCQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:03:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639F93980D;
        Sun,  3 Apr 2022 09:01:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h63so8535779iof.12;
        Sun, 03 Apr 2022 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KVd5HFtfdl/4YhzYTy1ARrs2qcreXKLJ20n7fqioxY=;
        b=Lc3foFpYddqhED8+lp1gUshprjqka20POXoZ1Fqvhx5Nuf5x+ISBeP4wT+FG5RetpP
         +LiHFJYLTcUeyRHXZoK/Fnxf4SzeKxG9hEvyNFvIlVHa/NDu8yAs+jOx/p8dbbPURno/
         I+zZ9pyY9vPwheJIa8DuATLYb9+Pygcx3vyKwPrDZr6FmrT6YMBiZSVRpI37m+BVSgim
         2QVaVx8PfrTW106nE4HAcyQNbop5Jbvu75mx2fPV48jft1UOsbVwYDhs36WntKG1fROW
         0rhTSnw6KvbXpCIiZ6jbVmx6cd6y8kIzTlo+g66AjvKmslg+BngMJb+PDr7NZJrrHdqI
         +Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KVd5HFtfdl/4YhzYTy1ARrs2qcreXKLJ20n7fqioxY=;
        b=ia5lT94sEhbhFXHJVGefJ/MLmoBe8kTz+CBuUYJVcyD/P+CQjLwzyZlQVSyQ119jfQ
         52+F9LF1ixI23DXiXEPHK0I5Q9oL2tGwHYgnFDGZcL7E9MrUvB9hU/BsYVG42Nb4cc5b
         njVk3qZ6SH+RJeXhPuhOR3lRHHgP4gizofsKDV7V9F2YAme7hssOk76XOgtP+xH14XYE
         Gok+YAyU96VksY4Nrlh+lkvNTY61iFxUq8GVO6uZeQu/STH2DyANGEAW70GgMI1hGTRn
         YRMsFhf2dlYiUTQ4rV9oa+c0OtY6ToTO2c1vQYYcHieX/4R8uR7KGNggFRn/90yMlvv9
         kV+w==
X-Gm-Message-State: AOAM533ZLggng7YuY4xc6Fa900x6LH1GTa68LN6dVQZc2ScMvUnkwtJm
        rFi6vySE21k9sCr/a5xx/qYh7kD3gtSRF2lLyug=
X-Google-Smtp-Source: ABdhPJwtM9rC5frTbOPfqFXajh8HCuXZAkrqVls+IUjlbS6KZoNTleMbBV69uFF+7VRl3sGXuqvc9T4HYSnSDMPqcSY=
X-Received: by 2002:a5e:9302:0:b0:648:c246:291 with SMTP id
 k2-20020a5e9302000000b00648c2460291mr3654500iom.88.1649001703873; Sun, 03 Apr
 2022 09:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220403131154.1267887-1-gch981213@gmail.com> <20220403131154.1267887-4-gch981213@gmail.com>
 <817dda10-39db-adfc-376d-a3d5e037937e@linaro.org> <CAJsYDVKYsz7c2yVe7TmPu_7kvBDXTih4+cceLsay2YJm21YntA@mail.gmail.com>
 <06ef6b4b-c8e8-549b-54be-9eecf59a7757@linaro.org>
In-Reply-To: <06ef6b4b-c8e8-549b-54be-9eecf59a7757@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 4 Apr 2022 00:01:32 +0800
Message-ID: <CAJsYDVK9UB=71Yj2t9Rc658W66Lf=uK6eLn5S+Y8Rj3skz4g+w@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
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

Hi!

On Sun, Apr 3, 2022 at 11:49 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> [...]
> >>> +
> >>> +  ecc-engine:
> >>
> >> The nand-chip.yaml defines a nand-ecc-engine, so how about using that
> >> one? I know mtk-nand.txt uses ecc-engine, but for new schema better to
> >> use properties from existing YAML.
> >
> > The ecc-engine code is shared between mtk_nand.c and this driver, and
> > the property name is defined in the shared part. I left it as-is so that
> > existing dt for mtk_nand doesn't break.
>
> This can be easily fixed with:
>         np = of_parse_phandle(of_node, "nand-ecc-engine", 0);
>         if (!np) {
>                 /* Backwards compatible */
>                 np = of_parse_phandle(of_node, "ecc-engine", 0);
>         }
>
> I would like to avoid having one property in generic NAND schema and
> keep adding something slightly different everywhere else.

OK. I'll add a commit for this in the next version.

-- 
Regards,
Chuanhong Guo
