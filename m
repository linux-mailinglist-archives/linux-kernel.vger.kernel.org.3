Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF34F1726
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377958AbiDDOiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377945AbiDDOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB893F896
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpFqu006418;
        Mon, 4 Apr 2022 14:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=F2c7pzu7Bp/BE53tOgXqV7ZQl3bUBNi1x6wf9SrcdqU=;
 b=YYcoxEVePjxHyqH19QQZp4GDGgaAAsPOEq5ZjpYtI7hQdxG1+aK09jC8hcBGzOywu3qy
 MJdqS7rD/NpwuGJpTaSRBgSWMYYFKCpFE1hHLC4+rQ0q5JBk9plw8mkc1JO9YMaYdK0f
 n3VyTnR5kbefTswOYEb5s9ipHwn0ewN2zYAzIVqD71+8L0GyzVQ3rjEMpnIlo2jGAdjr
 LtCJvI6kKZQOfpnlTnoGZOcLc+hGuNCa7rJeIxwBOn4TiHwah04eb5XwtMwbNukyyTo0
 ohpqe+eln6gceQAJkUcM0P1lT0vX4tH2YAabAVzW6+ztCRrQ0ZQgjia4kHWeXIu0G0ZG Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGkPh033647;
        Mon, 4 Apr 2022 14:35:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2guqq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAb1ZtNBBMSXVj+xhUETviQKnlw7iTqxNkAtOq5Kjez8zZlf6KK6ZIZmtG/hwos8333m15jxZfw2ZAEKeNFI6M3QQKmsJYCLiGZW5OjJHyKmq34lOKwgRYNUc9CpHF/Oe+jI/tk33Ux+OUxedlcTBwXNOI0qw2YrEBOWS/8LPvt30BbqNSfmw4H1cMFIU8eZv13S20oI09aelNp7Tk1Dw/2xK9YjaMrAkpno/w01KybjCqE6GRRqAOrxS6GiIqZuTtkfiHxicKsMcBfMZQMkUA4TET6Qz9t5ZpRWSo2fW95tqBPA5QEaFatAtxcRP7i3AObU35lsK0FMKrjDcAhfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2c7pzu7Bp/BE53tOgXqV7ZQl3bUBNi1x6wf9SrcdqU=;
 b=XDflme4T6t3NTCJPUdHJ0HPjLvQ1XVsx3NR21pmECFD10Py/IQSxhAs8zmpGIFWH+M51lwYJR+l9PiL67kYMD/Tbg4c3x+uwEPsp0MVfnvhGnldg2LqL0mGAMoq/PQuZxDUEp2KK1a6ydFjkHxMp7Io/TjznGgPB5JOJOYO7QSlkrXAE3pBJQ0AzY87GE5gMciJk7x7HW1gmPQHh7jMipQDsKCXP8fwPmmAB4JDcUUefog/1ni3PDgIt5zq6DFQs/PeBy1Ecb4rpURrsRp9ArT8nmB1ZbsESbBAk9lTqLsRCrct1H7s3bjz8jBTXwLnIxbXj4JOI77v4WVD0H7rZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2c7pzu7Bp/BE53tOgXqV7ZQl3bUBNi1x6wf9SrcdqU=;
 b=cSZ3rvWO3N2ujJXlfTjUjA7w0ijwN8KBxqNNFHqCwetR78rKsI0TY1PG8SlKekz+vOgC66vhMqy2LQTS5Za7heWuzI/Q8rBNaq4wtQ1Rr97LMMYZIr5a+FVOyptdef0XPvp4SFypX4s1T2f6Ck0huNSWVRuzxIaVQHl1dZ07KIg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 28/70] mm: Convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v7 28/70] mm: Convert vma_lookup() to use mtree_load()
Thread-Index: AQHYSDFEaCAkDMPkf0WSfxPm5yqeuA==
Date:   Mon, 4 Apr 2022 14:35:44 +0000
Message-ID: <20220404143501.2016403-29-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9d02792-89ea-461a-0948-08da164868f2
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13814A655F012D2EAAD19113FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJUio6329NGRnonxSQLj6L9DJJ5Wa9nbPMW0oJqr/X34KvFpIMFcQwiGP/+JQoR+tSm7LLIznLfFMa8MtqNgPYu2Nmg6wCQhje5PaPmiZmcYJvrRTcGav2Gsk1+nYK20Eta7uwlg33B/B1gc4cvV81Eg37x84T3a+Ftd0TOV9Wqih32fNAVVweEViASc5taPZXd8lc2B2nlUYOmOL/ri4jf1tn9PgaWADezTlif8RNaIE9rWr9Gw9yrx+TX3o7Rxc85VhSoisnYK9PDZ8rgEtmwf3kZCO52kPJcJ978fgrNrVW6Sn2uXGo3JRd1FLfrGmSsxKsCuI9F234Y6vxFp73eWe2/zw1WQuOXNxwLXCn+a1U9Vi6x7JMRnnIqYjs/IrgXxhcXvP9yvaIw17kJ3ROtT4v1hUSkmjz1oA1W51kMmhMBQHpgxEXuTR5eaC/VdW6UEmDumgmaNOD8sNQ4OS1Bq6a91pxKDYKqBgW+ZP6/LgAa8zcRa9FbAbNoU79EMa6I1O892AFmnVJzLbncxJLWAcBfqa5PAUxzUuPw9SE93ljephp1Xj6jDAABb9h7oUcJ1yDaxxyjwzjQTbnwuoOis8Zzf0kZRP2vszRkd5KCeuXDdAJb1o21ssTuUFMzdlnteaYZ9cGbvVeQNaNk9fbTOQw2RfP4BCzlEVxzGeJmyCVLypl2HsZOz24hORmfr3qcY1rDdelwx63MkUj+UoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(4744005)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gAjcaO3OcrvR3zhqfmh5DP3+T7gdw0o+cK6IPFCkMbaaYpYqcN/LbpYT5F?=
 =?iso-8859-1?Q?Ow+pi5elKOHgvp2SVL/LBzgepwRo8/XDR/xUH3c+8HbsWmMWQgEweqVyCh?=
 =?iso-8859-1?Q?g9M1gwDRcFDvGy/E7aHkcSpqqBrgCflbZFQRYxQQ0qJc7SXRW6BgMQR1pv?=
 =?iso-8859-1?Q?fwQ60Z6AUmGRXrnuiNAOlQcmF9QMV+Tr+JeZIJk1bfl8d980vWmvGQtfEZ?=
 =?iso-8859-1?Q?QZZb4IWoRf/dzCtwGHIxP7snYpQ6XgjIKEco/8Y++n4KVciQA/70RO+TRf?=
 =?iso-8859-1?Q?gdXa1TV9fyX8/S3SRgWu/sa81kyF3TeeodN5a9Z5Lk1+3x/t1xqxnn8AtU?=
 =?iso-8859-1?Q?6/esMSjTnWhVwzNyBR4ugaJvpUdmUKvakram9zCoQGlwDGlj4FGDt9gqSQ?=
 =?iso-8859-1?Q?w7z2lTyXr8B15v/iTVUG6QRa9D1FEeJg8XpsyLX15FZYUfXL0HYaTePC+D?=
 =?iso-8859-1?Q?oxJItlxop4EM6MMYzkwvAWsULi+tXmz5K3HbBNXIs/UfiBL2FrLvq6QNjB?=
 =?iso-8859-1?Q?hMxNwBox5rEPuv00ApTJDwW8TU5UDRerzl1fctLFBliLX3TwfQ/mJ+hx9g?=
 =?iso-8859-1?Q?1Step8ty4JxeRhkfoJQaaaa+vcsuI4/QqlrpHYnhm4SL38BvoKjz7/WCLy?=
 =?iso-8859-1?Q?NQ4DMQxf7nEhihcLOV0DhWd8q9tHL0h4uNAPLtLQqNjunCq+EZh9BK/qMp?=
 =?iso-8859-1?Q?reYqP6dnW9vPMbX/4pcXp+BvYiD2nw/RS/cBZyAUCQBBfhixgwFPnAwljR?=
 =?iso-8859-1?Q?B5ni5pnekiIKANftL0dkcPsX5DOEob79IX3OXmIXEHhRY9rnVaqxLZT0DE?=
 =?iso-8859-1?Q?sKDNBVt747nXcKn2VtqnN1ASQJfz19Wbx5saimAV9nTkJWXKDwpo2T2Ei7?=
 =?iso-8859-1?Q?ZR9elu3vLII7Zi/bh/z39IqR6LkMYqP7qITScLDuOh0EkXIFeqQ866w+qF?=
 =?iso-8859-1?Q?h/Tx/EMbTYJIMjS0SMGJ1UhUsBXq6nMcUEoov/M4ClAmsHJRXtvc+HtiKr?=
 =?iso-8859-1?Q?xJnL/9WdQMrwERIjeEJraS1V8h0yYbao7kX7HdYEerKWyz4CrKhP6bTyhC?=
 =?iso-8859-1?Q?Ju73maqyaoNc4GNi3ujHe3i3b4qtUvLMOpZVgi3P2acfCuhhZOB2hWpyMI?=
 =?iso-8859-1?Q?N6f506lpzrn9oCbEECWuBNMsaVUJwCzGgsBM/DhgCKwomWs8WeMClH9lTa?=
 =?iso-8859-1?Q?+yyPqtwzxl5nNWKrBVOBBWqR7aIOrLudx2nyNS1WvQvNkOlfH0IxDGyfwF?=
 =?iso-8859-1?Q?bQVZxv9Acb0vrY2M9oP17WQlKCwlbEFaYjKl5aBFUUjhX+xpfBv4Jk1G+L?=
 =?iso-8859-1?Q?xBBEge7qx3Lc45yGDuB2ijco6/rE6wE71qjhXSyXi3uM/tRj/36NRanYVB?=
 =?iso-8859-1?Q?dYJoRBE8c5Oc/jn1kRNbFzJUDlGfZbS6F/VW25iPqbM0w0roRUHeicaWfL?=
 =?iso-8859-1?Q?DSnQv3aAXnenMP2yohSQ47vKWz0ehN5CmrHnPFFHrjPQRh10hZGC1M0+bZ?=
 =?iso-8859-1?Q?QT7XkKyETpyDr+hOB3E/HKHUN6xTrX+OrrT9Q9mybiEVmAnL2aaGThBYa2?=
 =?iso-8859-1?Q?L/deoLLFU3PaydneD3E/RXOu1luC7pkax+ZWtljl6ugjtQwVYP4YpPwHdq?=
 =?iso-8859-1?Q?zU0lNvkx2B2Gz1MuO5s1RTf7AxcYBqYRuwaI5Oz8shuKnJaot7NNF9oawM?=
 =?iso-8859-1?Q?iad5+k8K5BqkxcExesZrL0P+bJhokuuB96+19BkTdrroW9QaaQv12bAe6D?=
 =?iso-8859-1?Q?bAGxLme2A48HpheGTS1GQLTl4B9vKWZthYWosSGF7Q/BAcf7cm1h1R/wRb?=
 =?iso-8859-1?Q?FoCZHhwUQVp/lIWWYXxzuaHbeIM73SI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d02792-89ea-461a-0948-08da164868f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:44.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Z/NaHF2eKgzv2rdj6EUaKq77o4jcfX3+lr0Lo7n4TkU+TTDCBt/XYyC0TjCPdgrYFWqENIpVKxY3jiM6fyWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: 3SnKS_8670pkAXekWWWaVdpw5tKbTDAg
X-Proofpoint-ORIG-GUID: 3SnKS_8670pkAXekWWWaVdpw5tKbTDAg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Unlike the rbtree, the Maple Tree will return a NULL if there's
nothing at a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c6dd177bbbe8..7e39bdb5769b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2800,12 +2800,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.34.1
