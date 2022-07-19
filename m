Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE33F5790E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiGSCbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiGSCbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:31:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00AB13F80;
        Mon, 18 Jul 2022 19:31:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKb7B9013956;
        Tue, 19 Jul 2022 02:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=XIFFZujGLqp/3FQ7GgaFMRV7FIvBpG6nyaRArvj1JVc=;
 b=Zqg0oKXSG+xzYagtmK3mSeB3rcUzHo+nJ4adwdVIUQCbk3JrSk3NMcpxJNn8ZG5KZmSP
 bBAcazm0/x3FqhfeKFBiivr6ZW+9omEsvSKCLLMY9P5ujJCOiTGHG+XYnyHUUcHMMq7O
 /1bv4v+Ee4SNfZDNxKAkXeluYa0By8xGjmlYWu+drd97yGkNzIJOghB27AggnFTOzX8Q
 FfG7d9yysthp23ggFJL3JfPlpfKASijIWFDD0cCyJ/wh1bNGXXzO4cL1kFpVkS2kW2T2
 gCFsNFjV8vcxe9KnKTzv2p1mkIVxRrBS6AhMVfPG7Xyx0xgY1OXg+ODx8X9aGcm8yaK9 Vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs4w86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:30:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J0AEDj007931;
        Tue, 19 Jul 2022 02:30:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1em42c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYc5H+X2v3YhLdNtH8JdKFN4prOCMENQXGWzrSWeypKuhXcWHN5lPkktySGzT0LeFIkK9L5a4ky65LdQp25PEIZZwyrVQxEMPs5ysbBWoMLVKq+WgCDQFVYx9PAgYta0eWDSoALG3QYudzJBw52WaqjYDROyXWvLNwIsEzGiQpwbxPIrCy+aA3//IB6OZCH656dGqzWOoQE/qpgvMJn+WCEHLEjZ0hIxm1UtlJdvbpbK2FMW1H+ogIMBdSmkM1eXqH4CYyOmjRLDbWWsdDM5DElYJa+NqPN1J7jzojyR2uM97gK6d+ZOi8zNpnOO8oDaGtUoG+BMvj1K5xSMDM3OAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIFFZujGLqp/3FQ7GgaFMRV7FIvBpG6nyaRArvj1JVc=;
 b=MVbEugVfAMA6hCtHv27WM+RSKpoSm82vuJO28WBa5o4ANS0Bu5zUwb8GMEO/+Rc4ewN0NHwLIN3+dyA4MSme6+JAKDTCoXiILP3kYQyoO5egPAKJEeXCOnfWt/8uE/lFiOrKA9xHP0sZbx71X/UCjUdUgUFAeHlrpAba6bDVJM+xBYnYqsOWC41n+qzwNty+1443LRyFSOoKKejyMSWupNPityZX2+EUPkfAIG5zOafbuEc+MxDaoZJSro5z8dRkCFZKEqcunRfzTdxfCIoXLD9yhva9XQLJ8Z/e0b4M+Vum5qaSO6SF97icWUZVzfkV9thugj0wZaWVrpS7qJ2Q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIFFZujGLqp/3FQ7GgaFMRV7FIvBpG6nyaRArvj1JVc=;
 b=d3iRJ2IpsJixRNoHivUaEQbHaS/OJKnjgpe2eCYbHJDTcXFSka+BHutmyj9YkGalVBL2KG9OjN04fMz1SQYZpd9JwO9maY2qOFdQW21SNcFeRF3r3nSpwZyhP6R17su0HR5YqzE/XInH39T+qlhpCxqR2MIG1wdajMAGE3PuJDY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1768.namprd10.prod.outlook.com (2603:10b6:910:c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 02:30:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:30:43 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA
 optimal size limit
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18roprg0r.fsf@ca-mkp.ca.oracle.com>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
        <1657797329-98541-5-git-send-email-john.garry@huawei.com>
Date:   Mon, 18 Jul 2022 22:30:39 -0400
In-Reply-To: <1657797329-98541-5-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 14 Jul 2022 19:15:27 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d42061-2f85-4bbc-5b14-08da692eadaf
X-MS-TrafficTypeDiagnostic: CY4PR10MB1768:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwaqvDmC2p73c+GvpLCVXQ507ysTrayP+VOn+KBG7wK0E4ZRI5YTYBueHaL9AQtw7SYFBwmryiBznnvQgryVHLEUq7vut0+p+9bRBdoqwPxmT8dpX6VAxQMZE/wH34AveQYyIAsmPy8JZiiAH2XQ58ZYupUt3BjF8Cw3/w4YHg2mVr0TB1djCsZ1/xBU8nNzclLkpcfHzOQJhZLGiAAMwn4/BERgsgiGkM2hy9VqEHWkEmSWXS2XySRvg2X+b3ZLxx5ccK6xFRbuAjn0G+KzOUcgQ/tB2fA0OlNTHew5OMIADqQOeZmEOZMFPAqnyR/0VTeSBKohO1IlelkfDDKljFsYf+5ZY8TWnPU3RafAhmly5AB8mbMkN/55nwdUgClyxJvytUq6KUM8w+8kvL/IRebbB5ubA0Uk7k459/5REyyRwzBzCK+zABC7Qe4CkxYCOnf/7eXjHD0anlbqyrLQLK9ZaVY2nSttfszLgWXHIhUbrBhkYkn//mXlwNL5quIM7nBlw2TuFC6cPErOOXIobFIO4IOLcNZCXcJWqL0df4JBbHFk3RsjTg6qlndu5Tzbo7mJy02ODRZbf51NPblHUysGWM7JXTF2lA/+zl/mLW6w6HGA4YfvYMlQbfMYAXNqKAHQ3LaJGtyP3eZZ0zX8aEmxkZvo2JIJ0GS74h1/Y1zmhJMJpA8rAKY9WPGX7w4tKqFx93qi1NxhWbLTUE93cvd4BHE9FQxH3eLGwa4yyFFZXEvyuUixLy6WQSEg8dJCM8/cB8U0AMs+DzjaTFYf6uFpZJYjTphzEowEZDTWSao+w5xMB7O2JTxm3vHcVU1m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(316002)(66946007)(5660300002)(4744005)(38350700002)(86362001)(66556008)(8936002)(8676002)(36916002)(6506007)(52116002)(7416002)(4326008)(6666004)(83380400001)(186003)(38100700002)(6512007)(26005)(6916009)(478600001)(41300700001)(2906002)(6486002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twKm6NM8+kb4A0WU60tRkdFFTjzinQB+iHtQbJBoiw22T7sl4rtdM8DJ9F5T?=
 =?us-ascii?Q?FGqP93rjwC52np0RF4N/UutSwhRXwU0W8kNd6B0C8zIeLtYvBnIPK72bc2AM?=
 =?us-ascii?Q?Ld+USK7KOIDko337SejoZ3qRGnIftRoysHH6hPsmzswQNiG+jTatjA6Zo82L?=
 =?us-ascii?Q?AagZFjym+5atNsbrTgx/yG3NZtx+2ljtLr17bmz0KWJbwkFkNlVirN0WIUo4?=
 =?us-ascii?Q?BW6i7k8CMB7JAl5MiWkBkF8U5vJ34NUjpI+CJU8keAb2TovgQwEo6NoYwxRN?=
 =?us-ascii?Q?bKFhEXBRo/+GjNvP2VxJM7k7RqIBATjLgp4LFkcZV1fOzqpDOwM74RhFBYdf?=
 =?us-ascii?Q?6P2neMJ+Sn35ppIpJ1XG80iJreLPJck0UpBooHds1pcnftS/G9XX09ovestd?=
 =?us-ascii?Q?fR1NrIVy9o3yMcvrvpkQD+KKf3ebsiKBcVGkmALMclb8U9j3z/hDVWJMrYdQ?=
 =?us-ascii?Q?FX1f3aWvx0CYy6tyKNSSdq7TUNLzRZK9IYW/lkt54uJmUUXksuNuKXvje07+?=
 =?us-ascii?Q?sgAE0LIzU1wDH4xkWhNNIEV4Xprd7kS/LRICyYd6lQZw6NsWQS+FbazqFxMS?=
 =?us-ascii?Q?xgkazKplF4QDFLdCL9u1kBxCF1xFYDSb5hTjOMzFR5VkJQAQQ0J+/LTXwwtU?=
 =?us-ascii?Q?LzEr3cNs7DNmzJ80+BNlPU6wpsfb6ijS0KS0pZWGfvAp1VWAfNzk6UJ4J+JV?=
 =?us-ascii?Q?CVN5L2JP+5aPfnzsa7kOKzTXGqYJdM6roSjtALToZmoqvcDkbosV26hQEkCK?=
 =?us-ascii?Q?Kx8DUa/oZEzd/PyyQwamaCH6cn7Xk80SlAv+mMLm98/oqu6AB3IPOs38QdW0?=
 =?us-ascii?Q?pcmup/aLzsHbi2Q86nMyjzxCTTKtnfgirJ8Sz9O2TaUwOOsa2jshuNtmfRZ4?=
 =?us-ascii?Q?MdVvbb2nmTmTGfu61PnWlrj48zqK7kk2Q6EYDoeMPwq/vhrqQwmEQ5V5g/Yh?=
 =?us-ascii?Q?T6mr0io6xs2DuT0rxOP8Sq/AJzxQLIUephIOxQjxGxJ6buVS7a0D20kg606K?=
 =?us-ascii?Q?9AM9Fp1SXbeCDj1r9OMSoEFwv2ZmimI46yLsDUZ99KBCksl/1utDIsZNdtxR?=
 =?us-ascii?Q?KWI9hdffghU5VpZz19//Rm+XDgeNoIbNjoN+Wcl3zkkMJVCSxycQCWZE0M5f?=
 =?us-ascii?Q?v2kVWhIUh/NXK7+mFEuu7aO7TuFhXNYVbXxX4S1wrExOZH918HbktFzpIuCS?=
 =?us-ascii?Q?+u/F4RTlSGOJ3wkoXpr69rmPzplRnkOqvbHIVpv/BWv4sb57UpxXtcQuTSJS?=
 =?us-ascii?Q?UU4dk4XqW8zPt8gu0sC4ruwrN7eOH3mrHXhfVllJiYshYHSl5vBnrf1QLsX9?=
 =?us-ascii?Q?7CQLzDjZZpFNDjhFnOPIA9AE4BSsRAVFq5nCsQc7Rqg3dGFtlApjcu6TVWts?=
 =?us-ascii?Q?UlyBe8lEzMlV6sZ7zo3ZnqSiEkaxl3fgJ3HU/JqPp5StfzupAC7KqaoSgLr2?=
 =?us-ascii?Q?Gl2t2/QAeJ18geoRMqaoeN/YZ3M/ChbJW9nBfEbBWGuFO1SYpvbMBYDhX/qz?=
 =?us-ascii?Q?myBYsyHb46zwtfTcNWgKj5yUvMAwg1e3QS6EEqix0ESZrM0CyYXmuKOlvghJ?=
 =?us-ascii?Q?DzTSubcXg48Vl/BHe8nG/kd+f8FAwyykkF/QM+Wcp2e9NurCywKcjdQG0Os9?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d42061-2f85-4bbc-5b14-08da692eadaf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 02:30:43.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtclvbNTsUr5KN35X8bv2M8+ykiyGT3qfvTMZiz6oGO6kTZDQVBF5qscuJMCdqyNvPPAnylYng5jR2falSOdQNqL4VetdAJPasUPZl+3mOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190007
X-Proofpoint-GUID: sKE8lQUSl3Fv2-Ao7dwW0guX0D9Zfl_6
X-Proofpoint-ORIG-GUID: sKE8lQUSl3Fv2-Ao7dwW0guX0D9Zfl_6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a1a2ac09066f..3eaee1f7aaca 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3296,6 +3296,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  				      (sector_t)BLK_DEF_MAX_SECTORS);
>  	}
>  
> +	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
> +
>  	/* Do not exceed controller limit */
>  	rw_max = min(rw_max, queue_max_hw_sectors(q));

I'm OK with this approach.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
