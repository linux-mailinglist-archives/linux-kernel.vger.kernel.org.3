Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF659C250
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiHVPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiHVPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BB3FA2E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MF6d30003978;
        Mon, 22 Aug 2022 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JO0r4e49SL8yNFbYSGnYxG4voDOEPt8M/5smtkbbnSI=;
 b=xgxw9d0PuU8d+UxX96M98gE6uMNXHHvtQE5tEXZHiCFBxIv59JwnAk7biK46M/LGI3Uc
 ZCHzmUoL8QQkcyYQkYM+ykQMH5b49zU37POKREGhfrwOb1BkVnY77BVYrnU+z7KebZEx
 D9ZAKpcLBxGH7GYPlsPktwWNUxhbFgOrjv033C3CDJFjqWRnlU3nnndlbXPqqfw+WwkX
 3dIHTesQbtVGWN0TpXqnrlOyovIcgg5aHAeSPfdqjNKSG6Qp6FjGjLU1nsPYq3WsD65F
 zuzEG86rPM6sFKEZ84AgUoNodp9+MiQ4U5vhaVb7Ibgx2Z7iBlk+MxcxDY+ANumAFEm5 YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4c56805x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4MWo035318;
        Mon, 22 Aug 2022 15:07:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u2en-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiWh73Gg03r9aV1W3M9fKJktjZ4jZStPr9KIKm33fb5efpbKxgnwSzUvQJCg5aYuczsZq0g6ps1/65rFgtJzJrNB2aHyuCjOkQAefVlR7MNZYJgNOA5YewmCnpinoeq3JfrvqmZqoeCTfyA5YytwaWiGmO2hbHauvAKub0340d6Z4vwsSOjYCUl+YUq0vrKDqrHEGDFVDfjZAp2TPLgsmj0aT7QWZne9WLWGfeM5a+2BTGe10YS2TorLv7bEOwdJxeAEvXKNlneTBdKACW+xNgB4sbMG6bDySqPYD+QB2HQAwFj+2j0y3HWwC9QB6ynAgtRcKKfffT5cBJTpM9rq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO0r4e49SL8yNFbYSGnYxG4voDOEPt8M/5smtkbbnSI=;
 b=OztlCP8FeKZU7BA7NivjBEhoc8zMhtw3n1jFl/Z86bh5Q7l1lcOmdJ7Cs95lbpM68++BhbOgHbu8ZATldLcgLpeqiicjLBMmwqmjChX7ddsk4zJ8Is8hUdmEHzi2HM5y6gZkwzBTdP1/JFNLG0dVhU85uiA7Zu0C4KEBNDF4SJeQ3B8JHlEsqcq5iHYzxshrbZyMYNk5fL55eN7bss+SVHgagG3e/5do+BX6S1R6X2Us1t5r7yJl3Wp4xIXKaeq1oSCl5L6ebTcLaNRoaI8gY8I9fbWLm5TDNasJepQrHqq0sWeroxfaPFeCYxuqpQi/LuyCjxre38lxzekz+WVxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO0r4e49SL8yNFbYSGnYxG4voDOEPt8M/5smtkbbnSI=;
 b=FKVb52A95sVFNCaw+gGXvNDcdlYVwb/S4JnKSi1goD6hTPLyziMHyTUTb6lkNCXv/QSrSVJ+9YRazB55tTbwdPcoc7rEX0kUAixo2nJ4l6DPgBPz0opKEq7euBwRuF5ghrhK85gI7mKkGNVI8xYcVUaPz25Gtj4ZghVnKjdCDHc=
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
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 66/70] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v13 66/70] riscv: use vma iterator for vdso
Thread-Index: AQHYtjjExIWGxKdyRkid9G3IbelM3Q==
Date:   Mon, 22 Aug 2022 15:06:33 +0000
Message-ID: <20220822150128.1562046-67-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb85cc26-9ebe-4922-6266-08da844ffbf5
x-ms-traffictypediagnostic: SJ0PR10MB4512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7I84OYekqQZF8WLs7xmH1k0RCRHLgPE26XqEYa0C+9tL2FJhB4LougnwocC32QOFb/pTtFlbdL/BraSaXDC/1NZdBjv3T5aqtDu31vzSpCdtTEiH1cTts2i77TADgWXoqsl6X3Xa9D6QYQn4ulV7iDEKXJ0qoVhray/yii5uF1o2RaS94TCbw2SCCO1WWtrYiH9+JV+f6c9zR5gK8bXYW7Tt2BtUameF9QswqSng9m9z577WpZw8Ua5cyQHx2LFUNUNwaV9f+opj8w2nmq/Avn0KzkkmWZa5D2fdvdY02D0Ug+ExTkEjl3sfu2gGW0zQ3qD3JYFOjWitlmje1oc4WuGQCRb2otzOXSvdicRXqDO0wTEjmh9Z+7WIRjJq52jp7XQFNKV/5mJDtE25ZWqcpOjH215ja8kB99vVDGtrGS2G4zzuiILU/rrRPgm3v63ULp+I/SMxpGH9vgpFjLyLD1DHdz5knZ46qrKWlMi8b5sUYYF2nf7W69nZeuH0tmy/4P9DlLA4PkYWpyyBr9izaBzeZq83J0hg06nVwnAjg8D7n/NY4Np+IHyyoJLfWXR+O+IMx4SfZsuPGbV1BVQ5Z6ZcR4EK9YMF77UW2oxkvpWHDcI//KZyHrFEuk/8UkVa4xaJaC8dOmTpUu7VfZ48nyky9BS59Cc3FXpWsX+Am2wPvdSbOxhsgfHDSxCYGdqD6KGYeRwZr9pi8Ribx0I0DLIO3GJC6Z3GMKQBnWmOouXJ/D8jrzhvyVhJon5humQoqCtstGbhvX+hhcb7vMjvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(38100700002)(86362001)(38070700005)(478600001)(6486002)(186003)(41300700001)(1076003)(2616005)(107886003)(6666004)(26005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(8936002)(4744005)(122000001)(44832011)(4326008)(54906003)(110136005)(91956017)(316002)(76116006)(8676002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IXGu0IIcYGDBQPzGXVH/ohAo27M5Bme1t7dZcNZE00fhleo+JLqS6B2o+u?=
 =?iso-8859-1?Q?hRTaQ3glWpfAroNARBb/MI7WVP5eKsR/S593IJglxdpumi1SX3eMR0Y6b3?=
 =?iso-8859-1?Q?F+moBqnJ+m7lZqSJwbP1VnQB9OaWRIlDpv0vxTF9xsAkOGIwFzp1MB/fkx?=
 =?iso-8859-1?Q?hsNeWNn/6fZoeUJgIdwf5Jmbmol6eRPP+bkBZ0AZrx6UdGl/hP2oZrSGbM?=
 =?iso-8859-1?Q?q0/ARIH2jbbW4PUenjzV5gWhdPxny19fj7fJ7f4hRJbfQwuyNMseBPgZgh?=
 =?iso-8859-1?Q?X+i/wR2i4D4B83u8p0ky12jSuMELcRpv4ZgV+hqLcXa8EPlny6nisec+2a?=
 =?iso-8859-1?Q?eBB26wLR7STb0ojjZQUsK93SAWawvCbUXqZdURLGA/d0bv5JJkDowDs7Q+?=
 =?iso-8859-1?Q?9MoLVqn88DkI9ap0zsIm3pYZLz9RU4/1eZcYiJEWiy6fByASXfEf9Aywhr?=
 =?iso-8859-1?Q?1Oj/xm6C/oW5DOC2J6B4JYPIBnixkduQmL4lKDKATUNn+ZzzI27WBnAaE2?=
 =?iso-8859-1?Q?lQt3UdgLDOn3zWz7hxtkA2unYr79nNm1TECyFANLElQWFHkiccXVt0FbFx?=
 =?iso-8859-1?Q?Z7k9Zmy7c0ThpGDYcrh3zjiFNjLdVy7gQhEB4Oy6gU0TAKFlIlBEdYqSXC?=
 =?iso-8859-1?Q?2sU4e4axqBnfW8k6isWW6DlEZjLQ9v+kZUwv9UOgSMtJmdu6NT2uKIHnnX?=
 =?iso-8859-1?Q?JxLMJ8JYenn2z2hVPzjHTZ7wU3UrdnW9rV3XrfKyMzXoO28SSeC4Kww9rl?=
 =?iso-8859-1?Q?JwrTSj7X99sAcQY38LLFvqqGLvINo7JrKmMnl/CUBmB0S0qoGJOXTH8IH+?=
 =?iso-8859-1?Q?N4QJLcdDs5jvkPJ//pQcM7EHJoes1cxYFJ5gZMgvrrA2U+w/6i/1TBRxAN?=
 =?iso-8859-1?Q?K4n3ajlq+yQHz7lsGEQruEzfwQ3OgA44edEtWwFw7tIO8jENk+HfagJN7Q?=
 =?iso-8859-1?Q?IQ1d+bgZ+jgUDXuyVOnJndvB95fgYGKNCCFtx9Km8cojPqMUQsSV/pLNwo?=
 =?iso-8859-1?Q?5kenPYloFfN/xcvaebKwNk9fLwNeZGEdlqDlF9weFSspOq5/l6epkLkLQM?=
 =?iso-8859-1?Q?9fg4Ac0r0sunCNUtTsdZ/DfXnOtQCkn6lZ+CHZLIAYWzAZDhk56PG4E4Nl?=
 =?iso-8859-1?Q?CA2FnuFXu6ELY8waK1B6w1vV6FHwJ+UHd/950e9RtSPjRTDSawYQnPw217?=
 =?iso-8859-1?Q?yMoJPsZn142AyVftz/RO2MllmUekC5sHNHjTFBpZNIjwOUSlRi3isqotFj?=
 =?iso-8859-1?Q?/DevqUyJPCINCEQpCt8AzJlBcbo3XmN9UfGTY/61HstRGapHRyfl7ZdHZV?=
 =?iso-8859-1?Q?W8QFo6ELTDajP7TfqesUSWHXq8di5YqoZvqZlAZKtR710OIUmnsolTRFd6?=
 =?iso-8859-1?Q?AiyU59CF+SSW2KqeUVA/Lz82gESfNNxHebsjUal/PJCEhn6QDs96SjlQSb?=
 =?iso-8859-1?Q?HmqcQEIvHUVCu6z8FP1cJgbyC08RHBDzsiLTl6gmWQ+OwJUi539Swajg7v?=
 =?iso-8859-1?Q?e/+IW5s130j+WjwqlS0cvFokPNXBnSJIiQYJtU6bEIO/mMea8DCENuSpKC?=
 =?iso-8859-1?Q?dfR5HxB9wwSb5gEzmk2/Nk1w68/t+kiHNc7FoN3EKG0dNOX3VKOkWP/FIf?=
 =?iso-8859-1?Q?qcyGHN31ef2jgGppud9lR01cLz3OeZWe3ufgzYNatL2DObjBLuhL9u7A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb85cc26-9ebe-4922-6266-08da844ffbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:33.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgoDCgBYY9rbjBS2o86yIxJIfY1CZJCc3L+8/xLADmjKeVLhIzaaqIRKSz01MkUAFS6VWiq/6VmVtfXpPAdEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=988 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: EAhsP2HFH7rHYJII20OI37FjwnzZhDor
X-Proofpoint-GUID: EAhsP2HFH7rHYJII20OI37FjwnzZhDor
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

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 69b05b6c181b..692e7ae3dcb8 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -114,11 +114,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct __vdso_info *vdso_info =3D mm->context.vdso_info;
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info->dm))
--=20
2.35.1
