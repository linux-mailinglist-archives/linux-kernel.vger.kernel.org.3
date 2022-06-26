Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591455B30B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiFZRJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFZRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:09:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C02DF46
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:09:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25QBjUPw025906;
        Sun, 26 Jun 2022 17:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4PrjR0lRUlWRUgB2nHAlfTXYBoeCYARfQqAmhOzDIhE=;
 b=bcWSe0yMqQot5r01cmt8ORELxGY5HKZeSpPBOXcpFIa0gad9QigrfjmJo4QzICMfbL3X
 hu1JIGgQnI3KcEwgwy9aJc2KFk9Impvo4FETCAbiE5496XM8NAJxjuIIKiRHSMJCZSpb
 BRfodEfQn1iggVjyMWiMg+gI7gIyTO1amOSaqcKpoPt5w0W0yMvC7mF0LvbO0v33k82x
 bdRU95m1uQxm5Fa/Jqp0aM7Qy9RRkno0TifStvTKlMyp2GRFqFwcv+KpzVpEj++RgpKH
 GdHARKVt9odrJbd2QNtr1jsTjuiEGG6XMjlyegmygBbP8xAD2Hd3avto/g/v7whjUkx0 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu1mhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 17:09:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25QH1MHl019483;
        Sun, 26 Jun 2022 17:09:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt6qt19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 17:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkaTQo9doEy3/wzqnERG3E5jzIHEl+g8LUYGhLVBkrPHkJJbC3+nsQ/bessKCh159Y4TCKYO0TRh9msPkY7gkICVYcgdN01HHPTu9fOVzsKiJieeA+B6WRx//QWe/3ys+/L7bRVxu7rKrEaWpaIugM6CKNiP/0r+C5mPZ+yQyJyFHgposekKwQRQJTeGlXDOHatxWgjjG4Mikcp0GrBDGicdfvqMCGHQnM9wRwdAQYNjrRO7z1NKB8jejcvST9/jMDjo+0V41z/kiJBY/iao9lLdCGNvkJR9AKdE66vOFIT2BJUEW0VQldaQw5LtjQUHcAOi+EwF2+iv6HHo0FVNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PrjR0lRUlWRUgB2nHAlfTXYBoeCYARfQqAmhOzDIhE=;
 b=WgmTKHbZqqwNiArl23zQotldfdIRwrB0hmJ+khqTNfjC4yxKBDJHQTVhYoae1VABDoA+Mu7czoODUFAJjx5ZnyOH9PlzpCykbOMY4bs01p2az3Ntj0QOtFjT4NhuqUMu1ZFwbXD/EjEVrehv6fqov3voujdhhHGSMyvGlZuuJuAoBI1GiFOSG5pkcYLF8ma+YRGwjFe7HYjyyOt+fwTqo9SXyqQGnzwfqYWwnW6PGg4jLSDXqAkVfF0Q5Dd3FAWDfKXRH6dTO5VdM24pMl1Nm9/SJCV/ZjZs28bzQcjuj4gR5mNHGWJM1c2khZSqKE1rZ+icKDnmZk0Px3kGCu+Ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PrjR0lRUlWRUgB2nHAlfTXYBoeCYARfQqAmhOzDIhE=;
 b=IzqEjRW47s22VpuCAn7dZuCRA5HgoIBz9j0AtWinaebUKCiS89h+0ip3ay8gN17jJ3kTZ89Lplj8fXMwpNL/9F+1CV9huzvh6L5pV5H2jQ3K/Sdcf4j8nPcKqJ9dkb8gohR+spKHpkuSFBZPyeAVvQ7MxLp62eUtQtI6Cd0g2sk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Sun, 26 Jun
 2022 17:09:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 17:09:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB70xgIABL6QAgAAImQCAABIPAIAARgOAgAEwG4A=
Date:   Sun, 26 Jun 2022 17:09:31 +0000
Message-ID: <B902ACBA-9318-418D-A14A-1411E7A8B47D@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
 <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
 <20220625134552.08c1a23a@rorschach.local.home>
 <AD7B3406-C1A3-4AC0-BFD5-C7DF7E449478@oracle.com>
 <20220625190105.750bbb0a@rorschach.local.home>
In-Reply-To: <20220625190105.750bbb0a@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2feab7dc-2095-45c6-1207-08da5796a2e1
x-ms-traffictypediagnostic: BLAPR10MB5156:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3M3r1boOOSIZfuXQMshKosuGmAiGdgvycznfmH4EkWcOHPKkAzdHjeVEQGujOyLghQ9IoNrY1KExyXuQ7ac0B7IvLMoafo7zEOUm0f1MxwM73JciHbjZha3NQJREbaSxZES5X8UgNwBie3gN8EASn6FTTglAE0qfGiJcY+atCswZ6NhxODkTiaDG1hccIVRN1qwaZj0V5lN8IxvBP+V5K+2AA+pZTHdoGFxAo0+MpncwHnEoZAwqy3EwlyGT+Vkt1k7b2JiNPn/Zo6s2TAWw8l7P5YYsQogBf/53YpNEPAtG6p5btM3QtbGKRJWLzVQqieLLMeskg7UEDMpOZLB5EY2wPaXaHYTLWaKFd6IfG+7TXzBhZXFQOQbXl9XXf3zQsstPkAB9Wl5mTP7w26n3A5QRFMNeJqXd+vgobY1khWUk2XOCamMs9etdiXYmbW4wE/TsbUrRwq9tlse7zCs2T6sgsq8pkWeTKYaJb8zyfL6voDoanXh6h8bxYL5HWAWo5tpp8I6ThMp69xYu6RO53fCWp41ThsYLJs9WnHxVCBPHt+iaWgJfrH8yR1AdZVu1V1SoEmL+EXjjnKTBWFbe4oxTBTtk5anEWbI88sKithGSRtti1x5+qLkZ/WrdRBWzh2hdUAZAfz/1Todr68WJhcJaPbbHaRiHmRVsQAD6YQlwJxgysjdrlTZJ3uXxwoynu9E9XLXRhzt4NLhdr6a1gL14Djw8HCh5KeW5yQ4EGWjNydKjAAqcDGPyY8ZUBrvutet/4NqVtOL5jB2tyD77vduBHn2CMuUsPDGuO7UEkyImmxK2jZGhqMknpzD3mZQJdyzYGWd7Z4gue/aEdeCXFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(366004)(136003)(376002)(66446008)(33656002)(41300700001)(38100700002)(6916009)(91956017)(2616005)(6486002)(2906002)(8676002)(66556008)(26005)(64756008)(4326008)(66946007)(36756003)(66476007)(8936002)(71200400001)(6512007)(76116006)(316002)(186003)(38070700005)(478600001)(6506007)(4744005)(53546011)(54906003)(122000001)(5660300002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2sFE7LW4Bk+v6z0Ae2lUcz9nm/7iBfr45eE8409iz1CdeBc/Ncb+MBCHT08r?=
 =?us-ascii?Q?gMe67fULBNKFztSut2Ev40dgLQtCzAuO7AxGJGi3sVsomSObWzx3TfdyLELn?=
 =?us-ascii?Q?a3x448j7iku9DzVa0tPyL/cPD+D0l4HWFrum2ZHujjcMEMNQn7f7k7bg7b0Q?=
 =?us-ascii?Q?AB/JJzIOdDKEMu4znNfx0DGmDHsvazXVB4GczHeQeA/PcIv7RqurVKdX896M?=
 =?us-ascii?Q?IOi/2czz4R/MqNxS2fbN/M/jANF02Hv3OZcV+ARDctG/aAsLbCylV7HRe0BD?=
 =?us-ascii?Q?aqejcyKkQvcEgAKtGhWiNUyXNIOW/KotquVH7FcLC/p7j/8JCsOThG/SsidL?=
 =?us-ascii?Q?boqYSCT4Qv0YZe9kUX/jTkHJ19abx1frKnS9mKJLXYioU5ZaOCiT40Dq9OGh?=
 =?us-ascii?Q?WGPQiMpEqdp4j3L+R2uT9/VYC4CQ3XTPYBtHfdtykUL5W8ACiIXkS27jf2+k?=
 =?us-ascii?Q?mdSvxhav5BmIHo7dcgST17/3cKrBw3Q7vAbxm6Jf4RLrpASZzJBD8Yvyjco2?=
 =?us-ascii?Q?jW4mjRS3+zqiBmXnmdi5dh9bZaFPHR6ArqCB7UCGLpG9ifD5eVHYOZSK7Mih?=
 =?us-ascii?Q?v2QBcCPFAthn9WKaYnQkpcDrhCQdY1o9ikRoTCwXj8tWEcRN32HZ1SzM0nmg?=
 =?us-ascii?Q?O3jaodYKkyZ9IMQdtmBSjv7xaP2vybc6SrN0MjMfJsHKmxkxqt5U2hvLCvUY?=
 =?us-ascii?Q?ocwj6Fim1hQQKMz9FXeid3S3bMeb8ztgfdhWRbdBesLf2iuB8PH6Vx5+4rF+?=
 =?us-ascii?Q?IAxzBrOmSlTOHghq7b3jZBk1Jpv6UHJIWWL9JzKbXzS+TB4Pc0NXE6ZQFK+j?=
 =?us-ascii?Q?51dAm1BXO2Y6nijwyPGrJ5YhW1PZIqTQuijyUqNBsjQymqb9PnfqK0yWWPBU?=
 =?us-ascii?Q?KbWcXX9FKPh/YEgYn6AEF0GG9InyT54UiZwSROMP0By5oYwX7l+DkTxLg1Qi?=
 =?us-ascii?Q?zWbMyTvIQDV/GmQ1m6s70AX2iCaWl01ZTCr0y+aAWyZROtUWSaSfQ7fWasPj?=
 =?us-ascii?Q?6ki4Kebl8uY+w2GDDbH2SUvNLVxmNjWau5a1SwlxJ76/Jw5Xp3yOa7S+B7t9?=
 =?us-ascii?Q?pK6v0qz9UX3/260R/bM5ay3aUIMqd21DgQSVeZMRyuSl0qQr36zBHue/epsf?=
 =?us-ascii?Q?pbWAk9K6SaRF7ZrhXYchHpwu2H4whFh6OczzCCYETih4MZauZNYFH2gjOBJz?=
 =?us-ascii?Q?tQ4RXeVXmEFcZc+CmCwScyTxHoP7Q1er+TmIKLIiD5CfQQU2YQc4FL0RTlHm?=
 =?us-ascii?Q?CCF8Uauucrf/GaPWZE5ERYV/Ca2mNYlK8NPCzIbRQwm1ElVUgq95RY35KtsB?=
 =?us-ascii?Q?zvL8zoStn0bihTrBtIku84U9dopKnpm+At1EbKvDxWMKwcX3oijGPzlHdCWs?=
 =?us-ascii?Q?sU3Gk40wmJpxq9c612Km6nycMSPyc70H5svGYcKPW65iYjCYAMjchKvh3bf5?=
 =?us-ascii?Q?U/z8FpnZBYA12fO7UVLHMnePhSi4i7jAH0tzoDrNZSOiHS46W3ExhXboAXeb?=
 =?us-ascii?Q?N95a4jjWBZfwqSaJfSPRYWcAiealro6C/JarY/EfttSu/bZi3DxET8dwRYr6?=
 =?us-ascii?Q?/SozphR8kapFMYbLFGWfLhK/X9L2wkK6jTY0fMzs56hgwec3xF2eCIa7dk8b?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8ED0C7034F81E24EB85A68397817C715@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feab7dc-2095-45c6-1207-08da5796a2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 17:09:31.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xFDgp+y5zBX5sXJinVqmSkjDgnQrNepUpqf/6UiTYdhdWUzxKFYxjULxbpWmJS9f9V107AwdFyiRu/wwgZH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-26_05:2022-06-24,2022-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=985
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206260069
X-Proofpoint-ORIG-GUID: 1wMh00A-jx3X-BHnFVGb4vJljZL_UDzz
X-Proofpoint-GUID: 1wMh00A-jx3X-BHnFVGb4vJljZL_UDzz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2022, at 7:01 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Sat, 25 Jun 2022 18:50:30 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> On Jun 25, 2022, at 1:45 PM, Steven Rostedt <rostedt@goodmis.org> wrote=
:
>>>=20
>>> On Sat, 25 Jun 2022 17:15:07 +0000
>>> Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>=20
>>>> [root@manet ~]# cat /etc/redhat-release=20
>>>> Fedora release 35 (Thirty Five)
>>>> [root@manet ~]# trace-cmd version
>>>>=20
>>>> trace-cmd version 2.9.2 (not-a-git-repo)=20
>>>=20
>>> Ug, that's very old. Fedora should be shipping 3.1.1 soon.=20
>>=20
>> Right -- this version doesn't recognize get_sockaddr either.
>>=20
>=20
> That would be libtraceevent that would do that. What version do you
> have installed?

[cel@manet lib]$ cd /usr/lib64/
[cel@manet lib64]$ ls libtrace*
libtracecmd.so.1  libtracecmd.so.1.0.0  libtraceevent.so.1  libtraceevent.s=
o.1.2.1  libtracefs.so.1  libtracefs.so.1.1.1
[cel@manet lib64]$


--
Chuck Lever



