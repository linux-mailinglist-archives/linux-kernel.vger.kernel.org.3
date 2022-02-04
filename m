Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B264A91AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356253AbiBDAgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:36:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47701 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiBDAgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643935011; x=1675471011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IgOaehzpMwGZOHMTzP6PU6HT3L/5YLrwGCMkdqJSnBs=;
  b=IuK80RGRLCuP7g7gClD2yHWdB7VN1Gydrw2/Rp4OiVAs1grT990Hphg/
   ZNqsgkHmYmeRK2g+sJ+y99FV0jHHUnW4ma3Oe4IvAn+lH8LzV9V28zk0c
   0JlXTt9rlAu3Cji9gCZOdExN74mWXHRWCEHgctF02MhOEHeeBURCuunBv
   kx3YVyq2Lzcv2coZry52YhgGDM+UlQ7ICoeZkeZUTTy7HOJ906Osn+kFM
   Xv8DzfRjgdc/sPnjPYSQW2fRTlQh3UjUacxraNdcmtc1NJa+c6CSmUcDG
   truA1BWMiYZWWUE8lJvO1gVzFp+3avlvINyGhcc6wgasxpa6Q8d6Y3//8
   g==;
X-IronPort-AV: E=Sophos;i="5.88,340,1635177600"; 
   d="scan'208";a="296215461"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 08:36:50 +0800
IronPort-SDR: 179F7XBoZvkv0MREqfotdyyhTe5x4/hJTQsCrinB+Wu3Y/SvpkXcpONtlKKRkYpumVpdca5ybl
 3g8MWNgdc8THJhBhWeaLJiAlbyExHrLB0WCzrCIkmJfeMr8C7opJBrOyBaqE1c1y+6Ejl2tFRE
 ytjJV5UWSBQTGw8OwRIxVxHxmBlkM0sbl2R4EK/Aiyq9lzA0zZ0bJCXtjWGkkGBwNnbeduvpdL
 rIXdfXsSgYamPPUuaM4H2jMXwTHP9UrS4AnJzbbO8SdZ7exGC0TSGkB7DGqXIOvCSN82NVx2mv
 IYa7nWIcrn/yur0OSEd0FOuZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:08:45 -0800
IronPort-SDR: 6LueybufYVXvamvjw17gkQL05UjNhZmU0xUThO1cHmvU6kLgaLvsSkqtGIju3giJwJn4aZ6b9+
 JraZ3wiVjOVdheA8OMfMz4742ia7ZMLxmjf5o7yM4W4DR03WgZIWOlUtcuRUwh6R9alJXz6ERG
 uij14Ntfq+GUiBUpQL/VpjohqnYG6BiSP9HYhDpHus8o+o5/iKJPV18Adln8YB9GSkvijs11G3
 97DzY5c6H5vC3k7NMJVgQpoB6SIGPSlMSAP25DlTITAxuyAJTIrn+ShZml0TUqtWXXGHTMD77k
 RE4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:36:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jqc6p0q2Rz1SVp3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:36:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643935007; x=1646527008; bh=IgOaehzpMwGZOHMTzP6PU6HT3L/5YLrwGCM
        kdqJSnBs=; b=Dq3sbwIZ339qZL0Fk14sZLjQkAGXdxIzmFyZl6HC2J/sjh3HecH
        7H2jpjRxry5ddQIWrX0ps1ukQD664HJzmWyZx+Dw8JI3MDLQwQqzQ/BFKT2uU196
        WtF7Go5BgfISV6ls10EbtcX1fPlJpFO1vfhTZqyCmI/O77VaCF+I1zx1UystYI7d
        V+czGekGTZNFeBip5ls19j0ylYu34JHDMStA49ui5blQqtYxkj/+NV590clTWvkZ
        ojwcbYB3wpCQkv3uNfeo0IeLq3B5tv89DQVvM4TxKJB1+Lwv43HXI6w0gum5uEp/
        GXmhRy6TflEoRDoqkxRTORdQx3hgF2Fnmzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7t7zznkZS35I for <linux-kernel@vger.kernel.org>;
        Thu,  3 Feb 2022 16:36:47 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jqc6j164Qz1Rwrw;
        Thu,  3 Feb 2022 16:36:44 -0800 (PST)
Message-ID: <f3362c6f-b4b6-2914-0652-d786e19b6b03@opensource.wdc.com>
Date:   Fri, 4 Feb 2022 09:36:43 +0900
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
 <59a198a8-1d87-bc09-d2d8-2d495ed74c16@opensource.wdc.com>
 <098f988e-1f12-c412-3111-60393dfe0f0b@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <098f988e-1f12-c412-3111-60393dfe0f0b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 00:55, John Garry wrote:
> On 03/02/2022 09:44, Damien Le Moal wrote:
>=20
> Hi Damien,
>=20
>>>>> [=C2=A0 385.102073] sas: Enter sas_scsi_recover_host busy: 1 failed=
: 1
>>>>> [=C2=A0 385.108026] sas: sas_scsi_find_task: aborting task 0x000000=
007068ed73
>>>>> [=C2=A0 405.561099] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0=
 757:TMF task
>=20
> Contrary to mentioning TMF in the log, this is not a TMF but rather an=20
> internal abort timing out. I don't think that this should ever happen.=20
> This command should just abort pending IO commands in the controller an=
d=20
> not send anything to the target. So for this to timeout means a HW faul=
t=20
> or driver bug. And I did not touch this code for pm8001.
>=20
>>>>> timeout.
>>>>> [=C2=A0 405.568236] sas: sas_scsi_find_task: task 0x000000007068ed7=
3 is
>>>>> aborted
>>>>> [=C2=A0 405.574930] sas: sas_eh_handle_sas_errors: task 0x000000007=
068ed73 is
>>>>> aborted
>>>>> [=C2=A0 411.192602] ata21.00: qc timeout (cmd 0xec)
>>>>> [=C2=A0 431.672122] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0=
 757:TMF task
>>>>> timeout.
>>>>> [=C2=A0 431.679282] ata21.00: failed to IDENTIFY (I/O error, err_ma=
sk=3D0x4)
>>>>> [=C2=A0 431.685544] ata21.00: revalidation failed (errno=3D-5)
>>>>> [=C2=A0 441.911948] ata21.00: qc timeout (cmd 0xec)
>>>>> [=C2=A0 462.391545] pm80xx0:: pm8001_exec_internal_task_abort=C2=A0=
 757:TMF task
>>>>> timeout.
>>>>> [=C2=A0 462.398696] ata21.00: failed to IDENTIFY (I/O error, err_ma=
sk=3D0x4)
>>>>> [=C2=A0 462.404992] ata21.00: revalidation failed (errno=3D-5)
>>>>> [=C2=A0 492.598769] ata21.00: qc timeout (cmd 0xec)
>>>>> ...
>>>>>
>=20
> Do you have a fuller dmesg with my series?

Here it is below. Conditions: I rebased everything on Linus latest
master, applied your series and the patch you sent below, rebooted with
pm80xx module option logging_level=3D31.

Device scan is all OK. With the system idle, I simply start libzbc tests
on the SATA SMR drive I have on the HBA.

The first command issued is 0x63 =3D=3D NCQ NON DATA and seems to be OK, =
but
it seems that there are inconsistencies. And that may be what breaks the
adapter/driver state because everything after that command miserably
fails and does not complete.

The inconsistency is this line says:
[  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
Which seems to be sensical for NCQ_NON_DATA command, but then, this line
seems wrong:
[  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len =3D 8

I need to go and check the specs what the FIS reply format is for
NCQ_NON_DATA.


[  137.187184] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec devic=
e
[  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
[  137.199339] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
command 0x63 inb 4
[  137.207577] pm80xx0:: pm8001_mpi_msg_consume  1446:: CI=3D46 PI=3D47
msgHeader=3D8104200d
[  137.215399] pm80xx0:: mpi_sata_completion  2481:IO_SUCCESS
[  137.220961] pm80xx0:: mpi_sata_completion  2503:SAS_PROTO_RESPONSE
len =3D 20
[  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len =3D 8
[  137.233878] pm80xx0:: pm8001_mpi_msg_free_set  1403: CI=3D47 PI=3D47
[  137.236696] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec devic=
e
[  137.247102] pm80xx0:: pm80xx_chip_sata_req  4585:DMA
[  137.252186] pm80xx0:: pm80xx_chip_sata_req  4593:FPDMA
[  137.257400] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
command 0x65 inb f
[  167.506280] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[  167.512363] sas: sas_scsi_find_task: aborting task 0x00000000aa372627
[  167.519049] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 2, abor=
t
task tag =3D 0x1
[  187.969173] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
timeout.
[  187.976450] sas: sas_scsi_find_task: task 0x00000000aa372627 is aborte=
d
[  187.983244] sas: sas_eh_handle_sas_errors: task 0x00000000aa372627 is
aborted
[  188.144734] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec devic=
e
[  188.151555] pm80xx0:: pm80xx_chip_sata_req  4588:PIO
[  188.156648] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
command 0xec inb 8
[  193.600813] ata21.00: qc timeout (cmd 0xec)
[  193.605976] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 4, abor=
t
task tag =3D 0x3
[  214.080236] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
timeout.
[  214.087563] ata21.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[  214.093929] ata21.00: revalidation failed (errno=3D-5)
[  214.256233] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec devic=
e
[  214.263043] pm80xx0:: pm80xx_chip_sata_req  4588:PIO
[  214.268128] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
command 0xec inb 8
[  224.319899] ata21.00: qc timeout (cmd 0xec)
[  224.324317] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 6, abor=
t
task tag =3D 0x5
[  244.799433] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
timeout.
[  244.806750] ata21.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[  244.813110] ata21.00: revalidation failed (errno=3D-5)
[  244.975500] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec devic=
e
[  244.982314] pm80xx0:: pm80xx_chip_sata_req  4588:PIO
[  244.987400] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
command 0xec inb 8
[  275.006814] ata21.00: qc timeout (cmd 0xec)
[  275.011236] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag =3D 8, abor=
t
task tag =3D 0x7
[  295.486387] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
timeout.
[  295.494025] ata21.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[  295.500390] ata21.00: revalidation failed (errno=3D-5)
[  295.509179] ata21.00: disable device
[  295.670556] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1
tries: 1
[  295.670570] sd 19:0:2:0: [sdj] REPORT ZONES start lba 0 failed
[  295.689972] sd 19:0:2:0: [sdj] REPORT ZONES: Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_OK
[  295.700621] sd 19:0:2:0: [sdj] Sense Key : Not Ready [current]
[  295.708975] sd 19:0:2:0: [sdj] Add. Sense: Logical unit not ready,
hard reset required
[  295.719331] sd 19:0:2:0: [sdj] 0 4096-byte logical blocks: (0 B/0 B)
[  295.728727] sd 19:0:2:0: [sdj] Write Protect is on
[  295.737928] sdj: detected capacity change from 39063650304 to 0
[  295.826347] sd 19:0:2:0: [sdj] tag#158 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  295.838761] sd 19:0:2:0: [sdj] tag#158 CDB: Test Unit Ready 00 00 00
00 00 00
[  295.920864] sd 19:0:2:0: [sdj] tag#780 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  295.933341] sd 19:0:2:0: [sdj] tag#780 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.010417] sd 19:0:2:0: [sdj] tag#248 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.022275] sd 19:0:2:0: [sdj] tag#248 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.101348] sd 19:0:2:0: [sdj] tag#949 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.113924] sd 19:0:2:0: [sdj] tag#949 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.192258] sd 19:0:2:0: [sdj] tag#25 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.204788] sd 19:0:2:0: [sdj] tag#25 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.284546] sd 19:0:2:0: [sdj] tag#273 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.297126] sd 19:0:2:0: [sdj] tag#273 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.376896] sd 19:0:2:0: [sdj] tag#653 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.389475] sd 19:0:2:0: [sdj] tag#653 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.468095] sd 19:0:2:0: [sdj] tag#159 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.479974] sd 19:0:2:0: [sdj] tag#159 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.560861] sd 19:0:2:0: [sdj] tag#274 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.572792] sd 19:0:2:0: [sdj] tag#274 CDB: Test Unit Ready 00 00 00
00 00 00
[  296.654506] sd 19:0:2:0: [sdj] tag#727 FAILED Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK cmd_age=3D0s
[  296.667151] sd 19:0:2:0: [sdj] tag#727 CDB: Test Unit Ready 00 00 00
00 00 00

After these messages, the tests exit on failure (drive dropped) and
there are no more messages. Doing rmmod or anything else get stuck too.
I have to reset the machine to get back to a good state.

I am starting to think that NCQ NON DATA command is being very badly
handled... Switching the tests to run with all non-NCQ commands is
working fine, albeit horribly slow (much slower than with other HBAs,
e.g. Broadcom).

Digging...

>=20
> ...
>=20
>>> }
>>> - res =3D -TMF_RESP_FUNC_FAILED;
>>> + res =3D TMF_RESP_FUNC_FAILED;
>>>
>>> That's effectively the same as what I have in this series in
>>> sas_execute_tmf().
>>>
>>> However your testing is a SATA device, which I'll check further.
>> This did not help. Still seeing 100% reproducible hangs.
>=20
> OK, but I think that we should also have this change as the mainline=20
> codes looks broken to be begin with:
>=20
> --->8 ---
>=20
> [PATCH] scsi: libsas: Handle all errors in sas_scsi_find_task()
>=20
> LLDD TMFs callbacks may return linux or other error codes instead of TM=
F
> codes. This may cause problems in sas_scsi_find_task() ->
> .lldd_query_task(), as only TMF codes are handled there. As such, we ma=
y
> not return a task_disposition type. Function sas_eh_handle_sas_errors()=
=20
> only handles that type, and may exit error
> handling early for unrecognised types.
>=20
> So use TASK_ABORT_FAILED for non-TMF types returned from
> .lldd_query_task(), on the assumption that the command may still be=20
> alive and error handling should be escalated.
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>
>=20
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c=20
> b/drivers/scsi/libsas/sas_scsi_host.c
> index 53d8b7ede0cd..02274f471308 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -316,8 +316,11 @@ static enum task_disposition=20
> sas_scsi_find_task(struct sas_task *task)
>   				pr_notice("%s: task 0x%p failed to abort\n",
>   					  __func__, task);
>   				return TASK_ABORT_FAILED;
> +			default:
> +				pr_notice("%s: task 0x%p result code %d not handled, assuming=20
> failed\n",
> +					  __func__, task, res);
> +				return TASK_ABORT_FAILED;
>   			}
> -
>   		}
>   	}
>   	return res;
>=20
> ---8< ----
>=20
>>
>> I did a lot of testing/digging today,=20
>=20
> Thanks for the effort!
>=20
>  > and the hang cause seems to be
>  > missing task completions.
>> At random, a task times out as its completion
>=20
> That sounds fimilar to my general issue running this driver on an arm64=
=20
> host...
>=20
>> does not come, and subsequent abort trial for the task fail, revalidat=
e
>> fails
>=20
> I assume SMP IOs fail if revalidation fails - if this is the case, then=
=20
> the controller seems to be in bad state.
>=20
>> and the device is dropped (capacity goes to 0). But at that point,
>> doing rmmod/modprobe to reset the device does not work. sync cache
>> command issued at rmmod time never completes. I end up needing to powe=
r
>> cycle the machine every time...
>>
>> No clue about the root cause yet, but it definitely seem to be related
>> to NCQ/high QD operation. If I force my tests to use non-NCQ commands,
>> everything is fine and the tests run to completion without any issue.
>>
>> I wonder if their is a tag management bug somewhere...
>=20
> Maybe. Not sure.
>=20
> On a related point, Hannes' change here could avoid it:
>=20
> https://lore.kernel.org/linux-scsi/20210222132405.91369-32-hare@suse.de=
/
>=20
>>
>> I did stumble on something very ugly in libsas too: sas_ata_qc_issue()
>> drops and retake the ata port lock. No other ATA driver do that since
>> the ata completion also take that lock. The ata port lock is taken
>> before ata_qc_issue() is called with IRQ disabled (spin_lock_irqsave()=
).
>> So doing a spin_unlock()/spin_lock() in sas_ata_qc_issue() (called fro=
m
>> ata_qc_issue()) seems like a very bad idea. I removed that and
>> everything work the same way (the lld execute does not sleep). But tha=
t
>> did not solve the hang problem.
>=20
> I would need to check why this is done again. Before my time...
>=20
>>
>> Of note is this is all with your libsas patches applied. Without the
>> patches, I have KASAN screaming at me about use-after-free in completi=
on
>> context. With your patches, KASAN is silent.
>>
>> Another thing: this driver does not allow changing the max qd... Very
>> annoying.
>>
>> echo 1 > /sys/block/sdX/device/queue_depth
>>
>> has no effect. QD stays at 32 for an ATA drive. Need to look into that=
 too.
>=20
> I had a look at this. It seems that we fail in=20
> __ata_change_queue_depth() -> ata_scsi_find_dev() returning NULL.
>=20
> Thanks again for your effort, I will continue to look.
>=20
> john


--=20
Damien Le Moal
Western Digital Research
