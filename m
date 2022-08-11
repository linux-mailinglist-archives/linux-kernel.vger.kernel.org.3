Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6C58FB09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiHKLA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiHKLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:00:26 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB725C5D;
        Thu, 11 Aug 2022 04:00:22 -0700 (PDT)
Received: from [10.1.22.96] (unknown [10.1.22.96])
        by uho.ysoft.cz (Postfix) with ESMTP id 04335A0536;
        Thu, 11 Aug 2022 13:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1660215620;
        bh=VKrMgfvRFgRq3NRX02KHVaAotdQVRUjqfk24MssBOr0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JXW+vlIQyA26nFiEn20Br9LOw+zCb7Sln6x1bJh0qhMeL5unjMxkEv5lP/3byyc4U
         mGalqVnwMmCJ82cWBT6SPp913HSDeCNBTBLTmBquCwgNUK3MCxc4ImUzWU/rC6Hl7W
         elQfbHGiizm5ajuNvxl4WEHXhZhvbqIQ4fwOJm1c=
Message-ID: <4d2de843-4895-9276-aef5-6d9ea60c689b@ysoft.com>
Date:   Thu, 11 Aug 2022 13:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Bind the backlight controller to
 the LCD panel
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 07. 22 18:25, Michal Vokáč wrote:
> Add connection between the backlight controller and LCD panel.
> With that the backlight is automatically switched on when the panel
> is on or switched off when the panel is blanked.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>   arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> index 5054e4ab82e2..0afd6647484a 100644
> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -55,6 +55,7 @@
>   	panel: panel {
>   		compatible = "dataimage,scf0700c48ggu18";
>   		power-supply = <&sw2_reg>;
> +		backlight = <&backlight>;
>   		status = "disabled";
>   
>   		port {

Just a gentle ping..

Regards,
Michal
