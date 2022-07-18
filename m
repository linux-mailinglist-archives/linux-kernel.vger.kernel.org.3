Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DFF578073
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiGRLN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:13:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58820189;
        Mon, 18 Jul 2022 04:13:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4X3r029439;
        Mon, 18 Jul 2022 11:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=U9bSBoQlIl24xzjYpYvuVoNGkFnnTeE9X46ydSrf8JU=;
 b=uyqWYtjsVK+96jzS/xrqwBgcMJ8004KoT6lzzSypuFV7g3t+IgbxG1exejmYVNeBe8UK
 40kPimtOoIhpF6GmFFXsnYTmQdwdzkNxKuSOwPXztM56LmyslM9V0ZqONarO1qt1ml9p
 I+jQQ8y6sEOuUpjOxXL1c/QQHa2wrl2417zdD+j5zmDlPPnxMrOEtVgGSjv/7HnDaHSx
 6adrH8ZVP6G2FjTRrXdc5S5g2x7O2hbH0nh7YmZ5w6NRtVBVOr6byj3rlOjyek2wW7hl
 LP8VbOY5jUsThQVE3hTGtrkhF0bgftjKMhaML3Vnh0PuDW8yp22Q2MjNebnDtgsVmzyg Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0u0wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:13:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I8PWGb004030;
        Mon, 18 Jul 2022 11:13:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3qjk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozs2fHIxl/EOqIunliWW/UD+N1Be2U2TPhBZcrOPPCloS5XHtY3ncrN5jU4nTXvsV5MttlOKa0/j8s4ScKjzo0vGan9xjcFuJ4r9IfyLdo0eEK7XSaMPTjsGemikRzP2mc6g15aGwj01NooxUD67EDwMk9MlLyrrYJ4NZRk0Pkkm2PZVw7Yk4vJjeJ9+FrDbm1gMAyzWnR7HpzmL8gNbaa2a4X5M/RLPE4iLTue/bt0Zoi0zmbqNRmaNMed/rFWa0sTTkc5N2SbLTg0iy5uDQRE+z5VODLZrpNSO4ifih9bvDJZtAAj4PG2y5vYjHSaKmmJkSJNlKmh/wp0K8zF82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9bSBoQlIl24xzjYpYvuVoNGkFnnTeE9X46ydSrf8JU=;
 b=A1r0DjJ53NxmJT5okgoBblQd9bUDeJ7eV9q3ctqfZetS+mWWDfuqQoXjVD7PhibZsOOw0u2MSHqLY6S5kRqkSF7UKJgzbe+xsHRCHusJenN753KcQo0zrq85zbqGs3DwL8RyTBiBWKzU233Rpaz25kJT78xon9amXGrLWj/hSRXHK87sOjy0FI66SBk8l4TeXhW/SnzykDARu4oRcSWLMDhpeAb3lmtDiT81GWyBOcMlSPXdlWHoHU+l2gbgbbCYgNHt9FyzsfvfsVbNM0MZxbssAVbQ+EnvtoQ5Afpfoqn070l7MrBjNrvj2Vyu0diysyxjngBwUFRRTSdJW16oaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9bSBoQlIl24xzjYpYvuVoNGkFnnTeE9X46ydSrf8JU=;
 b=CyFE5bLO7MtwEt8xgIdtXNn8VGtV96/UvesfI0JCcwf2jblM3szpq9o0dSNk/qFo7k6kMtYZ0GhXpIt7/lgp0bUMwadsTGgtZzJ2wtohhth7M7RKo3LFLvnFa9FMnF+6ohT8Eebz5AUN0a6VBU49vIhySymtVxWuWCknljPMwoo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4757.namprd10.prod.outlook.com
 (2603:10b6:510:3f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:13:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:13:18 +0000
Date:   Mon, 18 Jul 2022 14:13:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-auth: Uninitialized variable in
 nvme_auth_transform_key()
Message-ID: <20220718111308.GW2316@kadam>
References: <YtU/bFMYRCrx6tgp@kili>
 <YtU/tS/E2W9m+aau@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtU/tS/E2W9m+aau@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e33b238a-defa-496e-cede-08da68ae846b
X-MS-TrafficTypeDiagnostic: PH0PR10MB4757:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vvr7kgUz93vHvoHhXLH8itLvwzHU2Wcu9u3oFtqEOm9CtyCEXa682/IIzJpJnEZ8cPWHQPB7eXuA7sWIad7wV/djRQgXStwjK0G9Z+xum/0BverzHxZmIloNismt6aRecCgqIGSgPeMPKJrlLq3vEs6RcwOmOsVaLz9g7Yo2kXF60ycDlkeSvPZcNSp6hkRfT93aVdHg/ibX56Ae2hBKSIQgUCce+w8gUkjoOqF4z6Axr4gapCw6b1Ozu/6nfOsitkk86o0jn7XIE03VDS476uXMYeB2+CHCxv+Uz+/UOmVc3sWO50EjrNFzBoLcQrA5QAiGRTpsHD2wyDQbxPfzTMrf3McssUhqIiSZrrsLend5dvSHcC2aevz8qo0wIdiDFfLiU3mjg/pFSdupF5q6EcZvyGHfRu/j+ogHXhjh5fW4XqzxqaEgSf6VG3m6bPg3XYPTt67p5/d8G9wtibIKNe38Axa6uuYSOINzYCi6dJv3IlDlzig02OITUI9PKd0ThggsZPEGkgnwNP3dprnTP+5yGKXdIIkxC+aCG32/JVwxce0LdtQjX8QhKh9sLx7bAo38OOIMPuH9PScZvjlsru6Vo4DRQSBxS5so3HNFEl8VcJGdlrzKA74UZJS8117Uq+/FgBM2sUh+KVBlQFKAP7pA5MQZb1RG5gx+J/abn6bbc1Bmri5n+GJ6KKChoE/ltxv57QJcsQN/KHZ8Mb5xecQSQAKHW8M1coaluup3JBRN3Qg9OwAgQAW6wpQeHh/CWMwE9nL5dg2xbUfZpmgQ8QDZFCd8qF4RtyXw2a7/Mry3x0gHn3ckY6KSFzjDDIq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(186003)(6512007)(9686003)(33716001)(52116002)(41300700001)(26005)(1076003)(38100700002)(6666004)(2906002)(6506007)(86362001)(6916009)(5660300002)(8936002)(478600001)(8676002)(38350700002)(66556008)(66946007)(66476007)(4326008)(44832011)(316002)(558084003)(33656002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5eKNqPgTcZ6PJfeTHJQvpAhxRBQSQKsvsslapEHIFRas4djqGMVk3HCLFTu?=
 =?us-ascii?Q?G3vxjfBHbnoRKXiOObeOjuGDMuQpIjmoUDzf6trfnEo3Gef3HCwPi4xiQQ0W?=
 =?us-ascii?Q?1w2hKiYMkHwba8TMc/U3s5UWWfc056rCxRJPrp3Ov4AWsdo0T8bMQNv4sWbv?=
 =?us-ascii?Q?NPJUPEMh5G9yRBiS4Rv3bGQttZnD2oGA3lVqMDqDUs8yYRuoi34W6eQA1dww?=
 =?us-ascii?Q?BD9tgXGk/p7DoYSF+VPSE8b1+oV+LxWv2lM5RlFKh2AodtFOjZK/GpEFBtcS?=
 =?us-ascii?Q?YweDBM0U2J2PWd4ERVxAZkxx5UFGgI968Ozo+ccwsfvKdIVK+aYVNUY3kkbX?=
 =?us-ascii?Q?4U3EV8KhiXDuMOxKXbDes2hh9CF1zFEem2tcasrcxOw9Ja3p/pNLHjYGmb/j?=
 =?us-ascii?Q?VzBV4xu/WnKAo0m/u2OqFaav+MU4isZee03a98KXitvMbvpvr0YcewRehRpu?=
 =?us-ascii?Q?XAKjmkMu88Xgzb7hZOZV34PSgDKtGgM9NevV+y/i6VsYJfl1DKU64k5897km?=
 =?us-ascii?Q?UzAuimKRLiJW2GNP+UlK/37CNOnx0iPuimLSbWY83ncnWg6d2Ppndt7Ntdw2?=
 =?us-ascii?Q?W67WxDVuYnk8+S21ors+ztG/KZE3S0S/o2XR2JhVdbNGr6y0X7NAPFUo5+N5?=
 =?us-ascii?Q?WOR6MrwZitFl+U2mrwoM02G+Rc7eQUY5sF+zSLTS0ITIwITrWGl6pE8o/8/W?=
 =?us-ascii?Q?SDhX685z4jXLZrxsIbs8JjR6Vj6vrpJ7LlTEMxhJAYRBvf1M7iuy8gRDkEd2?=
 =?us-ascii?Q?TUaG6qDgsjwFVfEjETceHsG8Ofd+iWOr+JYvclBTL7YOJ5vvOu0wKIxZU+JU?=
 =?us-ascii?Q?z/SAcyTFkf+18OwIad4bFHzDeBNGRcbY0b/5WCxAzzdtbQeE2LdM5H2mdh0f?=
 =?us-ascii?Q?n/rwG5b8ppvmPymorfqMeBJS2TLVosO5Tx2xKR6mvp5tE+e6UgvTkPUbCLtu?=
 =?us-ascii?Q?VE2UegszQ5o+cXn8TIBEhMlU/jeTDUbdOozOggYafjelH5ihzY+XXqOHDaF6?=
 =?us-ascii?Q?iJ/rs8uGc1iO4u+2KnWrEBITFmV3KEABtjH1Pm+ISymHZe5CDjzoANRM0eBI?=
 =?us-ascii?Q?17zGsw6GZmqPq6Y6yDXYMJgE4VC5EBjxWcWcwu0tS3bg8sRSV11P6DC5uJL4?=
 =?us-ascii?Q?oiIQkwwh248e4k8lKJ47AvL/eo5Sf0gRkpBoLVLhUx3BulOypT84c6IE9bME?=
 =?us-ascii?Q?s0CKJigj1p0YfX/ksTz/MOFKsMaNw0cZ1P5gmBe+Mz95s6uE92YGoJqCm8Tw?=
 =?us-ascii?Q?rmijU+F7I0OfGAx1i+OHSkW4OIb0hNJMNkblhyXSr9N9Zmy4SK97W30k+ayE?=
 =?us-ascii?Q?17yzymG+T5MnBZvGGm+AnHAJf2Mx6PCwMeWPvoY1GEPyQMJMeqVyYgQU5HIK?=
 =?us-ascii?Q?NobcnSWXEiUCCBsDZwHsM84HVF1kBxVUiDfS0j1TFlmyM+isbjsc8ey+l9l0?=
 =?us-ascii?Q?1Lmipx8HJR4o4a9Lc0UVZ8m1m1aby0vVicx84ao4dj4MatuMrwedVuCueJ6g?=
 =?us-ascii?Q?7zRy514CiorGqEB9l6PI5vTQAbfkx4Y/vpTbh+wQ2ti6E1+ZsGuO4ryFovKH?=
 =?us-ascii?Q?qVlQTAakHtHSJatRr7iBkKK7BoewXhUgFLn/TQFwULATE0h6DOrbE7Q6SxxB?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33b238a-defa-496e-cede-08da68ae846b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:13:18.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vBLYJsw+KU534sVWzhnABBIvfDurA0Sn5834RftHo3VsaQKri+d2GL9rPycVTlJpb2VdyknbiXiLQyM1JwPxqD+FgiGgOxcbjpMer9HMY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=862 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180048
X-Proofpoint-GUID: j-D4G3F-KyAToC9gtjUANTZlT7LlxewO
X-Proofpoint-ORIG-GUID: j-D4G3F-KyAToC9gtjUANTZlT7LlxewO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the subject was supposed to be [PATCH 2/2].  Do I need to resend
for patchwork to accept it?

regards,
dan carpenter

