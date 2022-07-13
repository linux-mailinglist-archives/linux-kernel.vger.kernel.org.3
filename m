Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86CC573180
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiGMIsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jul 2022 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiGMIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:48:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353EFB5B;
        Wed, 13 Jul 2022 01:48:33 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MN5aF-1ntBob0jMz-00J0b0; Wed, 13 Jul 2022 10:48:32 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31caffa4a45so105632547b3.3;
        Wed, 13 Jul 2022 01:48:31 -0700 (PDT)
X-Gm-Message-State: AJIora8y6z6uYZh3PhIula2m8MLgT/2NIfjavDr0qbSOkHyXxmlEhuQT
        j8OrvOYyeYjs8Y1VcB5gkQiDsymoSKrKzp2ykIk=
X-Google-Smtp-Source: AGRyM1vMr+hSc6XskeD23TlpGSLGsRTL4NEsYvdeNOBHcA1yUcy1PSuMux1dEngAH38Zd7x/dWUVbgkF4avt9/jahz0=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr2817622ywe.320.1657702110838; Wed, 13
 Jul 2022 01:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220704025632.235968-1-renzhijie2@huawei.com>
 <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com> <df9909dc-3303-808e-575a-47190f636279@huawei.com>
In-Reply-To: <df9909dc-3303-808e-575a-47190f636279@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Jul 2022 10:48:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
Message-ID: <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, stanley.chu@mediatek.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gDaUUwadwRbJVvwyOuBr1OgzQBq2pJdQ83hIa3JyWYcdFgGNyRW
 T14G+lOpGsMt9q8Iq2qnhkiNSsfJp4ymDt3WxArrdWScrM/4IyaWg9KtLFN9p47bHfwxz14
 iLPunpO/wd2Keo1A0nqIxH9zoCGxMQL+C4YKpfKWXaTi1cGm6YGenUGUbmbkmjYDyt21jcl
 7LPovyFFz4mVrMYQdKQKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oCkHxI1MJDg=:i35SxlMs/KnI8M+kKInsqn
 bQNfdYcSu3IoK7UvwiaDYDLrMiHiJwc6+2TgsrmrcYUGezEzAAsXs5Itf81jFLG/Z2/awmlMc
 ItBTHlgN8bV2dnQLW4FXAh0SwvIiBYhIZt5fJJNpSioVIHs6+banh1BVOnsI0DVhlaYp/wptm
 Vq2TeQlp8+Bn7tecqbPfE/kAK5iWNiIw7c5fOCpMQ59B44mKvmFC6e1qGqIgIxIYEKV5S4sCy
 AlamTnfIV0D8vWu8ZztZw4nv7eiLo7n44ofYeEScThF8w5TmxdpPbiou6nurKxsLl51oh3xpA
 BMKKF2RSGKuhSf0bgH0Wc1BiGgOxzA6iiH3zIFIsTy9rISuBWFpzGVY824uhpb0dj9pA7E4g5
 RZe+96KN+JWhJwJCsdrI+gCRCt9qSL2F/BTCfE2jMm32Cvrbr1uWnbFNnX3uIiYVp4yWk+h07
 kMQoInt54SpvWH6Mnbzi06TkcXWjD705GhxFZhzlrlIBypHz19gCFcTShp5yLI4VHXXaaaNbp
 H0k58KYObGjwbIij615cAdjlJgtDczlW7RDglpzTk1gPOzIkm/C2KQJ2BjznM5HGWtKtHKxHD
 iQF2craGnq2LqEgkGRQl84cedM64rQX/IJs3SYL3MvU6KaMEXb6sswIfBhdD8HkxfjW0awRCM
 bhAp7KrmmNb3iP18UXQVdSoemj7RafO5jB/n7mZmmQ40fkbODiS75CWa+McJ/sA1AoPI3tJqw
 pywM0qzjfe5HRsjmN+OD2O7rZ3xQMw5PamzksOXwqmZQFzQUdcvctE3QB1MCOrp/gQgKTEtl8
 OriTo1qwb/jd1mxNTXKi/8UlvAZxK9O8VHc0xGxlcm3uI+sDKSOvjeKYlq0gxCqCQAlR2W5mv
 vfsz3CAqtOE/aItr8Zcw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 3:44 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
> 在 2022/7/12 16:27, Arnd Bergmann 写道:
>
> Thanks for your suggestion.
>
> How does it to fix the implicit-function-declaration error?
>

I missed that part at first. I would say the #ifdef around the
declarations in the
header should be removed here, it serves no purpose, and it is safe to rely
on the compiler to perform dead code elimination so this does not lead to
a link error even if a dead function references another function that is not
reachable.

        Arnd
