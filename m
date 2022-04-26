Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A150FE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350463AbiDZNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350542AbiDZNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:06:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228263BBEF;
        Tue, 26 Apr 2022 06:03:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q9CT7C027770;
        Tue, 26 Apr 2022 13:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ug74ufH5LlAKagy80FQm8FffvVpN9QWvhdWMuDzUxM4=;
 b=dhpbhqt93gr7xtE3kZZ/1eJ92shLLSm0eFlCSzRH9SwJlE4qIaNIhbWBZNBydGmfJIIX
 FjdGtK9VRY8AP/pTIF9LP5gEPu1/7yQerCFTNpmWL+g8qtWpAnDaISXv0ggP2UFRUFWt
 RCn+tIGHxfKebRj0A6v7Y0EJkNPaLN1ENbPV0PggmWwS+m3kuzrm/w4r+hdjaRLYaIsG
 11OXHmQ7CzOz4ozbz4q4HEHziyiBzl9u4n2uL+L29VBOY/VGMLcUrMHrNtYqErhkUHm3
 O/Jyd0KSQ1OM6gAFBNRxzUOYUdbpv6VmIzOoqfzzBTwkfVllYZLqdxV/L8iR2LHRfU2G pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9anxsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:03:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QCj4H4014549;
        Tue, 26 Apr 2022 13:03:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3bs1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUlkkraQTSnqhGgJDn1cLsHdrXvSFtD86OG1vrvdF3Pn9555Fi5XyC6kj4oe7cwOSbIom2dzmQnATEVuRrXrDXeQ6JNBt3Mt3ff0Mq2oetsUM195SHXLLIos5rgEmiufAisy8dU0ApUwDHL/Cfjogpv5v4Md9rGd05EUITY28UNG4FG4mVO6T6p9xlvUrelvAQ0T0ATQdg0H+CGC0Ci+BXsvc2suN6+YllQyz3sYF38xHejkxqpSOudID8TiCU5wslj6Ii+zX9R68Kha5vKEbirSfE57A6ueNUKItsbZs6b8qk492ueRNKZS2grDZSfw38KgO7FjQn6rrR7pPvgUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug74ufH5LlAKagy80FQm8FffvVpN9QWvhdWMuDzUxM4=;
 b=b5q4vgvBhgUUGBUGgiJ2m6z0V/GI1w4ginUxScbWRH2wDOWqLH0lQJjaBWRJLXfHcYvOSDiDKNG7Ut7njCqWaKwDJsNSdeCjaNeJXHHi9UE40Cf8kQL/Lbb6z6xr4UT+j6fYbjeSl5IrJ3tJfGkG8pu+6FoPQSPvgQGfw+c4l6HWPmH4H6GTfAOKe91tL+EbAJYIGJvMCTZEsgig66omn8UDxMhPgXv2M7jp7uSbpfsVFlwfHr+qjsb/FyhSVtaGmPaqIEYxqE2EmOCeK36wk+Z8Ey08oVdiT3qYJbK8clOZZKMn7coWryElCjZmpscC5Shql8q15jo2mcO9tTcPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug74ufH5LlAKagy80FQm8FffvVpN9QWvhdWMuDzUxM4=;
 b=iRQP6bfWtQmKeXSvS9W/aygpEBtKjNE04Hkte4QPG5vGP77yTOPGpTneJ6a1dc/C52hqijOgq237g1Jh+v81FJC7Vupo3GoXU4/0eck5WVc8XPggL1IJbqcJCrfZU1305cRX+3XWd0EP90SUwviokHT0qUFaqYhTTeBV7JcKQeY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN7PR10MB2644.namprd10.prod.outlook.com (2603:10b6:406:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 13:03:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:03:19 +0000
To:     cgel.zte@gmail.com
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] megaraid: fix error check return value of
 register_chrdev()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qxkt2t2.fsf@ca-mkp.ca.oracle.com>
References: <20220418105755.2558828-1-lv.ruyi@zte.com.cn>
Date:   Tue, 26 Apr 2022 09:03:17 -0400
In-Reply-To: <20220418105755.2558828-1-lv.ruyi@zte.com.cn> (cgel zte's message
        of "Mon, 18 Apr 2022 10:57:55 +0000")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a98cb4-bd2c-4399-1af5-08da278522e0
X-MS-TrafficTypeDiagnostic: BN7PR10MB2644:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2644CBC95150FFC03353CCA58EFB9@BN7PR10MB2644.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYzEtduVRnGWlRmXfA3IWmjor63bCyt4wTDLSd75w1aSjeTyVo5jT0t+yrGUm19utH8bijFVnkPMnU3QykGmp9e1+UwMxFovqa+s/BNxlEa3kXoKr9EHV3bxiCeDLNPWSdYFPQnlMGFfYaionN9wt3c50lrZPowI7avH36Hap3Kh4ibjN/73D2DjOvYTPHlk6W4Xch0pOfl13bUeM0UUeRvRf04QVl+PK5emWubEBhbfObzMknQBiqnppQiaWqBO1um8CGrmRG+xO4fRasPNDUQV88gK/NGKTo7ddJciHRv5ElczbBjX6cI4SGf0Y81Ywq7VO9ps2xtMUtBTT7f9AMw5tDbI5tSKxNxYzeSDOG4urJUA3x6P4ml3x/x6HdcJbywAzAq5G5NIDRCy/7QNJgC3E0vZ3quTvz5zXF7R5Vue9IdHEi//ANnHXU9TUywspV10aucueZiHQ3Sa1xnyFfvYBFbcSJd/dw0oqQl3aI8bEJNI6JTj3Wa4MrcnY0gRA2fzDAEWUjBu1wMnmCtUXbysj1mexJIWdHpg22/2EBqAEt3G3y4c3vp5J8BnIG7rTuOcCPnDgdYGnC8mJym6mg+59DJGgQNLAfdHaxLLpBN3rxDtGJiIZpX1UcF6/X9gfkoFYKNkJ1YubMtDoJenTwkx1k61qLxvJsEf1brXZKqLAcTekCcwJyNL2QsrG1LPb7cC22VXuqH/vTvQMWL/Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(7416002)(316002)(6506007)(26005)(8676002)(2906002)(508600001)(54906003)(6916009)(6512007)(5660300002)(4326008)(66946007)(52116002)(36916002)(66476007)(86362001)(66556008)(38100700002)(38350700002)(8936002)(558084003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNG6DoMjibD+JgyjwS/Llo4v08+hglh17HpZj5C7444VyMpMecZQzSTyLNy+?=
 =?us-ascii?Q?xp77jB3SSE8ElS/S8bf838KdzpC2DnzSP+imxYA35GUdhNaCYK+/7TakC3d9?=
 =?us-ascii?Q?cvkLcpDFqBsA5fU+RPP43wEufLOAWZFPWNJWJQnHb9oC9mj0NZiFujx/HIki?=
 =?us-ascii?Q?nJ0s+DKdquSQsDKuhlyzR9+BUUfI/ooNJch03BFkjPd/N1oU4tb0WnRqvtXU?=
 =?us-ascii?Q?gFPTmyELc7SvzM2Cwmvn/5cmZIosU2coFdtAJQ9gj763NhWKILT45n9b+aan?=
 =?us-ascii?Q?DaquhQpJ5F8+6PdMeun+Xr/boX9WrRucSo8JscUbBc9V42GGr84Z0Fq3rl0L?=
 =?us-ascii?Q?JEL1I8lXg5WxpGn/vrpk+uiLEbWtbqwgKU9OfkS5nbQkUs+pjVWZc7ef6q7h?=
 =?us-ascii?Q?obbdFWeLe5GpscSFT/+EDaEp5uHQU0GIVxT3c9a0dw+q1trPuirVx//egn70?=
 =?us-ascii?Q?L9pqilKgDBgLxPLy9LQePmk0zndTNoo9u7zN6HEf3vrh0wEKLQXPcYWrqhRL?=
 =?us-ascii?Q?Fua3d7wMhOYq8gOTBd/j4hU3mmjpDgIz6wgGvj3IVRNIPCOTIaS5Bd6prkY2?=
 =?us-ascii?Q?3Row8feHkJLcj6kV1wHxxE9MHEbztgDAy4p04wdL3sq6Jh+WxoF78GPn955f?=
 =?us-ascii?Q?jjHQVqJR2uNCz4VE/Ll6gCvVw5NlU1bih/RNdDvvNBy0ywVbdidhVLB+xkU1?=
 =?us-ascii?Q?a50cVMyRl1FaxwNIoIiAj890TTkyw8SGh8f80Lfmo6Gz444haCLH3H8fBx1f?=
 =?us-ascii?Q?qvliNPVcyhnKhABLkIhIQYKHQLR2jSc3ZP7idXvjqE9lc+trQcftKE20G0Wf?=
 =?us-ascii?Q?P95EEqy5tfnICsEK4LK59ElakJodV5r2ITvojUkOwTMCON5OKuKy4XkFyLdM?=
 =?us-ascii?Q?G1g55gtdCtlhuNpMSrafi++pR1Ew7SlIqSK8qL7bCQDNpHDQWpviubOZxGx5?=
 =?us-ascii?Q?tL30GcUd2IcGjADIVX+lF4jGl/CSM3NPoj2nvzcp/FJlhAnp/MOm8q5m8c1Z?=
 =?us-ascii?Q?eI8zdfZDIIhz/IY5o1FEUSnZ44xaj4HDcMHW8Qe6uW98LBh2Tp6TK8U/Hq8z?=
 =?us-ascii?Q?N0+/55SSjFoTuSnogXDdhhHhwk5II+ddFvIut6pcZ9q4IDe4ctSKeptAwhGE?=
 =?us-ascii?Q?WRUamfcW4DEQ6OAdpkKJkYTJXbcGqv/LBUt3ye952vFZKjkmLbyAAhgBpNLv?=
 =?us-ascii?Q?3hB1zssNd1Mc87GeA0UHn2BCyvUIfDj3Pe6avvbpx60vJYJvYk2by91+IHsJ?=
 =?us-ascii?Q?IoTY60LiE7z4LxGtzJIepRXU7Rtg6pcHjlOKm1uNS7EKH5W1+qgh480fJKKE?=
 =?us-ascii?Q?63V037MtbTy0VtOP/neh+zwogjR/4I85JScpHPIRO91jNEiBcqZ90lvyoTuw?=
 =?us-ascii?Q?YCrJN1Vxstd8tN6YoG8jNtT/TI6e2ZH6i3b2BL+QN1TqhLYIJkdUDukOoJEz?=
 =?us-ascii?Q?fZqYX4yijVHXfdD52s1xCwmz14VrrobE6L0rgXlSxwcTPGZDGWpIiplaq25a?=
 =?us-ascii?Q?MJpHer+Mv85rp/qMZROkYU6juBQohlWfYRdaKZVbm7GUbr2JpPJ9E1KyB1Om?=
 =?us-ascii?Q?CXy1jyDPQRiCGLkEVSL1MS9HHbtoyeBeknqRQeF9zasx+VTZ3htXvfzvtnkz?=
 =?us-ascii?Q?r6HmkGlqUkR3C64eQhQJ91zfDoGqTNTMkKNA+SeZU9v//8JUWNwnKtGhwE3T?=
 =?us-ascii?Q?Pqlz3qzdgN7OC0qurdIjPac/EgoD10fKJKb+RQSfZGgyOkIMMB5AN65vRMeA?=
 =?us-ascii?Q?479CrVJKBhust+Jd1bCwCZ8NHTxBMgQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a98cb4-bd2c-4399-1af5-08da278522e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:03:19.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc5H/bRRJhhzkuQwIezuEhAh9sNxPR1HI8s2gYu0FbeG1PvS1x0C7IU86vqK4yAkRyOX0WLcqn1TKL9fhKSn9Sw9uOFk1rVj7FlcESyxPwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=620
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260082
X-Proofpoint-ORIG-GUID: gvZ2Rq6Go2GRc3KvzJelmQhN6kcDKIO0
X-Proofpoint-GUID: gvZ2Rq6Go2GRc3KvzJelmQhN6kcDKIO0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If major equal 0, register_chrdev() returns error code when it fails.
> This function dynamically allocate a major and return its number on
> success, so we should use "< 0" to check it instead of "!".

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
