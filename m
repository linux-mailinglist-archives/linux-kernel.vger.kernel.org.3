Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58A5A8CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIAEjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIAEju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:39:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58016CFC;
        Wed, 31 Aug 2022 21:39:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNmvu3032278;
        Thu, 1 Sep 2022 04:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Yh4KkU7GeWx7YrrXm6GBjYyWXbPdYB5yTEkV4WNxuGQ=;
 b=m9xPlP/CqEDSOe9PsxXoXNq++adKxHb8BANzLLlc+RD3v9cqsQqwnMhe/15S4gIJwZ6Q
 Ppv44JOZAHOW6d1SKg/azpFu/xAOf7ONpUGUDTzrlBwpnRKp8C3c0Z6HjA7TMrEFw08a
 PR0kioK9z951pvdFDGhzUsxLLYZ1xxPrtYw2FqAmpEXGEXFnMkNfdugyOQbQlLXo2Ngb
 ElkaPZcx4SZdQQ9HRCCoBdGc1Y6h4RUW1Zt1KFF7zkEx1T2Ex7Mvg5fT7CE2xtFDVgau
 LZJ4p1DhaYAqQXTB/vUBUMQMjtwpS3CEzjioYaEbhLUiHjZpAwYzXcpS35AB0Mmu/VFY Nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a2s6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 04:39:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813oHMb022086;
        Thu, 1 Sep 2022 04:39:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q5s8tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 04:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTsf+NNk6TlN7yl1x/lH5mv2BMhIn8PzQf4rSsMwxKwEuHUnOvyQNZABA34un4AgEuj90iU+pUn7j5Lcmjrl1E521gxy6CemAmjRt9UeqB9nq3z7oLukhg4Ot3pZPP272KJIPX1Axn8S8kL5UchUHM1BsE+X91oV+Nxd+4h3incIPCqApnqyOhhnn2ghKcFHqCFpC4uV+wlwyey9Arek7huvBDqqLlzTtl1YIqZtg0yIx7pOPj8HrVZhBOgRRfBRyqDmcw2pqy9MMRlXLgp+ZFkgSiCPb7n/nAImiivP0Nf9ID1UxdSCe4Ok196aFMYmf/8vTc/CXMwPXxzZxW5BmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh4KkU7GeWx7YrrXm6GBjYyWXbPdYB5yTEkV4WNxuGQ=;
 b=GJP7Q94bVPhN7M3WJRQ7bUtRw/SXFo5LKYgjiqRioaCRwTVJkDiP6OYI0a6UwEKqJpVoX8BCWLuDN/V3wr687rsN6eTwIU5pkR/4T98X8cZP6m5cWjqFc9mkRX9vWHYgh+sNHkedQ/oPFeqzr0UvLDOrAB4X5qHhh7I/cqbfEQzeraSslDm5dN1cUg/I5gkB6pRToBZEokbwnNVNGtMaTlWnHszWn69lievsO6e+lhraK4cPlu4GZjY8FoJchekcLPLU9dF5cOl00G/9lOohqRYhj7QgrXBatwzCQoCP5HD1reYV3xLQkB7k+t0gM1K7TXFe+jYSRg2orRXEBZO/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh4KkU7GeWx7YrrXm6GBjYyWXbPdYB5yTEkV4WNxuGQ=;
 b=wdhRfDirsLzKV986lH9uv/XE3PydHDpxE54eb8XvChN+0YCTSIe/YJMPkZuxqzROB10yvgelJDHuEoEE1YFOzHmu148hs1+jwCCuPVrPfHJnl7k2kjSSMtT4/gNo+pUEfIrXa3jVJQ4GrfuUtxDQCLPK3QZO+VDeyN+hmiagxdY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 04:39:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 04:39:38 +0000
To:     cgel.zte@gmail.com
Cc:     martin.petersen@oracle.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] scsi: lpfc: Remove unneeded result variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ler3lncw.fsf@ca-mkp.ca.oracle.com>
References: <20220824075123.221316-1-ye.xingchen@zte.com.cn>
Date:   Thu, 01 Sep 2022 00:39:36 -0400
In-Reply-To: <20220824075123.221316-1-ye.xingchen@zte.com.cn> (cgel zte's
        message of "Wed, 24 Aug 2022 07:51:23 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc30fbba-8177-4781-1d50-08da8bd3faa3
X-MS-TrafficTypeDiagnostic: BN0PR10MB5191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0f9kfIRAFi7V7fXZK9ihb/5Q8zpusbhJ+ZSmzWaR7tA77t1e/ySO/h5OA/foJnEIxtwmHary6E7E2e5cK3MsUp13BUQBBl/LuaXxEUUNXyvc6pNDCTVw6qO6Slime9zL9AuCB3OwIgoIPDhLo9zDLKeoYekq/WVngiYwyvbqMurUAhTqrrLkFpRMSKzaFMj5QCtnCYVhOfOUgvk0GLaKytL1QEiYemFYgbg6moDCZzSJG1xLiF7cIW88J4JGPKuadsj996cAVvYz08cf9y36Yh27NVHqKcCbIMU/B9KcD908bJ4sVD70ljc8daAYGCJh+l4oo/9QCSjYH7mmkt9bUlepua23aLpfiZXYluX0g1he6pFsuNrDAxaepj/gHQskUMnnRdaMLnkpnuFilFa/7pF8VvS0hEXDFnpDfWuAuPnQVFbnVIHAR0uR+68Nnu8welFs8Pk4Blkt/8bFhNGBezASN/k62BEe5k5Wlue/Sr2qxN2SMfVojscNnlUK4IMPYqEOaBGuISu6JoCCOFm0jL3fnw4X87ndPnb9Tbeia64Tsq6KwTFRIvajpDu7bciPd/4/rdWh8MFYBstWlOr/K3DWZCsoxUNdEdGbIWexkVsMfLGRA8Rwh0k2NFl5lGkW8qOvNN9SwI84JdMoXS9rAoVEQRwtkZlFXjU7pc7fyYw7bvo1kYBO0/fyZR3s6v/8EMHpiUcmtZOHwZ2X6IkGnJ17aHA2dgrARZEYK/zq+kCc0yl6QHnukMp3hapPP/itecdDRrLhdzmw+x5Rfg/TVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(136003)(366004)(6486002)(478600001)(558084003)(186003)(41300700001)(52116002)(86362001)(36916002)(6512007)(26005)(6506007)(66476007)(8676002)(4326008)(66556008)(66946007)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJVfqdBKr8G5B30gyrsuJz2zanlfV0fQ+pWSUKoqXejtohUE0KkAN3YmwcR2?=
 =?us-ascii?Q?k+2Ybf2qmWRXV7UI31B+WNfNOHVVD4bbi5oAozlvVDYKWpTTS7XupAhkGA/C?=
 =?us-ascii?Q?nXq0umeA4ZB13gwkOt56c9qRfLNPLJyCOxaKgKNYpYh6+clYLWC34COBFVzf?=
 =?us-ascii?Q?X7scOCfV7kamEPAnnNBL5Nl+Frq/4rAxncEES2L7XxBEzDnzJY7/AJmfNkzP?=
 =?us-ascii?Q?uJ9ucCTCB7K7lE2msFS7c2J07nQniktgk8nqJ6I0UuhLt+VGpW34mfLs9Mwv?=
 =?us-ascii?Q?6d9t9tYt+D1Ju9UJcIU/49n290otNjtE9cy47GdODgP3GuoC4afd3mix5+bo?=
 =?us-ascii?Q?TE1hJsx6zbcNa+HLGWbVTuzDfQN3om2OvSDUnapPhpUdh7jo8rMfVj9WX6nA?=
 =?us-ascii?Q?fdwzl6DoCBxclOG1JOhUh9UE0auH9rcJMS/KMvqT9F6CWYn2kfTZ//9dwqFQ?=
 =?us-ascii?Q?9BnqLBPNacSP/xHRGM8JmbjK8ob79LaHBF2UXDnVSd/Gzw3jDP0pgv1thxJY?=
 =?us-ascii?Q?cNJEI//ud0JM56rxAHlh8W2ECCOhG8i/V2IjpRztK3vUMGbgC19W7hh5iv/l?=
 =?us-ascii?Q?CIKGRpapzaLPfkqF9JDxV6xTy5dg/xO+mEt2ub//Dodn8WbB1O4zVqAI95pt?=
 =?us-ascii?Q?mtN0tVCAMwhRNpzXsBOIPaMH+UXGebeb+l3ucnC1H1ANeImeIT2xFY9BjLBT?=
 =?us-ascii?Q?N5CP+ji/MIanYkOIOPaQB8ToBc9MWJz5N8eMGF10RRpo0d8kFWgi1gkjipmh?=
 =?us-ascii?Q?aUkkYrQOx42Wt29k4RFzJsjrMa1j+RZyAzrIe9p375S5lvdJZRlAKoEDLEMR?=
 =?us-ascii?Q?mzw7F7bScoa1nvaYr0RHbfnFaDCXnP8MGswTRgKLl+0AyGxP8OEubCa+BZur?=
 =?us-ascii?Q?6WOWggIlDbgkR1kt3qzDKRGsoM2bUcyYuXLAvylCVtFdc5tv2HFHN1lg4t8o?=
 =?us-ascii?Q?jw+G7pzqkJpzNNyBZEbc3oUKh/M5X3q/bt/DBjGWBx/uWtnoj5L0rv1btKNE?=
 =?us-ascii?Q?MhTk2+Rdxq5oN6QjaL/qRQeQR6Vz1jHx4xj3xx98cjtb95+BWRvvmx18fRyJ?=
 =?us-ascii?Q?+IR03QwDlg50H19VfIWnmfSnC7DYq59N2/MXBVuJwT0EoHbdDVjhVBKvpdPD?=
 =?us-ascii?Q?Kok28kgI50J0p2565kittqIrhKQMhCdffkOP35V7blPiBZM99jiN6Z+BJgWM?=
 =?us-ascii?Q?ea08TF186IHYrsZb0Bmn8Xpp4+Y6ZAX0nPM6md0NODng6CxPmAaeC/egOe3t?=
 =?us-ascii?Q?RcWvMLGtuiQlAafo2gqEVa7DZnQBSh3Q4VuWEol/Qu3mysz5ekLdztQYzh7i?=
 =?us-ascii?Q?z1djEDwp63zr3WXX7kNfpZgstJXc0EgNGcYdHaJpOPeC8WsGa5EfDxOrs+OM?=
 =?us-ascii?Q?LegeHmImi5ZtIY15E79rQDLuSxWPMKwyRJfA9Vs/+8HKsJ9drpsDVMKa2rEq?=
 =?us-ascii?Q?KY1RtA7gqZb+CScuRs9UhvCNZ8mGcfLmqxX1GWwwH8tOISkOSvcXuoUPfsw7?=
 =?us-ascii?Q?pRaFgBlz0WI8fgPEbLK26x/LTc8Cjl9if+iubwMVIXvsrZeD0WEY/BC+bGeN?=
 =?us-ascii?Q?usZIjPlcy18adzkXZVfxjR//p7tu6eSR0UPEPagz6vTngKVqeTg6RXmZmDiq?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc30fbba-8177-4781-1d50-08da8bd3faa3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 04:39:38.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCN+cDVRk1pcD+VXnvKgpCZ4YXCbd1s9VHQ6xF87dW958abzRhgQI1FojcofhFzSQSrn209jVoQETcxdEudk8GymP6kRip0xe5TyuGNIm6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010020
X-Proofpoint-ORIG-GUID: orhzVGeDYeXmLAZgZBH0QbpTiAEfPQhO
X-Proofpoint-GUID: orhzVGeDYeXmLAZgZBH0QbpTiAEfPQhO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Return the value from lpfc_issue_reg_vfi() directly instead of storing
> it in another redundant variable.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
