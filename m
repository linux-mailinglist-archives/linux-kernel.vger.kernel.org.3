Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E25470826
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245132AbhLJSOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:14:21 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:18998 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230284AbhLJSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:14:20 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BAGl270032723;
        Fri, 10 Dec 2021 12:10:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=6bLw8PV0wGdhrj9qUUUGQ/aTrVjG+S7eK4bUHn3Tqg0=;
 b=iNezJlqF9CtY/fuTW2OpN3XeUvhQXMKZHu1LxS5F1Moh2ztfGItzh6JMJDwjzvBqvakv
 wPMCSrjB1Rm1VUjVRiiF46yKx+HRGgrJ+8qKvYiVeCgykk4etilISlJhi1hmO4npO8YN
 vAEypP41d+QJMHtW00e1iFsIkD8vNbJ8TRa45mclAXCtvfAfsf5k4TRT0azhfwuC3QdR
 MLbs62CQD7zyDKrXBNE4uvg42vaKXtsdPVpBU38AF6u7V8hFBH8lgAdSTpmYDewPRM5u
 u+sK9KoNNYlNDcdd3YXLIXyKG8N9OW+FcAhhEYsQLScy4T3qeQwxnxCnHt2Gv47M1yQv fw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cvaq6g39j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Dec 2021 12:10:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 18:10:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 18:10:30 +0000
Received: from [198.61.65.77] (unknown [198.61.65.77])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 070FC7C;
        Fri, 10 Dec 2021 18:10:29 +0000 (UTC)
Message-ID: <85e9e11d-a4fc-44a9-55c2-3a4d2de7769d@opensource.cirrus.com>
Date:   Fri, 10 Dec 2021 18:10:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] spi: Revert "spi: Remove unused function
 spi_busnum_to_master()"
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
 <Yan6JVpS50keP2Pl@smile.fi.intel.com>
 <a1f546c2-5c63-573a-c032-603c792f3f7c@redhat.com>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <a1f546c2-5c63-573a-c032-603c792f3f7c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MglfS8b3EVvK8oP7VMy3cuLPPi0eIGNG
X-Proofpoint-GUID: MglfS8b3EVvK8oP7VMy3cuLPPi0eIGNG
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 11:14, Hans de Goede wrote:
> Hi,
> 
> On 12/3/21 12:06, Andy Shevchenko wrote:
>> On Thu, Dec 02, 2021 at 04:24:19PM +0000, Stefan Binding wrote:
>>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>>
>>> Revert commit bdc7ca008e1f ("spi: Remove unused function
>>> spi_busnum_to_master()")
>>> This function is needed for the spi version of i2c multi
>>> instantiate driver.
>>
>> I understand the intention, but I have no clue from this series (it lacks of
>> proper cover letter, it lacks of much better and justified commit message in
>> the patch 3) what is the actual issue. Without these to be provided it's no go
>> for the series. Please, provide much better description what is the actual
>> issue you are trying to solve (from patch 3 my guts telling me that this can
>> be achieved differently without this code being involved).
> 
> Yes I assume that eventually there will be a follow-up which will
> actually add some new ACPI HIDs to the new bus-multi-instantiate.c file ?
> 
Yes, we are developing an HDA sound driver for the HID CSC3551,
which is used for laptops that use SPI or I2C.
And in that series is where we plan to put a patch to add that HID.

> Can we please have (some of) those patches as part of the next
> version, so that we can see how you will actually use this?
The series is this one https://lkml.org/lkml/2021/11/23/723, but
the SPI HID was not ready to be sent in that version, but will be
part of the next submission.

> 
> Also I'm wondering is this actually about ACPI device's having multiple
> SpiSerialBusV2 resources in a single _CRS resource list ?
yes, a single _CRS with 2 or 4 SpiSerialBusV2 inside.

> 
> Or do you plan to use this for devices with only a single
> I2cSerialBusV2 or SpiSerialBusV2 resource to e.g. share IRQ lookup
> code between the 2 cases ?
No, the minimum number SpiSerialBusV2 or I2cSerialBusV2 inside the
_CRS is two.

> 
> If you plan to use this for devices with only a single
> I2cSerialBusV2 or SpiSerialBusV2 resource, then I'm going to have to
> nack this.
> 
> Each ACPI HID which needs to be handled in this code also needs an
> entry in the i2c_multi_instantiate_ids[] list in drivers/acpi/scan.c
> which is code which ends up loaded on every single ACPI system, so
> we really only want to add HIDs there for the special case of having
> multiple I2cSerialBusV2 or SpiSerialBusV2 resources in a single
> ACPI Device / ACPI fwnode.
> 
> If you are looking to use this as a way to share code for other reasons
> (which is a good goal to strive for!) please find another way, such
> as e.g. adding some helper functions to drivers/gpio/gpiolib-acpi.c
> (note there already are a couple of helpers there which you may use).
No, we only want to multi instantiate SPI or I2C devices from a single _CRS.

> 
> Regards,
> 
> Hans
> 
We sent a request to the laptop vendor about releasing the SPI DSDT, and 
after that gets cleared, we will send it to you for review. That will 
likely be next.

Thanks
Lucas Tanure

