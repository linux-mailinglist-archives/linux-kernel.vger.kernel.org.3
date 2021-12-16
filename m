Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAA47794B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhLPQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:36:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:40631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhLPQgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639672581;
        bh=/AbJGsc+dkLlG/Crdoxg/i9h2UZPWSTdX2g4mIfzJC0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QZvaS/2vp2wvumNwP2p9GDMS+WhVLLMLj4RIy5PkU+HQTNwp6X1P+yMarmZG3a+2h
         G2vMcFahcME2KyBe63Zx7N3NRLVPAcMzHutuij8PhinoViECjEVnFG1No/FvMUMXrG
         E3Xb49u5QpPUxpR5/bA/FVVO/H+By7XBnnfJTKck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.8] ([217.61.157.8]) by web-mail.gmx.net
 (3c-app-gmx-bap16.server.lan [172.19.172.86]) (via HTTP); Thu, 16 Dec 2021
 17:36:21 +0100
MIME-Version: 1.0
Message-ID: <trinity-18dddf5d-bc73-453d-a9eb-954de1ab7cc7-1639672581601@3c-app-gmx-bap16>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Aw: Re: [PATCH 1/2] mfd: rk808: add reboot support to rk808 pmic
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 16 Dec 2021 17:36:21 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <fe895d71-5f1f-daf0-bde8-c8ab5f4c0128@arm.com>
References: <20211215213300.4778-1-linux@fw-web.de>
 <20211215213300.4778-2-linux@fw-web.de>
 <fe895d71-5f1f-daf0-bde8-c8ab5f4c0128@arm.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:S5uDaFlDscxRzpQVDFb8E4cYXWI5fyFsA/fFhQaFn8DZ1YSZI4MQXF5quP6Gs9iaCmCyT
 RMrb00sUuIikMWruGhu4sYBfyugHMa0nLO4WE7oYJ3UbluBUU6ugyvEIgrQUqY/I6BU4tn025DfW
 N9QzHY+S7Plh5rSUMzNtZ6RBpZYBJzTeSIqjDVKy+EoS8jmB5/nFsT5SWXtuA4fBC7l3Aw1Eardt
 DdI4MpNhV3lRbcucRlpg9wtA9dnqz52/dj1LLSdb9noEj6jBe+RtEa2SOIFpU8hpx77WHkUsX5qI
 Vc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nfl6KFGRvEA=:F/5Flh65VOiCs5gOrs6dQy
 EH/LIyOl2NqGYk9gH7mK/G32o4WCzqEXPzcpud/HY3ILAvYyeae+BKc9CeVd9ZVEg6U5reStM
 zWpE7iuUmoue5Hy/CyOtRQT9mbwDP/yyvA9cS2q2ipkvKeEjDdz5BRmz3bXiYRE50FSkRinbo
 sJSOMr+ISJsPHOSNcm8lFogda5rSUkXPDqND9bHoobVJONd0QZyKtp2eKvWVIdJdYuWlXS8zp
 GJFAMmuA5Uq9kyR4hw+eJGiIMSHvy5GjnBT7cgF/KHBbxEQHpsewXeNbIKag0Y7poDMU5GlCp
 fje0m7ZtnOwrajTouCbDFir1a1W8R+mDBBUJiXuwtyuWNeOjGwG2Dfdno1aZj2KdgrnVjgSdZ
 Md7qBTNVgNyM2KSgbmjuLqyl6180ivBUrFLYeczeNLdY41BOw9RK2K2fBVAow0WWQRp6ynt1v
 zZLret2aY8Y+ALoCzjfp0AxxFrsEHL0ynvilKs305FUVg3T53Pto2qxAel4lXOq26F5h3T7VC
 I8d7S8YjtWZstUwxxTSEAXMUI6Wwz9aXSFetNlH5sy7UQE9wsbka9E/so4bZbgraH/Zqus27u
 I8pYIFR40LMIeCvmG8UEQjRNdObBz9q167wP3KhA80+58W1Wf/jHgu4YpGjR+JlKWyP2IOmyJ
 L4CuESmPeuqImO0+ePEMkUxikI+rWZJFJf0ImJCVOWgIFMLcfV/KmTEt7XMM8s9DVERDlNsZY
 1n+j2JZkcCLnXCiKYPIgI+M6f9NqjTWE/Jr9dW1dAzf+SWJ6yQtoox7bn3i3VWFiUp6Vi6Wy5
 jttfB72
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin

thanks for your review

> Gesendet: Donnerstag, 16. Dezember 2021 um 14:17 Uhr
> Von: "Robin Murphy" <robin.murphy@arm.com>

> > +	dev_err(&rk808_i2c_client->dev, "poweroff device!\n");
>
> This is not an error.

ack, we can change to dev_dbg/dev_info or drop completely

> > @@ -552,6 +554,7 @@ static void rk808_pm_power_off(void)
> >   		bit =3D DEV_OFF;
> >   		break;
> >   	default:
> > +		dev_err(&rk808_i2c_client->dev, "poweroff device not supported!\n")=
;
>
> If we really don't support power off for the present PMIC then we should
> avoid registering the power off handler in the first place. These
> default cases should mostly just serve to keep static checkers happy.

currently we had added all device-ids supported by probe. Before my Patch =
(Part2) rk809 was missing.
It is not registered for (currently) unsupported IDs as probe exits with -=
EINVAL for unsupported IDs before.

If anyone adds init-code in future but not poweroff/restart part we ran in=
to this. So i would leave this message.

registering handler depending on supported devices (for poweroff/restart f=
unction) imho makes code less readable.

> > @@ -559,6 +562,44 @@ static void rk808_pm_power_off(void)
> >   		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
> >   }
> >
> > +static int rk808_restart_notify(struct notifier_block *this, unsigned=
 long mode, void *cmd)
> > +{
> > +	int ret;
> > +	unsigned int reg, bit;
> > +	struct rk808 *rk808 =3D i2c_get_clientdata(rk808_i2c_client);
> > +
> > +	switch (rk808->variant) {
> > +	case RK805_ID:
> > +		reg =3D RK805_DEV_CTRL_REG;
> > +		bit =3D DEV_OFF_RST;
> > +		break;
> > +	case RK808_ID:
> > +		reg =3D RK808_DEVCTRL_REG,
> > +		bit =3D DEV_OFF;
>
> Is that right? The RK808 datasheet does say that this bit resets itself
> once the OFF state is reached, but there doesn't seem to be any obvious
> guarantee of a power-on condition being present to automatically
> transition back to ACTIVE.

i think you're right...imho it should be DEV_OFF_RST in restart_notify and=
 DEV_OFF in poweroff

> > @@ -727,6 +768,13 @@ static int rk808_probe(struct i2c_client *client,
> >   	if (of_property_read_bool(np, "rockchip,system-power-controller")) =
{
> >   		rk808_i2c_client =3D client;
> >   		pm_power_off =3D rk808_pm_power_off;
> > +		rk808->nb =3D &rk808_restart_handler;
>
> The handler just relies on the global rk808_i2c_client anyway, so does
> this serve any purpose?

i guess

ret =3D register_restart_handler(&rk808_restart_handler);

is better here too.

i cannot figure out why storing the function-pointer in rk808->nb too as t=
his seems not to be used anywhere else

> > +
> > +		dev_warn(&client->dev, "register restart handler\n");
>
> Don't scream a warning about normal and expected operation.

ack

> Thanks,
> Robin.

@Peter, what do you think?

regards Frank
