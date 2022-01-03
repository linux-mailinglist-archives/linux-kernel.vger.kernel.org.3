Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5565D483586
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiACRYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiACRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:24:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71CC061761;
        Mon,  3 Jan 2022 09:24:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jw3so29286468pjb.4;
        Mon, 03 Jan 2022 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0L/XmYFJf7rrncW5i02VYWysmo3VfvrxIa/jZ7I+BkQ=;
        b=ED4rqF+g9MCRv017zZ8RyDk0oWyweMGo8g7V0buGpzdZ3DhieYnVpLRtullR+zrVBt
         StidQeLg8O47qNCDe7npV4B4k4v9Equw317TeBMu+XVWNMHmKA8vYEywU3X0Lsvom1pb
         J+SyrVFQU3/4aP/PvVpd8Hblb2ey+Kp6FJklpzdkw0WEOKajkqPMGwCVp4jkCqG8qFI5
         nbI14EGtpXWC2bZqNA+pNuHrdcSZnIjeTJCdHY9A394+es//ZBfpbzsMr1Bb565gMon8
         4ogvTHANLrO8vKeEMD5mOuvsf7YUiBUMmGZg+J/zeQ7SkpcCQTP0WU++XaRpe2/B/JvN
         ImbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0L/XmYFJf7rrncW5i02VYWysmo3VfvrxIa/jZ7I+BkQ=;
        b=qzSQIDzPVP6JzpTBApjYMPJTlA+uT6CkXDdd8JZSDcceSy+ie2EiII/ZBgUyz3H381
         bM2ZglsAl0tGJHLNgRb5ivOXvZMaMGIYNBf2GPrkmiyHPpT76wX9wytOX+m05RFTERtv
         EdY56EMl1PPiq+5AkfDtrsHtH9nPuqpufF0J0Kfun4cAcQhIMTdB1/i0cQ++YPYgDn7n
         W29qJHexQbrURNfciXhY9DM50djmjjAiw+MGCqB2bu7n2HH5hfz9URtdBZyDdpMagJIt
         wb438XgtwpGTshbITVVVn0JXKSuJ7WvE/uLt4WZjrhBImdeTxzB9iuMGGfmAXxRP8sCr
         erQg==
X-Gm-Message-State: AOAM532791c+62NOEqX1KzastMu7S2T2ZbhWdJwY9HfEm3t8Pw8WQzu2
        L59R5U4dN4+pQgL0dmv8thU=
X-Google-Smtp-Source: ABdhPJxU+vdH181ESxpFTV/gZNCfEJtI3PFpJP0OJhjASZvO61OpFsO4xDf9+cjutucymgULxohxJA==
X-Received: by 2002:a17:903:110d:b0:149:a908:16a2 with SMTP id n13-20020a170903110d00b00149a90816a2mr16078909plh.77.1641230669038;
        Mon, 03 Jan 2022 09:24:29 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id f5sm40896020pfc.102.2022.01.03.09.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 09:24:28 -0800 (PST)
Message-ID: <299bf6ed-80e6-ad15-8dc7-5ededaca15c5@gmail.com>
Date:   Mon, 3 Jan 2022 09:24:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O
 operations
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
 <20211223002225.3738385-2-f.fainelli@gmail.com>
 <20220103174953.40d7fa52@xps13>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220103174953.40d7fa52@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/2022 8:49 AM, Miquel Raynal wrote:
> Hi Florian,
> 
> f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:17 -0800:
> 
>> Allow a brcmnand_soc instance to provide a custom set of I/O operations
>> which we will require when using this driver on a BCMA bus which is not
>> directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
>> to use the SoC operations if provided.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++++--
>>   drivers/mtd/nand/raw/brcmnand/brcmnand.h | 23 +++++++++++++++++++++++
>>   2 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> index f75929783b94..7a1673b1b1af 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>> @@ -594,13 +594,18 @@ enum {
>>   
>>   static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
>>   {
>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>> +		return brcmnand_soc_read(ctrl->soc, offs);
>>   	return brcmnand_readl(ctrl->nand_base + offs);
>>   }
>>   
>>   static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,
>>   				 u32 val)
>>   {
>> -	brcmnand_writel(val, ctrl->nand_base + offs);
>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>> +		brcmnand_soc_write(ctrl->soc, val, offs);
>> +	else
>> +		brcmnand_writel(val, ctrl->nand_base + offs);
>>   }
>>   
>>   static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
>> @@ -766,13 +771,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
>>   
>>   static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)
>>   {
>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>> +		return brcmnand_soc_read(ctrl->soc, ~0);
>>   	return __raw_readl(ctrl->nand_fc + word * 4);
>>   }
>>   
>>   static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
>>   				     int word, u32 val)
>>   {
>> -	__raw_writel(val, ctrl->nand_fc + word * 4);
>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>> +		brcmnand_soc_write(ctrl->soc, val, ~0);
>> +	else
>> +		__raw_writel(val, ctrl->nand_fc + word * 4);
>>   }
>>   
>>   static inline void edu_writel(struct brcmnand_controller *ctrl,
>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>> index eb498fbe505e..a3f2ad5f6572 100644
>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>> @@ -11,12 +11,19 @@
>>   
>>   struct platform_device;
>>   struct dev_pm_ops;
>> +struct brcmnand_io_ops;
>>   
>>   struct brcmnand_soc {
>>   	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
>>   	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
>>   	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
>>   				 bool is_param);
>> +	const struct brcmnand_io_ops *ops;
>> +};
>> +
>> +struct brcmnand_io_ops {
>> +	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
>> +	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
>>   };
>>   
>>   static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,
>> @@ -58,6 +65,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
>>   		writel_relaxed(val, addr);
>>   }
>>   
>> +static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)
>> +{
>> +	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
>> +}
>> +
>> +static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
>> +{
>> +	return soc->ops->read_reg(soc, offset);
>> +}
>> +
>> +static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
>> +				      u32 offset)
>> +{
>> +	soc->ops->write_reg(soc, val, offset);
>> +}
>> +
> 
> It might be worth looking into more optimized ways to do these checks,
> in particular the read/write_reg ones because you're checking against
> some static data which cannot be optimized out by the compiler but
> won't change in the lifetime of the kernel.

I suppose I could add an addition if 
IS_ENABLED(CONFIG_MTD_NAND_BRCMNAND_BCMA) at the front of 
brcmnand_soc_has_ops(), would that address your concern or you have 
something else in mind?
--
Florian
