Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34C56A090
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiGGK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiGGK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:57:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3A57226
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:57:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2679E1xh018253;
        Thu, 7 Jul 2022 10:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5te9sVZhOLSEYJ/AHALxlwcfJ/lHEAF+PKylvPTvLVw=;
 b=gjb7lINgD2xj3uO9ncCjPWA8kWxW3E3kdp8ZoUJEoefgG4t03tVCVqTXxhWARVWLjwWU
 gpJTwNQY3gG9rxxHaMEU74TqMyyH/u/nuLqRZV7ZRzcBxwiMxz12gfp3cpTZ8jcBgVf3
 D7PBdOTst907Ad317KqxR9hIVpNrzF+qANQCDdeYpBbhTszB8BKVkqw9Tr1M2GvSbyTn
 iwu6//uIgkUc0R2M9dbOzMeLeeAkqRB4hqcWtQlswoPoEANjiVow1bvbAAWFt7ZkuiwQ
 CQNjBgPi/nPT5g/AcGKP79RsiIC4yHlfuhXtKsoDPgod49zMxjAVeo+TUWbIGRyQcKXj JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyvmdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 10:56:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267ApUuE036026;
        Thu, 7 Jul 2022 10:56:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud8tk3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 10:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maC0sCcxGqqKWhOn8Ccy5p/tV5336SUbY9HQBKy9V1qh9s9+WP6JoiSnty2xV0YDPCigYPLRUm9ihd3hPa+P7AswwEFatfnc+QpjNk69k7jwLwueNOTn+N+SagHy9MsQcp3xlkVulFt2u7n51sUrZZVymecYaVnt9l8Q0McjZSku41/TSRcj417WEvfgeQgWKK05+cgQgIow3CdeibeAihthOqVVa73iIEH3FPRq9Z8qW/8GBPZE8ehGKqEU7rBD1m6+VHpnzjNOQosKwtjMRv6OxeK25BIyBG1lvzmKjavSpUTM+9Tzxb2BsE9nbOqCj4lBUtiIkVG5UfSWtFQckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5te9sVZhOLSEYJ/AHALxlwcfJ/lHEAF+PKylvPTvLVw=;
 b=fn7VxuMqwTHnrLSJ/GagWe6rNN2CsgX4xgaNQLp6OsFqWnImqq2rCKnZYgDmyHT9Ipjap0GCu1aNDtFt+vnX9e3xHIV0vfngxWNCR2LxQ+DTuJH1PF9PFrq/MMcD+usjMPsZHwtkKJWdQiZdfsnW8MM+7KQ0b247n8ct8+GrmG4Sp0tDztFWCbUkny3MBRnZem0NFqOKoSA2qNpG6EZWKOfF65fd8EPQP/xaej2XiIkG5VJB2ONmHSw4/Sg/YfFfiq53911luBTneQTWornsyegKH+siWDHo4dxFh2dsZlnHop7Y11cVWKBqg+8NT5mmFxhji7l3nvUSuBK/py/S8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5te9sVZhOLSEYJ/AHALxlwcfJ/lHEAF+PKylvPTvLVw=;
 b=nRicphZRGoPkMVuPT2E68R/BO2MkEWgMTlbJWEg5Yto60ccM6qfiaJeZjkxLbZBT3ZSDpAGZq2uqHDi5TEahGL3GRS9rIyNs15vvJb1TcW0lj1jTCU6puhIEVZFby3R8nyDB1Get+ObVU/R5Cwp9EkszdjiJvvw0PGEMA5dPHaI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4315.namprd10.prod.outlook.com
 (2603:10b6:5:219::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 10:56:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:56:45 +0000
Date:   Thu, 7 Jul 2022 13:56:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karthik Alapati <mail@karthek.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: don't use index pointer after iter
Message-ID: <20220707105625.GI2338@kadam>
References: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6096e919-5f1d-4eb9-16b0-08da60076212
X-MS-TrafficTypeDiagnostic: DM6PR10MB4315:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFbihEbBb7jWRqGXfrtgowM2Lie+FMd3hY+5N/6NGZj+s5cCCwFOgIPdFKoCv3FbnMqazP3NnW0WR6Wqj6QRlF0XLg2+Fvc3VEeKN2WN5+OvgyAXzX9qL9OYJihr0IxfXxDwYqQzytrea4K3EgTZNOSRit6waqxH4QlehCgxpuVTSxpfV4oXZwE1Lz8FDkGqQ/FuepaKIg7dOOZQHob97KoogLOrP2gx2S9t2Fot0OLO7Mi7OOVILiCsD1HPTvyC1eP9jDXlVSRR/A2Jg60fNfuV3UqklGA4//eR5lLT0UOfzT1r0vfPdOjMYhABoHR1cbapDpKTW5rFCPCv69p2UbsVsprL//Ynezszz51hXhAVJXeSB18ss+DnI3a1vojN5PyKjEcW7DAgK5r9rEyK5fBHGV0HFIsJy4Qd9kPKRacnHyOzTgFa9Y+jIxFzWKvw8wZyLtIs5Axt2M6Vbh93lwZ1WMJ4pswhcrBdHsz0/HnD/TTiUKQ3pRr4fCk9zwH0xTbZxdwDQfqm8DI7og9cc7RI5f6RPTmE2amPPsVO9a58HDNLd4gIV8J5iVZEk8tR+/GSWQT7PvZ3g/8WVNK6Owl4SvErR3BadvcK/1ettPcse4Ssms2Qu4dythdpXXwRoiO1ELTJQXOum07ekAYrdmQOIl3TrBY5krzSwQM65eKlCQA6funVyve4GND8qyyInE1pog6BmRuvsfCetn6Py3n8UZ0Y4gw4nADh5wspsy4G8/QEhdHi4wQaZ9+jzhO0HweZWtRFwyeziKl2YXS13RXG6eFlfZ9GChdDQG1LRjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(6486002)(9686003)(478600001)(26005)(83380400001)(52116002)(316002)(41300700001)(33656002)(33716001)(6512007)(86362001)(1076003)(5660300002)(44832011)(6506007)(8936002)(186003)(66946007)(66556008)(38350700002)(66476007)(38100700002)(6916009)(8676002)(6666004)(54906003)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z2445jrHVibJr9UYLlYspNC24k8WqzvU+LmuvuMI5iXf6YppZqPdr1LOzGry?=
 =?us-ascii?Q?UvJdmMmr+S7/c912sA3K1lm37a0BLuhnDLNraLLRCxHRVePbhTWxpFrT/Gmd?=
 =?us-ascii?Q?H1AVhyPjKBYYJtGvTwmjakaR+v2SaZXewF9Ju9vaoY7ORMXsjZfPtHXPL9VP?=
 =?us-ascii?Q?mqxvOAQQwkZs86olk62Kl2ptNfUTGe6vVK8cDBrHopvxJqrcMNFsSOTNqfsy?=
 =?us-ascii?Q?sEtE64yBBq6wgRi/1wzJqdR8x5OJu5/ysAnRYv9CrOXvnv523FINHXPcfO2H?=
 =?us-ascii?Q?86w7vio0Wh/QkQz9xh/hm8vxzYS3f1Ksd/n5klmUQhEkaOIz4EpoZcR1Df6s?=
 =?us-ascii?Q?PYrmGusO1natqPwYaBi3wqwFTH6/0c+ux2MpsGynCL/amrduKm+RJKyVAAY8?=
 =?us-ascii?Q?3ZicaNxLKhCO5POTGBXXsh7yvd2sE9Txz1KWfCFU00b3JvwyCxyMhvsMBaMx?=
 =?us-ascii?Q?8PQ9XY0s76Id0R012blu8dncPO22DBYEHEKw8pFS+dJ1C1XZ8j4/p88NB7+z?=
 =?us-ascii?Q?RnpZfDd8LVtgNjGdm2JESU7K65tZW26rQmKvC1jLGErhak4b8Yw2dDRHZf+O?=
 =?us-ascii?Q?YxeZkErRVa2aoQXwFkuGQvPRwqrwn9tLSE1YSBOoYmOUAu3624BU08Kn9NRn?=
 =?us-ascii?Q?6z7jIQrMDRhFe/zGdtYTuEIeuRnixvUlpk0QqLWwul3Qi8b5rVHq0xTdfRbN?=
 =?us-ascii?Q?EeCkcMuS1YSMSUzYSpIRpxwYlOxGSWUkQ8mcWKr7b0d2O7yd0lRT5eP0/eXF?=
 =?us-ascii?Q?Plfii6r3BFP+RvwweBZB3ByOYX84C8MWpAojm7FjS+eDqxP9GQqix5vrJTgf?=
 =?us-ascii?Q?2YB/LTfMXxgj+EvVMjBYqosW2rEO+0HL9jYXMIKIByy8FcsCNg9KgmMp6e5D?=
 =?us-ascii?Q?8/EEFr7HhzweAlA9Lfe0qcXXZn4p2vdJbwpoPyh5B/AJp60WuUAkLT2XAW0M?=
 =?us-ascii?Q?RXnWkDLSmMKxOlzQKjKbek+X7r8aARkLiiOf9JJ9RaeDk6RLZpTV5+ILxb1Q?=
 =?us-ascii?Q?r8bmPyHkUP76Wz3xw/bZ7Gm7DwiWVzKZmwKvI80QMUz8GI3AE+kBaNgsFyrl?=
 =?us-ascii?Q?qwSWlKfvdKPiWGSCjQj8BwTEQ0U5k1sYYGOfxqGCcFPm0ZrYsXOHUKlxoy9h?=
 =?us-ascii?Q?ItUb55STnsaoHWF7Zn+3pEnek++5ptwjqJe5lEVs5tYA+6m7Pza2PsOq7WVv?=
 =?us-ascii?Q?gCCQ5BuBzfjoxMxT+aAiu1MaSS7+YN35sFgwXe2DRVq7vgoe0TY4WJlMi8cs?=
 =?us-ascii?Q?FXp/SLMIqoDKsiv8YjS7NFviGLGgQnjRBFqg75X//w9CtbCES0VQ0yBvjlJ7?=
 =?us-ascii?Q?NWKNSGW0d/IHvjsFT7oeYpBY93hDpmqEe2GS7nxHItqgpnbHYo6dbEJzJzg/?=
 =?us-ascii?Q?JEilq7XVfkWKIQmKGqoVlmDjqYePIYtuSmI9g7S7JvJMKKSKZpvRoy2vJ6fA?=
 =?us-ascii?Q?VjAFsj54kk0fD4Wksp5FpguLUFBMHms56jWxzgLnmqBh+LaEAerqqmL34+9G?=
 =?us-ascii?Q?i/rvtm+iVyHYCg8odZcFCKX7yXkfSRRDJ3YtwQ8Y2Oh+vaJa8ELJ4aw001tF?=
 =?us-ascii?Q?WrPoKuyK1LCpQCedimegUeWT9QuIHXm2klxfTkDcKRgyOs4MDzykmhZxP7Gu?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6096e919-5f1d-4eb9-16b0-08da60076212
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:56:45.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvgp0+f2LG5c+N0J/BRxZxYNgiqaynnGZfTeJLrOPPam6+teBrlj6thFRbQnkxMrmmGmDMAANHvFm2rvrw1giaK6oFsiNtNTsduS8NBIU8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_08:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070043
X-Proofpoint-ORIG-GUID: iBZJ2_wYMPToJN4ZA1icGeZ1wefuE98K
X-Proofpoint-GUID: iBZJ2_wYMPToJN4ZA1icGeZ1wefuE98K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:59:54PM +0530, Karthik Alapati wrote:
> There are some usages of index pointer of list(w) which may not point to
> the right entry when the required entry is not found and the list traversal
> completes with index pointer pointing to the last entry. So, use w_found
> flag to track the case where the entry is found.
> 
> Currently, When the condition (w->dapm != dapm) is true the loop continues
> and when it is not then it compares the name strings and breaks out of the
> loop if they match with w pointing to the right entry and it also breaks
> out of loop if they didn't match by additionally setting w to NULL. But
> what if the condition (w->dapm != dapm) is never false and the list
> traversal completes with w pointing to last entry then usage of it after
> the iter may not be correct. And there is no way to know whether the entry
> is found. So, if we introduce w_found to track when the entry is found
> then we can account for the case where the entry is not actually found and
> the list traversal completes.
> 
> Fixes coccinelle error:
> drivers/staging/greybus/audio_helper.c:135:7-8: ERROR:
> invalid reference to the index variable of the iterator on line 127
> 
> Signed-off-by: Karthik Alapati <mail@karthek.com>
> ---

Already fixed a month ago.  Please always work against staging-next or
linux-next.

regards,
dan carpenter

