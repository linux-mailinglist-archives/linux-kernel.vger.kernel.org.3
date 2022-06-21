Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB58553C10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354862AbiFUUv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354693AbiFUUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A582B270
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2U9f018663;
        Tue, 21 Jun 2022 20:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hb6BiQoUvF1PfAWb3Foq0KJw8UR9SSn1w42G2mDR74I=;
 b=SjC1eymj3oNKBUg5QT90mM3SGuG3+/cwzRdynyx42GN+T1dsMikR0V4gEfTesGQdtjKu
 /ReoHOzMhyl7A14d192YhnNOjAAqI9lxqSOEX176LIrpLHe3GLRoGSYzPog+Ou+aZsBq
 t+PEAyx1ILfwv6cqWBu7m/qTq5ZXDcsB35mGqiOHKusQwnut0twZelS4W/st9cB9b7jk
 KVlNtt3VNs6zViEZmGzTISVAgoYk1FGTenVTc09AGiamKYQU8Qv05w6Nv/x4XixeswHU
 2spAzrzngchV9fGwr3QDGZE9vdZWgNO4ryQYnQ57E4DPGeR+zz9JmCe0erMcdjaAX7sO lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYM001682;
        Tue, 21 Jun 2022 20:47:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfMSqWTsDwq4G77CLc5gYhciKreCIKrNvluoKaWVuv8bublJjwhXzRSbkWSX7a5l1gmlR79VOiKtkeIiHittEBnA+IXaA4fZQ3Z/EqVZOX6eLopJlFMZp5M/nX3XRWdbEl5k105soYFQLXUZ+lpaho3CJeunjWZ1pKHIt0GpT2T8Uz6FX3twBjE/s71OikZ7AnFr2E4/Rj8zuLu1EjjWtw8dZ0y8AlCOq5bqC7AhTQ/ltxjbqvC7/wlbawPFQ4+muyqmGcbw6eeDq2Bf8LzVzwsuHjJGTcaDAci64us/xtf4IOamgjVLuSGTuRw1LuCiSz+BcjjjVG4LhPwp5x4/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb6BiQoUvF1PfAWb3Foq0KJw8UR9SSn1w42G2mDR74I=;
 b=JEsrZ32QFqBh3G9LifFHpksfoWIfAfsf0af5HbOVj0x//OGdFOCdALNKijTigEVPAG3WUWzVldUemcrjerxkyyo/JZMx7hFbeqAyk2ivUOzFpdM2w/GVyHSFASKialGwfEJAa+eUJns+iISD95djEPTaTsvltw9L1SCPEMgMwp4cDpU4aT31vPlyw5phyKSEtgu90vZdAswQq/5G28TNw1QHX5aRzTrYBsVBMGe2IicFU3GukcWrDvp4Q8ogvJHlpd2Utuy1o6wRXLl8rmNLbTFKfcuHZ7YrAn3iUmHwtPkSQ9iNT4Tdq/H0O77vmshna6T5VZNDWVNP+xF+DF2YKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb6BiQoUvF1PfAWb3Foq0KJw8UR9SSn1w42G2mDR74I=;
 b=leG4c5JL6D8Pdtlo27fRMLRmnBqMsW+qdHt4o8Z/2sFB1hut/7W7EbtDCa3byUBW+wl7UW65MxaMRIBpMHUn3MdvlsbtZ7a8SLPGvQ4gNO/iq+yfk36lgRMwFwLdfoxKKFO0pfFAh1xXU00E75zars0aykSJP65rsSCKt6BfVLs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 50/69] bpf: remove VMA linked list
Thread-Topic: [PATCH v10 50/69] bpf: remove VMA linked list
Thread-Index: AQHYhbATR62Q/2COW0OT7XksoSBRKw==
Date:   Tue, 21 Jun 2022 20:47:09 +0000
Message-ID: <20220621204632.3370049-51-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da87cd77-2c38-418a-8ffb-08da53c74fb9
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB53921B207D351CBAEC7D1F2CFDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h89zgiY8Ne8Vn0fML0FaBaBxv8WD5Vee3Xc0dMsW2u0t32wjHgufirhhTma5k12OJcwrfx6AnuTIm7ldmRM0VE4nTXHWWy3+aNQzaeMA67X0kdXtLSaNwiPQvJRu9vf66ETBdQFT00UnUQsNyAgNpQNRrTWTUn3TrH3ul0DsWnt0HGTO7cVVUfthljmJ70KDK1aey1nwzSp5SKEMEQX+/mhyzoGjnQv0G/6itu+xd1x9tc76CvDJxFy51Vu2VwwBfpuH0kXFQEoiXk2K5dtTXVxNbbVmylLY1onB7VLI6Aj+24Vg6eSC7f3G/ZlOITjGgdeoUfhP6YUJF3ILAT8K2yNqXPxF7zFaKDZ4WS6H2Yl/C1b4JL5zYgTOYQ4+cpZcmwoQAJNkXW+/+52c+BI8Y4YhYtJjJTUQhpWwmD16mfsB6EKP29GB9l6J5l404G/qTdNelrTlIvR3xA3zcl/WYh8Agi51VreIXVhf1syM9dbeQDMSCqv8GpHmRd+r4YyUjTH53J7bT+UR4Th1Gpt9LqSLAqAKHlftpC23/AojljHIZeHBSfYG6hauvtytT6CYLs6dls74irapuPGbRp3AEcu0MsLezEGs6QpvHpaJSWFPB0iMZ5miTaxyv6GZgySMgvqEhPmhQvFu4NZOvppi58U98UG4ABrvq7TqgOSfNcdX9GqKohdE5HVqv28SYpzD2ZijHvSM+hRcG72izi29uG8+ZxW4rhIBSM5zNxzwG01HthBJLkT0bFcmQsdB7LZ5luxjdHsKQ1K5y5KCdwZ7rwP/W71zxl4pQFnZ8TvKplI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FsMtO7Ni6VqQ0t5TaZbxrhkDcKmZ53ITrCwDX03u0Kzp5Nb4CcINaCnOd1?=
 =?iso-8859-1?Q?QHdYXAWanfoO7dYqFHMgQbBcqRchBkuYG8HC60hXNIlk0a7VQVOIJuajA5?=
 =?iso-8859-1?Q?FNWbGDOX4PBPBcJO7VmDydjCdGQd/6JikfnWaRY0jNxR/PNLPLEWxaVh50?=
 =?iso-8859-1?Q?CJ8bB6SRwLQmB8GG3NdYvEiwvUBHbjE2+GrIL3NembhrXiGcoavp3fWeiB?=
 =?iso-8859-1?Q?TkwpSO60yek/ziaoErLzBA1XdB4JTjyeNaVd1JcWxHu/SW8ut00+ECE8Gv?=
 =?iso-8859-1?Q?wV5/WFA8pWXaeelKhW8qfZz1cf1YcGQm2UTb7WlVifZagnrAppxZp9y4TV?=
 =?iso-8859-1?Q?/OrGyr+H7nkttQxJo/iCPSeDajSiCUqH9A9ZF8DF1VUNhdmOPurnArtNfq?=
 =?iso-8859-1?Q?TC3EPAxDeXYMqkWlChgL2FwR6EBhmmbcfMuXAph5v6rNg/CdZlApML/RJ5?=
 =?iso-8859-1?Q?uMI1TvXOVtv3x7iQwMBSuT3PqJmMw1OCPJYeSC0vLLBMKT3/AIjnTl7kQU?=
 =?iso-8859-1?Q?YAAoH+69l/uWF1i7McG1NsVbSW8EcTOZRo5vxj5Z8MZMrv4FYgQAT4gZfO?=
 =?iso-8859-1?Q?4gxlDLFf3bvOepOUsmaXX4lbnWkb8xEZyVEItyrmf0ZcgN4oyucF9fBLGB?=
 =?iso-8859-1?Q?9pgwmD+ViGE8umQhDTbAFwfIl2CqVU9LaNjNfiPvKPp/zfHoe2ev6WqZ1A?=
 =?iso-8859-1?Q?BWRMS0hvip37/jg7D6lVIK42RuNG+ASVdgWsDujv7pxhnWAFhY99EoDA8e?=
 =?iso-8859-1?Q?dApIqPIsOOw3igKI5cuVhZd7IjSfkKrlglywWPUkQ+6dwh1pEwDf2mRpSN?=
 =?iso-8859-1?Q?yMB/LqNoVLMNGIOVV1Ewek3JcCz/S1C6ySx/kSIVnoB4u24d5ie/xy4VeJ?=
 =?iso-8859-1?Q?sDeC0RzPLsG1sDUO4xLyZ9POk7v+PyNK8kFlevatcNV1hph3LseJV8axRv?=
 =?iso-8859-1?Q?EI5IZK4oDko8g1wKqqnC7mZh5VtIc1jax6lN3u8/0XLAYXz8pI4MKBlBte?=
 =?iso-8859-1?Q?PmxIt/gZhUwRIB/+etbl7HaLNZty5yY68BurWJqemq8t2R8qBZFNRAGiGT?=
 =?iso-8859-1?Q?jvOuqykugv7meFhm4YNLb9wgfOSo7HBjYv8i31IFWrHzRb0rYZtMsJGuBb?=
 =?iso-8859-1?Q?ZVcwqmHDo7BfngyJ4y1ZInmVnuCAD6HA7ntkJqNW7DNt9PYadQ7jNNV7jE?=
 =?iso-8859-1?Q?C2um/SL+Pu8FT5+QtBnFR0HPEXZ+gZI+yxHDclQV9iQzI4GYCp7QbGrobw?=
 =?iso-8859-1?Q?zrUk/ANZt8YVH1Mmvsqms77qqTtKRRh6UF9odM/LuARUSkdsjdosi21wwo?=
 =?iso-8859-1?Q?fpqwD3W0AfuwJ3UNX9mKK4HiDQ5Rni8MghWw9w21Y96zU6JfvMInMYE1QB?=
 =?iso-8859-1?Q?H14iFxOsXtcStsTId/se4dAY2bUlh7HM2IXTg781X6zjW6HeYe9YqT2qpp?=
 =?iso-8859-1?Q?SfusfI5ocmJmLgxGJeqyDbEZUtuJJbD3h4hZiRMpjkw0/lStOMQt5qFL/3?=
 =?iso-8859-1?Q?4LMV3Dy+YcFZF/2NghO39LAk3Sa/b7Q5JDqqQHe6kbpkk7pftyaOJQoRxG?=
 =?iso-8859-1?Q?hqK+umxihSDxdT20kE8LIusFJWodQ/YtJbzjMq8Je/RAULJ+zxwlP/u6cz?=
 =?iso-8859-1?Q?upU+TJxg1miwJGv/4ZaUOq+Xf8Om+oj0epj5kT9wHJFLA3ePhfvXxbGXnz?=
 =?iso-8859-1?Q?DT0MX1/krMgwOwoMT3tl5zvnrGIGAAVkCTPm62IUP+R0hYFZgABKgW4eya?=
 =?iso-8859-1?Q?pmO76Vf5Ls0Ty+vyuB8RS69dhCTDeLQ2gNSIQ5epNLlMfEtFwmFQON7ZLv?=
 =?iso-8859-1?Q?Ev9r/xm1y+s8C38r4KlqP0Mas2NK3Xg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da87cd77-2c38-418a-8ffb-08da53c74fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:09.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIPgGPFRvdwUPgd/urecATlMX9zkChlp974bh130oaYQEqwjVgMsG6jtaI89T9U2EN5pL5Exe4VGgyo5c7qXgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: 8iXB4D9ZFR_1wKxKyGSPWNkodoj1w5gV
X-Proofpoint-GUID: 8iXB4D9ZFR_1wKxKyGSPWNkodoj1w5gV
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

Use vma_next() and remove reference to the start of the linked list

Link: https://lkml.kernel.org/r/20220504011345.662299-35-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..1c8debd42dc9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.35.1
