Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881A56B8D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiGHLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiGHLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:47:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC2951E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657280834;
        bh=EWEAPU38vj7LmQ0GV5eR0yBw5Q9Puye2G39BDYq0u9U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i08e/rcxzGvUZZ6G9QLLYOldTQAicMr5nKV+Jya7oEM29J+uy5Q6o5EJcefDdpCZp
         xdi6J6MpXUGzoRZ8zjfu66CheQjXhBeFlXe13MGZz5Xa0vSbYrgLoAL+tcjAIZkYzw
         VKn4C9OaaRAaMlmX7ilOm6kVXI0xOFQZ0D8ihV4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.69] ([157.180.225.69]) by web-mail.gmx.net
 (3c-app-gmx-bs34.server.lan [172.19.170.86]) (via HTTP); Fri, 8 Jul 2022
 13:47:14 +0200
MIME-Version: 1.0
Message-ID: <trinity-e64eb9b8-7b25-4893-a1a2-ecbf9da3ef71-1657280834206@3c-app-gmx-bs34>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Aw: [PATCH] phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 8 Jul 2022 13:47:14 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220708061434.38115-1-samuel@sholland.org>
References: <20220708061434.38115-1-samuel@sholland.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:GfoyUgrdNBpE5DDJbWK8te0BuGsOwpkIMZlmgMLq1ItIB/f3fCmj/9ymcLMVp17XUT2zY
 3xp9r+UOjlAqGwFSDjqez3Ln2yovoTGQGt22vq8xptS1y220lsviKcnC5y3XihFCTJvaqPSWydpT
 QlSQW2TRIZRyM/vB9LZ5Xr2rjIbYLlexTW8UsnotLz3QUPu6HzZGLZtgNPTHuhvrsiYkai6FHyZC
 SkWma4f0xPHm3Y/9yGxeETmZ3QWbEZrDg0V1WCAv7o89412MTt2PfkAno2j+6BBSizptC/DqVu+F
 Fo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:wytnxtIYGok=:dTYOmJoT3eHdOG7IhPcXGp
 OGG8ryZh66JdV6Kq/GVwA8zElZc+LivbVYefnktcRVFAV/5PacCunOPDFSVGh/JcbSrFq5mO2
 B34W9Mkpio1MGUgNaCmWdlxC6Gg5V1I7dijebd5UbtMDRddWD6Mgt9OP981YMO/A5tBNAgcYq
 xsZxL7Zyqv1xwrQ+KTlyxKY+KlJsLvnKxlf5vQ4kYLg5SVImesW9Nz8AXiH0cw0fTIMZmRrXX
 9JV6HJXqmiZViJcpUNceMvSel/WGRQ75Knt6G1L45YhSb2C4C9qHfKfJ+vl+Xp0feQM0tqnQx
 tx4IRW3jrTqByEK0zl4rfDtMXBZ8HxDuxZXrPjqE7W7SMwFixbeM7TXWtfCe1N9C0cOJywGRR
 zVOSBAlMuZcRplnszMihWYtjlfesdzhB3xJtq3Wz87tfWUNdiW20Fy1eQCDrlXsHIdjfjnfYz
 be1mE3jHyh2LGPSVe5r4hU1x3RMKeQYu2ypkNwzO8YH86Z3+hPTiKeHGdpwe6HiXO8ZAdp8nM
 hzBafo32SQglxXd65Otp9vZT90+0dSpvESQdV66xftA2woSAFqbiZqTogIVSF85fqdr3wR9Wv
 EP9husCEOd2RJvTHaJxVAnaVB65mLBn0Xtsd3i7clKmxKN0yWuffwy+YTDIDFB2FsoWrvdQGz
 aIwQRVCtsspGPgs0zTDJM+6fyljHzHqI6tZ4foTlX7xk8MNLm3phwIXzVZljwZOZjVzbvwlb8
 fKCiPz/aKZCsEFFbTU0wOkCOBWJA2ybdzGuEm2/mVKA2o1XC0m7umnxZAnj/9mul/0gfujTJT
 xszZGf7
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel

thx for the fix...with this it works again

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank


> Gesendet: Freitag, 08. Juli 2022 um 08:14 Uhr
> Von: "Samuel Holland" <samuel@sholland.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>, "Vinod Koul" <vkoul@ke=
rnel.org>
> Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Peter Geis" <pgw=
ipeout@gmail.com>, "Samuel Holland" <samuel@sholland.org>, "Heiko Stuebner=
" <heiko@sntech.de>, "Kishon Vijay Abraham I" <kishon@ti.com>, linux-arm-k=
ernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.i=
nfradead.org, linux-rockchip@lists.infradead.org
> Betreff: [PATCH] phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode
>
> When the OTG port is fixed to host mode, the driver does not request its
> IRQs, nor does it enable those IRQs in hardware. Similarly, the driver
> should ignore the OTG port IRQs when handling the shared interrupt.
>
> Otherwise, it would update the extcon based on an ID pin which may be in
> an undefined state, or try to queue a uninitialized work item.
>
> Fixes: 6a98df08ccd5 ("phy: rockchip-inno-usb2: Fix muxed interrupt suppo=
rt")
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy=
/rockchip/phy-rockchip-inno-usb2.c
> index 6711659f727c..26b841c49ec6 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -978,7 +978,9 @@ static irqreturn_t rockchip_usb2phy_irq(int irq, voi=
d *data)
>
>  		switch (rport->port_id) {
>  		case USB2PHY_PORT_OTG:
> -			ret |=3D rockchip_usb2phy_otg_mux_irq(irq, rport);
> +			if (rport->mode !=3D USB_DR_MODE_HOST &&
> +			    rport->mode !=3D USB_DR_MODE_UNKNOWN)
> +				ret |=3D rockchip_usb2phy_otg_mux_irq(irq, rport);
>  			break;
>  		case USB2PHY_PORT_HOST:
>  			ret |=3D rockchip_usb2phy_linestate_irq(irq, rport);
> --
> 2.35.1
>
>
