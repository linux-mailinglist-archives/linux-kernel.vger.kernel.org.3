Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D724F7848
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiDGH4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiDGH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:56:38 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1EB1EA5EA;
        Thu,  7 Apr 2022 00:54:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DA65B3200EC0;
        Thu,  7 Apr 2022 03:54:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Apr 2022 03:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=hvRJV0pvl3fLnQVaefDbK7s+xg+2wLBb3A3T1r
        b+a40=; b=eHXmPPGVwTO8n00CRZPJ/6qTXK53BXAYGEUgX5Q4ulhZYaZVBXofVC
        e+73TlEPGRjNEFTAp62XHawGFRcv2Vx+8OLji0ezh+6h6xAdNRW+gVDTsxgOQ6xC
        SSSNTiV9WCeODs5dwjKJW3t8vBPjfA7m+chKp6C+lGrfMDNC88Yuj90znL63t3pl
        aWYzG9i7wNkWts7SEosxihm928gTA1/9LUPssyeWPbh4Lj642vl5JvABNea7TPJo
        kLVEo5rbL5yXxkuw11T5gy46szdIEA3Vr6eA6rfeYdOWTVKgsogCd9vomaoqQQWZ
        aXf+NG3BJKBREvlz5Wb1UUhlKOL2tO3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hvRJV0pvl3fLnQVae
        fDbK7s+xg+2wLBb3A3T1rb+a40=; b=ddD17FI/e7dTpvPXM+oT59gLJeP8esacR
        qzemYeqBlTAXFmFAjU3Ldoh3ezkkg2slPyZBqvXnbGGWQ5ASMbPNM1J43qkF5d+V
        AI5ivyyhGS9fHqtymUlz7K9Y/nxQKulVmN16w5HNL+KBQ7qC+R6r0G7fJZltQdMW
        6tWmP4v6PVLaLkuxmLzI3pQmA7tME4yYOlmJF4aNC+ZWy24REG6fL8ihMJA1Hwhw
        Vffq64B7/L4MvQUX2Wsm54NG+oWDZQBRT3fCbnJ1veDg0D2hlx1iHJtUcncteV7L
        dhCWtywu5mHtmGmhdFJvH81fui0Ev1ead+22PGH7VzxNm1DcxNEnQ==
X-ME-Sender: <xms:vZhOYvSYNG6eJq3NPujn5RnFmTh3UGDWuwo-62PxUGlhVgTTtmjPbw>
    <xme:vZhOYgx0tg6Ra_heBgZ3o603PS36jkw_8ZAyXHIauJYx7-pH1wdkySWiEoCbud1mY
    zrAcdO9lrQKuNeRj0s>
X-ME-Received: <xmr:vZhOYk2JYooCHNI9FCJpq7_sVxnIYri9TrxS18AA_SiesYmfy0UiungjQWLUdo004MsR8R-ctJao0kU_HDNMVJd2czLP5DuMczGRYGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefhffdtueegvedvueffjeeuffejfeffjedtfeevfeeuleejkeeghfeuheet
    ffduheenucffohhmrghinhepghhithhlrggsrdgtohhmpdhtuhigsghuihhlugdrtghomh
    dpkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:vZhOYvAPLxH8jNLQWE9e3F1tB7METMXDutZ6OGPwtL9BbYgXU02n7Q>
    <xmx:vZhOYogt36ZM9nWwgr3bYUgxrLqKVLAdYNmmjA3730hgffxEdR-Lyg>
    <xmx:vZhOYjovNfrQvOv4Uvu9GX1FkT1TLcjJPQQ6R-sMH-M1iSSnu43eaQ>
    <xmx:vZhOYkwGstWp97xfECSUvb9tHw6Elo7bdYe_jGXMYDxSvXroLaMOrw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Apr 2022 03:54:36 -0400 (EDT)
Date:   Thu, 7 Apr 2022 09:54:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [next] db845c: WARNING: CPU: 5 PID: 8 at
 drivers/clk/clk-divider.c:139 divider_recalc_rate
Message-ID: <20220407075435.ahlylmbqmqnpxz64@houat>
References: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
 <20220401151058.fipdax3kvmxknctv@houat>
 <CA+G9fYu+WddXTb0NcbviUfGQHhsmThssVCafLPw7+nj3JsoFAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i5yz424gkn64kvgh"
Content-Disposition: inline
In-Reply-To: <CA+G9fYu+WddXTb0NcbviUfGQHhsmThssVCafLPw7+nj3JsoFAA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5yz424gkn64kvgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 02, 2022 at 12:16:48AM +0530, Naresh Kamboju wrote:
> On Fri, 1 Apr 2022 at 20:41, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Thu, Mar 31, 2022 at 05:33:57PM +0530, Naresh Kamboju wrote:
> > > Following kernel warning noticed on db845c while booting linux next-2=
0220331.
> > >
> > > metadata:
> > >   git_ref: master
> > >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > >   git_sha: fdcbcd1348f4ef713668bae1b0fa9774e1811205
> > >   git_describe: next-20220331
> > >   kernel_version: 5.17.0
> > >   kernel-config: https://builds.tuxbuild.com/278RLnhgJL7XdlJbcbv07jiw=
bYB/config
> > >
> > > Boot log:
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> > > [    0.000000] Linux version 5.17.0-next-20220331 (tuxmake@tuxmake)
> > > (aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
> > > for Debian) 2.38) #1 SMP PREEMPT @1648699852
> > > [    0.000000] Machine model: Thundercomm Dragonboard 845c
> > > <trim>
> > > [    8.131366] ------------[ cut here ]------------
> > > [    8.131374] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_Z=
ERO not set
> > > [    8.131387] WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
> > > divider_recalc_rate+0x8c/0xc0
> > > [    8.131398] Modules linked in: qcom_spmi_adc5 snd_soc_sdm845
> > > qcom_vadc_common qcom_spmi_temp_alarm qcom_pon crct10dif_ce rtc_pm8xxx
> > > snd_soc_rt5663 msm snd_soc_qcom_common gpu_sched snd_soc_rl6231
> > > soundwire_bus reset_qcom_pdc drm_dp_helper qcom_camss hci_uart
> > > videobuf2_dma_sg btqca v4l2_fwnode venus_core ath10k_snoc v4l2_async
> > > btbcm ath10k_core i2c_qcom_geni v4l2_mem2mem videobuf2_memops
> > > videobuf2_v4l2 ath bluetooth camcc_sdm845 videobuf2_common
> > > spi_geni_qcom i2c_qcom_cci qcom_rng mac80211 xhci_pci qcom_q6v5_mss
> > > xhci_pci_renesas cfg80211 icc_osm_l3 slim_qcom_ngd_ctrl qcom_wdt
> > > rfkill qrtr lmh pdr_interface display_connector slimbus qcom_q6v5_pas
> > > drm_kms_helper qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
> > > qcom_glink_smem qmi_helpers drm mdt_loader socinfo rmtfs_mem fuse
> > > [    8.131462] CPU: 5 PID: 8 Comm: kworker/u16:0 Not tainted
> > > 5.17.0-next-20220331 #1
> > > [    8.131465] Hardware name: Thundercomm Dragonboard 845c (DT)
> > > [    8.131467] Workqueue: events_unbound deferred_probe_work_func
> > > [    8.131475] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [    8.131477] pc : divider_recalc_rate+0x8c/0xc0
> > > [    8.131479] lr : divider_recalc_rate+0x8c/0xc0
> > > [    8.131481] sp : ffff8000080936c0
> > > [    8.131482] x29: ffff8000080936c0 x28: ffff781940e58d00 x27: ffffa=
7f3f1bc6d38
> > > [    8.131485] x26: ffffa7f3f1bc6cf8 x25: 0000000000000000 x24: fffff=
fffffffffff
> > > [    8.131488] x23: ffff781947e8a400 x22: 000000003b9aca50 x21: ffff7=
81940be0800
> > > [    8.131491] x20: ffff781947e8a800 x19: 000000003b9aca50 x18: 00000=
00000000000
> > > [    8.131494] x17: 0000000000000000 x16: 0000000000000000 x15: 00000=
00000000000
> > > [    8.131497] x14: ffff7819bd718000 x13: 0a74657320746f6e x12: 204f5=
2455a5f574f
> > > [    8.131500] x11: 4c4c415f52454449 x10: 5649445f4b4c4320 x9 : ffffa=
7f3f011de84
> > > [    8.131502] x8 : 445f4b4c4320646e x7 : 6120726f73697669 x6 : 00000=
00000000001
> > > [    8.131505] x5 : ffffa7f3f288f000 x4 : ffffa7f3f288f2d0 x3 : 00000=
00000000000
> > > [    8.131508] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7=
819402c7000
> > > [    8.131511] Call trace:
> > > [    8.131512]  divider_recalc_rate+0x8c/0xc0
> > > [    8.131513]  clk_divider_recalc_rate+0x64/0x90
> > > [    8.131515]  clk_recalc+0x40/0xb0
> > > [    8.131519]  clk_calc_subtree+0x58/0x90
> > > [    8.131521]  clk_calc_subtree+0x70/0x90
> > > [    8.131523]  clk_calc_new_rates+0x150/0x290
> > > [    8.131526]  clk_calc_new_rates+0x100/0x290
> > > [    8.131528]  clk_calc_new_rates+0x100/0x290
> > > [    8.131530]  clk_calc_new_rates+0x100/0x290
> > > [    8.131533]  clk_core_set_rate_nolock+0xa0/0x2a4
> > > [    8.131535]  clk_set_rate_range_nolock.part.0+0xbc/0x2a0
> > > [    8.131538]  __clk_put+0x70/0x140
> > > [    8.131540]  clk_put+0x1c/0x30
> > > [    8.131543]  of_clk_set_defaults+0x140/0x3c0
> > > [    8.131546]  platform_probe+0x48/0xf0
> > > [    8.131548]  really_probe+0x184/0x3d0
> > > [    8.131550]  __driver_probe_device+0x11c/0x190
> > > [    8.131553]  driver_probe_device+0x44/0xf4
> > > [    8.131556]  __device_attach_driver+0xa4/0x140
> > > [    8.131558]  bus_for_each_drv+0x84/0xe0
> > > [    8.131561]  __device_attach+0xe4/0x1c0
> > > [    8.131563]  device_initial_probe+0x20/0x30
> > > [    8.131565]  bus_probe_device+0xa4/0xb0
> > > [    8.131567]  deferred_probe_work_func+0xa8/0xfc
> > > [    8.131570]  process_one_work+0x1dc/0x450
> > > [    8.131575]  worker_thread+0x154/0x450
> > > [    8.131577]  kthread+0x100/0x110
> > > [    8.131579]  ret_from_fork+0x10/0x20
> > > [    8.131584] ---[ end trace 0000000000000000 ]---
> > > [    8.131588] ------------[ cut here ]------------
> >
> > I'm not sure if it's feasible, but if it is, it looks like something
> > that could be fixed by the patch pasted here:
> >
> > https://lore.kernel.org/linux-clk/20220401122736.5yvanksa4pla7uql@houat/
> > Could you test it?
>=20
> I have tested the single line patch and reported problems not fixed.

Could you test this branch?
https://github.com/mripard/linux/tree/rpi/clk-improvements-more-fixes

Thanks!
Maxime

--i5yz424gkn64kvgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYk6YuwAKCRDj7w1vZxhR
xUChAP0UVOSNtC1qP84XhYgR5jOX0+qkLgOnE+8H9phnEaSRYAD/b4tGeJzdEGe1
t+sCqPDcVmNLKYmYYv37511sduZt7Qw=
=U3cn
-----END PGP SIGNATURE-----

--i5yz424gkn64kvgh--
