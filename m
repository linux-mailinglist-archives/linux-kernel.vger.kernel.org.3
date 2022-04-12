Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE14FD617
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386422AbiDLI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359479AbiDLHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901671C116
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:25:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C7N3BY029074;
        Tue, 12 Apr 2022 07:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=frksvLGFiDmGBdGmR/4+XHDQ9mNbbrkPzGJUPNbVsV0=;
 b=HSc463ymPyxRDH6POFsYfAKmsdR/B12dx7qpFFbfwize7zOelsoQIswCDJU+Y0Yujmqx
 PZj6C6Q9BUABmSTe3EGmZDLwEhc1NWqdj4AWYaOKE2E+gbAtet0taydQYFcvNyhySNs3
 ht+5sbcXXhZ1aRzBnn7x5zcUElHBcLMdWO9+wVH9FjgJf85/tCqbv4QhKXyLaptaxmQ8
 VJSOw526y5cMJCZ338zuu/AYx/YhOzRt7HaxMuT+/ExP7b5KTUcVmBd3tyZ7gWjxrNTw
 5hB3YIptNCJHmsFF87SlJi7U1nuzazcUiW5ilS3Wty1XzKEuwkWD/xhDEBnWvHQ/iDfu rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs5wpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:25:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C76DgP040258;
        Tue, 12 Apr 2022 07:25:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9h3e3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE3anhL+NDxj2t51uGSy+5FGnsGCtktbI3U/Fkppoh7xSlZvzotA/oP8+lqJ9TZ+DAb/N5RuY5GvkL5OlgEOmcKq7dOygwIpmOBwc4cyX8v0mjMrXFJgDS5mg72bOF1jwYjRq9W2uxa4IImv2/1YDWRQVk30Z8cNhZ0crNd05euBxvzsCMD7CbFUQkVB6E4ZNLyUjbqTKgtU46s0b9EWmnD0UVXeLmdJBBVlge1wcA34AVceYQpGCQpQ+XQR9k1ZKDCMiiU+2vNthWIutHy4dJ1LF7fKjhaUJsh0UdJ4tPbh/PWmr3dYnP5OCRW3uh4Z4q3DTieUZMAAM+XpYStGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frksvLGFiDmGBdGmR/4+XHDQ9mNbbrkPzGJUPNbVsV0=;
 b=ExCfy+JMlQg2jjz/i4nzKuMscrdVGsqvptP2yA56Ao59Wink7cF47eX7zTDj3w8GjCBXX3rlYNnNIxK+xWWa1H7R6BEON4zJLWO0rG0MZx4Krx/ajhredA3OiffclqoQFDXhV4ZQSwG/Avd/+c8kDkcPi8Nlq+XIC6m285emr3uLlEUdQE46VmLe92htD1EKaHmXFtXHPAcj+zD0DL+KVSsv9YFRp6cSReLc/F6P5PjcNmJXcryr9/dNOdAOzqA9TwzaUSlVIfcKwZiO3FGKZRJ0VdolLRvg0zZ4EP2vXqT316uIwm6UU9CkyEpVRKAVU6OzAanmdT0ZTZLJaNxRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frksvLGFiDmGBdGmR/4+XHDQ9mNbbrkPzGJUPNbVsV0=;
 b=umcKOTanTIe3FS5Gybi7av89KUMCPr2Qxq6/3qiPG2WmKEgSN0eX8uzMbPXW7OXuUYheqItwRyexuDLZ/SrFoJcSpC+XCPDMBC91LEnwYtn0T8Ook5Uau+TifstinNqqpUVqb+Kl+KxLW88rBlJbKwPQiRfVAdJKj928Imno8XA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5403.namprd10.prod.outlook.com
 (2603:10b6:510:e3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:25:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 07:25:10 +0000
Date:   Tue, 12 Apr 2022 10:24:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: replace zero-element array with
 flexible-array
Message-ID: <20220412072458.GC3293@kadam>
References: <20220411211411.GA2796005@jaehee-ThinkPad-X1-Extreme>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411211411.GA2796005@jaehee-ThinkPad-X1-Extreme>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1faf0b-2a34-4646-a0d2-08da1c5593de
X-MS-TrafficTypeDiagnostic: PH0PR10MB5403:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54039A07ABBE5912838A66C38EED9@PH0PR10MB5403.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gW4/XKJWpEpUEkx7wFBQ5PrJ2j480ZFScnLZqnkp4qr29BvjbMqsYiWgzkCJzp8eo0kBhnlUcYBha79C4emibQmf7LDmpvEIKVtonyEKcyEuwoIpQjpc/v6GKA5bre1wdChirLIjRmn+kNrS1+AwjGhYJJ98DYCWwYNzMXewPnt0RrWzpg9/UPZqacOIcw7KSI8wmYMiZjYy9ykCJuVkZ/8BxnligJjNPLiccHxQEz3v/ROYbK6BeBTOf6f1wS6Wxd52yg4jUWWESBRha/AVY9f1FipKibRaL63khxqHTs7VELXUJ5qcO/gJZOO2CHbl91jMSHHHGXfYwDtNclXq8W8vI87LUwIRbdqDQHH6+NCBDD7u37nkkVAFeLBFoIYCZ1O1hJsy6p4LdEqMQ/CRHFpRAfzwjTdhdty8zkgJwae6yiH/R0+aI7TPzckc/QX3rEPTh63Tpuyu8RsQIP8sDl0cRYTWzVuNTA8o/ZVrskBz9TPSs2Qoz2/F1KizKIWLw2Di0QqmB9ysQbAF/gIzgtBvxnACgeCbtUTzpiPm1SHy4r3MeCh5tg1u7wmP7t+UMdGw3+T0veCOETBxlsDs79CfGkbsEdoN5gkJknAsq1uv0YnGIDNyvG2opOYRCSW5EDI5TktXBBwToMTql4maROQoIJ7KtdNJ90OCFV8nsH7G3BITk6Y9+YcHMb0RQjf5Ei7IJVXCfKj+c1OBNS6piw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(2906002)(186003)(66946007)(6486002)(4326008)(83380400001)(33716001)(86362001)(38100700002)(8676002)(66476007)(38350700002)(1076003)(508600001)(66556008)(6916009)(316002)(54906003)(5660300002)(8936002)(6506007)(52116002)(9686003)(6512007)(44832011)(33656002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMF7O10USMZtnnONNk5FKkgjIW1n1AwdAoYwUWDQsrVSlXuPo7Yg0l/22sLu?=
 =?us-ascii?Q?Ek26r9vICUimvvprs+GG6N7pr+JR06B3p8k/CYEK0E7no2K1XglBTUsgWAlk?=
 =?us-ascii?Q?P3/KOLfSQ2XvE0iqcACuJjnLl/wjgzdtkwPcCBBwNyOgkEHFa1rEvtwlQQVm?=
 =?us-ascii?Q?Xjpn6293D2KOjV9jUplVE8Agr/XYX3n62lTp96wnZSjTDYGA379eWaaKsNZW?=
 =?us-ascii?Q?rMSWKAvIVfj6pKyJVHpbjutoLor/E/0XV13iLNBQCGE4TLSyKJM0a75UqbX9?=
 =?us-ascii?Q?BeKSbowXuiTXPbPnQecHkSWPApuDQqomCVuDaau86LIwHbV+8jxfBSnShgov?=
 =?us-ascii?Q?4HJjRO60AzXdEIr3WeX8EQDJ88GP4x2QgdbbwpPExLBHkc/hqMxxXmwCkcXc?=
 =?us-ascii?Q?xJ55ITuSNU8R9Ty5Cfxs6Egn9jvoxcU2cnyJrC2wPIujOIKR5TwudAEtZIRA?=
 =?us-ascii?Q?7HnmtZpzSq4DqwOkbU71vSyXcp7lcQHdn83Y+7yq/A8WJ2YjODwCEQF/s7ux?=
 =?us-ascii?Q?ipM7RFt/Oz6N3wuWB+XmsI3rU736bvjcnZvRVx4/JIiPKYwfGE8/CItng33W?=
 =?us-ascii?Q?2mGNPcGrD2m9LBkaNtPMhEqPM2By4Acn4OmLWwm14x64W7yBRoU7yfGi2j36?=
 =?us-ascii?Q?5/EwGn0hLJ0ZaMCklMzSbytH0sqBUnafvG7UIcdgLtuksAYh7QYDOAK+Xla1?=
 =?us-ascii?Q?7NWarUZvQCUW17Aa+oo79IVNzkEhQ+p5eJ2oNTqxYNO8nRSNsMni++flpXd0?=
 =?us-ascii?Q?V6czP+NttJElsCloE7n8eY+nKDnpPmMpz3P+9hGgFVf/765IA0t7Dn3nf5kV?=
 =?us-ascii?Q?gGCjBufBzx1pEG9nO/ypk2Znv1BCgCs8P+O2Ocjw+ipmceqKCoPmhSFnbisi?=
 =?us-ascii?Q?6RarGG9j6WFKt8MzjzyAx72rfx/tr18dWjj2l3ZfI00iVOUN1LQ/4aXad9Fi?=
 =?us-ascii?Q?VjHK7jMtTVsNykTXl+IxsG7Lowc7kvCcHChD6MYIpNDlQRAy3yxsF8hwy6ez?=
 =?us-ascii?Q?lC078qHdrpx5gSHr+Rw7pZc/E0o1gI/iIHxHWq0c4fTs2ES/UFU0GDoACiKR?=
 =?us-ascii?Q?m5iastVmkXMVbp+xJn9CoiYGJTfNDMfinc3JJ2DCslfU8TKJ4lN/TzZIqd76?=
 =?us-ascii?Q?3zBgawPrYHxW4dfWoN6ghttJ2WZ0GIGuya3ACRgyiwTYGwlQWxw8sH2ADrCb?=
 =?us-ascii?Q?oF21RQuxu/38V4DeWcxVa7XlkQetUdDkgMl38axU/xaTr88kp9gdjOcTOMl8?=
 =?us-ascii?Q?EYMvw109LWHzZb6rEs0epS4jj9AlX5zGd2HkSKZ7vFdTmBci6wyhlC9V3PAx?=
 =?us-ascii?Q?FpI+LE/ipXatOWdAlATGWYF0/NzS3aQCE63Y0iFEO5qpojg1XOTVKYYwBT/X?=
 =?us-ascii?Q?ygP0JkV4Xg4rjzhBhv+SUa4Lw6JFXYsVUyNFa1sTaATNo8v9eYbY3vhuM4PO?=
 =?us-ascii?Q?iVV/K+zd0GntdWyWExE2i9Fg/ZZVoX/ZMJaxpSL/lJyveVTP+QKueb/VHqL8?=
 =?us-ascii?Q?bdmXckcYtbFlbQZ90P9dIZKyf+rK205ZD0eiYzDHxKT6p+ya+qsZr4GmWfyO?=
 =?us-ascii?Q?G52+Jdau6I7/QbrwYm5PnL6jVIDrfNFRloJOyKioVyW0FyINWNMYxx0z1aVC?=
 =?us-ascii?Q?g9IrLk5cmef3qc4sfDADPxl/DeQGWUErjQNijr4JkVOqoqlu3qtOwPG+i5hV?=
 =?us-ascii?Q?SMwgPUgK+91nZpBgQYwO9d2+tnUI6Uxs2efdkuc2fZMOgV3TW+KvBg5XVuIa?=
 =?us-ascii?Q?92Ujbg+iGO+AM3JS/9JYrStSP/bNUPY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1faf0b-2a34-4646-a0d2-08da1c5593de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:25:10.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+ujZ3TZ6nCxU8g5bqqgv+N+YCGX0qbUvspOYeNE+O+gOhi9jjYS4Bm23jLpO5vZTSEfBFJDjSv8NTUPp6ETL1tFMVxE3gHxYOrVxNbXkcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5403
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=770
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120034
X-Proofpoint-ORIG-GUID: VZY1fsxj_w_u2y_cfWsZDq5UORath7Ep
X-Proofpoint-GUID: VZY1fsxj_w_u2y_cfWsZDq5UORath7Ep
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, this patch is not right.

On Mon, Apr 11, 2022 at 05:14:11PM -0400, Jaehee Park wrote:
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> index 8e9d9d59a357..d0b2422401df 100644
> --- a/drivers/staging/greybus/usb.c
> +++ b/drivers/staging/greybus/usb.c
> @@ -27,7 +27,8 @@ struct gb_usb_hub_control_request {
>  };
>  
>  struct gb_usb_hub_control_response {
> -	u8 buf[0];
> +	__le16 wLength;
> +	u8 buf[];
>  };
>  
>  struct gb_usb_device {
> @@ -102,16 +103,14 @@ static int hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex,
>  	struct gb_operation *operation;
>  	struct gb_usb_hub_control_request *request;
>  	struct gb_usb_hub_control_response *response;
> -	size_t response_size;
>  	int ret;
>  
>  	/* FIXME: handle unspecified lengths */
> -	response_size = sizeof(*response) + wLength;

You're mixing up the value of wLength with the size of wLength (2).

>  
>  	operation = gb_operation_create(dev->connection,
>  					GB_USB_TYPE_HUB_CONTROL,
>  					sizeof(*request),
> -					response_size,
> +					sizeof(*response),

In the original code response_size was equal to wLength.  But now you're
passing 2.

So, I mean the no brainer approach would be to just say:

-					response_size,
+					wLength,

And delete the gb_usb_hub_control_response completely along with the
reference to it.

But better to do a brainer approach and investigate how that response
buffer is used.  It's probably all fine.  So probably the no brainer
approach is the correct approach.  It makes the code look nicer, it
doesn't break anything and we will merge it.  But better to at least
look carefully at it first.

regards,
dan carpenter

