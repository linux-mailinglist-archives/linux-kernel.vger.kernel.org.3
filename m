Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA6F4EDC71
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiCaPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiCaPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:14:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24A114DF3;
        Thu, 31 Mar 2022 08:12:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEd2jj032372;
        Thu, 31 Mar 2022 15:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JJbK4IQY+VCwv32kjPGNlDTGkjHvce+vgcdbMqfhu8I=;
 b=tbWLZ+FHSoMH3UC21FJZwzA2R39wji+ZdJiBHNdpCx9P4LUAy+MTi0lG6kGiF76zHGxo
 jbD4DjM248s4bEEijMa3POSeWk2eC9B4uQs+nPQph0wpwDVayxNgiokkS8RK1PQuv825
 rmC/+Y46HbAdun6MvoGNcn3y8T+bvmNURoMEM1MM9IC0gvOkF+7KpNkW3DjL43m1KAIK
 L4FMMPMLSnwJ/OfkCOn3/yeP2/QOGcQbQEDmQfH7pMMEgD27biGjty8ZZFkRaNgMN5nt
 hfEl7emL365k+8r+TB0Q7S4LJM8lcrrimbDaBUNC5prma78hmu3g1vA0+I9y6V65fwMG Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctvvj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:12:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFAbbs010960;
        Thu, 31 Mar 2022 15:12:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94rbh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:12:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBzgCRD0HSxySTJqIdRPrp1trRpKkVm8sHoI/H4R5lpVfq94A0kT1wIm1aAt/UjeBckGHXB2H8E/O3f3jHtk73ng8+wbQAeH4IA+p8BoQjTXjSWoTqEIJ3Dipks/uBgXEX0kFOXV8oaf2Gunq5j7NTBbH1fBuP71ibCOf6dQIzvyHEeNWpJymzh7w940slksAtI1QYEU7Xi2sNFktCW4RItxG4qnZ64RcrVJU9WCii64hP+LjmR2bfK2fslU1VZEoPV3u1n+UO5RvQnvUtKABhcZ1dp/XKtf/zSurMNoL2sruCpzRaJgOdQGuwpLbP5Kdkfsjb/4EiBPKex61tlWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJbK4IQY+VCwv32kjPGNlDTGkjHvce+vgcdbMqfhu8I=;
 b=dL+ZAcGghOFwkpxMLues0DA+/Nr3MBBJyi7qNVjPHp1BnHxNpuj5AvljG+GfqhIq+ioYLTjWsbHMx/v3friTHGtsla51klpoyDjcBlJqcBTopmAHfQlO0sx+flnYuZOykbnOeieptSJcvdzRGqEgTnFyj9f8P/iuiOsOZbNVGQDgHnzrMTWB6dz2OxoqleJpf3oJdKO7nEii2dBOB07qOsiv+V3WagV7ISspuJKPPUv/K+Ke61GVZ8wL7+oQNprhSFQ9J6PxQ8fqFSCewU5jwj8mxIGe5htcCD2gTucol+QNWSv4Ucc5DKlK4Y91NkmwoJxrIi3NfZflgX2p3sWrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJbK4IQY+VCwv32kjPGNlDTGkjHvce+vgcdbMqfhu8I=;
 b=m/Iq6mASp0K9CLFR0dHZRSN7uHX0plUCHz2D1WRYG3k8KUnJFAOk7FjRSeavSG7G+SAH7+DfqFdL1cac2iW/uNaDYXt2LQTosJYdpFodFh9bPtESAKZXsSjalVkkNhWJ6U0hK+HgHcJp/ahYSamQXnlIEbRRr0kJ4T6BYppAKVU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2218.namprd10.prod.outlook.com
 (2603:10b6:4:35::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 15:12:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 15:12:15 +0000
Date:   Thu, 31 Mar 2022 18:11:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>,
        syzkaller-bugs@googlegroups.com, fmdefrancesco@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Message-ID: <20220331151152.GH12805@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
 <20220331152622.616534-1-haowenchao@huawei.com>
 <20220331054156.GI3293@kadam>
 <fdebdbd3-575b-b30e-d37f-dcc6d53a4f53@huawei.com>
 <20220331134210.GF12805@kadam>
 <574d33978be5eb4732cd3bf61727e6b509a7e484.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574d33978be5eb4732cd3bf61727e6b509a7e484.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac741c05-8ea8-4fea-7296-08da1328d6d6
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2218:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB221831B9617C1A6D756C218B8EE19@DM5PR1001MB2218.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtZCeSBLxXgKc+GtRdoLByP7rGnr4zdap/0d2d9a1FNZ8+jVxr3bK2dwP4IRIodlrDCTvv2mdVyXE5zDxCa2kqiOMGm3BSDFCAGKtXeMNFjOu6D31mGo8z0yfaOPcNqjCScXL4def1zJzIi8qLezTl5s+OCl2sUVtrncGjraw7ORVHO8Krm1K0/d5TftHld4GwUmaRSTCwXzar39mfc3oQv3fsOu8DbSLE6Jp5+h6x+k00oAB/WOD0MhHk4cr0zUBn9Zna0NcAPFZMtTrExAzvSYAlpD2za5Z8+8nWNRBZiApANXr2/+UnZwlRDSPrBF1dSHD6DvNO+ix0F+K6AaMxO/tMNcnU4JOhwReZGqw6ToVnrX4kpF8qL0z0oqgv3N+veZlAAE1Ckh+f7iQUtTZ6o16iSfKQaYemfx054KIdsBFlcPUZCU6+Ykhz2gqpdQgDbos5VzIzGVxsstR1R1/H1F9zJMBu699RxH11M1jST/HRizOysnrZATtZNt0Vbj3p/QsftLJ+RrO28hmokgyb5+YCWAE6IMPf9cXIt9xkFUbtaA1YHJ4gEcTg/pXujVNYDZcli8E32gNVugO5I853VYfIrJeo5znqFndW2h4TFiDjdrdyTQaqyrFlH/wXAJ5LOYDAovFXBFX/MCvuAHa6aX8mao4qCsjgY4wa7eM9xbMfprf4LfBwUjb1HGLEytLzLK5QQyFZK9HRpczFwnDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(8676002)(66946007)(33716001)(4326008)(66556008)(66476007)(8936002)(6486002)(44832011)(4744005)(508600001)(86362001)(2906002)(6666004)(7416002)(5660300002)(6512007)(9686003)(38350700002)(38100700002)(6506007)(52116002)(26005)(1076003)(186003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1cdp3XuU2M7xq5qaTnpxocJsvwYi4eGdMmfnmkTpFsCElZCy0VZl70i3rP+?=
 =?us-ascii?Q?1Hj6Fc3JiObClSU0uETVI8pTRGaUJHQNngiD4Rqf6Rtl7p0KO9NK50aS4Q/h?=
 =?us-ascii?Q?dQatJh2UKmFhV9LLTRWlolOADLfIivpV+q97zbTdqaILgceHXISIt3XLryoA?=
 =?us-ascii?Q?Bf6jYhOg/BYBK2HswBOGCzNKMqzxrW8lvpKAjwwBziyoUSEW0jGxw/vTThaM?=
 =?us-ascii?Q?OlK0m5exs4zllUJY+a2ZvO1wNhdJUR+D69R7/+7JSzjp24zcHkoBhe2rWiq6?=
 =?us-ascii?Q?F6A3gTrSmDSfb1SHdFIXMCDbZc++VwIohWQJAbE6gRj0LGCQMFWRvlRycVaJ?=
 =?us-ascii?Q?FiafrB8HfsmXwhTveVZO5M7uFMEPVlR1Rhuw3cae3psOwILOkLVHpmrYPJF1?=
 =?us-ascii?Q?aM1pPUs6HQ5cIPO/SkTOCrHyPQPTWdOp7J/WWtd9+tDUuslN4mfdkB+f0R03?=
 =?us-ascii?Q?ZT3XZ7NW5G8KZaqgQIlql2axL8juZ4Iq8zg+lboB/lA9nSWUE+0DetJceJKq?=
 =?us-ascii?Q?d9x77R8mxE9DOlZ6YnQR1KoWmWhd4MIgwBvnFGS2ToDC14ru2PWGltk/w1LB?=
 =?us-ascii?Q?oYEN3HgpsE3oKv/S2jYmycAHwypWKd/+NBX1UDe3dU0WGMR/0EhYudEgj78K?=
 =?us-ascii?Q?UNKmCwbBLqZncYZ3dGI5nk+rFOwV+LiCqpGIt4im7tGdnG9WT0Vltsww3No3?=
 =?us-ascii?Q?oqQB6HDVsv6Wqr/TMqUmjsumJJ+3VuRllAVCvZnihZDTKRrXWHtpTW5pMpis?=
 =?us-ascii?Q?V+XBD2buK5taPT7FKvjUYZ1Wo8stkcZm6EycfIZRbUxRLM6nvnuxNBGke8CR?=
 =?us-ascii?Q?TLlW3I+rZcrq0xzet9fawTGZotWm4Lp4GAkonwn/RnQUwoKPh6cQXr0arHDX?=
 =?us-ascii?Q?8CAUoPwwc99TaZHXI5VO1IVXYRzIffZY+5wqNuhsz2EQR109VK3EO1yIV1R7?=
 =?us-ascii?Q?fZM2/5hdw8B/lxlH31b2RfPM0VyIn6tp6DfRLYMC+aBPvtdj79zLuJK/wggw?=
 =?us-ascii?Q?UkG2jJjvdZ6xyioQ3lFgVAG3cg2o4XuJOk8dCC8A/JLO+1n3T584a9xSzrou?=
 =?us-ascii?Q?3krbnhGFdLTjX/Jl8shq1+zvoneyLF4X2hdBE58tA5Rgr5dBAZ8AwDYe2Xyq?=
 =?us-ascii?Q?5JTvnfSL65GYVCe35XKEDeihwN/vvslMSgdrhjHvnrq6IEV9Skhy47n9Zqr1?=
 =?us-ascii?Q?xIiS3F7IKYs8ewhXrdTqATJw7gm0HCiWyaGvXE23QiaGHxCsSksqBqhiC/Fg?=
 =?us-ascii?Q?P9LbQdTXpOv083CUX3N8uyI/K5WxnhooWlUY/YKPQGnJE8IG813eeI7g7aZI?=
 =?us-ascii?Q?v0/Hk6s8XporUsVFoSb6lFDyfFTBJe0bcsy+M/LdjFdmcUYQuuBpeHJdfufZ?=
 =?us-ascii?Q?dVsjwwSWs+SW217+tWwXqnwOnciSgfEswtqmn7JbvTfQl0oeTuyk90FA9XjW?=
 =?us-ascii?Q?pubmm5epuKJz8P7eOMykiIJ7bnGwqP5MYbeVV/568qODp+nmneKs3wDD9LM1?=
 =?us-ascii?Q?qdPcKC2IpJ6nBHVI/MinHDDld41l7Lnn3Ir2UXfemb5iWewU3XWG44m+VT0q?=
 =?us-ascii?Q?brnHTLPYMDtmbHwQ0cCJbc88shyH0xCjFIqcg5Z5ZOPYf5gbLHTQAQWqhPmo?=
 =?us-ascii?Q?wP5bYL4LNxmU0cW0ie4UXNUKABC+m535qYJ0pKzyLvQHBsYDyO4SlHnDmZOk?=
 =?us-ascii?Q?J7gRDuH3aEqWInyu2jECmmKbCaPFT2bUYxXjWqI/FDM5XKYXSBlNseEHjReb?=
 =?us-ascii?Q?DCIDvNmOyFtXmX87q3r+rWBhzHFQVr4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac741c05-8ea8-4fea-7296-08da1328d6d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:12:15.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHbjYJUal2zJ+gFkgzgM+yoyOV1Kw5UkQqqn2rLU4kBZ5DsZsXcRE3AuyTXlBBvYz9S7EhL9m0+WolTL7OxK/uU1rUxOvXglsq0nk3MBHMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2218
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=633 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310085
X-Proofpoint-ORIG-GUID: sttJ3hF5Y9saA45qPnzJ-ltQNNBn9I3T
X-Proofpoint-GUID: sttJ3hF5Y9saA45qPnzJ-ltQNNBn9I3T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:19:57AM -0400, James Bottomley wrote:
> On Thu, 2022-03-31 at 16:42 +0300, Dan Carpenter wrote:
> [...]
> > Also, I don't really understand why we don't have to call
> > put_device(&sdkp->disk_dev) at the end of sd_remove().
> 
> That's because the final put is done by the gendisk ->free_disk()
> function which is scsi_disk_free_disk().  Most of the gendisk functions
> we provide convert a gendisk to a scsi_disk (via the gendisk
> private_data), so the sdkp has to live as long as the gendisk.
> 
> James

Thanks James.

Ah...  And scsi_disk_free_disk() will not be called unless
device_add_disk() succeeds.  So Wenchao Hao's patch is correct.

And after that there is just a missing device_del() and also I see
another problem where if device_add() fails then we need to call
put_disk(gd); on that error path.

regards,
dan carpenter

