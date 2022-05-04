Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF837519364
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiEDBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbiEDBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3404143482
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LNHVA032436;
        Wed, 4 May 2022 01:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=VZRrkT6TbkcCxb4Ey82UjA92FS8b/Pjc2lTNl/G73Js+Q7A2vWSu9Jnm3s4RkhAB2GVG
 iSFM4F0LM3KZQW4OEc6PvXKmYEK5DXK98Sm8Yn6na2aehq6RMKF2YvB3hp+B6+Qig4dd
 NdCy/wywMkOoYuI/UJPOUBT3j9z4jUYPZZXjqClEc6QHpOzErjs6tBwChSVfk6Hhg8d8
 rtFfpfX97BGdn96LXIVCcoqd/cw3dyurp8c75+tPP5JDzmeTxDaKHOuZPU4cPyJhI9DB
 iR4DQm9XLnGs1sCzmzPfTVgJMsJjfLDP2NAaO35oDJCPFG8RXkRIw618zLLltH6G2zuq Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apy06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AxHt004437;
        Wed, 4 May 2022 01:13:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2w67b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyajvSUBEq9cwHbssjeV0zcmOCa5w2rNpYLI5ujSWiZC2kvdCKGCB+cLCBv+F1XOUFJTTTARf5fYwTMMEyLLdxKf6nGuqbXHyOJITVI27+hi/5wV/NN/fscI6ZI22F2151rp4DmumdKtASCu9kskxbO74d13y4fezOuCO2lQDIE+cQ31p4/M52jqtsb3JuYycg/gHvoMrsUg8Xhd8+la4tsXiTruGZo2gr4mfX2iZ5i9Vow3wlvykFQpGC7NxG9gKmhQbAFLEiDxZ1OCJgQiyOepcUBdo+xSQqWgA3vzSGncqTC7jjxFgl8vGypuuyZ2F/k+CQbeRkmZA/QrDDR12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=Dvy0ZkW2IGq7X3mpae1WevfZjowauUDd2yie5dzPraJ/tV4XzpDpuRFGuP5kixOYhp7EER7fspRCZA6QND/D522d42J1j63TrKmJjbJ9WSHDw9YDWcZMu5JX8eugMl0e0mSOLQd3YehdFmzGhA1DpIY3a5NvuU2xAskbRr77jTnpFqup3ZFjGvVt053KvqvlbvHJklLmi14s4efyXuVauRQBK1PjmJH9V9Ix6oCa4CtwgypjhUI1DmMEzXedN5iUI1vimB2mkuEI/SOQ7pPQQT2KenhFPPjg7ecNnVJzV58cnYVw8cYkwpwTHlLf4XI3moTLPJ3fSRbSo+JmMaYJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=RbxZVBA6KCOSIhklMXQCnW2atfOhlv/VV849Y2bWF6VoiuoIqyfCtn6UCgjhJhu7HI49zE5agQv1nIsrWt9SLuG4L811cQiZ9k+e9m6HJ6+7q2wzLOTE6MPnbONYTxR+gH1JyOx/nisKLdhSfor95rwpPvksN2MftruLps0jGFA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 30/69] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v9 30/69] arm64: remove mmap linked list from vdso
Thread-Index: AQHYX1Q4ePOHF/wexUWm6oVPPcfXGw==
Date:   Wed, 4 May 2022 01:13:54 +0000
Message-ID: <20220504011345.662299-15-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dee968d-8c57-4bf9-12a5-08da2d6b5bba
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB583054B0DD15C20697C8B296FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WnN3fdjNB/jGmXBHRadkyb+Ui7nMmM3u+oIU4hF+XnlmJ58qEM902H5EOofAgb/XJr9n3AEA7Mpb97gCkF8ItVyVCg9lneqkk3q/2gKaKSDdrG6TPNfUGvCWtWHveTdlbNRmnWzccdcVAihOMgeg93cxx4GGN+6Qx9odZTBt9BTDo4w7UiCF+KBPuLYNKXMjaoMrfSEhKysOf6pLlB72D/4hxHbdIfYEWehnZoieC80Eh9IbGPoAfUyBdcVwxQUQArqkjuOP3EPAvY/t2veGMtYfqG9Rkck4p/8rQZXNa3I8BUDL2aM3imUN0MGMcen73NmQN5GI4ywodKOKLaYBdBhMslM8vrtguAeaOwLsWw0w96Jcy/lNsPZ/BCqm30q0QfkOJgnEpyvU4ucO2/glvFJ7ms0ad0XwL3SUfhvHNv17yG7iCC/zLbYk9yKNVgVdTLHmQdMcHWJbXTim7DjtcjUgHSZTs/EQNjwqSkpSLKs7CM+GKlpyNii+r0XfJyeSrAtD8Da/5rQqbgRvyUp+WxxW6cpdIhdNJhXP35HVid2bCsUOHdOP6SKivE1xDgVesj5VQajAkif5Of748BrM9uXidNUN6uwtvdMD79trSP9NsXji8NjW8LEIMLI1YKpi9/xi2WuSmRsADmlJcnEThAWbZhb+qoDuDePmrafaQtesteLvFAaPjTleN+8iYCjw91H6klknmHbtt8KnBmQzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(4744005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lBUUDDUU1H+hB/lmNGdwk6get3xwglPE4qv+CM3JbzuQB+aLCN9PXWAIiK?=
 =?iso-8859-1?Q?SFQMMyYHLnxi7AOeUqdwY0LJyulhOKqwr7Hy9OJFHhFncwq0OnbBCOTEbA?=
 =?iso-8859-1?Q?gtavUTPexd0kZ7fO3MYNBQDrWAboXEDewu58VMyEUHg8hmFbJmNdH/o6V2?=
 =?iso-8859-1?Q?sQZbl7x9dWchp0LkwkdayOq5M5oYaRCRa8UeOZH/NJfKikV3TttW4ceCUY?=
 =?iso-8859-1?Q?KxEVBuVk8QDx68UQZZp7OoCNQE9Xv9vEfHUzYQNBPhXychrDYIMkvdpN2F?=
 =?iso-8859-1?Q?faNSX1oRcfgX3LNcwjQkC8KHFfSdZe9ykb/WovlcC4/xWDrc2RKWZvy/qg?=
 =?iso-8859-1?Q?fOGRXORL6TcJBVBdOsR2K1deIMDk2X9mFVfGpx6fob02dAJCeiEyZaJJdA?=
 =?iso-8859-1?Q?apADtiu8VA7KIUttumBrigZWthxnBbUuF7muQemuiHNlCMPj324/BU7F4o?=
 =?iso-8859-1?Q?DgxadzbVjk9zZRJU6G4qWJjMlfuqrT3l84KL6y8nl5DcSsgnREIfuEJr/L?=
 =?iso-8859-1?Q?yiYMW9475xtwYmgTi6GwGprdms/Y6FIlSWJ9Uk/GZ33XN0lJXn5WoBelIv?=
 =?iso-8859-1?Q?WrRHlkQkpkpel5kKbKJlovMEWhaA2Kq40ZoZNyrp67VZujT9xC1p7+DszA?=
 =?iso-8859-1?Q?7RRX7bJcDpVpoNYFvYxJrfEvXkYasAhYS6e9/CWNi+CeUaNGkFDX6AKxm/?=
 =?iso-8859-1?Q?EEV7esTlrCBFrc0+sLaC275d1b/PjsEVE2rFZ6RJET7Dmj5drj8G9RZ0bt?=
 =?iso-8859-1?Q?VxG7AEBXPqRbGKlobPrDgTY3kNW/KAVxIpA9TO7o9+Zwd77gV2iTFAKhlj?=
 =?iso-8859-1?Q?FWN+X7mY3hHWU4CAXN0KFCeGZUSBjqFbuz74dZYj8zDKj+42GTC5hhMIpF?=
 =?iso-8859-1?Q?0bY8MRaXsSibgfBrKRrDuuXzFr8Uwu7RvvW9EJRkIBEvH+OJwS5Mx4qrbn?=
 =?iso-8859-1?Q?YAfxRUqQsGD0Iyj2kzYnPuHIq5PNxh0T55oQUDpvcqWqdI5Agc5j44BH0F?=
 =?iso-8859-1?Q?nC16Sk+g+ilMDA0w/hIGD/sCvLhuIn3pU0ZtZADUoVO1eLGRlOwCdwiIEC?=
 =?iso-8859-1?Q?fyv5/tnAqblG4bYoZYNkEWhxAhzv8nUL+2bSidDc+jSYbaq/xpwvURCxP4?=
 =?iso-8859-1?Q?LH2oiiIiN7VtEk+J96PGP2zygIcv5IXbFq1uMc4JPAVyuKTmDBLIKQBK6/?=
 =?iso-8859-1?Q?zwfdMQQhWUcSjMmZYVAJ+g86QaXzPNfrrzGpKfl7Y3zIEbMwId8uHS6Aby?=
 =?iso-8859-1?Q?EN5daRzpupKImzEisx5fBM1gh9HGcOYXKVkVr+Uh4y+lkhAqWqo6h9Gx49?=
 =?iso-8859-1?Q?YnlEQsAUysGuXG2AsBGgN/c9PdaWCMOivRg9LaZuTPzwliO7ZTMPjuhiPe?=
 =?iso-8859-1?Q?iyw/4VVCZo4joUiax5QtC4zB9yeJxMJwPfSdCO8/emesR/AVTc8YvKVSWN?=
 =?iso-8859-1?Q?mtG5kjKMSRe3Hgb/okaXICcYnAOLcnfmtbB7dK2LB8yg1quhvfh7cic5R+?=
 =?iso-8859-1?Q?fvuWCV20HuC44UL3dFHCbKBftqf5vJDXcSVjkRZCZl5rWr1lZxsRdVIgXY?=
 =?iso-8859-1?Q?LROAgR5TG+2TLqnFQsBzO5csyFZD2PfiZN6w1G6SBOL7f6yj9MqVPm1R0r?=
 =?iso-8859-1?Q?bKXvhB5eHt3jeV2pUNer6wlwtZOl5ubKGtFUvxL/uff/Kn4SYBL93QrZ8Z?=
 =?iso-8859-1?Q?M8O2upPKExkZqymPNPGkQo04QphuEnAJX4TvWB7SGJUcg0Eq16ZJIhGBmZ?=
 =?iso-8859-1?Q?bXNbMef8wRHbR83Vs09o40Pu6OofTc5odxy5jEetGFN+SYHP5Y6sqqx8Am?=
 =?iso-8859-1?Q?8+C0J+WY9m6qqm3pzSxJpdGs7bPz6i4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dee968d-8c57-4bf9-12a5-08da2d6b5bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:54.5643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QURAEWAxQlQfqAKCYb4tpZQzkQKYmjgIEB2FWGNZIMRBSz/Qjn83Kdfw1KAC8NEGzepPfXyi56TT42JAFS6z0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: -EC-ZhsJZJWJtXHct2trkUjfurDI2XQy
X-Proofpoint-ORIG-GUID: -EC-ZhsJZJWJtXHct2trkUjfurDI2XQy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
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
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.35.1
