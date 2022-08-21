Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2E59B6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiHUWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHUWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 18:43:09 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F074F19C2E
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 15:43:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b2so6999749qvp.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=SLQM5J0xWlA5wbIdPKtFesag8huNtFa4txc60rMlobs=;
        b=LCe/vgen+XCMH74gOLjR7bN1ArujZ6DZNPJ6V53+IEZ6OgRPAwymR/F67fphTrZJ7i
         WX/OvPvYDb/q0lzT6y/ojevJgVtkkrJVME07VVUjhe+W7SrXZWha/xHvLbEo6dn99ALm
         RnU0FdS39Zd379nE+54lq5MlVZdTagm7AXtwD5nlksNAy8MY/8Kd/r5nFNZmDzU9lks7
         Kl8wGX1X2MLbJYkrWRYSh7eTAwvMiT/+8r/He0mVxOkpPhFRsaNUQXxkeIZIYl0Dclq2
         /fa1qWEhJOXvtuNsFdztaVKjysOZ6qJ3qfrrLqosuTGWz6e0b+we+E1tOoYP6nMxFiPu
         hQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SLQM5J0xWlA5wbIdPKtFesag8huNtFa4txc60rMlobs=;
        b=qKgm8UcdNS8fMGUcOaoP3ZgjpMvHKURfcwW/Kgk8tEdJmnPsI9cvGOmqkWdHLIC8Ol
         oOFASUU9whH4pxEbrEjPrn1HO8Y/Vq46gXfwOmqKkPy+GXwlMMWKtfdabsLIgL2nT/Gp
         Y/tL/IEdOTteSsRfZvmGgtOkq1oToivFJwTvOO0vBsiYs/pcCdQDDqAdyPGyN0j3yzyO
         nmwIlgNFrQnTOaMcks/I1juaXPUgg2XYR4Ddw932Kz7EXtiUrUFDIgjfT6LPnsy3tdGy
         O92e3u/C6dy3oL9LZWox3IAdiwXMlCNFw9nOGwQArZdPJL3ECXdYWFIYk4k5pbFt5M64
         +FXg==
X-Gm-Message-State: ACgBeo3DwOGhlHzDJNdUT8bxTA0s8lUxjjHjdKGQwb+P30ljp9GMCu0l
        4hhX17xDIwgFN2gGrHyvkinMCQ==
X-Google-Smtp-Source: AA6agR4jUAHSGLWTrHVAFXBM1VWQtLl/q6Bx2pU2iMNntHvDE7gUn5RyeTtfpxPXQQyVdyC/TQ5EXQ==
X-Received: by 2002:a05:6214:d6d:b0:496:e11b:69e9 with SMTP id 13-20020a0562140d6d00b00496e11b69e9mr2366488qvs.45.1661121786638;
        Sun, 21 Aug 2022 15:43:06 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g25-20020ac84b79000000b00342fc6a8e25sm7805333qts.50.2022.08.21.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 15:43:06 -0700 (PDT)
Date:   Sun, 21 Aug 2022 18:43:04 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v5 2/3] Documentation: ABI: sysfs-bus-counter: add
 capture items
Message-ID: <YwK0+BNSo4X2KA29@fedora>
References: <20220817141620.256481-1-jpanis@baylibre.com>
 <20220817141620.256481-3-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2NJOCRB2znqdE3uV"
Content-Disposition: inline
In-Reply-To: <20220817141620.256481-3-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2NJOCRB2znqdE3uV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 17, 2022 at 04:16:19PM +0200, Julien Panis wrote:
> This commit adds capture items to counter ABI file
> (e.g. TI ECAP used in capture operating mode).
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 49 +++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 06c2b3e27e0b..52ddec7cc76a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -203,6 +203,24 @@ Description:
>  		both edges:
>  			Any state transition.
> =20
> +What:		/sys/bus/counter/devices/counterX/countY/count_cumul
> +KernelVersion:	6.0
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Read-only attribute that indicates the raw cumulated count
> +		since count Y start, computed as follow:
> +		count_cumul =3D (max_counter_val + 1) * nb_counter_overflows

Implement this instead as "num_overflows" (COUNTER_COMP_COUNT_U64) and
"ceiling" (COUNTER_COMP_CEILING). You need to expose the count ceiling
anyway and a new "num_overflows" attribute would be useful for other
drivers as well.

> +What:		/sys/bus/counter/devices/counterX/countY/captureZ
> +KernelVersion:	6.0
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Read-only attributes that indicate the last raw timestamp captured
> +		for the respective capture Z register.
> +		Raw timestamp can be converted to nanoseconds as follow:
> +		time_ns =3D 10^9 * (captureZ + count_cumul) / frequency
> +		count_cumul and frequency parameters are described in this document.

Rework this description to make it more general: remove the nanoseconds
conversion formula and references to timestamps. The concept of a
capture is general enough that it could be provided by counter devices
that are not necessarily timestamping. Instead this description should
simply state that this attribute is a historical capture of the Count Y
count data where Z (if present) is the respective capture buffer element
offset.

>  What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
> @@ -213,6 +231,8 @@ What:		/sys/bus/counter/devices/counterX/countY/presc=
aler_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_=
id
>  What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component=
_id
> +What:		/sys/bus/counter/devices/counterX/countY/count_cumul_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/captureZ_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_comp=
onent_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_=
component_id
> @@ -345,3 +365,32 @@ Description:
>  			via index_polarity. The index function (as enabled via
>  			preset_enable) is performed synchronously with the
>  			quadrature clock on the active level of the index input.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/polarityZ
> +KernelVersion:	6.0
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Capture modules include N timestamp capture registers.
> +		For all N sequenced timestamp capture events
> +		(1->2->3->...->N->1->...), edge polarity can be selected.
> +		The following polarities are available:
> +
> +		rising edge:
> +			Low state transitions to high state.
> +
> +		falling edge:
> +			High state transitions to low state.

Other drivers could use "polarity" for signals that are not related to
captures, so remove the language referencing timestamping and generalize
it to simply refer to selecting the Signal Y edge polarity where Z (if
present) is the respective polarity sequence position.

William Breathitt Gray

--2NJOCRB2znqdE3uV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYwK09wAKCRC1SFbKvhIj
K8oDAPdLQOsV0FlcmpzhIjokWkcH5BVTKUkR7GjQ2TQlty8TAQCZWfBCROCuCvP5
MmMLxq00AF6NW8X7KSdJEupDC04oCA==
=WaOi
-----END PGP SIGNATURE-----

--2NJOCRB2znqdE3uV--
