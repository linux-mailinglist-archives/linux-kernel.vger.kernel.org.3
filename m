Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898A358CCC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbiHHRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiHHRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:37:44 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05A17050
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:37:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h125so11125173oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc;
        bh=8El6/y4C2ZPX2yELljyvmJcdy/glzkw03crtz7p/8Qg=;
        b=jWz9m/Lv1SCw0u+cyWggoKLtc6jD1VDjJvJO9/FV9obfAgL9mUyhChzEwGtuWTCCXg
         PZ/JxxHyvTiizWtXX4XRmcTlB6C7fDFQaSZDaK+H7w753KHQSZkH8cDp9fb0RgJR8ess
         34yR08qYiLQg5YFMKtKKue0wkyaHOA2Kpm28gEcSUbf81MFjMLU6i5v/ergbu+2hyPCO
         o4nq1pRdgck77FAXBa/xx1nKBT9+g7mp+zsMX0R5Z/jq2S8WxjaPo0LeqDNtDZmheq+e
         s3okpjjQWz2Ek9BHhEHvT4vRQHO1cDq9YAmrjiqHy/7RW+Zbbe554gwEUJTpxwGR966x
         fqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=8El6/y4C2ZPX2yELljyvmJcdy/glzkw03crtz7p/8Qg=;
        b=Z7WSkicb+TZsu44v3jBUv1Z7rQRe/dEoVPJfDyiZ1EeOvVAug+yjVMETWSd3W1Ccv1
         QxYkyVkvKlD5HJm0vhxcLlM2Zz0muaH7MG//oxKlF9Q7SeBVxUEl0b3+j55si8N9AEXo
         xtUBVAfsLZG0Qpn/PX6A0ZWgn7aQt6VrgXik1Y2+96JLwuGWjdOQ+rdFgrLarMGyl5ER
         B+lXV3QmpVM09K4OnGsZp3KtHnKmOspgt7y/qm+Bpi4XO1MDQkdysbBiUOcZLsXOcP1R
         X5Hme8j5K4xE5Y5f56T7iTn+y4TgpfCdF6ETcjMNIzSTkbnXCCzIY5FLAhHTxghbU/Kq
         A6gQ==
X-Gm-Message-State: ACgBeo2Y+99bVw8RCKOqaTxCuhgv6xTEwunCQb17LzqYtcFfOLLbq+t4
        0wo/oJ/ZCAqDw8mDl9ubz/x1eCQoTHymjq6pLz4nhSkW/VUMxg==
X-Google-Smtp-Source: AA6agR5VGE9b/GImxZUVPrnUDL9A0fPYyjIJ7qbfFUuxtb5lEJHnUwNddOG/L6gIvkW5VR3rDSjgDEcDCIUoZnzrjb8=
X-Received: by 2002:a05:6808:aad:b0:342:9a85:882c with SMTP id
 r13-20020a0568080aad00b003429a85882cmr10463249oij.80.1659980262465; Mon, 08
 Aug 2022 10:37:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d58c:0:0:0:0:0 with HTTP; Mon, 8 Aug 2022 10:37:41 -0700 (PDT)
In-Reply-To: <20220808142549.tdoc76vrcqcf2dxu@core>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-2-tom@tom-fitzhenry.me.uk> <20220808142549.tdoc76vrcqcf2dxu@core>
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Mon, 8 Aug 2022 13:37:41 -0400
Message-ID: <CAN1fySWVVTeGHAD=_hFH+ZdcR_AEiBc0wqes9Y4VRzB=zcdvSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: Add RK3399-T opp
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Dionne-Riel <samuel@dionne-riel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/22, Ond=C5=99ej Jirman <megi@xff.cz> wrote:
> Hi,
>
> On Sat, Aug 06, 2022 at 09:44:09AM +1000, Tom Fitzhenry wrote:
>> From: Samuel Dionne-Riel <samuel@dionne-riel.com>
>>
>> These tables were derived from the regular RK3399 table, by dropping
>> entries exceeding recommended operating conditions from the datasheet,
>> and clamping the last exceeding value where it made sense.
>
> Do we really need to duplicate the whole OPP table of rk3399-opp.dtsi
> just to disable a few top opp## entries?
>
> This will make it more annoying to add PVTM/eFuse leakage based voltage
> selection support later on, because then there would have to be identical
> multi-level operating points across multiple files. And that sounds like
> a LOT of dupplication for little benefit.
>
> Also Pinephone Pro has RK3399S not -T. RK3399 seems to be RK3399 selected
> for
> low leakage (values I've seen from eFuses indicate the leakage is half th=
at
> of
> RK3399 available in Pinebook Pro)

The vendor (PINE64) asked me to make these changes while stating specifical=
ly
that the Pinephone Pro uses the RK3399-T. Though earlier units and current
batches use the RK3399[s], the design was reportedly made with the RK3399-T
in mind.

The device was also designed to use the OPP from the RK3399-T on RK3399[s]
for the designed thermal operation of the device, reportedly.

> I'd suggest just adding references to select operating point nodes that
> are "too much" and disabling them with status =3D "disabled". This
> can be done from the pinephone device tree file directly.
>
> Otherwise we'll eventually end up with several files containing
> something like this [1] and only differing in absence of some opp## nodes
> and not their actual useful content.

As to why this is a new file? I have assumed it would be preferable since
this is how it was done for the "OP1" variant of the RK3399. I will defer t=
o
the Rockchip and ARM maintainers to determine which way is better.

I will note that in practice I agree here.

Cheers,

> [1]
> https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boo=
t/dts/rockchip/rk3399-opp.dtsi#L6
>
> kind regards,
> 	o.
>
>> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
>> ---
>>  .../arm64/boot/dts/rockchip/rk3399-t-opp.dtsi | 118 ++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
>> new file mode 100644
>> index 0000000000000..ec153015d9d13
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
>> + * Copyright (c) 2022 Samuel Dionne-Riel <samuel@dionne-riel.com>
>> + */
>> +
>> +/ {
>> +	cluster0_opp: opp-table-0 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <408000000>;
>> +			opp-microvolt =3D <825000 825000 925000>;
>> +			clock-latency-ns =3D <40000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <600000000>;
>> +			opp-microvolt =3D <825000 825000 925000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <816000000>;
>> +			opp-microvolt =3D <850000 850000 925000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <1008000000>;
>> +			opp-microvolt =3D <925000 925000 925000>;
>> +		};
>> +	};
>> +
>> +	cluster1_opp: opp-table-1 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <408000000>;
>> +			opp-microvolt =3D <825000 825000 1150000>;
>> +			clock-latency-ns =3D <40000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <600000000>;
>> +			opp-microvolt =3D <825000 825000 1150000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <816000000>;
>> +			opp-microvolt =3D <825000 825000 1150000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <1008000000>;
>> +			opp-microvolt =3D <875000 875000 1150000>;
>> +		};
>> +		opp04 {
>> +			opp-hz =3D /bits/ 64 <1200000000>;
>> +			opp-microvolt =3D <950000 950000 1150000>;
>> +		};
>> +		opp05 {
>> +			opp-hz =3D /bits/ 64 <1416000000>;
>> +			opp-microvolt =3D <1025000 1025000 1150000>;
>> +		};
>> +		opp06 {
>> +			opp-hz =3D /bits/ 64 <1500000000>;
>> +			opp-microvolt =3D <1100000 1100000 1150000>;
>> +		};
>> +	};
>> +
>> +	gpu_opp_table: opp-table-2 {
>> +		compatible =3D "operating-points-v2";
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <200000000>;
>> +			opp-microvolt =3D <825000 825000 975000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <297000000>;
>> +			opp-microvolt =3D <825000 825000 975000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <400000000>;
>> +			opp-microvolt =3D <825000 825000 975000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <500000000>;
>> +			opp-microvolt =3D <875000 875000 975000>;
>> +		};
>> +		opp04 {
>> +			opp-hz =3D /bits/ 64 <600000000>;
>> +			opp-microvolt =3D <925000 925000 975000>;
>> +		};
>> +	};
>> +};
>> +
>> +&cpu_l0 {
>> +	operating-points-v2 =3D <&cluster0_opp>;
>> +};
>> +
>> +&cpu_l1 {
>> +	operating-points-v2 =3D <&cluster0_opp>;
>> +};
>> +
>> +&cpu_l2 {
>> +	operating-points-v2 =3D <&cluster0_opp>;
>> +};
>> +
>> +&cpu_l3 {
>> +	operating-points-v2 =3D <&cluster0_opp>;
>> +};
>> +
>> +&cpu_b0 {
>> +	operating-points-v2 =3D <&cluster1_opp>;
>> +};
>> +
>> +&cpu_b1 {
>> +	operating-points-v2 =3D <&cluster1_opp>;
>> +};
>> +
>> +&gpu {
>> +	operating-points-v2 =3D <&gpu_opp_table>;
>> +};
>> --
>> 2.37.1
>>
>

--=20
=E2=80=94 Samuel Dionne-Riel
