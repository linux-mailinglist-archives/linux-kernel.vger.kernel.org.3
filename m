Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3652E56E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbiETGzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbiETGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:55:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B614E2FE;
        Thu, 19 May 2022 23:55:13 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K322gt022581;
        Fri, 20 May 2022 06:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pyLhAR5SDSCjhM1o4dP4CNhihWDG5i+NWOBoCN/vfFs=;
 b=fJSZgZXSUUF1RhcFMWY5wHeVNiyzrcmMwuJ2eiSF0ZWIrrKK+5tgih5JppC5L+1H7e7Y
 CFZ8Kn9IEl16gbIxJkMVfwDhcLqdCFbIgTvaDgXrDiPYzpcfDpdhBHWUdz/5qOUIMugT
 MUDbGj19VjDezyOw3RvFi+Sl4RKdB9x1cyH1Grfi7okc0ll7c4o1h6E6XOJiVIy8VuhU
 UqPz/JrajvciC2Q+yYzQ6sF/JQJOZ0Z4VW9ZPLPbHAajLtLhK6R9USlXhDZ7KPD2AZ4I
 t+EZBvJSxyqkhKDZB9hxiQbMK0lF/RWWThwLSK7Zs1WVlniMnwfX3jKud2MuD5/84pza yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g62qnbm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 06:55:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24K6pH3Y027973;
        Fri, 20 May 2022 06:55:10 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g62qnbm1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 06:55:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24K6r1lh001253;
        Fri, 20 May 2022 06:55:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3g2428y4ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 06:55:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24K6f99X49545508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 06:41:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A77352051;
        Fri, 20 May 2022 06:55:05 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EEC0F52052;
        Fri, 20 May 2022 06:55:04 +0000 (GMT)
Message-ID: <77e8b080-e7fc-fc06-a8e7-57ca30f6d0fe@linux.ibm.com>
Date:   Fri, 20 May 2022 08:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] perf/s390: Compiler error on s390 for bench/numa.c
Content-Language: en-US
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>
References: <20220519085530.999726-1-tmricht@linux.ibm.com>
 <CAM9d7cjjSk-qyA+ZF2YyrJUeaPN8wi7yDzu+ZRbiM4BhjFvg1A@mail.gmail.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAM9d7cjjSk-qyA+ZF2YyrJUeaPN8wi7yDzu+ZRbiM4BhjFvg1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i-UOhAGR1iFXBrRNdsV4W4rtr9srQwBg
X-Proofpoint-GUID: rn-J46KWVo_z4l3d1yaMXvUNHZw_dS4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_02,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205200048
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 23:45, Namhyung Kim wrote:
> On Thu, May 19, 2022 at 9:27 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> The compilation on s390 results in this error:
>>
>>  # make DEBUG=y bench/numa.o
>>  ...
>>  bench/numa.c: In function ‘__bench_numa’:
>>  bench/numa.c:1749:81: error: ‘%d’ directive output may be truncated
>>              writing between 1 and 11 bytes into a region of size between
>>              10 and 20 [-Werror=format-truncation=]
>>  1749 |        snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
>>                                                                ^~
>>  ...
>>  bench/numa.c:1749:64: note: directive argument in the range
>>                 [-2147483647, 2147483646]
>>  ...
>>  #
>>
>> The maximum length of the %d replacement is 11 characters because
>> of the negative sign.  Therefore use %u as format conversion.
> 
> But their type is int and I'm afraid some compilers might complain
> about it.  Why not just increase the buffer size?
> 
> Thanks,
> Namhyung
> 
> 


Sure fine with me, I will send v2 and increase the array size.

Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
