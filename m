Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B831652A598
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbiEQPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349601AbiEQPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:03:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E092B42EF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:03:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HE93Fe020449;
        Tue, 17 May 2022 15:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YdAObtsJ3prGJnblaBtB8aMkFc/YgX7LQeYWTIbotf8=;
 b=D5xnD5G6n6BfKPk+3EQB4jdGAeKpP6ouNw2EKyw/5YWroSUahJFpFtjOTcpmD6yEM12t
 ZtLcts7IRJp3DZK6w7utNsvUIXDCmGr8P54KNRmM/LEFiYPeD59nzrku+Pc+Sv20PTt4
 g0Lt2sS18E55lUnf93rkqcpaK7AeCIu1UpKOT79zqSYJ1Y49vbUI2LbArLf7SkfkuJ6k
 uzW/t1leNrc6DC6QgUHjn2NFVd0y48fQQEjleJd5Xfl2/ylX2fL7Wo7ALhXeeXyTnjUi
 VNMEbbgPnVJTs887QvdiymwO22mDnmVUQDiGCiUZE//Jh+Q1VqsQdEdrBVg2EoGyxC1S Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc6dva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:03:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HExwLp035445;
        Tue, 17 May 2022 15:03:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v8r2nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvbbi6CZfkJH1Nxf+K6Gv2ZIBd7HfXRiVhdtsRbxcTQTumBRMweGyxqOUEpRNHnC90WV4MsTdP0sh+NHrLU9hRupizl8/4yuWP7VFH9UYj+ueWbuCYSdxlEBTjtzwdpPOOsZ6xFsBQEPDLdcAoPTKHYkwCZPRMsE1zUPI9GGQeRFe6cdD9fe9H5agzdUSHZ88WE6i2OG9vCd2ZBxKmZPkDtLNzLqkfIagxXCaokkuCe+MmaZT7CWYjZR6HDr+AbUQpYjAvVnyp2JmH3N6lpVIrINwZ7i9TR3Qm7zJOBobIxvzQJ8ksZ3JnfzoecZ++/xaUVuUDA7KLacbR4Yol20Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdAObtsJ3prGJnblaBtB8aMkFc/YgX7LQeYWTIbotf8=;
 b=iA8GdIAFPz5F7xyYf2vLjN5VOQ5+PJEoDj2OpZ9dgB9s0r/PMZgEi1sggpi9r3+Ip6rxE7ZdkihYkTWXw9oGDm8YjYunrG1iK7d9YxMTh1JYpyND3DAbopXcqh+AJ/yemTy30SHwVxFnC/O9ifVgJicvlPY3fjXn7/0O8W3NfXBS2RSlcCej/IRrDI7WGO2eYxr+tLyLcLH5gOS/9kD34DqIcD6WP5SZhfzF6ioF4p+AHZaD4pftcbG64me6XCBlObQ7qjqMmp2IR6WM4W0bE4o0MEGY5WaBQFvVIU4cGCCB1C1iWI9hSjpVQpjB4NVdC2jqC0kC1j0NZ7Pj5D7frA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdAObtsJ3prGJnblaBtB8aMkFc/YgX7LQeYWTIbotf8=;
 b=ApZf7RsvDNdJhHxnhR/U2RZ+fb08ogRlODAOmVttbxR4cvKoOW43V2xsFBBIUisOKe0MPiZxuWaaSVIVHst3hSANRr+foFO5ONZpv9/07uj9u2bCV5WqX7xaYT9iDigixRY5kvQckGh+1NZRWbSTNkKrYdPhJFhivTYvSJkfm3A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3671.namprd10.prod.outlook.com (2603:10b6:a03:11c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:03:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:03:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAZIQCAABv2gA==
Date:   Tue, 17 May 2022 15:03:28 +0000
Message-ID: <20220517150219.7mshct4jkne6c5el@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <973b908d-7098-cbae-8046-9a42cfabd570@roeck-us.net>
In-Reply-To: <973b908d-7098-cbae-8046-9a42cfabd570@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8386cbd-bc31-4b89-d674-08da38166690
x-ms-traffictypediagnostic: BYAPR10MB3671:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3671206FEB4197AE364116CAFDCE9@BYAPR10MB3671.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k68wBBB67QEgF1+eCr9WfHmfNebMgizaPwS4+GOzEkLUwVuDMN0yh9/XuMIU1TICu75zaVHhlc0TQqeDBVX5zHsP4MjxYrOM+nuy6UePPE/3hL1ts/cTHx5SruVme4REd7Xnb2f7xFeLxNqbxdQ/uuEBU5Y1/OCxco7i3w7Zrx+VJ7LWOh2SDiy53ackPVCN51a9a2hSnbAnQag7BPbQnWY0U4ZxsvP5sV25W+0xAdiPwapP32BdJGsEGDH+MtY53ylj2Ph9LLqe8GK7rJoqJiPEUaRWDLkptuUXy6slot+Y7YSn7aqhaPc+aGz6qPICZmIf6uRsnPI9viidvS4/qg7ebLrcWz/b4xsJPk7RNMIzOqBFIy0BkExP0huqOFTzlSm7Jd3ipRAYULQdc/eCpOYdq74YfnWdsFJX1DvNWWREcWdDNk+03NH6twxcakLIkeNuTFaQGrgM/h7UCyDYgUxWaVvgp9qAVt0VjNZlerDXqnPkyJUbjyZlHC9pPCivRkowLu/oqlMKWu2jEfvY2RFwSKAr8Ff381exXJLycyRspEjT+IVP9ZGxweXGZspNZcW7gD/HX1Mki4PL/DiIsEHHcR+8ibiJQdkz/MLW8/0FXLmYKl5KnYGbFFX8bosSFiBCCHRj8hZGC6uBYO0OkKRFvYN22cGb7P2EY2HT7WV8GUNshbwjrAj6d0oj4JXXyYEFMb2tKqb9WWo4BuZ0pptbNd6AiR8WGoKhBKzsN6+XDswLq8t7f4oBCqO7ign1sNrur0FWCAOb42gOdsHiATuf5g4BVv6wTpg/m1VmGJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(122000001)(9686003)(6512007)(54906003)(38070700005)(38100700002)(186003)(1076003)(6916009)(316002)(33716001)(83380400001)(86362001)(71200400001)(966005)(6486002)(5660300002)(508600001)(91956017)(44832011)(64756008)(66476007)(66556008)(66946007)(76116006)(8676002)(4326008)(8936002)(66446008)(26005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lj4GxjC5tvd+ky7H4SbWZNvA/+X36OoZpCDCthDqGbRaCJ+rvGg2Aa+7U7Oy?=
 =?us-ascii?Q?f/LiXr7pXke5tDWD1HsU/AmStSjmTedJcSaZUkykJwPGiBmP+4oW6upUKa5X?=
 =?us-ascii?Q?ig4y5kT6AYGGUfvk4pl+yc7ebeIw4tby5soxGr6s2yCfKcMWY4a//km4Lpnf?=
 =?us-ascii?Q?2Ja7lAvpzjQb2GpH1JQ9RRsN6DJ0oN9xVkuGpvCNrTAHwMwMjDERlvBnlxFX?=
 =?us-ascii?Q?67WWv1Xah2xeqSVqM/lMNXg2oBT1yrtNidjtmn7q3ZdwdhHCQHmX/59poWf1?=
 =?us-ascii?Q?LZ5tKZ68GQMJldWTLxbHcCjDTepuP8nnMnJkuiT+HCOcYZkYx84eMlMJWxLg?=
 =?us-ascii?Q?9leVEqvpIsj6HROWXpK+TNhZf6AN7Sx3sbenKDRm3jyNUY0ndoiYv44Rbs+X?=
 =?us-ascii?Q?mlhMFvxyd8FhA/lYo5oUETnLCfID1/E4B75QpxNUD8QwqOyBqV+KuGgpyf6W?=
 =?us-ascii?Q?F7CNyhGDsaEGVibftUqAeKyNJDFTDO5+IijlbD4vwrEzSIhZEl1+Ia31+4QG?=
 =?us-ascii?Q?+pMqJBTG9kMQ53+T6q7G+gmJVOlVmY4nF0F7YQolNc/EHAu6nHy4vVK4dxwo?=
 =?us-ascii?Q?DUdqfoQWQunqetQ+2HVZTmECR3lV7iNMcG8YN5PeWHswzRkzpxiTdrnHqrFG?=
 =?us-ascii?Q?BCg8Mg8/mlN5Dehh4i9xhtaFeZgBTbXdFAvnIjziqKEltMbb7AMevcdllwyA?=
 =?us-ascii?Q?mp9D18YYamT7dMXqmttJwdtNh/CkpO9KtbN/7Fu2Pjja8PkJlxBvnbcAuWoY?=
 =?us-ascii?Q?wgpafIVaW7n5DR4T+3/JepEAOF2+9zgdWDPS6u48qumgZBz7D5LKnlcFDbgC?=
 =?us-ascii?Q?eh/echDCiH9gtk8ZpK8+G4QgvlG3lzl+6ZoVWx4LGqm+jY/CkwQgkbZIvhB3?=
 =?us-ascii?Q?yRWoZ0eC9RMb84usV+xsWhJ9O0cu1WzUPWjTIjYUEB5kov1f6NrY2h97zyxN?=
 =?us-ascii?Q?VodV2DAhKQmDv+j5txgI1OD5iR+V6ap9Ct6NhAkmiN5v7OWKym1Y/Zk0GL2q?=
 =?us-ascii?Q?wdUtVCZgWnBWlpWsaTtwknnOyU/IzvWimeGIQzVkb/NW6NhOltkTDY6pAjz1?=
 =?us-ascii?Q?koB3ZKWpE0yiBNt3migNN70lj9N1X59rhEw85XyZk9TRHOTQxinW20eg6av1?=
 =?us-ascii?Q?q2NzSUSS/XAZ1F+8NWdtRkwiAbgLsoZmFKsuvDGLYlNIHG8An5X96nIGHE2B?=
 =?us-ascii?Q?AcUO1A7NwDHjAFUQVSpx+Wsq6YsyJgyKGL51vRxGNywZ9ezRzEsS5hy7L5Gl?=
 =?us-ascii?Q?0N9hKjgHMWaVzxMNm1R9tiAtCp+6qCFG+pIbQDkseTv6qruB1zMVH4nO+JXv?=
 =?us-ascii?Q?k2Jd4A527vTozPCWEeQWu7aXeaBC4MhBKCSaiMt7KrFv7KHITXCnvlw/LrZn?=
 =?us-ascii?Q?V0DsFpMoEWG2a//a+hVgcK9bqAp1oUozAZTBwO5NGh74peOK1lhd9Rn8Gigx?=
 =?us-ascii?Q?Hrx+GgLCgaS3PUh9nrOx2XhSfzmxSR/LNdtt+Tq0gAe7sPm5jFHHC6hVrcCg?=
 =?us-ascii?Q?9pQ2AUI5GxY2uu933y51Lk/p4GSHZrWkyaLY3JAOaHkN6cKMsuS7M2UGKswR?=
 =?us-ascii?Q?SQLQ+uUzHQwMiIeOQdRPpBsKPq+xTbbL+H87Pqg5mKKlcE97p8KtQ2FJWeuo?=
 =?us-ascii?Q?2+waStblvkxpS7H20s99w/fSNb/PUwyNLZfV9aUXghQXX4XBzJ4++NfpdY1R?=
 =?us-ascii?Q?xX9AHz1WID+nr7i/gt0Spd3lbAaOXsG59aMFubyb43OBEI/+mVc4ZWSmG4II?=
 =?us-ascii?Q?ngQmrVBI7YF0A9u9DjtVY3MeY5zFttM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85A2F624705EB34B8AE8EFF6AF1ADEB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8386cbd-bc31-4b89-d674-08da38166690
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:03:28.7081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQIxNOkvIG5w+BeKc7k7l/KOB8HRLtBzeUNcfDxkGOlNMOYlA3T+3l2emSb+AYV31Q3Gf5NpoS4+X/wAAT4Iqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3671
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170092
X-Proofpoint-GUID: q1xjdHlTWoQx8DAlCaOJnmt39-TLvbC7
X-Proofpoint-ORIG-GUID: q1xjdHlTWoQx8DAlCaOJnmt39-TLvbC7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220517 09:23]:
> On 5/17/22 04:53, Heiko Carstens wrote:
> > On Fri, May 13, 2022 at 05:00:31PM +0000, Liam Howlett wrote:
> > > * Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
> > > > Heiko Carstens <hca@linux.ibm.com> writes:
> > > > > FWIW, same on s390 - linux-next is completely broken. Note: I did=
n't
> > > > > bisect, but given that the call trace, and even the failing addre=
ss
> > > > > match, I'm quite confident it is the same reason.
> > > > IS that issue supposed to be fixed? git bisect pointed me to
> > > >=20
> > > > # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
> > > >    'mm-everything' of
> > > >    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > >=20
> > > > which isn't really helpful.
> > > >=20
> > > > Anything we could help with debugging this?
> > >=20
> > > I tested the maple tree on top of the s390 as it was the same crash a=
nd
> > > it was okay.  I haven't tested the mm-everything branch though.  Can =
you
> > > test mm-unstable?
> > >=20
> > > I'll continue setting up a sparc VM for testing here and test
> > > mm-everything on that and the s390
> >=20
> > So due to reports here I did some sort of "special bisect": with today'=
s
> > linux-next I did a hard reset to commit 562340595cbb ("Merge branch
> > 'for-next/kspp' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git"),
> > started a bisect on Andrew's tree between mm-stable and mm-unstable, an=
d
> > merged whatever commit was about to be bisected into 562340595cbb.
> >=20
> > This lead finally to commit f1297d3a2cb7 ("mm/mmap: reorganize munmap t=
o
> > use maple states") as "first bad commit".
> >=20
> > So given that we are shortly before the merge window and linux-next is
> > completely broken for s390, how do we proceed? Right now I have no idea=
 if
> > there is anything else in linux-next that would break s390 because of t=
his.
> >=20
> > Even though I'm sure you won't like to hear this, but I'd appreciate if
> > this code could be removed from linux-next again.
>=20
> I finally found some time to bisect the alpha boot failures in -next.
> Bisect results below.
>=20
> Guenter
>=20
> ---
...
> # first bad commit: [f1297d3a2cb77261c10fbbd69d92bbca700108e0] mm/mmap: r=
eorganize munmap to use maple states

Thanks for all the work on this.

I was able to reproduce on a sparc64 VM.  I was returning node metadata
in a rare case.  I just CC'ed you all on a patch [1].  It should apply
cleanly to whatever branch you want since it only changes
lib/maple_tree.c

1. https://lore.kernel.org/linux-mm/20220517145913.3480729-1-Liam.Howlett@o=
racle.com/

Thanks,
Liam=
