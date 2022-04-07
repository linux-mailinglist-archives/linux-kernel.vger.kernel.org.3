Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F794F807F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiDGN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiDGN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:28:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75145FFB65;
        Thu,  7 Apr 2022 06:26:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237BVGx6006381;
        Thu, 7 Apr 2022 13:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=48okywLYSYqQExQCWCiE70bjredEKVf2aReHfT10qxc=;
 b=yPyQUi9+JHfDgXg8O6NHdVsCnSqPZaiKe5BvXJ/E4Wh7xhgMBsgrmiPUWG8P2T5PUZCr
 6n/eSHikPNJYmJCVw0G9+Pwgxtg/L9tfeEvCU4yVIVmRmZ3KmUExCkXP/sQDaIICPwmv
 mhdVxUAgCpAdDE7nIVqIuBUkMNNxQRKMHm4Y/JGqNhsOALdhYIiMFtUsO9k2jsW7xzeG
 oZiMdn6fwdSe5IjtvfOgnvGqUTxF8CL3cwIjZKy/QlvyT18r5MaRDxrpZkHDL/thRmcn
 n+GlkacqF19tf9TFxz2npMQ6sO962e4GMaisYymRU3xiY5MFiFx841wvFhVgCeQXnYDM 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31m004-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:26:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237DKYuU013769;
        Thu, 7 Apr 2022 13:26:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97ttau39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4ku/MeKl7vlG7WRQ/7oKU2Low2WzKSvQPYeLZ0hIxAmSAm9/o29pkttgVLal1dGHYiH/JYA6gYoUPcw0Ma1kNFnV5tJnCroo37ykMb3ENI5wYC9CAK201+7LOKxgR/w8W2U29TnTdgJmtAbv+nbnesWSwjirHMG5JYick+A+EXXE1Q6UPt6eZVKRDaiMCl8eEsjQ9KkTzZ3VGF56NSAKay2hHU+I9WjLtX8PJw1BXv7aZYMxnps3RToc7awODZ6CU5WrSF8fwO7dsEqewZAKAaZutOCkbUQxcvVmLDmoS77IMZn8lYfZjiWsZtFdggi0YuIlVt3dj62IJJlbNV4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48okywLYSYqQExQCWCiE70bjredEKVf2aReHfT10qxc=;
 b=ADbWUOZev5vTFnQlhCfSKSGkrNg5Q1PTf97ncy4mU9PAJ/Q1PwjqAdJQItoeRh6GZklhXXHDEoBW/iiOBZq5LzqDGK6GfbF7gzP2NlF0heMhzf1u6SOYhFWNSZUB5bg7dJnvEBMw4X/crdrlrBbBfyqSyiQQ2iLOseA6ssvwLBuVv2a7C+b/CZCNcTFGl0VDUUnFkDpnAUEx6QOnrPMVuN3zZp3qtGy19vhE/MGDtoCoeAJyHMARzwVL4A9IUtzZQfQYbCYE2lPvQyq6MACTYfYBbgQDV6H9Qx4U4FxXuv/etWCF4IXq58pMugJCPX/u/F3MXpfENlGISPEJSKwhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48okywLYSYqQExQCWCiE70bjredEKVf2aReHfT10qxc=;
 b=c9DclxKYJ17/G6av7TOT1OBEffDFYhL5PlCWF8nW0BoHSUmUOjcyX0YqacHn09zINpviONIlZv7NqThsFL6KfcNSH34a7vu8NMOosvR8nnq9ACoVGtVWuyWtq/5gpImL4q8BSY4Uf5XROB//zTS8XrL0d+MU17LncJZlJVOJmSY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA1PR10MB5709.namprd10.prod.outlook.com
 (2603:10b6:806:23e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 13:26:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 13:26:35 +0000
Date:   Thu, 7 Apr 2022 16:26:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans De Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] staging: media: ipu3: Fix AWB x_start position when
 rightmost stripe is used
Message-ID: <20220407132609.GN3293@kadam>
References: <20220407105724.308930-1-hpa@redhat.com>
 <20220407115133.GL3293@kadam>
 <CAEth8oG_GAuammtSqKzyj+Vq6ZsQJJOEeFhgxYhxXHViDYvkow@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEth8oG_GAuammtSqKzyj+Vq6ZsQJJOEeFhgxYhxXHViDYvkow@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce3afd9-4f7e-4370-93e0-08da189a3c9f
X-MS-TrafficTypeDiagnostic: SA1PR10MB5709:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB57098DF43C8484F5CE7AFB078EE69@SA1PR10MB5709.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9a5NCJzxtD9lm3WN2ZUsxp1VwBUpUbco/E0p/S0wQf1PFBRj+uvldlC+o9i7Ps8wvBaSgi7g3Lziophf8tcfYYH2Il1v9QePvnUOrxoKYecYyKj+ObMNg4hgQEkuKhUlj8Zx9gjzKTye1i9+z2WRGnywZYzMVIrEDQaIB1mKLmZzV2GV08449g9YyTQl7pcnfku7Wiv2LCQkOKqjvz6jmdvIp9klM4YQwS5TE41iaNAHVaAgfUiDNGBruTG/ath++IsZCCb6wLMwwRTIt3rJup/19m2kt8FPnqjTdXTEmj2ucBLTwG5KEACc907w4i/U2OeCeRQL0T4vNrf62T04VaVxaq86snXKehzGxZV/indtkyBnD5rXy+hX8CSJM8e+8wBeYYphY1cximOkY0V9J0fuuLI26K8NH8nhUwcs/iCdRhtfKkIm4GDREX6mLKQSUBjkAuT5pQoHx9GlQ/4Dr0LwQ5Zzh0IYyMsItUuLn8gxt8RFfhPQqKklk9F9UOuvkj3CC7DjCsTKvz/xkF+byK4x2GZvwZ2b8b0YxKzK+yUfxuOhwUeVuh64s+MXOpbTlSgpkBUpzHcuzgrsNUbBp6FTgF6JKv9qPnsLa0GgbSVsiXDMAh+vHOCsbVoR9E+SNwcVuPoKkWlDsxGGGBan6yNz8N23CDm1TihWXcueFJUohYrDXW0p9MX7RKZI7uuaw2H+VksXUN+XFpMIlfo/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(6666004)(6486002)(52116002)(9686003)(2906002)(53546011)(4744005)(8936002)(6506007)(44832011)(508600001)(33716001)(5660300002)(66946007)(6916009)(38100700002)(1076003)(38350700002)(316002)(7416002)(66556008)(54906003)(66476007)(8676002)(4326008)(186003)(26005)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ibFzmUCv4mKsvdzNJyfCCk9FNJa7ZJ2nTkM/g67IAodpO+TweixKkU55B82X?=
 =?us-ascii?Q?HVjdF1AV4kDPaNqfaR2ngg6FuGpFhmWckFmHMRZ+vTjLp/FATRPa6XFubxCG?=
 =?us-ascii?Q?F5wDRDz1XEMrmVsHW3N6oct733YSqEvF1NGg/jJ38L4EUtvLuQ9vkbciX6D9?=
 =?us-ascii?Q?cC6rh570+tXvS0vsP2ng+YZ0rtPqpvX189vQwwKQe9gsQQ5ZfjpTrY9j05C3?=
 =?us-ascii?Q?P/lrG55hjuLyo9NDvIMhrixy8BloOW3MAtHQ1I2zc5ayZvylZopfeaflLtah?=
 =?us-ascii?Q?iZWbSMoJOymscGCs7J8SthVXJuy5NhopZd7noYx9+FE1JhsAOp2DvRLu8pHR?=
 =?us-ascii?Q?Lf3eL2VtuWucaVchSpeLP1Tek0lH0rNuh5gBXyrqSTN1GlU2eYlI5Bm9gX24?=
 =?us-ascii?Q?Mqf1EoNPYuZwU9B0dlZPnL/1OdN91yb6jcT7QQkNvvbQgqYi4tuVPxuzAKM7?=
 =?us-ascii?Q?pNwiDbeE6Q6CliJhzK66EAXN0Jgw75w/T23cL4hrOmCW6M4jWt+h+tUpldPQ?=
 =?us-ascii?Q?wnN7jNIB3XDt6Ie4/nnDp+FFzw63DjNEGqqbVHrs+EJaDbEekW5yTze/FPnh?=
 =?us-ascii?Q?UzrnfmIZgd2UC+22ocxFO9pWWTkFwAzHU/7lyc7psEdus/SdLGYkB5shbUu9?=
 =?us-ascii?Q?ylMYtNiPilZe03n18GnFhQh7iLQpf1siS9/fJNABzhYKxOfEljAe28iTKU6g?=
 =?us-ascii?Q?2xRgapGR2cjp9R+40FDDrU0edz2O1Lbj7FS7mOSwxKPpefjexinKte0RTjQw?=
 =?us-ascii?Q?X6L3m+LaUlVq8iwBgTt+ObaPJ0nhK0cwH+8sMuA96Pe13cZ7yT/wu8bp3m+H?=
 =?us-ascii?Q?2mjlExAgWOUuPzKHwk555iSWtlQS+1ZC2d7Z+bjau2YG0grBlmydGV2GKGbB?=
 =?us-ascii?Q?vMpXp9BNnLGPqiyyGIo9QXGPJeiUb3cToRrugIUtRvvDv7Z3A0uHWirTJvzy?=
 =?us-ascii?Q?Q1X464a7mFStAVwXYTi0pB1ewIjsyUScI6swpy6FbslITsUc1c0GqNstKaFb?=
 =?us-ascii?Q?7t5xchISeuJCE8OxZy2/Qf5fmPfDp1s0r7l7px0pMVb1YOj3BGxQRmJulIS2?=
 =?us-ascii?Q?XuC/n+av0EEzHEuPsWkU1vpy/zNnB4Lc6BSKVx4tP4WXCuZSavTB2ViJop8/?=
 =?us-ascii?Q?xWbx0tX8Mgg5ARRTeiDaGEFESidlxuGqMTJrcJqJ45gy3WC/WRurq6BmsZUu?=
 =?us-ascii?Q?n1lrnceLTQG5wP0qm7iNVCPfw+Sw2WiQXYhLq3fOKYXicURU98zM67sJnONI?=
 =?us-ascii?Q?neWRqpL0+YBum2mo8akH/abiXs6QmPUrPoUTxrD49fim9wpdSUfWU8d2cur0?=
 =?us-ascii?Q?P8qgzK9qT+caTSy96OsjIf27ZS8qoCXeo5bcFTNM+sa7ucG6Dkke9VKau7DM?=
 =?us-ascii?Q?53xDNPI+e5to9vHx3crJPEN4IiGf1ygixTjw1RxDDAwDFN4OivtY359AopeU?=
 =?us-ascii?Q?aGtEgzYJSlEEO4tcuvwtWTvZ4hE4/7DqfZllC5HPKXVuIccM75kp0qJY1jX/?=
 =?us-ascii?Q?m/PWN5K3xXPZXQ0T7Ly6HbV81A43MGJ/F50Aq8jeAsvvjuDBdoiSFgSYMJU6?=
 =?us-ascii?Q?Maiczga/ryGnatzAEpt8waCMTUx0WpEN7Iu46AyFSAfcMEuyEVpad4LcJiZR?=
 =?us-ascii?Q?ISHVtZsaAPki9+aGWoW1HAr4P6eRTtUEFLvl32eZOyvJ12gbio9irZqdqkbc?=
 =?us-ascii?Q?8qlL06y7QS4VEJrma7LJ6JNN8Huwd3uFKh88CFgKB5rmG+K2hP+mKriAtdwy?=
 =?us-ascii?Q?PejmIKQcXyEsGxpO0qBZHJXBIopB96s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce3afd9-4f7e-4370-93e0-08da189a3c9f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 13:26:35.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTGO+PTg0DatZg68uV9qOmOAVN6nVl7xJp00NzuqpY1jAfwdHQ+c4X/m3B7BW2F8pbluRTao/TOsc0dSVYhKN2k4lfsMJvfZUK8EUvcrSqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5709
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-GUID: sBtpC4SsPmNbRwWcf0qRszhTBjpahx8o
X-Proofpoint-ORIG-GUID: sBtpC4SsPmNbRwWcf0qRszhTBjpahx8o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 09:17:38PM +0800, Kate Hsuan wrote:
> Hi Dan,
> 
> On Thu, Apr 7, 2022 at 7:52 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, Apr 07, 2022 at 06:57:24PM +0800, Kate Hsuan wrote:
> > > A not calibrated x_start setting would result in an incorrect AWB location
> > > configuration on a sensor when only the rightmost stripe is used. x_start
> > > should be calibrated by subtracting the stripe offset to set the coordinate
> > > to the correct position on the second stripe.
> > >
> 
> >
> > I wish the commit description said more about what the bug looks like to
> > the user.  This is the front facing camera, right?  Is part of the video
> > blank or what's the deal?
> 
> This is IPU3 image processor. I tried to fix the configuration issues
> on stripe 1 coordinate settings.
> 

So in terms of users, if you configure it in a certain way then it
crashes?  What happens in terms of what the ordinary user sees?

regards,
dan carpenter

