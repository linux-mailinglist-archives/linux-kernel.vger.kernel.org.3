Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA4547FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiFMGvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbiFMGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:51:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE915828;
        Sun, 12 Jun 2022 23:50:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25CJA7Vo023173;
        Mon, 13 Jun 2022 06:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rdT0Kmg0WbQ1x7KCFmYDIzbJUVE8Kl9lqsFxVCWGRB8=;
 b=aSICDTZT1PNK3V2MCDIb118/J8ckn7Mf4CNsklJqyLG3FioGsqFHnRQ/Mb9re8p4VJ09
 HqY7cCMoz3ZghvcEeH8sGTxGuhYYVq+Lc7ktgAllWSc/2fc3SLbXYDL8qLA+GAB803Xx
 txDI3iaufuFnkB07Y2DTp8iYEKCBtTMjQO6WFGCv0h9FwaqekKnFKfISR/BiCl/05pUO
 HhuDCx4xVtKc7BzvEQflthz5pHhHOi4BDcbqwDkftuAoFEZScCE+ideST57WL0F1pltg
 ZeHllJqJpK9plUTNmOTDkbzy/HMUzECXBByMqqgNP3JayUodRf1ECMeg6dKQlqanKCD8 Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9a6rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 06:49:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25D6fHRs023155;
        Mon, 13 Jun 2022 06:49:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg34f3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 06:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhnBmCqDPygfysrqtLdgROgH0JxSz3F3ORJd9JiskU1GPqMibQivgB2jgwfln6zMuMNy8mV/3eQn+f5aaSlgWxpcgZWqlyolPvw375obq/0z2ALay9PlEqs4C5Qk+eyrNzhMuw5loNcveJMhoNsyPN6Evf2BRUVpz+C4EK1VUjIPSwatFLG2evZ9nBNHLaWSs5WZ+3JREUpDBg3N7W68b2Etem3GOz3zxUxgEsanbt2z4Rjh+CZGga+9AIgBe4U/SC8CZLHc/1WPN87+n61/dnVxkg4VifK5evxDVJQn41/WvKurZUL5CBnehh1Cl3ijA7PQLOZUgX33LD43IX1meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdT0Kmg0WbQ1x7KCFmYDIzbJUVE8Kl9lqsFxVCWGRB8=;
 b=cPW/H/ZB8550cK4QULEISPP1NrB18t7RKpX1DGzNPzff+lPFZstWn10yfbAKkzPpl08zJz7Qv2IKwQcJZAp0FnFB06WDdelmj4dG5/R6XUJcLDm8zmeOoePqlzWQcLJwz9pEh0geH7lTUsX1KHeart78PpqMmNnl9n3h7b3vpXg4wr67bWSZsrVAaRDQGFevLLJRysOdVsod3xaa+LG0HmohG+Y0MoVOQXTUxKYwf6Ib8VKNvp436Cf6UJIxPE0gacnVbXPJd4Z215BobnQfDmd+jplMpTItdacw5nmGSAZS9cvei2m7jiyVSLJmGAT9+kgj1bplU+EXiWER9P5akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdT0Kmg0WbQ1x7KCFmYDIzbJUVE8Kl9lqsFxVCWGRB8=;
 b=UbD8WyOhsUA1iB0506J5NhMA3zd0sqUj6oaSv8Yv4Za79IHhge1MEbRzZoV0cBQD38+mhzxtUF2Vo8o+Jaz4HGEgRSenxjx/8B5hrtMK7G4xlRb3pSmjWHwimQmAvZkC/ySXUmeYvk+c+Ir4/aHGU3zTMfQxaewIbtKsSgH5Vyw=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN6PR1001MB2100.namprd10.prod.outlook.com (2603:10b6:405:35::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 06:49:50 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 06:49:50 +0000
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org
Cc:     corbet@lwn.net, dave.hansen@linux.intel.com, joe.jin@oracle.com,
        linux-kernel@vger.kernel.org, hch@infradead.org, mingo@redhat.com,
        bp@alien8.de, tglx@linutronix.de
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
 <20220611082514.37112-5-dongli.zhang@oracle.com>
Message-ID: <4c1e123d-6b5d-7fa2-d072-64deb119ae10@oracle.com>
Date:   Sun, 12 Jun 2022 23:49:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20220611082514.37112-5-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::20) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db9885e8-337e-49f4-f956-08da4d08e9b7
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2100:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB210006DB7C593BA85C365058F0AB9@BN6PR1001MB2100.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VQC+uxT1Wd+z6iaCp9pU5xJk2hiFs3QgiLZB2L6BY1uHlhT1lBNwBesQ64HIeY57uaFo1s1hofr3fYQw+GsO2wEdbk2tPpia1Z34Q0AfNUyA+bX0mrGJUqV7n7BYg1qYFW8UWCYjL59U2sqESiD0q6k5eBKKUJfB55HNmK+KaVU2U8a8IHqGbAJQ0aOG6oHXeBiEz3LQrxqTMCTRnHia4W92DeyiiXModVYbHns7Y6JMaRgqdASgwYQ2r0lbla9iQn5FZhGBwl76cV0yrfcVVSu0iqgq6pZ1FygAMGDDUycgVOVLyH7Vcx+YuWX5GQqWWrggBxGnfQeV4sHtOel1j4GkEUhYNHT3bwg/d0TZ06Y8XQVxcDlkOFCnnlWLYSuF16E6Nmc7IinHAKIqlCdQ22QrJvPNTwBhaLNbfuMVQxLUgAh8v7Pl3H6/u9b3u/iyMUZiL4tYAWIMSraVW9CI4rQCSsZ62+2qpjHp4pBPJuKXW2ucotldeTYz0dEh1r/MCpDPJsjr8FUqcaYOJ/EJ5Xnj5nsDmbI6XIXNkg0Cddd2QgOqN7lhqNPgXkWgMC9j/bF/RsApRrfIUATLY0RqS9nWIH5EqrNAyfGjbFxAjOQ+9JrMoVCIJZf2oGGaM1DTA/dNb+vROyAG63SmsKYhYIUrXYHqpSgSHP0Vy2HMwvBRNSdmv6ExW88+thQDsxfph32tFyRkMqJVOT4xTjkunphwrDKd5nkvJyqI4dRHV+ZWcSwA5OikLHZFVZ1/lPFSfgiL/sDrFMemVu385TD5jeghqipbc4EflIHDJgNt80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31686004)(6666004)(53546011)(6506007)(83380400001)(316002)(4326008)(66556008)(66946007)(66476007)(36756003)(8676002)(8936002)(38100700002)(6486002)(44832011)(5660300002)(508600001)(7416002)(2616005)(2906002)(6512007)(31696002)(186003)(86362001)(160913001)(15963001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJUejllUEdVRFpQRXU5TFUzVjZ6Zk5BbmRXaVhwZVVFQ3hLcTFJNkF3UEdG?=
 =?utf-8?B?T1VtNUhJNUVoMlpNQ0dFZ2MvMTZkQkFSazZaRXRSRzhzTit5Q25QcXpDWmxv?=
 =?utf-8?B?N213Z2Fnb21oanJhR3pua0dVTFFpZk1LSzN1aktiNVBWUkxGTlJPTXAxK0Vu?=
 =?utf-8?B?dHBQc01TdXZaakR1bVZPY2pEMkhUYXdSSzVGWGpmVU84UzY1aTVWMVhGN2gw?=
 =?utf-8?B?UEVZRkdUU0I3d0lRa3FmWnBXQnhIODVTaERzZ254MmlEa1k1aEdXK21wZzdS?=
 =?utf-8?B?VFdmOUtCakhLc0hCSWEyOEZRc2tWNFltMU9DdEt2d01CRDVnRXRqeXZMWjQx?=
 =?utf-8?B?MEJaZkQ0QVBXWjVERlB6QzR1dko0WkUxeU4yY2h3MG4vcmlJbFYzWjVhTDgx?=
 =?utf-8?B?NWdMUVhCQ0ZiVzBDS3k4Q0N3OENMWkc4YytUaWNianVZOWFtaHdmVmFtQnFt?=
 =?utf-8?B?T0U4cEwvenRaelJ2azNIOWp2Y0RmK3JSVVNXNnVJQzBjc1hpMjdnZWRGOThH?=
 =?utf-8?B?ZVB1bStEdWxXT0F5dUNaRzBaZW9PcktwQUw5Qkt1M3lnOW91b2pTSURoSlZU?=
 =?utf-8?B?cnY2Ykg4aktLcHhYbGc4eUg4REVmVmpVZDVHREpmWEdPRy9aSklhOFkya1FD?=
 =?utf-8?B?L2lnQm05d2srNnB2T09rY1p5bmU0dk5Wb2JCZHlha3RzQWZmUG9RQzZmMjZV?=
 =?utf-8?B?dzM0NzVTSVBVaUZxd3UxTGtHdUN2MkZTOGYvMEFvSmdBM3NabXROblJVdnVn?=
 =?utf-8?B?ZEZJWjlyT3ZtdWg3V2ZQMmtlK0h1UFVjT1BaYWJicGU2VzFhMTdNMzZUMDdm?=
 =?utf-8?B?YmJCdUkyZyszNHNxRGgva1U2NWU5WWpxVks3emlFd3l2ZUEwSVpIalZjQUlz?=
 =?utf-8?B?aFpydTNKbjkySy9VejUyZnVkWXFDSmVkYUlFb2hsSUphK3Q4RGFnTmN2K3dC?=
 =?utf-8?B?a3RTaDFqeTVZSWJtc2IxQk9PK3pMV01uNjFpSFFOK1A5UUV5Wit1bGkwVk9O?=
 =?utf-8?B?cTRMMVNwaVNRUHlDb3Ftbnd6Wms0Z2k4MDdOd05aRVNLZS9vVXkxMk1nZS9F?=
 =?utf-8?B?R2QwRkVZNkhtbUdZMVRvb3lYOG15ZVZ1ZlplbXRvK1A3SzZSdVAyMGRMaitC?=
 =?utf-8?B?WS9KNmNvVEkrc25MRzRmbG05V2YxN3dsbWJyN2djSk9hbHY1Z2pWZTJ1Sy9l?=
 =?utf-8?B?Z21ib1RWT1VpY21Lb3BvcWlBTXk5cFAwS1JzV0VKYXNocjNKenZ0R05WdnpH?=
 =?utf-8?B?ZWxMcW15dXJsbHlGM2JoeTlEaXZzb093M05mK2l5UzR3OWQ4cFhsc1hyVHp1?=
 =?utf-8?B?dTNlQTFkNm50bVRnQTRXd1hMYTQ1SVF0UTliS2VXUHZnQVkrT2Zxa2c3a1B6?=
 =?utf-8?B?enVuUlBxM1FIQVp2d2ljQURHbGFlQW9wZlBoSHluSG1DVXNEUnNGSjdZVmFi?=
 =?utf-8?B?WEU4dTdkVkpIeWxxcXAyQ2JwbjNwb1E5bUNrM3Q4TERDb3Z0SmR2TFFoQlRq?=
 =?utf-8?B?b213VVJDclpQMXprSkxYdENGb2E4ckV6K0crWCtycGloSmMwb21ZdnN2U3VS?=
 =?utf-8?B?Yll4S0Z1b3NVMmI0bHNxaW9WVlBOUGN0MzRwSmFVQXlOK01rb2YwK05razd5?=
 =?utf-8?B?Tk1xV3JDV3pDMWtzY1MwYk8rcTNuVGd4cFpiZWF6YTlKMFYzR1dPVGsxbnpo?=
 =?utf-8?B?c3FEZVNVRTEyRGdqc0ZVdHk5eVllZGJUVGRwRHhIbXM1d0pDdDNuMHV3TmNK?=
 =?utf-8?B?OXJRVmZkVUw2WWlkcTd4RGlFeEJqb1p6T2I0anRiOVp0NWtFajltK2IrbXU1?=
 =?utf-8?B?Y2pGUElFcENaZnQ2T0pQMi9IRWd3Q3RLWjVGOGF6V21BTEFUdjM5eThIYmRO?=
 =?utf-8?B?ekF4ZlY3M3kxaUR6RWtFSlFrTE1pcXl3L3F4bW1iaEVWbDNJT1UvNXBCQzZv?=
 =?utf-8?B?Uk1zUVJrYS9HTmJMYVNlTlBUa3Y3WC8wbjV4SjIwcHFGamc4ZWxjUUhPNTkv?=
 =?utf-8?B?NWdhaGNkY1ZRdE9mQkw4djlBMjQzeHlFNHFOZUVVVWgySjlCdnBDakhzSGh3?=
 =?utf-8?B?cnFiV29pUFBRb05YL3NRdTBzWm8yL0JRWTB5Mld5TFNHbHM2TVpraEdqSFQy?=
 =?utf-8?B?NnAxd2N3VzgyL2huR0ZaSWt4OE96dDdUR2V0dGFCVWZ1bnlJRXJxanpOMXVS?=
 =?utf-8?B?MEk3eU4yTmN5NDBoV01adld6cUdFb1AwMFhiRGtGRFBYdUNXdkRsRWd1RTJP?=
 =?utf-8?B?WC9Ga3JWSEVHc296ay85b3ArQThwNGRLYVBpK0ZlZ0xyTUhiSkdYZ3RBS292?=
 =?utf-8?B?bjZRMzBvVEZkVHdBSFQyaUFNTS9rbDNpaXBqWmhnTCtvanZQVlozdHhLQzh0?=
 =?utf-8?Q?LHAn1vRY6CIq5WqE6e5qnWDWt7ezbThLZfdzg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9885e8-337e-49f4-f956-08da4d08e9b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 06:49:50.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3BrGiZMNESdbI42LortYjilgP6xgxyc89I2i+DsTY/AjyeRlfizfAa60aAPXigpfy8ZY15rLvDrrv9VwZP4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2100
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_02:2022-06-09,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130030
X-Proofpoint-ORIG-GUID: wGRElR9f8iznPO59CAPgRyW1VfN_26WZ
X-Proofpoint-GUID: wGRElR9f8iznPO59CAPgRyW1VfN_26WZ
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/22 1:25 AM, Dongli Zhang wrote:
> Panic on purpose if nslabs is too small, in order to sync with the remap
> retry logic.
> 
> In addition, print the number of bytes for tlb alloc failure.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index fd21f4162f4b..1758b724c7a8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -242,6 +242,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	if (swiotlb_force_disable)
>  		return;
>  
> +	if (nslabs < IO_TLB_MIN_SLABS)
> +		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
> +
>  	/*
>  	 * By default allocate the bounce buffer memory from low memory, but
>  	 * allow to pick a location everywhere for hypervisors with guest
> @@ -254,7 +257,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	else
>  		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
>  	if (!tlb) {
> -		pr_warn("%s: failed to allocate tlb structure\n", __func__);
> +		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
> +			__func__, bytes);

Indeed I have a question on this pr_warn(). (I was going to send another patch
to retry with nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE)).

Why not retry with nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE), or panic here?

If the QEMU machine of my VM is i440fx, the boot is almost failed even here is
pr_warn. Why not sync with the remap failure handling?

1. retry with nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE))
2. and finally panic if nslabs is too small.

Thank you very much!

Dongli Zhang

>  		return;
>  	}
>  
> 
