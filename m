Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249A5482114
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 01:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbhLaAud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 19:50:33 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:44012 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242418AbhLaAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 19:50:31 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JQ64k3ptqz1RvTg
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:50:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640911829; x=1643503830; bh=nufFl89iVbbU0oz8pnVFuSCyd6gSaOlBqpg
        z1/8eBcs=; b=gZqWQg/VE7p7XnJfwb0PVEjvr0z8+d/sML9AhNwq3djKPi139iF
        fwbS531Wob70Q4w9QV/aBjgHXsDRvKy7opUuCwmfPMkQh7x2OF6Jalhiaw4wE/or
        4nohuDVHQkctBQr1en7TMyZkU05P89MquqFxaXy8NIujVAXBVscFx6R5ABef8xdG
        1aVK1ajtLw3jNs0kdwB0kgn6zYkG4/mvazcy2kiA458hnpkXdaH4bhTmPFVAZqSo
        QF0IuFgwlT8Cp9aFTe2gtX8f3dX80+ESvaSrj/Jtp/tvCBNJOqY+1rnuk6BqE/D5
        gAzTUdNiil5OOB/dDFC6S73qicb+59VIURA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gXAetD9OKuMf for <linux-kernel@vger.kernel.org>;
        Thu, 30 Dec 2021 16:50:29 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JQ64h704dz1RtVG;
        Thu, 30 Dec 2021 16:50:28 -0800 (PST)
Message-ID: <c2f4e26f-5c94-8f26-d843-5dd2b8617add@opensource.wdc.com>
Date:   Fri, 31 Dec 2021 09:50:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/3] ahci: Use macro PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-2-pmenzel@molgen.mpg.de>
 <88daa493-dc08-06ea-97d3-94a9a3d7e51c@opensource.wdc.com>
 <0a32d475-33c7-b29d-d30d-e80bdd821af6@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0a32d475-33c7-b29d-d30d-e80bdd821af6@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 20:01, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Am 30.12.21 um 03:13 schrieb Damien Le Moal:
>> On 12/30/21 01:11, Paul Menzel wrote:
>>> Use the defined macro from `include/linux/pci_ids.h`.
>>>
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> ---
>>>   drivers/ata/ahci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index 1e1167e725a4..6a2432e4adda 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -436,7 +436,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>   		.class_mask = 0xffffff,
>>>   		board_ahci_al },
>>>   	/* AMD */
>>> -	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci }, >
>> That breaks the style of the declarations here... And since
>> PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE is used only in drivers/pci/quirks.c,
>> I do not really see the point of this change.
> 
> 1.  It makes the comment superfluous.
> 2.  `git grep 0x7800` in the Linux source returns 1034 hits, so getting 
> the macro name from the header `pci_ids.h` and then grepping for that is 
> more straight forward.
> 
> I agree, that it breaks the style, and, if you agree, I could try to fix 
> up the whole file.

Arg, please no ! That would need defining a ton of PCI IDs for using
them only here. Let's not do that.

See Sergey and Hannes comment too. Let's keep the current style. Note
that with this change, AMD_HUDSON2_SATA_IDE PCI ID would be used both
here and in drivers/pci/quirks.c, so 2 places. But given that the ID
here is only for the table entry and used nowhere else, using the
numeral is better to preserve the style. So let's drop this patch.

> 
>>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>   	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>>>   	/* AMD is using RAID class only for ahci controllers */
> 
> 
> Kind regards,
> 
> Paul


-- 
Damien Le Moal
Western Digital Research
