Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98252E00E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbiESWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiESWjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:39:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0782F6A001
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:39:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJxETs029203;
        Thu, 19 May 2022 22:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d9l1rnaplMW1SOHXRnDeS4+T4lQrqVTAIPogas0FBqE=;
 b=z6keRvKWnAID2vHjJcxBZgPrS1G82i66oyBkZNEnJITWgelfOkvHN3m1pQv6h2kWIZXk
 Ai9OK7LIziAiOpisrBWyHeXdsrrRZSqmJwp/zZ5R4Lb6VuqXIHq9xMzwk8z7A7qV71OU
 sCFe1fZ41KBXxMyNv5IoaGH60l3d2ZKou3SvCQS120MzXq3cOuBhG/wbWaUeralew8aO
 rQ0kcksaLQCBelzCYTyHJ0LzqyRewlOd4KYhw0atBVGD1168llTCsNbwUWQExEY58vKf
 cWiNDz5tXoFAA0liYsb6p5G1d6qbh3r35OdMuO9OoU7QT8zu5llrK4Lfr/91d1bKMa+0 bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aan99s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 22:39:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JMQ4sK018831;
        Thu, 19 May 2022 22:39:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vb8r0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 22:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOCLxLPfisvor6GSZAP31TJA1VADbOV1/Vthw1ZwOjmHo3hZ9Erp8k3J6ugVC+to1dCv/CI1R0/H/GLwTJkil32+fEnQDX+xAMeAgtPmFUhH09qjRODGlHFWJC3hAs+3UrJMurHYuTM9JOSYZbKf9QKhr3YLJZTlxJTjV81K46S/Msh1RZEjzpb+HQTTKJUNlDAbsc8h+tE/uzmqCkbcjniwIu8f7Lv1IrC2CxPiRAi3XKlwlhCwDzhAq5Gap0cis+6TIV/7L2AeDxiz5/ncVAcZgs5FVwmJjVTWkA/0b2TgVfRzKF07YDNTUbvidbp7Qk/Xlxfu3f06xqL7494Dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9l1rnaplMW1SOHXRnDeS4+T4lQrqVTAIPogas0FBqE=;
 b=SHwEyhinKVu1Eu8e6CZyKi7IuVGNhEZZDXjNcfHtNK7kCQ7qAG/Bq94fpqLfApCso6oGoM2znqaodaF96gLwVPWMA949p+swE3BNVaYtppGLcdm8TLGtxrJeW0lWl6X7MhzgwH8HMMDxTNNh5StHE/rAV1FLg7o3N0zGEAFExpJSVsuRvNurpmwlQyNWjgLf7BPvzdoCWhy1MmeRNx0oAUOZ9cJvgAid9t3J6LCeV+eLRIlsjmja3qiZEhQqQnltgmFTcgp2bF0xhHHVNh6r1ZoxQz/OE/rkOq61S+Sb476pVVcLcqdXlNAv6FXHyewoI8MiIBLb+UDfOAkRajY7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9l1rnaplMW1SOHXRnDeS4+T4lQrqVTAIPogas0FBqE=;
 b=h/cgl7+feZ+dONuNBbjqGCzI8O59NvmBXPz8xcShHILyLH22zsjYrkYGCZP2aoVsQKqUgfQKCEIZfT3qDRtbmI/Di92fmJz/ipdiX9gwFUx3HqMXOnGpy4I+h6CZ0bUMnx9EdLv/GRlrCAoK28s9NPnu4SgS2wyaA6kwkzkbBY4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1820.namprd10.prod.outlook.com (2603:10b6:3:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 22:38:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 22:38:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAsdgCAAyWOgIAAdxaAgAAP5QA=
Date:   Thu, 19 May 2022 22:38:56 +0000
Message-ID: <20220519223848.wp77de6ohc744hek@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
 <20220519143541.dfzgoubmkboc6kk4@revolver>
 <28f3958f-dd25-cb1a-0a4c-040e7706ffc7@roeck-us.net>
In-Reply-To: <28f3958f-dd25-cb1a-0a4c-040e7706ffc7@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6366d10a-b4a0-4300-87ba-08da39e85c49
x-ms-traffictypediagnostic: DM5PR10MB1820:EE_
x-microsoft-antispam-prvs: <DM5PR10MB18202C852A990669877EB56FFDD09@DM5PR10MB1820.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tvjv2P/iTq3/NUL1KY3gdjsaFNM4v3iaehhLYKJ4qya4g5oy6LUDV2MSB7xNZcyF82MIov+LhpP+5JoF/tDXPYx7+wqgsiEbEdZ7brOAfNElnkv3RkS0y0foZT5uJDtSPI8NQPAZr1jPRKmDCfXa5hJ2bvYspCgygvwQ+WYwqWMUH5ybujY21yLsck+6LDMeIlG7hYiqnSHfMYS7mJpQM/6YMpZGDak/DyUeIEoRL4mNQPh7ZFbQ2qeLVEKTMp2aHyaLm2oea+c7zHg4GJjOITzPWRYKmyZUrx0A7MtPzFPN/hvzaj8QZmsP4Az0LNusvGnhp4OTWeYAt0olCM6UekoPaed3mfMlo5ykgCnI0/RIDMSCMMlMaf0TXZCAav+Umm4HDHFBBcGqm7799I4/gfr44DVQ0vr50mO89BU/RuXdHEPfasmqCRTs1fpNXrB+3uREwIJveHT5pwQJDu8GhtYt0wYzYS3RYiKyJ/SsytlRJKwvqtbNf9q53ZHKMBaaq7wz4KBliX+YfFvRvqT7PMpPoE/yMeVgIyWPmcoDMk3vk6sI8t5wWK+omEBKdK2qncFzmuDqb2fl9npRZIvZlKjCmfCXixEzT7x2xI5YOqzJFvTgfutDEL1nvRNsmy6zawXlllY+iPIlNwoYj9ThI4H0xUhFA3o64miJAPUgAsEdN4Gy6jMhRCFkP69JCsZCG/EAAx2GYg6HB6mh2j6mvTjEoQjLMZDqRSRivT6/zapjArRhR0tHwd6FtFQeJ9RdvQXRe6DHKc2ufSbAugrODd5exUCthf5Uj9tya3OjlazisbWubJVTTgELyAWJPE/rdT2vM2980abAyPZC9zob5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(44832011)(186003)(5660300002)(6506007)(86362001)(91956017)(6486002)(53546011)(8936002)(33716001)(6916009)(508600001)(9686003)(122000001)(54906003)(64756008)(83380400001)(1076003)(66946007)(26005)(966005)(66446008)(76116006)(8676002)(66476007)(4326008)(66556008)(6512007)(71200400001)(2906002)(38100700002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?STDEShks4PxmltHBbBf77V+VfvqNoHmvF0mZ3/fVqQfkyBy9gM0BFiPs9Bem?=
 =?us-ascii?Q?CBSl5xEZpgZ1wd62gZv01ktK1y+MxAoQo4JShUB6yERilvxFO9fkqKnyOlpb?=
 =?us-ascii?Q?m0gcqY2MuDzXsCacPdKCR5SWvvH8RB+CndS9EYOJRZZVZE5hG4LdpjR0XlS/?=
 =?us-ascii?Q?14p+L+NDS+a27zVLbN+ZkaiMgCErfjEEm9f7BoOrRdb+Z3xmhHdv6D8ayLYz?=
 =?us-ascii?Q?HpJvDo0FbsotlBr64cPgnFVUehHdlp20Xln/NOlb5lqiuZD7S0W3oAn+N1wc?=
 =?us-ascii?Q?iyNAwBAXaynHZassCvAG0DuFqhADsYjjMzXUGtvUgXNsZ/0SLMZraUHyU1kD?=
 =?us-ascii?Q?auGa/qpN5LBrS32tTWxE0bkFrFXNWfB4FE+eqLnYmC8RxALidoS2Q+3yavnD?=
 =?us-ascii?Q?0TTM8tcQlac8FMpeShwpH5c3GpprmFRo2MGVGqecB5xlMRDFeleYlsTE8fN2?=
 =?us-ascii?Q?W0TFDfqxFz/7A1CZZeAeQbAw6Hd5L83/aSuN3QUyNjAz+Kw3YnMp8Uwfpz9q?=
 =?us-ascii?Q?/QotbxyP19S3+MV9dR+5qPBzImWu1dR7WBg/h5qKJWbhLE8nbMGm6EG5ugRQ?=
 =?us-ascii?Q?cTqo+rZtMugm3B4iFDy0TaAN9X1LZlAY1s7d5V8WLOw7ZJ7zCfnOxD2WR1ru?=
 =?us-ascii?Q?R3qw4WIhK3LmVOCSUHgpr7+VvqRBtPA1Tnz9tB8Ho1/UExUttt73YzJzKS1+?=
 =?us-ascii?Q?RfaWYxr5FyPvOqD46oSPRPBDIsT/rBl9pakWscPTbFqp4+vMQZJ01nqq/sxR?=
 =?us-ascii?Q?/oUkTPfCYuOPTkuLc/subE+nRvdylNcgTACBfkNx6ewXUOIrwTFFGQ1cAOaa?=
 =?us-ascii?Q?peQnmC01h+IgGglRW/UvWxzzSGmGilUCRiKtTgGRcPF5QP0aef0o0IHVXI0r?=
 =?us-ascii?Q?chKZIasvL6KFT4fS9imQ9FJp92feT4gZlW7sRCRrYsyzYt/uIdLHz7fWhxHU?=
 =?us-ascii?Q?hsK4MCSJdbCJ3eFNcSfl0T/8+UQwxb1Kp2n9ThH0MjrLIaXzG27Ua5jZ8UxB?=
 =?us-ascii?Q?w5GrwfK7O+jsLJdty1ElPBHD50hD+lqgHXoLfos1VCaapSLaAh1XyXIT5xIF?=
 =?us-ascii?Q?kXaBgxX5PqvWifbZ/3lp4EKnZGDTrWWrtJfE3PnA16ElUF4JJNxE5N1C5FLF?=
 =?us-ascii?Q?rTUpBkPOGCw+IjoFcZds31Ggj5pKDHfidZlvB+7e6mQHzY0Ld1sDGGZnmHBa?=
 =?us-ascii?Q?h6wIQOMiIE7zie9ibZMcbOF/jSjgBS9/32dSEE2tsYp5n+0ObVIUqTHZVPRH?=
 =?us-ascii?Q?S9+aXi6gxB35GzrC6LA0DqTZU6M2pQIv2thR38vN26d08XzCl/+RSNOW26xn?=
 =?us-ascii?Q?VOj118HjpW41GXaBboJ3RlGoiZz6Qwv567EW4a82sEpxUXfdqNvqqjE6lt8f?=
 =?us-ascii?Q?zk+bjcQaHXsWSjjXl7c2LXelOFHguwF7OXEZ15V37oNdJ5n1eCHETUjbX1no?=
 =?us-ascii?Q?ak5mo8p/G+cfT8STR4xwx0iMCmqwJ+cIgmdY23vI/icpfMSMFcSZHRCg6x//?=
 =?us-ascii?Q?3K0aFIGKCBSZ7Tn+krR/gUI2pjm1B8ZdjDKG5EX5STCfSopIKGICXNnuK9+T?=
 =?us-ascii?Q?rtFy+HZJY7Tw9UOrBu5FFnbzyLNRMAYXjURNk/OqR+1gyFiRBHaeqxjYAIok?=
 =?us-ascii?Q?SpbYT2/TE2DAEaLbLS1BJZbiYPedqYPo8Zbyv5zEdJAndU1zj4OrInWeq214?=
 =?us-ascii?Q?9ADXnh8AB520moEPsULk90yIcGUXgBl8x8CcYkC7UEYwxQnKSWFSBpe+CxP8?=
 =?us-ascii?Q?LUUaPnighWQTuGb2nfbtcNWH3eFxZxU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C792620C1A7C1049A4096286BAF74918@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6366d10a-b4a0-4300-87ba-08da39e85c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 22:38:56.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynPwAH8+/BWcWVSgFptQKsHNCMHkBMD5DiAhjPzz4R4cHw8fI6GyM0dhlhLcF/iIuxVPRJX8yCw3yTHnjKyjPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1820
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_06:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190121
X-Proofpoint-ORIG-GUID: 3MZLIY12JkoZ8OOetLCyzDVDdcP1mqHI
X-Proofpoint-GUID: 3MZLIY12JkoZ8OOetLCyzDVDdcP1mqHI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220519 17:42]:
> On 5/19/22 07:35, Liam Howlett wrote:
> > * Guenter Roeck <linux@roeck-us.net> [220517 10:32]:
> >=20
> > ...
> > >=20
> > > Another bisect result, boot failures with nommu targets (arm:mps2-an3=
85,
> > > m68k:mcf5208evb). Bisect log is the same for both.
> > ...
> > > # first bad commit: [bd773a78705fb58eeadd80e5b31739df4c83c559] nommu:=
 remove uses of VMA linked list
> >=20
> > I cannot reproduce this on my side, even with that specific commit.  Ca=
n
> > you point me to the failure log, config file, etc?  Do you still see
> > this with the fixes I've sent recently?
> >=20
>=20
> This was in linux-next; most recently with next-20220517.
> I don't know if that was up-to-date with your patches.
> The problem seems to be memory allocation failures.
> A sample log is at
> https://kerneltests.org/builders/qemu-m68k-next/builds/1065/steps/qemubui=
ldcommand/logs/stdio
> The log history at
> https://kerneltests.org/builders/qemu-m68k-next?numbuilds=3D30
> will give you a variety of logs.

I did hunt that down.  It looks like it's allocating 512kb and failing.
I tried the commit you see the failures on and my qemu boots fine.

>=20
> The configuration is derived from m5208evb_defconfig, with initrd
> and command line embedded in the image. You can see the detailed
> configuration updates at
> https://github.com/groeck/linux-build-test/blob/master/rootfs/m68k/run-qe=
mu-m68k.sh
>=20
> Qemu command line is
>=20
> qemu-system-m68k -M mcf5208evb -kernel vmlinux \
>     -cpu m5208 -no-reboot -nographic -monitor none
>     -append "rdinit=3D/sbin/init console=3DttyS0,115200"
>=20
> with initrd from
> https://github.com/groeck/linux-build-test/blob/master/rootfs/m68k/rootfs=
-5208.cpio.gz

I'm using buildroot-2022.02.1, so maybe that's the difference?
Buildroot has the following qemu line:

qemu-system-m68k -M mcf5208evb -cpu m5208 -kernel vmlinux -nographic

>=20
> I use qemu v6.2, but any recent qemu version should work.
>=20
> Hope this helps,
> Guenter

Thanks for the information.  I will keep digging into it.
Liam
