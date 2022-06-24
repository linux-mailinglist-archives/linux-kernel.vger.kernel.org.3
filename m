Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D155A17E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiFXTLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiFXTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:11:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F297823BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:11:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OHdeVI006125;
        Fri, 24 Jun 2022 19:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=mO6crm6fUom5TR/suTbvK90R37YPGxmPiFx20/QyA0M=;
 b=y8w8MtXJg8v39bcPPi5aRT738Q/uixNx+mP5IiV1hSjM15mIRUMYZfcNNblpRkaiQtaB
 rPC+zzuPyDJ/PK2yrFUt3FrzkLVBgfYFsbNTzcN3WsYzryfYt8o54U6gWPLMYtQFAxbj
 ODXHgQOjqEgRCLsNGH+QyCoXnRyQM0YQ3eub5FxUZWVWAOMFYnsw+EhksXwj+oOzxNxO
 4yxAaMigtT+e2/3y6wtmqA2GPyQ9p0DxJoOb6cJRm506cle03D7jxFbghgQhjtxO/+K5
 H611usnJioOtFLJS9v3kZ5igdjO1pgLY9VCOoRF3FTxqZ4CWtA6kxCZbAVNigcfi7Z2m Cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kfe956-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 19:11:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OJApAq035318;
        Fri, 24 Jun 2022 19:11:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5xnmf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 19:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKMhVMQ3g/ABwSXdzuXKhh6pzyYlkmw8YTkF8ArSHVSa7FIHMFpK/2pppRTvyOrVLtdr9yZ28XQTObZUU5GLtnGsufM19SrJqtqOoIh5ET7dM42Ond6SP1uiYNF41KkqTYFP0rqK+PJP9KdUunDBoPvOhHjbKgcSsGTZ49tbRRtbM2XzcJbPpUYOmcM2BpFD0CqDZ+/4Uox33OGhQUfxmMP2933tGXUON1oEZbI97gxxVYWiYSO2fQR8kcEAm2xUkL9vuKiyTU0x7KkU6asnvUOhgLClAy7fQLMQMpz572s6Hao60HdJ5tsanL0F0NWbRrZqCXa8YFgcF5v4rXKLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO6crm6fUom5TR/suTbvK90R37YPGxmPiFx20/QyA0M=;
 b=RGk05I3fVsc6mzGi+R1GvegKGODk0yRIYQkHpA987jKpoTJgPTwx/Gq0etvmgDxIkjMfCPX1UzLXkUg3d5c+TEoxONt0wKOFNvo3zqKLamkK5uVoOmOZBrXdm098VpuKagGlgh1ZKvGs/3RoeWiGzvQXr7rBzYyddNiJiXxwuNa6YS8ZZCuuVSBAHle7gqnqvO0bZs5KwEbN+W/8OYQJr9b9VhY+jaLf80excl0z3Pgvgdk/SR5WGhhFLOc0CiyTDe4+kvhto+nu7dg+awgDulcVtJMHhBqC+bymPOmRoGs9TfU/n5VYESjvJzXXX5DRsuclc5f1qySNFRBpClDO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO6crm6fUom5TR/suTbvK90R37YPGxmPiFx20/QyA0M=;
 b=iZA1Bx7eATyLdq21IH6GtBAo6XQeK/WVucZUbVXBZbmb9/f9L5p/solXT2AhUcGhaUnU2ZarGl5EiMUbxLXNZiRIIzQ/3UqFC1bcw0RZWkLhR/CR06V1bRCFXCs/f0kzyZbQReM/0Tt4kJlmyUmx9C2PNPorBAxXJNWn4eSmC78=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4061.namprd10.prod.outlook.com (2603:10b6:208:182::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 24 Jun
 2022 19:11:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 19:11:11 +0000
Date:   Fri, 24 Jun 2022 12:11:07 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Message-ID: <YrYMS5sATPzEgUxb@monkey>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
 <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6866c370-1ac9-4b73-67b1-08da56154ced
X-MS-TrafficTypeDiagnostic: MN2PR10MB4061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAZlEcgXUlG8ZqNT82ycd8GXwKyAnGFG/4zhHpXPOEchrAjZwR9o5Barbz334PHN4ZTROLNZZs26goJh+gF947JKNbjsbA0CGwYARHkF/Q/+e/8umYbt0OkJryGvotbweTg9z5xLBbU4pNL0/5xUAquiViEvA3IfoNQbUJa5ajsAywQKkQYmFgkwebyL39U0mdCPBzroWi1Mq0C6hzY9QMJDb7TCmJxoc5uiVk4RsiQL4sAwqMV3dTm2ifpgVyxLLHlAJwwaY6eEiwoYh96oJ8Ro6ze6YG1TPG4Ciy7JR+5C9dvLzLcaEuDkEFilN52tO1b4r7qLH7MEooZGg+kkxkPJtE056q0jAazyK2h/PBMx68w7Q5a7XN1NUmXHYieo3Ev7whh4Pw5szl/qQl5SMSavIhG5Ix1ySGEvMwlnejjswvR3Qcf3Z4kRxlzhTPNJxYDMtYMwJcryDu/dvrK/xLTRNY1GzGpwywGhN2PjGdHVpK43nOHkq/yg4E/e1X3mBwvQ/MTVzwy4K8AuXVAloMfikH+1JSykYv13wAyuF0mTTL531oPM2vh6YbN02N7zN9xyMEjCo9Farrv/YFX9lHDKbaiCJQvIF2iCKtqCsa5uppHSOqC0FCob4nWCfhj8WlIz3fRJlnrF8eSEq1BRWFbhryP+nQiZ/SxzJmN5RY/P0xqe4u0fwO978gov9mgHh7MXu24fWJxRkzGgzDUZTAbMTSzql8Yii/TPYWIo/H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(6486002)(2906002)(8936002)(6512007)(7416002)(54906003)(8676002)(9686003)(33716001)(6916009)(478600001)(4326008)(5660300002)(6506007)(44832011)(53546011)(83380400001)(66476007)(86362001)(66946007)(38100700002)(41300700001)(66556008)(6666004)(316002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mis3RW1XZ2g4cVdvSHNKQmwwZFdJSk1MQTFvaEhQRGN3OFpNRkNSa1hndTF4?=
 =?utf-8?B?Q2xZLzIvWGlVTFNkSXpQWUpsZTNQWUhTK05tOG1SclJmc2pHdTMxSEE3aUtX?=
 =?utf-8?B?emxrV2VUZThNZGoreS82dUs5UnRLRDMwL2JPMTQ5NVhTaWxYTnZWdnZ5cUlY?=
 =?utf-8?B?MERIaktpTkNaeGo3d0tQV2RXZmdWalA3RnBscWh5ditlenFJS0x5bXZ6a0JY?=
 =?utf-8?B?ODdlcTFaWGNPVjMvd3k3UzIvd3ErSlFzWTRtYkhnSXQzc0U2WU9oVHRRWUQy?=
 =?utf-8?B?eG1rU29Ec2w2ZmdmQmVxNGM3RDJ2TzJEaTZDb0V2QzNGWUltYTg5eFBBYlVs?=
 =?utf-8?B?MW9GTUZScmo2NHdKLzVkL2tZMmFXMytvbUlRNHZERUNabHArUmUrWk5GUVBr?=
 =?utf-8?B?Y3lkRkxUd3hkQ0UwOHNQMmxOcUtxZE1CNFJXOG0rYXNLNWhtdzFZU3QyVDNu?=
 =?utf-8?B?aGlxVE9Sb0NFTVVtdllwdjhtRzBtNUhESXk4Vng2aXpCSG1TeldPZzBZS1lT?=
 =?utf-8?B?VzdlRURCaFExcHVYaEpKV3pZNEhXRWZicjVaUzBheWQ2bEs1MW5WTnovWWNu?=
 =?utf-8?B?VFBOL0YrczZ6aHlHY0F1dWxIVlVRbnBEQ3NkcThaYXpGTURXVko1QjlueWIv?=
 =?utf-8?B?dDREK0cvZVhpdG0zNGFrYVdBditKUXV2R2N3b3pIMGpqQzg0Q1l2Y2JMdFJS?=
 =?utf-8?B?K01pWVJpenpGeEFDM0pEdWZ0STNVeUlRbVV5THpSQ3pxcTl3ZDM0OXh3Ukl3?=
 =?utf-8?B?WkxVNWVYYmoyMXVsbHdFRnRqUjBLekJvZHdjS1VLU1pObUszLzJqODM5bHE1?=
 =?utf-8?B?SXR4Sk5SK01FMTVFK1JWNnV4RmhYRHdYSjZPa2VpUkZpUWNUTmp6L1QvZS9L?=
 =?utf-8?B?aXowMTVXMDFqd2dSMTJUWVVmTEJtam5YVXBIa2ZXYjBxbGdaaXJSa21LNlVG?=
 =?utf-8?B?SjNCTC96RHZmbldGVnRaUXZVK25odmV1dk9ZMmdCWk80NzFobXJvMThySmxk?=
 =?utf-8?B?ckVhdHc2VU9wS2pTVkI4dVMrNlpIc3hzaTRlaXRmMjRZNUR5YzJVMFFnQVpP?=
 =?utf-8?B?U1R4RzVPVzhKNWNyaFhuNmRwL1dhb2lOVmU3ZWMxYjJLWCtCVnMrR0hTSWdx?=
 =?utf-8?B?bE9Ndk4vT3NKcmhJZmE1VGVnREV0Uko0RVJHaGhkZ2c3SVJ0L2w0WnNhMnZX?=
 =?utf-8?B?RDdFbjl4WEYvV2VDOFVYMFdiWmhHTXd3M2tnUTY3V2VyTFpJTEs2OHlwRFlz?=
 =?utf-8?B?VU5BaUJqN1NhR2o0YnhpZ2ZHRmRUcWZmZVFuSHd6bXRYRzJnYlNJSjVqdUN5?=
 =?utf-8?B?WkxTRk9Wa05aWmFUOFNPRHErNXBES25DSjBnTmJKT0QrcUNYYUhJYVc0R3Zk?=
 =?utf-8?B?TlB1SkhRc25HYzlHUjN3Uyt1U1VYSFJ4SjNONFRqQkFqZXg0MFduNTZ5RzQy?=
 =?utf-8?B?eTJrc3Q2bjJRVmh6UEh3aUhGVHZTVDJ3V0ZoNkEyR25zdmMvYWRJSzBSUFpN?=
 =?utf-8?B?N1pJOElISWdFcTZEMlhLQmxSTGUwTVV2dWIyQzhIS0c2b1VlWFA3VmxsMlhV?=
 =?utf-8?B?ZHUzTkZtMFpudExCQU10aE85WitweUpaQ2ZKK21qWXMrYnpZRjNPUkFSVlZR?=
 =?utf-8?B?UFliMHptdFFYYVZ1VURxbHE1N0RRZmc1bDIrQXdiTjgrQVBKU0kvbThyWFMy?=
 =?utf-8?B?UHFqeExvZncxWERqMXM0b1VaUWMrbkNBRFdkUHUyek5SVWxaSTNCVGw4N056?=
 =?utf-8?B?TlNJUkJJZUFpVTRZc0w2aFNwKzNXNWJQcldWNUVkazVpVWJSWHRmc1llenlm?=
 =?utf-8?B?K2pRS1hwV081Nlc3OTRLZ1hDSnNBZG4wd1NpaDVrajJGMUZlNE14SndvdkdL?=
 =?utf-8?B?cW11RTljZmJadDBUZ2hoYzRmOVd4Y053czdWWWpZVEpYeUFQWEl0U0Rvdmor?=
 =?utf-8?B?dWFScXpNQ3hqZjh5ZDZjSG9vbzVyckRyKy9wUzJ3Ykk0LzdVTjFZVVRMbDYr?=
 =?utf-8?B?WGFvSTVTV0ZNcHIyRTdVZkdrdjg3anNieFRDb2FPdjZ6REc1L3ZQWjVjNm5z?=
 =?utf-8?B?WU9sRitDMGx0UTkxSmRsUDNiT3BYU2VqWGFsa0d6RWJkUGNFTkFJUWVhbWZB?=
 =?utf-8?B?SG5kRzFEUHFRU0tnNTZ2cWpWTWFBaFJvcDVOajNnTWpvUHUvekVsZVdGOUxG?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866c370-1ac9-4b73-67b1-08da56154ced
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:11:11.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsdyIkOJYjKoytWntnLCssmSIfCB8GTYlCvXFljmfbY1sO3avpMu7vtNuqZfMZdZNRORqH+BXuj1V7A/MG0e4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4061
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_08:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240074
X-Proofpoint-ORIG-GUID: q9hhqZE6CiTrCKK2dcKGwFs_Dk3BXdOV
X-Proofpoint-GUID: q9hhqZE6CiTrCKK2dcKGwFs_Dk3BXdOV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/22 08:34, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Jun 24, 2022 at 04:15:19PM +0800, Miaohe Lin wrote:
> > On 2022/6/24 16:03, Muchun Song wrote:
> > > On Fri, Jun 24, 2022 at 10:25:48AM +0800, Miaohe Lin wrote:
> > >> On 2022/6/24 7:51, Naoya Horiguchi wrote:
> > >>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > >>>
> > >>> I found a weird state of 1GB hugepage pool, caused by the following
> > >>> procedure:
> > >>>
> > >>>   - run a process reserving all free 1GB hugepages,
> > >>>   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
> > >>>     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
> > >>>   - kill the reserving process.
> > >>>
> > >>> , then all the hugepages are free *and* surplus at the same time.
> > >>>
> > >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > >>>   3
> > >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
> > >>>   3
> > >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
> > >>>   0
> > >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
> > >>>   3
> > >>>
> > >>> This state is resolved by reserving and allocating the pages then
> > >>> freeing them again, so this seems not to result in serious problem.
> > >>> But it's a little surprizing (shrinking pool suddenly fails).
> > >>>
> > >>> This behavior is caused by hstate_is_gigantic() check in
> > >>> return_unused_surplus_pages(). This was introduced so long ago in 2008
> > >>> by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
> > >>> it seems to me that this check is no longer unnecessary. Let's remove it.

Thank you for finding this!!!

> > >>> +++ b/mm/hugetlb.c
> > >>> @@ -2432,10 +2432,6 @@ static void return_unused_surplus_pages(struct hstate *h,
> > >>>  	/* Uncommit the reservation */
> > >>>  	h->resv_huge_pages -= unused_resv_pages;
> > >>>  
> > >>> -	/* Cannot return gigantic pages currently */
> > >>> -	if (hstate_is_gigantic(h))
> > >>> -		goto out;
> > >>> -
> > >>
> > >> IIUC it might be better to do the below check:
> > >> 	/*
> > >> 	 * Cannot return gigantic pages currently if runtime gigantic page
> > >> 	 * allocation is not supported.
> > >> 	 */
> > >> 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> > >> 		goto out;
> > >>
> > > 
> > > The change looks good to me. However, the comments above is unnecessary
> > > since gigantic_page_runtime_supported() is straightforward.
> > 
> > Agree. The comments can be removed.
> 
> Thank you, both. Adding !gigantic_page_runtime_supported without comment
> makes sense to me.

The change above makes sense to me.  However, ...

If we make the change above, will we have the same strange situation described
in the commit message when !gigantic_page_runtime_supported() is true?

IIUC, !gigantic_page_runtime_supported implies that gigantic hugetlb
pages can not be allocated or freed at run time.  They can only be
allocated at boot time.  So, there should NEVER be surplus gigantic
pages if !gigantic_page_runtime_supported().  To avoid this situation,
perhaps we should change set_max_huge_pages as follows (not tested)?

-- 
Mike Kravetz


diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5eabb8009d8a..c78d6c20e6b0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3416,7 +3416,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * the user tries to allocate gigantic pages but let the user free the
 	 * boottime allocated gigantic pages.
 	 */
-	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
+	if (hstate_is_gigantic(h) && (!IS_ENABLED(CONFIG_CONTIG_ALLOC) ||
+					!gigantic_page_runtime_supported())) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
@@ -3464,6 +3465,19 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			goto out;
 	}
 
+	/*
+	 * We can not decrease gigantic pool size if runtime modification
+	 * is not supported.
+	 */
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
+		if (count < persistent_huge_pages(h)) {
+			spin_unlock_irq(&hugetlb_lock);
+			mutex_unlock(&h->resize_lock);
+			NODEMASK_FREE(node_alloc_noretry);
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Decrease the pool size
 	 * First return free pages to the buddy allocator (being careful
