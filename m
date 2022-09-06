Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8D5AF4BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIFTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIFTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0D98A57
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdLcA014155;
        Tue, 6 Sep 2022 19:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UBx7Jh2AbduOyod8pYTD4iqi/F8swu0SPWDlWbmPJBE=;
 b=LuJj/X0a0vc2/WAsRBm5mGBJBwAUuVz9CkFglv8zh99kf7gOt9bCY3leip8XHkyGOat1
 81eVTYUqi4u/DGSsiuKmpk3SBGDAadzC0vVoTYZmgxDaMa/Q5YINHaxkkg5SP+f7k60P
 mAR7ZzBLX9BT9a0hFG5otJZpplwId9Ks8xIpv6HXxxbd3j16jvUS2Id0unZ+f+5TH2wx
 XVjJFWcaF6q5Bd9+QFLxWyreYZUSZoYuNnvutP+RSFyULup6gmbAFyVHJjWwS39HjosI
 PfONT3Rade7a7dxrtt5BP6uNbnxwRNFs0Na2bdxCMarZZuWINm809a7UG12qb340iAV8 fA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eymn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wm027549;
        Tue, 6 Sep 2022 19:49:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNGxhtQTE/rQzgzcCh/z0CTLkQaHwyCzpca7edQYdf/+1vnAqHMaZaacezRWCAjTDbvg8Yo1Nc60v13c7ukYNb9zn2e59K/8bYizbck7Xg5vtuDIeN87/IKTqrzi2GMHG8ys3rEpPVloQy6sjbmG1Dy8od9NYWD0hBv1+JQOqhA4qo5HrhXz82L5O1gVZqSXtmQDbwn4XCJNzCBLOCyJH7gvYAV0TbyHc5wuVWyyBikF69OqO2RMt4JPKO4SvcgmL8JOZJn9KzBOYDNOqxTcsQPIFGM1NNoeJ1zq/uzlkCykShvr+VwWP2SD1HNgC+hZ6/r6iCFDsyjyMGjpE9nNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBx7Jh2AbduOyod8pYTD4iqi/F8swu0SPWDlWbmPJBE=;
 b=lV5qE/U/CLRC4k/jSsxtYPI8d6IsCykYM/14aGHT1/jHQ4dJaFWEkyN49xxwvPyHiGat/SQzhfFvn3FmSQr5yxRg0aPPK4B/lStclwDu1QrT27N8AJNpITxNyhd74X4cNtQhVb9LfQt1OccbIo0c8P0sKPr6vJ9gq5qOC34ocPJUs1ybIfe5AD2OXGPdvlBhUc+zXKdF5zsIH17oia8fWBxXGHoH8R3tXep1imYFg7U6TNkURv1fjRjWixsvlgYUx2z+UZOoTixJMI5uHgwtOLjB+FwynTg5zV55cnR0bbLmyXVrLADIXCfiU4rg8RBaU4eDcrO5VA/oDwk4tpLuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBx7Jh2AbduOyod8pYTD4iqi/F8swu0SPWDlWbmPJBE=;
 b=GvndC5elUote/Vnq9U/HtMsQeVr+3qW7QkT6+JxkhFUvvIL7wCu1XrhRJVGbeQK0beEapcs4z2VVFhV4K626at0+xd/2rFhVkaRncqguzag8sCiR+NNXAZuMX/WVrUM1Lu9h1I15e8s0zqJiuKCX4OWJDZN9m05BCLXFf7wM2Zc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 29/70] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v14 29/70] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYwimxATSz0R0CjkS0GAGjG2eKwA==
Date:   Tue, 6 Sep 2022 19:48:52 +0000
Message-ID: <20220906194824.2110408-30-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b60f291-a295-4d21-eb01-08da9040d8e2
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z76DnTNDT8ew6TbmW0yn8TpjjsSV2pV1K8mHPb5vdd+aiMKWXLOODvDA/aP3C3tgE1qqJ7W9NIuPC0YAd8KRQC2AzRw6UGMirA308kISrOBdvr6plNNgHrzN46WWWvX+E61SbF19dqGInpmCwb9g/Fm+RrfzvBso9R3vi5mE3CXzcuPYJoIM0dxkU8vTi9Es5x0QsF1UpAxpUSTppFp/YK4PoojgO5TKzcsxHeiPhKlwK0fGlF2XF5wy8RaqP9BfhouyaVRrr386pAnExXcLX5zHygx2rrarGrv7zcpn7TsHXIcsVDkxvE0uqGZD/iNF1Q7bQmWTKaEbnoCiycF8CNubO+u87erxoM7fcu2UfEmTY7e/NLi9PfQtEEwGFx9XiUBFmSGpv1fCRb2ya2IgFLq+HsSFbgK7KNyYFBq7Vy0kwI9nT08evqpE1NjZcwg/3gIeM+6YIZPhBdH6rKRzkTuo7ID2xA5L7w2NevRKRai3J7TfDhUZwjkDEibO7xMYLWwp+hM4XGSmhpX3Yca/xbZy9XLhDPT8GGpm+lxeAk0boJJ3Bvx0TFq0oIeNrAVsq3lov86aMXgwanmUw3Du6SG4IfYkv8EuSy+2VFmJCi86LVzTqXD3t4/NwxRe9ewMvfGGfmG1FtWCCuu5dXAhUNk6iL0/gkKcapzQO3M2wPfcQem7jGkcSRQmKZpnEG6lYKMtWfszYfZbembBoL/+i5OZv7y1OLqIv2rDC+Z22VxrmYgYR0CAW2gpPhmmXqMwgO8voGqWG2RQJVILKtdgHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(4744005)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TQ5FPNy4CpT5lCMlarT7ky7MSAdPEl4IVCjwmLGkiglRRtGXs8yOWyWJ8Z?=
 =?iso-8859-1?Q?+3tIlzkxi1Q9Nhiyu4zs3bjlauBkKlGdgucyZtMRMXAkJolmcZQ6nNkAOU?=
 =?iso-8859-1?Q?QMdh6llnkNl5ME0jZgrS24WdBPSQBM2gABW6Lq1/0JomavC4OFvivoFvIr?=
 =?iso-8859-1?Q?vf7AJ1txTZsUmb3QhJnBDOryUTaXKph2D91mnk62O80+DQ3h91o6ohLBRG?=
 =?iso-8859-1?Q?fOrJtSmKMv1WgAFUgeb8R/M1KmIqu7b5Eo+Kw/ZH5liURjH6bdeN9yInfA?=
 =?iso-8859-1?Q?4P0027PV1lUFoY4juXnIEVuJUE6ud6gcJ8kVQ5ni0u6yQJs8ps+aLW8lh1?=
 =?iso-8859-1?Q?xRMHvEGSIeGa5N7c2df1EG1IB13oheAjBCqGgO/+CzTUzl5gWrFHtHvJS3?=
 =?iso-8859-1?Q?dSewK1vDqjliH2qrR5dTj7CZ8bytZEZb2uChn2kz0TXQj4HBm1F0VX8S+N?=
 =?iso-8859-1?Q?l7VWzhFNY30n69/17KopJymLAoobQSraJwwgckoRE5pBJBYU0G63+HPzz4?=
 =?iso-8859-1?Q?PQpw9dZaQPFkxPZfiJ44ElkgPL7pxvGi4cw3AzWjXQqoS+H3n3Nvc3rhJd?=
 =?iso-8859-1?Q?Ew9CmJMhY/kdmkxAITfJAN0KrJBARZ7CWtjPEZ1yto0JKIsuvaW0JiotwZ?=
 =?iso-8859-1?Q?v7NRFnGwnQ1L7YkUuwI2L/7jmOH0bKzyZ7OyAZXjEXDPmRzrvefnnq2+J/?=
 =?iso-8859-1?Q?HMhd/cAR2iftpy0uGZsIQ/BDWjSn/Q4oLYOV0kQh+4RhHYgiWdJzpZuA+O?=
 =?iso-8859-1?Q?5+z8NC0FZ4fMDYtf71I/yLHcdqKPkGClSSnToBLq7cRFEnPdisE7PrOTIW?=
 =?iso-8859-1?Q?NSXyELPzUFlMfzjF8Dji1i7s7uqW/+OD+ch+tg1bME0mzZsfC/UiJNpbjc?=
 =?iso-8859-1?Q?dqCosvQ72OFxAyIaH8gcclntJbmxP0opcfnZNkf47y/rOqvn+jfo7GEaqs?=
 =?iso-8859-1?Q?2tWOb3Pdr8597kU31kjMnyji8obZ33kZGhGoZFOwQ3+KUaZ8ggrnfCgyeR?=
 =?iso-8859-1?Q?qIzLaGapJZ3j7SbIbwjU2/zK6nQ4uwkrKaLg62HfwsUwxOSrr9VK/x83Mj?=
 =?iso-8859-1?Q?qbwwk39UfGRRk8KLAvx4KX595wkNjT/fKK+gjUvQAh/WPCzopeAjHAwAlx?=
 =?iso-8859-1?Q?ZDcVa3HTVRXsxLlWa13lBBOvrdI+0vr6mGdYRRYSyCeXqHRNK2lv1ZOowW?=
 =?iso-8859-1?Q?+LVtI6YMoIdl9k6A1YUNQRbP0GVuS6uKO9czgpBZ9maeHrYgQOQ1WyAr7v?=
 =?iso-8859-1?Q?Qcg4b7WD/1EQcaWMUNYqPjBFe/y2gz8AEx9aETbpFlwN8QX3p1ZZcvsAHu?=
 =?iso-8859-1?Q?Gry3da44oR5jcQ/f/IgiZWg97cw+M9WLGl1IFmipc4TjiqFMnhFSRHb9KB?=
 =?iso-8859-1?Q?ts+/c1NFtc3eMAye/f76s9JuTjgwvBMLzSuPqW3bGqUk8tyDChNZ0ddAaI?=
 =?iso-8859-1?Q?o7TQUovpIYcwL/50Aux+KOHfi1ozYLZVUA9IBTAhpUrdaXyAve/pP5871P?=
 =?iso-8859-1?Q?t+eCljc4mH9VAoExAtD9DB8PZlS+kYeRZXzwnMrASfuF2Gq5n60FaJ3Zqv?=
 =?iso-8859-1?Q?rdoGERrVxPicOEKRsMjXrqoPqIh+F1vqZ2IeUIuhmUDM3aOh6hFIQ9LJb6?=
 =?iso-8859-1?Q?JZ8QO0Qk7le5TGEIYLgoH+gZEVzZ2I4jmUwjS772Wqkv3TDjqNyo0p/g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b60f291-a295-4d21-eb01-08da9040d8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:52.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTBMZKYQse0nR7hohd6/Dy4+/OHG/f89GllWWE14zJc93pWJAi1c6VkzJJ5A/pO7nxCWPackB52b00Eapc2byw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: qjU_k5Yukc4A04RILJodvsedB_FLf5Gq
X-Proofpoint-ORIG-GUID: qjU_k5Yukc4A04RILJodvsedB_FLf5Gq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6e587f4e3a7d..8b7e9d5afd38 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3042,7 +3042,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+	ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
--=20
2.35.1
