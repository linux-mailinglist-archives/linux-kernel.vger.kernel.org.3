Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3BE522938
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiEKBxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiEKBxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:53:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC318629B;
        Tue, 10 May 2022 18:53:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ALxZMi010445;
        Wed, 11 May 2022 01:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aAm+qlRRABEECrtswoTxpZozVIZBvoASh6h/tstdI2w=;
 b=xNzjLa0QI8x4/gb0vSzrokQ0/ozhX6SwshhQG765w1h1gILP/yjdik936E+EtOGLJECT
 x6wnIYoHVw2MYmFlkUMmF20XboqII1Bf3fv5QRyN1bMnRSZHxcmFXA7MDF6yzMkVbn3Q
 Vg5+6jlOcpbar3xYxARgf4yAizn9N4vBN4Yzinutguyfho3l/JpsnqBCGeXBH+GaMUPq
 tP1Ti8/DOaWDxC3S4MggWX+XiUWCaRYcHzRlbyJiimdFvGLI+vtT/KeLmdAy5hggg6kO
 ZjqU75m1nq9/yFD9hNtdhw/aoQYy04CcDI2Kcm+FRvsnv4PvJwRE6sFDO/HCZ+9g0RUd ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c86nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 01:53:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B1kcsk018358;
        Wed, 11 May 2022 01:53:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf73gpyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 01:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl2EpOELvaXoCSrGrA/WegB5HGG1j/bxkLffIXcWGC/KKgRSe0SO1dV9N929xYLLCyrs2CWTe2XoSBvYoy4tI9nsq5BeBlYh9fVkQeFgDxvD1xbCuhQ9sDqkT8WerEZ1Py8nrL8GYWBL5ZKxXZg1GVXnng91IquKzCnlhnaCbkJ4eIn4E5Pdcvv+uk+8aZEN/fKyJ0Nvw/X7AnQD0suyxhrwTwL9yTlhHkcMpTbUJs5xT7aHKhH+c5Vu+lTuAK2fxXlqhtkzEfeoEwJ7/BPbxDEnjxN5kekTrKHnWt6FPcEwCvR3uqnH4tAcbkhDbFxc48g9cJ2EBHDbqMyPwKtQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAm+qlRRABEECrtswoTxpZozVIZBvoASh6h/tstdI2w=;
 b=dxmevZQLhiJ3ZbWPGOH1m6rsxDOqbbBJkIxKMTwd2r1NrqbX7yUpm0xKzi6iADRsfVxpJHEaf3j3doHlZ8ndiQHJEbdgx2ySyGwFlPe6Da3njLoZWt/xiYvZEQ8NrQ+1loa8jYuO5KxlDQiavaqzT4b0nReyUroEfFeiD//mMzh2S1smQ6TMJ7VHEcRhRWUECBw+yYfJw+YQgYYPG08T8Ev6pHgUvcbM5ytnhgJORjRMZYjR2szug6nV90j2Wb5X1mvvIh1A62N/xx+YU9ny/XnSFGTv8aQGe8i/8P5uT87SRBjezAI2Uf6GxPIkcoivdY2lgfdEq88Fy4juKJYQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAm+qlRRABEECrtswoTxpZozVIZBvoASh6h/tstdI2w=;
 b=vQZX3lb0aiYgJyzFKyHC+qIFx3xQYMD1+LiQv+AK9iRt/IU3QPVaCO0AJYM1jMs35jY/ZqadOEcVU2CHKY4Zy0GSWj4YYPzd/Sji8byOqXB7Xem9lg1UKfYAyO8ICtApIOWaYspcAZeva6MoSZSbqg7A/C75oHl2xg0cXKuJ3NY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3733.namprd10.prod.outlook.com (2603:10b6:a03:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 01:53:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 01:53:30 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com
Subject: Re: [PATCH v3 0/5] Qcom UFS driver updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d6s25te.fsf@ca-mkp.ca.oracle.com>
References: <20220504084212.11605-1-manivannan.sadhasivam@linaro.org>
Date:   Tue, 10 May 2022 21:53:28 -0400
In-Reply-To: <20220504084212.11605-1-manivannan.sadhasivam@linaro.org>
        (Manivannan Sadhasivam's message of "Wed, 4 May 2022 14:12:07 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9239077c-5869-41b2-13d0-08da32f10c80
X-MS-TrafficTypeDiagnostic: BYAPR10MB3733:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37339B984A19BC8E67BFE42C8EC89@BYAPR10MB3733.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psYfq7i41wbAaohk3cSuOP2ji9p6unVBoypDwvFzi7HTWaFS20YMrdHJ+Et7pdtEDYbDme9Gx6hLupflYx05KmpLklrtlpLg0bgF64IK2wKl3vrJ9o9ee2KFGEeJqU+jISUTLDw8I3Jw4a3nrIvQV2x4wbA/KJq4LizWCc9eS2uP5Hsl92WCviASHQKxl7kOhJbqAIIt9OLZsic0f7mAlqJsm/NV7XfAbmoAiI3vXMdHu5fFyMnBlVRsIpF3vo+cGmQ1tewvPO1aooiKh1hvsGLaCSqx4k0OSF/xfJPlLf5dfcRT2wYOTi7EcHXL7swwHBzv0jvxEASCAejA8PXPkj3/BjBBlvXIhL0ra50gVkOOc7WCxSs6+7b8NM/KaTpxJNabBIPWNrYWGojCJYhOMZei3xgDFQypBd+1QBZGtvEgihJZzlVlWiCrNZF8D75lIEgw8TYJoHbvJmxjtDYrwRqVI4xPkhwkL4ituQJo0pu+Psv9ml/yh9z9qH1V0YFVALS/ha+9LVPaTm2S2vCH6LKxEy+iWqtfmp3Tmb/u9/ubiV0WoDdWrP6E0qGVWVYeUSt11eitAyH997U1HCk9o8RHL+RFHnVNO55i7RhX3AYvx0xXduZFxLjk76QLzgz6dljh4E4Ho7z8j4W2API8r0ZuF6k/t5AqnNySsVunTgJJrPFEGtVnbUkFjx49cksNzLYHP859PqW9oKVEAH4VgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(186003)(38100700002)(83380400001)(66476007)(66946007)(66556008)(316002)(6916009)(4744005)(15650500001)(86362001)(26005)(6512007)(38350700002)(4326008)(8676002)(8936002)(6486002)(508600001)(6506007)(36916002)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Swrctqmb3ipH1JMnd0MJQm2M7OQ3UyUo83vgt0akhd9bq8gcfLgPwXE0WVcy?=
 =?us-ascii?Q?c0x1abMANeEzmvauWITJu3x6HXFDbQWkm+qsL+7Gk2uPLhsptSX/KQR/ukMr?=
 =?us-ascii?Q?BkEiMqAkyvARQpLSIuIYq0PIsmuYc1hzdEw1xJJrHSDna2bFw6KQ8CV9VeV7?=
 =?us-ascii?Q?/TZFaxE8pUwUP/OtDgVohdFBPgzFHvgtsNoynv2ImfoMcmTBsUZJ0rvfrGrq?=
 =?us-ascii?Q?KiOvzN0ASp65GpZ79pASUod0QHhUFlmIHeETrDvPUqWHyQQbxl68UftRYQrB?=
 =?us-ascii?Q?LDyQvPlZd1+s/AUynCvX0Xq115sKXnBWZ5Qq9wzO511V4iBzYnEE1S6WXWbj?=
 =?us-ascii?Q?HGebXAxJJ9aycQ2t+RLyBABB4cCaEGUOCD92BzntZ3AX6KR359fuUhwnk4GT?=
 =?us-ascii?Q?Wj4WRBiHAQ0ALIV1yyfWMzdTmrQUoFb8jGk8Hhjf2O4rS+6QlvX6WFFfkmLT?=
 =?us-ascii?Q?dos1iCva+70y1lNHq291yDRmIwv5tlJm2obqQlWvcgA1qna9zQg4/rcfoVDa?=
 =?us-ascii?Q?yBAaXrYK7zT8lFaqt+DHCmJhTkjdReyisN7gOTgSL4F+ZX1pyXsMhWRRuwle?=
 =?us-ascii?Q?RoU1S1RMo4fWLdpaRUNiGelV2OJjc6Dm9Akjc8C1D5ZBKMpNKi6pcg97BFM7?=
 =?us-ascii?Q?hgjwDpcVoAVDrFxDzulXjmDnHipS0okQfnn8LtlCGbAHBRa6VPRP0IFAApDG?=
 =?us-ascii?Q?pEyMghSBVc9BpUN8alIPGl509lDHmsrlbg41D6oZS4l/O9gAAkW0TVHy2zDU?=
 =?us-ascii?Q?QgoCX7YSr4WbPfCoup/fQnmzUxy+W9q089iJ1MuMaK36yWrscxGL2Wj3trba?=
 =?us-ascii?Q?LWoB3YDyQ6QHuY/elCo9w2hB8zlNsF+o3/DM8pyUC2pz2w+NCH7b6E88evFQ?=
 =?us-ascii?Q?pfyuizAl1BqrQ+dYV721imS3A6sYwM76qIelr2gvhQBxoTQy9q039DXB082R?=
 =?us-ascii?Q?7l6NacxqjsP9tEXlYklC9qDpqxcN0sXn87Yn5F85vjRyyiO8HMYWexHYzjNi?=
 =?us-ascii?Q?4Pb3e0F5eER+1lBcTLAfGaYH8ZHwAHEjDcow8iYbGHd0LVms3xZm745swepC?=
 =?us-ascii?Q?0PO0J25pdKXdG53OqkUHimr2NKJEfhfnBEs/30u0fSSV5bfJ5hIBE5sU+x1Q?=
 =?us-ascii?Q?/XB3yGwMbhh/kWgRpCPR9g09tmLhn6bOk5Q8HJ62R0mGycBFyIkp1L6E6775?=
 =?us-ascii?Q?0BBk8XKi5ecxfGmhKjb2g070lrO+kDCR83I8l76dQzm7bpsJNdbGGiXleWo+?=
 =?us-ascii?Q?NWMfHuxxx2RLXzA7d7882Aw+8CNwd010URx9eXUyyHiO0xs+SRpMukuq9Q5q?=
 =?us-ascii?Q?qf6hgHiMRabKITWbiyM6z9pThlxHNtvg6xjRYkRpEWQVMeH5GpezGTplHAwl?=
 =?us-ascii?Q?TLk7gztLsDFAXWlTlt6WI4m/ftyISJx1nsdKhyCshgmXMqmsTZx0mn5LEt1N?=
 =?us-ascii?Q?gFOU3YHZQ7qycU1iGoAN4n6HjVwD6YYzF43JX8gsb0Ol83VfiChHi6lyVzrR?=
 =?us-ascii?Q?RsM2cnge31WLDd5ksdM+jJ3SypNhEPPqaGTlIHJwBNWEcaiGSkWdwOfF3HQh?=
 =?us-ascii?Q?IDV5HraWaqDzuKeIMC2WWpyua1NBMHw4H2SESsXEKqUh6dP3VKYuF7QgSoWT?=
 =?us-ascii?Q?RUm+RTwoTsjVBN2vmvYgI4iCMUCKCihvubf0GEhsNrKM+PYJj1ZVmXFSrmf3?=
 =?us-ascii?Q?fFuGeBOWyKPtJUPzkIgWPvpHWQ3Vr6Lm+3Ve1wB+L/Gmwg4XKUPt1Mo2a5WK?=
 =?us-ascii?Q?oIF1StHA3k7YGyfxyhlHK5a034iTVUI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9239077c-5869-41b2-13d0-08da32f10c80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 01:53:30.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GN+OfZORUCP0mQkB/3ge7dp4yxas0VhKqBTfm5+sd13viToB2oXi51hdX5DwpdQq3ks5ys7xtf1Pg14iht6R5A522h/eNjOCtAszYg0DTEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3733
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=795 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110006
X-Proofpoint-ORIG-GUID: vCUk1ib-76Ty7xPy2RPMW3XsCpmx2g5X
X-Proofpoint-GUID: vCUk1ib-76Ty7xPy2RPMW3XsCpmx2g5X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> This series has some cleanups and updates to the Qcom UFS
> driver. There is also a patch that removes the redundant wmb() from
> ufshcd_send_command() in ufshcd driver.
>
> All these patches are tested on Qualcomm Robotics RB3 platform.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
