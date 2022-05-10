Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C3522134
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347329AbiEJQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbiEJQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:32:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596231C94F6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:28:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFT53C023694;
        Tue, 10 May 2022 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hP4oHB2Y5TOyjpu7ThdantQAg+KVVtIYhN7jlUsGUZI=;
 b=UhMdh3HOWtB3thek7gevWYge3PR216n7MTbwXCAhgqbHGopDqwxX30zlfftc5Be4+ZBQ
 vV1DZO0KoXNu9tvrLzKT9EoVNxfUj+g+vKaNLb5EGXAMXNzesKG8jNtIUIBVE3Tp7BLG
 EA2a/y5epuY+bJKMBrHUgaqFKJMMlftS9gnEGw0oIpsd3piQ1Uf8yQF/7qqpEEXh/k1r
 PQPXVIHZB9BvOnjyTmlwSNDiyuNvfwLC0teqaXFX9Z4FaDPRT0W+NM74UaAGsioKeaJL
 Q1g+WHHJoqSPoRgxVCcrao0omZM/5DuqAe0NYI55mAZpcCCzDr5s+SJ8BHJTWKdPHhOB 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatf9mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:27:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AGPbe5029651;
        Tue, 10 May 2022 16:27:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf79htyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dww0c0T9CDNAO6UeW0R+iEdcqKkCazx5o03QGvvgzGQVQXGe1e2J3ZtPJWb7tUmatyeEndAAu2CfWiky0y12W48gFTrbm+AG2cskCpFPX5RWYzoUVBO6TbAOKMQTbAA/xTaaVHy4SPk0xJAzOG6sEVGP1KRMlEEctYmMl8fKFdlm0ppwOL+lQCzZFrsH2G0fFCImnxzKmo5O/Pg7yddMjtXNPFNWW1BqPuzFH1bTohPypnGMphJHtNcLCu1SoMaooAJS1fol5qcqKzXWIU3O8bwpS37idV6pzNty6OAX36boHDyke28KN79hYNNTKFdkUNCw+KojRxIVNQHHQL6q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP4oHB2Y5TOyjpu7ThdantQAg+KVVtIYhN7jlUsGUZI=;
 b=DlbNOVfwkzWFzn9o9YKIrT3sANXTpDpIpwyZxVzhGdrbJdGWJLpx/GC1N9mIGsFTF1FXbEZ7+kNu6bR3mgqB84TJFaWj+PtBAyp4A5Lf5o6L0HJ/l3Uv5nmkxMUqvud2hSlimq/CJpZW3zyxgVsFO7xpwaDoSF4/iVTxkOGCVfzda3+lGFAg+432Lwi+jZKamBLodOqy9Ff26LshSImTusl5iWEibBRqzGo0aSnuvB9f+jLH7P44uh5Zy2iACFO6AZxjpWyKkNbGrzeUiTGZabKvjZG0jz1yx4yWmD3cLWFNoddZS8rw7HlkndJrX0wxjN/DwvZJPWrVvZblHr33kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP4oHB2Y5TOyjpu7ThdantQAg+KVVtIYhN7jlUsGUZI=;
 b=Hl+NpYfrEhrNOQ8HdFk86XNrAEnraNRURaNaJufQVOp8a3nzNI3ErDM5FAypV98d2j7JIIr8xlKL7JZdlfDJowxG71usKxpZKI5ofBlpQXNVjAMVpoyy7xO8aDM8Lv52IfYxK1/O/QJ0sjUyEGHcPzm4GyvA7aytU4xeueqOMXY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3827.namprd10.prod.outlook.com (2603:10b6:a03:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 16:27:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:27:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: Re: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Topic: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYX1QE+HvcVvuhWk2ltHXx1nzXSq0X9zAAgABf6YA=
Date:   Tue, 10 May 2022 16:27:53 +0000
Message-ID: <20220510162745.txhq4nu6kuselskh@revolver>
References: <20220504011215.661968-1-Liam.Howlett@oracle.com>
 <20220510104428.152064-1-sj@kernel.org>
In-Reply-To: <20220510104428.152064-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214a1001-870d-4f8c-b998-08da32a20877
x-ms-traffictypediagnostic: BY5PR10MB3827:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3827F3B7CCE409FB243496E8FDC99@BY5PR10MB3827.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMW7mObMIoQagWIDGMn7NyqjtwyuaQQnG5Do6Ka+HOP9Sq/S6wjP4MKuR/+CjJlgmaUQPbcjRKW9tKrTZEL8Vi4tU/EBq9ikq0x7ndkhJc8fHaLbjacO7wVghvW5IdyzFWKbf1FH1K6NLQ1HWcZeDLhuT84zpMzZu0eXxhYoVGvrpe8SH4h9B155eMcnzCMG/MQxcrl6c7sCct+2zz13Rsm71bB6Rm4DCBLVvJFTgSHHnizGfu36xEQ7kUDFxHEsf6myB0HekUBrNKw+0gT65bDF6cat6Yx4ySc9DwzCTzrH9JdfmcTY/xcD6FAsPI018dxXDS5oKFIcB/QPAsxt+0XqwbBhI57+tdAZHs97k0g32N8kab6Hn7y7PmiGwtynVbyynquzCNhNuV6DiwoLyNI+odI7YzfiKeRlvTMvLvrAAwDKKmwazxA5M8sInKJlw3FBz/kc6NAdFPHPIumlTD3Tp21/pT+4kp+aAmwbTbj636MXJTEV6uARDyCiC1XyvFxle9YBS2VZ/QPB4ki6BwJsyT4PHlTq5Ka8l3PP7jyOGODBCYQmQ4Bjq9R0YcERju6anMBsacG034rfKfB7hNbo4rbPE9ssDzGmB8ExlcASlLi5R+mtSJGi2QWOVtpT/7GKhEM4tehSfAG3PT4J7PJUMtXnr3tW0C6IutWqe8YvFzSHnoatTbx6xluWmr87ASdaCRdoa/Gwv+6WTa+avw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(38100700002)(6506007)(5660300002)(6916009)(6512007)(9686003)(26005)(33716001)(54906003)(8936002)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(71200400001)(76116006)(91956017)(86362001)(4326008)(316002)(8676002)(66476007)(66556008)(66946007)(122000001)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ggqk5oWgLIUSBnewkVkSjeN+S9n7TkkXWODu899J8eRWhSk8JOTkAB4EfCMU?=
 =?us-ascii?Q?eyDAwAAyzW/44POXqd2PuFYwjQXjHqnvHLQKE6kXj+vKLGXV6GQ2kiH4Z47L?=
 =?us-ascii?Q?MY5Ho4+VxvpbgP1xrMwtSWFPmrk9eVzQBYsDIZJYZr7vtzaMvV+rag+pZsvJ?=
 =?us-ascii?Q?buslPdas1BviOlFy3rm4KFbZgDJ+lQn2D1gnl03wFRFIBwcCVncZkm0kUYGi?=
 =?us-ascii?Q?bqeOqocgfCV7WkZR/bfOiViskivLig0JM7QBjVw39JI1KSZa5iNeBYZQApNS?=
 =?us-ascii?Q?f4fHOGEH5VJjqtxneBwbjWhxD2LhxyXBYUGG47YMqWWeV0rIFx4LBkDSlzPL?=
 =?us-ascii?Q?8qywQKdRHsrI7jQbX9JtKw1uj+QcdbfAbm1tu56OZhkOnyCM4g5tHgSKWcK3?=
 =?us-ascii?Q?45SG+nqieCjWFwfAzkKcoQ2HtAzl/4Pq0/0nkW9clFwnMr8XE8M90PYn6az5?=
 =?us-ascii?Q?GOgdbDEnc2a4cqdFVkUsxcrwRUmZ5nEHAt8yaFkHzlyC+MWNQe+/f5dSvAjQ?=
 =?us-ascii?Q?JOfSBCrcHu73RRNAFJgiSUrWufckEUHiI6UmtpMcMISkHzHPa22qIvvg+YTN?=
 =?us-ascii?Q?JRTug373G5dZkUGdT0YIbFe93FiT/GWKYuq1qM/Bw569ah9YA4BoibJpa/T1?=
 =?us-ascii?Q?ezUd/24GD6RACnNvYu+OgRAtswsJBkDzEvia06KC0AslTQlPi5jiivRjjCli?=
 =?us-ascii?Q?b8icIynjd54oV8lreGdVpEc33ZeAADP3LypI8R6lp2WulIc5zh+/4t3A5u1T?=
 =?us-ascii?Q?YNQQUp0xQ1UxlVuhaHqqt2Oqqlq3Oucyf76w1Nm3+MVDoa7tQY+x2AHwp+3y?=
 =?us-ascii?Q?VmdFHKCrY2t86nyRKzj44QDczlP5hzdL4bSur49+Yrp7yGRZ8Yvjb62okDB3?=
 =?us-ascii?Q?D06io0hXeYBuJW9JjMpO/ltiPGkhC8ZS+h7xDw/REHnIILSiSpTLc6pdJnc9?=
 =?us-ascii?Q?Cpgf/o3rfjQcZX1+ecuQBTEMn+BobjwvcQc3QCGa4nXEafKSY6JXwHkxtpay?=
 =?us-ascii?Q?GNblGPXfU95SgzdXK7LQ4qgdXFYKEwnPrPXldnszmEU73n4P+qPVqfkVm1R7?=
 =?us-ascii?Q?ZlWHrPjeCZv3IKRbknHhMc4e//hRGfT3C9SDBdBZNZJyyN965DPjtuukGCZC?=
 =?us-ascii?Q?S+xyxh/O7jLjxbdldTUH7c1pJ9qAB3uun4v/q9mIeC2qAPsdpRfU5W1SL/uQ?=
 =?us-ascii?Q?lrxPgP8mQ/RtR0rP/j/Q2eaBd8MiIRvCtV2BWrvoaUhQWRgd1KQnxaR0mLs3?=
 =?us-ascii?Q?wrlk+FEG3pnyLSsTCU7Gf1QLbntM3Jcq16INmWlAdIvhTi0Pj4YWi3x5gkKQ?=
 =?us-ascii?Q?OgOTbkDMxK+qOmyM1vinLi+tDiRiUfVu7LWnSdID+6dpND702pORnFXQyKDc?=
 =?us-ascii?Q?rDoNoNS5FPmWh5kZyuBOO50b4VW/fYT0zWT9xl1STOlsJjndfHsfcAyzMaOL?=
 =?us-ascii?Q?muIkZy/2Tm4sLLNGdi/bKxWqgffBRwyViomBdZhwKPpq022StNy/gECtGcJD?=
 =?us-ascii?Q?Bb/MXKAkdBtGtD6t6q8Q07Y93xf6QiuAGhJa7sSPIYfq8ErdXSXntkcE9m/R?=
 =?us-ascii?Q?Am1f8IGen4pcZTPBMxJXuKl3vtYGI+ZVXK2uL5LWJD/I9XT7ZDPTuFkFLrPF?=
 =?us-ascii?Q?Xq74h60u3Tha08t/buZJbnqdp8yl73iKv3ZTLTRnNHCL0jSBVTath9WMMXLO?=
 =?us-ascii?Q?giTkANepmB9w0Qme9mpoC76Fthpw/rNgzs0Hty7L9POPBSrRvz6+HR5bgeT2?=
 =?us-ascii?Q?PaUNEmyClBp4jTSqWVAGuAqCpl8yU3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88D4B5948A6E09458087791ECCA3D02B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214a1001-870d-4f8c-b998-08da32a20877
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 16:27:53.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neKhSOG+JTItv9tJtsB8u0cjS6dkobVjvu82F6Eqb9b1ulYi+DQmwl/ZJ55XRrtLCBhK2Aa5rAWETI9gToCtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3827
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_04:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=606
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100072
X-Proofpoint-GUID: UJD0AwAqlPg3_J9dl3WBAIPd6iHniJk1
X-Proofpoint-ORIG-GUID: UJD0AwAqlPg3_J9dl3WBAIPd6iHniJk1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [220510 03:44]:
> On Wed, 4 May 2022 01:12:26 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > This rather specialised walk can use the VMA iterator.  If this proves =
to
> > be too slow, we can write a custom routine to find the two largest gaps=
,
> > but it will be somewhat complicated, so let's see if we need it first.
> >=20
> > Update the kunit test case to use the maple tree.  This also fixes an
> > issue with the kunit testcase not adding the last VMA to the list.
> >=20
> > Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/vaddr-test.h | 37 +++++++++++-------------------
> >  mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
> >  2 files changed, 40 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > index 5431da4fe9d4..dbf2b8759607 100644
> > --- a/mm/damon/vaddr-test.h
> > +++ b/mm/damon/vaddr-test.h
> > @@ -13,34 +13,21 @@
> >  #define _DAMON_VADDR_TEST_H
> > =20
> >  #include <kunit/test.h>
> > +#include "../../mm/internal.h"
>=20
> V9 maple tree patchset has moved the definition of vma_mas_store() from
> internal.h to mmap.c, so inclusion of internal.h wouldn't needed here, ri=
ght?
>=20
> If we end up moving the definitions back to internal.h, because this file=
 is
> under mm/damon/, we can also use shorter include path, "../internal.h".

Yeah, that seems like a good plan.

I will be moving it back to internal to restore functionality to nommu.
