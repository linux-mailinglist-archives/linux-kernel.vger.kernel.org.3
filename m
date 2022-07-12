Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48011572621
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiGLTmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiGLTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:42:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D910B241
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:20:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CIdQ1f031069;
        Tue, 12 Jul 2022 19:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iD85MsUZ8TPR4rd4PbP1LyBxIUKYZGUtgDJrOvDl/+8=;
 b=MYUiYlMHFFzmlDgaHt6zHsHfCqHaSkbzUOf4DpJ5FSDrCv+AnJpPFVwBgnZZ8E4bWFTF
 /hhkVOHIOUxQMNxJw6gCFAE9y+/HyFdRwlOrj4RE6XCz8i+AQj3qlu5bowf0aj8lTKmM
 XYeEYNZAE3vMgszxp191E3XiiMVxKOdkOZjpWBSCgiC96611k9uXzD6a8xyheSU/h2u5
 76/K4q0wXAeNcZFBYMWREoZnPFbPgn7D/hCBG+yyJHPK5/PUknb09p0ehi1aeK3ZliA7
 g02VPhz5iQhkZK+vbW5SBBGHNJ3xytgn0y7SM0lq5bJCVKMq84qzNj8T/OWOddoUyfbC wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfyy0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 19:19:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CJADdG021677;
        Tue, 12 Jul 2022 19:19:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70445qs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 19:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzSgiaA6JrYRhxiKKU4rxKoOJqNFdtgLY3+EUHGVKi21zgUwCdGri+Unrj/g5OfcYf5igdWUNLgYfAfN8GFLlaHTlWNZfcxw0aMxQQpeyH2aJy8dyRhjVFd8hNdl7kcrzRGOXaH2RzKMI+6akXHrPW6ilhyQ6Jv2UNQgnymxXDXAwJ329My/7zWF7koU1mhYV7xIhemQN5uw/H89a/rsEwJn3arGR3XuzV82OIcfyDwOmz+ZWZd18tK9zMhN9jmj4fTeD3WMkvcWqRVELllXojYsnCgQH5/B8zF0du9FOYMoY6RxgupROCAzt0EDGSO1TigbGxezKhUTiR/aaBtAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD85MsUZ8TPR4rd4PbP1LyBxIUKYZGUtgDJrOvDl/+8=;
 b=OsZrueX6TCiRIRhP59UqAiSPet5cm5h5ly3U3IGjPSqjnbpc4ea0AW1Nmj532RFDTnK/U43VX8SKUkjmTUWtWqVSHtwPzCWy2uvUN8qASTMQpj9qg/51ukeDF9G+jSlQdzOBKip6izKW09GyQLl9hyCEO1Ud8IT7clcbQu3hSAMUiUaF0HvMn8NpuLcpkuXeHRvH0ypwEIhaZAGQtxVxQcYHseYd/XOh+uF01zQia9d3mC4ijJgJNJxguE0K7ZTheIfRuKXHFYMOmttAQBTiHTV43WTgqRM4Kf3jGLaPmr9GtnYz+fOBF6FaflyTPPNvbeg5HSM8zmWMPhZqxFiISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD85MsUZ8TPR4rd4PbP1LyBxIUKYZGUtgDJrOvDl/+8=;
 b=FcYd/jSBCgK/1iu2JGd04EKQXtwOmJ9KpPMvBN3FaxmrhJigfejaoWJbkVZO7AS0cJkXX/AiHNs4u4I0CWrfxsOOC9i1XqIKDwGK+7gU/RxcmpDGhRAnlfPwIFzqtpBdIHGyw8DtlBJwBwefb6H5gUQGT8RKrxiy2kGPbDlnZ4A=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 19:19:43 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%4]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 19:19:43 +0000
Message-ID: <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
Date:   Tue, 12 Jul 2022 15:19:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <Ys2jlGMqAe6+h1SX@kroah.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <Ys2jlGMqAe6+h1SX@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a514469f-3d1d-47a0-6330-08da643b79ce
X-MS-TrafficTypeDiagnostic: BY5PR10MB4177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YSrWJ3aM2Bi0FRjqIYfs2tB8FKDhjSVvITymp1OUfmLEA/KXR3cOouT9lOTMODZbIPsOVEDDsF+AJyWxqohEJ28cBQ80ApUg7rYlpns8bl5mX+PHBo0ytou9B00lvfzhlvRWxGpVUDXW8a3DHWDkCHAhmSyRN+Wf8L1v1DUs4xxiAUPPHp/Yca9AVIyHz0HUi1skVrCkak9s70L0Vvbi8eBxahSlBO3tlHZjl0vIAyw4J67b5NZ4GxFgVAgFztELaLSSOS/Rg/apii7KouosHl+YUoniUMyR1urro5SbyfRmg6nDE92SL/n3y7DcJyCaJA5JhNZIazLeuP5YQSqsq+CVCZVRwhT0+akF1mj+H2qN+desn2cFWOqAQbEXlDGcj8L5sp7Y5g3+ilByGGKMQLJ7DoFot8GWQdCRmaQWVSDLiEQkpx8y0P0KE6BzJTkQ9IhJ/0QKaPhbC/nD/4PNWMBCOdfzfvhEsyeK5e9TMd6xjsxWoPL0HU9JT/XQnKmLWQJgw/5RcnPfWkznyEWxnU2QFfxWn0eRfPeSxUMIwIo2O4KOWhJG8yiE+aHF0Ff/MV7HvzA3VaU/SgjRw0KRSRfI/YjMeSjqlxvgStV+2u509+5fEzTyJtNuuyv3qiueCppbj+TlAKIEp3jVjaah2IvscIdxo899y1xYs7CNoLHfh7dIxAYeWBjoEeBaI8FTMlRAvesW2Tzx9LDcUEzDw/KInm4iP+jNz4TKbzDCjhRQYvw0KSiwMMYwwgAfhW/WFcfm7ThEv257B2CmiIpWUshUSFozp94jHBGUd++pMMWO7NzhwOW4lomlSs9QVg+LRDT6AqVcASFplF0s1OPcTuWB0CWfi2NB/vajOSAH5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(366004)(396003)(6486002)(53546011)(38100700002)(478600001)(31696002)(86362001)(26005)(110136005)(6506007)(36756003)(8676002)(66556008)(54906003)(31686004)(316002)(66476007)(2616005)(4326008)(66946007)(186003)(41300700001)(6666004)(2906002)(8936002)(6512007)(44832011)(7416002)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEQ3OUE3M2xYOWs3UkczWWVkQUlRbDFZUk9STEJjNmtJTmwrUGVid2tRRlBH?=
 =?utf-8?B?cnUzZjA3dGZscEs4VzBOZ2dmY2swODNJNWVVTkFObnRnazZES1kxRGtYeHJJ?=
 =?utf-8?B?TEYyMXNYQmlpRTc0eURPYXhhZGc1TStLSkJwSVZVRGF0cGhxQmpVczEwUjdU?=
 =?utf-8?B?VGlaNWg2VWRWODc3ejVnbGU3emRtcThaR2FOTG9ocFZKajZsS0gyMm4xdWFs?=
 =?utf-8?B?YmFWTUJmVUlwYm9kdTJwUnNIRmJQcUd1N0l0dDJxZzcyYjR0dHdseGlaMnhn?=
 =?utf-8?B?blBPbkw0YUNyaGhUVjNCS2NlM1lKdWFRZWZRcHB6VzBocndrK2J4Lyt0SVdo?=
 =?utf-8?B?OHc2OXBvYmt0RjZYbHpxUmNIdk9xV1ZxTXlQNENTVUNPdVNEYmVYNmhvUHpa?=
 =?utf-8?B?UXEwM0x3UG1tUFFUd3o1NG41YTJnMHFMZXEwVFQ4VjR6ZWlrZ2Jsd3JYOHpF?=
 =?utf-8?B?MVZNSGRzejBmbFVXbm5ic1QwVm1YcjhGMUI5SUZoKzlBNFpONnQ4cDJCV01q?=
 =?utf-8?B?MzgwWnl5K2NTd2grSTd6TFhkbUkxZFZOY0dJdkcvcDVLamY2MVE5OEVBZVZs?=
 =?utf-8?B?YVpxL0xtWEZhbFVabzRYVEpxbmtEZWNjdGh0WmM0bW4zb1ZKVG5SWWlabG1p?=
 =?utf-8?B?SzU2N25Mc3QvMXFySHBMcnF3UDZpRzNUY2JYTUZwU0hvd2FKVnVYREhwMEcz?=
 =?utf-8?B?bkVEdGEweDFrSEdocTRGOGFCMTVoalpjQkZrSEpFS3RkVzlCNEtMUXhMZWlm?=
 =?utf-8?B?aEhSZlFZcFVVVGN3QkhzbGpzMTdzNWoyZjFsQm5yV2VRNS9CZGtQUi84bWc4?=
 =?utf-8?B?ZDBzNWZFajRGdUVTdk5jL2lnYkFtNW9GQTdtbHNGcEhyZlhqa2VvZXNPTEdW?=
 =?utf-8?B?cTdER1Y1bzZQdFdlN1llK3lIVTJNcGV1ZDNiL1RrR1lXY2JaR0xXbTR2WU1w?=
 =?utf-8?B?THh1TnR3NWpOVXB6QWZXT21neHdZVXRtZDdXcHJJL29LaEJoOCs0NURaT2pr?=
 =?utf-8?B?UlhiWVliMjJRSUExaGlDMCs4R05VZ2pRU1VDait6d09WY0tCVzRXQ2lyVjVT?=
 =?utf-8?B?eVVnSHROdUVORlE4aHA3NktHWCtqNjhtVk92eElzSnVSeGRaMUJsNHZVdm1y?=
 =?utf-8?B?U3M2Vlp2YS85UlllQnFmWHgxQWxnSVFoMjZHc05tM1pReG1GVHFmY2l2T29K?=
 =?utf-8?B?UXRtUzJOdndQYUxuQkJmMmsxZjl4aWNDYzhzU2ErMDdXVVFPS2RyVmZRdFVj?=
 =?utf-8?B?T1ZiUlVnQUh3NEZZcDlFSHJNMlc4R1BnS1hJdjBVeTd4QisyOE9XWlhWOXBx?=
 =?utf-8?B?SGxFZTFvYW1MaWVHWWJFaFNReTdwdStqN3ZpOVBNWE5tWUtoYWJPaW9qbkhC?=
 =?utf-8?B?RFRvWUI4OXlYYWNzQTFKVy95WHR3UzhoS1o2T2dDM3ZvWVM5Y2t4N2xmcUdV?=
 =?utf-8?B?MlFuaHpJbk1LUUd5NVAvUE5QTDJhTHBMaUhKSWNtdFdyTCtIbUdlOE5HbE9C?=
 =?utf-8?B?SFJTSnF4clJDTmlwK1FWNkd3cnRER0g0UVBtaU5PcmtReERBUFVDMnIrZXZm?=
 =?utf-8?B?SnhVQVZZaWVoQnRJWGxLRVpQQjRSdFNVdEl1bG85ZGtkald4UE5sWTVlaUEx?=
 =?utf-8?B?cHdCSlZ5a2pDN0pDdjVqVy9mMU5YQ21OVWw2SVhVYUt2YkR5NmVUNlpzeXk4?=
 =?utf-8?B?M29iVjNuMkVUMXkxbjBLb09pUTBDdzQvY0RRRXNoMzRRM1Y2cjJBZFlUcy9j?=
 =?utf-8?B?Y0RXWEtoYkxsZTJGRWs0ZGhoL1J3cUlpVC9keFlxUDlSRmJ4ZXBic01pQkVp?=
 =?utf-8?B?ZXQrZmtJM2ViakllMXBQZE9uc1RxQlZDT1I1TlRKZXhCYmJweDFwQzhyRkoy?=
 =?utf-8?B?SDBQNTNtcVIxbUJWaStIejZmUThTaVhmeEZUUTlZVnlFMWlBc0tuYmt6Sllk?=
 =?utf-8?B?QXFoUk1MRTFsZjhFOW5FeEt2U293WGFYbnVidFphT0xGL1Nva3BxRStWZHZE?=
 =?utf-8?B?RnErOGdXckRJcy9tazJTU3pCSFRJVFdINlpZV2xobWpBelI2eGVCZ2VWSEFn?=
 =?utf-8?B?a1piYitJN0tBSGQwQlFYL24zNDZOY3d4cytPV0VzZGN2UU5vSm5pY1FtT1Bx?=
 =?utf-8?B?NXp2S2wzYlhyamJ6OTVVSFN5cEJQMFMyTFVYLzVUcnRHUThaeDhNMmhkVHo2?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a514469f-3d1d-47a0-6330-08da643b79ce
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 19:19:43.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQJM1K9sNLgGnSc+KfmMDVuavnqpn33RnDHqw40ta7hbJYnXiGUk4ygyUzZF4SLrgrBM6FrFroAtoG4ZcDInMoCrM1epNkHvxvvFt5Tjvm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120078
X-Proofpoint-GUID: 90l5qejajIJQaoY7LC9GUmnpRHoQle1s
X-Proofpoint-ORIG-GUID: 90l5qejajIJQaoY7LC9GUmnpRHoQle1s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/22 12:38 PM, Greg KH wrote:
> Hi all,
>
> I'm seeing the following build warning:
> 	arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update(): can't find starting instruction
> in the 5.15.y and 5.10.y retbleed backports.
>
> I don't know why just this one hypercall is being called out by objtool,
> and this warning isn't in 5.18 and Linus's tree due to I think commit
> 5b2fc51576ef ("x86/ibt,xen: Sprinkle the ENDBR") being there.
>
> But, is this a ret call that we "forgot" here?  It's a "real" ret in
> Linus's branch:
>
> .pushsection .noinstr.text, "ax"
> 	.balign PAGE_SIZE
> SYM_CODE_START(hypercall_page)
> 	.rept (PAGE_SIZE / 32)
> 		UNWIND_HINT_FUNC
> 		ANNOTATE_NOENDBR
> 		ANNOTATE_UNRET_SAFE
> 		ret
> 		/*
> 		 * Xen will write the hypercall page, and sort out ENDBR.
> 		 */
> 		.skip 31, 0xcc
> 	.endr
>
> while 5.15.y and older has:
> .pushsection .text
> 	.balign PAGE_SIZE
> SYM_CODE_START(hypercall_page)
> 	.rept (PAGE_SIZE / 32)
> 		UNWIND_HINT_FUNC
> 		.skip 31, 0x90
> 		ANNOTATE_UNRET_SAFE
> 		RET
> 	.endr
>
> So should the "ret" remain or be turned into "RET" in mainline right
> now?


It doesn't matter --- this is overwritten by the hypervisor during initialization when Xen fills in actual hypercall code.


So f4b4bc10b0b85ec66f1a9bf5dddf475e6695b6d2 added 'ret' to make objtool happy and then 14b476e07fab6 replaced 'ret' with RET as part of SLS fixes. The latter was not really necessary but harmless.


So it can be 'ret', RET, or anything else that tools don't complain about. It will not be executed.


-boris

