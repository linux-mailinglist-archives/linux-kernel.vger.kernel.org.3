Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BE524005
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348652AbiEKWG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348638AbiEKWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:06:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543722BE4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:06:39 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BL116o015344;
        Wed, 11 May 2022 22:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OYvPMHDsbfxK5YIkv3uFo+MDF++6OacX1ZBizwrPWvk=;
 b=HFKund16gLQJkkHrBuZdWVzrThdpF85YwU3802iUPiiAYo5DX7avHJLx1+piAJcsoQu4
 Ktz4E6WkuEWzUNBMCw9SoApFOUULsYCSvs14E+C3/A/g4lnVOqlLzs//0W8PelwK4NBN
 xct8hnCyLTHSilihwghR+sq+mDHyAZ17nhU45jHMAY9wtAVnO3wMUMZQtpdEVIaG2xhA
 /VjTSnCUfYED6bOzolNmwfYcFidHr8pqt/IkH9UZQ7rKFb2Gm8MqTrUG5mKUombqsvsi
 GBE8yKbBWjG8hmYbQFioyZBWTWIgRT/QjLQxXRPDZAneASGY9BPUuEHVTEo4QwlQGLBK RA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0meh1c22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 22:06:37 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BM3EXe017322;
        Wed, 11 May 2022 22:06:36 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3fwgd9y692-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 22:06:36 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BM6Zq827394478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 22:06:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5C5B78067;
        Wed, 11 May 2022 22:06:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8CA77805E;
        Wed, 11 May 2022 22:06:35 +0000 (GMT)
Received: from [9.211.61.211] (unknown [9.211.61.211])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 22:06:35 +0000 (GMT)
Message-ID: <b597cc79-0f8a-c32d-397e-0c04777e9491@linux.ibm.com>
Date:   Wed, 11 May 2022 17:06:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: Add config option for default panic_on_oom value
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220511183400.47940-1-eajames@linux.ibm.com>
 <20220511145648.3c421ff592df32766319ea2d@linux-foundation.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220511145648.3c421ff592df32766319ea2d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JPkKlzF7SbobKuVaa-i98JK8bli1Hagd
X-Proofpoint-ORIG-GUID: JPkKlzF7SbobKuVaa-i98JK8bli1Hagd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=922 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110098
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/22 16:56, Andrew Morton wrote:
> On Wed, 11 May 2022 13:34:00 -0500 Eddie James <eajames@linux.ibm.com> wrote:
>
>> Add the option to kconfig and set the default panic_on_value.
> Why?  What are the use-cases and how does this benefit our users?

If a distribution (for example some embedded system distribution) wants 
the system to always panic when OOM, they may as well configure their 
kernel to do it by default, rather than writing to 
/proc/sys/vm/panic_on_oom every boot. Maybe I'm missing another way to 
do what I want here?


Thanks,

Eddie


