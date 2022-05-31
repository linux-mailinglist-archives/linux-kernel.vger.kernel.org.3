Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F196353906D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbiEaMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbiEaMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:15:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342AB986ED;
        Tue, 31 May 2022 05:15:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VBFkGc018049;
        Tue, 31 May 2022 12:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=e2/XXEhk8MywivO1LCRl13AZWfYccRem9A3/YkPaqMA=;
 b=W3iEgjEOok2VBMpBmvlgA5/pkIA8l6dOvsJbGzMJXvsqFHZWdT9NGs6omNe8JgtG3cyq
 IIf3mYmxrnKLLYis+8TjEYpHwC9wKp0ZeUepT8N4/u3YsOozY4h0tNRIpEoUY+bQtrJ8
 lGj20w/nMT/i1iDG0PTVmJPXIANfXrbD5M02oUhorX3a2rXemOHm2izvabdEh42zD41V
 BUdvQS7ihxrQUM4I+dvn7NyT+c0BkgglEU2NftnhzKMVaocqnz4svKHeyBdTnfLzzhM/
 jXJQIcP6dGatY/1SsNQNRF8Q62piryspRaFc5spd6X+3mWWPG6lnrJGylmGVvCwUorAS xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaumytb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 12:15:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VC5acp010878;
        Tue, 31 May 2022 12:14:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kenxy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 12:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYg6DmD6N3FKYO9PHHAkHDkakmBjEgixSLQrZasoo42HLkHt09sNAYQZrZ8ab6Xm4SL+oFSi/SP3ZcQDIpoHFyDJWPc/UpY48qk3Fuk9MepA1zC7ul0CtzRKnmVeZykPnH7CcObm3oTfxeeIB33mW9tmVnmiAEPlhMCL0Mfbqd8c6QXiuTTapxI+nircIcUTIq2hadpdZvL0G+UVLsGcENjfe8LMIix3VuH4tR9bHSQyXd3rZ/dNL1iFJYpnL+kpgNM/XK6/LKyb9hJbzMZWKWH+zPZFssM5R4ktmbpG1Wyld//LvyrZ7YRlv3n4q701RUEaaoD7bxA+pc4fpwMwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2/XXEhk8MywivO1LCRl13AZWfYccRem9A3/YkPaqMA=;
 b=YsaHbukquNxTWyRsnkz+b6y9+pgqurR9CIKsIEtPPE3G47mcHhHTJk/qxks1PzACDUCDdt0CnTg+zJ+s5BiEKLx1gb3GaiwUsY7AXFuPznwoj95evTR4dgj3iwuAAeJFRH1hdzhAZSKPUqWXczMOwMEsdb8shUsJzMjakW/xBWXtbLMUEUXpvY4Qgz1crqjPofNo4xac74MkFs7Td43LJorCEIHaAezOxYYH4RTUGzl2MZUGzfjtl78sO5Gu/iJkSn721Ul7VNoArcYVhJ3ITjVoN8LKglZ0HDv3DAiPcFq1r2u2k/vCzK1KmLF1oIoH+LhPtF39FJ6V88hM6Yemyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2/XXEhk8MywivO1LCRl13AZWfYccRem9A3/YkPaqMA=;
 b=boNP/2PRIzxDxkpp+LpVRmTBsegUFILdZ5yLPqbfygifLZen1WBJDZlxJ1yumJo4oQ/VNfNl2wNuTf7TvE17dS5L7ymnNiKEO3H59dlgebKTLo/LWhSBK/draitQ7jobc1HxcwmgoifBlJ2LWOYC9rg8IV/1Rdi46AB39Hks47M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1710.namprd10.prod.outlook.com
 (2603:10b6:301:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 12:14:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 12:14:51 +0000
Date:   Tue, 31 May 2022 15:14:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Len Baker <len.baker@gmx.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] assoc_array: clean up return in
 assoc_array_insert_mid_shortcut()
Message-ID: <YpYGsRd0L/6t5wLz@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dacbe7fe-ca89-46d7-5f02-08da42ff2990
X-MS-TrafficTypeDiagnostic: MWHPR10MB1710:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17107E242DF4D113176D06EA8EDC9@MWHPR10MB1710.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YK7DeWYEjdR5wzaM7jkbVEH7TFOxHd3ky8cUbk6XF0dptABGQuDVLa5uLTewlE+wAb52Pi3AvrIer4EtgMfE9f85zyNLToUvWS8ivxOhxP3XtU78aER0/yNLPO6xW5vURr+paorKWKEeGieHmBUAqiaypiaZbTHm58AyVAw9Uh+xnE9P/mjllAJ7mudanpss8gVG95iggs1cVdNof1dLRG+qVJ9WmSu0nYt7ZkHaZswcHh0hlcCiy/bHeE3YvDQX/MKbu5vxpUIgRcyEV46k4VUGhlaKvE+iHDvNCBtE5usXv6Mi576aQFijqVTINurms3/xPBeviie8inEcaVBW67+O7ACV6+Wcdg/vMRF3Ls9Mk05JydvS47xrjK0dy7gVOnWZUsvo3AybKJP+K/ZAVjK2qUEUTRPY0QDrLrM7tUEjNZ9wmGf6Y+lkn5Q1w/KbIVEAFLdI8xW6SgujOZrhohgfVrukm86bDlh3dT6rhbw0z+dZY+869vhHQano2kTzuCJ6/G1q6jMFKF2Y+Qna52t2Zeaqb4vvd72JKOqqMV+VtdhOWzQ3/S3z7UGh+38mSGGmIN+iU0uHaG6iAg5h8iqNLioaiCqtzVHz+zRPWBCWUpBoPkccaUPryjKLjalTnwSM5u25qo0oR7wDTwISWp+2rDQh94hSMnPQHdgHJXVvYNCJbInt6h8zT/fReQRde46J6Yb1RX7zkLbxvQJQcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6512007)(26005)(9686003)(316002)(6666004)(8676002)(44832011)(5660300002)(4744005)(8936002)(6486002)(52116002)(66946007)(186003)(66556008)(66476007)(110136005)(508600001)(38100700002)(2906002)(86362001)(38350700002)(33716001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhxJE817NsdYyTIql6SjnsIXuYUyQ5n3rVqcDWp4GQKz3cx08P6WvzFCSssD?=
 =?us-ascii?Q?4VXI8cNc9+sFXZxeH/TaEIy6SIVRnrtoPb8LEo9bwiqJMEVmTpeVRXwKwFEN?=
 =?us-ascii?Q?Te6EvUa2CKmx1OXjnoGU2EnMSmhpkJcItXkjYrEMd9GzySJ3rZvP60hAV2iK?=
 =?us-ascii?Q?UKcac89nDJeTTubfItNunSWZBsGnYJLmhrN9sqDVgBO8aR1fiOjlLnmJeWn5?=
 =?us-ascii?Q?iEpsYpzT8GQG3Y0/9HlU5Qu8PMmk/q6vtR5OofTtv63pT5qSF6VI8aEEuDra?=
 =?us-ascii?Q?eqY1u4od6T0M42cs0YbKZZLxyBQEa+u0blNOA42xdVCq9mB0Gt68m2DV+S23?=
 =?us-ascii?Q?CU5VpOuuGvH3FQO4UqpeZh5q9UuM1+yedYMj3PDdNKLPSHyzxUT4bdMF9TXn?=
 =?us-ascii?Q?G3enhHaXhzAfWYJvXEQxFc+lJR8k3PSjwzBnUGcLbii6NP2+LshIH7MULN2w?=
 =?us-ascii?Q?hZeaG0aFOHjmFEZ7GiEIOAbvfTWd3NUqFRDGYuO3piiJe3iad3aEX7FPt1kL?=
 =?us-ascii?Q?i8N14rvr+Dy1vVH8aEACNoTfL4itQrMbAkZkLiTn3LWImQ7NlsL/qF+Oc1O7?=
 =?us-ascii?Q?azvwNg4z/D9OYx0LVOVNH0PDgdT8wQ7DDZ4P2kQENkYYtNdapSh/2t9lawcS?=
 =?us-ascii?Q?L2iKtmpvlZmsH3YS4m92ZUMGhj112TvC4ZoFkXkRs5ZksDsi0zw9n/E+TEVW?=
 =?us-ascii?Q?UqSXzuWdzkXd+XWzOz/2j+J0ev477QRwqkE2EJ/nUkC9YQi9Q/oz8wASw71k?=
 =?us-ascii?Q?cMlyC/oyhUhMi0/+PDS+1eqZemqxBufB9TUYwV8CMw7Vlsmyob2q6Q1F41Rn?=
 =?us-ascii?Q?55DX1ioshEH2Z7SsR123uZKL2PmoNcwN0YPQkqX4O3NiPJ3lMjGvA4Bmwc5k?=
 =?us-ascii?Q?2W5tjimtV5BnT/XNsLI2SkTidXs6iiAvb+5QINHmsaT6r/dR5BnrXk1o+i2X?=
 =?us-ascii?Q?slajrtHKBiNnvYn6cry3saVneUc0mtDsuvw2fgA5p8Ad0aNiCvLMSawrk5VR?=
 =?us-ascii?Q?dAmuypOfqN5dbZIHUUjmnjIZCfHdrKmV3sJRdl2RBQnaXs88JQmzH7YjiKfS?=
 =?us-ascii?Q?caOilQISJeqPk8WXCSrHpsKHTTi5CuVdSNY/KI7US7ILwFuP+lYy7OzmyEg4?=
 =?us-ascii?Q?fpnDagKyfsGGTeFVp9XagsIMuPJGo5tLdedg5PEXvewtOL76XKyNXSL43Q7J?=
 =?us-ascii?Q?WmUM3pYaqtEL10pgOCOL6jGky6NAJGPYfTGzOinpEBB9ONTuciFXUTPcbpuW?=
 =?us-ascii?Q?VZQTA5fQg4y2grCFCNtLqalIpdJLXugejR4cGRlRYYktzecRMvGGcsifEtUb?=
 =?us-ascii?Q?jZKHGrnp7yep854FodoOI//hhHJOi7uLaHAR5DvH1ZwPTFMq4J91zMDi6D8s?=
 =?us-ascii?Q?A+5ylfqoeHgKoeSw7+WzprN2s4zhzDnPVvkbwBtBLxsQQHQCT2VjSMRmiY2X?=
 =?us-ascii?Q?6ddS1DWvPexHqmKbMU01a6GVbh+xZCQj4Um7/YWF/6vBGxvU8EUqQlt7bONm?=
 =?us-ascii?Q?JU+Dt0Gg6gUrgrLkH1WVSVLJG66WJ+f0j9MA9SPMzuFExibX1CZoNGvo4h8S?=
 =?us-ascii?Q?yyVApps4fD7Dg6tE11Q1MX0uybuztAPQUl7aQrOHBGITOak7FqGWWNGyESZ7?=
 =?us-ascii?Q?XF1aNv9lZMPg/xgQxtSU1qldArVmL600rr1KQNyx4KKs4GyH1lI4tidA3mu+?=
 =?us-ascii?Q?e7nLbEouY5/JVI3/VzFQ5BWpBuG/yOWrAx4275PQzypqpnVp+wpxNJA1HT43?=
 =?us-ascii?Q?W03uEqPifWYiYqn2sFXk1e/umpciiVU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacbe7fe-ca89-46d7-5f02-08da42ff2990
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 12:14:50.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15jd58oB1POSzqK7q9sWxdZ0PpAaJayqChaMSEc0AqYuvO6BZqxdx9eUi+0NBjc+BsBYWDzCvVlj65gHw0jh/72YdiBpgvs+wMuVZk3pS9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1710
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_04:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310063
X-Proofpoint-ORIG-GUID: 1xTiQ2THPWZUfseNM5-1CmQEe1kRHzix
X-Proofpoint-GUID: 1xTiQ2THPWZUfseNM5-1CmQEe1kRHzix
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assoc_array_insert_mid_shortcut() function returns type bool.  It's
cleaner to "return true;" instead of returning the edit pointer cast to
bool.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/assoc_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 079c72e26493..552a4970a9d1 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -938,7 +938,7 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
 		edit->leaf_p = &new_n0->slots[0];
 
 	pr_devel("<--%s() = ok [split shortcut]\n", __func__);
-	return edit;
+	return true;
 }
 
 /**
-- 
2.35.1

