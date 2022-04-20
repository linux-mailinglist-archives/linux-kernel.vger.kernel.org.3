Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4EE508787
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378319AbiDTL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378404AbiDTL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:59:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715213D49
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:56:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K9kxfO011972;
        Wed, 20 Apr 2022 11:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oqkb2Z0sDv77bLHtausYiayexks8JKfq7fGlsM1FAhM=;
 b=YZGz1AiXNN3KLluQByxBEPiYOk7IlAiPvECBDK7CrkfzF+Reacjo474wyo5VfikckHYF
 Djc7TIFM7M1uod0AzC8RDxoO0tBZU8+qYIo3iNBli5v96ZQkL/pVLog36EQBO3xz3nme
 SPgi6r3nqsidadnUgP43YtYEs0TI8N0+ilILyop0fzNTEBffNE/uzr220azLHMR21dT2
 rDYNirmccXOC9zw4ytXPUZY19MdKKwQ/8i3v4CIQfS6OkH02DAs0eMrNAkWVQBaHo5r5
 SJrmfHa+Big5q7n2xQvVhFH/thQ/t1af36LncyXpqNCdlIbkPG696IuCJjUKMJR/bcdC dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbv8wra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 11:56:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KBq9cE007187;
        Wed, 20 Apr 2022 11:55:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm861cs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 11:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Duq+mIYsp3MGQb64BX8JIDPbogunJESGHRjNnbhaoDDOaAejvDoKBLQA0EJwN69mx2ZOD69pbldxQfb6He3qNQ6MOYT6pzIeVHE86JxJeRsM/25VKATZH7vkrXfivHnhAuLUeEu3E7/v3wlt+8EBI7xYJ3okRpHo6Y1V4WNT7ZoZ2WXEtwu/3Rmmc87I8EMmULL9uI7eKkG1bg1gRnFBWnk+oU7mzJ120Wx6ubvq4rL7zNvykaQnO0JwgFWpkStgDCbk5E/cPNKGhx3hVbohQj1rJd/csbKj/PXMGp5JVXrZY9WC24D9nJJi4RG+BKw9Y1HSCyR4sZyMdw3WB68E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqkb2Z0sDv77bLHtausYiayexks8JKfq7fGlsM1FAhM=;
 b=DP9Qey/kUNgX/KWKzw37vaVBiJtwRe4F5jxTQIsO6OGbLL/GrxI16+BHIGWbbf7WcI3psQFluvRnu4uwwjSXTI3aRDlk0hgjdCGLZ2EiGFxLbqKIEAT12YEWYcyOFSPZrU5gkMJB9iEh9D/RYc8wIV0X3ihQ9h2hOVKKif12WhrRPqPYWH8+ve96FD+HFlU1Js3/vVwHlVjr5JJ9SH2lNNgc4suH/Irw0COLbpoIcg9JqPMyysdvIwSCFJRsoVJ+Ee8OtIA1bI1YsPTPbUVy2c0/Q7csUuu1/Xx4WlvaArIIhGFwEZ+ZD462vWedcF+K609bOJifXvAGnlbxgWEcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqkb2Z0sDv77bLHtausYiayexks8JKfq7fGlsM1FAhM=;
 b=wekwy8wICAtaGjM92NQlUtpeI7TaldV0JG63vKhlp+dgUqKWViPDnlKJ/N5CeKPwBwm3FHX81NGjJKZlalqOeLT+WLpkx64CfucnsHRJfomdau8jq+A4QF9peqMxT/K+T4yGFCS0VvHS6Q1jKm/2+3XdQrdHeiW/Xa3b5BtCbmc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3668.namprd10.prod.outlook.com
 (2603:10b6:408:b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 11:55:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 11:55:57 +0000
Date:   Wed, 20 Apr 2022 14:55:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 1/7] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <20220420115534.GF2951@kadam>
References: <cover.1650392020.git.jhpark1013@gmail.com>
 <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
 <32587233-0ff6-ed0f-b873-cd4f797005a9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32587233-0ff6-ed0f-b873-cd4f797005a9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94af979-d9c4-421c-e3bb-08da22c4ba7c
X-MS-TrafficTypeDiagnostic: BN8PR10MB3668:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3668B1560BD54B468C90379B8EF59@BN8PR10MB3668.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c73ZhbpSV9zd+oCgULmZmWiPFiB1u4FhS+LqU6rebU1oHXaX8c7STHFpMYX3y4pknqBRDlx00NUHkiYlqI/zyOiWRosTFYQOXs9nw0KwVf9ayeoroFA1SWaEaYfUtj8HPD7dUJzn2Mmtveb70RN+3o4BLeN9hurtR9Ns5usUjPGwjBALyuKtf1MieXt+aCxFPXnyeHZ7VelciVaHAH4hC68wNDGNFHJwUYdIG5ckmvZOxRQDOQlm7hj1+l2HDObitA+INkHubOhsZn37s7bm1LCZP3j48FnyVn4HaRbLBEa3El7EuW5Nbx80YQeIyCV9k0uAoMqKHWaqdLojvpa1Z8JT5NpNs1wqZKGASdd2NcVuWIyEgk4SkaiOQqxNmW0nzjE8oeCUObUa2Xkwt3S/OEr1E7K+/yUD9RZzlpyzti53/AgG0mHvzKHfDz3eyMN0zJVJm9AZ7+ZW1WgSFogm33if2as4PW33ytMSGFwtCquL0l69QQk8a6bhwp8B58VO2FP7oDBytG6omanVFZMxBuv6vUIwV6wJTMciKnKAgLdFOpjWVqT8JJARYzOQpZ+U8SXCK6PNN8otcCfX2hlEi1T7++hLsp/dFEh4Dc6VvJL1DzEkMJ3tQVwKTMK/ORnftkWdVmirMFsvwlDq8GzSGfUhEMWt7GrM5AZ262j4TPBKUz6B5PUSr7fgPdRG6UaQ+/w0f0jEgtnZyW00s/BSvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6486002)(66946007)(8936002)(66476007)(33716001)(33656002)(2906002)(66556008)(44832011)(6666004)(6506007)(52116002)(6512007)(9686003)(316002)(38350700002)(86362001)(1076003)(4326008)(8676002)(5660300002)(83380400001)(38100700002)(6916009)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9OWAPBXG5mGUPWcD0s4sB4U7k2XZau/9a48x1dNgpSm1NAy1XS+647dj8UG?=
 =?us-ascii?Q?N8Ec6Q5TiPvKjFNEjHBMazAW64p09Ro9wu4GVHm4h6ixPhPdG+3hKiFsWxJ0?=
 =?us-ascii?Q?J+beHXwGdW6ruwry2JPXSCAjuKZTUKLFg7rlmtc5JYa9DzgjFRR7Ve2paLiQ?=
 =?us-ascii?Q?UiZaocJ7LtlRztinZWse9yQnVTCPshXFHehCY5cAMWERYUiSPBjYTHt9DBSv?=
 =?us-ascii?Q?2LoKAExaUcQ2ApEdOnstOuEHqReqYCRhEOrAxKtWO+Amy4hXdeUv8NFqzsr5?=
 =?us-ascii?Q?QeUlIylAmkrouDXVhzMGKqDT8+dFVaWOFwWU62WeJ4b39jFAJLH+k0IeG3ai?=
 =?us-ascii?Q?8rh2UKXN0KVa8Tm+sDO06UezW+TZxKKMH9L0llNkEhWmcSiZumkXlNVm+ILh?=
 =?us-ascii?Q?wlFh/MT05AU4CRBRGpuaWO+V4W9K6eIjmtdjCIWuPdpOgv+YuU6uC+1mXWpV?=
 =?us-ascii?Q?g4/t8LZ5Ovo5hnW49K9hbyngszSjh9uqbc3z7gWptKqq2AcN3a64SZxSX5eU?=
 =?us-ascii?Q?1l1TTYx1mkCamtW07ox3NwvmTO5xvPb1sarmFVXscYjyCu2n1oZlNhp2v73T?=
 =?us-ascii?Q?ASdpgYyoqYkpSYl2s16SKNiMjlMG8X5mgBYJLNvGK864hFJjRJpeHQzPeqti?=
 =?us-ascii?Q?clrzzbN/NKOJgv0LgFQJciuXGpvePwMvvB88Yfjz6xA28s36mxsfq24cZXBv?=
 =?us-ascii?Q?TgO6nAlDwVf7F3v93BrcznMUnaSN7TGxeLOJWscihLtd1Xh54wGv3QpbDpcR?=
 =?us-ascii?Q?4zBS0MLgSGt5hjD7vIKFl8vL63Kwqv+S4SARySfvLVONR85dX2N8jbYEdKcE?=
 =?us-ascii?Q?mEMVVLgXVOUdlx27n63wcYQS+AoacazJ1ntjDLdpx9iA0mcEt3Ts6VLU50Px?=
 =?us-ascii?Q?Xwu+X13HuQuKqltnXp7vQe34S+hAb4oULAWfuRMR2sl4sbYyavBC4XWP4Fmu?=
 =?us-ascii?Q?eX/FgdZYxGD8iXlp51qY8f5oAPxVPfzX0EkbV1DdIcnPwqkW+jamJYBn638K?=
 =?us-ascii?Q?AUn+PsvWcleWI9Mz/Gi7HFjX0JxCMNCB+TwMhvkkMHP+8W0jVNiMTy9w3ge1?=
 =?us-ascii?Q?d/oUTkkKPlWxd4RrpLWhThSfil3Vf17HiPSxBLPw6hPGyxiQJ5Kuoa8ER7nq?=
 =?us-ascii?Q?m3D1husErP/g4q/4RLj/oneww9GQ3txpPSA3XOuMa+MPA4g1rS2s7xA6i8Ix?=
 =?us-ascii?Q?V/WN2z+5gK4mh9UHiM+9itAZ66wJOX/meXI2EywB2oEPm4ZB3qp4dlfLVxV1?=
 =?us-ascii?Q?piRuXqvCCYacpA/XCGN7T0kVraCZGBNizCnRUfbalhuYuFLJwfOIth7vk32C?=
 =?us-ascii?Q?MnT0ra2S84Z09iOEbjiOL+UvB8DjClMHA47d63XkqjcLNol5aZf+zsuqaoYi?=
 =?us-ascii?Q?+9XXhl9Om4PawY8Gc7tVL+wjld4KNAX1BdslVaY3A4B7qsKgfrcGmdhs1XY0?=
 =?us-ascii?Q?b6f1Bet1bPQOipmoQ00wxUbm/VLfXcoGM4ufFx/cCS0BVxBPMumnCsBtIO/O?=
 =?us-ascii?Q?b/MzPoNL47IDZBmd5gQW1ZoRGEybtZBBvhQDei3YtsEJ4G/ughGB8WPHxR4I?=
 =?us-ascii?Q?RV/M91Ww5O+7hsJvtF9V67/RJy9WsIsFbQ5H/YecoiTnHFlTdjnFHjJtyaW+?=
 =?us-ascii?Q?ZvBHFNhfVH0ztjgRUdp/5xl6J4z0k4XxvdEJW9XHuvAtUjTXQ+Dbiea1QCY8?=
 =?us-ascii?Q?5jAytQNpnJyt5vk9mkaN726wCV7NElO0YoUpyws0l5FH9xcu/cPeM+bZe3vL?=
 =?us-ascii?Q?yfiaJdo9N8BDhsw6wtXk5ODhNBASguU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94af979-d9c4-421c-e3bb-08da22c4ba7c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:55:56.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl/NobSDfc8cZc05Eq4/U7VJztciTF/bL8ydmavSkIczSctTggC1LfaiQCqK3zoLSw5XYu7b6nMYhTknsWA9ecSnk9Uy+xrwHDZINr3XmlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_03:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=711 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200072
X-Proofpoint-GUID: IciD0fSwFGn2CFsujZ-u1g7U1NSg8sQV
X-Proofpoint-ORIG-GUID: IciD0fSwFGn2CFsujZ-u1g7U1NSg8sQV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a kernel community, I don't think we are pro-active enough about
preventing bugs.  One of my co-workers and I have started a bi weekly
phone call to look at CVEs from the previous week and discuss how they
could have been prevented or detected earlier.  Of course, my solutions
are always centered around static analysis because that's my deal but
some bugs are caused by process issues, or could be detected with better
testing.

In this case there were two bugs proposed bugs.

1) The memory leak that Fabio noticed.  Smatch is bad at detecting
   memory leaks.  It's a hard problem, because in this case it's
   across function boundaries.

Fabio caught the leak.  I don't know if I would have.

2) The NULL dereference.

   The "&pnetwork->list" expression is not a dereference so this is also
   a cross function thing.  I thought I used to have an unpublished check
   for bogus addresses like that where pnetwork is NULL.

   Another is idea is that when you have pnetwork++ and it's a NULL
   pointer then print an error message.  Or even potentially NULL.
   There are various heuristics to use which mean that "A reasonable
   person would think this could be NULL".

   Or another idea would be that we could test patches.  Right now we
   don't really have a way to test these.  But, of course, we wish we
   did.

It's not super likely that we would have committed the NULL deref
patch.  I would have caught that one if you didn't and Fabio likely
would have as well.  But I like to remove the human error whenever I
can.

regards,
dan carpenter
