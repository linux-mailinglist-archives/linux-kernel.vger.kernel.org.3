Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2B470F56
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbhLKAWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:22:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28211 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbhLKAWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639181957; x=1670717957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1JMi8GF/GdmfDK5lGfdKv4uXnJ+Ek48oE7Kl6zbTBdA=;
  b=e8RpIWfVzhqKUEvfr3oXMEZmtvsKi76QYg1AN88NfE/ZpcvKTFElwRmH
   +0tkWePeaQuM+GnjS/4r3emPlRIACLYfv2Sp5GuTfWpCZ95qHCieTIuc7
   cnIbQWPQMvdIA8Fz/7qhDOkVZ1+hJBMWtLXVx6ZtXYNyzzvQ5Zwe84e0+
   xT16z7UbLNlzj4Cwq23rIrJPKX6YaVfPjIl1sHXF+gmr/acHeT7gPSd3v
   uL5XMAQk0dZVp3UyEfECu5uaPBUj/j6xweC+wl+FQQXQCC1sH9haSzzGP
   pDNlgW/iuNKiatMqY5slLGts/xmkTNL/ZOC3Se45yn/kgyEhdxhcFbajt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,197,1635177600"; 
   d="scan'208";a="299825232"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2021 08:19:17 +0800
IronPort-SDR: ncz5ZETfzS00eU94Nr8sBXgmBvL+DJ6JfSALNlqJRJFjiYc5jFgjvDsmG7tGi4KflLlS/op/pB
 2SA8yCcnFGrmrGP5gE8taKoEd0PhyRJnx2gV6J5zRRINvQUFDFss+M/Ll5+hHOBqjYmiIB7hik
 XIxrXZljM6tfdz0Q/KX/m2Jp//ceV+t/WLfgaA5yiGfOvAUfvd87agCfwB+gL3piR3WA1c+r9d
 FlJoHKNaHDjI+3lxXU7PDoH+P/Vr0k6Q/6ybA6/aWUjuleVUutMof/q0SpsxX3gpgA9q+dO0fq
 9Mp3PemBrQPqW0Avm4jP/QCc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:53:47 -0800
IronPort-SDR: HxGegeeL5WekP2STCTgdeqB81Itc+zjLqOjsgAkkWnRY9QbZ/UFGK0DOIPn8kKwKURqUCxBt/y
 MtfK/fssul+X1AAvjyELIqZ+ROuSLlMsJtqbab/HelIo9SKJDsnJSo5kMG4rM7Y0NSVnd4Ce5q
 4GXq2xn4AIzp4wh05DBJDwxX5zXXqCpHmpOt3jV8QdP3cBJzFeDiXBSIjLuIp90rxh8lBMQHGt
 Xwa7IeboRvoYONXKipsjy6BQpPqyjHSrnsGd36Iu+bVB9rnZpvTjj0sk78rF9IPPQJOLjVK4cM
 R28=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 16:19:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J9pKw50M9z1Rvlf
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:19:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639181955; x=1641773956; bh=1JMi8GF/GdmfDK5lGfdKv4uXnJ+Ek48oE7K
        l6zbTBdA=; b=c2h2XqTFpf5K0TBduGv1sm90JBjjy2CxvJl2JyAk6xGsU8Fpblp
        GBb+S1CNRLyEqFNngLOkqsFetESlUZpG6dnTXYQl1mqfJWPJ0TRNOPFz+gSHybB2
        VbxHtSDbGzTgjPtgr22QJc2qHN2xkDa4uMWTqkeS2aaPD6zHEzsJgLVQ7L0rJG5+
        ko35siN4tI+zeftJXSnEmMY+4Bnuc/XkBeqhrCpRGV0sMF4uahkP7Uqz535fnATZ
        0YDxGjFpFhdBA7VMoyz3QHV9gvR6DTTfAhnvu3UT8XIcytW15Kq0J7vvpiY0fFB/
        KBb+rP0KsGUqetd5I3nw7UI7wjFDK1XadDA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0eG3rqEYEoo8 for <linux-kernel@vger.kernel.org>;
        Fri, 10 Dec 2021 16:19:15 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J9pKs6pPYz1RtVG;
        Fri, 10 Dec 2021 16:19:13 -0800 (PST)
Message-ID: <f0f82067-f9d1-0f22-0202-ed11bf08b48c@opensource.wdc.com>
Date:   Sat, 11 Dec 2021 09:19:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Ajish.Koshy@microchip.com
Cc:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Viswas.G@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas.Cassel@wdc.com, Vasanthalakshmi.Tharmarajan@microchip.com
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
 <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
 <PH0PR11MB51120361EB6F6931CCE023D6EC709@PH0PR11MB5112.namprd11.prod.outlook.com>
 <f41d2bed-f320-1b70-7d63-fe77caa2534d@huawei.com>
 <6ed96184-6291-ad37-0241-00a5389293e6@opensource.wdc.com>
 <24a9ac51-ce60-b883-2284-023c703a7885@huawei.com>
 <5dfd6c4b-dd10-c9b5-7efb-82a11613fdd4@opensource.wdc.com>
 <a4b2bf44-ef21-6cc8-f79f-d0e41c8f037f@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <a4b2bf44-ef21-6cc8-f79f-d0e41c8f037f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/10 19:35, John Garry wrote:
> On 09/12/2021 23:55, Damien Le Moal wrote:
>>> Earlier today it was the mount command which was hanging. From debugging
>>> that, I found that the very first SSP command when mounting is sent the
>>> HW successfully but no completion interrupt ever occurs there - I really
>>> don't know why. Other SSP commands complete successfully before this and
>>> after (TMFs in the error handling), including ones which have sgls.
>>>
>>> sda is a SAS drive, but I think SATA has the same issue - I was just
>>> looking at sda.
>>>
>>> One thing I noticed in the driver is that it uses mb() in between
>>> writing to the DMA memory and initiating the HW - I don't think mb is
>>> strong enough. However I don't think that is my issue - it wouldn't fail
>>> reliably if it was.
>> Weird. 
> 
> Yeah, quite strange.
> 
> I will also note that these earlier logs are also red flags, which I 
> have not investigated:
> 
> [87.288239] sas: target proto 0x0 at 500e004aaaaaaa1f:0x10 not handled
> [87.294793] sas: ex 500e004aaaaaaa1f phy16 failed to discover
> 
>> I do not have an arm host to test. Could it be that the card FW is
>> crashing ?
> 
> But the later TMFs seem to succeed, so I doubt it's crashing. I did 
> wonder if it's going into some low-power/idle mode and just not 
> responding, but not sure on that.
> 
>> Can you recover from the above ? 
> 
> It never really recovers and is always caught up in some error handling.
> 
>> Or do you have to power cycle for
>> the HDD to be accessible again ?
> 
> Power cycle is necessary to recover as we can't remove the driver when 
> it is in error handling
> 
>>
>> Other possibility may be an IRQ controller issue with the platform ?
>>
> 
> Highly unlikely. I did wonder if the interrupts are properly allocated 
> and requested, and they look ok from /proc/interrupts
> 
> I also tried limiting the CPUs we bring up to a single CPU and so that 
> we only use a single MSIx and a single HW queue, and now get this crash:
> 
> [7.775168] loop: module loaded
> [7.783226] pm80xx 0000:04:00.0: Adding to iommu group 0
> [7.795787] pm80xx 0000:04:00.0: pm80xx: driver version 0.1.40
> [7.806789] pm80xx 0000:04:00.0: enabling device (0140 -> 0142)
> [7.818910] :: pm8001_pci_alloc  530:Setting link rate to default value
> [8.866618] scsi host0: pm80xx
> [8.879056] pm80xx0:: process_oq  4169:Firmware Fatal error! Regval:0xc0f

I have an old-ish Adaptec card that throws something similar at me if I connect
a host-managed SMR drive to the HBA. After that message, nothing works at all so
in my case I suspect that the FW gets into a really bad state/crashes.

> [8.885842] pm80xx0:: print_scratchpad_registers 
> 4130:MSGU_SCRATCH_PAD_0: 0x40002000
> [8.893661] pm80xx0:: print_scratchpad_registers 
> 4132:MSGU_SCRATCH_PAD_1:0xc0f
> [8.900958] pm80xx0:: print_scratchpad_registers 
> 4134:MSGU_SCRATCH_PAD_2: 0x0
> [8.908169] pm80xx0:: print_scratchpad_registers 
> 4136:MSGU_SCRATCH_PAD_3: 0x30000000
> [8.915986] pm80xx0:: print_scratchpad_registers 
> 4138:MSGU_HOST_SCRATCH_PAD_0: 0x0
> [8.923630] pm80xx0:: print_scratchpad_registers 
> 4140:MSGU_HOST_SCRATCH_PAD_1: 0x0
> [8.931274] pm80xx0:: print_scratchpad_registers 
> 4142:MSGU_HOST_SCRATCH_PAD_2: 0x0
> [8.938917] pm80xx0:: print_scratchpad_registers 
> 4144:MSGU_HOST_SCRATCH_PAD_3: 0x0
> [8.946561] pm80xx0:: print_scratchpad_registers 
> 4146:MSGU_HOST_SCRATCH_PAD_4: 0x0
> [8.954205] pm80xx0:: print_scratchpad_registers 
> 4148:MSGU_HOST_SCRATCH_PAD_5: 0x0
> [8.961849] pm80xx0:: print_scratchpad_registers 
> 4150:MSGU_RSVD_SCRATCH_PAD_0: 0x0
> [8.969493] pm80xx0:: print_scratchpad_registers 
> 4152:MSGU_RSVD_SCRATCH_PAD_1: 0x0
> [8.977143] Unable to handle kernel NULL pointer dereference at virtual 
> address 0000000000000018

Is this with or without your phys_to_virt() dma/iommu fix patch ?
I do remember seeing lots of crashes/hangs with that old-ish Adaptec HBA on x86
host. I can try again to see if the errors are similar. I definitely hit the
iommu problem with that card as I had to boot with iommu=off to, well, be able
to boot :)

Next time I go to the lab, I will plug this card again to test with your iommu
patch.

> [8.994782] Mem abort info:
> [8.997565]   ESR = 0x96000004
> [9.006782]   EC = 0x25: DABT (current EL), IL = 32 bits
> [9.018781]   SET = 0, FnV = 0
> [9.021824]   EA = 0, S1PTW = 0
> [9.030797]   FSC = 0x04: level 0 translation fault
> [9.038794] Data abort info:
> [9.041662]   ISV = 0, ISS = 0x00000004
> [9.050781]   CM = 0, WnR = 0
> [9.053737] [0000000000000018] user address but active_mm is swapper
> [9.070782] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [9.076343] Modules linked in:
> [9.079387] CPU: 0 PID: 20 Comm: kworker/0:2 Not tainted 
> 5.16.0-rc4-00002-ge23d68774178-dirty #328
> [9.088333] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - 
> V1.16.01 03/15/2019
> [9.096844] Workqueue: pm80xx pm8001_work_fn
> [9.101108] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [9.108057] pc : pm8001_work_fn+0x298/0x690
> [9.112229] lr : process_one_work+0x1d0/0x354
> [9.116574] sp : ffff800012d23d50
> [9.119876] x29: ffff800012d23d50 x28: 0000000000000000 x27: 0000000000000000
> [9.127000] x26: ffff8000117e8bc0 x25: ffff8000113aaeb0 x24: ffff00209d4b0000
> [9.134124] x23: ffff0020ad23b280 x22: ffff00209d4b8000 x21: 0000000000000001
> [9.141249] x20: 0000000000000000 x19: 0000000000000038 x18: 0000000000000000
> [9.148373] x17: 4441505f48435441 x16: 5243535f44565352 x15: 000000052ff6b548
> [9.155496] x14: 0000000000000018 x13: 0000000000000018 x12: 0000000000000000
> [9.162620] x11: 0000000000000014 x10: 00000000000009a0 x9 : ffff002086ef6074
> [9.169743] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff002086ef6074
> [9.176867] x5 : 0000787830386d70 x4 : ffff00209d5e0000 x3 : 0000000000000000
> [9.183990] x2 : ffff00209d5e0038 x1 : ffff800010a20120 x0 : 0000000000000051
> [9.191114] Call trace:
> [9.193547]  pm8001_work_fn+0x298/0x690
> [9.197372]  process_one_work+0x1d0/0x354
> [9.201369]  worker_thread+0x13c/0x470
> [9.205105]  kthread+0x17c/0x190
> [9.208321]  ret_from_fork+0x10/0x20
> [9.211886] Code: 17fffff1 310006bf 54fffde0 f9400c54 (f9400e80)
> [9.217968] ---[ end trace de649a9be2843866 ]---
> [9.339812] pm80xx0:: process_oq  4169:Firmware Fatal error! Regval:0xc0f
> [9.346602] pm80xx0:: print_scratchpad_registers 
> 4130:MSGU_SCRATCH_PAD_0: 0x40002000
> [9.354420] pm80xx0:: print_scratchpad_registers 
> 4132:MSGU_SCRATCH_PAD_1:0xc0f
> [9.361717] pm80xx0:: print_scratchpad_registers 
> 4134:MSGU_SCRATCH_PAD_2: 0x0
> [9.368927] pm80xx0:: print_scratchpad_registers 
> 4136:MSGU_SCRATCH_PAD_3: 0x30000000
> [9.376744] pm80xx0:: print_scratchpad_registers 
> 4138:MSGU_HOST_SCRATCH_PAD_0: 0x0
> [9.384388] pm80xx0:: print_scratchpad_registers 
> 4140:MSGU_HOST_SCRATCH_PAD_1: 0x0
> [9.392032] pm80xx0:: print_scratchpad_registers 
> 4142:MSGU_HOST_SCRATCH_PAD_2: 0x0
> [9.399676] pm80xx0:: print_scratchpad_registers 
> 4144:MSGU_HOST_SCRATCH_PAD_3: 0x0
> [9.407319] pm80xx0:: print_scratchpad_registers 
> 4146:MSGU_HOST_SCRATCH_PAD_4: 0x0
> [9.414963] pm80xx0:: print_scratchpad_registers 
> 4148:MSGU_HOST_SCRATCH_PAD_5: 0x0
> [9.422607] pm80xx0:: print_scratchpad_registers 
> 4150:MSGU_RSVD_SCRATCH_PAD_0: 0x0
> [9.430251] pm80xx0:: print_scratchpad_registers 
> 4152:MSGU_RSVD_SCRATCH_PAD_1: 0x0
> [   10.028906] Freeing initrd memory: 413456K
> 
> ...
> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
