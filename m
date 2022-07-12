Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5A57197F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiGLMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiGLMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:11:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E85A474;
        Tue, 12 Jul 2022 05:11:17 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUp8r-1o23la41Qn-00QjGg; Tue, 12 Jul 2022 14:11:16 +0200
Received: by mail-yb1-f181.google.com with SMTP id g4so13565730ybg.9;
        Tue, 12 Jul 2022 05:11:15 -0700 (PDT)
X-Gm-Message-State: AJIora+1Lr1cvLsc4AlqV+YkOuCjky/g/o9+aVW+t4MQx27U6qeTzAyf
        giwRYNe+CCFUI1Lg9G7kftU9EkxFcMoBONCyQtk=
X-Google-Smtp-Source: AGRyM1vp7UnReXw8m+vPAVGuFyz0wyqIHLMPURrFlaroid+4yg7I9Shva7VkxiomVyWA1nkeG/dHW0BGheo4eUm7J1E=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr22157231ybc.480.1657627874679; Tue, 12
 Jul 2022 05:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
 <181f1d88b64.e2eb2601586551.453778983551010212@linux.beauty>
 <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com> <181f20d0403.121f433c8600165.2068876337784123868@linux.beauty>
In-Reply-To: <181f20d0403.121f433c8600165.2068876337784123868@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 14:10:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3bSYZyKV_BywQFE5vi5RE4WoPwspXfTtO1ycV1zQDbmw@mail.gmail.com>
Message-ID: <CAK8P3a3bSYZyKV_BywQFE5vi5RE4WoPwspXfTtO1ycV1zQDbmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Li Chen <me@linux.beauty>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+zjAhnLj95+ph1V+04ZyezVsXW3m6sCrtwFXluUV99lipKO4NdF
 mAEgpzpGlWFbao+AgoilRE37FQdcPyk1U9p/lYP1LlKPXLglU1lZkbRD/Vx/jPlaQLBKfF0
 4Qr5xWbLaNuHwt2pPm0tv9hWCqowia+LZ1FMGawOwxvw3zSOVXqlFtRhmsacXrW50BGnJNG
 JYnO8FDLhy6mG46f8Qrmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tHoxLQUteDw=:YxduVIBuHjw2g/yDkWz0jq
 wn7FOoMuQ/UHM86DOKWpYBxULK+nrBmxGqAZ3bMVADZSSLubHQPnS0yf/TnF/heEU9O3aPZ88
 ejzov7VWOyaQeLaEjqebEMirYsjrMm0PK2uBhCuFRjjhJeK4ij1tkI+Ggh6gbdDNNVngXG315
 wueP3aMQd9eT/TcluiractUJukw4MVd92FY0JC0CDL9H3v2OHbXgBiqE8xhLfdqlRzGvePPfD
 g2JE763x0KFn2IN0yP8n3brE3JJsG1unMfc6TZCf7my8/Vv3I0FlB1yrXuANCK6XSAKWmeXvA
 MsfnzZUN7YZhdapNpHbLfa55Kve+sV9kJGJntlBx48VpPdS261zamq0GxaqNs+5opQ5wlL08M
 tXS5Q3vB0M9zrWQRPVQ3Z2R7sj/F7MTkn+mccArOjXYt/yJ+t5PgbJGqfcWoHXiAuVbz0hWNa
 tPMsbCg2VEwwduFAwNCsM8OlOqAIFJmEfASdMYSXm0B4HDX0E/BsOp71QGrBE+oJWldyaM2Mb
 6lpIqXxaPXYm1mNAj+JlsDIhQnY8F6moBfK5eQ71TXpdDwKHuNfY7xv/QVxvTSF9KIecAB9Oq
 6RysTxkdvnyu545cY5FpiDr0hgClhWb0BH5ys6KSBy2ydfmzEFoT9s/uTCfgjzs5C9d9NCUk4
 6b5Rw4kgWKt6HAbvPhh5HBn7LS3njB/21l7y7wIpuvllE40a22VqfrPVJzKCMkeElpkQrDFaj
 levSiPr/NA61BGixZcJ/MHtu3WHCHto/9wdyww==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:55 PM Li Chen <me@linux.beauty> wrote:
>  >
>  > This is a common limitation that gets handled automatically by setting
>  > the dma_mask of the device through the dma-ranges property in DT.
>  > When the driver does dma_alloc_coherent() or similar to gets its buffer,
>  > it will then allocate pages below this boundary.
>
> Thanks for the tip! I wasn't aware that dma-ranges can be used by devices other than PCIe controllers.

You should actually have dma-ranges listed in the parent of any DMA master
capable device, to list the exact DMA capabilities. Without this, devices
fall back to the default 32-bit address limit, which would be correct for your
video device but is often wrong in other devices.

        Arnd
