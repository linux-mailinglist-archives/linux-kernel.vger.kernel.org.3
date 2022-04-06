Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB14F6079
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiDFNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiDFNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:35:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F7463AC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:54:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235NRhH2004895;
        Wed, 6 Apr 2022 04:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1ban3eP6943JOmD8XcIWhKgViPNBZvRUteug+BlLhUQ=;
 b=IGlVmHwgzqz1ePWmjQAnM/acRrY27rUk566whxQM943WAOaMuzskd4vCOcoAv8BkJaLX
 NKibS6kNVemRBa2mhFUam0udCz8eiaV6v2zSoKEtCJYyiOTfbMYt7v1JRiST+bX8jlHY
 8NQLFjX7vB2SE6FI9if9F8j/CN641mTJjj/npDhysNyWu8cswPTikEkpPmd5ijth4T1e
 OzhzsDHuffwxFBadqE+m5grwzom5aUp5IT99pfmBop/i+/YacoJONGmc7h6babnUS9Dv
 hZt2XJJbLTwMMywcCmAtIrhLHENjA+X+nw8kOSKr8MAgv2MLujiPdaHcovk6ToUprQWA jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92yswu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 04:54:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2364opZ0032824;
        Wed, 6 Apr 2022 04:54:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx46bws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 04:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7MnhnZ2vNs4HJaHAiMtJnaBZD5nk2OhxagCt2hMhaDnduQNnQNTQGC+AqizwU3EE7VTsQO9vr1UhBG327ptI2gVvPwh+lyhChRGHEZjvC62wvWAIy2rx/ue3atwMETSwnvNgkuAqrQkno5cz48f4udaHJOPz99mszfB/PGfrkAozYFT+EBdMhxJnZ0xMAkl29Mes4JArggTQeOz8iMWfR+2B0thDsAQ1uFEntFZAbLyV0RUNs/LcY1MBk0AT3S9PWJYF/hHoE1EnJZKFjPB3UkAMq2tpsAD3EddjIq+NaBpFcsrt3uQuHbQtDJwPZkKgA2fulwF/PVDp7IN6Eds/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ban3eP6943JOmD8XcIWhKgViPNBZvRUteug+BlLhUQ=;
 b=Xn+olLjQbEyQjy6Q5irJWmu/Hn51ouzDBarGFm09FcxT64siHoDXUys40Hs2e8v8RO5+XSm+E23N5f5b0BX2mqqjDSB+EH5JRUyulq5L9nhu615kyAJTACzt1O+O4TyFs/TrSr8toT4Qm7wAKlS2lJkXDp96IJzjfWQJY5cKL5Yxr/38Hsb3Wj0c/m/qh5Na9c1L40wV+y6e1JF3L+klQC5Av8AkU/vw4rdlJOtMn9V7eEh8lgSP7rZEmCMiRa/QB16VoveVOdKlX+fdHPDRIpOFav3wP770qXHVzpP0rTHyk0CwO7wcXuDvAxBRf2oGeVOz+AA4/AeR0Wb2+3sl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ban3eP6943JOmD8XcIWhKgViPNBZvRUteug+BlLhUQ=;
 b=gEntpFwJUgUybHa2fO369tDV9Z54LE/6iFLlTisgFth7UYdadNWKJUgHVXaiwUUeL//zNZosOAdKr3Dol293c0GNBkv3M64GFW11fG+atFvrAiQuGfhiVBiZQQzo8/KIEM+zbqIoFvR87HKwf3FGfpL2R6exGQ5wuWxx/QqztZI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 04:54:24 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 04:54:24 +0000
Message-ID: <0dfe1056-3dc5-4d31-698e-e2c075ffd6ee@oracle.com>
Date:   Wed, 6 Apr 2022 14:54:19 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
 <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
 <YkxRDJ2ynEHGdjeT@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YkxRDJ2ynEHGdjeT@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d1ae0a-18d3-4d3a-9cfb-08da1789856b
X-MS-TrafficTypeDiagnostic: PH0PR10MB4485:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44851B072CADB543E2462595B0E79@PH0PR10MB4485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LAfsli1jNMMPUQNpolJ+Z1hjm9xB64n/RGqOGO8CAEVYddOZN0PWZyJf2tt1Wru/jzLaxSM3eacOrUDYt333WisydimT9Me4h9fUSIaQYxSt4dj1UgbNyMTeLvzg548/WxmgSkZDHBRG3PHeRqdoxyXgG2qN9H1T5ZV565IHBLU2yTWXNU07UGXh7FqwdjF3wdcnFHtmqgT7UYfI+66asPFkbJ0yflm6FoHfgtEeHPbZ9/j5Di+lLoKPM2IgFULjlrnG/JzINZIz3mzxOMsNx2zIc9Q1bDzRYlJNtfj0+RbHZE1JdeHRQpyulUEeFdM1mdzqNkvEmDOwoohTUZZPRYKnVrYhcux3iQokxpgnlT5dOfuQVO04J+YDP+GPFOEVl511X5KbELIZus3nkVDV3zvu1kl6cjlXyYYSdeQOhm/vz6DzsYNiLGirs9oOY4nifU8bqzEwGrewXVBqCazzdtXY+dlkWtNqMSvIGQCrBOhtJ7Tj0ERQNiEbsrQ/M8yJ7rcG9UZ+9XyCoCpu289302fN6YdVVgbz04UgbI7iaCTrI/dZ8idXGR+ZuvCYcgwhsB/8dQWNd4D94UUHHw2lJtm+dimIAbwWmqUTRvGveSyUQHjyv13xlQuX6kv0Cq0kCToPb+78A0SHag4lGx90Om/qRpVeEdmVNKmqO2mITnkpUYsZSPXLC+5WF+gXHWNBhvfl7eEWwFFOxJAu3CkItX2RjHfQqc/PHDbwEKGkiOmsBTbt9EEKDfGEoflKWefMnotdwsAJKHy2iuK5b2r/pQcIJWP8TJu8UDZHcH1Ex1oFSoujfBcZ1W8xyTupLUqfaHxu7qceDiWzQodwChIwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6916009)(966005)(8676002)(66476007)(6486002)(2616005)(66946007)(508600001)(36756003)(4326008)(66556008)(31686004)(316002)(186003)(53546011)(86362001)(6512007)(2906002)(6506007)(83380400001)(38100700002)(8936002)(31696002)(5660300002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pueTY3Yi9EQ3dWT3QycGYvU1J0R3Z2M05ZQzJxQTV1cjN2dVBmZWhkQzNx?=
 =?utf-8?B?ZGFaOWplaDBidlJrbENHbElTeDRNL0R4ejRuMmtHMGR6NzhRVHh0M0FWdWlU?=
 =?utf-8?B?K0dZVk01QTc2aXFwWmUxM3RjSHJBTjIyd3FXYjlDcGJNOENvaWEvQjB1emk2?=
 =?utf-8?B?S2EwMFJsOUhJRTI2Z2lCTUJJZEZTOUVuWDgxeCtpcWw5NzF4OGJ5R1dZZUhC?=
 =?utf-8?B?emlDNEhWK3FXaUc4VnFRSENKS01vME9OZ2pNcEV4eFk3aEVSY3UxTWtVUmJO?=
 =?utf-8?B?b0plSisvcXFsSWwyaGRRZVZCTThZTnR2NS9uZDhhbXZEcmFocGJQZ2x2T2sr?=
 =?utf-8?B?K1Qyd1BLemd6WnpYSlltbWgxbHBVTVJ2ZXNQRUtlelNSTk5uTzJCWXpKeWFH?=
 =?utf-8?B?OEowU0taQkE3TGVBc1F5cGRZT3BtcWdYQzhRS2gzaHdmUEFFclk4TUkvOWZF?=
 =?utf-8?B?TVgzWmxudElCSDlvdmVpekw3Q1ZvY1hvSmQyNjF4NTlqWnQrNWJIcXpEN0pu?=
 =?utf-8?B?YSs3c2NkamNRK1E4QVIxQXVYZEg2QjIxVXZpS2Y1K3NiY29tWFQ3V08wTlZQ?=
 =?utf-8?B?TE1wNDc3Rm9EdEdCU0pYZldOWm1iNWhKR1N0SHZ3Nkg3WHhlZ2lmZ003RkUz?=
 =?utf-8?B?SW94c0l5NHRLaHlHUUZJd050ZnVUd2hQZE5VeEpFTm1RZzdmUzNrMmdDZlQ5?=
 =?utf-8?B?MlhQZjRKNDQ1NFc4a1RyaVNmZDBMNlZvWmFXNFVXMVUzVkZOb0ExU0FjSXRl?=
 =?utf-8?B?eXkvbWdqY0Q2cjdXWUdyaFBUcnp5K1JFY0E5azFRZS9aK2NIVHBYK3BlN0Fv?=
 =?utf-8?B?VzBSZ255SkRjOTArU2kzRUIwODh5L2JHZUQzQnhHN2oxM0Q4S1A2T1Y3Rnll?=
 =?utf-8?B?MUQ4RjhIQittSWZtWHduR01vUjNuTktFWTl3cFNGdzJvSmxIK1pHc0g2U1l2?=
 =?utf-8?B?TkR0bFExZm54VytNTFFOOWswbUpuWnplVFlCNENFWno0dHlVM0szR1krcmtO?=
 =?utf-8?B?R0dXNnU2K3J6anhaVGFuTEVpMjNpZW15KzJJK2p6YjlyUk1TM3gra3RrdFdt?=
 =?utf-8?B?Ump2VHFJK2RUVXg4OWh6by85Yy9RMmJKT3VjMXl6NVoxdEEwblU1WWEyYkh1?=
 =?utf-8?B?Mi94NFhIcHVHUkdxdXNpZkVoczJQRjRlaWJpMzNaV0tvOE9DTlIxU2h1STUr?=
 =?utf-8?B?Z2NqQkl5SXU1RDBGUkpVUjQ4WUlLRkhGdloyTW5tUER0RFByQTJlRkxOMlVD?=
 =?utf-8?B?T01ZMGEvZ2I3dFg2Z0UvSTU0dmtaTnV1RVZwWVJIRVA0ODgyZ3RYL0lnYi9m?=
 =?utf-8?B?bXUwRERDTGNCQm1vcjdwTW1KRVBSQm8xU2s1T256WVNJQit1N1IwUlhMM3lI?=
 =?utf-8?B?YzlmSFN6MHc3ZjV4N3MxS2lINTUrTlpkR1BjMkVzRGMyMXU1bDYxbkpFZjNO?=
 =?utf-8?B?N3ZQend1NFJ1K1ZDS2VqNEFWcFIycWc5UzVHWGc3aTUrbFBwT0hjdUxjcG9q?=
 =?utf-8?B?NjQxRmlMZ3crNncyTW9TdldXTlhNc2ZZblI3ckhYNFZwMFBzUGJUUUJLaDZm?=
 =?utf-8?B?SlE0WVM3cEwvdWU3SUtRb3IxWmE0SGZKNTlQMzBPbjVWTHhrRmZseG1xZmFx?=
 =?utf-8?B?QjlJaGtsWGJZUWtMMkZPL1BFNzZqWkVtclhIdVYyZ3duSDJtVmEybEd4RXdC?=
 =?utf-8?B?VzAra2ZaQWtIa285WHlEd2svRFpBeFZmcHBiVE9zaU9peE85STc5dXZPOTQv?=
 =?utf-8?B?SWdGS1RKZTBsRmU4SnpNWXczVFVkQnBBOEZTYUlLanROUnRWWklFMG9hY1RX?=
 =?utf-8?B?REtweGRtVGZzcUE2dkR1U212RjRwZjlmYUFtY1B1Y09ZemJvaklqcklyU2NI?=
 =?utf-8?B?VndvZzNPUTNmZ3JpWjR3enNzcU9ueVhUT2dmZzB6UzRQMDFiZlY3SFhnUHlL?=
 =?utf-8?B?UGsvSFJOREhqdXkvZVpoMmVGTnZucWd0YXdJcSsyaVR6UU9Kb0NPSGltb294?=
 =?utf-8?B?ejN4NnQ3N1BNdVZ4Tmx5UGp1RTNtWitNOHdiWVQweXJ3MDdTZDZsK3VKUURk?=
 =?utf-8?B?QmtNM0hCN09jOUlaby80dGlIbmJLSDlsN2ZmN2JNMndDcHdCREh5VUlrcFc0?=
 =?utf-8?B?RGZrOTJLZkpnbFU5dUNpa29INHpCaHNnVG1qeVlIZGh1OFZRNWtMNVRpSUJm?=
 =?utf-8?B?d0tOTWx6am9ZVGFXRHJqeVV6cUd4OEZQa2t2eGpRd0tsbFByNFpmT0RBNHBD?=
 =?utf-8?B?MHNVblgxNnY5RDQvQll1dEhrOEc3Uld2cE5PWHJkbXlHV1B2MEVHVUp5Z2wx?=
 =?utf-8?B?Qm1tQWpVeEVsQmRsaksxQkx2VkxmS2hobHNvVEcvRm1vZmYxcXZ6Z2lHbk1z?=
 =?utf-8?Q?/iuup3TT6siDxfF4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1ae0a-18d3-4d3a-9cfb-08da1789856b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 04:54:24.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuzxBqXCX5LYiL35EbZOpErhlaDLE1hwFHSbE2sJuei5zfQ/KH5o1z/IGA/K4AAgSPbd451wkKU8hRFiMtSKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_01:2022-04-04,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060020
X-Proofpoint-ORIG-GUID: zq0LL_yrTA7sjjCq7hpzsK_W-f1trciL
X-Proofpoint-GUID: zq0LL_yrTA7sjjCq7hpzsK_W-f1trciL
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,

On 6/4/22 12:24 am, Al Viro wrote:
[...]
> 
> What for?  Again, have kernfs_drain_open_files() do this:
> {
>         struct kernfs_open_node *on;
> 	struct kernfs_open_file *of;
> 
> 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
> 		return;
> 	if (rcu_dereference(kn->attr.open) == NULL)
> 		return;
> 	mutex_lock(&kernfs_open_file_mutex);
> 	// now ->attr.open is stable (all stores are under kernfs_open_file_mutex)
> 	on = rcu_dereference(kn->attr.open);
> 	if (!on) {
> 		mutex_unlock(&kernfs_open_file_mutex);
> 		return;
> 	}
> 	// on->files contents is stable
> 	list_for_each_entry(of, &on->files, list) {
> 		struct inode *inode = file_inode(of->file);
> 
> 		if (kn->flags & KERNFS_HAS_MMAP)
> 			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
> 
> 		if (kn->flags & KERNFS_HAS_RELEASE)
> 			kernfs_release_file(kn, of);
> 	}
> 	mutex_unlock(&kernfs_open_file_mutex);
> }
> 

I did something similar in in [1], except that I was traversing
on->files under rcu_read_lock and this was a source of confusion.

> What's the problem?  The caller has already guaranteed that no additions will
> happen.  Once we'd grabbed kernfs_open_file_mutex, we know that
> 	* kn->attr.open value won't change until we drop the mutex
> 	* nothing gets removed from kn->attr.open->files until we drop the mutex
> so we can bloody well walk that list, blocking as much as we want.
> 
> We don't need rcu_read_lock() there - we are already holding the mutex used
> by writers for exclusion among themselves.  RCU *allows* lockless readers,
> it doesn't require all readers to be such.  kernfs_notify() can be made
> lockless, this one can't and that's fine.
> 

Thanks for explaining this. I missed the exclusiveness being provided by
kernfs_open_file_mutex in this case.

> BTW, speaking of kernfs_notify() - can calls of that come from NMI handlers?
> If not, I'd consider using llist for kernfs_notify_list...

I see it gets invoked from 3 places only: cgroup_file_notify,
sysfs_notify and sysfs_notify_dirent. So kernfs_notify should not be
getting invoked in NMI context. I will make the llist transition in next
version.

Thanks,
-- Imran

[1]
https://lore.kernel.org/lkml/20220324103040.584491-3-imran.f.khan@oracle.com/
