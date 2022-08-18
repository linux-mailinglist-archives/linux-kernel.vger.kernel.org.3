Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDF597AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiHRAmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiHRAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:42:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461919E100;
        Wed, 17 Aug 2022 17:42:43 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I0Hpit004012;
        Thu, 18 Aug 2022 00:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h+kCad6FaukL56RbduAxWPrAnskGs0Txy3LmDi1SL1c=;
 b=h+65O5uQDVcp6eJXvyPMnxgRM7SBK2zX/yRWV7kPeh8NInU4UW8Dlr1eQVFJ+QaB8Bi/
 YxtXoNzS+WzuFYLbreAh35OeXs8sMM/RkG+b4hFL5zNcQ9zYkY8Bv5t8pPwwxHEWTI+s
 wIYzkNZRVlGxn15y2ODF+OTxkfXmNKffC2AtpH65lT6qRVvNhs5M73KA/CGk2fBKmKqo
 /euFLIUmn+7RCURq+eRz553JGwzr4wiRX2VRFVAuPEp+OzzOK1ab66H9gd4HTwxHRz6n
 uTvDKZB34jhKv9IJ7nHQwOTOfJTi/lqCQYJHH03Jpz+s8ACmy/6MM9JOAc19pESDsEJr ng== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1arj0hv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 00:42:26 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27I0aFOh019036;
        Thu, 18 Aug 2022 00:42:26 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 3hx3ka3tpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 00:42:26 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27I0gPW549676638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 00:42:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB3E828059;
        Thu, 18 Aug 2022 00:42:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F6B28058;
        Thu, 18 Aug 2022 00:42:24 +0000 (GMT)
Received: from [9.211.97.190] (unknown [9.211.97.190])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 00:42:24 +0000 (GMT)
Message-ID: <e6e99e33-4279-690d-88b8-9e732551c17c@linux.vnet.ibm.com>
Date:   Wed, 17 Aug 2022 20:42:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Content-Language: en-US
To:     Robert Elliott <elliott@hpe.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TGN3nS18HXhgoPp9DOSCIbXOxE_fQGuq
X-Proofpoint-ORIG-GUID: TGN3nS18HXhgoPp9DOSCIbXOxE_fQGuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_17,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/22 19:20, Robert Elliott wrote:
> Improve the "make menuconfig" experience under the
> Cryptographic API page.
>
> The first of two patch series. This series extracts all the
> architecture-specific entries from
>      crypto/Kconfig
> into
>      arch/*/crypto/Kconfig
>
> A subsequent series will work on the entry titles and help text.
>
> Tested by running commands like these for arm, arm64, mips, powerpc,
> sparc, s390, and x86:
>      make ARCH=arm O=build-arm allmodconfig
>      cd build-arm
>      make ARCH=arm menuconfig
>      make ARCH=arm CROSS_COMPILE=arm-linux-gnu- -j 55
>
> Notes:
> 1. powerpc doesn't build for reasons unrelated to this series.

Did it build without this patchset ? Can you please share more details 
on the error or reasons?

Thanks & Regards,

    - Nayna

