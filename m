Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C7451509F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378988AbiD2QWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbiD2QWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:22:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7FD8932
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:18:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEXXAm011324;
        Fri, 29 Apr 2022 16:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J4JOJtX0tCRkHFYJmHrIDR/Oh084ha3BVW0+ZkOG6Fc=;
 b=Vcy9Y/fVNcnhNCBOjyCcIjcob1n92CirUZbzIVJfyWefU1s8XsAfh0/FEywScTWkrYMI
 +MekOy9Qb/HQQ8XfOukmHAG1B624pl/t65M5I7Sdd4hfyPfebm1vteYpxXDt+hPN233V
 XDpsPqtMiEMmabO6l7kOmtlyiyvdUNPfv1pkrOeSAxo6zEp+Hakd0J2Ti10sKTsECxLD
 AwsOornf+Zqhab4G/UQ6NIEapGcaUzJNiRUZcGRPc/fdhEIibzMJ8KkPmzzTZ6EORyzF
 HmhLv3vFjZAr/Evz6A/csQxJCDXi7uRd7uLVzb6bOypzrwedhiYgpDx/3YGZiz8QnYgU 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4qbs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 16:18:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TG0G6g017121;
        Fri, 29 Apr 2022 16:18:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w86fm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 16:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+sqvll1dPMScs+gjRMPz5ZQmCCk/3B1ZYqyt4S54qjMXuL5nfD5+IWogZbgc/4ygwzcWvLi5QdZPKAxhsYJq2xOTlsX6yHL7qNeBppjqpDelsks3ojSdrekh33Vff5XBsW6NXYP9ZR4KKlI833dqXMfPxBivU5Y9bIS7QTyAao7d/+wDNHLDARb1eilz28nC7jtKJ3Ozv3QBkgEzzoa8xnJXP8RFgzzMO2OlxRzgPKHp6qCrRFo1ZA+lnOuL2zxNkCr3jDvbk3Laam6tr1X98Payom8hVzzHyz6AgdW0cztaV1b93bRXSZGgm9FAzx8tCbWj0Ao9OuTIblesxaOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4JOJtX0tCRkHFYJmHrIDR/Oh084ha3BVW0+ZkOG6Fc=;
 b=C1akiTg1nlKXbuoM8JIfLHCiHftkMUiGlK1VxTY1QMsSrpePc2RJafZxB9VUy6roNPOATg4RfCF2TsmYQjI4BqW/yWUFantjiPnoOPekUfZnfA0GiOgNpp4dGpbZbACz1V6wchtuzHJ7+YtWmRpcDdqGZp3s1xi5Jw4GwdBIF4yzNzvgOL4APlQkxjSOWSN5iTZhwYmwoGy7OPJkFBqRnPA/94ifenX9LBl0WAxUZKz+jCPTIo+1elxDlWH941wXg46qPg0zHS4cz5cvyiywvCf7+tMZ50pvn84pz/qEJQyDiNV0S/SWWRAlnAh5gh+6pfcA97b99qrBVXa43gstIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4JOJtX0tCRkHFYJmHrIDR/Oh084ha3BVW0+ZkOG6Fc=;
 b=cBmzhUixXSgpvg2xoM4xtfm7fFykJgsGGSbA8YGI/II/R9U4WcFjrQquCGKd5PTZnELYfKUQwsIBkIFQ+hZAQmGPtbCs1/EaOP9v+gEVQeTQOcRLG4SjBat7j7pDVYReeY1HgMsb/g6YZkyiS5/AWfo94T4Pprx+ak2gi3AbqAY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 16:18:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 16:18:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgAAOgQCAAAJegIAANIWA
Date:   Fri, 29 Apr 2022 16:18:23 +0000
Message-ID: <20220429161813.oe55p4akkinjcarq@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <20220429130146.kxhxmi5jquzw56wy@revolver> <Ymvjt7GEXE306WyE@osiris>
In-Reply-To: <Ymvjt7GEXE306WyE@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89fde179-0817-4196-c23e-08da29fbe243
x-ms-traffictypediagnostic: DM4PR10MB5989:EE_
x-microsoft-antispam-prvs: <DM4PR10MB5989D9D0D0340E8EF5503157FDFC9@DM4PR10MB5989.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOdVbRD7a9Nz3CFqAuzj99No6gP+I+raby4Sm1JS8gX5UGgVi1K1xNQ+mB+LmJHYiIXTEN/dy1jVVqa8wkr3s/AdD6sfZwlK8/VE3bjwfN2YN5mhzvmY6EfgVUX32qAku34EV9wAtiPLVgEfTiShvyux7uzeoDVdUbdwNvCfJvgaSz0Or1cDfix8I9x9gLWGUW2rkP2r332Hq4ZprOmzj4N76bMun0MxjafWYiROLQEaI2CHK1qnyNcxDew1i3PC1C1lUdScAOSwZozp9CnAwnYQQAA6aagG4BUkaN5bvK9dbftWA0TNRTjAN5/LUeoNUVhj8j14mMBUstSET2prc1bFUcSuGGG1yx709FRslvl7mVwAKlViP+ajMxQEVce18CBFUTcZvSjK40ZQiatAUeF2oDnGRVEmxpY3Mv6L2xXxxO+FjkCQFfF14Bx04M+YAn9jwfkuI5s0MSEVC1pofNlVwxpyrxthO27BYAmcu2GQt3jyFosNdCNGxuwtOj7FJ1nbcMv8NGFwvJN2vtAJZddhIbFZKKR6FkgDJBvmkChffBnDYOuFTXVsVK1C0cnPX8Z2OCH8BDw8hdGKUYQDi2P3NpwWz4MevnQSPXxRCktojA0+kq2CTv2QY9lcbl/Afe86xAJpFQwgNUZMuKmJETjzmRubwyDfI8IJjVYr+RQ7qx25I7F1Qw85H3vH0VYqBHffWfE1oq0uYHET+iGWiwU8Yo+EJCFKsQomFdHLS/zIMTWxGRMrnd+qYAQL0Pt3qqHn/nPk8EBdEtt0biq31KTZ5q7lj/QIRvi1WsqSjq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(71200400001)(54906003)(316002)(6916009)(33716001)(508600001)(66556008)(2906002)(6486002)(966005)(6506007)(64756008)(38100700002)(76116006)(5660300002)(1076003)(66446008)(8676002)(66946007)(66476007)(38070700005)(4326008)(186003)(91956017)(86362001)(8936002)(9686003)(6512007)(26005)(44832011)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JRqQA3AqFKSCs+qDXWVzrSpxDg5M0ao7+ATl3UifiCcAQdB9UN8x4cWIjV4H?=
 =?us-ascii?Q?CWSNfTUGSDuMN/NlElidaHk4ftC4qZCdfzGP7nr60TkqRDPm6Z8bXYP5Kfmo?=
 =?us-ascii?Q?KSnoWJ1lXW/tUSNnYty95pIbEeWZn0iBV6RGL8Uv7F2zGOapVe170svgg1Lv?=
 =?us-ascii?Q?+zFI4yWWLwRiRUOwDYKNNCbwxRqn6TH1Pji4n18I59nfLKIAJEhqUtcT1xUG?=
 =?us-ascii?Q?o5Oj/647Joop15CjgJVoDLeAZDiAsLB5/Qc5yvUHucNqQFc4XnJ4mBiGkUUE?=
 =?us-ascii?Q?HcN1khA1QneCAPZkt5DZlRZbOkND58YoCC3sUSym7RGIfV1pTGbZwm3MVg+b?=
 =?us-ascii?Q?o7DzrsVQPvTKbNfEkslL4/Zne2/VpxC9lcvWPLZzLRIUAGcQJeSI9le7mkvR?=
 =?us-ascii?Q?9xEdG0+poQWq9tfdmqfLvcwqIrADsBti3OdXxpj9a89GXHZqlnn1R4cMJ6Wb?=
 =?us-ascii?Q?xrJK8RHq9T0PlPj1B2J7B8HAg9WX4twBB+L8Ix2kfOqe2CKFpd+q2Sh1GNgT?=
 =?us-ascii?Q?q/pxsClxRyrVBJWJDj073GmSQcYcluuq92qUloht/bU+mfOWLejcAQiXM8J9?=
 =?us-ascii?Q?JiqtroyJt4/nXOGPA3rNz90sejJklWgRlOpWW77Plus8QN3qNpYno76V78AJ?=
 =?us-ascii?Q?2cdTD+WZfLjOhT5r0y57YUPk7vrTJx0nWsz191cIhhdVaePjdQC+Zj5X4kvL?=
 =?us-ascii?Q?St1HHy0Hpc2CtSXh30LTWyyxM+X2fnI5l30lUISayIOgR4i7nlmzoCx6VhXq?=
 =?us-ascii?Q?sk+qfzydQMoqHMlLv6+ZO03oEZ1ZIVayYXKyTRKsyjDIPuqKr6/TMazJ82jZ?=
 =?us-ascii?Q?/N7KFXj+UWBYR0W2QTwy7H5EsILRY8UsDHjIxMs5xez89APRvunQbvkz9w48?=
 =?us-ascii?Q?2DWHLP8pkJkBNB9lMW4ppWa6evWKMJfVpTUuYnJYPHrts5LRHOStJuJOiOki?=
 =?us-ascii?Q?BEjzSU7myTzXuRvAnE1Ai3Unqdnqi98usPJXKhMVRd4VVO1iK6pKr3OxKd/1?=
 =?us-ascii?Q?5w4TvmHa/aWt02dGjCgwaR759JMdTE/aHQYMihCFZm5aprvUEqrwvwQHDjJ8?=
 =?us-ascii?Q?jGCUrNSqEgK1iWpY7La7YWHXuxxptP9VDXBwhD/oDqJEOnNhJO49/aCtQe4m?=
 =?us-ascii?Q?SsKPj4P3FXoRZhL/1GW5r/cfiystgA2k+SQRRMMiAo/s00j/REQnAoYQl1zs?=
 =?us-ascii?Q?1VsSqmIxuWbg1JgWDcM+fNgVjn+WM8MdoFZmGei4ni1lGwfIhiDDYR0hQlyE?=
 =?us-ascii?Q?HRUcL9Qmk60lXPnMYBjz+l4BcaF0OxwhVIyutz4/48BkChjoTq3Z4BhMvEro?=
 =?us-ascii?Q?sYFxg77UY5B+cq5x89iRAlmjg71VzrXivfd5wZqXibeCU9wEeVwhbNZU8kJX?=
 =?us-ascii?Q?txf+Q2Aw4WhsULheZa98F/0UAoRp1wBLbYNsAW4KkjWc05Q0OyaltVqhLO/H?=
 =?us-ascii?Q?NVDZDWSyPlRxLvXjnpghdo5gofygI+qW+FEpHoLjT8DAPCncegzDm39tlcUk?=
 =?us-ascii?Q?tSHanZ2AP5Z6ZkYL09Y+TjgWsLrnyZ602c1eiEkZjhPgIBHj0YaDP2wLQizp?=
 =?us-ascii?Q?/iQ/xGU6GOqMrD3H1QVUMV952uGmRGKypqO/LWR3MHQEsHMVhHrkNMwt5jur?=
 =?us-ascii?Q?7P8VZrtRtYbYVwvIcoFkcuOjj1vznlU248jR1f8PYU3+zliisUYzB+4SP53i?=
 =?us-ascii?Q?F48y++2nYSYppBFv49o4ZBIdaO8bwlDq2a2NLtLI/onG57P89qZEWuZ32lzg?=
 =?us-ascii?Q?q8ntH0HCFDAqjuFnQ0heYPJPlN8fbHI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34D46952AC71314F91374700E43B4FDF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fde179-0817-4196-c23e-08da29fbe243
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 16:18:23.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5TkDqCrI5fkinMAUEGiclzsVyhb0Srb5RNFIfR20bPcNZAYwL8SZjn0uvMH6r+Am/GxO3yR0sEgKJpbPBrk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_05:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290085
X-Proofpoint-GUID: VJtEmphzD60-PsiOhbCeBQLBubcmkUez
X-Proofpoint-ORIG-GUID: VJtEmphzD60-PsiOhbCeBQLBubcmkUez
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Heiko Carstens <hca@linux.ibm.com> [220429 09:19]:
> On Fri, Apr 29, 2022 at 01:01:53PM +0000, Liam Howlett wrote:
> > * Heiko Carstens <hca@linux.ibm.com> [220429 08:10]:
> > > On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> > > > On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> > > > > Fix mapletree for patch series "Make khugepaged collapse readonly=
 FS THP
> > > > > more consistent", v3.
> > > > >=20
> > > > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > >=20
> > > > This patch causes all my sparc64 boot tests to fail. Bisect and cra=
sh logs
> > > > attached.
> > > >=20
> > > > Guenter
> ...
> > >=20
> > > FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> > > bisect, but given that the call trace, and even the failing address
> > > match, I'm quite confident it is the same reason.
> >=20
> > This is worth a lot to me.  Thanks for the report and the testing.
>=20
> Not sure if it is of any relevance, and you are probably aware if it
> anyway, but both sparc64 and s390 are big endian; and there was no
> report from little endian architectures yet.

I was aware they are big endian, but thanks - the more info the better.
sparc64 is technically bi-endian but I think everyone runs it in big
endian mode?  Is alpha the same?  There was a report of alpha having
issues too. m68k is also big endian - but also nommu, so that makes
testing difficult.

What I liked about the s390 report is that the s390 is very good at
finding vma issues since it seems to use move_vma (among others) a lot
more than other arch. I've built my maple tree + v5.18-rc2 and
successfully booted with KASAN and poison on the s390. Andrew asked me
to respin maple on top of one of his branches with the fixes rolled in
so I'm going to work on that while the m68k buildroot compiles.

In parallel, I'm running a (very slow qemu) install of sparc64 and
trying to figure out how to get a qemu setup for those. I'm trying to
follow what Guenter has in his repo[1] and have found debian ISOs[2]
that may help with some of these targets.


1. https://github.com/groeck/linux-build-test
2. https://cdimage.debian.org/cdimage/ports/snapshots/
