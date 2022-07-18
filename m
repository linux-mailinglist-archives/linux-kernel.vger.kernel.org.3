Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDEE57812F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiGRLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiGRLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:47:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6DA21264
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:47:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB3wu3031661;
        Mon, 18 Jul 2022 11:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=54lkaxcJf43lzIeFF00ujreyUkjYxBkjzBPAq4zKh5U=;
 b=CtiZmKsBdZGMUJcrW8HsSBPKLSxy3X3UrwusL1IB6xjUgB/VnfQ8cDxveplgvuSkVYyc
 zE3SsQYHQzSvYJcoUELDZUs+ekGrVuHg14P6kI+fxf2rSWeyTE0O7UkLyxu0axW+hGbC
 t5D2rRVi2vDb87Owx/fowYhUhA0c9/RjwlagxOfoYOwVFttflKRRkyHYKYm7mPp7rvMQ
 zLky4UelaxJfLMaLkcYNCB4ubrOLxhx9y+k5PeNaaEB/WRZgwjiQwU8f8mFERkVYBbYA
 hVHR5fYJGt4gszotVq1IhIy6iC5yeybzlQI3HYVYwK/Qs0Wcc6c25eX4kEo/z8HhwYsp aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs305b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:47:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I802VL001666;
        Mon, 18 Jul 2022 11:47:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2dakv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoo2zeRr1taaeoUaRz7yRR4ATnAZ4U+xMBo8IrdVRK2CZ8U53wLEYxsUNGBmvR3h8ekB3GFSupAwJ2eY+kpb8cDIxI65xzCROmrY1OC3/Yx3nsQ7oLXQwkJ1AMrzFTZRM+31mGKPs4KENTUa1WYJDTZsS6SEFlcjtYZUwMfW9Y6+wPtDsJNnusvn9yD2PUwYuXxw+ur2/IE1yVkHtM8rdVf+ZdaseqLwYIpMf/kV4qC6u1QbsucPPo1BugPOm3nshxzprMiwO6DSolW6RMArMAeGO9jA2fVDC48TVj5YADty5Pxq2et1yvkoCUpVAb1JZNwflqxRNWA0J0XH4Kavww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54lkaxcJf43lzIeFF00ujreyUkjYxBkjzBPAq4zKh5U=;
 b=HoeLBZtb3S1huiP8Mq2eRL34m/icF4b0QUHFw6SwUGD/EFIifkDj7k7+YJqZCQhS/VBlBhU7aTuuk4leDSHRnZGtM+Uq1PYwtaIw/f768j6TpderVXndb3Ta3kzhFjs7//e7hWkmaoPC5fRh97lErGkLo/obVcQi9lBkfCCqvacSGrh+u2tLfF/oQ9+88lQXldX2+0IZnwIeY/Qsm4ggjqZbz/oS60WPvTEfQFaehbymlCEKRhAY3EZhzcyZxOLHd6LOceh4Eqm0GASkyzfin8qCltW/EhPWPgMoJkYLwyegVeotxWhq/g4FdnpDxfF64czl1mKl0s1SGDOHrLZR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54lkaxcJf43lzIeFF00ujreyUkjYxBkjzBPAq4zKh5U=;
 b=i7sLZeJ4XPKUhoXFjnJRgjHwRr6GZESTpnx2ldd7FShrqi+1QWVeI2+DgLJ4iSvcsn2sYTy0/LM2/rPmo6oJOKZLnUUHwMIg2j28lbz3XwvoVnphZgz64tm9YBbLjbGtwSJox28jg8fxWI0GlR51y2vEofdiIF+J5rT7V1iUymk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 11:47:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:47:23 +0000
Date:   Mon, 18 Jul 2022 14:47:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
Message-ID: <20220718114701.GC2338@kadam>
References: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
 <20220717070204.705878-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717070204.705878-1-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a6bfe32-ae8b-4d86-7982-08da68b34704
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOUl7ZDztMf67TBv6EnIxJdOISZqNwu2QzuWB524pQAAyErVzIGu/Z89djmSXmpojAGwpNkjiDunm4zQr6Jep1IWxRSElk0Iyq+f9KbzE71iaiRcLxgWtCVKCPLaukN+9TDrdvY8/K52vz8QTA9LGZzKmxnNxuhCvAgjHicOz9+XVDaRDIR+AkKuj0mGdhl3kKB5js2JrYHjZCb6OXqzIA81CUd6Hcff+0Hb4iqnjNlZGfgeTzyW33jsQlTDc7wLm2sFZmZAqW1EJUPnzxZKWPPGJSrfG2PoKi2bE7bHLlGySNB6GWS+/EcN1U+r2CW7cf+khQRbiFxKBjDExcB62NcsUuOQcpziUF1mg/6OyMFgmOO5z7owQS7GsixKKiy1YRoZr0QPobJi05i7BY9hWQcPmKGM3fEeQU3i0NIKR5K5HtP6qMmU2Rd7F5lHCt1U5L/R2Pgf4cJxVfMNBqXld84Q/oUw37uYhM9Y4GGhCIXYuUWfXSvs+UXEGUZdX0ofI3PqH0ibSmPbF+KwXFNIdNYWmd1P7qiKfkuWI6OOzVWdOXJLBPeDGtHVj9mOSRcFgo9e8m50ZcV37jlUlMMzE1528U/nxabhKizLTYKcTLY5k1Cxd7SHKAMQ1EslqZ7X3wmoxbVCuL3gltRWAznwALmhvdXEx0UegIH3UBJRSSmnmnvqH2aUJUYQWTLvmCGRkaI5j4WqjNcpZDlxhEDYNEjoNetgnm1PX0kO3NvrKoGmWwyLeZtaJi1ZeFJiq+ep6KKQLdxkCYbPcX3Nd1u2E90YWZw5VqAc46VBh9sg14IRYECyNbM+l+yDM97V05le
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(86362001)(9686003)(5660300002)(6512007)(1076003)(6486002)(41300700001)(6666004)(478600001)(4326008)(8936002)(52116002)(6506007)(2906002)(33656002)(26005)(44832011)(38350700002)(186003)(33716001)(66556008)(66476007)(6916009)(316002)(66946007)(8676002)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2glJ6/EjIqYB0ko83IGAj5j4pjNHtBuXI1UKnurRy8YBDi46Btkfz77KrSWC?=
 =?us-ascii?Q?ieSt5w2jRTFY2VYZqQ+luESC1xGjCGCOyEWVX/ybOEHrNodszlBlhDR1ZbgJ?=
 =?us-ascii?Q?gDEA+kpfH+CTdQFIf+hRAvi7K+52wNHfTB/0+6X4q0T9cbsZ8+mtk4Zo/24d?=
 =?us-ascii?Q?1cbMPU27kbR85X+v+kp8D+/o6Vj3IC9+YJYa+i+TCs/q/DeBpvWApajAJ++3?=
 =?us-ascii?Q?6rMtvlLbPdyFaqpTw+/lJe17/K0k2N/+AXo5qngXjB/rJEU/IjwcfIJoAxBo?=
 =?us-ascii?Q?bK06oTW6jskohmAOQesXx3qEgCWwdi7/1SYKxA55yPHrMn8ODbB/Bifw95ao?=
 =?us-ascii?Q?On7Jc71MINjT+iWniIGg2hOBwFFR/5jnONL4dn/eioZF5qPfLKec26IhgXEu?=
 =?us-ascii?Q?PHAtmvYkcFKb4gLTVFOPWu2MpH/detZ33jGB39FRaKhbce5L1qXtRzix+SXE?=
 =?us-ascii?Q?1ga6BiBwFMFRfQsTkVTw8ynvNkPFQDM8I/iL+2FrzvIAUezWe3lGje6Yp4Hl?=
 =?us-ascii?Q?GcQX1hQXy8B58CFMLed7KOUkkO9hzEwJ+eHABO2087zlqaXOvi9iHhcVYDRC?=
 =?us-ascii?Q?fdp/xVT/v7NWkq3ThRkvBCXuc9+Pa5W0g2911Rosl6mMCyI3au08bGe3FEK/?=
 =?us-ascii?Q?CyF242YSojMbBwa67vRFjTQ/VkcmOjY1toz0zMOQDHVPZ0/NVu6qpSdnfZ38?=
 =?us-ascii?Q?WMASJz673wfexppE37WlxX/hEBYLN83Oqz3Aw8YuK0Xx3dn7KUI+qlSe7wWO?=
 =?us-ascii?Q?qZwn/Qi7sppNFckcpMjfPqy7wCIemUFMynhDu8iAGCwQIwR8c4Ic+oFAT39n?=
 =?us-ascii?Q?QUBnQ61epOe9KjqCDlH8QsHJzm0HXunRhCB9Ztpi3B6rZnEYN+SRi+jUR/NM?=
 =?us-ascii?Q?JdIztHegB7b5rsBJOp+wmSdNCYSEu0Nbzy6GUR/WczYtTj1J2/yqaDtMZWYH?=
 =?us-ascii?Q?bRcpDbQgaLmotqNLcgJoQMYiYN+1lTeXqt2VIq0hdOPxbN50bMtFGzYhOwoh?=
 =?us-ascii?Q?kote+l3njD4IEorTL1Iqvg7qr3xXdodfwdtLBaRQibYkJhGoR8Ltu0p+teaw?=
 =?us-ascii?Q?RyjmT+763ai/poLZXZZvWV7QRedTeM7Cb5QX3JGmCh+lOiYw0Ax3vfahq074?=
 =?us-ascii?Q?2WMIjhwM+AAnCHrCWeXbKgP0LqhQtMXPKUAkvOZyqdSOOCMcSM+r2FNCYGSQ?=
 =?us-ascii?Q?aR1oTbj63IUboZ7M3wYkU/QXiWYphkHxBEDZZDXguXQ+AzjWfOIbt0a9pP0u?=
 =?us-ascii?Q?ZpSZLd9ByhMXtRvVo4vB7EH5lvUVNkzVGq3Z/W6Xugs9MDyytY/hAWI4BPPR?=
 =?us-ascii?Q?fDPjskCFc4OsYphQ/2wvIp21afjkq5wvvU1uyLeuHHD3sUxR1/Q53U2CBXam?=
 =?us-ascii?Q?A8LTsNc6jk/Q+uniOtqnsMWpBPlgWboARJqRURsABK+lVFq3BoZm3B/GFAsK?=
 =?us-ascii?Q?sUuDeOyELFzzmBWLA3zhIjEkl0Y7sRw/dpdlxv1hdFbFAVj9gYs2usHpRlsX?=
 =?us-ascii?Q?TM5LIaRaU4zf82miqOCoYGE0PllgyypPjOFJVEwYEvlMvc8NQVXkxXzXDpxP?=
 =?us-ascii?Q?GICvR7lZM7hV658zonJrw/eothq0R6JxBhnI1z3AtsUlk2H8tj7BQIC8/ttu?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6bfe32-ae8b-4d86-7982-08da68b34704
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:47:23.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VUfZN1eNp38NtRFccgobqGTU/k+b6pa41zTFNoBU8zxFvyZbxvRYTN9OZwJZ4F0ACJvl9U+N1EqkASpc+28mLjNSRrMkhLZLWlUfyfyYXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180050
X-Proofpoint-GUID: fFntxaqZ4Ud7FnZUe3iUH9_2lhzuN0_u
X-Proofpoint-ORIG-GUID: fFntxaqZ4Ud7FnZUe3iUH9_2lhzuN0_u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 12:01:57AM -0700, Tong Zhang wrote:
> -static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
> -{
> -	struct net_device *dev = m->private;
> -	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> -
> -	seq_printf(m,
> -		   "RX packets: %lu\n"
> -		   "RX urb status error: %lu\n"
> -		   "RX invalid urb error: %lu\n",
> -		   priv->stats.rxoktotal,
> -		   priv->stats.rxstaterr,
> -		   priv->stats.rxurberr);
> -
> -	return 0;
> -}

> +static int rtl8192_usb_stats_rx_show(struct seq_file *m, void *v)
> +{
> +	struct net_device *dev = m->private;
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> +
> +	seq_printf(m,
> +			"RX packets: %lu\n"
> +			"RX urb status error: %lu\n"
> +			"RX invalid urb error: %lu\n",
> +			priv->stats.rxoktotal,
> +			priv->stats.rxstaterr,
> +			priv->stats.rxurberr);
> +
> +	return 0;
> +}

When you're moving function around, then try to avoid changing the white
space at all.  It just makes it more complicated to review.  But
especially in this case, the white space was correct-ish in the original
and now it is bad.

regards,
dan carpenter

