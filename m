Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278D46B5B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhLGI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51004 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLGI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B78P1tK076170;
        Tue, 7 Dec 2021 02:25:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638865501;
        bh=vEwLde5Ty5GlaT3m0kO/+RaTK3RUO6ga6pC2HlXk8TM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mMdUUYuEczdkpmCLwXuUwA160SBTtvy2z25+aTI5x4PkzHWFmrimk89FXX+5XNtMC
         I7qOV4SKUjsEYVJgdVgTTdzLCgafV6uKH8Gtju7MYY3h9HrgDFllws2jCKiGZdEMVK
         T8GxYz0WbDp29XHs7rH7rK8RBNvNtTCWXoHtjBHg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B78P1ul071123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 02:25:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 02:25:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 02:25:01 -0600
Received: from [10.250.232.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B78Owhh075455;
        Tue, 7 Dec 2021 02:24:59 -0600
Subject: Re: [PATCH v2] soc: ti: k3-socinfo: Add entry for J721S2 SoC family
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211203120913.14737-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <11c818a1-3a35-89f1-476b-14490bc21dd9@ti.com>
Date:   Tue, 7 Dec 2021 13:54:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211203120913.14737-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/21 5:39 pm, Aswath Govindraju wrote:
> J721S2 SoC's JTAG PARTNO is 0xBB75.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> 
> Changes since v1:
> - Added ',' in the last entry too
> - Fixed the commit desciption
> 
>  drivers/soc/ti/k3-socinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index fd91129de6e5..b6b2150aca4e 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -40,7 +40,8 @@ static const struct k3_soc_id {
>  	{ 0xBB5A, "AM65X" },
>  	{ 0xBB64, "J721E" },
>  	{ 0xBB6D, "J7200" },
> -	{ 0xBB38, "AM64X" }
> +	{ 0xBB38, "AM64X" },
> +	{ 0xBB75, "J721S2"},
>  };
>  
>  static int
> 
