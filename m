Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013C51AD48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377351AbiEDSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377340AbiEDSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:52:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0359186EB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:48:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244HhSWw026258;
        Wed, 4 May 2022 18:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m9rwKxqP1ONGdO9g7F1rz5Rv0ubxo7oLf4mfjIL9cXA=;
 b=boalj2ZSOw7C53mZ/ry9rnsjYUMavXL5Ed5zjA0Lk8KbLRExACdBqBYcN4ENOphC3siD
 pGBAreW0gEOOirvBpSASm5sP4zJ91kVqHwtqQFP7n8YthGjafX6y3yt2+87uLIEbX52p
 ukr610wUfBf60lNVLc4yzX0ut/y1VqnMkkPWnbKKocVRkxvoPg+MiZURYNvuquY9gZYZ
 80YaBrbucWpyNNc0ztic5LUpnsS4in9eHExBFalvRKnYtrWJC/OcBaNLnFJro6p3Vtb4
 za9hE1gRr0G5zgCfpIkUa/2SqCS+Sx8L9fq6MlQha3Miabnhs8JJIMC40iD1/NvbFhpp vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc96xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 18:47:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244IkVVT028714;
        Wed, 4 May 2022 18:47:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus8x2g7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 18:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjXwTmW07al44UTDPaSZjtiFXPw/3ODt/4QITzsRetjTfQcVL5tGXHz+Q0LvehXP4IGtLRjooVy9DWSsUWiSIWtLxlSSOTXZxSaa8iClnPk4DeKl6Cv7Zl7x77dgVhb/HQjhth6rZjBOQziFjmJH1gbslBVXWjTTVDhq31Wb9ZXp21n8PVRstroIxc6UXfwuz9Yp8DZ3HXDdBj6GRxPR6Y684LcG7WlAfKQeezHn1IeucTcQh9tVrcVTjKz23dGtBnX5nqR1TIRXwR91fJBZRTV9kwE8jqMPJphfJ7uax4+2Vo1N/Qngz9j20MRun83ENQTjeMZDyYO5Nv2rK8HkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9rwKxqP1ONGdO9g7F1rz5Rv0ubxo7oLf4mfjIL9cXA=;
 b=ZoIb+5VWNMn3k3rPTVb79AWY/ssHjlD04bRppZyEuwgbUkRYx9d3lrK/SuNyvJtKkOhgaOyQQVnF9Z9y9UPdM86oQkPy3/pCZrxBd4pOZKDpHVeOHDIrxZ2j/nkIfxYYl/Ug9fBBoS5rZAQDKCRKgonDoA0UZhtA0gLaHS21YT8W2UqtGIan3QIjxOHpos6kKJp9GSsGB2XZ5tWgI/7Dm7wBXo6zU9dsHUrJGoU0gdMClSUMPiM4ARSpvolx4IJbZpMDRv2W8LMQXvL3pX4/6KGFXB8XF6RkOOC9oEwETPnLS269gtycR9X+8diQMjeCOnQcW7F7hx/RKRzbcbjWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9rwKxqP1ONGdO9g7F1rz5Rv0ubxo7oLf4mfjIL9cXA=;
 b=J0lCrSB9FTyxnD6fbaCCuMIftgXiiZxGjkYI4+xRJGpWoYKDAy1YinR0Vi7YRJQlaZjFyQ9pM1rHfmzGx9CFeBiuA+rjowobQyCOQAeBqKi+e+Oet/pBKh6DhxO4IbnvocsoRgVZOmc3rz5AOqs4uDFd/Tj7r8IaMz/JfVI8qB4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Wed, 4 May
 2022 18:47:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 18:47:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Topic: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYWX84+45146fpu0iPsmgBhR+6Va0Fx52AgABIVoCAAAqGgIAEpZEAgAAC3ACAAKX0AIAANdQAgABZMgCAAaLGgIAAI1IAgACiwgCAALaWAIAABJUA
Date:   Wed, 4 May 2022 18:47:54 +0000
Message-ID: <20220504184746.sr7lzv44oflkf3cf@revolver>
References: <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
 <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
 <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
 <20220503215520.qpaukvjq55o7qwu3@revolver>
 <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
 <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com>
In-Reply-To: <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67c1a90c-165d-4813-d0d3-08da2dfe9941
x-ms-traffictypediagnostic: MN2PR10MB4288:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4288596CB911373DBFDF474DFDC39@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IKbqPv/h3Rzl8FavlFsy/goIcOrtf5zumtb4FWSdrb2vYUzgyREtepGAGItjHCpi6u6Jw7/6V89E93qVVEWkvgm75seicH0w+w25LN1lj5fYcAdazdwQhh0hQGB7B/c+5k8KvIB+E7UUOcooPfxwYuh4lEAMqUgimxdF3MHB0CWJXZbh2J3Aex0nH5I8Ya92t0WEu0unbIoexS/sVg90iGAYlSiwmGBhy5fCO0R1onJiHzao7zZS3nRMFDXYqDY+WWIgSf8p9zieQIAVcQ90QS88I+1jEBV8okOmzldajtLL0VGtm51BxTAqzAkRm34t9sgVlFUQCPEfiQsBO4Wwd3L5vAJipmMUPQwu+GIJFM654grmeR1XqGD1kk3yC6jBm/N2oIdQSGmlzcU/5oM2x4HHrG7B07nukdztw7clxIN3Vrd+KKIvKsFey+ddGXPzcA3mGyYpJ6M7lGEP9yDdRWt9SQqyYiYqrdn+ioIGGTzTUbnzwod7rkC5qRDKxhCOgD+QeQR4XKB+jDpz5+GT6ZYeMNq5EMM3t4n8CXgdCcROCOgl5G4D0+71HbAwAY6y7U1PSsSUT9ZIJubSI+kBBFrrvkcU/uM6pKlLnOvFgDMi73Y5Uf8hXpwC1QZwD1hGT7892NPpJKTkQMD+sTMq3T60+H2GOFEG2FnJ68MfBkTJxwwkoa4oX4hUObZ1x+TC+YNNfzaAE1UnQ71VKDYcjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(7416002)(66476007)(33716001)(64756008)(8676002)(5660300002)(4326008)(66556008)(66946007)(6506007)(54906003)(186003)(66446008)(6916009)(1076003)(316002)(83380400001)(38100700002)(508600001)(8936002)(38070700005)(6512007)(86362001)(26005)(122000001)(9686003)(76116006)(44832011)(2906002)(53546011)(71200400001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3GFSwMiekrBnYg5uvhM4DWUiTEVS60pWOuqEDxh3/WLwy685hofGGTIN50+?=
 =?us-ascii?Q?bLdjMRxPy1qp05T4fFX6eDtwjh7omh/s5qX72punW2qzudYI7lsr/Bs6h3XG?=
 =?us-ascii?Q?gJwhilTIkDTcUmy3JvEdxBjMDvIyKID2x8RP7uKWnzBx10TZuhqI4uLDAkKg?=
 =?us-ascii?Q?3k1KZtFkqcTJsXyTjx9feljIFV/lL049cPFLoWkCBz8pC9J3V2iMdDhojQo9?=
 =?us-ascii?Q?Hj2vglokeVw+qGyO7mboCgYP/b8anhdnXDNJyfVCaQzIquE9w2Ox+ifftDvR?=
 =?us-ascii?Q?AvOVts9pl0J9PzgCfoIqlYzwttGGBALIiE2+tz/F2R22NYaOlBhsJ2UXAPWT?=
 =?us-ascii?Q?ElGAlJAr8z5f3QlN2uvf7Dx4YQkK4ZUS+XQpjwy3mg6AuyHyaQfqe7hXVUhK?=
 =?us-ascii?Q?UUQlbIYS9WTzwklJmfekvKKOSpQw54grqhmpPWI+0qwwUF5raZcH4pTi14su?=
 =?us-ascii?Q?6T4Sp4ICL7pqSbYwUUze2DLkiEG+V/+nSDafm4oIrZxCeHJw3SFq3eMEzUCo?=
 =?us-ascii?Q?WcMUtDb20CpLMV98wyLaI2R94OfwdXiWa45VqiRAAZXwulXyvig21csKU5h/?=
 =?us-ascii?Q?SVpv/kAGRS9HZepZ6U/uUENbTXnJ3wslPHzHcTRZ6gffp3HKnQuP9CuqfINl?=
 =?us-ascii?Q?4ycWZy+NTOZJoJDX9WwzTK1hohpXxEBXM1tw5ZyX+CTcvddx6NytStV1J0Ye?=
 =?us-ascii?Q?XUxNBz+3s78zNbU3CVc6rShqKqB+2ogAg10fXsRRP7mnTaNe6lcivNn8DyaT?=
 =?us-ascii?Q?5DcBJPrCQOYlkChWRMszciI/cRHGjRW3nb8/06rxWH7L5JW5JaXRXjqey0vM?=
 =?us-ascii?Q?RwcI4+NtIyCixLeckcAVAo1fjHrcOO0OiWjiH/skuFTcsinW4ljsK+PWvWLl?=
 =?us-ascii?Q?6si6oyJoqZ90RM8iWBQ23BGQpykePueoK0cpogc9sAXIn6Tv+V8J3QSddbQ8?=
 =?us-ascii?Q?Fckk/Ze/dz6rEOxyv2d5imc4VuHeRqxBWxJ/WgH+Bky0lttfYTP+QCrwdI7M?=
 =?us-ascii?Q?snHWnnmL728N0/Gc1BDZ5BS0i47qmsx0BpkMAaJtgQaNK6trfIi3JM7iGydb?=
 =?us-ascii?Q?FoYntQGxJRAKdzrGC/lguAt616FTm4WuVZ2zNidgeqgtKvtRWcfa0bKEc+Nw?=
 =?us-ascii?Q?Ejpp+jDlf2pDAzC2qJ9h7gSTZWLCs9KAJReHzYHlKoUjxMvmjulQ7W6wCR2p?=
 =?us-ascii?Q?atm1y7ukyxIV42Pqy/uf9TrNrD731WI6oM/DDYxFflI4IBdIjoPWxaULt0NG?=
 =?us-ascii?Q?Ccb72GqqZPEAqVFqWN4MpprwbEV3aDwdfSWkoUgMSbVv4aCsiQzozoGvY9If?=
 =?us-ascii?Q?oCVgbNqtYqckp8+mcLxNoIbDApTRU39MdLLngYYRLpk5Ab6WmEMA0mFzNOhX?=
 =?us-ascii?Q?JPy3Y5Shg7MrQY3qg7txxf3Y8kRnEetaYKXEVUKy3svvQX/Mt9hw1IOfIJFI?=
 =?us-ascii?Q?AEquYiAFwjpAxES4l6hGqQPcS6BiJoygiEJu+oquV5xh/CKIPk7+gArlTsFK?=
 =?us-ascii?Q?gEXC3ZyiWtQuvj8WaTAm0ORqei0S+XLJyU8o91W1GVliptAqKL5TO8r4Twx8?=
 =?us-ascii?Q?UxhoSg7S8O/GAOv+F3VP9MBzbDaWUp69QWZtxtNvFVUwdZo/POKhFk55+jUN?=
 =?us-ascii?Q?/GVJIBKvCI3pAkrSqRkc/fc4Qh3RpZJGR0oerj09AP2iln3CPw4V3W42HIel?=
 =?us-ascii?Q?BpCUjLYoUl+MtU66glnyladEnAi7b4wpaadfvrfsBNV5d6oEyAmFKitVv9jg?=
 =?us-ascii?Q?ShyNeCNmmD24PY2O8lrj3Vtv51lMuxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B85708E3B3299A47AAF9AD7E6B6D1A8A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c1a90c-165d-4813-d0d3-08da2dfe9941
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 18:47:54.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlBc6Q+3L55FsbCXQDe7p3+T0oY7kfomxtXtggt21BpPe1q1H4GFkOjbJ2Eh5uNvZ8rzqHsGg0T6d2Slj5Kb8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_05:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040110
X-Proofpoint-GUID: E3hkN3HI5SN8bJZLm-j-JLMsrlKlY5i2
X-Proofpoint-ORIG-GUID: E3hkN3HI5SN8bJZLm-j-JLMsrlKlY5i2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220504 11:31]:
> On 04.05.22 09:37, Janosch Frank wrote:
> > On 5/3/22 23:55, Liam Howlett wrote:
> >> * Heiko Carstens <hca@linux.ibm.com> [220503 15:49]:
> >>> On Mon, May 02, 2022 at 08:50:04PM +0200, Heiko Carstens wrote:
> >>>> On Mon, May 02, 2022 at 01:31:00PM +0000, Liam Howlett wrote:
> >>>>> * Heiko Carstens <hca@linux.ibm.com> [220502 06:18]:
> >>>>>> On Sun, May 01, 2022 at 05:24:12PM -0700, Andrew Morton wrote:
> >>>>>>> (cc S390 maintainers)
> >>>>>>> (cc stable & Greg)
> >>> ...
> >>>>>>>> booting.  The last thing I see is:
> >>>>>>>>
> >>>>>>>> "[    4.668916] Spectre V2 mitigation: execute trampolines"
> >>>>>>>>
> >>>>>>>> I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
> >>>>>>>> build_zonerefs_node())
> >>>>>>>>
> >>>>>>>> With the this commit, I am unable to boot one out of three times=
.  When
> >>>>>>>> using the previous commit I was not able to get it to hang after=
 trying
> >>>>>>>> 10+ times.  This is a qemu s390 install with KASAN on and I see =
no error
> >>>>>>>> messages.  I think it's likely it is this patch, but no guarante=
ed.
> >>> ...
> >>>>>> Liam, could you share your kernel config?
> >>>>>
> >>>>> Sure thing.  See attached.
> >>>>
> >>>> So, I can reproduce the hanging system now. However this looks like =
a
> >>>> qemu problem on s390, since I can reproduce this only with Qemu+TCG.
> >>>> Qemu with kvm works without any problems (same if I use z/VM as
> >>>> hypervisor).
> >>>>
> >>>> Janosch, Claudio, can you have a look at this please?
> >>>
> >>> So, at least for me this problem also exists with plain v5.17.
> >>> Switching off KASAN, or alternatively switching to KASAN_INLINE
> >>> "fixes" it for me with Qemu+TCG.
> >>>
> >>> Liam, could you please also try to disable KASAN in your config? With
> >>> that I think we can be almost sure this could be some bug in Qemu.
> >>
> >> With KASAN, my tree fails 100% of the time (mm-stable + my maple tree
> >> patches)
> >>
> >> Without KASAN, it boots 100% of the time.
> >>
> >> I think this verifies with you say above?
> >>
> >> Thanks,
> >> Liam
> >=20
> > I had a short look yesterday and the boot usually hangs in the raid6=20
> > code. Disabling vector instructions didn't make a difference but a few=
=20
> > interruptions via GDB solve the problem for some reason.
> >=20
> > CCing David and Thomas for TCG
> >=20
>=20
> I somehow recall that KASAN was always disabled under TCG, I might be
> wrong (I thought we'd get a message early during boot that the HW
> doesn't support KASAN).
>=20
> I recall that raid code is a heavy user of vector instructions.
>=20
> How can I reproduce? Compile upstream (or -next?) with kasan support and
> run it under TCG?

Initially, I found that e553f62f10d9 in mm-stable had this issue.  This
looks to be in v5.18-rc5, at least.

So upstream + kasan should work afaik - but I was using qemu and not
TCG.

Thanks,
Liam=
