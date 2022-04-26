Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3B51018E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbiDZPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352154AbiDZPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E915AE3B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT4b5025790;
        Tue, 26 Apr 2022 15:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m2ZI/+vagRnfF1xrHgAXXrk8PdRy69xKM1bE6sOeHmI=;
 b=DUx/jaLgxf+NiZNi9JBtHXHBeTllZbe9628x+ZyzxU35krd2V+pkEKXoxGD12iG0N3Rs
 mCstF6bBERdVNaKnkIkXOhN3IqQxJ4BEfWOTQvFcGYI4pTho7mM7FM5ThK53nEz+AuUo
 Q6psFHHVnbMk7Yfe64YiuE7QMTLSn8tXSUAX/faSNFHBzbH+TX72GxSdKhM6xy0zvDwl
 pUupPP+u94rggP3jS40daRfAyN0+oUU7C+49OnhKEqn/JnRuNFa6UUpz9x9lOv/n+ial
 QjlBtyNO3I8pDG3xPfiKLG01Uu9u8SuLJOdDuN44Sfrf1kisV3iaPfjyX1cQ/91BPp9V Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USV037884;
        Tue, 26 Apr 2022 15:07:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1cauUwKilPA49VmeHXiHzbJ+4B9sLYOBcbTO+1nx4whWQ5JA/rWnTugQasX23HnXWipm0ZnpshUmGzkELffXXzqmR9NAqZ16S2yniwrx7Q/9dczZKSG9MuD5M+YV8APQ2R43BCGfVrHw4k1wzhC+NYI27XY/OJC4iLRHgyk1/WnWMUOmCYzwLaMjq10HvGjMNq2oS67Bgkgsy3H1qzvQjnfYCQqRT0zr9ToPVSeHItZ9LB1CyP/RLZh+7Pn8w7AQ+R37uADK+VYAC+BCLNsTm6Flhp8FboOam6LJsF7gPV1tfnLYIEFFjNXFrwInEScKmHcn2sf6tCe45cquyFwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2ZI/+vagRnfF1xrHgAXXrk8PdRy69xKM1bE6sOeHmI=;
 b=lo3ZQ3o6VTCQTFi/VSaTkwvORvEqBmTadNXg9d4VIQZw8uVkStPgmj9p04/o8ZRCa5x/NnbJhWZ5LCvJJr5gxtXUeJbGQdJaMBW/c2mCYbdvy1WW9MwVml78zCtmYs2mxW1cvt0xUiUDQ+OaDrMsWDrxtdiq12Kg7l0nQRUDyLVVFs9LVd7RtHZhenTTzNaZ3HsyX94zVOfJTUgWFyEL21EYzsHTgFwhqT03Qp3UHn2SnabHalL6V7ueCuz8l8xqpf0QQdnBYj531xqbQVIU0RaETw+SkLzbAKT3yQzsHiZyz28E/55/aH69v2HCt1FGd7/CZZpoRzZinXweo9yGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2ZI/+vagRnfF1xrHgAXXrk8PdRy69xKM1bE6sOeHmI=;
 b=r8tTw345eipZMRKPzN86JZWn0jsg6ck4XIWyBRHX5RdEcfbN1itYe6dG52yVUZRfCRsEpBxD+K1M3+/UbVTBuu6XG/fcPlVZhm+IN6UNNkqd80+EcD7cqHzsJHHOwifebTMzZS0TG0wqN1+w6WncKlm2jT1ucvBVDZU7nhR0RP4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 52/70] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v8 52/70] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYWX8/emwTg3pREEyO1pu5RYTGrw==
Date:   Tue, 26 Apr 2022 15:06:47 +0000
Message-ID: <20220426150616.3937571-53-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b31a61-a5d5-4d72-2098-08da27967c1d
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377C26F1441A9DFB1059E90FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LYjGaNxJ9CXM0Cxzdk81mFajpOrRSpmeCpJ5W8XKk8PzG4OQkneQjqwJ0sF77Hjkoo1LsybnwUr2tYn7EwW9YqTtfLstLrZqiWgdrshlwDNYXRBe8SQYuLSWBd7oBgJSOD0WYCqMiqYhncE/xiPoiRVOqWk2ElakeXDyoyHgBiGUYgNTaG99lZxcllRWHquuUWs81Rrm4DCtO0LWSPv1m3hNI2w7HrjuRexkHkRbZA6z6Np351/Gli8AwoI0wcO3Cb71sJijj6RkkLAjHs/sCBO1NbR7IHV/4XkYtQBLv/+GceI4T7/QYbNC6xfnXiPhE9w3IR27JeVeqVL9kAXnVl3hGi78uGaIO2cSW/AqctrepoHcBY/2A5+royQwDLxZ0y+Z90T+V06erAx+DoUjZ2P1KxMRanp1hyR0HFmNTQ0BA3INqjbcXzsvHLuh45XILcjk0LSkNLxHmGVHQPd4Z8byNWScmyJoBNxot/fZaiLsTnJI7Qgyvcoh3nOy6mFwbs9PvVwVs+QVmxlFWmcv05iZlqXbem1xvDTdf7WlcA0scJsvUBq8N6L24/SjV1CpOZRqEAOdYI/u+McYRrdEdWRP3qz/V4e+ICMtpJa+PPL3Lh98f7aarLWlqLS/jKcx+V9cskhCHLQWOu/pTP41Dk7nbGiXPhQKHiDn2HLy4tm4W3PiWALl/48US3b7tillAc6MXTKgIWzzNEfCuSaIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(4744005)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k5sG+/cF/L0NbXWqKEHpKbwyrw40qQ9hEirSuNPJ3nKJcPsxp6nKwP7fYW?=
 =?iso-8859-1?Q?kHA5hSrLW59ilhiGJSlss33UMzPn9mTxfJKdThiieODTaGsqQy5hr9ZEMn?=
 =?iso-8859-1?Q?N2hbua8676N1REHqJNFh32YX6EZ/HWi62y/htLwShBCbHAmaag9EWKdiyi?=
 =?iso-8859-1?Q?ngglDV3Is1kr5hPHkdZt0m9ifsZD6jbyGi+uv9YXEOLZbKD16sBR30uPwQ?=
 =?iso-8859-1?Q?QTDgD7BN9c58gil9iAfQE0EtUm5RNDFVi2WgJLMRJ24EvDZwK6Fe2ezrEC?=
 =?iso-8859-1?Q?o+7EhAJUEi5tLlbqadgkIgPBo4YMAXecyyIyoiiXlmIRmZuYoCg09dNCpI?=
 =?iso-8859-1?Q?elGCWR/FP0N7mlEB1iRHrnsHEBUS873Lo2FT+GFyBLJeaXnNgxMN+5u3Ro?=
 =?iso-8859-1?Q?4ypn8ntSYL5bJ68OD0fS1nIiOlBWCLmCVEhrPQnqk46ol7fyipwJ8lozi2?=
 =?iso-8859-1?Q?IdrodMMwEcLTDkluSm2gUG8YA+fQ13jvQ10jNHLCleOww5a/SrmbTCSk5x?=
 =?iso-8859-1?Q?OxOPFfeY/+6a1bhURVS2ITAQfgWtOJcQJYJoak/xS3ptJK7VRT9PWF/lyC?=
 =?iso-8859-1?Q?oiiTKi64TWlCRMBI1hMGy/mgrzLltkerR6PacTl6wTve6P/3zYbagsVjR/?=
 =?iso-8859-1?Q?qjivHNAcMKGqnupiArqpTqArUt7/chIuQ6lXh86Z8aqH6sAYYrmZ1J9mOV?=
 =?iso-8859-1?Q?cDiknACdFChyFGvqQrYRjdVXv/LexBKj8dA26f/vUCXZy5gCwi0quRGeEB?=
 =?iso-8859-1?Q?cHIS8vSjdRQF/Lze1lOPSlUSJ3KzEMXDXfUYjjBBFzK3E0YcWPCV3QjAvz?=
 =?iso-8859-1?Q?2QzLPB2ILl7/Abv4zTOd3z2uf1LeIOdDA1qvvAs9KjJWD4N5J9PW9P9QCn?=
 =?iso-8859-1?Q?qCNRlwHubW0fs1aW8Y5b0Z0lRXbjT5HUVtq2Q5bJ9QK+Fi28Pn42UXojMT?=
 =?iso-8859-1?Q?1Br/oXl66nc18zFR2jQKe7jTBkqL7eIH8G4uxPRQGENbc02g5mfK+C4FUa?=
 =?iso-8859-1?Q?sOxpfI8N0QX42147/zaWs4cFVYhcRGAYF3xam3emNufoyljuKBAeaK1/9r?=
 =?iso-8859-1?Q?5YAg5Pd8+b/PHHR4M1n1mAunHTa0Vl+IXenEk/5nctnDwZh1PwrZ+hNkPL?=
 =?iso-8859-1?Q?WqxWt058zZ7Z3GwSD2CmWLMeQaVaYtUjK0IxeAay/pCc3dLqda/9xgfM9P?=
 =?iso-8859-1?Q?yIQ8nvo5TND0WPfoh3ytPYXEtvAcgU7CzvpE8lr2RVvzwoLJWSYYftuBbT?=
 =?iso-8859-1?Q?Vjvwk9ki8hmhe/vc7vN+NNBg6WUgQvrwsJnkOJ6TH11nRQakkuzXY6+YR4?=
 =?iso-8859-1?Q?BStvdukzPyK32n2f1iJTtbpiqvJPI7A28J6gNiZdgOnJJfQYCExnHyjgf9?=
 =?iso-8859-1?Q?N6AL7AL2a5r/FGiY0Yu5IViC9L3yCL9OqmKPpVvrR4HSX+uUHsht11PVIH?=
 =?iso-8859-1?Q?cXHaqZMDvOI+aAf8BVHkDtZxAxQjP/OYbRGZ3a4Ko5Y4cjCJ5JZQBLO5NU?=
 =?iso-8859-1?Q?wQkc9pAJ30QyA3hKWKbHRr/XNpH24mvuSgNwryYBvvD8LNeeNo3ZVwWa0E?=
 =?iso-8859-1?Q?Znh54Jxcq+BqcIaF+JEUU5c5er0hc5CbyvriX3BcCKLg+Qk3J46HlsiZd3?=
 =?iso-8859-1?Q?gRSGhKM7mWp5VGEZW6vDoWn1l+zBXuwAjIRZWfF8A+BHCbXrDb7F6MMkXQ?=
 =?iso-8859-1?Q?fadUQODoyycUoFoZn8fHJnFXLl4UJFprg8hEYRJX6D5sww5lZqrF768MkO?=
 =?iso-8859-1?Q?kmPsyTOMX3naL8OZvfs7OHc7XQnUKup/iOdvs5ajfKo0Dr20NHCDMyNF/1?=
 =?iso-8859-1?Q?8/LXOWRZCQpdq/HwkQwMsrazYLcT3xA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b31a61-a5d5-4d72-2098-08da27967c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:47.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFbYHhXfcC2xhB/LQ/07/zlCELHtgls4Na3kg0aN84CkJ3DrQaNwzclrFykd8ubYwkqfufTUPz1JJ9tv2BVQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: rDLuaBaXZt1OBuUC2GOVtdMB8P_qfq6y
X-Proofpoint-ORIG-GUID: rDLuaBaXZt1OBuUC2GOVtdMB8P_qfq6y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
of using find_vma() and the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5c17d4816441..d6dd04b8d803 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1609,10 +1609,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.35.1
