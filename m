Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7C4F48BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385329AbiDEVtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457548AbiDEQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:10:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BF25CD;
        Tue,  5 Apr 2022 09:08:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id 8so9556552ilq.4;
        Tue, 05 Apr 2022 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hW77YXphKvERuG5H+iUJ9uDZUjTyhWglFK1sbd/bTfk=;
        b=fUC31B96e41c6xmeoqpvrYUa+mUJ1GYiAW7u8dnTGZSOQ7OWqfyoSDvmCBT+eQyqiM
         UNdcfy7aDYv4YEBK6yTK4m94iqB4mpunTxsY35VKeoiyjYBvjZlArvV/DuQ1TafofBsN
         B8jnMYbhZHuAtG0EsMlbVVyM5/HNlK6BRp6Hl4XkThnT78hLnj3HpF4llnx3+OYAEU5U
         x3+rpPlMUisFFcYPr6dB1CgV3FqngwVsHqBKUAIg5DreEgngpLsbr+alvkf5CRYW+Tcu
         pxzT1+QZCWMKPsEZ8VNqb0XAtv+y2b5SWNMcGsIME24NejuAZ2pboYge6GEjQcCKTQBQ
         O4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hW77YXphKvERuG5H+iUJ9uDZUjTyhWglFK1sbd/bTfk=;
        b=X3Yex+MEBVhAG3/uZ8d6gsQ+pFedAT/jzjz+4U5Hgt4rTpenIrhM/lOr3PiYAm2qwN
         eooQBUfQj6+umEpIiRTHC0B6HX7Ve1TKFNeqds0G2r+AXLkqI6qgNRPXtPOyoLJL33lw
         AqANT7Om+Fnxtsa1fMsywqU/0dJNGG3knh/PxXVe0+fIdlhe1YlQX5bQniTK4jz2Cksh
         nB6garagGC048M//npDyJZxD1IlwiG3cEffSnlKTViXy5VTpO2iRFCXMHT7/mvWpFVcV
         3ZRsnGQsOAN+KkjZIvhBQSBI0/RqFTm8DB1f1R9ikTmtC9ktDi/5wa+bfPSkVP3PBbap
         4vfg==
X-Gm-Message-State: AOAM531/ssIyQKmteSgBSeIGHIjitpNzfFsoI4H7luqs2hPB0Q7iVL1m
        nhTcDZHiZz8mh6VZsMKQr3WliDNvST5s7lwTGB8=
X-Google-Smtp-Source: ABdhPJz0ff0WGn+zTKCeGfDo2EgfINMJ8I4npVJmeR2s6MXHr0OMaXaR8zU6qWKRN7KTFA46Gm77KGlaYFiEhbvOSdU=
X-Received: by 2002:a92:7f11:0:b0:2ca:50f9:63d6 with SMTP id
 a17-20020a927f11000000b002ca50f963d6mr2222344ild.150.1649174906221; Tue, 05
 Apr 2022 09:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220404131818.1817794-1-gch981213@gmail.com> <20220404131818.1817794-5-gch981213@gmail.com>
 <1649088538.050456.1436949.nullmailer@robh.at.kernel.org> <CAJsYDVLaXAoL=TcPun6rckcA_cdUS-zFy_7M6uCpfzX+jbQEag@mail.gmail.com>
 <20220405092024.25d97c33@xps13> <YkxlsU+P33ip2oWH@robh.at.kernel.org>
In-Reply-To: <YkxlsU+P33ip2oWH@robh.at.kernel.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 6 Apr 2022 00:08:15 +0800
Message-ID: <CAJsYDVL_-dkxRsU24NmWA4KuHTVSJwjbr_9kcVcLao=LYSz+Jw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Roger Quadros <rogerq@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
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

Hi!

On Tue, Apr 5, 2022 at 11:52 PM Rob Herring <robh@kernel.org> wrote:
> > You can try including spi-nand.yaml (like you do with
> > spi-controller.yaml). You should no longer need to define
> > nand-ecc-engine then as it is already described there?
>
> Including spi-nand.yaml is wrong. If that just landed, then this may
> have run before the base moved to v5.18-rc1.

spi-nand.yaml is in v5.18 only and I'm able to reproduce the
spi-nand complaint by cherry-picking the commit to v5.17 and
running the check.
This means I don't need to do anything with the spi-nand error
then.
Thanks for the hint.

-- 
Regards,
Chuanhong Guo
