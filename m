Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7556D738
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiGKH7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGKH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:58:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC71E8E;
        Mon, 11 Jul 2022 00:58:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B5jD63013747;
        Mon, 11 Jul 2022 07:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hBtEgTDSy970CDUjQiXsNtCZEwvTYiPxJpYa9RGS2+Q=;
 b=ATijTIayX0y31EL/pW+GXMihdg7d59K5QZxiLHjd7XpV7i6YOHfHuMNlJLzygP5EB7ba
 zX4ROfONlM3+sBNTQRo36LgKFutkwvIqYS8k69td0l2i4ySCCvftODgBDgrDM/0fOceP
 KGTRhd50yxv5LvZeq8oZMZ9hk9eFUm2jGPfk1DpneST3W3CQdjVxswUgm/cK6tM/65/s
 y4tmI30VMoqNGr6BCfwxISi2aBdx0Ta5idM4dnoBtpdfPu2LngFGV4skRVPBT8db97Nz
 RR/mgASROb14PKADWaU9lyCs2hF/J0xmU7KFlkg+DgJN7zvyqQKL7DGAaFHPiZxMe63l Ow== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84sab5ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 07:58:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B7oHqY016532;
        Mon, 11 Jul 2022 07:58:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3h71a8jd15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 07:58:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B7weno17236326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 07:58:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22204C046;
        Mon, 11 Jul 2022 07:58:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6DD84C04E;
        Mon, 11 Jul 2022 07:58:39 +0000 (GMT)
Received: from [9.171.15.135] (unknown [9.171.15.135])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jul 2022 07:58:39 +0000 (GMT)
Message-ID: <17777079-d671-2596-4371-511a182f3a4a@de.ibm.com>
Date:   Mon, 11 Jul 2022 09:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: Signed-off-by missing for commit in the kvms390 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220711084725.26b9ed99@canb.auug.org.au>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20220711084725.26b9ed99@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bJ-2webVAActu5jlEAA-askpXPZ4KgH7
X-Proofpoint-ORIG-GUID: bJ-2webVAActu5jlEAA-askpXPZ4KgH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_13,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 11.07.22 um 00:47 schrieb Stephen Rothwell:
> Hi all,
> 
> Commits
> 
>    a25db9e809ec ("MAINTAINERS: additional files related kvm s390 pci passthrough")
>    a0c4d1109d6c ("KVM: s390: add KVM_S390_ZPCI_OP to manage guest zPCI devices")
>    a4ae95559e77 ("vfio-pci/zdev: different maxstbl for interpreted devices")
>    0a8107de8091 ("vfio-pci/zdev: add function handle to clp base capability")
>    6518ebc68c72 ("vfio-pci/zdev: add open/close device hooks")
>    b8d6db486fae ("KVM: s390: pci: add routines to start/stop interpretive execution")
>    d53ad189a06d ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
>    1779cffa5bf9 ("KVM: s390: mechanism to enable guest zPCI Interpretation")
>    834c4bfa5b5c ("KVM: s390: pci: enable host forwarding of Adapter Event Notifications")
>    394f70328769 ("KVM: s390: pci: do initial setup for AEN interpretation")
>    7713b9894b2a ("KVM: s390: pci: add basic kvm_zdev structure")
>    b6a7066f4e9b ("vfio/pci: introduce CONFIG_VFIO_PCI_ZDEV_KVM")
>    59370746253b ("s390/pci: stash dtsm and maxstbl")
>    729c8d1d957a ("s390/pci: stash associated GISA designation")
>    59f42dba7d24 ("s390/pci: externalize the SIC operation controls and routine")
>    db29efaf10d4 ("s390/airq: allow for airq structure that uses an input vector")
>    7a7bdc5f142a ("s390/airq: pass more TPI info to airq handlers")
>    5857c6577bdc ("s390/sclp: detect the AISI facility")
>    1e41bd8fd172 ("s390/sclp: detect the AENI facility")
>    2f3a5d8de328 ("s390/sclp: detect the AISII facility")
>    263007d2d10b ("s390/sclp: detect the zPCI load/store interpretation facility")
> 
> are missing a Signed-off-by from their committer.
> 

Fixed, thanks.
