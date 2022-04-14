Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A510B500C38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiDNLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiDNLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:36:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A186E03
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:34:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23E8XwoV014133;
        Thu, 14 Apr 2022 11:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=thEnqAB1ERYQ04Dbe0pOcXboI43zl+5yjATnnei4+4Y=;
 b=DW/0kKT2zfti9NvgBm91uGM+74XxqxZQpHMt+lI7ny6BRwhw1lp1mNUuhBftTG0RYU6y
 zvt/XMXVuo8vioQCBUQOEM4N3AyjyBNVXh31J90DlUwOiOQI/MukDZw58AmOEqNq2s1X
 LUt8Y8kzzHumBeizwb9MmCcrzWIYPHCIxh3UUkdXXIR8RjJyQPU0DtllxjWGtJzCkcUo
 N0sBHdeBkPEC3ONbPLvEibmXZCGIo7RxjbD4Adkfqs0yF5mKWMhzqD2yVVy95/dDOECI
 6dyvnbqx8BE0pj3YBIRf/wjAYcPmZS3ErgtohQmaYhfreXQiU9cPleQzKH/+nYwt1xsm nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu4s87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 11:33:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EBFqAk026495;
        Thu, 14 Apr 2022 11:33:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k55gn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 11:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWy/7dYbcFeTzByRdl2YlgpUTitAenzomWZtkJMiIESDGVUnDVXZcSz/JlF5KzwtYh9HdD0tLKeYSmZq2jGeEQ7ogP7uPf7mZqbdhdIzTvslC1bsPzJBwEwk1qZiFG0/qztSg9Y7tfFz0DUSKQbQmoyHdSQ1LOANM6pDmkPBQ1K3fPlTYV/tmeHd2Q/d+sOsCRKdy/mSnqom8r4AmMB8Y002I4ZMBhuvjrhZqDYOevgmO9kMHPaOZadp9QVE1Y75hhiskPvW0mdRgqOReBofinxOpqCMW9sjIiB5uKygiNWKs4yZeOLXayHIkfO8Nb/ZFI+1dp9CPqsNuIG/X7pDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thEnqAB1ERYQ04Dbe0pOcXboI43zl+5yjATnnei4+4Y=;
 b=gyY/vxVUH+MCOYZ8xue3jIdhYIOZ8Xv6LNEUfmxSobnRi19OXYDQ0CQOgJXznIxeuprPrHENyP6s5Fq9tLR0RYfi52yeRYZLLQEJ70Xt/Dnk2GBDqfz0/1cX8BT4aTZwuv32SZJVORfTTVN2ZWsEW05NOtunS1u0qLWAexyN4PPDNkQUSLCdfaNEEerbQvnaaqOcC09xCO4JOppkBDjBBcDuShB6PKz/XAP2QvdQrtrmgEhU1ZK8QdjlA3ykqvuKFWtK3Fk1YtG6fKe+lK6PgTDDiAv5/vOGSkzMvhc6JUdGPvO0gCkMH/YUN/NcGpgFFR6XfROVmSNgirgDae5SYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thEnqAB1ERYQ04Dbe0pOcXboI43zl+5yjATnnei4+4Y=;
 b=W2ZrFJjB++a3rYgUWD7go6RjhBQZOAa2jkGyLWN0oKGE3imlrsW9MR+GtUXTSQ5mAv+IvcYQZ+0Ta2C0+CPpyS+zuDzkpngSh6vDyYzD3XwldtJxes4FpQ3neaX8a4IzjWVWiA5n0U63/mhA+9KKfY8MPKuRZacHLDq+5eTe+3g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5010.namprd10.prod.outlook.com
 (2603:10b6:208:30d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 11:33:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 14 Apr 2022
 11:33:33 +0000
Date:   Thu, 14 Apr 2022 14:33:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192u: Fix signedness bug in
 ieee80211_check_auth_response()
Message-ID: <20220414113322.GJ3293@kadam>
References: <1649932332-13305-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649932332-13305-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0112.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de4b71f-571e-41e3-dc31-08da1e0a9b67
X-MS-TrafficTypeDiagnostic: BLAPR10MB5010:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5010DC7FEF734FBD94BA87EB8EEF9@BLAPR10MB5010.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rt7/j6RmxdyhDsBUI4eb5O48eh1yRRKBc2QSLEyYh7+hSAaV5NP7QTlD2HFNr++DPgeUbk2gPUiegt8lc548rqQWGxZzpDQacDxmKm5pZo4cqKU9yawqMyBxwhuu4kF121Ji6XxW/tit7wAYEafVH/wrsBfk+KfAH29a3XPGGVrjm0q8lfawYt6SihXykscmvfJPyDJs48+ayd5yReewoCtFyOdfm070x5ykMiJCV1joikkmmMiKdj0gCf8Ocy3+tWnrjd7gDIwbk/yRTFINQuc3pnyCtBXRL79zfw2QuK7oQGF5dhKrIBSgwEMJrjyyBQuzIsfI0UFwY8P1Db1Lve9pb2Cxr839VcJevWRpEjfsNxoI9KrKP5UNXajkGqtQtW3Z857MfbX8wRt4xa5KGwsxAgki7qP/HqycMhB2Dm4IxURDabwgvur/lVKncHaiuxsbSXJKTNphks2GzyUjhJOgCP3FpoBovKX+ZbUT9wS3e8eZBnYVK4Qk/7sRgwSW2qAGUQI17/0FVoOFp8mkl4tlg6O3c4QqwX3c3yD1yTi/FS4n786DrBkag4OKifa7IunY2T/VuA6XGKhrIZfZrxguU7S1iuUZYJHXbkMuWGHGEGqRNuj0cIze6Pj01si75ry7EfJDmGRFEcwfH6eOz2fP9Ia9/0A0QEeXqqfQetNoGANAUzgdF+TBKl9EL/5vG4+laPTe7BbVIgVKm69iOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(6666004)(9686003)(26005)(6512007)(38350700002)(6506007)(38100700002)(4326008)(2906002)(86362001)(33656002)(66556008)(66946007)(66476007)(508600001)(6486002)(8676002)(44832011)(83380400001)(6916009)(316002)(5660300002)(8936002)(33716001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXFueZO0xfnB+7iR5SX8Y2Id0J2Ww1y3ZWYYghxQfmqCwkOsRYU6ADF0tv5Q?=
 =?us-ascii?Q?dAkFP4egf44csvWhppEprbx3S6ETplDreF3Y0F5dU2cQod8ovFQwi6ZNoe+4?=
 =?us-ascii?Q?i8BxdRaEESELVquuMs6mjEpbJTjIzWNmqTdh579mSUXPzOVvAY4ahF58gqqp?=
 =?us-ascii?Q?MzdSc1R2DnD4xZJZgMufC1NRTwHnDlt3wqdjCEcoGpfYUMIhtyc9pfiurUQG?=
 =?us-ascii?Q?1S4L5gTUpAcuagaB+nUcqCri9w4ZtZevtx5C7rQL71mc4s+I3Bx9Wnc3jHwN?=
 =?us-ascii?Q?dfMMMz8jeoh5wn0giuIzKn+nyIpehHZlRyTGVCXlpNG757nqmiyXXp6NnW6S?=
 =?us-ascii?Q?Ery84LkDF4TByUE7mmELj4j+jkchOd0eiNjgTbFSrm0+0j4eqBuUPgWBOMf9?=
 =?us-ascii?Q?f4B5nfDmS1rsAk1FuGF13Wotj/Gr0qwlnCBo80aFUD+BKT01GR9ClucKi5KA?=
 =?us-ascii?Q?xXvuH7mWbWILSdBm1ye3t5A+PK69l6cv1NeuIh5h7SBlNh9QjxxgwK4paevW?=
 =?us-ascii?Q?MrC4Z89KK/CcwqiPm/VTzb5Svdd6tuqCWeDsOkzRgBUV/LspiH9VvqGQd8+J?=
 =?us-ascii?Q?CU0ac3DYdSlZluAb4l51C7QLFBjrAGmGYMA/ibuX4PakBf1ZAlLje+pBFSHf?=
 =?us-ascii?Q?h2Ugu5KT2JVaPD1+9d+7n/3piH3tKTtl/iXaufOnk2OLYV4b6yI5fVpci4Mw?=
 =?us-ascii?Q?0Bw8SE/X2UVT75xXoNcB6zy0uyXDl3PTu8q1NCw9k+9lqAcdkUVe7O30NCko?=
 =?us-ascii?Q?erYymWs9de4Db8EQTh5QYym+E+0G21BRm/35470V/htoQJFVMB1a5GTmlC/a?=
 =?us-ascii?Q?QXYLo1E3nN4Wd+VDILyT6smWArDEYi7cW1k+eZkHSWanX5eJ4GsSjoHSDDUe?=
 =?us-ascii?Q?jjo3v6IPLTfXEyalTEBfu3yo2+JjF4/IWg9KLmdoxxbBnQwedJYtsIpXDhPl?=
 =?us-ascii?Q?YKWiXiKbDwN6LGIoMOH/aLGPcl7XR+yeZwZyvV4smYV86Yrx/EPHWyiF7LXG?=
 =?us-ascii?Q?VCPvlTE8SDDkU1kV/fjPxWdL8K2nN3+HWUpDfruvSj92e79KBXw6p8snz1ot?=
 =?us-ascii?Q?V65LzvYS95AdtT2uiAq0jxUcSrv9svdSb4Ew+kFWl0msGMOKan7xukaP7nK2?=
 =?us-ascii?Q?wy8DSDDWyzhMr2D06NlPcU/+BbMcamapI1TClbz7z+9/J4Wb9Q1wZRkMT4cy?=
 =?us-ascii?Q?N5mSXKfRDVYMACXaM5ryicLNBCnFoCJxtWwqNN8Ccd0+ttTRxakRrl5zGtm/?=
 =?us-ascii?Q?UYsxZRUbEHJejZncDs7cU8Ag/3hbFgYKEYnjGiNHyAcAAHdepDkYnz89EOO6?=
 =?us-ascii?Q?0dPQvdq2iBkWgz+UUxeLApPNLwZ9OXgKQ/p20ovvAojNzcZwVdkGjzBhwzPV?=
 =?us-ascii?Q?l8rJlEFmSZ6pkbkpBpdg0xICxAZFFSv7KanAuOKr9eoyINJLw6kcTpjeXFU9?=
 =?us-ascii?Q?n7FAiOTEoPjDqsQ3iAEXUw2ErIrryEKdoy1UvNbHICvaGYau1YyEnvbFK4fs?=
 =?us-ascii?Q?SijzUkLGuSVFUvI/B7rGFwgWru7SNGgwFeXCIZWzc/NDz7AL9GHhEkMsI7eh?=
 =?us-ascii?Q?8h/vSVlP9LencMkAPrZy2ULeLgVwNbvymxDvp1KrwRQ/PagtrlS0MDBdP5eK?=
 =?us-ascii?Q?w9RWTI+1WMv6PeH4FnZZ7ocuLueJv6Dl3Ygd3i4FNr6LCokAYHEQH93ZYnZU?=
 =?us-ascii?Q?MWdO6F8fhr8RL6Nw/SJ6PxJ6StrBx4GhpVP6QLUzOkNSEap9c3X9d2Bw+WXZ?=
 =?us-ascii?Q?RD1sV0LM/XfB29ZfC/Xp9zMVAg6ykkA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de4b71f-571e-41e3-dc31-08da1e0a9b67
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 11:33:33.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6Cwz4VeGpv39plxWX1VV+BULOdc073cdKXxyqohnDuzXbDPJBT+w+ygNaJchnlISFka58UhM3zypjsoAvW7eEUAoLKC6pTFwdlBuwQ6OCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_03:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140062
X-Proofpoint-ORIG-GUID: ptctsPiasMGPOz8nL12IjyyO0IwxJzGk
X-Proofpoint-GUID: ptctsPiasMGPOz8nL12IjyyO0IwxJzGk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 06:32:12PM +0800, Haowen Bai wrote:
> function ieee80211_check_auth_response () unsigned errcode receive auth_parse()'s
> errcode -ENOMEM.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index 1a43979939a8..4d060c3ec077 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -1461,7 +1461,7 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
>  	spin_unlock_irqrestore(&ieee->lock, flags);
>  }
>  
> -static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
> +static inline s16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
>  {
>  	struct ieee80211_authentication *a;
>  	u8 *t;


The auth_parse() function returns 0xcafe on error or else it returns
-ENOMEM or it returns WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG (13).  It
returns zero on success.  It's a bit silly to return all these random
things.  It should only return normal kernel error codes.

If we want we could make it print its own error message:

	if (a->status) {
		netdev_info(dev, "Authentication response status code 0x%x",
			    le16_to_cpu(a->status))
		return -EINVAL;
	}

	return 0;

Then delete the printk in the caller or modify it to print an %d instead
of the error code in hex.

regards,
dan carpenter
