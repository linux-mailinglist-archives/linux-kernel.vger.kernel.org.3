Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B4472D90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhLMNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:40:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25757 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbhLMNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639402813; x=1670938813;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+A9fEozVZHok3npBonJzIZu/ogaEiI/8H2o3VCeFoNg=;
  b=Q2lBCvpanL+IibzhJ0jgQ2YQy0SmRlSWR9H2fSA91dozI+kLDcgN4CIp
   0j2WKImSPEK7lsE4WLHgjsowHCwBbVNELioSfdtE7lHMfn8K07Q3xPP6M
   M5oU2endFH6ehBDAM4F9iVUEDGIp5v9xeDxgtCq6gfQ+daR/i5L42Z57g
   7uzwT847O1EJa153AAZHtYcdktI6kGDQTLFmzxx0OJCjOx+0TZv9EI8Xh
   cokNPvWcABqcboWCE9zVGeKLFLj7cjKIAvUyIz4/sQQloOmKjOoNH5GHd
   hHvWxjn39UiTn1fkiqWKFA9IuZ17BbeQaA2HIoOR/+ca3qdIqzPcSz4c7
   A==;
IronPort-SDR: 3pLTKlHHa9aGl6CpaQK2IoFrv9t/rE4xoPmOO7VLF9Sj7KsKgOmqyD1iIND4qYB5lHWJXjrN2d
 PSSo3pwCcTUQbHqPywhzYaOBW+n5Sqh9Fb1qqNOXIc1pabKPY/9tLARZKDib8vqpecCU2T0ey0
 la1gynJXlOksfF4F45RYD7tTFBaOxBMyCrX2zEpHowzTdpe6zqiXxZYHwmOiFwaJtacdhfhelW
 /xSKWVGAi9gZ1Q10H4BTXr5wbeCJaFqBxr9t0ph00YKI4EOcYYu7e5BW9S97rMAA5xtMPtwsyk
 0ZVJ6tkVHGIqv0wEvjmgdOXL
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="139570623"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:40:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:40:12 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 06:40:10 -0700
Subject: Re: [PATCH v2 01/25] MAINTAINERS: add microchip csi2dc
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jacopo@jmondi.org>,
        <sakari.ailus@iki.fi>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-2-eugen.hristev@microchip.com>
 <YaVe1sNFQfYEVtKh@pendragon.ideasonboard.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <25c5a4dd-0927-5b78-e32c-9254fcca29b0@microchip.com>
Date:   Mon, 13 Dec 2021 14:40:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YaVe1sNFQfYEVtKh@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 at 00:14, Laurent Pinchart wrote:
> Hi Eugen,
> 
> Thank you for the patch.
> 
> On Fri, Nov 12, 2021 at 04:24:45PM +0200, Eugen Hristev wrote:
>> Add Microchip CSI2DC driver in the list.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If needed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks a lot Eugen!
Best regards,
   Nicolas

>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 486bdf97f754..545c642c937f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12422,6 +12422,13 @@ L:   alsa-devel@alsa-project.org (moderated for non-subscribers)
>>   S:   Supported
>>   F:   sound/soc/atmel
>>
>> +MICROCHIP CSI2DC DRIVER
>> +M:   Eugen Hristev <eugen.hristev@microchip.com>
>> +L:   linux-media@vger.kernel.org
>> +S:   Supported
>> +F:   Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
>> +F:   drivers/media/platform/atmel/microchip-csi2dc.c
>> +
>>   MICROCHIP ECC DRIVER
>>   M:   Tudor Ambarus <tudor.ambarus@microchip.com>
>>   L:   linux-crypto@vger.kernel.org
> 
> --
> Regards,
> 
> Laurent Pinchart
> 


-- 
Nicolas Ferre
