Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA84C596CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiHQKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiHQKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:24:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623D5D0EE;
        Wed, 17 Aug 2022 03:24:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pm17so12082736pjb.3;
        Wed, 17 Aug 2022 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qQBgNK2cFBcoQ3FGXUIePsyJ39lKMEasmh4FaP7PQlE=;
        b=OKIOhq/f4RfOE4ol/M1LSMSoEmgfoOsyS88MJLS7GVNDtRyPTz4T29aQgl1C8dCiFR
         BcyR7uf60J1Xmw08ekWz2F4KJDw0WIqscWXGey9lyVHCAr4rOqvb3naRBUu36GpiNlb0
         YnM7pmozxKt9oKLg6q7S/iFXvOAkRR2YGe/+waHQMP8izhSqIj8dVctKzS4PUm1Erwhi
         Hm8sT19E/fwGSE9MFftHM50ZPnLl/2YiIsPRMtyK79aLlIxj6WytJq2rOMe7umCMCY6i
         RKlQNuVk2zwZSpm1K7vO6i28F3AxfpdGI4CodXNGGB8RPuZW+tidONpDXh1VIDP+xcBL
         LW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qQBgNK2cFBcoQ3FGXUIePsyJ39lKMEasmh4FaP7PQlE=;
        b=Wq0m+HwOlx4LJg8o/O8o/32FC53IoRSXffjKdgSDiKOGVPy7eWUaagEi8vJf1I1FWA
         eUCktBfKmYEQ/HiZFjLOR/XvDxh+3j4u7B2YKDmptz4aW33ZVqt2USq5BJiwdg1aKbZa
         yZkKk7PjR6N0+V+ZBrQkDoCe9HYMzJDn+N4rzCrTmhe/squaA2a+XBj3x+268kVg0o2F
         IjX1ISodkIR3ZukOEyQPcPCvJFS2QYgIPjimsWJl+4R1OhxdSAsyHkcJYp5DC7lE97Pe
         +9PoqPMvZ4UUXArLWkjboMfejFFVpd3JrbQvnc6AjyO3NPc9AACsegFUmtiPZV1Xt6h2
         aR0w==
X-Gm-Message-State: ACgBeo2khH3sHANx86rk4L+F/s96bdVS/ABLbwS57gXis9Lq1zjIqisB
        K3+Cy/X6bbV+bwa+UiNglak=
X-Google-Smtp-Source: AA6agR5W3y4GfAKTKJLzQV9mvcc6Tz+YKmkHbmqwZAzQVyI38lBL1Bfi6gnYYFyGei/WBjXgBPMDlw==
X-Received: by 2002:a17:902:b94b:b0:170:c9d6:a06d with SMTP id h11-20020a170902b94b00b00170c9d6a06dmr26121159pls.105.1660731896277;
        Wed, 17 Aug 2022 03:24:56 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001714e7608fdsm1060728pll.256.2022.08.17.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:24:56 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     mika.westerberg@linux.intel.com, mario.limonciello@amd.com
Cc:     gregkh@linuxfoundation.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: RE: RE: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Date:   Wed, 17 Aug 2022 18:24:50 +0800
Message-Id: <20220817102450.63514-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
Hi,

>> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>>

>> +static int asmedia_nvm_validate(struct tb_switch *sw, unsigned int mode)
>> +{
>> +	struct tb_nvm *nvm;
>> +	u32 val;
>> +	u32 nvm_size;
>> +	int ret = 0;
>> +	unsigned int image_size;
>> +
>> +	switch (mode) {
>> +	case NVM_UPGRADE:
>> +		if (sw->no_nvm_upgrade)
>> +			sw->no_nvm_upgrade = false;
>> +
>> +		break;
>> +
>> +	case NVM_ADD:
>> +		nvm = tb_nvm_alloc(&sw->dev);
>
>This function does not only "validate" but it also creates the NVMem
>devices and whatnot.
>
>Do you have some public description of the ASMedia format that I could
>take a look? Perhaps we can find some simpler way of validating the
>thing that works accross different vendors.
>

ASMedia NVM format include rom file, firmware and security configuration information. And active firmware depend on this information for processing. We don't need to do any validation during firmware upgrade, so we haven't public description of the ASMedia format.

I think I use "validate" is not fit. This function mainly to create the NVMem devices and write. I will rename in the next patch.

>> +			ret = PTR_ERR(nvm);
>> +			break;
>> +		}
>> +
>> +		ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
>> +		if (ret)
>> +			break;
>> +
>> +		nvm->nvm_asm.major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
>> +		ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
>> +		if (ret)
>> +			break;
>> +
>> +		nvm->nvm_asm.minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
>> +		nvm_size = SZ_512K;
>> +		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
>> +		if (ret)
>> +			break;
>> +
>> +		ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
>> +		if (ret)
>> +			break;
>> +
>> +		sw->nvm = nvm;
>> +		break;
>> +
>> +	case NVM_WRITE:
>> +		const u8 *buf = sw->nvm->buf;
>> +
>> +		if (!buf) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +		image_size = sw->nvm->buf_data_size;
>> +		if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
>> +		if (!ret)
>> +			sw->nvm->flushed = true;
>> +
>> +		break;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if ((mode == NVM_ADD) && (ret != 0))
>> +		tb_nvm_free(sw->nvm);
>> +
>> +	return ret;
>> +}




>> @@ -1953,6 +1971,9 @@ static ssize_t nvm_version_show(struct device *dev,
>>  		ret = -ENODATA;
>>  	else if (!sw->nvm)
>>  		ret = -EAGAIN;
>> +	/*ASMedia NVM version show format xxxxxx_xxxxxx */
>> +	else if (sw->config.vendor_id == 0x174C)
>> +		ret = sprintf(buf, "%06x.%06x\n", sw->nvm->nvm_asm.major, sw->nvm->nvm_asm.minor);
>
>And yes, we can make the nvm->major/minor to be 32-bit integers too for
>both Intel and ASMedia and continue to use the %x.%x formatting.
>

Thanks to Mika and Mario for the suggestion, I'll fix it in next patch.

>>  	else
>>  		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
>>
>> @@ -2860,6 +2881,7 @@ int tb_switch_add(struct tb_switch *sw)
>>  		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
>>
>>  		tb_check_quirks(sw);
>> +		tb_nvm_validate(sw, NVM_UPGRADE);
>>
>>  		ret = tb_switch_set_uuid(sw);
>>  		if (ret) {
>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>> index 5db76de40cc1..7f5c8ae731a0 100644
>> --- a/drivers/thunderbolt/tb.h
>> +++ b/drivers/thunderbolt/tb.h
>> @@ -28,6 +28,15 @@
>>  #define NVM_VERSION		0x08
>>  #define NVM_FLASH_SIZE		0x45
>>
>> +/* ASMedia specific NVM offsets */
>> +#define ASMEDIA_NVM_VERSION	0x28
>> +#define ASMEDIA_NVM_DATE	0x1c
>
>Didn't I already commented about these? Are my emails somehow lost or
>they just get ignored?
>

Sorry, I miss it. I've checked and I will fix it in next patch.

