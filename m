Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6C593287
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiHOPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHOPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:53:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C7167F0;
        Mon, 15 Aug 2022 08:53:40 -0700 (PDT)
Received: from mail-ej1-f52.google.com ([209.85.218.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoNy4-1nZ8Nm252u-00olLR; Mon, 15 Aug 2022 17:53:38 +0200
Received: by mail-ej1-f52.google.com with SMTP id dc19so14207471ejb.12;
        Mon, 15 Aug 2022 08:53:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo2NTseA6Pvmml7k4+2NCcIgxy34kaHbmUZgLkzlMwlchjndPuYm
        K/BtvcXzQxpTDaS7ImyVyofw/x+u9VAnj1WesUY=
X-Google-Smtp-Source: AA6agR4kQH9OPkAoSzw4z/FBPTVCt5TcLJ18r0latd6JdISl5KaD+R3rrNlWHfqDqar+qTRK7WgfYWLgQGqiKgJkzhc=
X-Received: by 2002:a17:907:7609:b0:730:d70a:1efc with SMTP id
 jx9-20020a170907760900b00730d70a1efcmr10863122ejc.766.1660578818066; Mon, 15
 Aug 2022 08:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220815143959.1511278-1-zi.yan@sent.com>
In-Reply-To: <20220815143959.1511278-1-zi.yan@sent.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Aug 2022 17:53:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0TcnXHVsxBkpqLi63XC62Jkg3HChtK4RgB6-giYb+hnw@mail.gmail.com>
Message-ID: <CAK8P3a0TcnXHVsxBkpqLi63XC62Jkg3HChtK4RgB6-giYb+hnw@mail.gmail.com>
Subject: Re: [PATCH] arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Qin Jian <qinjian@cqplus1.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3bjhYaUEWRlYdBweOdn0b/r+O4N0rvYexq07UftB14ZHOZPuXV3
 lf+VE+qVUESCIDx6KaEUMMG9THzdxte70BFMMIzWObilU0QYz2yYfixDwrOATWDyZzFfm41
 EKOxtpxlmj1HyFW6mnhXFC004OOg6wbraTMVq2dUiiTDTpeiTmPIMs4SE2+57BOzNDFzKTB
 Mf6oS5ka0yNIz0ytZ5pJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGq+X3QRPxc=:WcCirK0x6sdExTy6/oiMGR
 d1jcWbA/eojZLQTurF3uPgfDqYzfS6ZJ1tqOMsqtYOu55Ks3yQMFUrLmxpxs9nvCbz66J2NDq
 fxzuUVz6uP6APSR7YJ7dNCnKyglNQfEhQ4YQ59w4XtsPw2Se29LW0WZWAAp4fAPAmbUHBRMYc
 Gio3uHfDrldBzrmci+ilPaPYx+5KeaCn2QViuMCADLPH2KEoxEsWDFJVRNK2+Yes5whbfH6fF
 3IvPZliBPUY3GMMwyUTFodJi7d5QekFW9OsnJJXfT4Et9LAv2a0G7nytufJlmMTuZNMpzIMn8
 TLpAmVlD4N1wgL4Q7WCX55nEWJ6jfyICIoxiW3xVtVUQbYZ3JGOyzHuePZEutdGipL8bi2L77
 MsJ/yVPvaNg/X7gqfuG+7LyBEEcFGi/6FDGuMOVoZrG30coFBLnAJFvITlbKvo3iypsjw0qhN
 W2r3vIkKrp3/q2C/7SlGj6ereOURTh9KssFsMkidFs9dNWyOxkKCwiKM+rIArz0O1zeoRPqUD
 Uprn+LAc+DA0N32ZmODos/UA2h6tCl0boAyPCHXrE48+kp/lqSoUX3QJb/VJWb4dy7rWJmyYD
 aVPxkpx9/478/XvN0C/bAuvvamWyBdjkLubzy480Ue7IAM+d+Mr7Ql31AGxj9TiRgb+H2NX+v
 +nyh/uaWNLYjZiFlsOMbXD5aXBFMPhSaybdfW5bwDjYtQOnzwbU80VAwtePswoiQKpPZywT1s
 pLDUSPx5lHpT79JeuxHV8ioN5wq0+XpMpKGBospdR0He7HBK0iHw7I62Q69VMEUuQORLey08r
 FL0O65PYJ0M+H/x1oQn2ixTL4qdINn+9JWyNFv7fqFZ31VwHT+pz+m9faLoglis0cP5TEXbuS
 8XjJZrS94wtWc86ne2jA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 4:39 PM Zi Yan <zi.yan@sent.com> wrote:
>
> ---
>  arch/arc/Kconfig                             | 2 +-
>  arch/arm/Kconfig                             | 2 +-
>  arch/arm/configs/imx_v6_v7_defconfig         | 2 +-
>  arch/arm/configs/milbeaut_m10v_defconfig     | 2 +-
>  arch/arm/configs/oxnas_v6_defconfig          | 2 +-
>  arch/arm/configs/pxa_defconfig               | 2 +-
>  arch/arm/configs/sama7_defconfig             | 2 +-
>  arch/arm/configs/sp7021_defconfig            | 2 +-
>  arch/arm64/Kconfig                           | 2 +-
>  arch/csky/Kconfig                            | 2 +-
>  arch/ia64/Kconfig                            | 2 +-
>  arch/ia64/include/asm/sparsemem.h            | 6 +++---
>  arch/loongarch/Kconfig                       | 2 +-
>  arch/m68k/Kconfig.cpu                        | 2 +-
>  arch/mips/Kconfig                            | 2 +-
>  arch/nios2/Kconfig                           | 2 +-
>  arch/powerpc/Kconfig                         | 2 +-
>  arch/powerpc/configs/85xx/ge_imp3a_defconfig | 2 +-
>  arch/powerpc/configs/fsl-emb-nonhw.config    | 2 +-
>  arch/sh/configs/ecovec24_defconfig           | 2 +-
>  arch/sh/mm/Kconfig                           | 2 +-
>  arch/sparc/Kconfig                           | 2 +-
>  arch/xtensa/Kconfig                          | 2 +-
>  include/linux/mmzone.h                       | 4 ++--

Acked-by: Arnd Bergmann <arnd@arndb.de>
