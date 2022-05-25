Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10155342B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbiEYSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiEYSMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:12:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54236150
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:12:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PFhUM5030634;
        Wed, 25 May 2022 18:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U2up7R98fB5xkkjzPJLexxXd+bqlvpt0X48W7/jyMWc=;
 b=nQwrk+nHVa4Jscl3S/NXePLZdWaC+4PdeGdr0Sy1edZw0kVwsUSib3wGlA5heunaznh/
 b2GxD50qYXKseyR9NHKV9wdBxec050lu3gaSnArM15+xNXLFLh6CfY2qBmfU84VYVCNh
 Xd4nq6GIuI9Gg7EiVFIKQ2TJ1dEo2AxqHZxBQYrN3mtHVb/1pC/wCiTnUZhwM+g+rDMh
 wCa7Me9yBOe8i1VnwFVo8Poem7zI1+aVoFsPaGnf+1/fdtAsI4EaWjsXu+9CluVHBqZ9
 oMRWb8iySmorAeUFzxtPfsso2PGw5yq6VSt2Xe9HY1lHnASF4wG4a0bWUGuW45LQdZgw WQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc30ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 18:12:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24PHxOnA040134;
        Wed, 25 May 2022 18:12:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wvjpq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 18:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn97HidJFaQevq2+grZoRfH7kWzeEPffS06Yc8Rh4S2PlejyPsY1k0FPEt/sebovkYReyeRlMAV6dXoFriYrd+47+qiXkkosRz+kdDE1k1Jt8/uFHAi9p6REVXmVzaGiyyovj3fZEZovkJY30MdqBDJD66rfaYnrdcpTBWEqjAwcA1NvCWv8MOHLyD/jOrJagG+hylp/HXJIPzMwgvZeatp6tcF31/RIWY0ibTt9SVX57zDsY9zT4PyRPnP8ETxjfLV7/ordvRMWMRFvnXsmDzx2w0ufzvGS/GTys5RHhxs//7sBFexPSF3JVaWWggxVMIIWlZfAx/J3gSp9wE+y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2up7R98fB5xkkjzPJLexxXd+bqlvpt0X48W7/jyMWc=;
 b=SXJN+oSgWHgatQjzxPx8plCuDntc9wKmBUywlTiqSHIIegEf5H5S5ze/+mzP1Qrz4il8EH4FQrkAiUOgld2kPBoMJq/76irxaTZH/0ATDFpM+u8GyFYiztGBGEZtbfqnGggeB7CQXdHhYC3AY6RdNIz/xiT0PG1HVhdeacWevIvQJypDKLE/bPut1ncHfwtkisLP+S0YOXYiwMw0+SfzcSe2mo/LAyag+xYWloEgh8ypEZsufcKAGJKsJlJSVMKJkop9ZZjdAyN21Q/OLFUcB2FPhromCoobl2pBDwpkAH+z4tcLiYJc+tt6woQcIr9fYIisSmz3Rvjho+xWnGs0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2up7R98fB5xkkjzPJLexxXd+bqlvpt0X48W7/jyMWc=;
 b=Fvheg/e+44nRNE1ER59LGYLyBJy4kwsd+j9Fir4CPDVB3e5g4De9Ufse+7gAaRZO/9ebc0R6Hmxye+zEu5Ll/Kj9vzoFaY+aruAXWznaDx3iKvAt9Ne1UEO6hD1ls2Cukiy09hueO89m2MbK1FTXveZvmowTH8nYZnRsqxuG8aY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3048.namprd10.prod.outlook.com (2603:10b6:a03:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 18:12:24 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 18:12:23 +0000
Message-ID: <a41683f3-8d47-2b51-2034-d7b19caf702f@oracle.com>
Date:   Thu, 26 May 2022 04:12:15 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/4] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220519072658.736370-1-imran.f.khan@oracle.com>
In-Reply-To: <20220519072658.736370-1-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d1dc232-2f9f-48e6-b7d5-08da3e7a1de5
X-MS-TrafficTypeDiagnostic: BYAPR10MB3048:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB30489616F1DDF00643EA4DBBB0D69@BYAPR10MB3048.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hC3k3g4EuAZ70shTlmM5KZBPBSNMvCGDUNWwMkYuogoZnrQfON1Yg9Dsz1+qvMcMNpb7poTxNDkXKx5JC5k1PAn2HEJ847gmP1fSve421vfNwKIQBcudsfm5+mQT3PwK3ctTRE6N60ihIAAeD6wztyXxeOT82RlCFX4Vo1+zpA3HgK6aMoYzGW5OMOh+P0PH3oMN4hvSLlXqD0XycNv2IcsXL1EjQaa9g9rqNWNSEefwV06G1qUMBp4/xYVJQUnBwEIj65YmpEmAg7W5rYTY3rrtY4ot/5XhBCqUkr/qL13k/4lLP+aZZ0yy7mZjMdjO/8us30X05w4+lZDH9x8A0Et6ZZRGYqTO23bQBDxvoqMLWgOqagRLivF4O0k+U0JG9e1kj6jZRJQ6jLmJmjJ/YHXefQX8KZFmqfrmYRcvbj72jCGBZm0/fYGPWenmEcPBcHqGNJVx7AdyjPO0icBFaTcDchyUtqR6sW5ObH+RhovAEej/ojTlOJvXHbiDz8g8JJaYRMB+83iNcRJuMt1UJOwizQkCtL+d45SZwxP5Z4gjC6SXYezzlwq5cbd148n9Vo/UQ9dn2MNlTdKeg6p7jMr/3/XuaDPAigxRqW5LHkunBGGhcvdRE2Nf8bF3abWyiZEXN+Bn8eSfZ8nENbk3bmHDeEwqkv/2vLkiJBjPy9B+Ehl8X4feXD6supN79xp/brBH+HMESOMznkTq0yKs7xh/G2nlc4RcxPbaracwOtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(4744005)(83380400001)(86362001)(186003)(316002)(6486002)(31696002)(38100700002)(508600001)(2906002)(2616005)(36756003)(8936002)(31686004)(6666004)(5660300002)(26005)(6512007)(66476007)(66556008)(66946007)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHh3dTN6eENTNnh5czJMMXpXaktTYy92RXlwR3BianRNZWk2ZVRQTjFjWENL?=
 =?utf-8?B?cCtNR0pqUTdkTlZGdHFxRG1ScXcxUkF0Zy9YMXRhWG1aVGFHY3NQY01jb2FG?=
 =?utf-8?B?ZWIzbmhSZ2Ntakk3cFdtVGtmZW11U1J3OFhGLzNKbldkV09lajJXcmNXTFh0?=
 =?utf-8?B?OGdVYXFhbGtUYVQwbW9iTDBEdkl6U3NkZE5ZaXhRakxsUElTdGFnM0FWSDRJ?=
 =?utf-8?B?WDIvL3VPOXVoQjBWdFlHUkFHYlJYZDVtYjdXSURvWjBoRy9MZkthVXVzc3BF?=
 =?utf-8?B?Ly80ZmcrOFhoSEdrTXNRSkdvallwYWlHUXk2L3FibFZyOTdzN2lCWWcvQy9m?=
 =?utf-8?B?UUpIRDNIV2ZQdVU2QzlvMGltb0hjeTNOMW51TWpQTWJmeUUrTll6Y0VSemw3?=
 =?utf-8?B?SXYrWmNSTVhFZ2pST1htdk9RN0xWemRDaTEzYnUyNVpvTzBSaVdEY1o5YXow?=
 =?utf-8?B?SUhrdUZMcXNQYW9Uc0xBSlNDL3JzTmRiQVpFZ2xhd3ZPUnhMYWpabTdWOFk4?=
 =?utf-8?B?MlZxVGRuV256byt0Z2gzUjNJQjY0VVgzQk1tUXE4SXAzMWZsdmdwWUJXOXdx?=
 =?utf-8?B?TnRwZzJsS2J5WmVDZm1VY1ZyNjFKT0QrQzFGc1l3ZHFja1crL1BKRk9Uc0Fi?=
 =?utf-8?B?alI5ZXlEUWl6SFBSd2pDOTNCTStrR21tVU9GbUdHNHFlRkVrTENsMU9Cc3Fw?=
 =?utf-8?B?a2grZFIvOGhRUEQ1UmJJb3BmcTdvM2o0c0xzb2M3QTNVbWx3ejZvVG5ZRm55?=
 =?utf-8?B?djZPbnJtNmhNalQwY3ovSXdzSm11YWRoSy9DZmxSNzgyTkFyWnFGaDF5Y1Jy?=
 =?utf-8?B?S3BiRmFINzJINElGMk5CQng2TEFobEYvT3A3K0ZsLyt5S3Y3WU94SGozZ051?=
 =?utf-8?B?SUNjZytOcXpJaTdleW5VYU9VZkVmem1jREQ4dFdsaXJZN211aGxPWlBjVU5S?=
 =?utf-8?B?T3ozRGtpc3VNblVEdlgvK09VMVR0L3prdHNGaFluc21xbmlUbHhDRDNpSHJs?=
 =?utf-8?B?QlVPL2h4c3JEdXUxb2NLYUxtdVI1c044a1FCZGRqbWcvUXYvMGhQV3BsT3BD?=
 =?utf-8?B?RDB4TFRQc21CcEZnVWFlZWp4SGMrNVAwSXEyOVQza091aXJrQitsNGJvVWRU?=
 =?utf-8?B?ZHNPc1pPbVVWSzZtRkNCSEJ4TnRRSGhCRzRzQ3VlUEtiajBtTlMwa2Z1d1BQ?=
 =?utf-8?B?MnIvcElQY2w0UWh1aWJ0L3ZHWHpGTFVjUUdqOEVYUjVDNW9ocHNraTl1S05D?=
 =?utf-8?B?N0txelp6TGRuQ0pNVGxZZGpCWmRNUkY4MXl0YWJlcWxVY0trdmNaV0xRSklu?=
 =?utf-8?B?NmFTbFpVMGd3QWpBTkl4ZFpnYldPZzU2VWJpMnpKdFo2U1YyTGVtM0ZjVFFU?=
 =?utf-8?B?dVM4MVpKRUp1a1loQm5lRFVOVUZ6OHE2djNkSE8xbVJYSXUvSktsZ243d0FO?=
 =?utf-8?B?MkJPWWhFcVcrTWgvaW44eFEvNkdxUTEzUngyQ1hzVCtIMUttemlHVitaNWho?=
 =?utf-8?B?aGFpNHozM0NSWExMNFI2aFJGeElmTEFLL21LYllsOTlNa2hFdGs0TkMyM1Nv?=
 =?utf-8?B?dnMzbitOL2pFK1ZUaWJhVjQ3MVExME5ld29YaVloWlJFOTRaUVROLzlNS1lm?=
 =?utf-8?B?SVZzY3JOM3RlVFR1ZnUzdmRqQ3dGeldyZFhnYlUrY1BsYmZEZnVNK3BvNE8z?=
 =?utf-8?B?b1FOZmpNNStPOVJlclJqYktLLzFBOUpYY2h1MytXYkhnR1hQb1hreWN4OFA5?=
 =?utf-8?B?b2hLb3hadEtLRGJNNnAxb2RJdmphQml0NmI5Wng3Qy84a0x0NnIybDlmOFNO?=
 =?utf-8?B?bHQwU1I3S1JBdm1FVjZRYndVUzZMVHVHQmJHekNDZU9zcUwyZFB6VWovSG81?=
 =?utf-8?B?L0NWMTlDTFErbFFVQlFIY1ZpOEEySHlFd0JlVVR6OTJabytFODJBWUtSNEUy?=
 =?utf-8?B?a0tCcFNTMGRGdXNyL0dnSHkwcHVLbERVTzgwTUpLdUhKTnBwYzh1SDBnbXF4?=
 =?utf-8?B?d1dpaS8rWXN5OXhxVnNiUGs5WnZzNm1ZSm14SDBHM3JIMjk2WmNvRng5UEVv?=
 =?utf-8?B?R20vOWlYeHZlNXh3MUcxT2lrcmk2Y1BzMThTZEtGWmhubjBtbHN6Wkk5UjZt?=
 =?utf-8?B?K0NQQ0ErWVV5dXA1cGJoejkxYzBiV0pVNnR4SHAxaXpzYVQ2RGNncCtaM0Vt?=
 =?utf-8?B?aUVxY0xteTNRQkluL3d5MW50UHREUHZ0NzRHeHdQaVpIRDN2dGtCVzNmN2Vo?=
 =?utf-8?B?KzYrTEVpRnV5c3Y4akJ6NXF3dldsUHRISjNlV0VjMjV6c0dJNVdnaEJwMWo5?=
 =?utf-8?B?MGsvcTZLNDd4MTJqSDc1K2RyM1VzNEg3dlBXbEVxZHJDSWtlcTZ2WnBBZzNa?=
 =?utf-8?Q?dFZwxWEvUBR0eHtg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1dc232-2f9f-48e6-b7d5-08da3e7a1de5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 18:12:23.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zsWwWaIoeKwhKeQ4d0BCn3xDbsF+Pkt6gg3Io3GMepiLRSFRol8GbTnDebepbhX7wSe8VUxl986peesTq1tiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-25_04:2022-05-25,2022-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250089
X-Proofpoint-ORIG-GUID: 7O3LMI42M2JZql-7rIg3RPcd7nIXSMlA
X-Proofpoint-GUID: 7O3LMI42M2JZql-7rIg3RPcd7nIXSMlA
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 19/5/22 5:26 pm, Imran Khan wrote:
> The patches in this version of the patch set are as follows:
> 
> PATCH-1: Make kernfs_open_node->attr.open RCU protected.
> 
> PATCH-2: Change kernfs_notify_list to llist.
> 
> PATCH-3: Introduce interface to access kernfs_open_file_mutex.
> 
> PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.
> 
> Changes since v3:
>  - Rebase on tag next-20220518
>  - Rename RCU access related helpers and update their description
>  - Address errors reported by kernel test robot
>  - Include Acked-by tags from Tejun for the acked patches (PATCH-2,3,4)
> 

I have updated the description of RCU access helpers and have addressed CI
errors as well. Could you please check this and let me know if it looks okay.
Patches 2,3 and 4 have already been acked in earlier version of this this patch
set and they have not changed in this version. It is just Patch 1 that needs
further review. Thanks again for your help.

-- Imran
