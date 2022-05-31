Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEA4539697
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbiEaS5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiEaS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:57:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0C48E51
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:57:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VHENZB018888;
        Tue, 31 May 2022 18:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7mzVguEdeO03tQ7dCdUZdKIWJFUulVFYqE71nzWViZo=;
 b=dFiKiPAl73+3I8aSeBlQHRyxJQm+zUP1kqb1+w5L+q401TDPlBWvi8dEza2bHenlaSYu
 neGA7YfqAQFZz8LqNeyaszn5zjT2LIVfLcxZv0J29wMOgHBuaA31pXC8vCLgmaotvug4
 aHEiq+v2ATVP/6QDUBtO9HR9OpkF2AWD82NgV7bUWWrKP0wUVKlU0CSSPHLw853E7OVk
 qxuXCH9XJtkdJ2z1o83iaidKeSJ6tIdJxQPX+5O7cpg2gNOu0dtn8yuLWml2pqc1IaAG
 PN9pXvWndVbZSECG9wEtWvMaHpNW4frJ5gQCrkrwR2ZAchaYF00NchHX8D8u0Muieg3N sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xp11f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 18:56:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VIaBaK016494;
        Tue, 31 May 2022 18:56:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hvseq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 18:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMX3FdM8KAgoQ9fqFqgvlbTWM3gOu+tQQfD1Okxi/B21u1H6edrqTpV6ZFyHHXVyRhewsNoam1i57SyA8nXdcycxgp/IGLOzvUoH5kAmEbSi81cCULH6JYmYwlzp5mpTCje1z+6lQGvrMdXx4TcCQKEmI5Yu9wv6rTFVhvD5uRVt5UEzSQi4x2pUHl2GvUzNQZSm58R5ZmVk8K6CRvxM/xzzckDCv7QFIFMv/UANryv9+bR0vSTzg1iAZsrGz6h4iQm9AakvcZ56VDLkC17ergDN843Bz+9VO8SL937/CnCtYtkLHL+EDjK5nifHqEpmrJ9bMKNIPRmI8cpBgZc20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mzVguEdeO03tQ7dCdUZdKIWJFUulVFYqE71nzWViZo=;
 b=nc/fmovYq/pYkysbP6lGYYRs9eW8HK8mcO1WSJVVz45oAileK9PqyQiu+mvGB53lrjqq3tNR3ZzwvTOiQCoW3rIi3orH8mwq2B7QLvJZBY45t5t2ZN8vy8nGEmnjhzOOSHXrj5iGTEdDN+PSzdx8/FMSgimtLYxhAKcIB8WrlIzrk21fXcXoDoCth5AF9+mn6Fr6cq0bFkRJHEj+EyLuhWjmDkoHNRf/Kyrn8nV6qfgnaFAgelwevV7d0dDXDmgpGNg6rjGCHn4U6NpJBx0g71+wOzfaGNt6symRjvUFBQkiWoybpXzMoyHq3RFlY3Yh/KIKDIqMDIKfZcQV4Csanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mzVguEdeO03tQ7dCdUZdKIWJFUulVFYqE71nzWViZo=;
 b=jXhY7n5Q3f4VhqZh7TJNvYRvACFVRrDRyiO5x5/XdOP2mctWcr2VxanokWnAns+Am5QSM8VjO9FWQfkbRyxAHntH3p3QCuwY9Vh9CXfskroyVKzSU2RcAy0IAEfJxF0khaYbq13EBLyDKLxH9U1EsuBhVh13K6cVfmynwB6Fyu0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5621.namprd10.prod.outlook.com (2603:10b6:806:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 18:56:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5293.015; Tue, 31 May 2022
 18:56:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAsdgCAAyWOgIAAdxaAgBEFjQCAAagxAA==
Date:   Tue, 31 May 2022 18:56:34 +0000
Message-ID: <20220531185626.yvlmymbxyoe5vags@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
 <20220519143541.dfzgoubmkboc6kk4@revolver>
 <28f3958f-dd25-cb1a-0a4c-040e7706ffc7@roeck-us.net>
 <20220530173812.ehckwwrb5fk7mjfd@revolver>
In-Reply-To: <20220530173812.ehckwwrb5fk7mjfd@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69e8442e-5327-44b2-c5f5-08da433748ea
x-ms-traffictypediagnostic: SN4PR10MB5621:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5621ED9154B0ADFD80DD9354FDDC9@SN4PR10MB5621.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c/vUJHoAWw+FxuZB5zyleInxCLiy6VjEJFoyqmVkKFb+8BTVVV7y19tu9lBQAqJEMZ76jgPXYDfrUJnGTbyBdt0VkzkT6kNw+MBGGNBFUUsmQpzl1D066f8C5eN8CvyjKjXuKMXLNEyT4S6esoJb9mIu+GGsGuJVH8a85h262HT6HzjyPQbGoHqa70t5taIdWl8TUVVguji5z3OjCnfckZz4vHr2F6T7hLjFOLWsh5TQj+4sJtmUdxiy/bOn6Eo8uYOl5U42hFpRqKenkCtoFg6cAQHV180duMoO8gYKDENjGqL0/KeIsF5f0Jbe+9fzsRGemXaGYJJWgjoex9vKiXJ6AoeOm8DptLi5elWQy+rccFvbqvcEf4Kvz5SzqTMcNfT3Nu+n5A8NJDGBqnp38gzWpTxzsNTDcFYSRkJv5pjdRX988ulppBzyl1dPTOt2XzUCH+b8aTEazZq6OnfZ0LwIyTqVrQ/3UPbZI3Hj6o5bgNQ1w0kPV62hzikCQYncW6nxnESYT+swU6FikKpBmCv+fgB7fB2iCQu/4xKNF26+5vIhfRDF5PHrkpySPgOFMpf1mrTjYoM5hjgRohaSwPksb4jNPexTMopr8CIRfYlA+NXnGww02i+h6LuE348W1Vvy1Mu4Y0PMqfaLzHHjVLWZHKoNCt7I5jpbbWLez9j2TuolgyNHI07J4WaFMuSQOhutTmqtdZ1jrONWxeuWvRdEK0d9I8UNqkXmz3yM8xyRhz4wjdxjsXFC9TjxXKlgTWEwHUPLLqBakrc61OWteYWRpioB3D4nKXjhz9HYr6elltRpw7w7ZykC8AAfwebzHTeGFdUvJJkJNzOVOFpYGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(38070700005)(53546011)(26005)(6512007)(122000001)(83380400001)(2906002)(6506007)(33716001)(1076003)(316002)(110136005)(8936002)(508600001)(38100700002)(6486002)(966005)(44832011)(66446008)(66476007)(8676002)(64756008)(5660300002)(99936003)(86362001)(66556008)(66946007)(91956017)(76116006)(71200400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eNpyYnJlYinIo004bWxZClDCorqNyfbwVWixk5y9P+07wB4feqQRODL5f9l5?=
 =?us-ascii?Q?0mOBsh6ujYKqy9qVaQFppNvFFkZCQCdAVINpUGyCp5pXfBlvDiXC73fc6r4Q?=
 =?us-ascii?Q?v/FFw8tGETDzRGfFtDNMM4E5yppxBLLYOM/G+wF8GZHIUC3VYEGF0gfYCwQl?=
 =?us-ascii?Q?JwR1OOHatZM7C5pbyXbghK9NUo4iKidVs9ZqgP2ifqg2WwqZc1yEnWIA3rkm?=
 =?us-ascii?Q?hzDHYIZtIsfljnakJZ8BD1aWI6xt47cOZYvqkj2ZCJCBLjq6qGjUkP4mbddJ?=
 =?us-ascii?Q?a1iK6ZzpPWJBnJVGk3oyNHACHxx9+REaFE0tap0tq8McharaNLO3yVU7DoKN?=
 =?us-ascii?Q?FFZmJJlctjUF6fV6pv1cY6X/G2Gh3wYGLqcBmkAU1gNA1rR3YrzigiGAj8gu?=
 =?us-ascii?Q?JofCeh3jg7ZpdpryBbk9FzGrfRVOtvEf5/Owbq+M3mNjC48lbRqWxVKiO4eN?=
 =?us-ascii?Q?en45qRDjSb++1kVK/vFBpI+Oe5ior6zdfYBazySyDb57mC+8PSl7CJsdVXZU?=
 =?us-ascii?Q?WJJYmVragKDiabggs67eCCsEsj9sF2rKHr7ZemkcKXiY0vfJZ//RqsOkOljM?=
 =?us-ascii?Q?atx2VyzH8joyAA2wcBk3bzLaLFO3zQaeT32m9PDRysbZ4u/Ek1glfqPKb+V/?=
 =?us-ascii?Q?SdyIxO3Aolk2dTdi3vfKAD4Qk3fehyb056ODffIPmJ1F8s4Xgf+PZ82k8n8R?=
 =?us-ascii?Q?ZRGAuJ68v/uMFN6EOo/Kf8BlDhv0yTUOnO6tYlFWFROXdQrbavVkt+InNe12?=
 =?us-ascii?Q?KcPjQTTRedagfagfr/rKdPnSHTRJWB2Dna9mBOE2JeWjiX8w/lTcRufHciYW?=
 =?us-ascii?Q?ERdJS6HGVi8mZYzTZ1lVMZMLWWiLzHOunR69NCZLciBeSbDh2y27795bKU5F?=
 =?us-ascii?Q?3RxMqnVPFhpT0zPsIT93YUwlEjdo8DZwPAKRMXW3YN9RwYoqa8WRL2vsOeGe?=
 =?us-ascii?Q?JRZAv92TQwoaN0Jc2dT0mtRDnV/9YjAMVmaNxfBMOWmw5f0PMHTPfLOR2KJ8?=
 =?us-ascii?Q?8ONwdt6ZIo59IOXHYP+CiPcFF7Lq6orcL1a97AT3gZB7xRKkxyBn6Jsy9yTv?=
 =?us-ascii?Q?x3xIsDrPggim3E38RlrfzANyCPTDGqf4sDmrnN3rlb/lt8PTjnbrnuj24Ou7?=
 =?us-ascii?Q?iRi2K9g8FjyJgA2Y6FRqfhLSb3zh7wpHNGHk7/Mg6HzkiKM8Mh483JKcSwNv?=
 =?us-ascii?Q?O9EWyM5So4nItlOFBkHOQE5OJTF5EyrHTwO6EjikghKNceEkTUPE2zC5xK5G?=
 =?us-ascii?Q?hVzXMcg2Z9L3JJZCw+SDBwwYdTpp0MLuZF3X0h08qg/dmedqEA07LnmyfK/L?=
 =?us-ascii?Q?S2hFYESpfpHKhrux74paiT2sKqXt8by4r/Yx82b+uuWoKjaSDB3EMf2qz54k?=
 =?us-ascii?Q?2PkP/MPR6VK8njaD3sOrlYhJ0Q/N8SWkbNJvkuZtVamejWeQQXgDp4vvQyP2?=
 =?us-ascii?Q?DpQyLqZ5Mcpw+p2mgWGOstRFOQ/Qbl7AbcSbbCKgplH3GvgQeJFFl4xmy/Az?=
 =?us-ascii?Q?546SkziZ9R+KK6V2vOfCRalSic5/PpeSbQrHWGxvNVeFvzndsZieD9+aFcoG?=
 =?us-ascii?Q?fMo/CDqm0eWZ4AAcfinuHrv155IHTrPoSrErCF+oGy6JZJBAHu337JjTHJ5q?=
 =?us-ascii?Q?BAH2OWZoEWW4psVVKXPa+6tqlMiMDSucMUCIo74QW7yCXcOy3doAVtg2qx+u?=
 =?us-ascii?Q?MWNa16KV5hJxvXXdUmzNCuAN84NQViWZK8csSB7Scb5WzrnujCouEU16JUxE?=
 =?us-ascii?Q?tHDKGHAjws0oJyIdDHaZk0BCVqtS6X0=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220531185626yvlmymbxyoe5vagsrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8442e-5327-44b2-c5f5-08da433748ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 18:56:35.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42J+03Qogcc6LASKmAO+UtLfTRgE8oiqpRdAp3Xo0DzOArMhihhvR0HSY33WD9uqTZV2h+OXWpVTRAG/wNxBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5621
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_07:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310084
X-Proofpoint-GUID: LKvwAZaOBuIEcezWLNs2Z-SBJ0m6yH6Q
X-Proofpoint-ORIG-GUID: LKvwAZaOBuIEcezWLNs2Z-SBJ0m6yH6Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220531185626yvlmymbxyoe5vagsrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <202A5EC1D40CD740AD9615A13BAE8A22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220530 13:38]:
> * Guenter Roeck <linux@roeck-us.net> [220519 17:42]:
> > On 5/19/22 07:35, Liam Howlett wrote:
> > > * Guenter Roeck <linux@roeck-us.net> [220517 10:32]:
> > >=20
> > > ...
> > > >=20
> > > > Another bisect result, boot failures with nommu targets (arm:mps2-a=
n385,
> > > > m68k:mcf5208evb). Bisect log is the same for both.
> > > ...
> > > > # first bad commit: [bd773a78705fb58eeadd80e5b31739df4c83c559] nomm=
u: remove uses of VMA linked list
> > >=20
> > > I cannot reproduce this on my side, even with that specific commit.  =
Can
> > > you point me to the failure log, config file, etc?  Do you still see
> > > this with the fixes I've sent recently?
> > >=20
> >=20
> > This was in linux-next; most recently with next-20220517.
> > I don't know if that was up-to-date with your patches.
> > The problem seems to be memory allocation failures.
> > A sample log is at
> > https://kerneltests.org/builders/qemu-m68k-next/builds/1065/steps/qemub=
uildcommand/logs/stdio
> > The log history at
> > https://kerneltests.org/builders/qemu-m68k-next?numbuilds=3D30
> > will give you a variety of logs.
> >=20
> > The configuration is derived from m5208evb_defconfig, with initrd
> > and command line embedded in the image. You can see the detailed
> > configuration updates at
> > https://github.com/groeck/linux-build-test/blob/master/rootfs/m68k/run-=
qemu-m68k.sh
> >=20
> > Qemu command line is
> >=20
> > qemu-system-m68k -M mcf5208evb -kernel vmlinux \
> >     -cpu m5208 -no-reboot -nographic -monitor none
> >     -append "rdinit=3D/sbin/init console=3DttyS0,115200"
> >=20
> > with initrd from
> > https://github.com/groeck/linux-build-test/blob/master/rootfs/m68k/root=
fs-5208.cpio.gz
> >=20
> > I use qemu v6.2, but any recent qemu version should work.
>=20
> I have qemu 7.0 which seems to change the default memory size from 32MB
> to 128MB. This can be seen on your log here:
>=20
> Memory: 27928K/32768K available (2827K kernel code, 160K rwdata, 432K rod=
ata, 1016K init, 66K bss, 4840K reserved, 0K cma-reserved)
>=20
> With 128MB the kernel boots.  With 64MB it also boots.  32MB fails with
> an OOM. Looking into it more, I see that the OOM is caused by a
> contiguous page allocation of 1MB (order 7 at 8K pages).  This can be
> seen in the log as well:
>=20
> Running sysctl: echo: page allocation failure: order:7, mode:0xcc0(GFP_KE=
RNEL), nodemask=3D(null)
> ...
> nommu: Allocation of length 884736 from process 63 (echo) failed
>=20
> This last log message above comes from the code path that uses
> alloc_pages_exact().
>=20
> I don't see why my 256 byte nodes (order 0 allocations yield 32 nodes)
> would fragment the memory beyond use on boot.  I have checked for some
> sort of massive leak by adding a static node count to the code and have
> only ever hit ~12 nodes.  Consulting the OOM log from the above link
> again:
>=20
> DMA: 0*8kB 1*16kB (U) 9*32kB (U) 7*64kB (U) 21*128kB (U) 7*256kB (U) 6*51=
2kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 8304kB
>=20
> So to get to the point of breaking up a 1MB block, we'd need an obscene
> number of nodes.
>=20
> Furthermore, the OOM on boot is not always happening.  When boot
> succeeds without an oom,  I checked slabinfo and see that the maple_node
> has 32 active objects which is 1 order 0 allocation. The boot does
> mostly cause an OOM.  It is worth noting that the slabinfo count is lazy
> on counting the number of active objects so it is most likely lower than
> this value in reality.
>=20
> Does anyone have any idea why nommu would be getting this fragmented?

Answer: Why, yes.  Matthew does.  Using alloc_pages_exact() means we
allocate the huge chunk of memory then free the leftovers immediately.
Those freed leftover pages are handed out on the next request - which
happens to be the maple tree.

It seems nommu is so close to OOMing already that this makes a
difference.  Attached is a patch which _almost_ solves the issue by
making it less likely to use those pages, but it's still a matter of
timing on if this will OOM anyways.  It reduces the potential by a large
margin, maybe 1/10 fail instead of 4/5 failing.  This patch is probably
worth taking on its own as it reduces memory fragmentation on
short-lived allocations that use alloc_pages_exact().

I changed the nommu code a bit to reduce memory usage as well.  During a
split even, I no longer delete then re-add the VMA and I only
preallocate a single time for the two writes associated with a split. I
also moved my pre-allocation ahead of the call path that does
alloc_pages_exact().  This all but ensures we won't fragment the larger
chunks of memory as we get enough nodes out of a single page to run at
least through boot.  However, the failure rate remained at 1/10 with
this change.

I had accepted the scenario that this all just worked before, but my
setup is different than that of Guenter.  I am using buildroot-2022.02.1
and qemu 7.0 for my testing.  My configuration OOMs 12/13 times without
maple tree, so I think we actually lowered the memory pressure on boot
with these changes.  Obviously there is a element of timing that causes
variation in the testing so exact numbers are not possible.

Thanks,
Liam


--_002_20220531185626yvlmymbxyoe5vagsrevolver_
Content-Type: text/x-diff;
	name="0001-mm-page_alloc-Reduce-potential-fragmentation-in-make.patch"
Content-Description: 
 0001-mm-page_alloc-Reduce-potential-fragmentation-in-make.patch
Content-Disposition: attachment;
	filename="0001-mm-page_alloc-Reduce-potential-fragmentation-in-make.patch";
	size=1664; creation-date="Tue, 31 May 2022 18:56:33 GMT";
	modification-date="Tue, 31 May 2022 18:56:33 GMT"
Content-ID: <7014C8FF6E4E8D4180976D6776E07948@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBhYmVmNmQyNjRkMjQxM2E2MjU2NzBiZGI4NzMxMzM1NzZkNWNjZTVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBPcmFj
bGUuY29tPg0KRGF0ZTogVHVlLCAzMSBNYXkgMjAyMiAwOToyMDo1MSAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtbS9wYWdlX2FsbG9jOiAgUmVkdWNlIHBvdGVudGlhbCBmcmFnbWVudGF0aW9uIGlu
DQogbWFrZV9hbGxvY19leGFjdCgpDQoNClRyeSB0byBhdm9pZCB1c2luZyB0aGUgbGVmdCBvdmVy
IHNwbGl0IHBhZ2Ugb24gdGhlIG5leHQgcmVxdWVzdCBmb3IgYQ0KcGFnZSBieSBjYWxsaW5nIF9f
ZnJlZV9wYWdlc19vaygpIHdpdGggRlBJX1RPX1RBSUwuICBUaGlzIGluY3JlYXNlcyB0aGUNCnBv
dGVudGlhbCBvZiBkZWZyYWdtZW50aW5nIG1lbW9yeSB3aGVuIGl0J3MgdXNlZCBmb3IgYSBzaG9y
dCBwZXJpb2Qgb2YNCnRpbWUuDQoNClN1Z2dlc3RlZC1ieTogTWF0dGhldyBXaWxjb3ggKE9yYWNs
ZSkgPHdpbGx5QGluZnJhZGVhZC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBMaWFtIFIuIEhvd2xldHQg
PExpYW0uSG93bGV0dEBvcmFjbGUuY29tPg0KLS0tDQogbW0vcGFnZV9hbGxvYy5jIHwgMjAgKysr
KysrKysrKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxs
b2MuYw0KaW5kZXggZjAxYzcxZTQxYmNmLi44YjZkNmNhZGE2ODQgMTAwNjQ0DQotLS0gYS9tbS9w
YWdlX2FsbG9jLmMNCisrKyBiL21tL3BhZ2VfYWxsb2MuYw0KQEAgLTU1ODAsMTQgKzU1ODAsMTgg
QEAgc3RhdGljIHZvaWQgKm1ha2VfYWxsb2NfZXhhY3QodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNp
Z25lZCBpbnQgb3JkZXIsDQogCQlzaXplX3Qgc2l6ZSkNCiB7DQogCWlmIChhZGRyKSB7DQotCQl1
bnNpZ25lZCBsb25nIGFsbG9jX2VuZCA9IGFkZHIgKyAoUEFHRV9TSVpFIDw8IG9yZGVyKTsNCi0J
CXVuc2lnbmVkIGxvbmcgdXNlZCA9IGFkZHIgKyBQQUdFX0FMSUdOKHNpemUpOw0KLQ0KLQkJc3Bs
aXRfcGFnZSh2aXJ0X3RvX3BhZ2UoKHZvaWQgKilhZGRyKSwgb3JkZXIpOw0KLQkJd2hpbGUgKHVz
ZWQgPCBhbGxvY19lbmQpIHsNCi0JCQlmcmVlX3BhZ2UodXNlZCk7DQotCQkJdXNlZCArPSBQQUdF
X1NJWkU7DQotCQl9DQorCQl1bnNpZ25lZCBsb25nIG5yID0gRElWX1JPVU5EX1VQKHNpemUsIFBB
R0VfU0laRSk7DQorCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZSgodm9pZCAqKWFk
ZHIpOw0KKwkJc3RydWN0IHBhZ2UgKmxhc3QgPSBwYWdlICsgbnI7DQorDQorCQlzcGxpdF9wYWdl
X293bmVyKHBhZ2UsIDEgPDwgb3JkZXIpOw0KKwkJc3BsaXRfcGFnZV9tZW1jZyhwYWdlLCAxIDw8
IG9yZGVyKTsNCisJCXdoaWxlIChwYWdlIDwgLS1sYXN0KQ0KKwkJCXNldF9wYWdlX3JlZmNvdW50
ZWQobGFzdCk7DQorDQorCQlsYXN0ID0gcGFnZSArICgxVUwgPDwgb3JkZXIpOw0KKwkJZm9yIChw
YWdlICs9IG5yOyBwYWdlIDwgbGFzdDsgcGFnZSsrKQ0KKwkJCV9fZnJlZV9wYWdlc19vayhwYWdl
LCAwLCBGUElfVE9fVEFJTCk7DQogCX0NCiAJcmV0dXJuICh2b2lkICopYWRkcjsNCiB9DQotLSAN
CjIuMzUuMQ0KDQo=

--_002_20220531185626yvlmymbxyoe5vagsrevolver_--
