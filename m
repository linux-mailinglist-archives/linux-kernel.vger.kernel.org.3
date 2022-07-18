Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F405783D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiGRNhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiGRNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:37:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929B1A3B0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:37:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZkin014113;
        Mon, 18 Jul 2022 13:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=h3hc/7NY/DrEOQX5zwjF5UBKGhznt9ZhD2uleomkU/Q=;
 b=RthPlsgVOcm33mlQNazOot5Kgu1ahPp3vYsHTOuILAa1siKQUYhK2pyniVbN0m8gEOfD
 mbMyPMncNKnbtR6bSN7TED3prSVi3wCpTPDA1P1mM6CjHkJftptjHfIZKlzUltigd9mu
 45PkmA29EvcnD/lWXPkNXkU+oT7TvR20RcDVLZ2OtdBq9NCREl10wi1pHNqFsXVEr7eQ
 RqgZt40RamyspvQmW4MJLqnwIAqdlTSBWz3jdqZ+AdsdbAzPFvi2TQYKjVIccX+sBgUx
 zFIxJzgN+xS2hMQNTJYcuTFxIiOzsK7/RbvzeDlCkpUsrPVGtxc829GuH+QOO2lNFZCg zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a394c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:36:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBXQvi027415;
        Mon, 18 Jul 2022 13:36:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ma8s6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAW3qDYDmhoNYj4DjMY/6yEIkP8Lw47XR6+/45eTUWGvWLt+u12uY4UFFf8Ss1Kida+NIWjDxJoaeAIpRucNKiAz8EhpFPWqZ39Mm52PXG/+Qz4eeXz2MbMdXmq+uLvbigE2e0hG/Duod4ILkdsXkP6Xt+rO8L2Qkwg908BV5aunLpGU4pJb5CR5WyfikKNYa01ZmZrEU86CbB4Szk3ED0UiPj1AZuYUsdEebLeRq5sG/I29KUrWJs8MVrepxvpm8p3t89U5aUyIS05kuJKHLODsB/KnJ+6uXLt1tVoEyeKsaqzuAupkKloEW6a7bqblA5A0pGnbBF+GqsfGN08szQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3hc/7NY/DrEOQX5zwjF5UBKGhznt9ZhD2uleomkU/Q=;
 b=k0KWLSQ2MpNwT8nrOAULnTBQN6Nohozetk2x8nfsc/++tC5p1Rqz5jctlfNzHEF1FW3bNC5ooeuXI+/ndRdXDZ6VAwYZVzxb1jZ8pmQ3N/W1Gfyl8elUA5ZJlJBbJSuNU+Ukvc0+jHDtjbLdq6YTfo3m7jt2wVhtwc8TEbEbaNo/DQYRSHDCJkMllnjdvyxoVZSv5jc/Cf8fsTXEygdx7lD8D2ytWhTvHAk3li1sLuaT8yuh0mn3iFkvaMfGez2mIPFsuICCHJHclOE+50kbTFYpT+aqkstUD9cfhoeEZt0He98ueohJxLA7anoWeGpqQcr2hfHMx5B59bQOL80Qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3hc/7NY/DrEOQX5zwjF5UBKGhznt9ZhD2uleomkU/Q=;
 b=TCEsuc0WITOrDUCTARBxngn+Rg4Aq9VrbajVSg+EHFGb0QQ5/YVTYfSi7lnSkcpC3LZ0UF2AP1opk2BlAGn8EiKh5jlUnhwbBnMu5jWnFC/LWjRtgx8KURG4yddYrSfIIVvyrmjgM4A5xTERYJfdnci3aXC/mZqpe3vDBWhgbxU=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BYAPR10MB2712.namprd10.prod.outlook.com (2603:10b6:a02:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Mon, 18 Jul
 2022 13:36:33 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:36:33 +0000
Message-ID: <7e075c90-5adb-856a-36fb-73a8d424cd0b@oracle.com>
Date:   Mon, 18 Jul 2022 09:36:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Nicolai Stange <nstange@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        Ben Hutchings <ben@decadent.org.uk>
References: <Ys2jlGMqAe6+h1SX@kroah.com>
 <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
 <Ys3MI7cv2yKj9RFc@kroah.com>
 <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com>
 <875yjxrp66.fsf@linux.fritz.box>
 <ed82e54e-ccc4-f514-7018-8410d0f5bb82@oracle.com>
 <6eea38ab-17d2-7bdc-1277-9964a3828a9e@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <6eea38ab-17d2-7bdc-1277-9964a3828a9e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956a61a8-131d-4a9e-29b5-08da68c28798
X-MS-TrafficTypeDiagnostic: BYAPR10MB2712:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHvj6O7548uKtIk0ulA0N2QJlcFglZwKRqKYtHJACknQLw9ah8jra3wt8r4YGesAPIfnUmYSVey97XMTUGL4R9wXo3yH36HAYRUnmkQAQt78j2mQn0NOoXGgf+Xj7ma+QNGpNpBhuW7KaH94xMMGPYsKRBaRpa9uWPHmLZnDV3FktD6p9muG94J1xWsKlgLDx0jlEueIlm0BVGVpzxnPcriaUPi7s8N/BrKRIehz2lrtUrOEeOnIpsqSA58a1EHMIfQvbhYyyE5GxU8RJakYk2aDrdT5aeUSYkZDTDFxpfMqp9kUtGNf+broONUCju2gZ5ULpx8SW637rT5Rt9TSLx6VNChdVu66oGgakH4LEf6u66XXAdQ4kdip55XM2CT2gBe7vhKDv0TXh6h6k/S11uar7gQDkDkSGkQJwEaH6M0HzU0NtyrpDHFrpVLVB4sCj6iD/kGyytVRJtQzZO3a5PKelihv4lvFlc/9feBnuG1SUvcVFt78nd3iA8xLgEz1RIX+IMR3pPExbNoU4iQyXpSVj4HB/c0jvrLr4Z4Yyk50B/iBThy8WN+f9cAq+L4b8/lfqMQIcIyyfmjp18uupbBhP8bAN6H9XN6rVePQ7eyYegGvjrE2J8EeSJjzj91AfjB4dJcRa/TY6IZRkHQkW5U+oFe3FhEzk9Tk3E/YlM9JnkpP/rnqlPEY0xtqyNxRq25uYn2Xn45eo4eHhVZl9t6O0x3KYif+dppE44frcmfO8MkJd7S+ro0jkDAo2+yjcCcmfGwzpHkQk+G82VeFH5EBaluIwIHG5M9MuStFmzj08zQhmRN2/M7svnLHBDMItjyRfD2sypHF45diS1wgI1wNgL2WX6uG6gKamC55Ffw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(39860400002)(366004)(376002)(38100700002)(36756003)(44832011)(110136005)(31686004)(2906002)(4744005)(8936002)(5660300002)(6666004)(26005)(8676002)(316002)(2616005)(54906003)(4326008)(66556008)(66946007)(66476007)(6512007)(478600001)(53546011)(31696002)(41300700001)(6506007)(7416002)(6486002)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxiY2s1Z1dXQXl1TlpjVjR0MVltc3A0TVRNRnlsSDFxdzdLcGhEZHp1cnZX?=
 =?utf-8?B?UEpOUUFiWnZEU0o2d0VVWG1PeklVeEZkd1NqR083SWR1bEZFMTV0RHY0Z3ZG?=
 =?utf-8?B?OVpndFBXcCtJK3pWUTBSbHVDbDBybnREQXRPL1l2WnZPekJHQVo1dW5TbzVs?=
 =?utf-8?B?eFJvSDV6NW4zNHpmWGlialdvSUNoUTk3VFM4Sy93WFNWN2lLTWdLcWJMZVpp?=
 =?utf-8?B?RXMwNFl0a2cyVDNVNGRzdS9ibXZMUXE0akpmZWkzd1U5Wlk3ZnpiZTQraU5y?=
 =?utf-8?B?RUliY25tZ2syUWkwK0E4WGI5TDk0QndnQjFKcHREckhPMnJQSmlxUmgxMWEw?=
 =?utf-8?B?cmRNMndJcWRzUityelZnQmhhblFtNE5kNEc5Wk5PRnhHMitFTXEwaE8vOFFp?=
 =?utf-8?B?cXJZdGs5amN6NFhqZGhsWXFZbnc0c0RPS2ZkUUZHNEpiNkd5TUZCckdtU2dU?=
 =?utf-8?B?V2VDcFZpM1habjRKMkl3QWR0OTN6OWVHdXd2YlFLQ2pqaWZtNGRScmJnNDly?=
 =?utf-8?B?OWdmeHlFanptMHBTS3g0cWFXQlN5TTJRNDY4ZEV5UEVBZFRObFJ3TjdHL2Ns?=
 =?utf-8?B?OEdxOTZpbFJ1clk1OTFMSjg4ZU11REVSM1JvWCtvck11MWdNT1VJbDBja2FS?=
 =?utf-8?B?RHhDSytXRGV0bFo5UGZPZ0RnM2E2SHhZbGx5V21HSTNGMEJUbE9zMHFkaC95?=
 =?utf-8?B?RytYRVpDdmR3Nkd2WkNHTUE1S2NtRFhRQnZZdHNQRkVrdVVtOXRKYit4VGZM?=
 =?utf-8?B?UWZuMlI1S0JmWlR0YU5CVWFmdDgwcVEvVVBGdHp2OEVoT3hldlhSbGhHcWFM?=
 =?utf-8?B?NVg2czhQSkplRERJeHpBRm8zYVprTnpoWllwTkh1WGhGcG52czlhbkhqbC9l?=
 =?utf-8?B?OUxWeERyUFVFUE1yclg1Tzk4NmgyS1VJaVlCUExCQzlnNEwwaHprZFdSMks1?=
 =?utf-8?B?QVI0L052YmpIWWZJNVJkeDhFUTkrWFpMakNvYU5zNTJ3U0VzVXhtTExUaVB5?=
 =?utf-8?B?UUYyb3U3RmlzZDVUZGJuU3l4VWU0NkJINURScXJqYy9TcmlTY3Y3NU1KVEdw?=
 =?utf-8?B?RFk0UnF2SlFWeXJ5L0hEVWsxU3docjhuWm9XZEU4eFpnV1VwWGdtK1A2VXIr?=
 =?utf-8?B?ZktlRkpKeDZBS0YzaUdHdzZJdWVPZmlCYldBa3gxaVNPUXpIREJocnVka3dx?=
 =?utf-8?B?cG9xOWVmVStFemIwS3JpRlRrRWhYQnliUUh6L3BMOUFLOVlKcWpmZEtIbzVY?=
 =?utf-8?B?ZFhWUWxMYVptU1loWHJOdzNydy9HNzBXM0Z3TUtFZTByd2kwbU1md29NRlF6?=
 =?utf-8?B?aUltSG9oeXlLTGJHQWI1dWxmUDBXSWY5b0VmY25kOVFtdUduNVVkOEpZbzNK?=
 =?utf-8?B?SFFHcEVCVGdYRXZrck5mcWs3cTg4emh0aVU5RkxWVk1EZzZlaUJTZWNmQ0Vm?=
 =?utf-8?B?akdSSkN4WkxTR2dTZEY1TEtrY2UrVytVbkJpS01HMmhIZllNWExOTUhYcXFn?=
 =?utf-8?B?cHRqQTRVa0tFVGdFVVBkaS9pOUgvVmtpcTZmd3hDRTNGUWV2dDNuNzBhUnhj?=
 =?utf-8?B?eGk4TW93T014cDk5aDU3dXUwZ0VxK281aW1RZjZyS1pwUTYrb2hnbWNuS0kw?=
 =?utf-8?B?ai9ndTkzcHdGT1BsSlVXK25LMGM2VDMzdlpmalYwQ1I4d3ZiN0lRNmRjV21a?=
 =?utf-8?B?MFN2Uzd1cUozRHE4d0tOclBsallJbFpZazFROXY2b1M5Y0kxaExXbFROb2Ni?=
 =?utf-8?B?WkN5WnpmQ1E5RTZjTGNZNnFIdWo1S2ovQjd2eC8vdnFLTWRXdEFqUElqMVNw?=
 =?utf-8?B?Z2NlbVJLbDNpd3ZlNkhWTFYrSkY3VXYySWRNUDRXZGMrck9NUk5UTXBVbEFP?=
 =?utf-8?B?NS91cll1VTV1RW5CTUlwWjMxb2lmWXZsSVM3ZkdLRmIxV01YVGRGa004WENL?=
 =?utf-8?B?ZndaSjhjZ1JjQW9tNTZDR3N4TDN2ZXRzbm5MYnpNVHRORUxZV1g5MXRPRjNW?=
 =?utf-8?B?UFhVcmNYalpyMWE0VXNPU2c4K2N6Rk85OHFoUlFzcm9tb2oxQ0VSRHVxVVhl?=
 =?utf-8?B?Q0h6NDRKSWMxSjd4K3Q4NEtkU0ZJVDZHNXl6Y3lRVXFSdU43bGo3Qk9YMitw?=
 =?utf-8?B?NzRRdkhZc2lDbG1JeGU4TUVRT0VaUkQ1YmtEMGQwV0pvUVh5OWpWeHBlY212?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a61a8-131d-4a9e-29b5-08da68c28798
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:36:33.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lK1AIdeIt6/RrX1Le4u1OKvHjz6bemHp05CeGLE9xU9mkPEjYSk5KDPx+X8Qu53WGyTWBCuwTZeUuxji5aZTIanhIgKsmCVqAyiSRkgE9/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=990 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180058
X-Proofpoint-ORIG-GUID: b5XY6G6y847g1fD1OvOY8nCptARhD_t4
X-Proofpoint-GUID: b5XY6G6y847g1fD1OvOY8nCptARhD_t4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/22 1:20 AM, Juergen Gross wrote:
>
> What about filling the complete hypercall page just with "int 3" or "ud2"?
>
> Any try to do a hypercall before the hypercall page has been initialized
> is a bug anyway. What good can come from calling a function which will
> return a basically random value instead of doing a privileged operation?
>

This is all about objtool, that's why 'ret' was added there originally by f4b4bc10b0b8 ("x86/xen: Support objtool vmlinux.o validation in xen-head.S").


Before that it was all 'nop' which is similar to what you are suggesting ('int3' or 'ud2' would of course be better)


-boris

