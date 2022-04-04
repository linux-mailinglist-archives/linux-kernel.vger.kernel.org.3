Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF694F171D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiDDOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbiDDOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4E3F308
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DkEsj004895;
        Mon, 4 Apr 2022 14:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=mz05ZvZyHcXolxjynPEveAWTf8rHqOHieAMfkTVtdY8=;
 b=sCpfUzu9f5FfgbxHqDqlNz/5FZdltAmUHHuBmuQh0Exx5pQf3awH1gNm+hJgmVdQ6FEb
 je4cHWTTehn/nxHikQMwP9lUpE1ig1y669WQXFP8okwV4TGGlnHvrOUcL+Z9Ej4VQMyk
 0LWmFetJ8OgDhXJ5lXkHH3cBb0a9vozBM8qBYAuaIRggTPkuP2cYHc2kNV5+Lx9Iuoe+
 dhMlVmo4GEjbtsanz9OISwnZWmPhZpif/ysfFJbuEu2k7rZYECk0HslACyOl8Z70jToN
 RaZoMw6ZZSqHaIkt3UNjmbeSnwuuEbKbAJsUlQj3xgy1NTKklAztF/oTZoKV90eVT+v6 dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ud09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGjlL012809;
        Mon, 4 Apr 2022 14:35:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2h2f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYysruyjXVyikEah0vIYOdnIDyJhBRV6V0IsDBZ66Hw1agVe1GVeLwmmXMDlPvR0VFWq1eRC9p9EsDt2p4BUJS2rtXgz+DoiuofpalkkKbUT07oSqrjjoXaKokT++f3k/iSBev+4H/KVHRNFEwDVy3g5IIHcuVPWuYXkRoUwo/7UM5Db2TCV3um7egqSVgwZhbnsKUTHvd4WblGCfoXHVB4bzeST7VKJhdSKvIDGQjmp1DcEbQHP20NPXxcPph9nhXcsE3XHY8Y0R+fyvOcBjwuGLqBPBF8igNdOPiCsC1Nbq2ERhMdC1bBPPj7zD/lCwkGb4ZbyuFLmyL3+98V86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz05ZvZyHcXolxjynPEveAWTf8rHqOHieAMfkTVtdY8=;
 b=KyjlgzzLwb9uwj9rfL898zfqIyR4dDayj/WRpzksYNVQG2VewEFCAwRxK/xXdJCA16dKn1rzrP87wyoFI8ls9XCtT6Fvu2dep2JezhVPjBw47HLuEgfiSpVCKhkXTV1guN7agk2MRszdJEZwXfuawS6WDfBSfUbCgja96ekEbptHZ97YIFcUFEAwyyKJ2hBjcG3pTJ7l0Qk3ZbQ530jHxlAvZAfBCxuL1gCde4kDkr7g/K0ieoNPRW9ABLpciMgqR1bgoK73omPP3pN708eqfHJgFvqQPZs0LZBts1TDkG2pXJCWf/iGIdXQH1PlfjrfJ/ozj67kIn3DKlC9R5d2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz05ZvZyHcXolxjynPEveAWTf8rHqOHieAMfkTVtdY8=;
 b=x/9OmtJ4f8+UZQgKCs3RgVEzYp2a+CoBA9llA3RoO9Fs2bN/esICvQtW+nZpnImFNUbQb15fyzsFvwLU5FTw/NRksKh02SWxTYfJHzVBE7sGK1MwDa7UvtoD8UclDMtcWPdd0gXyAfWWv8l7/yc4MpmKl84yDl3AmoyYTvU7y0U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3881.namprd10.prod.outlook.com (2603:10b6:5:1fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkg==
Date:   Mon, 4 Apr 2022 14:35:26 +0000
Message-ID: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4f4e42d-22e2-4440-114b-08da16485c56
x-ms-traffictypediagnostic: DM6PR10MB3881:EE_
x-microsoft-antispam-prvs: <DM6PR10MB388100D4A3A693A13C03ACBBFDE59@DM6PR10MB3881.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNItssLhXYZ4Vd6p2auHPx+exD1lP02CLCddobxf2N/6d9uxwWICWpjKxEW+Rs/5G9z6o9dAwH0HmZL+bNFSBSxEP8oYND2EHPMTfrXW7ZGKAjP3COII/ZiZwsUvgpgpY7Wek40a35R61TwCR/jPjqHNkpwLKtVKFlIb15KFP4bn/IqeKkXwXxiZfWxmqPFGEvupWgP74RXko8t0ZfR1PLnxZppYXHCjCtfVKJJrTyBjJv2Vld89Nyjt7vYxgeBBZIEevpQQnR7K6ohELdA8X151jNhrQ5GFyg1z3AeIXeCWwIXjrf9JamKF4lcQWgABtiTbN4yTQPn18whAANehK/xS8GCkDsDbASTsYxisluouJaCREzPvInP1n4w20hPCgu+4TCIl7ktxeJq28PzROAxCsxoUX8KBi9Qvt0Vw7pNReF39O0p4EJeOBSiZbuhHcyoD9JFEp/KSQUGJgsnfMQcLf8JJIE7bWLueS8yYVa6/WBdunL9gn0sNO/6YSPQQ70RcW7/vSlUAqsQP0v7BJJ1wy+3ME8CafCOXnODJUnUNYtRQrudrLDzs+A8TeHbVgjm5OSdP2pWvZ2FsYUlEMnMe0YW50TdV4RtclCfN2lRe094sVJlRZMV6T1A/GMhgxm4yXmbrr0I5qcrC1furn6Id2HqYvZZM9WTl23CRpeXWDKC+vRGAsWRvnf3VLb5Q0+i6QcA3ZRUEc9N/Ufxvg2ho3YIIjn9PgHRPc2Q7DM9ZYt61kQa/4u1N8FRPH2N49RY8EmiZL4kA0czfiz3aeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(316002)(2906002)(6512007)(36756003)(38100700002)(38070700005)(186003)(5660300002)(76116006)(966005)(66446008)(66556008)(6506007)(44832011)(2616005)(83380400001)(1076003)(6486002)(508600001)(66946007)(64756008)(66476007)(8676002)(71200400001)(91956017)(26005)(8936002)(110136005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IeRmGaxNNHCsvnnNboBTOiCDL069g0RWRuABRklpYbMYtSYPBzmQlV9QcS?=
 =?iso-8859-1?Q?VdYqtFJMjRVU0xOpXDPaGBOyh9d5LTkxl9Oq/3nJG3yU8NAScJYozZlY5n?=
 =?iso-8859-1?Q?f//5CX/1J4dJL2Xdnj2DIgNOLH2bC5lfuxwMJrnms0a4F1OsoTiiLMG0oc?=
 =?iso-8859-1?Q?rCMksLUfUdEYrbsqXuvyJSTlTOtLMt0a//1NM+4RflF4dHYfSi3OiKjnhw?=
 =?iso-8859-1?Q?gdNRCCeQGUwRSPSG0lcKyJQUIEXjRbbXX9ZyL5/fjJp63iqt+nPvOidNcZ?=
 =?iso-8859-1?Q?6C4QxnzAZASa+Bh0qpVRKLbsaEO/+G7HiUgexUcd50iE9Fl7+M8ED3OZtR?=
 =?iso-8859-1?Q?NTNS3Sl+mD0yz2GYvAlkETmCTJcDX0ibUh1GvHj6KTAUYJg7kH1acw43Yo?=
 =?iso-8859-1?Q?hICs14sRQFHJs/WC713+3K68dksf3WebYvV4011C4qob5ko+yQSdPM7PMc?=
 =?iso-8859-1?Q?wIaiOk5FaraTq//DpdFsuGSAnY4XaLrb+ZfyEdCa3+fHjFpdp72CxBUV8N?=
 =?iso-8859-1?Q?2bfN9q4MXolPHSsasTHNxvMl+/SHTbVAFAMfCjWmJKQ6LQm3b5D3wRJLtj?=
 =?iso-8859-1?Q?sTZMMrX91/j4R/7+net0FdP+CV7ui+HTi8vLKfe4iRtJ7zuvq5n4LEcsc5?=
 =?iso-8859-1?Q?9akQ5l/c8Pu8Qt+v/bIXppr/bYUwxMNtxPvVwPponMP4QzY/su7pPuwQHG?=
 =?iso-8859-1?Q?ARJAo/Q+awLCIjPnhD6bx5q3sIS0ISLNUWLdw+8ujWH88kfm7SOJsEUHeb?=
 =?iso-8859-1?Q?owFzVlYe8p8loQJaTYfOVsTwpCewqOiDj1hdfwYMUmxczIfSato6kVik6x?=
 =?iso-8859-1?Q?Ev4KOcMp+cUihM2TPPSUrxJbG6WxTb3PmjKcolKHzDA04gllz2eZtj8qui?=
 =?iso-8859-1?Q?i+TcZa+C3hmqRSWvtdipNeJ249zVwyoGsX+f2+lD6dPdNty7Ft6ViYbzB+?=
 =?iso-8859-1?Q?tY4WyYydTfExU0EAwfA9t0Y0GqtQWKHpT60rrIbOs+2tPfw2vyOeuhVjiX?=
 =?iso-8859-1?Q?erdSR5vzMtQjTUQJjocdGH3OlTONP1SogbQKWzWRMlvv5qldGLQdSNNTHG?=
 =?iso-8859-1?Q?mWYPmfJ9sbBSG0IHqvNRel3tOIq7OHyz5VazKZmYzNwXQpfLYSuh3wSEOs?=
 =?iso-8859-1?Q?0j0moxt0QFf31IBLVRTdkxbdTuAAu018CpgPV9lzSx+jJuxalXNFReLknX?=
 =?iso-8859-1?Q?Q1G9V/1O/QktmquBrM3CLYCfo+DR4SY1zBV+envcGLpax/QzSK8yRr5NIZ?=
 =?iso-8859-1?Q?C7C5tmqWNk6kJliawaDN1NpCj0ulH/aA0BMnUOT8T+vWClBtOdOiQtzDc0?=
 =?iso-8859-1?Q?cUGC0euUbpY1+qXh72nknNJdpj/Qm4xjAk2Kk000oGOfZ7Mz42HyJWO8qe?=
 =?iso-8859-1?Q?wMTslv6wZMk8nkDXiq1mKLON6VFOz/zFvVF87qNbWCj367I73SMdt75P3H?=
 =?iso-8859-1?Q?cKwRj1d1PTpREhkhJBz75ba8HjxVFXG8EnXJ3ZnKmbWnZNHwf+yV6HJg9w?=
 =?iso-8859-1?Q?0ovLWCbKxyPt9k8dzU8W3LGPNx578yEG97FNjVGnQ4UliRbaKaI9drxeYm?=
 =?iso-8859-1?Q?zd29vKdrWsTXod+bgAErPUw5n6KVAIWml2+/HMf9mZuv3RbWj8I0LE5UHy?=
 =?iso-8859-1?Q?Zzayw98DL3hk0XFZ5EitjfQVMZwRFLE3CNlLIzDqQGYH0wTeksxUuGmvAv?=
 =?iso-8859-1?Q?FikDWwizOVnkvwGc4RqmATomE34ytQS/6uTZP2Jo+pLocLIn7vTCGx9sqJ?=
 =?iso-8859-1?Q?enASJkEe00w+Hq6iX/Vujw8dHrKU1YXmlA4eSQfkDIk+yNNeUOO5MCBtkH?=
 =?iso-8859-1?Q?WR7F4XVFkWkQtSqaQg7xg9zT5gqLm24=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f4e42d-22e2-4440-114b-08da16485c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:26.8009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhEk1MHFI40Eyoip3RHP9NybgjyyNkYw+6y6Lp4hYUqhV59nGGwbT5CqXAsP58kq4dfMLlkgUVw1jtg20s4ExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: 5che9HcELhEexYomzchhVe-wAqRt3e-C
X-Proofpoint-GUID: 5che9HcELhEexYomzchhVe-wAqRt3e-C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please add this patch set to your branch.  They are based on v5.18-rc1.

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220404

Thank you,
Liam

Liam R. Howlett (61):
  radix tree test suite: Add pr_err define
  radix tree test suite: Add kmem_cache_set_non_kernel()
  radix tree test suite: Add allocation counts and size to kmem_cache
  radix tree test suite: Add support for slab bulk APIs
  radix tree test suite: Add lockdep_is_held to header
  mips: Rename mt_init to mips_mt_init
  Maple Tree: Add new data structure
  lib/test_maple_tree: Add testing for maple tree
  mm: Start tracking VMAs with maple tree
  arch/arm64: Remove the merge workaround for VMA_ITERATOR
  mm/mmap: Use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: Use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: Use maple tree for unmapped_area{_topdown}
  kernel/fork: Use maple tree for dup_mmap() during forking
  mm: Remove rb tree.
  mmap: Change zeroing of maple tree in __vma_adjust()
  xen: Use vma_lookup() in privcmd_ioctl_mmap()
  mm: Optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: Optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: Use maple tree operations for find_vma_intersection()
  mm/mmap: Use advanced maple tree API for mmap_region()
  mm: Remove vmacache
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Reorganize munmap to use maple states
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Remove mmap linked list from vdso
  parisc: Remove mmap linked list from cache handling
  powerpc: Remove mmap linked list walks
  s390: Remove vma linked list walks
  x86: Remove vma linked list walks
  xtensa: Remove vma linked list walks
  cxl: Remove vma linked list walk
  optee: Remove vma linked list walk
  um: Remove vma linked list walk
  exec: Use VMA iterator instead of linked list
  fs/proc/base: Use maple tree iterators in place of linked list
  userfaultfd: Use maple tree iterator to iterate VMAs
  ipc/shm: Use VMA iterator instead of linked list
  acct: Use VMA iterator instead of linked list
  perf: Use VMA iterator
  sched: Use maple tree iterator to walk VMAs
  fork: Use VMA iterator
  bpf: Remove VMA linked list
  mm/gup: Use maple tree navigation instead of linked list
  mm/khugepaged: Stop using vma linked list
  mm/ksm: Use vma iterators instead of vma linked list
  mm/madvise: Use vma_find() instead of vma linked list
  mm/memcontrol: Stop using mm->highest_vm_end
  mm/mempolicy: Use vma iterator & maple state instead of vma linked
    list
  mm/mlock: Use vma iterator and instead of vma linked list
  mm/mprotect: Use maple tree navigation instead of vma linked list
  mm/mremap: Use vma_find_intersection() instead of vma linked list
  mm/msync: Use vma_find() instead of vma linked list
  mm/oom_kill: Use maple tree iterators instead of vma linked list
  mm/pagewalk: Use vma_find() instead of vma linked list
  mm/swapfile: Use vma iterator instead of vma linked list
  riscv: Use vma iterator for vdso
  mm: Remove the vma linked list
  mm/mmap: Drop range_has_overlap() function
  mm/mmap.c: Pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (9):
  mm: Add VMA iterator
  mmap: Use the VMA iterator in count_vma_pages_range()
  damon: Convert __damon_va_three_regions to use the VMA iterator
  proc: Remove VMA rbtree use from nommu
  mm: Convert vma_lookup() to use mtree_load()
  coredump: Remove vma linked list walk
  fs/proc/task_mmu: Stop using linked list and highest_vm_end
  i915: Use the VMA iterator
  nommu: Remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   218 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |     7 -
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/mips/kernel/mips-mt.c                    |     4 +-
 arch/parisc/kernel/cache.c                    |     7 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/coredump.c                                 |    34 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    49 +-
 include/linux/maple_tree.h                    |   682 +
 include/linux/mm.h                            |    74 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    58 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6979 +++
 lib/test_maple_tree.c                         | 37810 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    37 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    78 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    55 +-
 mm/mlock.c                                    |    34 +-
 mm/mmap.c                                     |  2053 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   135 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/include/linux/slab.h                    |     4 +
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 89 files changed, 47804 insertions(+), 1820 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.34.1
