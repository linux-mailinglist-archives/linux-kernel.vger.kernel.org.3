Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0158F7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiHKGnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiHKGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:43:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED20ADEE1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:43:46 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B3m4kB012004;
        Thu, 11 Aug 2022 06:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nMcpLoQ7ptxfnTBxvzs6bjD+qjRDhzLhvdtk15oYdCY=;
 b=Oil5fWqQWhld00zNcALuJb5huA3GYb//aRN4QIiGfRaaDExSeSu1pTkmFjYQc1czSEbb
 xu0SdKUx4HbJGpjcfgOOpfvwU57gKLWrWYVuKdTj2y0ktxmb+Rtb/mJfZaCbv9hZt0QY
 0NhrcyloCv9EZYbIm//Axl7I0C3OFOXPIcdKAkIJv9lhGNW1Rddv6/1Y8hP05vef6xxn
 cFOgfejKSKWnpU1w7fGb9zZdJJ+vsK8I84GlsrrzZEBeeMbJojEM7/D/U60vRtZ1whOX
 thDsi3X65/ytPU6D1cV8KXAHltNhAsP0B+BBuz5F6r3NfX42E91hj857Ix0jA9ZcY1Nm tA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hv95yu8c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 06:43:39 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27B6hdsZ007341;
        Thu, 11 Aug 2022 06:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3hshckqcee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 06:43:39 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27B6eqe1001571;
        Thu, 11 Aug 2022 06:43:39 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 27B6hceK007335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 06:43:39 +0000
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 23:43:38 -0700
Received: from [10.214.20.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 23:43:35 -0700
Message-ID: <c7e36aa4-899e-fb7d-ef2e-cf4e5925fbb1@quicinc.com>
Date:   Thu, 11 Aug 2022 12:13:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm/cma_debug: show complete cma name in debugfs
 directories
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>,
        <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1660152485-17684-1-git-send-email-quic_charante@quicinc.com>
 <20220810143102.595072879e4bae7f7c46e3e6@linux-foundation.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220810143102.595072879e4bae7f7c46e3e6@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xuk6NhXvNvJOZeDPnPbghGlygRWG4zF3
X-Proofpoint-GUID: Xuk6NhXvNvJOZeDPnPbghGlygRWG4zF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_03,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=842 priorityscore=1501 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew!!

On 8/11/2022 3:01 AM, Andrew Morton wrote:
> On Wed, 10 Aug 2022 22:58:05 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
>> Currently only 12 characters of the cma name is being used as the debug
>> directories where as the cma name can be of length CMA_MAX_NAME(=64)
>> characters. One side problem with this is having 2 cma's with first
>> common 12 characters would end up in trying to create directories with
>> same name and fails with -EEXIST thus can limit cma debug functionality.
> 
> I guess so.  There might be back-compatibility issues, but it's
> debugfs...
> 
> 
>> Also drop 'cma-' prefix for the cma debug directories as they are
>> clearly evident that they are for cma debug through creating them in
>> /sys/kernel/debug/cma/ path.
> 
> I guess so.  But please run `grep -r cma- Documentation'

I see the Documentation/admin-guide/mm/cma_debugfs.rst is not upto date.
Commit f318dd083c81 ("cma: Store a name in the cma structure") moved the
cma names from int to strings but no update to this document.

Will fix the Documentation part in V2.

> 
