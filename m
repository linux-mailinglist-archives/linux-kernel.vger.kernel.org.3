Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2834A81A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbiBCJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:44:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33449 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBCJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643881487; x=1675417487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0MsgAbh4rKd/AIf146X9JE/f/GdvqrG2XuzNyTCdjlY=;
  b=lo3O6DKo/SVvyozn+B6c00xrSyoamuez/5+oDmhMkcvrtzP+1KEYOJSj
   Uj5mXixfVkftuc9kbZlc+2l5trpTd7J1Z8m740pLuk/bmjLVk7yBKgAMy
   HlcNMdvuDMdHnfBP6Lb079pxpeBmozXMLIqFffKx4nKEYWSLmnrAjFPsV
   RQ+lDe2+TD+HEViRJew16hhnabh5vqO+zo88C/g12rQza77sOEwEQgdI2
   M2p0PBnUhordvFbmFrhymMUD2hqcuEVpEJrwl1XnJnc+2pRVXX3nTqavg
   k2lOFi3ERyFxG8IpViy6Z0yQYt4vLlnXL7W+IoZhScDsRdng7exojV5VO
   A==;
X-IronPort-AV: E=Sophos;i="5.88,339,1635177600"; 
   d="scan'208";a="303965963"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 17:44:40 +0800
IronPort-SDR: CExQKmUdABFGVWKth02cObBXpQcjHjhi7BcUCB8Yz7bqXuwjF7yJdiRl0ua1sUqUlSsWjbOsV0
 L1NjaBbGnACk1TGERnfyM7AFaKu+pHm1ZA8GpdxmmzSj6MgzAhImWoaqdDWGDnnyZg9nF413y+
 t/fhaYwGK8PU169qdjf17GvS2d/8o/kHijGNOnFl4PlhccPHO3cNT1sX6jy92OTPZIjcxVJ49y
 +lXRup6veFVMMWYlyQYtvameQAjpdRsa4xqecEXAaVkIqYS0WnRbTcphlPJpAyh94lzJJ5eWGV
 JUYcugmc0nUvwB9jIEoqcq3F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 01:16:35 -0800
IronPort-SDR: ndWnUG6Ej/l9zZtyb74MaZjj1erxcc0ncaXG6AI4aXajxdH8jj95be7ctKGUDJhORw1nGxZ60E
 Lva5lBGSNQCk3yuK0Yc8xW0v2b6Enxh1b0k5B1TzqE5wv6DR2lrWUVsgN+4f0MDPbeiuwM1cQt
 rOt39h4b4vILM79eeBsSRNGT+W6wt/eZv59i2/b9Ap7lGBghvnERXfaVO+NUU+eZM8rhjYUGhG
 oUAqVqmfgcYB6wMnEfxXuulsGW4enqtiE9yag3z2HVWjk7mK8KWk2ZfFK3prWsboDGRH8uyWPF
 TAw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 01:44:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqDKL2v5kz1SVp4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:44:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643881477; x=1646473478; bh=0MsgAbh4rKd/AIf146X9JE/f/GdvqrG2Xuz
        NyTCdjlY=; b=KjeOCQ3pxKjRqFH2gcgCuVolPqLaUgQ4kN+pR/wcJu4dLeBEfZx
        zbjNWPVbgSWDAj3NShyvcEMBpqHR0R9m328b4mPN+NAM24aFvnzl1wLEVzaYK0iQ
        ZPotoS4w5S1/p+qFaFnYDv6OC6fs4hp2MkgqnQDDldB7Jya1JgmRdInmd7ufaHPn
        qHK26RLiA1mamuE20a1Vo93j5Hb6BiNY6QOIdDP5rMC4yv9CNP93s0XGLvP2BJer
        wCUH5I6qpK0F6DJRGT5DkLZwi1xVT9lyW9xZfTykSXPfJvhRo/wo5nECBNFwyzq5
        AvcbHZlX8gGz8ypFQs0Cywdd8fbJutuLhvA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NwQKi-0iWTEu for <linux-kernel@vger.kernel.org>;
        Thu,  3 Feb 2022 01:44:37 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqDKG6bG9z1Rwrw;
        Thu,  3 Feb 2022 01:44:34 -0800 (PST)
Message-ID: <59a198a8-1d87-bc09-d2d8-2d495ed74c16@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 18:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com,
        Ajish.Koshy@microchip.com
Cc:     yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
 <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
 <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
 <a2de1656-b1ec-2fb7-caab-657e27dacb48@huawei.com>
 <49da4d80-5cc3-35c3-ccaa-6def8165eb65@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <49da4d80-5cc3-35c3-ccaa-6def8165eb65@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 00:58, John Garry wrote:
> On 28/01/2022 09:09, John Garry wrote:
>>> I ran some more tests. In particular, I ran libzbc compliance tests o=
n a
>>> 20TB SMR drives. All tests pass with 5.17-rc1, but after applying you=
r
>>> series, I see command timeout that take forever to recover from, with
>>> the drive revalidation failing after that.
>>>
>>> [=C2=A0 385.102073] sas: Enter sas_scsi_recover_host busy: 1 failed: =
1
>>> [=C2=A0 385.108026] sas: sas_scsi_find_task: aborting task 0x00000000=
7068ed73
>>> [=C2=A0 405.561099] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0 7=
57:TMF task
>>> timeout.
>>> [=C2=A0 405.568236] sas: sas_scsi_find_task: task 0x000000007068ed73 =
is=20
>>> aborted
>>> [=C2=A0 405.574930] sas: sas_eh_handle_sas_errors: task 0x00000000706=
8ed73 is
>>> aborted
>>> [=C2=A0 411.192602] ata21.00: qc timeout (cmd 0xec)
>>> [=C2=A0 431.672122] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0 7=
57:TMF task
>>> timeout.
>>> [=C2=A0 431.679282] ata21.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
>>> [=C2=A0 431.685544] ata21.00: revalidation failed (errno=3D-5)
>>> [=C2=A0 441.911948] ata21.00: qc timeout (cmd 0xec)
>>> [=C2=A0 462.391545] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0 7=
57:TMF task
>>> timeout.
>>> [=C2=A0 462.398696] ata21.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
>>> [=C2=A0 462.404992] ata21.00: revalidation failed (errno=3D-5)
>>> [=C2=A0 492.598769] ata21.00: qc timeout (cmd 0xec)
>>> ...
>>>
>>> So there is a problem. Need to dig into this. I see this issue only w=
ith
>>> libzbc passthrough tests. fio runs with libaio are fine.
>>
>> Thanks for the notice. I think that I also saw a hang, but, IIRC, it=20
>> happened on mainline for me - but it's hard to know if I broke somethi=
ng=20
>> if it is already broke in another way. That is why I wanted this card=20
>> working properly...
>=20
> Hi Damien,
>=20
>  From testing mainline, I can see a hang on my arm64 system for SAS=20
> disks. I think that the reason is the we don't finish some commands in=20
> EH properly for pm8001:
> - In EH, we attempt to abort the task in sas_scsi_find_task() ->=20
> lldd_abort_task()
> The default return from pm8001_exec_internal_tmf_task() is=20
> -TMF_RESP_FUNC_FAILED, so if the TMF does not execute properly we retur=
n=20
> this value
> - sas_scsi_find_task() cannot handle -TMF_RESP_FUNC_FAILED, and returns=
=20
> -TMF_RESP_FUNC_FAILED directly to sas_eh_handle_sas_errors(), which,=20
> again, does not handle -TMF_RESP_FUNC_FAILED. So we don't progress to=20
> ever finish the comand.
>=20
> This looks like the correct fix for mainline:
>=20
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -766,7 +766,7 @@ static int pm8001_exec_internal_tmf_task(struct=20
> domain_device *dev,
> pm8001_dev, DS_OPERATIONAL);
> wait_for_completion(&completion_setstate);
> }
> - res =3D -TMF_RESP_FUNC_FAILED;
> + res =3D TMF_RESP_FUNC_FAILED;
>=20
> That's effectively the same as what I have in this series in=20
> sas_execute_tmf().
>=20
> However your testing is a SATA device, which I'll check further.

This did not help. Still seeing 100% reproducible hangs.

I did a lot of testing/digging today, and the hang cause seems to be
missing task completions. At random, a task times out as its completion
does not come, and subsequent abort trial for the task fail, revalidate
fails and the device is dropped (capacity goes to 0). But at that point,
doing rmmod/modprobe to reset the device does not work. sync cache
command issued at rmmod time never completes. I end up needing to power
cycle the machine every time...

No clue about the root cause yet, but it definitely seem to be related
to NCQ/high QD operation. If I force my tests to use non-NCQ commands,
everything is fine and the tests run to completion without any issue.

I wonder if their is a tag management bug somewhere...

I did stumble on something very ugly in libsas too: sas_ata_qc_issue()
drops and retake the ata port lock. No other ATA driver do that since
the ata completion also take that lock. The ata port lock is taken
before ata_qc_issue() is called with IRQ disabled (spin_lock_irqsave()).
So doing a spin_unlock()/spin_lock() in sas_ata_qc_issue() (called from
ata_qc_issue()) seems like a very bad idea. I removed that and
everything work the same way (the lld execute does not sleep). But that
did not solve the hang problem.

Of note is this is all with your libsas patches applied. Without the
patches, I have KASAN screaming at me about use-after-free in completion
context. With your patches, KASAN is silent.

Another thing: this driver does not allow changing the max qd... Very
annoying.

echo 1 > /sys/block/sdX/device/queue_depth

has no effect. QD stays at 32 for an ATA drive. Need to look into that to=
o.


--=20
Damien Le Moal
Western Digital Research
