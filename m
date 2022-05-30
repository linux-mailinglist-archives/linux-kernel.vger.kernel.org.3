Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7631C5386DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiE3RjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiE3Riz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:38:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4D813CB
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 10:38:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UFLFDL026576;
        Mon, 30 May 2022 17:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SNpmgPGHHkK8lsAj2dXCZMfUA/lCCywdu+DE/OfkGBI=;
 b=qlDrhfkUoC4FA7sYfVyVK6FO+LB3Plq74nLskgxEGf8PTwoU1w5I/EWeolXnpjsILoVH
 8auVu8CSRuk8vKAcZxE696VG33puG+T3VuzAOfX1Ou7EYla9oUY1p4qOA2tlBSObQyCc
 a//iOaOY7IOJ+MHHJbwaO76sz2k661OfJPWteIuWDS2FkkmtQjmlvBOjqHaoGS5OXm8Z
 ljzKMp90qFaFUoCOLY0fkZauJpoPl+6+z6Ed5LVL9nsE3IPBlWonG0pENPmW90IKzNxA
 tpqQ4FaVGXP2dpzJ/3UBVLYFlMG4E47SSbIvmzwJLbOpN5jXPk8npZgYYzzm/ksBeRn2 Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm367b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 17:38:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24UHVxXl016345;
        Mon, 30 May 2022 17:38:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hqw40f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 17:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvPXDI2dAiDX62CuLobEfoDVgUHFPZFAE58otAKZbwec9qaS4qYYckqQt1RTbmw/Ee8eVprBvPiitlO3HOSKkLGwCQarip4JX7XXWyFrM4Q5QMQZfRAydGK5g6jOWQh5UQ2n3h0H/MXP4FATqoNZNjpn5o1g+iAxF+m1fvj1BIjjEQB3v1GGnXYGja9qYSqc1zx1LnvKUBSR6/PiKaH93MNzJRcNceUuy7m1kXg++yDMtdQGYVFA2CiU5MBy4RzoGEQTZbWDiWty1qphXaeg2xBbEeTHpxXZleM/eCJ9yhEMujaaJCN81tfQU3QIPrRr/C/lxCz0BjQnpFS0l7N9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNpmgPGHHkK8lsAj2dXCZMfUA/lCCywdu+DE/OfkGBI=;
 b=gfeK9YTixmRvjw3NdpexDsWMBNXKyzwAjPyKG8lN6x/8JKd9gNUqaMQOx3CAOGDuKyFKWSHVberGtWyBZ/90xebwz6tJ2ihK1x2MCfj/oW2a0trihmW1ZNCgZkQ0UGY92ocyO82+uE43Cg9mhDWinLp0mnYTQraaEACfLrn0MUd/Vjcz0jIrFWMbabpSiy61IUv2M5yHxMbiYwFkH5rAaM8ekxiiTvugYW7npWxOfhyjY0iYaqq472+8aIQbKurhsnW2gAEV4DGHZzWQcVQ3OmVEnAfE+taRhq7p3fFVEdWhZIQPBxZ8Ketwk2FtJWKnkI237dIQ3AbDAJGQOSbTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNpmgPGHHkK8lsAj2dXCZMfUA/lCCywdu+DE/OfkGBI=;
 b=Dljq2riog/YUOQ3/Tr7Q88BfDevEQWFFNLMg5d48c2Hwjiyqs9DYpPFQlSs5TTG23VSSFHaKGVqlo4sEyg9HGT6I7uxuopIez6Y5KMpqE78w1R5vG4mUzvPJZgl0+ev89rCf+6Zb0xKuSlutRYMCbxtdVd18wX740v75usK0Fio=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Mon, 30 May
 2022 17:38:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5293.015; Mon, 30 May 2022
 17:38:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAsdgCAAyWOgIAAdxaAgBEFjQA=
Date:   Mon, 30 May 2022 17:38:34 +0000
Message-ID: <20220530173812.ehckwwrb5fk7mjfd@revolver>
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
x-ms-office365-filtering-correlation-id: f449519e-ff94-46dd-c2ee-08da426338cb
x-ms-traffictypediagnostic: CY5PR10MB5913:EE_
x-microsoft-antispam-prvs: <CY5PR10MB5913E78CB00B85A5DCF2F85DFDDD9@CY5PR10MB5913.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Jzl0uQbZyRVAaiXUeFgLQi/qQDkXYGeL9AxrBc+bZi8H+F7k05lsG2rnWJrU3P98UTEuBsiqct7RccG9VqK4+kVVBMp+3u+FTXUsunU8d4/Qpj1a1gImaoTSbXI/RtIrlOlF1Ql3ZeUD/chakugKi1PhAmSRfOJP8hUOGScgqd3kqpn5M/GjfCjFq00VOgby6hfu4zTMbPyoIEV7dQCfaLTMe3HjD1mTIPH0E4FpSmf/VxAluioal4fSC04NPJBB+KDGbEX8HkrXugqz9j/qA3TvwV9zQlZLAMEhmxIsjRQA2pylt14sYNn59Hm2reBAYcIHFjSNNm4yI8/xlBp8uVArLncSAX6sJsiLpglAkTC2UgS9ykpr2PGf4R+96WEpPRQr2UmGt7eRw2evhyuqwiiG3MO/MKuRvBDd0Ka1Jyc6NMSuN/v3ofpIm0CXYPSU8M9aeL3FaJW04zQ0yhXyLU80LI2Nqr7EL1xoMW/JeVa5FJhQb/BPnoBZxgtA5uYTkbDtwugdD2aVN0OOZCcksnmjPhGDdVCH87viOy2KXIGyytl5fZHTIcBQeIJ3H8Mi3mEaEM+U1sDmwXwk/3u+ztsXUsX1eWqJiM17zSwFzqYPOWbAns5jIo1ko+vH/p4BL2lmkyp2YPGKe0Rp1lGIxjgWAMdcbzVJJaJcP0Az53nNWG1s9B2vPgc/bZnUKaNC4I9BNL3W9S84pi6MsJzCWY058GTnsHK1N66OdIrvAZbbSCAteupjWQ9pKMrA4ubOonaMPJoEc9OChe0d2z0027L1lcWuV1GVSSaecyuy09+WlKXskMHbMZNqimFUoK+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(316002)(122000001)(6916009)(54906003)(86362001)(83380400001)(8676002)(66446008)(4326008)(64756008)(66476007)(6486002)(966005)(38070700005)(186003)(66946007)(76116006)(91956017)(508600001)(66556008)(2906002)(71200400001)(33716001)(44832011)(38100700002)(6506007)(5660300002)(6512007)(26005)(9686003)(53546011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iMJIMQZAD2gop+4ZJXl/yXtkZgD0RThLuPUqY2MUSBkHlasOmolMewjGld5b?=
 =?us-ascii?Q?Kx69ajkqP1YN56Q7sS0dxYBWufdJJDj4xu50JlaKUUm3+E0NDyIEpZdjxcOd?=
 =?us-ascii?Q?ZtYTGeVyegd+Jf+KCyrEX9iNaadrX10TgJvLuQVKFHx2ZLXOO0tse3BRPpk1?=
 =?us-ascii?Q?ysOE4ZjerHNXckModR/TThjdPN7mIgo8hmSm1UQgXzE7JYaUYgfxygXVnwlY?=
 =?us-ascii?Q?WkD939JVwYJ9SVBQ5/+KlCbl8JUqJ4wjUjwc5KWW2CWn7DAhge6dRYF0Fpc8?=
 =?us-ascii?Q?kPW8WPVZ9Ua4I3IkBgA3DfUawXQApAXB6XEXVb5395aQkxDvuifeLZx5E16r?=
 =?us-ascii?Q?1zNC7XxnqqImQ6EPBDkOKFFkbf0qRIlvzR/Kr/7CTFifEA95XRtthouJayYV?=
 =?us-ascii?Q?1OJgC+tg++ASwnkh5Sv0R23sZSHBWrzJ337eSIxI8vYzdf1yG5v3x0NYjuno?=
 =?us-ascii?Q?Hs0oac6NlCK4U8lmd8Z2hz/5qyOAzTWF36nEagVAEP5HNkyLA1eMF0miZv9L?=
 =?us-ascii?Q?R6bj4juh3TmAdI3ch2M97pBlyuwQVC6Lqd5PCVFNwY9BwWsam0EhludMsRfy?=
 =?us-ascii?Q?71H6LMAnjcVSKYu1wG2MJl1T8ni4yzlXOL8paVcWd+1Z6LcOqiMPcto4gJGc?=
 =?us-ascii?Q?aSXBKzGe9uQAfOUCODod7PoqAOAcI0ROor2HgjN6x6p6ftG6X4xcGWNlnCWP?=
 =?us-ascii?Q?y8zyfTplS02oAmdFpTFhZPJpAwLdmNk0xzN38Yvr2Z/XOtGx96viUobnNOeO?=
 =?us-ascii?Q?nsAJ886jUI5tAzXqiihcJPuupL0EWE5MS1Aaw470G2m6QIj+mxpY04lcR93i?=
 =?us-ascii?Q?kPEtOxfD+oBZmnUHIqyzHXEnYAHawbizPq6rkIIz6w6VYETkvKmt7aVqvDEI?=
 =?us-ascii?Q?xyjzCitZ86z6edCcj5t9KXUPsV3wztwbq0K6JUf2KsYcAMEOukNVBcDTEv7T?=
 =?us-ascii?Q?xevloiyDHlSyj9Snk9vE0e3hhvaVTmyYpWp3dof5hK5Cor0QwO3XH97Oka1C?=
 =?us-ascii?Q?y/XJz3KJt9J8EaiPHOfrD6e/Mh4P9++FBiThA8HjL36jixwzhTmD0sbgdQoa?=
 =?us-ascii?Q?ZJpBqcvtcSQwzxyb/DEHi0dKvcQ/85ODmjKS5rTT+LgEGOznqk86H0D1XGm/?=
 =?us-ascii?Q?wnxQV2OV1u1DiM608in0U6ibpSVhIazyoKsVepuztSLq8Hl4Op1JbjFBWvMC?=
 =?us-ascii?Q?9iHRNXSufupkoLjSiT+8zd8rt8WACV6FllZ72gcgmHWWRnQv4LekYRuZ8ptn?=
 =?us-ascii?Q?P9ic2HiIsYQD5BEbW5PLnhA2LqxCKmWk+dhjnjksUxzjmAdoeh9WXIpwMlPT?=
 =?us-ascii?Q?7odqnjMIucc8mgjNHw/0I0ou8jGSOrBJpMAGcw1A/xSCOfxaN0ZX+ImhAdAB?=
 =?us-ascii?Q?/cL010hDRM+y/de6pr3pdILX92F5NlolpsEC5BSivjldQEiqVBQsqKa6DCsa?=
 =?us-ascii?Q?edu4OAOcnUd5yF89vWLOD99orNKFKgSI1FKyFb8h4Q2OlZ7cUwaIJSLJOPFf?=
 =?us-ascii?Q?CEssqGMsDkQ/vXgwGOZ679AoIsAqECYzhhfqjICJ/2V4F7ZV6kUk/5ngpkct?=
 =?us-ascii?Q?sFNHalg6m7RdCyHPdtOfqNTu+S/RNBQJTezTus1XJvbD1RS4iUdJ61rELUfX?=
 =?us-ascii?Q?CLlGEW/v2VpFnm/4ybObDKOXhaHvUKo1R432fJF+yG2eyR2iBQlYIzroBhuH?=
 =?us-ascii?Q?T/MyZDqLMxQtLRfHRKqWwouhQM1QKBTONdtGwX5OC5jiUyThWF+DTZXVAk/N?=
 =?us-ascii?Q?diIDM3m1nU8/Kn5o0pLaJVrrzLRl8eY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0858731AC5F4384EBE9D217A07F713ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f449519e-ff94-46dd-c2ee-08da426338cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 17:38:34.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owj0OFfhLfi5Cx1YcnYhs6owiOXHdxytbqfgSK0r93jEjPc6JK5OCwzravywP8uB632VkTnTk44PGZ6tlTXJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-30_07:2022-05-30,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300092
X-Proofpoint-GUID: nyRfwTE1ECT7A5lV0FihgfWZol1juEN6
X-Proofpoint-ORIG-GUID: nyRfwTE1ECT7A5lV0FihgfWZol1juEN6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
>=20
> I use qemu v6.2, but any recent qemu version should work.

I have qemu 7.0 which seems to change the default memory size from 32MB
to 128MB. This can be seen on your log here:

Memory: 27928K/32768K available (2827K kernel code, 160K rwdata, 432K rodat=
a, 1016K init, 66K bss, 4840K reserved, 0K cma-reserved)

With 128MB the kernel boots.  With 64MB it also boots.  32MB fails with
an OOM. Looking into it more, I see that the OOM is caused by a
contiguous page allocation of 1MB (order 7 at 8K pages).  This can be
seen in the log as well:

Running sysctl: echo: page allocation failure: order:7, mode:0xcc0(GFP_KERN=
EL), nodemask=3D(null)
...
nommu: Allocation of length 884736 from process 63 (echo) failed

This last log message above comes from the code path that uses
alloc_pages_exact().

I don't see why my 256 byte nodes (order 0 allocations yield 32 nodes)
would fragment the memory beyond use on boot.  I have checked for some
sort of massive leak by adding a static node count to the code and have
only ever hit ~12 nodes.  Consulting the OOM log from the above link
again:

DMA: 0*8kB 1*16kB (U) 9*32kB (U) 7*64kB (U) 21*128kB (U) 7*256kB (U) 6*512k=
B (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 8304kB

So to get to the point of breaking up a 1MB block, we'd need an obscene
number of nodes.

Furthermore, the OOM on boot is not always happening.  When boot
succeeds without an oom,  I checked slabinfo and see that the maple_node
has 32 active objects which is 1 order 0 allocation. The boot does
mostly cause an OOM.  It is worth noting that the slabinfo count is lazy
on counting the number of active objects so it is most likely lower than
this value in reality.

Does anyone have any idea why nommu would be getting this fragmented?

Thanks,
Liam=
