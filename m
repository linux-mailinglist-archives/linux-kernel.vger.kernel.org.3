Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45558A62D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiHEGyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHEGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:54:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34013DD5;
        Thu,  4 Aug 2022 23:54:39 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2756rcck014233;
        Fri, 5 Aug 2022 06:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=o7EH4RQLAIooUJTB9Rlg4lNS9aCgm/N/S08H5TczU1c=;
 b=iDcKBGsFTIrnEdi/21icvPh3heE/gKoGifznHIgmQxA50JYXhNEdVK1mbNVMxoybhrlH
 ZepqzOa0tP/6gHS7CwBLFCqVCXgVW0Imm7KY9DrVJiyYnMbpIDobTO2PhijO1YvGWRWw
 V1XfG6Ez2nX7FWTc5HFdkwtJEkOzx7TqxbzBzRFVlgR4/kOAgQfQ6ax17PNxF3gYope8
 M7iutWRQUavGexqmoSOMiNBI7+NHqHndqkBBIBDPlSDAWH/nmna8gQZJQcIs8XsDbDce
 rr7kJkTxYqwtPTXgsXnEH+Xq31NMEBtrvxSYmXfjVI+m5XRLL7zeSDMDzypAFpgiHsVX aA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrxbbg0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Aug 2022 06:54:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2756oDtr008846;
        Fri, 5 Aug 2022 06:54:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 3hmv9a3v3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Aug 2022 06:54:37 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2756saMh19268036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Aug 2022 06:54:36 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B37713604F;
        Fri,  5 Aug 2022 06:54:36 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE7C136051;
        Fri,  5 Aug 2022 06:54:33 +0000 (GMT)
Received: from [9.43.35.188] (unknown [9.43.35.188])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Aug 2022 06:54:33 +0000 (GMT)
Message-ID: <4c93ce0b-8e04-1f03-e4ce-7c763719169c@linux.vnet.ibm.com>
Date:   Fri, 5 Aug 2022 12:24:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux] [5.19.0] task hung for indefinite time with call traces when
 rebooted with Kexec
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BwV1JcNg4ik_Au_6u_1Iz1RkedK3lXDD
X-Proofpoint-GUID: BwV1JcNg4ik_Au_6u_1Iz1RkedK3lXDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_01,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux] [5.19.0] task hung for indefinite time with call traces when 
rebooted with Kexec, A restart is required to recover the machine.

--- Call Traces ---
          Starting Reboot via kexec...

[  909.964343] printk: systemd-shutdow: 38 output lines suppressed due 
to ratelimiting
[  909.967021] systemd-shutdown[1]: Syncing filesystems and block devices.
[  909.969192] systemd-shutdown[1]: Sending SIGTERM to remaining 
processes...
[  910.003729] systemd-shutdown[1]: Sending SIGKILL to remaining 
processes...
[  910.007053] systemd-shutdown[1]: Unmounting file systems.
[  910.007458] [228226]: Remounting '/' read-only in with options 
'stripe=8'.
[  910.090154] EXT4-fs (dm-5): re-mounted. Quota mode: none.
[  910.096694] systemd-shutdown[1]: All filesystems unmounted.
[  910.096697] systemd-shutdown[1]: Deactivating swaps.
[  910.096714] systemd-shutdown[1]: All swaps deactivated.
[  910.096716] systemd-shutdown[1]: Detaching loop devices.
[  910.096784] systemd-shutdown[1]: All loop devices detached.
[  910.096786] systemd-shutdown[1]: Detaching DM devices.
[  910.422063] printk: shutdown: 18 output lines suppressed due to 
ratelimiting
dracut Warning: Killing all remaining processes
[  910.439917] dracut Warning: Killing all remaining processes
[  911.783936] EXT4-fs (dm-5): unmounting filesystem.
[  911.784387] dracut Warning: Unmounted /oldroot.
Aug 05 00:11:54 | /etc/multipath.conf line 3, duplicate keyword: 
find_multipaths
[  911.816135] dracut: Disassembling device-mapper devices
[  911.936046] sd 2:2:0:0: [sdd] Synchronizing SCSI cache
[  911.939345] sd 1:2:0:0: [sdc] Synchronizing SCSI cache
[  911.944498] Removing IBM Power 842 compression device
[ 1104.673127] INFO: task kworker/3:1:221 blocked for more than 122 seconds.
[ 1104.673145]       Not tainted 5.19.0-rc1-autotest #1
[ 1104.673148] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1104.673153] task:kworker/3:1     state:D stack:    0 pid:  221 ppid: 
     2 flags:0x00000800
[ 1104.673160] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1104.673170] Call Trace:
[ 1104.673173] [c0000000060eb860] [0000000000000004] 0x4 (unreliable)
[ 1104.673178] [c0000000060eba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1104.673185] [c0000000060ebab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1104.673190] [c0000000060ebb80] [c000000000d244e8] schedule+0x68/0x130
[ 1104.673196] [c0000000060ebbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1104.673201] [c0000000060ebc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1104.673208] [c0000000060ebc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1104.673212] [c0000000060ebd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1104.673216] [c0000000060ebdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1104.673220] [c0000000060ebe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[ 1104.673225] INFO: task kworker/3:0:227332 blocked for more than 122 
seconds.
[ 1104.673228]       Not tainted 5.19.0-rc1-autotest #1
[ 1104.673230] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1104.673233] task:kworker/3:0     state:D stack:    0 pid:227332 ppid: 
     2 flags:0x00000880
[ 1104.673237] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1104.673243] Call Trace:
[ 1104.673244] [c0000000726bb860] [c0000000001b9cb4] 
enqueue_entity+0x184/0x4f0 (unreliable)
[ 1104.673250] [c0000000726bba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1104.673254] [c0000000726bbab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1104.673258] [c0000000726bbb80] [c000000000d244e8] schedule+0x68/0x130
[ 1104.673262] [c0000000726bbbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1104.673265] [c0000000726bbc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1104.673271] [c0000000726bbc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1104.673275] [c0000000726bbd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1104.673279] [c0000000726bbdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1104.673283] [c0000000726bbe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[ 1104.673288] INFO: task kexec:228289 blocked for more than 122 seconds.
[ 1104.673290]       Not tainted 5.19.0-rc1-autotest #1
[ 1104.673292] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1104.673295] task:kexec           state:D stack:    0 pid:228289 ppid: 
     1 flags:0x00040080
[ 1104.673299] Call Trace:
[ 1104.673301] [c000000069147510] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1104.673305] [c000000069147570] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1104.673309] [c000000069147640] [c000000000d244e8] schedule+0x68/0x130
[ 1104.673313] [c000000069147670] [c000000000d2e028] 
schedule_timeout+0x348/0x3f0
[ 1104.673317] [c000000069147750] [c000000000d2554c] 
wait_for_completion+0xcc/0x2b0
[ 1104.673321] [c0000000691477d0] [c00000000017cbe8] 
flush_workqueue+0x158/0x520
[ 1104.673325] [c000000069147870] [c00000000017d068] 
drain_workqueue+0xb8/0x240
[ 1104.673329] [c000000069147930] [c0000000001825e0] 
destroy_workqueue+0x60/0x420
[ 1104.673333] [c0000000691479c0] [c0080000009291e4] 
fc_remove_host+0x21c/0x280 [scsi_transport_fc]
[ 1104.673339] [c000000069147a30] [c0080000009b869c] 
ibmvfc_remove+0xf4/0x3a0 [ibmvfc]
[ 1104.673345] [c000000069147ae0] [c00000000011114c] 
vio_bus_remove+0x5c/0xd0
[ 1104.673349] [c000000069147b20] [c000000000866ba0] 
device_shutdown+0x230/0x3c0
[ 1104.673353] [c000000069147bc0] [c000000000190c94] 
kernel_restart_prepare+0x54/0x70
[ 1104.673357] [c000000069147be0] [c00000000026d6c4] kernel_kexec+0xa4/0xf0
[ 1104.673362] [c000000069147c50] [c0000000001912f4] 
__do_sys_reboot+0x2b4/0x310
[ 1104.673366] [c000000069147db0] [c0000000000333fc] 
system_call_exception+0x18c/0x390
[ 1104.673370] [c000000069147e10] [c00000000000c63c] 
system_call_common+0xec/0x250
[ 1104.673375] --- interrupt: c00 at 0x7fff894f5ad4
[ 1104.673377] NIP:  00007fff894f5ad4 LR: 000000012c17469c CTR: 
0000000000000000
[ 1104.673380] REGS: c000000069147e80 TRAP: 0c00   Not tainted 
(5.19.0-rc1-autotest)
[ 1104.673383] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 
28022242  XER: 00000000
[ 1104.673392] IRQMASK: 0
[ 1104.673392] GPR00: 0000000000000058 00007fffd50e1f20 00007fff895e7100 
fffffffffee1dead
[ 1104.673392] GPR04: 0000000028121969 0000000045584543 00007fffd50e1e85 
0000000000000009
[ 1104.673392] GPR08: 0000000000000003 0000000000000000 0000000000000000 
0000000000000000
[ 1104.673392] GPR12: 0000000000000000 00007fff8972b650 ffffffffffffffff 
0000000000000002
[ 1104.673392] GPR16: 0000000000000000 00007fffd50e1fc8 0000000000000000 
0000000000000000
[ 1104.673392] GPR20: 0000000000000001 0000000000000000 0000000000000002 
0000000000000000
[ 1104.673392] GPR24: 0000000000000001 0000000000000001 0000000000000000 
0000000000000000
[ 1104.673392] GPR28: 000000012c1922e8 000000012c1be7d0 00007fffd50e2578 
0000000000000002
[ 1104.673429] NIP [00007fff894f5ad4] 0x7fff894f5ad4
[ 1104.673431] LR [000000012c17469c] 0x12c17469c
[ 1104.673433] --- interrupt: c00
[ 1227.553154] INFO: task kworker/3:1:221 blocked for more than 245 seconds.
[ 1227.553161]       Not tainted 5.19.0-rc1-autotest #1
[ 1227.553163] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1227.553166] task:kworker/3:1     state:D stack:    0 pid:  221 ppid: 
     2 flags:0x00000800
[ 1227.553172] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1227.553180] Call Trace:
[ 1227.553182] [c0000000060eb860] [0000000000000004] 0x4 (unreliable)
[ 1227.553187] [c0000000060eba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1227.553192] [c0000000060ebab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1227.553197] [c0000000060ebb80] [c000000000d244e8] schedule+0x68/0x130
[ 1227.553202] [c0000000060ebbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1227.553206] [c0000000060ebc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1227.553213] [c0000000060ebc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1227.553218] [c0000000060ebd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1227.553221] [c0000000060ebdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1227.553226] [c0000000060ebe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[ 1227.553232] INFO: task kworker/3:0:227332 blocked for more than 245 
seconds.
[ 1227.553235]       Not tainted 5.19.0-rc1-autotest #1
[ 1227.553237] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1227.553240] task:kworker/3:0     state:D stack:    0 pid:227332 ppid: 
     2 flags:0x00000880
[ 1227.553245] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1227.553251] Call Trace:
[ 1227.553252] [c0000000726bb860] [c0000000001b9cb4] 
enqueue_entity+0x184/0x4f0 (unreliable)
[ 1227.553257] [c0000000726bba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1227.553261] [c0000000726bbab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1227.553266] [c0000000726bbb80] [c000000000d244e8] schedule+0x68/0x130
[ 1227.553271] [c0000000726bbbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1227.553276] [c0000000726bbc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1227.553283] [c0000000726bbc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1227.553286] [c0000000726bbd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1227.553290] [c0000000726bbdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1227.553294] [c0000000726bbe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[ 1227.553299] INFO: task kexec:228289 blocked for more than 245 seconds.
[ 1227.553301]       Not tainted 5.19.0-rc1-autotest #1
[ 1227.553304] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1227.553306] task:kexec           state:D stack:    0 pid:228289 ppid: 
     1 flags:0x00040080
[ 1227.553310] Call Trace:
[ 1227.553311] [c000000069147510] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1227.553315] [c000000069147570] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1227.553320] [c000000069147640] [c000000000d244e8] schedule+0x68/0x130
[ 1227.553323] [c000000069147670] [c000000000d2e028] 
schedule_timeout+0x348/0x3f0
[ 1227.553328] [c000000069147750] [c000000000d2554c] 
wait_for_completion+0xcc/0x2b0
[ 1227.553332] [c0000000691477d0] [c00000000017cbe8] 
flush_workqueue+0x158/0x520
[ 1227.553336] [c000000069147870] [c00000000017d068] 
drain_workqueue+0xb8/0x240
[ 1227.553340] [c000000069147930] [c0000000001825e0] 
destroy_workqueue+0x60/0x420
[ 1227.553344] [c0000000691479c0] [c0080000009291e4] 
fc_remove_host+0x21c/0x280 [scsi_transport_fc]
[ 1227.553350] [c000000069147a30] [c0080000009b869c] 
ibmvfc_remove+0xf4/0x3a0 [ibmvfc]
[ 1227.553355] [c000000069147ae0] [c00000000011114c] 
vio_bus_remove+0x5c/0xd0
[ 1227.553359] [c000000069147b20] [c000000000866ba0] 
device_shutdown+0x230/0x3c0
[ 1227.553364] [c000000069147bc0] [c000000000190c94] 
kernel_restart_prepare+0x54/0x70
[ 1227.553368] [c000000069147be0] [c00000000026d6c4] kernel_kexec+0xa4/0xf0
[ 1227.553372] [c000000069147c50] [c0000000001912f4] 
__do_sys_reboot+0x2b4/0x310
[ 1227.553376] [c000000069147db0] [c0000000000333fc] 
system_call_exception+0x18c/0x390
[ 1227.553380] [c000000069147e10] [c00000000000c63c] 
system_call_common+0xec/0x250
[ 1227.553385] --- interrupt: c00 at 0x7fff894f5ad4
[ 1227.553387] NIP:  00007fff894f5ad4 LR: 000000012c17469c CTR: 
0000000000000000
[ 1227.553390] REGS: c000000069147e80 TRAP: 0c00   Not tainted 
(5.19.0-rc1-autotest)
[ 1227.553393] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 
28022242  XER: 00000000
[ 1227.553401] IRQMASK: 0
[ 1227.553401] GPR00: 0000000000000058 00007fffd50e1f20 00007fff895e7100 
fffffffffee1dead
[ 1227.553401] GPR04: 0000000028121969 0000000045584543 00007fffd50e1e85 
0000000000000009
[ 1227.553401] GPR08: 0000000000000003 0000000000000000 0000000000000000 
0000000000000000
[ 1227.553401] GPR12: 0000000000000000 00007fff8972b650 ffffffffffffffff 
0000000000000002
[ 1227.553401] GPR16: 0000000000000000 00007fffd50e1fc8 0000000000000000 
0000000000000000
[ 1227.553401] GPR20: 0000000000000001 0000000000000000 0000000000000002 
0000000000000000
[ 1227.553401] GPR24: 0000000000000001 0000000000000001 0000000000000000 
0000000000000000
[ 1227.553401] GPR28: 000000012c1922e8 000000012c1be7d0 00007fffd50e2578 
0000000000000002
[ 1227.553437] NIP [00007fff894f5ad4] 0x7fff894f5ad4
[ 1227.553440] LR [000000012c17469c] 0x12c17469c
[ 1227.553442] --- interrupt: c00
[ 1350.433108] INFO: task kworker/3:1:221 blocked for more than 368 seconds.
[ 1350.433117]       Not tainted 5.19.0-rc1-autotest #1
[ 1350.433119] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1350.433122] task:kworker/3:1     state:D stack:    0 pid:  221 ppid: 
     2 flags:0x00000800
[ 1350.433126] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1350.433134] Call Trace:
[ 1350.433135] [c0000000060eb860] [0000000000000004] 0x4 (unreliable)
[ 1350.433139] [c0000000060eba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1350.433144] [c0000000060ebab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1350.433148] [c0000000060ebb80] [c000000000d244e8] schedule+0x68/0x130
[ 1350.433152] [c0000000060ebbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1350.433156] [c0000000060ebc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1350.433162] [c0000000060ebc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1350.433166] [c0000000060ebd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1350.433170] [c0000000060ebdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1350.433174] [c0000000060ebe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[ 1350.433180] INFO: task kworker/3:0:227332 blocked for more than 368 
seconds.
[ 1350.433183]       Not tainted 5.19.0-rc1-autotest #1
[ 1350.433186] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1350.433188] task:kworker/3:0     state:D stack:    0 pid:227332 ppid: 
     2 flags:0x00000880
[ 1350.433192] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1350.433197] Call Trace:
[ 1350.433199] [c0000000726bb860] [c0000000001b9cb4] 
enqueue_entity+0x184/0x4f0 (unreliable)
[ 1350.433204] [c0000000726bba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1350.433208] [c0000000726bbab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1350.433212] [c0000000726bbb80] [c000000000d244e8] schedule+0x68/0x130
[ 1350.433216] [c0000000726bbbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1350.433220] [c0000000726bbc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1350.433226] [c0000000726bbc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1350.433230] [c0000000726bbd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1350.433233] [c0000000726bbdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1350.433237] [c0000000726bbe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[ 1350.433243] INFO: task kexec:228289 blocked for more than 368 seconds.
[ 1350.433246]       Not tainted 5.19.0-rc1-autotest #1
[ 1350.433248] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1350.433250] task:kexec           state:D stack:    0 pid:228289 ppid: 
     1 flags:0x00040080
[ 1350.433254] Call Trace:
[ 1350.433256] [c000000069147510] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1350.433260] [c000000069147570] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1350.433264] [c000000069147640] [c000000000d244e8] schedule+0x68/0x130
[ 1350.433268] [c000000069147670] [c000000000d2e028] 
schedule_timeout+0x348/0x3f0
[ 1350.433272] [c000000069147750] [c000000000d2554c] 
wait_for_completion+0xcc/0x2b0
[ 1350.433277] [c0000000691477d0] [c00000000017cbe8] 
flush_workqueue+0x158/0x520
[ 1350.433280] [c000000069147870] [c00000000017d068] 
drain_workqueue+0xb8/0x240
[ 1350.433284] [c000000069147930] [c0000000001825e0] 
destroy_workqueue+0x60/0x420
[ 1350.433288] [c0000000691479c0] [c0080000009291e4] 
fc_remove_host+0x21c/0x280 [scsi_transport_fc]
[ 1350.433294] [c000000069147a30] [c0080000009b869c] 
ibmvfc_remove+0xf4/0x3a0 [ibmvfc]
[ 1350.433300] [c000000069147ae0] [c00000000011114c] 
vio_bus_remove+0x5c/0xd0
[ 1350.433304] [c000000069147b20] [c000000000866ba0] 
device_shutdown+0x230/0x3c0
[ 1350.433308] [c000000069147bc0] [c000000000190c94] 
kernel_restart_prepare+0x54/0x70
[ 1350.433312] [c000000069147be0] [c00000000026d6c4] kernel_kexec+0xa4/0xf0
[ 1350.433317] [c000000069147c50] [c0000000001912f4] 
__do_sys_reboot+0x2b4/0x310
[ 1350.433321] [c000000069147db0] [c0000000000333fc] 
system_call_exception+0x18c/0x390
[ 1350.433325] [c000000069147e10] [c00000000000c63c] 
system_call_common+0xec/0x250
[ 1350.433330] --- interrupt: c00 at 0x7fff894f5ad4
[ 1350.433332] NIP:  00007fff894f5ad4 LR: 000000012c17469c CTR: 
0000000000000000
[ 1350.433335] REGS: c000000069147e80 TRAP: 0c00   Not tainted 
(5.19.0-rc1-autotest)
[ 1350.433338] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 
28022242  XER: 00000000
[ 1350.433347] IRQMASK: 0
[ 1350.433347] GPR00: 0000000000000058 00007fffd50e1f20 00007fff895e7100 
fffffffffee1dead
[ 1350.433347] GPR04: 0000000028121969 0000000045584543 00007fffd50e1e85 
0000000000000009
[ 1350.433347] GPR08: 0000000000000003 0000000000000000 0000000000000000 
0000000000000000
[ 1350.433347] GPR12: 0000000000000000 00007fff8972b650 ffffffffffffffff 
0000000000000002
[ 1350.433347] GPR16: 0000000000000000 00007fffd50e1fc8 0000000000000000 
0000000000000000
[ 1350.433347] GPR20: 0000000000000001 0000000000000000 0000000000000002 
0000000000000000
[ 1350.433347] GPR24: 0000000000000001 0000000000000001 0000000000000000 
0000000000000000
[ 1350.433347] GPR28: 000000012c1922e8 000000012c1be7d0 00007fffd50e2578 
0000000000000002
[ 1350.433383] NIP [00007fff894f5ad4] 0x7fff894f5ad4
[ 1350.433385] LR [000000012c17469c] 0x12c17469c
[ 1350.433388] --- interrupt: c00
[ 1473.313106] INFO: task kworker/3:1:221 blocked for more than 491 seconds.
[ 1473.313117]       Not tainted 5.19.0-rc1-autotest #1
[ 1473.313120] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1473.313124] task:kworker/3:1     state:D stack:    0 pid:  221 ppid: 
     2 flags:0x00000800
[ 1473.313129] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
[ 1473.313138] Call Trace:
[ 1473.313140] [c0000000060eb860] [0000000000000004] 0x4 (unreliable)
[ 1473.313145] [c0000000060eba50] [c00000000001e378] __switch_to+0x288/0x4a0
[ 1473.313152] [c0000000060ebab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
[ 1473.313158] [c0000000060ebb80] [c000000000d244e8] schedule+0x68/0x130
[ 1473.313162] [c0000000060ebbb0] [c0000000008d4574] 
scsi_remove_target+0x314/0x390
[ 1473.313167] [c0000000060ebc40] [c008000000926460] 
fc_rport_final_delete+0xc8/0x250 [scsi_transport_fc]
[ 1473.313173] [c0000000060ebc90] [c00000000017ef58] 
process_one_work+0x288/0x560
[ 1473.313177] [c0000000060ebd30] [c00000000017f2a8] 
worker_thread+0x78/0x620
[ 1473.313180] [c0000000060ebdc0] [c00000000018b9b4] kthread+0x124/0x130
[ 1473.313185] [c0000000060ebe10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64


-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
