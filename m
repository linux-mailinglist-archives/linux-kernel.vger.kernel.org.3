Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853557ADD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiGTCTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiGTCSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311565564
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0Kfbw017922;
        Wed, 20 Jul 2022 02:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yPWmZEKdxDE/97wYlhEf85fIi65b7X/pJDDRWoZ7d9o=;
 b=ggN/a9RMR0Ss/77ngcXhdh2w2Kq+WdPgl+t7Yo10DLo/DYW3+yv4F55Wo/H2n0WsyAvg
 esvNqQ1LZm1bzvtvrh6+qLkH3SL4uCADVUDWGDXSS/uo+KsfSneMs49Uv9NMI6uXa8/B
 N/L1nHvUvi8EV7sJPZXn6BNXCyrT78Ox0n8E73OlDhCOwgYNGJjRciWwnPQF/gsNfoQp
 VsuL5JjN6pEZFBcE05tn3p/efdoeEohOr0Hug1/9bmc247YU4mhY+Yn+ZXmxV67BGPak
 OVLEXt7gaUayc4dA2dkxRnmFqrTpvGNrXFCEn3aRo8x06o99sgllYPGyZ4+5EM31JJ70 Rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2CLIe002698;
        Wed, 20 Jul 2022 02:17:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnupm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIjLRfI84DIhvmAeDHicjCNeRQ5DQMZOaIWVojBiBF9TIphXLbFzSCYPVOH0pqrHRuPMoCrSkjzqWuaIVAmjBDzOHtWRzfi4VrNMzfs6abjs1f4gHRdbPIeCwMjAdoOk6WjQV+JP9RmflnqLiF9iz5LPegHXaNDLzGjFlfhQdVjYiAsNWofsO/dk/fLnb1a9YiVGOWNIAHTRdeuQQy5eYRC50XSAIcuq/RQ/GOEVQuucSc+pzvInMvWAEAg0xszHTNVuz88RRkX+84L+YyhN2gtB7Sl7c7JIRD4Ru/e2PHHG99nhDQt1oIJ5q4AQ5zV1nWGNhENGBD/4d6YFJkaiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPWmZEKdxDE/97wYlhEf85fIi65b7X/pJDDRWoZ7d9o=;
 b=Lsa6CIftWuA0sVCck3O+LnLkdM/xqVofPZvGQE3DIhiRgtzzBkc/xQpepw5v0w+sNBJyg4ucdm6gZ0qVrxTQD5mprYFDgdKnb40/8ayqtz8HHqFUCdyd1NMOcX93+UF0tlHeesxo2cYmiLY/RgXgoe67m+SCuQk1AUb8Z8Dqsln7Br17p59H5MsJig6wkpg4J6E8F3+EFWQBZ8BLprVU8/uHQKar1H5sUJytwnmj1Agk8uujQiif8LKqn/l3fBbTZU8HZ7XnU5HpjTGID9F7upN7gtlkp5KLsWDWWsTwn5/BbxwW9cOgZfvZqR8EVXFCFkycmT7D2XOzFJfAhx2ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPWmZEKdxDE/97wYlhEf85fIi65b7X/pJDDRWoZ7d9o=;
 b=Ap1QGAqap0/We6Ciw/cLJO83xYAn4nC9S7ym4blVzJeyPpTcuG12AtCcnQP8zkS010O8Zr+fbqlnLs6ddvXTtIpM3p+bGrK+qVTaZM6MeVXD3m3xQJqdHxynj5a6V6MwTd9M0rv6FM/yvi6OoV2qAv+VNOVscw4jQoNdwwX3t0c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 20/69] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v12 20/69] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYm97o5tyqdDgPs06TGazU8Y55fw==
Date:   Wed, 20 Jul 2022 02:17:50 +0000
Message-ID: <20220720021727.17018-21-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09a343a3-03e5-4725-e443-08da69f60db6
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0TwWsG4WK7tJHmUxcc9rSvMUviWi7Xdp4abEM6cMTuzUk/il+oHEpoVN8dyb+DMrPVVRqSsP1OEUy7LE3Of7tI5sXo0Gd0FohRTf0GPJwZvgWUAI7sZRK2lML+7DBaoOp9W+/uLw0HE5tBtfRRFhmLW7v8nT/Ip5H/2ek9Mpn+JMfe9GFLbqKb7BGj4vipRdufnRt5iV0CGt+M5D7Zug/1lFLPXJDUbwqdTHZ89t3V/eB7Ck/0u0avHy6k3RrvzCZrlFdkgw0jWy59SDejqQx9NrG2bxDHCtSbmdbGGD8OwK1vZ17pw+K1QtY4XFqbvdJLbs56pJXnnqCN3ACxJUxZJ+Ctr9qgnTLMgH0HWPQrCtkXyvmKqFO1SbTkYHuP1OJd2ZobJJFAT9huyAu42Z1aYaWW56jr3joQ/yyrafk8yKasaD/N8CIGTJe2NKNSZcjUdV0iJ5/J8eUwPFeyYCvI/H8cE5o4x85YSZQtxu6vZMgwe8Cjo5UjyljQXd9s+9x3xqIq9pKOXQ3C97oPJOdq7Eg7dTqZke2sXKl62dtIK3/oq/M10gIrla/2zsTLlmFT3MKfaTPtO7SQS5rblihq78joz5OoATpdI/KlU2XhQI3zzSzIc7X3p8iUdClXs+D9bYRxqZXC9/Pxk7gM9mxUFfWYpj5EJ9+Mrg4dwg6yin2lwGJpx2TzstmfpoiqAuyt3mxuXp/+gmQ3ouEhrjmFLzevYezOv6jZR3yz30owZX4z+zGA6VVdA9Mqqt7o7rYpoWgwFCuar6sfMuhPia9ynbo/pL9f0Rz7RzqGp6aMDWt/FVt1SvFDkUN5/E2ET/FgMlAVmjtcHH5q9WXV1NC38dPxwB2kA40JF6DdknYZY/RKeekY0umD2urCnzPjV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mq3S7yNkGmCaXcIZwGxtAOmNY6IPDqxIURc5dEhitGgpNP3a/0cOcgcf8c?=
 =?iso-8859-1?Q?+yV+Axezdg70uMRWWNUfY91MdAAchzAH31oZWKxDXCSEOUVc/hstczWmn3?=
 =?iso-8859-1?Q?AU4q4lkcq4El9FLzl9T9gHl5PKMQqQkcqrASj9o5Ksn9z/WEA/01VpSyoN?=
 =?iso-8859-1?Q?kQVkgDpLG8OHmifDc9dUqHXbITirlphsSE9S5XnW8z32MFwX2TgEBIQSX1?=
 =?iso-8859-1?Q?pj+pIL/bx1w99pUU0K4oOGmlZ73waXrj0rD/ENtdJO/ZQv4oT5RDNAKbTb?=
 =?iso-8859-1?Q?BRFqVVlyMkMXhenuZFS6PXFlr1M/gG0NDZ7lKHXHqDhpp2wlJeEbX2a0hO?=
 =?iso-8859-1?Q?LtUeYtl0Q1XxSd12EHANgmIC+huxTlOt9i6jhJl3OCRuFECL33EoXChoVr?=
 =?iso-8859-1?Q?f1sffDTdY/povp4wEvR1PNY9cfEi/ciOgJV5c/ktrU1avwvSG7ReFiZR7o?=
 =?iso-8859-1?Q?IYPQYGiOPVN/HSRHPlK36c+WxXH5AFx0CJQn4kozDQ+juVu2/GFdPFjqRZ?=
 =?iso-8859-1?Q?domwBQJppLNcVTYgshD31KuznIDql5dXHJV3erkvHbkUwmCHVcwV2uEKNk?=
 =?iso-8859-1?Q?/eVGqJiF/I1BlsFWzzBybKVehvFh24bW42zgcgI5+NmPkBed7foqR5p3QG?=
 =?iso-8859-1?Q?HQFXSZt+xZR3lsBitSrDS2cxWUStFwlkoUmviswL5nFWpKyCP4ZRBwSPVy?=
 =?iso-8859-1?Q?lq0SqqMl5h8DrQ4HEAjdcUn5EnGiIkNESQd36GqhEjxF5+5CmDKD/37xwV?=
 =?iso-8859-1?Q?cVWkfmbi4TGvGJ0DSKrGQEAZ0rRhLZBPHgdR1+96Nj1WAN8wUKbgtTDjcZ?=
 =?iso-8859-1?Q?ae5zUFwdZnquTd2RlfMKEa2nScDe/MxN0Hqwym5NaSJy/Zv8HQ8vpiFdqx?=
 =?iso-8859-1?Q?YAjh/ufH46IXqVzOK58i3kGR4WjOnNuX1oZjbpWyLFMTOP3fg3QlKTjBKP?=
 =?iso-8859-1?Q?qgOdaabO/TMblGKQdxbAX1CS1rx6OHBAjysDpFKtMfez00Z3sr2BNAfm3e?=
 =?iso-8859-1?Q?mBDb6kUVzZvDIOk5o67lsoJE4F3NWE00OXVkvo1M6tXUu8h3TPtv48Ntzw?=
 =?iso-8859-1?Q?oJquolyqO+PccTTCRw9Fw4Dx5N/CBGT4OG4/evLVtjCULduXb84p1UZGxO?=
 =?iso-8859-1?Q?ZSls5Q64PxPCDj4Q5D5AlstONfQizbntL4lyxTOoLTRFVOu0k32kGf3Ovh?=
 =?iso-8859-1?Q?iLb7v7bYu3QSsNMQJSiqaUUg/wWhORe3V3PUOG0iGHqhrfAj/H1Hkw6xKR?=
 =?iso-8859-1?Q?wmzFulYrGCV0P+hvsuj2R9gOO8UpnSOps84/+pcRN0KAZfbS3fyZE6D2gA?=
 =?iso-8859-1?Q?OM+4yTQpQEGVURsYrwQcsyUyGXdYhZ8kPdOzAMseNU/QH8TR6AnvE2L+6D?=
 =?iso-8859-1?Q?dyHYgSeWsMrXMLkoGIkCWWA2XVGTSNy4vvJwcmlKGZgQXVcbcZXtaUMO8L?=
 =?iso-8859-1?Q?hdLbcv0FeuiMHzUsyor4HfODWKf/BtP2eGS8lbvrqdGK2l2dNgCA2eh9zX?=
 =?iso-8859-1?Q?OC1q6cXAUrrB0Av7dk+FTGqI2UZjfh6Y3AGqFtD7oUoz6hi0xHu1dn6wju?=
 =?iso-8859-1?Q?c95pPw14HV9FWY+1uQiaE1TFrJ08ieq8c0Ytx8Yc/tWdA3zff4PyQjuDAg?=
 =?iso-8859-1?Q?FacDX5aAg6ug0pdGCv6cgUCyw/NU2YdTP+IcFBDFOyjNry4hYFLB4B4Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a343a3-03e5-4725-e443-08da69f60db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:50.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5c8ri52QeVofgJ78XT1yQZkgwWNZ0KXP8VBjxLHzBUoeaq3lV66F+5+5Tetj5WcNh8loLvXFkEovvsvTP5p7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=607 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: Lr81GlEW9umrTLYxjllS845REpY5AzWb
X-Proofpoint-ORIG-GUID: Lr81GlEW9umrTLYxjllS845REpY5AzWb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Link: https://lkml.kernel.org/r/20220504011345.662299-5-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-21-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 051b503c3fdb..8207fbc6ed87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2864,7 +2864,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.35.1
