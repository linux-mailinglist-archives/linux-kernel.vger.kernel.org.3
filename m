Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA74F144B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiDDMF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiDDMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:05:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF91FCFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:03:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234AU0a5012575;
        Mon, 4 Apr 2022 12:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nenD5x1VPY29Xn78YUiXdyygmPr+WscAw6XKEDfjceA=;
 b=rCJI+tSC8vzV5cgzetEYUt17WAmGUl97J8IUAe6w0RV4w41wFssDdqkSGJQY4W7YpXLJ
 I4/R1zwGDZikagkXT0s2VHLGek3MbZT9svcrhl2BsI4zxBBOiaZwWwyl+l3z19e1dp8W
 UDrcwW3QrkdB8SyB/8oUUiOP6ZHJRzxEuHI+UMffINStHX/zZGlTGH3PXZTEpI15/ygX
 1QPgY/tTfMeOOo5XzmANNWJ1bIxZ+KUMGl8dMIH/LfDkb7NqUijIAvq2c8AQnzHBLiEW
 +u1rzT5sHSsKSdbbFfsG/3hVeLcyDraxKxgLUBWsIXW8t9cfJWzkKGooq02H3C8V07JY 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcaxyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 12:03:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234BuvKh032944;
        Mon, 4 Apr 2022 12:03:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2b7kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 12:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBL3hB6I8JG9xGhfdiGL8fdEQX6sjNYKRoxLErYxIBmUPXn+6oJ+TpzY4EJTAPWf9SuU52SLECx7S6OAdrTpw9w3oglrHyFL9qouaodgE4FZqu8ypO+CZ1OpAdBn4ep9sX2kYpx2qcl9jxMuBIqijTCK9P56ApKc2eJfcxXzEuugMG7woTiMPmlcMAKrWByG6sv0Uew1QvAybZE9yByf0/bLDCRSM8IkWci7z46tbRcRqUwgwV5i0Hi9790RRLbgiAlu3giHsuFfI/0vKT1Hmp12S632Raz5n9FE/sMqKoIajTmDy3BW+or8igAglcnxh0OkBnUQ8AxIlT7+ULEN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nenD5x1VPY29Xn78YUiXdyygmPr+WscAw6XKEDfjceA=;
 b=bWt6KKVdS2DABfC/ppW4puiZnP/48pDMf23vRefhD9sqagWm2cfnTfS0CZcBsKlIs/4cRnrztKiF+Kkurdvjl14Z2CCkaOpzsQQdxoiRYMGTSoM6g6ZEmLlnLVWO/TKGviC4fVm39epQFEHRqWrLS4vz+a2EgvN+kZ9BxXWrbofBASDEi7ulTaTL/ebVdKRxg7Y1den6S92mq1GbwN9NBVipH3os+FY3U2qUXb5tB5uIbTO4j2+OoMCHt59o9LxFOtt8t6FV210I3yLemsRckzf1vRyWkG9UnZGD0R1Hzm7NGCvrixD51JwmSCQ3sh7cGjGt5UmZNyep1iowhqtkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nenD5x1VPY29Xn78YUiXdyygmPr+WscAw6XKEDfjceA=;
 b=vPwnZzhvyHP7w2LSdkRYx8A7UPqhrHCPCkIqGQzyVClgUyYCsFchB+eFVbLntNuAsUyIKYDx02JIWQRaXPS4/KKbkKb3jYvpg1Bm+12DaO/jm7VShdU+ugLrLKsao+6royZ+C2C4W1EtsaIsN7klZGmDm32bjLOWk9R4TsFczeg=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CH0PR10MB5243.namprd10.prod.outlook.com
 (2603:10b6:610:dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:03:41 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 12:03:41 +0000
Date:   Mon, 4 Apr 2022 15:03:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Charlie Sands <sandsch@northvilleschools.net>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Message-ID: <20220404120332.GY3293@kadam>
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
 <20220404105041.GX3293@kadam>
 <4729027.31r3eYUQgx@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4729027.31r3eYUQgx@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0075.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::15) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a08a727b-3128-4924-e441-08da163328eb
X-MS-TrafficTypeDiagnostic: CH0PR10MB5243:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5243175347955C1AFF5236B38EE59@CH0PR10MB5243.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58t/mLpWao3oV2E//DMGmkfcXsq3Hv1tQRNmfc3p40TXpb0VMlFMPjq4xQunpLFrdkdgjsliQJTZlw5qcp7ISxkI8dwWtlsOk0xvTb2esRkhyI9H9atStowJJhqqRfaDVud2Dyrn/aMHnCOPV6dL+Td3S9W385tzrDueCWupli3Bp1w3Qg3QVriW1MMhCiOcufG508tl8X8x59+IyUKMtBsW7R3Tnq7J/IRSfvWqBfj4gFHIwhtJe+4xOJYndjJt9/VTJ9XoRd0QX8TEUjx8ziKcSi9cD/lUG/etlWtSPNaUuoQx1ks/y4nK3cJvrO5IIsEnBOwaGdjqZHvigCncQZYCaQU9ax3nICTg94M2IzhoZesMB1kMIsewRuH8rwA++FhLJQt4jMjX/o7zl0rXCkOkP7/iXAUPXJqCa+d7VbZ2eNjn5QRZruMrDZHa2d1fmSS58TFI0qDX1XkaK05KliUdmcNkxN8ON76eR8hDugJkTTwarg8DMOvUx9URzd6d/shJqXQeVwvVj/QE5g8CxT0wsRUrrm67liz24J5BxFHEhriCPxcfdOExkJ1HqKWMpRWfnAQO2ba/BuYobjuLIom1TB1e+jq5IwwMGsKbRJq6DYUQQ5zlSkVNjwwXcak45Wn1cg0/IQ/LQDDOE3QGLbeKo5vJOHousKkQcgGihf9tjY011T65vmwbWt9sHphbVFQf85zGGhAkBOGK0uvZ7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(4326008)(83380400001)(8676002)(66556008)(86362001)(66946007)(26005)(66476007)(8936002)(186003)(508600001)(1076003)(6486002)(6506007)(38100700002)(44832011)(38350700002)(5660300002)(9686003)(6512007)(316002)(52116002)(33656002)(6916009)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGSkYQ3TqaHCpC4s+TiwgpcVRtFlwjoCGBvm1ikESbUCBKDeOOJbCCy0FZbT?=
 =?us-ascii?Q?G+q1QEuiYhV9mzc31ncwc/f88Ko8ATwxH+RsW0CjvqHQzySedJJpteyTgM/F?=
 =?us-ascii?Q?vrjdDI7WIa/pmWuYmEI92AO/DAsvBE0GyPX6kDDwYWMa3JWDCbChIyTtAsgl?=
 =?us-ascii?Q?19yTzVnN0b/a5Fxdp0q9xh+TI3yqhTPF/n9TLf4qZQOt1ONmUGV6c3uuAZaE?=
 =?us-ascii?Q?2HU6cfOh8Ielc3rCc9cbmV9waTnMTm9e9VHtEYSU663oRh3uobAGWuCnI72D?=
 =?us-ascii?Q?ACRYInM0vQ3QNQVOvZUHGEyaIRfkJAM2RlQHUtQ9eYqqy0124gq0OzCDC0rs?=
 =?us-ascii?Q?g+J/2CdWNo8YeQpbiZ+yGyNT0dvBUBlG3og7Wh2lJaVNyyKEj0V2dVmchLLz?=
 =?us-ascii?Q?YaQw5LKY6ErGsqltP7aCVz18PSm1m0aMnH5ali56lebvQ13YlRbauwD1/vbY?=
 =?us-ascii?Q?+bdj+xiRbfRSYNm77d/lJOxgzPUzKr+NGuh7a9OVxGLPrHpqGOrQ1rgaiUJI?=
 =?us-ascii?Q?wGAW+jpnlhR+GCiJlz865vExUkGRZPvYSBhyqWGuIK5DozPknTQr7CGukp5U?=
 =?us-ascii?Q?pIxNSTsv3FEt+bURZrl6TvMntuLJReRv6OYLkrTxOfNfVwx+ZIHGYhVg6CFb?=
 =?us-ascii?Q?fdq6uhmPZFNthNhPDS6awCJ1Odz0he4AuWZsWPcZsvkeXu5ZkdITKWMZZ0kx?=
 =?us-ascii?Q?XZGHwJ6QP0s3W5HXbYNUOu/huzwpUj84/7ANKxUtG01cIf5OGJLJOlyfbHOO?=
 =?us-ascii?Q?UiBz5aaUs97sb9hxHwfj9Iw2+DgtpEO86DrKSk5WSXgKsC38zgNOGSKRUbHU?=
 =?us-ascii?Q?0qMf/cFFLTawfVQ9dugFMYH8jZaqu+oY+HvIeueblOCMG0cZOS/dTsrcZUvy?=
 =?us-ascii?Q?DQyvU6SD739VpAt7+dkMq8qE5J+30SXkEGIofKMaJXfE4+DrN3WhS+HcKiTS?=
 =?us-ascii?Q?QeffTDjr29ebGIlmN8vkAcOWEUSaqfAWoRxs6U8+hf9PM17s5wYvp3JuYsJf?=
 =?us-ascii?Q?AF0qZ2jf8uX2NEMKIAm1e+TxmEs+2FV9yIbGEATIF5JnzpuUMMDWfeYFYw+Q?=
 =?us-ascii?Q?oiUrIzy/XGQpI1VnX4J4cSuDMOkJflBRr/b8DQ7YKqN9jawWS2yJD5d35qXx?=
 =?us-ascii?Q?ySJGd1xrgQYioR4jsDCUigeQNKABI1k4tzwgC0gpPZcaP9Np4DNGGaynOjqH?=
 =?us-ascii?Q?NZUsJJXf/gwXg0BodnbpmChIBUCqHwaWRhiddquoMlXSAmg7KsPzGWDSkliA?=
 =?us-ascii?Q?Z4jxG1S+gDaZfudFw3nsiK9PCnxjuwhGak7dz8zCvITS2GCW5WPzCsI5cYCt?=
 =?us-ascii?Q?GYKrM+WqLfjlZMt/c+GC05mAr/2U6WVDblXUbS3HAr41hmMkgjNCBsHQiZ/B?=
 =?us-ascii?Q?gdzN+Vov6oGpjSqEVOlGQe0QynR7Y98XMmJcZur0lJzghBrDdH6d6b5xdlt8?=
 =?us-ascii?Q?Owa84OlWlgXUXQqt7x3LclqM6ZjTB6YtQ880iT4At/Y1vGjdUKigJkThTmUK?=
 =?us-ascii?Q?RTkzRKkkZMLrI75NRkPALaZ99IoU9/SfkirqZLFXn+NmP8rS5lkVPqAuGTZq?=
 =?us-ascii?Q?HlQVZuJb+RA6eMskapCdzuZ0VCup1pu0jHcvsfh7NgjKRECaIipZlK51zv2T?=
 =?us-ascii?Q?rz/16T5Rs1LdLqCly3V+yy7p/tppxA5BTCHfLYfv2raYxF4K901Qk33kPfaE?=
 =?us-ascii?Q?TopD9a7FyBMaEn15wrMDU7kydXeMoIdqT/enzevol6blanA62o3uY4kCRy37?=
 =?us-ascii?Q?ZfvSLXsOzfnZRjoodiktmL1xfV7fD0g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08a727b-3128-4924-e441-08da163328eb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:03:41.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2UYVhDMwSbAygsuAMILhGzmtxbDcgRkgVkTdFDLtg/rNBU+qc/PrEhraHZVN7rSjhZxw3pt7thrCRjYRg4kvbZkctQ/8LqgxIfif78D+lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5243
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040068
X-Proofpoint-ORIG-GUID: N5y3o5qrB8JYDM55pjYUFdgqAYcq-9Zq
X-Proofpoint-GUID: N5y3o5qrB8JYDM55pjYUFdgqAYcq-9Zq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:25:37PM +0200, Fabio M. De Francesco wrote:
> On luned? 4 aprile 2022 12:50:41 CEST Dan Carpenter wrote:
> > On Sun, Apr 03, 2022 at 10:52:07PM -0400, Charlie Sands wrote:
> > > This patch fixes sparse warnings about the memcmp function unsafely
> > > accessing userspace memory without first copying it to kernel space.
> > > 
> > > Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> > > ---
> > > 
> > > V2: Fixed checkpatch.pl warning and changed variable name as suggested
> > > by Greg K. H. and improved error checking on the "copy_from_user" function as
> > > suggested by Pavel Skripkin.
> > > 
> > >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
> > >  1 file changed, 13 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > index 7df213856d66..4b4eec2bde96 100644
> > > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
> > >  			       struct iw_request_info *info,
> > >  			       union iwreq_data *wrqu, char *extra)
> > >  {
> > > -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> > > +	char wrqu_data[9];
> > > +
> > > +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
> > > +		return 0;
> > 
> > return -EFAULT;  We can't assume that that user wants to copy 9 bytes
> > especially when they're passing a 4 character + NUL string.
> > 
> > This is a custom ioctl.  Called from ioctl_private_iw_point().
> > 
> > I think if you try to dereference a user pointer like this then it will
> > cause a crash, right?  So that means no one has ever tested or used this
> > code and we hopefully we can just delete it?
> 
> After a quick look, I'm pretty confident that we can also delete 
> rtw_p2p_get2() and rtw_p2p_set() unless I'm overlooking something.

What are the problems with rtw_p2p_get2() and rtw_p2p_set()?

regards,
dan carpenter

