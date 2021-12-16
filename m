Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825D84767B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhLPCHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:07:11 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56708 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhLPCHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:07:10 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211216020708epoutp014039a23d0bc47d2bf7c1bb777b05d3d1~BGhfJ4O-X3190031900epoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:07:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211216020708epoutp014039a23d0bc47d2bf7c1bb777b05d3d1~BGhfJ4O-X3190031900epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639620428;
        bh=mI74+lYrCIoVgqdKUWVKTn7G5egS/5n/Se/dnL91UTw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D5qIHzPKVmNxDZMDvQeDbgh8Sm64gktHecOZ5oVA0aPjqvaGNj4WpK1Xy7ZxTlFDT
         dqNKgtvRFs+ijh0Y4cTybcs2rI8Z1+VZf0V0UEg2MAF+eGTWFYuwaqy7Z8rPI+XPiw
         AJrJgM1eVwxd8pankUCJ+Z+2oPhji8EPfoDkmeS4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211216020708epcas1p161eab40748a79555c4b1ebd10a0f1372~BGhe2qLWS1738817388epcas1p1b;
        Thu, 16 Dec 2021 02:07:08 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JDwTz176sz4x9Pr; Thu, 16 Dec
        2021 02:07:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.3B.64085.F3F9AB16; Thu, 16 Dec 2021 11:06:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211216020653epcas1p4710b50224fca7fec1947e7847edaa91f~BGhRWdxG31146211462epcas1p4H;
        Thu, 16 Dec 2021 02:06:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216020653epsmtrp173cf683b51f9552468bca2e5e145f06b~BGhRVoCtW1982819828epsmtrp1k;
        Thu, 16 Dec 2021 02:06:53 +0000 (GMT)
X-AuditID: b6c32a35-9adff7000000fa55-28-61ba9f3fdb94
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.5F.08738.D3F9AB16; Thu, 16 Dec 2021 11:06:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211216020653epsmtip17f4e1355c753882be13279aee8373a37~BGhRI2NW11715217152epsmtip1V;
        Thu, 16 Dec 2021 02:06:53 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: sun8i: addd COMMON_CLK dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <aisheng.dong@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a56dbd34-cd89-63a7-e24c-6f45487aa129@samsung.com>
Date:   Thu, 16 Dec 2021 11:29:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211215140523.481425-1-arnd@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmnq79/F2JBg/apSy+TN3FbPF30jF2
        i21bNrFanG16w25xedccNovPvUcYLW43rmCzeP6ok82Bw+P3r0mMHptWdbJ5bHy3g8mjb8sq
        Ro9XX+cyenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
        5OIToOuWmQN0kJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLRArzgxt7g0L10v
        L7XEytDAwMgUqDAhO2PT8wbGglaeikend7A3MM7n6mLk5JAQMJG4uH8LaxcjF4eQwA5GifWT
        trKBJIQEPjFKzG2pg0h8ZpRo2HaKEaZj0vN7jBCJXUBFq98zQzjvGSU6Hixh72Lk4BAWcJFY
        MYcJJC4isJBRYvqlnWDdzAINQB3ttiA2m4CWxP4XN8DW8QsoSlz98RishlfATmLB2wfMIDaL
        gKrErsMLWEFsUYEwiZPbWqBqBCVOznzCAmJzCphJ9D3dzwQxX1zi1pP5ULa8xPa3c8COkxBY
        ySHx/9xtdogXXCRO/9jODGELS7w6vgUqLiXxsr+NHaJhGaPEr8mdTBDOekaJl7M6oTqMJfYv
        ncwE8iazgKbE+l36EGFFiZ2/50J9ySfx7msPK0iJhACvREebEESJssTlB3eZIGxJicXtnWwT
        GJVmIflnFpIfZiH5YRbCsgWMLKsYxVILinPTU4sNCwzh0Z2cn7uJEZxatUx3ME58+0HvECMT
        B+MhRgkOZiUR3icRuxKFeFMSK6tSi/Lji0pzUosPMZoCQ3gis5Rocj4wueeVxBuaWBqYmBkZ
        m1gYmhkqifO+8J+eKCSQnliSmp2aWpBaBNPHxMEp1cAUdDR5s6ppnYBuWQ2ro1DTCtsV9zIW
        bmTq2BbOqTXPm7VY2y9H44lVvUd1mlsVv3Ox/KugDwu1/85++CbGWyjipWmJoaf5xK+zZe30
        Olk1Lb/ercoM0MsM7fQ42ZU3PfrmJsvtl3SEypjZI4o+ZfEGzzoRZsNu7/x2Z1X4T67Dck9T
        X1qwaSXb/0i+YtX21v2wnPxriRkylUnLL6juUNPq4rDMWJQ1R1jiSsWsOdzBPbtmLzTRkpZ/
        HBmyu/hBaqhWW2XP5T1MMhde963mcTm2sNRVXln+Of+Mfv8T78W8q+aY7nd95tCosf6mG0ty
        yfZT98pj9vhPbhNpSFrZrFrktOC21M8OR0/JWZOVWIozEg21mIuKEwHJy/+nNgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTtd2/q5Eg01P1Sy+TN3FbPF30jF2
        i21bNrFanG16w25xedccNovPvUcYLW43rmCzeP6ok82Bw+P3r0mMHptWdbJ5bHy3g8mjb8sq
        Ro9XX+cyenzeJBfAFsVlk5Kak1mWWqRvl8CVsel5A2NBK0/Fo9M72BsY53N1MXJySAiYSEx6
        fo+xi5GLQ0hgB6PE1eZ5zBAJSYlpF48C2RxAtrDE4cPFEDVvGSUWrf3ADhIXFnCRWDGHCSQu
        IrCQUWLb9n1gg5gFGhglJhw4BjZISKCTUWLHVH4Qm01AS2L/ixtsIDa/gKLE1R+PGUFsXgE7
        iQVvH4DVswioSuw6vIAVxBYVCJPYueQxE0SNoMTJmU9YQGxOATOJvqf7weLMAuoSf+ZdYoaw
        xSVuPZkPFZeX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OL
        S/PS9ZLzczcxgmNMS2sH455VH/QOMTJxMB5ilOBgVhLhfRKxK1GINyWxsiq1KD++qDQntfgQ
        ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpoQWt/IfyiZuM521JHiqPG4suHSx29sx
        LDBV+7xc/3ppUw+VlbcP2XxI6q322ie1qWdb0auuO0+DV5xYWpl2N+Raa6SRUu9cIUFjV16+
        Up0H/6fsYL0l+bE8fmPS24VdwhuuHU6/LtX82TKm+MCuiObwZ9vZNocv/Oy0ykBNrdvuK0eP
        3xO9dr3NB7JUCncrJ2j+FPhusP3w20Nx+5+1lte/iDu5KXPD5TCWJ/fuflC7/7dIRSi64PoZ
        LhY+vpetsmqvIlIbWid1HbjI0z+1r5TtiEtm7hadDn+XOTrPWUPPZb/sc9/HMEuv/Nmyl/4J
        liJyjzsNzCP2nFfd8fKeZ+LDqzFqB6Mv/whb/clCiaU4I9FQi7moOBEA2rCPVyADAAA=
X-CMS-MailID: 20211216020653epcas1p4710b50224fca7fec1947e7847edaa91f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211215140534epcas1p4a39eed46b3bd0e8582837321d1f279e6
References: <CGME20211215140534epcas1p4a39eed46b3bd0e8582837321d1f279e6@epcas1p4.samsung.com>
        <20211215140523.481425-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 11:03 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing the driver without CONFIG_COMMON_CLK causes
> a link failure:
> 
> arm-linux-gnueabi-ld: drivers/devfreq/sun8i-a33-mbus.o: in function `sun8i_a33_mbus_remove':
> sun8i-a33-mbus.c:(.text+0x450): undefined reference to `clk_rate_exclusive_put'
> arm-linux-gnueabi-ld: sun8i-a33-mbus.c:(.text+0x460): undefined reference to `clk_rate_exclusive_put'
> arm-linux-gnueabi-ld: drivers/devfreq/sun8i-a33-mbus.o: in function `sun8i_a33_mbus_probe':
> sun8i-a33-mbus.c:(.text+0x85c): undefined reference to `clk_rate_exclusive_get'
> arm-linux-gnueabi-ld: sun8i-a33-mbus.c:(.text+0x878): undefined reference to `clk_rate_exclusive_get'
> 
> Fixes: 8bfd4858b4bb ("PM / devfreq: Add a driver for the sun8i/sun50i MBUS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index b94eb04761f6..87eb2b837e68 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -135,6 +135,7 @@ config ARM_RK3399_DMC_DEVFREQ
>  config ARM_SUN8I_A33_MBUS_DEVFREQ
>  	tristate "sun8i/sun50i MBUS DEVFREQ Driver"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	help
>  	  This adds the DEVFREQ driver for the MBUS controller in some
> 


Thanks. Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
