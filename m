Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD38652DE77
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiESUeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiESUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:34:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637A7A835
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:34:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJxJvF016112;
        Thu, 19 May 2022 20:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HSdX8JuL4MMuH/LMIKVQv3n36KHAeSSfnEsYUPiLxlY=;
 b=yk/Ojva28QrbtEa5H72xnMz/t4AS3J9f+oTxCLunFpjqu0Mgkgv7IqP6+SWjMUyy5cIK
 UoPSN7gSp3sF4W7L5llwXYelYv48JvD6FNu7YnDdU0K+8CgdM/Chgsr7syDylH1/ANBL
 i7pNx2qflFoLYoUVzEtRXnCyXE3/1Gt/AKj3x5fim7bx67ByqhsLbgu5wA2KVu4SS3wa
 2xtVn9LVBfKnEdA6G7SNT13EJDBJO5A1mg6mK5BWa9Olx8UMvr5p+4DONbkxKgCt+pt+
 sZh+B267xIuQJ5Gph4fo7krHeoBoIjgV0MCmUQJOe75xNxDBSJ4ABugmnWFMRKdak63K WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytwevs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 20:33:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JKF7tR001633;
        Thu, 19 May 2022 20:33:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v5nkts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 20:33:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8VgOAB3q7yVFaz4CYy9PzfR3eMOnBNY1T6VJQuUmsmmeWAXL/PmeECOzOEFx+KtynSwf3XLjvRtq3WCsPN/H3SfcW5XzAfz2PKUBX4ZQS78Smd7IaNwC9dJ/N9Hu1v9Us435Neo3pToNQlN+caHbS0Dt5TUsfnKwyvu3iy7Saqq9kY3YfhGdbV8aATqTaFZB/GRFHYDKnRh8I74RTDXziDEYwkNN5yFVKC6Tmw0xtnro3dBYw2aywi87z0Rn3rMugZIfVyAbZTHNZAybGCVV54aXRXrz8cKGEXA69hdGgUBECmND6n0sn4JKQqrQiGTaxBYGxnSSFTngkBVgYeu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSdX8JuL4MMuH/LMIKVQv3n36KHAeSSfnEsYUPiLxlY=;
 b=jo7IbPzuzyVGgKr85TRhAiwj9i4vKDBTJzt4cfv4XGoIOMRj4zmPJSuCMqV0nLmd1ncQyvwmXhIFt88BHpufBxJEkcsyVC7G5F/I3KiJRdu79nTF4V/9nh1BPZNe+QmUa4b+u+9MBaZGFx9JjTE95vTz3awoHtJ9RrEniFpVcVhxTQ9uM+ffDbE7dLMFLBCB59SV0/2TOjwMdWtWNL2uTr2oWMRz9ISSI9DlCf6ppaMDxq0wA5+hsA3/4XQgKGn7zLBgXaLKWczTtu3Beq8o4+sJBMsU1o9bzIBSHB5viLXEzhieifsTn9dx1p4FJvfeXaRelT1X6fPdMZgHV72JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSdX8JuL4MMuH/LMIKVQv3n36KHAeSSfnEsYUPiLxlY=;
 b=VIrY7k0PkfEDI/L9iUogYqHRRbUA17wMHSkkS3zgR06JWDQQoKLAHRNoA9k+GamUp2z+dqmw+kl0nmagqNIZ8Os7TJJ6Fm0YltYt7a/QIA2ZoCcN70Bst93wd+oGJlCjwrw3pjIOGw3dTLV2VSQdLga57/ceMZsXN4KiZI425Wo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3115.namprd10.prod.outlook.com (2603:10b6:5:1a2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 20:33:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 20:33:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Suren Baghdasaryan <surenb@google.com>,
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
Thread-Index: AQHYaPp0ya25IVmpGEOQVFiK/GoNEq0mm3EAgAASAwA=
Date:   Thu, 19 May 2022 20:33:38 +0000
Message-ID: <20220519203332.qsxuzxt2mufcbv3e@revolver>
References: <20220516075619.1277152-1-surenb@google.com>
 <20220519122904.5aef389360ee2cba42d7b4ca@linux-foundation.org>
In-Reply-To: <20220519122904.5aef389360ee2cba42d7b4ca@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d75b0c84-aee2-4de1-bfb0-08da39d6daef
x-ms-traffictypediagnostic: DM6PR10MB3115:EE_
x-microsoft-antispam-prvs: <DM6PR10MB311571D7E362B3F583399581FDD09@DM6PR10MB3115.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZr7mQmYOvWUxXp7wLxj02+GMz1L3VjeAKSIA7RAaOaz5FfzN9lebQ7eJKaO0/L3odBscWW6zhijVIoIS/mAg7yAg6bpetEeqoWIBEzeuY11cDQaJwfnynOkwFji6hWGa3qLcB08d1bClJS9Zv3hRfsJMqzVTBagglxyPxXbKrLcn7ClAMZHN9K6tE6+jLUw7kUpI+8hrcRdmaw5U9sEG2AYzdkxYInY6+THmrD2minagulWgH9FxAIeIzCC11X9qi0kMy5UGQrpjIvRzfTnJ3cgdu/5hD2rorE9kfyj7GJNakeK7Nk2QuvG0PJIsEFMoJ9QJZRsgcklMxMigNoY4FzFiw8RarvbRv4DnIdzDNQNnmwJibwq6TIJlCQ5RBgCaall+kiE6B6bS+n1+6WnclQgPZizjWzKLHklqJ2zJNnFtpfFrR3kTWd65+GOlmUrqr4lJ8IOuIsmIH5OCD1c36vsYE6jRpc5czSOh7LkiIHt89tkM16dkhGk0lJ56j2USWambFFAf6fB1frq7vv+MMeIRsBMlGmqBpKywh+pleO1GStX86JcSC6bH/rrsKoE8+sL9q8qjGAfUwOP9M8pY8+RMvoHPZ+WK2/++TwLLFiYhOvsflNKtbnbCBuejDaYuB3NahQEEVJis+GvqfBjBAu8X8jTkWUAjtcZONmlCXs9/mr/RIq05hneiq6862e+byK++YOHp+lEHKuoxmd5dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(5660300002)(1076003)(9686003)(83380400001)(6916009)(316002)(33716001)(6512007)(6506007)(7416002)(44832011)(2906002)(8936002)(186003)(76116006)(66446008)(66476007)(4326008)(8676002)(66556008)(122000001)(64756008)(91956017)(38070700005)(66946007)(38100700002)(71200400001)(86362001)(508600001)(6486002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eB1YHpaLM5MgNp4oTt7KtRNEmYK/2n+lrS0ps62nE1y5qsF1edK6W5FK2UNN?=
 =?us-ascii?Q?bEYSwSu1/WaSNYYshGOtf7umxpiKAbqpadPe+gEkmyaCPsGqkNFu99/jWOXg?=
 =?us-ascii?Q?lYruTbvNpl/wlDmFDH7Wpsg6U4kzZrLMTROGP12xwUFnkppdQoh9pb+8qrIS?=
 =?us-ascii?Q?TN2ttvAIZTv7Sh/8hh82nTQozN2xno13mE73MB+Wm7O8fIgPd1rkXTAnLIdn?=
 =?us-ascii?Q?1djpD2WdlWqrENTfUB3Pa4I7+UKVWmfwCpGF38ddx/amC1PoiPC56dWVG/XP?=
 =?us-ascii?Q?SJJSMhjJJLHSMXpRYVzKLbPhFIpzh+olfTd+fixRqqaOWJsPWsV3ANR1Losi?=
 =?us-ascii?Q?5qPRbEKx8zA+wvaj4L0ginghZ1nN1LbufSQ7zALz/e+nl86zG8xL9EMfQEQJ?=
 =?us-ascii?Q?+a26mACr02y/cBpBWSECucGuyiVi/rAoR/sh14NVGCbsUaOx76QAve12aBN0?=
 =?us-ascii?Q?dF3Ug83NKZTog/YmMYhycL3FkYQ9pkCecwwc2wTzNixT1jTP/ManPB7sao+8?=
 =?us-ascii?Q?i8qaLR3ZIBYyZ+w19jhuSXNjS0qguq6ZGX+wWDSf48jYuMYQRSJmmtmVANvE?=
 =?us-ascii?Q?SC6xaXYafHfzFft8DODyeveQven7K8q9QnR3ReqrjuYpWXbu0NGoajdmSocb?=
 =?us-ascii?Q?w0oBhjn5H87yghCOimABcWKQ4AtwMcD1ftnFAhzsukc68b92jz+/pEM/hOuH?=
 =?us-ascii?Q?Kp1rVuUsra5u9S73Sdgebd6Y9VYqKBw81fankR8LzM84Bb0ep8am5v4e2w0m?=
 =?us-ascii?Q?MqxCVzWRNGiArRqOfORC3/fRFpqRUV+952Qu8EHOgtFOpafJQMuCAQjxZOcQ?=
 =?us-ascii?Q?lDFM13BKD09PZQeuCAeg/bNzloz+d6NMHECcSwGYv+f3lu4UQuosPQjsGbUe?=
 =?us-ascii?Q?sljqEFxegpJTOb8X2XYDaBeSuNEVNsdFzqPu8X9cbMrUjrl5810sAiJ7G7zf?=
 =?us-ascii?Q?/5OkN4272u0LG3KTXB9QyGUhzZ1LpisKZKrsxQUk3AllCmvKp4RhpPhf/8kv?=
 =?us-ascii?Q?kOt8uV4GzIMQzq9KvOYHFsw6nFvMfr5p5WImwLkIPc+M+8BGqvlC1piOOS9Z?=
 =?us-ascii?Q?P79LeRtiJMWYuug9j2ex7ZFFn2dNa5CuPpp6Tol6hvzo/VKRC1flTX83B6mx?=
 =?us-ascii?Q?ETNZmiafNxMcEFrPp7+EMSYQxxsros2qxFfdle3AI6OauMDyijodDtGyUMSg?=
 =?us-ascii?Q?2a6BQH7euDwdx9PNe0F4d93onI8LjXOvwJk984n9NgJ33OHeLP7VvrlLEVS6?=
 =?us-ascii?Q?KN366yniyAZWX19ACDi/Vigmhd/1AK7xxWisRfXYHYWF/NSWgsYfub1jip1M?=
 =?us-ascii?Q?ldmfMIUldpzXMOqrKjrO90SLULDI+/qtRNDqor84g/Vqnxb3r2fzgisGt/i8?=
 =?us-ascii?Q?Oa9CHKb8kTqgXOsbk3K/6gOuEcZNuKh9idzrxL/Gm0Iyh4wyJC0cCVtTW3ij?=
 =?us-ascii?Q?ZckUwIh6NaB8xzstAmhEgmDcxtiTBRa/1MVC6lQmj5H8rYpVml5bN8PrJTj/?=
 =?us-ascii?Q?SxiPlM7/tfJ+8PBHxo+QCFseqWOhFKD66gVR3DjHB5C96x5sRT9Ri+Izk5PI?=
 =?us-ascii?Q?CUWhity+JFIoKuqv6CrakkqV9WFs1P2YzS/BE9pqUG3miTfPrezQnyl5mxvJ?=
 =?us-ascii?Q?927GaIa0K2kjNd+CAX6rzHc+k6c/Ne30/ee6c13isgDPUuRsaMgDKiRWQabl?=
 =?us-ascii?Q?L60lsV98JU1cy5X+V2rf1LSKlZ4BANoZaacMRh19InS0u57ZOZE+tzsImwXM?=
 =?us-ascii?Q?I1fwus4D4G1nxuLJcRO3f0otYiHPa04=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E250EB566AD604F9C74D647A0FC684A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75b0c84-aee2-4de1-bfb0-08da39d6daef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 20:33:38.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdXCtfKMmpF6DqdlaeWTYd72mpTPfDpzMpWoYibv2VglZWRWiEDdqAUn5HmEun4fKCjheqaHrkys6A5wZ+HUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3115
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_06:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190112
X-Proofpoint-GUID: 6QgDP8CbmeRDzdYRqNWr-X0j_4a78vEx
X-Proofpoint-ORIG-GUID: 6QgDP8CbmeRDzdYRqNWr-X0j_4a78vEx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220519 15:29]:
> On Mon, 16 May 2022 00:56:18 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>=20
> > The primary reason to invoke the oom reaper from the exit_mmap path use=
d
> > to be a prevention of an excessive oom killing if the oom victim exit
> > races with the oom reaper (see [1] for more details). The invocation ha=
s
> > moved around since then because of the interaction with the munlock
> > logic but the underlying reason has remained the same (see [2]).
> >=20
> > Munlock code is no longer a problem since [3] and there shouldn't be
> > any blocking operation before the memory is unmapped by exit_mmap so
> > the oom reaper invocation can be dropped. The unmapping part can be don=
e
> > with the non-exclusive mmap_sem and the exclusive one is only required
> > when page tables are freed.
> >=20
> > Remove the oom_reaper from exit_mmap which will make the code easier to
> > read. This is really unlikely to make any observable difference althoug=
h
> > some microbenchmarks could benefit from one less branch that needs to b=
e
> > evaluated even though it almost never is true.
> >=20
>=20
> Liam, this mucks "mm: start tracking VMAs with maple tree" somewhat.
>=20
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space=
(struct mm_struct *mm)
> >  	return 0;
> >  }
> > =20
> > -bool __oom_reap_task_mm(struct mm_struct *mm);
> > -
> >  long oom_badness(struct task_struct *p,
> >  		unsigned long totalpages);
> > =20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 313b57d55a63..ded42150e706 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
> >  	/* mm's last user has gone, and its about to be pulled down */
> >  	mmu_notifier_release(mm);
> > =20
> > -	if (unlikely(mm_is_oom_victim(mm))) {
> > -		/*
> > -		 * Manually reap the mm to free as much memory as possible.
> > -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> > -		 * this mm from further consideration.  Taking mm->mmap_lock for
> > -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> > -		 * reaper will not run on this mm again after mmap_lock is
> > -		 * dropped.
> > -		 *
> > -		 * Nothing can be holding mm->mmap_lock here and the above call
> > -		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> > -		 * __oom_reap_task_mm() will not block.
> > -		 */
> > -		(void)__oom_reap_task_mm(mm);
> > -		set_bit(MMF_OOM_SKIP, &mm->flags);
> > -	}
> > -
> > -	mmap_write_lock(mm);
> > +	mmap_read_lock(mm);
> >  	arch_exit_mmap(mm);
> > =20
> >  	vma =3D mm->mmap;
> >  	if (!vma) {
> >  		/* Can happen if dup_mmap() received an OOM */
> > -		mmap_write_unlock(mm);
> > +		mmap_read_unlock(mm);
> >  		return;
> >  	}
> > =20
> > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> >  	/* update_hiwater_rss(mm) here? but nobody should be looking */
> >  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
> >  	unmap_vmas(&tlb, vma, 0, -1);
> > +	mmap_read_unlock(mm);
> > +
> > +	/*
> > +	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> > +	 * because the memory has been already freed. Do not bother checking
> > +	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> > +	 */
> > +	set_bit(MMF_OOM_SKIP, &mm->flags);
> > +
> > +	mmap_write_lock(mm);
> >  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> >  	tlb_finish_mmu(&tlb);
> > =20
>=20
> I ended up with the below rework of "mm: start tracking VMAs with maple
> tree".  Please triple check?

One small fix in the first one.  Suren found a race with the oom or
process_mrelease that needed the linked list to be removed here.  Please
correct me if I am mistaken, Suren?

>=20
> void exit_mmap(struct mm_struct *mm)
> {
> 	struct mmu_gather tlb;
> 	struct vm_area_struct *vma;
> 	unsigned long nr_accounted =3D 0;
>=20
> 	/* mm's last user has gone, and its about to be pulled down */
> 	mmu_notifier_release(mm);
>=20
> 	mmap_write_lock(mm);
> 	arch_exit_mmap(mm);
> 	vma =3D mm->mmap;
> 	if (!vma) {
> 		/* Can happen if dup_mmap() received an OOM */
> 		mmap_write_unlock(mm);
> 		return;
> 	}
>=20
> 	lru_add_drain();
> 	flush_cache_mm(mm);
> 	tlb_gather_mmu_fullmm(&tlb, mm);
> 	/* update_hiwater_rss(mm) here? but nobody should be looking */
> 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
> 	unmap_vmas(&tlb, vma, 0, -1);
>=20
> 	/*
> 	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> 	 * because the memory has been already freed. Do not bother checking
> 	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> 	 */
> 	set_bit(MMF_OOM_SKIP, &mm->flags);
>=20
> 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> 	tlb_finish_mmu(&tlb);
>=20
> 	/* Walk the list again, actually closing and freeing it. */
> 	while (vma) {
> 		if (vma->vm_flags & VM_ACCOUNT)
> 			nr_accounted +=3D vma_pages(vma);
> 		vma =3D remove_vma(vma);
> 		cond_resched();
> 	}
>=20
> 	trace_exit_mmap(mm);
> 	__mt_destroy(&mm->mm_mt);

+	mm->mmap =3D NULL;

> 	mmap_write_unlock(mm);
> 	vm_unacct_memory(nr_accounted);
> }
>=20
>=20
> And "mm: remove the vma linked list" needed further reworking.  I ended
> up with
>=20
> void exit_mmap(struct mm_struct *mm)
> {
> 	struct mmu_gather tlb;
> 	struct vm_area_struct *vma;
> 	unsigned long nr_accounted =3D 0;
> 	MA_STATE(mas, &mm->mm_mt, 0, 0);
> 	int count =3D 0;
>=20
> 	/* mm's last user has gone, and its about to be pulled down */
> 	mmu_notifier_release(mm);
>=20
> 	mmap_write_lock(mm);
> 	arch_exit_mmap(mm);
> 	vma =3D mas_find(&mas, ULONG_MAX);
> 	if (!vma) {
> 		/* Can happen if dup_mmap() received an OOM */
> 		mmap_write_unlock(mm);
> 		return;
> 	}
>=20
> 	lru_add_drain();
> 	flush_cache_mm(mm);
> 	tlb_gather_mmu_fullmm(&tlb, mm);
> 	/* update_hiwater_rss(mm) here? but nobody should be looking */
> 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
> 	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
>=20
> 	/*
> 	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> 	 * because the memory has been already freed. Do not bother checking
> 	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> 	 */
> 	set_bit(MMF_OOM_SKIP, &mm->flags);
>=20
> 	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_C=
EILING);
> 	tlb_finish_mmu(&tlb);
>=20
> 	/*
> 	 * Walk the list again, actually closing and freeing it, with preemption
> 	 * enabled, without holding any MM locks besides the unreachable
> 	 * mmap_write_lock.
> 	 */
> 	do {
> 		if (vma->vm_flags & VM_ACCOUNT)
> 			nr_accounted +=3D vma_pages(vma);
> 		remove_vma(vma);
> 		count++;
> 		cond_resched();
> 	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
>=20
> 	BUG_ON(count !=3D mm->map_count);
>=20
> 	trace_exit_mmap(mm);
> 	__mt_destroy(&mm->mm_mt);
> 	mmap_write_unlock(mm);
> 	vm_unacct_memory(nr_accounted);
> }

It is worth noting that this drops the mmap_read_lock/unlock before the
write locking.  I'm not sure why Suren had it in his patches and I've
responded just now asking about it.  It may be an important aspect of
what he was planning.

Thanks,
Liam


>=20
>=20
> The mapletree patches remain hidden from mm.git until, I expect, next wee=
k.
>=20
> Thanks.
>=20
> =
