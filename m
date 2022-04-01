Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7DD4EE95B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiDAHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiDAHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:55:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC3140C7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:53:18 -0700 (PDT)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5Q2f-1nZMc41MiD-001U4k for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022
 09:53:17 +0200
Received: by mail-wr1-f54.google.com with SMTP id i4so2989708wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:53:17 -0700 (PDT)
X-Gm-Message-State: AOAM533MrPHAaEurEsdxkil6j/oSz6C92HaKXJM9iBuE5vGWvVWUjyiW
        KzsD0zxG93Ixrw9Jg2qjYlmWh0RWdAXXBnSffhk=
X-Google-Smtp-Source: ABdhPJxusnK+u0DqKBkLuDZOOKI4/Zzi0nexaW+kVu52xIgMD7+d3FBFhk7GeTr34pvfDFosmtsJveIZUp+6B4PwU/8=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr6693841wrg.219.1648799596920; Fri, 01
 Apr 2022 00:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220401041615.3296387-1-jcmvbkbc@gmail.com> <CAK8P3a19-qtAg8GD8a9nG4ZPuyoDi3n39+zvHcRV-YdPJbJfKA@mail.gmail.com>
 <CAFCwf10hm4+WOa9JTNLTnEGtOGScOVu+PAXbk2=r+14u8d68VA@mail.gmail.com>
In-Reply-To: <CAFCwf10hm4+WOa9JTNLTnEGtOGScOVu+PAXbk2=r+14u8d68VA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Apr 2022 09:53:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a05=J6-utHZ682bVGb8bEZczLDEcFXsK7yXcbER5CRTDA@mail.gmail.com>
Message-ID: <CAK8P3a05=J6-utHZ682bVGb8bEZczLDEcFXsK7yXcbER5CRTDA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix build warning
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Max Filippov <jcmvbkbc@gmail.com>,
        Ohad Sharabi <osharabi@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gUryK+d737oRkj6KChzTzsB2DtmkjWe+raEzZUlbfDHfbG4GuUh
 q+K2i4oEkKef56HEab/Bus/FqUo1kSYGAaIagatst9DDSCNrrSJccE/xlW2g4o5MlxWRBW3
 MqrTfwmAY0O1Jf5aNy2zSOqjDAO0xkjjuj0lcQvEyJsMUdnw431eP2OGqxV4ftKPrz3Q4au
 i4JkRCw5PtMkj63CJz6QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:am+a0hmLgcY=:FhzXhqpSfeWX+Pe8RNLni4
 yLu85JFVlJnygYGReUvGYzfrEImZYCMCJBAG5iPMrsS8Ii2qXAZEMeEb3EKg/tl35dnKdWaXq
 EpcbNkV5zDX8JHWWlSm1keQmSwIHundBJZbMhx+w3l7RjKgX1OnyU+llhEthCm+lHs4yK4Y45
 c1wA/nf20a2knWPgrNYTTr3u2DK6eWh2+dSEnnEn8NRQ9l+koB7fdEefOGgUSL5W8H2S39UQ/
 K/JA6LN2dP+UcbiXr9C1y4dKUBVWyTBN+8Q327aAFoZv8XKon4pUtO3Zl/dNBG15P+QltDBIp
 Cl6fqEnsOj6Vejo1foK9Pu0QHQy6kC94bTA0SohnDp1zae5YNscmIGKvoKr7fE5eFU79vDMcZ
 fsbJE9ldvaKR6+vLJujha9tbghMbLDXc1F9w4E/aem73ZFI2ZvvbCdn/cW7YhWE39s7w2qjba
 NWDt9RKWnn1HxnANqC1M8BDjU3EQGMcI7R+x0IHI5mvRvdyIL3kEaT0KSEhbg8PHKFudVci0P
 W8JvelH6jt7ZFtpCEjGo3MtoAx0E9wXLFfdBDwW7AVKxDsRVBp5OW3nWDptaqZfDXYQlhGu7d
 66E3n4rqPbPcIzYu0YaTk3TvtKU8DJpuw+/YFrLddR6xQr5bwfY/VUIcIo5JCBQXDTEh01RS/
 oP11LQm36ioSUMBS4J4FnoN3b9r6bPPSkRcBYEo2EALR0g+/gluJuxx/ElYwnHaGd6gea2ZMR
 pOKi9XRD49DF+7FbX5lK2Z1fKhvpiadqCi+VctN59uo2ROazv2NjL9C17sU9xYzztQcuODgl1
 njv1p88RB/maJ3RYGFewlaA1zcQyQyVOBywb5vUpxirYQF42vQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 8:55 AM Oded Gabbay <ogabbay@kernel.org> wrote:
> On Fri, Apr 1, 2022 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Apr 1, 2022 at 6:16 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> We use gen_pool in this function to manage our device memory
> allocations (this is why it is called alloc_device_memory).

Ok, so it's none of the three I listed ;-)

> Basically, we initialize the genpool with the total size of the device memory,
> and each bit represents a page according to a fixed page size, which
> is dependent on asic type.
> The addresses represent the physical address of the device memory, as
> our device sees them.
> As these addresses are not accessible from the host, it is appropriate
> to hold them in u64, imo.
>
> For future asics which will support multiple page sizes, we need to
> use the gen_pool_dma_alloc_align() variant,
> because then we need the allocation to be aligned to the page size as
> requested by the user per allocation.
>
> We ignore the DMA address because this is device memory, not host memory.
> Therefore, our device's dma engine addresses the memory using the
> virtual memory addresses we assign to it in our device's MMU.
>
> Having said that, I'm wondering whether gen_pool_first_fit_align() can
> also work here, which might be less confusing.

Thank you for the explanation. I think the best way to make this less
confusing and to avoid the type casts would be to define your own
typedef for a device-internal address, and then wrap the allocator
functions such as gen_pool_dma_alloc_align() in helper functions that
do the type conversion safely.

       Arnd
