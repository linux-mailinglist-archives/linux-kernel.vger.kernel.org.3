Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791EC47E086
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbhLWIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:40:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52906 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhLWIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:40:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BN8eaet001555;
        Thu, 23 Dec 2021 02:40:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640248836;
        bh=FRcSWyBsMFdpNi6q15QKtk8vskpou3CpjToRLckx8mM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GvNITeHM6WXxRtU4ANWumMl0c6CnkF/iTKdrb+Xd+Wwm9e6evdfZLAtty+C3eI1Q1
         JxpFT4PCJDT+c9U3hhpOBZQvdPJe2l9TKlSxRs0D40ddywXkas4Fii23m5vM6XP9Pq
         uHym4ARgrhJ/otAd4UHbV1oavrzI01j8bM/iUZU0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BN8eaEg036672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 02:40:36 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 02:40:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 02:40:35 -0600
Received: from [10.250.235.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BN8eX0J098078;
        Thu, 23 Dec 2021 02:40:34 -0600
Message-ID: <d9481b0b-cce9-9410-5190-f86ac41a3e3b@ti.com>
Date:   Thu, 23 Dec 2021 14:10:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] arm64: defconfig: Increase the maximum number of
 8250/16550 serial ports
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <20211208080737.10761-1-a-govindraju@ti.com>
 <163955131474.14033.3915304006426054820.b4-ty@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <163955131474.14033.3915304006426054820.b4-ty@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 15/12/21 12:41 pm, Vignesh Raghavendra wrote:
> Hi Aswath Govindraju,
>  
> On Wed, 8 Dec 2021 13:37:35 +0530, Aswath Govindraju wrote:
>> On some TI SoCs the number of UART instances used can be greater than 4.
>> For example in TI's J721S2 SoC, 11th instance of UART is used as console.
>> So, increase the maximum number of instances to 16.
>>
>>
>  
> I have applied the following to branch ti-k3-config-next on [1].
> Thank you!
>  
> [1/1] arm64: defconfig: Increase the maximum number of 8250/16550 serial ports
>       commit: 8e799ff45baebab781cf392be51a54b1f3fceb23
>  

I have dropped this patch from the queue, based on comments at:

https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/T/#m4ecb0dc6a78c84631f072faa1b0df0df46333d09
