Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD04D1D91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbiCHQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348558AbiCHQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:41:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3231752B0E;
        Tue,  8 Mar 2022 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646757617; x=1678293617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xQzJKcusyvUkkA9RXf+HpUrMRJQ394C+/khbeGtB8Rs=;
  b=ZEjJanj1lVqzjtdFspKEsA3MDxqwQAi1hn725sfB8JzTkuEbGLBPw2Me
   I/QtCd0loFK9GJcaivnebY4lQC+9nxnwrdPVXYfzSBQw3BSLyGq2O0uPg
   fYP8Sewx1huU6KxmBQjpAvMn1jaxXaoa5qVwtmea4TRtxjSaNC7MzJjUo
   mKCsU2sYVjftFJLJwqGARHWa53UM0tLxAW4RB6NIrCxtM0wtUpF4wLJxO
   Q03cP7rLFJlqrHXdDcm/efIX9aTTjkZ7tw2IZ37mQm6SHCQfvMG8NpYsE
   vd+rR6DAVZH+K5RMXhhaB6F5lCMRHDVaXPc/DzKqicQSjGyVh6M8V5Wbz
   w==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="148493344"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 09:40:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 09:40:15 -0700
Received: from [10.12.73.60] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 09:40:13 -0700
Message-ID: <ca66b439-ef3d-9968-7bf7-d0bf5e98813f@microchip.com>
Date:   Tue, 8 Mar 2022 17:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: rtc: at91: rename rtt bindings file
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220308155735.54146-1-alexandre.belloni@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220308155735.54146-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 at 16:57, Alexandre Belloni wrote:
> atmel,at91sam9-rtc is a confuing name for this file as it is documenting

confusing ^

> the RTT used as an RTC and not the other regular RTC (atmel,at91rm9200-rtc
> and atmel,at91sam9x5-rtc)
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Yes, clearer indeed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

True that this driver's name was confusing from day 1...

Thanks Alexandre, best regards,
   Nicolas

> ---
>   .../rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml}   | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename Documentation/devicetree/bindings/rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> similarity index 100%
> rename from Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> rename to Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> --
> 2.35.1
> 


-- 
Nicolas Ferre
