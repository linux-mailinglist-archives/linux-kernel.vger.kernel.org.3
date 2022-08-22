Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FB59C228
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiHVPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiHVPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864A3E77B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEiqMM017861;
        Mon, 22 Aug 2022 15:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AWegru4RD8UsUHu/3ba37VZUL5R+lQ0Hg4yDR0NBcEQ=;
 b=hMVpJagQbVGemNCGHBAmcjz9KgLzbtsml29W67NfwufbxHHD4NhrbwsHTe0ROoDB3sbT
 Q0Qf1Ct1gIoVBT7oHHAHY2IXugC/IN4e4lSGfqrLhF+04ii+wjnMtxltsusgwR43aqzs
 viNhw1imTeAwIOBXQr7g5WJ2WBCNnskWYojF4ZOZciUqkGvvsDPsO/ea5lTv/McXNlbb
 aDOF5Jr7EDPVwwBSePKBbDmsucRRRbHLVULg4XMHVDJT4Yr3ME/J5a8LqLFAirXu+FJe
 NnB6GRZ8xue8MVe/3Cz2V+WTW+uxmAtkFEAxzsExvY9pDOcuWhSmqhE2hv/BZTy2n5jS ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nml037786;
        Mon, 22 Aug 2022 15:06:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg3e04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f89ubr9zOGTAmoTij0em50S2ZRoIsg6R1wbP+0y/HSdefRfSRxvcmD9Ym0SyXjDgMMPoUwe0lQMpBUbMtzqWnwYxKGKHru8kvoh4NhkwAxdl6TJiggNNyNxPq1QrhHgKBMWSgy4pYQB0ullOu7z8Ztrb5NScWKKD8qJqRHFakEONfbqojpak22ynRcvZSmBQmAp1s9gBcYYdCw/QjF8pW7UKeI0qtvjE0AlhIJZQabaMsB/FNInNcxpT8aTqd+g9utFXRLCVtSvrPTj8RLfMfnFfkb3/710Cf9v8jjKcFwxNCiz8PPrjZDg97mKX9/d1jtBcseWW3gYK5Y3tYMcvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWegru4RD8UsUHu/3ba37VZUL5R+lQ0Hg4yDR0NBcEQ=;
 b=SUU9PPtn1hGdNW/fIfn+IkG+oxS2pjLBN81GnSt0f7yGxBPwooKhB6W8Q7Nt3aVCjBvad2Mcg+mhfpc+UjFTYKk83v6zYXc6QsdgQUSRRWUqenxu/V44r6li9+PcABVc7QhNH62lSowEgL03ogJNT/HUR7KMg+419dt4HQjfe0bPSnkvXG1ZCVn996VzKuBgx4cbYN+MR1KKUSVkpbhoi/WwACFXqr3TLccWKlCxBRvcd4uWjkZ4CuT5LwxOzVIxXj0PdPZJKTTgUB+fQVOqOsLUZynOp70cdTVvWHvLULjf9SS1ftXeiysuqnGZFxYjMmEvs0xyirIdo7dUdnROBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWegru4RD8UsUHu/3ba37VZUL5R+lQ0Hg4yDR0NBcEQ=;
 b=V8SDlUyQDd+HxCXRVz0RLYb7Ah7hhXYuhdBlPHwBUcQ7erHUSAVyjiXtaDuFY06lJWUV+Df/Ed/5qkbv0V4d4HxddVblXLQg6OqGA3efmKdSl1kQaLPIIPn17mSx0jOBWFxqy2RSja7LjPtuj0QqtNx/OXYRjCv2uV8kNgZZK+Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 55/70] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v13 55/70] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYtjjCegFYAKpn606y6nty+Tl0kQ==
Date:   Mon, 22 Aug 2022 15:06:29 +0000
Message-ID: <20220822150128.1562046-56-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50d4d37b-43de-4672-432b-08da844fe691
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGp2QuEbUQz1qo+jPmlRp2o8PAAnSEhswPdr9JRWs9cXB9QT7Z90XEWxpQk0LAP4P/p/DedzhLOGupjTX59u6HvYYjZ3oUgleT4veejzsGPSVXY+29CUMMLox5EjJEKIrHSF3tE2uAIqh16c6nVzKnVIZEdfCCdTdyAw0DRdFHgxZ9UF95J7F3c5U+Qlm6WKRMpuWY+GgUSl1B2woHhB5B0/3nYy/XP5PqK+XMg/p5mjhTVzFNnawTYPgWsActFXfJDL1zaVO5LhYyPhv5eVTCOpDgzj/IkbEnVyg+D6TtV7VDbCLa9RJIDvp9xgUuiN7i9cst21+VpK+98M0PRPCaDc7rSkZHeWyob/wog7PnhOMeHexWZJYyD0AqKE0de8wg3RurhwwtvomLaszeAh/ZqZigUS+LahcIXXB5Aw9n+ZQw/rg6He4CX3VuAd7VtDAvO9kPLeUkqPxVCX2H4zNutFgihpYpbSKgec1emT2l1+yzetH9iE8h963mjFzpQ07xa1E+sgsHG7gfXuAsD8Uac0bmU/E6wKowUfCP3S43vOfan3D2JPhid5buRz1ge1DOkVaEumsBw+VJKoLZ4zy5G5Z4CNiATljtJeNk2TpEQxY51Sd5fhun0uHQB/39u+I5NvD7BYHobse7n/M0zh/yfqfWK4fjZ/EUFdejfms4otqVuXQgrEAIQSeHla9p1y9bH93M/Klbgbyimsk3JcSN0/EgkTIVtIemfHtJ2OTiVdy3Qrk/t5pU+53O/Z7LbKikLJwl78pAyQVWCRLGyFsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UfOVfiK0BYGY6cV/66gSr6QCOKGZPaHwJ10y8CVrUsB5ILvIrdzpaOABO7?=
 =?iso-8859-1?Q?HJdFPuHjQvNua6bpd4048TUPDE3BrqWhAWdCQ8cWQchcL4o5Kpq8o4P4Lj?=
 =?iso-8859-1?Q?DQC4v8bV2kMZMYFLxE+yaElVuzTOv/+JF5AMFti2pk/crxW9zYNWibvzlj?=
 =?iso-8859-1?Q?Ob8+YHfEC/VKqajq/7+JDBCh8hUupVYQ5fPMl+/wnsypCt7dDvId1pXSBQ?=
 =?iso-8859-1?Q?BYoVfw3WM4V4vXv0srrXDUq1egWrBSEc8G3TnWbRFArkfKgp9kAhixC339?=
 =?iso-8859-1?Q?/9sB73QJ7L05/7h0rUic1mtbRX313rwHik7fcGgUcgxD0oUXzMmH3sEP0s?=
 =?iso-8859-1?Q?pXU8rs/HF3ee/aS/iB8aZY7JSWuBYX9x2+i3UPDUkS1uQtzgPAp94353qB?=
 =?iso-8859-1?Q?Dz3aU0iCSuVlhyJYbEALqzp7rzy8OpNVJORam+A1+ipGVGSi+xYcmq8gmp?=
 =?iso-8859-1?Q?XSgvrqcasepOeLPBvnPLYolKto2Mjx9EVSul7yewLs2PKA083bA05z1aUc?=
 =?iso-8859-1?Q?hmPzX2Bs21Q3Vpw8zt0hTAV87WGY+RdZbCNYuD1sw148BPMAcHw8E4VSQL?=
 =?iso-8859-1?Q?XD3YMKsp1o9ITV1jOsHtr6HZxwAgDzx9/8c+btS78Er4oIWUUfL8l5V9n0?=
 =?iso-8859-1?Q?jMQjTpqOXEdafkTW2Bqj7UlwPZobbAp4PpYcEz3ga6+hY3Bv0zLKZtyPEE?=
 =?iso-8859-1?Q?KG+QOuedCp9UdY5b/0uW533+C1ruNRt8N0Ij7rP4By2fcASh2LtXFiwADO?=
 =?iso-8859-1?Q?AOSDgMsKdaosNXj7QiWiVlOPtHtSyovoh5I4NVdB5HT5lRBFjpqB8jST+S?=
 =?iso-8859-1?Q?xrHwL7Vr+zhkCDyJhuAGgaXh4j6Cj6ul1tjdiJRRZWlb6vzT4LxjhR1HlQ?=
 =?iso-8859-1?Q?ZD8pw1mfN2d8wBTiPn4M+L5RzU0xggRyyNV7Mi2wqPupZTDcfETuSY7Jt5?=
 =?iso-8859-1?Q?zN1hOEMOjRZwiv0A2QUl718qWq2t+YmeLMSpT0921NaE3dplEu1+ZBgDym?=
 =?iso-8859-1?Q?EqYcJsw4DnJswmpkehxBlv6fsvPcZqIbX+80q6IdOz9IK54ju3uYENmAPQ?=
 =?iso-8859-1?Q?RtmOZff6uIUuzldqy5Xjei3B8E9yxzSCd+Ymc9ltafwCFtajD2X6DsTjFo?=
 =?iso-8859-1?Q?eV9Mla94vgfzC7fSif6NY/3NTF0e2f0Tgmxi8lToXbfQTTpNldVgdLM9K+?=
 =?iso-8859-1?Q?C80F046psM6txnJO07OrJQkPYwuK2vu1L7zyz/kOHOJBZ2Fznr1KLUHhHR?=
 =?iso-8859-1?Q?TXR3lFjCsd8K3mJut0fv4L0VQ6Tgjm+rQBS10V9fCF9hx/2yUx/Wu5j0A9?=
 =?iso-8859-1?Q?DF+ICQGzIOQGlhURZLrEy5qq9ElqOOHrI99ZK+519z/uQWZe1YC3ZHq7hE?=
 =?iso-8859-1?Q?vwyIdFVfsnFkyJM/ymbN0XLvX21wVZnm7vZITXU466y1nKEyc3kzxB3uB2?=
 =?iso-8859-1?Q?qRxQxVeK4NtttrIaKqzrYlq01r0fFtf6Fu3WNkMXcQEkkMQ/xxgrNmXJ+N?=
 =?iso-8859-1?Q?DKBOftTNh5c77MGhCddP2KrEpRAtDoDTN4LV/UGRgPriZ2nPwZf9QC+eEK?=
 =?iso-8859-1?Q?OmArdlp6ueGMmu3HNf3V7NmLtxAY/sPMLtBFyg5pXPOFuHRICYUphL4/yz?=
 =?iso-8859-1?Q?ZkN3TpwsomRerrcXNOQ/0VRO/pkzCkWWxEAqx1GuVJjXwSOHpwIHBkqQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d4d37b-43de-4672-432b-08da844fe691
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:29.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD0gZjesSL1l1FgboEUN6XXam0yvkL25/Xg4FD5h7jR0mq9Wxc14fbvvLiWryTz/NFOQXxRi/YBjBXNT6oLa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: TxCAxxMW9nkwg_UBa12Wu2FDcTcR5wRi
X-Proofpoint-GUID: TxCAxxMW9nkwg_UBa12Wu2FDcTcR5wRi
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

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d59c6ff9435..0a6e53eae329 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5874,7 +5874,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6172,9 +6172,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.35.1
