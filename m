Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAA4F1773
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378231AbiDDOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378247AbiDDOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB340A2F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlLQL001019;
        Mon, 4 Apr 2022 14:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ALBrevdHJUjszYt9Gr9p7ExUeyPxC6eupHjMVzGUNcw=;
 b=HeuwVWvZyfaBIm5a6r4Mt1kmZ9nz+N6RUyPQy9v6uV+tovTrK/LXNPIu8iBXRXLAt9L7
 S6HtZNYdicLUh4NdTPC59dLV/hLdto/SG/FmJhSojaVqz1OKxbsUUyEb2D3c3DSkGNUm
 VdDm1KRtb2eO5tkNIarKxM0rW07NDjf8e3DhbviauyG8LVKnCl1Jm4VnU6j4bvZVQ8Jv
 yAwCDTd6/iOFUNS0wSODs8umnfdgMPcm8ULZWWFnZNbO6ULeKEZQxPuyv+zJ3+EA6Bqx
 w3n3Yh0NYjiQZefuzqJaiESCNJcggeNdRQnqlHz2umANTvWLTpllWlNJxFj78Wv9CYUg tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3skbpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234Eajob011889;
        Mon, 4 Apr 2022 14:37:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZJACXK49daSPMJIqgdlgrHm8O9dp9IyV8d2iT0uPx7SgfxAKan6ru3t5I4CetsC7ovF/VZRfXVmS+bhJ0uZCy+PXsC8e3IijtHe5F1G7ipQb93nJb2EDYC7ut0h81CWfzvP+z1PGqSfEUd8i95RiPRNHsDuwW+C++Fw7uUPrPf4vs9Umrp0zEtNoS+D+tNnQ/UuEcE3wBTVwSOKE+332N5pLjcJGIju5a6v/uHMTfuvkfxwCMuklmGV2PUzA2mBarNstlo/xtuIbeDfrxkcK5uKcY70nK3HsEv9oUj8E8FixieZRtNwaGP3OMQBGNMy3sOAEpkJBgroW254ucPeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALBrevdHJUjszYt9Gr9p7ExUeyPxC6eupHjMVzGUNcw=;
 b=D5JRcfMaH6IXcJBtNgC2bEa1UykpW81nZ8jPg1S/yIfEwOMCUbLeFsqs4SGUn16keHOv9/B476r7PcOYysh6COXCmLFqu4DJrnbbeDCA/W5PvjVe0XOYJQpDzOyp9TJ3qGlfI5YfWDw5rf18Odb4txkLhNWyR3gr9rdrgTgOThwyQGxkcdIWYM3y7MSGN/9pDxIDpH331dchIyagTHmecQOCCGDccuHPlBQZ2t3663KEXcobnWzFP5DAcch8oxHAV/oUMjjpRE44LjfVdhhXysx7EQAX8OjVFBdlmG6C4iZHmqfHeYgGxEUxngo+YmS/ODHyNpcavQZW9UR/YDuoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALBrevdHJUjszYt9Gr9p7ExUeyPxC6eupHjMVzGUNcw=;
 b=C8XHiWAgF6eel9WYOk595QS0YMn/hAQQ6ozLszmSusBy9xOAvTNqawDlpIeTklAQ4JlfbWRl+5tjfaK1NR+F2tMJUrKr6chCCTwPk2asXAEpM2Rf2fX0EvNrlmWSzO4CU4E7w4X1M9fJ33UjrN1/d5meDLwsp7b9yM2n9bwmHuU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 67/70] riscv: Use vma iterator for vdso
Thread-Topic: [PATCH v7 67/70] riscv: Use vma iterator for vdso
Thread-Index: AQHYSDFMJUy5BS2Cm0abIY1qdEaJyg==
Date:   Mon, 4 Apr 2022 14:35:58 +0000
Message-ID: <20220404143501.2016403-68-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425104b5-1d86-4555-8fe2-08da16489870
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB574201E66C82C07EDACF5D27FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3KU8XqBuwe6qE6O1kr5XToREn+PZmkaCYVCoz8/XIxFH4inkCcmo/p8igDVy/suXO0b9nglbSIg/fMQCst+9j2EH6wbXdiKVRWJ9gEGCdem5hguwiFD9MGgbZZI8ZJtzHIiNgjaaCpgDlMYoX5O/ibMnRBOu3XcHDvOKE+xdY/5wZJEK59vieXM+4CU63QWKEAGHGRZPeRkJAgP5+faJWLUIWsHub8YExWOWW8aZuRQT6y/jLzOD1OMZNcOvKPEwR+eagyO2xCJVZBgJeKa4i6OqYiytCjN+PnJ33rncam8yIxvPEwd0lM+4RyP13t1yIsaHPyyXurzt0vfwHIIEKf+p+UEGrcO6WL59ypuaqGDPeKXCziqUvLx4ZY60VapJ/zzUCfgDx4CSnjiK7b6I7RLBYZCZFS1vo8fmPtCi48Ezv5MMhTqNwEZlMzDifmrH4Bl0On9bJlSceZrz8dmKZxDVKRMYUaLgIqwbNG1KuJaGBBMMHU6xQmH+jUkbGYBVu3xEAATX/Nga3ACs6i05m1RY0yvoUUWt03A3n6hJgXis/YOKewgBcHW3/0Tz30tZXnjyTBte49Sd5wbITZQV2sH5pmI0P3l8LYsIny0zJUnHU9Mbm2MI5JtWLBeq1JmsBX1pen9gEG8WzzlOOxpiF1UeWz+L4yYF1+29CvJkR5ToAtI26kDWmA1IcHn2kNCy/+q3LDdX1SUI85WigA3Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(4744005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mC2zqIAMZ9JYlTirnheDXk8StxpGxgt1CPNS6qzwqEfZH/rFJtaaMNfOJ6?=
 =?iso-8859-1?Q?9m0ZKiXv9XFTmPglYV+v9wef3BzEqqd8Be/Wj8tSwp8s4gWBTBccXelK5H?=
 =?iso-8859-1?Q?oY/aY7SPk16mfcwWmWrUNPpEYSNfWm4NF40eboAtI33uQbdPyrFrzKzUsZ?=
 =?iso-8859-1?Q?V50LlRim3v2nj1nUXevca9hK6HkyOwT+wWdGfWZTYKGiI6bM1x0AEokPzw?=
 =?iso-8859-1?Q?Tj5cBnqTClw+xf74yFcGU4/1ng2ypLevlNb3xerXrKE1kSZm2GgTDAiVOX?=
 =?iso-8859-1?Q?ERumOoZJE96LiWgK+u0+tvlH5oDZ9jSkNTGaYfHWAUn7pFoz+b/DAKxaYn?=
 =?iso-8859-1?Q?2th7V4YdOIIGhkSrV7jTJ51TYdmPICrPK4iOboaF+0u8SUWnmtemNGwcjZ?=
 =?iso-8859-1?Q?syzeFAvqx3LsqQuvv65C6YX56x8xyGcSMz9j69gaK3wwMIVgS2Puju0xBj?=
 =?iso-8859-1?Q?KsSddCHZ/T+gBYvT2ZehR1DrJqMZxv3T5tdK32g9tfb1IpGtJqYl90FlHX?=
 =?iso-8859-1?Q?Qb3lNJFuJxGPrp7OB19+g1HLSlUc9ISm2NuHgsz1hOJqtigXN0e30SItEH?=
 =?iso-8859-1?Q?i1JQVoqo4s2D9DWdy2Pw/SFwdrVP5sUDqJKWzxLZ2ZeMWpwk4CarU9BGDf?=
 =?iso-8859-1?Q?nMT91Xeq1KOcqIE0QRHJWBQnG+POgVU9z7DU4pa0+3+xYfRNW6rlv3Ajv1?=
 =?iso-8859-1?Q?lXDp5tI1AAf9VI1cTf7Q0JZLiACGdCr/jr+HiPWDW1oc9LR9WlcKECE4fq?=
 =?iso-8859-1?Q?Df4yJNE9KF3SBKn06so3EEdvjvbL3fg+RIr1f53YxwMCR418R9xOsGGoiH?=
 =?iso-8859-1?Q?yKoGAtSdONb0wFDniODJ0i2qLqArugFA5AkSARSDTRULISy0r49ITQxk0B?=
 =?iso-8859-1?Q?328aoUf/z3udOdldh9urCg2JT3jmUwunVCvzajdNQxGQjlR1zIKXlo7FtI?=
 =?iso-8859-1?Q?xvgPAOBho7UtTwsdbPFYoK3UC+43UGulbYVapI8I8UOSNjhds/msK8hXg/?=
 =?iso-8859-1?Q?viZiL0VY/owxmy6p++sSsTytUuoxXkfq37BeLv83fIMwceOjvzml5FrXC8?=
 =?iso-8859-1?Q?A1oOrMn6ZYB8gsIlOx0gnxJO+YeBdO1590tX+wHEjRadLf7LIY/H2aeGBJ?=
 =?iso-8859-1?Q?S6H8TmjqcjsawV1Kb569JzAejUJgO/nb8dt0S7KXX037udpqK68FVWSOKk?=
 =?iso-8859-1?Q?QD9JGe+xQ4A12IMP/GuB43o0F+s1/SZWroPK4nq9adLoKdJmyobiDBr7is?=
 =?iso-8859-1?Q?eQXOjxgMN36HS0sfzUboyPEti6M6ZSaebDGh6D+BiJfVgw6zYShLf7vgch?=
 =?iso-8859-1?Q?xKrQz14MkTpvxyGBjW90s74Nxyy0KcFoKmffcD5lVXNetTG6WAPpbfK97C?=
 =?iso-8859-1?Q?Jle+AzzPbDxTLwy5NPCbt15WunwMNgvnXI4+fgjPiGTnihfWrsFXiDLovB?=
 =?iso-8859-1?Q?P6xvVoI3LK1PQCpSlJC0sBgEawt2DKY8wwPgYQr2+TohakjPy0HUNmVpBU?=
 =?iso-8859-1?Q?bXYeCwUqA8PafGo6HMUXFumR7Sx0Fop018reFe3vTkORM9T6+DZiLNYmF9?=
 =?iso-8859-1?Q?PFrXUTG3ooE4XcWqF6O1JNbwR4YJYyAagy2OwUmtodE3ZVuUifzaOaLG7p?=
 =?iso-8859-1?Q?99E9j9CP2AxmM30gnV6H7+dYZLHY8oH8UMe3fiRT/MonuY3KlamPYpwA37?=
 =?iso-8859-1?Q?isUutDNONzMAofmB8cqcYWAwbjk+ZiZHvC4wQmbUp+tfxdpv02MspLahBL?=
 =?iso-8859-1?Q?xtAhzqe65tBc/TpoVebrbchO6iAO5iIHw6O2l/GtN6pwZssOyZbSCX+oYP?=
 =?iso-8859-1?Q?CoBTcTXJF2jAkbKAf8ljM+EkZXlE98g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425104b5-1d86-4555-8fe2-08da16489870
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:58.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vr5JLJ7mZS1tqSCYg91bl0FWuoeaTIaftkDTsJ5rAeX4CJd2etFrXd87IiBLJVf08wqn4otYoPHbRZNaqggBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=862 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: Sa7degHJpOH8VkRyMtrv5M0LyAGdo8oN
X-Proofpoint-GUID: Sa7degHJpOH8VkRyMtrv5M0LyAGdo8oN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a9436a65161a..20e2ae135fb9 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -116,10 +116,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info.dm))
--=20
2.34.1
