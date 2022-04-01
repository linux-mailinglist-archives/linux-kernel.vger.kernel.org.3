Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0964EF706
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiDAPsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355275AbiDAPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:37:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B76A023;
        Fri,  1 Apr 2022 08:11:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 10C1E3201FCD;
        Fri,  1 Apr 2022 11:11:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 01 Apr 2022 11:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=85vYE7geyFacYR8Bxp5rx99f4lvCAgcFm8Mv3d
        x7Et0=; b=uqN93OsRY4pv8Qlr/shSQR72EtAJvueZ4TOqtxSPxzqVAPgyt85kgc
        cpMk5Lr8S1rzv2WZwkk3w2+5YNXaJJVfFw/Z+g6H0TTQC0S+SfnN1f1weInrqNn1
        KEFnLK1tcldUUraA3PQwMEtGkjGb7wzO1VfyArh/PrMIVe173PfI5PTfr5VR1m65
        IXRDtfnn9VU7v2+08pjeE2yZVs53uErgnIxWwQT3souvEkpongoI6yWYKgUnW8at
        Of5GBu4yewyL3p+ObxO3PlovJ61Fn5IJpaKZeF5ZAxHYn7E6AVppyvn4qex72eQo
        1fDd/bToXqZfaIngYJNGTvUNdQ9Pez0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=85vYE7geyFacYR8Bx
        p5rx99f4lvCAgcFm8Mv3dx7Et0=; b=YzOT3Ye3jL23wTFhiPMZJJ7XWXtE5Si61
        9RgwF0BkNxIEmWBbxNzStCCcf/1J4JBs/VdstTG86BtsK3sbtQdop5eDQHNc9TVE
        zyWBe3I4cxJ6fRuKvcyRUVc1SbUYBabsI4wCpkV5lkg3I6qqqV5oZ6csy1B5L6D3
        px3EAXXZVY+YdzdSuuy//l9zQQf3hzbbKqFkeV3fzyP9YkBaksjtAcvMtdmpV54I
        Lbo2sso+eyfTh4wLmORkqKzyXxqDMKS1qsRRKfdVfIorUKGJ7TfczSThkOzkftLK
        M0HuO8F/DggXrRRU/epXiT5/drz11Y5IfPVM9Q5iCKdThC1V4QjeQ==
X-ME-Sender: <xms:BBZHYtDBn6wWaMWqZOdMlkJeiLCpB-RBe39EhkuR0RF6lfII6025Pw>
    <xme:BBZHYriB3FsZBzKU3s1yEkr62J4qyvjJ5i0P6ehGAeYYG6WB7HKnTMrla4R2IEOcx
    U9W9-xtm6EKMHiXxg4>
X-ME-Received: <xmr:BBZHYonjblZ8br7N4xFtMF40JIsY1NXrzpUASr_srJhdj0t1hRQFasXFe8X-NY5pVxyLpf_tR_nz0E5tmgaEoDPYhEe1oHuNKULSm2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffdujefgtefhudelleekffegteejueduudekveffteeuvdehgeefffeutdff
    jeevnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpthhugigsuhhilhgurdgtohhmpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:BBZHYnxj00KQNhZOIa2UXOPFEHTYLF9SwXltBLj1a3tul2GjE4Wvxw>
    <xmx:BBZHYiSI9tnfJfHxZsHMUbH2872XFVhQMZbjpqtfrbdARI9T3yfabA>
    <xmx:BBZHYqbrXoaCOUK4Bre_ME6PlieSVBTevTYlH3UTsWNkYpggbAYzhA>
    <xmx:BRZHYnjAd0ulsaL8ThUtEh1UENCL3aCitf3l9-dmJQ_fh062608-dg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Apr 2022 11:11:00 -0400 (EDT)
Date:   Fri, 1 Apr 2022 17:10:58 +0200
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
Message-ID: <20220401151058.fipdax3kvmxknctv@houat>
References: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25docxotcljt756a"
Content-Disposition: inline
In-Reply-To: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25docxotcljt756a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 31, 2022 at 05:33:57PM +0530, Naresh Kamboju wrote:
> Following kernel warning noticed on db845c while booting linux next-20220=
331.
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: fdcbcd1348f4ef713668bae1b0fa9774e1811205
>   git_describe: next-20220331
>   kernel_version: 5.17.0
>   kernel-config: https://builds.tuxbuild.com/278RLnhgJL7XdlJbcbv07jiwbYB/=
config
>=20
> Boot log:
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> [    0.000000] Linux version 5.17.0-next-20220331 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
> for Debian) 2.38) #1 SMP PREEMPT @1648699852
> [    0.000000] Machine model: Thundercomm Dragonboard 845c
> <trim>
> [    8.131366] ------------[ cut here ]------------
> [    8.131374] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_ZERO =
not set
> [    8.131387] WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
> divider_recalc_rate+0x8c/0xc0
> [    8.131398] Modules linked in: qcom_spmi_adc5 snd_soc_sdm845
> qcom_vadc_common qcom_spmi_temp_alarm qcom_pon crct10dif_ce rtc_pm8xxx
> snd_soc_rt5663 msm snd_soc_qcom_common gpu_sched snd_soc_rl6231
> soundwire_bus reset_qcom_pdc drm_dp_helper qcom_camss hci_uart
> videobuf2_dma_sg btqca v4l2_fwnode venus_core ath10k_snoc v4l2_async
> btbcm ath10k_core i2c_qcom_geni v4l2_mem2mem videobuf2_memops
> videobuf2_v4l2 ath bluetooth camcc_sdm845 videobuf2_common
> spi_geni_qcom i2c_qcom_cci qcom_rng mac80211 xhci_pci qcom_q6v5_mss
> xhci_pci_renesas cfg80211 icc_osm_l3 slim_qcom_ngd_ctrl qcom_wdt
> rfkill qrtr lmh pdr_interface display_connector slimbus qcom_q6v5_pas
> drm_kms_helper qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
> qcom_glink_smem qmi_helpers drm mdt_loader socinfo rmtfs_mem fuse
> [    8.131462] CPU: 5 PID: 8 Comm: kworker/u16:0 Not tainted
> 5.17.0-next-20220331 #1
> [    8.131465] Hardware name: Thundercomm Dragonboard 845c (DT)
> [    8.131467] Workqueue: events_unbound deferred_probe_work_func
> [    8.131475] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    8.131477] pc : divider_recalc_rate+0x8c/0xc0
> [    8.131479] lr : divider_recalc_rate+0x8c/0xc0
> [    8.131481] sp : ffff8000080936c0
> [    8.131482] x29: ffff8000080936c0 x28: ffff781940e58d00 x27: ffffa7f3f=
1bc6d38
> [    8.131485] x26: ffffa7f3f1bc6cf8 x25: 0000000000000000 x24: fffffffff=
fffffff
> [    8.131488] x23: ffff781947e8a400 x22: 000000003b9aca50 x21: ffff78194=
0be0800
> [    8.131491] x20: ffff781947e8a800 x19: 000000003b9aca50 x18: 000000000=
0000000
> [    8.131494] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [    8.131497] x14: ffff7819bd718000 x13: 0a74657320746f6e x12: 204f52455=
a5f574f
> [    8.131500] x11: 4c4c415f52454449 x10: 5649445f4b4c4320 x9 : ffffa7f3f=
011de84
> [    8.131502] x8 : 445f4b4c4320646e x7 : 6120726f73697669 x6 : 000000000=
0000001
> [    8.131505] x5 : ffffa7f3f288f000 x4 : ffffa7f3f288f2d0 x3 : 000000000=
0000000
> [    8.131508] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff78194=
02c7000
> [    8.131511] Call trace:
> [    8.131512]  divider_recalc_rate+0x8c/0xc0
> [    8.131513]  clk_divider_recalc_rate+0x64/0x90
> [    8.131515]  clk_recalc+0x40/0xb0
> [    8.131519]  clk_calc_subtree+0x58/0x90
> [    8.131521]  clk_calc_subtree+0x70/0x90
> [    8.131523]  clk_calc_new_rates+0x150/0x290
> [    8.131526]  clk_calc_new_rates+0x100/0x290
> [    8.131528]  clk_calc_new_rates+0x100/0x290
> [    8.131530]  clk_calc_new_rates+0x100/0x290
> [    8.131533]  clk_core_set_rate_nolock+0xa0/0x2a4
> [    8.131535]  clk_set_rate_range_nolock.part.0+0xbc/0x2a0
> [    8.131538]  __clk_put+0x70/0x140
> [    8.131540]  clk_put+0x1c/0x30
> [    8.131543]  of_clk_set_defaults+0x140/0x3c0
> [    8.131546]  platform_probe+0x48/0xf0
> [    8.131548]  really_probe+0x184/0x3d0
> [    8.131550]  __driver_probe_device+0x11c/0x190
> [    8.131553]  driver_probe_device+0x44/0xf4
> [    8.131556]  __device_attach_driver+0xa4/0x140
> [    8.131558]  bus_for_each_drv+0x84/0xe0
> [    8.131561]  __device_attach+0xe4/0x1c0
> [    8.131563]  device_initial_probe+0x20/0x30
> [    8.131565]  bus_probe_device+0xa4/0xb0
> [    8.131567]  deferred_probe_work_func+0xa8/0xfc
> [    8.131570]  process_one_work+0x1dc/0x450
> [    8.131575]  worker_thread+0x154/0x450
> [    8.131577]  kthread+0x100/0x110
> [    8.131579]  ret_from_fork+0x10/0x20
> [    8.131584] ---[ end trace 0000000000000000 ]---
> [    8.131588] ------------[ cut here ]------------

I'm not sure if it's feasible, but if it is, it looks like something
that could be fixed by the patch pasted here:

https://lore.kernel.org/linux-clk/20220401122736.5yvanksa4pla7uql@houat/

Could you test it?

Thanks!
Maxime

--25docxotcljt756a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYkcWAgAKCRDj7w1vZxhR
xQhqAQD9TRfKP+yInwBbsA9UH7rk4a9uaL5qTy8IEhUfFGVMcgEA+j6eFXzx3DyM
UV7SUiD406ZMAkW0dK1UzfyTnNfYagE=
=U5oE
-----END PGP SIGNATURE-----

--25docxotcljt756a--
