Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B68514A56
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359719AbiD2NWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiD2NWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:22:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D3DC6171
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:19:34 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCuIVt020228;
        Fri, 29 Apr 2022 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=V+p+Rv02lhh/C2xv4y7/cGXeK48jdJRLmPLIIxFAHpU=;
 b=jLBxar1BgpbwMGKF+qnRuRU2TsgYueLtAKvpjrEgbI79w5Osu+Dh9rW0Q+QUVsPlKdFY
 s3qCe9bckSV6Hfm0hlr6LbwuTze8Sp3811jTcn92fC4UHzklhSsn/PcgeCMt87f5MXJ5
 /MDrFVyMrG/CXx1qvNV0U6nu2Z2aMB6Vopt25HFf/umlBraodxZ4Aojvlxe+29hD1ezF
 0/RcyivDd29OKpl9RIVmuwDNOyfC7eeqQ1mRg3rXzk8RHgNFU9RIk34LwhGpYcl9ZmZ1
 cbIRf9A20V7IfAwzrpNRZuwwa9ar9ROlm1QfuEEH+Ded4LlgBuczD/hGkptEY1V3oFs+ 2Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqt9ebdgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:18:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TD32Kk032223;
        Fri, 29 Apr 2022 13:10:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm9391648-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:10:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDAGoe38339056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:10:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8FBF11C050;
        Fri, 29 Apr 2022 13:10:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AC6511C04C;
        Fri, 29 Apr 2022 13:10:16 +0000 (GMT)
Received: from osiris (unknown [9.145.7.47])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Apr 2022 13:10:16 +0000 (GMT)
Date:   Fri, 29 Apr 2022 15:10:15 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Message-ID: <Ymvjt7GEXE306WyE@osiris>
References: <20220428172040.GA3623323@roeck-us.net>
 <YmvVkKXJWBoGqWFx@osiris>
 <20220429130146.kxhxmi5jquzw56wy@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429130146.kxhxmi5jquzw56wy@revolver>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gaadsF3wQCXqGi2vnCghirqtbgXDkRpR
X-Proofpoint-ORIG-GUID: gaadsF3wQCXqGi2vnCghirqtbgXDkRpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=895
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:01:53PM +0000, Liam Howlett wrote:
> * Heiko Carstens <hca@linux.ibm.com> [220429 08:10]:
> > On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> > > On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> > > > Fix mapletree for patch series "Make khugepaged collapse readonly FS THP
> > > > more consistent", v3.
> > > > 
> > > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > This patch causes all my sparc64 boot tests to fail. Bisect and crash logs
> > > attached.
> > > 
> > > Guenter
...
> > 
> > FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> > bisect, but given that the call trace, and even the failing address
> > match, I'm quite confident it is the same reason.
> 
> This is worth a lot to me.  Thanks for the report and the testing.

Not sure if it is of any relevance, and you are probably aware if it
anyway, but both sparc64 and s390 are big endian; and there was no
report from little endian architectures yet.
