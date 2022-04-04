Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438534F108E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiDDINR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377932AbiDDIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:12:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2E2FFDC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:10:57 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2345SN60030809;
        Mon, 4 Apr 2022 08:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=tAKXQfMvRCEEIiiVSojR/R8R8Ht2XcOJOM3wBqpNUEc=;
 b=Czk3k9UW6HBSWYUbb3JnMa8ho39iJgQ32ONPKsSQ5WfueOp6uFzs29GLrX8SY8TKXuBS
 o/AB9atB++ssUjjzg0sJP17/M5DG4WkonXjZVAwiBaMDrsrIYMBc5yZF1kURzRqTkFbb
 wQgHpCCurTH6s4TmM2xCelQ0dWQQ2cxJKacqgRs/kYkcPjyf6C4RKiloAr/+T4WnoCIr
 QBJ8gDAXnOe7FpmgRz6e00nHeOe8WbbM5N7IqisZxirs/5j98YVQ5cFkxidLOZ/ECXhZ
 +CmBEJC7dhqTwQTtcgZni5pgPRC0OvuaQR/pOV14esy2A8G7CIRIcTR4TDsQB/0nmALw dA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f7035urnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 08:10:49 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234890Ts022378;
        Mon, 4 Apr 2022 08:10:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3f6e48nxjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 08:10:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2348AlpY41812432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 08:10:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81B03B2068;
        Mon,  4 Apr 2022 08:10:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E37AB2071;
        Mon,  4 Apr 2022 08:10:44 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.46.85])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Apr 2022 08:10:44 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:fastexp.2022.04.01a] BUILD REGRESSION
 d9f3e7d671416fdf5b61f094765754269b652db0
In-Reply-To: <20220402161148.GK4285@paulmck-ThinkPad-P17-Gen-1>
References: <62486f05.ithFB6YqfjaeQiXK%lkp@intel.com>
 <20220402161148.GK4285@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 04 Apr 2022 13:40:41 +0530
Message-ID: <87fsmtmfpa.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1crnnamSpFLVdQFy6S4GzguIrqtWVT4s
X-Proofpoint-GUID: 1crnnamSpFLVdQFy6S4GzguIrqtWVT4s
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_02,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=663 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1011 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Sat, Apr 02, 2022 at 11:43:01PM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fastexp.2022.04.01a
>> branch HEAD: d9f3e7d671416fdf5b61f094765754269b652db0  EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
>> 
>> Error/Warning reports:
>> 
>> https://lore.kernel.org/lkml/202204021454.WDwBbwVL-lkp@intel.com
>> 
>> Error/Warning: (recently discovered and may have been fixed)
>> 
>> arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void
>
> Adding Aneesh on CC.  My kneejerk reaction would be to add a
> "return 0" to this function, but there might be a reason why it
> looks like this:

yes, that should work. Do you want me to send a patch for this? Or will
it get folded with other changes?

>
> 	/*
> 	 * This should never get called
> 	 */
> 	static inline int get_hugepd_cache_index(int index)
> 	{
> 		BUG();
> 	}
>
> Working on the other problem with RCU's Kconfig options.
>

-aneesh
