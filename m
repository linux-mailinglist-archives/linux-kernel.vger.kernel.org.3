Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5485A23F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbiHZJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245589AbiHZJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:16:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDABAD6BA4;
        Fri, 26 Aug 2022 02:16:40 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q9BcuF015784;
        Fri, 26 Aug 2022 09:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TxjDCpdT5D67dXIfLoPwh+ZU8ah7MjHvF3PFFORlFFA=;
 b=pYLFTRRM6wYpeDYMTpZkPlwRU5iKGRlHyJMeXkKiHYStQYCYwDTCk0bpGsaKGmIifNVK
 wqockz4+e5VE3W1Wo9K4pLM/3u+Z179vE+p3q71H2zoGgPJJZLdz6sG9qy9toFh7AhGJ
 /BDxcF9iUgfzt1bQnGCXm1Oq+G8YiJGbQ48CbtmAj7XZQuCSQH9M07uFEg6S5sBX3XZP
 5KGert7SUShvXKi+xAxvtu9ewGFz4axaANRxrOJQVsKXRV7/tduc4Sm+NI4xkhlqY1C5
 iVFkONB6HyjAXChLC3wIcveBO7sxXUVX/dNnraoAGwxmFabzKDc2Tp2Hd1IKjF5rk1PL iQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6uax8402-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 09:16:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27Q95Rwj012943;
        Fri, 26 Aug 2022 09:16:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3j2q88ygsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 09:16:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27Q9GqFB39059932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 09:16:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59D5F42041;
        Fri, 26 Aug 2022 09:16:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8E164203F;
        Fri, 26 Aug 2022 09:16:30 +0000 (GMT)
Received: from [9.171.69.241] (unknown [9.171.69.241])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Aug 2022 09:16:30 +0000 (GMT)
Message-ID: <a79806e1-cabf-a604-22d7-8ab09e48b343@linux.ibm.com>
Date:   Fri, 26 Aug 2022 11:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] s390/cpum_sf.c: Fix comment typo
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220816171911.6888-1-gaoxin@cdjrlc.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220816171911.6888-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HpKzCMaxpOBUMP-Hk4UoJeUdJUJxh1es
X-Proofpoint-ORIG-GUID: HpKzCMaxpOBUMP-Hk4UoJeUdJUJxh1es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 19:19, Xin Gao wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  arch/s390/kernel/perf_cpum_sf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> index 332a49965130..0fda19b1e21d 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -1160,7 +1160,7 @@ static void perf_event_count_update(struct perf_event *event, u64 count)
>   * combined-sampling data entry consists of a basic- and a diagnostic-sampling
>   * data entry.	The sampling function is determined by the flags in the perf
>   * event hardware structure.  The function always works with a combined-sampling
> - * data entry but ignores the the diagnostic portion if it is not available.
> + * data entry but ignores the diagnostic portion if it is not available.
>   *
>   * Note that the implementation focuses on basic-sampling data entries and, if
>   * such an entry is not valid, the entire combined-sampling data entry is

Acked-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
