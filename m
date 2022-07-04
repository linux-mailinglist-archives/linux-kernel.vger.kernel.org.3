Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735905653AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiGDLfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGDLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:35:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC555E88;
        Mon,  4 Jul 2022 04:35:28 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264AkWRF023810;
        Mon, 4 Jul 2022 11:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j8n8QnNWxc6DqyHBFvfTXm1SINLsB982cPLlzWpJtlc=;
 b=j66OKN5uwMVB7s/6u1riOvfh+ddIcPg+MgAJ04w7veGf3G/R87x1sLDpDyI0cawiJ4xT
 gY1kz1USL2qOFnah5h+k2JwTZwpwSPYTESMXn+/o8kffRr45VpwKds8MPKrsJZz46Z66
 3U+bRum0CWK38VrktNoNeX7qOhua79d2q9jPaTMs0Si6I4VzXj+VeC+LEIYH3qoduoWR
 SeqMsYY/Wa2yInGkXyQE2USxX4w4crN55I21UpXE2OM6lzv/LJF07rx/7irsz/la8+go
 hLVGCBeEtf7G3C5W93BwP1eyBSEuusx6zQHJhwRXnQV1lCPib7Dz7Mz3dtyx/6Zdrev3 og== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3xrh92pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 11:35:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 264BLK3h017554;
        Mon, 4 Jul 2022 11:35:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3h2dn92mtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 11:35:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 264BY8J124117668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 11:34:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6793AE04D;
        Mon,  4 Jul 2022 11:35:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E14CAE053;
        Mon,  4 Jul 2022 11:35:20 +0000 (GMT)
Received: from [9.145.42.138] (unknown [9.145.42.138])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 11:35:20 +0000 (GMT)
Message-ID: <7a4be6a8-6833-f049-3fef-48285a9fe40b@linux.ibm.com>
Date:   Mon, 4 Jul 2022 13:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] s390/hwcaps: Add HWCAP_UV
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
References: <20220701100210.5482-1-seiden@linux.ibm.com>
 <20220701100210.5482-2-seiden@linux.ibm.com>
 <1a2a885b-d408-0426-8e8c-ad1c56f4c215@linux.ibm.com>
 <YsK6ViBvm/330a0i@osiris>
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <YsK6ViBvm/330a0i@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoadaJZBvzZJnBsB6S75yyigtsUkZyMC
X-Proofpoint-ORIG-GUID: yoadaJZBvzZJnBsB6S75yyigtsUkZyMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/22 12:00, Heiko Carstens wrote:
> On Fri, Jul 01, 2022 at 12:10:18PM +0200, Christian Borntraeger wrote:

[ snip ]

>> Any preference from your side?
> 
> I mentioned already before this RFC that my preferred solution would
> be to have a solution which extends the existing method to work (also)
> with facility bits - haven't checked if all existing users could be
> converted to facility bits, but making it more flexible would work
> certainly.
> 
> If Steffen is willing to do that, that would be very welcome.
> Otherwise I'll put that on my todo list.

I'll have a look on that.

