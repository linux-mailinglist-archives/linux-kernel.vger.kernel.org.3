Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A75E59C25D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiHVPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiHVPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5A3FA1C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirqN017910;
        Mon, 22 Aug 2022 15:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2ToXV3URxTl3IviYCKGHSOY28a8N+5pXOnBdd2j3NJI=;
 b=ekKTtFbXIpnkTeyjLO3mWYTM5OH7zh+oE7kfOa3luNUx7ANPJF1LouKTU3cKF4Ap9CCs
 4PxERnXSURCnufoHf+lM7JWbS/2GXrcESzVBWZApILDWnUcAMeNMFOPun8qqRWtGO5Jr
 FmT3YG/GOrLfkvc8OzdHQjklKYUf1EPhc+zAaTHOGfNW/PvznWIRzsfE5sd7lZq0E9QA
 HEFk6nZRP8NW7wAKDqVw3+L6HDxByJtsm23p9OVWd6cSq9Fc0DDv898YjmP7yJ6VsFx0
 cFfgVHyFhZyUX2RswB3lloFjAZuZ2VzrMgG2DltDsVbRtbwkBlTPA6NBAQy4RmGUtmfo FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4MWp035318;
        Mon, 22 Aug 2022 15:07:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u2en-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS//nMuB3/TXWCTJUS8KsVlVZWzSeCwQEpeqbgeppBiuNXfp7f0ofcMeRldN27o8MZ3xS4sHGXZVPxflhGVd8XCfwKMq0tRLmOex+QJA6UzBZmAVNP2m+B+2lbnD+W7tnqgnkYGHklAoUwbT8dFWlSWA7UOAJf4eUZWH9M452bVimAyIMBxGV4uy/lrTWQqBMCTBJJ4bjBiHyQHaje328nIy2LOdTtMmGGHqHeakCCetWAzGbmM6UWRUg64NdDkncm3sPZaRdlt0xwlgXi3/cD9PPEu7SV/IGxGLoYMQTdf8lkPzkY3NyNjpU6G44ODqINvITwoVjQdTlUwLIRUK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ToXV3URxTl3IviYCKGHSOY28a8N+5pXOnBdd2j3NJI=;
 b=Ad46Bb27IcrImNOIWz+dz9Jcwey0HgyxaaP6t2LmQCsbOjKADFks3iFRLb/PqV6kmvXXk13cIcKpGnkntF/jVg6XjcWSEUZx++ZjXh5iDJQ7zFpz19n1dwKoh54ClqMo5NJ/pCE1tETODsl3bGxAJu5O1faO/nH9FtB0EhVs3VxzbzQ4I7p+1FmhXNqcoWYE1+6u9797Q3iERGtLK2aDTfPiUW/OUfnfEDbzoZOzSykJRwFdtU7NKMFA99mns3184ZHqgHocPW/3K6MN4OgsfoLitnWhRi2zi3G8B7ZkV6C4zXeLw/HQyzMaBa/Tq1kQknCBkDee7sW2Gw/Gf3Z1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ToXV3URxTl3IviYCKGHSOY28a8N+5pXOnBdd2j3NJI=;
 b=A/ssL9BUKyGutVYYYKnI3BuhomEyoqf/GBlHCfZ/gpSVENxMevRp3keBRqF5au3zOLNO6Ad4qv+xImXjQ/zg5OQyFts7OwjuokBBhxm4me9cGUF2oxKNEG1TmC0SlXlVpzrxLiPAgXFmdKq0Y/tldU8S2nMEQzuABXnhmnsCIPA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:07:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:07:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>, Yu Zhao <yuzhao@google.com>
Subject: [PATCH v13 67/70] mm/vmscan: Use vma iterator instead of vm_next
Thread-Topic: [PATCH v13 67/70] mm/vmscan: Use vma iterator instead of vm_next
Thread-Index: AQHYtjjELiCgpLREdUmZIO0wwSaj7g==
Date:   Mon, 22 Aug 2022 15:06:33 +0000
Message-ID: <20220822150128.1562046-68-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8c47df5-e144-4017-9807-08da844ffc4d
x-ms-traffictypediagnostic: SJ0PR10MB4512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVi3DhIhOak9mB02NNVfLmO1/x+qPY8IeRVdQquySmmHy4xxTmusmQVQXpQCAw7gpp6JqdcSZbKk+ujgS0IZrgBguLcMeGFpJLEpmmNZbmKb2n1Tst7SKrB5zulDe9AzsvSgxeOcCQ8HrWIKiju90avsUKEla52VPHpVK0yGsaneTaucgUkkSg7XOSSoqKOilLZuv9l9ZJt3dOE2TOuzNyu+tCthWRV2beurVXnjUQpzAYWyqCT/70IlhO7TuXXbpp++8aHjwcu6bVsuOPX9js9CNv9xM6KUueapY8KDdCoPseh5tf1eirZ0YpD+qE/9Me9d4fTQjgRiIXHlDpLc+3z13yz/6YAkFli2JpYDiz38GTZ23ogcWyBtTQN5GvypRXwsfukKx0tnKUNG1FaOHkhiYVrCBISH3PgdZ5KzewtZBk6JinQmNsTvl/n2jXt56C3xfSbBWpi98Nu9/1AMDq/S850a3Uy8bUZLh9d3B1sLEnn8xmNqu+eXFOdMqe1FzhR8adtowvlgj+ukYApHH0FhEXlPBRjxIW0zoHlnA2a37feWlLSGs48zh8lTvuVFp1NcN15FfD+DYtMuaMv3Iia8kouAvFUCCGhMBi+Nce993WvgRBkpPID24LXn1HDDa4+s1tAE9iE6pnYUMYsyJEkxXjTIuxYgz5mUE44+fA0W5mnQnygZ60V1ROzfcend489hgd52uJcv4C0sTByZiOEksOTqwZJWxCoBEw2lAYaHGAxXLpkIuSGxYt/dC76EsE89Et6IJ8HdSraoxX5n6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(38100700002)(86362001)(38070700005)(478600001)(6486002)(186003)(41300700001)(1076003)(2616005)(6666004)(26005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(8936002)(122000001)(44832011)(4326008)(54906003)(110136005)(91956017)(316002)(76116006)(8676002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7f0d4jeYyzPCkSOIptZovVwshzIf/juFkbAwAfJBPTr62JkNPYK+qbQier?=
 =?iso-8859-1?Q?QUU5DyctuiO6jhSSjfjPH4DR6B3ZRkB6B9sx22AJvuHyCWvYkVVL+UJ1cm?=
 =?iso-8859-1?Q?dAeQxbIHHKw7l3yGXKpbyRYtoopm/wEnrG5paVsboJMt8TW8hXR0PBhu9K?=
 =?iso-8859-1?Q?Vy+KVinFPOaFz0VzSyaQO+ayIu5ZCF9sGimUge29fhpbt+f4TbtK5pPL5j?=
 =?iso-8859-1?Q?p0ISJFoua19OpotqwdNAD48e0+FaAp2VK/fzmhAn4OFcRAq/ygQn0NyCnc?=
 =?iso-8859-1?Q?RE6N3IYw8DBte5GKonabmZf0f9eGKmJ0NVpK4VFhDIWzjWx0zzAS6PzWIw?=
 =?iso-8859-1?Q?gd4PZkRtoGmmNRaJonWiWnUK6c+FxwwMEhayYkfDpGzkI0VK1VsSFlwaAn?=
 =?iso-8859-1?Q?kpH510Ng85HQ3Myb0XDJt8wO2xSWwFmU4vGU75TRsbJFzvcV8PqMPxqmUT?=
 =?iso-8859-1?Q?gGvJYWx9lMIbMyiGfwRZL4Zx34YlsYKoZFgwdbs7rJTlPY8rNxvxuN8eBX?=
 =?iso-8859-1?Q?XVt5XmqV5HRWNGOWU2vGDZXrMXobg8JIlfbqeQmZG14kD3jo0Ngc9va+GN?=
 =?iso-8859-1?Q?6Z8PkksxJbw2cNkA+utAN78ozXO+zwS5J3ipGHhWabNk4JhUeTB3kdZzfz?=
 =?iso-8859-1?Q?CZaK8vH6CRkA/TeUAcZLC8B/Piz1Ynbs+eHDKX/IFLDXmF6usseEJNOQ6y?=
 =?iso-8859-1?Q?f0w6TuPoEUBFEVv3VMO9URSDIrxLTiJ6cHwkrYSBfG3/Jbwolfj35WnaJS?=
 =?iso-8859-1?Q?twfNYRyi2K6jOHfetvu2Pysba4SdygaD6q965IdJRX15yYTzA2j3HLMXvD?=
 =?iso-8859-1?Q?B8YoLBpnyAJZV0mGrtlMpJFznqp6HBw0f/iZAGvcQYsIhQ5fwjE2zTZqL8?=
 =?iso-8859-1?Q?3s3QMgNmoq10O4RToMDT8KwIT8ytR1pgfh7aeH/t6lgOVdU+g0MGi9Y6nt?=
 =?iso-8859-1?Q?SOUtiPS+5PqNTtFl9OlYnN8CKPOCH8ckpIxdpboxgH4h80uoHhG1z7hV6Y?=
 =?iso-8859-1?Q?dC40HJf9CgNOYNb72xT4ICblB/X5a/5Abb8GMU4tKHvHhyyVQbv92D2+n5?=
 =?iso-8859-1?Q?gtUSoc/yYVyej2lY4xuSr9FxalJTdVi4v/AnSjvEWT/FglpHEI8bI2Mo18?=
 =?iso-8859-1?Q?IGbefd3GWZINtov+jnDHhosGdN2bCTyDIEFUh1q33eGgl1fACq54BVqMaI?=
 =?iso-8859-1?Q?9VXWxcGwVankrftRx5AbIrRzZelNBJjmeEo4R2DmRgQdWseo0EIjiIAv1n?=
 =?iso-8859-1?Q?KMselAGD3Ck7uchf4/j4tuD/1W2dBMgFRh0dIjD5cnR+MsMoZDL7qhvUBH?=
 =?iso-8859-1?Q?Hq+K3JoZ8rXwyX28JF+uGt4wuEWUGvTpdpE5Y5FJi5zdPTvpLriPKJNOey?=
 =?iso-8859-1?Q?X5RgnoAjO3hQBAdWTZD68HgE/okqrF99bG6DSRDI/LkVi6L7guLYfm0Oxm?=
 =?iso-8859-1?Q?qV6SWxJN19mnpQVkODT3uXgY2/iVA9cgVzhTdnNw1InfqWTtJ/ty+LvJFP?=
 =?iso-8859-1?Q?pe2sqYhVmQvRUTXINXN5HFTJNMaKNr9XRiZ0Q9bQl3TQ6vTHZ4RjDkapXE?=
 =?iso-8859-1?Q?c7Ox0pChMOVoprwpCk3ShptS9LjVrhfldg0lDGgae/YGcm+xhInVMLtN7K?=
 =?iso-8859-1?Q?vDPuJZP2pDDcOEQZ98fV29J5ZXnKMvSAdCVA61pBhcLIT6hxDAPfBJ6Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c47df5-e144-4017-9807-08da844ffc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:33.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycdsZVOZ6mOtPQwE38tHZIZ3hcczk7E1tlwCHB+kwyZ+0vhLFFAEkLnpm2P2ogRvfJp4hPYmuK9BDdFvA4bSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: 0e8fGUEX0Xse3zflGjlSVOikj2yDYVlQ
X-Proofpoint-GUID: 0e8fGUEX0Xse3zflGjlSVOikj2yDYVlQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma iterator in in get_next_vma() instead of the linked list.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/vmscan.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f693720047db..9b292f07621e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3747,23 +3747,14 @@ static bool get_next_vma(unsigned long mask, unsign=
ed long size, struct mm_walk
 {
 	unsigned long start =3D round_up(*vm_end, size);
 	unsigned long end =3D (start | ~mask) + 1;
+	VMA_ITERATOR(vmi, args->mm, start);
=20
 	VM_WARN_ON_ONCE(mask & size);
 	VM_WARN_ON_ONCE((start & mask) !=3D (*vm_start & mask));
=20
-	while (args->vma) {
-		if (start >=3D args->vma->vm_end) {
-			args->vma =3D args->vma->vm_next;
+	for_each_vma_range(vmi, args->vma, end) {
+		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
 			continue;
-		}
-
-		if (end && end <=3D args->vma->vm_start)
-			return false;
-
-		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
-			args->vma =3D args->vma->vm_next;
-			continue;
-		}
=20
 		*vm_start =3D max(start, args->vma->vm_start);
 		*vm_end =3D min(end - 1, args->vma->vm_end - 1) + 1;
--=20
2.35.1
