Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855B59C256
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiHVPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiHVPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728BB3ECFA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpjjm016581;
        Mon, 22 Aug 2022 15:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=QUWpSeM+11YlgnqdmyiWhiHRfk/zUHLgAiiH/NOBn3H90eiJY8OLmIp8Mje+Qxl7vWc4
 hGGQpzBiMcjwuSfTVs5lH1qKhkjTPOddOY/VsHVurpQkR8XkIkY1qQzbNTPApNCUyF3j
 NekCqdCDmiu/PBgKpfPw18XsyubkBvwJ7/vsQsc8DNiT2u+hN3WXUTJS3YxIPbPJHA8f
 9LnViolDq/oVDk+XTU2kBwww3ZT0Dw+bnLV1pi2ssQFk46bz0tKTBrfh9lEn2u5ioQ3d
 0+RTCkx+5n0M/qR6MBTdmFPBC0QSig/KLtEIkwb10ZKRfNx09luQU3Q9r4O/+JKS7h/r 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Og6026762;
        Mon, 22 Aug 2022 15:06:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8berb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0or0BjQW3QCbyVh/GujvwOtT15STWXYlhJyQpBqMK18ZxJ8KcrsBlBrVfEpH7NruV5Y6TC+cDEaqHZ59anNQ9x1GvuUo+BwX3hn/0cZrhSqVaWI/TjfiEmGvy62ALpa26yqb+x8PcHDPltxDyJ6Y8S9/OYFny9WJDUOg+l5lYpwLd6G0AFxLWnrtVrqtEYxLw5WWpgK0ukzANXz6uwAhYC6ZxuHLI41zT3nhw7VqO8bjlOkQAVaXiybfCrASHHmfEUbrIkrBfg99+bMcK+GmSrzoJ8pttCeeUVeASbzc1qSgSr+cAfwVKClFJVypdZPeCRQF5m0habVo8Lct1zu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=JbIXsVsSoLQfVcvDfU92xohxpg3gR4BpnL/xskGUfzNS4ul49X1M52eiOqJQt8c9HMQNPVitLcMWP5baU7Kuwg+QPX3cXwzMFoJosQw9ihf+bkTlXELBMydpZDy2kkrdFC9NUjDyc07jEUzN0tT9hF4XLiHydDadspW4iuwLm5cT4wnOSRqV5furO4dwim99fKyT3+vjVh4SsBEGUGHTCexiXcaawv+jq/2XUtvPuiRXBar3sDxUx9KeYPSYhg8/Hk7YBK5lxBT8KR5YmIZgb8LFTJo18sGiafjFAb90Fl0DN/3h/qarrfSsaPmJ6Cpa2riM+roB1fvgbRju4UAadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=XNEPuspHH9lfdm1vN4a7OqL5js0rZkIkpCo8zu6nKZM+TlEu/+CgUwKD+/YfUnGW4rNhcJ/u6f9DcVsyQLINzriNNG7sjm33IxOm7ZWYXssa6E5DbBqoaf8nmL8Gjdk1yQ8DgNii++VmyJt+0ptqNbzyd5YEhjZFVIojHG69Ff4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 62/70] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v13 62/70] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYtjjD392uD1KdRk+AgY2fPZ94bQ==
Date:   Mon, 22 Aug 2022 15:06:31 +0000
Message-ID: <20220822150128.1562046-63-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2990285-b86a-4a45-af59-08da844fe86b
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZc+I++3S+56yXOwatxeHH1gzpkiz2dr48ObfWmlkBlCwsVI4VSewIfP0u9Klm9YZ089+iQrDtMFoM9BOiGRC7w1N71q7Hi5jNmv1YxRa4LDLbabaFepzUnIqWnXEoAIv6WW1bXS2bhghaF2OKvIgkedf+ZmBE8vCP/vidCcL5H2ZNaCgGGOF6jxvm7mgFIr5hvrQCpBeiIChmuyPlnPJYw04o33er4BE2DVqFIxmfE89R3U16SOJsjnx08KvSGtJm33//mfGzhfm15PsOSTbB74RjdYGG4CgkTAn13/djtHqTqonmO1LQ/rpyNHaFc8dTTv3ilNmpcEU9t/oWqal64dufSS2b21drv1bWn3OchMgk0BRu1yuaKMvLbCMZTJryaGxoHihYKuSpnoPigLb7NK/+wj1Aec/gavXUYF4h7dCsSzBRSH56jRJrLQxwNpysJLbQ2NT+hfLI6HYJk+PYH/lQXCcYMkFaZg4tRi+Tx/sVqp2kAmDF6vAsLfwXMeMH3YAiXe88jmzITpe5kZsf/8WZC61mu0/g74zQ+MXH7DrXOW2L+NDI4aqRPc3rpSRYKvxQYyt9R/Sr1AW4mlLBS2fm1WVVo7tLYQ/PwpJD6ExZOyBhue+5TA3r/HkU+VttPSqio0wnzISbHX+iMSIQ253gRTOLImEku4aJ4DkTWPFWox0+ekQ/oPvVU1adk2ERg64WG1aHFS4ubcfPlcX95eSlnAdIatoWNlSGfhWZCPyakSPKQqER5X+ObC4AWv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(6666004)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(1076003)(186003)(66946007)(66556008)(66446008)(4744005)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jPz4ryEv0wLeVOAnGb+9B2NtMqgObfs3XIDhtkXy9tSF19D7gxAXprJupz?=
 =?iso-8859-1?Q?Yxz2OS9liZ/X3zTSgydJsACnfkup92yq7SicnlsNBfjUkOikPb2J2mv3kI?=
 =?iso-8859-1?Q?ieRSqomovV5cD0RMmqXhs+BfJYkyIqaNjQvFM6iKRyUCApeKPoxMGdl2wO?=
 =?iso-8859-1?Q?cpsSt9vJRFwIu9BKF5+MzFnAWe3BPGTbm0mJwFxadtMP1tOFnsQLf5D7bN?=
 =?iso-8859-1?Q?UWT81RLA7m6CtLAqTyGAmo7r5h3nAaYJ9oJKYivyzQIbrlRk6kCKEIV5Rq?=
 =?iso-8859-1?Q?ET4EQiohigocAQfKJ3udfwvYA8YVa/E2MFWN+iBUJaksbPrY5BIyGQzY0U?=
 =?iso-8859-1?Q?Ha3VooLL2gmFDSMJ+NZoLcBYPz5WZIhHpr1gRWxTS2gLsQ57TeFeg7BUcH?=
 =?iso-8859-1?Q?r65HsE5YdTbvUqE+WKlz/e6BrkdBJminIZgqP6E/NRDFprToGIbZSyBBlm?=
 =?iso-8859-1?Q?nQZlF+wbLRVSV8mZHdd3hMHOQFNat242DWYcG6uPZyTR3zz8x1KEdii72d?=
 =?iso-8859-1?Q?CYm03HPX7whoZv8xI97dpZPvlNqhIF0kNzGdOJHJyzyqeQ0g/6CRYlVNy9?=
 =?iso-8859-1?Q?h+OjCwJgXcZvvXYG7Z/t9PQeqSjkTDihVj+lHU2G9HgAiBpaySVXUZDW5w?=
 =?iso-8859-1?Q?gJwfIv86s8e1jz4XzMyEG9gJoGCOOnYUTfFVy6t7Pr0YA4w1eFqy/vRHsR?=
 =?iso-8859-1?Q?4ePpa2hXjl53gRnYdiv9HkidtvfJxxt+q3u6BVLaeX3qZjOufTCO3C7De1?=
 =?iso-8859-1?Q?ecdGFIUiwzAunboTAud9F9H6+4eQkMXwEeDTVWKnJJpMDbjPKSjnx80wf4?=
 =?iso-8859-1?Q?Z14a8vm/A9WiTbjXD7fQpkSapiS+gAGZsAIHYezdMr11ua4/gaBRBjdbig?=
 =?iso-8859-1?Q?cZU/HS+CjrqE4TNhRUuHMIDbplWHx+A0sew0FkwRhgPV5Intguu5eH0mbT?=
 =?iso-8859-1?Q?1rJYHzpuGLKNre2rZ3/Ou4n+wZDycKJWkDeQHUEDZNXfRSPjj3UntKZk/8?=
 =?iso-8859-1?Q?XjhZ4hMtAtaYuHnCbrDO7S4KqRkUfR3MMwcCsi6G0gckxUZdudKdQDJkuP?=
 =?iso-8859-1?Q?juF5S2LYxJj8UPrqwA4QNX/g/qtsTUUDDZrZmkC4ok2O3WT2YsbJDLm2/A?=
 =?iso-8859-1?Q?voM6uFpdfGv41uTqEnDq46ZtU1k2oL0w7kOhshlxJHIWoFqDfBfpBRMpAr?=
 =?iso-8859-1?Q?QrhJwsEmXZ/ZRTPw4V2wBPMzd/4I2CAVmvDsIDiUxJVxkVcEuaX8E+VqbW?=
 =?iso-8859-1?Q?Ge3HR7seLu3pWK7OaD1cnv+fgjYyVUumoEoR9J4fdzWIEj0jAj+frxYL65?=
 =?iso-8859-1?Q?OjtpVATR+1popT0Y6OLfqUIPb3/n1wfNJdrRHZJ+WDNN+IvXKGT3BfeX56?=
 =?iso-8859-1?Q?01IiVfmCPJb+ynJzhFnJXhzwrk1b2tet/Ltks3is7fXgwMwdFYCoq8sWu5?=
 =?iso-8859-1?Q?Mopjd5Rpj1Ch7FRTzDauRXqKHsQo2zZt9WW55BclkMXNLfGDQkTvaArQsU?=
 =?iso-8859-1?Q?/Zc3I7ZMmOxSdIVlqoa6KfU4dLuKTrXagcSHmtbk8AusEtA1FUyKxfUQIu?=
 =?iso-8859-1?Q?ncgI/vdDEga7WCw7Vdu32udAhMPYU49GjEvQkU4wsU5kFMBZZv/LV+6xtw?=
 =?iso-8859-1?Q?L2aInX4YO1dR38V45hH6tLWD7Q5TX8ZNWcORzaaQko7Ucad4BkxGaS6w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2990285-b86a-4a45-af59-08da844fe86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:31.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1sxz/1qZUuV9/AMZomKsd8OJpv7mE1xJm/xR1DhIC1eJ4DkvYnBgkz9e6STkpuJyN5qj9mYU9J2vhCYxvWhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=995
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: u3lmyNptEwO9Ageinn5ZK2CvR8J-msuA
X-Proofpoint-GUID: u3lmyNptEwO9Ageinn5ZK2CvR8J-msuA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

walk_page_range() no longer uses the one vma linked list reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
