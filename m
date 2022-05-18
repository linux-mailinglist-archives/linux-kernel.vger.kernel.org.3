Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB6352AF33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiERAdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiERAds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:33:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB136369E0;
        Tue, 17 May 2022 17:33:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKMwfE019084;
        Wed, 18 May 2022 00:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L57kY0A1KadQh/c1Rdo07FibB7w1CadrM47o0oRBwPg=;
 b=MHUk0DwUQvsGf1kIyxx1uMLG05/9PhColB3HHLr1YLmGSFSJQuGSNAl513hNlgogfUm7
 DF8qxoc9DXwKKTX9EeGk3dVljnVPZpEqMMsgQ56XVBrtpUtcUyHG7G8u9on7D/slLwGt
 Dth+p4q8UOkMjlc9Gnv6bdW47ucdDUc/qkVX0w/MCVWE2LmpITfRkT0mBZI1DTH0mr+r
 CSj6RPOrG0Ce3TAJ5lA9RxycYAtwiFAkS9VrduaXTEiJGRxfsWQ8DeO0q8lHxbaGljAe
 hMmXSOvSpXd1ojC3EsrdOPAjsPCSpokhpHsn38v6Jei2FRMOxIQOBVdXe1JYFltCZc+2 Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371yxa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 00:33:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I0Pm6X008822;
        Wed, 18 May 2022 00:33:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v3ru7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 00:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBOi82VjhI7QAcdvw7fJURth7kDz10o7LJUX+dlkRPfLde77PvTZ8T/QTaPdQNGDkc0beDd1W4h0+rjpxz9/yaJW01c87LQj9BpHNxoxdKtmca7WwhHMl9eEEPZFGeE6fPaUGyD3agOHmSUmISkb68cQm2DLWlGUf7hGscDM7Nz1/l0v5nEJwZPl4OCenFdrl6rPrQ8iaAjG+b73blKj6SXDEF0OWVcx0o8hCK7VMQiVW6CKRVzZ7J0qa/ilIat0kEzSuPBLU8nzTsETQdhkIPIOlybMc+yf+mGEmZfG/zCn0CGSvbFHLw8vtOBo5rSpx+kPWwarjj/2a2EYAJXHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L57kY0A1KadQh/c1Rdo07FibB7w1CadrM47o0oRBwPg=;
 b=LRvTam0KJlBrqYCuUogwZ3zmAXx/Gml/j+ADWxPllCoXw5T8wbH1SFO8yAdqPYag9MfhtQAfOkawBSw7/PMfT3HX8y+Q+kbZCaeHqCuw/YeI9r04csEEcpEksD16vMAHZvSo/7/DCicneYb/q1DCToA/TSxFYACnqg/vzt/aGejv/L5/pz5ItOS85rZsqvjimrmNrM81EZHcDj6wpFOmFNc3IFntpubc5Daqs8qz2RbZ3n9z/sOHp6vfEHS7A7gwHyBypyqNRy8D3m5PbMgF2vthPPMRB+yGG8geBh+DyH+nRVN0OewlDpR+TdsBZbWjOll/UW9bGgXeSbUUsnz75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L57kY0A1KadQh/c1Rdo07FibB7w1CadrM47o0oRBwPg=;
 b=Kygdf6rnnHlEdVN6gP5OgIE2w7kt/cOyhqhntoq9uRFGPXN8Bo2q8by/5/V8gxWk5QVFrNvsA/OHdgmIwYfVAivUiZfNZJV9+KTSOfbCcItA8bXU6ym/IK5oLbVJflTVc2E+rEeJ4UMU4VyAbeuPqVhgMD8ifpL7JT9JD3ZnV2k=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CO1PR10MB4657.namprd10.prod.outlook.com (2603:10b6:303:96::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 00:33:37 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 00:33:37 +0000
Message-ID: <9700f700-a426-31b8-9bb2-20d8bc7f3f01@oracle.com>
Date:   Tue, 17 May 2022 19:33:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2] scsi: target: fixup incorrect use of 'cpumask_t'
Content-Language: en-US
To:     mingzhe.zou@easystack.cn, torvalds@linux-foundation.org,
        zgrieee@gmail.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, dongsheng.yang@easystack.cn,
        zoumingzhe@qq.com
References: <20220516054721.1548-1-mingzhe.zou@easystack.cn>
From:   michael.christie@oracle.com
In-Reply-To: <20220516054721.1548-1-mingzhe.zou@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0080.namprd06.prod.outlook.com
 (2603:10b6:5:336::13) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d1aee06-8b94-480e-5c68-08da38660c2c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4657:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4657ADF9B586D4E99F1709FAF1D19@CO1PR10MB4657.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmtJM2beT02OTCCoD9M8Hm+4dZ4nFnlJGZJ1/1CiXMPyx017Hgx0KgsvdSJJcFncnGu9OWohwvAck6ni4WcWOxiu6x52T/ZNx34iWW1hWdSFv4QpZn0zc6Es+DCY/iSlDZjexu630SxV5NizKSb1NTkqcBc2HnRsmRNCqCLNsWFh+uynOIh0xXKJGZ6dzrOAgjuchn802edd2vq+dbxniL2HnZa4k2mEz/h0t0XIyArzRuwSefx8QhcdpFrgH/MreQc+z3wFsPtvKoDTQ/4F1zIJwBv0ClZmcVNquh0sLI0gpal3o9fNtAL/2nliuCgRZbBZ6TjY8jV6GvB/MV39MRzWSff4QTuRKc9xR8QQbstGpnOvL7cte15nGIX0WJt+4GV6gzZ6PgNSK+STfJJYOddpoXVxeG2lx4RUyr3bdNdnxYTlV6F+0+Elm5B7NdhihwcSaAHhOYPZek6kK1sjqmpx7md+hZI/GI6UtVTKVO9gl2JrOeGFXCNMVdGxC001gKsFyYSIv+YlnpgSzXfpJTWzXDWvmCqNFlFgKUQPWJjIZpw7C9+CDQoFQPmj09lN6v1qRTjL7rYpcSLULYomf4U7o72lwar1tsJHyE6Kguu+agyttZvLcm+75Nx1tY5m48MKfMIfD5AApLsTcmyy4R1Z2SYSXEwNAGl9JAGTyVIat41rhTK4SM5K7WVwjwDmEpRWVMjEjZSwpQTgSUX6aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6486002)(8936002)(31686004)(508600001)(5660300002)(4326008)(6512007)(2906002)(8676002)(6506007)(31696002)(26005)(186003)(66476007)(66946007)(66556008)(53546011)(316002)(38100700002)(4744005)(36756003)(9686003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZNSnc2S3FyTC9QZ0tJMFRwS1R5N2pncEpXVnV4RjZiV2dnbFkyTUlvaTlr?=
 =?utf-8?B?TEVQejh1c0Y1VTE2K2hJR1VYZVMrd2psNEpTMjNJL0ZJLzRyWU1lbTNuWU9I?=
 =?utf-8?B?eHh3ME5MVGsxOGRrTEZ5akZhMitCUEhzWWxIK1lUeDI0TzlvS1FTQzczdXBw?=
 =?utf-8?B?M0gvc3d5WkY3VnRjMm9pYzNrVDlrRXdadU9mSG9iZWpDRWtPNFZwL002cS96?=
 =?utf-8?B?YlZDNXFXbE9XcFVESlZYQktabjhScExTaVRwSWJhZ2I5ODBvdEhOM2Y0SjVy?=
 =?utf-8?B?WFBGRTV6WmdMaUlkcWJIWFltUVpvSVJhUmlHS0NMaWVyOTkvdXNPOEc2V1N2?=
 =?utf-8?B?YU42RHFQdEF3Mk5DR2hLMjdoYkFTaUtSak1IakZqcU5HTkQxZVcrOTR1UVNK?=
 =?utf-8?B?SWZlZVZmMFNONndnektKaTRLQWV4bCtlUk90UzBpRllRQ0RtL0lPM3RKbzgx?=
 =?utf-8?B?YmNDOEhwSmNtZkdxTllsKzkzVy9naldOaXRzVTh3QTltajZxTDRYTHZUZVhz?=
 =?utf-8?B?L3JQeXlIeEVGcnkvZFdadDZ3NUZ5YkNBZUIrRWxGMXpRbVZLL1R6bVdIMTdP?=
 =?utf-8?B?M2NVZll0bkVvei8xak43Tk1uMDFQSm13WDJvZEZiT21jbURSdW8rWEl3cFdY?=
 =?utf-8?B?VUgwRzVtalk5YWhLSHJ6eGZneURRcEloWGg1eCs4MmZJZVNQWnBzVzkvT3NP?=
 =?utf-8?B?VHRrcnVVT3JyZkdwU0Jibk80UThpL3M2WmdRUzBDVG0rMHNwMVJxTG9uWjBM?=
 =?utf-8?B?Q1RKRThneGozckNGUUJUd0FsYmFMcHN5bmVUUnJDbVdCdUFVOTdXODNHa3Q1?=
 =?utf-8?B?aUowQXIrSENveG9VenNzWVNKeWZWd2dpWEh0SDN4RkluMUlSenVuWVozZTNF?=
 =?utf-8?B?WG84TjJmTHFEamZRN01VVnR6MU1xNFdXaVZtS3o3MUZpUmdpdnF3SmlrSnMw?=
 =?utf-8?B?V2lybkRDdXVqeE5hN2k0UGRid21SaFp1R240TkF1ZzJVTVp3bDluSk90UHQ1?=
 =?utf-8?B?WDEzTUpYTlphTSt0WDdpbHZBbE90UCtUd25ESjhaMG1PRENxOWxoTVo3QTc4?=
 =?utf-8?B?R0xodmVSNWdVWXpsU1plR0NndUp1Nk1keTc5eTQ4eStTeTZnNFFyKzZGNWJD?=
 =?utf-8?B?REh4RGt5YUx0elVWd3F1K1NwcXo1c2p2czJxNU1OTmZMdHBXblFuY1Z4dWpj?=
 =?utf-8?B?bDFGdE04T2dRZU5ZYU1xYzd1RDVRc0VLM01zME9PZ2lEcHFxc25GVVM3UGxp?=
 =?utf-8?B?bEM2MExpbGl0Vlh1WFZIc0ZqTzlkbGltbE5EakFPMzBBeTV2Q1h1L0VkbGFF?=
 =?utf-8?B?cmQrbmNZS0ZoZXZNa2ZlUUsvUzB3dlZwYnJGcG00TUJTK3d5V3gwdWF4elUr?=
 =?utf-8?B?Zk5TK1B6bWdlcG1jYnB4dGdMRGc1SlF5enA1OVBxKys4aU4yb3ZKak9mSWdZ?=
 =?utf-8?B?cHdPWFpmNXp5dzJMVTlTaGFzQ3BLSmp2UUhPaXFYTzVCUUViYWN1Zm5QVEFm?=
 =?utf-8?B?WWNrbWZpc21RcDQrUGM4WFkyMXpGZW9BbkRab1U5c1RzUzViY1NOVnM4TERY?=
 =?utf-8?B?VWxkcWZ3ZHRPT1BTbkluR1BKSnF3dDNzTmdsSnZkcXFLWWZxcXJWMCswemcw?=
 =?utf-8?B?RFNJY2o4UXpWK3pHQSt0TlNxakMyTnBWVksxVE9iYi9CdmducnNMR3U3ZnIw?=
 =?utf-8?B?eTEyZCsvZ1JTNmF4NlNnVVBsR2s1a3Ywb29QYm04K0VPbmZCalJDSzJxVjVj?=
 =?utf-8?B?aXRYRks5SzllMkUvUndnTVNEYzFMWXhuT3B2SWpPQ2d2SVhyZ3NWTlo1ZWsv?=
 =?utf-8?B?MmwxWE1rSVB3cFRCQTl6T0VCY0lyOEY3eFQyTkRxOGQ4UjlQMitIeTNua1ox?=
 =?utf-8?B?c29JNHRqUTFrTkdoU0lwSzlqK3VPU05rSXQ0azh3ZFVMTXNjOUlPa0JTU3dx?=
 =?utf-8?B?bk5iQmZXS1BQaUpxd0ppM3l1U2dES0hFTUhzNXY1ckhFbWxmeDVCMm9tR0ZT?=
 =?utf-8?B?T1FCWFZnZHR3TDRwTzFubVJLMnJVYVJVTXBVZ1lEby8rajRoYXdzWkRBVk9s?=
 =?utf-8?B?QVQyV21TdnNVckwwSDJqR2hXbTFxSHBsYll6RXZHcmdBNUgzZDFtSkVMLzhw?=
 =?utf-8?B?d3ZOUVo0TVhFQnhiRzRWU1RqK0ZJcEsvWkVNYjRIc3cvbCt5QmZwY2lkWDM1?=
 =?utf-8?B?ZEN5OHAvTFcwc1R0MDJYS01qTTlURnRDTU91REZ0UUcxOU1TQk1LMFo2RlNi?=
 =?utf-8?B?QXY2Yk9hSHBNaXJORkhFVExOK1kvMXo2dG8zcy8yRUdXUXNkOVI4K2Q3YkhM?=
 =?utf-8?B?NjBYODRRQnVJYTQySXJYaHA2N0xHOGdlbE8xYk9OOGtab050THNETnFIS0NK?=
 =?utf-8?Q?AIfwp2o+3Z6zynjM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1aee06-8b94-480e-5c68-08da38660c2c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 00:33:37.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AHc1J6+n5iRBTl18u5Aj2fkya4Kgd7DckwSJU3CzVjscy0oAiJZKP75OF2uWwX6ulrdJ9Jiu9+ixCP8iKfvOHYjmrbgd7sV6D2mTjYtyAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4657
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180001
X-Proofpoint-GUID: Bas0wXOPN_XiODgqtk88IJKy9I2obPyG
X-Proofpoint-ORIG-GUID: Bas0wXOPN_XiODgqtk88IJKy9I2obPyG
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 12:47 AM, mingzhe.zou@easystack.cn wrote:
> From: mingzhe <mingzhe.zou@easystack.cn>
> 
> In commit d72d827f2f26, I used 'cpumask_t' incorrectly.
> ```
> void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
> {
>         int ord, cpu;
>         cpumask_t conn_allowed_cpumask;
>         ......
> }
> 
> static ssize_t lio_target_wwn_cpus_allowed_list_store(
>                struct config_item *item, const char *page, size_t count)
> {
>         int ret;
>         char *orig;
>         cpumask_t new_allowed_cpumask;
>         ......
> }
> ```
> 
> So, that the correct pattern should be as follows:
> ```
> cpumask_var_t mask;
> 
> if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
>         return -ENOMEM;
> ... use 'mask' here as a  ...
> free_cpumask_var(mask);
> ```
> 
> Fixes: d72d827f2f26 ("scsi: target: Add iscsi/cpus_allowed_list in configfs")
> Reported-by: Test Bot <zgrieee@gmail.com>
> Signed-off-by: mingzhe <mingzhe.zou@easystack.cn>
>

Reviewed-by: Mike Christie <michael.christie@oracle.com>
