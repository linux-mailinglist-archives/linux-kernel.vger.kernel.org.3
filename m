Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFB4FBE64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346965AbiDKONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346953AbiDKONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:13:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118ABE03
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:11:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BCwIl0012649;
        Mon, 11 Apr 2022 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jhr9oRNGv69ne4XJ6MH2R9/geENqUi43eD8YvadOIeM=;
 b=WAH4bvIXBgz3mRVMWPTAmKu9DM4TpVEmqjwe+asFcceoHCmNdK6vTdmnPFoIKfiqW5e/
 26L9DEL9xXunWh3uYvq3mEeNXW/3c0b9D3G6z/9DguLwGo1I4H5nvMf38jOg8+mwygjM
 NKVo249WhKtkYzsYrStaay1bQQy4PdgD/4eIMPmE7T4d7h2zoCFTKzLcC/LsAHaTAPe7
 VpYPn6r0Of/DBnkWhXK3HGFE6vU/jbmAQapfDfvqVLrddOG8/HWXy+ZnTfOJIaVvouQV
 Z71bme6bD1REn0pEqU5adEnbB4obhEBWNEgfcUc+FlZPpRET40908EwfS9X49hy++aOi yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2ptus4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 14:10:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BE1P0N017170;
        Mon, 11 Apr 2022 14:10:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1r8e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 14:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFWLTF8J5rScd7Zu4TUnmfdbMiLR0qiKD+6vvGUGwq1Q3lqcNWScy0TyolrE/0O8zv5S+wuLa/hUYOiIp4EeqI88DkUc0fNrLUEoQpEzP+vW4aVzIYYvvn2Lk03iTLjQx9K0ygtsUTdzpOUP+0KDwg7O90XBgC42DVKoEkCfTNYUtpbyDI7s6g7hRyIEqVjHLs7cqfbVu3PApBFnMEEDqtxew9qbShIfSoLxIBvW4iIcncsQbXqwv/V+IXVZ6aWCfk+U2XMz4JGn8rJ3104RQZLTbwEANaib3Vl4D3fP8ClB9G82eedaOVlCOnHf9wxvW/TLT8isliSghKDzu25AHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhr9oRNGv69ne4XJ6MH2R9/geENqUi43eD8YvadOIeM=;
 b=lqwcPB0qrkGkpwAb/g1tlZ4htcqlWtHxyHucDV56VY19I1iUNHbQOuQJQbsMm5Q9VNYyHQQ1EwLGRTQTA1Wc1TeIlMZqbk1tnRN8TvGGA+YXFWA7UrZDpd8gavHwDzaAHHgSsUa7A6gByqOr6IEfbC25KsmIrH7qJhFsBo9PvOxft5mVN9/RnrDxzhtUxBngDk4Y/9+cpLiv80rXv7d4PEV9Ojqt2adcypX42XuMVyELUFy/NCNIpzEyIyEU8wEVlUIi9VDqxDGtfjiqR5bRVvYoNfWHwjjKZIHGSUGSh3E+UYSq+QJDLXVCPF0ocialoDFDR7371k4lLcBCIs50kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhr9oRNGv69ne4XJ6MH2R9/geENqUi43eD8YvadOIeM=;
 b=nsw2KiXwHbQl1GdDRLfpgT9miH/9yByhMdwbLgZH17nHUHEOb7cUL0zYF6JZdIEJ4UbDD/rsAt+wsVdqYWqebo2d+WMSNj157x01/jewF0ZJOBBM6N9p5dBW+CBQmtKBcrEO5nlrLd43wFrk4Ze8nY5IRCLDK4H5Bi+e2BtTHOQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3332.namprd10.prod.outlook.com
 (2603:10b6:408:c8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 14:10:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Mon, 11 Apr 2022
 14:10:49 +0000
Date:   Mon, 11 Apr 2022 17:10:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <20220411141033.GE12805@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411102136.14937-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8c45fa-cca4-4b2b-b1ea-08da1bc51439
X-MS-TrafficTypeDiagnostic: BN8PR10MB3332:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3332A1892F634D70D25C69AF8EEA9@BN8PR10MB3332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnT+yC4LIxWV6CuEj5gfioC08sGmBrlHaqU7uj73QNmMtVmsL+UyD3M5mQfLwB3ntPdPBdyhVWmMz1AyiyZV8vmGXS/ORyfihEnhdDKrsD01Eu/zdiB9XkGXgA9DAJTm0SQfNCgU3cKYk8qOO3Y/DvxZrhk6Rqa1gy8uyeCqHxP0OLLlyqAATwZ7P89wel9bjKLcFrWPLd4klOU2qnv4Gna8vyT43Ewh6t0MdkEoMpKOv9KLHkLs5ud0X//5PzcTpsGVJJ3NIPPBqU+2ZYpiPx00jnj6hsBz/RsmP3sXhVEm9IhK1GJz/hbu4hSzJvCATPNH+PQsWzpNqdXwFDQh1XDlokwWVA4hwyKlTJ2zJMT4IAaDmbHsUkmt74rpG9abs8vpdmEYkSYSmHWjKDBfuZBdzpfX+IY2igXX2qPSOjo50gKAV8wBIC4empoKJUBTw73GHu5pbWOOkFvdG+gK9B2YxB+NMfHIm/S/2WQe49XkHLQNChQB5lJQAO0CsTSmnWP3CRNb81fEJgp4tV8ivtHT6Vp2UDXREcyyRvGkTzptoDYX7FEelRGQlIvnrhhV0VNaro21oAovpEnltQRWCIJSZ65/aj7wRlyknkXwY8RTvUzVDfHaENHGFogeFbgiq3yLEeh2shsQvZqTNHXlRoz53WueMzR3UDB0gmeThU3hbTxozAgT7aErXvkLfycWdkWZ5NcStcFeaNGGYWd4og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(86362001)(26005)(1076003)(186003)(8936002)(52116002)(6506007)(9686003)(6666004)(6512007)(508600001)(2906002)(33716001)(5660300002)(6486002)(33656002)(66946007)(4326008)(4744005)(38100700002)(316002)(38350700002)(44832011)(66556008)(66476007)(54906003)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5OKthGbdYIkzGgr+Jv+AhtJ3tjBGdQ8WB1e++GUlHsjnBxD2YP6SHVf9S9y0?=
 =?us-ascii?Q?SaKG5UrmzVRA9dy+xB5f6WlPbo4Pha3Qm1AmBahK6k6y7gp6rEzYh5kYRBYe?=
 =?us-ascii?Q?OXDJXok0hKb7UkrumI+DvMs9S5YA/fjMmBC5G1uRW4TDIqDiTPhQnrnssrCU?=
 =?us-ascii?Q?kUBVesb9ugs51Oh1P1bNJ1Q+TqexUjIQDwPVZ81cpvzn3WpBfjo55SfsPy1X?=
 =?us-ascii?Q?NoQoIU5a+7BtPryjCMrAXJ8kSo77pNXbHRZmaXQZ5Txwq41WXtzA3qtwW3uh?=
 =?us-ascii?Q?PHG/vskNC1zD3CTUmZEIFbrQVH3SFg20HgX+T5Lbh29E1KghXWLI3pcFkdui?=
 =?us-ascii?Q?ZwTHPN8VHxjPzrbd/IVaPLdG/wKW3jdpEumzQ4ILGdibyugVhV3zvKkDAqYz?=
 =?us-ascii?Q?k3J3l+dr9DY95U4sBzZkH9g7VkgJowlYf4plLFruOW9EIvS935l1Mh2x8s7O?=
 =?us-ascii?Q?+gzCPoOB1cs05SWqH99UwZULGQKETR2BjzY8bATbkRnp38QLEMCnz2XRFA2Q?=
 =?us-ascii?Q?v/9tc3PK6LxLwfEGKWx0/3Sz3R5gx3x33COH7qFbg0yIgW35gjeecrRp7fgt?=
 =?us-ascii?Q?0gKcTDda45B57zJDGFMmrb0o0oDzK/HAwNbbMIEQpRAet1cCKa1HxHlzuDBf?=
 =?us-ascii?Q?NoM+CZs4Q1Z8CSfkf9NwurEVHas8kDZe13PPXSWH0FgX51HcTMJpMJ8Li2oh?=
 =?us-ascii?Q?OaFkqI/dp92NbMFrvGOxEcqN2qKpL259rL8Mz8tRXL4BgRy/OeBPfdnrQsCG?=
 =?us-ascii?Q?5UuiyyUI9qPZWXV9eyxmF5aqfy0SCyayQm5gFItRq0nH51BNKLDZJGjhXbec?=
 =?us-ascii?Q?3Y/vH2zn6GOHXVq6GOh9aQKLJENyvoyDOjW2nCtJnPwzZhLjLhWT/cubCdR4?=
 =?us-ascii?Q?qdgpfdmx15MpHjIkUhG7UGIsFTJtuSRRBSUOs8qDQ66p+hAmPg9V2UeuTNQV?=
 =?us-ascii?Q?sK+jTvj99iGMlOgQnnvLBrbF3dFajk+WgULbW4yOsyQ2gziwNH2K+wO7ON9P?=
 =?us-ascii?Q?PIoRfOuWyFX+45AoGw6+z3iF+FQbbjBgXLp4zW2XiLwy1t+uqa016IpSlJMo?=
 =?us-ascii?Q?YPyNlgDDBEM6bxh9UL+Kqhk8q+J+X7Hy85gRWTo6O518qf3pwjbkFPst7z+F?=
 =?us-ascii?Q?DJaoER8ntvK1pyNZFdPWYSqHx8ro/el1GsbyE/IzQLjRYfEfNQmA1Xl2I37Q?=
 =?us-ascii?Q?0YJuPJVRaijnxiRebZGIdS/zucQp5Fk2ZLtTqiSdquaFEgny2HJVlx20CsXo?=
 =?us-ascii?Q?JAg/uExZZUVJnzD95F0eWKpEsFjCxafqZiwF+5/92rxo6C1M6hSfsjKmKCpy?=
 =?us-ascii?Q?y9Q8d7WFf93R2yX5ngzaJvRKh1z4u6bO/ZU/kNPhvVnLT0nVwGOHYD1hApGT?=
 =?us-ascii?Q?pYkoNbOkGkSy7Q+C7lOuOgt8Dh0qaLGAWWB9njfNrEVPj3BJnBq23aGHgeTK?=
 =?us-ascii?Q?ocKCE93JBJxP6QVpZs4oH+Rj8FemYKmyI33jKDQ8YcPJjOwsZ//0epgTgoBB?=
 =?us-ascii?Q?XS+WKkI/fbu+ypJpygkufhSIfgd1DcWvC7ecFicmqMzHs7NQTCCsFTj20yCm?=
 =?us-ascii?Q?RauEx37Qib+oOmgRL4NtW7QVhzodDljOdy8WKnoCQ+HD6HKnVvp9T3dxmngC?=
 =?us-ascii?Q?jhYwadyBceS0URpYgcTlI0P8P/EIaruLgg3F0uziimV+IX79Nn1QOlmr3r2H?=
 =?us-ascii?Q?/NxDYZbcJIrsEj/OqcxskuO6hBtJ+b0BjIF6wtAv2ebhfh/LQDWkBhoS0E3j?=
 =?us-ascii?Q?e1m7Tp461acTUrc7s24xLRL2O2bf3Zg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c45fa-cca4-4b2b-b1ea-08da1bc51439
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 14:10:49.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6pEXEXqGly7bMiicZM7s2l4JOx3RUn6rchsUPzLs56i8vWca3KDLz6OUFl7+aNREfEi0GVFUrBZnTLHBLB3malPEg16JiPje83kIL9IZ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3332
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_05:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110078
X-Proofpoint-ORIG-GUID: Wa8bndauC_BVjYZxH0DghrIC58LZ6mIn
X-Proofpoint-GUID: Wa8bndauC_BVjYZxH0DghrIC58LZ6mIn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:51:29PM +0530, Vihas Makwana wrote:
> Drop some unnecessary wrappers and update all the references
> accordingly.
> Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.
> 
> v1 -> v2:
> Drop the wrapper functions with underscores prefixed.
> 
> Vihas Makwana (7):
>   staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
>   staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

