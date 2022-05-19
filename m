Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A478C52E025
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiESW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiESW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:56:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54794ECC1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:56:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJwvMM030086;
        Thu, 19 May 2022 22:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QvZf9KiEGK9801MeNY57PU1NQaHSf6ex4ALYNC6pyTE=;
 b=j3J0Na3lAsmU+L5DxHCT69noJrtz6ka31YHcPBDZPGzN8P+Oks+vg3xk8g74VxlsZuEr
 r8UUw8LZtgMQPAlJzfSV6NHzBfMhHe4gtpIHgHCi4p7083bvWDMHuc6Cni/+EyJOZeQa
 14xjM/n0N+QxCdFqf7LkvymaEZNWceO9o4TXLhf6gX0u9CgR6IDjslKXAgjOpXEpTIid
 /b0EMa+ipTb5Kd4fZS4D5IzAvb9PzCPzCJqKO/0OKTCS0CwrVjwdGigjVpE/FCcGWKCT
 UIbtqqCv/sKO/9/M8N2DbstaN1oh9mI1z9p8c60xXwPfE8aBcoZcK3YR6lJS5bIRGj+W Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23725ury-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 22:56:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JMp7xT001449;
        Thu, 19 May 2022 22:56:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v5rdyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 22:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTAq73TdAi4c6vhM1mhbAWr/BXR6xR9ltiaZ7enzZNrXjkD62gZXv2pjZGANDcOFCwYkIcJojB7cbdjQfuiQyeXF1N7d7IQ+uL10qhwEWjdxzeOzdrANtbGAv4Sjqx0Zq26RLsiG/5PpICbEKKDmITrdJcWtEHAzTPooZ1uxFbccS3fKmZ6qOUDNBd4n2Ln2NUMTocrW5n3A5Gdk318ok4GAexSg5ufFticFuy3u2GjLct0M8tnGulYFIMlXbgdvALRbsEzaWbrrrD6NEsGtI10L35Zp1pLXPmeNzMYzpjNTTdyFVw/Y5npwK8fLbkXj5IHZV/d2pxVYbFXst4balQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvZf9KiEGK9801MeNY57PU1NQaHSf6ex4ALYNC6pyTE=;
 b=dSh1v4nXrAcdPn78OY/RIdpjdn5m2x7ahRpYNyL3b9p0mLn0ZtBR7LVIE7x/BUlNCkovR5E4LW2CBKE60fPrYPKSAwaTj1MWB4g0Q8xT0YL0BQG2wNe6lZq+Rrj4iBRJiFe9Mq7urVSmiVc8LcbeQu44h/s99dcoxaHNHl693P1PxuNOeT4FOegzKiNzGfiK0g0bNOuw0uWKND252tqriQdLWPPCTt8dK/qgUa9XmUepYvcdszENqsjZTp+awK5Spsux6u+2Mhw8ArLG1o9Z2WE8OTWfiiSfPiFapwiQRjFfJ40h3LvzMdQRSwmbrgwB0PDJL8ajsHwFNlL0ssHymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvZf9KiEGK9801MeNY57PU1NQaHSf6ex4ALYNC6pyTE=;
 b=xKca6uCW4ZYoHmIq3PROMSJVUAth1mrpWwYb0DuItfxK1ZHIa1tSWTDeKVB0bIti7kUJDfkGZf7Yd/r/FAPM4v0+PqhfE8kBUwjf+RcqKou34/3Tiz5YWy8LlSX2sPir6t9v9jZIT9v7eoYvbftk9xlSYUJutn2ewN5CBpmscyw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2941.namprd10.prod.outlook.com (2603:10b6:805:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 22:56:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 22:56:29 +0000
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
Thread-Index: AQHYaPp0ya25IVmpGEOQVFiK/GoNEq0mqk2AgAATyICAABdMAA==
Date:   Thu, 19 May 2022 22:56:29 +0000
Message-ID: <20220519225614.r6ey3bl32c3gbih5@revolver>
References: <20220516075619.1277152-1-surenb@google.com>
 <20220519202149.3ywynqhbxlzp6uyn@revolver>
 <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 255b02a8-f7f9-403a-f604-08da39eacf7f
x-ms-traffictypediagnostic: SN6PR10MB2941:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2941055ED43A04CA990EF698FDD09@SN6PR10MB2941.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvkE2yP7+PnacsOcsO3RctdZ1/uAvgfBKoICTzA4hW1pjjBJwzBBNAs2gAt5uPTak+Q5Ls+kPrLtazNtQ6ExBDZnUjOGCIiOl0acnSNPAlj2jzaf+KcDZwgYznYnfw4vIiLDMAUYMgp8uQyD8E5Oh/FgkGQ0gxiN1Bs+ti9QSfl68H2iC8Q/KV37dlB8PtMlQaAeDp6GM7XyZhpsehfqrSOhW2b9Wy3fmaqzN+9/KjAfZnqm55yqHcO3180nmvIU/tydCK94LMOb/qxr78FBL+PvEwDF+jUZpbF+1mHbVXddsanXp1qSYUqoIdlKaEr89OsPRqb8HxGEy2hngUqdlLOB9qd0hiEnINp3MtMkty4QXnu+z93JmIruXSiDTFbZenkzUfgA3QESOzz59AddJSIiX2e6XrMaVJaWiWkuByZ5AcjSOlBBKfUVA+I9QBJhhAllZ1lKtNIu6ucT33PCIHZJgaARha2GVpXMRccx0QHvhG4RQHEtTXy7v5x6V/0SKZRq7d1SxR4HnINruFjsYBwa4c8nlAJT9A4fWmSCfkn/hhzKWamvTbh64qJWR/Y9lfz+vyzrXVymH/eCNioiZ4rurz6SCU2aYfTqC9QxQ4P8fZaGmg1/OIk+w7YyHYhLo4A7YojI4qObZ6WiFVfql1C4YKqqB1hc2j6DfoyFqRbaLFbytUrxsPG7ioQy8ZyoNs4mheMV6J2Jk09U6eTUuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66446008)(64756008)(91956017)(1076003)(66556008)(66946007)(66476007)(6916009)(8676002)(83380400001)(316002)(186003)(33716001)(4326008)(54906003)(71200400001)(44832011)(2906002)(26005)(6486002)(53546011)(6506007)(9686003)(38070700005)(76116006)(5660300002)(7416002)(8936002)(38100700002)(122000001)(508600001)(6512007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1cRJYI2Bx/Q4uGgjfmPVAKL3Dc+ZW+9azLxzeVULdjVc/iOobh0y578jaQ+Q?=
 =?us-ascii?Q?foiejV7THozzVdqPhabbjHqwc73e9SkNyt3dCwW/W7oMjB+YL1u2KJHHdwv2?=
 =?us-ascii?Q?PUVqCKMoEIAN6CS3lIzowbLDXvo9FNRhsyKa4utoxV8JsXhWr3UEQPExWy29?=
 =?us-ascii?Q?qa08KZ0CrW0XEwrrJ3jqlneu8EBbd5dsa48CdMdjEeykHH7XOt2m8BCfsexB?=
 =?us-ascii?Q?ck5EDnTu9EiPD2Fx/oAZHXAvK2qwyBda5ouh8VhmQA4BuqCk/78irWz47BWf?=
 =?us-ascii?Q?mgtjb2axchSgcswM3pk9R6K837DW+sqUO8OxIMl47tFZ+3Fo2iWF2zeYRLu+?=
 =?us-ascii?Q?+GDTl6ZEgVMINHKNh7eRDS+hJobwmOB6xTpg524Perlttlm+hiezloA9CQ0y?=
 =?us-ascii?Q?STRakF6CNHzUzLm+mu9iBKGQva+zgeF91S303spvXDng+0O5N+yxtsAoQNNI?=
 =?us-ascii?Q?Jg2AtgBFvZ9nIgiQzXug8vmMt2Sni/BKLKY8FiyIqDIxMETY9QoycI1zvBoV?=
 =?us-ascii?Q?uoytUi2Wt7ffHUiySEB+ajdQiG+0dK3tAv1LHzqDEinWZo50T7/nzfRQiA+A?=
 =?us-ascii?Q?QwhC22fB2lXTsaUoNv68zLHRzORwbdCBLr1ulIh4jfLLli0tOtNkQ1knBg8h?=
 =?us-ascii?Q?p20x/BYC9fKsigVE9f8MQe35U1cWpqzSM6sA4p1KUoNSgLulkbI1aoTNLnnn?=
 =?us-ascii?Q?O6IJl1To79t6srfD0zqeI5PClBFVY/roszPX2LfuVQbVt0zj9QDKgOXpvQ53?=
 =?us-ascii?Q?uYh29OKMfHiVLzRm1gm0dGAvT0mAOui0leFbuJu0+X1GCq29t0rlSZSOHIi5?=
 =?us-ascii?Q?9cZ6j7e72e03pAp/FYnekHRrFoGGs+KxIQEO+SuCXoI/gLmxTLftpW3OkFHc?=
 =?us-ascii?Q?St5JowGrZ495Ovz4iqnONvK8+vZ2+bZqbL9WwATo6yKE/l3fxVJgLERXiQ0g?=
 =?us-ascii?Q?66F0CKcEs6b0JyTHiGudeyThu3BSzLFvy0+fMgUBnIfcgtqB4lblLtDWwK94?=
 =?us-ascii?Q?Vd3+svfijk3HVCYrlb63mMKAD+P78rlNDWu7cFxUrhwt9L2TAwFVghROQ7Bf?=
 =?us-ascii?Q?EHSjVyJF/HhL8xMnEaY1V3BbawuaMtRQTKwD+2/wA/STtIBYUUqSKZoYNCdr?=
 =?us-ascii?Q?webpPmsZg1GdW03a+9q+E+QE88jS2czWdJfa2BuDGLH+1s4908TSFcYdmVdP?=
 =?us-ascii?Q?bGdS24Y3cMxMZ8S/O/v/hfHKT7r8wywAZmliwEWoDH1k+ba7HrXQYH4qjfAm?=
 =?us-ascii?Q?0fvfO83iU0NCfjm9s+IarQaZt78H19EkvDXZn/MgZx2ip/ZhhwnD/4oNVBY6?=
 =?us-ascii?Q?N8K7VxRL2C4tMNWfIg/RWRbKI3E4jDRT/ym+XWFWBeUgNgNxpJtfzig6+CrY?=
 =?us-ascii?Q?vcQLXs6ox5nBl/EcOs1pD/beYnu5/kvb/b6lUjZDLtIKkk7BlPbFVAIBQgND?=
 =?us-ascii?Q?FzoWaGq52+gHaDYNqm2CPEKprmu4nE/cikeoSFzJ2P5of2DTxTkZdi6BK1If?=
 =?us-ascii?Q?M3IeVgJJaezynwuGxPXahZpbosZF2oPGoOwlIGRZghflguIn/MWb1jXB310M?=
 =?us-ascii?Q?ZyDBeWCSQLvitsqoBgM7AmIK59hs7HYaUBHIRuHMsx+uk3ifdYEFiJGPA+Ja?=
 =?us-ascii?Q?+Efiqz2CuLr/OXmb2Ksphki69+pCO6082gK+Fc46h5b/5D/P6rXp9AO7ftOB?=
 =?us-ascii?Q?OAYQpdrdMmDZ6BOgNRJL4zBhqD+vtaByx5jROznVXwUG7+FBBP5UPwVnrPFU?=
 =?us-ascii?Q?yXEO1+uaELVVPHxtohHRJ681jXVAXoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <334C6BFC074406428E7FD2129DF27C7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b02a8-f7f9-403a-f604-08da39eacf7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 22:56:29.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VK/K/YbqRbirpfEZbqXXPcvRTn3qsybZhaZ6Kx8Kp/AXA0d6iEN+Vg3o2EVdKLGIQ1E4z4O5eQL/LW4ALEcmBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2941
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_06:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190123
X-Proofpoint-GUID: AvJNEjEj2oQg5IsS3yIl30eN4gOp5KDF
X-Proofpoint-ORIG-GUID: AvJNEjEj2oQg5IsS3yIl30eN4gOp5KDF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [220519 17:33]:
> On Thu, May 19, 2022 at 1:22 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [220516 03:56]:
> > > The primary reason to invoke the oom reaper from the exit_mmap path u=
sed
> > > to be a prevention of an excessive oom killing if the oom victim exit
> > > races with the oom reaper (see [1] for more details). The invocation =
has
> > > moved around since then because of the interaction with the munlock
> > > logic but the underlying reason has remained the same (see [2]).
> > >
> > > Munlock code is no longer a problem since [3] and there shouldn't be
> > > any blocking operation before the memory is unmapped by exit_mmap so
> > > the oom reaper invocation can be dropped. The unmapping part can be d=
one
> > > with the non-exclusive mmap_sem and the exclusive one is only require=
d
> > > when page tables are freed.
> > >
> > > Remove the oom_reaper from exit_mmap which will make the code easier =
to
> > > read. This is really unlikely to make any observable difference altho=
ugh
> > > some microbenchmarks could benefit from one less branch that needs to=
 be
> > > evaluated even though it almost never is true.
> > >
> > > [1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concu=
rrently")
> > > [2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unm=
ap, v3")
> > > [3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow =
oomreap")
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  include/linux/oom.h |  2 --
> > >  mm/mmap.c           | 31 ++++++++++++-------------------
> > >  mm/oom_kill.c       |  2 +-
> > >  3 files changed, 13 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > index 2db9a1432511..6cdf0772dbae 100644
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_spa=
ce(struct mm_struct *mm)
> > >       return 0;
> > >  }
> > >
> > > -bool __oom_reap_task_mm(struct mm_struct *mm);
> > > -
> > >  long oom_badness(struct task_struct *p,
> > >               unsigned long totalpages);
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 313b57d55a63..ded42150e706 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
> > >       /* mm's last user has gone, and its about to be pulled down */
> > >       mmu_notifier_release(mm);
> > >
> > > -     if (unlikely(mm_is_oom_victim(mm))) {
> > > -             /*
> > > -              * Manually reap the mm to free as much memory as possi=
ble.
> > > -              * Then, as the oom reaper does, set MMF_OOM_SKIP to di=
sregard
> > > -              * this mm from further consideration.  Taking mm->mmap=
_lock for
> > > -              * write after setting MMF_OOM_SKIP will guarantee that=
 the oom
> > > -              * reaper will not run on this mm again after mmap_lock=
 is
> > > -              * dropped.
> > > -              *
> > > -              * Nothing can be holding mm->mmap_lock here and the ab=
ove call
> > > -              * to mmu_notifier_release(mm) ensures mmu notifier cal=
lbacks in
> > > -              * __oom_reap_task_mm() will not block.
> > > -              */
> > > -             (void)__oom_reap_task_mm(mm);
> > > -             set_bit(MMF_OOM_SKIP, &mm->flags);
> > > -     }
> > > -
> > > -     mmap_write_lock(mm);
> > > +     mmap_read_lock(mm);
> > >       arch_exit_mmap(mm);
> >
> > arch_exit_mmap() was called under the write lock before, is it safe to
> > call it under the read lock?
>=20
> Ah, good catch. I missed at least one call chain which I believe would
> require arch_exit_mmap() to be called under write lock:
>=20
> arch_exit_mmap
>     ldt_arch_exit_mmap
>         free_ldt_pgtables
>             free_pgd_range
>=20
> I'll need to check whether arch_exit_mmap() has to be called before
> unmap_vmas(). If not, we could move it further down when we hold the
> write lock.
> Andrew, please remove this patchset from your tree for now until I fix th=
is.
>=20
> >
> > >
> > >       vma =3D mm->mmap;
> > >       if (!vma) {
> > >               /* Can happen if dup_mmap() received an OOM */
> > > -             mmap_write_unlock(mm);
> > > +             mmap_read_unlock(mm);
> > >               return;
> > >       }
> > >
> > > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> > >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> > >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > >       unmap_vmas(&tlb, vma, 0, -1);
> > > +     mmap_read_unlock(mm);
> > > +
> > > +     /*
> > > +      * Set MMF_OOM_SKIP to hide this task from the oom killer/reape=
r
> > > +      * because the memory has been already freed. Do not bother che=
cking
> > > +      * mm_is_oom_victim because setting a bit unconditionally is ch=
eaper.
> > > +      */
> > > +     set_bit(MMF_OOM_SKIP, &mm->flags);
> > > +
> > > +     mmap_write_lock(mm);
> >
> > Is there a race here?  We had a VMA but after the read lock was dropped=
,
> > could the oom killer cause the VMA to be invalidated?  I don't think so
> > but the comment above about dup_mmap() receiving an OOM makes me
> > question it.  The code before kept the write lock from when the VMA was
> > found until the end of the mm edits - and it had the check for !vma
> > within the block itself.  We are also hiding it from the oom killer
> > outside the read lock so it is possible for oom to find it in that
> > window, right?
>=20
> When I was trying to understand that comment and looked into
> dup_mmap() code, my conclusion was that this check was there to
> protect us from the case when dup_mmap() gets interrupted and leaves
> mm->mmap=3DNULL. So, in a sense it was not really a race with OOM killer
> but an interrupted dup_mmap() case. So, once we checked it above we
> don't need to recheck again under write lock. When I asked Michal
> about this he was in agreement but it's possible we overlooked some
> corner case. If so, please let me know and I can add this check here.

I didn't see how it was a problem either, neither of the other entry
points modify the vma linked list/tree.

>=20
> >
> > Could we just unconditionally set the skip bit before taking a write
> > lock for the duration of the exit?  I'm probably missing your reason fo=
r
> > doing it this way.
>=20
> That's what I'm doing - unconditionally setting MMF_OOM_SKIP before
> taking the write lock. Did I miss something?

Sorry, I meant to type "before the read lock".  I think you answered
this in the other thread though.  I think you want the oom killer and
process_mrelease to be able to run in parallel to the exiting of the
task?  If so, is it worth all tasks taking the read lock and then
dropping it to allow this rare case?

>=20
> >
> > >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEIL=
ING);
> > >       tlb_finish_mmu(&tlb);
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 49d7df39b02d..36355b162727 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -509,7 +509,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
> > >  static struct task_struct *oom_reaper_list;
> > >  static DEFINE_SPINLOCK(oom_reaper_lock);
> > >
> > > -bool __oom_reap_task_mm(struct mm_struct *mm)
> > > +static bool __oom_reap_task_mm(struct mm_struct *mm)
> > >  {
> > >       struct vm_area_struct *vma;
> > >       bool ret =3D true;
> > > --
> > > 2.36.0.550.gb090851708-goog
> > >
> > >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >=
