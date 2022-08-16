Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16859660D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiHPXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHPXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:35:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F3832C7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:35:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GMxl3N026249;
        Tue, 16 Aug 2022 23:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=MIdgK4feI+FtMIvyiwLdpy4tVKGIfdNBr9SxVTUZLSw=;
 b=IOcmnDyDMO38HuxnVRKJUT0cCGO2tYmGyeGssQVVWwbx77Yl/dpWN2Zxy6HYUMkYOrE+
 8RRkyv4Eii7Vsef/eQiag4wAhyFkrwg+s0FsYI9BVmVnC6VDlhmxfm6Crz5K9xIyKptC
 XQnu+9WrojlrZT1J2NnbZYTrXKUv/Awh2HH7NLC1yXwIIbOuFva7FVvRaLk4aekLA2yT
 ZUhVXJg+gMegKjNk9hSNmMCRls2tICB+EpUUNf3i/lZvM2fNcrvYbkAfde+nWWIe5lrh
 lPUBGSYPQ9iszbCb9gJjOFx4RJ6dtNLCjuyYcnh3TLcke/MYyYvlc9e/kPpzS4MeL6L4 Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2r2fkhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 23:34:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GL8ci1004693;
        Tue, 16 Aug 2022 23:34:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c6crnyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 23:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9wvTlZ/UJzNyz1LsPv0mcHqUM6Kp65x1OajVaOnRi5l9JIAjwM1NYS2OCeJ0JN/o0UrgpvYi2QIGW6R7UVXnrsrVCjU3Uf0kITJmZ29+CZuYqxhdg5zGtSGipuRXKngkRrBwSs4SZcTak7gPYWMAAVq7+tmtzGuM0jEmd5YdRnKaZAISUEbF0fmBAM8p7aJzi0vZiKTcXrebDCas9yk0B2868RUKvDCfCmZrOCtUFPWUazolskmoFWUJDBYxxTqdVlBEbe5mEJNnFUhz+O9d61kNekrGxK7cOGLqUVKzgAWvi1mozBugVyd92gWY7grf6ztzgJ1So1yFT8WJ+CGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIdgK4feI+FtMIvyiwLdpy4tVKGIfdNBr9SxVTUZLSw=;
 b=hdq5LRxrtF/V6mkMaIn5srruXBBkG9H3JtCUFbbtEmQO8fXYogT7bpbTsLT2txmw7Aa7XgNcXM9CvFrImsvklC3K5IYahuJNq/xJ8YQuN0kTb+KHRo5xE6AwWA4RuwDIrltQSaiwpxac6TfM2DfpTuIuWi7rDsnv2mfqV+JQHhsbL9zDTeLnLDdQs26WaDqEIghmhrciKS6aQLint7G2XAXenX7/l6ATES/E+AEDlnzK4BkoS2C8Mq1Ieiw3UejeEgzJKqM7lHYfDcXZ4TF8TQQuUwvUwShVMgWnrYsAkSb2mHmPhPMf/jF6hWaX5030Pw55BsP0QGvXScFwdwZcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIdgK4feI+FtMIvyiwLdpy4tVKGIfdNBr9SxVTUZLSw=;
 b=ivbHvqhR7m7AFusAQJCO+i8aF5HMKeuDI50X/2dmvevNLaraoVlNnq7iaqTvoYIjjfgC0IHH6gh6bjqvsFPW3PTnlanY/3L4m3iQcwPuAtXwHhDtburPDZr3I+/ZjE8+MWyt6ECez4lyuVL8bBcIv3NDU5PHqr+ikLPh0lyayjI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 23:34:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 23:34:50 +0000
Date:   Tue, 16 Aug 2022 16:34:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/hugetlb: fix incorrect update of max_huge_pages
Message-ID: <Yvwpl/RD9tLr6HJE@monkey>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-2-linmiaohe@huawei.com>
 <YvwfvxXewnZpHQcz@monkey>
 <20220816162024.60087b143995d9e21413fc52@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816162024.60087b143995d9e21413fc52@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:303:8c::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb883646-01df-4750-e0d7-08da7fdfe9d9
X-MS-TrafficTypeDiagnostic: CY4PR10MB1989:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiSD3D4UEx3h6w+TFP43hECbYvs+aBzHZA6q52pivjY/smP8mDBoh4GkO4CYJf8Nz/CwSpI75qAhYlmgoIt+mLN+rOQlB1Wb/RBMmieos+XpJAdKGicwVcAVWSjiAfdNhowmzF1V6vJ1DiMXPGEZk/7dn0Ywy1fIUs7dTI6JzIdGAGqk6dOEO/H/y2SatetPvPdyG1vDTRnnPqfHE27MlEDjTGUYPMNHuzilAdKmitK7FeKvOrgqccszdErGJvRCZm+Ps7u8Y7J5j186H1oADz+kHzyrSXuwGm8M2XiQbbq9QALmLUvFb1aXiv/c87ij+rqP5cLN+KEjcSEI+8KgXF+v75o+PPh2DGUyoHWpgutt6MLY4ANdCVlklOTGs1F5V1eB4N1LkblPK0vJW58Uq/t87X1rGg/RUxaG/3xRrSzW4EiZ+J09/CBFhZT2VQOMVixV0WVAauTcb6PBUhz7Hm9oT086ZcjehW45m4IM5UACkfRmgmMKJoe3I3OiCKj4hi4iFDjuVr2V3JprpmFo6xA5h/szjkEU2CZjtpuc/X0lC+5qfU4/MFaSPEV6djCliq5FzMRl4N8DEk47FaapdUlsCGgrGN9Q4QDmpGTVWq1fQ+osQrk0CB8PvqOrr2G3unT0poWEI9UkyOhf2KmpVhXHCkXboEEE2px09G5V5cFrlnC5GW1v+7BwHnM8K5nBAJhQVYxJUjFbAWG9QniNL+mrSixvEZEjRVfbggdw+DbcWb2TyICkHCQPpZF6U2Inntv6JepwOu1LBuHSjiBCKHnC88OdHfFIAgE+smf7chk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(38100700002)(5660300002)(478600001)(186003)(86362001)(6512007)(9686003)(26005)(8936002)(44832011)(6666004)(15650500001)(6506007)(41300700001)(53546011)(2906002)(33716001)(6916009)(316002)(8676002)(66476007)(66556008)(66946007)(6486002)(4326008)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0PVb0SHqtzLuWL0IOJAsglSjdhigTtmT93HTc243NPiYnsmwKpdZDz7ulyM?=
 =?us-ascii?Q?CANxqokSkbrQXCiiWXbObO+1Yi8QOB3oGgIfg5noSb9yFNU0YJBUQB5OZFw+?=
 =?us-ascii?Q?ulXWJ/g1/YrDdz0d23VW8AtCkFbyNK62M/hGaZ4gCPRcsRvB4IlzcrwYomhn?=
 =?us-ascii?Q?tNibj5CPV5dJV9fjaIEsR00+BiVVGUXCKwRTyFI+thTmUJ81LdwiOOyuV8T3?=
 =?us-ascii?Q?Qpf6xcagZTmG3//8hgHhkc1yaD1S04F3eBTFoOtl63thsIrOgSYKWyhMkHRQ?=
 =?us-ascii?Q?PhqMrNFCKfMhamcVY5yV79MQPH34VR9dSDEGXb0S4f3YTKTELHrObjHckEh4?=
 =?us-ascii?Q?UzhvPc1BMRh/gKdC5s6zG5j/aBNyVluAG5gPagh7T+c1qxvRLaj6f0uPkCxc?=
 =?us-ascii?Q?SLI6finy7YpD3L3emkcs+RPMcn7djuXUGbRuicaYUi/3s1AnZ6UW85Korzzo?=
 =?us-ascii?Q?Ct8mnnpwuxFc/PQ7/ZvunAjGP3kuy06hB+5UOluD7lUP59p7cg7tbZcwIxaI?=
 =?us-ascii?Q?fouluY4XEUoVFJc3aVT2pyPIXYp5gBwIvBvq6wC8y8Jy+/IB04lnZaGmtKOp?=
 =?us-ascii?Q?zSJ1u24CehsobR4U2qT6p+LTXtypWiFNl+KcpBDRhH7me9wr13l5+8L3ZBzK?=
 =?us-ascii?Q?atAoW4JQriiXgJ9r/FxqzPLxCyPoV9egB6Ka9oNVfKjeKNl0kwnP1DPH+oQG?=
 =?us-ascii?Q?SF+xMLhFLoxsrlS1kaJSuTRexgvUGBpqWInJaBi5D/8J35tiQrRT3r/t3RUi?=
 =?us-ascii?Q?VmVNx+AYbex6RiG0+w9Cxzr+mhwCLwy+0m8xby9CXgb4Nut+fXhhN8qcvGIY?=
 =?us-ascii?Q?aorxZg4UGlBPQw0bCRv0wvL4unkQE/JqiN253ymVZZat39uhWvA1ew4Tf24D?=
 =?us-ascii?Q?wbwxzOwmaRHbCrTdhNvxdOOttEpODXNri6kU1KZIf6FBWqqYfeAFjdI3qGqX?=
 =?us-ascii?Q?OSwaO3wN+YGFETQkzs7pzbAAPEG6ibpHHzOJVkPZVGGN9bMITPsUvKMvjz6G?=
 =?us-ascii?Q?w3fPf8HPTYVDAr3/k9pj+9CQJobnj4a2hzoK6Sbkk4Yz0C4hR2L07bG2NlH8?=
 =?us-ascii?Q?uQi4D2nIxfUVyfaBK2/BIj7N0Rkbd1QN2O5n4UvL3ZoMOkRtWYc7eHgBZbNp?=
 =?us-ascii?Q?li3HyEx3k0ZKLF1UOx6LmSfqYlPf3PHNEGe07vErEInWrDk/lqIkFw0LmhFq?=
 =?us-ascii?Q?DtdCNaS0ZdHApqlm0EO1LzjGicXYx7BDOegriSFRgiFPaPkkSyNTomOUjnfc?=
 =?us-ascii?Q?9meYUMOe1PW8Fe9Lq5fX/vagGmpUS1fL5NSOYnAr2r3BlzaSrqKqwbOAlwAb?=
 =?us-ascii?Q?TQLAdOilDkiu9rqOw3BU+v0Gm3mZUPGiOoUdQkpVXy6ZqBTopRoKVM+blaur?=
 =?us-ascii?Q?PkIq2Texxdx2jYwc16JQsAxuPy1hqIEpK6SV1t1ev8wgThkaKNjNb9ZeeAmI?=
 =?us-ascii?Q?bZvY3IJ7IVnE1BhKn0JoBz9Ib6+3Xea7nAs3vOwPmBeWfbDLOt0i7k7r40ei?=
 =?us-ascii?Q?FFUscrhmEJsZWM31IxonOq9CkZJhbg1g4TuMMHoal0KkcCSKPnlWscjdWwul?=
 =?us-ascii?Q?PNwy4K89aWKd2wvhVE2aEX7zOXftcvBHQSAG/cfKLD8QDy2ckQ3cmsWOalFJ?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OqbS5VU3ZpCscOYg9Wz5y1H1QhfrLxY9ulRVVmrhALH/hSG9yhb9S+vM8IVF?=
 =?us-ascii?Q?iO/vhpMioqmYYqB3Mhv6pPbbHAONqQgFUTsfjxbLHpXpr+biQ6kzgVG+qAE9?=
 =?us-ascii?Q?Iwyb1R7MV8quNzMvb4z56jf3FEsN3ygHozZ/mYKOVuwYijPW/QivsNA+Zt2g?=
 =?us-ascii?Q?5oZmhsT3i4pXabAcIbwd59X0YgFBX8TjDdabYDdjPigAMuKURc9X0zroS/Ib?=
 =?us-ascii?Q?oXuM1q44jXhqQ5Kwo7yMSBPTTQ5xgELitsNqlJLAJRL/WHrbqhdHgGaQh1az?=
 =?us-ascii?Q?cantXjTl/HNTZ2BrFIPWdYRN+6KRLdTqjmdfzpJcGCRi9eMRjakQaA2iPm4e?=
 =?us-ascii?Q?xMDv4kWlIeYejvqyY8nchDDlktF9/Op/CQct1c4k8V7BfGbDzX1zht6MMpiU?=
 =?us-ascii?Q?VUHzaXHV0BOKJx4dwnJdD8E3eIef35vY0igVDDUbuQC7AGrKVyh8wA6Bc1+o?=
 =?us-ascii?Q?Iv5uW03jOSKUM3JgW8xNznKpDSjVrIN5NayjeAD5bUEoQM5fGjPE9bmbJ2cE?=
 =?us-ascii?Q?qp2iHYZlh7TateVPyHoIoDKspJiF79keO2+6Nm/DWfzbRm0tmSTE/g+NV63U?=
 =?us-ascii?Q?onQaEP2vtlWV+uZ8tCGfdIXcf4m5KalNwy07qJ0BzSCc8czhwOGxOpqgVDUg?=
 =?us-ascii?Q?BFHaDE+qbR9Ac1egaPC/MTpKBd7QMHNQ3akWDjITC9sFNwGoXX9qYkgchE+4?=
 =?us-ascii?Q?9N+ob3VyMIZaqItWwymminrY659KEFcxPRZEjOgk7RKFdIh/F5lOdSNP+mGc?=
 =?us-ascii?Q?GlNfSChH2hnOiBEuhWIX4zfsCoNeKymSZzIpaapm7DkGxfozR/KWjOODKmyp?=
 =?us-ascii?Q?uhEpK5y0xx/Q3YiThRujxzl8dF6Yha//3OPg1DbYpSgnhIE3v8R9krg2lTcG?=
 =?us-ascii?Q?zkI9Nyw0qpU6PJxJJeiAv4pWIxXtnlQzuEGzZ81CU1zCRmFqmPjXgtqfQ9LS?=
 =?us-ascii?Q?ObnbVIaXO2CdyxuBCKRbtg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb883646-01df-4750-e0d7-08da7fdfe9d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 23:34:50.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM0en4oQRH9h6VdQAaZApeSvyRrsDUJiEyuZ265OuwZGIuo+ChUGZPFBtd6kHMn1bqJuMHlUAl36J5VqD1FZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160084
X-Proofpoint-GUID: RhKUelaIbTXZyyesqK9qDho-2JX-UTAo
X-Proofpoint-ORIG-GUID: RhKUelaIbTXZyyesqK9qDho-2JX-UTAo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 16:20, Andrew Morton wrote:
> On Tue, 16 Aug 2022 15:52:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > On 08/16/22 21:05, Miaohe Lin wrote:
> > > There should be pages_per_huge_page(h) / pages_per_huge_page(target_hstate)
> > > pages incremented for target_hstate->max_huge_pages when page is demoted.
> > > Update max_huge_pages accordingly for consistency.
> > > 
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > >  mm/hugetlb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index ea1c7bfa1cc3..e72052964fb5 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> > >  	 * based on pool changes for the demoted page.
> > >  	 */
> > >  	h->max_huge_pages--;
> > > -	target_hstate->max_huge_pages += pages_per_huge_page(h);
> > > +	target_hstate->max_huge_pages +=
> > > +		pages_per_huge_page(h) / pages_per_huge_page(target_hstate);
> > 
> > Thanks!
> > 
> > That is indeed incorrect.  However the miscalculation should not have any 
> > consequences.  Correct?  The value is used when initially populating the
> > pools.  It is never read and used again.  It is written to in
> > set_max_huge_pages if someone changes the number of hugetlb pages.
> > 
> > I guess that is a long way of saying I am not sure why we care about trying
> > to keep max_huge_pages up to date?  I do not think it matters.
> > 
> > I also thought, if we are going to adjust max_huge_pages here we may
> > also want to adjust the node specific value: h->max_huge_pages_node[node].
> > There are a few other places where the global max_huge_pages is adjusted
> > without adjusting the node specific value.
> > 
> > The more I think about it, the more I think we should explore just
> > eliminating any adjustment of this/these values after initially
> > populating the pools.
> 
> I'm thinking we should fix something that is "indeed incorrect" before
> going on to more extensive things?

Sure, I am good with that.

Just wanted to point out that the incorrect calculation does not have
any negative consequences.  Maybe prompting Miaohe to look into the more
extensive cleanup.
-- 
Mike Kravetz
