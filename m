Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7757A6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiGSTO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiGSTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:14:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE0749B51
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:14:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGsmoD017933;
        Tue, 19 Jul 2022 19:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=JJDbbumj7TmH+BexTyXxwo2GmgP6p977tZ39ZTA0gAY=;
 b=RAVeKePPrXDUBNbYPMFzqQkp44eVfahK4J0VE9X9ssHGfSfnjHdXo02Lh8vlFvoVNUbe
 dS2WSEBWZJVWAFqOY/dCrjx7ZCf7Gz/a7FJlp8h2AAR+UO6OUAYe4DmhHR8o9y3Bl4wa
 0YgBaCdqacGmjCgM2YqkseBZ+ZvmLpBH6/qObR/ZqysyWo8b0bmBQFYqI8pdi7J3RTUT
 ta7JY54VRv9cYBh9Xs5ealbr3hNAZy21IVY/p1xzv3c8+fCMboC2DRvNY2TJDbS/Gaqg
 qTq1YyrB8wqwnGZJZZL06atyMCho96RLLQ3f4D3pBoFDRrjEu+FOF7G0BFTeKXBzXvSw Lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0yjky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JI2Bx5002654;
        Tue, 19 Jul 2022 19:14:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbe0xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtZ26gc4LLpDLL3nhqExsmRVGwiXtQDMcuEFQBotPyBECeOZkPdkm5AIkNDsgtbT/+TKkvFN9YRScUi4G3mIZjK/AfoilowvCGFvLnks8aUSOXp8RioHmPoEv9gJ9qJjVhZhm6uAhxEPj7sEFFQSS4OAFKniD4JDFzx01dyQ00pGetMYI18N7+M3R3Sc+JZIXurzCxcaceRV81dT0jSDnjUdoZm5Acf8xQFPwU2nwAWup1smGeyKya+JLBQN9/ww+PFUU9vz82UOFJEv2W18Tc/8hVkvBgx1MyUVHoIJ64pvlF6kXlR4lLw18FrwXmNhTp71w3aMaPuN2Xx9QYB3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJDbbumj7TmH+BexTyXxwo2GmgP6p977tZ39ZTA0gAY=;
 b=ksDDFBd2E96zjIdMtjQ49iojuYHfqjR+NiSB6DCAkUk7hfwKlZsNeTiSW9225v4tc4hkaf5G9OEc7gi9wMxFaVvi+faNouLJdVF5UYADqa5aBSzw/+3LTmA5Gll+f/lNgJi+g4zNjfR3kkIUEyVdjpPX5L/EzHDDQRmZlt5tbiFfDP+auFyyKzENMVr+Aobja5+vqZL50sVdv/rAj7Eff9E6/DdcozWhJLyPLcYlHzw3MkLkh1Nr8zK0uH3H69RQvPiv319TO4YRQ2nvBTsadjfStUhzgnE0apzb2HmS6i8P6Cck28DaqRHb3BaEIQHB9JjEeyfb1FYyKoOOSrvj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJDbbumj7TmH+BexTyXxwo2GmgP6p977tZ39ZTA0gAY=;
 b=KlbFH4xSLMT9S0Yz+3tUxs5kViA2UUcxdbLwLIVg5uSyaapKYWETqYjyXwEhx53p8HhgjSe9ovqOaSImSja6Zdd5ULfEmDWcEJ6BEriKKYwlH5ceAqikqn+CZEyg40NjsDlU1mAGXa3VhX25rmbMfGwO9cblGTRgJdSMw+DEApA=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BYAPR10MB2648.namprd10.prod.outlook.com (2603:10b6:a02:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 19:14:01 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 19:14:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH 0/3] mmap: Remove do_brk_munmap() optimization
Thread-Topic: [PATCH 0/3] mmap: Remove do_brk_munmap() optimization
Thread-Index: AQHYm6O0XK2UIQ1cS0WStM6deUXAAg==
Date:   Tue, 19 Jul 2022 19:14:01 +0000
Message-ID: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f03d9a02-bf0e-436f-3a82-08da69bad6d1
x-ms-traffictypediagnostic: BYAPR10MB2648:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7+r/K+D4OOh5yfvpIjTH3RzB/DQwfhvDDu6mUdvy30Oo1VwUGRDyenUqV1vKBVDyjNvDkcVdW+aB/9duSy1UEryBpFo19KQBELeT32FFfhdGhdmkeQ7fCOB3mKCBWSr//pUOK5dv1IlTIiHE5bwwqhs53qCTLSgsCqEJpVZwvPWnb3LAyhMvqjE5fdwT5L8Z04XruJFjtrXK0Ros4TFu0LJZhEVsdAMjL/fFC6dkAFoILJzWpkIcmRF87Mi3UF9o44l1W8YPZiusMg7UlcR3cX/KyJoOs0AmOczW8AWk/R84gXJuupJKap7AEdxzYZOzQfne5xdQScmW9gOPKIT/OaqLnN+FIM0QCMhdIBwjdKNJjZFlMyhiqblUVqaWQFPsH9MXL5RliRIoMPRhH4c+me98txmc3MlUYfLNoGvKoQRKg+zSmbDMJEJEWaAPVYI4vluUKnCCpbVxecFfiQ/JbI2G7kJtALKu3QQ5rWdLRIPf5X7CkVIMnv6Lyhvx1cTev1oAcxE6QqEeAESEV3YgvK6dPGs47U+7apZfQkIEt2W9NW0gEr1KZMTPE68B+9JuOP2TjN0Jrzo5OHeIN9jrGh30Y4tFv17nr+zhQ9zlsK/H0NpSDvqqBg7/I5rKrE1YIK9v9Jc2IjaiVKUj2yC1IxQKdfvPwH5ILasDGuHCTXbsFL3dvZNjE4fKl/O61W8idIYMqkAUa/iiU4suhq7wHrCySNJLuoc+9+JzZnzajKLvt21A+XfNnXZNjEsNqKnB8xcCg66/H/g66nxtx9lbIWRa72UZ/xGmTOrOKiHIjVgDJ9OqsX6/uR+TeaqGQsd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(66446008)(110136005)(478600001)(6506007)(26005)(86362001)(6486002)(6512007)(41300700001)(4744005)(2906002)(44832011)(316002)(66556008)(8676002)(66946007)(71200400001)(4326008)(64756008)(8936002)(5660300002)(66476007)(36756003)(122000001)(83380400001)(38070700005)(91956017)(38100700002)(186003)(1076003)(2616005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?51/FBqov7zNokaeuguCoErpC/NDn9miEulJMiciSbOgM9FBEwymMCMc5Zu?=
 =?iso-8859-1?Q?gfaSvcUi+pdxUD3OsSIjIzpZ6V9UG6P7EAzj66ejc/ger8/IzDnznhOk+5?=
 =?iso-8859-1?Q?b1q4iyQQ/H9b98qalovr92ypUlxNKF/uELWBxR7hljhvsqBzsmG4x4Mfy9?=
 =?iso-8859-1?Q?3rzqGi4Ipu+iUjNSxXMnDYjNEXZA5Kjd/5SFHjnraeyY4voGljlc1A/orB?=
 =?iso-8859-1?Q?FPXNqx/vtvQClyadmnUz4TaHrWJi7r91Agr7O5G/JMYS1S/hL4opyRo9k8?=
 =?iso-8859-1?Q?0oB5eBh+A4KJJkoZDLhMC/dmdAK6uEQLcoa8RnmHM4ah6h9knfr4zBE5Aq?=
 =?iso-8859-1?Q?h8B4HVgBylY9xH7mt3mQboMRUzlUSr2t8T+mqRfjNkQj2tJseOIjIsZkXV?=
 =?iso-8859-1?Q?xiYH1QLHcbRsKF8WWStLdR7/5Q5tc2yksHSkvHfjyYzmfTGz4Bex67raMz?=
 =?iso-8859-1?Q?mX8hIQQ7weIfOgmPM7vxn3zD9sMhgjzbTQjU2Fa2CG5Pl7nHfFtN2yYaR7?=
 =?iso-8859-1?Q?/22rKbezq/inec4Vj33hC9CeGicFGWR9aX4+LaI63Kj7h7YIcfnZybl+5h?=
 =?iso-8859-1?Q?VtWbllJWepexzLFMcXxD3Xooe+cRkm0DYsTu5DPPkNb95nwYzsqj1zUF2X?=
 =?iso-8859-1?Q?Ug6G1qlxovaLVUW/2GCh4vT2Vf0/Z2l2prrlnvARlA4mNykArBGCjSYqKa?=
 =?iso-8859-1?Q?MQJTDN3pFaLVAvMZS9njhRwbx/Pd9B0m2FYHeLlAq/hWs2Kajga3dbLaNK?=
 =?iso-8859-1?Q?wAbW+9FOBAuwu0/ZEbPZaNuzGQdYMx8vWXGcH1nYtLsE6nEDbPQRiZh3ze?=
 =?iso-8859-1?Q?pgM6ssm1lbMM2sMeZNMPICS5OgSQ8KTvl21LpQC2ugqcbOCWZaTepgOIJP?=
 =?iso-8859-1?Q?h1oWw0JTqCObwDpwtwVpzP2cPJvbkNKnhmx++vip+u0tmAfk8H25+Ykgr+?=
 =?iso-8859-1?Q?xp+aTSK1C2ewHasAsChAWg6wqXVGGhybgZ/J4gPaLQw4qHe+nZvGZ3Iy02?=
 =?iso-8859-1?Q?SMg5qynxy0jBPfvI+15IRqqzQ/fr5cB52dwSnrC2sHuVMfdyeO65XklxV2?=
 =?iso-8859-1?Q?QGp+0wIRoB4FsMvM6SWDCBC1NlfLq6mRhdyf8IOSFNozitkuT8w4RU0dVq?=
 =?iso-8859-1?Q?cUk7LsYVAFfr9kQ3u75V9QVG4gu9syiWalVmhmGZSL8hOQmROcaXeRCv5D?=
 =?iso-8859-1?Q?er+QiklZUAPgbElg8K3Wo/Tr8BoK9iShq7NZp+2f69JPS3xYxD/A2PDSGU?=
 =?iso-8859-1?Q?uSvhMbDBxcyEPPhuj2Df/s5aB381RVeSVyYM2dMPB6c+zM2XH4SZa42W45?=
 =?iso-8859-1?Q?m2aqedpnhRY9wyeiyZmUGqBpnjcqYv55JKjA3Wk5TZqLWKIT6tYfXot78V?=
 =?iso-8859-1?Q?VhkwcOVuB0ZtjVmtchDkIBXxmc5QKwf+5yzXHkFReRWKoq0Lltj1LzgXs9?=
 =?iso-8859-1?Q?dAPtW9EmzWP6ObZUtkdzZazaG+iaG9VbaT9t4G36CiSpA+BF97dUe2GJHs?=
 =?iso-8859-1?Q?wGamjULunqOOIYS+EuL/+zwNP5GE3v4quqWk20t31W7cTMSsOHT+QSJIig?=
 =?iso-8859-1?Q?tf4cjvdTdRKVXs62KzXeAWp0soTV0HDBMckccnde0GPkfiVXd13gzndhIE?=
 =?iso-8859-1?Q?2U8tJh7Awswpi8EHNkSGNz/4ZQ+HdRmmJe7x4bgfX881zxn8aqmOKbpw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d9a02-bf0e-436f-3a82-08da69bad6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 19:14:01.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpO/Om7HFMXyyEqPq+7aCXyRvhZIfw+/IaoyjVl6ZsBiM1hv9rDf0bcDlDO8DKAo5ydySgjX0hrpmdd8rY7pIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_07,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=946 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190082
X-Proofpoint-GUID: gMQZc70AtYoE1OiDIJwGxNyfyO87sPAK
X-Proofpoint-ORIG-GUID: gMQZc70AtYoE1OiDIJwGxNyfyO87sPAK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The following is a series of changes to remove the do_brk_munmap()
optimization that Hugh flagged as an issue.  Please apply patch 1 to
(mm/mmap: change do_brk_flags() to expand existing VMA and add
do_brk_munmap()) and the last two should replace patches in the v11 set.

2/3 should replace 28/69
3/3 should replace 29/69

The end result should look like this:

static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma, =
                                        =20
                         unsigned long newbrk, unsigned long oldbrk,       =
                                        =20
                         struct list_head *uf)                             =
                                        =20
{      =20
        struct mm_struct *mm =3D vma->vm_mm;                               =
                                          =20
        int ret;                                                           =
                                        =20
       =20
        arch_unmap(mm, newbrk, oldbrk);
        ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true)=
;                                         =20
        validate_mm_mt(mm);                                                =
                                        =20
        return ret;                                                        =
                                        =20
}

Thanks,
Liam
