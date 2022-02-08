Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3C4AE49F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387956AbiBHWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386543AbiBHUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:54:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43431C0612C3;
        Tue,  8 Feb 2022 12:54:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s7so956653edd.3;
        Tue, 08 Feb 2022 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDhjQ85RPBAN8gdoe5LBgB+KXAQiKOAIVei1JjMNISU=;
        b=KlypnIg2Q4TNPY7ywPtIVAaC6gRlZf6/GaS4h98jSWnLdWAidpxxul8Dh8RxnzInIB
         FxFlGMNuADDHiTj1ewb1BRF9aaR5XLlHuz2/sVe6MErGo3JBZhwGf3/3pyC74jJUe/AU
         ISjM5AFHdUg4pyXoFg9Qv4DHHrrXRF9/FGaSIcgOSflfHRjXYLzo55WHkUo3Yl7smqnF
         vOJWuKEk7HTt+0s3/+vvS+NBxUN1vEh5xKLL2O4TeJCTdxLrZkt7q+2iaZjfvz6d2j6c
         JVALpU/Xt00xdIc0NKJ0q7Z1+8bsP84m40fU9rIJfDFRB8BKYDyzClp0/Sh/iFL/IF4v
         gkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDhjQ85RPBAN8gdoe5LBgB+KXAQiKOAIVei1JjMNISU=;
        b=h0j3UXdmolw3xPe1fJRItIbVqrmZ/BiOeZPPxRpXtZN9E3liDjbee+4KsDHlJhRzDd
         GNJWvS6JV9FMHKOL5BU1OLpZSqtCWl6X7UeiCdKBELlC9jhJ++1NE2vk8t/+AGidc//k
         AQsk6bGl9RmWiSjvMvDVZLLtVFjBGw2uqtVDG/2JLz2DX71GNjVFO29pgu8bLX9A8Onh
         BW8YKHkhrRPD/hVmAZDOjcLJI9dYK+si+KYXaQEbpiNvYfGaTVV/lpDT8Wr2Schpcc82
         Ms3w4R/LOClJHpN92LnuEmPcCXPLle9RdK/Ss2e7mqo7WvoGomlUDYM4B+eUKNwe87Ce
         QY3A==
X-Gm-Message-State: AOAM530vQF7dJrG4m9Ck5v2vVBP6XFZPjTW94OW1/bQ1F8vxcbSD8qmF
        /zcjvXiJXvYXdy5Ovq1ZXOeiRe3PLQ/FMA==
X-Google-Smtp-Source: ABdhPJzKxy1DftrC9Hdvyz71ZUjBbAQJvqevq1dibwVr5XOxE/w6Jr5uhIT+BNs11hMybA1XTWmzhw==
X-Received: by 2002:aa7:dbc3:: with SMTP id v3mr6404848edt.32.1644353654531;
        Tue, 08 Feb 2022 12:54:14 -0800 (PST)
Received: from netbook-debian ([94.179.49.215])
        by smtp.gmail.com with ESMTPSA id gj8sm2329107ejc.186.2022.02.08.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:54:14 -0800 (PST)
Date:   Tue, 8 Feb 2022 22:54:09 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add CPU core voltage
Message-ID: <20220208225409.5285adf9@netbook-debian>
In-Reply-To: <11918951.O9o76ZdvQC@natalenko.name>
References: <20220208094244.1106312-1-eugene.shalygin@gmail.com>
        <11918951.O9o76ZdvQC@natalenko.name>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2022 17:15:46 +0100
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Hello.
>=20
> On =C3=BAter=C3=BD 8. =C3=BAnora 2022 10:42:43 CET Eugene Shalygin wrote:
> > A user discovered [1] the CPU Core voltage sensor, which spans 2
> > registers and provides output in mV. Althroug the discovery was made
> > with a X470 chipset, the sensor is present in X570 (tested with
> > C8H). For now simply add it to each board with the CPU current
> > sensor present.
> >=20
> > [1] https://github.com/zeule/asus-ec-sensors/issues/12
> >=20
> > Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> > ---
> >  Documentation/hwmon/asus_ec_sensors.rst |  1 +
> >  drivers/hwmon/asus-ec-sensors.c         | 29
> > ++++++++++++++++--------- 2 files changed, 20 insertions(+), 10
> > deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/asus_ec_sensors.rst
> > b/Documentation/hwmon/asus_ec_sensors.rst index
> > 22de1b037cfb..e7e8f1640f45 100644 ---
> > a/Documentation/hwmon/asus_ec_sensors.rst +++
> > b/Documentation/hwmon/asus_ec_sensors.rst @@ -39,6 +39,7 @@ The
> > driver is aware of and reads the following sensors: 9. Readings
> > from the "Water flow meter" header (RPM) 10. Readings from the
> > "Water In" and "Water Out" temperature headers 11. CPU current
> > +12. CPU core voltage
> > =20
> >  Sensor values are read from EC registers, and to avoid race with
> > the board firmware the driver acquires ACPI mutex, the one used by
> > the WMI when its diff --git a/drivers/hwmon/asus-ec-sensors.c
> > b/drivers/hwmon/asus-ec-sensors.c index dd7b207d062f..bfac08a5dc57
> > 100644 --- a/drivers/hwmon/asus-ec-sensors.c
> > +++ b/drivers/hwmon/asus-ec-sensors.c
> > @@ -18,6 +18,7 @@
> >   * - VRM Heat Sink fan RPM
> >   * - Water Flow fan RPM
> >   * - CPU current
> > + * - CPU core voltage
> >   */
> > =20
> >  #include <linux/acpi.h>
> > @@ -100,6 +101,8 @@ enum ec_sensors {
> >  	ec_sensor_temp_t_sensor,
> >  	/* VRM temperature [=E2=84=83] */
> >  	ec_sensor_temp_vrm,
> > +	/* CPU Core voltage [mV] */
> > +	ec_sensor_in_cpu_core,
> >  	/* CPU_Opt fan [RPM] */
> >  	ec_sensor_fan_cpu_opt,
> >  	/* VRM heat sink fan [RPM] */
> > @@ -121,6 +124,7 @@ enum ec_sensors {
> >  #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
> >  #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
> >  #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
> > +#define SENSOR_IN_CPU_CORE BIT(ec_sensor_in_cpu_core)
> >  #define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
> >  #define SENSOR_FAN_VRM_HS BIT(ec_sensor_fan_vrm_hs)
> >  #define SENSOR_FAN_CHIPSET BIT(ec_sensor_fan_chipset)
> > @@ -139,6 +143,8 @@ static const struct ec_sensor_info
> > known_ec_sensors[] =3D { [ec_sensor_temp_t_sensor] =3D
> >  		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> >  	[ec_sensor_temp_vrm] =3D EC_SENSOR("VRM", hwmon_temp, 1,
> > 0x00, 0x3e),
> > +	[ec_sensor_in_cpu_core] =3D
> > +		EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
> >  	[ec_sensor_fan_cpu_opt] =3D
> >  		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
> >  	[ec_sensor_fan_vrm_hs] =3D EC_SENSOR("VRM HS", hwmon_fan, 2,
> > 0x00, 0xb2), @@ -172,32 +178,34 @@ static const struct
> > dmi_system_id asus_ec_dmi_table[] __initconst =3D {
> > SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
> > DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
> > SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> > -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> > +		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> > SENSOR_IN_CPU_CORE), =20
>=20
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>=20
> on Pro WS X570-ACE:
>=20
> ```
> asusec-isa-0000
> Adapter: ISA adapter
> CPU Core:      1.47 V
> =E2=80=A6
> ```
>=20
> Thanks.
>=20
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> >  			      "ROG CROSSHAIR VIII DARK HERO",
> >  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> > -		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
> > SENSOR_CURR_CPU),
> > +		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
> > +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> >  			      "ROG CROSSHAIR VIII FORMULA",
> >  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT |
> > SENSOR_FAN_CHIPSET |
> > -		SENSOR_CURR_CPU),
> > +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG
> > CROSSHAIR VIII HERO", SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> >  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> > -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> > +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
> > SENSOR_IN_CPU_CORE), DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> >  			      "ROG CROSSHAIR VIII HERO (WI-FI)",
> >  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> >  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> > -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> > +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
> > SENSOR_IN_CPU_CORE), DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> >  			      "ROG CROSSHAIR VIII IMPACT",
> >  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > SENSOR_TEMP_T_SENSOR |
> > -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> > SENSOR_CURR_CPU),
> > +		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> > +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX
> > B550-E GAMING", SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> >  		SENSOR_TEMP_T_SENSOR |
> > @@ -205,17 +213,19 @@ static const struct dmi_system_id
> > asus_ec_dmi_table[] __initconst =3D {
> > DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I
> > GAMING", SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> > -		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
> > SENSOR_CURR_CPU),
> > +		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
> > +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX
> > X570-E GAMING", SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> >  		SENSOR_TEMP_T_SENSOR |
> > -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> > SENSOR_CURR_CPU),
> > +		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> > +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX
> > X570-F GAMING", SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> >  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
> >  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX
> > X570-I GAMING", SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> > -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> > +		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> > SENSOR_IN_CPU_CORE), {}
> >  };
> > =20
> > @@ -467,7 +477,6 @@ static long scale_sensor_value(s32 value, int
> > data_type) switch (data_type) {
> >  	case hwmon_curr:
> >  	case hwmon_temp:
> > -	case hwmon_in:
> >  		return value * MILLI;
> >  	default:
> >  		return value;
> >  =20
>=20
>=20

Tested-by: Denis Pauk <pauk.denis@gmail.com>

Best regards,
             Denis.
