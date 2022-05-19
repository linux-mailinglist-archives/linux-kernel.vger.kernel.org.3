Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8552DE46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbiESUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiESUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:23:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740249419B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:23:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJxOvr011961;
        Thu, 19 May 2022 20:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NHhNtWEHlNOIkaLMR994nfhv3MewDTO3PIczd2WlY3Y=;
 b=Skrmpg3xngxuUL1qxQqVo7ct2dXGNx7I0w677xQPLN9M35G8mU/EpZs8pTMmOnMTxjxb
 M8ojmL900a2qSgRLjgVUTy9xP/T7B7qe4X1IFeNvEQEEQROk2Zh1xby9aRfgOvqL2g54
 NYYZ5OyGSOeM+0P+opCqa8oIhMCafTclgaD4nXG+Ov7iUUYKLf25mWyLgVhAOKU8b9fP
 R6JcuRe7XW0sFPmofI2KbenRyoS5CRM4/YDB3Y4iUZ45YvTZ2UbBOj3m2r6+s6DBWHPv
 m9TbwOJEwjGGQJSz4ERPY9QHPhI7j+CwEBUBb0tS8BgDz2h7KvnM4OIQuQlUp1Tv7hQ+ pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310wdk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 20:22:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JKGCZr017212;
        Thu, 19 May 2022 20:22:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5p08x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 20:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f708bz8MFIpFde8Z2N6cPIBblqSQCigwDhxgCUmNrivqulzALu0mXB2uq8UrGw5Qk9+NchR0ftJoVUVgzTnPNjlw7n3J7aFuODBK2VyMFj0IJKumF4/T8n68vnXpp41xtGkFejQlWWkyV3u49XtTjX4S6XUGSKME4ZQnbOo8VwCTdekcVw1IwRA2xK3uDPfm1f8w8SJwTUGHubBYAO2uGjHLldeMqpHvSJJQueiFOwd/y9IExzCVxY5KbwB09lNciO6LzGP/mD3PI0Lhp+9O11qnvwDGCH/dz1Ykx2/Yfk/WboGcqq2NKHvtmanOALTG0J1Jfpk1Qss3cFK3gwjClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHhNtWEHlNOIkaLMR994nfhv3MewDTO3PIczd2WlY3Y=;
 b=YH0cOR8C13yZo2VF/mzDT9oQlxMvU5vYjlisaiKSJ7vNELXc60Dj4VOtvzH6WKXy+T6XKVtzobLGgV3DH5MB925+2Xly4hg3o+z4m/Jh1lozev0rbKCFVtBxMuPIFMN853W3ksUZ4ffH8OwADOM3bb5rdj8ykkZ/l7aCLsZse1K9kfDetqm8oIdi4wJFS/UMy1V2UpHoSr/Fus1erriDTUI/vPmm6T2SHhJbd63E1uH+byMOQ4jr3OdIJKMSdlNLWAiTBcmXTwjLLlxu0N/KePBexT9sbwqJvIOJKGmp7dL5Sw0Wv0nWRPVBo2dFhyzQPN0f/77j852X8V/+LfNW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHhNtWEHlNOIkaLMR994nfhv3MewDTO3PIczd2WlY3Y=;
 b=xCIs2/GoGNE/O6gW1v4DWGQ4tnQlzEEP94H+2gyqIDWCdx+HHCSNUVsc40t73ZpgEfGiAuOAvrF/S0JLQF52dqIaVk5HY87QuCTqw3uAkaiyQcel/4Aj+VbNvySTTm7A0/Y8NGxHf1PesbPa7ZZskw7G1VtZr76pXbUSGak5If0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3493.namprd10.prod.outlook.com (2603:10b6:a03:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 20:22:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 20:22:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
Thread-Topic: [PATCH v2 1/2] mm: drop oom code from exit_mmap
Thread-Index: AQHYaPp0ya25IVmpGEOQVFiK/GoNEq0mqk2A
Date:   Thu, 19 May 2022 20:22:18 +0000
Message-ID: <20220519202149.3ywynqhbxlzp6uyn@revolver>
References: <20220516075619.1277152-1-surenb@google.com>
In-Reply-To: <20220516075619.1277152-1-surenb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c09b1c5a-a9b6-4b63-39ec-08da39d545a2
x-ms-traffictypediagnostic: BYAPR10MB3493:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3493A07E3E4691F84FA884F2FDD09@BYAPR10MB3493.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQp7KYUYkE5pBHiNw7DAgqihoKyk6FEAvW3AqydYbFGMTwq8WkpYwsA/7gjGeQL0fDWhi5MJlv+KXZk+7ErY3JczUyEegXPRsxoehO5D9r4YQHs0IVVYXk9aKdSyunx+8IFC5FuegML92lEfcFucW8+whVfEvDTGhbkG761u1+3ZV/IK/bXffy9O3lXGYVPH7K5RNlPoQJZSITgK4GYo3SoRh/YAabIqLe0Cqq+e/079LsDqvL8LGP8ytr7d7wPCf3VBVYkMjGgTZSbinjVC3E0O9MJsekuYIDqzEXLNvdAKnU41jmcK9E1o24N/9okbfhxzL2VSss47xV6j7v0xLekjK8RJmIq4aEYbDGTFklrVJlGUkoJ8p+zRXb94iX+yMzfCgRP1v1H9VHnVwzi9JiDmno2IHSaDfTB6Mwbf7HHg/cNXjTg8K+nu0Ew5h64ZJ5eQKugGeEd0UsJtaVMNQDjx1xKTMj/SEKY+xktu8mEh/gLyBo6udEFdUtphRPQVPswoPgkmye730E28Q55VSZxtwGfFn3L5ZeE2GR/qRZhxILHZ5RpsVTBkNpsqLh1xKQj0WHmDkcc9b2NZ/DxtcwS7fGhshOWKi2DnHKIQYWMcQPZjHZNdqAiCUQjTIqdH33tJJ2ih9myUjyoOw0nmHMwVBjfTeQHokeOIQ6w6tyBoJeRuvA4xcFng6nH+J110u40huLVfuVgvBR7NUz/riw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6486002)(122000001)(6512007)(26005)(86362001)(508600001)(5660300002)(6916009)(54906003)(316002)(64756008)(76116006)(91956017)(33716001)(6506007)(38070700005)(66946007)(66476007)(66446008)(83380400001)(8676002)(44832011)(66556008)(8936002)(71200400001)(7416002)(4326008)(38100700002)(2906002)(186003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EoLko5Mjr33r5JyDmmzsbiVgg+bPZW1+Hsm/I0RMAX4E4m4JT9hLF/nxSuiu?=
 =?us-ascii?Q?3tt333CDA8mBPzaSBYSypjsWfYIxgbOOCLYXmIVdt3yyJterArVcJVRFQs5b?=
 =?us-ascii?Q?uvnPtZ3cxThUumEf3oKwPZGT7IG/qCqNbczpE8bzkmEaHzmEa1mQsAahMEIM?=
 =?us-ascii?Q?D8odx+bMbrJg5lOvJ9s9r5pI+mP3UulnrXuPSVBfjwgcMK1q1xzQ0NU38yrL?=
 =?us-ascii?Q?7AXuIthMjD2SDUkYk+AS0iGIHpwQWQ23viOLRUA09kZqnr4jSYqE1/D7H/LU?=
 =?us-ascii?Q?ze5LbZpEGSLkJLKVXYoZP91aXft7UB6qYapO8d+4GukiWnwtKamhhsRWS6Dw?=
 =?us-ascii?Q?HUhz+Ab3hjy+dD4lC+HjC/bDFK3yPwKUw9tvoqTN4tdvHP8hnnym95YXpG9Q?=
 =?us-ascii?Q?zyZsjU5omB9wmKpDSqRydR3bOsx4D43n1DquypNorIuFB+81j5vb2HyLp53n?=
 =?us-ascii?Q?7/K47ydwE35t0/cDMqtU2aiZsyx4id37Ccy3qlmJZzTrd03dQz/PtY7UC1P/?=
 =?us-ascii?Q?UHS9e4GQChc301gZkwGRs6UreRaxsYpQguvruNGnnYUeI4s3P+3BAUtEA73w?=
 =?us-ascii?Q?jHYeBnYL4KPvUm4ZlBx8B+CNug1c25xd7w9KCqiwbvKJyt3OlOjJHnwl3gT5?=
 =?us-ascii?Q?OTs0sDfMFq73VCYL02c/TxUS/pJzdr+h8J1sov8OwGOF7IP5GjwdGhUDouhk?=
 =?us-ascii?Q?M2TYHfPYX2gKHspmTl4T6Tq1bYPh7QCZn1vvkyDMCZl0qWR6ZqxiGYJf1W1z?=
 =?us-ascii?Q?AJqFZbBsDw25zVgq5f/rhlKyvq6oQLIGvj/esKTBdN03y/NlBVQpKQ2DhIgl?=
 =?us-ascii?Q?bPRyQnpWHiFdl4EzSUqg5A2f1+0aMLY6L3P/spi+wGKKJ9k7gBdXFexFh+Dg?=
 =?us-ascii?Q?trkXa2O718n2XtPH+BFU0TAQcGtbkhKJPI3h1Yw5d3Fy3jhpCMUQQdrBw49G?=
 =?us-ascii?Q?3tTcDpfpMmxm5nYt1Uwug8uqP70eqimUzkOudpcdWMGstPKcqNQTkucJ6+SK?=
 =?us-ascii?Q?jKPM7da3v8/sGLYzAbyfDoU270/96es8I0DVwrf34yTsJ5aorCT9X95sznyt?=
 =?us-ascii?Q?bOKtqGsc+DVuB6ile2RWfRYANP76iivBz8zK17XQIpcbqx1+pXZ8/8IOEGfh?=
 =?us-ascii?Q?xu06dTlD5nWKuVJid7uY6ub82mjhJiJsako8MU8I9HiHHGLsQJRC56tfscAg?=
 =?us-ascii?Q?Y3s0tsEotdPVblnDWqFwIzBn9X2DnXcwu8vGsPWDYikGMz7mFHiP8apmqMj3?=
 =?us-ascii?Q?31FneM5Zax44+5vzrolkBH77pDiBqkWiMQ/epj1TvuJu5PSVgW2YOGrmzxP0?=
 =?us-ascii?Q?mbxLRgNWKvlDj1VgbxxkTxtAxbK4eykAHolQDv60i8egLIo0jM1ORKpj05fH?=
 =?us-ascii?Q?JdVjpSwg8jXkoytQoiq5pJOzdzZprSSXybDt5M2MIVXhmp2vO9Yn8oHKpc8P?=
 =?us-ascii?Q?L55U6F5u2UDR7b9IC+QevH0kFOGJIOdv/0k4Pg2+hUySkNiyoU/tIF+6CQBi?=
 =?us-ascii?Q?1si4vuRiVcc5ShfNDgmB5gksJE7c36TOSIiMf9ZaPDSR86g/YCi6+yGItDWL?=
 =?us-ascii?Q?9bEljPDsh6dPHaq5oSNUNF1t2XcebVXevn8y4XVb1SF110gWlwS7/REp92JL?=
 =?us-ascii?Q?xatEItYSzU0WaqIYyfkze8+pdGtr3m/3T06rDIDZJZuDDwn3A3AADI33Ny7b?=
 =?us-ascii?Q?wDtQiYZifDjiftQKstBXA6BlVgYqlSoXgD7lOKU9O14SXRGLt3QE3NobBnIx?=
 =?us-ascii?Q?B0ecwvgeUiUjSLOU8YiljodVy9KVxn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <695FD65CCDDDDC4F84F2D338822C475A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b1c5a-a9b6-4b63-39ec-08da39d545a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 20:22:18.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jykChMRX32r0056C10ZGvVcNdl+eMREg+Wrkf/x/4pbpmobdpMklr+sIsCBMVPY36+7FrB7heR/x6sgXLLXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3493
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_06:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190112
X-Proofpoint-ORIG-GUID: docP9pcuHZxrCUbwuBJW_q8MqPRTxKIE
X-Proofpoint-GUID: docP9pcuHZxrCUbwuBJW_q8MqPRTxKIE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [220516 03:56]:
> The primary reason to invoke the oom reaper from the exit_mmap path used
> to be a prevention of an excessive oom killing if the oom victim exit
> races with the oom reaper (see [1] for more details). The invocation has
> moved around since then because of the interaction with the munlock
> logic but the underlying reason has remained the same (see [2]).
>=20
> Munlock code is no longer a problem since [3] and there shouldn't be
> any blocking operation before the memory is unmapped by exit_mmap so
> the oom reaper invocation can be dropped. The unmapping part can be done
> with the non-exclusive mmap_sem and the exclusive one is only required
> when page tables are freed.
>=20
> Remove the oom_reaper from exit_mmap which will make the code easier to
> read. This is really unlikely to make any observable difference although
> some microbenchmarks could benefit from one less branch that needs to be
> evaluated even though it almost never is true.
>=20
> [1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurren=
tly")
> [2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, =
v3")
> [3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomr=
eap")
>=20
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/oom.h |  2 --
>  mm/mmap.c           | 31 ++++++++++++-------------------
>  mm/oom_kill.c       |  2 +-
>  3 files changed, 13 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 2db9a1432511..6cdf0772dbae 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(s=
truct mm_struct *mm)
>  	return 0;
>  }
> =20
> -bool __oom_reap_task_mm(struct mm_struct *mm);
> -
>  long oom_badness(struct task_struct *p,
>  		unsigned long totalpages);
> =20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 313b57d55a63..ded42150e706 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
> =20
> -	if (unlikely(mm_is_oom_victim(mm))) {
> -		/*
> -		 * Manually reap the mm to free as much memory as possible.
> -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -		 * this mm from further consideration.  Taking mm->mmap_lock for
> -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> -		 * reaper will not run on this mm again after mmap_lock is
> -		 * dropped.
> -		 *
> -		 * Nothing can be holding mm->mmap_lock here and the above call
> -		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> -		 * __oom_reap_task_mm() will not block.
> -		 */
> -		(void)__oom_reap_task_mm(mm);
> -		set_bit(MMF_OOM_SKIP, &mm->flags);
> -	}
> -
> -	mmap_write_lock(mm);
> +	mmap_read_lock(mm);
>  	arch_exit_mmap(mm);

arch_exit_mmap() was called under the write lock before, is it safe to
call it under the read lock?

> =20
>  	vma =3D mm->mmap;
>  	if (!vma) {
>  		/* Can happen if dup_mmap() received an OOM */
> -		mmap_write_unlock(mm);
> +		mmap_read_unlock(mm);
>  		return;
>  	}
> =20
> @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, vma, 0, -1);
> +	mmap_read_unlock(mm);
> +
> +	/*
> +	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> +	 * because the memory has been already freed. Do not bother checking
> +	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> +	 */
> +	set_bit(MMF_OOM_SKIP, &mm->flags);
> +
> +	mmap_write_lock(mm);

Is there a race here?  We had a VMA but after the read lock was dropped,
could the oom killer cause the VMA to be invalidated?  I don't think so
but the comment above about dup_mmap() receiving an OOM makes me
question it.  The code before kept the write lock from when the VMA was
found until the end of the mm edits - and it had the check for !vma
within the block itself.  We are also hiding it from the oom killer
outside the read lock so it is possible for oom to find it in that
window, right?

Could we just unconditionally set the skip bit before taking a write
lock for the duration of the exit?  I'm probably missing your reason for
doing it this way.

>  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>  	tlb_finish_mmu(&tlb);
> =20
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 49d7df39b02d..36355b162727 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -509,7 +509,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>  static struct task_struct *oom_reaper_list;
>  static DEFINE_SPINLOCK(oom_reaper_lock);
> =20
> -bool __oom_reap_task_mm(struct mm_struct *mm)
> +static bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	bool ret =3D true;
> --=20
> 2.36.0.550.gb090851708-goog
>=20
> =
