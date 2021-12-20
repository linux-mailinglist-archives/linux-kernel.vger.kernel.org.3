Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C491A47B124
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhLTQeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:34:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:39039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhLTQeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640018027;
        bh=ZoGhci92Pzfv4A5imxxMOsvZDJ9MRBfoQGXiuCYauk0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ep0yjZgh6StG1uDzh72pPHSbdH7DwrCB0ibg6AwAqoMsaFcGlV5/ko0HmfhzQxRMI
         HEq5N9fjJX7C5FGmtQERKgTPGl3nNrE8CFb9e45BEQOF/ZhYUzS/WGGmu4cuOW6UqE
         79/gULrTdnmuCaSYoLQFQoCSvBEyGuSr6p2dgRwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.120] ([217.61.144.120]) by web-mail.gmx.net
 (3c-app-gmx-bap45.server.lan [172.19.172.115]) (via HTTP); Mon, 20 Dec 2021
 17:33:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Aw: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 20 Dec 2021 17:33:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20211220144654.926112-1-pgwipeout@gmail.com>
References: <20211220144654.926112-1-pgwipeout@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:aN63Vhyi8qOQ1mrG500MQtjFKWLfORtmIw/m+CLwvNZ6YHqbPNyix4LT8W/d3cYs42HZD
 4YNIGfk43PtdXGS2zZvHeu9BI56Wi5P99XNI+RMrtVWHimHxpyUUDUbkiAIHBahuLjn1q647mpDS
 2V5fWc7j5DxdxEm8nDlvp8nl8b0SVsyV6Yzo3GXd8/pf5O0uAL+hLgu+7CVgb5us+EGlntSrCnlG
 raantmj4zKiTZTiGQlAXuz5gmLG/R6/HmlGuZKjlXaNosFdzB/dbs0XUUtsSUCyIfDHwM6rgzQSw
 /g=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fctntlAvfjQ=:kGkdc0OKd5+rGRtLmFteLt
 o8/vObSJzeeVQIuhF5wDr7EQw61A6gMkmrJQ3teT8KdwZVpEAbc0+cYiDdeLCKsECs1QGRoyi
 8ehf8i4yoz3iqVCiPqMcItcZYVfcxGc9WcsJZXzqTJbH+dYcY/4uTV0CjAXY4rUJ2yLJuEVZE
 7UXBtJreMMefBeslNoVO0GEVv+IE53OPVXECbqQNLdCEO0phYWtge+mKIKE+a9uJHQ8K2Z2vU
 TR2RIn1CpO+Feem/9osZVce7BLyilHtZCwCyeq8wToPDyXLWRdVDLa68pbr7ZXP5+dcD2qqpl
 zAUIJ+jOPy4CvMpZBe2kfVxi8eKjlsrCxA25EQ8hIlH6hjV3O4WRr1wH5kxXOgI5uQEn6vs3B
 4lgjf+UXYuuvmPH5iF6RAoS5AeqzwwvUgmUWXbSihAmYlTEd+KuTeWtK6hnDj6Fg05HE88XIC
 OoUT+TfKTJt36zm1tdyskk/QqaZ7vq/UtiKZSCtvJRaEPiIMr9+mtOmWENe2AxBWsPDUTk5Xd
 WeiC9qhpQN4+Z+BzM1x+9Ox6/odHO4oAU+MN/dwacmQ/mvmz4e/SqHuyNKAh9AsL0NH47fybK
 MynDS3bM1yjjPTptfFMP7KRtOT6Ar1kzv3N3e/LKT5jmQsFNNZWL1lsu/iinSuCe0KZwtbojv
 XTnX2gtbVsMDidbnEmR9mjfdK6GYf4XHeVbiwi3QbkeoYeMYZHZ0VuGl6SITl9EfmBtX/OCVO
 Ovnm3ILG8SjRzDmjyppS16M9Txj7SPaHd2WoLxZ8NrdeLFB+sy8rht24+tUcw9/MkwvscjWPY
 CytY7nO
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 20. Dezember 2021 um 15:46 Uhr
> Von: "Peter Geis" <pgwipeout@gmail.com>
> @@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client *client)
>  	if (pm_power_off =3D=3D rk808_pm_power_off)
>  		pm_power_off =3D NULL;
>
> +	if (of_property_read_bool(np, "rockchip,system-power-controller"))
> +		unregister_restart_handler(&rk808_restart_handler);
> +
>  	return 0;
>  }

this change misses a declaration

struct device_node *np =3D client->dev.of_node;

regards Frank
