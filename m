Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798C155C1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiF0HiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiF0HiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:38:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F5260D0;
        Mon, 27 Jun 2022 00:38:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R48dOW029151;
        Mon, 27 Jun 2022 07:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=peOt8on59j1MWV+geDEW1NQ22d4p7gU/U/mf3OgnF0o=;
 b=azIoTGm9E2QUk3EZsXDxEpHh1fLIEePjVL1KaSz7778Hp6ZKoYqxrRgnxA9gsw+ohFEy
 WgvJEGDrdWZhcaTOxldlwYtiHy4+D9NTinztR3vfoz7fYOMfYvwUF/zNUYlkp1y/jmc0
 rbdkcAsm+nSZQYy2/lrXJS8DlJxYCmL7aJT1IJZkywEbwJ4SY3fOCDsPF+ldC22W5+PN
 UkpEzrmsM7ALmvL9bp9KxGmPWMmg26+e59hO/sX40exA0KXNAxtIzrBQdrgaBkH2fnKw
 8D/3dek6+J6GqAKKk30vD0gClZs+B6yPLqrG3iMHUhkWv1HAYcCGB0hQ8TPmtrrkUlwc 8g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt89tcvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 07:37:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25R7VDu8016509;
        Mon, 27 Jun 2022 07:37:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt72u0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 07:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo1ay8/hqQyka3JG+XLe6IwrvrgSvkd+0IMB3xNb8yMv6PggI0RwwIxagxX54N1qBOC2mv5ed/VwJeDJTbOyYe/BCvs1gZokluf9Cd8NONDm8llaf2FaQmrz0bp8EAsxT6V0Fo3q+4HOEOy6mMSHdpm94LkwiM5lFa1AskZeQkBlQBDyH4HNxUsmoTr8wkDACrTfpgrHn1lKKGA7Fs9vxihrL0c+NMs4seXZ4HHCvuFk59/eLaX4aqNBFUmuWqLCC/7aNYigFjVk9Ba9u1D6+qhAt8/MrsRhCTp8KJRehN+DzDy28v29ScekHAV4jW/ZsfkgthiOK9lM5oa4vFYfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peOt8on59j1MWV+geDEW1NQ22d4p7gU/U/mf3OgnF0o=;
 b=bDbKbr+Tnx8XYrGvxR9qat0offixc/iYWDn3f6nXdSX2jUHf5cpGd6T6+knoWAPL8f/Ww02Q0ZeeXTS7jdXsXNNlSkFW8XyZvbQfndfA1S3fOoGXRbj2vAzzcd2H6riC5ryyn7tdELsjc6LWntjEYqlJwnxL6q+uZfeu6eZBlmb9NXh6N9EpHb1JlzlPK/ImHWLtpy+hWfzZzGoBPKz9kpja2BoiqnenoudcrG03/BGRL3qmVbZB22mpMEMQZeKPsm1MFqwlMl90/sYppPekWnOq6+cGJihzj0uMA6xLowEsLDDQeZgyIyzlO/+OO0ZCQErlr6bNLWm+hcEdrOAsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peOt8on59j1MWV+geDEW1NQ22d4p7gU/U/mf3OgnF0o=;
 b=LzKYH9062qpS/BN22axaBQBTPsl9DRmiH1+d1aFufY2WssBpeuCux2hPjFDbII7hvtu7fC+DnY6jBPbO90wF9da4EQwhNgvi7hTkY0cpq+sFs+HX4m0R/6Vq1QxAHfHZj4TvFnISSWEDTkeuoVSG7sh9UJpzJOmOWZQDsCxIIbM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1986.namprd10.prod.outlook.com
 (2603:10b6:404:100::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 07:37:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Mon, 27 Jun 2022
 07:37:50 +0000
Date:   Mon, 27 Jun 2022 10:37:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380 sensor
 family
Message-ID: <202206260803.ctZKSyI9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0426e760-816b-4569-99fd-08da580fef7d
X-MS-TrafficTypeDiagnostic: BN6PR10MB1986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTho77vESBMGdRhK6n0pTWWuNwxG233KllmjXV/EUq2tTCPHneMZc0iI81dlaJPJpVFAEbY1CgjV2d2MmqD9smGrVJZrKER8benRsLmlSzga92AAhD59IrSNzBoaCUt/pgAK90skDCInYmXvlJoUZ+wtQA6zlH6ZSwnrPRZ47c3G/L6IaEBalcwsP1o3cb3eSsGL/sndnWalGSLqVctm5RqTMwpFHDu7fiQ2GqtVHhofkxSmWV2xIpvTy7iJ1CIea5q8v0wzlc+tbpNjELydZRZjNCrKaMPxsj5t8s1TfgRA9BVN7s0lMktRo2iBvw4uK9bftHMwpesQiisXt1sxg6nIrT7/5mGKd98sKpHBoki5fRtv3mc7elDEFzl4nKsZ1jIo+1HlXJnof9ojL4cOA3r7pI528k1hdwFfAbTGZqemIr+y6q3vxlk2LT4hUy74vSbYogK81pF3PME9I2a6KQhPIzJqErpHZJa7RJewfFJBZL4l8TaME8heYe9jGNM+zoso+bMWyaKrVfYQv9Yy+y/ueJDGWyz0vFIB0nbL+qPat6DNZJMW9g6HD4Ys6xlSDiMvqdS7gvMzHwOTTK8FebqpFsp5f7KyeEF/iVWNHmw6FAMDFPU4cT3MjjtgbvLPtKBgEqIFGmnYjFLeBFyS27duACZ2OIm/JjxqWC/7l7kqLzgkCoqim/87ccBqe3KV8yYVtA9AhJ9g1QZzOJ1Sotfy8FF+g3A4yHAelR8kqeqRMMzHKQP2dWg9EnED12054B6rS6dMzlLmZrN+B9O0eF72JS/M0EQnvCQJsFkkMapxgOQQ0ChiANtURA+N2GV0vu0x4P66a0UFsMdmemSAqjbG+QEt8pm1tAWcNn+2RMI9fuf8YRr0UXOpkxZ2dnpZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(39860400002)(376002)(396003)(478600001)(8676002)(4326008)(66946007)(2906002)(26005)(5660300002)(66476007)(8936002)(41300700001)(66556008)(9686003)(7416002)(6512007)(86362001)(44832011)(6916009)(52116002)(6506007)(6666004)(6486002)(966005)(54906003)(38350700002)(38100700002)(316002)(186003)(1076003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pKXpgnyiSmxv4CspLeFikAUU2y1LAeKwb4Esk6Z8vZffKu8Tic5Mq7LPaWbO?=
 =?us-ascii?Q?7Sb7h1Bw7OcCTa8WCdUAF/yZ5OYgA+UbK/LTeNCZuMIQWvBsfzQc4teV9W9u?=
 =?us-ascii?Q?BIXIStFRFSf0vdV1hbwV5yf31Goiio/HAR01IZHf/hrxeWDkftZ4z2LOD1ZA?=
 =?us-ascii?Q?wUOJuk3bpV0KwZrC+FLxQQixCm3HU/1z9vNVUGbEbSBsoFD2SxZ4DJJGe+Zo?=
 =?us-ascii?Q?AcNrV7s7dDKpWxcMDI1PFlFyqV98loacHfqH18CclOx+4YUaTIMCJxJmyYja?=
 =?us-ascii?Q?rfNCIt6bnHo/HIcNnUWSJ0rW5h7UlAV9xbwoNFsbkt3g2W/zpRaFiZen8qds?=
 =?us-ascii?Q?62IeDaJtLEVUcN+wPAU1v+FWhd7J3VhQlxMAuBmrHoKF6LkBIBgW75wIrEAW?=
 =?us-ascii?Q?oy4SHD9bpFmWOmpkF4RP9cXEGZSGFZ+T+Ro4dw3d/gN9wOLFu1LWSGuX6HT6?=
 =?us-ascii?Q?Hd+xO9jXQC/3RPISwW6gGjOa5aXbQ37Cm3PTKIHPlG52b/nnOppyyZt5IBiv?=
 =?us-ascii?Q?MKlgzikmn7nRxv209Bs0VlNxvGihhXRbuqOpNNTfI4KUCj++IINpzq36MVNZ?=
 =?us-ascii?Q?aZ6V4Ga7vi6NmPrnmq4MzanPQonLmdRcUBKPit26hLOzRh+rLt30opsonmhM?=
 =?us-ascii?Q?V3vj93VqElRI3LMoa3nlcSSbn3XyATPGuv6T7v5jjFufD/O8ad4r6dA94wZE?=
 =?us-ascii?Q?8Z2fcuz+cniL9zMmNTPex0YMA91qkuyJP07JF6BzeW3Garufw20CHDP1WIyB?=
 =?us-ascii?Q?IHWWma+tU0hf5YmohE/J4rVZnB3kFK7PaxQfyuqRCY8z9rKd7PVP4Z05ikj6?=
 =?us-ascii?Q?d6rhY+VAMgh3VPi4NyROJUShWE04rA+C42cM2UITzlOpMyNGg0YC5kFRDsHi?=
 =?us-ascii?Q?zYjW+qJUAyjUj0OovE8yGAZPVoOc5Eu21oaC6PUbYS91oE4Th+6ZI3iIXWz3?=
 =?us-ascii?Q?7nz898GOISwqn4oXNPV9nkFBH6Ad3gRfVR9lpbk2Qv9nHfcrE/KcSQnGhQnJ?=
 =?us-ascii?Q?Gd74Mi1TgKy90/l8od9ihvD1toHPcLPP8jYHrar/+F4i5DpAE+8E89QBqsoC?=
 =?us-ascii?Q?bFGNRR6J+KvRXHjkeplVX+A/OWKWhHMMwyHRLwN+c0KFqKnpEaVg9MWffCd2?=
 =?us-ascii?Q?+K+o/BlXkKdy3ojJ79sUKaafcJMUEYQcV8qya+u25wvyxih3pjPRrPWeGnPx?=
 =?us-ascii?Q?Hg9MNVWBh/EbK8d6+amQsq9Q+NlqHR5xOaAxzdnKS7XBDJiO2PwyDxO34TKs?=
 =?us-ascii?Q?M0qxWGYnKec7UNLN6rCIhszEo1oUrNp7us7C3BKEr+ARLKyVgkRqXoZ2y7kA?=
 =?us-ascii?Q?7DqFgF31tRGWYfsL3DlTQwnTIdGUPSr8XgHhQSj+T3AINR+kHA4z7/zHhjwK?=
 =?us-ascii?Q?Ct0Q4fpirzZF0oZTTpYkb2yOIcpyraum/sSZCaPE9ZOte+NVLIRa0KQ7FoQ4?=
 =?us-ascii?Q?lmkiYspFuzfv6SOs1VWd4OXLZ5Az01SaH60B9/W/PzVXfhv9hue/N3REZJRB?=
 =?us-ascii?Q?zczF2/XEjJF26ZIYXaAil55Jw7+z8tVVftN2e/w0WPNi+3v1oWiizEgnK1Jo?=
 =?us-ascii?Q?dzXh+FBWxGEval29Wl/7FnW9+bolQrWEyj/bA9phljPZ6a3/20EiFBmMnkNU?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0426e760-816b-4569-99fd-08da580fef7d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 07:37:50.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHx+NRQL27QSd/rMtGddYCKt8uLSwcnIkHG9dQq1JfckLzzjVdBJ9ZQs/clw0bqGmiKnprKUY6zwwDQEmZC2JaFaPoTLryqsNVLo3zhDzKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270032
X-Proofpoint-ORIG-GUID: XJTqRjO55cut2-04x2flT4NMlzfObU_l
X-Proofpoint-GUID: XJTqRjO55cut2-04x2flT4NMlzfObU_l
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-m021
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/pressure/bmp280-core.c:1000 bmp380_chip_config() warn: should this be a bitwise op?

vim +1000 drivers/iio/pressure/bmp280-core.c

56e3f8aecddacd Angel Iglesias 2022-06-25   988  	if (ret < 0) {
56e3f8aecddacd Angel Iglesias 2022-06-25   989  		dev_err(data->dev, "failed to write config register\n");
56e3f8aecddacd Angel Iglesias 2022-06-25   990  		return ret;
56e3f8aecddacd Angel Iglesias 2022-06-25   991  	}
56e3f8aecddacd Angel Iglesias 2022-06-25   992  
56e3f8aecddacd Angel Iglesias 2022-06-25   993  	/* check config error flag */
56e3f8aecddacd Angel Iglesias 2022-06-25   994  	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
56e3f8aecddacd Angel Iglesias 2022-06-25   995  	if (ret < 0) {
56e3f8aecddacd Angel Iglesias 2022-06-25   996  		dev_err(data->dev,
56e3f8aecddacd Angel Iglesias 2022-06-25   997  			"failed to read error register\n");
56e3f8aecddacd Angel Iglesias 2022-06-25   998  		return ret;
56e3f8aecddacd Angel Iglesias 2022-06-25   999  	}
56e3f8aecddacd Angel Iglesias 2022-06-25 @1000  	if (tmp && BMP380_ERR_CONF_MASK) {
                                                                ^^^^^^^^^^^^^^^^^^^^^^^
Looks like & BMP380_ERR_CONF_MASK was intended.

56e3f8aecddacd Angel Iglesias 2022-06-25  1001  		dev_warn(data->dev,
56e3f8aecddacd Angel Iglesias 2022-06-25  1002  			 "sensor flagged configuration as incompatible\n");
56e3f8aecddacd Angel Iglesias 2022-06-25  1003  		ret = -EINVAL;
56e3f8aecddacd Angel Iglesias 2022-06-25  1004  	}
56e3f8aecddacd Angel Iglesias 2022-06-25  1005  
56e3f8aecddacd Angel Iglesias 2022-06-25  1006  	return ret;
56e3f8aecddacd Angel Iglesias 2022-06-25  1007  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

