Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA2502581
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiDOGWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350433AbiDOGWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:22:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E076550
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:19:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23ENWotR018415;
        Fri, 15 Apr 2022 06:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1uMPAOzpu1y5gnih3TqFZ3zxuSNFA8udKZDhQeR48ew=;
 b=tlnqeh/81uytxyf4Igl5PeYj9FyboHuX5dCoblZPBwdANVLdmLnV+bjkszX1+0kQlsB2
 cpzgsLWy43/Mms2IQebs2h55j4NFdie4mz1dWy2K5G6CMNaEbBXoGVJ+ju5eaePLzq02
 krgwqjrWnGwn2lypRw4rVw1p5oFpUQsoq1tFc22yL/HYKYlfUz22S89G19Ej/CIjop8e
 2ug7d3iGXY/QzhsfkvX6nlmLVVUS8wPAhQDTMQ2d32KmpYy57+svCRBSREhbyKAsCiPw
 1owsH2n60N0R51tMwDynZHN/pDb7QZLm9BkFEl0uCpTadDBaK+jC+J3T6TQXd1aQF2hg iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1pn18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:19:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F6BQIm022936;
        Fri, 15 Apr 2022 06:19:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k5fp2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs5WHkty9fzd9D6GONFR1lSwzheJqvslG70VYmFWxvhoGhLXFQS2c095dFWj06L89+bE2wTit0m+sOdnZVSA8yoAoksHEjxqSNJc8oM7WXRXh2ct3pi6x4KAA5HBO1xS2dynvpBRPzadendpDMhlaasORaHFgx/Vr8ps4lf+dFPrOoWL8eZ9xtCHymk6SzH6Mh1oifUKAtyTMZAcgLbvzEmnpLxoioXanm1+uEMmfoOyzrOCuYMZ1JROaoheU1gG9aZJU7HjyZOUU+KaqzTXE00iw5F/+oU4vpjGvOFV/iCte984LUoOXtcPX87DxFr8DCHIKerpQyo6WjDt5OJwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uMPAOzpu1y5gnih3TqFZ3zxuSNFA8udKZDhQeR48ew=;
 b=GKLevTQVfQLSrC8WgaSJt3fOrwpXKzArwvteY9cKTWhV3QQzKsgbUs3M4AB2HZH7F/cxd2LKhXvmgYl0XNSpuW3oJ9XV8ewHMZQ0L6un8J2Kn1VVpCSh74r9FOxbV5L86XtHLooStCvDvd61aFB8AAVLYFdi4ER89m5TCmQperxRDqUdVTFuHbh1n+DpjFCigQAzEbDcNwR8/ijlpSt/BKHHncyipTkm6F08a2mHGa3dafaHSjZGsfuOiLC6FZzjo7UqLA4sNX7GioQFcuLtsUID97E4kLeTmGldvZT3udcE2CrlR0cWyQ9Vf2xZOAYu8llWBlBmEqc/Gq3rbeBEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uMPAOzpu1y5gnih3TqFZ3zxuSNFA8udKZDhQeR48ew=;
 b=Oh06xYNDquvlGsR8i9+Ekwyvr+P+dkMptd7YctIuK+NvK3KTVPXyFxmdTUWIEzbW7IFY0uA/WalbfMX9KmXtEhXDC5xYbAdbhOi5KtVwUGt4A2Am1HoSka12FfSBeqp07WGDMIAsrI/Fzu5UwEeXArRBAZ71XeZPj2AYsytvYpM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4896.namprd10.prod.outlook.com
 (2603:10b6:5:3a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 06:19:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 06:19:17 +0000
Date:   Fri, 15 Apr 2022 09:18:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220415061852.GO3293@kadam>
References: <20220415053116.GN3293@kadam>
 <1650001836-25956-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650001836-25956-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e88d17-50bb-4e2d-d80f-08da1ea7df13
X-MS-TrafficTypeDiagnostic: DS7PR10MB4896:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4896F2B82568219A0AF359CA8EEE9@DS7PR10MB4896.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiSvuAbHpVTo6ptbA4bZ3a+U6iysZRO/o8I/qRmdWGuTayHt4ROZRPkxLppILa7a6fgbPbl5vy1lxOi/q+E/Xlx7uhXlYSMx9zxwYL4V13nD0zxrD8wTZdj3RWR497Qghqo7KVtTAiHzaPh7KAdfT3YhSMwibbS7qTvhRU3yua+Ny1TGZ59SLmRmwHPTCKdg66TIepqD34fYdZ2mvCEiOuMa2TFFD6TorB7/p0lOADOWa4+69/ALeWwfAl7HPJ84pqVNWLqIHMUvYIKBAg7JjLvraITbx+8tTECCCbYo2VEv3T37CaIhx1LCRRFYxeDL907bvqaDX2bwMRREKXEbXhlMHFrEQQaB5IQ5VYIXznvCzoofQ0hPh08bzkZPMqc5UI0g3z1tEe/xrs1W0/i1IyctA+nLYQufX/7iJHA1Eqsqmc05aKM160gXAJ3uQxWu6s2+T7fLbc4kVVhu+fvConNVURKu6RVXEafDIZMJ7FdJj6AOdrC16wzOTX+xgZN17iYwwQjq2heEfPoCPjVVE2L2/gd+9hYZw6Zxt1aJxChfYXoPnLcOlXrgrCZ4Z3BmeHsLDlHoA/5o7jDLVEmtEBvxkqscj4Byi5/IynAEqyurSE0ihELO2aOEJta6jvAyFnPEqHQVxTlf+oj01Y/iyuERkQWuuLEs2hD0mugyv7gVuAKtkoVAY/CNJumdURFPS4n8qZgPrjUwbadPNosSjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(52116002)(1076003)(6666004)(186003)(44832011)(8676002)(4326008)(66946007)(66476007)(66556008)(9686003)(26005)(6486002)(86362001)(5660300002)(508600001)(6512007)(6506007)(33656002)(8936002)(33716001)(38100700002)(6916009)(316002)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qMv1Fqmw73e5AWX+xocwEkPzx+kKDvAvYqtY1O52sOE0O5J6B285zSQxWfIZ?=
 =?us-ascii?Q?Au0eKv7s24hekWga11zplFy+Psdop/FrM4fe+VqyRGIpT8L354MI0zygTpVF?=
 =?us-ascii?Q?2SW3F+8EV54vpRTEz6e36SfrUBry2N2bhXHGBCWSjXFHctP6rLjeFD5V1Ohc?=
 =?us-ascii?Q?3Fhals3sHM1I6FoIh1sz+c5kYMQZKaOWbq8e5rHTRjPhUDvTYza5GQ9OdRrx?=
 =?us-ascii?Q?KTDKXYkX8K33dMBKIRv8Sq1PDMKLyaNAuJZ4ySPC/fnoQG8ZmRGYq5yI3BcE?=
 =?us-ascii?Q?nCBfc3q5Q0/Hr9pLfM57CLhQJg9zoQpB83hHROiAJRWbBHnE4PoP/nybwesl?=
 =?us-ascii?Q?Ro63u9P6EinyVBo44RgGDlEvW2PI5WM5FWGDTowp3GolonX2FYmK2CRO8HJo?=
 =?us-ascii?Q?YCVKeqMzOc9X3KGQOXWkvoUeS2216sGaQKVkbRVPuYhyd8WziHPD8f9/XCFr?=
 =?us-ascii?Q?uHX0fLnNZ3+hphd+m09lLaNVUYnIKTSHpJ/taAo7pGctgSFnIKcyfIhp1chQ?=
 =?us-ascii?Q?wt559De6YWoazCHpJW49Uy1uqD7qwoTXWwpJ+z5jL7/jzZGIiHrXtoUWt3fY?=
 =?us-ascii?Q?gun0YF9P1eT26G0V8OG3O1l3YnR7ziFF0uGcE5HdYdEZTypsToV7rXKDqPGm?=
 =?us-ascii?Q?lQAiHnecLo9z5vuN+SIfF1InN3nCZmqeMeYsy2EI/w7jvI4O3u2dBpmJ02OD?=
 =?us-ascii?Q?ongSi5dPmvhi5apFZ5mBYPiSzE9aJ9igBggoWuMCO6s3GYDhgqMH4R3EbkAH?=
 =?us-ascii?Q?OhauwCIOxmb0pt1NQqPzVLjewhclKwCDkq4uruv5q6pdhsn6fipnZ2fQ4xoA?=
 =?us-ascii?Q?+QXECIWJYCgBHpxy6uWFjW9aa94MxFnYXivNWNSUEpII/CZQpTiEZQlME5vL?=
 =?us-ascii?Q?TacJKHBEeDr3cygbFoNlGd1wzWR+wJy/2AMJUUHmqi4InnHfgHJxSJNwAkw+?=
 =?us-ascii?Q?9xmlgVZfmjYCtDwN7PP8GH4bY4NiXMDN2PbsuxOOOqLjkQ0ULITJ+Rz50qbW?=
 =?us-ascii?Q?OutG/w5scnvajPy6vpxvW0xDKCPMoRWGP2tTlLg3GrLE97K6YCozKQCtixhM?=
 =?us-ascii?Q?7mAIzJ14x2G/SVQOgH1Y85x/YTHtsqmZEdtylmWh0uL4XNlwfihh8hOf8fsC?=
 =?us-ascii?Q?gIU0yYntySTZFLKJjet27OF97PjAgSpTUgz3cIUfkdsTWim/wQx9Y6KJqXws?=
 =?us-ascii?Q?RXjOdrgmnzGW3rF/3TtdwacvIoRzT8VnMopj9JfkPe2poxU+r1QNsKkyWCaN?=
 =?us-ascii?Q?qsrFQBxWTxoTdNW4W+q4vmsLEQ+4KBYzjdobcmoxJfrfnEMjlCbmKkiTM6FL?=
 =?us-ascii?Q?ZeYTN8vgPFFrxlW2TdihG5PqkN2iG1XUpn4bN8ScavS3BWIfWr1/WTCruDh4?=
 =?us-ascii?Q?E9LHQLecKCdtilUnWkSVTUpd/7wU+RevdYGnq05IJcad1M6G/Khy3jt5ndFF?=
 =?us-ascii?Q?Gy3qojZELmyhYgWLTtqC4WEDdjFU11OV5l653Q5Ub0fyKIEQs6jIZNHz3WQI?=
 =?us-ascii?Q?UDR0vWVb9SVPhlD/B0iM4+qHcb3lQkjISp8m1+BvygcUk+q8yv4ZBet+1uRt?=
 =?us-ascii?Q?BfVqmIAdutH3jLmPYDNi4T96Vnojnv6dmO15uhT60SwERx2x/9vK37HusnUn?=
 =?us-ascii?Q?1poNp7DYCDpAiQ+N1GbxbEPaaE0mTk5OOmQrcF5PW8CAxY5u+g/+Kbe0L4kd?=
 =?us-ascii?Q?j+gtXVsK958FVhzuMgQ5AR9Ke1vgz+cry3pvr913HIFQXXtt5v7CQ8gFSCuI?=
 =?us-ascii?Q?qzhXiBN8Pz3INmYjTcGdM//gPuxCRsY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e88d17-50bb-4e2d-d80f-08da1ea7df13
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:19:17.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR/Xt16Jkwffnwhcho1OjzaTuSEgL49qEcrbCVu0q6FFdc/N0D/DSUPBN/yQDjyV/7m8cellhhPyVY5h/qQHOZAMLf4co8rYzoKVgzGWyrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4896
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150038
X-Proofpoint-GUID: w09keAvkP5fTbJqUieZ2M6qEdBLrteOj
X-Proofpoint-ORIG-GUID: w09keAvkP5fTbJqUieZ2M6qEdBLrteOj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 01:50:36PM +0800, Haowen Bai wrote:
> The rtllib_rx_assoc_resp() function has a signedness bug because it's
> a declared as a u16 but it return -ENOMEM.  When you look at it more
> closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
> a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.
> 
> Clean it up to just return standard kernel error codes.  We can print
> out the a->status before returning a regular error code.  The printks
> in the caller need to be adjusted as well.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: reduce return random value; print its own error message.
> V2->V3: change commit message; change s16 -> int.
> 
>  drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> index 82bf05eb1cbf..4a1b9a94930f 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac.c
> @@ -1764,7 +1764,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
>  	spin_unlock_irqrestore(&ieee->lock, flags);
>  }
>  
> -static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
> +static inline int auth_parse(struct net_device *dev, struct sk_buff *skb,
>  			     u8 **challenge, int *chlen)
>  {
>  	struct rtllib_authentication *a;
> @@ -1773,7 +1773,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
>  	if (skb->len <  (sizeof(struct rtllib_authentication) -
>  	    sizeof(struct rtllib_info_element))) {
>  		netdev_dbg(dev, "invalid len in auth resp: %d\n", skb->len);
> -		return 0xcafe;
> +		return -EINVAL;
>  	}
>  	*challenge = NULL;
>  	a = (struct rtllib_authentication *) skb->data;
> @@ -1787,7 +1787,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
>  				return -ENOMEM;
>  		}
>  	}
> -	return le16_to_cpu(a->status);
> +	return a->status;

Please do not return a->status.  See my previous email.  You're sending
new versions too quickly.  Wait a day between new versions.

regards,
dan carpenter

