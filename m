Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DCE58B0EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiHEUwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiHEUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:52:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998414D0F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:52:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275KnLmC031988;
        Fri, 5 Aug 2022 20:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vvTjhwols0PebIHwJvyp7HypDepzWhjqNQNxDAlUzC0=;
 b=S/ahcY0kJaYKHG32QtedUvMbHi79qPI+nfj7l6TbOm5Rl1xVGGcE+rUid9sNwDJEhz6/
 XikkrN7l/7VDX8Fj7CVnILTpxbCzJZppZVOi4bCXpqLD6ExM83KmesDV+4z7ELwspONw
 amdGZOFnvcfmytCnEsMvra2i97qDZTc0OeZN0zYIewfs6KcgDkFvCxqAWA48YCvCEmQO
 o+BPKXx/1GJY4EJMyX8CbHJ1P0woSNKnXiljz5VRykgG/RtvARRzCs2z2UBozrhtgPd3
 lSVY+yaWquyiKiOmrBBx8TZyPWXO58sGZQ5zT6ce7JZQAe7m0T/1hDRcf2AUxDYsbEhA vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6trupt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 20:52:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275K4vjY010864;
        Fri, 5 Aug 2022 20:52:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu35qbjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 20:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGwOzpQRfuaw9ZbRKD9iwPyxYbAbbg554pSd2K5Lfs38PWMnWTEz+PoYzC4isLt8G/lKfXYkOKgX1+uz5XY1oimiEheXvVnpNwSaB4p1AYR7wkx/3G9dWA7f0mtafgzjtecCJXL+pjkcxa1vImuFP1ofaNH5eTHqFUNtoa1Beo3h4i1s3p9eFjGlDFsIm/8QHlkNSTsi1eLXmuUw65mgQnp6GsBCSLrF8cMesU8juzHE9o5Wf6mPEZ7a2wPE2IGfe/MXgayKRnCCLpDJgkRNZ2OJRGOgP8sUKc1YMpUrhVO8UO56mjG5HT1EQatCjSov+rIpDBT3a/rh7qBwI9KccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvTjhwols0PebIHwJvyp7HypDepzWhjqNQNxDAlUzC0=;
 b=ZINRuLSGl28Fd19SSbft0UNJP5CQ0YZh+ObqxY4ff63XkRRyDYNgsvAQYDiSXcyHBDCGlTRd1Jlc6DPcZfvvek06Eh0IHBpd2N/aSEbAeF6dlM/yi0owy7yU3pN0W34ZfMt9qty4ncM/PRhxgyIkn4Q0LuuJ8u9a/PB6l/xLLVx6HYMezpdQ9tqdBTV1CUgHj7+cIuxXdfpcfiLRyZWJxSGWbmYkRgpVhZ8Z6xO6ISEeESFg6pKHacuZ72V2ImwCeEqGbWInxT33eaCpOR8K+78f64h4OsRdauNu2xsVCn9qDf3mOB5nwCMDk2w0omqgtymEpH/0TAEeQWohZdiynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvTjhwols0PebIHwJvyp7HypDepzWhjqNQNxDAlUzC0=;
 b=hovMntIakh3Ej2ShFCf2Y/fviQELVHOY3Xdwl/FEkGWNww9E5UMfAQS/775CNInBdvOizwxmnCT/mDm2EhCQHgf37mbSy0aitQfktUki+bpKFS5eUiJgNWleX7Iqe9RGIjm2M7H9Gisl34kHtdjtcL9lCW5aMwVZx8Icajqriu0=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 20:52:16 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 20:52:16 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
Thread-Topic: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
Thread-Index: AQHYpAsmmbDT6gJKuEORFdp5TP+PXK2g0leA
Date:   Fri, 5 Aug 2022 20:52:15 +0000
Message-ID: <0BAD35F3-C90F-4425-ADEE-B39E507D4AE0@oracle.com>
References: <20220730042518.1264767-1-willy@infradead.org>
In-Reply-To: <20220730042518.1264767-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3729.0.22.1.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a01c55d-0941-4fcf-42ef-08da77246136
x-ms-traffictypediagnostic: MW4PR10MB5881:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgXnbCMobM4qO2O1IxvXso23L9sQVxJmKFx7/MWcohoM4g5M/KXMpT/BzUdfCGrHVmcK1Wr/zVyyQHepuw+tYLMmBc6dQ6RAaSN3uCKfkbCfBXsV5xjg9QNtDj5vTTO6SOazQNFxorM0evoREe5d47v/2tZGrM5rgu1dFzUnjvPGEDU33AKVYnfwaAjUIw7RjN4GW654ESGRoYKpRfN7BuOK9E6WHSLWJxsZeYYtmTUP1jnmCfcuV7gdpMqp8SI/7l4oI93RUbD6YkhGCn79KBCH/rwwIzkpELnskL2TkqfWRR2wEy/7+59GLwaqgLhp6Idp0RdQ/jD+NGIzI1fOtq8fqunCSJ5T/Ofn8RmIr8Ql9iHFpee0LyQKbxeP3C7LqBVOH03OV+xvNAaHIq4ycdXTYbXvJmG3yLVL1mWUYRTcb4ZKO7ucJ4skWmCMfaxa7mu0OOyzxN2/NcDVXlMVU/4UvJ9GYWBvSilrJ2Hh+Ts5fOMdGqHVg+vbMFARM2HmSac7jvAOElrboZEynlZwleutAAud5+wqNS7ktC46uYviqGQMmgYIuB81UhsYD/SaKkGnZKZHs+L45i3yG7BZsbI80sujwbKXFLIeS9G4FJrurI5fpacebX9lBPTfpsERKszfzimFFYPISYIwrv/OcB2ckwBqBIpS6OumzSFR/VCF8ZrOOZXvnTr6GXAQbZyJ0CeRAykfS8AJo5fLy6Sgol5JLGdskZ40Y9ikonlgBZ+7WEQLIHDDG8ghbpoYg0T7cTU5MJXPOww6ZzvJZdSKMsuC2JQd3JWswkza8ZCNBIhTKojw9GYGR/lpNlnJ/p17gtzl63y9qwC3nhT4F6+noA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(346002)(366004)(186003)(478600001)(2616005)(66476007)(91956017)(66946007)(64756008)(66446008)(76116006)(8676002)(54906003)(316002)(66556008)(6916009)(33656002)(86362001)(4326008)(36756003)(5660300002)(41300700001)(44832011)(4744005)(71200400001)(6506007)(53546011)(6512007)(38100700002)(122000001)(8936002)(2906002)(38070700005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MStqyYc8Jtj4ZLUjKWMkYYakH7eyR5IkOuaRQZ+mzPc6OA4hpeWbRIZhVZ3j?=
 =?us-ascii?Q?LApBTG71f5JJ8r7bPrnI4MIHHfKNHHwIpiM0P4xbQ9bvaaVxRLx437YrGnoQ?=
 =?us-ascii?Q?V6z7bSWqGoszVLgIXSL1yeFpk4KOHbIvbyrUssu85k1xSMtUDnuDfKXE1oGs?=
 =?us-ascii?Q?7XdgCNnES75QhLh5nJgHi15PPv0J0s3k1inTP0v07MtpSAXD9SCv7IRXhSOU?=
 =?us-ascii?Q?h9XFXPW141DM4439n/JDQyvVECYZ379wzzIyhJhMRsKps2s2LyfSKYUisVUc?=
 =?us-ascii?Q?fMCsLlx6qGHgZhHZktxJ5cLkfxulTYM87JTzBKiYfrzSxjyTP20hdAuj4EBx?=
 =?us-ascii?Q?sydzD6+cSwxYXMbuWOVX2SAsZSiJ2AboovN85Vrgu0LtcA3E0vEJtk0FkLA8?=
 =?us-ascii?Q?JKIE760nh4owIu2qK/+2L1JseSmXebROKVEnlbgfkKvtM1mlXWu1Q5+D8+oK?=
 =?us-ascii?Q?Wu45QWIlI7XcOQqRVGAQfnt73B/rvCaD/RKNNFl6bR8wrri3HuxPpxLKphcb?=
 =?us-ascii?Q?BiY+bn3acvusLe7xjE+InrYBjbgWrjmKsYVYw1Tsf6YGA65Zu+Jo0usUUf2f?=
 =?us-ascii?Q?R633+8o754Jg7MBUzft95V3zts5bkAOmpB81Q3hBFiDfEOc4NnLd495MnM8A?=
 =?us-ascii?Q?PK7ldbGiAjzT7lrJUaAizBlvwUnlfIz52ZZKlORyVUEVnXhIf+jJbjqX6AdV?=
 =?us-ascii?Q?lZ084rfWgCk+eJqgams1WVMV3M7jyI+9yWU+cva0ho+73p6TO9x9ap5crucb?=
 =?us-ascii?Q?TDeYeZhKfQ85oV2IpRQJ7WvemSI0obn3wLIKJ+8NrKGBDAVFhiKaEjmr/LFX?=
 =?us-ascii?Q?tIaUifrBmrI6usURfl2ZkFbpFy+iMJrO256lKfgERPg68CJ0K+Y8SUwUvdyV?=
 =?us-ascii?Q?+9FiNHvSs9Xt7G1UMs0rtcafpxEm9y6tyechc7E564bB/LkumTHesiJffnZq?=
 =?us-ascii?Q?AA3RM1++LzNsCkGZDZ/a/Mw3/js8We8Hvg6nxvDtYVqIfYThD26Qp14g3BZT?=
 =?us-ascii?Q?ssQfJaDK+QXWI/ySmZFZTWOuIMIs0QRjJr8RfPShlP1wrnxTo7C0ctqlEWoz?=
 =?us-ascii?Q?FGuyxxTVkIFCbJlpdV0IeKw53foRjsMWFQDa1F88JKNHnULRmYzD+s64Xnbc?=
 =?us-ascii?Q?NbLeQRJYHGhwEiAh71Qkwr1UKTdK0kI6NwUTK0NhS3eYImbYFES0GuEenQCO?=
 =?us-ascii?Q?TisOnVoYvNCpQBr9cVjf15jsmUCbzDjmEp5FsUnjnm/OqWW/AJ+89LsvmhJD?=
 =?us-ascii?Q?jhFcj6WxIxWrQjQGpYbngdwTwbtOeJR4YFks/lNvVu9HneKI2ds418is+4Gt?=
 =?us-ascii?Q?kOD/esQ3qdCYT/yTXGLFIu13+1it2UEyGc0qUmsibnMzikLfGLW/SHHjvxT0?=
 =?us-ascii?Q?gh/Tm3MRo1OW90s1DJllNTKcMjogmQN5YuJ8QTyhMskAhuqpJ33kLo6V7N8C?=
 =?us-ascii?Q?m4HOepn2jDLlhmVEMyx7IMwdEkLU63CshdwDII1NcJMGLM6OoKjQe4XSP067?=
 =?us-ascii?Q?kUmAXtBNS94P4bAoD/J9CesPPMsU4iAlqsnAzakWuzYjud+sHfbtKGi1wVSj?=
 =?us-ascii?Q?8qfE2ovJVQd7Sen4Q7iok5bvDsCw8iJgv32jzMXrDS2neLD7NYL5EKh29gqG?=
 =?us-ascii?Q?+JtzycW2Tgu2QoYWPu985HQaDORCfUfvP7LnxcjbC3NI?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FA4CED649D4FA438DD7688A3EF76FF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a01c55d-0941-4fcf-42ef-08da77246136
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 20:52:15.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx9ALKEhkBWOxVIc9Ft6u8o2qqwjWDLATJEgL/S6E59YrjK6IivpSCXEwbgEPRS7GyJwggGNexmh/7lti49ZDY7tk3wBMlQCuL6BJEazVTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_11,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050091
X-Proofpoint-GUID: 93Czjeimj5cMWV1u9tw7ygTTgWg2QQS7
X-Proofpoint-ORIG-GUID: 93Czjeimj5cMWV1u9tw7ygTTgWg2QQS7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>


> On Jul 29, 2022, at 10:25 PM, Matthew Wilcox (Oracle) <willy@infradead.or=
g> wrote:
>=20
> If we allocate a new page, we need to make sure that our folio matches
> that new page.  This will be solved by changing shmem_replace_page()
> to shmem_replace_folio(), but this is the minimal fix.
>=20
> Fixes: da08e9b79323 ("mm/shmem: convert shmem_swapin_page() to shmem_swap=
in_folio()")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> mm/shmem.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a6f565308133..bcc0a3c7b5bf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1771,6 +1771,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>=20
> if (shmem_should_replace_folio(folio, gfp)) {
> error =3D shmem_replace_page(&page, gfp, info, index);
> + folio =3D page_folio(page);
> if (error)
> goto failed;
> }
> --=20
> 2.35.1

