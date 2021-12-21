Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0AD47BC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhLUI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:56:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35742 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhLUI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:56:30 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D6FAF881;
        Tue, 21 Dec 2021 09:56:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640076988;
        bh=7WYGf1S8BDG27njLvLts6tNjK2pQWxXOMg8FYbWA77s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Acyp+CI18nFqILYPItoK/lAmDwtjqT1pah47YFI1lKwa3p05wRPVpAXR7jbOaq2oi
         LVKDL5xYm/G1t9ZEeBo9jIZFYMM6tRNLalY8stB0IjVfbs6JhyTkiHimrYT6ljQD93
         kuT2fJR0YIHGh1OIC+HBPcyOyXv+D5rjmY83obqw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211221050420.238376-1-zhuohao@chromium.org>
References: <20211221050420.238376-1-zhuohao@chromium.org>
Subject: Re: [PATCH] media: platform: Add brask to the match table
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhuohao Lee <zhuohao@chromium.org>
To:     Zhuohao Lee <zhuohao@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, hverkuil-cisco@xs4all.nl,
        levinale@chromium.org, mchehab@kernel.org
Date:   Tue, 21 Dec 2021 08:56:26 +0000
Message-ID: <164007698660.2512616.16070074975919900443@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhuohao Lee (2021-12-21 05:04:20)
> The Google Brask device uses the same approach as the Google Fix

Perhaps this should be /Google Fix/Google Fizz/ ?
But it otherwise looks sane.
--
Kieran


> which enables the HDMI CEC via the cros-ec-cec driver.
>=20
> Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/m=
edia/cec/platform/cros-ec/cros-ec-cec.c
> index 2d95e16cd248..8c8d8fc5e63e 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -215,6 +215,8 @@ struct cec_dmi_match {
>  static const struct cec_dmi_match cec_dmi_match_table[] =3D {
>         /* Google Fizz */
>         { "Google", "Fizz", "0000:00:02.0", "Port B" },
> +       /* Google Brask */
> +       { "Google", "Brask", "0000:00:02.0", "Port B" },
>  };
> =20
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> --=20
> 2.34.1.307.g9b7440fafd-goog
>
