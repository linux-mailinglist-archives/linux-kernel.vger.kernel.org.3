Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CB4F172D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356942AbiDDOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377872AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6183F31D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DncS1012575;
        Mon, 4 Apr 2022 14:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=MTWThaJoerIVFQgIfj7vUAHBhHMxr8WjtpZnHJqYfnJTaGnxlXnMt5A/ijlPvRdwfyuw
 fRXixxh2+gt7K+t9HBUeyEMWE/p6RlFUXxzwGtMAKk1lu3FuAQsdNgcpyVmOSfGUHtFE
 fVA3pCXQ00Kra932/QZ+qp035lh9x72/MAhQzgGsK8wnqqMXB0HVEnF/ByvVSX5P+r3R
 VleBPtV5cNns373EkYqyhiIqjVOCaiPBg5fS1SL6HydVTvOcrf37D2QqtlAet4Ug1H7x
 OBEvPiu4u1tHOigXRyz0/iQiJYqG8BuWDMjqxYMUH9x80EQ1sf/ChwupgOutQxY/BMeI Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQE1028988;
        Mon, 4 Apr 2022 14:35:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZlQF0UxReT+3ZE3UCCUEKboYnqnZuS7MtVpKeUHi1Txlx6rcqhevJ+hv1X8mJZCoTDRRLEqOiqJOhFy9qAskczpYiznw8nsnT9A/1h+019gni8m+Yrwg8I6F6VMPyIQoLWJMu+EK6hnK/O1XJkK7pI4D+XlfDw58ll+SzcHmwPdasOiVINl/XgiHhnqlw/bFXRy4Z3tDNhuWfhtRVnpDGP769UkZWa6P3dkH3qsVZaryKYhrX1GoGNw68YXOOT4S307j6/WGxxqQusfYo7HEnfeKZUa4U74uUnhKDZZvV5t+43Z2OphoxOEiY2ksYRbCni/psqRIxXSnR1LkSc4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=DY07TzWTZTIXRx8w/TnmcNurObGxr2AI4+M/VKennsU7rg59jiV/JJhsVGxSodhLALZixTWSPzuiQpFqOnjlc+Vj7AFFOFDIy6GelFRFSOcXCjAcgqsQbTU5Jp/G+g0hxOA1kvaitmt3l0ragvjxbugqnYMrSFa0yIJKZsYZTVJo9uSBhiByO1na5drEwUUEF291AxdERg70IkDcaixCNDGcoYgVrjtbV5EbxKggo8jj4HI1jKN7J0ODm+PtwhoAtikvDLqlKaZotKdq+LTsFu5HwaCl54076eKZkqM2Do9d4z1HM1XYHc4Yj14bIBJEsgaJ3g3DCO0wZQTIO/TRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEzxfb7vYcsBLxA1MHbi67kU0vkdosDz4gDWGEYaOQ=;
 b=LmAN3W17WS3ZSOo2M5+l6znA5SrGYlADc4IyZBjB484bkMR7y+tT7QxFABhCUCCZx0nX+Voob2sKpPy0HxV8pTz/wg11gVtqJ3j7KEjTbYNITPk51fw0UoBsbJHJZmyiryRuTnM8PxY6T1y6VgirmLEWt6YLA/zOsEQiT/6vLDo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 21/70] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v7 21/70] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYSDFCMQQvyyBBlkqT8YXXwhjCDg==
Date:   Mon, 4 Apr 2022 14:35:41 +0000
Message-ID: <20220404143501.2016403-22-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca42340-8e1f-4dce-558e-08da164866ac
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812A5E3E9CEDD75D38CBC26FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xMt5adq5RCMACidJ2t3PdyH82MNwWoPUr7nrCVnb74P1/SKx3KHb7ddZmCeq+ZnaBwwEcXcoyPcPxxkswWhsT3zlwcYP8Dz6sfHvzGgKNxErEFvoxHJHM34i/Mg/f60ozCWk/6/jIJAMBgohnU1BEE03GKiQo3SedqsWMEnUTP+nvgl7aLuIj3H4RC3M09adob16dnVWZhrXJsq2IXAMBfSII2HMiehGbiYviBOimuKpiW1PBPC0PwFpLFiTYYbtaI+JFZ/o7NCNLqfopxSBjyyHwnoTf4tMfHWBwDAuHMxM/Xd4W7UHfn1epjrklm2LxzAXIHd5dpAK6nYbiGFGnNUyq0JDgfzko/vq3Dj93caRzApdM+hI4odx/5t1u4TSKvtkeHXwJLblkOaIvbAkvFBKquz76Y8Fu///wcv6bxda4wPZLK3WzqDvL+Jnnt1XWd3s48JiKEuL3Xi5f+K1XzRE7rrzCJlOqm1gMqf6l/qq2/3bXvdQITfRJxlB7eDmXODLAUWAh+kOPBiFcSb4NuO8wPTb2vkIyxgaParvPtaYY8m45UXMh6CWlELP6OiH24KdabYAh1gIpntNEhYK0TnGPbEOeCyAF3lt3DLFLBdLG7hF+oMyI1BZypsiXNJOoojxBUibr80E5F8MG8s7d2LSCUokYzgdNpTNQ6BNiP9UEgMdUfyJdytIIENQ49dp/R7zeYQP1LOEE+D2MlMmpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4744005)(6486002)(8936002)(1076003)(44832011)(83380400001)(6666004)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jOUHAWGJTmt1VcPYPF+7zAZ6t9da0GZ/Qy+QPjcLhg8ZGE7IyhhFEbRv7x?=
 =?iso-8859-1?Q?f2eiMaYB5/QnxounnorVhK0PuCoVG9ZHE6MjXaCrZ7sqZGxAu5mJw61pgi?=
 =?iso-8859-1?Q?Pa1v4mQk6ABah0U4Qm84IJTkaYfGSC2wN2vwsQAcTgLq0GhM/B9zybofzF?=
 =?iso-8859-1?Q?G39WG5QhBSNH7VvKHSIqUL/sq3Watu24Qgtb7xwZQDtcXGWXXCQOlieeG4?=
 =?iso-8859-1?Q?T2dQPxNUMfkdyeSKBMpMgXpohLO9YpiGdxxVthD9XmvaHB84sbyOVI1GbK?=
 =?iso-8859-1?Q?JfkwSqv/xXaM+KSdgtGTPYFJ0PkhsPjG8NNjGFCRnILbiToV5wsViJsoIG?=
 =?iso-8859-1?Q?BMYj1XNi+otKvmoVDPKcsUda3qI6YMcwcoKmSYIukKe6g53gxs8nvisn+w?=
 =?iso-8859-1?Q?wORkVX8OoktTTgn/ENEswhQhbJVV09AeqH+oGSPPrq9cdJk3vKEBg1gs0e?=
 =?iso-8859-1?Q?Oo9iLkpFl8CQ4tGBu6kmzA45ThaRp9kvFnLiyJHGAfM876IK3+PKRPSlUV?=
 =?iso-8859-1?Q?aPqiEcTvjcyM87YGCgytQ3UCavVhFkOmDbSGjcYj4MZvZStDs5ZPOnWU7E?=
 =?iso-8859-1?Q?3oeRKA2WRwNxr/vIUt3KvvCa3cqHS4lVszRVbyJTMgaDJQWnGtV9bNEp/j?=
 =?iso-8859-1?Q?aBgQQaMxYj8/YXTpsTJAggMKSl1KEIY2yC0eLAtNPWV4AZMXyVANiHeZ2n?=
 =?iso-8859-1?Q?zOkV+g4ng7M3hqMmokUHI8tYh1zitxqTnTCCw6bAAOW+0YmBBRO4YzgY2D?=
 =?iso-8859-1?Q?3SuQWAzC6xNVqPGFOL2pzfrqvP7AwvRx6AYgTFDX6rWqvIqdL7OgINiqHm?=
 =?iso-8859-1?Q?SmE3onqLFgWPkZ2mWLFG1Zcqe7YKD43+wwQnzioK7Ox/+CWY1eWAIC4uMH?=
 =?iso-8859-1?Q?IKO2psHjAu90KCjG3fOH7VLqMc3TAuHZYN4feLr80gWCJ/zVlmAGrk7jzv?=
 =?iso-8859-1?Q?mFZZO8HnZsUdIXaGUJvQrW4TQrNFiZyjDJftjNdhrRLQgXYwpsLb8T9VOn?=
 =?iso-8859-1?Q?nnk+eifqZCUhOSRelOU1QQGZD6/x91UrqVsi+Q0Gnx6thgFJ3xnEZI7SBp?=
 =?iso-8859-1?Q?LcFTnHnRp2ZwR2XcfYa1hmW6mQ/39Nu8a5uUXHiKCZkGaMqzYNfoCVWEEM?=
 =?iso-8859-1?Q?MYAS63rkevse48ooadpumxr7pyXHN6LLE8vCpbjp4/4u0XlIVDqUkiae+s?=
 =?iso-8859-1?Q?YhfsHXIAPbBWW1IOnIINXvyo8F/b+sQ4O+h/oV5JCq3jH1EPGO3y6M96n0?=
 =?iso-8859-1?Q?Q88RJh4LUQCDvdjnGTSYJ7rJGeQyocvFeVYChyDOlW/gVnJHdtNpdsl8G2?=
 =?iso-8859-1?Q?r7X0bQUWj6y7AwSdojM+YCBbm5QzALjrUwfYMT9ZJAI9OIuMHSKAfhzBa/?=
 =?iso-8859-1?Q?3bSxEOVCMcR78epwBYRTR6+gg8SpCGL2dtO5MGsJtOwL34aPfbvPMDNPsO?=
 =?iso-8859-1?Q?uwunnwUt+91hH48thiq4UYm5FG++8Ht4DVvIuQKm9V/PPgjx9ezVPBmtND?=
 =?iso-8859-1?Q?zto3kairgiWUEqRsYGeHs5/3DfkTaG4qExCixcm6sqI0xSF3seK4yZODPX?=
 =?iso-8859-1?Q?XsHjlHyp3XCHHOjbyyAdSb3on5gRA/zvszaNJpQRtqYhbQyycLZZLfGNEu?=
 =?iso-8859-1?Q?EE3elzf4SuTxh5EhhDji48T26TMnoI8op7DKPkOsz90cDKwx5V/uACEZyF?=
 =?iso-8859-1?Q?tLYn/7r9zdMjPoNYh7qEqNXGrRwYzusRhzd8gF5i/PJ+FBSxmI5fNR80zr?=
 =?iso-8859-1?Q?fKnQKeeoSsfTR/ZUDz6A6GSY47+6At20v7nwOooHdBQSvHbSo857VLCn31?=
 =?iso-8859-1?Q?wuph30ahzHaqyKBVTNtb28g4V1asLJg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca42340-8e1f-4dce-558e-08da164866ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:41.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDD91gizPyye8dQVbCz+zcdTTP4/+dwYGO+h3hKRiXNXX5v+hka1FLNBZURMURSu98Nh3Ohs9LLhfBTNQCHr3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: ViAgp8NFxST6AGu80d_WCdy6z6UFcHB3
X-Proofpoint-GUID: ViAgp8NFxST6AGu80d_WCdy6z6UFcHB3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.34.1
