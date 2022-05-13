Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B645267CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382732AbiEMRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382765AbiEMRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:01:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028457107
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:00:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdEvO031702;
        Fri, 13 May 2022 17:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y4d7xxFUf12zTR8IiqzsxC85rmjzQDZy99akyoJ7KOU=;
 b=kLDZaasgp7aSRPe/8bbzs0DkQIWgCtVqYnwYw7awxUur+npIzzdNZPt+yi7LknI/eD5p
 q8W++k7IWIkK8PM0dCwSJaHUhkTOz5GJMaP9beKcmUPNtpQJHs5tVPZsli6Kne+7R5UV
 hVJBCNXz1lnMmy6ksmzBPHo8KBXVIJPTf6uiRf1EH7fiWT7AoIT5jurZCNewEG1eFi+g
 plRiriHnqWU6ibYV9mu9NbEUroGmQy/6v8xVkPx8G39ZDFBCCaguKiJYr/rKyAwNGf1r
 8RPoSKquYhTZaunrXnYkcUkrJQ3aewMCjAAewNuubTYAMp5qwxsQFhk6Mns31L0tCFHE lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04q558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 17:00:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DGjlpt037649;
        Fri, 13 May 2022 17:00:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf768c57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 17:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDBAOEDuGnVqgABjpwIEbfopcII62iPrgSgiLSVduy7ww7Nn03cwwCSDkjIA37rbM/k3TIRpy4BnizavLIQl5TNe/sphAch15gUZByBjzd+z68j4RD15HxPo7wr6tw04xQYPQcoBMb4gsgt7xnOeRA6KE9qEZlUR/3KUfFXhCP35o5zdduFW2uAH8OW6sEkP+iiZi1yUJtnxdpOFCiiqzF53NA6wuJOLMuVCkYGDA0O+8HEwzNoe7nwGvmN/81KCxZcSCDQbGFcfnDoFKGKj/5Gauo7FtxZcik9KeFyuKklvxTwyMeqA1Lfb1qQF50h3JWqcfJiqUyNDELErF5xpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4d7xxFUf12zTR8IiqzsxC85rmjzQDZy99akyoJ7KOU=;
 b=odZZ7QAisUC1f9wy82Pmjyg7Or/V14UQBslrJoi3Ojmb6j6wzGgZVvYv8Aq0E2Sefv786/NbJHomvOZdTiE+TeemEX3ggf5c1VR/pjUfMePuuJI32ydJz0JQP3BuvJKDMstbAfs1L656Gs8VhGN886OPXSFrL9Der4e4TZr4F2hYCcCQgdDIkQq4f34iCwufTA7196dBSC0civizkBcvbvXA5mVl68mYQoFhXnGIw3pIbjIGITxFQ+ZpODcME1PpE1+Wb3m0GcyznoUQ9dYh7KW/k7aB81IbUIr2RlLLfNP7Nbgu85JUnVegOqE0BIAJ7AA3OjQV1Ix1lvhZg3LPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4d7xxFUf12zTR8IiqzsxC85rmjzQDZy99akyoJ7KOU=;
 b=bgD727aH4mznlztYu0SMoB8cLtVxzYBb0mQJyaaXKF5zAM5g4uj7DXUFPl9KGBSEuZFKG1zZn8k8v5+vb/vkwwm6d4+vBWRnerxJnWycVFHv/0jJ7I/zsB3tyaMCb8841jbmbey5pwTgO11IVRrRu3j6Zk6pf6TsFFR1wRAFxEw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3025.namprd10.prod.outlook.com (2603:10b6:208:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Fri, 13 May
 2022 17:00:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.025; Fri, 13 May 2022
 17:00:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAA==
Date:   Fri, 13 May 2022 17:00:31 +0000
Message-ID: <20220513165955.mkg5wvfi4dwpzoer@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com>
In-Reply-To: <yt9dk0apbicu.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e0efa3-a241-4db4-712f-08da350216e6
x-ms-traffictypediagnostic: BL0PR10MB3025:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3025BC1852ACAFADE306E041FDCA9@BL0PR10MB3025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4W8yuPoU0iqFbd3PP7pZ0Y+mLIOyQu0zXGsHGl/rYOK5FCFH9o4Nhc7cg0Fc3K6nadjbYfecOv6nUG/f28rsF3KSCVMzsm3EqXQdvbQMa0acmZOYh0gtqSEVBMlppOY1WwS5I2dMfkl2HjgyZv0MTWaNxR2GXo5y98/JLQiEYysfRftkdQFp6Avsmw+s/+fPkwo/zemaAo3BFMhT0egexT2MZh9Pl3vjqL66p6EFZyJcHNruoyXIi3DVASRlhsF/PEjcVyVsxTMIWbw0L8mEi0OfxNzswnX/Y8i4H95GsXn+Ur779ofu4erWjPWoRIQYXlno2u/R3+d5fSmGtePJSrkXxEZ++e5+oNeWfAoqHPUlAcxwU7s069yUzH7jLOVdDT65F07BQD2B68n3Orml5TDOpv/mK/Xu3VRIgoq8l5AcpTNa1oRCFIb7nc4lVQDrxc4UZP8GaOTpG94ZHlZo28JZ96x5NRVOtqX/N7fAqHEVOb1ES6OOpbXAI2A51eslyWAltKjBuikEHIRyJJgMnT6pLCSrpjjQQjXkQ/HVF5n2JpcdTvIXMz6+1Xu/OorMczTiZd44AssJGSisUeI2k3olnvk5jhypdCTxRaLct8U1udKSPZ3udWje73SEXT6uis0hskGROqoBluAI+aHwxfiSMSS6DUbeFBG201obO9pc+14NfnXXn0YsTGUwLKTFd8axmJnZ0JDLWT9UjS/pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(6506007)(508600001)(8936002)(5660300002)(91956017)(2906002)(66476007)(66946007)(76116006)(66556008)(66446008)(8676002)(64756008)(4326008)(26005)(38100700002)(38070700005)(9686003)(6512007)(33716001)(1076003)(54906003)(86362001)(6486002)(83380400001)(44832011)(186003)(122000001)(71200400001)(6916009)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NV8OO8LdM2lpk2/03bCCKgs5cBp584CqzFtcCRLXUqGrNfYBjhR7oPhfht4D?=
 =?us-ascii?Q?KC07Hw0EqFy8Jh7ieLHueSN9XXT+jtboEPojwgYZhB9dL/8drjGtK8hMMTHF?=
 =?us-ascii?Q?cOKbviZiHmVljwTKvuF8ApAaXYf0YmKvBtGzbr/iTe2hSbWpYpxRPF1XZ45i?=
 =?us-ascii?Q?gE8HmkxibUwUHDxJSubuuVXpxTLPT+sACWKHOkqtHC8RkcNcKnMuLZiWv+JC?=
 =?us-ascii?Q?u3oxYpGjS8j/qSg10Feaj85wc6C74C04aJYDzu4Bz+CNbDKo5leTzxw3R0OB?=
 =?us-ascii?Q?+0eRbjK6MPGcyQF1ktpk+W43XsaIfSWi2qBOwETOZ4MiB5UlGR44wKRhVE/F?=
 =?us-ascii?Q?za8Y7ZeGq9MmtXqdKIJwTXSSRagws4Ex0Vyire0c0YFm8Ng4BNcxSvsGULmA?=
 =?us-ascii?Q?GrFytTXGtOM6rW4rvKPmz0oo+VvjRTn0u07UMJ6bHUlWYXfIIk/YzhjEDpDS?=
 =?us-ascii?Q?Rfzxhp3Aom4Os1DqT4CKaeMBEH6aei/BmewUcr3Uqxe+VBQl8n5C1CSfguEH?=
 =?us-ascii?Q?vbyTDx6C8z/57CuA4JYQbG3Xkdj604xNPe5OK7tudpHCHjN7M2xCLF9wgeF7?=
 =?us-ascii?Q?rsf+WlMC5MsxXNvQNu/FW3Ev7GpRapt1ZaBbWnvTEO8xXAmAF7Z0fQioN7gy?=
 =?us-ascii?Q?ncPT0q6ukkADKoI7uhhnhC3/i4z54uFlam24AxkkvBHEUecuSi1bRH2tC8bF?=
 =?us-ascii?Q?n9VWGK0cSrfaij2kzbKm+6GbivAvR4cgtJL9GWNELp+4xT/STI3qHQ5tzxKy?=
 =?us-ascii?Q?2BiNvSnGRNp7kXobqTv7JSC0zQS/rmjGavH0C6LmK0ZfoOa1JGdpioh0RPQT?=
 =?us-ascii?Q?z5dg9tA3y6WKPBcb+3joS2N/6HsY91XrOvlV4Djnp89x5VQHIEDVgBJebUBy?=
 =?us-ascii?Q?PWouEXTW9c21bXAwpLrT+i49iupRb2jnjjswM60rvg12+N8gpywRiS2ckNN7?=
 =?us-ascii?Q?YEcsByM+KnThXw/tV7KIoewEthBpbRvNMI5F2S03nRUQR6sXIysooBY4Btlo?=
 =?us-ascii?Q?OSp3Gu+bUU4WT/1MPUiWOB8yQubqH9+8ETvqS7OesXbSRIeGcjyiUYirWQxc?=
 =?us-ascii?Q?ZAfB/Db2xTdaPOBm89YC3dXt5c/S4uPZRpFf/WruZcKxwTo6q5SMFL1vA51F?=
 =?us-ascii?Q?QuImE3E4qpJ2nvPGBvKy1EdPrJ5nNQedVlOIkKdeQzsBEmP/uyilq+XeJUBp?=
 =?us-ascii?Q?GFDso683H+6m9eQnBNdp9U1oT5WLgDMi8Qu8JwQGd6e6gNbsDU/+iT4oaOke?=
 =?us-ascii?Q?Cge2u3EYFkNKN5oH+LeHCeoSx8O0lbiJzFI0w4ORQMHsIcczg7b3eJ26VKs1?=
 =?us-ascii?Q?iK/ky7KMFZyg+A7Is4sq5AKly402ABvBKsI2WEcFdaJKXibKF5xO27AaPm70?=
 =?us-ascii?Q?5f/iCyhjubpNH8ohAYm0ODAnb6kpTNLavNdxkrkIJQN8XirKH4X5qVQDAHwv?=
 =?us-ascii?Q?FM2V8UuPM+lzlUrCj14nImgwU7EsRLcbhy8ZMIrkMOmTPXbzQGPCbyqZJHxu?=
 =?us-ascii?Q?Z69O5ZoOGXgSGDoC8tZHZJaoa5r2DoFdkh8Zz9dZ3InQRamp+Z0gzl2EDhfB?=
 =?us-ascii?Q?eFoAJALtu95yeEeaQ2AOm/56OYJwOvhozhrjUJ6ACdGdZ0m98EK7gM7nrJt9?=
 =?us-ascii?Q?+MdMs7m/IPvHna9nS+enagyA4YkH1PMvyl3c+Z2PVI+Ct4wycaEZD4E+91kL?=
 =?us-ascii?Q?garAE2oExU9Qw3K3H0MW2i8qkG4NsUK90JRBtGmMsBG0jELbZRDg2+aMvu9K?=
 =?us-ascii?Q?r/QPpqcLNi2pe8hBwKuCEuAz4x1BkhY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6125B686538586439A8E9C3037DF7D2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e0efa3-a241-4db4-712f-08da350216e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:00:31.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdjUCGnvlMDA7nT8dI6yejru4btoX9FiMP7WA4GhE152LX4k7Tsd2eC3MVX5K9FWIXIkmO5bdqhUEoyjS2d8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_06:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=977
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130072
X-Proofpoint-GUID: IVYaiYl8l9uvtfs6RhKgOvhXpa2ikQIb
X-Proofpoint-ORIG-GUID: IVYaiYl8l9uvtfs6RhKgOvhXpa2ikQIb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
> Heiko Carstens <hca@linux.ibm.com> writes:
>=20
> > On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> >> On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> >> > Fix mapletree for patch series "Make khugepaged collapse readonly FS=
 THP
> >> > more consistent", v3.
> >> >=20
> >> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> >> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>=20
> >> This patch causes all my sparc64 boot tests to fail. Bisect and crash =
logs
> >> attached.
> >>=20
> >> Guenter
> >>=20

....

> >
> > FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> > bisect, but given that the call trace, and even the failing address
> > match, I'm quite confident it is the same reason.
> >
> > Unable to handle kernel pointer dereference in virtual kernel address s=
pace
> > Failing address: 0e00000000000000 TEID: 0e00000000000803
> > Fault in home space mode while using kernel ASCE.
> > AS:00000000bac44007 R3:00000001ffff0007 S:00000001fffef800 P:0000000000=
00003d
> > Oops: 0038 ilc:3 [#1] SMP
> > CPU: 3 PID: 79757 Comm: pt_upgrade_race Tainted: G            E K   5.1=
8.0-20220428.rc4.git500.bdc61aad77fa.300.fc35.s390x+next #1
> > Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
> > Krnl PSW : 0704c00180000000 00000000b912c9a2 (mmap_region+0x1a2/0x8a8)
> >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> > Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 000000000=
0000000
> >            ffffffffffffffff 000000000000000f 00000380016b3d98 000008000=
0100000
> >            000000008364c100 0000080000000000 0000000000100077 0e0000000=
0000000
> >            00000000909da100 00000380016b3c58 00000000b912c982 000003800=
16b3b40
> > Krnl Code: 00000000b912c992: a774002c          brc     7,00000000b912c9=
ea
> >            00000000b912c996: ecb80225007c      cgij    %r11,0,8,0000000=
0b912cde0
> >           #00000000b912c99c: e310f0f80004      lg      %r1,248(%r15)
> >           >00000000b912c9a2: e37010000020      cg      %r7,0(%r1)
> >            00000000b912c9a8: a784010b          brc     8,00000000b912cb=
be
> >            00000000b912c9ac: e310f0e80004      lg      %r1,232(%r15)
> >            00000000b912c9b2: ec180013007c      cgij    %r1,0,8,00000000=
b912c9d8
> >            00000000b912c9b8: e310f0e80004      lg      %r1,232(%r15)
> > Call Trace:
> >  [<00000000b912c9a2>] mmap_region+0x1a2/0x8a8
> > ([<00000000b912c982>] mmap_region+0x182/0x8a8)
> >  [<00000000b912d492>] do_mmap+0x3ea/0x4c8
> >  [<00000000b90fb9cc>] vm_mmap_pgoff+0xd4/0x170
> >  [<00000000b9129c9a>] ksys_mmap_pgoff+0x62/0x238
> >  [<00000000b912a034>] __s390x_sys_old_mmap+0x74/0x98
> >  [<00000000b9a78ff8>] __do_syscall+0x1d8/0x200
> >  [<00000000b9a872a2>] system_call+0x82/0xb0
> > Last Breaking-Event-Address:
> >  [<00000000b9b9e678>] __s390_indirect_jump_r14+0x0/0xc
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
>=20
> Starting today we're still seeing the same crash with linux-next from
> (next-20220513):
>=20
> [  211.937897] CPU: 7 PID: 535 Comm: pt_upgrade Not tainted 5.18.0-rc6-11=
648-g76535d42eb53-dirty #732
> [  211.937902] Unable to handle kernel pointer dereference in virtual ker=
nel address space
> [  211.937903] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [  211.937906] Failing address: 0e00000000000000 TEID: 0e00000000000803
> [  211.937909] Krnl PSW : 0704c00180000000 0000001ca52f06d6
> [  211.937910] Fault in home space mode while using kernel ASCE.
> [  211.937917] AS:0000001ca6e24007 R3:0000001fffff0007 S:0000001ffffef800=
 P:000000000000003d
> [  211.937914]  (mmap_region+0x19e/0x848)
> [  211.937929]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
> [  211.937939] Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000=
000 0000000000000000
> [  211.937942]            ffffffff00000f0f ffffffffffffffff 0e00000000000=
000 0000040000001000
> [  211.937945]            0000000083551900 0000040000000000 0000000000000=
0fb 000003800070fc58
> [  211.937947]            000000008f490000 0000000000000000 0000001ca52f0=
6b6 000003800070fb48
> [  211.937959] Krnl Code: 0000001ca52f06c6: a7740021            brc     7=
,0000001ca52f0708
> [  211.937959]            0000001ca52f06ca: ec6801b3007c        cgij    %=
r6,0,8,0000001ca52f0a30
> [  211.937959]           #0000001ca52f06d0: e310f0f80004        lg      %=
r1,248(%r15)
> [  211.937959]           >0000001ca52f06d6: e37010000020        cg      %=
r7,0(%r1)
> [  211.937959]            0000001ca52f06dc: a78400ea            brc     8=
,0000001ca52f08b0
> [  211.937959]            0000001ca52f06e0: e310f0f00004        lg      %=
r1,240(%r15)
> [  211.937959]            0000001ca52f06e6: ec180008007c        cgij    %=
r1,0,8,0000001ca52f06f6
> [  211.937959]            0000001ca52f06ec: e39010080020        cg      %=
r9,8(%r1)
> [  211.937973] Call Trace:
> [  211.937975]  [<0000001ca52f06d6>] mmap_region+0x19e/0x848
> [  211.937978] ([<0000001ca52f06b6>] mmap_region+0x17e/0x848)
> [  211.937981]  [<0000001ca52f116a>] do_mmap+0x3ea/0x4c8
> [  211.937983]  [<0000001ca52bed12>] vm_mmap_pgoff+0xda/0x178
> [  211.937987]  [<0000001ca52ed5ea>] ksys_mmap_pgoff+0x62/0x238
> [  211.937989]  [<0000001ca52ed992>] __s390x_sys_old_mmap+0x7a/0xa0
> [  211.937993]  [<0000001ca5c4ef5c>] __do_syscall+0x1d4/0x200
> [  211.937999]  [<0000001ca5c5d572>] system_call+0x82/0xb0
> [  211.938002] Last Breaking-Event-Address:
> [  211.938003]  [<0000001ca5888616>] mas_prev+0xb6/0xc0
> [  211.938010] Oops: 0038 ilc:3 [#2]
> [  211.938011] Kernel panic - not syncing: Fatal exception: panic_on_oops
> [  211.938012] SMP
> [  211.938014] Modules linked in:
> 07: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000001C
> A50679A6
>=20
> IS that issue supposed to be fixed? git bisect pointed me to
>=20
> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
>   'mm-everything' of
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>=20
> which isn't really helpful.
>=20
> Anything we could help with debugging this?

I tested the maple tree on top of the s390 as it was the same crash and
it was okay.  I haven't tested the mm-everything branch though.  Can you
test mm-unstable?

I'll continue setting up a sparc VM for testing here and test
mm-everything on that and the s390

Thanks,
Liam=
