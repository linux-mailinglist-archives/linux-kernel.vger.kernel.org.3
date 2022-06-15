Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C24F54C442
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiFOJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiFOJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:06:44 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA563A1BA;
        Wed, 15 Jun 2022 02:06:43 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id d128so8259579qkg.8;
        Wed, 15 Jun 2022 02:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9DSawQVbU2xPshFF9LAgHn6cTfBWg4lJqDboKl63Hg=;
        b=oxqXk1GPotv4YU4ONPmbtUoj3arBsFCU6pwpeZOcM4t43ARLZhv+hyPkZeJApQCjlh
         vkxlG3GQj/a/WhWPMf92sPpMxin5CtIZ2sV5M0T7TBw5kakL8qNZlEIVurzkmyRDsboi
         9JCqMSy6yEMxq3MuuPwqgwNDdjzTm6WAKJYwGHrXJWzhhR2tPfRSBAMOWWvjYYj1O50q
         NKestzrZpfv+O8Irfi1a+FJarpVMwtursyFBffZbwNrhDQnMnPplcFpzeLH58W5eiTSL
         LHqneS4awccgqn9eyiQGK2ETvrNpAx5QfQdwOLj0TiRWswbb+TDNLY556Vm8Z3iA7bCJ
         O3jw==
X-Gm-Message-State: AOAM531iNRLFNoaT2syP8mSHX7OgpT5kSXPDPRs37fE9Y8YglVKyRqp0
        M2WTKek+1jmfrtn67KI52/u86xi/VJ0uMA==
X-Google-Smtp-Source: ABdhPJzARmoMsvzNGtBILu67fu7FgK8+hvxemVQRuhqjVg/UAEqojxgNKy0AkUS1zhV/ikrNHtb1yQ==
X-Received: by 2002:a05:620a:1324:b0:6a6:bc8e:e3cb with SMTP id p4-20020a05620a132400b006a6bc8ee3cbmr7500121qkj.130.1655284002612;
        Wed, 15 Jun 2022 02:06:42 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a0bd600b006a73ad95d40sm11984019qki.55.2022.06.15.02.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:06:42 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-30fa61b1a83so55137797b3.0;
        Wed, 15 Jun 2022 02:06:41 -0700 (PDT)
X-Received: by 2002:a81:6c46:0:b0:315:bb1:6a21 with SMTP id
 h67-20020a816c46000000b003150bb16a21mr5651903ywc.283.1655284001657; Wed, 15
 Jun 2022 02:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220613131033.10053-1-wsa+renesas@sang-engineering.com> <20220613131033.10053-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220613131033.10053-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 11:06:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-56GZmZJ-JvkFvZ6NsozsamtoKURPzsS-3+AYtZBhFQ@mail.gmail.com>
Message-ID: <CAMuHMdX-56GZmZJ-JvkFvZ6NsozsamtoKURPzsS-3+AYtZBhFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: spider-cpu: Switch from SCIF3 to HSCIF0
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for your patch!

On Mon, Jun 13, 2022 at 3:10 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Every loader before Linux utilizes HSCIF0 with a speed of 1843200bps.
> Make Linux behave the same.

Is that true for all boards? Was there a firmware flag day?
I.e. the U-Boot on the Spider in Magnus' lab has "baudrate=115200"
in its environment, while I can read the output from ICUMXA Loader
to U-Boot, and Linux just fine.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
