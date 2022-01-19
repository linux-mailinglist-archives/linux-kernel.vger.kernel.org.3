Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE8493F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356464AbiASRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:33:38 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19112 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356459AbiASRdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:33:36 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JD9ur7018066;
        Wed, 19 Jan 2022 11:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=LY8az2HAXRdiK9ynIDy8Pw58Iw4eWpj3/24rUT1e+os=;
 b=n0QG9BKUv/1pDcuKvySsjS/eXUiHdN6Pa2KnT1oZgNYyDFNO+fwhDORWK1+fqQ7g43bk
 Fort2dn9nT2QuJEFg7Tz9dFUfhIWfJZX1xBDtdHbWhjiJVS4CH0fSSJgmX2mRwvXPaO9
 Txx7dhGfVOHBIpWG/BHtarUi4WS365imxDLrMAEOxV0Au4Ibz866GgJYxqHEfX/iq8PT
 OJzMYlLhdOOMm37xlY8g4r/goafnb6vGYYI+jCPeV4sy8sVXPBkT27mWHh1AuygbeoOg
 TXSWdobJjzdao/Ls+BZsEf9NaNOXZE0Dojpye0q6p9uC5hzh0eHVPlI4r+4Skvtcwlyp mQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dpk9mg9xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 11:33:09 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 17:33:07 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 19 Jan 2022 17:33:07 +0000
Received: from [198.61.64.122] (unknown [198.61.64.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B1AA0B13;
        Wed, 19 Jan 2022 17:33:06 +0000 (UTC)
Message-ID: <a3522b5e-fb36-b959-d2ea-d141d3ad9999@opensource.cirrus.com>
Date:   Wed, 19 Jan 2022 17:33:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/10] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
 <20220118145251.1548-6-sbinding@opensource.cirrus.com>
 <CAJZ5v0g0n201FPcG9LBNG3e4UdNYSWmj_1sN3MxLxmK=GoF+tA@mail.gmail.com>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <CAJZ5v0g0n201FPcG9LBNG3e4UdNYSWmj_1sN3MxLxmK=GoF+tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pZTpulefTaRyopYGQrjbyoOJAYlFsx6q
X-Proofpoint-GUID: pZTpulefTaRyopYGQrjbyoOJAYlFsx6q
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 16:53, Rafael J. Wysocki wrote:
> On Tue, Jan 18, 2022 at 3:53 PM Stefan Binding
> <sbinding@opensource.cirrus.com> wrote:
>>
>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>
>> Moving I2C multi instantiate driver to drivers/acpi folder for
>> upcoming conversion into a generic bus multi instantiate
>> driver for SPI and I2C
>>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> Why are you moving it away from platform/x86?
> 
> Adding SPI to the mix doesn't seem to be a sufficient reason.
> 
> If this were going to be needed on non-x86, that would be a good
> reason for moving it, but is that actually the case?  If so, why isn't
> that mentioned in the changelog above?
> 

It was a request made by Andy Shevchenko:
https://lkml.org/lkml/2021/12/3/347

There is no plan to use our CS35L41 HDA with non-x86 platforms and we 
can't comment about i2c-multi-instantiate use.
For us it can stay in x86 folder until an actual request.

Thanks
Lucas Tanure


>> ---
>>   MAINTAINERS                                           |  2 +-
>>   drivers/acpi/Kconfig                                  | 11 +++++++++++
>>   drivers/acpi/Makefile                                 |  1 +
>>   .../{platform/x86 => acpi}/i2c-multi-instantiate.c    |  0
>>   drivers/acpi/scan.c                                   |  2 +-
>>   drivers/platform/x86/Kconfig                          | 11 -----------
>>   drivers/platform/x86/Makefile                         |  1 -
>>   7 files changed, 14 insertions(+), 14 deletions(-)
>>   rename drivers/{platform/x86 => acpi}/i2c-multi-instantiate.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4e828542b089..546f9e149d28 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -392,7 +392,7 @@ ACPI I2C MULTI INSTANTIATE DRIVER
>>   M:     Hans de Goede <hdegoede@redhat.com>
>>   L:     platform-driver-x86@vger.kernel.org
>>   S:     Maintained
>> -F:     drivers/platform/x86/i2c-multi-instantiate.c
>> +F:     drivers/acpi/i2c-multi-instantiate.c
>>
>>   ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>>   M:     Sudeep Holla <sudeep.holla@arm.com>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index ba45541b1f1f..2fd78366af6f 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -295,6 +295,17 @@ config ACPI_PROCESSOR
>>            To compile this driver as a module, choose M here:
>>            the module will be called processor.
>>
>> +config ACPI_I2C_MULTI_INST
>> +       tristate "I2C multi instantiate pseudo device driver"
>> +       depends on I2C
>> +       help
>> +         Some ACPI-based systems list multiple i2c-devices in a single ACPI
>> +         firmware-node. This driver will instantiate separate i2c-clients
>> +         for each device in the firmware-node.
>> +
>> +         To compile this driver as a module, choose M here: the module
>> +         will be called i2c-multi-instantiate.
>> +
>>   config ACPI_IPMI
>>          tristate "IPMI"
>>          depends on IPMI_HANDLER
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index bb757148e7ba..d4db7fb0baf0 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)       += spcr.o
>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>>   obj-$(CONFIG_ACPI_PPTT)        += pptt.o
>>   obj-$(CONFIG_ACPI_PFRUT)       += pfr_update.o pfr_telemetry.o
>> +obj-$(CONFIG_ACPI_I2C_MULTI_INST)      += i2c-multi-instantiate.o
>>
>>   # processor has its own "processor." module_param namespace
>>   processor-y                    := processor_driver.o
>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/acpi/i2c-multi-instantiate.c
>> similarity index 100%
>> rename from drivers/platform/x86/i2c-multi-instantiate.c
>> rename to drivers/acpi/i2c-multi-instantiate.c
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 1331756d4cfc..3e85a02f6ba2 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>>           * must be instantiated for each, each with its own i2c_device_id.
>>           * Normally we only instantiate an i2c-client for the first resource,
>>           * using the ACPI HID as id. These special cases are handled by the
>> -        * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
>> +        * drivers/acpi/i2c-multi-instantiate.c driver, which knows
>>           * which i2c_device_id to use for each resource.
>>           */
>>                  {"BSG1160", },
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 24deeeb29af2..37c1c150508d 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -990,17 +990,6 @@ config TOPSTAR_LAPTOP
>>
>>            If you have a Topstar laptop, say Y or M here.
>>
>> -config I2C_MULTI_INSTANTIATE
>> -       tristate "I2C multi instantiate pseudo device driver"
>> -       depends on I2C && ACPI
>> -       help
>> -         Some ACPI-based systems list multiple i2c-devices in a single ACPI
>> -         firmware-node. This driver will instantiate separate i2c-clients
>> -         for each device in the firmware-node.
>> -
>> -         To compile this driver as a module, choose M here: the module
>> -         will be called i2c-multi-instantiate.
>> -
>>   config MLX_PLATFORM
>>          tristate "Mellanox Technologies platform support"
>>          depends on I2C && REGMAP
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index c12a9b044fd8..6c7870190564 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -110,7 +110,6 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)        += topstar-laptop.o
>>
>>   # Platform drivers
>>   obj-$(CONFIG_FW_ATTR_CLASS)            += firmware_attributes_class.o
>> -obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
>>   obj-$(CONFIG_MLX_PLATFORM)             += mlx-platform.o
>>   obj-$(CONFIG_TOUCHSCREEN_DMI)          += touchscreen_dmi.o
>>   obj-$(CONFIG_WIRELESS_HOTKEY)          += wireless-hotkey.o
>> --
>> 2.25.1
>>

