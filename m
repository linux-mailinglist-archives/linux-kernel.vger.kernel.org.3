Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88350184C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbiDNQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353047AbiDNP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC36986CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:43:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EE9vY0008887;
        Thu, 14 Apr 2022 15:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8sU0cSnvnGlMopNkbgoOGdXRqsesWtsx4/a5tPWCqfA=;
 b=pJ79+D+SwurO4JXQUW1IzwnQuazyX91OB8X5zHTdrCGaMT+gXlwyhQhxGEHOtyTl6hb8
 24ELzn/1wJ9uD92TCNH8bEwNORX60xAfdYVxFo16zpVdWYHQOyvLCyJ7pls/MfhDQkC2
 iRJIh5imeaZJaH3e4909IhNppK10ziNswe9GPlIC5O1OEB4jzsuHhB1WmcbJ5GtVDzcO
 gAXhnAr7DRrdO6uY55u7MDbdtFSJsUIiKczwQW5ZMpxQ3T2zqAkgGJ5SSb8Egherl+DX
 Qp567nMDA9s4cMrsr+EFzH/O075q7Dl4jCjLKwkTnbKsfgSCoCYmO5kW7xl1Y84t47Ou gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2n6n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:43:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EFhNp8035963;
        Thu, 14 Apr 2022 15:43:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck1537x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hil82B1R9nU9u1WSTflFY0AVLdIxn1bC/mgiPolTS5HHMq4I+fJi1f5fpU+ZqkYcd5Ck4moD8EFRPb+p+r69Y5BNDzJ25104ZY4ihFJaYu/VAgkujDSKWcBz6XVKZsqgx6svGi9UmPgI8AZ8dZaHuVUdRY+NU0rs++tNz3a7+tn0kk6syjIxc6rtes2EF+LlzPDhMDFEzCvORxaBO1Oa+o6xexQ6QqthkPYCXdm1okijqrTjYPNayv/hH0Svj0+a74Frv8faHNIeUiO4aL0iIJ5o3JjZyMmIQj4XuY9VjkqGRnaEb9R8mxGstvb9Kl8xdoWfwGdLNR1gIlkURASs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sU0cSnvnGlMopNkbgoOGdXRqsesWtsx4/a5tPWCqfA=;
 b=Fx6QHBd/KXGRhpESMpLdUo2DSdMxrZ2Cukcy3LuVDaHYjK1R7OU0V9T2We4mb7XyDnchC0Yj+Lx2yzLN77W7EGvQlzcRm52TM95WUQROfZZsH8IrVizsjH192x3n/og0PlmlCqR9pB4wIaxI5YUHh7Ysw9rPKTSsQqFMOn1VUq4lcgARPDHCU0KXVVLE0m66BHhgYZH9FsgUuALfCRex5ezEhdT8jJ08jN6X4b6XiAon7EtMBQBaYJYs5p4xYkyuHf3FPp+whUBlsKRaPL8tLRDx/Okx8e8OO6VAteQJDr/rrlWpEvAQcOdh9mXETQwX5SbfPcF89IjsoBjTcQZfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sU0cSnvnGlMopNkbgoOGdXRqsesWtsx4/a5tPWCqfA=;
 b=l/eZfKMm32eKzBZh/CBlxQbc7naNsLQgsmqj6DbLkH0mttRHGUXer/A1lPd72oas0j5YnlAaRo5IwUJ3jOMzly4icTC76SeLfUBUi6a6W3WoJH/KzeDz10ljFFAdJcGqfJTVhl/QoDd0s787I7+BUL3+B3icsj+6UMxy3NhB/OU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2634.namprd10.prod.outlook.com
 (2603:10b6:5:ab::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 15:42:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 14 Apr 2022
 15:42:27 +0000
Date:   Thu, 14 Apr 2022 18:42:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220414154215.GL3293@kadam>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44f6ff51-aac4-4ef2-6fd8-08da1e2d5ff2
X-MS-TrafficTypeDiagnostic: DM6PR10MB2634:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2634D0B081F6D197823FE1FD8EEF9@DM6PR10MB2634.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1EpW6sQe9PpYz9pmP4tlt5tQy3cTE1aPE+24Bt/NFE6FR9CokUIPggfWoLTrZH+hV7tiy0MahEbrFUjHQIZwr1KnSXyDLWd5RRiuwRKF0sjs4MdKh4OlCzO0mWnrfjdX1szOqCB8lB9oT3YqHoMS+7hWgyL2wtk8mjmKPbW+S9E/WrjiL/qS1tZxIRtTgYKmbVArbtajRKm4BaOE1xfTTvvMwIsVPtx66klTtM9wLqCuOfGbG748zbjfhcd3bDKrBYrcGklZ1fNxk5etrqx4uf01O+AFuwwkjxq5Grke9n6rYPLA8+hv8/IaF8K/UMmGQlghqq2wF2Qa1XripbyU4rnkco2P7Fje8PbPlA8tzjBJShAfXjOKcsbjMPWsVq2UldOq3ZMCk8pTw9/itJa0eWX5btRPFpb86nk5qadqINdc/dBxZGDc7X9S0slbXgdMvHA59bH6XABKEIXyETC5MeCOcUf4KI2L8E0CjJqQnDcJ++V20RGpqIYQXIVCsuunARdTWmDGpLmBLVDewIcBLZNPDUrWBZ0VNtLhkL9kc2Acf6300RNy3IFHToVb33WBqYe23g47Ac4omG4ZKG3zPQNljKEcZqDJiXy/RiwAyst8djKwVSTmtm5zKy0dUcJQZ4EuLFd0kXUhWNiDOPUvVIa/I3Iv0fRf/LozWBnkd3FhDRZhHYc3bePTwSDijwNagYNuoCp0iuaNbTTy3oy9qirzeYUOiu0GbWfO3Wyqy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(66946007)(186003)(44832011)(6666004)(86362001)(6916009)(2906002)(26005)(5660300002)(38100700002)(38350700002)(316002)(508600001)(83380400001)(8936002)(33716001)(6512007)(52116002)(4326008)(8676002)(9686003)(6486002)(6506007)(1076003)(33656002)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7FHM830LAblW5Yilp3LrKKPor/Y/I17GR3Fp/RoVbDzYDxx8E5bGNko+9Sg?=
 =?us-ascii?Q?OLGzxW4yFvbr/vB3Ssnm4bYDGGD2d9h/WwNa7Lz/mujwysvrvjK1rQ8Ici11?=
 =?us-ascii?Q?9oZnfG9woVDIVXnaL+kZTn4tTXha+VAbhzi4IM5/ZJirbpTM8CMeoxfISH1d?=
 =?us-ascii?Q?/35S7lxG9SHKVn/evrcrhUIi0RkuGR1nMntQSKrMCG49EM/Q/RcQw4IHuLMF?=
 =?us-ascii?Q?LxnKkC2u7lsnloiGmPrt+iy/0uuyYUBjMgaeoln2kCPnP3r6J8pnTRArgLrt?=
 =?us-ascii?Q?katTyG23zDmLmX9aY7b0cuBTDnnCMTUWNvwp1EhdTW5AOp4JRh60Q6lfJc0t?=
 =?us-ascii?Q?SLGlS+7yqwMu5+8rNGnrBOaRxHVeKdOjn3nNcW4DLPKaANe4jEwUBMCfzG4T?=
 =?us-ascii?Q?cSnNueQCvuqQ9904mti78OTLHehSpI0HVfNeRo7Kwnc/Ttfz/sSxVu+Xd0Ry?=
 =?us-ascii?Q?KkyKa6o0FO3JvwSxoGe9Rnhor3PBaPKYoF0jQPWhDCq+muj8B5gQJcTn7r4/?=
 =?us-ascii?Q?Xfj5njBB6BOyyuldfnfHGUt9FRGehQV6CCe71StzEEWgBj/UsuAYyk3lRJjc?=
 =?us-ascii?Q?aXFPv5y3zcoj3lpqM3+4x1BNds1vzImaKPfohjA+A3vz1La2Lo7VrxAQ68lG?=
 =?us-ascii?Q?rd2N7SaHu+apsezEtA9vVlVD5sxk5jCaIGoPewR4KAEN3nM6EZYTAowaoIZT?=
 =?us-ascii?Q?Tpum4VahAyNGadz7r7GZ2xK6JS08KEYjUNyIPY/urR9Kgpgt+M9JtG9cNe4s?=
 =?us-ascii?Q?s3/hbH+wH5OFIqF28aSNiWondGMuXTbJCiyWNyovLP7eYPduRj27QrydUfBD?=
 =?us-ascii?Q?1zGzisoYbqqaZdy7sMKtPbD8KjYYHLc1VXu6aVUvFqrA7o6gSYInuH3B4qIS?=
 =?us-ascii?Q?SriNhRdsBuXVcOgx26MWLyrCZeIyxa07Ei0UusZs5juGYc3rzD54Ona9gaVA?=
 =?us-ascii?Q?KuTwQNW7A/pp8UlreBxq+nlrvsaYpvU99hFe6U02o/IkoO9762oiVheWZAmB?=
 =?us-ascii?Q?BsykOJGvYp1LgqBOl3CXrHfupNIvWBO+cJg/UMzdBSC7Anp6YUfPtX9TrkqT?=
 =?us-ascii?Q?FextcEfPOK/AHsqbRi3SOSUPaSGFcHdHZJXiffIOTF2AVLku6io5ggKCQjOU?=
 =?us-ascii?Q?p53eX761Ciq4BOipt8UcpLwL2n+vSNM7KxH3vuobybXTJaKZ3t3RDqkUS+mF?=
 =?us-ascii?Q?isqBK+Rr51GZGWE4M+1hbA+ke4srWmok7zmPYcf1lwrA8jFBWvcUitN/hQ4O?=
 =?us-ascii?Q?dCpq2E1+3S+yNG0IWnitI0lo/ll8M+Y61VZOEfNBQA7hsYXP0O54R8StSiGP?=
 =?us-ascii?Q?J49WmFgSpjxfBCBcsgqJpHSC2H8DQXzJI4cXK7WTMmNAG9Im79JfhNMv51nM?=
 =?us-ascii?Q?WMD57wDQvmmNTB3tsErKpZWuvPBTcAnAxOUTuMC3SDoLryQXL1VVdtVMJVrb?=
 =?us-ascii?Q?Fw6bXPcRQjDyXcoOzcNQtODrQJ6hKZaB7hQSQ5+zZbpsQH3WL/nXmWyfMXmv?=
 =?us-ascii?Q?ajrJlWwYIABUKs4MVkbNh0OEilyQMBApUOdAFaNeNrk5JmFSoDlYllh8Hv6/?=
 =?us-ascii?Q?yMXXQiem6VucYFghXIUT7/dwfOqnmosCPPgzpi01wPqfoua2hiSdty/DU2mC?=
 =?us-ascii?Q?K77D3ivAiapCFcxeYHKV8XvRba/4jcWgAa7caU23xHJLiKx1+x5K8TkOHQKd?=
 =?us-ascii?Q?fN26BimM4gga6VofiqVj0vRIE9Yb9vEGu4I5kgXnSCp0fG+gGo9YfxkBALW/?=
 =?us-ascii?Q?CPf8H4xPHM7ML1no9RLFvOTdoR8/bLw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f6ff51-aac4-4ef2-6fd8-08da1e2d5ff2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 15:42:27.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cRW/zJYFxF2slr/t/Lj+9sk1aidiYJPng7qZFGad0hV3lSCHoiKGveS14Ijoh5WviuyBM8ObT8LI3AdbHC7u33HEtVQoCUsfq84si8TyPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2634
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=931
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140084
X-Proofpoint-ORIG-GUID: sLVOFzBaA2h5UMIMX9OEOTX30lKYmQTQ
X-Proofpoint-GUID: sLVOFzBaA2h5UMIMX9OEOTX30lKYmQTQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:12:23PM +0800, Wang Cheng wrote:
> Due to the case that "requesttype == 0x01 && status <= 0"
> isn't handled in r8712_usbctrl_vendorreq(),
> "data" (drivers/staging/rtl8712/usb_ops.c:32)
> will be returned without initialization.
> 
> When "tmpU1b" (drivers/staging/rtl8712/usb_intf.c:395)
> is 0, mac[6] (usb_intf.c:394) won't be initialized,
> which leads to accessing uninit-value on usb_intf.c:541.

These line numbers are sort of useless because everyone is on a
different git hash.

> 
> Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> ---
>  drivers/staging/rtl8712/usb_intf.c      |  6 +++---
>  drivers/staging/rtl8712/usb_ops_linux.c | 14 ++++++++------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> index ee4c61f85a07..50dcd3ecb685 100644
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ b/drivers/staging/rtl8712/usb_intf.c
> @@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
>  		} else {
>  			AutoloadFail = false;
>  		}
> -		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
> +		if ((!AutoloadFail) ||
> +		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
>  		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
>  		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>  		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
>  		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
> -		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
> -		     (!AutoloadFail)) {
> +		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
>  			mac[0] = 0x00;
>  			mac[1] = 0xe0;
>  			mac[2] = 0x4c;

This is a separate fix from the rest of the patch.  Send it by itself.


> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> index f984a5ab2c6f..e321ca4453ca 100644
> --- a/drivers/staging/rtl8712/usb_ops_linux.c
> +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> @@ -495,12 +495,14 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
>  	}
>  	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
>  				 pIo_buf, len, 500);
> -	if (status > 0) {  /* Success this control transfer. */
> -		if (requesttype == 0x01) {
> -			/* For Control read transfer, we have to copy the read
> -			 * data from pIo_buf to pdata.
> -			 */
> -			memcpy(pdata, pIo_buf,  status);
> +	/* For Control read transfer, copy the read data from pIo_buf to pdata
> +	 * when control transfer success; otherwise init *pdata with 0.
> +	 */
> +	if (requesttype == 0x01) {
> +		if (status > 0)
> +			memcpy(pdata, pIo_buf, status);
> +		else
> +			*(u32 *)pdata = 0;
>  		}

This isn't really correct.  In many cases status is "len" is less than 4.
I'm slightly surprised that nothing complains about that as an
uninitialized access.  But then another problem is that "status" can be
less than "len".

A better fix instead of setting pdata to zero would be to add error
checking in the callers and then change this code to use
usb_control_msg_send/recv().  Probably just initialize "data" in the
callers as well.

regards,
dan carpenter

