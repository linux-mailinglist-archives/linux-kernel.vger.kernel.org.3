Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782B59CD10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiHWAQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiHWAQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:16:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097DC2645
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:15:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27N0FV6k107065;
        Mon, 22 Aug 2022 19:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661213731;
        bh=1pvEIPM5APQYIyVk9xEPtDo5fZUVbe90+kCOuMJEMmk=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Awm180sKAWTrh07acCCEnY52GRYqhnpHRsphg0OJ+jnrF0uHtcBpv532TesA+SuBs
         Xjh56JsdQ9ChlSkV7s58fjW0ZE6SovCBUTMjQKO25fNoSV7CrUR1Gm7QBF5e5tVagt
         5o7ciiVUgIxAyK5vFIZhnb2HcwHEMDCmGaeCP0gM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27N0FVRc046189
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 19:15:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 19:15:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 19:15:30 -0500
Received: from [10.250.35.81] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27N0FUmo067307;
        Mon, 22 Aug 2022 19:15:30 -0500
Message-ID: <c09c1ff3-5be4-71e0-ba76-d96da1e49501@ti.com>
Date:   Mon, 22 Aug 2022 19:15:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm: Move radeon and amdgpu Kconfig options into their
 directories
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220823000111.9765-1-afd@ti.com>
 <a5f03c19-faeb-9a64-a214-8f6a0552e8dc@infradead.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <a5f03c19-faeb-9a64-a214-8f6a0552e8dc@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 7:06 PM, Randy Dunlap wrote:
> Hi--
> 
> On 8/22/22 17:01, Andrew Davis wrote:
>> Most Kconfig options to enable a driver are in the Kconfig file
>> inside the relevant directory, move these two to the same.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/gpu/drm/Kconfig            | 42 ------------------------------
>>   drivers/gpu/drm/amd/amdgpu/Kconfig | 22 ++++++++++++++++
>>   drivers/gpu/drm/radeon/Kconfig     | 22 ++++++++++++++++
>>   3 files changed, 44 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 6c2256e8474b..24fa9ccd92a4 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -234,50 +234,8 @@ source "drivers/gpu/drm/i2c/Kconfig"
>>   
>>   source "drivers/gpu/drm/arm/Kconfig"
>>   
>> -config DRM_RADEON
>> -	tristate "ATI Radeon"
>> -	depends on DRM && PCI && MMU
>> -	depends on AGP || !AGP
>> -	select FW_LOADER
>> -	select DRM_DISPLAY_DP_HELPER
>> -	select DRM_DISPLAY_HELPER
>> -        select DRM_KMS_HELPER
>> -        select DRM_TTM
>> -	select DRM_TTM_HELPER
>> -	select POWER_SUPPLY
>> -	select HWMON
>> -	select BACKLIGHT_CLASS_DEVICE
>> -	select INTERVAL_TREE
>> -	help
>> -	  Choose this option if you have an ATI Radeon graphics card.  There
>> -	  are both PCI and AGP versions.  You don't need to choose this to
>> -	  run the Radeon in plain VGA mode.
>> -
>> -	  If M is selected, the module will be called radeon.
>> -
>>   source "drivers/gpu/drm/radeon/Kconfig"
>>   
>> -config DRM_AMDGPU
>> -	tristate "AMD GPU"
>> -	depends on DRM && PCI && MMU
>> -	select FW_LOADER
>> -	select DRM_DISPLAY_DP_HELPER
>> -	select DRM_DISPLAY_HDMI_HELPER
>> -	select DRM_DISPLAY_HELPER
>> -	select DRM_KMS_HELPER
>> -	select DRM_SCHED
>> -	select DRM_TTM
>> -	select DRM_TTM_HELPER
>> -	select POWER_SUPPLY
>> -	select HWMON
>> -	select BACKLIGHT_CLASS_DEVICE
>> -	select INTERVAL_TREE
>> -	select DRM_BUDDY
>> -	help
>> -	  Choose this option if you have a recent AMD Radeon graphics card.
>> -
>> -	  If M is selected, the module will be called amdgpu.
>> -
>>   source "drivers/gpu/drm/amd/amdgpu/Kconfig"
>>   
>>   source "drivers/gpu/drm/nouveau/Kconfig"
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> index 7777d55275de..36b1206124cf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> @@ -1,4 +1,26 @@
>>   # SPDX-License-Identifier: MIT
>> +
>> +config DRM_AMDGPU
>> +	tristate "AMD GPU"
>> +	depends on DRM && PCI && MMU
>> +	select FW_LOADER
>> +	select DRM_DISPLAY_DP_HELPER
>> +	select DRM_DISPLAY_HDMI_HELPER
>> +	select DRM_DISPLAY_HELPER
>> +	select DRM_KMS_HELPER
>> +	select DRM_SCHED
>> +	select DRM_TTM
>> +	select DRM_TTM_HELPER
>> +	select POWER_SUPPLY
>> +	select HWMON
>> +	select BACKLIGHT_CLASS_DEVICE
>> +	select INTERVAL_TREE
>> +	select DRM_BUDDY
>> +	help
>> +	  Choose this option if you have a recent AMD Radeon graphics card.
>> +
>> +	  If M is selected, the module will be called amdgpu.
>> +
>>   config DRM_AMDGPU_SI
>>   	bool "Enable amdgpu support for SI parts"
>>   	depends on DRM_AMDGPU
>> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
>> index 52819e7f1fca..3248d12c562d 100644
>> --- a/drivers/gpu/drm/radeon/Kconfig
>> +++ b/drivers/gpu/drm/radeon/Kconfig
>> @@ -1,4 +1,26 @@
>>   # SPDX-License-Identifier: MIT
>> +
>> +config DRM_RADEON
>> +	tristate "ATI Radeon"
>> +	depends on DRM && PCI && MMU
>> +	depends on AGP || !AGP
>> +	select FW_LOADER
>> +	select DRM_DISPLAY_DP_HELPER
>> +	select DRM_DISPLAY_HELPER
>> +        select DRM_KMS_HELPER
>> +        select DRM_TTM
> 
> Would you change those 2 lines above to use one tab + 2 spaces
> for indentation, please?
> 


Sure, I just copy/paste exactly as they are in the top level Kconfig,
white-space issues and all, to make it easy to see that nothing was changed.

I can fix the indent issue in a followup patch if that work better.
Whichever works better.

Andrew


>> +	select DRM_TTM_HELPER
>> +	select POWER_SUPPLY
>> +	select HWMON
>> +	select BACKLIGHT_CLASS_DEVICE
>> +	select INTERVAL_TREE
>> +	help
>> +	  Choose this option if you have an ATI Radeon graphics card.  There
>> +	  are both PCI and AGP versions.  You don't need to choose this to
>> +	  run the Radeon in plain VGA mode.
>> +
>> +	  If M is selected, the module will be called radeon.
>> +
>>   config DRM_RADEON_USERPTR
>>   	bool "Always enable userptr support"
>>   	depends on DRM_RADEON
> 
