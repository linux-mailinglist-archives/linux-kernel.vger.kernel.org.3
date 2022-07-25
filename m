Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483E757F9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiGYHMB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jul 2022 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:11:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54AC65B4;
        Mon, 25 Jul 2022 00:11:57 -0700 (PDT)
Received: from mail-ej1-f45.google.com ([209.85.218.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MnZwp-1nopQX0l7t-00jdY3; Mon, 25 Jul 2022 09:11:56 +0200
Received: by mail-ej1-f45.google.com with SMTP id l23so18932180ejr.5;
        Mon, 25 Jul 2022 00:11:56 -0700 (PDT)
X-Gm-Message-State: AJIora9cyPaOFO5T5UBLHTYa3kxrYXxtwB95KREtPbkkvXUz+64EA87l
        YQe7AMUIZ5ulLaa+Ebu3CPyYZZftE5VAluc2Ox0=
X-Google-Smtp-Source: AGRyM1vsXI3Ky9UWaTbBb62V/2imE1yupiH29WQmI1FGfnsmQmviYwxhNC+GHy4zia5B5lmb/ALvUGKfZkDP6ajCAGg=
X-Received: by 2002:a17:906:dc89:b0:72f:1d4f:cea8 with SMTP id
 cs9-20020a170906dc8900b0072f1d4fcea8mr9259669ejc.654.1658733115829; Mon, 25
 Jul 2022 00:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220704025632.235968-1-renzhijie2@huawei.com>
 <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
 <df9909dc-3303-808e-575a-47190f636279@huawei.com> <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
 <af043109-c101-a147-707b-82e79469ae73@huawei.com> <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
 <f565a5b5-8ba2-adbb-8093-6d60b2159222@huawei.com>
In-Reply-To: <f565a5b5-8ba2-adbb-8093-6d60b2159222@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 09:11:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2L4J1Qfu5rw8dvbto25zZDiUrv6vbv-6A6nckgyoRmZQ@mail.gmail.com>
Message-ID: <CAK8P3a2L4J1Qfu5rw8dvbto25zZDiUrv6vbv-6A6nckgyoRmZQ@mail.gmail.com>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:4Hnd6qv2aReeCv4L40SIrXRriKLErRfBQYpKFGLEr+8SRSlbCJ/
 XzANk0NFSzCuqkCrvXPxu5eSEgxUhzHslJh5kFTYdXGlKj9LQi4p5IQ6FplbLp55YHFRdta
 id5tEGet6Z9EYZCNcr9i37IXptQL4dTXt3wZEsaPxvCPFsQr2t1gopJYIRxG0CXSC9auNpd
 xZD8DGv+YYRBMbqpGnyEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nCKXhoUNyI=:SP205vTv+DP4PCcpUufk8P
 NnGvuGHi3h1YGJjeewb1H1GlC8NNcaXP+/LDHKAStDWH2TT+z/RH2f4Wh76PSEDzgPPpnFuJX
 SPrdoyiJ8DtJCtX7P4cULORS7iQ1hRB/BRwJwXJ8HJ7yvmo0UuumloaThqV3eQrHD4fiYtrUg
 x1SsyLBIBuQBVn/eVdMGm0ni+16AfFHDaMHxfKrknukGLIjQxXX845OIJF3NeYdm7qVjtLOei
 zg7QKf0VB2yZgxd8EzGtvayMaUXCINfiR9yRLJI9lLDdzyteR5cAxr9zQF9oaNFOBBExjvzsC
 VS4cpynTxBUkCY15jlBYDAzFEmX44uglVhbn5fg3vHHdU8cayBJ14ZSe1DHlAiXe9MHF0+k9F
 +hRN5bNivo1+411Muho62mkWmczwfl9q77rOE5QiFZwAzSkR9ZptWr2ftmWzmEmR3SjizGz+k
 gmBRQyZVoi3/oRabfITLLaJwuletIRcSO1hcmHeHX9ev//RA/16RQqV2pjk0f11IZhQjiOdsu
 DgTCpKh9p5AJtkrNGQpz/bdY4WlgOj8i2S1ds26Yveb8KuDITFt1OPb053ie+lM/b5A3ptm9y
 cOku9V04QC+CtJrzxbWM252IWvpqKmgO01fGHrkTSyz42Rqq0KkItn35m/Pg7woiknxRQgOfM
 TNBJkCf7V9xSKYPQoRpn+cMIjPr+cAGMQxNsWkmECkqZnOxpxCcpromHntyp9k00GlUvq1Er/
 aex9kFJa4ZkR1ojWbwoLPZKycOtE3eww3I94snSZFL4OIS4WvQ8Y10l3ur6KuRwcuUbf6wynC
 Fo4ETTFYHL9GOAsHfipv+QR6T+TlmECR9gtiEQbDgOSsUBhhSu3/RThZoxooY0uDcJtRtbYtj
 /vz09guMIi/gp7MT7C9g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 9:00 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
> 在 2022/7/25 14:34, Arnd Bergmann 写道:
> > On Mon, Jul 25, 2022 at 5:38 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
> >> 在 2022/7/13 16:48, Arnd Bergmann 写道:
> >>
> >> I try to use the new marcos SYSTEM_SLEEP_PM_OPS and RUNTIME_PM_OPS to
> >> replace the old ones, and remove #ifdef around the declarations in the
> >> header, my local changes attach below.
> >>
> >> But it seems  that doesn't work, which has ld errors:
> >>
> >> aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> >> aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> >> drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_resume':
> >> ufs-mediatek.c:(.text+0x1d0c): undefined reference to
> >> `ufshcd_runtime_resume'
> >> drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_suspend':
> >> ufs-mediatek.c:(.text+0x1d64): undefined reference to
> >> `ufshcd_runtime_suspend'
> >> Makefile:1255: recipe for target 'vmlinux' failed
> >> make: *** [vmlinux] Error 1
> >>
> >> (CONFIG_PM and CONFIG_PM_SLEEP are both not set, and
> >>
> > It appears that there is a mistake in the RUNTIME_PM_OPS()
> > macro definition, can you try this patch on top?
>
> Hi Arnd,
>
> I apply this patch and it worked.
>
> When will this patch be merged?

So far nobody has submitted this, I was just guessing and I had no idea
if this would do the right thing. Can you send this patch to the power
management maintainers with a proper changelog and a

Suggested-by: Arnd Bergmann <arnd@arndb.de>

 line? Thanks,

     Arnd
