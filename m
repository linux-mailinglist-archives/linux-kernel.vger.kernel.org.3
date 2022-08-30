Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1825A5E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiH3IdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiH3IdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:33:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC1C274C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:33:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U77Sia028997;
        Tue, 30 Aug 2022 08:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hkDhdO7/FqYzC6k2Ce6+IyR+dlYXk4DxyeC9AWfCwaE=;
 b=PBUCzjYcip4vS4sdR+KRcKY4ta07UuFOm5NOV8H+P0/Ihp++8O18hN6jHzG3S0P3Plae
 VoEzakLQ8A2Fcs4w2VbB2Wr49Xc6DJz7mkuV68358Uwki2/2zg+5hvggWLLb/7aYLWI+
 Al55X+nhPkpbmKLWSr1dFssLyQowWIDBkcEIpUWr05rYiKdGtkwFz9BXQfEChDqVGD2R
 d62LUEeIR7l9xavwebgnDGrXkOWVlc21wDfREri3ocKMRcljXAAC8Puaobwm+zWDz3lk
 oMgEddOeYdbaRE/CGYb92YEbZjMB+VJbknvebzdpQK9//qBkYYIccWaTnFJKbv/aoUMB 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0nn68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 08:32:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27U8HaJH002468;
        Tue, 30 Aug 2022 08:32:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q9safj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 08:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3phl0SyNQOSzeZUjXjsGOsVLpRHgtr3Dbcg38Dh+5lbs6BhiQZQ8MBvl5J+pOqSJl3bQSTdzmJVF95duScrHQTugFWmx5IpqW6H6PzP+LG0NvT2ajb8w2Bx5Cr9F/zpnfckY4zOCQm5LifY4u8Y/6fT4rbIugRGcheY1KUgm71yXRqzOhjxKh7yB2VVuYuMIoSGy9AF+RiCSsfLSCXMS31av8Oci7g22du7Ae2gO5mupk98JjrohHbB3t4FO5N24ndzTIHRaVL9PyhZXABgXiMVqaKEZ4eqd0Sa88zuRb/abpeXnMnDaXhVTqwJmoXYrObfWffLGOAcyLG1P84EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkDhdO7/FqYzC6k2Ce6+IyR+dlYXk4DxyeC9AWfCwaE=;
 b=AilHjo//chNP+hmqRrFGvzZtDxe89q3NOJbm8JTuZYMa/qFPtoX3v9CHqtCy3M8CEBlH5953W3HLZEoV5AHgCFAIWo1f1GTWDDYpBSPvq2aROwpcgk47Aq6LmBbhvP2yQ5wnyy1moorCGpoeYK7ng70MGv0GGWKdxym/VCUMWnNHwSLmzXtDfeYPnuej+MfKE04o85BDqzyWNAlhK5C9aDfCZELKAvBVIZHq7t9YxuOh1Wnz4sOUwFbm9wh3DAWV4gGZ9YRi5K0v9DbqR9nx8sYGkOsfPL/0ua16Mo9VzmWSdW599H7+9uaBB8DKvPCRNpaPjphC6wg6yF3liDZDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkDhdO7/FqYzC6k2Ce6+IyR+dlYXk4DxyeC9AWfCwaE=;
 b=NtnQH9wHH7Q8b28IdzCEQ7a3zImrC+33wXdNWd3+lIHYyX8zHy/mO7abN7kxe+shLdWtyCsm5RrtBwT+VX3YvZlQdDgTu7BXVa5G6aWAf508/qRi3SUGx+sH1M5r+dvBCF2VJXZPikm3aU5AcOtNPSZ8dTxa8aBPtqFCTog99Ys=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1237.namprd10.prod.outlook.com
 (2603:10b6:910:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 08:32:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 08:32:32 +0000
Date:   Tue, 30 Aug 2022 11:32:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v4 3/6] iommu/mediatek: Add error path for loop of
 mm_dts_parse
Message-ID: <20220830083206.GT2030@kadam>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
 <20220824064306.21495-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824064306.21495-4-yong.wu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a9ae8f-58ad-4a7d-f81c-08da8a622e9f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1237:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJE0KkOjgEAX+wbAqqsno+gpPqARaX9Q/G3+QddsaMnXMt/DJvfXX7uXxa7cm5KXmKQ1KAK7SRMti/yrRlK7jXYciF+mNDn+6lEYkJJ3INv/bL0bKjkzTlR2b717L9gOZWCtxVkAQCuGUK/bBQg1tzmkOABGFy55gZ0IKcqMvaS8MCVaAaz6en/akwkOL6FOlyg/7ub7uqIYxXeZV9mX8+9L9Ea6md7N3/Trg5IugfL/Uh8ApmoGNCTHOZU9HVwVcmCeTGh2IMGmey9oNiZsBSOl3ser5XCbgP57Jla3aNEmI1OFoPHzlwRRNXXF4lAdOEoCgQOc7Hb5dOrQwM3J7V6Rwh7Vdy5rc+ZgfORnnFkbDJdJXEZXoHPI3IVkW0v/af8XATOSg1h9BbMiWfWqINz7bYES8qPNf9vlvNoruoZLKPBg4KUrPMyJ2dSgTceCPu5BbKWU8+I3882F2jo75PekdSmnZ2gXLHxKmFl8geQXBxm4EY57BzURVNLTvLk2gE7mbgttX9eHShnVs9gHLo6Tf0tuk7E7yf6+evwDSXjkCk041aCPN2H715+cXoCOu0jmr7mDQ1cnf0NpLD4Oec1hvPaaIcNiEOg5uTuYjWngIgVmUCq+DzmbYla5ZguILcHEwoAb0VFfYcLHBo5VGahvEDrjGxBKfZ9L4AOdB6DmhAWELA7FHwV3bQ5pwXYtcvU75lWpLabH9YlQ/3rYvZifus0hFhoYMADWyUN4j2NZQePUQvzx3captZ6VSvo3NR/mc09NNflpQAjF5VfOaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(39860400002)(376002)(136003)(5660300002)(66946007)(66556008)(44832011)(6916009)(8936002)(8676002)(4326008)(54906003)(66476007)(33656002)(7416002)(316002)(2906002)(4744005)(6666004)(478600001)(26005)(41300700001)(33716001)(6506007)(6486002)(6512007)(86362001)(52116002)(38350700002)(1076003)(186003)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7CtLa4FF5R6xkt4OWWqt46EeSZdI+GJy//W8D/zxmKzY+z+TW3TY0zr+CWR?=
 =?us-ascii?Q?5572IQZhl8GTexxoXDxZimjlIS27ceMtAn/lGXrQ+X/JTPX3B5Kum8LxrRc+?=
 =?us-ascii?Q?IKGnvWFu7zEniI4S1ZcoRFn+j2AmsauBV53oTUhCoX/Nze9WWNzs3SjDF2b9?=
 =?us-ascii?Q?YN8bs5L8oMyPLqOvQJIm1TyTHZI0hyvDZq9TpAfxJgLMgTvZZixZ29nzUw4v?=
 =?us-ascii?Q?0RJXJLktR/icYHbrnZqjLlwT4/c2WiqSoxKCkMGMlFryELIWr/SWcovvsMKO?=
 =?us-ascii?Q?0PorA1vj9nJ3dR/dfi5KmoRt9of8XFW9Qc3f3gmhksz+m9Q5027zqLY5ruyw?=
 =?us-ascii?Q?wJuNRwo1mrHT72GYEqqeXpggd5d1x1ZjElwb4ktZkAl/Qb32mJe5hWuV0CHG?=
 =?us-ascii?Q?uGa2H2nqCg9ztGs3xOmX3vJ6XT7g/jq2j4YFYy3ZOMVZj9KO5RvJVCjImVSg?=
 =?us-ascii?Q?/k6+bzXKP6e0CFH9JA7pyf+N3tkLUswjT9pPvUUDco55db9vSjZN7O9ZgxYB?=
 =?us-ascii?Q?BUA4L5J08LXILBguesl9Fqv6cbqf9c5qNp3Fm0BWJYofnZfLu7HB3bfmnmYO?=
 =?us-ascii?Q?D7eDX8htVNnVJnmQuidKgY+jvk5kW+CGuRprHxpPOjzsVnEBjAj5AyMg9QjK?=
 =?us-ascii?Q?iEWb6fh5bk7sxZFfbFzshDBV7GwvJx4lZOuV2hMaqJM9qSyZgzhmNFKInInu?=
 =?us-ascii?Q?BaIkYSqsZRk47l7Bprr6LO+ywasmCl8jmqds6Js0FgCunxm7ZT1rJ85dK+yu?=
 =?us-ascii?Q?YJ4rqpewE02CY4fVUe7Go2K342lvpXtmkTWe50hOg2AtVZV4zJJo91g6r7Ur?=
 =?us-ascii?Q?wZy7SMZ+6imIo2XEOUuFi/u89CbLsY0lK45fMvy5Bf0sK3nhdo1JYTgBXOy2?=
 =?us-ascii?Q?m6XTdahaOkaZJ2Cq27lnJme+n0ho0nn1FOCRcB6LHxXzKCeyaZFg2wz599f1?=
 =?us-ascii?Q?YIBR579F+bvR9QVzwY/hjf73IIMb3Rl2fDr/bJUOhOJV2vZTed+lqWDX+MEa?=
 =?us-ascii?Q?vmUXQKY2KRYT8LM2JqHO9dbG1Uz9Y94vAMSadx+3UHpWG2ysbso5teyiDzAn?=
 =?us-ascii?Q?d9z4enh7UZXk9AJcvu1Mas9lZBZ+8XW80hoU7V6AiOtKgNhIwUvyk2H0GSCB?=
 =?us-ascii?Q?v2i/osllstY5YAqC7BztGUeznPm5VioYxf5XZdzyC+tWFg1W7FHbf/unCq5D?=
 =?us-ascii?Q?eZooM0q31iLuGk+IT510ocjFbgPqEMCGTi81pYhEFc1HxlIj+5eHSUbBBmKS?=
 =?us-ascii?Q?pR/BNeuO6vyjrXM6uCCJBUSSNM7GvwhjoiUPENpb2EM8uI+stBjAknDAdIwk?=
 =?us-ascii?Q?odzXCoIyBSjKqnnobb30Le+PPfVqNIwCHIUxrA2bO7asU2NY/yADJ2YSk2yI?=
 =?us-ascii?Q?NPKFye6kOQzp+ltNLf8uLrhC+hoya2xAUCrFtm/rBYvixCtQrQ21Ice/1j3G?=
 =?us-ascii?Q?UBigSWa349h59YEXtiCXkQDZQT6JrLvcO0JwNiGfUcgADXJQStbMhE2a4rIJ?=
 =?us-ascii?Q?MZJkYVCYUreLh9//6K7+kvIHt0bmlI/8TG0AG2UDzzl1oYLuZGz+WI5pStTm?=
 =?us-ascii?Q?pp+AUF++oMIv0IyFsaiRpT6Zd2w/xm4Yi+vJEOKkxR89f0MDzOjTkGx6E0Bo?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a9ae8f-58ad-4a7d-f81c-08da8a622e9f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 08:32:32.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoPsiP3tnijN+IGuEg/fuQA92IO5NlpXRnlmHOFj2YsWGJc1nj1mPa69F2voM5ngYWSR3lNvo7Dz/zrmCleLNwjcpGUwP+tWYYvUiAYho08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300041
X-Proofpoint-GUID: uMsHMasyWkuM-nJ8FFIQqI1iCPS50Ngr
X-Proofpoint-ORIG-GUID: uMsHMasyWkuM-nJ8FFIQqI1iCPS50Ngr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:43:03PM +0800, Yong Wu wrote:
> The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
> larb is parsed fail, we should put_device for the 0..i larbs.
> 
> There are two places need to comment:
> 1) The larbid may be not linear mapping, we should loop whole
>    the array in the error path.
> 2) I move this line position: "data->larb_imu[id].dev = &plarbdev->dev;"
>    That means set data->larb_imu[id].dev before the error path.
>    then we don't need "platform_device_put(plarbdev)" again while
>    probe_defer case. All depend on "put_device" in the error path in error
>    cases.

I don't understand what you're saying here.  There is still a
platform_device_put(plarbdev) on the success path after
component_match_add().

So if we fail when i == 2 then we do:

	put_device(data->larb_imu[2].dev);

But for the previous iterations has both platform_device_put()
and put_device() called for them.

regards,
dan carpenter

