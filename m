Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1050EE59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbiDZB6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiDZB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:58:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004D8120D04
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:54:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q0junV013187;
        Tue, 26 Apr 2022 01:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mdat8bV8W+a2nSatIkGCjtyRhbVHpD7hcfhb89nh+Xs=;
 b=i+iRWkpoCs9NPINQ+nZaVVfWFRheCR9y0FsgKTydHivHBJdwJkPwGY722oisJ1xgMTVA
 JxEmStPXf8kCa0VEQ8oQDGc3DVjF9njyPW6XPP+Dy4X7+Do2K2VMmqbY4UwDxoEB+2T6
 EvBHvnwvN7C9LMN/Zvm8r5uaxDX0aU3B1mYG1EinLQu5fkv59TqyDRmJ01WXBvyT4Oly
 cSvQWerVSaAFJLTGZXzY2pArubQp1LmtTKQ2OeJ18JSHFTzg7Ice7eWGt8XSVAd/phUk
 htfBkUbcfj2kqB9oi/r+sTfgAP1pcnf3BYAGzrntM7j2mEbOohwYLXco2opk2wg/XMWp XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9amr8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 01:54:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q1oTAP022367;
        Tue, 26 Apr 2022 01:54:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj1r25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 01:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5q2qYGW3Q9bJxqvcbU2PAbndgsPl4IjDRcP8kxaww1v04B21m1mQQvTMFLeYuKqeTZX0KtjiqhV9yoL8n2uSTYK/586F/EMYC3Rz3dsomeNUpe8MaU+Ft3P+kVKBlIPZdpEfghhoUbzETERiB6d1y/WVZLstba4ur1Sjexpo0tRPHlYNkRIJGPvZ1rWu6CVjdBlB7UDcvSITr4yiGA9LhB0HnGz8VaZE2DtoFCuSYIRGYCA65JwuskeMXPkc8zU+KpRa2dguXrEWSQh4aDruF2jB64Jwy3QwvB9YTpYcefDA6hC9HEQs5kybmtn7S0g0RakjBMyHd768R5AaTFgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdat8bV8W+a2nSatIkGCjtyRhbVHpD7hcfhb89nh+Xs=;
 b=EogSP74QFKELue4p4LvkSxfSZTriOrGtOH5pYTYnYfJ3+Xk0eH0Eh5yefB6Sxfxtds5uVMWj65WSNyxNazWHPaxi58ZEE83BZU/Dk89F9Fif0DxaQjIzJP6b5j+ZXlGVVErB72i6/J9FQ9DkTW6dJK7O+Dz4CUYQvLr6/ZOY/iECTSIKSE1O4ac5M4ESlNAaEBfWcArFYauu8m4TkBz3dORArgcVeIGaqymEZYixiWesCD4FRESIVbZNPHtkp/k0qu8pXprIJpZQMwUK+P0pLcaV/OXSUSj6b+xxqi9kADjFZpxZObXeGNC/V8UuChQNfYqj/mseX3fe09ANI0KQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdat8bV8W+a2nSatIkGCjtyRhbVHpD7hcfhb89nh+Xs=;
 b=vC+vo3LRCn8iQkdUEdigP4jHKOmljI6OG3okxmlfxIsVNdL+LxvLSvM5iL53P2QEjEokXw0aL93f57P/dntyu6hafmy71+IQy24pHxmPRgvvhnU8oUjsY7ltIY0lcHDQWZwd+8Cysgm+x28dWn2AQaepeMa5Ip4S4Efp11S0tcY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3642.namprd10.prod.outlook.com (2603:10b6:5:178::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 01:54:45 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 01:54:45 +0000
Message-ID: <4a778d83-df05-14e6-038a-9e0fb86f068e@oracle.com>
Date:   Tue, 26 Apr 2022 11:54:36 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v8 02/10] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-3-imran.f.khan@oracle.com>
 <YmLVrfI4UN8ajoUM@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YmLVrfI4UN8ajoUM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0092.ausprd01.prod.outlook.com
 (2603:10c6:10:111::7) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc16015-6f3c-41b2-5b06-08da2727bc91
X-MS-TrafficTypeDiagnostic: DM6PR10MB3642:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3642D669A5C28B729BA56C9CB0FB9@DM6PR10MB3642.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxryrCHyNytiqt/6gpkm8HWyjrfscAKQmREZt5u2E3Tf++VOJOwFNppZ3j3YXS22WO21y2PRtRQBQ3U2QddDZb5FlLGAHE6f9W7uyPs2dmUyIX0SLTHmgvkWnabMJXlwnDugz5UKwl+gB0VUdxws9e5zHeo41L41NvzK7WkFXw49W5+HC9mV8RCC/zL6URXM/opEq2JrQ2NmXMpTA2P3EhTUaSeotZKYRC1TKGFTYYsrcfuGjRDik9YKLPrtCrd6LQUPNcmVepRe/KXznmkVz3p5+RLmvT4Uz8hyjBMVoALQ9ks5QWwDCl7Fk0TqvlQTp9+0jfOwZUtHA6w19aEDjMcSFKhrNwzaQb7oUkBkXKJMqQsg2Xx5WHN4isv1R7soaoF5d4aNfUQN6MR54DCrjUYYxpWFbDebtL54BAUfoT+h2478nDPtFq0ECM6Yo03ArCBicVRdVVGP84wIH/YwIfLgkVOvCg9Ug16opVjrCRx8pz36n5ZhAZB6eNeBWd6ealbTtv6B3+StTj2lFldAgiP6ZIwMwIIPzeX+fGKJkSBLgLpzjJy2rfwqeI/5+SXk2KxHpa1DbLka8TGelXoqkF1X9/Cl7HZ88FQvKSba7SE9AAG6PokVbxbfImh1XQdZhtzWyWHxmP1A+v6cWRKo4rfGCIY4nC3voR92ZVL3f8R8ibsxdvSZZlWmhyecSvE60pmkuqqM3NO6i47/jL0Ky6B+kVYfkVHZ1hwey5ZvgilmJ8cICrxwPLDIA2tGWfqtf3FqaDwa5NRqEhAvOE4CPr1aOx3DOYQVt8CXBi20cdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(31696002)(6512007)(8676002)(66946007)(66476007)(4326008)(2616005)(26005)(6916009)(6666004)(316002)(6486002)(86362001)(53546011)(508600001)(6506007)(186003)(83380400001)(38100700002)(2906002)(31686004)(8936002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVKdFdITmovTEhib1NvQWJaN3ZaOW9WaDdKa0ZPRy9OTlhzNjYvMnpPTnY0?=
 =?utf-8?B?WFhYMkJsczBVUmZEZUZsU0tmdC9BVUYzc2NhUDBkK2tIV2dMZkdCeWtLR2ZK?=
 =?utf-8?B?K1MzY1JNaXQ4OE0zUTZyc0NoMkgxdEREbjdzL1dvU2tLekxpcU9sYTdJbk5G?=
 =?utf-8?B?Z1Ewa2QveTM3a3VTOEkvUGdYZzRLZ21sK3RDY2NRMVRYK0ZYMzJHWWtFZkhX?=
 =?utf-8?B?R2ZtWlN5QlNHa2dSeWEwcW16d0YvWTVNWE5JMWJKMUR0ODU1RjRXTmhhWjBZ?=
 =?utf-8?B?Wm9NTGNITGVqdnRYT2lqQk9DWXhkdkZOTlRIbk9JYnR3MEM3SFZiRmdRVTVj?=
 =?utf-8?B?OTdwdkF5T2JvbmpBRnhudlZxdkwrSnA3Y1J2MldDSjNwQmNrNjY4OTU5Z2FQ?=
 =?utf-8?B?bldBcWtQU0RrWlRLcmczMVRLWDhWcnBTK2ROVXNEZlJDbldMcHZDWFdlT3A4?=
 =?utf-8?B?Z0ZUS1ViMVJId2pHMkRSSnNEMHJsYm9wT244dWVLYVdmRmhsZlYxTzVZMTZy?=
 =?utf-8?B?d0h5SjR3aUh4Sk1CVUtVRUtLQUdzRUdxUUtHRzNqYnpGaTYraUhJdkVyYXJw?=
 =?utf-8?B?U2hqU1czWk5Hb2xIeWJZU040ckJYTjJBV04vaUdLeEUrS1M2NU5WRjVPNFVi?=
 =?utf-8?B?a2RFdmJscUptQWJNcndibk1jSGMwcVFPOTVGQzVyQ3FoMHJ2YjlLa2lBTWFV?=
 =?utf-8?B?MHV2VGpjaGFpVkd3K0JBQkgxNy9PWkpiQVBnaHNoRW8ySlYxYWFDN05rWmE0?=
 =?utf-8?B?WlcreWNpZjRjQXFlMExJdTMvT1Z0M3hYUWV1V3NXOTdmL3A5aFZRS1M2QVpW?=
 =?utf-8?B?cXRnTzkrRnJnbUZkbnU5UnFXU3diQUVOL29JUkFpQVVGQkcrdVBHR2NXTjRs?=
 =?utf-8?B?bFYvVmYzR3lmL1Ezazl3NUdwUDJCVTIzZDVrMi9hQmx1VUpkUHRFa21CcTRS?=
 =?utf-8?B?dWVPZVdJSkZ1NHhnTUQvWkdCYkFrNzFIdGduTFRSMkVvRXJYMEhSeVNQMTB4?=
 =?utf-8?B?U0RzOVg1TGZKNEJlWUFHZG8xUjBldUJKT1kxWVJvMFhCVHpzSXlSbmt5OG9h?=
 =?utf-8?B?ajZnRGcxSHVoTTlUblY0YTQzRFhSdDlkK1p2bkNYN3JTcEdXRHovZnZlL0Q2?=
 =?utf-8?B?U0cxMnp1akZiR21GWkRkYlU4NXkrOHhTaTllODh0QzM0SXJiSzRVTzlYWnYx?=
 =?utf-8?B?SDBrTnhZd2JIb0l0Z1Q0RjNESmZKSFJieURYWjlOQVJXQ1QwL0Y5K1hJUSs5?=
 =?utf-8?B?dXlXRjNmL3BoYnpWT1VPaDRKeDV1RFVuMGFFL2tidDZLcUsrTVFhWE8zTkM4?=
 =?utf-8?B?ZHltcXZ3bU1jTXJSMGtxaWJ4djVrTktDb01rQ2ZwNVVxdG5BdDhGSEJyVVFp?=
 =?utf-8?B?QUZUNDI3RUp4c2pycWdGbFY4U09HOW1SRUFOSnVhaVFOMWJGam04VG5WbmJY?=
 =?utf-8?B?d1g0aGw4a2ZMTSt2SjNyMWM4alk5UVVldjdha21RbFNQYmp4NnZZa1pvMzhp?=
 =?utf-8?B?YUlwUGNxc0prcDhWVVhwZ0hUZU9VVDhXWkFhaXNVMUh3ZFplZHRieTZTOHdH?=
 =?utf-8?B?RjIwK3FOU0psMmJ5UzVtQzR5N0htOUNoa0ZhdFNHa25UZkoxNVRKMkgzU01M?=
 =?utf-8?B?NkNjTlV3andJMG9UaFA2RUJwWS9mMWovR0xMNC9peUl6R2Ftb3EvSmR1R1Z6?=
 =?utf-8?B?b0RaVEZyZmR4RGt2M1pEODZyUEk5T2VoLzNkeVdFeDRRUzVvVlhVdTlvenE0?=
 =?utf-8?B?YWdkaUN4S2lLdTlTZlpTT2RxVkhGbWo5MitHaWxFc2JRV1MyK1BEcUFzWGJh?=
 =?utf-8?B?SzVibnhvZmNEZ1lXTmxIRFRublc1Tk5LODc5Tk9zajZGZXNFdGRuaEhVQ3RP?=
 =?utf-8?B?TDJMb3dEUTdjOHBCUy80T0JXL0I5M0pvRnVKL1BlZmRzeE5aNDdHSzdiT2lN?=
 =?utf-8?B?NGVFNkVOUzR5ZUZSZ2VyWGJ4WTNua1VEMExVV2p2V3NtR0VpMGhzVmoxbDd3?=
 =?utf-8?B?TlFud01vYmNPd3Z1c1Q2SmhiUWN0N0lrOVRZd2dnbW4xeW9ndjJzRElLc1pB?=
 =?utf-8?B?UnNMaXJDbzFFeVorN3prRUFxL3BIZGZENkk2UXdzMS9ySTlaL2w5RGVTVVJh?=
 =?utf-8?B?bGJRYXJMMC85TWdZeEFrUk04dldrTms0OGZwMU9rcVEySjYvY2owWDZqZjFl?=
 =?utf-8?B?RHBodFE3Tzl0Uklhb1VLTUxvaDhHTGtiWFUzMitweHBqdlNEazZrdGIzR1lt?=
 =?utf-8?B?anJIYWpnb0JYQjJpeVRleER0Q2FPN01HampCUDI4YjZnVEw4bjdkNEYrdzhs?=
 =?utf-8?B?S1RpTjB1Z3NGSzk2MW9TbGt1ek1nMG5vcE00WGpZUDZDV0t4U2VZQkRXSXlj?=
 =?utf-8?Q?FE1ZG6G77INH3/QA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc16015-6f3c-41b2-5b06-08da2727bc91
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 01:54:45.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSLIzXkwkuAGSPK2XDppC8WqVac9ueGBH63EWkjAWLiht9YnBdDQF98SPJLiE/ROiu7FSfUgJ7+yPV9reROhtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=648 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260010
X-Proofpoint-ORIG-GUID: bST2MDyO8vYOsZdPJrw0aLBOyR39dTHi
X-Proofpoint-GUID: bST2MDyO8vYOsZdPJrw0aLBOyR39dTHi
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 23/4/22 2:19 am, Tejun Heo wrote:
> On Sun, Apr 10, 2022 at 12:37:11PM +1000, Imran Khan wrote:
>>  static int kernfs_seq_show(struct seq_file *sf, void *v)
>>  {
>>  	struct kernfs_open_file *of = sf->private;
>> +	struct kernfs_open_node *on = rcu_dereference_raw(of->kn->attr.open);
> 
> I suppose raw deref is safe because @on can't go away while @of is alive,
> right? 

Yes.

If that's the case, please factor out of -> on dereferencing into a
> helper and put a comment there explaining why the raw deref is safe.
> 

Sure, will put dereferncing in a separate helper in next version.


>> @@ -201,7 +203,8 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>  		goto out_free;
>>  	}
>>  
>> -	of->event = atomic_read(&of->kn->attr.open->event);
>> +	on = rcu_dereference_raw(of->kn->attr.open);
> 
> cuz we don't wanna sprinkle raw derefs in multiple places without
> explanation like this.
> 
Agree.

> ...
>>  /**
>> @@ -566,24 +567,30 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>>  static void kernfs_put_open_node(struct kernfs_node *kn,
>>  				 struct kernfs_open_file *of)
>>  {
>> -	struct kernfs_open_node *on = kn->attr.open;
>> -	unsigned long flags;
>> +	struct kernfs_open_node *on;
>> +
>> +	/* ->attr.open NULL means there are no more open files */
>> +	if (rcu_dereference_raw(kn->attr.open) == NULL)
>> +		return;
> 
> For pointer value check, what you want is rcu_access_pointer(). That said,
> tho, why is this being called if no one is linked on it? Before removing the
> refcnt, that'd be the same as trying to put a 0 ref. How does that happen?

Yeah this check surely should not be needed. I will remove it in next
version.

> Also, can you please rename it to unlink or something of the sort? It's
> confusing to call it put when there's no refcnt.
> 

sure I will rename _put_ to _unlink_.

>>  
>>  	mutex_lock(&kernfs_open_file_mutex);
>> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
>> +
>> +	on = rcu_dereference_protected(kn->attr.open,
>> +				       lockdep_is_held(&kernfs_open_file_mutex));
> 
> Again, a better way to do it would be defining a kn -> on accessor which
> encodes the safe way to deref and use it. The deref rule is tied to the
> deref itself not the callsite.
>

Okay I will factor this out in a separate helper.

[...]

>>  static int kernfs_fop_open(struct inode *inode, struct file *file)
>> @@ -765,12 +772,13 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>>  		return;
>>  
>> -	on = kn->attr.open;
>> -	if (!on)
>> +	if (rcu_dereference_raw(kn->attr.open) == NULL)
>>  		return;
> 
> rcu_access_pointer again and you gotta explain why the lockless check is
> safe.
>

The lockless check is safe because no one will be adding to ->attr.open
at this point of time. This allows early bail out if ->attr.open in
already NULL. And if kernfs_put_open_node makes ->attr.open NULL, it
does this under open_file_mutex so subsequent check under
open_file_mutex will make sure to bail out if kernfs_put_open_node won
the race.
I will put an explanatory comment in the code, explaining the same.

[...]

>> @@ -912,14 +920,13 @@ void kernfs_notify(struct kernfs_node *kn)
>>  		return;
>>  
>>  	/* kick poll immediately */
>> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
>> -	on = kn->attr.open;
>> +	rcu_read_lock();
>> +	on = rcu_dereference(kn->attr.open);
>>  	if (on) {
>>  		atomic_inc(&on->event);
>>  		wake_up_interruptible(&on->poll);
>>  	}
>> -	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
>> -
>> +	rcu_read_unlock();
> 
> An explanation of why this is safe in terms of event ordering would be great
> here.
> 

This is safe because here we don't need to refcnt ->on in this case. If
writer (kernfs_put_open_node) has already made ->attr.open NULL we will
bail out. If kernfs_notify got an old ->attr.open we can still safely
process the event, even if kernfs_put_open_node updates ->attr.open to
NULL in parallel.
In both the cases the behaviour/order will be same as earlier code that
used kernfs_open_node_lock.
Please let me know if this answers your query or if something is still
missing.


Thanks
 -- Imran
