Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350E4C39BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiBXXiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiBXXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:38:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED90A1688D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:37:31 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OKrf6M014174;
        Thu, 24 Feb 2022 23:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+4vthZ7Pmyfi2hSy5nAEFgWUJnl6DLwx6sQ3Stcr49w=;
 b=HKOvMJEf60QJCefIfB8i87ih5GMgdVLndZ5kSI4Y76tELxXFt9uwN6AgXIfoWfUuCIC0
 L7mRSZxBYarqNBft9lZHfCh4rdodCFyElCjRziuGDUthswx7UR2ZA1U5GaWFxwzriQKQ
 51sfPGL1tRHrrDrA5jQTpv9513aClb1QyplWdvf6pbPw0iqKJaYX+zg/RTEntslbAIKy
 8xjEx5lBI+5Vid9BK+PMlxiB/VSMI8gzVIpyfRtRuAZ1Q4ulXi+VFabf7VYridQ/K0UG
 NOSzl2POxjzpimY7SHHD17qkMnLGhMNcE+N4Hvw6uravuWI9+jPq+VWORLA9R0dnAtSx Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edw3ce2yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 23:37:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21ONPoMi030642;
        Thu, 24 Feb 2022 23:37:25 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edw3ce2xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 23:37:24 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21ONRBfs005272;
        Thu, 24 Feb 2022 23:37:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3ear69k0vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 23:37:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21ONbKT018678088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 23:37:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A855204E;
        Thu, 24 Feb 2022 23:37:20 +0000 (GMT)
Received: from [9.43.82.21] (unknown [9.43.82.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E563F5204F;
        Thu, 24 Feb 2022 23:37:16 +0000 (GMT)
Message-ID: <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
Date:   Fri, 25 Feb 2022 05:07:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
 <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
 <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
In-Reply-To: <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9hzKxExDbYTpXwNE4mN7A5wsFDJgCAMJ
X-Proofpoint-GUID: I3XXsI_SUImIYOZW-Ys2InNS1YMVbHjL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_06,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/02/22 05:35, Dave Hansen wrote:
> On 2/23/22 15:02, Abhishek Goel wrote:
>> If needed, I will provide experiment results and traces that were used
>> to conclude this.
> It would be great if you can provide some more info.  Even just a CPU
> time profile would be helpful.

Average total time taken for SMT=8 to SMT=1 in v5.14 : 20s

Average total time taken for SMT=8 to SMT=1 in v5.15 : 36s

(Observed in system with 150+ CPUs )

>
> It would also be great to understand more about what "hotplug on power
> systems" actually means.  Is this a synthetic benchmark, or are actual
> end-users running into this issue?  Are entire nodes of CPUs going
> offline?  Or is this just doing an offline/online of CPU 22 in a 100-CPU
> NUMA node?
No, this is not a synthetic benchmark. This can be recreated with
entire nodes of CPUs going offline. And the online/offline operations
have been performed by simple scripts. The time observed can also be
verified (for individual CPU or the entire system) by observing CPU-
Hotplug trace which provide consistent result as observed by using
the scripts.
