Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB86D5816B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiGZPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbiGZPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:46:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB22E6B6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:46:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFXs3S015605;
        Tue, 26 Jul 2022 15:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GYRw2fMaeZ2qQH3mzhZyeyQOB2dfFBP2cGFyI90IZjw=;
 b=ltobhGuXJuIFTCHtdUHffSZiqCkMPLOVQ2YkHptTZ2ynQJN8WaEsiK2JT0Un9UYZB+vr
 GWGO7W++xWTYroKNbKQ6IDC73Fp89Su8wbyryViA2PveY9javVX4OifAAZ+hOxbqbBYW
 1a6L2cZ1QP8u48NN1a+EeLsMIh//U1kve+gHNqu7L3sUyFZxeV+uZZkYwpb8j2n5ZW93
 4mIb7Q20GgG+dZrZiU6iHknbpZrGYW8JZ5bL28Q25HTyGIIeIwFdIqHOVYLVV0Nnu/uh
 zn2KsZmaT5ayMNa1C4mbdpFTWimDCjtSZ9Wg/kMGBJ1/nJSjAY+4ypfy/uTkX5mXAwwy xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940prrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:46:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEvov9006379;
        Tue, 26 Jul 2022 15:46:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65bp69q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBToqwMqeaADlKmHMYzSrQvksx31PeKA06eIm2ZjnJaPogaP5fuzP76hUdTkDqqVwE/JRJni3Pl3ZcS3d/zbQVQGfPvWQZXPQoP7kQHtjQCOMbXhqf0xQzc3hNbdrotQyQab7FNHkYsbq/47WCG+5+uWd9Hct8GyHzThv3eT/9NaWYVaXdKepgvwH4b984346znaqqp+Ng64W7v+SEBUYEAWwzmmz4v2xZiyHOTVaxyDlbvSAn0xMT8VvAg1xku1+Rz6X8+w+5OZDbzQ+mMM6gqFGAI80PDPCHsQ67w4AFuRRdT2aswARofOQcGeA4KrzwSdY1QE+jMffREMczjnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYRw2fMaeZ2qQH3mzhZyeyQOB2dfFBP2cGFyI90IZjw=;
 b=V6V5J+MnZWo3ZqaavOCjE2PcO3Y2Le2hNplnjW5OjGaNlr3CPIpv10dw3Etds76DrWWQ6uU+ZhdHjcn5Nh5D+xLhj0M6sF1oINBp7hm1mdDgSrOn6aTCUY8w4WEmiwZFwxVJEJcNB/BSSd2RNPfpA+FqOpA5+X38k0qjL57q09OvdDq8mbjWV5MGW5ZcVlYinqzq2sIjgw5e7qd4PT0+yDapqP2Mu5t4igwchHg280gccI7RGPbgxVWBsVDijg2jRSNOreIs6pfoMcH9APLrHAkvKVRzpfcuSgNMSplMNaIkz7NhsYZKFQOQMoiNvGM4agmlBF4h0cxIgzYsx3+4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYRw2fMaeZ2qQH3mzhZyeyQOB2dfFBP2cGFyI90IZjw=;
 b=bDhkoKrFZmmnn3IKLbmrw8aqz+XVO6YGpyVL1wOVf2q78MIY6c6s7zrif5I03T17mplBfhuUZXfMBLSFT+tEYU9GMVBqJPyFAAbTjEde64tEvS1gQImjd4U7XxGRJfp9zYyriZJAmHDuOM8hxV3S9qYFqJd3SVI5YG4XTJQz3Js=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2339.namprd10.prod.outlook.com
 (2603:10b6:405:2d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 15:46:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:46:12 +0000
Date:   Tue, 26 Jul 2022 18:46:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <20220726154602.GQ2316@kadam>
References: <20220725220745.12739-1-phil@philpotter.co.uk>
 <20220726133559.GP2338@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726133559.GP2338@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a94722e6-3575-47dd-af75-08da6f1df775
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GB5VmLthgJiB5WfD8KvsxFPJX+OaAkcXeNizOykAvJyMdxf33xO4ZIqIhm1HNXQj1UNAPie/EuiH3AMmzPS0OPONjZqXk5MK7srNnIi5UnvvFljOwGdb9ScgO21NCWns1r5EEpehULJr2P0kbR1I13zdkd6pfLk247hVjRa+zseWTthUD05DmWqUAfZ3eZObPwztglg7nXl519YZK3ON3KJjjp3J6CodLTJWPXQL7EgqckQZpFQ9VWATY8VLxeZc8Vad+ijgFDAZdmoWQFqpMIcyYM/rR3DU7ikVxKX22ZLm88qihbxQrj/WFF/zUW40CJXCYohezmU2/4xtk2YxjNsu6fHU1F0xexYiNQabdXLcoha5+fJs0kaaBaiantoK3WytN3g1F6M3+2Z61ENsVBbYM2xuso34rMPJfwbWV/9tiwDl74JTCWsB1YcqJ81xoCeLY8b2wXzD2a58bBHJ54kP/ltuog5+pgEp9duXv0KSbhVqbrNdywPa6wX5sQhU6RG0BW0nZfmLjpZTfSbV1WZggacdJ3DbIapb+P5B3KlsZprM++JJysFtzYG3l1vrkNM6pT2rEC6d2PE7UHeIgiy//ILItNUnIC7afeDC0qSwtDvaXa7ajqvDsitVa5fdiKz8sPH3m7nGq3RwBy9NWs6IBtkiSQTghhTULHbTDUtPLzih0CtZcDhDlEctiYynmz6zlyq8HiUcjp6aPi7PVds0dASM+/moOD+Gr3LBaOAuuw1cxF9gqP7wj0uMPQloz0rSvR7i7mO1YjKTztZkNIcP2FBttX6XeVHZ7dUfCLoMHrIGI3I7TuI0jVNZijVz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(396003)(136003)(346002)(366004)(8676002)(4326008)(6916009)(66556008)(1076003)(66946007)(66476007)(478600001)(6486002)(52116002)(6512007)(9686003)(44832011)(33716001)(2906002)(26005)(316002)(6506007)(8936002)(33656002)(83380400001)(6666004)(5660300002)(86362001)(41300700001)(186003)(7416002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ze9hqZE5YZnKqwg1f5lAt4L/ZoRNn23Unv2iIozZD8plUN0CeVb56ZOsrc+?=
 =?us-ascii?Q?beg+CuqL0qjrjfubU38YtC8qxx0WxWBTx4ko/ohJ0rOZ6uPMeeYRdiJqHdL5?=
 =?us-ascii?Q?5L62K58VyTrg4ue6kqK9ZAbxIxAj0eZaBkxTcUGuBNo8k10pdb/HWWSnULX3?=
 =?us-ascii?Q?PWL7FcpCnYnpUPCU6VS33xB7Yd3RZtd7Qp4KA1nJlSyAZj+g1uXQjsupxCeJ?=
 =?us-ascii?Q?Hnx+LUJBbKUoossHmVhehQaWj+W7wmIEII6sCY//S2B1Xaeat+F9CiSbitMe?=
 =?us-ascii?Q?9/YjF8KV0iVkuHhJjviyIKItLDmk2/7Yi54xFkX2Uahr9Uqm8Kjx6RbWfyq1?=
 =?us-ascii?Q?SHvGGZ7MdUe418c5g2mRu8O0h035rtd7v21Zt8CAq/q7aceMaBb/IWPDXoI+?=
 =?us-ascii?Q?8K1Wz3b7jLwEQkt87+dEx4+sQ+DYBlVn/VGmkIZ2P0UBcZeyiBXtNzNBM/Xg?=
 =?us-ascii?Q?HTlvkm6wviX1UUPelGAagTdSQhuhq0J//qBhoh0AlOBMuj8Se6z2NiQezsK7?=
 =?us-ascii?Q?SlhYjokstSdZj/g5QIKLo6LpqWzp+KetYkZU5C9YJ0jOOLfP3S/22wWhvn3l?=
 =?us-ascii?Q?EZQskk4+pWwFQ+lgCx2zImz9IlW2Beimrkyx2DtI17nKPY0G8nZBma3jYjjv?=
 =?us-ascii?Q?LnubyZVwFlU4ylyzX6g/OiegNOyFg1LduX5334YMwMpkzWWBOm8Fkc7kso6J?=
 =?us-ascii?Q?5qVKSOrBi+gK+qHK4oYnsOPK+P4fkE2ke60a7TPVp3LZY8dNljRkcZxEWhpc?=
 =?us-ascii?Q?Rai59//+Xq03/pAQSbKzqNorZj+pX+yEhs77k6S8AOywv/2Jycwfkkvwowkr?=
 =?us-ascii?Q?pTd+YjqfPfkb4obgP/ITNxiQx30zmE5TB+RSzO53WO9TMaBMU3NvoyIHmcJc?=
 =?us-ascii?Q?Zgf6/ujkSelP+kUewGFA6A6K5HXek8kwnOwG5QkBcxwTWE5PoMavQNIBMVJY?=
 =?us-ascii?Q?9meoELfTCMR4PetueLtmn0PpnER2hR3UZ4tfmxbu0t5nfM9HM6rbIBz+uHny?=
 =?us-ascii?Q?2mlH0D+k81SjLJqOjzdR+ktHbRbVkm15iMQcJ/Mte+NrVuGF4hrAHqjPj7On?=
 =?us-ascii?Q?LCvikQY3MhGcHQ7EG3zndZHo0nKxTaXIYrKUHG2/BcLwiJI10m4mf4+CVVAZ?=
 =?us-ascii?Q?eoDtmCiHiQc3THqEGQadg4qCPSr76bnHQ48K72rqrGqr0SL4ffRu/4iNgC6N?=
 =?us-ascii?Q?jFZjfiJ7Wb6ghE99Ufy9dZ2y6Mz/FVPz6Rn4Dq/FSEbhVBnlHLU0UdL+YZCV?=
 =?us-ascii?Q?P7vfb/GYBOSB7bIcyjXzsFkZnfho4MaHaPSdw+CiJ9LInUp9mgd6w4BI1N00?=
 =?us-ascii?Q?F65v8wGjXWTXyt+xPr7PLU4quzJB58zmq1ZsUUwLDx3FhzaOMMuRzMaWR/sn?=
 =?us-ascii?Q?cwHFYWBVkEQPnioJC6CsAqR/ViSgMfD1LHqXk6Yzkv4ywv2bJAsTDsvIt+8V?=
 =?us-ascii?Q?PvNjHYltEkUoelfo+kWXmmE4lLCgLVrbBUZMyOGN2qC2gcZ80WYr4pfbwbfM?=
 =?us-ascii?Q?+6f8d69kLzq7HlwOUtnVx+UNnd2CrNpQggKOnbp1KSr1Db3JMdtEyby4AbXe?=
 =?us-ascii?Q?kmuFj+0xaJ92YTPtvJIRAyjXYpeqnvNh2cYp2xrPHyfPlTXiZd3H6PLdLIQb?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94722e6-3575-47dd-af75-08da6f1df775
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:46:12.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKfeEtrzX2i+q/VJQvqfkiBZ8qk1GSttX3eYdFuR0eymBnZQ9f8hEuoQaFoGPl5sorBpqVmFfEgO8ySxEU3DGJ0yT2x8zGxrIeCfwtUWt9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260060
X-Proofpoint-GUID: id15q6S0KEIK08S386vTsuoszOOlzntL
X-Proofpoint-ORIG-GUID: id15q6S0KEIK08S386vTsuoszOOlzntL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 04:35:59PM +0300, Dan Carpenter wrote:
> On Mon, Jul 25, 2022 at 11:07:45PM +0100, Phillip Potter wrote:
> > Convert the rtw_pwr_wakeup function to use 0 on success and an appropriate
> > error code on error. For the first failure block where ips_leave is
> > invoked, use -ENOMEM as this is the main cause of failure here anyway.
> > For the second failure block, use -EBUSY, as it seems the most
> > appropriate.
> > 
> > Finally, within the functions rtw_wx_set_mode, rtw_wx_set_wap,
> > rtw_wx_set_scan and rtw_wx_set_essid, pass the error code on from
> > rtw_pwr_wakeup as appropriate now that it is converted.
> > 
> > This gets the driver closer to removal of the non-standard _SUCCESS and
> > _FAIL definitions, which are inverted compared to the standard in-kernel
> > error code mechanism.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> > 
> > Changes from V1: Act on feedback from Dan Carpenter:
> > * Try to use more appropriate error codes than -EPERM.
> > * Revert the places where existing -1 was converted as they are out of
> >   scope.
> > * Preserve error codes in places where calling function already uses
> >   proper negative semantics, so that they can be passed through to the
> >   caller.
> > 
> 
> This is a much better patch, right?  Everything hangs together better.
> 
> There are seven callers which need to be updated and all of them are
> updated.
> 
> Reviewed-by: Dan Carpenter

Oops.  I messed up my R-b tag.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
