Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD5529764
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiEQCas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEQCap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:30:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34BC34
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:30:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKqhbX017447;
        Tue, 17 May 2022 02:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IS9KAddkzSLMXOKipuyWnzZ0dJ2ZlgN8nEJLVsqXUMk=;
 b=P9YVCAQTfbJv4TamkodlJdh409oWpOANK9k0/nlg/duTNiHzIqmgwmuP0yeIEQ5w9yDK
 90VFgJoLGUs7PuHQyQN5pSSXU/MkerHTsmY4RNzIoZfl9kfQtF0GXnBidf0roc9di3F2
 nQ7WeLwuWtmSZCJHNm+ObmgwalSWvp0XinBTM/oKw00hKKRAekZ6hnczrn3IgJ0wmF+F
 P9LPfu/uHTlddyR07D7aA6npZmG1InB/SlqtvOgDGGx8aTTl7sET30EjLnmUr8druFRp
 zULXFwtXYxBrPRDeNrCJtXGW5FggZogB/GusieBxu/6jt3IucSAMtxk4tMPBYHDNoWdr og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aacvmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:30:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H2Pu9m038283;
        Tue, 17 May 2022 02:30:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83q1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtEtWwtxzKTFSt6Ui39eaKc4m0gmTS9Xmdau3gt83zuq64zaGmUs2cyWj6EMKckpkPjY/yO+Yp6EVqdx6GJ4Tc4ATt4SLvwvMmNrq5efPTaJe0KpwfTQ3Wz8UrPfmAzh/+Gv/QfHxUNF4Di6zxRkDkVKx41USLJetcxdaY3Cg1yImJR0+U9BU+iJZen+6PG+k2bOfIyAyHacalM2DDEZycIK6KuAz1jawA28LQHykranuRpoWw5VE2Y8kfW2cfLknzAowWD0L9gGmlseSfXTp0mjmSIa1i0OpthX03MgwkarTDa2j9L7+BgXJHO03eASjPGy3ZXbGhGN1wE6rL/UZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS9KAddkzSLMXOKipuyWnzZ0dJ2ZlgN8nEJLVsqXUMk=;
 b=fLMzcBsiT2wxVzrfMn6sTW3hgWPYbdkByxdZl2JbmI2ENWpAwZXKPsGFETUCkepXMKZRoRITFT7TZMiyeVrCwmiQGqdHeku87QCnosyUA9F9w/gr/oXMa9oygCX0ELNRclggvPEMloNnJN8jfT/6PafbEh+Ljt+x+4+VPqTf0HfUWqG7+/OwpfHj+4ZBv4dZ05xpnaaqU+egT4gVORFtQCBimM+nNbU3enDc24yOXRYjflEv7Gsg5BPqKNEuoktvY6Zw8H5GGhlDKXbCZRwx3DXpUfZZZjyqD9gSKbcUdJLbT5mFom52dOo5ZFoxoIWrnOqltJWBs/QZaKMlFX+7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS9KAddkzSLMXOKipuyWnzZ0dJ2ZlgN8nEJLVsqXUMk=;
 b=PQz8Z1vGB3JRLF4KCouTVi9VC7vaQ4g+OQjyNRQBfuB3ePJj7+eN3hQrGOF9GmuRRYRVYkwd42Ml/SpeXbUK7af131xtD8zt1LQ1OReoS4WBFtLIddUT1DQsNuKtCVjqTGC0mVgmRjouazAfyguY2XBZGKSSJ4FN76mTvG/6jK4=
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 by DM6PR10MB3819.namprd10.prod.outlook.com (2603:10b6:5:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 02:30:34 +0000
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::6491:741a:3540:3e12]) by SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::6491:741a:3540:3e12%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 02:30:33 +0000
Message-ID: <4532123f-4c03-0303-1480-a51faabca806@oracle.com>
Date:   Tue, 17 May 2022 12:30:26 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
 <YnQtL7+GYHwpo4n2@slm.duckdns.org>
 <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
 <Yn0/RrgMRie2YPEb@slm.duckdns.org>
 <526b46a7-7daa-9050-1276-e19836816991@oracle.com>
 <YoKna/Ty+k9O+pjt@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YoKna/Ty+k9O+pjt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYAPR01CA0008.ausprd01.prod.outlook.com (2603:10c6:1::20)
 To SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f91856b7-46c2-45b6-b0f6-08da37ad37db
X-MS-TrafficTypeDiagnostic: DM6PR10MB3819:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3819E820D257C88500CA0FE6B0CE9@DM6PR10MB3819.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1H+stAVD8cQ8PA8s84lawPw07/yPvf7XqFEHdGfVKSNfKVqS43bBrk3nKZTQWP+J0Sd6DM30LMKdgSekayOwv+EcJPKKSsvr/E8l+316v2lyRXtnWAE87JpvV+tTWdNoB8iGj1CwI/6JujuI0tnlh4f5Xzd0+7wycf99k2bIj2FixWanpXCh+HmQm8D8z3jmb0BqVT65KqQaif08upgvYnQG0WtHT2vm8ea2Eok9kOymyrj+VHzIZXvDSx8QMniQAzdbhwECPNMORVlwba81VYGEh65Ip3iieg+cvNCEcvnrYa6XlG2XBSCsxDD656CQew8ebnWWHS33srC3+WkKn8gH9ejCPBoCz22x6gu0mtFYmRgGmVOZSnslFZ+xgl5FuqhFy9IAJNG6yFY1kPlaXT4kMh9i708Z6zz4L6yiplvskSlZLVJ4gkxou8/LcpeteytX05HW6VyCQPg4s0mfglKAmVvUbsQYymelUpC5i4jzfeRdit0fGjO41H5SGm/ZDK+hyqG7D5NXZPDqDh2oG+ufRZ1hVE8TmbgfgNnD8OPjYwkjtIhDgOb3ylrXn/07IL8/ZPcZ+JOdIjJ+Is9TWzzsWSVezncFy4BDgn45T8xwXXdt/X+uuXLAXH6JaVTn+w6+L1IHHGEcr1Eo4wpS+dOgIQG7uQ7PUyYO4dUWWC28FlenbgT3erXCfoeE+Bn52k7QZLqXQwaldlwh8LT/oxaoHIea0hHdbBu+ElWRG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(186003)(83380400001)(2906002)(31686004)(38100700002)(66476007)(8676002)(66946007)(4326008)(66556008)(6666004)(26005)(31696002)(86362001)(5660300002)(8936002)(36756003)(6916009)(508600001)(2616005)(6506007)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVE2blMraVNWVGwxWkF0SDFCSHdMVHFUcjMyYi9nalltY3EyYW9uS2UrcGs5?=
 =?utf-8?B?ZlNmRGNVRGxnWFRKcDZhLzVaOEt5emlwY1VsUXhnbTZFUUs0Yi9Pd09FUHZx?=
 =?utf-8?B?WlNqejY1Mkw1MGU4RTZHRTAwbzRsMmx0bFhaSDVUbGdOR0NCMFJHZVJjMEUy?=
 =?utf-8?B?eGRUS3RXUmJqOFJIeE56TmV4ckc3OThPS2lsbzNBa3o3WDVTb2szUGpMN3hH?=
 =?utf-8?B?S2N6cFp2eG42KytFVEJjcWYzNEphcXcxVFZ3c1ZpN3V5ZUMrQnFWY1RYdXhN?=
 =?utf-8?B?cHRzM29kTlk1VTFCV09PMytjZDlqU2IzNE9DRXk5ZEtoVWJlV00yZjBNOUJI?=
 =?utf-8?B?bFF0SG5NUyt5Zi9EQ3YxSnBPNzQ4YTVTSndWWk42R29pdUlWaTBIbWhwRzE1?=
 =?utf-8?B?Y0lqM3NQSGRNb2Vhb05zZW1RdDk0YW0xdkthckVwbXE0aVlLdlovWEQ2RE56?=
 =?utf-8?B?Y0gyYUtBWFdUTVRQQ1VoclJGRmF2VCs0dDVwTkRWdWlXWEJtS09hVm04Lzdq?=
 =?utf-8?B?OC9BUFNNeVBhSU9LTXlBR0tOalFIOWlxdzhaWWRoUkhuakd1Rk5rcDFiR2dn?=
 =?utf-8?B?cTdBc012cnIrTksxcnpkaGkwNDdDckpHNmF2T3J0M01uWEUrYTRxaExXUUZT?=
 =?utf-8?B?RzBVeGc5KzhzcUQzSW5sOUFEak95aDZxYTVEVklURTZJUEF6NUthTTNrSUd1?=
 =?utf-8?B?REZXMmJuWEh2dlRnejFoVzRuTWhjS3BRSGUvRkxTR0xGZkltb0pZTmJCU1lH?=
 =?utf-8?B?UStacUhQZGl1K3BYenRZSktINVNSUmpUTVI5eS9XS1RtaHIzckd5QkR5YXdp?=
 =?utf-8?B?VVEwTWZRaFBieU1MQzU5eVdJd0gydDVPdlNOcWRTNDFoT0JyMy9yYnBleEdM?=
 =?utf-8?B?TE5ZcFhJNFVtWElIRWhzdlgzYmhiZ28rYkQ5SzJmRjFGRnUyaS93U3NPM1JY?=
 =?utf-8?B?UllSK2FLWEZzN1V5OTY1YlZPYzA5WU54VTVxcmFxRE9tNTNoRUo5SCticTI0?=
 =?utf-8?B?WTNpdGliOGRLanhNeHJUcGE4ekExL2wya1B1ODdQV2dLQTRjR1ZVOE82bkt2?=
 =?utf-8?B?TzJTeU9yRDZTQnB1ZE16dUxJbHUvRlRUSGdwNXVTcEZFMlg3c1lzdkFabGJB?=
 =?utf-8?B?T3ZUYkNsRDJEZlBHMElabUpVUGFEalVjSUxkNVY3OG5BZXNnaDgvK29LTlZi?=
 =?utf-8?B?cklWbWVyL0xqeTFOOUVUS2tTWjlZeDhzeENJK3dmS0dzQ1EydHFsbm8xeXd0?=
 =?utf-8?B?WTBSejFqclRiM0h0RjJhdzJvVHJxYzRzclVsWGp3enJ2TTlkSlExUTB6bGVT?=
 =?utf-8?B?cWZWZ21iek02SFRtbFE1MDNzYjI3ZWg5dXcrT3p6Z2FEUGlPbFhjT3E3Tllu?=
 =?utf-8?B?VEFleTlhT2hOaHRoQ3RydTAzaFhZZ2U2N0Jqc1ZDZ0NrSzZOYXpWb3U5M3dW?=
 =?utf-8?B?OXlVQlVQTGV6T0tpSjFpaklqbWFIUTBPNzNqTFE1UGZFWFVCVFpETWxGRXU5?=
 =?utf-8?B?OTByUkFMdHlROStvbENZamZjcWtNTHd1R0tXYXQ5dTgxZXR0dXNyVk5QZ091?=
 =?utf-8?B?ZE9ET0ZMQWZtUXArT2hmeDVzb25kZWxXbSthRm1lTHBOSEdaOXN6cyswRWx1?=
 =?utf-8?B?ZzZmQi8yamxqdXI1MWpmUlU2WEI1R28zTTNKTGJ5WGRJTDlyLy9sUUg4cjlP?=
 =?utf-8?B?UjY5Q25kSnl3a0tNb01xVEVGWUM2ajZrR0x3UFZCRGN1WXZCUFYyWUJpNDE2?=
 =?utf-8?B?WWhRbHcxNmdOeWp6elZOQUJYeUVRY2Q2d3dOWW1EQVQyNlBKUG1IVmgzczRJ?=
 =?utf-8?B?dVI0bC8wSFdjTDBiMDU5ZjJpT09XR2E4c05mWk1SV3JHNXlvNWFkdFY0VWpL?=
 =?utf-8?B?SzdTQWxTT3M5NElsdTEwMk9NdzA1UzZEOFlnd0JHWWlnQU1oaDgyQ2U4cVQ5?=
 =?utf-8?B?VkpQL2VFUng5d0pleUc5TXFFUmNkMTlzMmVHcFladTIxMTF4NUV2SVY4QTdG?=
 =?utf-8?B?WStMNXlRcUZ1ZjRKUHdZcHNQNk9aNXVPcmVIak1ZSDhuZk1GTzVNaGpFZ1Nv?=
 =?utf-8?B?MWVwR0lSck5PUE9EVzJlc0RCNUgxb2VDc1lydUNKRTJ0Y0laQ2tvTmZnMjNi?=
 =?utf-8?B?M1EwbmFjRjNrRFpEdDZJMDBpTHRkU0xBd0YrSUJBTk1nNGEwQkVlZ2tGZXEz?=
 =?utf-8?B?Z2ZHVzdSZ29ZdnFOSEVEYnBDL1hNc016QS9rbHNOamRJa281VWErZ3NsMkI0?=
 =?utf-8?B?YjVTcmxZbjJQMnFJSTNHV2lNRFVQdmNZaEZvWDVLaUgwYWlPL2VMV2xyeGMr?=
 =?utf-8?B?N0FHTE1BQk9QNzdCOURXKzQyVkVFa1J6S1FxeDkvUEZxeWlhYndxV1JLL3dn?=
 =?utf-8?Q?igAETUp7hRNTUj0U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91856b7-46c2-45b6-b0f6-08da37ad37db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:30:33.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9Fw1kTAPMmMAVXrurXJqSfq1+1/XNwu2L0CG/p8oC6uZ9Quy/wwqcod5TRb+ZN3oU9w66QJ7GCyXQlb6PzQfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3819
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=864 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170012
X-Proofpoint-ORIG-GUID: yraQsRrZ3pTEzUhYeFvMQoDLjIVmyrkD
X-Proofpoint-GUID: yraQsRrZ3pTEzUhYeFvMQoDLjIVmyrkD
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,
Thanks for your reply.

On 17/5/22 5:35 am, Tejun Heo wrote:
> Hello,
[...]
> Why does it need to return NULL on empty on->files? We wanna trigger lockdep
> warning cuz that's a bug but it's not like the caller can recover from it
> (short of causing unexpected user visible error), so I don't see what the
> point is.
> 

Yeah. Returning NULL for this is wrong. I overdid the checking part because
current users are using on->event or on->poll. Also I have modified the
interface to accommodate for different condition checks (Please see below) and
this would mean that users of the interface can/should specify the condition
under which dereferenced pointer will be treated as valid.

>> If this looks okay then I can replace usage of kernfs_deref_on_raw with
>> kernfs_deref_on_check.
> 
> So, this is the main deref function without holding the mutex, right? Then
> name it kernfs_deref_open_node() (or on but it seem a bit confusing to me).
> 

kernfs_deref_open_node() looks better to me. But I am thinking that for
dereferencing ->attr.open outside explicit read-side critical section we need
only 2 interfaces. One for the updaters and one for the readers. These updaters
and readers should be able to deref ->attr.open under specific conditions which
guarantee the validity of dereferenced pointer. For example can we have just
have these 2 interfaces:

+/**
+ *     kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
+ *
+ *     @kn: target kernfs_node.
+ *     @val: RCU dereference will take place only if val is true.
+ *
+ *     Fetch and return ->attr.open of @kn when current updater of ->attr.open
+ *     ensures that as long as @val is true, other updater(s) of ->attr.open
+ *     can not change it. The caller needs to pass value of the condition
+ *     (@val) that prevents value of ->attr.open from changing.
+ *
+ *     This should ONLY be used by updaters of ->attr.open.
+ */
+static struct kernfs_open_node *
+kernfs_deref_open_node(struct kernfs_node *kn, bool val)
+{
+       return rcu_dereference_protected(kn->attr.open, val);
+}
+
+/**
+ *     kernfs_check_open_node - Get kernfs_open_node corresponding to @kn.
+ *
+ *     @kn: target kernfs_node.
+ *     @val: RCU dereference will take place only if val is true.
+ *
+ *     rcu_dereference and return ->attr.open of @kn. This is used in cases
+ *     where we can access ->attr.open outside RCU read-side critical section
+ *     as long as specified conditions are correct i.e @val is true.
+ *
+ *     This should ONLY be used by readers of ->attr.open.
+ */
+static struct kernfs_open_node *
+kernfs_check_open_node(struct kernfs_node *kn, bool val)
+{
+       return rcu_dereference_check(kn->attr.open, val);
+}
+

This will avoid need of different interfaces for different conditions
(holding kernfs_open_file_mutex, @of->list non-empty etc.) Current updaters like
kernfs_get_open_node, kernfs_unlink_open_file can specify
lockdep_is_held(&kernfs_open_file_mutex) as valid condition. Amongst current
readers kernfs_drain_files can specify the same condition as valid and
kernfs_seq_show, kernfs_file_read_iter etc. can specify !list_empty(&of->list)
as valid condition. This will also help us if dereferencing is needed under
certain other conditions in future.
For just checking pointer value we are using rcu_access_pointer anyways and that
should not need any wrapper.

Could you please let me know if this sounds reasonable? It is not changing
anything that we have discussed so far in this regard, it is just reducing the
number of interfaces .

Thanks
-- Imran
