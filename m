Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EE51978C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbiEDGsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiEDGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:48:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11171A830
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:45:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2442W2SX013665;
        Wed, 4 May 2022 06:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xkpSkqCzY9hP+kTadBzX4rM2duzul55zN5GQgcelV3E=;
 b=m8H1yakKA1sq4jAhmv49SHcF871IU0PZ8eJNoSUYcpF5BqW46QHnaDvCp4KJquKdjY8l
 b18AzWTCyyy8ht+RnPoRzkOtLIj/kixZ5YEj65uk6KX3KVmhhctd4GCp1nbLzU+LpwQX
 Ve2COkLnmqn/LoqvPrp3rJy8wDA7xTtXXGgv0n8vGkgodor/ndir3Ri1jerpBzO3T7M/
 Eh+cmtDJcEJ1+RNvstQ9vk9PfDZLNfhfC/JFlUAeHYNMtGlqJ0j2OJxDxG5/WjyIu22U
 wr+xR+6311xMyapmS6AiUFp5r4+ieAOWR5gVDqcQdIRRC6IoSvB11jOvLWq2rTnGECOd YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsfj51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 06:44:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2446itoT013557;
        Wed, 4 May 2022 06:44:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj97mna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 06:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsPCba8BkDpsLKLiM/45957Kha1vaKpxrR6cAv2DgbCM9G466Ruf5gOKX2KBUhUKQT8aZAXoIJjqyHq99+LI9BN2pv9nTwYnwMCgACywCG3opy66PtBg3IUl47P3qs+7AnXYDubUyi/zMmFJZXHyXF6ri8DEZmcDIyDGrVRhrXkPUbLjFKLNln0f80NiCLKr1AQ/ohibUHo7KbQP3U/BI6HaJJ+6Qx6UER5MKe+EdO67OcTFMHKkfP3wP3/s+pKy5AGMS946IhVtooLs1nq9oVAsQIVbECZB4HlliejthAVaL21kfnCTLh6TbzFsfSCvZCFAephwtYRvbLBGvOXP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkpSkqCzY9hP+kTadBzX4rM2duzul55zN5GQgcelV3E=;
 b=hG/G+uW1O6Usa/bUSThxbq6Uo6+1xRcITyz2n1gzduDUL9ta4Hy6nrzXwy92KaVo9tS6HQgpO/k52BOkpMrS6Sh5LpJjeqvvBNcTEY74d/2+zHIsiVyg7Bf1SO19Z5xaB3EL3C2+sFN6FFgRgSDthajBMrSUQ1eIbXxAp41AC8UFDI4zz/TBGXpvJn3Wpyfe+8I2du3zJwPO5KhVhMFLri87mQc9kUsosDu5aAZtYdaU+ePZjYJxqC2Xv9LlWV1lwGoID+sblyivQU9GJHUsZlSA6h7tFwNWfvIpVhGwNL/bo5qK/8i/OYYLIrbcMxh2K4z7mt8/WQ7c4k6iGgjcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkpSkqCzY9hP+kTadBzX4rM2duzul55zN5GQgcelV3E=;
 b=RStJzLEIG3X1GcxQ/AWGQDpM/QRux+LeCSmrafCCNtByYFR8GFHAbw1asTukIYolBJT+d26hux+N2iW9AjLbM9KCt2YcjILAftkaVDLOstkDOHlLRs9iuoYExYJiRMfdQWLNR7SJXba4CSMqWd03Uywx6YqRg/+MOU5ysnQjZYQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1265.namprd10.prod.outlook.com
 (2603:10b6:405:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 06:44:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 06:44:55 +0000
Date:   Wed, 4 May 2022 09:44:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix late checks on pointer
 dereference
Message-ID: <20220504064436.GJ4031@kadam>
References: <20220503121047.3590340-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503121047.3590340-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae47f5da-c2f2-4aa6-9cb1-08da2d999958
X-MS-TrafficTypeDiagnostic: BN6PR10MB1265:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1265A2236D6B18DFEEBAA5228EC39@BN6PR10MB1265.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1cepUlhpd9KL7aj8NPp6k1AEqMSiCQkP2fsjmC2G2dDTggjmMUQRWQ4BpsCCq0ceKMJ2Ct4iu0fG+hM4fWmI5J+hV/RG2dShAboVIL8y3I3eFlMb0xTS9RhyR/cieQb3YeC+brivp6rgCYXZVuqXI3W8qSsR4Cpcl91wZ5gDpcGro6fDobQX8VeHgfK6SPUMMBKd5lQHrPpl3TULO9v7e0NJ6O7DhVhfDyrnfW9slsFMWO6OXsLkb/SZPwg7iOZTSM+ke62eAYMxGI1af9jfXIa8tTmL8K0vKtdi8yE1lHhwNf+E9QpkjW8U3vmHHvGOjnHuQspQUjUL+HWPXeKZk9gA46NSHuNPJi5puOIdiTxmAmoa54+3qUpbMFoLsoquILcv254h/iSw0xZGuUZYZUUFaKwt04UHPrilqeJxDNel81c8gE3r52hq2FCvQxUu9DO0UeW4LvTE8y8K8hBVLhBbKL1ZZy73QS2pZ48xmxu+lY5J+adXzexFL+sCStfuEW4KcQ871TkLsiHrpKC38qhoKuZkazE5fy2wJFXyXfuaDoTNVDEIBGVn48/XBQN2WC0QXwOyrC/tE1rOpo/VJZsa5hPwpVqzydTI9QdNsR+uQCMzPG7iAx+113e1LloCKusr2Dx5fvmXY+Hp2WiBQnVAXwQbn6EJLHctHXuLtf4lcsb6UBwxxmHCfr9CkP+699pBEVnyJ/flmsDKkFciA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(8676002)(66946007)(4326008)(52116002)(6666004)(33656002)(508600001)(6486002)(38100700002)(38350700002)(33716001)(86362001)(6506007)(316002)(6512007)(44832011)(9686003)(26005)(6916009)(186003)(1076003)(2906002)(5660300002)(83380400001)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdXUzNbBbSwAByXLAeYdyRAJKzfEZUuE6YY5QZkQfqBfzeyKEcgTkm+oRuuE?=
 =?us-ascii?Q?aHN/hhXaqPA8RFDIiM1iHwNkadNJCRavcb1ga0go0veHABgcde9GWrro8KdL?=
 =?us-ascii?Q?kMbfuT7Sl5kAzURYeGSnp6Yg9/MmHXnWt90ALWuHCWsUPLKYOuqEud/KukdE?=
 =?us-ascii?Q?dbPJhD5BkTyoivJPhKZarGMFAVhAjr6mlbLdHhBsEhR9SWhCyjZqgZoqCZNm?=
 =?us-ascii?Q?HMPs1oZ/LYNJSWzHuQVsvwzOtL5EGc7fLzE5n3LIDONqV7+UPJcHgSw5Lxaz?=
 =?us-ascii?Q?9qUTjjIfTW5uYNTmUTONOqrDgiWA7DNrDr3GRSd6gN8VcFVXEiLi/1iv9roS?=
 =?us-ascii?Q?OHSzEDFJiQmKkv1Sg4vPfP/LnF3WG21kHtnVfPUPQfsVpDURHf9DcNmZU4rc?=
 =?us-ascii?Q?wR1oZvNbOvWwXYh3ZZwtqv10GMXmbysKhYvV4gyVEFDi1vrwTn4fD0Twhfcx?=
 =?us-ascii?Q?WOOWJMD1wzA0GaIfODpbPl3l4v9oX39IC9sf7vKGWgBGnd4WRd6uS+bFCohC?=
 =?us-ascii?Q?2fjhxIPsXkMg3mCE+vueMyG01awe/GVBc6ThumMDyva7qL+nYV86/ohIbHc9?=
 =?us-ascii?Q?0M0uGpnB/y+Zs0t/DKYo2HBfYEcLlUvO75IXBjPUqpzylbtw2ZNcXwGOP6H0?=
 =?us-ascii?Q?XS3OMhAuy5S8g1eJIgYSt3b0ii/wyQC9BsL3geqLMd/ZHnZdBKisQ2y94hrM?=
 =?us-ascii?Q?TUOiaFKN5CwJANYEOmiRv055x0UsQmWrfZ6C5VKiyjRfulGHQg4Xg1srK7dA?=
 =?us-ascii?Q?6+H2tiMzVNQF126FnbHo5/ISoEKpAiApEk3V7rOLL8leoOV5LK9O5Tix1wez?=
 =?us-ascii?Q?CRtGB9GK4H1+3BmoSpcqXwO257Fkmrz9uCDmvVD518+7HXngRCNP+N0JeJKU?=
 =?us-ascii?Q?n8McMht9Rj165iH5DIFOt8fvCgP/e+4gifyCQLymfGWareNA518ldHf7bozq?=
 =?us-ascii?Q?WYSAdEiNV7jtpCPXCr2s+B6vA0mPKkkF9zvzxBNLX3exJhsiFRLhI/tKClEr?=
 =?us-ascii?Q?rZkHPUiVM/nWJ30glq9TwJFYA0wSRtO/r4pkfQZq6ZpRT9NbrLodlVk0ZD/V?=
 =?us-ascii?Q?Q57hxakT62Ekc/SXLlpDz2hpHivKsgy2p/PDnq8SXuWBHzzaDi3u/RT8yWiR?=
 =?us-ascii?Q?YFAkqSNK+F61Im8nuxRQWFW/GwzsWamcmCBbX0ypujLWAlSD4RpHZotqqrmL?=
 =?us-ascii?Q?ih9E5mBNUaLva175H47uOCsge5zIDgPxhni11y1SQhpcfe9Nd3NZ4hbPx1Vk?=
 =?us-ascii?Q?vDNmB/ljwaKMYNkOebIuwW4JYCC1lx7VWnnLVOQTCEz4MYHOm0MfY4q3+AlL?=
 =?us-ascii?Q?wRkrcjhJoR2rbheKs/8dsC9Yhe8Qqv2/w/YcbormvyL3IC8USzCbwtKJIE+F?=
 =?us-ascii?Q?dHvgtG3V4XqUXNEhMWYrrSSyMfzG65Pl0kpP/ZnFtaySmNJI7y2xpObEOe2y?=
 =?us-ascii?Q?iR0CLkqr30Wb/EHe8arORsU1LSflTkSDCmxhgwRHXrm4RkcbvYnzC/DYWHHO?=
 =?us-ascii?Q?esYYVNHUGZIDAy+J619SDPMGgZQnKl5b4dNQ0pz0o5E4GcwwpcovCVj1eu7k?=
 =?us-ascii?Q?PBDkxJHUzGB6Su0A1WpM05RDQgs8LVzP22rzTnMEhvQPnlR0lOdWeoJsegEQ?=
 =?us-ascii?Q?DON5IQ01iH6W41jGSfxslc5NiNoBQttPM9OSyhi8PPXPcIxLc2R02q7UBrzu?=
 =?us-ascii?Q?gnjdV7L/Mc5bxNHC3rI1S08a9eH02Rl2aqhE0sdMDTUigGlmfzWZtPDSrdtE?=
 =?us-ascii?Q?PjSBDM0r70MffgYi3nPHMlwZlyl1cII=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae47f5da-c2f2-4aa6-9cb1-08da2d999958
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 06:44:55.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cz72N0TT6Q6JEMpxLD7s5F/E8JreEBckyLSwVCt14t2YfCEcyvt7li2V4tgbP4T1bFfTvBidNCEuOTugfF2xQKaitCY0QBSJMhHs/6fQ/yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1265
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_02:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=774 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040044
X-Proofpoint-GUID: 7TD0vztVmLQh38xSxdWYYyzqZMOdzWGM
X-Proofpoint-ORIG-GUID: 7TD0vztVmLQh38xSxdWYYyzqZMOdzWGM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 01:10:47PM +0100, Cristian Marussi wrote:
> A few dereferences could happen before the iterator pointer argument was
> checked for NULL, causing the following smatch warnings:
> 
> drivers/firmware/arm_scmi/driver.c:1214 scmi_iterator_run() warn: variable
> dereferenced before check 'i' (see line 1210)
> 
> Fix by moving the checks early and dropping some unneeded local references.
> 
> No functional change.

If there is no chance these can be NULL then a different option is to
just delete the NULL checks.

regards,
dan carpenter

