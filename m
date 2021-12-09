Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C888C46F6FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhLIWmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:42:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4852 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhLIWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639089499; x=1670625499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LDsNc/Oq686fzO2A+NwuQ7HfDlYyjkmcFgkOqIWKXJY=;
  b=Bt5erKAb4vkF54mt5+EnZ93pb8PZ1FHr3FApaacA2WfJ5GeeWIt5lFIg
   RwiXDAe/Yw6nADvQ5tqCuuE9mwZIYKvmlahMq65CVBFC33zHeYh48tUms
   vfmnFcNOpXfiXRdR0fn9lUcwRcMhG9tmC3TdPBPSUuztTlxqmcqweHz80
   6524hkrPJ0Jj/WMniMhI6mzC1ZaMpzGQWqFS9fbNGn+7iTgKgdMUuzrmt
   nzO5xYhkxvwgZLzc9ED2yV7L0n6YbEJaanI5+wVV8HRh9vfNuvB1QXHG6
   y29n0ospr7tey5JLfFWFN1xMi3rWFQ/dv1TSjSaI648amDwD2Dlrgk9Kv
   g==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="192666804"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:38:19 +0800
IronPort-SDR: 4A+C7jh9kGH40bDw0SLAK/DjNYtGJdmXVtO+ILEqDONcM5NljyBF/fPHHNI+/mR2wA+MijrGYS
 YaDI+RpaDTcpk6oYsZcRQWDrCVKu5KENyNY1djKJq8mbzjlDf9b9aCnNuuaHGIJevCn3X0hTWw
 CRLouROHoT4H8qi0ir3SV/LuHI4KUyQo78WFr2AenpMWNlHUvd7C5LWLvCxbsWxOZbbwbJsxHv
 31X+RSvUOxJR7T5j6AVB1dm8oizL/Xz5dYPdtXnUKqSvphyuuWM7s9rJxjLeBIogMk+04njydG
 Opkrd5hLcFUZbARrmPG7u9uI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:11:22 -0800
IronPort-SDR: mK5lVb4i+1LnFU/tibxRa8CiGkkvlbULlkI2ImIYFjKNP18MLNu/+ArZilHujLoAzbt9Ld8Ve4
 /AKdJqo0mF7Ig8Ip1CNkVNFQr/4SPeNMYrmoJaTjzkyiqkjUFdTovz2lZRts+VeUMCimlLK0qw
 YbOIOnpwS5nyKV3DWI3Sr+CK8lFWLyl/Hx5IH47TVcdQEReldArJYS4uGYrWre61KiRHWRxrMA
 /56TsW9hqXZR59xr0sNShudT3vvwLKP2OJnsfihzVv6ROsY2515uMJN0tIf6a/TeT5RHmoDvu2
 bc8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:38:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J987v6bGVz1RvTh
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:38:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639089499; x=1641681500; bh=LDsNc/Oq686fzO2A+NwuQ7HfDlYyjkmcFgk
        OqIWKXJY=; b=COmcHiy2VTRFcGJY0BZWDRknFb7cPPcZRTzw8jHhwU2yjk+saPv
        Eaxjd5lHdYfL3Gbg4jcE+F+QIyk+iJEhHvr9a6rtYGOcVsD2MFLQJAKyljuo8NkM
        DiKcv+CX6KpKpxg8NW3IK6rjoeK0TnWB/ce3QprE97YO5IF7NuTBqqD8g9/Bo8un
        doX1Am9/afmMKKlLzq1HFY7OuN8aKIkJaBILM7XQtqkpP4mhnVbs7R5s0trQtwOi
        w+wp3abQkZdfwdPR9G5UJLRW43ds8dM0z7u8mOpUHj+gsyUZO6lsn7Xr1i9YAXJR
        mN+hkrKekCcSQzAv9RZlB8RioZS9Tz5XERw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id epUBFLfa-MaN for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 14:38:19 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J987s43GBz1RtVG;
        Thu,  9 Dec 2021 14:38:17 -0800 (PST)
Message-ID: <6ed96184-6291-ad37-0241-00a5389293e6@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:38:16 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <f41d2bed-f320-1b70-7d63-fe77caa2534d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/09 21:19, John Garry wrote:
> On 09/12/2021 12:04, Ajish.Koshy@microchip.com wrote:
>> Was testing the patch on arm server. Didn't see crash there but observing timeouts and error
>> handling getting triggered for drives. But the same code works fine on x86.
>>
>> At your end do you still face similar situation on arm server ?
> 
> Yeah, I see that as well even without enabling the IOMMU.
> 
> root@(none)$ [  163.974907] sas: Enter sas_scsi_recover_host busy: 222 
> failed: 222
> [  163.981108] sas: sas_scsi_find_task: aborting task 0x000000005c703676
> root@(none)$
> root@(none)$ [  185.963714] pm80xx0:: pm8001_exec_internal_tmf_task 
> 757:TMF task[1]timeout.
> 
> I figured that it was a card FW issue as I have been using what I got 
> out the box, and I have no tool to update the firmware on an arm host.
> 
> It seems that SSP and STP commands are not completing for some reason, 
> from the "busy: 222" line.

I have this HBA:

c1:00.0 Serial Attached SCSI controller: ATTO Technology, Inc. ExpressSAS 12Gb/s
SAS/SATA HBA (rev 06)
	Subsystem: ATTO Technology, Inc. ExpressSAS H120F

Which uses the pm80xx driver and I do not see such error. E.g.:

[335568.262395] pm80xx 0000:c1:00.0: pm80xx: driver version 0.1.40
[335568.268931] :: pm8001_pci_alloc  529:Setting link rate to default value
[335569.489392] scsi host18: pm80xx
[335570.801031] sas: phy-18:4 added to port-18:0, phy_mask:0x10 (50010860002f5644)
[335570.801225] sas: DOING DISCOVERY on port 0, pid:58830
[335570.801310] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[335570.807638] sas: ata22: end_device-18:0: dev error handler
[335570.964864] ata22.00: ATA-11: WDC  WUH721818ALN604, PCGNW232, max UDMA/133
[335579.062526] ata22.00: 4394582016 sectors, multi 0: LBA48 NCQ (depth 32)
[335579.070487] ata22.00: Features: NCQ-sndrcv NCQ-prio
[335579.307260] ata22.00: configured for UDMA/133
[335579.313018] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[335579.323512] scsi 18:0:0:0: Direct-Access     ATA      WDC  WUH721818AL W232
PQ: 0 ANSI: 5
[335579.333243] sas: DONE DISCOVERY on port 0, pid:58830, result:0
[335579.333338] sas: phy-18:5 added to port-18:1, phy_mask:0x20 (50010860002f5645)
[335579.333453] sas: DOING DISCOVERY on port 1, pid:58830
[335579.333596] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[335579.341596] sas: ata23: end_device-18:1: dev error handler
[335579.341640] sas: ata22: end_device-18:0: dev error handler
[335579.500374] ata23.00: ATA-11: WDC  WUH721818ALN604, PCGNWTW2, max UDMA/133
[335588.427115] ata23.00: 4394582016 sectors, multi 0: LBA48 NCQ (depth 32)
[335588.435158] ata23.00: Features: NCQ-sndrcv NCQ-prio
[335588.513212] ata23.00: configured for UDMA/133
[335588.519027] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[335588.537683] scsi 18:0:1:0: Direct-Access     ATA      WDC  WUH721818AL WTW2
PQ: 0 ANSI: 5
[335588.565288] sas: DONE DISCOVERY on port 1, pid:58830, result:0
[335588.565543] sas: phy-18:7 added to port-18:2, phy_mask:0x80 (50010860002f5647)
[335588.566917] sas: DOING DISCOVERY on port 2, pid:58830
[335588.567515] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[335588.574948] sas: ata22: end_device-18:0: dev error handler
[335588.574971] sas: ata23: end_device-18:1: dev error handler
[335588.574979] sas: ata24: end_device-18:2: dev error handler
[335588.732190] ata24.00: ATA-11: WDC  WSH722020ALN604, PCGMW803, max UDMA/133
[335597.778187] ata24.00: 4882956288 sectors, multi 0: LBA48 NCQ (depth 32)
[335597.788081] ata24.00: Features: NCQ-sndrcv NCQ-prio
[335597.850404] ata24.00: configured for UDMA/133
[335597.856225] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[335597.866680] scsi 18:0:2:0: Direct-Access-ZBC ATA      WDC  WSH722020AL W803
PQ: 0 ANSI: 7
[335597.876485] sas: DONE DISCOVERY on port 2, pid:58830, result:0
[335597.879720] sd 18:0:0:0: [sdd] 4394582016 4096-byte logical blocks: (18.0
TB/16.4 TiB)
[335597.881483] sd 18:0:0:0: Attached scsi generic sg3 type 0
[335597.888827] sd 18:0:0:0: [sdd] Write Protect is off
[335597.888830] sd 18:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[335597.888839] sd 18:0:0:0: [sdd] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[335597.968683] sd 18:0:1:0: [sde] 4394582016 4096-byte logical blocks: (18.0
TB/16.4 TiB)
[335597.969489] sd 18:0:1:0: Attached scsi generic sg4 type 0
[335597.978210] sd 18:0:1:0: [sde] Write Protect is off
[335597.978214] sd 18:0:1:0: [sde] Mode Sense: 00 3a 00 00
[335597.978228] sd 18:0:1:0: [sde] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[335598.053869] sd 18:0:2:0: [sdf] Host-managed zoned block device
[335598.054476] sd 18:0:2:0: Attached scsi generic sg5 type 20
[335598.066428] sd 18:0:2:0: [sdf] 4882956288 4096-byte logical blocks: (20.0
TB/18.2 TiB)
[335598.093762] sd 18:0:2:0: [sdf] Write Protect is off
[335598.100101] sd 18:0:2:0: [sdf] Mode Sense: 00 3a 00 00
[335598.100119] sd 18:0:2:0: [sdf] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[335598.158832] sd 18:0:1:0: [sde] Attached SCSI disk
[335598.158870] sd 18:0:0:0: [sdd] Attached SCSI disk
[335600.015402] sd 18:0:2:0: [sdf] 74508 zones of 65536 logical blocks
[335600.099235] sd 18:0:2:0: [sdf] Attached SCSI disk

The driver is uselessly verbose (for some reasons, the dbg messages show up),
but no errors.

-- 
Damien Le Moal
Western Digital Research
