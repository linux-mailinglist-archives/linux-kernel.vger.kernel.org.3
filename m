Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67203508438
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbiDTI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377025AbiDTI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:57:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D83F3BBDD;
        Wed, 20 Apr 2022 01:54:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K7lK3M009092;
        Wed, 20 Apr 2022 08:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=n1wOzqDYc/OrsNWR+p+tHM6d8vbPcqAXfvwnhSPAvOE=;
 b=jHztad9HrShQPgd1BTJnmtqixqEtaanBG05AGUa6oyJbuKupJcohxa45LCAH8G4oPYUq
 Wz85QRdCSJnb5bLuoODxur4oApemrGB4iwaYbtqk+AfoCpvb7uK0um3PuDNjnvdfumb6
 GQcklUWAH3YWSxUzgFxs514/Soxq3SnI6EpPR2P6JSQSNLFpV07jqj5ASI8moe2P5OR4
 wDQnxUhorHKGCEMPKQNJZi3gC+jpYBvIxBNFGVnAtR2hf9ub3Et9Ceq2Aq0KhmecY7YO
 hTMSnZfwn7ljrBWsSpjDF7BPx573vu3RWK2cKUv7jfS0Smevolctdg+W9O/O6xV6v7p9 /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2rdvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 08:54:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K8nh8V012661;
        Wed, 20 Apr 2022 08:54:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8916ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 08:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTyAXoLkwxgBQq/05QBxksMI4P+g2IHfZOb8vUMXuKss2fzd9iJweBvI7kTGDVEsc6muuWmab1HKZeELAqmL573KHOcTQ+FtjflAEIu2vcctnpsN4qoYAEmkoYx3kAkESq1yszse3CT3JW+X5LUw0Pn88w0kYI90IizXzCYQ+h1EcskYjpFAShiNTLlqNzqIzGSlv4ZMXom18nGIHQ35T0GgC6J2I6Js/dWGjGLfoKrdFMkldWADnKkkc06IDVApd5JKwGAwsVrm0VOq9AfmdUXF2u7qB9xMxxEuTfLwTK7tn01BKjQZnuef66qJo1EbFBPB83wWYtmhLGW3ND3JRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1wOzqDYc/OrsNWR+p+tHM6d8vbPcqAXfvwnhSPAvOE=;
 b=e7kpMj7yfDhNwhydTX9b1NifT9NVXWA0DPYif8VKoglTppfHSf2hQpkry2J8DtpmoB43m75pSwW3F04Ygh0Y30hG8rJBcWuA8GwCsqvtRxfvd38iR/pDV9vM0GnW9S9JbF/rFCgXCtlCe8iQyUPe/dq4e4guw9MRuQxMbF9qKFzETopiGycBIa5FDidp234gJLFoL+oPHKDeQx6uzDv75f9CNaFZNyfI+d2csXIkH6cJDkVvs0lhvEhe05tcYB520MTSeJpqiXTQItIt9jUr/+aPpK2t9xlDnl6Pmoe+49aDoTpgWgdmgwdrD8a/1/pJyKS16E5sjLDHhkpRKnIzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1wOzqDYc/OrsNWR+p+tHM6d8vbPcqAXfvwnhSPAvOE=;
 b=tPn/W/9sEn0A3OQlYhy9EuOxJ5X5DhJUsVDaOs0TBBah9HwKLI5o3QXwqqOz/9ar8tafGwQhvSrEFV0CmLx09hy/vJFIaQ8i/gbxuuSFlQsSHdfWkkxVv1PZVa/CEGau3viyUi1BASpGN5zbL9LwbFd5GghTR4+PKUnQWIISdVY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3387.namprd10.prod.outlook.com
 (2603:10b6:5:1aa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:54:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 08:54:05 +0000
Date:   Wed, 20 Apr 2022 11:53:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <20220420085339.GA2969@kadam>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <20220420074249.GB2951@kadam>
 <Yl+7UrQFyLvfKRdG@aptenodytes>
 <20220420085132.GC2951@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420085132.GC2951@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d6d51d-e021-41dc-c312-08da22ab5321
X-MS-TrafficTypeDiagnostic: DM6PR10MB3387:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3387DD7B4617B46F44C3C7118EF59@DM6PR10MB3387.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pN9y6T2uscLIkmdR8clQ8eOQiId+jksJVV9wk/PcEChbukYHUm1LiYoWLS1J3hzxQ9qQl2YVU5CE+bEs6aQeMZQrQVm/KKyDZvsEyjq7RqGVHRXB1oyy5+PyBh+E3UPwd1DAMXC45qC/TRcVFigzPvOcL3crQv6NQRyLL9hOKoEIQZxP57UtpOqrn+IEAFpO1gzdCkekYAgOOlP3LfpAwivOLlW/7yuSSS8bVLG6mGgcIcY2VVv8cJmJNvlXsRUzB5afsZGjhstBAgnQpjSXnqBkQCatgKrUt9ix0G4Z+EVLwKHbAnRTFVLtTrZsqJeLS9F03sdn7ozHUeoOCuPDy6AP5dXBQMgsBv+uBAEUW19ZK2LcHEdn2NigQtABpgVoI165XH9J/MgrrSSW/v1cGHfrU30v8EMT4mD30apXHPNEVeSCQO9ttlL2IARkYFZSEHTICdgZgCH9tULElCS4hjQlvqRaYGI/jCUk6hP4Uy9aBDcuZETcCMk1lxWLxOLv0GA0FEFJfdvMGfcV+u4aHCPrjmNuFSnLyg3CyxnyyiRk5Z0kuN+vOv+C6J3Ah08sszasEa7Y3QAaeM/qCBwo/c533WbIQanuaeqDfGYXoGtWUS7zQPTbLVwsxWDH7dggSEWvhA08C4ZBFQbDRkCyK9edCn8wgp8mBV7a16echHRHeYtP/49Z7H/JUX8a7zfW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(52116002)(83380400001)(6666004)(508600001)(66556008)(4326008)(26005)(2906002)(66476007)(33716001)(8676002)(7416002)(33656002)(316002)(5660300002)(6506007)(6486002)(6916009)(9686003)(186003)(38350700002)(1076003)(38100700002)(86362001)(66946007)(54906003)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAtVm/dsgPBT/LD38J80fjr+SGYVwl/w6o/vBhCnchgJMHEk70ugCdSAMvrY?=
 =?us-ascii?Q?N282VmIatnJXlghnCsD3mjz8PPjwjdfhMdquFWhRbeK+xHnba6DjCuvzZhS2?=
 =?us-ascii?Q?rJYakVco5aQZ6wKwWvdUoujzDkMadKz6p+2Ix2gAaN0CiTilX0pcbHEa1Gkc?=
 =?us-ascii?Q?VLyl/rTqJMrBAXGJrqBntsxoHAXPt+hX71kg/ovqJoYwcE3Hkg7rT5R60Vdu?=
 =?us-ascii?Q?E6Xv0fZaGQLgmXjykuk+hwTemNZ2uGVplawKTxWrCha4OPweD1sftSnCBALp?=
 =?us-ascii?Q?gRZceBIuJOtXylQ+IiN7mx2ehxKhZs5HnJmpIjSzSMTdkKLOLYRnJ15FBbuG?=
 =?us-ascii?Q?N3dFt0Nj7gftlkmsAxguWlakxWD1nXeTI3sgYnE9mM/YPMAT3XQ2kKF/I/S2?=
 =?us-ascii?Q?FQL8Lq3/i+DNk0GhX2Isq9xrc81aeMAStD5NH2mEoDi3qFWtBDwR1925TXZ+?=
 =?us-ascii?Q?Z4gR0t5PrjJI3+Ksz5pHPDJgY5//Run7RqZyuoqBV8RTydMm65kmVQchSBd2?=
 =?us-ascii?Q?LI5hNSI+lxx7veEaqDdzePp0jdtOT4YgG8ceTmL49MRQNrqEILmWO1V1WSvi?=
 =?us-ascii?Q?HS28EhFJ70wh/FKmQwf4merulX3R4IDQmcUn52X9X1fn/9QxG3BO1vG9aKLW?=
 =?us-ascii?Q?UcbeIuP+QbzsUe/QngimWrB3k1e7JW+FWOXhCWjwRPOQ8e6u+HKXG0celJ54?=
 =?us-ascii?Q?WfTJil1Zv88p4Q4P1dqxqKYAg31t+A8mRRjs0vWCDz6ZLS99jfOcso12XuYC?=
 =?us-ascii?Q?TiNZ0AGYz3j7d0FUmPCIztvlldLK5M1kn8YzrqH+yH4WGuTum8v282tP/HIp?=
 =?us-ascii?Q?lENaSr6Lzlrd7oHoatrySF4l5nHCEV/6Ijz1UzcAbjNkF66L28A6KMih7VrD?=
 =?us-ascii?Q?S/sg7teo9KYCe7Gw3QA21aEnoPFNfrV6/ZSSdM4me49Jz01cG3JKySwydQl4?=
 =?us-ascii?Q?pbuDJKYwdJBzl6f2H5Ht0RKGWHLSm9wAsm15d3vaHfKBha554eCoyIOx2X65?=
 =?us-ascii?Q?epXWFBSAinGQ9cXyNJnbSxcg1xgB7/9vJchobVOTn74p+ykRSGt7bsfBrC1A?=
 =?us-ascii?Q?ZADD9TBB5yt3doLkD19K4/QezIM+EdEV4gF8yYkK/+D0mbYu9Df8Bkrmoh44?=
 =?us-ascii?Q?Z7dia/XAeZexZ9w0cHHktyhk7IVgK7befoukEzDqY7MZQlBy+iknWePt55Cg?=
 =?us-ascii?Q?WNUlJvyqym6I22hTu7r/wdtDQjnIl1hPFaViRDrZMyKNIgNwb9FP2BgOrH/1?=
 =?us-ascii?Q?lgiFzJPmA8+KtKs7OEmgqc6Qf/9mBd6jouLBKHOSt+Xq+sKTNVUVAan43OlY?=
 =?us-ascii?Q?1fygqucz0SrBPkLxUIOJ/PpGBeV+u/foMG2E4LHogkOVDx2E3TzY06skyE7s?=
 =?us-ascii?Q?lbPhaHLiTAEUYRWsupfT90EsK4lE5HBwTtdi1AIDYBq5md00RKJALUl0W95y?=
 =?us-ascii?Q?CTj9X7yAz+DswfZoJ+gqK+vbcLiHWudpYBww6cdmwdYnDfXgnxMH4637h1oU?=
 =?us-ascii?Q?11e19NLR+GRU8DhMoOauyGPzb1jYxRxbwUZZTi82AHBDTfESIP+d5tSi78KZ?=
 =?us-ascii?Q?OyiQEwaid3T7cwudXiuzr2Ea9OkpVrt17HP54dC7tLq8uwZNTzR1bGqAKjvg?=
 =?us-ascii?Q?FcBYl6OYdK+wpeQd9HzvjpqNWIBB5ae+sbOiN57Kyrt0qheVmMSETwFeE0NX?=
 =?us-ascii?Q?OkSYXKqv2TrVHZMG8LOmqNdwSP9OJk+5SKXs1JmJwHxM3hSqO5THz+7oSsZl?=
 =?us-ascii?Q?i/bjEm1GK+7W7eLu5D0jMhSRW4ejfyo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6d51d-e021-41dc-c312-08da22ab5321
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 08:54:05.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wETI6hM3EqJH8ycARIl4MCP0WgHgzbKeYIDcDsDIcydPL0JfMMlMAp95gZiBs5a7wmLgDoUBc1m03tsTcwXq0uzh4BtdQZc2vKXKQqNif1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3387
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200055
X-Proofpoint-GUID: tMof3bDAhjrHLJYjxDzUU4jUu2Z35j9V
X-Proofpoint-ORIG-GUID: tMof3bDAhjrHLJYjxDzUU4jUu2Z35j9V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:51:33AM +0300, Dan Carpenter wrote:
> On Wed, Apr 20, 2022 at 09:50:42AM +0200, Paul Kocialkowski wrote:
> > Hi Dan,
> > 
> > On Wed 20 Apr 22, 10:42, Dan Carpenter wrote:
> > > I ran Smatch on this patch.
> > 
> > Thanks for doing this!
> > 
> > > On Fri, Apr 15, 2022 at 05:37:07PM +0200, Paul Kocialkowski wrote:
> > > > +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> > > > +{
> > > > +	unsigned int width, height;
> > > > +	unsigned int stride_luma, stride_chroma = 0;
> > > > +	unsigned int stride_luma_div4, stride_chroma_div4;
> > > > +	const struct sun6i_isp_capture_format *format;
> > > > +	const struct v4l2_format_info *info;
> > > > +	u32 pixelformat;
> > > > +
> > > > +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> > > > +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> > > > +
> > > > +	format = sun6i_isp_capture_format_find(pixelformat);
> > > > +	if (WARN_ON(!format))
> > > > +		return;
> > > > +
> > > > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> > > > +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> > > > +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> > > > +
> > > > +	info = v4l2_format_info(pixelformat);
> > > > +	if (WARN_ON(!info))
> > > > +		return;
> > > > +
> > > > +	stride_luma = width * info->bpp[0];
> > > > +	stride_luma_div4 = DIV_ROUND_UP(stride_luma, 4);
> > > > +
> > > > +	if (info->comp_planes > 1) {
> > > > +		stride_chroma = width * info->bpp[1] / info->hdiv;
> > > > +		stride_chroma_div4 = DIV_ROUND_UP(stride_chroma, 4);
> > > 
> > > stride_chroma_div4 is not intialized on the else path.
> > 
> > One could say it's not an issue to put an uninitialized value in this situation
> > since the hardware won't be taking it into account but I'll initialize the value
> > early in the next iteration.
> > 
> 
> My understanding is that it will trigger a KASAN warning at run time.

Or is it KMEMsan?  One of those.  The one that complains about
uninitialized memory.

regards,
dan carpenter

