Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35E567842
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiGEUTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGEUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:18:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E013F41;
        Tue,  5 Jul 2022 13:18:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JnOhK006577;
        Tue, 5 Jul 2022 20:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NpqRAE9LxGtlycXAWX11geX8OQrf0c0ByreP0Ot9OtE=;
 b=y3SGx+WDsBvYRi2u0SwbRGlPwcvwvxlLWwUUw3YmeW/ofn2Qh5XLXlIgN+ev8b9bv8oP
 RN2ZUfdxYg5Aulz2JIQnfIF3wqiELIHTTPgvkiwS4nGCPYGLtACqbPQU7wKdAl/X1iml
 pq+vWYVk/m4G8N/L/9wB0Y4DmDERbVr3K7kdIstN84cwPuEF56bwDsYl8ARdzXBO5JWj
 pKyEHJhucFHMcHLBLnhvc1zlKUxToKSZqDEWzuWvw3qiXDdG2J+TcIktZ2AO2HQn9q/S
 pInp3jqLjhujIkGN0sMDaFuVYnPb77KCd/CyD77NlUy/vEvD/cIDCJDVEbagwb3rkF4f 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyg4cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 20:18:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265KFnMF024072;
        Tue, 5 Jul 2022 20:18:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ude19gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 20:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7brpYldnFREDv0R6kGop/2NO5skkVj+PhmyxAbQZFaOoF8xY7SS+6//B8Ne9Q5FoezS44a9WUR6s7W4i1g1YdceP/XFL39jyKTGmmmfdWibkGLL/C5TwscZ7oo4T7+DFRaebRX+WO97BwpvHKWYXlG/xzt7lXc8wdBCgTXYxQQcFdwzD1VkS25HXz5gx9VAXWNV82UFiytXHaot8qFtQNNcwTimPFS7ktMkIU4wt2bPXDyYBpPHbrSIr+SJAKiUawLobFPgZ930CkfqwYYrgYisLvWHa4gKUaBTTtYQ2d+u23+ZLEKS4o8ongwzUsEcWLFhZbEMuPY26VkPYrv6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpqRAE9LxGtlycXAWX11geX8OQrf0c0ByreP0Ot9OtE=;
 b=itO4haxB22wYSiXQ+NzbEH3UyJtYuqeUOdhm352SpzvTmgLOO/AjsNy2xtwtjiH43+DJsFjdZQWDu1Hc0Mfmqxb+ckgKTF8X4fpdKCxIuWMhZTnwM2DIeCeiRWVzQaTrPZfeLi5WGeA0z5QCFmCa7HIFuQWKqg/8STJnWiUElfO/YeA+O9Qp7nrOTxczaw367ev81vJvQeV01DKHUTaa3eXt7HuaT2Xj3Q6UESU/h4zSEqZE9W5IcSc37czCHuWgEpiAfWQUPbtjQgAJw9tcWdCDgxKdmDaN1xI+midND+Jz8ikBOviDawYMiglLoTPGiQeVKHxIMVSFWXRUDcxaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpqRAE9LxGtlycXAWX11geX8OQrf0c0ByreP0Ot9OtE=;
 b=I0uW1mOAQRrskZBsh2DeXBfLgM1BNKPI72920Dvng8aT8bUJLGjizkRc/gMC8BCaZf485Oq6gJiTwk54r7ZXLCYlPDxer/Z+O7sY8De8IjEKKEB5pkd/95K65jwESaHxT/bCJP2CWWvmUFG2P2ksJwHUQFQWfOjjphmRpGwDhMY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 20:18:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 20:18:36 +0000
Message-ID: <ea0bc8e3-177c-f78a-de37-339e6261631c@oracle.com>
Date:   Wed, 6 Jul 2022 06:18:28 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
References: <20220701154604.2211008-1-imran.f.khan@oracle.com>
 <Yr9U1q0BBinCgyrT@mtj.duckdns.org>
 <deaaabe5-0a0c-b6f9-c85b-5080874f6437@oracle.com>
 <YsSD4k0o6PPYpMBe@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YsSD4k0o6PPYpMBe@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY3PR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:0:1a::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c8b256-b38d-48b9-4294-08da5ec38aad
X-MS-TrafficTypeDiagnostic: PH0PR10MB4694:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuxJLq+6Li8t4V6Wg5uNVzmigK8+dCaFylnLE4+UQNtRi9M1YR9H661dzGtCLPcLhp6m7bemxTQ89HkFvj97h0T7twUDYGzW35w61smsbXeqQdl4MjgRdd+1Uf9i6VUzEAe+JtUnCmcQhfMQwmXVIyuyc/u/03Bq6FPdbAZi9gK4dVaMjBBUbsJYz0FJiL/s149hUVmbkOpSt3th/XbxXnBLYU2ApCZ7MLayVzGJA2G016IC2Dghvl1UGe4Sg0p2tK8iedQI7Yg6EpkJis+wudMMtR/wOx6WOhv0wXmd0n5KLnIrSExey+2qIGVboYTPSNpAWkBbaaZT28fbaV4HVbAq2udK4Ja4Y5CJ/hggLUSMosUzF5E20rs+1bxKcD6px2vxL3Ye6i8UmBCYzOmpY26xQ7QnsKzC9x9d834/HZagSG70cd8OKrDRWUHqZs77zO9KbE2ldM45AtIGBQf0doTfa3BSFQAX2bmVtoafXxLWIBhVdosqavn3trfvT3+FGlHWAjn4CrwAl60DkN/nMzq+rAyBsQVFKrOIBsgmC8eM5GHBA+WagP3VZwx1Bmtvt1O8xPZoYksOca3M4Oz7GGHCop+6n3nZ8kgD3Ec+S7ORvh1oo1k1m0ot4e2nw0/8R8sy2fhEBoPg5EWhhA87r/i/gJastJqsnoMae3cNH37x5nDl6lRMRER4df0a2p3ytKBdggv9zchTtj01tDwS+0sQ25/ATKemxlF56XdfAHS70/B/2WlfOjPPJREcgYuhZNUH7R/P0+DgkdUZVnNnsPRefnzaF51hNGuJvyNHCeYCEAjJ8J7xh6+IsdEFRJWr11lj7kY5/oAObH4TCf/7r79t0iLYosDV8VAyHOcHNQuv/jklkFmon7A5OciZ2SBK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(136003)(346002)(376002)(6506007)(66556008)(66476007)(8676002)(4326008)(6512007)(66946007)(38100700002)(7416002)(5660300002)(2906002)(86362001)(31696002)(26005)(53546011)(2616005)(8936002)(478600001)(31686004)(966005)(6486002)(36756003)(41300700001)(6666004)(83380400001)(6916009)(316002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJrNmRSVmI0Tnp4TVo1MWJ4cVpKNTYzMHRoQUZYanpyYmhQeFZweXBENnlq?=
 =?utf-8?B?WGJRRDV4VWJwNXQrSVF5VDd5bTM0endTaFhHdTc2RVpiWHZaL2JlNWtIcUdG?=
 =?utf-8?B?Z0IrY3Z1dWl1bysyNlJRQldJNHlwaW5rVjdUSjBMZ3psT3ZRZlFEWllnY1Ri?=
 =?utf-8?B?K05TamtEMitzazNPYmlUTDlEd0Nxd0JzQUxWZnpVOUlTSlB1ZTN5Zk4wL2VH?=
 =?utf-8?B?OE5WM3A2NGZMZUpKSFJiaFdHK24yRUhHWndRNnY3dllEVHY4dzFZTm9TMWsw?=
 =?utf-8?B?a1Ntd0l0TnF2d2Z2aGdxQWVqTzFMS0N4bHRWUzR4NFNWUzFTQmJrUCtGclU2?=
 =?utf-8?B?Y0NydEdybCtqUmF6dHhTUlZxY3h1eVVUMWNFMUhqN2FpSzFOTXV6YVpsa1lK?=
 =?utf-8?B?STRIRXNRZzNsSGEwQmxhY2tRNjUzbWVvbkNCRWtCR1NDTDVQNzZaaGVJRCt4?=
 =?utf-8?B?V082WENwTjNUUnVVa0k1UW1Cd3lZY1ZNRVlWeTJJYW9ZTVJhM2ZMQnpaaHlH?=
 =?utf-8?B?QmNVdUlOSzI1NzFMYjJZVVB6OTlUZ2tnR1NMNjE3RlBJOHZvWjlwVzk2Rm85?=
 =?utf-8?B?aTlJRnBSbjM3NUhzOG1Qa3psVjdOSjhXeEJLTnVXR2l2c3YwdVpyR080ZlBj?=
 =?utf-8?B?WjVkRDVNYUp0bjFsQUZENVg5UDZqZDFKUXRtTXRyTUdnR1JaK3UweUhReHZt?=
 =?utf-8?B?YlBqK3EwaUc4M3g5NDRzdFIwM29tOWY4Qm5wWDVFOFBZOW5PZFBKcXhBTW5Z?=
 =?utf-8?B?cHoyQU8rdFBRdUFNSEZ1ckdyL1hrbkJXVnFkbHE4ZXgzU0lqTXRUTU5Cb29h?=
 =?utf-8?B?Wm9DcXovOXo5d2IyaFBWRFU1UENPejI0K2phaG5sMDNIc01iUUdocExFVmxI?=
 =?utf-8?B?K3F4cWxKOWtjUGs1R3lkUVB4MVlNSy9sNDk3eW5VNVBFS3FPMW5udDh1VjZu?=
 =?utf-8?B?dmlISjQrbUhxcDRQVVdDR1RKeHVvbXIvL3FOWHdrY3ZhaWVEWGJ5OEhNVUFQ?=
 =?utf-8?B?STdGa1BUM1l5ZzJhekh5QVBiVk1hZjY0d0l0VVVua09rVmo2UUVXMTJmeWlU?=
 =?utf-8?B?NXd1NTJJaTZBTHl5cUYvSTZmUGVrSzd2ZEFpcDhCQjlMMUxrUFUzSG9yVmow?=
 =?utf-8?B?YlpOa2RLRlArMGRwaDUzYjNSS1B0M3FkSXdKZ3NnODJZVFFUckJwSzhLRlpL?=
 =?utf-8?B?dzlYUk5TakgySlQ1SElJSGI0Ni9VS3ppbXlmUG9nRmlzQ0RVemJKNVJMaXY5?=
 =?utf-8?B?eHVzOGhHSk9hZDFJVGdZbHhWNlFoTWpuK29PdzZyenkzbkdVUXJvbWk0dU9j?=
 =?utf-8?B?NW1hMkZ5b0RrRUVGVEVOcndkK3RJbXpTQjdueXJyNWF4MGU1S0RyZ203YitO?=
 =?utf-8?B?NXZIak1RbHFtcDNZU3lUdTRPYzVXUE1YcE1ZN2NLVXVWMnI2T1pnNldkWXNx?=
 =?utf-8?B?VmFUUVUxa0FiNk9UcjVSdklnc2ViV2FQMXlUenBvS2V0QS94Wm52ZS9PVVhH?=
 =?utf-8?B?SlJqZFFPMnppNkZzdEtCVHNWa3g0T09ZMWtzckZzcEdKdzMzZGxQa09qTEg0?=
 =?utf-8?B?L3dnOEZWWER0QzZaNS84cjZrWDhLNmdDNmYxRHREOEJJWmJIU1B6WVpIQXBu?=
 =?utf-8?B?TS9NWHNwQ3FqSityUmdBaHgwSTNXWWVUcjZMSGlZMTNhbkQ1Q0dSOEZwSmFH?=
 =?utf-8?B?NDNIQWdNdkUzYVJFM2VTdExDRHhQR1hrYVlwSGtGdmdJYXFWb1JSZ013cURH?=
 =?utf-8?B?UmRWa25rclRaenV1ZjdoWGNvend4VzBELzNCeEJ0U0psYzE2aGN0MWQxdVd0?=
 =?utf-8?B?QkFRdUhuMm9PbklEelJpK0JQY3VXcTlwY0J5K3EwRW5Fc2dTcDlCclQ4c1U3?=
 =?utf-8?B?OEF0WUpuS25EZzNzTzRsRG5GTko1c3ZaZ21GblZ5UGpjcEp3M0tvRVVLU0VG?=
 =?utf-8?B?SG5Dd2x6NVVJVDQ4Uk9MdHFlVDRLRExjMVhFeDN2VGJLbGVZN1BheXI3YkRi?=
 =?utf-8?B?KzhpN0hyYUk4ZHpTWXBVM0FwMktTTGkxZEVHaHM4OURBODc3Ny9VdkdLQUJ2?=
 =?utf-8?B?WWM5S2cxclVRWGJ6cmV3L1NOa2UwZE0yd0hRUDJKRkRXRVBwNjdiKzR5Lzdt?=
 =?utf-8?B?U3NYWjFudnV3N2VUSjBPNjZ5Tm9FWFhSazZOWWN1YmIxcENOeStvRXl5Y0Rw?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c8b256-b38d-48b9-4294-08da5ec38aad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 20:18:36.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgJ3CbYkkbSLeAqNRcT+PR6SMAnMx0NVmhv7r/4V1xZ0sEzwkie1hxIYmWjsjQsN5BuNpEtL4DUjDc2BC3pYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_18:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050088
X-Proofpoint-GUID: PXotXwAixqAZvJHny6kXx7G3SE96Vk1S
X-Proofpoint-ORIG-GUID: PXotXwAixqAZvJHny6kXx7G3SE96Vk1S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 6/7/22 4:33 am, Tejun Heo wrote:
> Hello,
> 
> On Sun, Jul 03, 2022 at 09:09:05PM +1000, Imran Khan wrote:
>> Can we use kernfs_notify_lock like below snippet to serialize producers
>> (kernfs_notify):
>>
>> spin_lock_irqsave(&kernfs_notify_lock, flags);
>> if (kn->attr.notify_next.next != NULL) {
>> 	kernfs_get(kn);
>> 	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
>> 	schedule_work(&kernfs_notify_work);
>> }
>> spin_unlock_irqsave(&kernfs_notify_lock, flags);
> 
> But then what's the point of using llist?
> 

In this case, the point of using llist would be to avoid taking the locks in
consumer.
>> As per following comments at the beginning of llist.h
>>
>>  * Cases where locking is not needed:
>>  * If there are multiple producers and multiple consumers, llist_add can be
>>  * used in producers and llist_del_all can be used in consumers simultaneously
>>  * without locking. Also a single consumer can use llist_del_first while
>>  * multiple producers simultaneously use llist_add, without any locking.
>>
>> Multiple producers and single consumer can work in parallel but as in our case
>> addition is dependent on kn->attr.notify_next.next != NULL, we may keep the
>> checking and list addition under kernfs_notify_lock and for consumer just lock
>> free->next = NULL under kernfs_notify_lock.
> 
> It supports multiple producers in the sense that multiple producers can try
> to add their own llist_nodes concurrently. It doesn't support multiple
> producers trying to add the same llist_node whether that depends on NULL
> check or not.
> 

Hmm. My idea was that eventually we will never run into situation where multiple
producers will end up adding the same node because as soon as first producer
adds the node (the other potential adders are spinning on kernfs_notify_lock),
kn->attr.notif_next.next will get a non-NULL value and checking
(kn->attr.notify_next.next != NULL) will avoid the node getting re-added.

I must be missing something here, so as per your suggestion I have reverted this
change at [1].

Thanks,
 -- Imran

[1]: https://lore.kernel.org/lkml/20220705201026.2487665-1-imran.f.khan@oracle.com/
