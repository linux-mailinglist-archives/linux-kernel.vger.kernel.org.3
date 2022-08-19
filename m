Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4C599483
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346434AbiHSFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiHSFb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:31:29 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2091.outbound.protection.outlook.com [40.107.23.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC44E0FCA;
        Thu, 18 Aug 2022 22:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9gbTOfc720XXCAp7q+679VwIqCVmYJkBrF2+uGcWFn3oAmvYzFhAYLu7Ue/fiEgk4tFXwYsbRT+K1xmaraVySeZ4Eczz29hymf/5vChUFaZGFR4rOz9J4BPYy7JZTaJmsmD51BfCA5dF7gCS+8l1UfAJHZULuO4dKgvTknXL4mYAJ7/NYudIJ3mP7Oyvdm6S2SE9EFnrI2y+S9lV4TsblLpjoLIRdFtEf5FI8APq7xAo7p0h+KKws5m130nJuwZZpnC79Rww39qY3+zIVYEYWGSESnfIpqfM90P/zdPl28So6YMLcnl+WTUfLxy5Vi1NXRCgz0bDgBxO1pRTnLv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sqCHmyp5j2qBLAwz3OB2o/E4w0d9ErsYWmGCs61dIU=;
 b=XWd5ogdXguiftilI7U5ynthqYf16kULsvVrl3q7dkCXT72hDAjOvuTQv2IB4qhYRhNOjLbLmZBEWDhosZ0fWtv6LKV6ABJzcXwoWK0zkkEP5UsNRrE0h1wlgBbtwlYPaRNOP/CJIC/xP4oK1Id5W9yTeVhN9OIR7UVd1keC9E3Q7TjBZStxEHN4EpfljBUFqo/9UxiigR0rO+jrrejJgwewNrvXoLSoyJcD5yDXdkiLvxWiTesBj+06+rVLD7Rjd4sNYF5F5w+OPdpWWZGcNKkXi4bfiT9xW00gr6btJqOZjyjV+GMVLf9lVvItqj5Bn/OXjf0VyuA0VeDMJdLs13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skidata.com; dmarc=pass action=none header.from=skidata.com;
 dkim=pass header.d=skidata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sqCHmyp5j2qBLAwz3OB2o/E4w0d9ErsYWmGCs61dIU=;
 b=fF9zw4mXgfJKXFp1wMxb4QkW5hk17wwzeCZuAJosnoiLsDvmk6bslQ3Cj2VZGBANYE4l67IehWCpDA5GLuigM2kg4iKdYsBB4Yq0GqF+jeRJFJUIjJ0OJKPijSr03XmVvLTDpZySV0fEV4GCBmyjWTqFJTqpLL4slDhSQ4W4xbNZ7U1l6UX1+qOlZqnU2emgBBdO4W6ZQqMKD31idOEzXz9KJ/GefDTpTdh5CxlO8ajYPiF5s0yXn2rfky4utxXf6Crkh/uwP+kglLMBTKiHVIbRX+8afoFpDuDM8wUxRRPXGmW8BUavD+gdJxNxSdvxufWHLZVeKUVLgcF4+igT7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
Received: from ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::8) by
 ZR0P278MB0474.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:25::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.17; Fri, 19 Aug 2022 05:31:23 +0000
Received: from ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM
 ([fe80::91f2:a7f5:699b:388f]) by ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM
 ([fe80::91f2:a7f5:699b:388f%9]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 05:31:23 +0000
Date:   Fri, 19 Aug 2022 07:31:20 +0200
From:   Richard Leitner <richard.leitner@skidata.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] usb: move from strlcpy with unused retval to strscpy
Message-ID: <Yv8gKHKM/HjIkmnz@skidata.com>
References: <20220818210116.7517-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818210116.7517-1-wsa+renesas@sang-engineering.com>
X-ClientProxiedBy: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:43::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbbae6f-d114-4588-a4b7-08da81a40daa
X-MS-TrafficTypeDiagnostic: ZR0P278MB0474:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qrde3+OELKdlwtxdseUocRw4GrWl0GfUa63BkF1V5M74vvlmjsdvWlqm9nG1NAfThzREUQNcQZLE25K8g/Z15SUFSrGmU2eZI3vKRPvPdfjTuKLnU6CQ5Fya59mQObHBJsg8q+eQSQ0LNvUdHWP//KJAmTmdlMfIGo1ucrPogeyU0DQDlPq6x0ZQrZUTME2kFltGoz/1viJMlH9DQGQzn+cuI3DMGReMnhCP71z5137EnGRFQTC1AkX44sB7RoMD48F2bm4FOVGvVJkfQKCrju3FEJBRa3K+ndoFE+neGdi1lEV0i+tF5cw+saOPERy6ZUanl/1HFARob4ivtHeg/PFWhPPE04Tu8kWCb1XSDA1iNtYSzPDIRBF609KaH/+tdDwcc5NemfgJYO2x06iHuQKLbCJYPAqWBJeJdl4dpAgvobJ30qhy//+WnbbMmr6daiEAPqS6k4u+CXD7vioU3bwXqO02lYppwhqSqxNOW6nw7wialDY246z+bE4yyBD2Ac9yMxGn2fiaYDiMAmWPrcXDcKz3fw4+VE/cssSK7s7OU1+LOxpx69jMhF87oFuch9PutyjGZdHRRXgy5sfZMX+/3Rm/HLXr8DOW48cd1OSjWUmiU/63AHV28C1XPMl6RRdbSCU5x+rD9le/igOeZpA7YSgl/TBgtcBGh+jc3ErraeDTE31TgKLt9QCK7hXoGo5hBmHID+mXR+ScLOBcHhslgBMTxe/AOFIo+TcFpNgFunzBiFcKGmLg/bZLZ/zjEI5PXfOVSwLgJDtoI5BJwvaba4BWlFCG2G+eePUz4q5WkoZR4lRP8EY2ef4Zk4ICu5SjQUTTVNtoFymlyyjmog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39850400004)(376002)(316002)(54906003)(2616005)(41300700001)(186003)(26005)(6512007)(6506007)(86362001)(83380400001)(966005)(6486002)(478600001)(2906002)(5660300002)(7416002)(8936002)(36756003)(44832011)(8676002)(4326008)(66556008)(66946007)(66476007)(38100700002)(156123004)(41080700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7xbgsJZ/wcrVQnQ+FunuzRj23iyvshkVG5LhOtnJH8FSPOS/u3XbWmLcpEU?=
 =?us-ascii?Q?oleJliM/WUazn8t/+kHNR/DtkaOQzgy8jCHyYRa8HgwkyrZA6+vCgkZGAMnr?=
 =?us-ascii?Q?UwiBIT5lh1AZUjas8rJ+hYb2c+2DhLMRRjanoKo5oMiQQiJl0fG8tl0ycD1b?=
 =?us-ascii?Q?qiUTPIpSVujEI/uxjMHdFhQOagNgTFhvuhq1Idar9ab42iZDxV9Sil54fN9d?=
 =?us-ascii?Q?bb39nRrsoY9gOHazRBDRSZpeUJW63WIWqgcV6b9g3dA3XJ+Y0guE9lVaTphp?=
 =?us-ascii?Q?W0zc7J82xmv3j+BLmOdma71dWK5Pj0KHbd+oJx2nJqstKk1+EN3l7vB2w3Rp?=
 =?us-ascii?Q?4t56M6aio9sNdDW81OkKg84LABESDGzP/QqNDssmxxwYg8nqDOljrGymxalH?=
 =?us-ascii?Q?+Kbg8yKm8tADJoeghXwAMgRKNc6H1dekAAc1ul0MCncGK45gjNqEGWJIBqC/?=
 =?us-ascii?Q?Jcdvn+4q8YOvBL4vgFp/a0hu9fwX3Soa0p3J7mKlI2nO98kSVRPKFnSMaIvK?=
 =?us-ascii?Q?eF/A4bHxJpGfpWwQA5ExXU8WKXcqAxsFlvvWt0kI3uNbaHr3yNaMmy5mCR3N?=
 =?us-ascii?Q?S8D+TzQ4a5SzoTvL8f+6LFa4UOALJcarrqlVuCm19Vm8JEejlbqIZ8GRukx9?=
 =?us-ascii?Q?R2yUKckFvQ2Us2OPSQRWaC03I7fqwnP6iVaBeUzpdXAbZw2Io5xgkjoI5D7Q?=
 =?us-ascii?Q?3j0Gufhnr0IvUgnIq/SlfGg+TyOOSl2zMwUikWNOGksa3LRKphx7zWlqT8pk?=
 =?us-ascii?Q?7f3wiUlhfbG5PdJd2MGvjF9IrDHRYa4qIso9DhgsNE1zhqmW3pnngyp9C3z9?=
 =?us-ascii?Q?egPhG195gvA/th8qkbH/1Lg+HALv8XoT2u4utnvmmaiklUGeGqvt1glOyCEo?=
 =?us-ascii?Q?9AtDE4GdNYQSZ5WyU53j6ofb6f0ot5s2XluZq0SdHr+CNwNVTqzY1krERhei?=
 =?us-ascii?Q?9bNiVs8MD5Ya/MpMQ33pQJqUyas0ak18Djk/UNh4OoItHe3sp1d5Tn3OLj+a?=
 =?us-ascii?Q?JrHB8o90zUVkxQVkWzPEgxsUKu6Xw5WadQpDI3CyjMkSZMP/KpoZGKXlj1sd?=
 =?us-ascii?Q?ASZlO0iVHSWLOs1hh7M+NOprEgD3kTxZl5a63T8EVv4X7pK70rbNjxbs9JfE?=
 =?us-ascii?Q?3gYJIDMIOrou4RONoIYvMh2zd9IhQP49xPDnhcld/lGqnCj/RYZPWGHPANRE?=
 =?us-ascii?Q?sgnFG2mOuki7ornimGK4JTVMnO7wQ9vAUCDgYjRJIHC3NfaF90dgYi86TyTA?=
 =?us-ascii?Q?OsicTCHNAeyCddUA9sS50miMadZx0wXxGdl5TBsx7vWb857y73XlyVNongCX?=
 =?us-ascii?Q?xsDhK6/XGv4ephrYOw32JM6k9erkxxizzXGdDwf7z0y4tDOogYC+DVWzikb2?=
 =?us-ascii?Q?l0F0m7pVYAe1YfsUtg4OBG6qiIhXfZpkOiS2EwylvtP9cB0ycxQV1KS0j7EI?=
 =?us-ascii?Q?YhHFTP6ivFvX24xY9Xi14e5Gx3XXdoz5HCMON3hOFxzHpBZGgSLO15T6AdJj?=
 =?us-ascii?Q?78osP2PC3ZE2hPOihkUTg26UypmGxyqIbp1jBF+zXBJ/dApIp7WNFq2Otde9?=
 =?us-ascii?Q?hyO+5Yydy7XuPyXR0yvMBkHZZROmVBLQPNsu4VxB6ERIA6WhASujAxsmTB5w?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbbae6f-d114-4588-a4b7-08da81a40daa
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 05:31:23.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNF9a+zshHYnPiei4XDhXm8+cZ9upgECuypk6haxcqM7vSbIzCUgd1xkRHS9i0U/D80YyaFj7pEqCWo7guNggMAgjJO0gZcqbjuqkLaaZXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Aug 18, 2022 at 11:01:15PM +0200, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/usb/atm/usbatm.c               | 2 +-
>  drivers/usb/core/devio.c               | 2 +-
>  drivers/usb/gadget/function/f_fs.c     | 2 +-
>  drivers/usb/gadget/function/f_uvc.c    | 2 +-
>  drivers/usb/gadget/function/u_ether.c  | 8 ++++----
>  drivers/usb/gadget/function/uvc_v4l2.c | 6 +++---
>  drivers/usb/gadget/udc/omap_udc.c      | 2 +-
>  drivers/usb/misc/usb251xb.c            | 6 +++---

Thanks for taking usb251xb into account.

Please feel free to add

Reviewed-by: Richard Leitner <richard.leitner@skidata.com>

>  drivers/usb/storage/onetouch.c         | 2 +-
>  drivers/usb/typec/tcpm/fusb302.c       | 2 +-
>  drivers/usb/usbip/stub_main.c          | 2 +-
>  11 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index 362217189ef3..1cdb8758ae01 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -1026,7 +1026,7 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
>  	/* public fields */
>  
>  	instance->driver = driver;
> -	strlcpy(instance->driver_name, driver->driver_name,
> +	strscpy(instance->driver_name, driver->driver_name,
>  		sizeof(instance->driver_name));
>  
>  	instance->usb_dev = usb_dev;
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index b5b85bf80329..837f3e57f580 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -1434,7 +1434,7 @@ static int proc_getdriver(struct usb_dev_state *ps, void __user *arg)
>  	if (!intf || !intf->dev.driver)
>  		ret = -ENODATA;
>  	else {
> -		strlcpy(gd.driver, intf->dev.driver->name,
> +		strscpy(gd.driver, intf->dev.driver->name,
>  				sizeof(gd.driver));
>  		ret = (copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0);
>  	}
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index e0fa4b186ec6..98dc2291e9a1 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -3700,7 +3700,7 @@ int ffs_name_dev(struct ffs_dev *dev, const char *name)
>  
>  	existing = _ffs_do_find_dev(name);
>  	if (!existing)
> -		strlcpy(dev->name, name, ARRAY_SIZE(dev->name));
> +		strscpy(dev->name, name, ARRAY_SIZE(dev->name));
>  	else if (existing != dev)
>  		ret = -EBUSY;
>  
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 71669e0e4d00..f4f6cf75930b 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -430,7 +430,7 @@ uvc_register_video(struct uvc_device *uvc)
>  	uvc->vdev.vfl_dir = VFL_DIR_TX;
>  	uvc->vdev.lock = &uvc->video.mutex;
>  	uvc->vdev.device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
> -	strlcpy(uvc->vdev.name, cdev->gadget->name, sizeof(uvc->vdev.name));
> +	strscpy(uvc->vdev.name, cdev->gadget->name, sizeof(uvc->vdev.name));
>  
>  	video_set_drvdata(&uvc->vdev, uvc);
>  
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 7887def05dc2..e06022873df1 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -144,10 +144,10 @@ static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
>  {
>  	struct eth_dev *dev = netdev_priv(net);
>  
> -	strlcpy(p->driver, "g_ether", sizeof(p->driver));
> -	strlcpy(p->version, UETH__VERSION, sizeof(p->version));
> -	strlcpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
> -	strlcpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
> +	strscpy(p->driver, "g_ether", sizeof(p->driver));
> +	strscpy(p->version, UETH__VERSION, sizeof(p->version));
> +	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
> +	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
>  }
>  
>  /* REVISIT can also support:
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index fd8f73bb726d..511f106f9843 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -67,9 +67,9 @@ uvc_v4l2_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
>  	struct uvc_device *uvc = video_get_drvdata(vdev);
>  	struct usb_composite_dev *cdev = uvc->func.config->cdev;
>  
> -	strlcpy(cap->driver, "g_uvc", sizeof(cap->driver));
> -	strlcpy(cap->card, cdev->gadget->name, sizeof(cap->card));
> -	strlcpy(cap->bus_info, dev_name(&cdev->gadget->dev),
> +	strscpy(cap->driver, "g_uvc", sizeof(cap->driver));
> +	strscpy(cap->card, cdev->gadget->name, sizeof(cap->card));
> +	strscpy(cap->bus_info, dev_name(&cdev->gadget->dev),
>  		sizeof(cap->bus_info));
>  	return 0;
>  }
> diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
> index 61cabb9de6ae..b0567c63d754 100644
> --- a/drivers/usb/gadget/udc/omap_udc.c
> +++ b/drivers/usb/gadget/udc/omap_udc.c
> @@ -2558,7 +2558,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
>  
>  	/* set up driver data structures */
>  	BUG_ON(strlen(name) >= sizeof ep->name);
> -	strlcpy(ep->name, name, sizeof ep->name);
> +	strscpy(ep->name, name, sizeof(ep->name));
>  	INIT_LIST_HEAD(&ep->queue);
>  	INIT_LIST_HEAD(&ep->iso);
>  	ep->bEndpointAddress = addr;
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 04c4e3fed094..87035ac09834 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -547,7 +547,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  		hub->boost_up = USB251XB_DEF_BOOST_UP;
>  
>  	cproperty_char = of_get_property(np, "manufacturer", NULL);
> -	strlcpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
> +	strscpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
>  		sizeof(str));
>  	hub->manufacturer_len = strlen(str) & 0xFF;
>  	memset(hub->manufacturer, 0, USB251XB_STRING_BUFSIZE);
> @@ -557,7 +557,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  			      USB251XB_STRING_BUFSIZE);
>  
>  	cproperty_char = of_get_property(np, "product", NULL);
> -	strlcpy(str, cproperty_char ? : data->product_str, sizeof(str));
> +	strscpy(str, cproperty_char ? : data->product_str, sizeof(str));
>  	hub->product_len = strlen(str) & 0xFF;
>  	memset(hub->product, 0, USB251XB_STRING_BUFSIZE);
>  	len = min_t(size_t, USB251XB_STRING_BUFSIZE / 2, strlen(str));
> @@ -566,7 +566,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  			      USB251XB_STRING_BUFSIZE);
>  
>  	cproperty_char = of_get_property(np, "serial", NULL);
> -	strlcpy(str, cproperty_char ? : USB251XB_DEF_SERIAL_STRING,
> +	strscpy(str, cproperty_char ? : USB251XB_DEF_SERIAL_STRING,
>  		sizeof(str));
>  	hub->serial_len = strlen(str) & 0xFF;
>  	memset(hub->serial, 0, USB251XB_STRING_BUFSIZE);
> diff --git a/drivers/usb/storage/onetouch.c b/drivers/usb/storage/onetouch.c
> index 1db2eefeea22..01f3c2779ccf 100644
> --- a/drivers/usb/storage/onetouch.c
> +++ b/drivers/usb/storage/onetouch.c
> @@ -201,7 +201,7 @@ static int onetouch_connect_input(struct us_data *ss)
>  	onetouch->dev = input_dev;
>  
>  	if (udev->manufacturer)
> -		strlcpy(onetouch->name, udev->manufacturer,
> +		strscpy(onetouch->name, udev->manufacturer,
>  			sizeof(onetouch->name));
>  	if (udev->product) {
>  		if (udev->manufacturer)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 96c55eaf3f80..ab89c014606e 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -151,7 +151,7 @@ static void _fusb302_log(struct fusb302_chip *chip, const char *fmt,
>  
>  	if (fusb302_log_full(chip)) {
>  		chip->logbuffer_head = max(chip->logbuffer_head - 1, 0);
> -		strlcpy(tmpbuffer, "overflow", sizeof(tmpbuffer));
> +		strscpy(tmpbuffer, "overflow", sizeof(tmpbuffer));
>  	}
>  
>  	if (chip->logbuffer_head < 0 ||
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 77a5b3f8736a..e8c3131a8543 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -100,7 +100,7 @@ static int add_match_busid(char *busid)
>  	for (i = 0; i < MAX_BUSID; i++) {
>  		spin_lock(&busid_table[i].busid_lock);
>  		if (!busid_table[i].name[0]) {
> -			strlcpy(busid_table[i].name, busid, BUSID_SIZE);
> +			strscpy(busid_table[i].name, busid, BUSID_SIZE);
>  			if ((busid_table[i].status != STUB_BUSID_ALLOC) &&
>  			    (busid_table[i].status != STUB_BUSID_REMOV))
>  				busid_table[i].status = STUB_BUSID_ADDED;
> -- 
> 2.35.1
> 
