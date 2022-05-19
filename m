Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5952D6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiESPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiESPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:05:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7D3E5C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:04:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JDFXtN012698;
        Thu, 19 May 2022 15:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=dXittLr5spJWCEbAs5XdRpDfv9TAtOkCa1pC5cfem9Y=;
 b=tf0lR+5X81ZzowE1g7QNWdWJYKzb95b3hSbd+GcpP8oelH93UeJE7AbcDB6VZnI9l8CX
 rlmptofmFnhRtl0qtzl5FvQfnieDm6hwnAbfIsGyQCfzZPtzuzr5FiV6u95h8ukI55+E
 x4FvF9GJTYkaqUpW77ayGYhYHNLjlDvS9jiHgYleKMFggc2IiklcT+hnWKRBkDE3wHW0
 xfHxTDDXaWVUCvSiDhTmgThBBEqVMNI1GJkgdRrF5WybVGmLVpDl1Q5gl2Avtdt6NKn8
 aRv08n+z1sENG2QkYpwJrz4mZIwsyzwffghLIPHrywGFJtj3vRu5zzWmyHERzoPqYWoR +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aam83a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 15:04:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEt7w3025649;
        Thu, 19 May 2022 15:04:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v5d951-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 15:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myk9gdblHpFPuG2AUWq0GgyOZgoRmCx2FE77bpDDUGqcq7+qD5vO8E7pW4p6kEFQfxFAz1nUwCanQox5SXok2lTOxzRomKwogaCcKp0Bkq4LDAxounLvmv864TnO9VYtum33AqImHxjloYR2e4QAw9lybq9FN3zcsu/5PqOP7VgMh+Nq+7YRhIqRlPhM9/A6pYu8BIc4HgTVVl7k8cbAhYo6en90VklissDcMXZlZeyPMsdFMxvqbCxr2zCyDb6BHqFhncmpa87KjKcMJzTClzQLNZZPUBTAj9y+FjHZdXKMv2dHog7AraBFCIe/OHOjNLWSsJPIPf1JSma5E4Iacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXittLr5spJWCEbAs5XdRpDfv9TAtOkCa1pC5cfem9Y=;
 b=G1N3hWeKuUJ2x6kKq1o8EDO/gd7/GBPuIniNeFVc/Ym0PKhd+4dZbATDetWv0OdrM6ixr7hFcta61jYwbjdg89M18g9Zl8IbCCw7aXbwEnhqOBldfxVFnB2z5T/ZtwW0tDzdaIeVzEiDvwTv81DMs7QtyPVf7W7l0wLij7SnsAeDySYHPiY3zR+vtpkkYlO9MMJ9exZbYtnQeJyGj/LgKWJ1y1k2hu43jpL5ejVh8+ZpSY0BpikS0LGXVAkS7/uSMkkRMMTf6s0eVvekEddZNg5v7qC9k/+nWsG0ILNIDJ8x+3/L+KCIj/ROE4iTau9efqwTrNVFEaZao4YKZd6Psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXittLr5spJWCEbAs5XdRpDfv9TAtOkCa1pC5cfem9Y=;
 b=xWjfOGlT64wqq9QJMsOXHyzCFlESEzQR7oJ4iGAYVyVgIidrYKGnFvd4eAKZydJdl8brnx2qPYBmLpR6MraSWoYohwuUXCB1UHEZ5dpa/L7HHozePtCZUNVoW8UO7zFcba/F3cx2l4b9qUWPLHSd0uOg4SzX5aRfE3pJYeoXZTY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1984.namprd10.prod.outlook.com (2603:10b6:300:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 15:04:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 15:04:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/mmap: Avoid dereferencing next on null in BUG_ON()
Thread-Topic: [PATCH] mm/mmap: Avoid dereferencing next on null in BUG_ON()
Thread-Index: AQHYa5HJjea6o159qEeThrIvXc7AOg==
Date:   Thu, 19 May 2022 15:04:50 +0000
Message-ID: <20220519150442.1289962-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9864b61-2463-4bd2-a2ac-08da39a8ec35
x-ms-traffictypediagnostic: MWHPR10MB1984:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1984E1401D56F26D43ECD36BFDD09@MWHPR10MB1984.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BafFpbrDabXLs197VujavfCYWpVAO8pMZb/C+n1qXoERKG4CoZbpT2MsaFz8g5esFMgBA53vFPXuSwyd3ihpLXFFPcX1yNQZAEauNQ2gchhJA5AmyZV+zwgKtoYK5wSuhoBd1ktotWHifUPWagDSEUh2B2eQcMAjbwbIjKsqE05ZQILG7lYucf2MALZ/LgXML1J/8rNIJ5b2adRf9gdx3ytRAl8c2b7nyyeqwvx++hJmDIJMg3ab9osSX1ftDBr8/d2qqWMME5AZGQonYBy+v2qqdw4b7kiNW3/wExMenDmNPM0WTI1kXChgI1eo1iaHyIUe5YVWxKe47LdWkupJvouFXPzp4r/dp6HB0b2BqXSor40qb6UXJ78wHBs7tmF8fDEnn7bbtMgt5pYcVZwqypksYQCF5wZwOZIs14ma/JALmGN1kwhXET2wYfRoQxUTXGQzH+F/UdvtGdXeM01/hleGp3vgu9TALutNxSirlFw85VaUByOZcx5m3oEEzZQ/XXQN1GAO/wW10FbUk2qctEqNy3m7/d09OQnNbJGsskEX5HnhQ5Yk6ymHm+PoKMaAaZ+ITUtwEx2nUdGf6CZV53QOHApQHIeQ/KL1M4Fi2HKHqfBjAsa/07dK+018yhjVRSmX4on5/mbd4C3n+CDbUddUciCgvD8dh8lx68hfD0BPmeXpynTfU3Syqq4Zqb+g4OXFXayQAZXJIgDw8y+ufg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(5660300002)(8936002)(2616005)(4744005)(6506007)(26005)(6486002)(2906002)(508600001)(6512007)(86362001)(38100700002)(44832011)(38070700005)(122000001)(8676002)(66556008)(64756008)(66446008)(66946007)(66476007)(186003)(83380400001)(1076003)(91956017)(71200400001)(36756003)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YYH0zMqQFiCTpgACOta0aMFI9Gtk29FqbivnTUfYovL5UfyWkbGYt25GqQ?=
 =?iso-8859-1?Q?JNP5FBLjlzKTvP717tPQ4mxzjerJ40n9efaj95jlZyUSqesu5lZ+Np8SpS?=
 =?iso-8859-1?Q?jFWukscwHT4g9sfISwUGlRPHWeu/nQXM2ijQeQO0sTV9R51qsWCk3Ltyv0?=
 =?iso-8859-1?Q?pboLdQBiPxGFMs5cnhZynYBsjqP0z9q+1PAdr2awBxVDvW5aEwREq4FxPx?=
 =?iso-8859-1?Q?N+kTChs/WTcczRImvf/SY0e1MGsF5rxdzSohLiEfx5N3O+J33j6NiLzIRh?=
 =?iso-8859-1?Q?Px5W1xKMfa56+WSATCduiZENhQcOrm9DTgbOTyYmiPdL2A/SMNFK7ODrn+?=
 =?iso-8859-1?Q?wERY6EqGkkxEDImiE2GMH9tA6LQuLS/wUlJA+X6P6Zw0BvY5oHXpwXsAsr?=
 =?iso-8859-1?Q?/vA3QXdRlud4SGPwZszcYlJI71nDpgmhoL5ldLeTI0EfNc+wT4eiaLyO/i?=
 =?iso-8859-1?Q?3IY+XCqIg//tn6D6JmDHo0iLeM/W2eC3Z7r97v9ONwOpaO+hGEgTJ4u26m?=
 =?iso-8859-1?Q?CEYXoGUmIaDRJ6QxAMauts2vsg8tJ4KNPmql9YNHaFkQE09kEAYS5EmKAP?=
 =?iso-8859-1?Q?FdLBppl2U4rpQ3NkuDJWZa13dFhDq4rFyo7F3aogHs5zVcyXbmlI2tEnpW?=
 =?iso-8859-1?Q?WxlRJyHN+jjs1Gz6irfToC54ysyEh0l1F0hXdE6xnMZ6lV8gS5R+Ucm224?=
 =?iso-8859-1?Q?ydQ4M4m9m0cgcscWYQ2lr+64zOkwyxII8SgYuRQ1lrTdaAzcfCSkW5qMvY?=
 =?iso-8859-1?Q?DC/4vspCbqFSgNkdjCb1R6FB2Z2epUlmQoCyxBT6wQez5kGNgT8iJVAm9F?=
 =?iso-8859-1?Q?G1FJwd7IaEwZ17pmkaaHMX1elq7mbUZwSl83GYG7QT+We1dJEusYd4ssuA?=
 =?iso-8859-1?Q?Wv9ZxQZ4DgNH+gYe8W8dUrhi73dUAtvpR6eOhKuIB9t0hZUWyAs/MJRmxl?=
 =?iso-8859-1?Q?b1ZHMz2iOD3ic1PwGAXE5zE3Vto/3CgAfwN3yt4XA5+QbfMNNmv6d8V5zB?=
 =?iso-8859-1?Q?lWMIU30a/Sab7tQKQTnXW07GQHi8TTN3INwu+26r5biWF9FST0F8+0NU24?=
 =?iso-8859-1?Q?GxKSv6U4L8iuEuPGnQRSxfT1ApvUegAisEgOCBHfOLWAS1aT7pYQxjFDnz?=
 =?iso-8859-1?Q?2nZ3Yr+931M3yLdBduuM69TQnVH9ESIJV+V7ywa+pfWSP1FLpYvSXzmERL?=
 =?iso-8859-1?Q?9YxrM39jT7uDemxWKvMMVSG1DHTTZ9UdJD6/hxI9kbsVMtAnuRx8NZERCn?=
 =?iso-8859-1?Q?q8BLN/pPwBI8VG/L+wm4LKEuW+cfipJlQMI941xIzW3UE3oxgPDosBy960?=
 =?iso-8859-1?Q?hdnNfkHknqEVZYRBMGfZhRlTRhI2iXwNLJ5uMB+3GlyOOXkS9fsG/7FOw1?=
 =?iso-8859-1?Q?APpAqnlIL1CIH/Vi6x0hRpFTfp8FHc4gUxGCtrwPt/jFG4OUHBJ9jkNdd4?=
 =?iso-8859-1?Q?NOAXgdDqJXY081UnTBhAPJrKXHeCyzKp0NwJwDwMrcwu8FMucskxIsmHer?=
 =?iso-8859-1?Q?MWrP/RUcZCekeH0HJ7uugWWfXgp8txjmD3+P+kGUgLJFCmgVVA5gUXQb79?=
 =?iso-8859-1?Q?t9G5PAHW+lXrwf13D19yeaxv0lmDhl0OHuNBGHWBfIDPzzgVtnv3hTRTv9?=
 =?iso-8859-1?Q?YroE9P91ak2+muLlxZZJ1Lf2WOwTEzlx3UCxAno4BEfyr50IkeoWS5SlrA?=
 =?iso-8859-1?Q?N+YHhzvC7dwtTDRRC1F81P9EJQsA2MCXhNHm1hnoNrQeE1ZYQ9YphDWbgg?=
 =?iso-8859-1?Q?gybStUeiukjv3WHX7LARRYvHqS/h7HLdGUtzHnYRvJzMjKW+E7E6fDIS9V?=
 =?iso-8859-1?Q?0RI4h32vFLN9qAq5PJX/EWgCFp/QFi0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9864b61-2463-4bd2-a2ac-08da39a8ec35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 15:04:50.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ko0UPcpzcX4t64g3AUzJ3rG6JAJ2lHkIpi62kxwwvuA2inniDdjjiDFSTXdAEUZskATr99V9bkTgMCt+T+PWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1984
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190089
X-Proofpoint-ORIG-GUID: FEY-l-XXD0lT3e4fighsAWN4rQEQDbb3
X-Proofpoint-GUID: FEY-l-XXD0lT3e4fighsAWN4rQEQDbb3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check there is a next before checking the bounds.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4279e2acd243..f1fc9c5c068b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -583,7 +583,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	}
=20
 	/* Not merging but overwriting any part of next is not handled. */
-	VM_BUG_ON(!remove_next && next !=3D vma && end > next->vm_start);
+	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
=20
--=20
2.35.1
