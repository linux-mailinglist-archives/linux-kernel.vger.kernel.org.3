Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAF46B20F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhLGFGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:06:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40635 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhLGFGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:06:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A5B1B320187F;
        Tue,  7 Dec 2021 00:03:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Dec 2021 00:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=r
        iQDwEQEQp6qZ+FwL0DoiK+dCU7g8tTjz+eEcDuq7f0=; b=l9haoFOohDK2qY6xQ
        KyAYunLS2ffAqq7GSzxZ+DgFw5uC6WVZWdIYUmRag4iklhO4qUywFKBbDBXQLqRF
        CjiIomGm9Cc/OdQA8d9u36Zf1BDoJb3z2csqzLX1sj8j8ACBQovzONZuvAb0UUAT
        cuRhVMeE7my4N59z1uLm1MZ/7gz9l3Nq9Fos1IyBpGMSmATav2J9zHjxhr0lNNlb
        9R1M8wue8DJbKwoqNBIkyM4Wbk1VQZTMmJBMUkc9GFMbvR3ekqLdfGcBIVB810zj
        51oPD6va7KQks6KXpaXVh8bs/748QEEsgdllt/b7Qwaq0GlxAjCyR7h5P7KYuX19
        P8qFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=riQDwEQEQp6qZ+FwL0DoiK+dCU7g8tTjz+eEcDuq7
        f0=; b=Nw986qF4m0zPLKjy4ifnEsiahXIqE12vy5aRAZ/CVPq9XXOvE+OgelLs1
        qosEsY2JUqZO6WaOgH5DaECTTudPXRx4EcMsgCT0r/z2GYXeWMDvjk3rAWmFEv7p
        6ck/21FF/9AjJw9oka37z/QSVhUXJWpMNMEhijJPL/qo8/E4Y1cFM1enXDpSc6oO
        wx+mziRGP7DHBDuGtR2Ps/ouSTXkYc7FHdVwBw3Z/tKGFnsEBrwiDmfHkXwxrGHU
        rYUXYmoyisSZF/JDSNtcp60fliAylvA/FIzx854K1dErzPfous3nP+1iBc0Qu6AB
        SDJ4o1VABlSgh17Sqv7onC6ntJ7ow==
X-ME-Sender: <xms:GuuuYaWMMiXBs5ac_7_fEdhQ1RTfDsY6hGAVYqbhMyg9CWIgEGZ9qA>
    <xme:GuuuYWk89Eb3HmgWgHg2wjyNbU9JZkDPFwcx674XTM4aP3Q9ma9fiVFzKKtwynS3p
    b1DaEf-JDMvPd83IRI>
X-ME-Received: <xmr:GuuuYeZmcFp3ZMlSBKz7ECEFtdg-o8k5sPkT-V-PhOwlH3rpmhWntWmatRE1CJVBjrIwRoHtqy5gpdJJwlAIEhkV5pYOxmYW4BqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeeggdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnhephfegveefhfekgfdukeffgeefkeevueelueeiuedtgfej
    ieeigeekjedugffgtdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:GuuuYRXgORMhEhQN1z9ERESg3Sv_j0x8QaIris7np6kx1y6m6BYATA>
    <xmx:GuuuYUkLlzTA3lYaO5bmQ8AD8GwwIER_SlB-H0VcId8R1GPlia_pLA>
    <xmx:GuuuYWcApk5muyhy8d-oyosH-AKmfbWDgj8eNpzevgJqwLpacEQF6Q>
    <xmx:G-uuYe7UPu8h4xn_CBWNsQQA5Sql5MrL9-R7Kkww8A2uuVlB8JyStA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 00:03:19 -0500 (EST)
Date:   Tue, 7 Dec 2021 15:03:14 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        roderick.colenbrander@sony.com, dmitry.torokhov@gmail.com,
        pali@kernel.org, rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: set INPUT_PROP_BUTTONPAD using
 input_set_property()
Message-ID: <Ya7rErNDpHnL/ZIO@quokka>
References: <20211202110807.6783-1-jose.exposito89@gmail.com>
 <20211202110807.6783-3-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202110807.6783-3-jose.exposito89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 12:08:07PM +0100, José Expósito wrote:
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/hid/hid-alps.c                   | 2 +-
>  drivers/hid/hid-asus.c                   | 3 +--
>  drivers/hid/hid-elan.c                   | 3 +--
>  drivers/hid/hid-logitech-hidpp.c         | 2 +-
>  drivers/hid/hid-magicmouse.c             | 8 ++------
>  drivers/hid/hid-multitouch.c             | 2 +-
>  drivers/hid/hid-playstation.c            | 3 +--
>  drivers/hid/hid-sony.c                   | 4 +---
>  drivers/input/keyboard/applespi.c        | 2 +-
>  drivers/input/mouse/alps.c               | 3 +--
>  drivers/input/mouse/bcm5974.c            | 2 +-
>  drivers/input/mouse/cyapa.c              | 2 +-
>  drivers/input/mouse/elan_i2c_core.c      | 2 +-
>  drivers/input/mouse/elantech.c           | 6 ++----
>  drivers/input/mouse/focaltech.c          | 4 +---
>  drivers/input/mouse/synaptics.c          | 2 +-
>  drivers/input/rmi4/rmi_f30.c             | 2 +-
>  drivers/input/rmi4/rmi_f3a.c             | 2 +-
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  19 files changed, 21 insertions(+), 35 deletions(-)

series: Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter
