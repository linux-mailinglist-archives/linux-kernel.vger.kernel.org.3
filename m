Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFA4C9893
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiCAW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiCAW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:57:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC00D63BE3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:56:19 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221LhblS000538;
        Tue, 1 Mar 2022 22:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sylPMh1mjENPweOfTDXuIVEt+Izg0ICZgR+K1C9ozkI=;
 b=RV42jCxYRAQFFeq1jNPkS5ZtQCLqg/9SAl+505p5hqAgSJhEL67ixbvVbfyNp43k5fvK
 iDJOqlFzPByUmneza2i8FTgQT92Zk9886G/TYBTpmSuRhIZ6pUR47V3369All8tZ6o29
 rN+CKr8QnCQPB0XmQv6wfONcLquDVGrOXfhUledKrERNPhKnCfCvrTfKoAkoYYqWP4n/
 aFgyBpjv0aIfPiKsm44qDfEYGNKyzb2SHmyh2sDzxHA8FBlzEMroS+w4rd2N0Bnn6dZ9
 EWmGxYda3oiejCeuX6lufJXn8m4dwaAJv3wCkpbtIg+F3VTU5JQ0NHj81luGsfJ3S+CR dQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ehunj15cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 22:56:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221Mmelg013311;
        Tue, 1 Mar 2022 22:56:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3efbu9bqen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 22:56:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221MjC4644564810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 22:45:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7219942041;
        Tue,  1 Mar 2022 22:56:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2657842045;
        Tue,  1 Mar 2022 22:56:06 +0000 (GMT)
Received: from localhost (unknown [9.171.95.195])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 22:56:06 +0000 (GMT)
Date:   Tue, 1 Mar 2022 23:56:04 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Message-ID: <your-ad-here.call-01646175364-ext-8714@work.hours>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
 <20220228143633.r4zoemgtmrq4uzvb@revolver>
 <your-ad-here.call-01646100074-ext-8278@work.hours>
 <20220301203935.r74qjc7p6qbno4xw@revolver>
 <your-ad-here.call-01646175058-ext-9349@work.hours>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01646175058-ext-9349@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 29fBxCnU8Xd2bqFg5Mh_TVX5Ho0Okft2
X-Proofpoint-GUID: 29fBxCnU8Xd2bqFg5Mh_TVX5Ho0Okft2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Mar 01, 2022 at 11:50:58PM +0100, Vasily Gorbik wrote:
> I use it the following way:
> $ ./fuzz-maple
> $ ./fuzz-maple -minimize_crash=1 ./crash-abdc5d14045d52b920d17c6818db7383e1a3ac84
> $ V= ./fuzz-maple ./minimized-from-351a4f19a3b166974009662f657daba183e1ff0e

I'll attach couple of repros, but it doesn't take long to get some.

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename=minimized-from-351a4f19a3b166974009662f657daba183e1ff0e

8 88 8 84 8 2 8 4 8 14 8 7 8 12 8 18 24 8 18
--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename=minimized-from-b348fbddfff54ced341b78c953182f47b9e53c67
Content-Transfer-Encoding: quoted-printable

8
 9n 4=FF 78 8=F0=1A 83 8 978
 =FF=FF=FF=FF=FF=FF=FF=FF	91   59=8C
 1 5
C=FF 1=20
C=FF 1  8
 4=FF 89 8=F0
 66 8 97=3D 5=FF 78 8=F0
 83 8=20
--Q68bSM7Ycu6FN28Q--

