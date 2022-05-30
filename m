Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE753856B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiE3Pu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiE3Ptl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:49:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA9434A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:11:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UBKrJM032454;
        Mon, 30 May 2022 15:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=641DpkZ95p4J6cEj0ED4qiBM3QY1VQ4MpoPbhIs41uM=;
 b=bBrJMRQ8A1Buejk+kOa7Nb0kV1JHCOl5d38ME4I4oeTPRnyy5MEUEYotjlZCEg4LKmvB
 nLJNPHSv4IuSmo0PhLXei7Q1IFUcwC73kOLvpzZ+1NXB07RBvnVMDy/N449WOfAAKxPZ
 IsFUedj/MB05dTHOnvXnIOksKb7PLSoeBiF1Fd6945mvaTLKUgtZv7QqqFfah71FcaHF
 +Wca8UKWIQlzmOqgsr/ItpFtucABXr8GXAaKCqncR9L68/5GIZ+U7LSxhcbrIP/YQ7F6
 nqDcNfvf8u0yTIhoJzkNXUdyQtuAfOf0HvELb2AM/E9xD6uIDYzGCD3HylP0rICgZQwc BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahk92r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 15:11:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24UF1XUa039837;
        Mon, 30 May 2022 15:11:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8ke0aac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 15:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID+rdTEfTDHsjbw12Oy3zshFfT4XGhTYBE7iW+QBOHSCsiqIE8JOFCkWS2go/n+55ttgBkYgz1T8p9i3kKBYAmVF2kulg/axW8FDRE5XN3ewoT+KZ6REVVPZygJiYi85E9qhHGx238fdvaSy1+VxWcIU675hKGsFwidOQI63j+mcquNChj6BwF8wg2VTf1d0eocbRVXdM+aIN2aZhMu8icFVpLKcqhtx/mJOM3VfTLkV8Z8TOny4+diBNMfojhwqiy8F2jFU7koYymB5GghtdDQq6E02SWjWPDVr5MIT6AhmohOvsojW1rw/CTSaIU91lLVKEXyFPL8O6a6yT8z9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=641DpkZ95p4J6cEj0ED4qiBM3QY1VQ4MpoPbhIs41uM=;
 b=iH8ZTa9us7tFA3rGJBvf3geLVP4OhrYIXBwdVUdYFP95cdEkJxEdcRvmjKtatEQrwFiQpTHdO2ZYL7ZtbW/4midgHqwGTOajmp9oIwOSrKYeXmAgXgYZnJCT//ZKjy81QBlVW9ppIyD6tIvmTXS4azZ1SDBQrenyadL+e3D6CUsyZtKotLH96xq8WQ63j8UyK9Lhttuff+7dx4CPDZqfH7V+DTmg0uB1yU/aVwIFr9IzcJuFvv2VKSmFVF2bgvJDAEx+wa6CYV6naVirpGa1GXHWtzZt49ZHY2NDS1vwMRQVWdPLHTujuirc9eWPCT0sz+xjXeqoggJ6lRI6NjV0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=641DpkZ95p4J6cEj0ED4qiBM3QY1VQ4MpoPbhIs41uM=;
 b=CXll3/2bJrdJ73RWDEGwjw4PF67Q/PPZT3BL1NCMByQTT53emd4P1j4caHapIsdMNk76Qe4Sc0spVzRDpLwy/BLY+83ZFRWN9fha+A1cIze7nszPHXR8XYWbGFk29J0RqgknLgMoreDnLCldr+iLxildaID0OgWZUlgqhr84C1Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1436.namprd10.prod.outlook.com
 (2603:10b6:3:f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Mon, 30 May
 2022 15:11:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 15:11:02 +0000
Date:   Mon, 30 May 2022 18:10:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in dma_map_sgtable (2)
Message-ID: <20220530151044.GQ2146@kadam>
References: <00000000000011e14605e03a125d@google.com>
 <20220530144542.4382-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530144542.4382-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62024bfd-da3e-4608-ac4d-08da424e9bf5
X-MS-TrafficTypeDiagnostic: DM5PR10MB1436:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1436C60A4D84B35A99D699208EDD9@DM5PR10MB1436.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y049EdNk3VBWur9Pk6Cz+N7PusOqCGSxN/XXo2N1VyAl88VopYJPiBSR8hyV6NcSLNebM2WepIMSWUCQSsHn46T1w+FaUfyBgnnhdlBHByox/v7b1ePHrZEcejlVaQzZKIMwptqurBtnOLw7c75/bIzAo180Wf+m0QhxU1iCoLLW7rbAUHqt8oMYUekycrEcLOfWuoPiVjWeLRBqIsOdb/44kd9MT5Af5MNJaJ9/p76UJmaQQ6RdKyVGyAGl0ZGgmdTG/pfLAv2Vr/+DmN4yJUCVM/S52aGl/lKEWMMBSXCD77L72TH9fTE7n2XANabtKfXzyBgy7M6MwsZ+oXShX/xgmUdAK+clr3Kv/on59mvm6okNbB6oby+vdRQaHY2VAw+ubAljIqeXPZ76YHA+CuWqR1RLKMEoluBs520r7LZe273ErACakPccVdoHKyNSbj94AhSNDAz1AN4+wr5E2Yd1iSoPYkbtuDK/9Khbl00qTQxU3Ouj/T+HiPpt55DSxxTrUXvnXsyLyyvtVK3PWoPG76Jc5GncYuiRboFaulkXClvulyNqQ6f09w/eaOJs5PZnP/a4jaS3ppxV0SXIHks0PJaZkRaslQ9Vs+VXkwPvoJlGEesJcb97SCcZDV0qHKGEKlQgpBAXx5sn0gN+4I3cPLLGTT/RZKEGDGtFKo4EWqbu4YdnaAxRtf6ahD1gQLhxVEoZUXFBFur7uI/YhEO8rQvUe2YMDPubErEQqkRVXa+K6dJSCG6qauvtC3sQElrjXeB0bwu91e1a+yxWvpLqNP5cXkazq5bkWHtudfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(2906002)(1076003)(316002)(6916009)(33716001)(6512007)(26005)(44832011)(9686003)(6506007)(86362001)(5660300002)(186003)(52116002)(66946007)(66556008)(4326008)(8676002)(66476007)(6666004)(83380400001)(8936002)(33656002)(6486002)(508600001)(966005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJDLub3aA0SzuLBpcvrqVUTxCDiupkbYnkE+WQfU4H4+ixz2IKm8dhoNFhxk?=
 =?us-ascii?Q?VVjaORl42wzAybt7yxRL+fyuo6OkNW+7v8Gzt3xtjur5aqyAhd5RCcYiN2JK?=
 =?us-ascii?Q?mD542kVo5q96l6qVrTa+oe8D4uWU5C0Ue/gPlZ6ToK/tJVqJ5vsUdJxFjSJg?=
 =?us-ascii?Q?t0JhYLJA9Bf7jMXw6OfjNd3jQDpsRcpVTIWJXKkkGjw1qJ+Xi1OVKN3//gLh?=
 =?us-ascii?Q?TayX6mgxJw3w6Tx/LtvgUWrqmit599aDQS5geUw3lB+PC50bc6+Ts04tvSTT?=
 =?us-ascii?Q?tsC5+BArhV+TnRl0qYraOn7NiOFMEP9EbqI27nlDcmcEr2uWsSCKgX8mHEHK?=
 =?us-ascii?Q?Fwg4qn1k5qLcs6xbDzMtuQqvsx1jISohuG0j5NPNE6KpVwHO10uSyMlCx9YG?=
 =?us-ascii?Q?6Cfpc/nu8w8P9ge/sjZXT+o4hozhpTIKhhncTKnGvHsHSOauAf9vY5sU50mZ?=
 =?us-ascii?Q?BuhLR1cpZuUHaQ3/BL/CVFy4tRfK80TYOJVVbKCd+zZ/qNUIPiEyKFhYzRwe?=
 =?us-ascii?Q?NuhG6wOBvMtnf77p4yupfJQuHm7S/GXRhXMmc5CK6Vw4sjKW/1Okb31hhMwY?=
 =?us-ascii?Q?tD3X3HhYdENlTTZeO6gAijanNBu1AfoPEFvLofh6ywxm1WHSsT9fKWZRTrCS?=
 =?us-ascii?Q?FuuSwiNDHbbaF7GRjN8PlL9Sflrb4RYHeoWREJSxSTRjJa+/Anudg0keX10E?=
 =?us-ascii?Q?aJAOL8qECGbuo7oSuWfmGGHnYfYPqOhId5mBJk/RHeHtK9Avu3MTKhrMpeFV?=
 =?us-ascii?Q?nTJtvltBQi2B79MeQsLafepICndk1QkN2K66pEAw4ojVRy8NAPSLQu8FvbKD?=
 =?us-ascii?Q?q5D4f8CzDLrzVuWy1dOgLXI/xUm9dp0H3FX7lcHvbxYLX4hjHDlWwAV5aq/L?=
 =?us-ascii?Q?jchSNjmzPBL8HpJ9ydraxNHR1lLVR7ieGcNevMQD7sgxNLGzMLq4WgmuaF7s?=
 =?us-ascii?Q?4GJ7ba4Qxe02V8scL801g3ipDvk6/k7Yg2iYde99SPzw4gtQL6pF6JGcd5S+?=
 =?us-ascii?Q?AXGxHYUhwqECmUdufnB6h61OT4zLXezKFusQf4Fnsdm+jDJwD6KXmGoZipYH?=
 =?us-ascii?Q?nmU5vFjjT2EH+eg9qbTJuQAnCpteEoLr6EBZEXKTzqakUEYwv9YQ7ZUgcX+d?=
 =?us-ascii?Q?zzxvp+coJarBCFRICbHvDvVMnWGKBiPzNjwYBWFEqtk8W2W3NiR7iGWR4uKZ?=
 =?us-ascii?Q?4h1ofWtBvZTECw4nUqCiv/WlVI0TzourCF1NmjIECPbtZC/WkzUCR26/ZC6b?=
 =?us-ascii?Q?ghqX45kJRIhGDQD0hyfsKEfdThbGi74Vk81tdz0EQruJDV176qp9+WI/laut?=
 =?us-ascii?Q?IvwUnPUahxLKy5nHiZD0dQDG5vA+TOL7ugbQAZMIYtx2cfmlb94noMLF7P+i?=
 =?us-ascii?Q?GsEwqg9d0aR46efDDDucZes/t3TszBH1TeCJLcEWGbqdz+35T4/MmYatioRj?=
 =?us-ascii?Q?8FFy939tWbUs/zDacnbXfRB8QcKo9eqEow+MY9qOSZZltpzDrIJRVTYzZVG5?=
 =?us-ascii?Q?0MFCN3Mnj/a+r8cYMgnSOBTIGlTY7Vf1JElFPNyNAl4woqeiZQtxmTlOJcAl?=
 =?us-ascii?Q?t8cbhCqrngBJh75yAXiscFbJix12GC5CvonPlPHnB/UTGgFgvwr2GXX5iXvK?=
 =?us-ascii?Q?2LYwT6Yijjy8ZRzXiVYSh9gUghuPHJGVGI8AVDGxnXw2EdKL+HSFIx62jem4?=
 =?us-ascii?Q?HKyq6IkfEOOdoj3c4MeL5+DkAgYsrHfbJL7yv3lMtjq8YT6UVE3so7JMEb2y?=
 =?us-ascii?Q?hMwGjZh/CChAznLvuVDJzs+vCM32fuE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62024bfd-da3e-4608-ac4d-08da424e9bf5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 15:11:02.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QDeAEps5ZofJ/T07o2gFYx5pAGjPquo17a5nB+S0RvDHGxS7leVA0gnxYTUVbPjUSg3OU5n+mxU2pmd/4OlbpCakB7YGol+WRlDlBIpsqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1436
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_06:2022-05-30,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=906 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300079
X-Proofpoint-ORIG-GUID: ChxgROchual5yLipcyBLzw0ZlvF9XYei
X-Proofpoint-GUID: ChxgROchual5yLipcyBLzw0ZlvF9XYei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:45:42PM +0800, Hillf Danton wrote:
> To queisce the warning, make udmabuf misc device dma capable by default.
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   7e062cda7d90
> 
> --- y/drivers/dma-buf/udmabuf.c
> +++ u/drivers/dma-buf/udmabuf.c
> @@ -273,6 +273,14 @@ static long udmabuf_create(struct miscde
>  	if (IS_ERR(buf)) {
>  		ret = PTR_ERR(buf);
>  		goto err;
> +	} else {
> +		struct device *dev = ubuf->device->this_device;
> +
> +		if (!dev->dma_mask) {
> +			ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +			if (ret)
> +				goto err;
> +		}
>  	}
>  
>  	flags = 0;

Unrelated to your patch.  In this function do we not need to cleanup if
dma_buf_fd(buf, flags); fails?

After dma_buf_fd() then the fd is exported so we can't clean up, but it
should be okay to clean up if dma_buf_fd() fails.

regards,
dan carpenter

