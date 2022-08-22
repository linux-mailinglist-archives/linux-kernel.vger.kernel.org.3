Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE959C23C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiHVPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiHVPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4B3AE53
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkUsA022008;
        Mon, 22 Aug 2022 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=j4OXzP9sc8L56IR02p652+sfDEGFsbR52+i407wH1e4=;
 b=FNLJaw8h0g7UYruH5/hddOBLiUS7s9clwUSKf5KW1uDcL5vRASknK3wYghybzmtVCkL/
 1vUYQx+q6TxAz3ZhboOF8ENSGLSYDiHInYGQ3FEY/6UJOoOWppJMG2uUuiWcHsFlnH/g
 3bOrQzbUSS/O9uA7zwgsKUUAm8LTqRaSby7UavSxrqS4Txh+3MZndn91tMF7ZUV3nRJR
 njd+pWdW9/eTyF7g4bYdsbl+Mfmtat4yGVO/dHq3lS6qkt8Xe2573ijcS05zrwU0JQey
 CD9BCYPN/TTntdagZyZi+caJ9XDn6aqZu1/fVeYOUzwFjUea1B6vp/j4YY8KZqScgTMT 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OWk037856;
        Mon, 22 Aug 2022 15:05:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg3bsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6bw12PLc+dP9WYWzDJoRaBnqboWCqFnCDPf167ly6BG/h5AcxhjxYMZaSMmSwZFmIXSYvHpgt/u7qXQIc4SU+/pV3AjXJlahyAovZ8/jGGMWqdRp9YyIg1x4xf8FPo6TUaGbR9Z0pnDvA37txxfHcOR48A4vssGihpSXu94EpAKitzSSlxx4WDv/oBm+IbXV0ArZDufJaeAKROHHdeusShax5PLvgdWewGYpIZMBGYzg9+DKE7N4onfoakQBfxtYQ4+pHZBD+s7mqdC0EkER3cu99j/G0pdPOSXJNUkWsP0d7G79KvJydCIXDtNxGLRuSRGWergPNx/gTFi9G1Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4OXzP9sc8L56IR02p652+sfDEGFsbR52+i407wH1e4=;
 b=VQDj9KlnBSXYVMGWikoS9eP9x3CGbLA3Ajm/Meh9xFrRT9aAqHlkqMYyGeCVhf/hXgWzzGMUqonzJF4gLqMzlY/rYt2MFa6FPhSYrHDzAaYASEed3oPaGlDkLFLVkYBmLuzRQJ4zMTUgViDkV7cenO1w5rfltd8zsktXRu+/UWCAeWcnD4wH9qCXLiCS+BxHAkFIzBkoL5ghz49G/K+hrGAZ9K/Vm2gvjhH3D8qRb8Ny9yYqPwIkS7+j67EWnFrexKrHd9tnKw9Ehgdl+hmKp2XyrGRl+jVXJp/MYUP8VrKoVsqfFQwhBT8Y2FpwdaY3GlO1iqaUueWAHJFLyv4DYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4OXzP9sc8L56IR02p652+sfDEGFsbR52+i407wH1e4=;
 b=EPi4u/3vCI/dVRqzDWUG8uthzgljyglFOZetFGdq5M5aONnqii6u5wjMEA99twFwEjUTesBZQOn1z18JbRBLwC2yCTNdmN4Q+vQxuTWCbZSA37GWCtxuiPlTDB9za88WoRgoyQnhJ/1bIm3ivMY+mzSaYyxfKD2Mofs1oWHcm2g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 29/70] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v13 29/70] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYtjiY0RrMXyi95kGAebmwEfmmAg==
Date:   Mon, 22 Aug 2022 15:05:19 +0000
Message-ID: <20220822150128.1562046-30-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 907e69cc-563e-42db-40b2-08da844fba9a
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaoxIlQC+bY9fX43q/vOZgtXX/EB43YFxX8O3QhGmcbDrjEEL4bI0zopByE6S/9g4rGfYKYxVqLKDnCbBP1HWXR1KdwRzsG4eHjII6CIR8GSEtDfJbN415BBlykkxt6Q1AcDAamIHg6u3WcILHKW1gXPlLf4ZTPUeXFX8YAQHRO+LSyOO2hyxVGYZQ4gjlPdJHb8qCbH89MQRNzNkGJUqUUTuSJthiMzR+/PbdGOwPh8Q4WVQQJomSe/Abomdd766y0P5ZGP5E33KIxP6Xi9xRtnrCZ4HCNCfUJ2lC6UwfRv/9vYFN3w1ET+ffo+OqS68NQ3A+Ug6K3AdYjy8Ddo1XcAcaqZhy/a6KTLW+94Nxv+YAe5wGq0e8Vll1Sr07dqtpscXoFtXyThBZfpEJTjXRbMibKvNDvMjDWJjDzgPt7Al0mfITCTYmVLWMTJeEUMlRZroumiMKIEuPq9NISK33u9nCyffE5bVRUBMoSqkgJDF9TZXaPDZP+uenSaqcEn6cwz7NsUt1LKiG6DHO4NftAh8ls7VUbp6xLsM3JG4omuIJMZAGp8vt0rPD1VamECrhVvcGd9TfJTnD9bebATasCaMnA6byqA4P5vp94B2ZtxraqWQXF3sQxREvXY72qBT/ph5+fr/+yK29NB7MwNy/jUcGbQ/1T6o75i/6AZhfESODclV2QHgirNL97nA5cSa0Qg9PmupS8ug5Yc+zMuqDLYpAo3Bo2rxCKT367ntG5iigp3QqpuF6jJ8ENf1RRGTTetI03Okln6OJhVhN/PTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(107886003)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(4744005)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kAtw7NiW0+pqPuFSIDe/9WVSAxpFq/3IQSnHJupypCLq6lFo1531lV2VAV?=
 =?iso-8859-1?Q?CLD37Gd4+m8SYi4jHVOsUqWCFJXbiBXSjEuQXitlVg3I0Gi17SHsq8jM+v?=
 =?iso-8859-1?Q?NuX/P9V7e5DrW0HQgDcukvB2Vagyqv69j/rI5VKQSdlbggwvu/fIEX834P?=
 =?iso-8859-1?Q?nq++vJ5b5aydQUr/jpLFtELjPuhy7ioCKJQAqsdtDUh7mRnq2vKXENKgY2?=
 =?iso-8859-1?Q?sncPvjgBWkGHNLQJdTkFftDJTdNtg+YjJWjfAcOP61N/4F4nKOkh4kD0WZ?=
 =?iso-8859-1?Q?SwpKXHYpf7ukPpEBKojhBdPIEgthIZA90WZmzAk6g8WRx84OwZq/W96j9c?=
 =?iso-8859-1?Q?nV8tMH/rvqR2ewsjFiFtrbQyKiZj4sEfMR9eUmBCh8TA7Ui4o4qQwX7O/B?=
 =?iso-8859-1?Q?1I6p7t0pw9Biv3uP9B/A6dm95TIbAsw+eDBA/D3qSu9Og27xi0pdWAqhi6?=
 =?iso-8859-1?Q?og0qWXSRaUy2KweuPR3AnZazR+i6vNrQE5F9B9eOgBeuHErix0tZC2UANr?=
 =?iso-8859-1?Q?lMvtDZjnafVqz7vhTEcBEr1gvpUVh/JQDll5CETbUBMwA2si+XhRQM2GYK?=
 =?iso-8859-1?Q?yZlawRepudkbEhhNYXyUBrlka6aJA8dMdInIdIUXyrBS0GXXiPHXCHfu9d?=
 =?iso-8859-1?Q?YXXfEHQxP2T8uA/g8vDcvCj4jcBMAF7Lah4Z00IrmGkHUGKzpw4UofbwUa?=
 =?iso-8859-1?Q?w3yJbmO3YahtBwcdQ4/oDNmIyNVidXzois/idse2U8+eSwSeJM/tlttf5V?=
 =?iso-8859-1?Q?wroThE1MzChuOHgs4+/YvKGrmTFdRQnDBkzq2hl19hns92op3z+bj6V4zK?=
 =?iso-8859-1?Q?qK49HEqB1+tqZbQfCFZffJiJh8GsBwzWO3ClF91MFmIXgEcLTLEs+oLnqh?=
 =?iso-8859-1?Q?WazZd5KF//OntfwZFE834UDKIhL2mtOsn9zC7aUI+BwQleLHNtOULhJ2+K?=
 =?iso-8859-1?Q?j+sL46g7wZMxCq6e8cB8rK2SZAu8TLGyNiix2h3MsJ/4WjUzEsBBmPIdyW?=
 =?iso-8859-1?Q?eELXiL6DWdXKmwyVHHrnr/SLKcF+CxD6mBo3BIC3gKUeqRaPSIXEwIdvb8?=
 =?iso-8859-1?Q?/5ubRvZ/l2B0KbzgPRCtpV9i1ZqnV7vXDIeY0W6YhVFyxOBnGUqdB0rgGc?=
 =?iso-8859-1?Q?D6CSq8CxaYM7yTFM0xPqsfoioFxrYgWBETN+hSOpQUwDFQNWuSBbHY3vbS?=
 =?iso-8859-1?Q?fYiIDWu4DW6lL7U2c3raZxO5nvgCo3JHtuNryNZZtp8C+yDiHQ694Et33V?=
 =?iso-8859-1?Q?P0H3I33/23t65+4RtzINm0NkHkwO7zakTHfFl2KoJhwx+WtyTLLteeaG76?=
 =?iso-8859-1?Q?UD1OMCTa2mZuBxcz6VfK5unneHflbIrxhiv3bJG0A4FKbHDIktuEjCAFPJ?=
 =?iso-8859-1?Q?+yN7OnhxAoEuhBBD2D1GXhYC40kOCSeZCaUxyjCbRaYiuq2XHTyS0DcUCk?=
 =?iso-8859-1?Q?i2JT8vXZxZbnzE/jJyUPb4Fxbo9dFdzbtqlmvP50yYLzSMWGBYAr1je/li?=
 =?iso-8859-1?Q?vyEyJ9xhdQWu3XVa/gmrI7hXDgyDiDcuEPM0WIPRTvn3LnBOxu40tEzMQc?=
 =?iso-8859-1?Q?1dCI2+x3tbOj2/u9jbIl8wqji8uiTVi5K7e/MRIJmUZfXSSOUNeCFVfIEK?=
 =?iso-8859-1?Q?KzN6cHQXFuEYMXBRYZ2KBmU259c6VyCry+a7k67s85rhZKKpGa2TtPjA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907e69cc-563e-42db-40b2-08da844fba9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:19.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ps28ZuV4+FzfHm1DH4WsHSEk8f23jTYqIwRToNE/voxAuQGYKF/trwDwpXsROPH2VPjQ3+xMaHwd1lZZ36U0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-GUID: oAcFdtebHKaF7aUkF9k5eBQMQTS-qJLL
X-Proofpoint-ORIG-GUID: oAcFdtebHKaF7aUkF9k5eBQMQTS-qJLL
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

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1c90a58b9cd8..64d12dd9d234 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3042,7 +3042,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+	ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
--=20
2.35.1
