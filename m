Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5B54CC14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbiFOPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344237AbiFOPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:01:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9238BD5;
        Wed, 15 Jun 2022 08:01:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDbEZq015196;
        Wed, 15 Jun 2022 15:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2ZMgmdnNbAPUyt4bBvBpdy+e8hpqUPkD6li8G4zjwWg=;
 b=lQmaxaKYZ3SykLDlTbc5yXdjJ2pDz2j7gjvhxEX24xmy0+6kL6N/pB24WpXyP5SY/fLE
 iFCa5Gx5uc6VpSXYuOGva9eVe4eSyQTt3i66zWcXdGwHtkChMCNlOMD7Etde7/p1vPlZ
 wVb4+2okAakvdQcPXGCNkDaR9J0oWlW633w2sHd8b4qFJKP/4kh8JDARRb5hSIaI9Bu6
 PHQi8VqOrluarC+Om4H9TEsh4VEG5zOgV/vW+4x2pZdp0nDoDkFU8ss8+LaA31js2M85
 l3Ta3/tQ/L1040KPlFWf6XQcZlxz/z6Mi//DtUvSR3MtScP2k9CiOvm+1am9V8Nef3OG 2g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0gw9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 15:01:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FEQ7On023155;
        Wed, 15 Jun 2022 15:01:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25vyf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 15:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUB3r0NLUGG5dRTv4IGsFLlsPW2osFTyyb9vpHUCQewOqqum8Lz1FCgf3UiltrbzhH6iInvY096MqZTEAQLo+N5I4+34yTnC7+SzyoYZ6KTG900MNOdwQgy/D9XxgxyM04AkCY4OtrW/WsunrItNFzudM6FIeGKtnNh5KfpgMUurMwOAmnMsbsgsdqLEce31a11YX6ZSBD4KmMaP/Pqz2exsMqRj0YXVsAAqE5a2MerSmd/4hflCp7m+VadgHTekQrBz6qCQIectPrNtt3HBz9yzhf9tEKxfThHUCA41lB6+/pd9mg+k2KFVsuuSaibNKgrAB3gHaL/olLq/8gtZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZMgmdnNbAPUyt4bBvBpdy+e8hpqUPkD6li8G4zjwWg=;
 b=UbtieDgbEmrrlfMgPgJPJxqXg16lRSgowbCXrwQQ0KaS9yi+JKMTXnz/KFm+uvoCSCHXSiBD5dHtwT9ngHvEwI+lEdIiC92CFvn+I0VGccLQ76viKBaWxEiCF9GOXprzP18otcd7DDfnXCHQo50KNj3g8XB9mfqqzn07MEyZWlH/okYmvHv7Ybp3Ln8aAYuZxkDNYSkmJlF+unfCMJ4sGBviQFtj7m5trxdyN4epN+Y9h5k+iNsebp9UFuWYX7l4zPKKzvV1oYon9zeg7QOlt5czhugDti5jPSAUyTL5l/5bTa3qPcEHHv2dEIEcRA4FpesqqiKz+D5Mic/D4RdFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZMgmdnNbAPUyt4bBvBpdy+e8hpqUPkD6li8G4zjwWg=;
 b=V60miAKB1GCv2+YXIo64PBf72BMstYt8y5mNxKwh0mp7K9eczTNYi1fSgLmp44dS0wZaECE7hJT/Dyx3kJeocLYM1kcPGyKRQFHlNb7/5vM3hq6ZCsK7t2OOg0s07ByWq7AWbklhZfFUs8VV8g6i6WuOvYLjtWJfTY6BtwVttYM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3435.namprd10.prod.outlook.com (2603:10b6:5:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 15:01:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 15:01:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Issue in count_mm_mlocked_page_nr() with commit afcf76df48f9
 ("mm/mlock: use vma iterator and maple state instead of vma linked list")
Thread-Topic: Issue in count_mm_mlocked_page_nr() with commit afcf76df48f9
 ("mm/mlock: use vma iterator and maple state instead of vma linked list")
Thread-Index: AQHYf+KfGSNAMx0Wek+ZyXoAkLRdIa1QkcSA
Date:   Wed, 15 Jun 2022 15:01:27 +0000
Message-ID: <20220615150119.6uvfxpvlm3fxmjex@revolver>
References: <CAKXUXMxs3waRA8pveFQ2LRMF5imoHxjQ0zfLS_4vpfr2YSLYPw@mail.gmail.com>
In-Reply-To: <CAKXUXMxs3waRA8pveFQ2LRMF5imoHxjQ0zfLS_4vpfr2YSLYPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93400563-1780-4bbf-c96c-08da4edfec92
x-ms-traffictypediagnostic: DM6PR10MB3435:EE_
x-microsoft-antispam-prvs: <DM6PR10MB34351962EAC4FCD008A92423FDAD9@DM6PR10MB3435.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZHVH7TKSmQP0QwD5W2jYAY+gI16yL9Ii4d3sxcxblspVxi7nDLbCMvg3g2GMdyO+LEVMz1ZVf/KZthJBa+BT/REetWYPLeDHZdef7VDXcaB/W2AMg+zqHmUJT2nWwHejrK2+50bPV8NpX9px962hET2xA8PGEfe4I5/WI8Hr5/9bSrMtEhqaw7JsSD5domdhqRCg/snMhUvtWn1aO7U16WqYvg+29H5TvLIzhm1cJo9IG3m++XTWIREQLwyrC0XznPUScsDFn3z/y021qT2WfvAhghUilxiRfJwRgIdIUKLG2yiU3NTmKf6Esd5xbKtIqfPTcqITyT0bcogtP8CmWVQzAJlyWtGTaupum0Fu7XBy2qBohgAwcUsF6kscroQL14G3iaZ0u+/WyhoFSMHw1SEmCywgkL5NOe+j7Qcwa9xgO9fN1r81ZOOiIt8wogebSxCEA40s3Hy0g2uEiYL4++sidOJ6z8fLu9qh96pquY/GsxpcMOf66atlicNqzB3XsytHkTB6gIjxgJ02zt4rJwG37eYj/64cNm3JZccdyYvf8k8ereFSKBa7qQfx5QYt5lrbr80kRw/6awogHoAf6wxenLpg5UNDVSBOalDa3h7TaQxuqsUssNFmR11MiS5vf1dc64EbNTtykOze173w+iDxX74GkHWpmYhGWy0gATjbYDvrrWjyLSlubc7lT9qri8gkxlKQBAVZKnChxrbmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(44832011)(8676002)(316002)(91956017)(508600001)(83380400001)(33716001)(2906002)(6916009)(4326008)(6486002)(6506007)(86362001)(9686003)(54906003)(26005)(6512007)(71200400001)(122000001)(76116006)(5660300002)(186003)(1076003)(38100700002)(66446008)(66946007)(66476007)(8936002)(64756008)(38070700005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ThWdyxuqTiXdzV/8wVXxvp4TR8LAeoFQMD9/2iVze6bTm4qWQuf4XQwPm9xj?=
 =?us-ascii?Q?hEPWLBZj5x0H4ZSk4urHGiEqzOCJ0dBDLcSJXtJkClaWGWeXlKVLB53/vM9l?=
 =?us-ascii?Q?f4s+z3A9r77m7SXTtesf/XzFXyOHewQZvufZaxh/fGz8KzAc30HcBSLZFanM?=
 =?us-ascii?Q?ctq8YAc6yFwT55S3uoSaYgFQp/reZOVlIGkQN3Az8ypR0iArBwp2yuDUYAXB?=
 =?us-ascii?Q?A0Egz+SvO6/HGHctRNJ2/BuFmA4c81IIxH2yp9D14koM8QMg36ky+XbWjNr9?=
 =?us-ascii?Q?yLIXyRL3wuu77agwtZjIdyCVdwu2De3Tja9IgxzcsRAF14ziWtUS7PKVUTJQ?=
 =?us-ascii?Q?Z2FjcMz+NiuiuhbDJUVKKRXLzxRqetteZvXdxNE9aa/GNd9cX7SmLddiLtY8?=
 =?us-ascii?Q?/TaviXv6uMD5wLH/BBJNO9BT4bbfNKJ3Zvhi108IX2LnVEbQn7zvVsB2OY7b?=
 =?us-ascii?Q?Y+LZQVy5eO6JCMSaUmybKpoBzw06S0mnbH2PMY1B5b06qJwys1t5GURqHUWX?=
 =?us-ascii?Q?bDa5E7VmRHZ3RH1xqY0vwV3L5fE66N/piVwc2i3OSkSi0DF1FAIw5whrsDD1?=
 =?us-ascii?Q?a+gHjd9UhBL08ciyfY/IHQZCSL+IUtlHKYKO154FaRjaoimB3RTlnrH3Nu6x?=
 =?us-ascii?Q?rZsV8XvqRKTJlsZuurFVrBrdQl5WKQBgqHLf1qoRepvdYXgZ1UtQ3TEuJes2?=
 =?us-ascii?Q?EWJ0ho59gdVsHZyHPeKFLJ0SO1aNwVQMsfVxlSwLTgydv2mwjM6uAl7Rrdyq?=
 =?us-ascii?Q?de80MigWs/wY1eBV1ffpv/p5MNdjZGrk1+3e4IaQ3I+0nrZ21brnvYOB0feG?=
 =?us-ascii?Q?R16X6J8mYct/sbxhozh0YU2aKrXBYRWxTDjMsL1xF8gc7K/r8uCl/Mo6sk3K?=
 =?us-ascii?Q?2SjqXXo2/gGsGmaVmpRl2pqingSwYUUe7P9fTGxkE6qfkuQjjZeebCVCTyyV?=
 =?us-ascii?Q?RKH9o0PnGYQRTZbqqupZF1jRVJV/ZLmbs1uws9Z+Kayp6zBRcRBlWl/yywP6?=
 =?us-ascii?Q?T/DfxFZ3udqaJ72bnHRFXn7BItXz8m8VSSbAU+MR3QvRdYuFQ+Wh+thS8NY0?=
 =?us-ascii?Q?L9nMngI16OanFG9+m2auibdTwAJ3iIeOICEbIpy2H7CLje6ujAQYynNK0SyM?=
 =?us-ascii?Q?4Xonvvcp7x4kSZLD2+BR/4rubf8e4e4xBlU5Xg+suJO1FlOZ/HGZrDt2uQGy?=
 =?us-ascii?Q?wgpJRhGZn192hxWDplN0iiL/+n72lDcowzsJjtZ7Jnj8b8eozZeDABgSrApP?=
 =?us-ascii?Q?Wtkk8mtXlMXfHf8JboDoZCSmimwQbXZDi5VgMSm6t+rh2bQurrtx8eW2y5YR?=
 =?us-ascii?Q?Xtigh3IX3T5dReERGtixQYmTEnv8GoHho757I5Fh2Ulz1EJwEpKGthM9G5JO?=
 =?us-ascii?Q?RxhE3Vgp1LKehwYKmATJ0nW4j8su7zeowGTpyEJz0j1BCfWaV/xDyualT0s+?=
 =?us-ascii?Q?dQspuRG60zM/4jX73XWfplcCZOqCwbQRMFIEits6c2yXEkA39AUmitdgCoPD?=
 =?us-ascii?Q?uIllsNatHZsOMT+GxY5RAw9gH1gqUKVJP8ZBC63eX5+ZDq36naWkg5kD+6Nw?=
 =?us-ascii?Q?+mB3drbsvdfWtikZM5+a63tMekhCn9a2bC800EPJ1pTbjlxdVvzAjc9HPFl7?=
 =?us-ascii?Q?TRyf1s26tULVJeMxH8SobuhKsQCrouvBDrwFha4VkzfIRN5o9cH39uPXgzT0?=
 =?us-ascii?Q?PzES/EZSHfXYYsrwyhZgsHGgFc6XeIyFA3yn9/21x0srIXso4pLnAVlNQ7z7?=
 =?us-ascii?Q?fcnrqy3Lhy4OXJb2wnbLavirflklg9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A50A01A94723F43AD72F95C7A54671D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93400563-1780-4bbf-c96c-08da4edfec92
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 15:01:27.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rGt98uKF7wH196jFJVv/CHRI5F0zI0l2/MlXgspSsPCYl9C0whjJU/d1klzenGyl4BwQEjcDiWLsajK/84t1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3435
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150057
X-Proofpoint-GUID: oiRw6sWvoe54opm1x3twbbQH9pt1f74o
X-Proofpoint-ORIG-GUID: oiRw6sWvoe54opm1x3twbbQH9pt1f74o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [220614 07:33]:
> Dear Matthew, dear Liam,
>=20
> The commit afcf76df48f9 ("mm/mlock: use vma iterator and maple state inst=
ead
> of vma linked list") refactors the function count_mm_mlocked_page_nr() in
> mm/mlock.c, such that the special case:
>=20
>         if (mm =3D=3D NULL)
>                 mm =3D current->mm;
>=20
> is now dead code. Before the refactoring, after this if statement, the va=
riable
> mm was used further in vma =3D find_vma(mm, start) in the following line,=
 but now,
> with the introduction of VMA_ITERATOR(vmi, mm, start) before the if state=
ment,
> the assignment within the if statement is simply ignored.
>=20
> I assume that:
> - If the semantics of this function shall be preserved, the VMA_ITERATOR =
macro
> needs to move after the if statement.
>=20
> - or, if the consideration of the special case on mm =3D=3D NULL is actua=
lly
> obsolete with this refactoring, it could be simply deleted.

I think this code was never necessary.  This statement was added in the
same commit that added the only user of the function [1], which passes
in current->mm as the argument.

>=20
> I will keep it up to you how this issue is correctly resolved.
>=20
> This was discovered due to tracking all dead stores that clang-analyzer r=
eports
> on an x86 defconfig. The underlying issue here is more severe than "just =
a dead
> store in the kernel code base", but it is probably easy for you to resolv=
e.
>=20

Thanks for the report.  This code should be dropped.

[1] Commit ID 0cf2f6f6dc605

Regards,
Liam
