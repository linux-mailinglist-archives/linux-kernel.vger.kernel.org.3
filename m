Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4352890D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245334AbiEPPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiEPPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:39:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE43C726;
        Mon, 16 May 2022 08:39:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GF6vNt019546;
        Mon, 16 May 2022 15:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AjyokwnXvbOSmseDJZ1dIp6rzbAw7aGtygllNjBy6KA=;
 b=MnnxohohUFX1vrWpb0WrAXpwYEqNtBmtgb6png92HfPa3QuOEX/KdeydpzhiHr3lf+7/
 dCOYshxepLf3YLYqejLobZfCTADPldfXAJrvAzcOHyM0460MxX/Y73oxAYQgzlqxMJTx
 TM376UZ1nZYiFkr/uZHbW+w0H3IJ8BGMct6269Y7tdFGZeExcJj8CU/n8lGF4+5Hsjy6
 NSxHhu4/XAWiRF7Ptk2KyABEjAP14ZIyleI5uGJvO2Zcrzn7YAAW6bYP8EsVRQ815tWw
 yUX3HsRAsC4lmL52JKCyTzDpS+ma78R7J02lTyat5s0ohTvRuLe7BKKjwIIEcsJ/pGuK MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s3njj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 15:36:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GFZc88004229;
        Mon, 16 May 2022 15:36:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cnubu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 15:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep4Sd3RJgidyL/43PdogS3XhjRwlX0CfMW0S8R8KUDGWLWLDae079FG8oUyhikI2AYF+IEszp+t9LkRMCuOO0BdjQnQkhWhZTTVrQdMBuUq8dWc1z9YBkHDNmGYI+xvhjsFCGPVy4uZjqSKeSDbYmEszuxNvbXHMUlLoOM1dvln98d/NriQ+IoUMRA2GRtGGp9M9RWd0Ma4aihYA4M3cS51enIwozPCte6cwQF2gq4J9guxJ6RX7QzTpw1nPRC+N+88FVB8GPJ7OJz+HaeKSKMgMa1mQwMUJnywyr55CogGIKXX5gQR5BOHaiPJb076B4eXxHLZUZ1nZbiJ84b/8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjyokwnXvbOSmseDJZ1dIp6rzbAw7aGtygllNjBy6KA=;
 b=neENK+RIcrWhrw49zPpAT5+CQSdSoIlh4PwoF1TlDPjM/1GsOS7dZmN9yb0uSJakW0qJKnEnDofWV0LwpVBvlad2gZLIhY8PxAyYb7ZF9DzrsMqX4BnpXiq4mhy9JOPsry5UKpBQ032/dGNIPN7lQckXMdJ6s8sxLuFrSleiVhkudCo7m2b+XP4D1kTz0qJ7nG8bKx/prPfhC4yUGgMBk+NvIvsS82H0Ot/bgIngtC2XYi1Cx8kIz88a1C1KEF+BSiwfnRbcWeXN/1aCwsmLEOJoGg6TmzTAgxJNBHmBT/ckzwINrd00aODKQO8GsxRkh5dpNgLXm1zDbfigAjaH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjyokwnXvbOSmseDJZ1dIp6rzbAw7aGtygllNjBy6KA=;
 b=JJaAChQl5Ca3AhJVOHmHIjztJfvCOjQVxleytOXp/o/K9y7Hxc9m9Z6CjNejhJsCTMDQuky0B9VlndwZIt9m9KJZHourcajM05qmN9nDjmEKddd3W/W4vK3FPjk2ka0U9AGAlruw8w3jbYhiCL9CvN7zw5EJOu/nFHaQ6e0YjZs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3980.namprd10.prod.outlook.com (2603:10b6:5:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 15:36:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 15:36:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        SeongJae Park <sj@kernel.org>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [next ] kernel BUG at mm/mmap.c:3235! - invalid opcode: 0000 [#1]
 PREEMPT SMP NOPTI
Thread-Topic: [next ] kernel BUG at mm/mmap.c:3235! - invalid opcode: 0000
 [#1] PREEMPT SMP NOPTI
Thread-Index: AQHYaPFZjjbpOCHDMU+Oev6jN9i6VK0ho2yA
Date:   Mon, 16 May 2022 15:36:12 +0000
Message-ID: <20220516153605.f4cxfa7yx2jnorfm@revolver>
References: <CA+G9fYtU7i356bhfGSVaZUkeqE2gE-GE0NQ1iqxJEH_u4BZjSw@mail.gmail.com>
In-Reply-To: <CA+G9fYtU7i356bhfGSVaZUkeqE2gE-GE0NQ1iqxJEH_u4BZjSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3660ea89-4720-4950-fd18-08da3751ce6c
x-ms-traffictypediagnostic: DM6PR10MB3980:EE_
x-microsoft-antispam-prvs: <DM6PR10MB39807D76C793BFE4AF400DDFFDCF9@DM6PR10MB3980.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Izrbvrqe3/34THzaDV8Dnnn/+HGlfQryfwLGCIEGPK08Sg6m2135LyWDup4+IGwCiiOHxrVazA2i6CtSZ5+7wRBsNFtDyXG68RNxL2HYUbO278Hrtw4xJ2+lbqhp6cpBRlaorqM4M64XZGCBcmG+9rdxaesIm3nxcGcfBJ6A2BT1453n5d7jjmbZveCIA7+JxZmawlSSE56W2TareI1/1sxF7sF9ERzovWVjucthJ7NrS54r2K0pWBYVI2OQuJhdT+l3CnS0hfZYOYDDzZuZIac9RI9SlEd2MNOfR+m2n74qpzeEMzCs5n04g/e92ZQpz0xkZiGRFsJe9y2UMX5+pd8ivLJy91kzXqMBDZNTcsU9SeqO2SQJU7rys1vOqZaXmZvZ6QwoDYpgzuBoAo2/NrivfiguZ1t1sO0TCK7tgSlut6Joz8Yk4YCU9ePLhulBJ8oLxVKjHHylyZR11EsctkLZBZBqkiZ1i0YwnH/Y+6gQBUyAhvFyOD7MWZQhMs71om83O2GTy+TLbsmprlgl5aD+BWaqqs2wIlwreCqyJrSkBwmxXj+yEgaGXox8IB1WGkRAgMosn8bdvWKIgxsHNx3ZSf0priLkBtwyppT6Kp/ExqF4sQyJc42iHn95qn6AH4QojWwpbFp5cMO8gOq0xZWyM/ZnzbeUGRcfVN862U424JeDKeF9Q138yE3ZO3ieyb0M34X1qpFWU704NMT/mracnkDxN0Md1oBCJGor026fjkObIatmu/j/S9i5iNswgPr07gnV8GpavKMSdQgVfiv4w/Mv6Lzty2xVyAFQPBlguPuJVHN8m4a3sUzt2wR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(76116006)(66946007)(66556008)(66476007)(8676002)(66446008)(33716001)(91956017)(2906002)(1076003)(9686003)(6486002)(26005)(54906003)(6916009)(64756008)(6512007)(6506007)(316002)(186003)(8936002)(83380400001)(122000001)(38070700005)(38100700002)(5660300002)(86362001)(966005)(44832011)(45080400002)(7416002)(508600001)(71200400001)(17413003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qqaGhJNNc5tdQ9wonfh3l6ycBd27AEBYT/oCzC/bLHOu7GSnnAhbIzVzUJDl?=
 =?us-ascii?Q?0cdGD8LDR4Vcd0DLkG8XxzCOWb/2E0D8GpF4AqIRAjRJjbrOYax1IOl08O5t?=
 =?us-ascii?Q?wOOcP6hSwTe49Wt4RsRhjxxb7c//lK3OGyFLj5WHW6MTdu+AHoE7sJo389dk?=
 =?us-ascii?Q?qyBO20mrYmZR6cv4ZDMb5vwxNHVxmwE1xzv7/lsaBmmFUEXyRBa3T2n8/YGn?=
 =?us-ascii?Q?yi1gWkKGW8z3xEeaVOVargPDFMcpfOY/m3ss8boJX4Ve4m8uGhnbEgC7EOll?=
 =?us-ascii?Q?PhlUiDlQX4U63jpMiLs754HpuK51k1xcxjdglVMIL0+y6X2qzjMd3uWsDQ63?=
 =?us-ascii?Q?26Ux/plZ+xS7bbCsYefnvq33BxMA2jkwvUk0xWQDVl7Wir2Cq1tFqDeZ8eVA?=
 =?us-ascii?Q?xZM4esDqU8A8lSBfMsC7TrYssGXGlZB99+GNw+osxRHP/lRRkfgdwZlaZjWF?=
 =?us-ascii?Q?hHGmMAhAd527osCQgb8SvgDb20tvvWFuwJz+Z0BcjDy2Fqmes8F3qrFx+WYf?=
 =?us-ascii?Q?EWaDcEzqopKYuW0YD7GOJxwypKoPw/yKxBpuNYGWu0kYk3s8JJWZO2KZYt1Y?=
 =?us-ascii?Q?GYapmuiiAdCgVijY9GGNJTK0lriY2ruX0BfpAWYExh1zLF6AuW6Z1wC/QKm4?=
 =?us-ascii?Q?1dftxzWYtTCHkP6KWFCC1XIfLWm6tTwOzTzbH1ChbcVkub2QABZGeieqE6Cm?=
 =?us-ascii?Q?xWOxISvaOE7PRQMGQQ0iZCDYerEqfPnN0noa5CYjyyz2rAqUa/ozlmvrorp3?=
 =?us-ascii?Q?IW/oIq7/fNP3Bu+UQ7Dc63yK7FEBMYTwzh+PGb0QRL9gt3GKh/MLDI6KUnLm?=
 =?us-ascii?Q?v+9NXDOmudHcMQ0hlbpkfU/+dSLBPeTGnIFQNLYqD2DDf6ZMq+AmU/1hVd/X?=
 =?us-ascii?Q?uzNfkWcRgPtkRIPYZkLZnxC1xgmKNlssdXgvtbhHlJBV3iNsyvtcgRvPUrXL?=
 =?us-ascii?Q?I/vXSU/DPN/VpU0ZCDs5+ZVSgv+GizkkdtIMffJSsiQQB85km9hwH92ic4kK?=
 =?us-ascii?Q?VuaoP6CqOMO6g4FYGbX+rGQ6MeSbDjJRX+uaB/fWbw7Ugjo7vI8i1r2wUpGx?=
 =?us-ascii?Q?ayrM71b70Lam7f/RMCyLu+dSKXjn22AJs1l2XcGE3G1hiUSwhLyPtzRxZtMw?=
 =?us-ascii?Q?Kmm7kigO+bSSpYAHAd1Pd0BPxpSIDftAFIPHcfjojJpWv97m2aWEBLWmmfk/?=
 =?us-ascii?Q?6E7cxV93p2WAiuEnGI7u11ZWeKJf2RK4d6LdImkHPYY3+jfJP9VSPGgVKUhQ?=
 =?us-ascii?Q?SYFPIR9SUEnIC56O7hTnwiOp1GinoEq5FSLUu57QzsQwkX88LlflsEdPN5Mc?=
 =?us-ascii?Q?EU5JFFVquaGRRf/mIVSItHE8EtLfqA/6N/14zd42+uNm5fzxa65UkIaxjhqI?=
 =?us-ascii?Q?L21kbOKmORF9mUVfgMXO+RZuuNxGgaC5VxPVtZyM61w1DKen+FaSjAOt6Vmw?=
 =?us-ascii?Q?gJ6f0YCWiLalbu+OQ7dNFXJF3MR0V4KodRPnYBKC+snCG/VQy8oWUzqBviFL?=
 =?us-ascii?Q?QvD5tA/HAIkbwO6oYiIhCkzBm1uUe1JgnD6RpBgVTIbJqTpjHDsyza5VCPhA?=
 =?us-ascii?Q?2OZ6WHM6v5zdg1uiSHCyiH+fhlYyMmHHd0OFcDlBQ0Pu0wYXKotqm7jgLgKd?=
 =?us-ascii?Q?J9ZbkKph4YxGFQuFiaMZAwPh/OcbgpC11Vld69mq6C9pDcsZSrzac6g8LgFV?=
 =?us-ascii?Q?KR1gNLMaKZLc9MF5QzgdqNNHD0MuPKnBLpWcp4AFBpsTW5wcuU323OqSxMOj?=
 =?us-ascii?Q?kFMEciLW7GZzTpqe5mJT4lIkXtezxOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A935731FC1D444DAEBA505DD2603ABA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3660ea89-4720-4950-fd18-08da3751ce6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 15:36:12.1474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8L7yRBrwtvlbMqD/HRvAGVSk51rq1oSNAqpze5+kpa9K1qSjODOdoYw6dySWBCD3b3JKmBT94BPplTxGCzANWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3980
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_14:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160090
X-Proofpoint-GUID: Km6zCpOnuQDPp9kcfq2XiV-yDSR0imBs
X-Proofpoint-ORIG-GUID: Km6zCpOnuQDPp9kcfq2XiV-yDSR0imBs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Naresh Kamboju <naresh.kamboju@linaro.org> [220516 02:51]:
> While running LTP mm tests on x86_64 the following kernel BUG was noticed
> on Linux next-20220513 [1].
>=20
> mmapstress01    1  TPASS  :  Test passed
> mmapstress02    1  TPASS  :  Test passed
> mmapstress03    0  TINFO  :  uname.machine=3Dx86_64 kernel is 64bit
> mmapstress03    1  TPASS  :  Test passed
> [  666.897222] ------------[ cut here ]------------
> [  666.897260] kernel BUG at mm/mmap.c:3235!
> [  666.897285] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  666.899420] CPU: 3 PID: 25230 Comm: mmapstress03 Not tainted
> 5.18.0-rc6-next-20220513 #1
> [  666.900552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  666.901868] RIP: 0010:exit_mmap+0x32c/0x3a0
> [  666.902542] Code: 87 78 03 00 00 00 00 00 02 0f 84 41 fe ff ff 4c
> 89 ff e8 37 bb fa ff f0 41 80 8f 7a 03 00 00 20 e9 2b fe ff ff e8 74
> e5 e1 00 <0f> 0b 65 8b 05 b3 ab 63 55 89 c0 48 0f a3 05 39 4b f0 01 0f
> 83 36
> [  666.905542] RSP: 0018:ffff991342abbd10 EFLAGS: 00010202
> [  666.906334] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff93ea0=
353540c
> [  666.907464] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff99134=
2abbd18
> [  666.908589] RBP: ffff991342abbe08 R08: 00007ffe337a6fff R09: 000000000=
0000009
> [  666.909745] R10: ffffffffffffff00 R11: ffff991342abbd40 R12: 000000000=
0000058
> [  666.910810] R13: ffff991342abbd18 R14: 0000000000000012 R15: ffff93ea0=
7f8d800
> [  666.911940] FS:  00007fad8494b580(0000) GS:ffff93ea3bd80000(0000)
> knlGS:0000000000000000
> [  666.913153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  666.914147] CR2: 0000000000bba268 CR3: 0000000075610000 CR4: 000000000=
03506e0
> [  666.915119] Call Trace:
> [  666.915473]  <TASK>
> [  666.915805]  __mmput+0x47/0x100
> [  666.916280]  mmput+0x20/0x30
> [  666.916677]  exit_mm+0xe7/0x150
> [  666.917116]  do_exit+0x1c5/0xa40
> [  666.917566]  ? __audit_syscall_entry+0x109/0x130
> [  666.918220]  do_group_exit+0x54/0xb0
> [  666.918708]  __do_sys_exit_group+0xf/0x10
> [  666.919249]  __se_sys_exit_group+0xe/0x10
> [  666.919790]  __x64_sys_exit_group+0x12/0x20
> [  666.920356]  do_syscall_64+0x35/0x60
> [  666.920876]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  666.921561] RIP: 0033:0x7fad842c1846
> [  666.922095] Code: Unable to access opcode bytes at RIP 0x7fad842c181c.
> [  666.922959] RSP: 002b:00007ffe336ad8b8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [  666.923954] RAX: ffffffffffffffda RBX: 00007fad845a9740 RCX: 00007fad8=
42c1846
> [  666.924895] RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000=
0000000
> [  666.925846] RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffff=
fffff80
> [  666.926779] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fad8=
45a9740
> [  666.927711] R13: 0000000000000001 R14: 00007fad845b2628 R15: 000000000=
0000000
> [  666.928671]  </TASK>
> [  666.928976] Modules linked in:
> [  666.929491] ---[ end trace 0000000000000000 ]---
> [  666.929502] RIP: 0010:exit_mmap+0x32c/0x3a0
> [  666.929508] Code: 87 78 03 00 00 00 00 00 02 0f 84 41 fe ff ff 4c
> 89 ff e8 37 bb fa ff f0 41 80 8f 7a 03 00 00 20 e9 2b fe ff ff e8 74
> e5 e1 00 <0f> 0b 65 8b 05 b3 ab 63 55 89 c0 48 0f a3 05 39 4b f0 01 0f
> 83 36
> [  666.929511] RSP: 0018:ffff991342abbd10 EFLAGS: 00010202
> [  666.929513] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff93ea0=
353540c
> [  666.929516] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff99134=
2abbd18
> [  666.929518] RBP: ffff991342abbe08 R08: 00007ffe337a6fff R09: 000000000=
0000009
> [  666.929520] R10: ffffffffffffff00 R11: ffff991342abbd40 R12: 000000000=
0000058
> [  666.929522] R13: ffff991342abbd18 R14: 0000000000000012 R15: ffff93ea0=
7f8d800
> [  666.929527] FS:  00007fad8494b580(0000) GS:ffff93ea3bd80000(0000)
> knlGS:0000000000000000
> [  666.929531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  666.929535] CR2: 0000000000bba268 CR3: 0000000075610000 CR4: 000000000=
03506e0
> [  666.929540] Fixing recursive fault but reboot is needed!
> [  666.929544] BUG: using smp_processor_id() in preemptible [00000000]
> code: mmapstress03/25230
> [  666.929562] caller is debug_smp_processor_id+0x17/0x20
> [  666.929575] CPU: 3 PID: 25230 Comm: mmapstress03 Tainted: G      D
>          5.18.0-rc6-next-20220513 #1
> [  666.929580] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  666.929582] Call Trace:
> [  666.929584]  <TASK>
> [  666.929586]  dump_stack_lvl+0x6c/0x9a
> [  666.929590]  dump_stack+0x10/0x12
> [  666.929594]  check_preemption_disabled+0x10f/0x120
> [  666.929606]  debug_smp_processor_id+0x17/0x20
> [  666.929609]  __schedule+0x36/0x600
> [  666.929618]  ? trace_preempt_on+0x31/0x40
> [  666.929634]  do_task_dead+0x41/0x50
> [  666.929661]  make_task_dead+0xd3/0xe0
> [  666.929664]  rewind_stack_and_make_dead+0x17/0x18
> [  666.929702] RIP: 0033:0x7fad842c1846
> [  666.929705] Code: Unable to access opcode bytes at RIP 0x7fad842c181c.
> [  666.929706] RSP: 002b:00007ffe336ad8b8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [  666.929709] RAX: ffffffffffffffda RBX: 00007fad845a9740 RCX: 00007fad8=
42c1846
> [  666.929710] RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000=
0000000
> [  666.929711] RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffff=
fffff80
> [  666.929712] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fad8=
45a9740
> [  666.929714] R13: 0000000000000001 R14: 00007fad845b2628 R15: 000000000=
0000000
> [  666.929717]  </TASK>
> [  666.929718] BUG: scheduling while atomic: mmapstress03/25230/0x0000000=
0
> [  666.929721] Modules linked in:
> [  666.929722] Preemption disabled at:
> [  666.929728] [<ffffffffaa82a574>] do_task_dead+0x24/0x50
> [  666.929733] CPU: 3 PID: 25230 Comm: mmapstress03 Tainted: G      D
>          5.18.0-rc6-next-20220513 #1
> [  666.929736] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  666.929738] Call Trace:
> [  666.929739]  <TASK>
> [  666.929739]  dump_stack_lvl+0x6c/0x9a
> [  666.929743]  ? do_task_dead+0x24/0x50
> [  666.929747]  dump_stack+0x10/0x12
> [  666.929750]  __schedule_bug+0xd2/0x100
> [  666.929753]  __schedule+0x471/0x600
> [  666.929756]  ? trace_preempt_on+0x31/0x40
> [  666.929759]  do_task_dead+0x41/0x50
> [  666.929763]  make_task_dead+0xd3/0xe0
> [  666.929766]  rewind_stack_and_make_dead+0x17/0x18
> [  666.929768] RIP: 0033:0x7fad842c1846
> [  666.929771] Code: Unable to access opcode bytes at RIP 0x7fad842c181c.
> [  666.929772] RSP: 002b:00007ffe336ad8b8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [  666.929774] RAX: ffffffffffffffda RBX: 00007fad845a9740 RCX: 00007fad8=
42c1846
> [  666.929775] RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000=
0000000
> [  666.929777] RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffff=
fffff80
> [  666.929778] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fad8=
45a9740
> [  666.929779] R13: 0000000000000001 R14: 00007fad845b2628 R15:
> 0000000000000000Running with 50*40 (=3D=3D 2000) tasks.
>=20
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
>=20
> metadata:
>   git_ref: master
>   git_repo: ''
>   git_sha: 1e1b28b936aed946122b4e0991e7144fdbbfd77e
>   git_describe: next-20220513
>   kernel_version: 5.18.0-rc6
>   kernel-config: https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP33g/=
config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pip=
elines/538244935
>   artifact-location: https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP=
33g
>   toolchain: clang-12

I'm having an issue reproducing this on my configuration.  May be the
clang compiler though.  I'll keep digging.

>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20
> [1] https://lkft.validation.linaro.org/scheduler/job/5021584#L2916=
