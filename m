Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA43C51F83E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbiEIJd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiEIJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:31:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2B210B83;
        Mon,  9 May 2022 02:27:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 85ACD3200914;
        Mon,  9 May 2022 05:27:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 May 2022 05:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1652088463; x=
        1652174863; bh=z5peICARyV6gw69WenVqUK4dOs/cJCiJ9yWzJBPFzDE=; b=o
        kTtnZCT4WeqieMEGPaqyNLWwcEKjRrxPrpCLDclxp7cS6vEKFMSl/pZPO/J5s3EU
        HBfq1j8IPn+Wj43Gf9lb8Ea05aFlUqt2Uv4PxzRMTjY0H0gfhMs0MSGI6iwNHD6V
        RKNEnxG6v+6sMcqLEoj4KmE3Xj/JBngzyztnnJHH/1RzhjiCZLzM2d2ePf6NBSu4
        GaSK97vIjSwgTCSXZPaVaqhmvlAlM/J/dUuXrQpg5LNC0Ih9QT+/ay/gQ0ERk+Bn
        ABwkcW9a/E0KorbSyPvPh1DOtz0AkAOBW9iABcUtXO6UrBdpWFwnKtj97XAMdhaA
        nPQGYggFQEyUceszxNxoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652088463; x=1652174863; bh=z5peICARyV6gw
        69WenVqUK4dOs/cJCiJ9yWzJBPFzDE=; b=KUa9Jq29tvqGiT7uEf+FwpGtC4y11
        rJ+rPV8FWiaAwDEwWFGzDqWdTP4TtQfMlWTQ7eZnfs/SfkvVHOatLWdqjUapBN2p
        nNHhd2nlA9lIgV9x2OCMz9qgxi6Ek7RhCMzGexerhOuDeL3jd8JWVntUMTLVeYrk
        TxXvhA4GcKAVKPF2gv/fKICn+m8hhs8SNPpieaP3MVkllFsOCUnM8K3eDfwscdtT
        uyT8ASLxb0UMgqJbIyd3907EfjAUpk9t24Ha0Gg+C5bRLNsybR3fc3RlI/tUF+hN
        ScMsIUn15VzxpaxOFWYVkGFmlYMFQdEGPvYYiBTxBE1Pf3jS8axf25Wtw==
X-ME-Sender: <xms:jt54YvkOIbFttto_DW8q0SLk69Eb8rBjNkZQ93IkJHQEYsaxdmjptQ>
    <xme:jt54Yi0yCSL0a6gFQHB7pkDSdJ_KrjMFCHmTJ0yRg6Vxs5-zLVFRfXVJ_n624r4Wj
    aAmIhGBVgcJe64j5Ko>
X-ME-Received: <xmr:jt54Yloj2__KFd5aKy6belo4TMFx-SHLvpdQrHtO3D8evABhtLs2pjwqZrqX9b9AeTHGz3mP6EVF5gInpHXJNtlJTUjtmaqLHZ5CXa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedutdejgffftdehheetteduhfekgeevgeffteetfeejudfhuddukeefvdeg
    geeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:jt54YnlV7LkQsB0RtQEXuyrZQdOlGUOYUXMe1anqypbDjIgWILGSxQ>
    <xmx:jt54Yt3eOnTEawnqCtpFEAvX2U6ZUCJr8tsKzOJu8KzZMHLEQJbDvA>
    <xmx:jt54YmsO7vszbzzMMfN7TNXE47chBmrGlqmN9rX6CU9Ra1aPwVEsCA>
    <xmx:j954YnzGlUW4O3tjftTK39IT_HjBY6AWxQdbNZH7VN8-zvIi3pOOKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 May 2022 05:27:42 -0400 (EDT)
Date:   Mon, 9 May 2022 11:27:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Message-ID: <20220509092740.qmpizwxappy77ggc@houat>
References: <20220509084853.17068-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220509084853.17068-1-qianfanguijin@163.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:48:53PM +0800, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
>=20
> OPP table value is get from allwinner lichee 3.10 kernel.
>=20
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 291f4784e86c..90de119095fa 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -54,6 +54,41 @@ / {
>  	#size-cells =3D <1>;
>  	interrupt-parent =3D <&gic>;
> =20
> +	cpu0_opp_table: opp_table0 {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp-720000000 {
> +			opp-hz =3D /bits/ 64 <720000000>;
> +			opp-microvolt =3D <1000000 1000000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		opp-912000000 {
> +			opp-hz =3D /bits/ 64 <912000000>;
> +			opp-microvolt =3D <1100000 1100000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		opp-1008000000 {
> +			opp-hz =3D /bits/ 64 <1008000000>;
> +			opp-microvolt =3D <1160000 1160000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		opp-1104000000 {
> +			opp-hz =3D /bits/ 64 <1104000000>;
> +			opp-microvolt =3D <1240000 1240000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz =3D /bits/ 64 <1200000000>;
> +			opp-microvolt =3D <1300000 1300000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +	};
> +

How were these OPPs tested? If you didn't, please test with
https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test

And report the results

Also, U-Boot sets the 1008MHz OPP by default, and the voltage to match.
How is this going to play out on device tree where the CPU regulators
aren't set?

Maxime
