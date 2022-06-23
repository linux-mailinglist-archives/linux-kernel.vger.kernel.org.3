Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971C055730F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiFWG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:26:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96541F2F3;
        Wed, 22 Jun 2022 23:26:56 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N50r2x029227;
        Thu, 23 Jun 2022 06:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/P7t2phBqu+ao82YbmtEivv5QBjmpG1rdiMSp18UT+4=;
 b=GY9vQtDq67CFJwCb7t6gId4sGaSxREcjhvnwP8a/zAoudYMQf/l2hFVWGeUXnWSz0/ve
 G3XAhyN0qpgCL/W7opev1lIpAcwDJwyJhLKVwdT4U0hRMz9mgKveUIRshhMGIca4EuZ7
 mCzgSzYu6SIJAc61P9KmFrsLXK+85cmcO/82Vv01CbnZAZHSSSbfZ6me7VCIs8Y8Xt6p
 cFE+YYWxwuggqI0OMhIt3UtV/b3UT5FTf+937vWSbJNyDs6xjPxthLkfXqayU/7o17Zv
 RhYsNZC8jIl41QlB9Rjjnj+nV5K6ZNTEIELyrn9AKNc1I9N9q91V6lRJr6U0HESb+LsX GA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvhnghxga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 06:26:56 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25N66A31027533;
        Thu, 23 Jun 2022 06:26:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3gs5yj5b4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 06:26:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25N6Qouj21037398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 06:26:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A23A405B;
        Thu, 23 Jun 2022 06:26:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A614A4054;
        Thu, 23 Jun 2022 06:26:50 +0000 (GMT)
Received: from [9.145.6.211] (unknown [9.145.6.211])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jun 2022 06:26:50 +0000 (GMT)
Message-ID: <64567338-827d-75ac-f941-5f534db57182@linux.ibm.com>
Date:   Thu, 23 Jun 2022 08:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/1] s390: Add attestation query information
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, hca@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, nrb@linux.ibm.com
References: <20220518135908.1110319-2-seiden@linux.ibm.com>
 <20220601100245.3189993-1-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220601100245.3189993-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fre8i_0nPAyFGDEFpCUc6LHAo9S5oVS9
X-Proofpoint-GUID: Fre8i_0nPAyFGDEFpCUc6LHAo9S5oVS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_01,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 mlxlogscore=882
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 12:02, Steffen Eiden wrote:
> By design the uv-device does not check whether an incoming attestation
> measurement request only specifies valid plain text flags or has the
> right request version, as these values are verified by the Ultravisor
> anyway. However, the userspace program that generates these requests
> might want to know which flags/versions are supported in order to
> create requests without trial and error. Therefore, expose the
> supported plain text flags and versions to userspace via sysfs.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks, queued
