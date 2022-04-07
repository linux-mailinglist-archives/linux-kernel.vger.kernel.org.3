Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A624F7E71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbiDGLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiDGLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:54:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB053E19;
        Thu,  7 Apr 2022 04:52:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2379T1HE014716;
        Thu, 7 Apr 2022 11:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=b1+rjlo05IoK6I8VsV2Nslqjbnxur0EvyClEMMh5qzQ=;
 b=yhijurQULvBxruZWkuWEJi5Zg8FS2X0UaHz1lRHBTzW/el5gRAvgM/mOliuUYEiciq+l
 QKjUDfllnYrplZUjNpjmX3OvNlC6cE6lumA4rRLr09oB0HBAUXZoi3yNWMGxIckAhN7a
 +MNba9zfbPU7Z9hGbtcEfBWIjRThzq+u50akcnATamC0bdEQnwRqz7DGd8wEF+OpVbhu
 CDJHgi6FBJD358jE6MnVpdqmyRaI9x28SEcxhNwjcEx7yBFGXphPlKFXu/Es58pREQ+H
 +XxgsRJnPuvrEtGnJMqo+OTApH3dMh1h/l0fkXYv33AcK5nOdxg0rOcp6Xq4ZaFSqBM7 TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9ueq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 11:51:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237Boiob032913;
        Thu, 7 Apr 2022 11:51:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y7esy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 11:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZaK6ptEUwBSJsWzrGmx9ApSTtQIGedaMNf7/h3ljh0Igcv1DeVCM02G2fmIAhlN1cFYYEhQ1H9bvtMpEzWmNko8PD3l5G5xe+S/UoZRgh11nu9l5v5xlt+mr4IouHIsm46N6dySz6DnIbEGTXejAl9MJYe0DyNJ77ktiubSDFBKlBYL+7wYsqHes1GM1YxajYhC+zxnbQ36JU0zxqwbHZQiZyEtmHm9ci29R2c6X5jU3h0FV2ix/2s0I30d2clx9ayKj0H9wXgflcXk4/BPCogGvQS7y737ytrlzllGzLRVgaoOg+Io4o2nL1Js7AIvkVJU0vhUg0RCrdVUv3WKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1+rjlo05IoK6I8VsV2Nslqjbnxur0EvyClEMMh5qzQ=;
 b=XngWK6aJUpM6rIHh5v6beEBuqium8eUbi4tUOnNtD62f4SW97d+1yF5n5MmEk0kA+MM9ls6F3KX6vp1GV/1inxxHCMV1rBL8nFwIfeC3vHWKgzE9zjcpH9yQURyvAsNciQ+gnhfplN5gpEtzpwhU33Cijqh7V1oktAUt5OwSKObkM7SH4FtAqgaLTGF8WlKUwafRqLDxJhf03zSs9jqTWgIS4RjJUCoeUYcEhhoA0Nj/sPPTazshsu781M4mYXg2hxNXk08LHH6O6AU5rotOYZ0JxD2aO1/g0xKVwqRdXIcTCO/Rf/hXQqnNp4ncfwyXzrQ34kTArNZxIHdjbC8F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1+rjlo05IoK6I8VsV2Nslqjbnxur0EvyClEMMh5qzQ=;
 b=uT3ABvnVEBNidIzd2UwFFsliMYhatgoJ6nrjZJvtLsdS4TXNd9mvvfDBR7Bxu15sRZVJ9yPHVJBjmoqAltM4WDiHIiZDQ8cFZLFtZy9oOTXcqUZdwGxP6Ue2L6+BMW+bY0VFS2o1s2S9UuVxK0JYrSx8OmqqpZjwQQihUfyZZf4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4622.namprd10.prod.outlook.com
 (2603:10b6:a03:2d6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 11:51:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 11:51:45 +0000
Date:   Thu, 7 Apr 2022 14:51:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v2] staging: media: ipu3: Fix AWB x_start position when
 rightmost stripe is used
Message-ID: <20220407115133.GL3293@kadam>
References: <20220407105724.308930-1-hpa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407105724.308930-1-hpa@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0190.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5279e45d-4a29-4a79-06db-08da188cfd18
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4622:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB462264739D119C840E126D958EE69@SJ0PR10MB4622.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38XIbGc5JtzV+QiFRT/1Nn8Bq2SXFeH1A6b3zaaj8MWNBry0S+4qBncRVVxrfVESkW7rY4E4Xjgl1TUazUy38OqH7JwSSFdIQ7bwyqtVwdu4Wc97XVZIbhfLTDfi8CzdT5Hl2vHDADbuGir3Yo7LWeRrvE4QZJXZEknYDXL2AfZBAt3B04qLxeWh7zQh0TL7Vwxtw0HTrKoXnY/Bznp9HmG6C5TMSxQr/RqQx7GbOBDn6FexEu/qIqkAEZKKzsVlPh59+yYpqvhUPCkcGHjphFvst3FnsEpo4wg6PWxlylVM+zpw9894joknydKwvq4HwvFrxGroL7Mi4T7+OD6JoEVmR58PNYrWp2FlWmJRLIZqVjryYNfXIbeOWbocvAmiIzM46ap2uR8AsXvWgf3kOoBsKfvNsT5fVYSWN0DyprhBctI5LeisFLHN5pSQ80TevB9/ahEsYl0bWRchTzecyUjmOVVNIy2AuGKmdDeILDt6LzjiIRO+AGK55ZJW5ZvKO+L7toGcj6uh/BGh5KWGxOUBRtQ0rpkQbmPOhcIG7CsjRklHeIZeHNp1TUdeD4irdwTFe+D6xaaPANShg6NWSjuBTeIfAk/lXEArh8/aG/zxIw8zIrjYl8d+Clc0K2b0d6xUabepLR9Vn9CrbiqOXpVwur4KDHuvCwITMv8tS/DZjucXRzWz26VdZFDJQgquoGoHYGxyNXQb+LE06kQbkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(66946007)(8676002)(5660300002)(66476007)(2906002)(52116002)(7416002)(9686003)(66556008)(6512007)(6666004)(33656002)(8936002)(86362001)(6506007)(4744005)(186003)(26005)(44832011)(508600001)(1076003)(6486002)(33716001)(54906003)(316002)(6916009)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vHd+mS5IpGD0Oj0KCIgycER6JFigloVGq4JwP11QaaVBC9VAdDGfzOEG4jt?=
 =?us-ascii?Q?UKlF/6/Hc2FzRHWK51O/tbjugtNA3z5XQpLDOYxk/meQuLQhPCB1/XSphcXa?=
 =?us-ascii?Q?rt6lN58lMXz7acHp8ciJB/HzI1LIhYOVnUMQWlM8b19OV2jd1YkesWtKyRAi?=
 =?us-ascii?Q?c3P/LcV3tRysxcNb8nFFnB0axYmkaAwagWcK9bcDOoVyScw/GCWDitjp6tA2?=
 =?us-ascii?Q?RUnDBWH7b00Y3JT4h/Wkd1oD1TZhmQL2PBHhaC2LACnjB0DBh48YFt8rI1rg?=
 =?us-ascii?Q?h8DJZEYl5QidRnuSDaz7GuW8gZraMSEnT203Sn3tNYULeZTdcQxc9Y5cpA07?=
 =?us-ascii?Q?BnfIIHLUbUEYfUlVjo1aW7Iooqxfl5cYR7gTLcwzQGpZ2Y0rNGZkFsiBYejS?=
 =?us-ascii?Q?PXD+f2qYgCJ4GrbNa254+94X5N+kqyzc0yoQ6w2sH/xEqh8QDO2wgImjic5B?=
 =?us-ascii?Q?cdvSoTmXlDyPjfdZ7YP4z60AqaGlOnhxWWydLc35nIudUtM/+ECZDaa8OcuY?=
 =?us-ascii?Q?uwwqlkTfp0gEBF2YntT9ID6iI86kJiC20guOdXJb8VSBpVyS93bvG3vG2xLJ?=
 =?us-ascii?Q?oWsPc6DOecu3zeIIrOLUau0ZvM5NzclGQi1R/vx+pspMGR5J2jHNNAAhrdRL?=
 =?us-ascii?Q?xEZfO1SQZ+Oyy5neVIw2EO3q3qZB/zqamzRvCqh1/WiAaC4fQrT8Dop1VePS?=
 =?us-ascii?Q?EOqB7SaKAR+UE5IP7AGE/qrrvQqqFJ3lEou1PZYw4lmNhl3uFunC+JnK/wxB?=
 =?us-ascii?Q?NmthlyZ7i/G3PCHctrBTX479zGZmSecWgT2v3uFc1p91CRgq8ynvjOw9BQ6j?=
 =?us-ascii?Q?MU6UAjT8qxc5bHCx4SrxDVpm0LGydMp80baj09X1BhoHndT/bpm5aHLyo2NQ?=
 =?us-ascii?Q?YdGLxAEFnb6pnDqucKEYxTGFL5IBYZKy1y/OnQmhWcwbnNFQPhLfzhIj2nZu?=
 =?us-ascii?Q?xdBoMHEt6QFAmluBtg7RfTiHiBQc//86b4Fwd8R3KwfaJsorkWMbQzrGseip?=
 =?us-ascii?Q?cgIMgpXEHVqCWLOKMgYR70x+h5uc06dAAmv3E0TusOfHlmvOLNzbk9eCdwyD?=
 =?us-ascii?Q?VtIpkmyWqTHJZ8tv9jCXspPtHWCTfSRg3ua1gt+PSkgpcLY52lvxIlBT0Zke?=
 =?us-ascii?Q?JQ4shqxNPisfwkXhHBdVut7ppgRly0ako61OZFhrQOE/gpkrxYW/W/60Zslt?=
 =?us-ascii?Q?OLp9I6ixiCL2yZRCO4UtVYArtipQq1YTEHF3AaMG0jbE6+gnplbTacg7VB7e?=
 =?us-ascii?Q?XDvvRr3UQ5/3ODR1BNgUfQF+6RMb5km0TXZS5gYihzb0UR1/ijnhLk/1S1bf?=
 =?us-ascii?Q?R1PkUwSsdQU7HATSeMmiBiZP4j7WkyLj5YkHa1ByGdkMHaTTzU/v4pK8A/nN?=
 =?us-ascii?Q?hjQvNO1uhhw220PE0ACcfJ4g/s26dHcYQcQSZc7Dr9x1f+VDENFz/EZdyZbS?=
 =?us-ascii?Q?Ea6stQ0C3T6uoAEeVhXm15Y4t4HG1NgV+rqV6C3x4Aso0e77znt378uYSNzW?=
 =?us-ascii?Q?T2mKCtRJgA4PjVN1vDzGBEzdxdpqd5XWqIMH/kRRp08a6bTS2bqtcfBlnZdq?=
 =?us-ascii?Q?J6KcZxQoAhUbbAiNmNn63qsjO8oNATgS1O4g1HKcL8zuLqbxKKf3clJtuCZr?=
 =?us-ascii?Q?WnOYXMbFmU+WnVq3hVkW16s1NmTHkK55Zm4I2zDIj7//vp74eX8TyT8AJS8R?=
 =?us-ascii?Q?ikSKnn25Pg2ToFDYN68HEfDukoGlYDYxOF3V3RNCtcWBKtNQ7Uel2TrgHvXY?=
 =?us-ascii?Q?JGoDl9/JsQJZLmybdj2h5YmZ+9PFdT8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5279e45d-4a29-4a79-06db-08da188cfd18
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 11:51:44.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKuWi3V5TmoiCYkOq6P9B1TYAaCyQd5NB7CZl/pdrQxZFstgxh6wa8Ssw9kwx1TysNGC2dtJ6LOXqta57c7WEKZdL50wXrWlvPI3QhJuJKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070059
X-Proofpoint-GUID: 27PlgZ69D5V2ZPQvgw6fbEOWPDSDb-eW
X-Proofpoint-ORIG-GUID: 27PlgZ69D5V2ZPQvgw6fbEOWPDSDb-eW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 06:57:24PM +0800, Kate Hsuan wrote:
> A not calibrated x_start setting would result in an incorrect AWB location
> configuration on a sensor when only the rightmost stripe is used. x_start
> should be calibrated by subtracting the stripe offset to set the coordinate
> to the correct position on the second stripe.
> 

I wish the commit description said more about what the bug looks like to
the user.  This is the front facing camera, right?  Is part of the video
blank or what's the deal?

> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
> Correct the patch. The correction should be awb, not awb_fr.

I tried to review the original patch and it was impossible.  I saw
you're from an @redhat.com email address so I decided it must be right.

I kind of get that you need to be a domain expert to review these
patches but this function is such a mess...

regards,
dan carpenter

