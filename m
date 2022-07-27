Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF135820FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiG0HW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiG0HW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:22:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E98402EC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:22:56 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R61Zsm008067;
        Wed, 27 Jul 2022 07:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=Y5n80P9wmHCJwMqQdwnyVve0bgknGeP9i3Q1IHTk8QY=;
 b=gsVJaiaj2Pvj95MS8bRN5MOzOLWHNvBMHFb2upfuI8qmMpfY/lgcysdyQ7rZsSMWEN72
 nUkOHe2ypnAMKXJ8swzsT6ydewT/bDTJk0qffqCdNmDC5hHYDxJ9wwcfQ3wkOhDfZaZX
 PuhEhnL+AnHjAtOBd1Mw8FsU5hMQdN66bmvXObn7uJhLSmR/nBL3IJCxde8Cj1/ikcQt
 pPwpvGWwwEPPwNKO65yz/zfyORry6OhAGf6EQ5bkiy+2EKd5X6QbjhnGCIfnk8Fcp5Uo
 gLPz2E4DIOZL6Q+Sk59Mb4v1RJsage9p5XV4uTa3HG1CfRMtNlwL0c/tLDyTh+mNP2W+ Sw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjyqxt56k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 07:22:55 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26R7KGd3027121;
        Wed, 27 Jul 2022 07:22:54 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 3hg94vqq99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 07:22:54 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26R7MrhV33161716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 07:22:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B496BE05B;
        Wed, 27 Jul 2022 07:22:53 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E644BE054;
        Wed, 27 Jul 2022 07:22:51 +0000 (GMT)
Received: from [9.43.111.89] (unknown [9.43.111.89])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 07:22:50 +0000 (GMT)
Message-ID: <94b935e1-5b5a-1da5-a24d-2906802bf802@linux.vnet.ibm.com>
Date:   Wed, 27 Jul 2022 12:52:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: Build Failure "kernel/watchdog.o"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y5ybXNK6EJrEjM6GQL3WAzrSlGT9zgSs
X-Proofpoint-ORIG-GUID: Y5ybXNK6EJrEjM6GQL3WAzrSlGT9zgSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=850 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Build Failure seen on linux-next with below error

--- Traces ---
make -j 33 -s && make modules && make modules_install && make install
kernel/watchdog.c:597:20: error: static declaration of 
'lockup_detector_reconfigure' follows non-static declaration
  static inline void lockup_detector_reconfigure(void)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from kernel/watchdog.c:17:
./include/linux/nmi.h:125:6: note: previous declaration of 
'lockup_detector_reconfigure' was here
  void lockup_detector_reconfigure(void);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:250: kernel/watchdog.o] Error 1
make: *** [Makefile:2005: kernel] Error 2
make: *** Waiting for unfinished jobs....


Failure is seen in Build 26-07-2022
Build 19-07-2022 was good

Git bisect points to following commit id
Commit id : 058affafc65a74cf54499fb578b66ad0b18f939b




-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
