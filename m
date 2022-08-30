Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92A5A592A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiH3CLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3CLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:11:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABFE9D12F;
        Mon, 29 Aug 2022 19:11:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0cqZx029373;
        Tue, 30 Aug 2022 02:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=L3Anb3iu8OF9TXDgDuUBkzrSdEJIa4+z/l2UlG3MOa4=;
 b=tOy26ATM2yCc0RWNtS98rEZ5wTtqV7mDO17gFqgATGOfXu/PGzYO6m8RbEddP+QEXHBp
 TiFwKynxjkxCC9Q21ISBC+JSn3yxDr0QTliIVb304wdC0RUONWw3QxnriIU96Xy4WX+b
 fbB1p3wjhtEAmVqf6YqqzAamuWg5wt8FRW9WDQP6E3PvcU+cqG3mwCF0Bk1aCX4+I1WE
 7NJqSaApUBywDzFFHmpWO3HngUfqlCW3dXPPjecVYexTCzpUBjp7SwEWpIJAxhkVNlXm
 4iVAEMlowdr3yeVaP4C8ap6QO1Kh/gTUmO3BQuPos1nkp9OsuPRuI1UdXwoLhhgsyZLj QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0n2at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 02:11:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0RCnO034196;
        Tue, 30 Aug 2022 02:11:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q37vwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 02:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5FY5QD0x3axUTTznA+xilBzm7jVBvmEHEYysOGH2xP5GqpAbjjcyj1jtoZZA5AQkUItIzSiwb9lKUS13tjwzxLA7d2gSfbcA84+VHxs2zUCoX9DF5M0vQbFvWHX5PTU1uxXW1Y9ZbKGqnAHQlGxX+FTEqljF6TLCnu7I8jDlltXu/fga6S2JNSPBhFLpYiysr83gvj2JWOutGo01qMiEcowWmfNj7uosyIv5ZB4wMgIiSRaxLem3/3YD54Y/VSAME719HpiCHBW8ZjrRYMoHzZP0BWIxMeYrQt1gAewynBN1g6NpYzzeKBDdCw8BULZjQnyaP0fHhWjV4FNv1i/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3Anb3iu8OF9TXDgDuUBkzrSdEJIa4+z/l2UlG3MOa4=;
 b=ZG1mGc0JQGqoy8fx3i6QmaZSuWEu8DZaBfwBPK1EbRzkO6Nnv8kN3dgg3ofRM8POyGfJ1BBS2zPjHMA5ZKpR+9cpS897/lj5c3ypFhjq0OTdi+3UbILD2GMJ3ISOYK/AlDAJQj9pkL47u3hPYodp5HVa3TEMqsdZtQnaZmpRM1LIwztPcGF7oemauuDwC9vY1CVJbuhcSVrSMdLGpJW3Ki+lx+/dW9MY4nYPZ4gPym8vsNjEyDgcR7QI9Bs9emADho8NDx5KFGNjEv3LmUg3+nzQ0PPoVZ4NUGr53fvL9eNirZ70jOCrmw1Nx5zjeZG88Zs3eOlg5J20+JATrsr8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3Anb3iu8OF9TXDgDuUBkzrSdEJIa4+z/l2UlG3MOa4=;
 b=KH5lotfgf1fnC9zambARYbDv0TshbtFFPKZNVc+AglXiQ526F1/M6TgODXQdzRmpQc3EuO5T9FUxKszyzEWGVbycqTVtnbOaJfsWNSQg8XFX344Spg8fqkXbbFEp98seKscXNwkQPZatIfTyftSbL2CXD89+Nh76NBH09csxWMc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5358.namprd10.prod.outlook.com (2603:10b6:5:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 02:11:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 02:11:14 +0000
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k06qqyh0.fsf@ca-mkp.ca.oracle.com>
References: <20220824115057.107e3d42@canb.auug.org.au>
Date:   Mon, 29 Aug 2022 22:11:11 -0400
In-Reply-To: <20220824115057.107e3d42@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 24 Aug 2022 11:50:57 +1000")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5de5b43-42d1-485b-a3a2-08da8a2cea94
X-MS-TrafficTypeDiagnostic: DS7PR10MB5358:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fi1N8kBrKu3xHyld6iNJe0LpcgVPkKvVCJRQ3kgtkh5MPIH28iY+Gpovq4l6L0mVj5YP5Gg5kjeB7J0CLGrx+D2E3oGNWBukPvzj9wsCJj51cRDubCm3UQm0Yty/oEZK6eZ0QaOe4evUhgQJmepEgX1viYHIq0vhGpwTdxSBopywPekrunn4sb6XjeVFBa2TIFLFo0AxfpKuVHJclyiVMT/OjK1Isvu3bdcBL8d/qscjyY4T2oqANVCid1/6wq7HI8tvDZz5d15FWYFnOnMjyLk8Qd6WIwvIxX+kbw6EoTDSzvwDbBsiuPy3G0GWWOnxx7YpA4mV4htV7iWHNYifuJLfc6rCMALW4etFMi9yVZCCc8jEEYge18xT78+cPLmNmElWWE2FLaYLmDquBxbcbgBKuaSqSQuvQFOFGFhG74y/toLfoBqRGto+knIoQp399P5AhFEm90CIJez6J849/IvgHwENlLrl8AxfooOOkNSqqkTOUeolCrmq7PSzvZLLUPLBF1shTKve31+0GLGR0zQeUFCtvAOBw4fPWd76gSRlzLbI6Z0EK1eOve2ACm4xSVFM3OXe3bSltnNkmSrD1CM+aYNCF7BINeQAn6prOVCjyLmlUDk+GiAfT9aT4D+VU52ehk4TQM5x/tDxkdh23br9qnPYMPS079HQS/+M+w5oFMv3sVLlu3/wxVRCE5zCUZlZL9HVC/Vg6y6ITjchCY8srV9K3k4K+lFqxuyHBgcC6nUcnGjaPFOhd6TF6L38DyXZeK7JsTbncQ054IsN+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(366004)(136003)(346002)(6512007)(52116002)(86362001)(478600001)(6666004)(36916002)(6486002)(6506007)(41300700001)(26005)(186003)(38100700002)(83380400001)(38350700002)(54906003)(66946007)(66556008)(5660300002)(8676002)(8936002)(4326008)(66476007)(2906002)(316002)(6916009)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxDogELm+DDZk7nIP31kn4PxXScqIQAlvXxqeWzZuo7+R11xaG0jn6dCZns1?=
 =?us-ascii?Q?aoV1Kv3V96vpsGKR4kUtHkF4JR9lEf/x1548jWd6t5+G3GisKqXI6NfzEhHL?=
 =?us-ascii?Q?9RM0+l7prhkLgiGQVWeUdHgaPBc0Rdix5g60uo0fEdFwSS+WNmGHRfMbyshv?=
 =?us-ascii?Q?t/3WNNS7n3dpR0N/LjQOTajWTJT80mRaJ1svX9WgoFW5lYTU6dHVMty+Yvwk?=
 =?us-ascii?Q?gPqsi6k0ndoQzXcnPAjlfghzOgjeQjFJ+BfP+EhATPf25w7BhDVqvohjVp9x?=
 =?us-ascii?Q?lcO7/euemgHhTSXNftr7Y0rXcRNqfCn7TWxSJgSnDj++c+Tk+UB7iKMUM6Kr?=
 =?us-ascii?Q?xvl2lvfca+54jxCtw9F6IX9HtmIkMdskjLk2u3pE/0r47rVq4hehecev/tQE?=
 =?us-ascii?Q?m0AW4v2KK3iwDxfOkobcPcC4B09tM+HARCG3Pv7VWlkYHwru0bs6es07yh8i?=
 =?us-ascii?Q?GKcSbaQlFYqPti/UiIMlZJlKT2qo3f3gHM1usi7wT1HidFB9DUPjIcz2Dl24?=
 =?us-ascii?Q?0FHT+pIe5WEshRwZ80v8zoXDxHAsmu0n+snYVijAZDmKLIkFCdKQ1TbTG9yZ?=
 =?us-ascii?Q?ebYRZ7Np1A6u/Xo4GHW7WyUNug3MnAQYbHnTcLntV1q+mW177me9jXC4SJ/4?=
 =?us-ascii?Q?yCg8WSByukMmDfioSqFTWvWfGXrTIY4UQZSHg8oZWUZPsnSzVigyvEChx9BH?=
 =?us-ascii?Q?dal4iR4bnvADAUb04mJJRfnqOMNr3fGZKyLZ7MVy52dfGDXwiv0ZgJDv8nBR?=
 =?us-ascii?Q?90eQJ1eRZeK+tRHHgGTAXO0P+CY+RdZZN6zZIxXdiO6x7UuNf9bS2T5/PDzi?=
 =?us-ascii?Q?u8OuR1pSg2RZveM9+DE9dEQW5g5Zq7Iw3ui8qnCWGiXMxK+TTVUBaYe59VUB?=
 =?us-ascii?Q?aro8c+mE9Moo5wnMhWtE8tas5IuEufxYE/It5ohBzEDaadqWy9yNrIY52o4D?=
 =?us-ascii?Q?9UEQ+BpY3ig9/H2+ayp1FVefmbU3iwNR8evQLc30Kliekz+/8SneoIjPs3ai?=
 =?us-ascii?Q?0T5K9R4kDKi4scnF3qTeFbFHSe1FG8XlVgdKOTToWw84QPrJ9eLuWCE/2ydU?=
 =?us-ascii?Q?jDSYgczglXxc8RQmPwp+xS+1I1hI19J7BrLgLBdT+o7ehTAT/ZD36BFSwBoZ?=
 =?us-ascii?Q?OoteGq7nzV+PPXufYV7H6kQmo7xlocrfr9x7BN7B3x36T0VVgV+Wxof+O3is?=
 =?us-ascii?Q?WxZz0ZNS6w1mwUgZwdEnXKTJDSMZSohHw8LShwXzo4ChJYhXqVlIn9gmIf2h?=
 =?us-ascii?Q?3kBOobl1l4YPWkmgynoD/08YQoJI5QpvxRHfZBXZxocMLQfQS9K0eaH+CJMN?=
 =?us-ascii?Q?fm0fvc/vUZEb+JCYvNJE1+Jfm0uSKudImxJBq/1XTFkE06pnQ2Xib9CyVXE7?=
 =?us-ascii?Q?7ntSl5D8Dj5jyG1V5uiYHRWNKgJzZkj8IfwxfTlR1AHdfgyxx92hS5QDeK7z?=
 =?us-ascii?Q?4+lNU2d0ZThL7zN9LrNN3IF3hvozGEpgK3ZVjlRCeojw6chlolTdDIf0ghyI?=
 =?us-ascii?Q?3xTusFg3zIkc2gk8s0dh7R/B3ceGDiW5GSWJTDmElcPwEvpEt1fYfWybD9M+?=
 =?us-ascii?Q?/KFD29mqFQji3U0D0i0967Rz7fUN3IPJf9WtTCZjOz49PZpkEUaDRpSpHf99?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5de5b43-42d1-485b-a3a2-08da8a2cea94
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 02:11:14.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8nqP0a36yLPCamRW044MHAdh8v3wbpYEemILLy8jzr0UVAcZ6BRIOr0dolCohCZn2BCCByR+DGPIDSlzjtyO87NmszGSAIctcHnnWve1j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=944 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300008
X-Proofpoint-GUID: xwVmPIS3JMmDGa82Hx7vsXLDOQdZwC3P
X-Proofpoint-ORIG-GUID: xwVmPIS3JMmDGa82Hx7vsXLDOQdZwC3P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_update_mr_sas_port':
> include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werror=array-bounds]
>    40 |                 val = *addr & GENMASK(size - 1, offset);
>       |                       ^~~~~

Sreekanth: Please fix, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
