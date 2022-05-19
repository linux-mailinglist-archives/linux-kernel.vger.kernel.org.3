Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63E52CA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiESDhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiESDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:37:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47A692AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:37:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMIlMO005301;
        Thu, 19 May 2022 03:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3E/O8AuINLgANbErtoOw7Y85IDi/sCQml8Xl8teHJJ8=;
 b=Dqc5tammtL7GcHC2z0dg1c07YIee99qjegH3hwrM5uMFoAvJRUBtO5aVAV9vk5dsbfYD
 GNizgx3V3Z6yUxYoo/IsYUVUo0nHnWMj4UdjtzTPB85y0Dh+56JNv4/2aJ7cdB86p4tI
 G9+JinYWO8esPF9uv0lbcO8+y7r4PiE2y6SGc1dnY1R1sKqMZj/UWX2HYBbaMY6VagR1
 qzHfqmlT5kwLd7bWrUh+VmZf9fG5TrU+u6aur9vyD15Nmsn8njdhE4pKDgNOakCFS3SG
 32juBjI9dcAtKJepGLjnPYgIBb/tAkZFPB2Vc60xBLYJ4jzv+paB2oRWlHHEfodptp8u DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2372378v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 03:36:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J3VbU4027222;
        Thu, 19 May 2022 03:36:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v4kbds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 03:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyavpUGvQ5jsOZTmaO/rakaTP5ROfSC489Fmg86PDKML1M94QZQORiA60aPf26SFcDvhkqfkTZezqgVTKH1UoHVWzqGJlE6gqeyefpknPc4yJcQ+DmpHIv3pREnnTihZAHfy+6QRcXWZK2Ng/mIIa6yC76FZJwtQX/1e4+HMqIdAo1MZhCN8EcXaC00FVDE8popk7oOsxJVCJSIj7i8G0i04YQdkioL4ixtfT/SSZq2QLivuojpSj/q0v9bBaKLnMZfAkuDywNqhj5sPNucbzItrixhpM04lsc4uevITDIVFv40UockP06Dfrf4z1akdYh0enIoGCWZ3X7qoFQ5TCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E/O8AuINLgANbErtoOw7Y85IDi/sCQml8Xl8teHJJ8=;
 b=KdDMvSfDV2Dht9LFJH2yG1YDYzaN+H/G7SusibnLYKJIWm2fSDuzpARKKL11sr8Al9jALoKZp4yQ1heD9Q9Vtoti92zRWLp/WaW0Del9FfnA08GvTzEuPDyJ+KtAYH27TnAUwvCWyb7FjDbEOcUwGWtjfzxfNVdmGgQwuVZBKtOlOvL4te+7UYvwnRf1CKUm+gnCl/NQq1HoYfXedBVF8qizaqg7cjRdMfqg6gTVVFK4jlOmZvhwDeaWbScXr2MHorrZPo0Oa3Jg2oK7jHl2Hs2xJgB9rDwIXNmYx8gamTfTg1S8IBQDDPBc8bb9FFeUObCOMN6tAGee14F1aSQxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E/O8AuINLgANbErtoOw7Y85IDi/sCQml8Xl8teHJJ8=;
 b=kRjKv0Y9WW/uQhSWdeGEFBQczZshwZwr7G8Lm/7cL04JPPDpi77ObsZTwCzZkQtv5/hjBx9SKo3FNHNPPPtTkLWJPm/fYVyVw23Rsp11EQht/dwtn/ob6Lv72yr7/G6APrEA04gH1cuyUF1mwMEpI3slb0vCVGeo5UNYva4VlRw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1882.namprd10.prod.outlook.com (2603:10b6:3:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 03:36:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 03:36:48 +0000
Message-ID: <ea9a9ef0-05da-835f-8d85-491cc133d4d7@oracle.com>
Date:   Wed, 18 May 2022 20:36:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: vma_needs_copy always true for VM_HUGETLB ?
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Peter Xu <peterx@redhat.com>, Nick Piggin <npiggin@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
References: <a7ccd8b2-c659-44c9-cb18-1496f99aa5a8@oracle.com>
 <872b743d-ac21-59a3-bd31-109229f63112@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <872b743d-ac21-59a3-bd31-109229f63112@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:303:8e::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420197c3-bb07-4305-a3e5-08da3948cde7
X-MS-TrafficTypeDiagnostic: DM5PR10MB1882:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB18820E5F7B09F112E2A57700E2D09@DM5PR10MB1882.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuTXsiKir4IcyGz+Pk+pw3eJZxPPcF7K8aKzFWE6pvylKeY9OgPlNEJ6iiU6Vb4LhytJ2ioC3FZD2uAm19rJYiltPojftJ5MvIgerVAkhla8Ya91uTjxOxvY+q6ENvGQtvK4tKL5yJECSYcS2c6jtpl8k/MViTzuqPhEkOqWskMWCmGxJBOsxzVGVK5A+H4mjt6ucinJyJlW2szj/dEFkYZUY/Irk3LJOrVH0H+2tl5tqsNCrL0ndL+nUiIYYJjtSbGM+aX0vbuB1m47j0icI+w9TdBg1DaJbfY0bvMugMc4aCq42OUbTC0ziRHm7XejFsKVHtUK6F67iTZA1PLs3WnDKt+7/bfOMqWZrDetAQixL7dKjL6LFu78FumA5EMQU00C2yqw7RC9FZKava1kwLgtx6NufkKGZE9ac3DlHKkOCwVq7UA5WZM/lvRQdptP+ZmQ9ohOT+R3chSKIMr46+Ge/QkBsL6jQVjvcoRG/CwmOEYC92BypxeftBC0eE8thtqIEkx1ZS3XLBQKOyqcTUwVijrU7J1t65ahZr1FpqGTSFqp5iJyqcJk5gHtstd7PzhtFawrnXXPHf+9WEefAZvgQBtfLEW6mUmXyHQdiOsEpbEB7RyqMHv/kMPsf8tp1ox9Bhxrs4mqc9cBq4Mdy8icpm4v8GkFp/7lvT/Pb4hwD41IP4hRZXmfB/iFAG4vEAjftQ2YC73iJ7XjFsPHbKlonJeXe1tbeZVGoklT0B/IBiesfenB/8SmaUaf6npxIHDHF1IbrRIc8DTyygD7/7sabV/ThNJ5fOyzNCOA5xKO/Anpnoo3q7xFDt7AYzj6SEjcjwtPxUqWeL8k6Spdo3whqQJKNIwd8IcwQ1xtyiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(8936002)(31686004)(6506007)(6486002)(508600001)(83380400001)(5660300002)(2906002)(36756003)(186003)(86362001)(66476007)(38100700002)(38350700002)(8676002)(4326008)(66556008)(31696002)(26005)(6512007)(7416002)(53546011)(54906003)(6916009)(316002)(66946007)(44832011)(966005)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZxaVJxTFB4OEo0TXdiZXFWSVNEV1ZEQkt0MGJ5WXZ3SVM3MnJIQ1hrTGdN?=
 =?utf-8?B?VE1ubXgwcmlhdUMwYTlLNmtUaFpGV29jMG0waVhqUWVrSFVGVjFkeEVzamFD?=
 =?utf-8?B?TGFnT1M0bXM1dG0xMHRGeXRubUJFSFBVVHFEZkN0WDhXNUFtd1BlUGhXNUNZ?=
 =?utf-8?B?UGVzOXpBbWRxWWZXcjVHZ0VTRmFlVFBxZGNKVUhTYktOZmtDNFRZSTU5Wmlp?=
 =?utf-8?B?bTl0ZFp6d0R5enVTaW1KdnVBR0RwMjJLMFk4NWdPd2ZSKzFYM1NMQXVhMm9n?=
 =?utf-8?B?VEtJMEtJMlBQaVNOUVhtRWNZRzNGQ0JVTW1WeUZBUXVheDhiV1QrclJpY2pq?=
 =?utf-8?B?cjIxSllBR01sbFhOakJveGZBYjJYT3QwNDY1WSsrMWtGdkN3VXVLR0Vnb0tz?=
 =?utf-8?B?dmY2Smh2bWZ0MlRvL0J4NU5IcEJFZzhOUm13YUhyaS9Ic2FMYldyNXhwMnRi?=
 =?utf-8?B?Tk11Rms4cHFLQTcwUXdYV2hLc050eFdiYkhHS1VlWlY4Q3JNaEtmenlLa2hU?=
 =?utf-8?B?R254Wll5a0VHTWw3bmZWTFVDeFMvRStqWnF5R1gwN0V0YlBEOFYydHdTNEhu?=
 =?utf-8?B?N09kaG15U3VjZllKdEsxMHorL0ZITG1VM1VWUGJrSXlxVnk1ZFNUZlQrVldl?=
 =?utf-8?B?aXgzNTNxNzZWU3E2WmFPVDEvNzZ2TEJkOWxQdHNRNmxlWlRPZlFGWk1kLy92?=
 =?utf-8?B?M29tQTM0K1ZYK3J1clBldm93TUhhSXZYdTlMZElFQ2x4bEtrYVAvcVVRQlVr?=
 =?utf-8?B?UzRvQnFTNDZsYlArTUpvRUZnN0YrdU80aDBFSzEzZUV2eUdQajJUVXV4UGpF?=
 =?utf-8?B?Sk1US3VjWjVZdWVCTjdFTGxCeEV1WjJHV3hEUTN1U1RVc2x5aEVqNENlY2Iw?=
 =?utf-8?B?R3dMM1gwUnpNcGZGR1VFWEpKMFFwME5WUDIydUhhdy9ER2JWK1BsQXhwSFVN?=
 =?utf-8?B?RVBBelBLREZnUWsyQ1h0L0RhNXdBLzBCQ3pET3k2OHBpVEdXNytTRGpzR2h0?=
 =?utf-8?B?NTJoR09aZWdoYm5yRENncDdQM0VGMTVLNGlpUDJCYktSSTdhMHg0V290UmFa?=
 =?utf-8?B?bzIzNnZBeURiZEdjc2d4ZFM4ZlVGempyWWZkL1ZiSk0yWHRpNFBiQjlCalpC?=
 =?utf-8?B?OXZNblc4b1NLanF2T2FXc3hwNDdpbGdDQWhNb1FocTVQd0tKV1BYS2tGWUxB?=
 =?utf-8?B?VjgvUm9qSm43b2ZXWXhtR1BUM0VRS0dJczhKd2ludFlUSUN1aFJ5UUNDcUc5?=
 =?utf-8?B?UVNyV3hXclZRVU40ZlFITUx6SU1kQ2tJOVduS3UvUFR5NStaQnVkOHFaMDNn?=
 =?utf-8?B?b093eVliRnJRYWRkNElGNjd6YjZnTXFJaVdyTVZidGg2aE5pQkwrY3NZNmQ1?=
 =?utf-8?B?cTg0NDM1YUVmRTJuRnlyak5raE4wZWVBUXNmZ1ZCaGprVEVxQUZoTGpWOUNw?=
 =?utf-8?B?aE1OYUdIQWsxYjhtMVFJY1Q1bnFlcXQ2Qk1NcFQyQ0FEMHVMdlRnaGw0eFlr?=
 =?utf-8?B?aGNaSnVISUcranVDNmlUV0ZPUGdUejRJa21JRThLbFJTVDI0eXQ1cTA5dXZu?=
 =?utf-8?B?eW1sM2dEdkk0YklkbXkycTRlNlVieS9HQ2ZxQTNkUU9aYkswaTVaamRiQkF6?=
 =?utf-8?B?dWsyWWgrY09LaUNKeDYydkd5c0pvWWpnckRZZ3MvUEJYOVJTYlNVNmhTREE1?=
 =?utf-8?B?WEg3bjBUS0gyVDJudCtGZFUyWWVOTVhNbXloWHhyazVFM1VoMU55RjlXRGsy?=
 =?utf-8?B?L2RlYVdBdjM5UW55UlhiN01vNUpkeENRdHpGZEh4MlZCTVJkQU9VR3o3aUlE?=
 =?utf-8?B?b0ZPQzR4M3p5cSt5MDJuVXMwbm1rSTRwckoxTTdBOVJneHJUYnh4cFFmckdi?=
 =?utf-8?B?Q3lMdVRGdzVJTTR3aUNTcWY5ZG56YmFKQ1p5NUl2T2pPajNYdXM4aWxGNVdD?=
 =?utf-8?B?SnlpSWowMmxlVERHK1BXa08wTHdNa3NTUlFMekJqZzlOVVFjOG1UZGpXWG5r?=
 =?utf-8?B?WHU2bTlkRDd2Q081bUc0dmtSTDRyN0ZuQXZhUkxuVksyMGlnSkdBeWtFcVFx?=
 =?utf-8?B?eEQxMUlpS1JRTW1KdUVYakI3dzhiendpVDk1Q3lOS3dreDJnOXVGaFRPcVNE?=
 =?utf-8?B?ajgrd25sd0t1VWp1d0pFYkZ5UG1jZTk3dHQwYTJhb3hzdkd5UDVKa09oL2xz?=
 =?utf-8?B?bS9jWFdZM3RxcGRMZTFFVFNRMzRqZXg3MTJ4UmdpWHM1a3NLNGhpL1VMMlQz?=
 =?utf-8?B?Tkpub01TY042aC9pNXdOK1M5WFQyK1paK0VJbkxCWlZIVm1YMjZ6Qk8zSW1j?=
 =?utf-8?B?eDUyc3o5djlTVDkzRWU5ZXB1T0VOZEFWZFBXa3ZEYytPUEd3ZFUza20vdUpr?=
 =?utf-8?Q?/KXK8bOlkT8N5zno=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420197c3-bb07-4305-a3e5-08da3948cde7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 03:36:48.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRKtiSzc3E1BDEF+aav7zA+jnaDrzJZebeWSLeCl6SYebdHTECvshxW5ssmcxxtza8gYQUKBc/kH2x+UvMDgJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1882
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_06:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190020
X-Proofpoint-GUID: jG1ckxSuBB_GwdrgNgiBcBnH4c8ZQWJP
X-Proofpoint-ORIG-GUID: jG1ckxSuBB_GwdrgNgiBcBnH4c8ZQWJP
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 18:30, Hugh Dickins wrote:
> On Wed, 18 May 2022, Mike Kravetz wrote:
> 
>> For most non-anonymous vmas, we do not copy page tables at fork time, but
>> rather lazily populate the tables after fork via faults.  The routine
>> vma_needs_copy() is used to make this decision. For VM_HUGETLB vmas, it always
>> returns true.
> 
> "vma_needs_copy()" is *very* recent coinage, not reached Linus yet.
> 
>>
>> Anyone know/remember why?  The code was added more than 15 years ago and
>> my search for why hugetlb vmas were excluded came up empty.
>>
>> I do not see a reason why VM_HUGETLB is in this list.  Initial testing did
>> not reveal any problems when I removed the VM_HUGETLB check.
>>
>> FYI - I am looking at the performance of fork and exec (unmap) of processes
>> with very large hugetlb mappings.  Skipping the copy at fork time would
>> certainly speed things up.  Of course, there could some users who would
>> notice if hugetlb page tables are not copied at fork time.  However, this
>> is the behavior for 'normal' mappings.  I am inclined to make hugetlb be
>> 'more normal'.
> 
> Good question, not obvious to me either: but I've found the answer.

Thank you Hugh!  You went above and beyond as usual.

> The commit was of course Nick's d992895ba2b2 ("[PATCH] Lazy page table
> copies in fork()") in 2.6.14; but it doesn't explain why VM_HUGETLB is
> there in the test, and goes on to be copied.
> 
> I haven't re-read through the whole mail thread which led to that
> commit, but I think you'll find the crucial observation comes from
> Andi in https://lore.kernel.org/lkml/200508251756.07849.ak@suse.de/#t

Sorry, that I did not find the entire thread.  There were only a couple
pieces on linux-mm and that is the only place I looked.

> 
> "Actually I disabled it for hugetlbfs (... !is_huge...vma). The reason 
> is that lazy faulting for huge pages is still not in mainline."
> 
> and indeed, look at the 2.6.13 or 2.6.14 mm/hugetlb.c and you find
> /*
>  * We cannot handle pagefaults against hugetlb pages at all.  They cause
>  * handle_mm_fault() to try to instantiate regular-sized pages in the
>  * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
>  * this far.
>  */
> static struct page *hugetlb_nopage(struct vm_area_struct *vma,
> 				unsigned long address, int *unused)
> {
> 	BUG();
> 	return NULL;
> }
> 
> Oh, and that pretty much still exists to this day, to cover that path
> to a fault; but 2.6.16 implemented hugetlb_no_page(), which is what
> then actually got used to satisfy a hugetlb fault.
> 
> So the reason for fork copying VM_HUGETLB appears to have gone away
> in 2.6.16.

Yes, that is the likely reason.  Functionality was not originally
supported, and when it was added this 'optimization' was not enabled.

> (I haven't a clue on private hugetlb mappings and reservations and
> whether anon_vma means the same on hugetlb, but you know all that.)

Yes, I believe anon_vma means the same on hugetlb for this purpose.
Although, I do need to look closer just to make sure there are not
hidden surprises.

Thanks again,
-- 
Mike Kravetz
