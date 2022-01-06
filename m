Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9B48612F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiAFHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:55:53 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28816 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiAFHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641455752; x=1672991752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9hiyN3diJQDZOnngksGKn3A2YNPvEM2B2/Gn5E4IP+8=;
  b=GInok0nkMPOmUKV5FlqZuyqU2NY03YfS/jsBPd+IrEEh9C4gVRBrShNH
   D3NcqHtx3KBa5jmQgmoZqhZwO2RiHXCk23md3Yd9uA+JEi7bzeayiP/iu
   pImE8P4ebCR9v+MjCWtd5ruAqvkSVeQPZ/iWAH6OfmKYBhBThZ9zhM+VB
   QCq/Rc20xd87cgNRQVo8gPG0EcdqW04awH2S2Tkq7P5SbbzohJNUW/WOh
   +PGHW7PouHBQmoApDoVHfEM+0hP0Aselp/kAP7M0StZVL6czaj+AEq0GE
   QnHhOspHzA/6YIpwH9OyESLp2EVbiRqnLsVenUvT7JxvwqVOShkUJOqUV
   g==;
X-IronPort-AV: E=Sophos;i="5.88,266,1635177600"; 
   d="scan'208";a="301685293"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2022 15:55:52 +0800
IronPort-SDR: eci/wDvjhs3BmcY8xDVjnS0HsS62ftDNRO5aY5lOx0MBbjpzQerhxefK/VfE04a6XpqoWpfjle
 XQ3LQtQjlmBhYwAs8nT1+Jrswmi1OIB4SdtqJ2nHvN2yisIZo7wI2lSHtzc2cwEvwWCaywW+ay
 nWuQqvmqPoIkS8th0oAjVnXxxYGGvv5tXNcmT6SDtmJbtbLDz/hSJjfssNW6nUYjxNgZUM9hpF
 B30EUluh1hY1r/3PMW2vs51h3uKVFC3mUB1L99rqPvEb01tu3vSYx01OtUP+WyG6melk0nc8p5
 O1w4sP4yN0xZTcubh3Pbjcgk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 23:29:42 -0800
IronPort-SDR: 4PXYOrIv5EFUQSb8ZodwOPhKoZOFoccyVziyE5uxd6j06he+Yf+/FMcGb+3z1bLAoctQMUgSg3
 /2tuIcyuN82LkdVpd/1gNSsaiVxxcf/Cxgzqojevz3Qv8iVyQIv5jjmPb63Nj+hS3+4xrggJhb
 9XsWyyybZvvwKxxfc93nDuNMa75NbPr9HkJILUH+cjAYxvCCKYPlr6IeucjBmVZlLZrQj/xBJn
 vW9lRTbmm1Wsw5NzVq7H3ZitqKgWAPadxR8fzzo8yQGfLQ0JPrpz7FH9RQQpM8uVSf3YCeCYcV
 UKs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 23:55:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTzDl6RFFz1VSkZ
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 23:55:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641455751; x=1644047752; bh=9hiyN3diJQDZOnngksGKn3A2YNPvEM2B2/G
        n5E4IP+8=; b=o0aXcvK2o1YuEcLQOWeEXiFNj8cKWIPKSu/a6dFFL5H8tyXN4wt
        50wkHJKLGDivdhQt7f0uoMDn1Ac17vFBcDe366mDjpRwPNIsiUEruSFqbeoKi6QQ
        UvyB3k8/KENatrdfh+enw8265tljbHXMVHhIC6Lqvfg/f6CcuEfs++SF5kCUppMj
        SAwYN3siS88cY6o/zT7mmbry5geI4VYVH+hXVtVeGljwUGwFt4h0vPtSoieW0ak3
        jFeN4wRFFURq87VdJ2DAT/vg+OIbn1bpW7I8cOQA+CjLdDAIJznDZsxIHwU5Bl3I
        PM6I9uK4gn5X/UNmRggKfpLsNbBaCUB7MSQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TyG63QHuQXQd for <linux-kernel@vger.kernel.org>;
        Wed,  5 Jan 2022 23:55:51 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTzDk6YQzz1VSkV;
        Wed,  5 Jan 2022 23:55:50 -0800 (PST)
Message-ID: <1665d5a4-994a-b9df-33a9-c748bd5c17be@opensource.wdc.com>
Date:   Thu, 6 Jan 2022 16:55:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/2] ahci: Rename flag `ATA_LFLAG_NO_DB_DELAY` to
 `ATA_LFLAG_NO_DEBOUNCE_DELAY`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
 <d5130eed-d881-f654-3e24-b552609abce9@opensource.wdc.com>
 <e19a8764-2943-f370-f1d9-bb399a2aa1ac@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e19a8764-2943-f370-f1d9-bb399a2aa1ac@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 16:35, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Am 06.01.22 um 03:52 schrieb Damien Le Moal:
>> On 1/6/22 00:36, Paul Menzel wrote:
>>> The new name is longer, but clearer.
>>
>> It looks like you sent an incremental change on top of your previous
>> patches. Please send a cleaned up series. One patch to introduce the
>> ATA_LFLAG_NO_DEBOUNCE_DELAY flag & msleep bypass and another to add the
>> AMD chipset.
>>
>> The commit message of this version patch 2 should be the explanation for
>> the ATA_LFLAG_NO_DEBOUNCE_DELAY flag, not for adding a new chipset ID.
> 
> Sorry, but I think you misread the patch. The flag 
> `ATA_LFLAG_NO_DB_DELAY` exists since commit e39b2bb3b7 (libata: skip 
> debounce delay on link resume).

Arg. Indeed. Ignore my comment :)

Let's wait to see if there are any more comments and I will queue this
up for 5.17.

Going forward, it would be interesting to work on reversing the default:
no delay by default and mark all old & unknown adapters as needing the
delay. As you mentioned, most modern AHCI adapters most likely do not
need it.

Are you willing to take this and send a patches ?

> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> ---
>>>   drivers/ata/ahci_brcm.c   | 2 +-
>>>   drivers/ata/libata-sata.c | 2 +-
>>>   include/linux/libata.h    | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
>>> index 6e9c5ade4c2ea..649815c196ed0 100644
>>> --- a/drivers/ata/ahci_brcm.c
>>> +++ b/drivers/ata/ahci_brcm.c
>>> @@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
>>>   
>>>   static const struct ata_port_info ahci_brcm_port_info = {
>>>   	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
>>> -	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
>>> +	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
>>>   	.pio_mask	= ATA_PIO4,
>>>   	.udma_mask	= ATA_UDMA6,
>>>   	.port_ops	= &ahci_brcm_platform_ops,
>>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>>> index b9c77885b8726..67b2e7cf3cc4e 100644
>>> --- a/drivers/ata/libata-sata.c
>>> +++ b/drivers/ata/libata-sata.c
>>> @@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
>>>   		 * immediately after resuming.  Delay 200ms before
>>>   		 * debouncing.
>>>   		 */
>>> -		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
>>> +		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
>>>   			ata_msleep(link->ap, 200);
>>>   
>>>   		/* is SControl restored correctly? */
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 2a8404b26083c..15802e644962d 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -191,7 +191,7 @@ enum {
>>>   	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
>>>   	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
>>>   	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
>>> -	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
>>> +	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
>>>   
>>>   	/* struct ata_port flags */
>>>   	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
>>
>>


-- 
Damien Le Moal
Western Digital Research
