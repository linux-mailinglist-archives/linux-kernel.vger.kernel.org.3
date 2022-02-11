Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5544B1F33
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347659AbiBKHRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:17:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiBKHRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:17:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50693CF;
        Thu, 10 Feb 2022 23:17:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id co28so15076661edb.1;
        Thu, 10 Feb 2022 23:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbSRnB08vEBChddEtK7z1Dl6p66oSOEgpqno3jwGhwY=;
        b=djfQ5CMZFldGLXvBjCoHdSTzUxCE9v5E/Vuqraz2hH4g9hjme8zlerNhJeE1izks/Y
         08B8lhgMkKrat5H9lU7TDd36hCGXPz/JN1WekrSXzSdXDYqkdahMUiiVBdB/bYkP1TfQ
         KUMBfoafBnu53C9f0u42fqknl4ALzQ5ut3DH+m+xkGjXSLNh7sgTUQA11PjiqJkdrB+n
         iwPhIq1bf5eDLulC3sYTO1q9tdDRva1Ze6h9Tn/S5d+tQ9fv5yESQr82+x5KRfaSTPtl
         5QzVovhAanZkozk6qA1wmX7/s75Dui1VUp2F6gNWxlMk2it1xeEvzCBDmqh3srXCJ1aW
         pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbSRnB08vEBChddEtK7z1Dl6p66oSOEgpqno3jwGhwY=;
        b=ZIcJeyU1HcJPEY8aAmsk6ehieRPkXGxZySjcpKoyvLLXMRPgwKyAUJu1cjTLIV55iS
         eoT28sAbfdHlDS/odP8vlV4k5NdpGw2QW5vAOeyxl4nzn8k+1R/6YYL3Vz0/eL8y7/gu
         lWFiysOB9WNNrzI/gaRy6xfv7GOcB5ckpe6YfIcK6kd1uZNx8Xx3p6ic7Ts05MFotVQy
         YuXkLeC8q+/hdDAyLRAhCUSt2xtmVS7YZyGoDawBfITzwkIbAanm03dFV1SQJbbLvBSL
         dLaA/HvirjDffHGjdUKkvb4OXu+1lmh7HtXnViA4pZVUqGBaMKGVI6oDiKwJl22Vz9H3
         RVJQ==
X-Gm-Message-State: AOAM530qRfHKmBauQTbwwmfTuvWwP1JTdl2xgeVadhZmN59iJH5p+/Jx
        cvFTFBvuLaBDhsV0O9S/NeJIg4fi1gmCvMIpBCLGP5Z6s+Y=
X-Google-Smtp-Source: ABdhPJxX2xrGPANbJIpPVUoePrASb6M572vGeqcr/2kkBu7/Dr/oBT8P5bqbCMqV+nxfEqCMqd6lZGzy0XPjnPmOtQM=
X-Received: by 2002:a05:6402:5299:: with SMTP id en25mr459589edb.265.1644563858742;
 Thu, 10 Feb 2022 23:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20220211071403.56146-1-christian.gmeiner@gmail.com>
In-Reply-To: <20220211071403.56146-1-christian.gmeiner@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 11 Feb 2022 08:17:27 +0100
Message-ID: <CAH9NwWeXEArfZzaTWCd32NPXu5CBzQJY2vpo9pRSCSF924v4fA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add ESM0 bus mapping
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Looks like TI was faster:
https://lore.kernel.org/lkml/20220210172246.27871-1-hnagalla@ti.com/T/

So lets ignore my patch - sorry for the noise.

Am Fr., 11. Feb. 2022 um 08:14 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> As the kernel repository is the source for dtsi files for other
> projects like U-Boot it makes sense to add the ESM0 bus mapping,
> even no Linux driver needs it (yet).
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index 84bd07cd1824..09ff14643ee6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -66,6 +66,7 @@ cbass_main: bus@f4000 {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges = <0x00 0x000f4000 0x00 0x000f4000 0x00 0x000002d0>, /* PINCTRL */
> +                        <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
>                          <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
>                          <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
>                          <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
