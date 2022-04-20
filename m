Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027F5508415
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376957AbiDTIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbiDTIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:55:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66D1CFD5;
        Wed, 20 Apr 2022 01:52:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K7ACFL019753;
        Wed, 20 Apr 2022 08:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YypRJW55ppKOErIRLAWMRLwL+yG3v8mao/xq+bzIp3I=;
 b=eeWiLeH0qIkzpfe5ncKCb+uSi2mF4QfngncXUd/3LHiJ1f/Anb2b5jrxIJR0ECp3PHdb
 cQEIAiqZETOL077czzFrUfFgoe5PVECVyTDKBiVp46dY/wOI4RXcvISi2Hy9Q71teuIm
 gzjYbc0godDB33JSycwftDtNwrnIi8EJHpW05I7BpYT3mFxvTOhZMZx2rxDAIFayzpIS
 Ds1IXwu6tSm6ycKdZ9kJzAz/BVY29FK/heAXYSG6MrUNKuQ4wlhwSdatXo9qj0pAr1s3
 6QBhNDHsjlcbD5/Ndv8MpdCsjrYOehwEXYBdgUiOZEfpZbygH7hl6gyFl8LdGAZOMeuQ gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd18fw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 08:52:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K8mtEL004188;
        Wed, 20 Apr 2022 08:52:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm899yg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 08:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZrpHaroPdj4Ao2T0qWEVSbHNi/YZE0keLxGTAwWAnyovbwVojA8uCeOb5X1SkazzR7KzwR9GcAfvddNvFEzSAvCg4N9gXJVb/RaxjsprjDYLDJ/FSleNZhTR9tgk13o/F1q8tS11s+RSPFpg9qDEbfHZnkMKfUMrhuJhkrK6x+w5Mr+mFS2c2c6I7YXHek8yhObTF15Eb9PFz1K82H8akNkQc62ndKspXO0bxdOT+Zor9r2lZK8fqhmOrVIsyiU8BzUMSGLA7v7/pvwKKQierW4b8T8Nx1z2xkBqwakQULZsl7yORGQzuVL798CrEi4mwmIvtsJJqWWr8ph+Pplsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YypRJW55ppKOErIRLAWMRLwL+yG3v8mao/xq+bzIp3I=;
 b=JeAXPMD5HizVH9wgDbNZOOaZg3jrFDiyGabawHKnnuBovh0FCN8KYh2sD4hWJ9K5yD0Ldy5E7V4GLfQcGJ+BkZkobyd4aCfRE2aibCpc0SavzA9SYz/IXeF/rcLyKOOfq9KxBgKXwdmgYGjuw8jIvg/AX5Y8Z4YqLX0p8Lb/B7d8LoMmxLniY8aNHV6fx4qUTX0WmpjTME3fPmmpJMCmepuxPwHxJM1Ua+dKSeQFYt1khoKh+/rLN5QTUo6gePX21MtElJQ8Q2E0UdJL15fHBX5OSiJnfO7qRtI1J6fMKFves4unVTb6mFyUEYpp2Ew4Dw0QPgKQT6+QWzMRO0EAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YypRJW55ppKOErIRLAWMRLwL+yG3v8mao/xq+bzIp3I=;
 b=b3H47ls03YN/cC4HxETCcIjPp33RIefLQdPW0BTirvIiBiyxeBjRSfMbxUuvhx4X92kxzH9YACGnzQPTstAtbEViufNW6vXmziPYcuMvusyMn0KMVbAusaIuGQiZWc4aeJfjClPaJSwtQ5a87LEikbtIJAPrcW+yUFrt6i1DcfA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5304.namprd10.prod.outlook.com
 (2603:10b6:408:129::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 08:51:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 08:51:59 +0000
Date:   Wed, 20 Apr 2022 11:51:33 +0300
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
Message-ID: <20220420085132.GC2951@kadam>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <20220420074249.GB2951@kadam>
 <Yl+7UrQFyLvfKRdG@aptenodytes>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+7UrQFyLvfKRdG@aptenodytes>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec3273e-afb0-4e42-4116-08da22ab078d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5304:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB53048E3A7DC4D139B76B8A8B8EF59@BN0PR10MB5304.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZItD6vfsP6gfM3RPESNo72ALv8dBXTWa8tBTJFvM0V3Qz7pqcSn+tP+SW9JxRQkG5fFctQI5hWFWqK904A+xyk6HBCrjkkqFR9yEKLsnV/zuDlSPDaQmmsytHdGzGyw9mLhDyJ+AStzCfWPGOZquPo0eX4CMo3n92lNngzBg7PWOJMWafr5EL+vVvH5ICnXljF36Cmk1dyuSCqhZMHPDR/fMWkinxK4z9KKBLbosMxwptMAMAWQzOg1YPeiM2zCHM8g9oSYuQpszf9k6KlJg4WqRKxbIirYm+k08w/ntr/ys/3M01KPEAru1YdafcZ24IDCVR75H6ZaUvR8x6xOp2Q7fMmNY5rTaRuA3ltUMZ6p3tSM7M5ErGYOnyaXS0BZC7DH60T0ptR7Gtcbaag/yoYSTZWqULWQFkuMT6PyRUM1YM+fJ2HuIRF8SwWmwPAF2EJkxHP2RuXbhL+4VaLL1yIhkLp+F+JxiPPExLYeOXVXy6Kia92AxlaoBUNJ7jrHa8stzGWxdzvhQa/ZznSAX+Gw5gGCE3KRUvxrbWr4d+PuVCZu2cVmWyt4XepiSsJM6tQqRxFj5iYvAk/jZtSAtJG1FIebSTtOVxwMzNwOBHxk+3rrMzqfdVN3uQGQnu+q5TrI8xpQEmSX8HRQ6Nsvon5Oj3Uu9jWlOTJkZki2UFZwCgkbi/AIJLrooY18O1z0j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(7416002)(44832011)(5660300002)(33716001)(8936002)(4326008)(38100700002)(38350700002)(8676002)(83380400001)(66556008)(6506007)(6512007)(508600001)(6486002)(66946007)(54906003)(6916009)(316002)(1076003)(186003)(9686003)(52116002)(66476007)(86362001)(33656002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ubfp+RMlr1V4j5Umi4zZkSfOjReqsd/oTeGX0ESFCb5HrS1DxDjfwyF4Uhg1?=
 =?us-ascii?Q?OQ+6NWw04PDcUIZC5I+Sf782j857+Y5+SAAmKHROx1yIt3Q92JPgGw1Z0mtc?=
 =?us-ascii?Q?Sf8dCiZ4ia6BE2qeC+jsVPpVY/3T2CBr6xmtLZFPODMc733lDXNfvj6qxBiQ?=
 =?us-ascii?Q?RxajMtfb65koTZcSr3zZWechk0tClefwi4PuCUu6qrfqGRcQZqu8DfOkNOl4?=
 =?us-ascii?Q?y8lC5Zl1FONFJAUKsqRtMdL1TSc4hjyLXvdKnICeXBQ5/ia7tnqm4ka5QFQe?=
 =?us-ascii?Q?aJ19lzWekak379HdXL5xm4rj8v1sjVN/WsACvVFIlk7c2PlfhkaOI4caWR4n?=
 =?us-ascii?Q?qC5XNTOysTxZ4dUcuX1/nZC9hiLaDQ9pTpaiKfHoRvds2jEdx+UbQ4McBJqh?=
 =?us-ascii?Q?BuqaHWMH+Au0MEE+hZmZ5OS/eKjpZBlYFHlimFWokitl7Mp2PaQ20EWTwd6b?=
 =?us-ascii?Q?zfNy2JzBOlcmBlMDMTfMf/QXKj3nT4lVJKpUFumirDRcSQ8IWG+xjR+7apXI?=
 =?us-ascii?Q?QCXg/as4gz/nfH8eMwPlBBWmfsMyIgLPwpMKP+uCDtY/AqjUM+gphzQ1shS4?=
 =?us-ascii?Q?VTv4UHwt2g5u8yUa3WzWxonfMkmKin6+NzVsUh6j/Z8TRYwFKF8v11W9f7Dv?=
 =?us-ascii?Q?mmbEbzlsPT02iVSgCDWd0LSLF1l2TsO5VSwA7wJzRAc9LZRKJYHpnPqH3uaH?=
 =?us-ascii?Q?mkeqmGHP2uCZ1mBiu4157J5U6Rp8qmpjo7u6tRfzl6b8/c6v5eVcDUkrBZg9?=
 =?us-ascii?Q?Tq4/LGjC22wfXukIpyREOHkkzwt4QQJrnEwbGfVL0vX4ARCgMQhBpGM0OcOm?=
 =?us-ascii?Q?znqj7Cjr5+DewzhbludNZWRw/sWaD0W3TSYYv9GbZZwYbUCrLnX/VYt+c0Oy?=
 =?us-ascii?Q?dnWhdZiWYmrqWwDGyqDmLF8MmY6qlkV9b1xfM9ARIJTtf0vRvWh9Yg01RD1b?=
 =?us-ascii?Q?oCEIe1E/IJ+wH6erId8eBO+9bks+LQnagv1G5lGkwnm69zBoRxFi/mrnRpm7?=
 =?us-ascii?Q?LZ9Otyhpb5bPsfzw0F85RW1gaaLOfIACklFXRGwf5m0h+damYoYxejLux2QL?=
 =?us-ascii?Q?zSyAXpkyl8lv4IpHWHvhhN8ChYlpuOBRP/v2NgUvpwx5vqyr3gSQXKB1QxFY?=
 =?us-ascii?Q?r6P91dAsXHXYUW9574yB/3EwNhFBZmOj4/wbCEmFNaWQlfVugw1/tf0tcafs?=
 =?us-ascii?Q?RYIBb47bNikxYdbGHG/tk7z7kvHEcUElwBHbgPlCIynnbllJsLO5CvT89Dew?=
 =?us-ascii?Q?Ro5GCCWDotSReGNbcRbu2hcOS4q2WGHY+JCG1Y41H9x1nYt+aqjB+63dHPVJ?=
 =?us-ascii?Q?lxu7dwYYRtDRlZymYOtT43GiI3hwAmnRp2EYQImqizm5R5um9cTp866ee4G6?=
 =?us-ascii?Q?+taRhDbq6TczeywcauQd1MZtRbBnBeOWOboZyB8PnJxYkzkygWYEiSWeHxJ7?=
 =?us-ascii?Q?MLJ0rgcHtpDx9G4vVteChrBL4IyVXUD3fPpHhFCWhkXuMUaEZnZNa/wLbG4m?=
 =?us-ascii?Q?oLmEgscpTExEf5Xx5eR04peWVBAnEhOhOIEXGslgf1QRDD1GKHb3mz5l76oE?=
 =?us-ascii?Q?48KUN10RAYJOQAF6KNd7+OpI6bhQCAUDC93BwmTjT8SQtsNtTwm+aPZefMP7?=
 =?us-ascii?Q?+5Xa5w01gNsyqkqO1ODt/5zLQbKDhaomU4npYxOI+s8dhJ+P9lwAmEBR8ef6?=
 =?us-ascii?Q?tc8eaQ7318XYpqg3T6x5qLmbVY7m5GiSPityvPttblGyk6TqN0zhp4UnkFq2?=
 =?us-ascii?Q?U4AHK0a48jXg2os6pfe5qEcjpNLHOKQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec3273e-afb0-4e42-4116-08da22ab078d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 08:51:58.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeVK/ekpZDOqzVW7psLxsuHg/cV43IsT5n0Ev4F3gzfgzYjH9u3liDj4qMAbTr+PK2Apys5nMvxFBngnU8FVcrpE2bMMAX46fdOrjZIjjoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5304
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_02:2022-04-15,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200055
X-Proofpoint-ORIG-GUID: TenOhgY4qaV68-UcNo-EUTj5v9tFsHMa
X-Proofpoint-GUID: TenOhgY4qaV68-UcNo-EUTj5v9tFsHMa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:50:42AM +0200, Paul Kocialkowski wrote:
> Hi Dan,
> 
> On Wed 20 Apr 22, 10:42, Dan Carpenter wrote:
> > I ran Smatch on this patch.
> 
> Thanks for doing this!
> 
> > On Fri, Apr 15, 2022 at 05:37:07PM +0200, Paul Kocialkowski wrote:
> > > +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> > > +{
> > > +	unsigned int width, height;
> > > +	unsigned int stride_luma, stride_chroma = 0;
> > > +	unsigned int stride_luma_div4, stride_chroma_div4;
> > > +	const struct sun6i_isp_capture_format *format;
> > > +	const struct v4l2_format_info *info;
> > > +	u32 pixelformat;
> > > +
> > > +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> > > +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> > > +
> > > +	format = sun6i_isp_capture_format_find(pixelformat);
> > > +	if (WARN_ON(!format))
> > > +		return;
> > > +
> > > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> > > +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> > > +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> > > +
> > > +	info = v4l2_format_info(pixelformat);
> > > +	if (WARN_ON(!info))
> > > +		return;
> > > +
> > > +	stride_luma = width * info->bpp[0];
> > > +	stride_luma_div4 = DIV_ROUND_UP(stride_luma, 4);
> > > +
> > > +	if (info->comp_planes > 1) {
> > > +		stride_chroma = width * info->bpp[1] / info->hdiv;
> > > +		stride_chroma_div4 = DIV_ROUND_UP(stride_chroma, 4);
> > 
> > stride_chroma_div4 is not intialized on the else path.
> 
> One could say it's not an issue to put an uninitialized value in this situation
> since the hardware won't be taking it into account but I'll initialize the value
> early in the next iteration.
> 

My understanding is that it will trigger a KASAN warning at run time.

regards,
dan carpenter

