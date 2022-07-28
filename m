Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F158488E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiG1XKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiG1XKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:10:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17440286F5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:10:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKJ0Od009624;
        Thu, 28 Jul 2022 23:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DOQT/KUqlqsGczY6dMr3wVoRwKshwl33ymjdIQA2U1g=;
 b=jJR+5HASIdteoTMB+6GQ/X/AR6AUgzQdY6btt6RcZiv6djeKKx4CNnwSJr364wfi0L9z
 OycmK/UKHVemcTqnJpLjLQr7+IKys7bSh51foCIYHVCR3GYCCBnBeCXeGibV3AQjG28Y
 No4spX/KnFN2dnVdaFR7EA/SzcdyEqD8embhf75hXjY4fJwViSytIisYFeQsKOaDXFVz
 g2CITPcBQQuzOkguVVv3+wbiZngv61wo4fVEBoDSLOGDe5AjjfuHHDy/XCh8oUkoKrY/
 j1kynhQURDN9MUH1hoYfT48QaX2LtPY3hfXNhF5rlAxHfKJlh5mnciuFkOdnLPgCwnbK rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940wjwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 23:10:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SLTKMm017628;
        Thu, 28 Jul 2022 23:10:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh653sb4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 23:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzCWH93LsbwdFfdaCY8bDO8UMs1c380yFP7crQTk/iWDAEi6CJshofcL8sF4pwrRKcrS2+2KVK4akdaUXkq+YLOa++VXfNV/BTWbOkRqmvmxFJ5fH2TE1CuhRwG66txtPN2ZGMswm4fi7Fn1tI/DQpIZ8AzdQE00VZZPnlElorUI+UpSB2qOCA3C7qia7GvkbVxHqy108GhP/heQRhUTE3EXtek7ANQ9tqiRRhR3viXXRnHHmqQhgkm4DQeiwAqIjSsbZgPeDnb0socjeLiAZUzEIcefwagilPJY27ilacv+ZJUxr2lUtw8ImSBsIgZ6/enOduIa2NwBnu+jsf2iZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOQT/KUqlqsGczY6dMr3wVoRwKshwl33ymjdIQA2U1g=;
 b=Y4NzSirXCs6XKzZAKT20TRVmDWu/Gb90rzCtLY88Z6i0jJZu5ceKNlmwo8yK5eyM2UmYjMc+F8T8RMxvfyd+kXlv15YLim8IQfwSlZPq1VUS7hHgFlTAZRf7hS1KVE7vcw9f+k5dErLJwWo1VSECpfUNUjLx/blDOImpiXBolGhVohAnyS1tSx1gWbXT5FcObcbT/QTxBq1EUhHiSIY6xmVYVyrqrDG+TbTHMdsc/sFpTUs8Y3anUC4zYrby0p7dLJPbyp5uWGHfaga2FFbzEe4yx+VJwPkrQ9gx8kr47YudFaPwe5TG9LrMvICU1FQYZfpwjhNMRf3yhDPhfzFePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOQT/KUqlqsGczY6dMr3wVoRwKshwl33ymjdIQA2U1g=;
 b=xxIU/UZOs0aaYzbw50vI/EWBQJ9PAoULtOjWOnzwc8V9ak+dpL1eMM9woZElFLNI2IC8l3T3td9zEc81T/oLOfDynVlnBwE+mgPThL2JBHOfPMQMQs+HeDlXQDK1TQywvcGaBFYSPkuCwwl+aNJCj+Gq+W1MtJGsc9vaVd/i8fs=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 23:09:59 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 23:09:59 +0000
Message-ID: <ee19c2c1-9e71-1190-b27f-327c8a6942a4@oracle.com>
Date:   Thu, 28 Jul 2022 19:09:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jane Malalane <jane.malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org
References: <20220728125244.19163-1-jane.malalane@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220728125244.19163-1-jane.malalane@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::15) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9270724a-64df-49c1-3e02-08da70ee4b3b
X-MS-TrafficTypeDiagnostic: BLAPR10MB5329:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojK0iE+SJoQJoeDz15RGwwkrJoG+s43Tc64IFj6tJWnLnTGPJinA55RP6Ge/EkhpcF+13i2tk3HaTRnCuyQnlaB45a1Z0C6eRKk7L4r4Gcz9Eo7vfD9NiNIa7+zfBV6rozaG3EorHcfLysYEZlNt8l4bEPoCBbP7U2TisQITFCU96XuGzBldjEd4VHKqVgHwA/X8WjP+vAIsjPYhUtJcezOtVTWLMHGjnQLCOASi1P2lYpWk1VqBhdG2WiA8VXuKVGROVamNk9yAIVQyKFxwJwUiwqQy5DnQ96wkaYygvlIBOC03Jfwqk/yoFoSMO8pId+i5XuvLkoYBeX5pvVs6nKBtzmycs3c+DDracEjTkQWshGFRIrsZN1YrZ+n1jY37kz2sFooxgk2TUIDvVqVx67mo6s12OUlUmJ08f4ldu3wGl5Qhak+AfufY00WvCbwy0wNfrW8ovaFmv3HYI9RTilNOQfB4985GU2qtcXEOZpp+DOVTRC+vCuKs6DeCzmu7oyqWIbkeh67E3BUzTmbpViSsLnJYaejtJTGWLInxeOUdkVUaaYpHD84cDCdno67MZ6ljNksBT26l82cZJULeE9vHULokba3RMwj9RjbvDOT6huoNPckq4O7DM781jbr2s6jwWPVEO3HYIccNqpUXF8W6a86tnsZpQRJcVmoUsfSa82j26796NwixbN2Fh9i5yGoZecz8EfQfGHlup2ZMq7z83iEB1Xla2/yxK1aFT4b/EEJ8GHWjs6TZrK+dzG9Afy28c3uty5xtcKv9oaG/W6pEYlqmZcLs24pyW8wZrJlMvH9cp6937pwHtW530qeFU+B57YlaE6+KlMf/zy19mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(376002)(136003)(66476007)(6666004)(41300700001)(2906002)(31686004)(316002)(54906003)(86362001)(36756003)(31696002)(478600001)(66946007)(6486002)(110136005)(66556008)(2616005)(6506007)(53546011)(186003)(26005)(6512007)(8936002)(4326008)(8676002)(4744005)(5660300002)(44832011)(7416002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1JscDdLZkIvZXVCUmY1S1RKdzIzU0xQamdaUGpJZ2lteWlxb0JEVGdoLzlz?=
 =?utf-8?B?bHJpSUYzREZJQWN0ZnVTQzZuWE95ZUtoRWR1QkZraW5QSVdyUUtYWXgwallq?=
 =?utf-8?B?VEhFQWZNNTN0QUEwUFBVMXR0SE5OazhmMkpZY1RDc2xqdlNkdkp2UEJhNmV4?=
 =?utf-8?B?c2R0akQ3SmdHWWJ3c3VlMitZT3ZVSG14cll5bnFSb0p2enlSSjFoOXlFbkVi?=
 =?utf-8?B?UGRMcE9nMGpFV29RWERTNXlNT1FjbkZJZkRYdnc0UW9ORVE3YThSOUtkbkkr?=
 =?utf-8?B?b0diN1RiNTU2UzRlRDNjOElOK2dPZjF2d3pLdjZKL3hKUk5aSjRvNDhITTh5?=
 =?utf-8?B?SEh3QmNlM1BYdFd6byt3QjMyMXZIclJSMmZ5NExTSGRCTFJBMCszcU1QNW5Z?=
 =?utf-8?B?S1FxT3lGZTRIWm5mMTlGa2E0SmZuY0hkRG02dGl4bGJidFk2T2d2V2JiZCtU?=
 =?utf-8?B?OTF0MVRoYU5yT1cwLzdNWGVVRXdPQjRBQTFhMVpzR1h1Q0xobzdsYVl1NnFE?=
 =?utf-8?B?ejFlWnFjRzdLWkNNbVFWSnV4V2lTalpScUxsNUpFR091RnU5Wno2OUJWczNC?=
 =?utf-8?B?YTVCS0JTTFE1TXpDZkw2U2x6WHJqY2JOZzFUc2kraXNmSXBGVXFEd0JlRUs2?=
 =?utf-8?B?ZEYzeVFuOHJXVy9jOWpidUYzUTNZZ2NtalVQc2F6bzJrU25NaU14VzJWSFR6?=
 =?utf-8?B?Uk9xT0R3NVd6WTM3NHlSVmJTMll1V0FETEpxaDEyMVZXaTJwN1VMWm1PVnpl?=
 =?utf-8?B?aEpVdUZTLzQ0dDNwVUlLZlNUMFRRUDhtM1ZlT3FuTEhPTThJU2U0U0hQSWxz?=
 =?utf-8?B?bFU3T2JTTi9xNjdiMWxWay90aDQycXErOEtxbnNCRi9HWXZEd1creDdqMjI0?=
 =?utf-8?B?cUdwZVBCYjRZeU5MNVdOb3ExcExibnVjTWNObTVPdmpNbmtYbmc1bUVUYjFC?=
 =?utf-8?B?Q211SnVOazBWTkVhWi9CNFpoSEVNek5tbGdVVTZOZURFWW9hak9FTTlSZ1Nl?=
 =?utf-8?B?YStVS3QyYUpVQ25GZXlyK2tSakF0WUx6dWFFWHh5VUhBU3FsQXJkcDhZZ3Na?=
 =?utf-8?B?bzBTd29CY0l1M1dNTjJubXFCVTFuaFpTd1EzZU5DbEFoSERNNlJwdG5RNzFX?=
 =?utf-8?B?eW81V3dURlZGeEtQWGV1azFsbFMyS3F3QThKNllyL0E3RnlHNEVFRHhwZThZ?=
 =?utf-8?B?eGpwMndPTlFFeGc1QjZQZkFIVGsyQTUyTTlqRnBCdm9pNzgxZ3JiUlZJcXR6?=
 =?utf-8?B?bFhCNEQ5VHA2TmxkOCtuS0tRQmxnZDdGbnZ6N051MkxHNjBTK2pCY3gxSmFp?=
 =?utf-8?B?SlYxZVZaQWZJaUZ0WjlUVkdBZnRwMmFNL3BnWXJ1Zm5MV3lUWXE3RnU5a1V6?=
 =?utf-8?B?UnRPdXo3eUp3aUtJT05OZUphT1Z5KzZxbFFva3BET0laZTBpaTc5TG4vek1C?=
 =?utf-8?B?OHJGVW94L25nKzRqZ3NBY3V0Ymd5eHM2UXlsMXhaMEZSZG1xLzZxcEozWVhs?=
 =?utf-8?B?b1hLWFVmb1RQOHhlTFlUUGFYSFhTNUhKekNubllxMzFEUUZydDNNWWhHSkVl?=
 =?utf-8?B?NDlzNG5YWCsvMysrZnc1emk0ZkIrZHVMa09TTm9qbGxaUUQ5Y0xOR0dQNUF5?=
 =?utf-8?B?YjZwTEpoMFpsOTlhUEQxS01JWjI0dklTVG9mOGp1Y1JDZzZXSlo2N1FPaG5N?=
 =?utf-8?B?bkpnSjJoQzV1QzNFdnJORVNMb0hrMHkvWjVsSCtrOHRxMmsrbEdqQTA0M1dT?=
 =?utf-8?B?Qm5nSWMvb0g3TGtiKzZRa2ZNdTA2QnVuQ2xTais1U0JobHJWM3FqUHRJUWJQ?=
 =?utf-8?B?VHJRY2VxN24zV1RqVlUvS01IYyt5Zi93NzY3L3R4VER6VksxVlJlT0ZNQzl6?=
 =?utf-8?B?QjNUZTZqOXRvWXYreHMzNXZsWFUxZUVBR3g5Mi9mVjRTZG9MaUZEN1FlRFhQ?=
 =?utf-8?B?SXNsYmNualdYZFcvQ0N6aTlLaHpBbTNDWk8yVDVnRi9sZGhPem5ybEdrbmsy?=
 =?utf-8?B?eTJoSWZkQVN6blV1RW8xb2NGODYrQWtnb3JBVnZZZThRcUQ5YWVrRjF6ck4v?=
 =?utf-8?B?Q1hxSWlmbjMvblNtRWxHMENzeUZ0T1VSbFZuRElsTUo3NFNFeGV3anVuK2or?=
 =?utf-8?B?eEp1MjVCNkt5Z3pJdzZ2bkFuK3YraXQ3RWhKbW1MdGkrVGhzNC9NanR4eVMy?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9270724a-64df-49c1-3e02-08da70ee4b3b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 23:09:59.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmRnvOExXnrvRn9eeAe7BwOC+cXoBjWoIv8Ql9LOoG/VlnM2a1XPb1ATpCNWWdXP6OMK3nwerGR9ZLh21M2Em7mry6jJoFKcAaMGQzluzCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280103
X-Proofpoint-GUID: ctTXCaCEqhwEuIkVB_W0YPIKmiVz2MNv
X-Proofpoint-ORIG-GUID: ctTXCaCEqhwEuIkVB_W0YPIKmiVz2MNv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/28/22 8:52 AM, Jane Malalane wrote:
>   
> +/*
> + * Setup per-vCPU vector-type callbacks and trick toolstack to think


The comment should be adjusted -- no need to mention toolstack now that that code has been factored out.


Other than that


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


> + * we are enlightened. If this setup is unavailable, fallback to the
> + * global vector-type callback.
> + */
> +static __init void xen_init_setup_upcall_vector(void)
> +{
>
