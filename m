Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252055DB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiF1JEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiF1JEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:04:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5912628;
        Tue, 28 Jun 2022 02:04:01 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S8rufq022609;
        Tue, 28 Jun 2022 09:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=EJGVXcpSjcj2Rfl0CfzF9RguZzjarCzVFCxQ9X1hCYA=;
 b=hpBIKYse59AYbk67PIxoVLV0X8SH144AOjWgED1Hpa318cMB1MwMfGTRf3oa9M1NizLZ
 C1DpGpSImybohGoVjjgLH+usLZ6sDhFJE1eDTw40VPfZmduESxJTlv1ckLX1sCWqlNCS
 /0SMWMA7MqR7MD8I8EVfPWBC5BHko3oJ43td32WE/epnnpKn7S5b/hzZsOJUHkns0NlG
 h4VLyZ9gv02rxlvX2HjJ1F4jJvrWRuyXj6uYt0kfY/kvoN+gB2F8Qjx79CTh5pg8pzQT
 rPi33MhEo9M6Bf8vye/ovlpq6ylZLcndXdnY/3WXXkVK5zYSZVmA/7J4QC6RaeXWQIXH 2g== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyxhk87we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 09:04:00 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25S8nxWt017280;
        Tue, 28 Jun 2022 09:03:59 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3gwt09c4y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 09:03:59 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25S93xOq37945742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 09:03:59 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B22124052;
        Tue, 28 Jun 2022 09:03:59 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F282F124053;
        Tue, 28 Jun 2022 09:03:56 +0000 (GMT)
Received: from [9.43.77.224] (unknown [9.43.77.224])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 09:03:56 +0000 (GMT)
Message-ID: <3c38b723-40e6-ded9-5a3b-7b442a3f65d8@linux.vnet.ibm.com>
Date:   Tue, 28 Jun 2022 14:33:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux-next] [[5.19.0-rc4-next-20220627] WARNING during reboot to
 linux-next kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _pt95T9ALtjXM3taInJZXnEO77dkQKhw
X-Proofpoint-GUID: _pt95T9ALtjXM3taInJZXnEO77dkQKhw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_09,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=738
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux-next] [[5.19.0-rc4-next-20220627] WARNING during reboot to 
linux-next kernel

--- Call Traces ---
[    1.788574] ------------[ cut here ]------------
[    1.788577] alg: self-tests for rsa-generic (rsa) failed (rc=-22)
[    1.788586] WARNING: CPU: 9 PID: 218 at crypto/testmgr.c:5774 
alg_test+0x438/0x880
[    1.788598] Modules linked in:
[    1.788603] CPU: 9 PID: 218 Comm: cryptomgr_test Not tainted 
5.19.0-rc4-next-20220627-autotest #1
[    1.788609] NIP:  c00000000062e078 LR: c00000000062e074 CTR: 
c00000000075e020
[    1.788614] REGS: c00000000e733980 TRAP: 0700   Not tainted 
(5.19.0-rc4-next-20220627-autotest)
[    1.788620] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
28008822  XER: 20040005
[    1.788632] CFAR: c00000000014f244 IRQMASK: 0
[    1.788632] GPR00: c00000000062e074 c00000000e733c20 c000000002a12000 
0000000000000035
[    1.788632] GPR04: 00000000ffff7fff c00000000e7339e0 c00000000e7339d8 
0000000000000000
[    1.788632] GPR08: c000000002826b78 0000000000000000 c000000002566a50 
c0000000028e6bb8
[    1.788632] GPR12: 0000000000008000 c00000000fff3280 c00000000018b6d8 
c00000000d640080
[    1.788632] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    1.788632] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    1.788632] GPR24: c000000000da49e8 0000000000000000 c000000050630480 
0000000000000400
[    1.788632] GPR28: c000000050630400 000000000000000d c000000002cd33d8 
ffffffffffffffea
[    1.788691] NIP [c00000000062e078] alg_test+0x438/0x880
[    1.788696] LR [c00000000062e074] alg_test+0x434/0x880
[    1.788701] Call Trace:
[    1.788704] [c00000000e733c20] [c00000000062e074] 
alg_test+0x434/0x880 (unreliable)
[    1.788712] [c00000000e733d90] [c00000000062c040] 
cryptomgr_test+0x40/0x70
[    1.788718] [c00000000e733dc0] [c00000000018b7f4] kthread+0x124/0x130
[    1.788726] [c00000000e733e10] [c00000000000ce54] 
ret_from_kernel_thread+0x5c/0x64
[    1.788733] Instruction dump:
[    1.788736] 409e02e4 3d22002c 892913fd 2f890000 409e02d4 3c62fe63 
7f45d378 7f84e378
[    1.788746] 7fe6fb78 3863fa90 4bb2116d 60000000 <0fe00000> fa2100f8 
fa410100 fa610108
[    1.788757] ---[ end trace 0000000000000000 ]---
-- 


Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
