Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA65153B1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiFBCrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiFBCrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:47:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FF4617B;
        Wed,  1 Jun 2022 19:46:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251NXnC2021611;
        Thu, 2 Jun 2022 02:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wRhvqI/OKITyjD7WrsmVXnM+zWAvzcxW12iujurgO/E=;
 b=PztaEQ4kTxrhINQ+mgwf2KmCN+j872tj64CXmnDd+bfLQB9XlR8gXyDSMtOs8XPqBkZs
 Whbd9Yo1M9kNZnJs/DnyElPgvLlTKlh1PohPOrE/hbRlgZCLb6Ax31rdxzz9K3FDss8+
 uRcBnZx1rBJe0oU6bWIdqkDqEasEjuziEKVrDIlxG/P0ePVVrTWzw1W5QSHlBV5OW8UP
 hrApgLzG0DagAvvEGvUHNaqkxVRAZqDVd4qfMNv2CxxAA5HSCymol0CszmjV6zY67sgu
 3ZBCfaPrtsUIV4DXnoyby4+i7oDO7bij+LzifIOk54AAxc03Yd6pZNFwg60ZTk2uvu14 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x99n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 02:46:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2522eAi2008923;
        Thu, 2 Jun 2022 02:46:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p4f1nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 02:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbh/lKBUSojcqLuF3Ouw5KKIo9kKOENJau6ZHdr9ewHvpohB8zCriZ7UZjWDNqm7Ahfy3iab2KhPFPjmbqECNvjwQFKzGOe4w7O6byo9TMCBgHQ/msrCcXEOJ/25Ve0Wk+ODMgI2Lgnrd9PTEVtzbEdAIX1QY+7bvc7PfLwUl7zSFnUx2Y4OCXYL6DRyCCklXjoooDugHT/SfprYl/pXEzkNVymMKJ6rWbPyp+i7cIq7fHMbyrHl4OuNX3ABUIOUNXIdcLQ1Nl9nEnlbtaMY8D0sJ7sgiGJGDz1K4EhQGi3AuXYXatEp/TAmTPDC9idsfchiLtBgYrslJ1f4jwR+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRhvqI/OKITyjD7WrsmVXnM+zWAvzcxW12iujurgO/E=;
 b=CvXJPYbBb19qW6ulzl5sx9GRVmBVnDzWRwQpe/1i4WLrECQzOTetF6Mn3Hbv8CZy9MOfz4uJUx8kbA6nqzNQaCw+A2OqgxQpG5rLfXP4dsaFvFy1qBWFSfFvNnBppdVHvhil7BKw/LbkytOm6uCnPog1SyW65+M389X0+2FGlOMhuBfVke7LYB2dqhg7TELS8uVoZUDCD4Ikt0NKfkPIFfKN6H+lT/sXlo629Wh3WygVz6738wx6ZzSDfS7FZpdDtQwhj5DwS5ZZBuUSl0Ec3DG3JO8YKEE57bI0msVMY8BtlLJSC4LEY20BMnmt+9f5NZIazeLvLRGElLux8/HDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRhvqI/OKITyjD7WrsmVXnM+zWAvzcxW12iujurgO/E=;
 b=RuiwMRGXvdvVyCj0qhd+r5RffgAQtmS0m7C9kM33xs+yV6WeRLwdhLmWlrOvf3/XIvC/88IHZFaUdhUasfVOYhxUNI2Pi74AblsOI5snre+YuDyj77LPS6LvOn14ed3yl31aBHTjcOwT+pk0cR8W6v3u86ZkgcA9KTSNqW+xmBM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 02:46:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 02:46:48 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: remove setting of 'req' and 'rsp' parameter
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wndz4wad.fsf@ca-mkp.ca.oracle.com>
References: <20220521201607.4145298-1-trix@redhat.com>
Date:   Wed, 01 Jun 2022 22:46:46 -0400
In-Reply-To: <20220521201607.4145298-1-trix@redhat.com> (Tom Rix's message of
        "Sat, 21 May 2022 16:16:07 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25cde736-497e-4d6f-4979-08da44422384
X-MS-TrafficTypeDiagnostic: DM4PR10MB6158:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB61581C05B2264834FB0716B58EDE9@DM4PR10MB6158.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cP3Oy3RTHo7Rki/JjtbVr9YS67dIqMl8olDv5BBbFKvN7qH65Inr83o7uxKTssBbn5Z6oFtGWvg2+AoKngoe2lg1w+EBmpgFYZkIhiFDB3ZFejL4M1MmMqfb88ZLcyeCAz181l7cvpj/fY5hOMozU/JyMqlmxu/UvEZalC4ZoebbE1hyeeBeTHJwcmfc9Ipa6o5zFRrqUClxrIVTFBkKwTN9py1TzS9XvSsICpQ8hllM/PB80Am3dTF3SDTYz76U1J3AmvcqghXnYsLauQcagFHbslOA6++ypbEY6V7MnH2Tt9Rh/hRrmJCMyraDzQU8d6YGleWidRaoy6daWTmvollU6Ny50abbMxE0w5m2nhskkXOytLRGjaIg9vwuJp65p6Gpe1iGpH0aRqjPDwpvFeCS5RbWWaT0iJevEE+IqOt6ZHyjteVKv9csSrCrpd94DAAwg4+fRDmDxcrPBvA0+Nqek5CyjDsvA5Qv+2QQzUkvbDUMrhlyyNXhAAER7+kYvKrY3UkvIfps1Wo1wHI3nhnQy9Fe91JtrMj5lpnAXrdHIGJoLjxuOVe7M7bPjHgBEvq57XPugNC/ltn6vOrcuvV1+0cuP9vJrdfigh+yZPa9wkAM83YDcjOO2PQ1jua9tFnBKUWLkMWb0T4B4btEE4R5kpGMbA05DLY8cp1azuf+cDfmE6DToiKkoUeJNE9Nil8vrkJmd4Hzy7Hb3ULy5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(5660300002)(66946007)(8936002)(4326008)(86362001)(6512007)(6506007)(508600001)(38350700002)(66556008)(8676002)(38100700002)(66476007)(26005)(36916002)(6486002)(186003)(316002)(4744005)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C26DYkRWMZ6tbkLy6f+Wox63UjUMQyaKpRO9GqFFillD/GJb63aM1Y+qP/nz?=
 =?us-ascii?Q?jbLExcxjBxwgp4AcnhtjV9+tGzJWZkCKIGP+28UqtEP4NkqmLdYzigdn9nyM?=
 =?us-ascii?Q?a2Uc0xTdMB8obLPeAMkkSmqm0oixtgm0roVWAnMLzG0NrEmDal/wqVoy6Y/T?=
 =?us-ascii?Q?Big8kHErnAaVARR/Kw2vt3KFWONVzrN6WBRp19q0UmhoIdc2i8JdHs7EAOnz?=
 =?us-ascii?Q?rp5LWZ1JNxIAV2qgHFnknOxKRabVwH5Ue378ATGfpDyPLlDnTlyXve4T5XDr?=
 =?us-ascii?Q?n6ZXBkpCP+H0abw/1ZQ7GahoeCo+Um4E0Jjg0qwUTcT1k4OMQjSmKEZo8KFU?=
 =?us-ascii?Q?M7JPUrcdCs/FOtvXScleQ5DT+gDR+UFfY0W5awYs9+xnb7xmm8vhcZumZ3Ti?=
 =?us-ascii?Q?ALtB2OOBD2FlcjkD1SneQCI/7xtYdvbljvBr7vgDLD8TzGkXyljznWsfUN+S?=
 =?us-ascii?Q?1QkJ/qsYaC0e2O8qW04hJY5xTJjTCLKQ3FRREHbuF3GUrt8K0e3a5xE0on+K?=
 =?us-ascii?Q?sAIrLeV7MeMFjp/7M/zgDhEQ+QbWWckDgJZ0TLG64CJ3E6MQQRrWgNZLGIyW?=
 =?us-ascii?Q?qTpMnDutDfjMsOnxE1P6NCV2M/Hs/m6bXJi4YSQW82FAGGj4JJ9K5SHX+f39?=
 =?us-ascii?Q?b+E3JaDiCr6RExVD/RaxzRfgUiTk9XkHqZFJctDQkkZ4jl1ivXaSmihfNdTp?=
 =?us-ascii?Q?eurWu4ZNKOQyVXMUFQzolU6ZQ6/mwthRyr1j7w708yPvwZoStCVKGdT8D0Rr?=
 =?us-ascii?Q?fZUW2o+NC97b0yBHZzDRKX+K9Yu/5pLGobn2sKKfBDaShV62jc/fVey63X20?=
 =?us-ascii?Q?9HzaQUS/vz4JgfpsrZ/QKF2LojzkfLvSWlAN48oK5UvhQJOvXPBpHu7c0ccq?=
 =?us-ascii?Q?lEhBqp0CeEFuJn8SsCZLxqKpcJcHVGo6Dzub1hKNdLWpwyFxFvR7abYjwrir?=
 =?us-ascii?Q?epIl+U+m7qoISTuV5EVVEkIegC9m8VBVped8rXnlyJ+F2IFIlnHpGMC7eyOO?=
 =?us-ascii?Q?AR+GrjqV10mscV1rNhmCX9+RBp9boj9prMaSwfslXCb1DnStzET4OveDhm9O?=
 =?us-ascii?Q?PiV/Z3upORDCoBz7wB5UmVd0woh++xge5R5llnrbXYtwZnJY9Agx9I93heho?=
 =?us-ascii?Q?pr06iZZN3nWRxPXdLVBxO0FgqzEwtOXa6zwp4U0UJ4td+86HZG/fpSYAZZjX?=
 =?us-ascii?Q?gqFazpz+IlDFrXJ4D0mqs3tCnNXGMXoFZcIfFl2JjSwRzfEg2stDT5s70doC?=
 =?us-ascii?Q?m9OYl7cZ8l8X5XejhvPZLZdRhXXSPotZHEEvyOSphOPa2h2N9LgjRbgen5eI?=
 =?us-ascii?Q?IHEWcQ+SEf9+NvMHF4MAUHR/bCwgNSxoD+KwlGq5wmYv7MkD5S0vw/DnDkaY?=
 =?us-ascii?Q?eU7sHMA/UBN1HDcGd5+mC8erbvtsNXhOqHuejRTyKp9trA67wwdwmi9Bvmc7?=
 =?us-ascii?Q?F/meTMdwGaxdWZanD61s2PYQs51O9MxAR4frhl+bMygStyuoP/N3Un3A/MCN?=
 =?us-ascii?Q?jwPOWeNwiRyz+y/m3l5WnVARlfalMi+da9yNXz7GHZ8y9T21SbeX8mFapyvU?=
 =?us-ascii?Q?+4mNK3mXWK8suyuMEOqPAaQi7oegrpc3Ut04pCO3wFqEdpxUkfnj/R7GwCf8?=
 =?us-ascii?Q?y3d3dDnwQDbWnhAFhHuWjLWx1qlXYw8AgYjVY9j2hRaZPHfp2P9/5KZol44C?=
 =?us-ascii?Q?XihPmbJWenOM1E+TmOyKXFyPnhSuOh07pE2m65hWyIXiGOx9LXXA2yIflV29?=
 =?us-ascii?Q?uQaqYc0S5I+gcxVX7DnnHRQ8OPh1Syw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cde736-497e-4d6f-4979-08da44422384
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 02:46:48.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvdMnp+j6506iDYPYSc7QkiK73xE+O9rg8fGx4ZYaYjDXBlb14UG78ZIj8Cd4/cKFFBmcDMrGzKjSbWqyyyfEjxnI+EvxvcgvdbrmDEzbmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_09:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=426
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020011
X-Proofpoint-GUID: EFfF3HSu3ASvU9cILJYToEkvjgftnVk-
X-Proofpoint-ORIG-GUID: EFfF3HSu3ASvU9cILJYToEkvjgftnVk-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> The functions qla25xx_free_req_que and qla25xx_free_rsp_que are
> similar.  They free a 'req' and a 'rsp' parameter respectively.  The
> last statement of both functions is setting the parameter to NULL.
> This has no effect and can be removed.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
