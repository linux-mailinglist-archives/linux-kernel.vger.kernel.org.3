Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E72530D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiEWJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiEWJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:39:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714331EEF4;
        Mon, 23 May 2022 02:39:44 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N8ES3W011224;
        Mon, 23 May 2022 09:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zsmPVrG1Ynl0sgRhzsw10gD7jRYGnQQ9anIRiCDtMNU=;
 b=lESVrBBOGA5su9d/J5p+WoCyGSj80CMyxQbRDMOQ9zfehl3ruQwXsClZiVzIqzjpri8B
 hMVpurSyZPobAT+DMSeT30S9a7Y93EiHDGhHu2kPf9AwWCDx/XnQuwqh5Pe8h6a7o+uO
 OOhpTqDlf89Y7yORWz8pajbjb9wcB+qXgJYSw9/3ZmwQOQLw/dmn48Avxi0uzWLRYNSV
 rx5b6Dp/pE7Bwhqu5AEMOK2hJU/wsBSD0MqthPT6HpxTDF7TbHR6k2wJDuP8aiLfKPdg
 ITMfiTwj+khQCjisXQKO56pdNUf7oH8V4eNfl2aZDdGR0ajzFBNI+0N42plbSbX+sHRL gw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g79ct946e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 09:39:41 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24N9PHgv022808;
        Mon, 23 May 2022 09:39:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3g6qq9a4pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 09:39:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24N9dXUL39715278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 09:39:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326B04C04E;
        Mon, 23 May 2022 09:39:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDC564C04A;
        Mon, 23 May 2022 09:39:32 +0000 (GMT)
Received: from osiris (unknown [9.145.75.188])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 09:39:32 +0000 (GMT)
Date:   Mon, 23 May 2022 11:39:31 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH 0/2] s390: Kconfig: Style cleanups
Message-ID: <YotWU/E8z2fJaqj7@osiris>
References: <20220520115708.147841-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520115708.147841-1-juergh@canonical.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i0sqJUWLP5g8vyQ_L9hLa4BG34Llt-V0
X-Proofpoint-ORIG-GUID: i0sqJUWLP5g8vyQ_L9hLa4BG34Llt-V0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=415 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:57:06PM +0200, Juerg Haefliger wrote:
> The majority of the Kconfig files use a single tab for basic indentation
> and a single tab followed by two whitespaces for help text indentation.
> Fix the lines that don't follow this convention.
> 
> While at it:
>   - Add trailing comments to endif/endmenu statements for better
>     readability.
> 
> Juerg Haefliger (2):
>   s390: Kconfig: Fix indentation and add comments
>   s390: Kconfig.debug: Fix indentation
> 
>  arch/s390/Kconfig       | 20 ++++++++++----------
>  arch/s390/Kconfig.debug | 12 ++++++------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Both applied (v2 for the first patch). Thanks!
