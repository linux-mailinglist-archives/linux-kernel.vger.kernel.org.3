Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F91519353
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiEDBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiEDBRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7731348
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:13:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7fd030616;
        Wed, 4 May 2022 01:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f6aabrnmzO49lBVOmHQvV8Y8+WcnB9vAHpe26pQcMwo=;
 b=o9pNEgCSwerMzFpdVm4k8INbHYs9KtYARH7DHK3Phuqh+s1Nt9WPdvom71PbuyQGPgQm
 neyhmgBUnu6mktdJPZlwxpIPZMCeEzjdDl0bPj/vgLh14zqwKOv3vzdk0qU+kggFh2a7
 Z3ct7e6gCfNma6qmSu5GlaUlLB4c4VdLt08OPJQp3OmU8Ld2JodzNyW4YG/itsKYHmbO
 BwvTvmd1/cc8usmipUHi7A+34K3wOWoLuVdGYQUNXbMy1AYL/Gpx9GU3sytgj+kQLSWM
 DmUDo62xYPAhu0np3f3tIGCA/lU/82nA7f4sQMvPxW36d509KVSmY4fKrWIQpeMJL43O 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f60p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJT013094;
        Wed, 4 May 2022 01:13:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ednxRqIaSMci8HABa5HNIDzk+2jwfn16yrZCy9bexVbuWM6OuipmVkLNXogIUPsRnuEuv5cjK7qjXM7I2u+ihM2u6abvlLU6NDMkPzyJMEKOJ/LKaBcx3CsF6u1S/8o0DwKZ1msgVuoccu0g3uxYsK/jofrbZ0ay+AQV26YmOIE7mbcSGm1AwYPZP6cbm1Df/7ra0ByuyJpa0L0z0U2Ud+b5niwxw+HoDQxYCC2ayPB46VX27xMO5DlFxrsGAPS0J+PGWE7I84zjcCKkfqzFAH5pGSaOFYRMNl5fAb03WyO/w8lMpbT0Xb0YwSW9RnZMUqjtjOKg2P3w4EaZeFGb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6aabrnmzO49lBVOmHQvV8Y8+WcnB9vAHpe26pQcMwo=;
 b=HS5T5NqJVpNnsSrgnhZ6obYt09LvFUd+6l2G/vrU8/PWh9kLm4mFkIXu9zmwb+faOpbRrnuzRYGuGT8S4Oj2072v7ShZkhMaCHcjACqqYQed+BjHAWdQubl6pzZy3TE9HpUBcXz47UTvam9hixygQz2RO87Uckd702uTtzXE7rUedhG3dDtbd/ZeKEAV5yaFmF/BpeXHpZ4YU4t5oYxHbpHwGsKoh52m6s+wasi5L8VyA14hJpdJ0c/wdxXXK1LoDgkvMOoN/+a1Wg0+tThPVJfczBQLzumyDVDP/g521kMa9N1tCXS25m6XCVzVz2+2PtICV6reaQ0bwK1z3xqLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6aabrnmzO49lBVOmHQvV8Y8+WcnB9vAHpe26pQcMwo=;
 b=lTCaPiQw6BeoO8vgzQeCVDIHufEjrp4JioffDa2D2YTr/lGnTSsoIoTjUrc92Zf6U06BgkxkCr4BlaEQKwuDgdAL/BwZV6cKuLEImlXjES9XoTnuv24oTZ+gDkmaANJcoXnBzR1Jd6PD822f+HE+UXhRqYfrrZS21nkQVtie9ug=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 20/69] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v9 20/69] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYX1Q22PIpMi3WUE+umQfM3ciPKA==
Date:   Wed, 4 May 2022 01:13:50 +0000
Message-ID: <20220504011345.662299-5-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da50d69c-f65d-4c20-2554-08da2d6b595a
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB583087C1FF673589DFDC75FFFDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPr7pqgvGEQWvZC12Jfswd3SPOByYvZNLe82uzyKx+qDbYmxntMZW96/ZhzCi49KzKfF2IzYEvwdJO3s195/skWH9fmnQlwU4FEqQZBDLujbjMQ5hWtzM7VNRS2yWrAZ5KAIX2wAzcVWR5hcNC90v2PoNfssQc6pvl3a1yE5UagPsh5tOSmrkzpE8xiXcObhNmRFyKpwVZ2qOWzDPnjqeOYy11H7GvD/LeuZ9DJrSFQsijC34RN/iQdn5nwPTkhTRcdzDlu2hnY2hN4kyRAW3Ag+cuQ4fP/EEn8pR8Por3C3lzuU6wmgSH2ZI5apfizUe1GT2xuvHGGXCyjA1z945FNLEXLI8fGyYJC5AkPpZiA1E2L93hmxrurU2jrPs5/KCnr/SZ8LBHD6T5d7EoEKJoFgUBivILZiAjUgJpcUAYxAIfxjFsuYsmPQdoc1G2OW8vJj9bMCZZOdQl8muaoDp9BS3R2z42Q6SR7b9ggW2c6ctDskQgPcVeG4BvfUeZcCplVeBOyF+K2NRA/xYaPUpSfiWlsRFJIn7VN7l54O/U/BwgIFSzE7WjIke3loREWGT0bxOcpSFsWpwG2k1riaru0Y6dHYTAXKMGffjA8mPyWcn6w45OepnTtR3CWfFs/yt+CnQYfu1iVTT3WGi0Dtn6MXTa+6HfEf/hIcVsxxotvZn8q7yhxkCxe0ng4O0HW4oCMhMFvWetihTnDvWD82vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(4744005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?br84OcQXVMBZrxQa8qfz1R4hnXcf/3QRYcFxOXEB37ZlY2mFT7YIhN9gAl?=
 =?iso-8859-1?Q?c3RtnA5cxO8eB9kUe2ZSVqsLzUSDRgK2xqEYEeX+4symsBVpOUd9u5NYX7?=
 =?iso-8859-1?Q?H0ZB9Uy6nmmVMfYDa93KMWYj6TkM3zPZEJpu589hPeDS3+tnWeHAMpvxFt?=
 =?iso-8859-1?Q?+kOoC+n6xzNFtjeLsXP6h04kOS5BwtXCFFPZhb9zCXLraOTnS02lusAOq2?=
 =?iso-8859-1?Q?n+PIvdraqyW634gVimIOQ+BZ73uYwpEHmTLhgcACoJhfIQfQxYB2HHLKbi?=
 =?iso-8859-1?Q?NjmWWcA/bnIwrmj06QMxGXZRAXoudYspD36peNACVtbrNOFQDM4G01qbMM?=
 =?iso-8859-1?Q?Q67SXq0t2FO5LloqsramyJrkExgydZnrUpr2lkx9OdOIHpugGBMxXMruok?=
 =?iso-8859-1?Q?Wmn8g4/n2XxZEOd13pYtI6ny+DNgD1IiDSLCPnWH+jjmKLEXT4GOE3crxK?=
 =?iso-8859-1?Q?WisJVo7L/RwHOyE8ONgiCvGvYRCdWqsJZO0EBpwvQGDUdOTzPtzhaVSIlS?=
 =?iso-8859-1?Q?j/jvQHeCyC/YGJfPHCKht5WYssAldqFr9wEchzePj8cng6TPyYhR50NA7c?=
 =?iso-8859-1?Q?jrbAMt3ypNR2h4gpGOfckCeWw8BzdK2sZ0yLrNjPUg2uDLRPDong9kMpZw?=
 =?iso-8859-1?Q?96aEU5GG+y88bcSFHYfxOHLqn6P3lAKPvljvPQV95DYi8xH6HOErVNzJ5i?=
 =?iso-8859-1?Q?gfkMXHwoBAL1UWfZaXY4N3QD1xYV/GfW4G1O6yj46icWjdrfIlK6xJi+Vl?=
 =?iso-8859-1?Q?1YzyP++rYNSYc6lmwViFTVaFoYLvkVhwmeGIrFw0ce16dFPZeoM1YVn4TC?=
 =?iso-8859-1?Q?q93+yRkD8Gp7S/yvOrKql4v5T53A2o4lbi03BAhJISd7pOwEIW1G3db4lZ?=
 =?iso-8859-1?Q?nkVlL7ajH4rNR9Q9hEpG0dpTKAt+1cDFGcISMixBHcfVa1oXb0T82BvCYi?=
 =?iso-8859-1?Q?5+BgHp/mHAzmbber+86xS/EAp6VQPPqSxYqpyXeC4TeUP1gIi2XGQeWnHh?=
 =?iso-8859-1?Q?KU7Xmi2mt9V+gyoXim8svQ/KZ1aYZlydvex1nNG3dvKXvuX3absJc0unLX?=
 =?iso-8859-1?Q?7DChKKg8HJWXOo6DWp5ZSqUkdrdQaoK939+HcgUsvnO6PreEivoY/ZYmYL?=
 =?iso-8859-1?Q?PJHDeWb36IMzx+CB3FQv8Bo61d6b5wWhJsUvwABU3lPepoJ+OHYi+/yv7c?=
 =?iso-8859-1?Q?9W8IuqYvjfvi/LmokwTQ+PbaFlGgIuzwUZYHcF5BclNz24Zlq32lt7C22c?=
 =?iso-8859-1?Q?FQUgfCABDIaJESfYOntEV9vHUO6agkir4HVLat18xq7L7GMMYPd2Sllr6e?=
 =?iso-8859-1?Q?wMsgi/NDUgZaD9i2I7RCWSnF2knvyaF/63W5hBRVJSWRxbAFYueEnIgPrE?=
 =?iso-8859-1?Q?ekcGEh1Nx9DOOjFVOYRFkNEFoSQB0sNxU2yF2IFYdpUNHcld1kmyD1xCLP?=
 =?iso-8859-1?Q?l/gzYZSyZeXvzjf1XQhowdK0ksdq9fqitGME6I08v+WRzPUPL5YJ5Auyu+?=
 =?iso-8859-1?Q?Ix5piQuYAJAdnHp2ZJcQCzZgiTllWtpwE/7XLE5Jtx0tRnpZMTRQIEbFI7?=
 =?iso-8859-1?Q?XkABTwy2Q9DMYVaxa4Dg0osagPsHuS8Z+gguwzFliakevs022WEkqEACKw?=
 =?iso-8859-1?Q?c0cJBN9YCfDHYKBnW81P8AKRlL1hKZwgl3C8/BabpcCr27b+YEMSWG+g3I?=
 =?iso-8859-1?Q?N/ryZoNHNe+Uf/pExDTU4z3l0CpcPCoiZvFfksO+lJeJSrWIq3pH6sKpcN?=
 =?iso-8859-1?Q?HzpGgz5iEHV/4S+2ZLPJd0yOKK5rQDW7Aa5uxY2M8liV4LXMDF17ZQj1rb?=
 =?iso-8859-1?Q?SmGxpwrpyjJjSoo29OxaqWco2WfBq5U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da50d69c-f65d-4c20-2554-08da2d6b595a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:50.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfaLCoVigsCy1Ge8ogjoow5F5eu9Kp/7Pq5FDRr0UDrbs5pTdbOvF2Xfb6WjANRsZ0al03eGMqHIfZULtAJKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=618
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: InahW_MdG_7maYl6mr0nPill0sQYit4V
X-Proofpoint-GUID: InahW_MdG_7maYl6mr0nPill0sQYit4V
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

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d11673080c33..0fdb19d1b48b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2852,7 +2852,7 @@ static inline unsigned long vma_pages(struct vm_area_=
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
