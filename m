Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F735699D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiGGFbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:31:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E943134A;
        Wed,  6 Jul 2022 22:31:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2675RHEq027963;
        Thu, 7 Jul 2022 05:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JahQI0wCVfTKzSS0T0XiXQw2qvRF9QGjCY1nJJFl4jc=;
 b=ru9n4cpowQfkTMW3feGOO7rrlP31Wqk+hcC8Tyoroe7ez4SsgNs0csDyeK5q1Gjutwqj
 tOuiwaxjT6iScsplRE/VTE+qWTLHVCt04YPRLgAewKg24A7q14qWijUUhQIP65KtUpf/
 Is9BqBflmo4zPp43oESs2/sfyyUTs8cg/6VuyFJLWMpzVckmVKF5pVuDPj2Xj1rBubrc
 Su4e/Y+AjiTW7oixZKTfcQGtsfMD/9eiMyPRZwd7ni4/XZ1JEXQiNSme4mwwTVZKiWjt
 0y8vBzpALFkqmApbYb3tVvHNStH0pGN3J8biGQnPHHsPt5zVSFRF/iOxF5qDxc4qu24d sA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5sbug1pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 05:31:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2675M4V3004211;
        Thu, 7 Jul 2022 05:31:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3h4usd229n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 05:31:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2675VIZ422610420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 05:31:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103884C044;
        Thu,  7 Jul 2022 05:31:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84FF44C040;
        Thu,  7 Jul 2022 05:31:15 +0000 (GMT)
Received: from [9.43.98.185] (unknown [9.43.98.185])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 05:31:15 +0000 (GMT)
Message-ID: <474e1842-03bb-6621-f1f3-4dba74be41f1@linux.ibm.com>
Date:   Thu, 7 Jul 2022 11:01:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/12] docs: ABI: sysfs-bus-nvdimm
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Madhavan Srinivasan <maddy@in.ibm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1656759988.git.mchehab@kernel.org>
 <38a59ea8cc8581a3009d269c9f1cd4cf07b347dc.1656759989.git.mchehab@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <38a59ea8cc8581a3009d269c9f1cd4cf07b347dc.1656759989.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KF_vX-_4Sv3kGHA3aSGvUYcmWlQNdRu8
X-Proofpoint-GUID: KF_vX-_4Sv3kGHA3aSGvUYcmWlQNdRu8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_03,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/22 16:37, Mauro Carvalho Chehab wrote:
> Add blank lines, as this is required by code-block markup syntax.
> 
> Fix this warning:
> 	Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 

Patch looks fine to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
> 
>  Documentation/ABI/testing/sysfs-bus-nvdimm | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> index 1c1f5acbf53d..eeabba807e4b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -18,9 +18,11 @@ Description:	(RO) Attribute group to describe the magic bits
>  		Each attribute under this group defines a bit range of the
>  		perf_event_attr.config. Supported attribute is listed
>  		below::
> +
>  		  event  = "config:0-4"  - event ID
>  
>  		For example::
> +
>  			ctl_res_cnt = "event=0x1"
>  
>  What:           /sys/bus/event_source/devices/nmemX/events
