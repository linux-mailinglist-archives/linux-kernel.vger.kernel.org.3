Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534C50A59A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiDUQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiDUQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:25:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CB021E39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:22:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LGHvlf019298;
        Thu, 21 Apr 2022 16:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hv4q/j3+CPOUEc0c2Jm1rff0mVAK5wfszfeVTdy6Uhw=;
 b=ciqZGCqV0vzwpH51P9xjkjbLpUhX0L7cuRBZt6ENqKpThhfBYsKzf9+BwvMlYWuuLuUF
 oQoB6kpaDlbWOIqkaSs/y4EQ5f+WJs7losaxYrCiMD6/x5dq9LzWn6I8PjM5LgThdZWz
 LGKNHinFXkDV8Tohuf/E4t2va9nlmtAldvaL+fBRiS0X8Gxpkq4M4e2qTHgi2bX551dI
 r4+waolRdc7lfPRDkbolpiTUYrhG1l4x59AqEFDD4Ry1arkl8MJ69YNPNvhoAOkoF2OO
 X5dhbUPVXnagnrQsAvtLudjXoqAoAietbm0OA0AUiD/BlQzicL6S1rtcxy0aU8XYCg8l Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cv7ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 16:22:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LGGuDs004584;
        Thu, 21 Apr 2022 16:22:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88w7h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 16:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkS7YHTPDCfjfxOl/j+bo4Oy8tLd2nSTUdVyKMiHcU76TsR/BJxBRoVkXdjQZojLeoMNrNZQb6wRC8AqSA0oyMcDSKd3YPz7iWb4i4b93O0iEiFdRK26uffAkfeUsvNs5AWISJdrNOxZorAeqJPmb35ckuDIFR8xdXBAX880nf2vBWKiD9kuXqlVCoc+qAGx/uXBGOQTnI8Rt1UlLgF4zkhvqZX//zgmZDFcZ4f8OYdr0VtPo+5wRIdqAYq2IXI3eUtlLka/JYsVaJytsgEPiI3HZN4OKse1iCtLmzLj+muAdgq2n7sr+HzNjRKVCbgPl0uPHAwTYbRlUmiH7d4tXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv4q/j3+CPOUEc0c2Jm1rff0mVAK5wfszfeVTdy6Uhw=;
 b=GYJ2ojVxBPC0OCZ/X/6HpaLEpgGnntnb2i2qZBTnDGWcu84DmRIMb1UF9OhgsEDb4MEyDGxHzM+X8m1ITVaLwKA6LSXIzRStVWQUqBWQ2MNUVKBSOY5JmKEvV0IJYC1eC1MBEziQQu0lLw6tPaQYjbO/nLVK6IRmGuTNJ0kCWPPqL/ci+0+Cp2mlm820Q7J4zZsCAWDszsxLkRxCV+XRPSySiwMXGrPvaJ2F7id95ac/V6dIs2C/XDYbSD26VG7yiUqoCZNNqYiy0nGSrQuExrSubuZtiYfuBYYhgNaTWsBkMIRfxCS8Jacu9ybFwlYy9VkWfE7fqMfE30KKeVgWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv4q/j3+CPOUEc0c2Jm1rff0mVAK5wfszfeVTdy6Uhw=;
 b=NKMw+Icpq7rL6hdS85viRyfTniAbWkRpoqAxe9Hrg/thdlokrRthNtNcLNvbdDejOy5GQ9cyFMKylQyGIyPvdkhZ+hR2dKBw9+JPN0RCEArYz7eFDOxiPjYcyJKeVUdhXENwEDhX8XGGjKHK+FpU9u5AxIPfZT66BWcV+TnYiYY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2551.namprd10.prod.outlook.com
 (2603:10b6:a02:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 16:22:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 16:22:12 +0000
Date:   Thu, 21 Apr 2022 19:22:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     lkp@intel.com, gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH V5] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220421162201.GC2462@kadam>
References: <202204211558.TapLZO4j-lkp@intel.com>
 <1650529277-7893-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650529277-7893-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0186.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a650010a-cf81-4050-130b-08da23b3174a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2551:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2551CE246E642B71687504BD8EF49@BYAPR10MB2551.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8v8MV+DZtBoLNMWENPWJ/fXR056f28zEOgItmaEwdTXOayTpVSNa5WXzLaG3qbIYuIG9HvLfxoFjPvG7gRlNvzB3NTfKbwb5aXsLvC/MmO8GFCamXk2QHcIqiqm4UZB7Uw7K5UPyNyfu/SwL++VBczfgSwXCviFB55uUfvrQJJyFlnZ6xdpswl2W5g2r5hT3xrrR5Xe1kZIE0AunzZRVNlVSU95+P+Bsdkcy6wdQ3l9xozJ813SIoBlHtsA9Vr+/xamxQFw3bgAbsSkb5gEAjUORyMeQOUagbR0A6gVgZOOQdVRisOOWwm39b2hCoDiifF6/nUE0/nCN+bTJoftPRfGz6bEZMIXrsXbozVgNWrI8ZcPyo9fz3gM4wjC3HSOuxqgojythQy523RB94TBxYcUPelFfxp2i+vxmepbiPocs/yI/tUAUZER42NLnl3huvAPPd5cMfjzBMUiaA11vAgLTvoEHhKkc5p4aPdilflkm9HMvOvsdu6G4VFIRdKMh6rxmXLE7jKgClvhoitZZr3Iy1OulpAMppVRUSxPMw+HQM9DFDxdhJM6Unws52CHIk3+k3jeqONZEOSQqDqAIN3wa8ZGoi26tjVXOfyjZpW69hSsnRrb7HDaLkk350l6mKqazfR7647kOLmSif7nV1Ws/MQOZANh96Ih4QcZB/mHaI+d1XPAKxEKKwQ5gLIm61vZHpg3mFuT3jQWg6huSKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6506007)(83380400001)(66476007)(52116002)(5660300002)(26005)(6666004)(8936002)(33656002)(508600001)(86362001)(6486002)(1076003)(186003)(44832011)(38350700002)(6512007)(9686003)(66556008)(316002)(33716001)(38100700002)(6916009)(66946007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8734LlMA944VKssRoBaOhdOY0LIvG73lkMWTf0Z9xRImoDVnq7FS/DQlvEf/?=
 =?us-ascii?Q?kz+G2eRs6dswcwJEDORF7gZa6mdIXVolIdNfV2OWRBbXQEzZOpRgnLsE8eau?=
 =?us-ascii?Q?B8gDysAXeYMRzgQrtKzKK03c37THfxtwLqPZY0S9UbMKQ5GyDd4uS5obn8yC?=
 =?us-ascii?Q?9fwtgz6C+tbQKn4qtT/P08atBLtyBto6cN3PShyhH9+jIfYNkqCqtkI2MDw0?=
 =?us-ascii?Q?Ew0tveRZBmCPwCSK99LKMCkI3MsxOosNWk2SY6TFdrv6V+i7+/Plh0jv2K/I?=
 =?us-ascii?Q?NJC9ippGGcUTO6LX4Tbq7wh1lO8TFmbsHMw8dBskUMnEHQEVMzHsOgQP2tVz?=
 =?us-ascii?Q?8fW6ak9o6GjFL6kebj8lAyDH16u6or8VMW5sUjNCEwdMq+InKAZoZLQRGokL?=
 =?us-ascii?Q?wgyVWKdwrUqxufXD4HqeoUdBXLeXtW48KfleIOYFZtKc0z9GIIGlNrOYiE2N?=
 =?us-ascii?Q?GbRC7eLWmolMQR6ES4upQG8rSFmKvlIMmoeyg1ciZfZn9yMxW76E1ppOOEgx?=
 =?us-ascii?Q?kIAqFQX7BVaz+u2G6Cq1XgZ4bubirdjNhmuY0PtpS788oLJG2CYYE7LfhQQ2?=
 =?us-ascii?Q?FsxBDDzx6DGZVTQ6Z5jyvptEREaUkljSqRj1raOK3jWMH+h7nTm8mQWHamFl?=
 =?us-ascii?Q?Dbug/xPqicbUloU64hOAMU+IUqKL02t6kgwzzEp+6MsJuIkDSId8xcM14D4R?=
 =?us-ascii?Q?VABvQ8NA+dIykSNdfRBzs5dHSQCADlhtsCBRPY0Cm8GXRbWlKoVuiYRvOmWs?=
 =?us-ascii?Q?OSd6oo85Dq+/Th02VA/GPq2JnFAY12jLURowCo1slJ2ueLp7brvV7KxKuyxW?=
 =?us-ascii?Q?9N6HCd2aKXLRIPhFqNhrDUUc+HTHBvhLt0FcNeVOEjS2hwdD6iejMSAaX6Ow?=
 =?us-ascii?Q?jmqP4lhXDBEI1PjSaEzWQKm2nkO7WPwKkZ6ZwkMT+oYAJAIskkB7dBeXxIhp?=
 =?us-ascii?Q?jtF28kXMOVss2gIv1eOjEkwMXwlNFGBPD1Lz0GBpusFFsPCZVFw2EAq0TcKV?=
 =?us-ascii?Q?xtxkqtXe9sihT+NSgiU2J7yBRdd3NYCoemHoy9aMsEhaU78zzwf65CJk5jag?=
 =?us-ascii?Q?DR6SOmZaUVNnISjUA5OF2tzXZoMcdOBLSobKa64NOBt8pMOa4gl0WzJXGwrE?=
 =?us-ascii?Q?HZbEp92IAQc77pp2oT6w5o2tocgoC6mV8FVc7wYjZNVJ6vWUS7c8a5VXfam/?=
 =?us-ascii?Q?nEgaaGnxO2WwN1aR9ISu91eTaw/TKTHJ1qWlu07ziFFyLITnVhc5agxvABzS?=
 =?us-ascii?Q?vEG94C5EbMXz8eD1DJRyZUWDl5tAohSo8El7uTLTflg585D4oRISsMWB/s7u?=
 =?us-ascii?Q?IrpAt2OUNoBUFoWa0WUUIiCo22EGAU1WFra8UyBwc2jBQrpmlavOiZik9xZx?=
 =?us-ascii?Q?9h15jtoB5a87XXHGha4bQT0saeTBc+K6GlKOPv/eCSsf2Duiq8R6dgXoGe+z?=
 =?us-ascii?Q?lSOig0SP7eDRE4oX85S7S+MqgtYlq5Hfy69Y4wzkh0/fOm7PzL++YJpkN8Hn?=
 =?us-ascii?Q?ebUqmR2JMoux8j6AXX2Tii3WOWgHt3sdtNzK+1Ri+iKrRaueFiVsTXOVcc7r?=
 =?us-ascii?Q?esFR6tpZ/XTMHc9mm0z2MQQM/Q3cfkmYC470WICQ4+Lvm0gC3HeDlnTNVRu5?=
 =?us-ascii?Q?l24ef4+Ust9XtFvvjpC3eF/Cni0JE/z4OPtP/1TVCuR+J9iwDbLd+NN5X9kV?=
 =?us-ascii?Q?mXRF7JHyDT2E3B6xOc3AwZLPG6+lmqzw7aqzhL5LMK8RgIIbF6x8zAJSttCK?=
 =?us-ascii?Q?Vp2OfQ7dA763fBLgM98NS7e4jwGSpT0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a650010a-cf81-4050-130b-08da23b3174a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 16:22:12.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G24LSs+eurBM/QmxAImsSg9HJaY+QlIU6RY58PifYYiOR/ogDBRBHa1IizKC5PS8oJlX0LGdAD6tQxgp8wjpYWI+pEXWuAdoY7gEP1h2nsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2551
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_02:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204210087
X-Proofpoint-GUID: mgnEEJB0eVuuR_h2tPNdPIyPVCr8MuXo
X-Proofpoint-ORIG-GUID: mgnEEJB0eVuuR_h2tPNdPIyPVCr8MuXo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:21:17PM +0800, Haowen Bai wrote:
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
> V3->V4: 
> 1. change message suggested by Dan Carpenter;
> 2. hold a->status in auth_parse() and return error code or 0 on success.
> 3. print le16_to_cpu(errcode) -> int %d.
> V4->V5: fix compile error.
> 

Looks ok.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

