Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF51578116
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiGRLjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiGRLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:39:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96A6452
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:39:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4SjO018834;
        Mon, 18 Jul 2022 11:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0Y7GYbCKVmalfoBR+iyBhMoEXEBUQ0Cj+PM4MkReuoU=;
 b=r5Hx70sc/q7e0Dxlw5Zng7yc4pGioFP3Ikhe3QEmnKhhM4/ZZk5DquTVmEPTxcOJWtJi
 WctJgC/FJ2b/Vk4KFqje106wfGwdMxXHQtjWwEoZWlJYKsHnzPpRn7uLPwT4vjfPWuk2
 e94nOEavxum7dhjDWgn2eMU2bGy6fFB3J2ywLAdcNiKnNQUjzpnC3kbYxzD3dUqAUzRi
 aJxoZzpNR9cHfQGujpzH0C1MxBeAxAkaqfNB5T+UWuw+1+GpFZs1lWLiljr5b176zfLH
 5NU9ZfZ1kl7Rw7kamzDW4rU1Hv4cQjBUbHpvGnD1AfwxELAbfyHKTjYdwg7NeLgwHwvu tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a2yw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:39:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBd5r2028080;
        Mon, 18 Jul 2022 11:39:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ma64ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPON5JZRhnsNx6HD3kX03WKywdFx9DFWeubyvBSRY6uWmUkwKvd2kVIkhi8knAL3Kg/l++Vghq3fX2MF6uQhymqbl6WxXR1t7OXXUFXt5PYj0CHXrH6JA28qP0mXQiDLHjeufo4lSRhY518WoUfuu3DsFo1W0Y3K4+cluOYtJK5vVoB9d2jGOVgiJwrELxmfIjUO/SGf86+7fgEVYid9gjSU4os2JjBE9j1+or2gX1AnhQpwU5cIpHprDWike2bsLFT7+F2OeBS8/798rbkLuaaS31lOJAmPBaTiJNw+rcJhaltOjtOjetAzGzooFEa985152NRS2bq4mqlqoq5LDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y7GYbCKVmalfoBR+iyBhMoEXEBUQ0Cj+PM4MkReuoU=;
 b=CHkJGY86QOkk6uEnwM7THEwcx5DWTsymfCKGvaLKUoLZFilPysH+IRasAKtrzdtSANh0BbxA0on3Q23iQSF5TnNGJagnsHrO/NALgnLR0VgZraKEgqCCHF0hqPA3/jYPN3f4qLtWi39HTaxVH0jBgysgIUytmhO9vsfc1YuDzzj7zOBW4ucpZzwZK108chEhJ8Q2pd+mwmP4sW6rYcT+3qhbNyk6K/t2i+gciBIRvK2CCN/bAZAmXzrMl3TfuFHmBbP+E6FDrYf4j2UrjwIxGm8S8kcbZhPQDYAsRUqlbk6IZoqLVjPpQme81ootwekWDnEYdZg6HEKm3G8YsS0iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y7GYbCKVmalfoBR+iyBhMoEXEBUQ0Cj+PM4MkReuoU=;
 b=IGSVxCEvU0Fi4FG4Z2eMzOKqfk/zzy3kxRsdfEQWfSlCFx0Zld7PK77m6a7KabIiU1or2TFblQhep/If5n4uTHPZ27lrtK4tySKAT+rQXWVw3HLH86smqSRTJQudb1WlXUgZVwdlKbDX7WjCB1emhsponP5dszqkFbbkM2Tsfes=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1622.namprd10.prod.outlook.com
 (2603:10b6:910:8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:39:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:39:26 +0000
Date:   Mon, 18 Jul 2022 14:39:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
Message-ID: <20220718113915.GB2338@kadam>
References: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
 <20220717070204.705878-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717070204.705878-1-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0009a3a7-4840-4164-9406-08da68b22b03
X-MS-TrafficTypeDiagnostic: CY4PR10MB1622:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+jaMgJQ+wYZa+waZhPanTpp7eBQOPvk5GUVRVpyPdigjMtrh5FQIUjpUdbDf+ebNnQqgkBLBetI7ZKlVfwYcv01SR/OzveO3wl95UvXt8tuAPeDfQFvevIIoiyMNyABmECr+i2sDvRLp7G85TXeoFkpC/cnjmx4J9yYAFttW8KVZMuoF7zw5ZbrFnG9NGpZmevrCjeZUwIbJD7FWsNjCp+4S19OfHRkNV0C4uWA0zwa87KQG05gxLKrZ7Yx2EP/pvGmpT3GExEpXsEMQc8xLEw+7yh5xgtZpfy/Y1tDIPYViVIq7ZLC6y6s/eSkonTgdxoRAlNFppRNqPvz3KCUHXpz6UeGBD2U9km/msoeTMQkeSEd4vL3NmksB9YFqY5TBkOp0pXapPoXeKVuR9j1VogKKNl0QFV2v2Ls4SK4l8XZXT96xNC2D5xaNahT0BuiVkswun0EfS3GBvrBV+uB//EeaOR5Sezi3YhJDXTaHLOAW4a+VNM35pONA/BWEb8CqqnAoTSVLLUv4FH/F7NUesmXl5+4aCrr+ius+/li4feC6LXAJiGiUOJxUeTR8TTku4vkMQRUTjSToNuFtpPjGoC9FmmZgY0i1PPVRYJVkOSF9H/WH34iH6N3zsXzkhRbDy+LxL6HACnUhv1lPc0fKKFxEv+E1r9UdBA7z6bPE7URd0AzId9CXJ0bPpT/1yA2FOrMxCaepPG9EtF3z/M2lTGP+qhRQdiO2z4GDi6dvTPqPtNoOI+pG1e49yEGyHCxRj0HdDVldJbHsiY8kL05HF8/RqeFlXpZ/LtplFMZCH4Rpl23sbnPxgjxXfVhcTJW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(41300700001)(478600001)(86362001)(52116002)(6486002)(186003)(6666004)(6506007)(9686003)(1076003)(26005)(66556008)(66946007)(38350700002)(38100700002)(6512007)(8936002)(33716001)(44832011)(4744005)(33656002)(2906002)(6916009)(8676002)(4326008)(316002)(5660300002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPJtmdvJXv/vS8qs5mFfBnmAYzuZq5zanaaKTetnbQinXNOt6NGCiX0vdREz?=
 =?us-ascii?Q?wDjbDppqddf6ZFJWVvdQFdqPeJPFfzSyY1d9BnZrJmKvEaPBnj7yFc4TIpuz?=
 =?us-ascii?Q?tO58BXBQRy1zXLJlqattVMZJsAV5MYSAq4EGi0e76Rov4i97npDo+iODI2oF?=
 =?us-ascii?Q?EkUgULDkxFsDqP7/kYBoru4MuA727tkU4VYKCdsDp9lM/Gcu8eZI89IPHC3k?=
 =?us-ascii?Q?rRUj0fIanroMNBLcaNdndFvKz+Og/z/8CJt/mIMgMTUYgwO/98kzcU+xthiO?=
 =?us-ascii?Q?6FSlCsUPkw5/zJVO1IZ+b7O3HocNuWijrrCXq1SNQtYgp8tG8w/q+a4rkY3m?=
 =?us-ascii?Q?EvOSYAjoVWpcYXEucv1gZKOUqzbizyXXkxDuLP0nTRi+VH4R4mkkn+pThoPN?=
 =?us-ascii?Q?URwVgW8BGoPzNJ8yL9Aci/as0itdsEK4gf8DxKdBR9q48BRrL2WIX3HRAt7q?=
 =?us-ascii?Q?kS4ByiFtEPlqnDdGnuW+wRK05rJ0mB3j2ytFOjSo83RQvU3ahVsUDC6H47Iv?=
 =?us-ascii?Q?+n3IX7gFIoiua7+UpUbP3eY9QQICGTQXa5cqz30hnh738SZuOr8gcrJhYau8?=
 =?us-ascii?Q?rHDq6ldzCsqx/ZIg06Vtx7xAMwNcbPQGh1HyXysGaNgyWAF6j2qodFBR52pV?=
 =?us-ascii?Q?7eRknE9ld4HDSOcIeJgSdFU6sq4RfDYhV9G8/EehnlevEScROcuqXQu8VTY8?=
 =?us-ascii?Q?kEFEDj75I35nLOFMksRx9B+Wk3icgh/3YVw+TP7uNy1VnPsBBajoOld21SKA?=
 =?us-ascii?Q?plCvWpCvfl37QuRN8daiXDBcZp7dBrBT5UweMGNcGhG55/s8AJyl8a8CsaaY?=
 =?us-ascii?Q?BW3ALFC1uBdFN3mTh+BNBWjqQxHbvUXGdDdO92/D0mc55PUv1307s3+qITod?=
 =?us-ascii?Q?SFjQTZv4tYa3+qukzuLPpMso7azsENfalpxqwMmjziKVfIf8KQosQAeQx4Nz?=
 =?us-ascii?Q?rHZgWjltjq2pHQ+wtVUaMImcZ5t26xlniksRLQNRa2IhatXycC5HNsVt6DAf?=
 =?us-ascii?Q?Auk7uKaJ0oMGiYd/uiAC9uELzz9ugJvTzD2KwR79feVH8qlNHXEsRxQ1rrrO?=
 =?us-ascii?Q?G70swbSNDYVxzIHiYRzL7/Meblb3WMtBNR0jIa4CsGvI1htiE9Ji5vHxNfy2?=
 =?us-ascii?Q?PQdLEs4h+VWprx/dud4lAB9PPFVKubWwW+R0dx8k3o0Qtpe3pfjJ6FUFbNe1?=
 =?us-ascii?Q?pxJA2kRf+3OlDqazIVTYxf1qjprixDfIJTo+ifASMgl17u1WSIpbbIJguppN?=
 =?us-ascii?Q?6NkYORYDeDZukGrBdStrQAt8iOymJJpAkaP/veKGe3PEfvExc/IOZ7q31AdR?=
 =?us-ascii?Q?z1UMV7geAeL4CCd12btpPTXwjZPmXLJ2QoZjg43uGeepTUtf3IpkI47ZZ9FG?=
 =?us-ascii?Q?8PqFFiEbLIJhvf+mym1rR08lzmLhkV4TuWQltMVAIew2d8VO5d6FySbdQmzt?=
 =?us-ascii?Q?8wDfpqRNFZGWJIonsw6aKwktn0w12XYngL+8d/U+Z2t9nVoCRfliHvMYoFyf?=
 =?us-ascii?Q?2Zvt8A05xpCEMDora4vzXN1jEZG0QT6lCtTK3J1RkyNebknANXe4xDjmAbyd?=
 =?us-ascii?Q?r+034+KTzaHvtjNB9bx07/Y96wbj0xujlskwmP19Som85G/Xb8Ih6g+5sgj9?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0009a3a7-4840-4164-9406-08da68b22b03
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:39:26.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T10wwY53w6TOPLRSAm8E7guz8T+lSGEVIUOdQetABLPIRtze80Ek9o/vXbWBarSGpMTJwCQQ7oonTwXF+qxBE40/xiAlW9mb3t7qQsnWRxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=842 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180050
X-Proofpoint-ORIG-GUID: WeTPnxKEs2r5LGozr3Rkv5PC5wPHEXLU
X-Proofpoint-GUID: WeTPnxKEs2r5LGozr3Rkv5PC5wPHEXLU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 12:01:57AM -0700, Tong Zhang wrote:
> There are 4 debug files created under /proc/net/[Devname]. Devname could
> be wlan0 initially, however it could be renamed later to e.g. enx00e04c000002.
> This will cause problem during debug file teardown since it uses
> netdev->name which is no longer wlan0. To solve this problem, add a
> notifier to handle device renaming.
> 
> Also, due to this is purely for debuging as files are created read only,
> move this to debugfs like other NIC drivers do instead of using procfs.
> 

You're doing too many things in one patch.  Maybe do it like this:
patch 1: Move the functions (no functional change).
patch 2: Change to debugfs instead of procfs
patch 3: Add the notifier

regards,
dan carpenter
