Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B85A0E48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiHYKrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiHYKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:46:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFB75FC1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:46:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PA96GM026319;
        Thu, 25 Aug 2022 10:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OWEQXYJAauWSZP2viRJzq1+pJWDzlTFoXdETe+TStVU=;
 b=vduyNdd6/bvjhXvPOSlrDnoWjmgiuZ4H/GE8B/pfiY1C/I5fMKgAAKYCuevnCRFf2fUz
 lJeU81kWrRgtyafr+hKQTouXopBgC4tTqhDribQU3Vfymd32mXlDS5HoP890/A7+EUI5
 KNon6KVzcLAn0ECYsaVrEc5+W9y1s5uWQEhPwyINIqFE6AIbq4ZeCfz954s4b45F16NR
 ElFN/0D+rSNXrygamiaWoUiS/O8sJsru00UFgAYeOaT1MvJWuUd0uN2cBQBEhPdeHVpX
 ++bCbhxLLl0h7SMbPnjlJ2uYbcMvSEeLlVgytQo0t4lqOlp2Dw6eLKCzu/J2qeuEveSW SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww3rps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 10:46:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27P8Eciu028407;
        Thu, 25 Aug 2022 10:46:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4m4bc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 10:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOYjZiOQqwsmRV5+0C5CMZL/A/Kt9m7qCZIrS1qdhNVGKwuFFMbQvnDwS3bLV5FJ0PmQZgKCUWVe86eYiYb1eZT4uRQUnh0yc58TAn6CEKHPo1ndVZzZeCLVlM0y/rxKYo1QbXXKGf92E1kR/TwPzCha9BWnwLQoTzHpWIOhINfQVJpXL8yzfpZxROzLt3RbErqbzSflFpcq4j/OffANK7Jl+OFSyIXZf6Ncoj0BID1nIpBuv9q2i6TIjrQ5AD1FK2svMoobfyjSylszzvYOvcUUbB7mByw/61c/8EdHaXPaIypzH9ZIxLnEETtNP7LJh5z343jPFwe8GNoZzQKIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWEQXYJAauWSZP2viRJzq1+pJWDzlTFoXdETe+TStVU=;
 b=h5lLXLM9BQ1bkh4zbh7wZGf04gaIVin0nXDPcPtQBCf4hdygGUygK6/ozb0ZG7t+nmlGG4v54c2uDP+itW5VLASYt4u/1D8abgX+3u39opIiyOicrWR9l/8DQktUmXfbEXO9Zt00kO7gRPn6/LNz9I1aKaMioDUQr/Plpdl2LvJ9xQ7xzv0lWxxDSR+yvNLmUcnbDMMe+hxlXWBZklF6EliIpAW1CJU0qMPD168duo7tn/ZuhS7rq53XRWfYnscIXSOFcefFGjG1Ol04qnw+yY/JhhmWG2hM4cfboJK3EX5nANvbH3ZOm/DlO+X3+bUxDHB36Cs5/rQEF5BPkNGEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWEQXYJAauWSZP2viRJzq1+pJWDzlTFoXdETe+TStVU=;
 b=C/DJynw8Oez1mFWp3mPEiDoyQvDfXKEIPAvaD2M14MSmHTVOfNKyLK++oDL/Gm4y3FTHZdEAxUSLcwcGjbKd+2dA/+J+NyYhWB8VffIcxL3DlU7yOH8vERemi9QH5OGvwiWK+Ldu8Doyoh4EHgjcYnFJdg1r2SqURmO8wcoGVcU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN7PR10MB6523.namprd10.prod.outlook.com
 (2603:10b6:806:2a6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 25 Aug
 2022 10:46:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 10:46:28 +0000
Date:   Thu, 25 Aug 2022 13:46:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Czerwacki, Eial" <eial.czerwacki@sap.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Message-ID: <20220825104604.GD2030@kadam>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e6c19ee-6314-4c9c-4d13-08da8687101e
X-MS-TrafficTypeDiagnostic: SN7PR10MB6523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVJND403FGob7EwDaRLOpoIOqzLFYv58to+36MWc6R77pn37KUcrN5e08rm5rr3xWzGqffP6Z9NeccPJgD17z6jSLVgprLE99MZXVYxhcibQATBw6ZxvIjfYodIQjgL5mncC+jL1x2+c5pJha/NMfkoprgREYOWA1MffRoWfTU3TXA/SHYvaasV5vSSloC9/KcdV95Fu8SQEfUa1z7xVJjyHwrObYwGaeiVrRDDKpLzm5vyZWS4T05E9Q9JPIoNyzgmN5z0q0TisldVAixlGRV+MrnnfbWfTUwzcGwVaMpBJFdk85QUKXwXv8iGvgFb17wrNy5jvUBAylDS92L6ZQsAeGqu2qQNxx+PzCdyKFpmtbgo3qG1+yJ1ZR25yFMcZ/fP5g5IMbBqjMmgUyWEFY0tmGV84YZXjjDmJ4IElxzTMT+WmCSRhEd2b8l2CilnlAKPcJ/x/R55d4QLfhSSWEi3nX16zqffSjO2A77TKQMuVMTU4MECJmikHxjSJoAUapY3OWioe4LtKvNsoTeSPkUu4kHBEJIOIz8N+VqNvlFRuOdWGexzkT80/00hVFVgIEgHV8wLyrYzxNbNJ2Q9aBpTdmdgTnPPr0uodD7NwD+1lv79CLLMEH3Xd0UC+6wLIbKyoacMmqxj/jUb2iPLn1G1UYW0OqGL9eYNGAI8xQG3sfOHYi3TfnGdiqfBXutb70389FrOaK6uoqYUt1F5zUEV7hMp8AoBI64xGPqGyn6SKUFQeVgEwGcwj8ieqtvjzu3DLYcjbmbJmruywfYPScg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(366004)(376002)(136003)(396003)(66556008)(186003)(38100700002)(33656002)(38350700002)(86362001)(1076003)(316002)(66476007)(44832011)(54906003)(8676002)(66946007)(7416002)(2906002)(6916009)(6666004)(41300700001)(9686003)(6506007)(26005)(4326008)(6512007)(5660300002)(478600001)(52116002)(8936002)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62+oHthZsVTNb4QrOauOI2erVL1jOkjYVZrecKtLK/LizrKFDr+OfNkhxLTH?=
 =?us-ascii?Q?WxH4Q0zaCNIzT5ZTev6Lpck/Q8VuG7hmzih137l9euzPxkmvTaOR8sN/kTBx?=
 =?us-ascii?Q?MtsQ7Iu7E6XqiJlZNKVBoXrXqXszJgZS+/PUUYxUnClnwsgAj5bFBoUtUyQJ?=
 =?us-ascii?Q?j7yQ+2lm0fJob/7JF+wuAZJTZOX4s09lO3ljiKsGXso6gtjWIzGAs5o4UMjL?=
 =?us-ascii?Q?8zryR7j8Oa5T+8qFmpVtaFdYwHKc9Lxcl7fyw+fVjn/fwu9LQoTJX3cmik72?=
 =?us-ascii?Q?o0zhv5rvy0DtqDVbyVluL4QWqQ9pWwLqIiTodMNkpNGO7ur127Mn+38fZMBz?=
 =?us-ascii?Q?UWdVAwOKbWRylpxddT3XIa6tMMEtI3QdaQfnI4UeAyvVg2luQ07ZOk3ltt7f?=
 =?us-ascii?Q?wc45TGiTQUSj9o4g1NTpBfzMGevKzKlLlGNJ/4gDrgIsj1QOYWxfqzn+Xsnu?=
 =?us-ascii?Q?Mgvnnslw2ErFg8kgTEi/gAqXKA+mZiX1rcNUXAUUiSYrvF8omDwWzgc7/JF/?=
 =?us-ascii?Q?u4MJPxCrr9XFnYUUvQRNPkecYr+egVI7pwjXtdSoN6NiIHMQswxtF5QZc0TC?=
 =?us-ascii?Q?SiJpggahthuQ9xuUXjeqysCwdEiyEFh7PstI2kh6VqhUKNARMgZCuuE/c1Bv?=
 =?us-ascii?Q?4bZvO4MYpMFIp8MS2inYMWbGPqjEMln/KMqmsmt+M/9srlZzTflPxdeKoikM?=
 =?us-ascii?Q?Q4ngRfc5ydiJUxXuJVrgFJT8Yqg2zMsqcqdD4MS6JhW2Iw39+NlBAbm0G0GB?=
 =?us-ascii?Q?NIhUwmgvOozHskUgbKabJ9SI2nm6du7KNiZqES4rjYQzDyEpMJ7P2BgpXN0c?=
 =?us-ascii?Q?GZ1YugnGGmz/OL43H0pY3ST9Y0MipYF2g7Kaj0TFcq0PrmirlmyNFSI9DUkk?=
 =?us-ascii?Q?gafhwX3w6fMu4zdj1lbcndt/5XPRPw6ifQuNqKeYMqNSv2P1gU9Zzjiy4Edj?=
 =?us-ascii?Q?dbBlRzSefIkGff/xlS2GmfI/ZTqmu9znbT5zejSWiM4hh1R5/QHifOrZuPrx?=
 =?us-ascii?Q?OW8qeW3jQxEkOuOqe4UplgyyzMHgn9SQKI+tvzPzG0TW7s8vPTKeB02YOYBH?=
 =?us-ascii?Q?RG1g2cDwfCtOCPjmGzjW0GzE5JOR3MfxHMSDY91v7XXZ4+sJRdDOSmc6bCys?=
 =?us-ascii?Q?GLgq5Lv17wYo7fzlWnrCk75upNdBxb0iSPEI7G5pBoReBwaZS9ZCGwAfxJDG?=
 =?us-ascii?Q?s7UT8vtdcUTu8/q748hENYP4DMzpYf8yr39WSxxTJwHflhXqysc1EC326Dpd?=
 =?us-ascii?Q?Qob0ocRJTFWt1YCIAY6uk1KnayeTTlBh58idkoTyQzaQbOc/74LfoQWfrC79?=
 =?us-ascii?Q?Dri6Q/WRNLAVQbCN+/XEQzKVUz5Nb9+RFwtBCkXnbuNlF6ZOWdyQh7d1rr66?=
 =?us-ascii?Q?d6AbfeuVWFQskMGS2+X04ER1sgbkWDL4/Zkf/zZbSBGgClG2yBVV4u0ZmbhB?=
 =?us-ascii?Q?lKN43lKxQhItL8CeHPlrOqYutwidiXCr5OQPTqGHXV03GV81jgU0a3BsOpJl?=
 =?us-ascii?Q?hxoP2HAlJcrwIpt3dImv5UrTZqcV7nh6dDoraj4j3GeNSSDD9JXfncoPhL37?=
 =?us-ascii?Q?fqgjicJjIlLU/k5v3zSA/MpQuOOSqqGvnqfb3RmB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6c19ee-6314-4c9c-4d13-08da8687101e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:46:27.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DAi9wb8qGWxOT4E7B+uK4C59TffwyMp7BEFRp0QlkvG6r6WEMp6OUyb/UkqG9XFUF5mMdQV8ThLU4OuSoKOYP890p+WhC6yr9Wy4w08eKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250042
X-Proofpoint-GUID: D0ewIpeQoIi83Ubx7vB1Sq0u8j6RssGE
X-Proofpoint-ORIG-GUID: D0ewIpeQoIi83Ubx7vB1Sq0u8j6RssGE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:
> Introducing the vSMP guest driver which allows interaction with the
> vSMP control device when running a Linux OS atop of the vSMP hypervisor.
> vSMP is a resource aggregation hypervisor from SAP.
> 
> The driver comprises of api part which facilitates communication with
> the hypervisor and version which displays the hypervisor's version.
> 
> This patch s based on previous patches sent to the staging tree mailing
> lists
> 
> Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>
> Acked-by: Leonid Arsh <leonid.arsh@sap.com>
> Acked-by: Oren Twaig <oren.twaig@sap.com>
> CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Dan Carpenter <dan.carpenter@oracle.com>
> CC: Andra Paraschiv <andraprs@amazon.com>
> CC: Borislav Petkov <bp@suse.de>
> CC: Brijesh Singh <brijesh.singh@amd.com>
> CC: Eric Biggers <ebiggers@google.com>
> CC: Fei Li <fei1.li@intel.com>
> CC: Hans de Goede <hdegoede@redhat.com>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> v1 -> v2:
> 	- fix -0 var init in add_sysfs_entries (pointed out by Dan Carpenter)

Please don't resend patches the same day.  Always wait at least a day
but probably for a new driver wait 3 days.  There are going to be a lot
of comments on this.

My comment didn't even warrant a resend at all, it just something that
made me chuckle.  It will take a while to review this properly.

regards,
dan carpenter

