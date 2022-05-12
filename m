Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81B524F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354904AbiELOBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354964AbiELOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:01:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0972655238
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:01:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CC1wn2004224;
        Thu, 12 May 2022 14:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PZKeUa51MnK6JBOqFyls3O7ght9z6gRfDZMSkyjlB54=;
 b=BXRgERzMIxLm/scsT3BPr0w/UG1SxHJPDqG50kbAvqSAXBWbX2p7KoSS2kZemsg/fWCK
 /EYxrJGAsgGo8X1NYMBNpRwvh8+OtiPeLC3X049bqc3l7ZencIQwxwqFWIdGb6sV8u5B
 S/L7EwmuDkOpHZ0TKZa+ZI1UQs3dRQ7NlvMjyhjMFZdc7xdPopfENlh+tcC9Efy4qXbL
 boCeBfq9IbosNGQuQZ0FgnRbbFidbj2pAuTRBT4VNBnRzoDJjXwAvO2O2pTS0HXWEOno
 hIeBKwa3W9+QRQqGF2TievLb7nQNeVijoQaNW5wWq3B/baoxuWt2IiajNzZ1PZMDjibO Ig== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g11vr313y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 14:01:36 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CDwSM0029524;
        Thu, 12 May 2022 14:01:36 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3fwgdacfvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 14:01:35 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CE1YnN30278062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 14:01:34 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D069DC605F;
        Thu, 12 May 2022 14:01:34 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADD80C6059;
        Thu, 12 May 2022 14:01:34 +0000 (GMT)
Received: from [9.211.56.168] (unknown [9.211.56.168])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 14:01:34 +0000 (GMT)
Message-ID: <08e04659-2d06-2eb0-0ba8-8717a2d2bd48@linux.ibm.com>
Date:   Thu, 12 May 2022 09:01:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: Add config option for default panic_on_oom value
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220511183400.47940-1-eajames@linux.ibm.com>
 <20220511145648.3c421ff592df32766319ea2d@linux-foundation.org>
 <b597cc79-0f8a-c32d-397e-0c04777e9491@linux.ibm.com>
 <20220511153616.9298d246adb1c7fea9ab453b@linux-foundation.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220511153616.9298d246adb1c7fea9ab453b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HzQyKlLHrsOPuOBNQonRFQ1qjIg6Mk27
X-Proofpoint-ORIG-GUID: HzQyKlLHrsOPuOBNQonRFQ1qjIg6Mk27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_10,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 mlxlogscore=927 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205120067
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/22 17:36, Andrew Morton wrote:
> On Wed, 11 May 2022 17:06:35 -0500 Eddie James <eajames@linux.ibm.com> wrote:
>
>> On 5/11/22 16:56, Andrew Morton wrote:
>>> On Wed, 11 May 2022 13:34:00 -0500 Eddie James <eajames@linux.ibm.com> wrote:
>>>
>>>> Add the option to kconfig and set the default panic_on_value.
>>> Why?  What are the use-cases and how does this benefit our users?
>> If a distribution (for example some embedded system distribution) wants
>> the system to always panic when OOM, they may as well configure their
>> kernel to do it by default, rather than writing to
>> /proc/sys/vm/panic_on_oom every boot. Maybe I'm missing another way to
>> do what I want here?
> Presumably such a distribution would do this in initramfs initscripts
> and forget about it.


Yes, my thinking was that it was either a line in an init script or a 
system service. It seems more efficient to configure it in the kernel 
instead.


>
> What inspired the patch?  Have you seen a situation which was best
> solved with this change?


Yes, our distro, OpenBMC, uses systemd, so I thought we'd need a new 
service. However after a little more research, I see now that that the 
existing systemd-sysctl can do what you suggest and set it during early 
boot. So that is probably the right way to go, and this change can be 
dropped.

Thanks for your feedback!

Eddie


>
