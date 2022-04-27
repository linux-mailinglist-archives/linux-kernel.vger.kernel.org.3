Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98F2511DED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiD0RAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbiD0RAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:00:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2AC1580E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:57:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 125so3876493iov.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=Y1ivuFVRU8wdS3czu8kzEmQaRPo5keRKWPeKEDXR+3o=;
        b=JZeV1kjxZ/ZzHdw55o2kSE9D+HMmVwGIl8+GAA5u2RUt5s3+o2pIPJM+2f7/XYrKP2
         SsZXaiw0KbT4pOzj3Anhlj3ZM+A+dMroAbe/jBaT46HdHwfSHCO56i5/Qb+fMvHs3wnD
         xid6EnijbQI/+T5lNZjVRa1oOHQ/XVB1BMEpNmq4ZsncIJ2diWuwZr+/F6804O+rgAbs
         qlvm6H9/96S5zGREGS6dCstYxPHHYiPTZC3zfZoVsJWCHQwOqY9i6EicAf1QOvDiRUUY
         yIT93zZTNidx/xcdigE+cJJrGZgYWwA58I0nML0QxTCfB0LYNHJwh0WoeIzyPy1tVuZH
         jxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=Y1ivuFVRU8wdS3czu8kzEmQaRPo5keRKWPeKEDXR+3o=;
        b=XKP/NHoRpQxScm/E4Q/SKjBkWMoC58SJMgMecxarEvuDvu6zJXvWfaYOLdv4p9M1eJ
         bbb9DLqc6KmJg4hctehWpeqFEqwBgDEYOVZGiBNH0/r12POBfoB1azI/DtQu4YEZhTg7
         nhIMQBoNwCNDnxE6zJqRaXxMwC+0qbclpVckwOVY1ySMX2J0ZD0kALIvjKKz0NNPBcvX
         hJiMtPmGpGjOIOZzF7h4iltism4bCrxpLVMA2Mv8vJFmRqtfQTDolFC4+oaL+Ol/RPn/
         aSvhfP0Dq87RngunDzRWykl/AiTbTMV8pvnpIhjE6SZ/YsfH7F4QzBx+3d1bTUa+71m9
         GA5A==
X-Gm-Message-State: AOAM531prrkEhY5ZoDaU875UD92CtWIs49L6OU6ixJ58BF32It8hC3nf
        9nEn24xN5izCUzJJ3Gbe6bKC7EQ4WxR4/etkdas=
X-Received: by 2002:a05:6638:16cc:b0:32a:7375:8472 with SMTP id
 g12-20020a05663816cc00b0032a73758472mt12612390jat.256.1651078660862; Wed, 27
 Apr 2022 09:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com> <20220427143001.1443605-5-eugene.shalygin@gmail.com>
In-Reply-To: <20220427143001.1443605-5-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 27 Apr 2022 18:57:29 +0200
Message-ID: <CAB95QAQ0jwgQyV+PCVy1swN8hXC9U2oRbtbPqU13oW8_1v9zaw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] hwmon: (asus-ec-sensors) add PRIME X470-PRO board
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G=C3=BCnter,

I forgot to add PRIME X470-PRO to the list of supported boards in
Documentation/hwmon/asus_ec_sensors.rst. Could you, please, add that?
It should be the first entry. Commit
8f8db4b5d10cc4a2a801514e677dd5205651b771. Or should I resend this
patch?

Thank you,
Eugene

On Wed, 27 Apr 2022 at 16:30, Eugene Shalygin <eugene.shalygin@gmail.com> w=
rote:
>
> This board is supposed to be handled by the asus-wmi-sensors driver,
> but due to a buggy WMI implementation the driver and the official ASUS
> software make the BIOS hang together with fan controls [1, 2].
>
> This driver complements values provided by the SIO chip and does not
> freeze the BIOS, as tested by a user [2].
>
> [1] https://github.com/electrified/asus-wmi-sensors/blob/master/README.md
> [2] https://github.com/zeule/asus-ec-sensors/issues/12
>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>  drivers/hwmon/asus-ec-sensors.c | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sens=
ors.c
> index 109c3920d77c..998d49d6b799 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -137,10 +137,41 @@ enum ec_sensors {
>
>  enum board_family {
>         family_unknown,
> +       family_amd_400_series,
>         family_amd_500_series,
>  };
>
>  /* All the known sensors for ASUS EC controllers */
> +static const struct ec_sensor_info sensors_family_amd_400[] =3D {
> +       [ec_sensor_temp_chipset] =3D
> +               EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
> +       [ec_sensor_temp_cpu] =3D
> +               EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
> +       [ec_sensor_temp_mb] =3D
> +               EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
> +       [ec_sensor_temp_t_sensor] =3D
> +               EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> +       [ec_sensor_temp_vrm] =3D
> +               EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +       [ec_sensor_in_cpu_core] =3D
> +               EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
> +       [ec_sensor_fan_cpu_opt] =3D
> +               EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xbc),
> +       [ec_sensor_fan_vrm_hs] =3D
> +               EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
> +       [ec_sensor_fan_chipset] =3D
> +               /* no chipset fans in this generation */
> +               EC_SENSOR("Chipset", hwmon_fan, 0, 0x00, 0x00),
> +       [ec_sensor_fan_water_flow] =3D
> +               EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xb4),
> +       [ec_sensor_curr_cpu] =3D
> +               EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
> +       [ec_sensor_temp_water_in] =3D
> +               EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x0d),
> +       [ec_sensor_temp_water_out] =3D
> +               EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x0b),
> +};
> +
>  static const struct ec_sensor_info sensors_family_amd_500[] =3D {
>         [ec_sensor_temp_chipset] =3D
>                 EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
> @@ -186,6 +217,15 @@ struct ec_board_info {
>  };
>
>  static const struct ec_board_info board_info[] =3D {
> +       {
> +               .board_names =3D {"PRIME X470-PRO"},
> +               .sensors =3D SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +                       SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +                       SENSOR_FAN_CPU_OPT |
> +                       SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> +               .mutex_path =3D ACPI_GLOBAL_LOCK_PSEUDO_PATH,
> +               .family =3D family_amd_400_series,
> +       },
>         {
>                 .board_names =3D {"PRIME X570-PRO"},
>                 .sensors =3D SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP=
_VRM |
> @@ -753,6 +793,9 @@ static int __init asus_ec_probe(struct platform_devic=
e *pdev)
>         ec_data->board_info =3D pboard_info;
>
>         switch (ec_data->board_info->family) {
> +       case family_amd_400_series:
> +               ec_data->sensors_info =3D sensors_family_amd_400;
> +               break;
>         case family_amd_500_series:
>                 ec_data->sensors_info =3D sensors_family_amd_500;
>                 break;
> --
> 2.35.1
>
