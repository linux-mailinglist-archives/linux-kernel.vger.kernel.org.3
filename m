Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DB519344
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbiEDBSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiEDBRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B973134A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243N1sIq003197;
        Wed, 4 May 2022 01:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TKI9eNCa51gzmFm7RPpxkwdSqX1KojWPWooQ1PT2cSo=;
 b=AeshOZHQZgx3KaivqCm8UTz9khvv5fyWsodbIZgXXnlcn+wenKApjg939tVNn2MCC3cG
 du5jjUJzGFN86wzoEWyK3Ui3WeYKTaMelIksEJ1jdB94PHZ9+QGe3GQxIawns5Bk4V6B
 qefkDcmLGh5bojJIzcR47GYCNPuIUWENR38pMnOFbtaGZwW7Kci7qtZDWX7aZ/4h6qzq
 2JGNmcmE0ciBCOzHbCbGAuM+tLIKHttZ3Ok4v1bTl8Ho8QXDRXEW8Lz6VMlXvtZsfWqi
 MK68RmJx+uJz0wPsGtjvl8/2Ph2fxwOaeSYYzmZ6h6gk3ZnlQbUv9VIRU82xlIoQqy7n kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJY013094;
        Wed, 4 May 2022 01:13:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCPHmiDNJPZV/n64de7XrMnnkm+NSr2vFSZkMer2tyh8+l3wl01ikUhfwo10NBPIg9avJjfUIXU0I0dGgXhiS+VgivVd+oc1NcZlgP8zvsEjMa/M736Ku6QLK6I5AKJAmSixYzAjQtr9Pi8sCLFXabFD4USL9KTXIMWE0WHsQbtDkQqT7mvrH2A4SoxAiRmzpmJoOJ593zT/2z+ZjA0J+jns287qWMwOmj7gx6wk3X/ZnFSRa1F+PrKXPBv63RfIDN9Z30t4wstyObREK6EUpcncRYv5Qy9axSxJKS1mbm4v+bRcMJ4fhKHa+RGdzQ1slqjSKRE12dbilV9RN8n4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKI9eNCa51gzmFm7RPpxkwdSqX1KojWPWooQ1PT2cSo=;
 b=ZvWnnjMCbXeVDjPMq0QmVPZO4xfBH1HubMYU3uC4ecf2tZMyY3P/8ZWTenr9sqUL1JLoCPiUcsY2YfVVJNw+3L2r55h2JPzA6sGLBrBWarePgCDXl6a2ij9zhV44xxhfek0Sd9OWJu8D8UfMjukW0MnN2XyAbpoEYhlDx0Q6OKbmLBvofkpcKKXItvSLfT1Vwgs9WDM7rN5AVNHyTs1P8btKrasoBj0MMW6avn9OOF/qBfFHWiv1M2qHFG9im7FbNt0XtQ9UI2BZ8qY6JXElEV30RHs9j6qkMW68opGXjAp3k1KXt3vK+f4X6LgwK5Zb79DDOdCxZeeZkRCZ4+DJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKI9eNCa51gzmFm7RPpxkwdSqX1KojWPWooQ1PT2cSo=;
 b=ZK6DWzK4IxV+znzujbw1xc34ZkrihidUyIi8Ws+cOo5uuqD0xjSQ3NLUdvw0naAyHu3hef+dhwvIeC1wSKBVb6nAIhIVU6RAu8f/k5Y0JpOEpMl6ygZ1+87feKm8bZ61JziIApypCFuRoNjINUf5sgGMpDgjae32PFDvOLMNuzo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v9 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYX1Q4rrpHgD4S50iCTnVPTBKD9A==
Date:   Wed, 4 May 2022 01:13:53 +0000
Message-ID: <20220504011345.662299-11-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aad753da-20b7-46f2-d280-08da2d6b5ad2
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB583001B8C19DAAB0E489A255FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHHvlm39NNfrL/6poL858bZYHYhHdnbI8mddHVYpdO/DYIEYXoj8WxoNYSdXjy7mCrno4EM/B1u+ALXVLW0DLPfU80pn0eSwsgdFg0yR1YCASO/meCe1wFE7QMK5Wu4D6mBcKzNiP0uzzrmcbUDC92vzNFxUyNgnY+b6iEuMikN3Z5nokVM6s8ygFzvqRKy1yWGLcmOD8eqzgUvjLo/FpdfKAFB6Ntvdv2+W6lV1lANLfN3eXUG2HlgMHTxvdeGdEiLXaFo3yfE7SIEgqfIqfzz/4REEL0u8ezaH+DT16Kz5ZTqrEtsfVcHQEuFY2PbEEHKTK1pB+KYJyn3uvf4WKcKBylmOigmxqpG9GOGULZG47l887y4irdzFlbRwtVl7dWT9CyNwdCj/Ed2peP3tlSemy/Bck/8fm36k9PfPBJIvMRjZM/4RX52FtwkDyL/1AQIiAavgYswP7gkbgfW3ytk0lzOjNYlq/NFiP2xfyVV5raRUNARfJQNSxoMlOyzT8k+NzMhzXpcACUeO66Cz2j6jf+Vsxk7/MuyqtXtNVN8hIlbzUJDk95ophHVb6I1LBpfEibXdmNKN1xZiKdHdspOSuEi1hX+a31MNyvF4Ktn72+ssZtT0DIpadjP6WzDLjfYdue6ZfTMRmYMaDGd8miQAnYuIOKTLwny3guaw54MJYmpSy9tSps8jYhrIEGws30Ra360/m9rhObPIdph0OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(4744005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SjG/B7X9lM+trA+cJLR2MhZ5Zyfspu54r/bQ376pUJYxKOlAMN1w03Cg9z?=
 =?iso-8859-1?Q?r3G8mlW3NNDBthIiB2a2mJY263XHrDAQLFPMridUP7fON03S4hWMqE0+jY?=
 =?iso-8859-1?Q?J6ri2xXJutNBjvaPUtw/RMbYJbgz93z0grDHdtiVW03xjAJIS++oB8o2jC?=
 =?iso-8859-1?Q?9nTIVc97bZf5MBjRoKcylkSxHnp9DzISeUqN14ee7RAcNBlg36GzOgkCsv?=
 =?iso-8859-1?Q?NFp+YvkmcVC1/3hcMXXjwiuoJAzHyLn2unxfyvvv5ZMm3sg88qeCgTisaz?=
 =?iso-8859-1?Q?gH9SCIag5HNMt4UUE7bCTFkwMQrqoRpNVLZeiQIVXyy1k1lKeFsmj5DseN?=
 =?iso-8859-1?Q?nqOgu7W1kK+4dC/6Oa9/gvm9f/Nd43m5tzbWcr8KKiTPg0lvZm4b8h6oVW?=
 =?iso-8859-1?Q?PkoBFxhFpbrtK1B9N8VR5p6GH5IM2/qD8trUEF0QSxDigs9krX6WSOsSS9?=
 =?iso-8859-1?Q?NviposFxpi6g09wsWiU0+1e0u1JZcLOOQAvMEhLgxtR7ck0YyMPvtqV6w9?=
 =?iso-8859-1?Q?2xR6b5YUzXrfbi+uyM1WImZyoVnHQIDfa2d3/MUpFEaSVJb09OuK67dQvH?=
 =?iso-8859-1?Q?5QWkXfZ3hMWzbA/2h0mrtnIKMhOldnPRpdTQcOHrweagj20OAMu+7+R1IR?=
 =?iso-8859-1?Q?LAOqRD3jRUszSlJaJUEJ0R2SxKMw0QzszycOjfbOIxLwuUW/MpBjuKVwt9?=
 =?iso-8859-1?Q?AyLUv4TGpvx1DWzgJLPrm7UD4dgeFaBwmrmjG9RddV3gLg+6nm1ZJGdaPB?=
 =?iso-8859-1?Q?fkMQXAfta2K29LODs4hv4rno0ije5udNaCGORIzb9MHDO/DKD3zwFYJHjS?=
 =?iso-8859-1?Q?tw/GoTh0v4bQOBjHdfmOvP3wO38jQYJ1vVogbd5o2k489mFOOhBG14garq?=
 =?iso-8859-1?Q?Uo1XAzeYntSxtFOSftj8IHcQ6Fsrv9goFaCP32ZfA9DjYkmyOhYwX4xI6y?=
 =?iso-8859-1?Q?vUs9n55lTfxtZiC+efbDzoAtsqXyI2VZIBjMUJyU7Ht/jeAsjWVANXEDUv?=
 =?iso-8859-1?Q?8rfmAo2Z5RIn3GXevmUBl1hKVfhxRBGVmVZCHPdvvEcVx86MyYsXb15P4k?=
 =?iso-8859-1?Q?m+hReFMiL/koLASOXgw322sBrxRtDVx6fchmweaFv4lU1y+wcuFsZ+ucRw?=
 =?iso-8859-1?Q?0dv6G/QH/TRBblOeKr+TCJ8fsgekf6N9PjErWL4d9ww1PD/pDYTdTwa8ak?=
 =?iso-8859-1?Q?kaznP4DTeOKIJR2RNkg5QjgKfuNHfEJhqwLiLheTR6b9s6s2cER6IBP1/w?=
 =?iso-8859-1?Q?XTxFRtu/RvAsKLji2JyzuUbx0BmVDZ9gCy5/REuKCXtSh/w36zU816RSo3?=
 =?iso-8859-1?Q?g4uN+paALsA9yd6q707mAr0zC2P6cuO5BXYcjRPDoYFKMkWJ0SD0mmNm26?=
 =?iso-8859-1?Q?LLbTQBWFKYDhbz/JyWtTh01kbC0F2RNhvzwDNkULzHT+zME0dt+gewjKtB?=
 =?iso-8859-1?Q?7JJ7ASeoj6wrCGj7qLkhdUV/WERw7ydzxaNfwbL7onUzWCh1DErD3htiDA?=
 =?iso-8859-1?Q?Ee2iJKgkdoC1EBpoTykuO11Kb8YeHRU/ASnYflB63qwAfwISsbaUt5/fqp?=
 =?iso-8859-1?Q?KcPV+m4Zg2mmBYRMXpd5hvnpSM5W352sE1wajbz5JL3xtzQhCcSH2R5Xwf?=
 =?iso-8859-1?Q?zs1kquLWV24MYbtpA//sbybLCWIy/lFQkatlZUEojtKPiK4MLy21RfKpqi?=
 =?iso-8859-1?Q?RrvJ6rI6TJCbau6GM+Swr23ZdaMdsTzEZhx6bSWv77ifQht4hlCNC6AjiP?=
 =?iso-8859-1?Q?y8ovTUg4TtqDCXN+5qvGBrQ0HvDr2jhru+qeScg3f9rv2Eepb6yeGEoVEY?=
 =?iso-8859-1?Q?2l43GK2JDfy4cNM+jYEjAfXklZO5H24=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad753da-20b7-46f2-d280-08da2d6b5ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:53.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/Nf5vfy1OunP3GUv0HBtQJuOH57kNKbpvgLwGpjO0piup6i2fPUc50oHYxnCdhxar4HZrKPCRBz+knjTuqxiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: VXxul9ZiFkWIq6glvbAxQJMTSYtgBIfB
X-Proofpoint-ORIG-GUID: VXxul9ZiFkWIq6glvbAxQJMTSYtgBIfB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6db9face6f84..f6d633f04a64 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2797,12 +2797,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
