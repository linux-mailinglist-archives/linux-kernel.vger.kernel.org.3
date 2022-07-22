Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E057E413
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiGVQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiGVQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:06:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F32AE1E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:06:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MG46DS003805;
        Fri, 22 Jul 2022 16:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ff57MgpnKX8cKV1z5su/3KGxrXxUul1jjBxwGB/5TUk=;
 b=dxeoie1zi6zb1s7B9xhiJfzbmAi5DFYiOyrd9zqKMSSs+YdPpllEKGor37xFoEzcwXl6
 1tZY1z2p6sXt0hKteXfgWLDPHhR+5UNvO7PSsFOQxXw3PSWqLeVvcTUjS9jmkT+wJnUu
 MW7n9MNARJK7nWYhnfIKJGeWPgoDFax4WqdKMOePJEUSLi2MN+9gK4GtlgwxsCIUS+rk
 GZIQ1fRGVvz+4MJg72I514cPjT/XQ3DJVG2EbE4e/c6vmTjb5VYSXVRtsTeLJztF79FA
 DUYKdNCgo0QtdJQvODQH8VsUX9gFm9eGI7gp8dLmIGRkM5RttP8VAZUUWKA3QbgmqH7P Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtqxr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 16:06:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MDSo5M022152;
        Fri, 22 Jul 2022 16:06:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hv8wtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 16:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0gTamQqWzGQxh8lQIDVs/ilmiYr4bT8br59giHdQwrARyJbbrUiw0iIwimCIeD4KJtDb05tYr548O8UHBFFExjDLa6KL7GMWhpkgDmcu0yDo1eIJ+WJq21+xhaSM35EO47U9ppYQvgZn+3iTe0hIl9+AYEsQ9o2wWSN1C/6WgRHYo3fp+EGm5km6APokatDpzwOtRefprcpAv0NoU5D9N9e0Uia8euvl5qGjpMoNCI9jHvEmnuF8u4mgcaypGSvVhQ2yR3NqvXszzu/eOb7Kmf9H1K2pUUvF9yQb1duKPyiyqe1G5t1MvbD94t6bDdwlGe3ONFnZBNNChXcHwym2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff57MgpnKX8cKV1z5su/3KGxrXxUul1jjBxwGB/5TUk=;
 b=jyJBjhLSZr5UtknPxVm2KUu9MgxtXO9pEmWeTsEHsJpEBKAfnDVHatWqcghR7KOrRSfyCAffwsXvaDQDr9OaJV1kgg7qroePck356+RVfY+bHnxrvFv8uFEh+na5Mrd8uy4KLoX6whAN9rGeGhOz3FQDQyBGaPSaopwEi3p5rCKERvGXVhrl9wNXmSiIn3ZHbEKUG8JinprEdPxq2ILGTB86RjgDyK6fbkOxZlDPrtMwHtUC5OuznZ30c7GYhE1vQ86kGoeSr7WAy5Gfcri3wRPO3upKLWGF/qGlgjmVj2j5HrQ3OqRx3k1MqABtSFOztlN5RBNSs0K2zKyBcF2WOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff57MgpnKX8cKV1z5su/3KGxrXxUul1jjBxwGB/5TUk=;
 b=tuDCscCapyTZ1e2B2MtFKXHogFhrrvN+LP4iKNOUATLTCwG1ZZhGXtAJ95PeNtWCXIyrlNjlEMX5rgiqxggLquDclRyEknD20gDX71kcMnTUdAWVDUZiHbQM9WyN7r+JVpZXHbLmTmhF0Hqwxy2xuwx9uz9DLIB0Lsp6K6N2dYI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3877.namprd10.prod.outlook.com (2603:10b6:610:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 16:06:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.025; Fri, 22 Jul 2022
 16:06:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
CC:     Hugh Dickins <hughd@google.com>
Subject: [PATCH Fix 2/2] kernel/fork: Detect mas_store() failure in dup_mmap()
Thread-Topic: [PATCH Fix 2/2] kernel/fork: Detect mas_store() failure in
 dup_mmap()
Thread-Index: AQHYneTxYX5AgNhIrEq0YRmo2lBMNQ==
Date:   Fri, 22 Jul 2022 16:06:03 +0000
Message-ID: <20220722160546.1478722-3-Liam.Howlett@oracle.com>
References: <20220722160546.1478722-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220722160546.1478722-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3a4f3ce-d95b-450d-9079-08da6bfc1491
x-ms-traffictypediagnostic: CH2PR10MB3877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siqSp0hzNUJmiufVjgB4PIMuRoFMNYRWw8tRjRiWf2mrk+lZ99q4zKN2QNqNs287tnsnlthJweQXmpasOrrJRGv9EUSx5eUF0r2s2Klhxb/91Z+0sG3U9aDrlHk7HbGh3liaqaCCDgenDvgn0c14497LFIqzfqkI5hwaWEkCYlBgrMvNFt021QrZ+WkxsMg7s6qJPoRFznbLLeOCjx/4039PH2/Pth93t/Cb/SSDH1cQdL+2tZtHD7JQKi/LQuppCuhGCKjV2Rf6VcdbCMXYrlkEi6v7dBRIk6qa2s4FANUk4tLIPRUFML7Y/7DkTxtS+Elk8UAxsTxJkoOoOe2z5NnA9HvrTeGeJG/41MTSDi70t9uRIyerNOFBbPFH7JYKvG4GuZ/Q+j3CN3LQcuX8Y8YpyVvEkTisz032bNDtCBwuVnnaRpC4yLQ0uhPS2UZlQ+TaFw2Hb3UA3ei8ZA2f2VzpuLLwpsTxgjdGdKjhcj7AhPoLe0JMuAsKGdqSm3quN1Y9YzY9zsuxJhtwwhGcRiagBnKGdb1/MpUpTC+i20U4bhBXipdkBhqh+c/WXe341mj1SlHm5ebhDJGRLRB1keRQL54Mq934ZX7tMXOk3mCyxU9IUzKcvX1KFLxQBZiVR7/Pud3zgVEJ0JhU4+ARQMl4RfVnwlcvlc+d5JP2oHLBPiCh1EcFXFQY1hCAPDGlxoBT89CTl1kr9rC6sQR5OkK33YNg902i49cv0MSA3A8h2URqZirdpZLjZw1bb4bRvTLHaA1qrnCEbfi0fa1jqZdwFldFpv/ka7S2039JnkNQ76vQ10QUbFvMfw4VWPnx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(76116006)(64756008)(66476007)(66446008)(66556008)(8676002)(186003)(6506007)(4326008)(66946007)(478600001)(86362001)(91956017)(2906002)(122000001)(4744005)(38070700005)(8936002)(5660300002)(316002)(26005)(41300700001)(6486002)(71200400001)(110136005)(1076003)(44832011)(38100700002)(6512007)(2616005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OVTISGX2U1DL3NikX17/YWX78IO50sGjuIPY1BK4P5luc3mj+1nvtwBtKS?=
 =?iso-8859-1?Q?tyq0t4Bbna4O1F6Tc6E3lKsNVdDdHhS2U8vzYy+PPP1IgxGSnFay0OoRQQ?=
 =?iso-8859-1?Q?+KG9DFR1WP0TfYPyV5XyCY85aFncYp5z6yzJWtk5H9XsOn9lG01t6IACwk?=
 =?iso-8859-1?Q?FiL9iRjSuXlKF8uegNdDPLNRbLLhPyrz0O9V8GTiMCE45QIY84bX7D9SIb?=
 =?iso-8859-1?Q?iJLHuHI5GB9FhPN754gAJyMIhWNVbRVt7gV9Ans2zS8UZ6KyRhI1eY1+B8?=
 =?iso-8859-1?Q?WsNkLQA9qtM6S4s2l+LQvWmGg37+stYiDuUd7Y/2zBd8WAjTHNwCPNQaYT?=
 =?iso-8859-1?Q?XKDEXsTt1q4RPXt8VENk5BWfXzL7hErtzs/RZ2MVqXBz+JDuD7EB6/DWy+?=
 =?iso-8859-1?Q?1ERTLJ9hVdjN8AePcFgBQ6OPYkHBrjk6Hop15cyAcXiRmLg+fv4glcnfvO?=
 =?iso-8859-1?Q?ObKWwabu9MIpdc7GF7E/AT/KamlUcHEbGO0X+KyVIshEJfeSjYGLcwpR/N?=
 =?iso-8859-1?Q?1eF51LOB8Uu9hD3uvzeeVUpZLW2ee7IlS4u3rRhMT8WW0GLqK+1bKKmrUJ?=
 =?iso-8859-1?Q?RwFvgWJPh+9RHY6bsfZvaMCOkD9KJWDr0dp2ll20Ih2JSc8fkA12g7h9K9?=
 =?iso-8859-1?Q?PFz529uCRyOXQYxVVhdrfG+IeSgbAoPAf8Ltdn3Ii5ztj7gcF5HbwP6E6G?=
 =?iso-8859-1?Q?xVMCVLoTuxWHMp42YNKUVfrQfUSItwryADxb6A2LU3aWbnHMIi8DW5wCve?=
 =?iso-8859-1?Q?8jtQhVp0EWfwSKp47L8cVzkfsluEDxvQyUBMjIBf3GxiOMkaRwinKtf3yJ?=
 =?iso-8859-1?Q?usz+J/ywZyNMbYLGIdjt0y8aIc9bci1HbT1aKsT7D/K7rMn4GtEvOwLMyz?=
 =?iso-8859-1?Q?YftkjU5JV/PXbGp7rtzJUSoqe6kJ/spt3P05uCbcnBg4aNHSm8pwlco3cU?=
 =?iso-8859-1?Q?bfKNZn/+4AV+eFqVNBj17JMbEwT3X8kCv6G3BdyfWl1v3qOONiuqfLnOV+?=
 =?iso-8859-1?Q?NU6NvVgIhfX97fJbFGJZffJ1b/CKjo/flrj6uKUG3E38Kbfa+TCx6a4bh3?=
 =?iso-8859-1?Q?WBULaAobn1eHs9UcalZH07Xga3/jVdb4S1HfPexZp0MkdWNtvkDfdv8M9D?=
 =?iso-8859-1?Q?pPaLhLCB9KThcBFU0WSQ1wTnBTiITS3QFLZI7ghclc/LdZT0fuShUDuydz?=
 =?iso-8859-1?Q?7h3QFdLxqb5A5SH8mvfsS1HN6pn4c9tQ2lQZjauy0k0EEwAAxNd6fajDCy?=
 =?iso-8859-1?Q?FXCCNPhbGFyB8GQnwjJUvCXZVRnGRIrU1q3KWMy6q2cVdPIfjbfVmWh6hP?=
 =?iso-8859-1?Q?i0Zi20KA8GJJPExXSeIMrhPi6TTyNtJSvMD3QTyZG0ZKwOaJ8Wx+hYmnuI?=
 =?iso-8859-1?Q?a1QpVUy3hQoCdONsVYMSIjX+lHVs3USV691GtjAL1Wl/4yMtW/1Bmu7LNL?=
 =?iso-8859-1?Q?lvpLZRnEe7IAhRPvrjJTwuFh5cvUiIahnso1PVPGlpAEJcsoRtikJIbFiG?=
 =?iso-8859-1?Q?4ogw5DXUpWFxZ/XZoDBcLRuVR1usNSCArHN+WY3b8aIQTiAXtAH5QDBewZ?=
 =?iso-8859-1?Q?WVfW2huJV3F4zbUzEggcVADAlRBuFb0PDnidlNbzg+kNnqjmAEsOWqM736?=
 =?iso-8859-1?Q?39GkCeg3QV0WOXii7s4YuYDiIOWZK+ILxQ53RLrKXdSTREvUQYmtsFgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a4f3ce-d95b-450d-9079-08da6bfc1491
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 16:06:03.5018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGpTNtv25rRmwWBVmzsLv3PGFnfzaHmwdsI8hoDSYkv6RxKvF1Gm+ZdCSSaHZke/WcCroFG3vj28/5ks+na4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220068
X-Proofpoint-GUID: VdoK0QeMz1WzRwAr2M1-tRiJcIprKPTS
X-Proofpoint-ORIG-GUID: VdoK0QeMz1WzRwAr2M1-tRiJcIprKPTS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_store() should not fail, but protect against potential failures by
checking the maple state for mas_is_err().

Fixes: 57579b57de57 (kernel/fork: use maple tree for dup_mmap() during fork=
ing)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/fork.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2d7ce88da540..dfa2d5d22ed1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -685,6 +685,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
 		mas_store(&mas, tmp);
+		if (mas_is_err(&mas))
+			goto fail_nomem_mas_store;
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -708,6 +710,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
+
+fail_nomem_mas_store:
+	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
--=20
2.35.1
