Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F050BA87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448868AbiDVOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386242AbiDVOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:48:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBDA3B5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:45:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MDpv5E009605;
        Fri, 22 Apr 2022 14:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=G47ameR8mBAoTqyic+7jGAHRdB7W0Ee1ZauoQzYE5HM=;
 b=nKopWAamsIJ8PTxR23MVSco3BFZ7AZR+1aHxWfaQKGWA4l6qUPrUsoE5nhnDzt/t4QBp
 SzTrORWFML2i9zVJ+AWRhhYAynpU+begRLeUnQ4t4b4Vbdn5WZNMgILcgxUTlEesLaUN
 Q8k928qjPCUcD0Gf3PtaqsLGvA/wbNmwAly4IgJRWMoZUfBoP525hMJvLDa617kN87T1
 +hRO4BAtpTVcgX2z/rwhxSvJQg1Wz5EUWgSwGa7BbBpVXGPwnerz+1JDwXn9sKE/lRVU
 Dj2L3i8KqR/q4e/c3acB3lDzxCWbb9U12bUizCpVmQNnxXguOLzz+OJhLjL8p4gVvVie 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2xwhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 14:44:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MEa7vk028005;
        Fri, 22 Apr 2022 14:44:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8as34q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 14:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNdb4z6nDkXvZqnneEuCb/XKNJhzHUI2Eq9OyC45puGIqfx7lsKFXRsayzQ/n84bw6zRzlkgc9W66ExXrilWSRUa0P02Lj60AHiHL+nT/dxIvrdQExTXcL1CNYGtK4qNsJYGAqR+KMaBPKQesri3A6jFkmMzRUV6Lcc0gQgY5fLYja4GLOvhWEsB+qdJY4o1EN8aDZUKNSdpo1SEZ+0yH88cfhlGtZH/M11OobrgyFh89tYgYYiwMAF+87y7zrSQl4c2ZmU4GvD0VJWtdMgA1ooPEy8d7rYJBj4gbRoKm/R9NZX2u40qBawVNk5WskpNDU95KZEa2dXRIXbOoplkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G47ameR8mBAoTqyic+7jGAHRdB7W0Ee1ZauoQzYE5HM=;
 b=BdPqDJvW0+FgyPd/VgdYtWDlJHEtck6EqjM6njd3AnsRZgd9I0kTpVl1YDsKPLdAO8gzQ/TUyRZ8RWwjmguFEB4DaFrMda4JbSxYyQFRnnEOaECa3XSpsCATezbSCeEV3oJwUHWEjb3ObfR7yu7LFL391qbW0os0OX67bivpE/qlNpm2uoGmG3WYnoLQtkMo6uj3N2G9gXtg3SGmkcHbEnRs4ZRE7H8Ja1xkOtrc476QTxKv7dC4LNKnIf8sILGoa4gHWeaCvGjPEo+2Lb2cXMPPkGMmC0BRKbxhwfx9BzFC7jIvJE83Po1FsQYm0IgYJGCFbMvJK8DEoa1my4e5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G47ameR8mBAoTqyic+7jGAHRdB7W0Ee1ZauoQzYE5HM=;
 b=I/8f1JvxefR5KKKBcV67ctiZZ6euNxEG8QYZ4k+f73hmFqYxwW42bg/K6rZUhovE+9zq45Y5CGw4JhfA8Ui9rFqjqOLTzQ337OfWddc4ASFnumbNQyXvvS77TxlpRcK2YC04ZR6lI+iuMqRHMNzR17WHCLC+dRMrSzgUDdNNluw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2533.namprd10.prod.outlook.com
 (2603:10b6:a02:b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:44:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 14:44:46 +0000
Date:   Fri, 22 Apr 2022 17:44:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tom Rix <trix@redhat.com>
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, stefan.wahren@i2se.com,
        gascoar@gmail.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: change vchiq_platform_init from
 global to static
Message-ID: <20220422144423.GI2462@kadam>
References: <20220418164356.3532969-1-trix@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418164356.3532969-1-trix@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016c8cf1-537f-47a4-fb75-08da246ea511
X-MS-TrafficTypeDiagnostic: BYAPR10MB2533:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB25330C7B4AB2D1CDDD0F19498EF79@BYAPR10MB2533.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wSIunRZYpHmandtJ1Bes/0tY7Ux4BlTpna1mYvoUvH5YJqXmuJQcibV9ymGoeFO1G81UrToEav7o+dpn2/xxXO0S+QeGGxj5+OgYbAjjYF3fNu/WrcE4MbJkfNKnkRW7AeGWcdo7cZkXd2KeLoJkeNx41aF0B+bQmKiIKoNdCSqKPefc9+O05OuaReDTIUKScFeXdVS5R45kkW0uLcguHdme6SNn/spT9nn6DAHjXUa3V9qP9Nm6E2PydM6Aw5LpuITN9Hq7PtNCzRCIO2HnS5PYHWU3xFjMtQNkHrMY+f5Yl0QFtRBqpbVaLH3vZmQqwHfAlpbU1VUDs0IkrfEOeTrRFTocibEjSVA7WcO/z4q3H0WtY97fwMuTsNa+VFKqjh8jge+Bs8FiwHnognt/LTo8OgDW53AlxUyT6/8jWkbk4ybSJU4LH+q6pmBAEewR8ar3M1D/uM7zCjGUgkV2HCspNbISyRjYHldzuiNpmlk2zEGAN+OOaoqCYRRXqbd30khlx1vuXUeHnMVFsqp6F9XwuWVaAPDLoRfrrVHFdz4HRawUa7rnhHttyyqmBtvAg7Wy+qhjYvngzO6aXrDYz4ewH/MPvQYIsLVTaqG99AqGmkd9N1c23MJsVbGkozuM1WdncDg1k3LZvWP9CJn/2i+Qm6lIf3TFuzxkvVapSfzdIHpvfJX8Mh4mNQDO/cyZLi6UiVobIBZKvXUw6S2Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(8936002)(7416002)(9686003)(4326008)(8676002)(86362001)(66556008)(26005)(316002)(38100700002)(38350700002)(4744005)(5660300002)(6486002)(2906002)(508600001)(33656002)(66476007)(6506007)(6512007)(6666004)(52116002)(66946007)(6916009)(1076003)(186003)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V1PDrrr9LZHWUmHmGU5BfvkX6HbyT20OMmRZWZwfvrJW3nN58IxBLjejRBi1?=
 =?us-ascii?Q?TGlncC/HIeAatrMmkn3swt2YbUtjnDvzDFi6AB1itI+eA54BdYR0a8bgzZj/?=
 =?us-ascii?Q?rgDJ2JWlFLQcr70EyQYV8Jwp1tFWUvR7Iu9LhEYSjfESUPEEUxCGKf8gGQFk?=
 =?us-ascii?Q?iJ5x6vZKzsEqOUSUPZzR9WMrjOSqoPzYgpHddZYXSqaEHcj2RoNLzoy0dDh6?=
 =?us-ascii?Q?Lfuknb7xYLpUG6TiKWfqrOPTz3YkxtW5QiIjRXNzczwBR8mJwG5ZOjx/Hd61?=
 =?us-ascii?Q?Xk3s8dR+wBiolM44ZrZ246BMonSg7q9x/Lb9K9zX6g227UjBo+7JQPu2AbNo?=
 =?us-ascii?Q?h6IR6ccOl7zsZs3Nx1MZpTrqcXhEjUbHw3MdGwfPfWrR98et/uxZYCd3J5fo?=
 =?us-ascii?Q?P0tCsAd0JL+vfx8OthFtml+7OXfj1rjtsCKRJPOBBR4+zc8/ZH5RaLhXMY+w?=
 =?us-ascii?Q?E4qXuDfX54xCvmr3jXwDKiSM2aFBTnCTEWf4YssSOBb9bsquZ/DATR3m2tO5?=
 =?us-ascii?Q?GW5brV+BVabez2S0lYx5TJ/Pom0cvBNbKHHq235518AGtar3C1VC6/PIELAf?=
 =?us-ascii?Q?9QLwpr7DYR0rx0qM8yitMK/gKBxE7PsontNv9cmBFyrqc3mJz3WOfDrmrC5T?=
 =?us-ascii?Q?T2q9RAVoIpL8N+wcMA7aBOTb6W3d4xNO5NeDjaCSrCTz1J+xsuI5antpVK8W?=
 =?us-ascii?Q?sYrWNxywam4bGY1PFG19cpzSDYWr1WuQPCykayje4OSWqfSiu0V7ibHn8PF0?=
 =?us-ascii?Q?ccJDgHK+0uuvoK8Wl+wPDAfcBec5No7moBExXAi7jOhIoqpccsEaRFWKlnNn?=
 =?us-ascii?Q?G2dIumIDuHkhC3Zitgrhi9IfNx0dosJt7xenI1o5OSw5jSbZA2X1fLWcfE6k?=
 =?us-ascii?Q?LXV/MycYgM79j4Ahw0Pl1gesfS2bMk7NfMkeeVzTxtpbRaSP5Ff1FIZGgqLP?=
 =?us-ascii?Q?swiEDNRLK+Am62i3hXesiI132xG8uMN+kYE8/mQ3ZpBP8ay9oKg1q96idQkI?=
 =?us-ascii?Q?B4jlMfXZPZYvbF70nj2L2mF2FKTkK2D+p8+2+MqzL3/vKZnRqYVzv+Dhql79?=
 =?us-ascii?Q?xEjTBIxK+rdOPiv+QPF51+T6+FKqAJcxdorg/4BcJ+JcFbA+capRnzI+ydDP?=
 =?us-ascii?Q?85XJ8dBIoe9dfSjfFYHwYbLlaTxDK15GJCK6OPmfThpmNtn/YXKvR559adqg?=
 =?us-ascii?Q?Dyc7MMCYpf9XMsznhd5Ql6n20jZUu0tK4hUhiMfeGnXzCwwRUQD3y9hDx+Ox?=
 =?us-ascii?Q?zIy3lBuT5PHClCGZRfVqOovIgMKIe3CqZWhF0kevq1dqYqoOcWEH0GpPOfRw?=
 =?us-ascii?Q?ffb2ZHEroWNSfxyjuH7Wk6axkD/Jkv7g8C4mtqTR/RVNXRIrIeOYfSJ2IPjl?=
 =?us-ascii?Q?5/WUQLyWUBfzdVnEnsIP/xL+Vr2UvZo6wND+Nl6jAG9d4K2YWHi0abb2x7IT?=
 =?us-ascii?Q?ADHZ+YFmWGK2vu49+0Ao07deYWC78d29Z4BsUvh24Wrt8TuKH49mHsvqdmSE?=
 =?us-ascii?Q?w82X3eko3l2AOk0sGsPyNlGrRajgtFZWqZHUjiTllo6Ww5njKk+9ixzOrNqe?=
 =?us-ascii?Q?BkloCbcBTbTFFqQyVOEpO1Yzbjfh+RuZJqKfFbBGLZgQEvQt6QgJRyI4gIMZ?=
 =?us-ascii?Q?+JRC8asqTIjOMPWUs/vTa0KVrv1fRTsdFG31mDSVm7AMf3pcMhBHWBGHFndn?=
 =?us-ascii?Q?/73EL2QgCWTGfjSSHkaLrN78Uz/synaTRX1PhslFES6O9TKXX8yf/kZsWmnx?=
 =?us-ascii?Q?nHs02Ea+dHxQcr1cwi6Y24KqyGqD50A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c8cf1-537f-47a4-fb75-08da246ea511
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:44:46.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz3niUgGhva9YECVf/fINe2Xa+acWuBMKJI1KhGKgjHaM5UeJvCAm0tb9lPR6O8rl/ffCRucygv6X5kb423N5cJ9U2upMSc1wV6vWPVVfhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2533
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220064
X-Proofpoint-GUID: 8J7B2fZdws4GtmXUNoSQxBLtivwMvMzI
X-Proofpoint-ORIG-GUID: 8J7B2fZdws4GtmXUNoSQxBLtivwMvMzI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:43:56PM -0400, Tom Rix wrote:
> Smatch reports this issue
> vchiq_arm.c:466:5: warning: symbol 'vchiq_platform_init'
>   was not declared. Should it be static?

This is a Sparse warning, not Smatch.

Use this command for Smatch
~/smatch/smatch_scripts/kchecker drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c

And this command for Sparse
~/smatch/smatch_scripts/kchecker --sparse drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c

regards,
dan carpenter

