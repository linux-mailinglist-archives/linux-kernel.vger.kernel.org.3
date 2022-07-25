Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3F57FF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiGYMvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiGYMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:51:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D212E64C6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:51:18 -0700 (PDT)
Received: from mail-ej1-f43.google.com ([209.85.218.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuUvU-1nOXt03oXK-00rVv9 for <linux-kernel@vger.kernel.org>; Mon, 25 Jul
 2022 14:51:16 +0200
Received: by mail-ej1-f43.google.com with SMTP id tk8so20358062ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:51:16 -0700 (PDT)
X-Gm-Message-State: AJIora/Avv3Iak6HnL6yQRDJbKbSo23grCpL9F+oSuI1jmc8aXWEDp4d
        oUlaAf5MsovSdTScst0N1IlI4Qp3uNXY9Wc7h7o=
X-Google-Smtp-Source: AGRyM1ujhhY1O1VjhzWjSGchJVlAUzNSHu3b8hjAjKdb2T2ZkFPQmlV+7/Q8PwmW7bopcRw3+cSD7IXE44152T9smDs=
X-Received: by 2002:a17:907:97cd:b0:72f:2df:274f with SMTP id
 js13-20020a17090797cd00b0072f02df274fmr9717512ejc.766.1658753476486; Mon, 25
 Jul 2022 05:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com> <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
In-Reply-To: <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 14:51:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
Message-ID: <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        jpoimboe@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IjDg/2Qs4H36w6n9BrRurfT1NS5lE93ZIpfCCBDVUt4Q6rGMSVJ
 rMlta/HTiLYNal2AjSjazU1GNe0HzYNHCOvNR0mw3gXwY1Bm8kFWsqKoLGc7Ryiz+F/qcLD
 4V29ESA9xuAFN0iPqwQqfA0vJOfYgU1o3DltZ3CRf5pql6JrePo6L8d3OjqLB4kz+hqQKRO
 IO7C752rQsIUNkIFxik4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ySfa4K9zNZo=:1rrlyTEKFHM0S1bNIrdLG8
 ShWihQFHrqH3u0tUTGSUubJemukJoFWcZohw0IhOAdEmwqgEj8ihtAEUE1Dv2ZSSSogdB6jxA
 65B3+aWyZWJBxMhH7Sv9vQ6UHo/yxT20TGDFd9wL4mXPQuUrx/U3c9a7hsqxFRJ//fx0alWOt
 ACpQPE6QyUohhufFn6iBuBLhOrLpYJb8O3RjmQ7vN65b/7oTWRriEgxfdAZiROKDhf6aZHydf
 oSriwZwsHicpzjveYGygq7m9GXmD1s6vc6JFBSYoeFyjlxkd+XKGWPr1EfV2piYcttUphyHh/
 eMQWOsr7EQzby0/sfsLciJZeSxhbbO4Gv2O0XmSQggWgUajIRRYAgxOyzJrZGZEKaMnYHwPRC
 /hGU0op8y0qMUBo3d3kJt0DJiNXmLZyQ8DDq8/aAyjmzgTuLKsIj07swWWHck1OrP9mbBix8p
 101KKDPd4AbxH95erVb7kihws7ijZRt7tTVYJd5BopBYW3kBO3p59fG/t1ILuONqknRZoSvHC
 k7YrVdKmfkbIgNznoX5Z7K6CT4HxR0ns9oKHDspm06F/UpJyIYxLFsPeUIgVoBDBbDlfq/t1J
 IWRrcfOqM1nCe10wCQlDlImB0dkxtZAb7AFx0s0z0Ip13MFpX9vuF0P0cRUAHPA2m9MooB1UK
 S6vW66Y2zCbzegIZHKamQmObSNuEd5Wx3JKlaSuJ89AtihjdsKWnPikJXcg+8WS1twgydaTK0
 JghGPBKTuwLgv13LFVun/t0CIYJjAwUvh0jtdw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 1:57 PM John Garry <john.garry@huawei.com> wrote:
>
> On 24/07/2022 21:35, Arnd Bergmann wrote:
>
> Here's a brief'ish summary for why it's ok to delete these mentioned
> configs:
>
> > CONFIG_ARCH_BCMBCA=y
>
> On next-20220722, config ARCH_BCMBCA is selected by config ARCH_BCM4908
> from arch/arm64/Kconfig.platforms and the latter is enabled in the
> defconfig, so no need to explicitly enable in the defconfig.
>
> On arm-soc arm/defconfig, config ARCH_BCMBCA does not exist for arm64
> platforms yet, so this is why we see this config deleted for the sync.
>
> > CONFIG_SECCOMP=y
>
> Since commit 282a181b1a0d, config SECCOMP was changed to def_bool y, so
> no need to explicitly enable in the defconfig.

Ok

> > CONFIG_QRTR=m
>
>  From commit fdf4632aa834, we enable config ATH11K_PCI, which selects
> config QRTR, so no need to explicitly enable in the defconfig.

Something is wrong here, as qrtr is used the same way in both ath10k and
ath11k, but only one of them selects the symbol. My guess is that there is
no actual hard requirement to enable it.

> > CONFIG_PINCTRL_MSM=y
>
>  From commit c807a335d3b1, config PINCTRL_SM8450 is enabled, which
> selects PINCTRL_MSM, so no need to explicitly enable in the defconfig.

This looks like a bug, where the driver should have used 'depends on'
rather than 'select'.

> > CONFIG_SND_SOC_TEGRA210_OPE=m
>
> There is no issue on next-20220722.
>
> On arm-soc arm/defconfig, config SND_SOC_TEGRA210_OPE just does not yet
> exist, so that's why it get removed from the sync of the defconfig.

Ok

> > CONFIG_MAILBOX=y
>
> In commit fc739069aa92, config MAILBOX was enabled in the defconfig but
> it was already being enabled from elsewhere. There was definitely no
> sync of the savedefconfig going on there :)

I see it's selected by a couple of drivers using mailboxes, and I
agree we shouldn't
need it here. It might be good to just hide the symbol in this case
and select it
consistently from all drivers using it.

> > CONFIG_QCOM_ICC_BWMON=m
>
> Commit 76f11e77f919 enabled config QCOM_ICC_BWMON, but like config
> ARCH_BCMBCA, that config does not exist on arm-soc arm/defconfig branch
>
> On next-20220722, no sync is required

ok

> > CONFIG_SLIMBUS=m
>
> Config 5bd773242f75 added a kconfig "imply" on config SLIMBUS from
> config SOUNDWIRE_QCOM, and this happens to mean that we don't explicitly
> require config SLIMBUS enabled in the defconfig.

That 'imply' looks like it was added to solve a problem using the old 'imply'
semantics that are not what this keyword does today. I suspect it's still
broken when CONFIG=SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,
and the correct fix is to use a dependency like

      depends on SLIMBUS || !SLIMBUS

so the defconfig symbol should stay.

> > CONFIG_INTERCONNECT=y
>
> Since commit 06f079816d4c, config TEGRA_MC added a kconfig select on
> config INTERCONNECT, so no need to explicitly enable from the kconfig

We have one driver using 'depends on INTERCONNECT' and two drivers
using 'select INTERCONNECT', so at least one of them is wrong.

There are also a couple of drivers that use neither and instead rely on the
IS_ENABLED() check in include/linux/interconnect.h, but this is potentially
wrong in the same way as the SLIMBUS dependency above.

This clearly needs some more discussion. I would suggest removing the
#iff check in the header and forcing all users to use 'depends on', leaving
the defconfig symbol.

> > CONFIG_CONFIGFS_FS=y
>
>  From commit cd8bc7d4eb66, config PCI_ENDPOINT_CONFIGFS is enabled in
> the defconfig, and this selects CONFIG_CONFIGFS_FS, so no need to have
> explicit enabling in the defconfig.

Again, half the users of CONFIGFS_FS use 'depends on', the other half use
'select'. We should be consistent here and always use the same method,
probably 'depends on' if we want to keep it as user-visible.

> We still have issues on next-22072022:
> CONFIG_ARM_CPUIDE
> CONFIG_DEBUG_INFO
> CONFIG_DEBUG_INFO_REDUCED
>
> The latter two are not an issue on the arm-soc arm/defconfig.

Ok.

> So let me know if any comments or how to proceed.
>
> And would each config item deletion merit a separate patch?

You send a combined patch for the obvious ones (secccomp
and mailbox AFAICT) or send them separately. For the other ones I think
we should try fixing the Kconfig files first, otherwise we just end up
putting them back afterwards.

        Arnd
