Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07B48D80E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiAMMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiAMMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:35:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47474C06173F;
        Thu, 13 Jan 2022 04:35:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t24so22438622edi.8;
        Thu, 13 Jan 2022 04:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LftLg0r0Faw+W6UND9T0SXsUaqtJ0ZRucKUPsxlKlXc=;
        b=hYIWlIYnpsLWMFOV8ltzNbs8XDcKpvGbzs+nnSbI/PBIgULVwJ7cEpXfqH+d4nHJh1
         rEGAf0ZTTkAwky3PhZfJXabZaUcy9Khsn/GsO5ift9lfdrcPPKXOA/TaI+qJKpWNgTjk
         7H19U57b2TiDXmtRVczH+sYbHveb2BJvXk+OnE69uzL8um5TBqqlKT+Z0Jf2Wj7Vmgt+
         FwUjaB8v3YVh7zbdqFrC/dSM2qXDz9Tt7MAVKXDcDWza0ttWs+OSWrsHqMOLk4IvCNhv
         AJhKj+ARGsf+K9wcw11aJzcQ/FVIzdhDvKD1N0WvjOg4NBF+tGTf8iJbQZef2/J6pPIo
         HZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LftLg0r0Faw+W6UND9T0SXsUaqtJ0ZRucKUPsxlKlXc=;
        b=We8gh/sQhhnaHWIBT+VM9mJ5tas56p/PIVZUWjGs778XTXLAx+GzLZCQ5MmauJoy5u
         iLhONUcOLsIEb81SlidnoPEie+o5h2PEsfWHhmVdfyOpTwTVr9rMDSOBYr3n+x2xyQ24
         HGFrTtRy71QaRigQf0PClO9y4PEPFU5KUWGLX4pU8MjPNmkqfXJCZq1dFheFKjoQ8fa0
         kKGyI78Up6GSC84Z7f6Si6jYsOB8v0wmkH555O4S9F2VTpWBHdAHEs/qqXf1iHPQ4kMQ
         /ex+ZWCGn3+X/Qo8J2zvOJiu7vk3iVn7GJRAjpOpuCBTQNES+GyewQDIZ9UrmSuY1aZa
         TCYQ==
X-Gm-Message-State: AOAM533jeVBDPg1j1Xg60fBVt7Q+OiBTl72aWnbLvmqyIW5d6xuNky5Q
        24EY8kx0vwRxNT8KLV3+7tQ=
X-Google-Smtp-Source: ABdhPJyqdzUl4Aa3NbTKIeeuDRq1eL9MwIEfCFaL0CYvjb77VO6b8ZIIh7qD5UrrkpxX6b75E6U1RA==
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr3386976ejw.529.1642077332873;
        Thu, 13 Jan 2022 04:35:32 -0800 (PST)
Received: from skbuf ([188.25.255.2])
        by smtp.gmail.com with ESMTPSA id lb11sm829889ejc.216.2022.01.13.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 04:35:32 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
X-Google-Original-From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Thu, 13 Jan 2022 14:35:30 +0200
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     fido_max@inbox.ru, Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
Message-ID: <20220113123530.dn33ze7yvg2jlnfv@skbuf>
References: <20211230151123.1258321-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230151123.1258321-1-bigunclemax@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:11:21PM +0300, Maxim Kiselev wrote:
> T1040RDB has two RTL8211E-VB phys which requires setting
> of internal delays for correct work.
> 
> Changing the phy-connection-type property to `rgmii-id`
> will fix this issue.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  arch/powerpc/boot/dts/fsl/t104xrdb.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
> index 099a598c74c00..bfe1ed5be3374 100644
> --- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
> @@ -139,12 +139,12 @@ pca9546@77 {
>  		fman@400000 {
>  			ethernet@e6000 {
>  				phy-handle = <&phy_rgmii_0>;
> -				phy-connection-type = "rgmii";
> +				phy-connection-type = "rgmii-id";
>  			};
>  
>  			ethernet@e8000 {
>  				phy-handle = <&phy_rgmii_1>;
> -				phy-connection-type = "rgmii";
> +				phy-connection-type = "rgmii-id";
>  			};
>  
>  			mdio0: mdio@fc000 {
> -- 
> 2.32.0
> 

