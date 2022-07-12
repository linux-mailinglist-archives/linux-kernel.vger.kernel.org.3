Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47DD571728
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiGLKVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGLKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:21:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B7ACF5D;
        Tue, 12 Jul 2022 03:21:03 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdNHa-1nc9JF0wls-00ZOxM; Tue, 12 Jul 2022 12:21:01 +0200
Received: by mail-yb1-f173.google.com with SMTP id 136so13148962ybl.5;
        Tue, 12 Jul 2022 03:21:00 -0700 (PDT)
X-Gm-Message-State: AJIora9BGr/85byGURXkGZi6AhKJ7Rsgu24rtZ/tG25+W2Sgak8izLVv
        RE4hYV31OHI4Sh+XelXi1Q1wNMDTJQ0ffrz4ptg=
X-Google-Smtp-Source: AGRyM1u0DfpNZFdtacLh454XdE0+/eSeOxQ9MmfhnisUAQEL792GTH29k4R54VpGVR8P2rYD8K6yZWp6ilnLKqt0FsQ=
X-Received: by 2002:a25:73d1:0:b0:66e:aee4:feb3 with SMTP id
 o200-20020a2573d1000000b0066eaee4feb3mr22274006ybc.452.1657621259882; Tue, 12
 Jul 2022 03:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
 <181f1d88b64.e2eb2601586551.453778983551010212@linux.beauty> <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com>
In-Reply-To: <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 12:20:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0hRmedaQpbKr1rJhHr6XZAqGnp0zmHgzz_Q5bwP6jE4A@mail.gmail.com>
Message-ID: <CAK8P3a0hRmedaQpbKr1rJhHr6XZAqGnp0zmHgzz_Q5bwP6jE4A@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Li Chen <me@linux.beauty>,
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
X-Provags-ID: V03:K1:OhWq2gQu4ykQh5L9z/AYaKpcig8BYTAwtIqFNUzQkyV76jRF6I2
 0xuhN+n6LeKTSY/gISejcWQjcM5lwKpEZfEdgUR+XFnW0xOXCST1LPdbj1sIG54fJkYvgoh
 75O+qFaXLXdTHIJlKWtjB8OJNpMg708crfjNRD3/wcNhokAFN3hsa7k9I+VqipaH1B3PJmq
 rwQ5oVLACrRftHZV10Uaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BF3DBGx3ui8=:x6gKsivD8BODwEjo3vB3R6
 dqrQkIWMWnk6WVFVyPHrvIVQwdLLGyBEl7Ditp6J3f1ocWolb13LO/IhJuXRdhmJ5mw2m1DxV
 Baf/RRAV8BkObEAnL4kEX7r/e3V6h0MFvqnOckWCfd4fxoCHNMvTzGcP+tkCR2VEZf37q6GEv
 FkADiopXmfNZ5msLcAmmkxgOCc7tHuBeOGN4v2HlXW0f/Mr82frm8rT45ORpuYNe0HfSde+/y
 OzS8qEVJVf/ubQLrVLDMXAr9d9gzbU4soa5DhCywtQ+VHV9jHXTZDB++5D/0iRYQO3niYDmXl
 Ts6mZ6JJPEmPjVtgqRzuObkT2abM3JS43asvZRZQhV96jEFoOcEA67EZyGvkdwqOmcS2fQtjB
 1R1yjul9C71vHsSWSmnmF10zKyQPYwxKCpMdsfEnclnlPNO6At54wO0jU+QYUheECId/QXDzM
 PStiwmAk5qlLKHfOEVh6k/pVmVgJwruWBHuJvO8YuJUGDqt4hDzmCFzRfGeJB6Ql3lO9OfpYr
 op0SU4SLzJLTTtJASJGVc/p8XfT4lkig2U7cxkJ/GiUULEaUuqXwyeu8FMpl/jfdMy4E9zjRv
 n55mQqBPGIIZ9xODn/Rg70KwcNJsfVYUhMT0Y8sxOY/bn6ii0fPY7Qox48weEDpGtTYpQBypM
 NHpkB8xgz7lHzVt94/VGMOS5wtmF/8p3nRG/ppzT7utQEOu352SRn7+JWLeI+8+ify0JhlUKM
 ruuGg2h+UskP0tnh+t+r9eEZxK0tyfxE9qV+lUhWaDb2cR7oYkMZbOdwGH/9fKIDptC1YjQKo
 KJEWLYIZ40vZYG1UbRUNl0ustOsz2GrV4CyvrzFFk+bPo7+z1V+OcRLMTiCtdD5CP8DD7Vjc5
 BohngiPyKoNW48vA0kz8NWMvaddaxtcJHr78ygiLU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 12, 2022 at 11:58 AM Li Chen <me@linux.beauty> wrote:
> >
> > The limitation is our DSP can only access 32bit memory, but total dram is > 4G, so I cannot use
> > "size = <...>" in our real case (it might get memory above 4G). I'm not sure if other vendors' DSP also has
> > this limitation, if so, how do they deal with it if throughput matters.
>
> This is a common limitation that gets handled automatically by setting
> the dma_mask of the device through the dma-ranges property in DT.
> When the driver does dma_alloc_coherent() or similar to gets its buffer,
> it will then allocate pages below this boundary.

To clarify: in the DT, you can either add a 'alloc-ranges' property to limit
where the CMA area gets allocated, or use a 'reg' property instead of the
'size' property to force a specific address. I would expect that in either
case, you get the type of memory area you want (a reserved set of
addresses with page structures that you can use for contiguous
allocations within the first 4GB), but it's possible that I'm missing
some more details here.

         Arnd
