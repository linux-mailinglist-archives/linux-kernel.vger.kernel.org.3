Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE8570FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiGLBt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGLBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:49:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2F2AC5D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:49:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYnGR001823;
        Tue, 12 Jul 2022 01:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=70VnACj4dQ3VEkvuqpC4sR8E/kz4QTh2t2+ddhKFx8Q=;
 b=YqDvnvsFV0DBeG71QLPDP6LclFKJbJ+r1vPvvDDrNOD0yIrYa7cQoCtZUZEktsdLvTfq
 HC8cZVoa6EDKa5/cfR6e9H6WHSaJ6VcP23NgJ4QXpofe5rnU6Rg7eqfwLgS4GQLnBtN0
 pBjFSjnFuY+TMefYLbtdorjDOSs3c7daY1pTnoH3volussof1wIzL+W5QofCtyiCWL/I
 MnanHCoLMD8pBadR0qCBH7Fhqbly3wN8o48fPmawsVv2DLALcVhhnK1BpuloMId6wt8h
 yV7Q01brzf+bulQE2B8tjI9jw2CNA86oCImaUsW7AExMlNHIDmN/ZoViVN2GKsnTRNG8 Ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrd4kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 01:49:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C1fHOJ028175;
        Tue, 12 Jul 2022 01:49:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70436w8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 01:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8zDB9M1rswwgg3pBAzT1avF+UtsBI2+Wz4P73EhdWFs87N2fOeOBpgWwcwWnuUc2AI5fldVcdCYqTH/zGB/Otd9HLKSP3/qeeVmrPjJmux2S4lF5fXQD8/GitNP4s4VY9RZthhB8L5prCD6+B5yyYVu8Njx5Z0c/LDQouoeYcDEQRUvBPGpq9vSCb2qSPN3xwG2VA/WTEdZYU72P44/xJgoYcKmseb5udGGgm1bL9H6XtSmFfzPlOJU5gyvnkbkwGchsefC+LdaEMnNcD/DSXnPqOKQr5442RnND58crA4WzgN6CG70vBWlXPGQ2ccNfd77DStuw/BhF3GSJ561tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70VnACj4dQ3VEkvuqpC4sR8E/kz4QTh2t2+ddhKFx8Q=;
 b=VPD92e+6hIY74s9ysuFyk3sR3jpQ/s0uR2QOUJgxdg7DK6qjmtl3zX0NG7FBw9hqWuUBdUPDckuAEkhAPSXQV7Q8S85H5HCtOkyi8JOz/7rdMCQJb9OZgfVRB5CLIcTRvS2PDZ37ji1Ne1S+FpOmM/i8yBH8OPuSFqbd4dAPEtvp49fdOPS/RX0x/hE7Bx0hGQ5vVqmicIYNz1rPALgA+vWYFjwEKqRCBFx5A8A61VyFGPbkngF+jNFT6jRwWVbRRW3iBYAeBdMC3xZa5dnrL12k3mX5hqDPC03NW6wIk5OJydxj/opw+CgBpHh9iOy0c2A0rCJIvjvmrx2Zhmrisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70VnACj4dQ3VEkvuqpC4sR8E/kz4QTh2t2+ddhKFx8Q=;
 b=dkBtaN9PN/eGhQSKMkwxg9o/AsTkzCqUmL1xoxTSUvQTkox4DBU3vsqPxc7DnDXGoPOJTTYKi8+COW58UGWgaa2E5oLlqlo/N9YUdzyuY4gvxPgXSxsV9dT4lwSy3OZMuNToIYFDvkJ5Smv/louLsxCkxoit4N3zbSA5QBv7EXw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 01:49:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:49:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Topic: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYhbALqTBpFGf5+k+LdWHoM0UZLa11v9cAgARX6AA=
Date:   Tue, 12 Jul 2022 01:49:12 +0000
Message-ID: <20220712014902.3lfeaebfhyc4eakc@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-14-Liam.Howlett@oracle.com>
 <YskuUvl55iK+uRWf@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <YskuUvl55iK+uRWf@tuxmaker.boeblingen.de.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 488853c3-2536-43ed-28c3-08da63a8b8ad
x-ms-traffictypediagnostic: IA1PR10MB6267:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZW6o8rT2VfLxk/Qe3j+mD4LOxrWibGPoput9hnu8mVH8WYplZNfMz+yvFd8/sQOL+JQzofM+dKj7Yd8GkYR7PvAtk6SvP9AWwM1SkH0WRm8dsj2ZAIhsWUmkG18bo2+Iy2Vwn/FIWuz35tyigHFSYnWSWwN7F0j2Yilc6Xd4KNQj+3AddWtWWV8mCfHqrVx8BlpgM1apNGf0bngkqCkCrVJFqlRundh1zwsrAcncuoZltB+QYS9V6z152z6ZrRWiZgklfIO4aAyYcCithAL+TNtaO+rTJumOuLskaKuQS+eHiBzhqnBkAmfzogJwwPU45gjKTPlzCWu6BTMx1Xku/d4tsraEe6KboGsx8xo90UmKNAGSCcw3D+7h11eHjt82O7WPHAspIE3oQ8Vv6EENVJW4PrefE9eqD41P7jU8KCBfyFFBWyU/dZl8NlIbei6Rjhihm6yjhu61EUOZp6bBvQ1XoJYb2TuCXlyQJTMZPYa4UUxURBpy/BtJUtwEUx7SAz9vAHrDJh9SiailJ7AouZInNscv7Y9uFs30zCso1vNE36G41NHQ+bvPgulhlw6dkkzs3q2gGlzzLVzvQYOtb4PJzk3wtWQ279Ien2VIWjNmR+7ZQTsYS5tUUAUryGhYGCBBnHYyKGdJfd+FxRM+fpzGBUR3MGkCB3RQjJDx5GxrXtM7ZtKXzXi0KiNHTJPg43irQdzfWR2cjQu/YatbCCsPqAbIOwcxtLT82piJrFqyOLEQhFnqfzTtKMIqwffSL+BHKwpZQXODJdjuW86gdIuoOPdno+x1o5H6a8YsnopLSvQPKG0N4DrE5FS4cNPP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(38070700005)(86362001)(6506007)(76116006)(2906002)(122000001)(54906003)(66446008)(4326008)(38100700002)(91956017)(64756008)(33716001)(316002)(6916009)(66476007)(8676002)(66946007)(66556008)(9686003)(1076003)(41300700001)(44832011)(71200400001)(83380400001)(478600001)(6512007)(6486002)(186003)(26005)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x50GYLpH1Bc8MkEQI5DBHQ7TJUaRaDhVtwObYigc0iSlnx6cmPx/F7wKXTU5?=
 =?us-ascii?Q?qwoSsTezWB2YWD4OqAmXVHmRDxO/k9XENqIvZrBO25Z6QU/SkHDl1AUATJtS?=
 =?us-ascii?Q?t5yAYfaHACRj3X6jrd4L/pk6HdzkhMyjF+YlgP5x0bxWbjg77hdLAw5wwmQf?=
 =?us-ascii?Q?bXcnotXSzkaDQGNPpCDkV5xUdo1xy47szzVhO89g2/k0O+iKJ660M3sCHgde?=
 =?us-ascii?Q?cenSX7kzubexlcN+xmmaSNdHNHWMqHD8Fj8pG1fOizoosbG5ulwp2kd/ZD12?=
 =?us-ascii?Q?X3/b0ygJBHQnQ/TFPPoLobiFA9vBBL6pqASNnM+Ct/NAaiTyHJuxlBT2SvlQ?=
 =?us-ascii?Q?sYm9q0VWGlJE+GTikgWucFup3XHLoESWfKhY/BZYuPoF2L+PI2vJhB6i68Hk?=
 =?us-ascii?Q?YOCE7QNm7fcHm1F20sO2/RKA2QkMUuK0yOeIKdCHNJwbrLRtenHqq5VX6wHC?=
 =?us-ascii?Q?7UV4ZZv3WWwaDbbJRj4qO9co8ZC5/VzQOI+W+FHcJ4pcW58eFQSMo3LEvgoN?=
 =?us-ascii?Q?J2tmlNCtXzUW3Ex5CnP5pzDGl2vOoLEyION21e5Qh1c4CDI4cg/wAp926/LQ?=
 =?us-ascii?Q?J8gk0xw1N8tN0B8LRqfUmpjhPUi2lOwLv5yWS5TZJho3fSeucXILhcubGPqH?=
 =?us-ascii?Q?JlOTnK6YOX0qSIZZ+2Y1pCH3HNykcIsyF3KMLV0v5WGUd6cGpUylZDnltV1N?=
 =?us-ascii?Q?K7KdCyVzt6G9DzX+SeUEYbcoB8vdVDYl6AfKDFZi4h8VDknV28tcYXqutfT5?=
 =?us-ascii?Q?M+pXF1iF7a6btbfwsS6IqvHciCRrqMaijl+e5FvM7LA8v2RrJNnV9ei/fpy9?=
 =?us-ascii?Q?vysQIAPO356CfOxWnvcNk/cXnOU6RSlZpC//cwxWue65g/egB+c8GkkWCpA7?=
 =?us-ascii?Q?bWtM8O5M+pDQC2vnTBCOvUB1vI4wRTVzKX19gcHCyOrt8sV9bYHSMPI3A6az?=
 =?us-ascii?Q?qH0nDQkYnDB/Tg8k+9PbZuDqk8CxqIkvNwulfoEYH4SYsVef+AQTLUI1Xp+l?=
 =?us-ascii?Q?cRv+h7kPU4z4K2u+N/qKaNQnUkDsbvQUD6CguYztFb+kxZY43BeBjjk3AL9O?=
 =?us-ascii?Q?yo0TUAYopPPUryTZS+8H7XQwL0xX81vtnNMPhOUGWQDpUJmAtVl7pyx2iAoj?=
 =?us-ascii?Q?PFhBRjaYqIIArt2RDRWZXOayvQDRVKkvb0DRHFzVZK+jqX5pK1NyIjPP0NbT?=
 =?us-ascii?Q?T1nfveqLPytmGbcEjGJnR1hbK2uRSauTVVO0RyhBZpSOxAaFI/nwXXEv+c3y?=
 =?us-ascii?Q?Q8kPEA9l51TcMJiz7iO+c2rvLXruOaK6P9CVDsE6wXZ0iaRRN2ZxLN2RUq7N?=
 =?us-ascii?Q?km5tca1Ku87cv1LmgF/FaecMEk/JMGAWNUlXSvLDyOvPPU6gx+EhZfnOq0KT?=
 =?us-ascii?Q?QCerQ9GBrjaeNt4v1dusUg4duwrL0kdNAonbTul3DDECKEKbhYtcWf93kmVL?=
 =?us-ascii?Q?xoAQB01alkxvRNlPR08ZIpi4Va06NF5sCvZ5niTpH+U20+0178LWwMcMLlcL?=
 =?us-ascii?Q?lyk9vZYSjdeoGbr6888j/Rblm3dw5T7BY1uB/Dev57aX3mNa9TzVfls+TA9n?=
 =?us-ascii?Q?4BQX3LP1nB0X/Ed7K0jxii6YnPqDY40+7RBlNUzH6GA9y8gB+ymFzA83a9cZ?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5F0FEE0335E914598D8C8B17D20AEEA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488853c3-2536-43ed-28c3-08da63a8b8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:49:12.9889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neXgzhUFOE2zvt4YME65zXL2sk4yWxc6EaCv//47k+0bWZhZqwNaZz/8STEC52Q3LnPalYd0fmOUYe1LApXgZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_01:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120005
X-Proofpoint-GUID: DXglZrQf5khpe9kADMOZmorbGW1ueoe_
X-Proofpoint-ORIG-GUID: DXglZrQf5khpe9kADMOZmorbGW1ueoe_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Gordeev <agordeev@linux.ibm.com> [220709 03:29]:
> On Tue, Jun 21, 2022 at 08:46:55PM +0000, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > The maple tree code was added to find the unmapped area in a previous
> > commit and was checked against what the rbtree returned, but the actual
> > result was never used.  Start using the maple tree implementation and
> > remove the rbtree code.
> >=20
> > Add kernel documentation comment for these functions.
>=20
> Hi Liam,
>=20
> With this update a user process crash is triggered on s390 when
> the below core is executed (derived from LTP fork14 testcase):
>=20
> #include <unistd.h>
> #include <sys/mman.h>
>=20
> #define GB		(1024 * 1024 * 1024L)
> #define EXTENT		(16 * 1024 + 10)
>=20
> int main(int argc, char **argv)
> {
> 	void *addr;
> 	int i;
>=20
> 	for (i =3D 0; i < EXTENT; i++) {
> 		addr =3D mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
> 			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> 		if (addr =3D=3D MAP_FAILED)
> 			break;
> 	}
>=20
> 	return 0;
> }
>=20
> On 4095-th iteration mmap() returns a normal address, but shared
> library mappings go away. The page tables seem to be intact as the
> memory is still available (I did not check every mapping gone though).
> In addition, the memory contents of disappeared mappings is zeroed.
> As result, an instruction that follows the mmap() system call turns
> into invalid operation code:
>=20
> t35lp64 login: [45116.631391] User process fault: interruption code 0004 =
ilc:1=20
> [45116.631403] Failing address: 000003ffa580c000 TEID: 000003ffa580c884
> [45116.631405] Fault in primary space mode while using user ASCE.
> [45116.631407] AS:00000000e75fc1c7 R3:00000000e758c007 S:00000000a3e01701=
=20
> [45116.631411] CPU: 4 PID: 1745 Comm: mmap Not tainted 5.19.0-rc4-00162-g=
34de4ebd5706 #36
> [45116.631414] Hardware name: IBM 8561 T01 703 (LPAR)
> [45116.631416] User PSW : 0705000180000000 000003ffa580cc38
> [45116.631418]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:0 P=
M:0 RI:0 EA:3
> [45116.631420] User GPRS: 0000000000000000 000003ffa5af4040 000003ff65afb=
000 0000000040000000
> [45116.631422]            0000000000000003 0000000000000022 0000000000000=
000 0000000001003e00
> [45116.631423]            000003ffa5ab0b48 000003ffa5ab1018 0000000000000=
001 000003fff5879500
> [45116.631425]            000003ffa5ab0f70 0000000000000000 0000000001001=
218 000003fff5879428
> [45116.631429] User Code: 000003ffa580cc32: 0000                illegal=20
> [45116.631429]            000003ffa580cc34: 0000                illegal=20
> [45116.631429]           #000003ffa580cc36: 0000                illegal=20
> [45116.631429]           >000003ffa580cc38: 0000                illegal=20
> [45116.631429]            000003ffa580cc3a: 0000                illegal=20
> [45116.631429]            000003ffa580cc3c: 0000                illegal=20
> [45116.631429]            000003ffa580cc3e: 0000                illegal=20
> [45116.631429]            000003ffa580cc40: 0000                illegal=20
> [45116.631437] Last Breaking-Event-Address:
> [45116.631438]  [<0000000000000001>] 0x1
>=20
> In other words, if before the mmap() call memory mappings look like this:
>=20
>           Start Addr           End Addr       Size     Offset  Perms  obj=
file
>            0x1000000          0x1001000     0x1000        0x0  r--p   /ro=
ot/main/mmap
>            0x1001000          0x1002000     0x1000     0x1000  r-xp   /ro=
ot/main/mmap
>            0x1002000          0x1003000     0x1000     0x2000  r--p   /ro=
ot/main/mmap
>            0x1003000          0x1004000     0x1000     0x2000  r--p   /ro=
ot/main/mmap
>            0x1004000          0x1005000     0x1000     0x3000  rw-p   /ro=
ot/main/mmap
>        0x3fff7c00000      0x3fff7c2b000    0x2b000        0x0  r--p   /us=
r/lib64/libc.so.6
>        0x3fff7c2b000      0x3fff7d64000   0x139000    0x2b000  r-xp   /us=
r/lib64/libc.so.6
>        0x3fff7d64000      0x3fff7dc3000    0x5f000   0x164000  r--p   /us=
r/lib64/libc.so.6
>        0x3fff7dc3000      0x3fff7dc4000     0x1000   0x1c3000  ---p   /us=
r/lib64/libc.so.6
>        0x3fff7dc4000      0x3fff7dc8000     0x4000   0x1c3000  r--p   /us=
r/lib64/libc.so.6
>        0x3fff7dc8000      0x3fff7dca000     0x2000   0x1c7000  rw-p   /us=
r/lib64/libc.so.6
>        0x3fff7dca000      0x3fff7dd2000     0x8000        0x0  rw-p  =20
>        0x3fff7f80000      0x3fff7f82000     0x2000        0x0  r--p   /us=
r/lib/ld64.so.1
>        0x3fff7f82000      0x3fff7fa3000    0x21000     0x2000  r-xp   /us=
r/lib/ld64.so.1
>        0x3fff7fa3000      0x3fff7faf000     0xc000    0x23000  r--p   /us=
r/lib/ld64.so.1
>        0x3fff7faf000      0x3fff7fb1000     0x2000    0x2e000  r--p   /us=
r/lib/ld64.so.1
>        0x3fff7fb1000      0x3fff7fb3000     0x2000    0x30000  rw-p   /us=
r/lib/ld64.so.1
>        0x3fff7ff3000      0x3fff7ffb000     0x8000        0x0  rw-p  =20
>        0x3fffffda000      0x3ffffffb000    0x21000        0x0  rw-p   [st=
ack]
>        0x3ffffffc000      0x3ffffffe000     0x2000        0x0  r--p   [vv=
ar]
>        0x3ffffffe000      0x40000000000     0x2000        0x0  r-xp   [vd=
so]
>=20
> Then after mmap() returns it turns into:
>=20
>           Start Addr           End Addr       Size     Offset  Perms  obj=
file
>            0x1000000          0x1001000     0x1000        0x0  r--p   /ro=
ot/main/mmap
>            0x1001000          0x1002000     0x1000     0x1000  r-xp   /ro=
ot/main/mmap
>            0x1002000          0x1003000     0x1000     0x2000  r--p   /ro=
ot/main/mmap
>            0x1003000          0x1004000     0x1000     0x2000  r--p   /ro=
ot/main/mmap
>            0x1004000          0x1005000     0x1000     0x3000  rw-p   /ro=
ot/main/mmap
>           0x37c00000      0x3fff7ffb000 0x3ffc03fb000        0x0  rw-p  =
=20
>        0x3fffffda000      0x3ffffffb000    0x21000        0x0  rw-p   [st=
ack]
>        0x3ffffffc000      0x3ffffffe000     0x2000        0x0  r--p   [vv=
ar]
>        0x3ffffffe000      0x40000000000     0x2000        0x0  r-xp   [vd=
so]
>=20
> Interestingly, all addresses mmap() returns before the problem hits are
> 1MB-aligned, while the last one that screws the mappings is always page-
> aligned. Also, the iteration number 4095 suggests some arithmetics that
> leads to an integer overflow.
>=20
> I did not experiment much with x86, but the problem does not hit there.
> The config has CONFIG_PGTABLE_LEVELS=3D5, but I am not sure about other
> options that may be involved.
>=20
> The tree I used to isolate the issue:
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm	mm-everything
>=20
> It (looks like it) gets pulled into every linux-next, so the problem
> is reproducable there as well.
>=20
> As we are approaching the merge window that looks pretty worrisome. I wil=
l=20
> try to get more details on what is going on, but may be you have an immed=
iate
> idea?

Thank you for testing this code.  Yes, it is because I was not returning
the error code which I had set when gap searching was exhausted.  What
is happening is that, because I had not returned the error, the mmap
code will munmap the area and replace it with your requested map.  There
will be a patch for the maple tree in your inbox shortly.


Regards,
Liam



