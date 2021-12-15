Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F334783BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhLQDnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:43:22 -0500
Received: from ixit.cz ([94.230.151.217]:38938 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhLQDnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:43:21 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D07DB24CC2;
        Wed, 15 Dec 2021 16:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639582118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Edv46GPYMJdJozDwMUanWLkqZtLTb27/B2Rn3iDwNQ=;
        b=GXAPaLdrpkYx14JHvm2zisZ8qSpyq6BTeXd+5OCNNVgTl7mfP7w0pnkjJ6j+ERP6EMLjsp
        p1WonHQHoHUOFb+ugI5ZjjFPxXdfcjUpgLiSuPnUTl5k8k3AE43bq7HYSEYQexRSBGbAj2
        mBODbbk2VLtGW/X1asJafXM+CLhPqqg=
Date:   Wed, 15 Dec 2021 16:28:30 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v6 11/28] ARM: tegra: Add device-tree for ASUS Transformer
 Infinity TF700T
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?iso-8859-2?q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <INX54R.ECW0Q9B43ONC3@ixit.cz>
In-Reply-To: <YboHd6tIUrl+LJQb@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
        <20211211211412.10791-12-digetx@gmail.com> <Ybn1Ne2aGfsablwQ@orome>
        <02d7e9a9-6999-cccd-aea2-d069c759cd56@gmail.com> <YboHd6tIUrl+LJQb@orome>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry and Thierry!

Sent as "[PATCH] dt-bindings: display: bridge: document Toshiba=20
TC358768 cells and panel node",

I'll try to not keep these patches for myself for so long.
David

On Wed, Dec 15 2021 at 16:19:19 +0100, Thierry Reding=20
<thierry.reding@gmail.com> wrote:
> On Wed, Dec 15, 2021 at 05:52:24PM +0300, Dmitry Osipenko wrote:
>>  15.12.2021 17:01, Thierry Reding =DF=D8=E8=D5=E2:
>>  > On Sun, Dec 12, 2021 at 12:13:55AM +0300, Dmitry Osipenko wrote:
>>  > [...]
>>  >> +		i2c@1 {
>>  >> +			reg =3D <1>;
>>  >> +			#address-cells =3D <1>;
>>  >> +			#size-cells =3D <0>;
>>  >> +
>>  >> +			dsi-bridge@7 {
>>  >> +				compatible =3D "toshiba,tc358768";
>>  >> +				reg =3D <0x7>;
>>  >> +
>>  >> +				#address-cells =3D <1>;
>>  >> +				#size-cells =3D <0>;
>>  >> +
>>  >> +				clocks =3D <&tc358768_osc>;
>>  >> +				clock-names =3D "refclk";
>>  >> +
>>  >> +				reset-gpios =3D <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
>>  >> +
>>  >> +				vddc-supply =3D <&vdd_1v2_mipi>;
>>  >> +				vddio-supply =3D <&vdd_1v8_vio>;
>>  >> +				vddmipi-supply =3D <&vdd_1v2_mipi>;
>>  >> +
>>  >> +				ports {
>>  >> +					#address-cells =3D <1>;
>>  >> +					#size-cells =3D <0>;
>>  >> +
>>  >> +					port@0 {
>>  >> +						reg =3D <0>;
>>  >> +
>>  >> +						bridge_input: endpoint {
>>  >> +							remote-endpoint =3D <&dpi_output>;
>>  >> +							data-lines =3D <24>;
>>  >> +						};
>>  >> +					};
>>  >> +
>>  >> +					port@1 {
>>  >> +						reg =3D <1>;
>>  >> +
>>  >> +						bridge_output: endpoint {
>>  >> +							remote-endpoint =3D <&panel_input>;
>>  >> +						};
>>  >> +					};
>>  >> +				};
>>  >> +
>>  >> +				/*
>>  >> +				 * Panasonic VVX10F004B00 or HYDIS HV101WU1-1E1
>>  >> +				 * LCD SuperIPS+ Full HD panel.
>>  >> +				 */
>>  >> +				panel@1 {
>>  >> +					compatible =3D "panasonic,vvx10f004b00";
>>  >> +					reg =3D <1>;
>>  >> +
>>  >> +					power-supply =3D <&vdd_pnl>;
>>  >> +					backlight =3D <&backlight>;
>>  >> +
>>  >> +					port {
>>  >> +						panel_input: endpoint {
>>  >> +							remote-endpoint =3D <&bridge_output>;
>>  >> +						};
>>  >> +					};
>>  >> +				};
>>  >
>>  > make dtbs_check complains about this and says that panel@1 (as=20
>> well as
>>  > #address-cells and #size-cells) are not allowed here. And indeed=20
>> the
>>  > binding for the Toshiba bridge doesn't mention them here.
>>  >
>>  > Do we need this here or should this be moved to the top level to=20
>> fix
>>  > those warnings? I guess what you're doing above is describe a DSI=20
>> bus
>>  > created by the DSI bridge, which also makes sense, so another
>>  > alternative would be to fix up the binding and let it accept those
>>  > properties.
>>=20
>>  Toshiba bridge binding is incomplete. David has patch for that [1],=20
>> I
>>  don't think that it was sent out yet.
>>=20
>>  [1]
>> =20
>> https://github.com/okias/linux/commit/0875230062294b6db17f395ced0a8384a4=
c1cfc7
>=20
> Okay, please make sure this finds its way upstream eventually. That
> patch looks quite similar to what I tried to do to fix this up=20
> locally.
>=20
> Thierry


