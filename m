Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBD55735F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiFWGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFWGyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:54:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043F3B003
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:54:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N6bhIr009474;
        Thu, 23 Jun 2022 06:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jyYObI7jAHbi7QG5ZNqf4wk18HNqgBp0/uei1k54ZNs=;
 b=LUPK6pcRbJbYIjEWM8eBRHYLukMov9gAo2NBug6CkmZH1SucDvdYP/H/j26w2x+OiwBN
 yU7HoKRahvPKm0esnQp0rFLNSNoDGsih2PPwedoa6vBW8AYIP9k+8COhK8YOSRDbVRfR
 FNGvsFDaMagnm/cvQVd4RsZ6mY7V54yVyTef83+dyiE9rS3QIUd6Qkf7cuxLtBmKYv7V
 0ofCBZl1q5Ap+4PO+xk8XG1ffBxZNxDWHhhwwwOneMu6fUCCsxL+v28daVFvQs6ccrp9
 u1IFSLfFdl8u0G0HPKFI6bJgBWYtoCzDmGnXDV5EeQ1EGr31mWnEK4lP1gw7NjzTnFe5 jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g22cp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 06:54:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25N6ktIf037996;
        Thu, 23 Jun 2022 06:54:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5ec27e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 06:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk9I3dP1EJKl99FW+Jhuu65AYv+v1BZYUaIKFdwuskw0m83AMTikJ64NZC1C5g8g7uOV+9oOWQMKEb0a9ZRFO1C1D2An8W/vR9oPSr4/WVN2eJISnuyvUNgSqcI611D+N9tMfUUF6CMyc1R/8WUHSllXeEwAzSw3JBfflup7d3ndX/TTjqVyeS4yhza44YDGY2of2sS+dw1vCbF83u77V0XlQv7bwxpknTj++I4pPS76Fw2yXWJAyzFKSRuWLeIxIJD1HCib+ICNG0+DBbCSz9ua9Jj+hAjosNFLCOCRHpOy2johT0Np92CGGfDOKbIeE75rVl8XB5a7qdgtSNWimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyYObI7jAHbi7QG5ZNqf4wk18HNqgBp0/uei1k54ZNs=;
 b=aauAljTy3x2PHW0QD0WJj77cisO6/S1zt7WQxuLATra8cX+FUssTA3oPXtJEOvop5WNSbIUnwhgyMLW9beye/AQ2bzbKnzf/mfwEWJLSn5aIRfJN1ClEksrz5mbdL10ASCaZ6/+oxQA5JYWlz+PmRxv2bT9vqwSLaCCVEC7D4ybnBjD4l82gorqj06U5zk3xw9pUuOg7CeQlpBo5ao04O6aJYN5qm1HyJ4PNkTR67bah1u296z6vU1UMWhDUwlookJxb2z2jsQywHLmP/I//GI7Y/6IYJWKN21ENfInOGwjwb04Wi/scpNMoKtonLBBpHi+GGcVC0yxwCLP4BJxAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyYObI7jAHbi7QG5ZNqf4wk18HNqgBp0/uei1k54ZNs=;
 b=eSbrtCY/4GfpemH7Cuz/ESaS4hZAfjrDgqlKhgnjkAo28o9oEcyz3VhMExGjHAtl5PAsnWHBuhk58PGQPVE7PSCNeoEJF9/5doRdzpEQc09pnLNGZ35kEbhWaP+uUvkaOOLuDIuPSn5YaaIWDjIt1ZZhOLWFk4E3pLGB++8JI9E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1734.namprd10.prod.outlook.com
 (2603:10b6:910:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Thu, 23 Jun
 2022 06:54:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 06:54:35 +0000
Date:   Thu, 23 Jun 2022 09:54:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Staging: rtl8192e: Cleaning up error handling
Message-ID: <20220623065416.GO16517@kadam>
References: <cover.1655909205.git.f3sch.git@outlook.com>
 <AM9P190MB1299C167B21A1FAA157AF1C7A5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB1299C167B21A1FAA157AF1C7A5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4160b23-8d58-4cee-3cb8-08da54e53bcc
X-MS-TrafficTypeDiagnostic: CY4PR10MB1734:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1734EC957E5E8A7E5C56944A8EB59@CY4PR10MB1734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywBf6iAZ32ZRc9B9YLVtDouHFVqQwkPiOLhJFj/exxbLy4P7nXsNwS9vXuMfRC/5kHvP2O6kaRmJoD8CgUVuEk5butP/4v+/x2/f7dMVFWBHchsjlbBxcPNS17WRiDHWUlobpqIcClhCn4fa7t67P8ufu9h38HZvfrgMTzinJaaYF8upIC57sJArrAPCKCrKyXi/4vKzShc8zaUfsbRD8omPsprz7rfqh9QswRnNLVVhF/WW4oLZfKotumyktkxEzPziuvTZZyC/8z+VK4KDoSbAJUCz3gsp7Y8Brl+04DKmOhSYChHCUUt1EP9ArZ9oZ1BHmKN6Iiu7X/V9facIJ/V8tecXxmUH4DG+KdXs9LPpV+jhOBQUb0Hj+u3GEpuc3XIC3VLFxynQiswRZY/5viRW6srBajXsC2kAtbv69F3aohksqvQLl9D4uSTicXCjTrkNzG4x+djp2wHB9UaxKz/GHtv+gAqzcyGznmpJj6vOSr7kLmwFkQ+j/QYWamtZZOHRxKs9LE9BEs5uBtl9XXlHHbXjCmSy7BLAgoh5oHjDTAYnWt74XDC+izk+Rq4K9PVlH9ivD50CopVD6O1gzkZK5k3uIL6k6ZQe2r3vy+eZXYn99k7/G+6AI2vhPE7moZFM4iuc5M6gW5WYL46t/EUroGl8rC7hIujOntAUvo4FUa531judtKOyP2VtsSVffRNx+Lkak/g2LxWmaMwAP+zzn32u43uJMCfQDEGRFLyKdSL8zgTn+EpD15C+bDOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(33716001)(4326008)(5660300002)(44832011)(9686003)(316002)(2906002)(8676002)(45080400002)(8936002)(83380400001)(6486002)(66476007)(66556008)(33656002)(1076003)(6512007)(41300700001)(186003)(38100700002)(66946007)(6916009)(38350700002)(26005)(478600001)(52116002)(86362001)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BbywtCUuNevpm2ESbJ1uhK7t4ao1NBttpg5FQLHZJa0OhKYfvK2ZmjzKDaL1WrUvlbKGBQkEPnDEcm6IzWxeXJW47RPnqzLCdmRILWW+JIVOT6lz1aY0k47WendRR7NeYg8sVGZAImtLJZB2AXwaiykV/bLMKiHGxIGDBICsEOgRWRjI2c34DEo0iuPIOhEH37conp6ZRCELzhmORCF3mrwJsquEAC0tTxdWahC5oJWK77hP9qTf+xNvmw9wdNMizOTVN/fnfTi6VTTHu5X2rUySPS7T8mT7NoFglzExbGXxJj5cBHkHs8OUV4uqXCur5gejea8G0JaeXOknlWiOM/hgfCO+9P2z6ddH9fYFfBzmxXiyBBb7EpMI8+v9OR3veMEfSPM7ktbL5cQGsVbqUsBC6idyGHLBOSoQnkLmfdeNl245sSoh5YCtSqk8QBpa4pnwVdIWo1QGqh5j3OAWMAIeyq8H2mWlojJuLXmQeqdGy+J0NWpDqaW+hgV9cncILzrPpmXBC3e5oVgVJwJjYASVyMhr7C2z3vbSVf2uci2eWj8CP0PHDW87HujgCZqwfBUjtVG8h5c/r3STRCZXfJGS3YKbm/oBueau/JshyAviUYXS5hvp9H1ng7uL43xbteGQkCdVPVlu6S7/wsTdRtCpb4dvRBTE5tnPwtggTLwL243eD2TA4vJglZKv3wKFQncHSoJMWFyoVjHtXFM2Jdz3r/Nr25dwnhqhUP2APTv2f7Jh4jWEq++3zqbVXFKh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4160b23-8d58-4cee-3cb8-08da54e53bcc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 06:54:35.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yidp1Kmv6QLG65nDdOPlbr4NwCuWaz+JvTZ8YqwM8OZ36z+Afo8UNch/mpfqUjygPy/nxmfPkEEujxyUQT7GdQsQl7Z0ez1Z13lPQJ5E9kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_03:2022-06-22,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206230025
X-Proofpoint-GUID: MRyYqH6DJI4khLgz3UwVtvNxckONZdRt
X-Proofpoint-ORIG-GUID: MRyYqH6DJI4khLgz3UwVtvNxckONZdRt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:12:46PM +0200, Felix Schlepper wrote:
> This error handling is more readable and reduces code size.

There isn't a reduction in code size.

> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>  drivers/staging/rtl8192e/rtllib_tx.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index 1307cf55741a..b246f5e0cad7 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -214,19 +214,18 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
>  
>  	for (i = 0; i < nr_frags; i++) {
>  		txb->fragments[i] = dev_alloc_skb(txb_size);
> -		if (unlikely(!txb->fragments[i])) {
> -			i--;
> -			break;
> -		}
> +		if (unlikely(!txb->fragments[i]))
> +			goto err_free;
>  		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
>  	}
> -	if (unlikely(i != nr_frags)) {
> -		while (i >= 0)
> -			dev_kfree_skb_any(txb->fragments[i--]);
> -		kfree(txb);
> -		return NULL;
> -	}
> +
>  	return txb;
> +
> +err_free:
> +	while (--i >= 0)
> +		dev_kfree_skb_any(txb->fragments[i]);

There needs to be a kfree(txb);

regards,
dan carpenter


> +
> +	return NULL;
>  }
>  

