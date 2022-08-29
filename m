Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D4B5A41F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH2E2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2E2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:28:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5713DBF1;
        Sun, 28 Aug 2022 21:28:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F12233200684;
        Mon, 29 Aug 2022 00:28:26 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 00:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661747306; x=1661833706; bh=7f5gUMyENX
        zYFC/ZQNB5KKhl9DF71UmgTG9JV/GtQd8=; b=hmn02Qf0uEQelPuAsQJ5ZnUE4Q
        xQmoqWN2UacAqvaRq12ZKbf5tlFwbZsKQCDAjYNhRqbmDV1c55UrdL7L698rfVJ/
        yuXr5daTrDDI70KTiCs9qp9ZKgZxDAuzrwV8OShx7oVI35ylE2LajJzVPR9Ck4lW
        rvTwTmMXfCJ68ZbYLUsiGBsH5m+OJWsEXmGT6WaBkGNXB13DgvLNiTnS+9baPsmz
        m8wXdoUdKd85+15e7I8sWQNiJiqQ7Wm1+ytVVmZ6GbQJXyanIlafUmc8Mo/X1mGF
        Z4H/7mkfLS7f0Xt1FylqVCymZI5fsUYjoS+fmMBMORNQWeBzH0tMj/NAniMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661747306; x=
        1661833706; bh=7f5gUMyENXzYFC/ZQNB5KKhl9DF71UmgTG9JV/GtQd8=; b=L
        bu4AgXDZz8O9nzp65MSNkKZIRJP8N+hz1Yx9ZEn/iY/itxZoW99UNMieTrYViYL2
        9q6QJEsRzEAdtI9/K4ZgYBdOKqIwg2AMZ6azxM109K6PAn7u00Fl9tgGl6AoUuip
        JfXMi+S+CvZOLpOsoXxsrk1/OE1IMkskrXe/t7fREV/ajw7VgZZzkXtqTI47QCnN
        6P7JtRFIe9rrAbiu7KqseKbNQ2jDD1ARxpuwFL6baAvN0U8wnyGvyjA8HhRN0+at
        fIJePQ94Ra7xmjjkHTYcyUuL1+PHd5P9OzfbU0/SEllyhj+glUYzdyWyFJGFytCd
        jO+r0t7oziA8F625NFONA==
X-ME-Sender: <xms:aEAMY8QrbOmutEU30XGSFse7XEDO0i1EP3LpCn45AJKtlPY7qQO-Yw>
    <xme:aEAMY5zWBiu3rdljYwD_K5-XpWX3iP6ZaSj06CR_nywrqD1If9_WT9HY_3bwYCVjk
    jI5BQtUFCZ-NfGmQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdektddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfv
    ohhmucfhihhtiihhvghnrhihfdcuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvg
    druhhkqeenucggtffrrghtthgvrhhnpeegfffffeduteeutdeikeelvefgheeigfelgfei
    teejvefgjeekieekudehueevkeenucffohhmrghinhepmhgvghhouhhsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthho
    mhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:aUAMY53g6Y1zsNxUGlwyiU7nbIpviAYJ0Avac5Yvd5aSN8x2pAAuXw>
    <xmx:aUAMYwAdAQhqPMuN-BNnbia_ooXCTQ2ASvzexdxHuFt92OLgBnBCuQ>
    <xmx:aUAMY1gdy2Bkb0sQh9PZHa1c6ht-vE6rNBjGNjoW0ai1cPDxUGoNnA>
    <xmx:akAMY15NcvR_okLgwZSwTB0mv6GQU4FW2p85w5_0G-jaySqCTC5GIg>
Feedback-ID: iefc945ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EA7332A20079; Mon, 29 Aug 2022 00:28:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <7782b803-b331-4b19-84f5-86d1f06b0259@www.fastmail.com>
In-Reply-To: <20220822083339.o6bqlyirrm5hvjbc@core>
References: <20220822012449.21005-1-tom@tom-fitzhenry.me.uk>
 <20220822012449.21005-2-tom@tom-fitzhenry.me.uk>
 <20220822083339.o6bqlyirrm5hvjbc@core>
Date:   Mon, 29 Aug 2022 04:28:03 +0000
From:   "Tom Fitzhenry" <tom@tom-fitzhenry.me.uk>
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Heiko Stuebner" <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, "Martijn Braam" <martijn@brixit.nl>,
        =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        "Caleb Connolly" <kc@postmarketos.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <n@nfraprado.net>
Subject: Re: [PATCH v4 1/1] arm64: dts: rockchip: Add initial support for Pine64
 PinePhone Pro
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Megi.

On Mon, 22 Aug 2022, at 8:33 AM, Ond=C5=99ej Jirman wrote:
>> +			vdd_center: DCDC_REG2 {
>> +				regulator-name =3D "vdd_center";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt =3D <800000>;
>> +				regulator-max-microvolt =3D <1350000>;
>
> Looks like a wrong top voltage. https://megous.com/dl/tmp/ad3dcc62bd00=
f41f.png

I will fix this in v5.

>> +			vcca3v0_codec: LDO_REG1 {
>> +				regulator-name =3D "vcca3v0_codec";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>
> This should not be always on, but only enabled by the codec when neede=
d.
> You don't have codec described in this DT.

I will fix this in v5.

>> +			vcc3v0_touch: LDO_REG2 {
>> +				regulator-name =3D "vcc3v0_touch";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>
> This should not be always on. It should be enabled by touch controller,
> when needed. You don't have touch controller described in this DT.

I will fix this in v5.

>> +			vcca1v8_codec: LDO_REG3 {
>> +				regulator-name =3D "vcca1v8_codec";
>> +				regulator-always-on;
>> +				regulator-boot-on;
>
> This should not be always on, but only enabled by the codec when neede=
d,
> I suppose. Also modem codec is supplied by vcc1v8_codec which may need
> a gpio configured as pull-down or drive low to be properly disabled,
> and it is not defined in this DT. Please make sure that regulator's in=
put
> doesn't float and is disabled by default.

I will fix this in v5, including adding a regulator for vcc1v8_codec.

>> +&gpu_opp_table {
>> +	opp00 {
>> +		opp-hz =3D /bits/ 64 <200000000>;
>> +		opp-microvolt =3D <825000 825000 975000>;
>> +	};
>> +	opp01 {
>> +		opp-hz =3D /bits/ 64 <297000000>;
>> +		opp-microvolt =3D <825000 825000 975000>;
>> +	};
>> +	opp02 {
>> +		opp-hz =3D /bits/ 64 <400000000>;
>> +		opp-microvolt =3D <825000 825000 975000>;
>> +	};
>> +	opp03 {
>> +		opp-hz =3D /bits/ 64 <500000000>;
>> +		opp-microvolt =3D <875000 875000 975000>;
>> +	};
>> +	opp04 {
>> +		opp-hz =3D /bits/ 64 <600000000>;
>> +		opp-microvolt =3D <925000 925000 975000>;
>> +	};
>
> ^^^ Why replicate all these OPPs, when they have identical preferred v=
oltage
> in rk3399-opp.dtsi? Also GPU is not being enabled in the DT.
>
> You don't need display output support to enable the gpu right away.

My bad, I had forgotten that I'd originally decided to leave this out of=
 the first patch series. I will address this in the patch series when I =
enable the GPU.

>> +	opp05 {
>> +		status =3D "disabled";
>> +	};
>> +};
>> +
>> +
>
> ^ extra space

I will fix this in v5.
