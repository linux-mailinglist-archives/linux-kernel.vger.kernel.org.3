Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA752C65F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiERWg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiERWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:36:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F95B8A1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:36:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMIqOH007853;
        Wed, 18 May 2022 22:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=cnH6W7b6tE1y/CQthqwY7SYjsLdrzQWrzsUeQvb1sLY=;
 b=1G78fsCkXtobwcEoIcGRPJ4egfZ4pOxaMIZd/urwanGEBJ3p6O+Zsn9nbmtntXXK9Cdt
 xRuaH9D2y2KFm9EkDluP8KVlYpsladDfbXkV5gusZYz5yasEvJTodxbE3rTuFoIK59c6
 lJv1GyiljmdbtxQWhvQ9S+wpknrKox0RoACmErkwACAkXSoHGb/bBlu+2vE1l2shcqyz
 pdlExj0VrKn7Meu8hcSWjYLJMTh7F4DlUejEzY4NiuR/N1vesgpQFeeafBDisUq0+Hqc
 wQIWyLzHqZnL2jK629Ms5bYbNxF0lFn37YHgGLJ0/u4abPXk+TfU6SI5/UibG+b01Siy hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucadsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 22:36:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IMU1kY013286;
        Wed, 18 May 2022 22:36:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22va7usd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 22:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr0iEOVvL8EqIkXs2HVrhQLYvFvf4usBSOsy7MWlhVg65gkjXrxSrq8VYUDvy6mp74z/q9ob3chku9YCgc6w6OKIXra4rqySYS5gQbE3O0KgHgR5fOEnYJZkQBN/42yTADRyeqFvVG05elPCSC8NnNT6ufT7Bkpdfxck2A2Iqo8zKDIs9wML0DhPfYsYMlwJK8o7nRovyf7wYQL6IlL3lddCAVzt1dR9vTHd9EGAaly9s5diYHpayENEXcsyuxGARovs3sDuPDFRy3tY8/eQ7/IofGXA3vRIbgsKp1X2r7dKXLe2irLaKx6EubJtrrju4SsD+KKMBo5nplT03zj2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnH6W7b6tE1y/CQthqwY7SYjsLdrzQWrzsUeQvb1sLY=;
 b=UFm/nqeqzDvF7A41e9BqA9qFD/b26NwBAB8UebU1q1WbmN/HCpQRAiN20NtDWRtjiWASF+g6FxVpR0pBAU/pA1fKXXgTjhpLlee8nAslvjVSgRvGhX2TXSDVqRZIMbxooU3Z6VUmiNpb7I78OL3/OoduyTVDYrIm+89/SAbDWiUu4amGPGA6T7HTIy1SHG7nY9EubmLkK6hBBEZl9hcOZgbpEfQj8bMx4nhWjJm61hpZ2/goTVcKP6Ja4MsVHAA1Rh04F5c12BEn++cs7qLvj5mFJUxyuuhiT8S5snUxy4PshuFEEzJlmZ2AiZH2W02KukpOkS8KgTGRfm3/iYfUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnH6W7b6tE1y/CQthqwY7SYjsLdrzQWrzsUeQvb1sLY=;
 b=YcV5lKu6IfqDfbRgxS5TSICL6Fm19+Gz3GwGPkimHuvhvs5u/roWrZrko6YOzfGAfPyJaB6ULXIr11EkyEt0/M//H5wiKTHcsXItrx8RggUY+hSSEubE9YKkM9/aLTjD1lvQKGsGngXxwfwk8W62rKjIKURtlcEh2OJrjpcUo6I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1823.namprd10.prod.outlook.com (2603:10b6:300:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 22:36:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 22:36:31 +0000
Message-ID: <a7ccd8b2-c659-44c9-cb18-1496f99aa5a8@oracle.com>
Date:   Wed, 18 May 2022 15:36:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Subject: vma_needs_copy always true for VM_HUGETLB ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9aa33d4-c252-4c5c-1b45-08da391edb27
X-MS-TrafficTypeDiagnostic: MWHPR10MB1823:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1823F1A9135FACF6D84027CEE2D19@MWHPR10MB1823.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: US1XNaxk7gLUqhAdu/axcBBmpZv6d+5QNawK3W3IHOZyGaP/MCNIPtm+uSX3MTA3knMej1DhE7V22zTCGQTzjZl06qgzC/lvbozR/gStPM4qz7sD8qrtCpmAY/BqnIBnHndn+8loHFi6KohjtFKM1c65zggHuXIZ2H71jn5l4gcwrpUZLHvY5SNTEctGU/MhhyJDPjU2TIwJBB9fDOh4stTG8gCGJqfAXNMp4u1UkwFWVSxQNCO1FDEqzYXRfoTTNgsPIom0XnX8tYIqikD1pIwdBpOvj01Z9PQO5WwdLiL8zMIoQC96WtcEBXNqVxTiWa4puXlrrah+gg6kHAb6LUi1NI3iC9GuUeafj+HDoSz0+rU1ujlZbqIrTh/+R+GlKJwgARAaAuVEjXbBf1IHAUChUyVDH/hipkai6QxQ6kZzaeEzz0rAQV9YfmdIRqZ7NWRbBf1ndKQmxTyVo62+8eMh+YknrhbVlwvpoOO+q5ZCSmM0kMnDVaJDuz9jV2BJvlUzy03U0ccteZ9jMYUOIXPOAtRWqgpkt1TdvSQmrFFHhJFR5zbFfCjITxQbhVrDY/FqKr7lSJQpv3pJ046hEKuC+FTFr0YSjf/4rG5DzRMwFetwEJO18O3CSjcThki6IdX7Oce8LDMMLTqLk4QwTabEmt4BL263ff45KUQQTHcZ+BECrmQMdGFUumv+7NduqVCJY7EsJNJYXeO6P/fMpNPIIeD/j4QH8Bjh43/c6xhduiGd4sZTbVY+egsaGbUiygZSKf4Phh8Fgsu4Cl3HVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(36756003)(6512007)(2616005)(316002)(31686004)(52116002)(6506007)(4744005)(86362001)(508600001)(8936002)(8676002)(66476007)(26005)(83380400001)(31696002)(4326008)(66946007)(186003)(66556008)(110136005)(54906003)(2906002)(44832011)(38100700002)(5660300002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVhRkJtbm94WlVPbzhoYVV2RXg3NXUrTmZwYTg3TmlhbkdtOTNiZ3lPVFNL?=
 =?utf-8?B?dTJpMFE3RVlTbjljcTF0cHRaeVMvbW0xTjBuUEtlM2dmLzNGUGRrNUEzV0x2?=
 =?utf-8?B?TGdjZXYzbVlSTUJHT1ZLUTVHUHZ4R1l1djRpMjhwbEZpM2FCSysxR0ZTQ0or?=
 =?utf-8?B?MzA0U0lUeUc4NXorSDdBbTM5eTF2UzRsNGFZdlp3MXo0UnRBeUxlSTltRUNZ?=
 =?utf-8?B?TUhEOGtxa0Iwd1l6L00yRzhOQ0kxUXEvbnNQOGFOVDIwNVdOOGRWY1VKYmxP?=
 =?utf-8?B?OHFub09iRUdRMURFeDRPdjcwdUxvWDBYTS91alZOcDdobTVOdGtVVmlVRDdU?=
 =?utf-8?B?L3BhR0p2YkFDQTIrMjRncXJoazVWN0ZFK3ZIMVVONktUNE5rU1dTYjVuWXZi?=
 =?utf-8?B?eUZOQWVpSEE3Z1JNOS9aUmIzOHhSSWx2MTNDVHl3SnQxN0VqQXNHSWZnVEFI?=
 =?utf-8?B?K0Z4KytlNC9CMjRPRlVhU2F2UVFKTUU0blhaZEhZaWNPc0l1TjlqU291L01q?=
 =?utf-8?B?OFhselhqc3RlM0dld3lacGtDMW13QXNzWjR2QjliVm9JVVNwSXBlbVBKWVlZ?=
 =?utf-8?B?QnNXdVJLV0wvSWNZN01TaEs4MXcvWWM3VnYwK3czcUFlODRMKzBUcHROZWhz?=
 =?utf-8?B?eEQ2Unh5Zi9KcTBqVE9mRlVMTFp1bjQzQlhGV2g4UXNjU2JxTjhiMkw2dXZZ?=
 =?utf-8?B?ZERGMWxiTE54dk5WSFo2ajNpTG5XVGpXd1BhWk1RellmK1VVNFhSdEVMK0Mw?=
 =?utf-8?B?YjljQ1A0MmVDTElrc0dIV1lOU0lYdk0vdmNvcmZQRVQzNlN2SHd4N2UvbjFV?=
 =?utf-8?B?dExnV1Y4bFlDVFYxV1FHMFlHajgveEFqak00YlpjSXNqOE5Mdlh4VlJiWGRx?=
 =?utf-8?B?QlpaMXUrYlU4cWd5NEhxeG0rOG54Z3F0eUdGUUFnTFY3Uy9CRVBXb2sreGFj?=
 =?utf-8?B?eHpSOEMxUUxzU3ZoVkhxajlWRTZkWjBuQ0NpTmxDbkFrTkhLWEk2UXczNG1t?=
 =?utf-8?B?VGlhQTlZSGhkSVA5K3k0cXBSVGxhQ3ZjRVVnWmkwMkhJQkdKTXE3ZTZLeTRt?=
 =?utf-8?B?a3I3bE5ONXFZcGxSTVR2OHZmZW02alVBUy9BNFNaMitBbEtXbGNLblFqV2R0?=
 =?utf-8?B?MG54RVhreUNQdDhKaURuY1lDYW1Namh3a21TUVhxK2psOE9hZVNlaW9wZnl0?=
 =?utf-8?B?N2pTb3dGcXBaM1NMV2ZYL09UbFA3WVgrS3dKeVlLY3ZPSkw1WlpFNmxrc2FB?=
 =?utf-8?B?Z1R6S253dTFGRC9oNkpHeWlvK3Y1bWI5SitpeHBsVFpiQ3BHYUI1TC8yREx1?=
 =?utf-8?B?c2hUTk5hVXBGWldnZjQvTS94a1hjRCt5TjJvZVJUWFZDQzJQd2J2WVBKaXBM?=
 =?utf-8?B?dmJ1WW9rYmN3QUU1TVJpNVdYNG5xZm9DU1kvRkwrM0R6QkFTc2QxeDFvV1lF?=
 =?utf-8?B?NUZtOTlYM1pIMEgyZEh0UkFhc0RTYU40Y1ZHeC9FdEZwVzZUM21wR2s4OUE3?=
 =?utf-8?B?QkUrME55RUlHL25pT25JbjdDQlFrM3crSGpnMVFEcVV4ZWp0TzdidytDSG43?=
 =?utf-8?B?WHhmUjNxZWFXTHBtUlN2empGeVVGUUhxcjhjRVl4bC9nVllYM2R1M015K1dZ?=
 =?utf-8?B?YnZZTGVxS3NZNys4dXZnRlpqTVVCRnlDL1JUTjNzMURXNGNZbTIzUHVLVWI2?=
 =?utf-8?B?bzI0VnNzUUhEZjhmZVduNkNSTGJEejFrMkZFRENrcTM2d2Y0RHhlMkZkbWQy?=
 =?utf-8?B?VXpaSVFacTRJMWQ5Q0YvbTNQcEg4NHQ4RmN0dUF5MXE5QnBEK1R2T0t5WWVu?=
 =?utf-8?B?UzgrVTY3SmwwcGE0UG1BbWxnZFVYKzNFTzFtKzNvZ2haV050R3ppZ21VcWc0?=
 =?utf-8?B?NUZBcGRZb3l4RmNaOVMyeXgvb1lLbExqTlEwZnBRTEdtMDFUWDhQWlh5TnJp?=
 =?utf-8?B?UCtTUnVrL1dEWmJ4dkFDdXJsL3pDZHhYVk1vaUZOZlBZVkc3dWNBVS8zMEFo?=
 =?utf-8?B?dUVCTUFjNGNJWlFrS0NHalFpQ2ZFdzlyM3p4R2xnczZlVXpkdlZPMGlIYy92?=
 =?utf-8?B?Yi9DeGN5ajcxUjZBQjZXMTV6bVQvdUF1WUZKajdqdlZzOXBzNndHcWhmV3R2?=
 =?utf-8?B?TXdoS3RCQ1dHZlBFUGVIOFZtdnhvaEFOT1hqQWlrTm5CUlZKbWVrZFc5RGZE?=
 =?utf-8?B?MjI5MGJ3bGxsT21KSXZnejA3a01XbTkwUnZ0RTZEa2Foa3d0cjdKcm1iUW1M?=
 =?utf-8?B?RGEzZnNUZHRRN25ZSmhEWld0cEJGMldXdE1ZTnpTZTl5cHVJaTFJSXo3VVZz?=
 =?utf-8?B?OUwreWhqWjBqb2VKQWM1RmhyemZLTUlJcS94R1Bud0o4Tm1COE1GVXhVTzMv?=
 =?utf-8?Q?LMgWr1nQBfaaWfvY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9aa33d4-c252-4c5c-1b45-08da391edb27
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 22:36:31.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLR1Z3ezXD3ASuMg3HIpe8rC2GWqMye7VIry7cxN1WXQamW6tZ2Ab7E52OUdqWv7PECW2NSn2uPHMqiEiXlKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1823
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_06:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=788 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180125
X-Proofpoint-GUID: _kSt_ubcV7zV11TrvxQ_GibHO2t7ycnk
X-Proofpoint-ORIG-GUID: _kSt_ubcV7zV11TrvxQ_GibHO2t7ycnk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most non-anonymous vmas, we do not copy page tables at fork time, but
rather lazily populate the tables after fork via faults.  The routine
vma_needs_copy() is used to make this decision. For VM_HUGETLB vmas, it always
returns true.

Anyone know/remember why?  The code was added more than 15 years ago and
my search for why hugetlb vmas were excluded came up empty.

I do not see a reason why VM_HUGETLB is in this list.  Initial testing did
not reveal any problems when I removed the VM_HUGETLB check.

FYI - I am looking at the performance of fork and exec (unmap) of processes
with very large hugetlb mappings.  Skipping the copy at fork time would
certainly speed things up.  Of course, there could some users who would
notice if hugetlb page tables are not copied at fork time.  However, this
is the behavior for 'normal' mappings.  I am inclined to make hugetlb be
'more normal'.
-- 
Mike Kravetz
