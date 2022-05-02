Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF2516D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384239AbiEBJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380009AbiEBJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:37:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80070205CA;
        Mon,  2 May 2022 02:33:42 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2426uAci021772;
        Mon, 2 May 2022 09:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jJ+GRxrt2xk4FMHKuOBnNoDWz8NuV0uvK28Gl9JJRio=;
 b=ohjp1Qgnm6w3qHWMmk/MhRYJF7HiYy47DJBtO+kyEhhR1B5xeWivG0qaiNEpDNS1opeK
 0ffdHP6vLqna+WL1sfPsQTsQaLyvt7R3Tiq6NGG4BCxDOmv2IyX9aHuv9nR47TtzEpLa
 kA2cHvGjMAxC+WtoYvLx3fTBvgLibzBjEsBRweTH83TQqlOSsgHcdj8YDhJTHJ8tjQXG
 dJru2N9PJNSr6JfN0luVSO9NO2lBZ1rj1Ic2YNx/ldRz+dDETU+A/c730GSMdp8HYmmB
 L9Ns+FllmMXkiOWnRZWuCfMgdBhDgDYv43ehO1uxcOCZYzbqVP7p5jaBjM0EmBQoPhzX IQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftafd2qgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:33:33 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2429SDqi030594;
        Mon, 2 May 2022 09:33:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3frvr8t1bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:33:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2429XSx554067692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 09:33:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AD5C11C050;
        Mon,  2 May 2022 09:33:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1963011C04A;
        Mon,  2 May 2022 09:33:28 +0000 (GMT)
Received: from osiris (unknown [9.145.172.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  2 May 2022 09:33:28 +0000 (GMT)
Date:   Mon, 2 May 2022 11:33:26 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/crypto: fix typos in comments
Message-ID: <Ym+lZoRbROC9H4Vb@osiris>
References: <20220430191122.8667-2-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430191122.8667-2-Julia.Lawall@inria.fr>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HkY-HNJVB82HBxsZl0GLKfS-uQ51MqZi
X-Proofpoint-GUID: HkY-HNJVB82HBxsZl0GLKfS-uQ51MqZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_03,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=707
 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 09:11:16PM +0200, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/s390/crypto/des_s390.c |    2 +-
>  arch/s390/crypto/prng.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
