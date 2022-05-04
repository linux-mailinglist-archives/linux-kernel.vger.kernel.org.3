Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E648519323
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiEDBL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiEDBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87331345
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7f4030616;
        Wed, 4 May 2022 01:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=yjMyWdTF/LqBFb5UQ5UgLgjdMtB8nZtouaLEhLmHT3uYjt99iGu0Bs2sFjSNm3g96xDE
 x6D4ovbM6f+wfLjhQHpGf+NvVXGlBnIZg4ho272WIQvgpABJMzyBmff8LMkLC3fPPROf
 1Lt6Fvt23sNqi//COw9pM6ehGDPi52DFYPweaJ9GKLJhDneZ0L90oMZ3qwhwIsZBbOCk
 GsA5WT//ewdtj/Q9RIc5RiRzF24eKbkz8B1LA70AOLHawVIprDZ+R7mEb+NYy/jQqFt/
 tAB65gfqrl/Mf/BPmFq90tTDeoLW9MS2d4cQ/BZRNhy/o/PTDQ5UYfS/BCn6AbOpmn4u yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f5u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24415XlT004554;
        Wed, 4 May 2022 01:07:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmuyt7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJh9mMy4dyiC/V6Oo9hUDVo9KjFttN8OHHndshV2M7BSffzgDvkgILgTIcX2puW0pZ+iexpSCE8cvFmOgMe4Whe3HcwcGs1KVNvbzBta9onFZPaYNT62paYfcjIx6sfuNvtRlYwgVEBqIgNZe0aJCXJA6ZT7NOsWiwjHBDK+l0dS0jWEAIcLW2O0KJ7kMo9q1/gg0Y/YUUUSBhf2qqLh2X247I0u1ISrDyFX0LFoBxwc12VjzTnm/b4v2dQMDjOY5Lfmrm8FebXSGzmwsL5HcyniviCmgHWjrMpE3tovc6/LJqxUL9pRKLwSzaG67SAojJUdfbgUCWNgM+GC7kfbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=F7i+zqRrZUXdJzTqZMifZ9QuOw6Vh13awY7C03RDNe4jufWerrqtY+HDWbOxqN7L1DKSqQkjBBfG9L3j/MU3RqWPJaAFbYsNeOfZHZoeaM3bn9J3NKPPvx6cM9J6xmu2uHb6ooz9/9338jv4INrJXGtMfnnW7dnF3r0f/3naQ84jwE2MwJ5kNVX7gQWXBn7RdGtZsoSEQPTznLDSjjNEMnRPMzQb52rwnjv2EuKoNBita5ZrKoSAWF+M30qqgLc2YX/EzGoQyf27nXgpJL7nmQbD5q5vk0F+EJ5aC9xwLm3VXTPltTItd0FGstaefUVklJtnQAg/NgYBXPq94qIOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=ydbqIKQMikXOEnkjKoL+E1f0VMjv6sl9JD0Z7VNi3fu1wrMIeOHWmoCXifNTwJGeojC0s/IprEWnWWRJUgQoUdZ/MDPeDM1ApF5mT2GG+3010JI5ILnc+E2NqfHeI1W+7nlX7lscil9BSDekhwHqfjFKsi2th0Lpz+7MX6DvUjk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 06/69] radix tree test suite: add lockdep_is_held to header
Thread-Topic: [PATCH v9 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYX1NbwYfQMPcTJES0t11LneCsDQ==
Date:   Wed, 4 May 2022 01:07:43 +0000
Message-ID: <20220504010716.661115-8-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456a1671-300e-4985-30b4-08da2d6a7ea5
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4214A869BEA7782E4A475EECFDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qcPSL7aUtbpcbtN6Xkl72+lFMh/iNxmX9QUYWbl7ky04YVzjcIhwYYGAgLpB+r/4TgHj565YJAGAtO3TXePdq5x0jkl+WT3e3r91WnRPztx7giRtJcUuHDWzLljVwaCYtqAE4Iz278KaP4t0TQhpK7ExosNmQIQXwreYdSXhiEidntQQDOjB6R89GzT0V09t1oiuyLMzrz5sOPJudDID2pp7xatpqB8JQfBWyDMPctWhMx1gLO1BLMRR3/sACOBLt2LI+BlZILHrGoPC+V2L5WYfyaUoqsDV5i6I2GOUl5PxO0NKWPEDae3F/0Z3waVOzYXuWd0BZMgvk5fXFNAxSo8JXD5sz3PM2ZIZ1RSzqcRqe2yWW2oh9VBzG6tJOGUpVhBrh5CVZXYatfODMNjnsikxDuqSUPSGpYReGgX6o+qBq+4cFVLaw4sdf8W+i0vqhsd7OWZnLn5cYuXjavvlabxwyrw+Cxr7laBZzsVzi6x62z6plX5PekrGRC8JtB4as2q8UkWkYf1SVuESXXP3I6ibRQpWrPAwYHxVCqhheGDC/co2hQLU6GAJ6dnDcndHM12IDY6jRlUl0ifJ4ktV0EIvik2I4Tx8lnhhUjgF2N7aIRKzM0Fh6DWuWyUGwJKXe3sDEOkAxFAZ/EZCr2cP75MfU4HDBHH9zQsusus3q6NB7m55u0knx9+HOx2YcsV4asiMRGHo1MiB85P8XcEVmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(4744005)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?phPqrF9Tk86baslq/DZvNJeLwN+MAIhYlaKGZOwW3zo6UPkOUcCnbCT0cJ?=
 =?iso-8859-1?Q?56qmCWBRbFZ5HteQmjSuVf3uaUj0d+/ZAwN5Bm9J/508ERujfzPX2QHOy0?=
 =?iso-8859-1?Q?Gxh1mAK/XCG2AqlDp+hJqQb2DudulyD58o+ckmH1Tw7pfGFlI5HF58ssji?=
 =?iso-8859-1?Q?tR/m9sm3KIQperizavN5uZO+lK9g8hnnkEJas+MwTsWrscDqa6p8smbal3?=
 =?iso-8859-1?Q?Gm8Wp+PU3fawvBvtii5vE+khr8VjrUX71hKGtR9VrEMchDBIZu3sxad1Vs?=
 =?iso-8859-1?Q?OFjD2xxl+K/k7vcMmajVJJF0eW8jXxyMQyYmCpxTbcW9VplDMWAPYUrB75?=
 =?iso-8859-1?Q?W8dGtU4Ty3t3V9TDWZ5ebcD7Wm9ir6/MWocy5e72vQaa3643Ra8VoOPwar?=
 =?iso-8859-1?Q?yNfdMhEr1elq0qBpaxmTH1K1BLPDAkcp7IwjaPIDGor3B7wdit0WaEJ6PO?=
 =?iso-8859-1?Q?EPULKvhOPjdaLsdrC132D8RnlSxcrDRmzy4Hjctm6L9m84JE8JikfYaWkp?=
 =?iso-8859-1?Q?7DezJaGNFkCXtVNd9Go5RFROan1Uld2c5SFxpSsoamMZOV/lk+vZWqTLam?=
 =?iso-8859-1?Q?SG9SPdz2tj3xVEREwtScsExnWlxOmPVWAqKMiNoCQWbyvKJ9G3z/qAWDuI?=
 =?iso-8859-1?Q?qknsCVGLEMD0HW3Bn5JPOL2Y1RRyN+mP7UQ+4Tj9rtcZqEB9bCP9eUiuUw?=
 =?iso-8859-1?Q?2q197QBfPz5yixN3eL9LWkofvvNPH02ujG6wvj+nH28XNSEClIdBHXxtmV?=
 =?iso-8859-1?Q?YxAyHLLoVUBm1kFH3ZXY3YTmz2bR4Dhtjc6pwEFdNhcyDZgKyOPmdcGERY?=
 =?iso-8859-1?Q?ErgU8aZCENnAki7/Ml+vam2UStfDIulRs1HKUQCsWG+t+DEhqm1JPFu/UT?=
 =?iso-8859-1?Q?gOHrg7PVPRHiHUPRPeSgvZP2IGaAZ4p3CvB2t5QUufG9KLU/zGGiijofla?=
 =?iso-8859-1?Q?dQUfmUyOsNHGKiII7USEPj6qMsUUpQcSI1SRYVICwJ15qTZaQTLqYf1nuh?=
 =?iso-8859-1?Q?ctIEslAO99NXbNVxq8W3MfEECjIZGwqBJl9ghDeKIzTBXpQPXIuykBomzB?=
 =?iso-8859-1?Q?gSy/2bKw3ZHsqV3URamDfFKrsySs8E1bxL5HNBNH69G7P0gpmiwwycnClH?=
 =?iso-8859-1?Q?8AxLfP4LvEV+Llk46ozw1A12FyumXkv7SqekBTeXxJ3+DxiIOXetIPZpNZ?=
 =?iso-8859-1?Q?dRjoMloa9+e6s799fvT2QCimeGo2lw5hJwiKbP90q9+aI62AltkUSkIGqX?=
 =?iso-8859-1?Q?hAsKQMf1OL6JnPKASxwh4O9dTpfT42z3i6fV49x+psSZ39tiqLGnLa8Asq?=
 =?iso-8859-1?Q?zzUHMpIPEd7I7XqyTGmIYROB7JJACOpiqsKyBeL2AOcmwL5HksKzFNNg0Q?=
 =?iso-8859-1?Q?nvCMEsizkpsmNt+Ii9x+AR5LNE7fTcyfkxoRIwoGq1o9nfMwsFuGvBiwQa?=
 =?iso-8859-1?Q?XdtpTAM75tG/UxdElvWt1BQ5viD8TC+769FMUGrASowyiT+fMtAsv74Xeq?=
 =?iso-8859-1?Q?TH4ZMr0FZPL4QLYgzNLb5Gebe+qcf2JX9oFCCYhYuS0ZoHCVCnXAGnylOH?=
 =?iso-8859-1?Q?ZkMHdKXrz+NX4A+OEfr8pt91kuH2E0ictYVqsYC0ZPqzeCj7eCdZYH+G8x?=
 =?iso-8859-1?Q?IIL4dnG4Msk+zdW0qcPK0YyVrwV0jz9dRofawQvkd2qwH2676dKCHbMzWp?=
 =?iso-8859-1?Q?v25MWspxaraKLmrW8qRj/+tSfQIPWPRXxopRrRUMzIY0y3Cru3WD+isCfm?=
 =?iso-8859-1?Q?SmaggBAs2AOzOTY3OG9Z8YSZnXii0KEP+w75+JbujC8+LKBBLFV35w8TNN?=
 =?iso-8859-1?Q?ZYCWHVFxuB/+hhW3GDim4aIxT+fFlfs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456a1671-300e-4985-30b4-08da2d6a7ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:43.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5e6yVQPKi29vCBxl9Pu0jUU9NmsUB4IzCxlYkoX0PUyvD5Tn212NB848quTLPvTa08PK/6Gmw3/682OMuzj8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040005
X-Proofpoint-ORIG-GUID: dpVb6IJ_8u8ex9-MfE2_iDqozxUGCQKx
X-Proofpoint-GUID: dpVb6IJ_8u8ex9-MfE2_iDqozxUGCQKx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

maple tree uses lockdep_is_held, so define it as external in the header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.35.1
