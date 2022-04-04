Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F14F16D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbiDDORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDDORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:17:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F51FCDE;
        Mon,  4 Apr 2022 07:15:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z7so11419359iom.1;
        Mon, 04 Apr 2022 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5E21fn+577TVIeU8kFomfMeng4iJST9d5OAfTwxTna4=;
        b=WLjYGWfI8NieOzOaszwCD3go3mVW5B5I2+6Yg+OjcgoBVT7LMgFMz6W9axdgJItbWS
         kcNOl5cStadfExLLKu1xE9sG/bZt6/C3t0E0rkMUhT97PYyBmtMH6qcC8UJoejnKPJSW
         zUyrXFK85nzQBkDjkerQYx7AfBEO8Ed1TWxT4udvEf1T5G+3EPY4EACkL4d0Kp7UB+Ll
         zKiPdNxmZwIOuItE+UUMShHUPUoGhjVPS21SyhceuXkqX0zhq2MCbu1hMm0b2oYm6sCC
         Zi2FjqPaGKGlZSm3r6Ep1XtWCIDha1NmDS1Es3E2ck8hZA+Msy/JGHviUvTH1Awt+9QW
         puDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E21fn+577TVIeU8kFomfMeng4iJST9d5OAfTwxTna4=;
        b=RtI3Hy3XQlmpXXnsM4b47SM2ZKmUi8zoYYufleBQCCOZGgy8/2MZsEz3xH3gz3G6am
         DgsTEPPaiS3wSaa0taFzmSpg3gdYxa1fns4aEvPNt8VnfgBubb6x6A0HV/nNlJeMOcnl
         ghKWKWaRNSdfmuxusIVPuvh4ig4OLXegfUOehBXKl9L/0A/ey30SSzD8VdCc/etv6vJ3
         eahOEo2MY4RQczw5ODH2XlxPkmi+we4FjRfTq+hR8midiZTJiZzrtdxm2BTINKLh6EVM
         szJ39qdiUKpPVeZVNrqX2Uhx79F8LkIWVGEpPArHtHrpBijWxhQ8fA0OLuCLhuEreUeG
         lAwA==
X-Gm-Message-State: AOAM531pPX66foVxdXEwq+Y4Nv4HmNoyn+AwZBXzgkQ/jPM/fkybdrLJ
        RhkRvVqMC9EIBhSPA4opA6HovGBLaPmsGadpLa0=
X-Google-Smtp-Source: ABdhPJxbrZxaxxa23c8KuLbVlw6fjbA5zoUQwfxTtjRwR9H1HCw24823wBw9jzwWM0Oe8D9H9Q79Z4l3QqfPkd0Fz5k=
X-Received: by 2002:a6b:8e91:0:b0:645:c11f:e322 with SMTP id
 q139-20020a6b8e91000000b00645c11fe322mr113988iod.162.1649081734248; Mon, 04
 Apr 2022 07:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220404131818.1817794-1-gch981213@gmail.com> <20220404131818.1817794-5-gch981213@gmail.com>
 <14c921b5-4240-a026-252a-d5fb60836b34@linaro.org>
In-Reply-To: <14c921b5-4240-a026-252a-d5fb60836b34@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 4 Apr 2022 22:15:23 +0800
Message-ID: <CAJsYDVLY7HByymtd8kbdNGQ-oHMvpvU+CkWQgz+jOoANEwuKPQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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

On Mon, Apr 4, 2022 at 9:52 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> [...]
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - ecc-engine
>
> Slightly slow down resends (max 1 per day). You sent v3 without giving a
> chance to review this.

I made some big changes to the driver for other review comments so I
decided to send v3 for a review of the new version. I'll wait a bit next
time.

> Wrong name here.

Oops. I'll fix this in the next version.

--
Regards,
Chuanhong Guo
