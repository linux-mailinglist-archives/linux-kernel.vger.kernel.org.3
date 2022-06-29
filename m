Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BED5603C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiF2PBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiF2PBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:01:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042A25C7A;
        Wed, 29 Jun 2022 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656514907; x=1688050907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AFnpmXUgV9Lobv665HMdU2c+9Hcf3GrmG4/61iUM2Rc=;
  b=KU09C2pYpASOHrpzAYPa2SrEksyyHuLqo0/7amnDZQW1lK1ZS63MPeW1
   UEjRBR745sj+epv2rQcOhpIf+Tgv2d4u4OZH6zxyklpDmJQQV95NB/VTz
   q5US1oL0WPATJNZl0nAFAsai0mHNRs3vUSJxy84f2H/vmT0BmX3GMxTA+
   kSh0wMM3Wac4gAhD8hk6Vmw9EHNcbIQCDSdLxNeDZAq+h1zdAvuAzmRLG
   U9KWeg5jj1zjbtWcgH6UrG9YoUrVYOeRFmL3YLxipwFKPYS5Zr78fAAlj
   DAZUrXmrJWVxptAuc4B5CR/DdR8HjvPVZSQgbM8mv4xE/0lyn5h84t04S
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="180037379"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 08:01:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 08:01:43 -0700
Received: from [10.12.73.52] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 08:01:40 -0700
Message-ID: <f641fd0e-2da2-112e-f2fb-f5d89af00587@microchip.com>
Date:   Wed, 29 Jun 2022 17:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergiu Moga <sergiu.moga@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <a2422718-2ec4-dbad-0245-1d78dbb39f25@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <a2422718-2ec4-dbad-0245-1d78dbb39f25@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiu,

On 29/06/2022 at 15:23, Krzysztof Kozlowski wrote:
>> +title: Atmel SPI device
>> +
>> +maintainers:
>> +  - Mark Brown<broonie@kernel.org>
> This should be rather someone from Microchip.

Tudor Ambarus <tudor.ambarus@microchip.com> is our maintainer for SPI 
controller, sorry for not having advised you internally about this ;-)

Best regards,
   Nicolas

-- 
Nicolas Ferre
