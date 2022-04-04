Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661854F171B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377711AbiDDOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377577AbiDDOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F63E5D8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dr7f6012451;
        Mon, 4 Apr 2022 14:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=RILQ9rk+iPObQAqb5s2geduE9REdiXt9VNn4tQ8M3yiGQGH0MEA9h7nTAjlPaZQw5yNq
 YRwbPUcpv4QL4f06oS/gL9Bc9EsLBh2SMagjtmmNcvjgq1aLlC2M8NJrOo5ot7zq7GYb
 ig9gVrtQ/Xhinh28x9JLXMecF8s8kEg6xc7qlELDodHiyV0AaoqqaSSfrOGcKVuesIkN
 CZjDfUDyEX8cLtCMa+F9Y2HUlhXh8dlD4dqwg8EMq7L/4H3aRHHGX7H9dRVVbbPu4NqN
 jAeOZATT5FCLa6KGLjPKfLxq1712aLnBa+IrKlgSmXNoon+40/3kzQHBT7osmrb6p9Vi 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGdik027742;
        Mon, 4 Apr 2022 14:35:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gm6e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJvaipW8OiOkzDBqxOo16/L8jsxAZ9ALWN7npgnPph82oxFd2XOw8ihwZSrO3KGWz24rmfakQDpwzOiotzCeFFA3H302fcJuX7FMejmEnG2daYeV7wohow3xEt/W5eIA1GDA2QVHtntF2h49fOsFFfY7FBupXYoU7X2kkpqrwtzWqK/RPkxe8r6UEiaD4jgOHWHx3GVeG7f+NEmFanSbwc2+rsQfUL+TPbvQws+60r+2J9aA98GPlrzsMF95DkaKHHRa+ctHQeADUacaxxAhAQ74NCGK+CrBVwGkbD/E9tqnXOEVkbtzNJFT/l7WLB8Qbhsj7qnzbSB0ET3E7cj6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=IBmhzwlOf4lkuaUPFTd4qqq+NyYJa3RT7DDh0gSlf64bMHRsSNy6YH1OOjHQpK7ofeI4SxaNaYmeNONWkqze28LLK0qOFWrwmRAhWFND92FAVc5zEGxqz4tE16ORQVobUsB1rwtHvQWiACHyqE4vQnILkWIfhGLBF3fhxM0ZPN4VIEhqhSmKxZhMTOQlGEkGJRmcQiVLDFlfLMdMmsmmE6bFAc5QIoaZ0HIB/rLlhntvze3ZWWgzHtnEiZNEaLsA9Xgqkbp4r36xsNgywFomWlDIJeCTF76quGrvwuONJKzMEMO9OLt6QTsXujaS+5+4Dnh/v22CpI71AHicEYQCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=ruPO/0/zIvSIYNdXJIMLY6dSqIdEQyXHTWFzlnzWMpJQ3NhDQSvKG2MlTDgiLtrkeKBhwGEpy/F1D3sXEbJAzdxD7ypUzTv9p+Lx1JOk9v7I+e65rBpgLl8w1tuBimTGRxSB/OJkDuQBW1Cra112qgNAcCwoUztEmX1eSgdVWQA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 05/70] radix tree test suite: Add lockdep_is_held to header
Thread-Topic: [PATCH v7 05/70] radix tree test suite: Add lockdep_is_held to
 header
Thread-Index: AQHYSDE7gL+IuQBAc06Z+qgO1DVLQg==
Date:   Mon, 4 Apr 2022 14:35:29 +0000
Message-ID: <20220404143501.2016403-6-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1004f399-8195-4cde-438c-08da16485e16
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329D06A66ACE5390958307AFDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cbz56rfKnRTMU5vZc5ocGHr1TLRdIi6BNVSsbdoCGf8CKbsU1DoLfPU8AtxKl7RCbgwiZhMFB2J84qKH1Gmn+eWIlkxNhsfdQv2/Y31ynA5sp103Rpkwv9qWgBJjH3srFa2x31vINE7rTKqxxeU8xVIB0+Y7PSQhqaOUOla+vwAgddu2Vt8JDciA7uE0OUm/gt1MC+NU9TQi9D9mhf4NPASYwQkdnJi5uZd8IRqYc1jGRZdFs+1Q15krWhI1Xveb+st2yj490nbhfDhC5f7IH3lu+rZd0nRKcx8TaM4QzqzdgmcW9wT4AhfM0Gc9W7eiM5TY6c5Apjfj805kMMvBSExi8BFkaCf94AwdZ2R8Ye89Ykgb+LYsl/f7wAZDdzdL96aAaB7niBvPnsdVPRtD09KEJV99JMVMKYhouHhOlfPVt6d206moOCIVajQJgAeAm5PY9DQDGFWoOz+hk5YUU90eMN/6Ei3lbfaQDPK+f/WnJECEzL3Nk5P+Ga1Low9bA3tzB5QXds9kNdfbtp1l1Aq2sVYlSUYo33xAcwRRjTmJ3uMbMyfeewpPEcdoclqeTmJdNaI+9C870kZvcgaqv+aB5e9KzVcxzLmEJX7gWo0stvLgMdOa4TmcO3ZivYwSl5Eqegahk9W6oevhhUkEgTdBPiKJ1mwTn60GPm724Z9ZhAdErhgB2d2eythRiX7yMUc+y2aKDr7YPrUGsbeJPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6512007)(122000001)(4744005)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RDNWGLhEMq0B3XOK0M6aLgCkktNl7powwPS8U9F3eMJNwg1AZoIaLnj8Px?=
 =?iso-8859-1?Q?nuGS6Warjs0P3urWQpTwdTleU0qxMcNAtDu/LKpoiXwSCJzjozrvYwLrnX?=
 =?iso-8859-1?Q?R1TAue/slTvnxy38skcSLWofSvZz3YNwzjpjyYhnanfapOEO6ChkzJp4Kj?=
 =?iso-8859-1?Q?zuGoUqdAzFuyZywnkae+i3bmkPzBgGHTRs8fsIz/Vbi3thuD5fVQELy3hT?=
 =?iso-8859-1?Q?dopwF9FpqmfOTb48M2l4Zzfwwq5eDsjZ3L3vvWH1enZ+y+Nj9Ziauw4x+T?=
 =?iso-8859-1?Q?2CL5Ok0BvqlQsnN7w/rWsyr9KWLsXo3mQ7B8vR1kG1xr7pqUo5raTiSIRH?=
 =?iso-8859-1?Q?ZyCo5VOTxoLjk4z+VL5DFs0JR6/H5M+oUKDxzdZOmmVxsyxIOLwtfF/2Hm?=
 =?iso-8859-1?Q?DMIJ6Zq5DjHJtIoC2PKsXnswwzHE1wJ0QmsnHJq0gXvSXTFvVWCrZpgLqM?=
 =?iso-8859-1?Q?LBpbt44GT158tEkVbgQBWft3YygXOpw6d1cB1DiMxKDJzEAx0Y4hUjqlyU?=
 =?iso-8859-1?Q?D3g/65ZubdaYTjnekyj+r3xYJv9LcUcNVMX40nZW8Li9mqumI/Q+eNImpC?=
 =?iso-8859-1?Q?Oxz33tvDwjQuLESe59MbTt3eAdSedGdPnVZusUwICXrdOJOjzEt5AF51P1?=
 =?iso-8859-1?Q?SJzQR9c3zvTt1QCU9uzW8q8RTXlcC4hX+7ykgqatNdy1fCj3rBeX5sHD0p?=
 =?iso-8859-1?Q?fYgRgVyGfzniR/YadRDgWmirD6ifL/0Rw8YXRsdJ4GnWK91L7AHyB9PSvo?=
 =?iso-8859-1?Q?Cd0TW9LaOL2hNPfRAUcaxlq/9w/InlCtS2HN/Xn9axTixLAxgRuP1J3bow?=
 =?iso-8859-1?Q?ZUt172/moMMbPfbvzaPqCDUpnbMFzdXlRJOJwxpGwnWDNvGFUumRjy7Dru?=
 =?iso-8859-1?Q?lYuhEM/NDQmxMMX4fVveyOrl1mK2rik/e6to2exlmeeQBzm86mUd31HMTD?=
 =?iso-8859-1?Q?98ALYVRUvDgBbjFMFmWx2T0WL4j/SKJtvUq5AHYYioI7KaVmZqAT/MLXy2?=
 =?iso-8859-1?Q?ixgMrTSopzYgi71vvrmR9IhRj1Wg01JoDigg1dHMZsxs4kPimcJ/PRX027?=
 =?iso-8859-1?Q?e1woUeZBisukn3N/jr1i+4XdHew2h6MVJ2xqrqKQhNFdc6Sx6s+PptBkoM?=
 =?iso-8859-1?Q?5sJoaEoMDu7JUXM02cKqTJ7sS6LkB2V+175lL+Y3JIxrpjq1ug5mJsnClE?=
 =?iso-8859-1?Q?17OoGwj7PK/lYaVE4JJ21+eTS+cSsNvG41iPBotMYd0+IFVRdlHzS4QvST?=
 =?iso-8859-1?Q?AHVOt1Ne7spJLBhmlL7gLnsDAy545ELETIUa7atq7UsTp9tXsNT2a1cND+?=
 =?iso-8859-1?Q?e+AIqPNtbAfbfkk3clFRvo8IiDNxH7GIPLXwb6zDbeDqaesR4dDE8QjGbn?=
 =?iso-8859-1?Q?3k4t0ZDbGoWpPC+sTC8RkTYU+2UnFPxGcgT6PtGxoHEDCHwdGpiJlAnjg6?=
 =?iso-8859-1?Q?et5/AS+ibWrPeLf8Nhqu91bzny27U5v7IAZvYtncL26MMDbGxt5GWiGbUt?=
 =?iso-8859-1?Q?/y4L6tWZLAf5JMA52y88LslbeJtybD49RwEhSjk1M08RibKRa15TPUGWv0?=
 =?iso-8859-1?Q?fykFwDY/wUo97qJqRxbTOTrX5LuChHxfDalItXmeORQEnRV9ehzuVPcCDK?=
 =?iso-8859-1?Q?xhnkOv/0jp7l/IO5fcXAgUtrMBgNWLIjyPjs25QNEaM0/FSD0TTY4GlW7k?=
 =?iso-8859-1?Q?XooyBqXEu4n/+OH/5wlbZAnG3y01jwFDTw6b2FsSuPyyJdpwOQZatNXTd7?=
 =?iso-8859-1?Q?ERbMFWDgueMD/EOwMU935w/K4EImsj6VCPuMOFrGJViwNvigoPOzwXp/p9?=
 =?iso-8859-1?Q?lm5s/tDNQMxdwPGSyrBPV9F/9Js1uWY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1004f399-8195-4cde-438c-08da16485e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:29.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFa5XWFqoatPEhNkMrgaFHS77gehNqUH7i2XJlEz0tgv4n50CfK4n0idiyKva4An/Ysz2fCNclbwfDIkDuTv0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: fT3m6nLriKy_myxTB43rnO5yPkUVcvS9
X-Proofpoint-GUID: fT3m6nLriKy_myxTB43rnO5yPkUVcvS9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.34.1
