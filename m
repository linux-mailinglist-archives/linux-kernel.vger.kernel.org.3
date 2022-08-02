Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F395878C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiHBIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiHBIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:10:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2526D5;
        Tue,  2 Aug 2022 01:10:13 -0700 (PDT)
Received: from mail-ed1-f51.google.com ([209.85.208.51]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5gAG-1oLVk13t9e-007C6I; Tue, 02 Aug 2022 10:10:11 +0200
Received: by mail-ed1-f51.google.com with SMTP id w3so963814edc.2;
        Tue, 02 Aug 2022 01:10:11 -0700 (PDT)
X-Gm-Message-State: AJIora+2O9gaY5hbZ4oqjC8Wr8sYFyeQYvMGdO4Xq8Pbo9h1WReQsomp
        sJN+UWWh7lyV87B9Uq7sYmuO8D0d5mZ2Sf4P13k=
X-Google-Smtp-Source: AGRyM1v/HqHwbEDYWX+iBQTrBNjWYHzrWjUAqsUsM3oDd39cerR78g3FWoIIPreKizV2F5AVl2aftYbbgEROHwhpPbo=
X-Received: by 2002:a05:6402:3693:b0:43d:1a40:21fd with SMTP id
 ej19-20020a056402369300b0043d1a4021fdmr18891990edb.206.1659427811579; Tue, 02
 Aug 2022 01:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220802020819.1226454-1-sunliming@kylinos.cn>
In-Reply-To: <20220802020819.1226454-1-sunliming@kylinos.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Aug 2022 10:09:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0B7eAuTZx-ynoKHo2O49kPxwD5bXoS3G5utRriuH3Dcw@mail.gmail.com>
Message-ID: <CAK8P3a0B7eAuTZx-ynoKHo2O49kPxwD5bXoS3G5utRriuH3Dcw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sa1100: make variable sa1100dog_driver static
To:     sunliming <sunliming@kylinos.cn>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ufX2SafejYawHSK04SlcPYS2TjNFODc8KLsqVGlZiglCrGNASBx
 3zdNsDpereppXx9l0yNr5sAdrKeprzrhHUNv7pm71fySGHnR0c1ZAadQlkxcMFRohnerap9
 doRNydqZi951ON1NQtXVT6QNn0Eh8/JxodXy1AmvcBccvSLO6e2ofsXJhLqTmdC5unqv9hY
 /Nm3bwLtvQC1MR2Envkbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QwvWEWBpm+g=:VRsJuzbhfDYZ8Xx8Tmmrmh
 WVq0prnpdh7yRtZp4KMC4CPhzNLXDvgqU7KUe3h5H3SaQCoG+pBRAa3nLcL0N/Ll+erIqbker
 wnKspT+hLzwBu5BTutUOUY/TDVT2YgXWG4XOi9o4GwTB8V4K+6/1mNkasBY9wQ3E/yAV4lcMN
 F5wmwie7UOt36eaXQEJIqQJMUAErAUlNZe17XMUkyaH82SToz1CYa+bPfhQHDnHsmpC2siuwl
 dBGI6kE9CfL8SxkexHA18kj8ReMmGDgOP1tFx4Qldbo1jttnEzEx7q3OjXKfr0LfaPpaQeuea
 lMlBV7AaheAnF+cKk+cDl1N0dIxdxgokrUKRvY+67YBBo9v5NSqLgF0ci8i9pUuMYai3F1yKv
 O4hjoCr/iEZbaDOnPejFhsZBVjt8OFgZ20E+hgDQcVYbldDVJ6aOi8/iZ9SJewPamdw/9iWPQ
 hPT20IXVaA/WMieO1sK30werqJ5fzwvJh33dIVLnxtOfOFff1tTU6eHlOOffXVextxAmeJr4G
 YdEIX52UU+99vmzRcWiVU32ZOZ1LIafWW/Q0b21NxNtmQbOYkGfRZkK6nNSsWpu5X7vxsZSta
 lQxZ8TV7Wwe6Mg/qNhERB/ZNLwDmSLtNhPvg188EOgnRo3T5RgxEv/qd0KV5F1L1ubngqnedq
 Nx8XlBjZb3FraQ44/D5nNtchGVZAvrfM13IQ8UJnne7Al/OKX9FVhhH7lLgXsXyVed3nWy8fx
 H8shiRC5hWEAMykk6Z1vr75LtWQJL1Tsac4xWQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:08 AM sunliming <sunliming@kylinos.cn> wrote:
>
> This symbol is not used outside of sa1100_wdt.c, so marks it static.
>
> Fixes the following warning:
>
> >> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver'
> was not declared. Should it be static?
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
