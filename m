Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F64E595EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiHPPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiHPPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:24:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E12C31D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:24:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDdFki022951;
        Tue, 16 Aug 2022 15:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tupXvhLheJzD6WVpcLO5pEeHDtgWAn1JEFuksFwf2rs=;
 b=ihC7sZoGLyzOwIwrLsd5jMRHZbct/rz+XHffsw4WwoGAf74gErt6PbfEYIkRJpTAv6qf
 IhCNrUxHCZXbUlknDhAxs06h9PTi6LDMPHmYyNzOaTCZx54wuqoeNTymuLotaNSLLQpV
 elKGQCpDX3RDS5iCNMpJrPaRG/yqltHUhcCFctmfuK/giudRx/QZ93D6zpxR/LFlGeQJ
 3onhYhzBJ+vfuRZ0//7pf1WuAesMa1D40iNdiA9fdy5N8n/m+kLfIWOzotACCaHyzi9l
 xhAAYz3tsM5oJTv4ytdmfNd9av+Ovi/i3TASW2NpInng0mCII1Afin83UXQAIrtWLDae 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3js6anc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:24:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GFGVUR021341;
        Tue, 16 Aug 2022 15:24:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d8k24c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZCDWRLKOqyYfiC15v2ZQzx9KEa2Nf80Dqe6qgidHiKSel27PEC0GyVx3VNl1Xy/jNcIhUQQICKhpzK2xVbraeD/TkyMcfwtd7wh4DHKl/prv1/fwo4k7oqlW5qRXAayBK6m7TKO8CO6RVRxXloD3TxNZWhZ792pUZ3NH0SSQDptntcIPcUbVOl9lCsKD+gqjlaSnuHN3tAhJEbjik/3x6DKxajA+bfLH7tgjXWahmQXbF7c3tfFZhpGIJ28iJezOeuHFU0Fbg/NacjuIerqo32hm3KzYH1TmIdk45Jo6EzdxSab+vQ5+KBkuEndw9Y3NU539RVTccQdKCvLMktjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tupXvhLheJzD6WVpcLO5pEeHDtgWAn1JEFuksFwf2rs=;
 b=m7P6Y+rIa9+yF3BgXrqQlh7+PTdPKBIipdgfmmyTpo5HziATwsRNmPCcsC0/Q3J6W0m1yIubPQEIIfqedveGNAHJ4TRFA2eEQVOCMkkw3a8jNyttoTIUCD0NGog8qb0jeNpUq8IL/ZKR0Hlm6rTRkXTaLXjYF4tSmBVVeVscLkPLjHDjeKQT2xaFhqNVNUyd959XRlJ5MeZj6bY2fsnsUI3Hv058onLlmEU6UjbjIehkRrxfwnodFtGvKaLhrf7HfL76g/lArU2WdP2y0LWnxKiXOkZtcwHSYYac2lbAefU3GEuYewTKmgUTyHEpy4D+dBxw8O14Tfnsc+AIB9T8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tupXvhLheJzD6WVpcLO5pEeHDtgWAn1JEFuksFwf2rs=;
 b=jryvsPfdbjF7dYVaqNsP6BoNVg1+Mujk1z2zLa7X8xlmvFTqAr+BWkGpJBfcjBoPhC3SI5//UBxCd+Z8yBMsv1RchCQ7Cx1Ra2Nxg2VKmzLmIZK43toLO7kVnLwlTyEcImPN8tGN8rsEZsINwmy/QIQKwYORHkziUjhpAtms4QM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 15:24:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 15:24:06 +0000
Message-ID: <b7e89e42-2dc7-3fcf-d949-d9e259c1f026@oracle.com>
Date:   Tue, 16 Aug 2022 10:24:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 7/8] crash: memory and cpu hotplug sysfs attributes
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-8-eric.devolder@oracle.com>
 <YvDoPTSkYo6dg+Di@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YvDoPTSkYo6dg+Di@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:5:54::41) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a29745f2-0346-442b-ab01-08da7f9b5bae
X-MS-TrafficTypeDiagnostic: CY5PR10MB6022:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAUE7K29f+U/T4/1zc/RD04vxBbdIZvFI14ZtlP0zxgnuglytRoJRn9jXv0i41wyO2OL5PXVYuZekL8Vbz0BScYpLnlqf6cJeLbdZiNGVKsXLnrwFERg7030K1beTsJiSfKQIk8QtyZMccBx36f0YgOG9UlPxdadaw/TnQ5xZ0mWz5Nz40Yq+GOHCG5SQcZ3eJ/PLm6GUtlzfIdQs2s/EF6fFR62M/An1fXat/clLnFVbrJVyroiFeGHqG0DajQc4aaCcWYHxx5P395ctBesSFXb/fckT5fgcLKyrhD9eOpUlI1yzwcv83dt+bMk0/jV0rmgWSzuhM85SiKtVDwY3sJIV3rWsy6Do/hAnSqF2yPD9Uf/E0DUijPghlZCIEw7DDEkNZG2h9B8PnAJiQALNfk7logiB53+Lmxu5kELrmQXG13D9LFpyD7DNyVg4Ua11wR0GgPohCni8NAYkzjECq3zQ3QGl4/+bIkNQcVKzkfqKAMHUAmFd0cflwLY8y7SajfQbSH/Z1DzqA16ge7ykH73vbn3FEkisoqXSqIGjo+xyJ1MGgqRe6ZiPKdDwYnjJCaN+/QsHE98o4v+WtFMC2dF+SlUTp9Mwt3t4snkpirDTm/BahbReesHa9dbjplqfKrupEPDYXPwCN40HlVfKkk8f9CXkztpvspUF3TTcpmEzzfiPjVzPfXoSfD3+hYGmAKjx6uU4t1TemZyDJRZYciOhuoqwdXwkEJYDj7wQ6IM2M4RzmT05iUZSbJcs3/vJvX/b++53h1m6jH5xE9Y9SNozbn4zemffMcFdcnyyRqjb0f0ek/P5/z7cQ2h3VqC44LYrWDZOWVBZUbt+yABAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(39860400002)(346002)(31686004)(7416002)(5660300002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(2906002)(86362001)(31696002)(83380400001)(6666004)(8676002)(6512007)(6506007)(6486002)(38100700002)(478600001)(53546011)(4326008)(8936002)(107886003)(2616005)(186003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZic0RHVk1oWk9LdzhGMXJnKzZiY1R1UHl6dkVRNDZZRDJlWjY4UkFEV2d2?=
 =?utf-8?B?YytmY1I3NW9iRjNnTWFJb3hYT1dJYmFVS1Qxc0ExUngxZnV5MWNMOGJrQWlT?=
 =?utf-8?B?Wi94NG1xS0w3VzBFcFh1b2Y5MXFGUjVaQjFhWGtjMXRhKzZSMlVMV24yNmI4?=
 =?utf-8?B?NmZSODFkMkFiWkZpT3Z0VFdKTHNVbmZoQytYM1VxWWhDSWcwbG0zOW1vNmZL?=
 =?utf-8?B?S05LYSs2N1pOaDdka0tnMmpFbFllS1E2NWF3MWdmU3o1NnhKZSt2bmkwNHJj?=
 =?utf-8?B?OUFUVFhGR1Npdi9vaGQwVmpseE9lZ2ZzRGpkRzNvdGlOWUszalE0dXo2b1N4?=
 =?utf-8?B?U29YQlB3TStsWXEyU0RXYW5NVnFZZ1lHQXJQK2RVWE5kNFk3OXcvazRRcTd5?=
 =?utf-8?B?RG52RVQ1Y04rK0dCNTNtajZQK0dlRCtUdXlrYTVhSUxuZUJUUG4xZWxyUmky?=
 =?utf-8?B?cklMaHhVSy9udWM4QzJyVlhtTmc1dTlFenVoeU1mdGRGZHNldXowNXVJdXBo?=
 =?utf-8?B?VDlBMkFNT0Z1M0YvUjl5ZDdmRHhPY1BGRVMwMkcxclBDNFhUa3RFdnBJaDRn?=
 =?utf-8?B?Y0JyaWdSNWU2TGh0NXJrVnJISnZvMFJQM2RLQS9yazl5dWxWZk1SZ2RCdmdj?=
 =?utf-8?B?RzRXSGhGT2F0VVpXSWtJZ0RBaytHK1ZxZ0FoUHVCYllYNVhKWFBncTZaU1Bn?=
 =?utf-8?B?eU13WmF5ZFkvc1ZORlJUVmVGVzNiZU04aDRvRHVGRFVtMFJkdXRvU0J5a0ZD?=
 =?utf-8?B?bndaWGNCQXVUMlE5emRkdyswRXdPYWVEMDdBZWJ5bUgyTWZaT0hRSE9PRGZs?=
 =?utf-8?B?WkRRelBwMi9JVlFZUDRsa2NSRFZIYzFUNHhFRjdOTUJkOXZabkg5QVJqNjRo?=
 =?utf-8?B?UDhvYW5TdW5yZUdkNlN0bG1RM3dwb0JzMDBjVjBicGJOSUJYQ0lrazRPaksv?=
 =?utf-8?B?aXh2UHNSU3VTR2hRYlhjNHBVUEkyejB5bWpLRWt0amxva3ZTOE9pY1U0c3RM?=
 =?utf-8?B?RmFlTTFSOGxJUW9MeVI1M3Z0UDR6TzQrd1JRKzFibU16SmEybHlJbFlMQXFI?=
 =?utf-8?B?aldrUWV0dnEvbzhUbms5VmlLNW9WaE0vNDJpem9KMzZYVENGeU1hRy9nM2JR?=
 =?utf-8?B?MXlzWFNuYWJ0TkgvT05TdDFDSkNza1VZWThJTjJldjlwRnJSTU1Fc3lDZjlH?=
 =?utf-8?B?anZDTC9zQUd0VzMvQ1IrdDgyd2dvU1RJbVNyOWNwYWpIRHdaU0x3U0RmaXo3?=
 =?utf-8?B?QlR0MUVydnBHTjNjMnpySFNaNzRMMjJmVGtoRUpHcGMydnV6Q3BoRWNGMDFZ?=
 =?utf-8?B?bXVDejJHdFJpMTczM2pueEI3ZHhpREFJeFRvVjlIdU5ieVlrWE1sS1V6c1BN?=
 =?utf-8?B?ZWY4REhMT2hDQ3A2bVZWSFdPRTJNZ2wvUXJhaHJEN0Z3ZXR6QWFnWDZzbzJW?=
 =?utf-8?B?cGNCUEVjekJhRjQ2Nk5pRGU4eTl1WlFTSWhsOU12U3JObVppNXVIS0NzaE41?=
 =?utf-8?B?R3VXQzhMQTluZE1rUXp5MDZsSWg5NmhHUlk0Qzg0WkVsWDBvaW5uSmhiRWFN?=
 =?utf-8?B?RnZ2TkdiRzBYVXdLMjRxTzByL2NSeFJDSEZxcjEzaXR0cmMrdk1ZU01RdjFN?=
 =?utf-8?B?QVBnZUpjRlV0cVV2Qms4aUR6Y0llYk4wUXF0YU5mZzMyNFFlcDhhVFpqTWw1?=
 =?utf-8?B?UzFLS09NTDl1RXpKMFlGQllxcWFHaFBxNGRIaE5VTE5NUEZJTDk4bm1RaEZ5?=
 =?utf-8?B?aTRray9lSW5RcEV3b3J0aThrQXhOdkhHSktKc2dzdU13RlJ0ODlCd1EvQ0Jm?=
 =?utf-8?B?d0pHSjRjNzR5R0paVFhCdkNUK2tWTlBzNktHZ01qb2tKRkkxODlJVDl3MUZz?=
 =?utf-8?B?djIwcWpiTUlvcHVndTIyQWdHZDNXaktwZHBzKzdiRFRrWjNwKzJ3eDY3RG1R?=
 =?utf-8?B?Kzc2Y2ZRSk1pb1hwS29ZTjlUd2hWaU9nYUo2c3F6SForYlN4aC9FajQ1emsw?=
 =?utf-8?B?UXkxYi9pRlQyaHB2VDRqOTk0bXNTSkZwOGF5cnV5RElEcnlXd3VSeHAzTUsx?=
 =?utf-8?B?VEZVekZSc1FLSDFVZFJZUk9kc211Z1daT1I3UmY2VDdzb1IweUtoWDFtdDF5?=
 =?utf-8?B?a1o3WTlsa2dnSTh0SHF0ZENvNFN0WXg0TEN5SUg0emFkOEF5K242SDROaERN?=
 =?utf-8?Q?RnV5+jdqp4B6qBIIuXp9FbI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzI4VjhIMk1nejJWWHcrdzFKQWgyVS9MVDNyWlZwS0dybklDSVltK0VmTkh6?=
 =?utf-8?B?Z2xxclZJUzE3aWVtdlc5L2UrQkc1eW9jZ3NqZjRNSUsxTFZSMVVmcGJkOUdM?=
 =?utf-8?B?RnJxdnZiQjJ3eHR5VXF5SWsvQ2ZuNVg4dHNKMTVFa1poaXhuODh4STZDc0d6?=
 =?utf-8?B?cG03T1U0bldSTVBJU3J1Tm1pb2xlRENWdU1XV3VGSnBUTHBqcFYvWlJnVGlh?=
 =?utf-8?B?d0hZaGVTellFZWcyTDNzVlkzM2Y2dXEyVjJjTUpsQ2l6NzBkUFhIMERSaFhR?=
 =?utf-8?B?TmQzTDVHV0Z2bThPdm14bXMxaTNFckxWT0ZZUytYYk1NU0xCYTlQQnhib1N6?=
 =?utf-8?B?SVNQK2xRckx1RXBHL3NOZHZGek1hMkZJOHhNUTRTRXZDQVJSVGgwWHE2dDR3?=
 =?utf-8?B?NTRhNExXOGxRRkxzQTMzQkFZKy91MGtFT1NnaDJyOENhRGh5ajFVL2YwMGtG?=
 =?utf-8?B?bDd6eDJKVXNlYjRZZE9JY1ZVOTRlaUU1akdxZnVRaUx6TE1Ha0hKUmNGNTZ4?=
 =?utf-8?B?d0hUdEZIb3FnSjhDUVd5YXE5dmVqSkZBd2gzN2hrUXFPUlVWanlBRnVoSlVS?=
 =?utf-8?B?TWh5L1l5QzhyNXlPLzJZR3NieEtMWHdmcFhINHlyQzN4ZmxRWUZlbVo5Snpv?=
 =?utf-8?B?ZGFCMDg2Tm01Y2pDb21oakE4MHdoSzBJUS83TjVMRE1lQ3ZYbVgwVHhtWDh5?=
 =?utf-8?B?dHBMSWxIT0VlRHRXWUZJdUxCM1dJYTBheXRYSmlsWkJvR0tCY20wWFp2RGRE?=
 =?utf-8?B?NWNyVy9KVlRsY2JNWTU5eFJobytBaTQ2Y1RBS2E4U1h3eUJBRjhNTFNGVDJ6?=
 =?utf-8?B?aXJJZmRrRXMvMVVnQ1JmMWRVcVhxV3VQcG9vdzlEYkNITmN2QlNTc0dlS2RO?=
 =?utf-8?B?WjdyOFZIbzNGcWNOTmdWdExYTFY5a1lJV0M1Z3E2a0hMUlQxeTN1cUxKNDdj?=
 =?utf-8?B?RVJtUDJFcFhnaGJId0xtZDBaZVF1WVlBeTFMNFJIc3VsWk45aDh5elY5OU8v?=
 =?utf-8?B?R1RSdFEyWjF5ZGZvcGJMc3FuM1I5cngyUzdVSmN1OGc3UWpEUGJyTmxZVlRL?=
 =?utf-8?B?SlAxOWQ4OHdrT1cyNXhvL2hDQUpnMjVnQS93Y0Vub3MxektHcUduWldaWjJ0?=
 =?utf-8?B?OWtBUHl4ZTIrWWVmN0h2TExTcWd0M0o4dTh4cmFEdDZIRUkrRHlpYVJRK0I2?=
 =?utf-8?B?MmU0WUx3VmZmRkI1dUNRYlI2b2pJcEEycFpSeGRjcnFJV1J5c05kT0cwRGVJ?=
 =?utf-8?B?Z2NGRStXV1hVZHVyWTF5YUxIUjhIeGxvaEZNSFNIRUdsaTg2dFpQZjlPR290?=
 =?utf-8?B?MWhLbG51eVRGOGs4MHR0dCttRXNxMXM0d2szMVVjMm5mL2tnTzd6eHFyMWNF?=
 =?utf-8?B?clU4OE5NSzdVbFN0ZDIwMC9DS2NSYXBOQmdrT01TS2Vlb1pHcFpiQmN4NG5F?=
 =?utf-8?B?YlBzc05Xd2dZUm4renJZOGQ3RWdRSDVTYmZVbnptOXhFd09JT25lZ3ZwOVNx?=
 =?utf-8?B?OVdSNnJyQzBzZkE0TTM2TFE4dEI1ZytXZUJRTWdNRlN1NjVta0RsM09ST0NH?=
 =?utf-8?B?cHl3eEFWdHZJVGR2T0ZENWMvb3JodnB3dXhXVmIrRlFpWVVlZVg1Wnk4c2NU?=
 =?utf-8?B?cEg1SWlIbTBCaU5NQVlTVmlkSjJrY1NUQnBzZmxZZ2VFSm9zNi9vQ0FldTV6?=
 =?utf-8?B?dXFmam1BNXAwblBVOC9xeFdYdXBMenN6cFVMb1YzQUd0Z2dmbXVsV2RBT2la?=
 =?utf-8?B?SjM3TVNLcy9nYkF4eFUwdnNId1F1cXc1SkNzaHROcXc2MTBMamEvaDYzZjlR?=
 =?utf-8?B?Y0ZxemZRU2p2OWpQZ0Y4dWU5V1lteWU5L2p2dUdhbHNnMS8vMVZtSHpSUy9w?=
 =?utf-8?B?UmlQZERnNmM3c3BEUmhsZnJ1NEQ3WE5BUmw1aElnZTcwZWduZ3o3RS9Memd2?=
 =?utf-8?B?L3BvRDAxUEg4eGNzWjZFaGtoK3RweHFWeVJ4YVhVOHB6K2JRbDBlajFxb3NZ?=
 =?utf-8?B?QU4xRit0dnQ2dFd1bnNGQ0p5Snk0SEVZWDJHSjM0YzVFWDhvdHMvK0ZSaE53?=
 =?utf-8?B?dk9ld2ZWa3Jvdnl2WEdpZVdFaXJIRU1xRER2TzJ6QTBkWk9xZmZZd1lWYnBX?=
 =?utf-8?B?UlhPNFBVMThPNUJ4YlNPMzBHWkU5bVRPMEZUN3NBbTJ3R0ZjbTRnVlF5QjFT?=
 =?utf-8?Q?J5fZoMrxodPehULmQ+R5h076fMEkJltSTXZIDOh9CBC/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29745f2-0346-442b-ab01-08da7f9b5bae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 15:24:06.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+uKX/ei87wvWRXCmSqPbaXm+tE/J9dlN5g9o+AE6Zs2jJaRLH3s1ir0tI82nog1yHgRfrTpBQ+HnkG8o6P7YaIo2VFxOGoFaXzu7mfCGiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160059
X-Proofpoint-GUID: TwPxtrmrRV6uQ2ZAPbYrOxwAXqCPYKA0
X-Proofpoint-ORIG-GUID: TwPxtrmrRV6uQ2ZAPbYrOxwAXqCPYKA0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/22 05:41, Baoquan He wrote:
> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
>> This introduces the crash_hotplug attribute for memory and CPUs
>> for use by userspace.  This change directly facilitates the udev
>> rule for managing userspace re-loading of the crash kernel upon
>> hot un/plug changes.
>>
>> For memory, this changeset introduces the crash_hotplug attribute
>> to the /sys/devices/system/memory directory. For example:
>>
>>   # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>>    looking at device '/devices/system/memory/memory81':
>>      KERNEL=="memory81"
>>      SUBSYSTEM=="memory"
>>      DRIVER==""
>>      ATTR{online}=="1"
>>      ATTR{phys_device}=="0"
>>      ATTR{phys_index}=="00000051"
>>      ATTR{removable}=="1"
>>      ATTR{state}=="online"
>>      ATTR{valid_zones}=="Movable"
>>
>>    looking at parent device '/devices/system/memory':
>>      KERNELS=="memory"
>>      SUBSYSTEMS==""
>>      DRIVERS==""
>>      ATTRS{auto_online_blocks}=="offline"
>>      ATTRS{block_size_bytes}=="8000000"
>>      ATTRS{crash_hotplug}=="1"
>>
>> For CPUs, this changeset introduces the crash_hotplug attribute
>> to the /sys/devices/system/cpu directory. For example:
>>
>>   # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>>    looking at device '/devices/system/cpu/cpu0':
>>      KERNEL=="cpu0"
>>      SUBSYSTEM=="cpu"
>>      DRIVER=="processor"
>>      ATTR{crash_notes}=="277c38600"
>>      ATTR{crash_notes_size}=="368"
>>      ATTR{online}=="1"
>>
>>    looking at parent device '/devices/system/cpu':
>>      KERNELS=="cpu"
>>      SUBSYSTEMS==""
>>      DRIVERS==""
>>      ATTRS{crash_hotplug}=="1"
>>      ATTRS{isolated}==""
>>      ATTRS{kernel_max}=="8191"
>>      ATTRS{nohz_full}=="  (null)"
>>      ATTRS{offline}=="4-7"
>>      ATTRS{online}=="0-3"
>>      ATTRS{possible}=="0-7"
>>      ATTRS{present}=="0-3"
>>
>> With these sysfs attributes in place, it is possible to efficiently
>> instruct the udev rule to skip crash kernel reloading.
>>
>> For example, the following is the proposed udev rule change for RHEL
>> system 98-kexec.rules (as the first lines of the rule file):
>>
>>   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>>   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>
>> When examined in the context of 98-kexec.rules, the above change
>> tests if crash_hotplug is set, and if so, it skips the userspace
>> initiated unload-then-reload of the crash kernel.
>>
>> Cpu and memory checks are separated in accordance with
>> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
>> If an architecture supports, for example, memory hotplug but not
>> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
>> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
>> attribute file will NOT be present. Thus the udev rule will skip
>> userspace processing of memory hot un/plug events, but the udev
>> rule will fail for CPU events, thus allowing userspace to process
>> cpu hot un/plug events (ie the unload-then-reload of the kdump
>> capture kernel).
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Awesome, thank you!
eric

> 
>> ---
>>   .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>>   Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>>   drivers/base/cpu.c                             | 14 ++++++++++++++
>>   drivers/base/memory.c                          | 13 +++++++++++++
>>   include/linux/crash_core.h                     |  6 ++++++
>>   5 files changed, 59 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index 0f56ecd8ac05..494d7a63c543 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -293,6 +293,14 @@ The following files are currently defined:
>>   		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>>   		       kernel configuration option.
>>   ``uevent``	       read-write: generic udev file for device subsystems.
>> +``crash_hotplug``      read-only: when changes to the system memory map
>> +		       occur due to hot un/plug of memory, this file contains
>> +		       '1' if the kernel updates the kdump capture kernel memory
>> +		       map itself (via elfcorehdr), or '0' if userspace must update
>> +		       the kdump capture kernel memory map.
>> +
>> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>> +		       configuration option.
>>   ====================== =========================================================
>>   
>>   .. note::
>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>> index c6f4ba2fb32d..13e33d098645 100644
>> --- a/Documentation/core-api/cpu_hotplug.rst
>> +++ b/Documentation/core-api/cpu_hotplug.rst
>> @@ -750,6 +750,24 @@ will receive all events. A script like::
>>   
>>   can process the event further.
>>   
>> +When changes to the CPUs in the system occur, the sysfs file
>> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
>> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
>> +or '0' if userspace must update the kdump capture kernel list of CPUs.
>> +
>> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>> +option.
>> +
>> +To skip userspace processing of CPU hot un/plug events for kdump
>> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
>> +file can be used in a udev rule as follows:
>> +
>> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>> +
>> +For a cpu hot un/plug event, if the architecture supports kernel updates
>> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
>> +the unload-then-reload of the kdump capture kernel.
>> +
>>   Kernel Inline Documentations Reference
>>   ======================================
>>   
>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>> index 4c98849577d4..bd470236d9a2 100644
>> --- a/drivers/base/cpu.c
>> +++ b/drivers/base/cpu.c
>> @@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>>   static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>>   #endif
>>   
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +#include <linux/crash_core.h>
>> +static ssize_t crash_hotplug_show(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
>> +#endif
>> +
>>   static void cpu_device_release(struct device *dev)
>>   {
>>   	/*
>> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>>   #ifdef CONFIG_NO_HZ_FULL
>>   	&dev_attr_nohz_full.attr,
>>   #endif
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	&dev_attr_crash_hotplug.attr,
>> +#endif
>>   #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>>   	&dev_attr_modalias.attr,
>>   #endif
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index bc60c9cd3230..63c1754a52b6 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>>   
>>   static DEVICE_ATTR_RW(auto_online_blocks);
>>   
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +#include <linux/crash_core.h>
>> +static ssize_t crash_hotplug_show(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
>> +}
>> +static DEVICE_ATTR_RO(crash_hotplug);
>> +#endif
>> +
>>   /*
>>    * Some architectures will have custom drivers to do this, and
>>    * will not need to do it from userspace.  The fake hot-add code
>> @@ -887,6 +897,9 @@ static struct attribute *memory_root_attrs[] = {
>>   
>>   	&dev_attr_block_size_bytes.attr,
>>   	&dev_attr_auto_online_blocks.attr,
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +	&dev_attr_crash_hotplug.attr,
>> +#endif
>>   	NULL
>>   };
>>   
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index c9705b6872e7..3964e9924ea5 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -109,5 +109,11 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>>   {
>>   }
>>   #endif
>> +#ifndef crash_hotplug_cpu_support
>> +static inline int crash_hotplug_cpu_support(void) { return 0; }
>> +#endif
>> +#ifndef crash_hotplug_memory_support
>> +static inline int crash_hotplug_memory_support(void) { return 0; }
>> +#endif
>>   
>>   #endif /* LINUX_CRASH_CORE_H */
>> -- 
>> 2.31.1
>>
> 
