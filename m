Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435E571D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiGLOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGLOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:51:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403BB0F86
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:51:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtapB016690;
        Tue, 12 Jul 2022 14:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=r9S8+om4rgu1ImPqq/cLgcJk0xKjmIBH5+22Gi4HIYo=;
 b=aZ4FhHoBglK7oxBMmEXGMQ1JTw5efhHnBuARf07jXe5hA1JUx1Hz2aNlJ4b+FVFAEMNw
 X958bw+nkCU1gbmWfmP9bjbqnclYPueLycdirMHBOzD5QQzg/uMEuZZMR7qZsBz/mN49
 213dXwq3A001suaIfBSWM9JZFWKEIIpRDFr2L4zIuRK7VnwF/Sc9AD3dbEPZpWhteNHH
 gqOb0XU0XWEJrXZyu3PS4kKpQx9OtvF/Tl5zFD9Z4X4xkK8TZ9PJ+9F+VGk01sSeBGCn
 9ozl2h9h7336lBgxxCKgaEpWE5ataVsfFcplHfeqIqZbGvIQgOn9HDXxeMvb1uaZUzGu SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgpsdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:51:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEoCgl029043;
        Tue, 12 Jul 2022 14:51:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043svww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:51:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ito9ppeSj/RDjlwfueOfSXJOc6MUJcBMQqhMgQLk3XXAh/cJMIUyu1vh0H4YhuwvoUGNrBiMieuj9D+z34SL34QPk24WEYcD5HCUGF1ITaX3c+PLzt4NY8E7Oqt+FdY7EPBUCkxUCHS/FUNEKNWIqbP/iVS0GhrEnPSrlQK/rNfn+HXfPVlNxnz15iB2T7QGoo9+zf46Php3Tf87qZSmm3+g7iwmts9Bivvq/zIUKXfdQ+5kzm17BcyD+FDipIk0u6kcHNRmZiUWDZoDJDhws53QPevps6tCvGoIMALME4SVlO3Rg6jLqdEfunFInPUAaALoecasn0bJokOXvyQShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9S8+om4rgu1ImPqq/cLgcJk0xKjmIBH5+22Gi4HIYo=;
 b=WLEYvCsEdjJ80DV8veO72Eiq3NWCXc2ESztRmjdtSGKaBQGj6PO6075NGIUOMTsXqkGp/KdSbYHSSvFnKzUvXx79PMpOlXsX6ge45EoG9uh8EgRw5XXUn3DufrUgdLMZ/nYuYvbF0fgpkAsw/n/C4leGxEij1VVf1nG6TVQg5nvURfUief7duUmqvZsWaUfXWgPNTSBKil6Hd2iBzMGhjQj+b97HFq2yDBFUZy82aeysqO1Gx4lnd+H8WAxA/q2HvN1cZxOrKLJ7N6i5e9rsc9voyPUomcKjExOJtEnJ4p2ZOW2O4jIrkhrYbEWvzoaLubuS5fwzzhMf4uySH2fyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9S8+om4rgu1ImPqq/cLgcJk0xKjmIBH5+22Gi4HIYo=;
 b=LaKJ3Bjt3elNobbzPD4itLSaAGvZJ/j4n9f+YtaDOs9NCAKHOu6jfZlcH8pG+u8zX02JydcH6L/vONdbqgOKu627Ni0dwHf+F3X4y274KP2UkbviEEcYAqF0CdckyT69905V/wFBqe3Pz6XJ3wBbTMpNqxXS3mFN3BNctN0jbns=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1585.namprd10.prod.outlook.com (2603:10b6:404:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 14:51:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:51:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/mmap: Fix return on maple tree expand fail in brk()
Thread-Topic: [PATCH] mm/mmap: Fix return on maple tree expand fail in brk()
Thread-Index: AQHYlf7QXCY2NBcbHEu4IJRPLMcvRA==
Date:   Tue, 12 Jul 2022 14:51:08 +0000
Message-ID: <20220712145059.4191132-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 951f74e8-b496-4440-a184-08da6415f486
x-ms-traffictypediagnostic: BN6PR10MB1585:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0IBrW9sIue2D3dJ+AlKmE0Z8gt3Oi945f4TVDau1bjbe24vCmolHAItrJKv3YYcBhbpS6jHM7NV7IFb9h+nzvna4IQ7WLt21nDc2YKFNK5hnSVF9Y8Ef5JmDBKeBej66R+8EiFphB1LsbliNbq0c8yTCFx190MuD2lqdS6YD0WihzUoUm8uLFIHTiuVTvTsgdLz1T16+zy3Ahhp0qh4ZJed+m3kFJQ//gfI01Hqv22hdiivoXqwGPUoBMlYBgFfW+8RLnZnJHFBJ3j0iueOO/or50tNuBZ8mcA3o468LvgCiGCo86Fs+gbKllmi/cKzR/jawBM4Dt+BoY7K3fofks53rcXaSxU8rbGbvPzpj+wR+PPBonfE+raOrp0HM/85HGgjxIMEEGE25DgGJ2nR4G8yeS3rs55NXmXyisPN/QQKo3TFIAXLbNRUNb9QzdNFrgwW7aTC5GkGuZamtAzkn56BSxnMeotOvXIKRjGJYQnVN2lkKiLbhgnUZpLn+s3/L+GUjvwp2P2XJk7QgoCmqIIfg6Z/C6zh5RlpE/bz7TPSv7JCoV3V8FpV3HQYhO0q/Kwha3On3cz5I0aGfNNmA6JgxpqZpodRmdc6LgbGEu6waXq/cJwTgC/8rDH0X+8ZpxkIJa3OeDMzm/xuLj7dGC1PGz+iCfdNSNLde/6G5cJEaUVmr49gRZ8R6xEQkJVqqr85NDewJjU+u0tZ8dHoqglQ0LUayhNfZWGS9x7vpztdua7T4GzWjEI8nXIahYrUY9wguQQQ8lJ4iIOKl7b4bryO/BECvoicmI2JjPXJ4RVDlyGCR6/qL8CgMt8MQ7VXP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(39860400002)(346002)(26005)(6512007)(186003)(2616005)(66476007)(1076003)(38100700002)(38070700005)(66946007)(2906002)(6506007)(122000001)(86362001)(36756003)(64756008)(83380400001)(8936002)(6486002)(478600001)(44832011)(316002)(71200400001)(110136005)(5660300002)(41300700001)(66446008)(91956017)(8676002)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6b18wKtoybFLB3WomByuGarOUbTHQjuuC4cGEUBeCB84gVcCY5seS8bxr6?=
 =?iso-8859-1?Q?O0O3GOf0BSUg8MlnF1Gf+kdN45ZiIgDnuykx2dyr/oZoRjL8xYC/zQp3f+?=
 =?iso-8859-1?Q?PKmUc17RA6hFkJm0bO0i5UMaWGKMuXs31ru9VVaGa7XIKXGenWj7VfLUNd?=
 =?iso-8859-1?Q?NAgVR9V/yWAH6+UZDwxX7/b7dpGPdW4pbSpS2zGLPKG00fk2IDrwNyyEo+?=
 =?iso-8859-1?Q?czM7N4UItLWWPxRPeTz36iHAQe9NcoHyuLHGuGACF/rQLjlP5BYCDU+kW5?=
 =?iso-8859-1?Q?gqg1klge8s09RbB65oK4hJx5UvpXotIYxVPf5Wv8OkZC8whyh6LfW6iMF7?=
 =?iso-8859-1?Q?GEgpq2OUlT85AXbhyBJkGXdr7Ogz09RRjGAKsCda+FXy3sfPJosxzO8Ktr?=
 =?iso-8859-1?Q?3ZDjEFHJvrYQdEJTdukz5tXtM6NCyukwBtOBHfNDJKXb+9zqbYP+0HFtqO?=
 =?iso-8859-1?Q?UM2N8YO/+kWHXSDvElchflR5b1wXq6YPXSS05dTKFPCdk16MKx93j1T1Gu?=
 =?iso-8859-1?Q?PJDY33wVqdFKfbuDrUpeD0sZqeWgwiWFOKYfHXYZ9i/9iyzqd0Fl3g7cbm?=
 =?iso-8859-1?Q?sYyY9ifp8oQDtmqk1v/OsIk4jWWK36edPEI5+LvlKVrqSf1pJq/DIT2cPL?=
 =?iso-8859-1?Q?g4WjVAv3pwqOxjCVWwxHY/HHtn2c69f8zULpZ/zIFtFc6JPiByFfeVgBcl?=
 =?iso-8859-1?Q?6QhlmUJPu4gHny8GOQMrRV7S3UWldNRrN68YeyP205g3rCa12DjBbFNkGx?=
 =?iso-8859-1?Q?8ra6Smr3uWNdu47a8KM/o8HXujZdDRznupzq9N1V9JOGStJmhrtAE6Cyek?=
 =?iso-8859-1?Q?6DFpmTWEbv/gjfQLCwaeIO7jRKLuulGxEmq7eWnGsS+QlOUPt7oCqQCgUQ?=
 =?iso-8859-1?Q?DlYhC496Sq8uJB3wCShoUpKYOWp+f78GodhrMjq8qPv5O2DhYp7sbZlSd8?=
 =?iso-8859-1?Q?7SKWUHYyO0ZJ4l3xScoxWsmOKhA0OZoZVZvNrQHA4TqHNnXMCBatHU39cQ?=
 =?iso-8859-1?Q?GRifJMLUuSr4c9QWdwHlEZg6xHxiwJEwGUVRajxkU4QEZnc3yHkyv97OeO?=
 =?iso-8859-1?Q?E+LDCDwVHqqb4beSWnkNBpehOv4d3MWEt4Ev40TOnvypL4/H0zh2tTkCXJ?=
 =?iso-8859-1?Q?kZ3rdgkcd9syq+b32CLysO2x5ad1AXwO29pEKwQ0h2Pe9NbsSD1xmQZhz4?=
 =?iso-8859-1?Q?elHh7BDk7Rd0FceCp4S0R4jbT6hcywhGD+N38wDydeHKmqlFM51Pi4YcQL?=
 =?iso-8859-1?Q?8chXQx5tJapa52HPSF3mbGmE7STAnBJjbzdrHl2vUkF0njth5zzCmmG2Mr?=
 =?iso-8859-1?Q?DXsIXKESTkv2GSAAA3JRBo2FN8W7cNoZr4Okh0tBMV3mAOGoQI78Wc40Gs?=
 =?iso-8859-1?Q?j6+1an2MMGCwwXUcYC0j3b7vT3IET96cab7kKjXCI7lmHe/WRtorGjCAq7?=
 =?iso-8859-1?Q?0Cozubny3JHWdwwcq/uNwvDxkGZVDeBmGFjwqLh94Kwum/ISUnTEYLxs5I?=
 =?iso-8859-1?Q?oOzRThtkeeET44logNyoHCGAb6FS9poT+qtx/1yFBp3Bf+LkZCOdoAyaU1?=
 =?iso-8859-1?Q?YO5QE01bvphEP7IXddcP70fC7YqnejjPAf+IwlDbk0DLrx9Zi9D8U8Bq7k?=
 =?iso-8859-1?Q?tnbPhp2NZjSf2YN+4FCdAn0JKGcO0fwNdjT/sC/XWkbLTRzI7U+OTHNg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951f74e8-b496-4440-a184-08da6415f486
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:51:08.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBcm7Tk+Rvd+4vV4W5zckMovpLZMNLVaPfLmKW71z6CmAGIVgBWgFLeCR2ET3G0hqzHuDxLTGowdME8+T1GEGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120058
X-Proofpoint-GUID: 1KOdPIUTWgK6CLQQFSqdJ2xL-NaDOcVw
X-Proofpoint-ORIG-GUID: 1KOdPIUTWgK6CLQQFSqdJ2xL-NaDOcVw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When do_brk_flags() fails, ensure the necessary locking is undone.

Fixes: e9bad648fe05 (mm/mmap: change do_brk_flags() to expand existing VMA =
and add do_brk_munmap())
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9a07bc18e6aa..f25f53d7600d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3071,7 +3071,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
 		if (mas_store_gfp(mas, vma, GFP_KERNEL))
-			return -ENOMEM;
+			goto mas_expand_failed;
=20
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
@@ -3113,6 +3113,13 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 vma_alloc_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
+
+mas_expand_failed:
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
--=20
2.35.1
