Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B9650CBE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiDWPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiDWPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:43:52 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB229810;
        Sat, 23 Apr 2022 08:40:54 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so12295817oix.12;
        Sat, 23 Apr 2022 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzCcIN29nkpvI2UER8MH1YJgdnaztNku+DeAKFhxois=;
        b=bPS7lQeO3AQ9qev+LMicfaSd2cBgPI+se275RPpaKqQnwfecEh47E4m9+HnMlB0ezP
         t6O+ZVYNxjEDkV0BNMRbjM4IEZg+d8uXP/a7Emf+4OabAtCghFGftpb1bWV1mukLZ8qV
         RmdYuBQUi3GSKaz/iM2CI3M2EvqekDDUQVCXfQEbBLiLMYE7astTlYy5L2VXmKgRzj7B
         CoF26P+LzBc+1L4r/Xt1dgQnJlw+HDue2aR6QLVbKodN2yN4GD24YRBW4ltHto2V2ytr
         5lYcNiReAge0Gp2UGylopYkGkUeXhgvRDOBrifLjOVh7PF9pQeb4wISN00XN+b7O9Vf6
         MwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzCcIN29nkpvI2UER8MH1YJgdnaztNku+DeAKFhxois=;
        b=hg16LRLjvb1ddbAc7rP3ZOH/MDx/VdY2SiIbNeJv6MhAkT/0B9HUs0lXNhY0cQT2Z0
         UNLWnOfEmfbVSZ18lF8XHceyqkuxWvDCpERWCaZHKDauG4Xsdx9vq+UzUols91cnCjzX
         2IYUAj/PEnOnRUvRiq1QLkiDP5B8zCya19girCXq+mNv30y2zZnDIvqliwFU0WIv1+C1
         1h7cK/z/fFqsgwG0EtwFdX0X8sb1A0Wsp3TmLy+CvjC0STavdlgJr6wCQ+vekmyxTkEQ
         XBxdDNO7eLXVhHQ6BmlDThdZRcsEnymnsgmapkprwyrOgx3lTV5Ba2S5XV6WMFqbKpuE
         210w==
X-Gm-Message-State: AOAM530188DCOBOgCKR6fwFQdRDL4aKz6LPBNp8u1rm0N/qmHIX0tvPP
        udoxDrtYtGxDIl3ErEbzudMlK2PQYVz7EKYwfaKOOqvLhMc=
X-Google-Smtp-Source: ABdhPJwlk6fRtYGJNDzgjZpgoGD57WULA7uK7+foP97nQ4fYkNdwcgA5K3hCFaH4kNK0C2c1xex2GncA6WGM8t0RhGI=
X-Received: by 2002:a05:6808:2396:b0:325:b6e:6cf0 with SMTP id
 bp22-20020a056808239600b003250b6e6cf0mr943271oib.288.1650728453616; Sat, 23
 Apr 2022 08:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220409120819.3124209-1-gch981213@gmail.com>
In-Reply-To: <20220409120819.3124209-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 23 Apr 2022 23:40:41 +0800
Message-ID: <CAJsYDVJa+UAZNKsYCDSDjjN4NYWZ987y9d_rpaKnmH-Q9i=Nxw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] spi: add support for Mediatek SPI-NAND controller
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 8:08 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> Mediatek has an extended version of their NAND Flash Interface which
> has a SPI-NAND mode. In this mode, the controller can perform 1-bit
> spi-mem ops for up-to 0xa0 bytes and typical SPI-NAND single, dual
> and quad IO page cache ops with 2-byte address. Additionally, the
> page cache ops can be performed with ECC and auto data formatting
> using the ECC engine of the controller.

There are two missing register configurations in this series.
It wasn't affecting me back then because the bootloader set them
for me. I'll send a v6 soon.

-- 
Regards,
Chuanhong Guo
