Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E5559CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiFXOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiFXOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:47:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F027FD2F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:44:16 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OEgKM6006584;
        Fri, 24 Jun 2022 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=d5HXA+asXWl90KVBp8xnvOgNuKWNysdDXiDLBjkUW0M=;
 b=Ita8jtl/gyRM3TqcMzsrk6HDB/ZPGvxjDRUBEGdH2QUuJIdGVgomyqBke3uyYLIukUd+
 +2Ma85mxKF94NnHIFzqdPA89mUXdqv8BgQxLc78pcvSjocAhMo68HIeywrnvbQQaRIiu
 1bC9iVGtVQQUTmL8jpEvcowC1Kq8654q+A5RWSac2mR3TyLXkRBNRTptVT/Ftbel+zZ2
 VIkKS4I9QBpDaB4lnw/pxtWjOWcsCwR+ufHtzuTjrloeq2ztidPqYWEu7f9D9CzGOSID
 TjLmwiepQEU6uzjWTzDU31Z3S/Kqxg/88pSXyYlbMI4/QbKEKQDO9sfBq+XAgBXjnCOe dQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwf8tr173-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 14:43:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OEKVD6014707;
        Fri, 24 Jun 2022 14:43:58 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3guk92rs1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 14:43:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OEhvfU27656488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A9FC6059;
        Fri, 24 Jun 2022 14:43:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A39DC605A;
        Fri, 24 Jun 2022 14:43:56 +0000 (GMT)
Received: from localhost (unknown [9.65.252.72])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jun 2022 14:43:56 +0000 (GMT)
From:   Fabiano Rosas <farosas@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2 1/2] powerpc/powernv: rename remaining rng powernv_
 functions to pnv_
In-Reply-To: <20220624142322.2049826-2-Jason@zx2c4.com>
References: <20220624142322.2049826-1-Jason@zx2c4.com>
 <20220624142322.2049826-2-Jason@zx2c4.com>
Date:   Fri, 24 Jun 2022 11:43:54 -0300
Message-ID: <877d56qfyt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XxTzzFsdG_p6zhiZmwQVy_aWCIslEPa1
X-Proofpoint-GUID: XxTzzFsdG_p6zhiZmwQVy_aWCIslEPa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_07,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=894
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> The preferred nomenclature is pnv_, not powernv_, but rng.c used
> powernv_ for some reason, which isn't consistent with the rest. A recent
> commit added a few pnv_ functions to rng.c, making the file a bit of a
> mishmash. This commit just replaces the rest of them.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: f3eac426657 ("powerpc/powernv: wire up rng during setup_arch")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

