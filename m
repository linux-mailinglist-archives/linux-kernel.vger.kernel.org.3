Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FC467696
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbhLCLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:38:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhLCLim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:38:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BZFt2001632;
        Fri, 3 Dec 2021 05:35:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638531315;
        bh=iW3RyW/cm/sUg1ANaPVf9fkZFSDiEUqpMhaMEtCqznA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FS56ZsnTTwk3siHEQxK5EiAYc6aY+Cg0nBmPIT4x44o+LgHhYLlXf/69vNMb2MKZ4
         dx7ZBVwQo5DTg+RH7AI9qIPRKxpexplcrGs+ZiMFgzd0icAopbexRpfJusipSVVOt0
         RjiTdvoulwVBFzNMgoWocIn5+aY8Vl6hBDY6uGZw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3BZFB8052817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 05:35:15 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 05:35:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 05:35:15 -0600
Received: from [10.250.234.139] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BZCEu124513;
        Fri, 3 Dec 2021 05:35:13 -0600
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J721S2 SoC family
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211119131510.14350-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c15ef772-514f-4433-77da-79e498e22100@ti.com>
Date:   Fri, 3 Dec 2021 17:05:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211119131510.14350-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 19/11/21 6:45 pm, Aswath Govindraju wrote:
> It's JTAG PARTNO is 0xBB75.

%s/It's/J721S2 SoC/
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/soc/ti/k3-socinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index fd91129de6e5..83e5a40824f1 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -40,7 +40,8 @@ static const struct k3_soc_id {
>  	{ 0xBB5A, "AM65X" },
>  	{ 0xBB64, "J721E" },
>  	{ 0xBB6D, "J7200" },
> -	{ 0xBB38, "AM64X" }
> +	{ 0xBB38, "AM64X" },
> +	{ 0xBB75, "J721S2"}

Prefer to add ',' in the end so the change is confined to one line for every new
SoC family.

Thanks,
Kishon
