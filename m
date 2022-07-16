Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F9576E30
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiGPNaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPNaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:30:22 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70802193F4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657978221; x=1689514221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FdNvnC/jXLQVuKQKOh4GkSi9QHzPIjITqKh0ZUq3XZg=;
  b=pPEftJfj9kUHZwd57zYDNwfdwAlZyeMHotTeedMbPnkkrrSoBz8DXMKU
   KC+Ieanxc+rqT9zaW5j2TqE+nNsiEeRW1hJJbTIX95H7VYvJrHdUwrXWg
   pGXTsdUzmN+3ugB6+MW8M1Q2Em07ta21yRxtCgcbk8Fy+FdqhPhKjbrs0
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jul 2022 06:30:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 06:30:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 16 Jul 2022 06:30:20 -0700
Received: from [10.110.64.167] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sat, 16 Jul
 2022 06:30:19 -0700
Message-ID: <9f734033-ecf1-af99-5d17-140fce910ff6@quicinc.com>
Date:   Sat, 16 Jul 2022 06:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: winbond: add support for
 W25Q512NW-IQ
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
 <20220716000643.3541839-2-quic_jaehyoo@quicinc.com>
 <52fb683e27b3208d07d9f9d1ab44148d@walle.cc>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <52fb683e27b3208d07d9f9d1ab44148d@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/16/2022 2:11 AM, Michael Walle wrote:
> Hi,
> 
> Am 2022-07-16 02:06, schrieb Jae Hyun Yoo:
>> Add support for Winbond W25Q512NW-IQ/IN
>>
>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Link: 
>> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks again for finding the real issue here!
> 
> Reviewed-by: Michael Walle <michael@walle.cc>

Thanks for your review!

> But also see below.
> 
>> $ hexdump
>> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp 
>>
>> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
>> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
>> 0000020 6f00 7074 7420 7365 ff74 ffff ffff ffff
> 
> Did you noticed your SFDP data changed compared to:
> https://lore.kernel.org/linux-mtd/20220710145721.1207157-1-quic_jaehyoo@quicinc.com/ 
> 
> 
> Which makes me wonder if you ever had an offset 0
> with the OTP_INFO(). For Winbond the first OTP
> region is actually the SFDP.. So you might
> accidentally modified it.

Indeed. Looks like the region got modified while I was testing OTP.
Please see below. I took the sfdp dump from a new clean part.

$ hexdump 
/sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
0000020 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
00000d0 0aff fff0 ff21 ffdc
00000d8

$ md5sum 
/sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
347f0027ec5a09e8e78d5685485cceed

Thanks,

Jae
