Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C338E586808
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiHALWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHALWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:22:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419865DC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:22:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271Ancjo026725;
        Mon, 1 Aug 2022 11:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=7cC0g1OVdECOqYszair6kWnz88bsQC0IXEpiLFNHNt8=;
 b=JDbGj3odIrnv5a6m9HGuHoWh8G45+QqDhybBeNgZ/WizcgL3uti2jGdLneoj0aKtfyOB
 sOtHaXeQ61NrUkR9TBfTKSa45WBBu7XzQNFWaAljxN4CD7R/W/oGUWvAMUgdAWLwD4el
 QKJBo9Ke5WEFeqfHuzrVRCMlFkDjh9afIl52LyfHYSVZzZcbhv5P76L2Nl4n7iAUd2/6
 FOcCINKGpaMLOhrvElkNzusNVmkH1d+qSxNMMn1zldrYe6hM8jqW0VZPB107UDSyfrSY
 qhOktKVeRtUoSk9uWbHANBQk0mcEoCJ4JVPgTEaZEtfZnGlNqlnQNs1yF5bhfUVbcaZG nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9k9du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 11:22:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719cbna000973;
        Mon, 1 Aug 2022 11:21:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57q31p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 11:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlQ1TV1yVXw+ZFiGllUaQQ4GlpS91O4XLJx/XHkGEop/P2NMcfsYo3a0WkA6QIKHv+FSaqEtLyuPO9oIQp/hDLl9SH0RS62LqX7tMkMh8MJE0Mosj7UmjYYhAtkoGI+MWDg6GChnTH73gC0ucrsxMCPFJwesI00egcndxyH1y49RPqmOhkcpptZrfuEq59mKSXZhaPQbv/LE8yFJtCzo90r76XDUfgtzM0g7HgIX2E1sILVyBI9xGU1jw2JPyK1WkBYz7wLnZ9RlJPq4R8aZ4E10IrUUL99/6Sus1F5IfV1cNDhmxrbu/ehe63pAKiFXaXK3KQHK7DNiXGQHdyIyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cC0g1OVdECOqYszair6kWnz88bsQC0IXEpiLFNHNt8=;
 b=H3fJo9CGq77NlW15VGBvjvl3MfVCLfWZmpx7jY7L497A5OaM5rfkdggYjLZVeUzK0IuX3IgUuC+JZkqGl2rbCsYHu/gOvu/qQtQbAVLvpwaISRo7oCBh3UzTjDZ/5nLPe38sp4paMzcQfJviusajWDLOnohCXbYiEM0HT4U7WBXbZktyY+Dvq3fo6MrcM2jVo3eD0yOnTbeglV9/KaBqHJaZ3alqZEFv3kUar4+rtdkHu5+PPuwO38sBx9md04y+8kzIRWIvOsVJxupuQ0N3Lg+eFYshldcP6WHMf6Pe4PNoyRQOUhBQkrYCOJ0zCBfln5P2qP+40HgNMW8k8OIcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cC0g1OVdECOqYszair6kWnz88bsQC0IXEpiLFNHNt8=;
 b=PqzTcWorwU0jEF3o4DWGVwoMhFw4/IET3ZCY0+ke+Pg6C8glXGXFK99c+jtoC+0IjpcS17TrYwmIMTLEMPZeXYQfGawPSbeO44wzjgsoQ1BlIP6a6EvGWCM/qgyiqptHMhg3/Xx+2acjfv5lFBLMUkYq3AW17vmRTRuW9XxT+Z8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3274.namprd10.prod.outlook.com
 (2603:10b6:5:1a1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 11:21:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:21:57 +0000
Date:   Mon, 1 Aug 2022 14:21:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: vt6655: Create one function for four macros
Message-ID: <20220801112126.GB3438@kadam>
References: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
 <d4768227a7ea10ccec6d08eb0c55f8790ef70379.1659192760.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4768227a7ea10ccec6d08eb0c55f8790ef70379.1659192760.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0181.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a6c03c2-602d-4201-bb00-08da73b00b8a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZF36LSPefh/tFCpiuoiMTZIwfuTE3zPHM10KfUVwubKSsvBVO62sakucFdFBDMOTYuLtlakXteBHzYoF+d46/CjLR5SqLfDlHfh9U9jXj3VwwdGRWH2JLDncUL409B6wcU3y1/w2zn9xbtm6CpCJP9BOXzSiRNQ9xi0qi/C2voSKBOJiIhDWz+S4MBFjgXaebfPthUy/bz3IYHKPnnY/brkV8i2YHWeb7Cs4q6FAm8gxoQs4gSgYfYOPPliQ89WvxgAZJwhlBM38/Q0SuprAjtR3pNimJEYnnLOiR8V29RKrGuuUHl/ZGYSJngRD6zMIwLbRJAUg4Cdfwp6F3Tw1Ig0Sjh46NXzgNQENjqPPuLQG4pEs7hQQDlEpvL+4A3klhOrhb6zVD5VxF8doCG6uzb5SVTkzXm727uAoCQi6UwwCJzX1we3IEGe7icVx7nNIOGSL7mxyQ4Uwi6wo2WpuduwjqsvkySpko7GZFiU6vVQLa3r8jp/37VsBxuJNr3Mif2cGf1Qqeb27Cu6BI6bSGv2rBIGgGF/mL5+UmC87HkNym7imfEWLrL4C3Y5AzdXv9+MwGKY6ERCMSkPzwDj8amhXNsdOo7fKmwPJ7EGXzX08tX09kpk9rdNEruyi4eqQoXIlS/3a9/2YjkRd+iA69Dkh/9jVQpb+1UaLc+YCHEqnub9zPzMSfCcd2g6e06vDi+jOsualG9mpZ4uwcOLf0uIZRRcDDSJ19LwVdPut7fIZvXkBS6yC4lBzyHVJ11QiPVH6CSbqyD/xHCGM+CD9kcGiET9a2650uA71UUQUW6CEW74hNCgrvpHpFAZ9S3vb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(66556008)(8676002)(33656002)(66946007)(44832011)(66476007)(4326008)(86362001)(6486002)(5660300002)(8936002)(33716001)(478600001)(186003)(1076003)(52116002)(6506007)(41300700001)(6666004)(2906002)(38350700002)(38100700002)(9686003)(26005)(6512007)(54906003)(6916009)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBu+T0iccy43JvSekwMlcXguPwLgLTRrKHbZS2wy3NEQo5yNO6W194O6Yx/n?=
 =?us-ascii?Q?ni3IXJHqaXQI6xA4iwPi951vaF3BaiWe4rCFZpF2UL9na/vt5G76Lwj2F68d?=
 =?us-ascii?Q?ra6a9gofBXuMfv8OqIMIjU1niFJU3hRB/wsjH5H311FR91VvuS4g7DGRPT6H?=
 =?us-ascii?Q?N/PF7LUfcicN8CmrzYgaU7HbNdJB4/o1BN4KZoWUiOtb1Tm1U2c7Al8/CigH?=
 =?us-ascii?Q?TBOdR2cwaz7p901fZmJ/PhUQvOPdan8+DruYeezye8a7LdPGUuOUg1jwxx7+?=
 =?us-ascii?Q?aOZKW0DxmL3AZEaV+L0OLhDweLteH57DkuFk4woZ1rQbWd9xKfLEAmuFi5aC?=
 =?us-ascii?Q?LpzB44Myls2q+bvG3unmmyelnILfBKGkYCVWDfmqKX4Y4wZCZDI7vUeyY2xa?=
 =?us-ascii?Q?V6fYSdLKAh8tvzmGW5u9XcUQnPxvRzytwPbI+hSMadaO+DslQppumu9JCrEQ?=
 =?us-ascii?Q?teoUV0wlWD/La73sBAwFlZztw62jZojU/GhPrncnWREh8tQR8Zqtpp17l1Zs?=
 =?us-ascii?Q?ByFlxF1UfAAJkMJuu8zNBNpAobrnhETXRpiv25K4f6AJhw3QXNgwYLsiBmhN?=
 =?us-ascii?Q?lIoZfzjMGJ6GAkyubVmwyQ1BVhPinvLJZDgey2BSpXKuzsqhW50v5flbp/Tp?=
 =?us-ascii?Q?gRdNIlVd/HoJvyLqTSCCyM8ek4l90ckb9tBPG7AZzJsMWNDNDRFmGLN5Q8+v?=
 =?us-ascii?Q?lLqjRHN1k3aFrTnmzexRsTDb3ETz39C7CR9/abSGjGXRr+iKYmr3NPpZPXd4?=
 =?us-ascii?Q?bFWJIBZCcUegMhXAeN0ufgd9XGnwcUr0DOb9DcbQbiaA6E9bCQRic84InrD9?=
 =?us-ascii?Q?XEjL2Ys7L410DXauPSG1eQyIkzh2nrK/48IW9gxQMLeE+f0tObFXCrCDPgzF?=
 =?us-ascii?Q?3rhRR85LvXdSu4ahP8Aa3s5C4Vrnkh867w9ZL7oS+0Nv+uC9xhNgqOXq/aXH?=
 =?us-ascii?Q?2soQbG3ei+VGXBv5CXj7fzfI45P8FX8ZGuHW8xZwUqd/zvBDFDJzpQk4dtYF?=
 =?us-ascii?Q?qFBeCT5KupjDTay1QbSH9574W0pcAj6A/9hDHIBJVYO3Z9jqkNRm291wzwpt?=
 =?us-ascii?Q?vFNqzMalimZ9m4icwqH3q0mEtt2IvyP6tviR2cFFIu1N1UXctGYxI1mVw6S9?=
 =?us-ascii?Q?ZOZnyf8HrlnF7UUL5xfVV/NuJt+KdB/eNpDTyAFVucgOLHdsOp6MC7YGO7WS?=
 =?us-ascii?Q?gPk8tQxAUOYYtviqxliF8wpQtr/tGHU0cm7hnTVPNbHkv2SSBv8L7qn12V4K?=
 =?us-ascii?Q?rRwg9OP00/5gk598cE014e8hnKdQtD1Y+T/dTCa4aO9VbxeWdRm+GSBFxmR7?=
 =?us-ascii?Q?ELLIoy+I9Sy6hCvmvMVsZaBdrBfVP2muShwqgv1zyeXs3PUH6/llcYyDpnmN?=
 =?us-ascii?Q?ms8ILT5FbnGXU7w2e+PSwAMDYUrbJfPm1SXDavhjaKNjHjWbOtN19LS/frtL?=
 =?us-ascii?Q?klWfZ4tJf6xi9Kw/nYa8wsbJBXbPswXgpi9M/V7QEOjwFyuWVObzuvqYQCSf?=
 =?us-ascii?Q?lFMihPr27KJZzwLgSpM2ylumhKn8ZDQgHvL0+aN876dsb0Fota4znGFT6u9K?=
 =?us-ascii?Q?8fiFBw+gKaPlve0jWC2FOspAmBOVomQNTYeNn7y0xtu37IN0Lu+n7ToH0B3x?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6c03c2-602d-4201-bb00-08da73b00b8a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:21:57.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYEin4G9iIilH1xe6jKu10el2+GXfxyAxKhRvpuTxzC5oX0T9PCkLrv2m3pTDAKPG6k4OPGeXK8saFsfh1fN7DZv+lbWYwVekwR3eHxn7iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010056
X-Proofpoint-ORIG-GUID: I6A7NsL-qS4v0bmq4-wGCe3Mx6CXHYfq
X-Proofpoint-GUID: I6A7NsL-qS4v0bmq4-wGCe3Mx6CXHYfq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 09:20:30PM +0200, Philipp Hortmann wrote:
> Create function vt6655_mac_en_dis_bits_u32_reg with three parameters to
> cover functionality of four macros.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/vt6655/device_main.c | 12 ++++++++++--
>  drivers/staging/vt6655/mac.h         |  3 +++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 3565aa53f007..5f64204dc312 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -216,15 +216,23 @@ static void vt6655_mac_dma_ctl(void __iomem *iobase, u8 reg_index)
>  		iowrite32(DMACTL_RUN, iobase + reg_index);
>  }
>  
> -static void MACvEnableProtectMD(void __iomem *iobase)
> +static void vt6655_mac_en_dis_bits_u32_reg(void __iomem *iobase, bool en_not_dis, u32 bit_mask)

Never have "not" in a variable name.  Just make this two functions.

static void vt6655_mac_set_bits(void __iomem *iobase, u32 mask)
static void vt6655_mac_clear_bits(void __iomem *iobase, u32 mask)

Rename "bit_mask" to "mask" or "bits" because bit masks are the only type
of mask that there is in the kernel.

regards,
dan carpenter

