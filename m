Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D019D57A3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbiGSP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbiGSP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:56:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEC1D0D3;
        Tue, 19 Jul 2022 08:56:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JExJBP031784;
        Tue, 19 Jul 2022 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Me2weV5LtaxIZkzrUxjea8R+oE9mV0krDEyckCgPEhM=;
 b=USg4+gP1+8YAcdqBC/o2S1OuqyV4N1JLvkmyntCooAcwKwdamNypj+iuMWiz+FOy/bFx
 EALE+gYGo8rJ6tFSSlc6NQoeSAj6garS57zwyGRr9uAuIkSjmNVI8SDa31gkAep+qsAX
 AXV/gAjSu8YixOTJuQVyghipqPq3b5oUOdXXfvLCmeSPYJFGpw6oWlkNd95i8cKc4Bkz
 Cx05NhX/bOROzs2m9r6Hp6s/8kkpaJX5vtfxCXvKSf6rEn8YZlWqvNKFGma3gqs3Dm7Y
 vFOy8RPvFd9xvhAoAh68VJv9v0xAWbmnbFYKk3UN4V8586sdGHyQadgF4FD6ZiuM2CoU kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtexhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 15:56:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JEUZhk039270;
        Tue, 19 Jul 2022 15:56:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k4vk22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 15:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2xOcLUqeONisYKRPuGDb171vQUYZWsCsUqhQypf8k0IueX1qy12EeQmsFbCcemhDcj3UtPurMr2eGPhXGzTlOMENy0TumiUYupDZbTa5okMcs0/EwloOnl0F9GBo3lsSpBYe7fD8fy2YIZqwaodajWfdPhY1oSN+heBqrzjbMJBHr6X8uAJHPR4xD9gX9cgQ/Svceurm034efEpQRx0cxb7lnURubQiFhjCvDbfO0XDT/fJ5fsvRC/gwFkl5udkxU9O26yujX4rrxHv6ijH/FrFoVXTyCVo5rux1xJSdOAFQtoEReu75llTwYPuLQroUY9QgsIXlQTKnAb3AEGwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me2weV5LtaxIZkzrUxjea8R+oE9mV0krDEyckCgPEhM=;
 b=iHddPq4a0GJL7iizkvyok82sQRbgUN8Lel0BG0CAGr8uX83Q8jZolIB2r8tupoh3Tzt5Wp8SesVsnGnkkGPVLncQ68LfE7Lcmv4gX1bulDIgvZZ+/KTs5hMixMOgTec7tlRWV4KvP6fzzVfeN3dBOBFEGgxiyonhqvp3tmP09SJFyRkRJv32PSAL/gddwlMOBzhapDIy3eXb6WA+FLS5Zuqk2/qRA8Wto9y1O8V21SQw6hXeUeRnPX+gCMfopA/ERorVxkRPv7R60SzVqAJgh9y9t2Hffu5LVXhMGF/VEnILuKOcwYzixffBVxcLFgJkmkOFOXo2tgdD6he5LcRm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me2weV5LtaxIZkzrUxjea8R+oE9mV0krDEyckCgPEhM=;
 b=z5+PoaZK9flXVhCy1j3/Ve3wrYre5MiDUgLLI4IW65Nyu5kuDsvRBLZbB/EfnOicvml/Dp4XAjf2rbKUsseWkdt61NtPDMvoo85RqIKEo3MUqd++wLO1XrjF+vUNkGDZ2gH4GCcSt/jG/0cE0+Pe8SB+viY+tcssV2Us6yX5GOk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 15:56:09 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50%6]) with mapi id 15.20.5438.025; Tue, 19 Jul 2022
 15:56:09 +0000
Message-ID: <74bf1df3-a466-9d78-1a25-7425c89b9fa3@oracle.com>
Date:   Tue, 19 Jul 2022 10:56:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2 2/4] target: Implement TMR_ABORT_TASK_SET
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Youn <John.Youn@synopsys.com>, linux-usb@vger.kernel.org
References: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
 <7d31722a7e07bc24ea37b5841a17545003eeddb4.1658195608.git.Thinh.Nguyen@synopsys.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <7d31722a7e07bc24ea37b5841a17545003eeddb4.1658195608.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:610:74::34) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca06823-bf6e-40b1-5ad3-08da699f329c
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOssSO97O8Dtbsx00WUwkVqCCffUfKWZ4lrjklAIxX0MAc1tuHdfIHK2dM1dc+agMA1h8V6LjToGYjCps0qpoRQJ1S67KrH51shbxOvff7acNwzzdIrCqveBruwmwwJp5abl9DIECl9xmKOz4UIsita8UpQyYmdXD9P/UhP/rSPwI54VaPKU62MCF7buTOem19bq4zaN54G4tmflVWuucTVuV57PbkAE5x7yRwT8Rb80C7KxMjXauBlvCAWQDrkDORdcRKrqSD47tqPFyqsk0C+qlB3/Vfwb7S7tLb2B8nlZyDAL3wQ4Ti5eUmm4aLTAe+DO27ZhXa8zjRB+BnhZSyT1Zd5TrW4Ej9P1YH5LFPHL1L8gS6J8ccG6vuvJCXFhA9saJEWqtuktrtpd2v+dcyv2hB1nRiMaeTscMh/+4McvZyghIcl/nYS3CfkFfHttb2MFq+rTzQ9ellcexHe/YfQCaH6jq2UlsegWqAaXyVb0e8ASEJCPSQp014NqZsbXu5/bb1IA5EQ+gbaTNM9QPLGvxwuXI0eD3/wb4z008s/gCzHIqpVNPtVpB6OmJUHU4rMLLWBXVZ5xmH6P/pv4w+/FZSxJXQakpvMTprdvvHjp7v8NdxyH9EGZhMfIrYv0sl4QeTR3ZZepoh8QzE2L9h/uUYlF7p5+libUHIYbYhGLDnKEJHNI1Io7m81Nc0tBudEzRz8eHMXUFG/s+LBqOdFNbuFlBTk4dGGmYe4cKMGr96so1Eyju4MrDAOMjMbBDKz9NKhHHFI3JhodObNS7BgDJbZsVOieGGeNmYEUl2cEmQfvRWSW0uwADWjNSLxZhB3AXeWWLD6UxDHCFPRGPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(346002)(376002)(66946007)(8936002)(4744005)(66476007)(5660300002)(8676002)(4326008)(66556008)(2906002)(36756003)(86362001)(38100700002)(31696002)(6486002)(2616005)(478600001)(83380400001)(6636002)(316002)(110136005)(41300700001)(186003)(6506007)(53546011)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJwQ3d3TmlXclhKL2M1UTNXL1MwZTdpWU5QQ0tFZDNkM3ZpZVU1UDk1ZWFZ?=
 =?utf-8?B?Wi9NWjQrQ0pmQW0rQnFoSm9pc0g3Vkxtbkd1YnkrN3dhZUFVWHpLc09ZS0Nq?=
 =?utf-8?B?SHl2QmZGR21Ed1J5cEpOeGRNb0dJNlY2UjhQMGtaSkE1NlRPaXdodlFndita?=
 =?utf-8?B?cXBSREZ1SSthN1ZDV2ZwVW1HRUV5dWxoSHpGTG5DOTZXRVdDb1pEM0xJcllk?=
 =?utf-8?B?Vk5HbmZZTDZSdUU2N3dnV3Zmb1d4M2VIdWJsVmRRQUNMQTUvaVFGOFhlRWJp?=
 =?utf-8?B?V25ZQ3JRckQwWHdaSHI3M2d4aWxhNFIyTnQ0SUc0dkxwRE9oYTVKam1ETU0w?=
 =?utf-8?B?K3lGc21vU2R6OFNOTUNVeEljSzhUSHBFYUhUK0dSOVBEQjU0TVBEMGpURWd3?=
 =?utf-8?B?QThpZm5KV0YyS2NZREZ3MUlCb1ZIMXFwaWF0d3hqaHVtYkZSWUl3WnV4V25j?=
 =?utf-8?B?SlQ4cm9LZVFQQVJnbHc0bW1CbnFxblQyanFsaEx1bVdsZThGYVZSVEhHQlVy?=
 =?utf-8?B?SXpMOU9pa2FQZUcxSWlCRTZGVDBsQWgwL0E4dXQ4WHlhbzc4Zy9hZklxUXcv?=
 =?utf-8?B?K201RTVoclh3WEVCMWpzTWozMzJDeFVhNjRmUjlKUzN1ekZmK1BvNUo3ek5X?=
 =?utf-8?B?Tm5uRUJnVjdWMjdEOVVRWnM0dFlpK3N0b09WR3l4OTNaU2F5bnNYRG9RZnhV?=
 =?utf-8?B?RFA5cldTd2EvN3BRYkQxRXNuU1hZTk9tY04yWW56Zkk5VlVRK3hOZ0krUWZk?=
 =?utf-8?B?MHdQWVZDWEdCUFB1ZFVMbW8rTkFHOWVIVVR3UTRQYWcvcDFLUG9tM3pQNEFp?=
 =?utf-8?B?L0xpVW5WZDV6bUpXSHM0eERsRU1UaDl4YzlITTQ0YzVsSzZMS1hORHl4bUxk?=
 =?utf-8?B?UDJUa3RiSVI3c2MyajRiOVRHMitFMmtXN3FjMzl4eGZTUnh6eEpoN1Yzd1lz?=
 =?utf-8?B?R0xwTXRpeG5NU28wZkFCSEFlam9zWHZlR2R5dVoxcXIvMWVyUHVvUW05Y2lI?=
 =?utf-8?B?N21RcG9TZWcwUGxHOUx4K3JhOHkzVklkWS8vY2hQR3RVU3lDbVBjSmY0VHMz?=
 =?utf-8?B?VHM0QU9USk1qSnNZRXlCV00vT0dRQ0hvQVhnZ2UrZUtYU1U1SEIwZHFuenJT?=
 =?utf-8?B?eG9LOERkY3JGYU9ZUmdBWisrRnROV09OaytIMmh0UHNkU0Zxd3BJeVBGa2FR?=
 =?utf-8?B?bXhQcGhvL2xFQmdTMTBQN21YY0hTSHJLcWozbGVHR2ZUWVFDTlBnNUNZN2dB?=
 =?utf-8?B?dTFGZ0puVFJKSzdpSU10MXFPOGJkMW42RzhQZzI4RG5nQU91WjJZQkxLcHdK?=
 =?utf-8?B?VXhrbStiRnFEWlYrQVk3MFJxVytjSmlHYnc1NTNRZGZIdmxmamdObXR5YWox?=
 =?utf-8?B?THZ3SHl3VWNUM2UrUUk5VXVJcHNlSnZhd2dCNFVDNHEzOTR0TnY1MVR4Ymdl?=
 =?utf-8?B?ZWU5bW91dE5SUG1SS3FiMXRqNFVIeTlFZFA3SGF6LzM4M0tHck9CVkc3dE9V?=
 =?utf-8?B?Z05jbDZMaWUwMldCNWFsYUF5MDFNZG1JOUx4eCtJRWVYZXdSVk5qNnhXaTA4?=
 =?utf-8?B?dGprdDdkTVVzaEcvT1ZmOEFrK3JoRUZVZHJUSXNlN3ZRZm52WGFtb1RyUEUy?=
 =?utf-8?B?QWIwVURNRFpkb00vVVpzQXRxQVdSdmcweU1JcTAvVmVsLzNOUHhPZWpGYVMv?=
 =?utf-8?B?QytOT3Y2WDZYSEtDOHQwUUdBcHVJRGpRUFRBa2tMbytXRkpwUERPUlo2cGwx?=
 =?utf-8?B?OGRMek1WbGlWMTlUZjUxVmpZVmpaVTVXSk5BMDFycDRoK254bUFFNUxkK2oy?=
 =?utf-8?B?cUFwenEvMzMrbkFXZVRsalkrYXNiVW9XOTY2ZU9DK05iSzJSOUo1Tjg4VmtH?=
 =?utf-8?B?UmgvZFN4QmxGbzBUaGp1V1ZOYVZZbzJWQUMrQXEzZGNxYWJKSldtbnhyQVJQ?=
 =?utf-8?B?QzNlZ1FrajRhSG5pK0U2cjJoVzFOMVNXQkJNa2Jhc3cwVDJoWW1uQWZhNlFY?=
 =?utf-8?B?bG5FN3RhSDJsNGpBZ0FQNlJHK080TktlRks3Sk1HMk8yUlhTZWp0YlB2UHpy?=
 =?utf-8?B?dXMzM0l1QkRwWkpRdjBpamRBTFlzNEtFZ3R4WVJFNjJ3dDR5c0dyc3FXNWlF?=
 =?utf-8?B?a1kvenIxYVE1SUlOVnlJbDN4Y3Bqa0p5NFhSMEVsYlVsakMyVW4vTHYzbzZO?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca06823-bf6e-40b1-5ad3-08da699f329c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 15:56:09.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZAGb5SqVjnJLfvUcT4QYPNtwc6Y0BxSTQyTcw2ZaJNpuQGUYXRtVjb6pUxJDBZJQQntxgSRaTfFYREBQsuElnSnPJnu9ETdMQFUVfMpgv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_04,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190066
X-Proofpoint-GUID: hefh56ZjOhaHpjLG5N-iHKM6COdd9qv1
X-Proofpoint-ORIG-GUID: hefh56ZjOhaHpjLG5N-iHKM6COdd9qv1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 9:07 PM, Thinh Nguyen wrote:
> Task ABORT TASK SET function is required by SCSI transport protocol

What OS is using this and how do they use it? For the latter, does the
OS try an abort for each cmd first, then try an abort task set if the
aborts fail (does fail mean get a response that indicates failure and
also does a timeout count)? Or does it start with the abort task set?

I'm asking because it looks like if it does an abort first, then the
abort task set will always return TMR_TASK_DOES_NOT_EXIST. For the abort
we will remove the cmds from the state_list so if the abort task set runs
after the initiator has tried to abort all the commands it will never
find any.

> standards (SAM-4 r14 section 7.3). It is similar to ABORT TASK
> function, but it applies to all commands received on a specified I_T
> nexus rather than a specific referenced command. Modify
> core_tmr_abort_task() to support TMR_ABORT_TASK_SET.
> 

