Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04090572E77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiGMGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:53:05 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A1C48CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:03 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220713065300euoutp0207e0fda0cde73ffa847b47f7de6532f0~BUPvxAHC61251012510euoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:53:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220713065300euoutp0207e0fda0cde73ffa847b47f7de6532f0~BUPvxAHC61251012510euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657695180;
        bh=kglwyw0l+JmmPr2wkppTs/DXoUw0o2GRZnyznPS9T5U=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=QN1BH5e321CioFgCIOMUnxmEeD9poJHRCPZ3meNLU0MgkdvhixnLLOvrWRfFc53SH
         JO5ufLd29iidYxDXuljzmtqszpc+pZdcr3SJ5e4HNR3W+hBMeT0wXns2K354i961Bd
         zu+QrpWKZ1qOOTY1Vg0SRRQJh2Qy7dZ3nnHimABc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220713065300eucas1p277757044958639fe93015c865cecfd14~BUPvX6x5z2003920039eucas1p27;
        Wed, 13 Jul 2022 06:53:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7C.DD.10067.CCB6EC26; Wed, 13
        Jul 2022 07:53:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220713065300eucas1p1cfa32c4d59576d077762f76fd7b4a5e4~BUPu_SUFk1597015970eucas1p1H;
        Wed, 13 Jul 2022 06:53:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220713065259eusmtrp20a6bbebda144b6f1b4a0301dee19a2e8~BUPu9bDcy2427524275eusmtrp27;
        Wed, 13 Jul 2022 06:52:59 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-27-62ce6bcc79b6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.65.09095.BCB6EC26; Wed, 13
        Jul 2022 07:52:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220713065259eusmtip20a42113d225dcd69e26dc001f6154dfd~BUPuTd6Uz1939919399eusmtip2V;
        Wed, 13 Jul 2022 06:52:59 +0000 (GMT)
Message-ID: <f68f8bcc-7543-5957-0e17-2cc797898ec0@samsung.com>
Date:   Wed, 13 Jul 2022 08:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7pnss8lGfQcFbeYO3sSo8WZ37oW
        O7aLWEz5s5zJ4vKuOWwWh6buZbTYNms5m8XdeydYLP7v2cFu0XXoL5vF8lM7WCyOrw23aPx8
        n9GB12Pb7m2sHmvmrWH0uHztIrPHxLO6Hgs2lXq0HHnL6rFpVSebx51re9g8+v8aeGw+Xe3x
        eZNcAHcUl01Kak5mWWqRvl0CV8bVpTOZClZpVXx4+46xgXG3UhcjJ4eEgInE5/5tzF2MXBxC
        AisYJa70nmCEcL4wSnz58YQNwvnMKNH2YSYbTMuRs4uZIBLLGSVuvvvCDuF8ZJTYf2UHK0gV
        r4CdxOybB1lAbBYBVYlFP1dDxQUlTs58AhYXFUiWOHf2KthUYQFbiYnvPzCB2MwC4hK3nswH
        s0UEtCQ2XXvMArKAWeAas8SBVdPBmtkEDCW63naBNXMKBEo8O/aAFaJZXmL72zlgH0kIrOaU
        eDjlABPE3S4Sq2cfgrKFJV4d38IOYctI/N8Jso0DyM6X+DvDGCJcIXHt9RpmCNta4s65X2wg
        JcwCmhLrd+lDhB0l9lw+zwLRySdx460gxAV8EpO2TWeGCPNKdLQJQVSrScw6vg5u58ELl5gn
        MCrNQgqUWUien4Xkl1kIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITHan/x3/
        soNx+auPeocYmTgYDzFKcDArifD+OXsqSYg3JbGyKrUoP76oNCe1+BCjNAeLkjhvcuaGRCGB
        9MSS1OzU1ILUIpgsEwenVANTyoJn5pcEwy42H+b6vzxqc9e6wBaWxiOdGQVBG8x3Mtj6CApP
        qjujxDVlTqVNKv/tPKdt0et//lrwaYaP/U2l4gOTmXN+Mp6emfUw7PWOWblOe34WCYme2vwq
        1K1WOV7/pLL5r3c7Ls3VO2f7a84TpfWCrI/0+O6XGh7ZGpB1XMpbe7qDrL2Sz1Xr3aqWrQ+N
        /zddNXm2sCTFRG2r3SKOyRyyko2M5QXzNCPqY5yYJW9dsPDZ6nT35aqNimcs9abanZAKaSrs
        XyGkyfhZr0BA/rd9YJNDkbaDQsCKp44RX8JdlkWUmxw51GmR4Vjks3RK/N+LopK30z4GG9W+
        PfKlZ0tPbdm2PHf7NH6FfiWW4oxEQy3mouJEAAvbKnHlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xe7qns88lGTz6bmExd/YkRoszv3Ut
        dmwXsZjyZzmTxeVdc9gsDk3dy2ixbdZyNou7906wWPzfs4PdouvQXzaL5ad2sFgcXxtu0fj5
        PqMDr8e23dtYPdbMW8PocfnaRWaPiWd1PRZsKvVoOfKW1WPTqk42jzvX9rB59P818Nh8utrj
        8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
        vYyrS2cyFazSqvjw9h1jA+NupS5GTg4JAROJI2cXM3UxcnEICSxllGie2sUOkZCRODmtgRXC
        Fpb4c62LDaLoPaPE+8V/mEASvAJ2ErNvHmQBsVkEVCUW/VzNChEXlDg58wlYXFQgWaJ5yyGw
        emEBW4mJ7z+A2cwC4hK3nswHs0UEtCQ2XXvMArKAWeAGs0TX15NQ2w4wSVw40QY2lU3AUKLr
        LcgZnBycAoESz449YIWYZCbRtbWLEcKWl9j+dg7zBEahWUgOmYVk4SwkLbOQtCxgZFnFKJJa
        WpybnltsqFecmFtcmpeul5yfu4kRGOPbjv3cvINx3quPeocYmTgYDzFKcDArifD+OXsqSYg3
        JbGyKrUoP76oNCe1+BCjKTA0JjJLiSbnA5NMXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpi
        SWp2ampBahFMHxMHp1QD09K90Y0vQ659qn61UkhJ9OsDll2PO46HLTstw/s4pN/s8o/dzCFv
        69Kr46ZIKUonuq2eO22NnICwOEu5Uu5KWQE2/fNKT1ZtvNP5z3DG25TeaoMzv7e+2CV0wNDQ
        59XV1iRRg2TttGo/v77gs0xdGx95CLiaHznmFj45SiR5+QKOmP/1MdyLJ58TdnfxVlr+L/3U
        hosdsdLm71gT/6r2bbpvbyunl/GqnjuzaIG/uO+nnYtM7atPyd+dyZ1bLqvDk3ex8Hd2tMzf
        6gcx1W1lyxx3R86rN9c5dUpuym4er0d8Vc8ddLz2iTpqdT4RrW65VGjd+Ng3ct822wr+Wy9+
        PI2d9Jxphk3lhzzxlbZKLMUZiYZazEXFiQAi5blWegMAAA==
X-CMS-MailID: 20220713065300eucas1p1cfa32c4d59576d077762f76fd7b4a5e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
        <20220705083934.3974140-1-saravanak@google.com>
        <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
        <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com>
        <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 12.07.2022 21:38, Saravana Kannan wrote:
> On Tue, Jul 12, 2022 at 5:34 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 12.07.2022 14:25, Marek Szyprowski wrote:
>>> On 05.07.2022 10:39, Saravana Kannan wrote:
>>>> The uevents generated for an amba device need PID and CID information
>>>> that's available only when the amba device is powered on, clocked and
>>>> out of reset. So, if those resources aren't available, the information
>>>> can't be read to generate the uevents. To workaround this requirement,
>>>> if the resources weren't available, the device addition was deferred and
>>>> retried periodically.
>>>>
>>>> However, this deferred addition retry isn't based on resources becoming
>>>> available. Instead, it's retried every 5 seconds and causes arbitrary
>>>> probe delays for amba devices and their consumers.
>>>>
>>>> Also, maintaining a separate deferred-probe like mechanism is
>>>> maintenance headache.
>>>>
>>>> With this commit, instead of deferring the device addition, we simply
>>>> defer the generation of uevents for the device and probing of the device
>>>> (because drivers needs PID and CID to match) until the PID and CID
>>>> information can be read. This allows us to delete all the amba specific
>>>> deferring code and also avoid the arbitrary probing delays.
>>>>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>> Cc: Saravana Kannan <saravanak@google.com>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>> - Dropped RFC tag
>>>> - Complete rewrite to not use stub devices.
>>>>
>>>> v2 -> v3:
>>>> - Flipped the if() condition for hard-coded periphids.
>>>> - Added a stub driver to handle the case where all amba drivers are
>>>>     modules loaded by uevents.
>>>> - Cc Marek after I realized I forgot to add him.
>>>>
>>>> v3 -> v4:
>>>> - Finally figured out and fixed the issue reported by Kefeng (bus match
>>>>     can't return an error other than -EPROBE_DEFER).
>>>> - I tested the patch on "V2P-CA15" on qemu
>>>> - Marek tested v3, but that was so long ago and the rebase wasn't clean,
>>>>     so I didn't include the tested-by.
>>>>
>>>> Marek/Kefeng,
>>>>
>>>> Mind giving a Tested-by?
>>>
>>> Yes, it looks that it still works fine.
>>>
>>> I've tested it by changing the Exynos power domain driver to
>>> initialize from late_initcall. This in turn lead me to a bug in
>>> generic pm_domains code in __genpd_dev_pm_attach(), which returns -2
>>> if the pm domain driver is not yet registered. After fixing that, I've
>>> successfully observed the deferred probe of PL330 driver on Exynos
>>> 4210 based boards both with this patch and without (with the old timer
>>> based code).
> Thanks for testing it again Marek! I was hoping you'll hit the crash
> that Sudeep was hitting and it would give me some more clues.
>
> Sudeep,
>
> This makes me think the issue you are seeing is related to your
> hardware drivers. Can you look into those please? I'm leaning towards
> merging this amba clean up and adding delays (say 1ms) to your
> clock/power domain drivers to avoid the crash you are seeing. And then
> you can figure out the actual delays needed and update it.
>
>> While preparing a fix for the above issue in genpd I found that it has
>> been introduced by your commit 5a46079a9645 ("PM: domains: Delete usage
>> of driver_deferred_probe_check_state()"). I didn't analyze it enough,
>> but it looks that something is missing there if we are trying to probe
>> amba device. I assume that returning -EPROBE_DEFER unconditionally there
>> is also not a valid solution?
> Yeah, the unconditionally returning -EPROBE_DEFER wouldn't work
> because if the supplier is optional but not present, the consumer
> driver would never stop waiting for it. I'm looking into issues
> similar to the one you saw in other threads [1]. The problem always
> boils down to the supplier device's DT node not having "compatible"
> property and therefore fw_devlink creating the device link between the
> consumer and the supplier's parent.
>
> Basically if the drivers/DT are implemented "properly", you would
> never get to the failure case (-2) if the driver is actually present.
Well, I don't get what do you mean by not having the proper 'comaptible' 
property. Both affected devices (amba's pl330 and its power domain) have 
compatible strings: 'arm,pl330' and 'samsung,exynos4210-pd', but the 
devlinks doesn't help. Is it related to the custom device addition code 
in the amba bus?
> I have some other ideas on how to get these to work better (not sure
> if it'll be for 100% of the cases), but until I get those ideas sorted
> out, I might do a partial revert of the change you mentioned.
>
> [1] - https://lore.kernel.org/lkml/4799738.LvFx2qVVIh@steina-w/

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

