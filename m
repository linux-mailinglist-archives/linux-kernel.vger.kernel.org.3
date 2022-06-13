Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C454A1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiFMVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351175AbiFMVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:44:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AF065B0;
        Mon, 13 Jun 2022 14:44:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJXZFT025679;
        Mon, 13 Jun 2022 21:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=X91FYddY8kf/K7zVMlaLcTEEFOtMiVSlYlL4HKGyOnY=;
 b=UBOZXDDHcv13BOh2ua45EFM+wU0/Omp9/OKTyyzqyh8AmJ/k/cOrryBY0We4+fMeqb7f
 8mfFr+KWF8nL8jrxDn467M5GJk8i0toNwwC+CjXYpA+6AZ3faGwG46TFFRz6f4S6cteL
 bxL+EdhOf/jp+9dCMU+VBLHgsj5ymczcAPSxLvs5SDQSLYryK/5kxlsade7Abr5yUL0k
 L1JyMqlEjeIjYK1WShRi82UWEutSk4R2l48Vcoul9lz0h/ZmcbfBZTbL5uNZ0+PIH3W2
 QAxyfC0HiwCftbEVDEarE/OQLmLXe0jSK1icWjwdPH4HwrymfIGmoFYD81oSoYDRJyey ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9c69b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 21:43:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DLhFh5005000;
        Mon, 13 Jun 2022 21:43:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpddb80j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 21:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3un6joX8M/rrz+4Cn8WoVGQiEDWtcMLAddese0UWoYbRUNAhFf2fviqGaXbZTWFMdc5Q+bQ3Ci7wxiO0AtvgI7fIrTAURfQxx/plgcvBU1P0XmMkh9rrqKM85wRhrUNItTzL6kI9P7XAVncs7K9IHGqKJq4XjNS0btYybh1VvtaCtQH3HZPdkB/qTSTI6T22jCVX0bQkdj1V7SP5JHxF8uWeeidf3CFb5ZfYOnIz8WONNSJrlxbBtiemkNp+sAHgzBdbSfwRWxbSeD1A1KA0aKHSICYr1mnrAyOm+HG2KBWv+ZoZBQZPvjLdGgPjMDE13A82ndBp7pIuvQIcumhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X91FYddY8kf/K7zVMlaLcTEEFOtMiVSlYlL4HKGyOnY=;
 b=SNezWqSnCckTRSzcACbeECvo2t/uih+dAjdrVKrGQrfUfxdVp1omq7GT9/ca9z4eKdw/5N3qg56oBL2K3AweyouTmlyk5aA1hjDd8ncbdYZ91BD+TkTOmplgz0kq5GRuBHWRAntKlk2ajEQTtVjM5W9E5rKUGYYKNKHLI3qhWu8LvCh3yUIiHnY7+hvnAId2fUvjgU/KslGHLJGmcMCaJqwEyTodiyTMj8TB+/WVJDZwBHy6z2TAbk7EOt1EGpu4qG1zjCUcSuLV/zEVhNW5NnpWLJO7woDRZGMGEUNu4JYnYvm4z2ra2pIC7437D/fPmLYKJwZkNR2K980DNahM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X91FYddY8kf/K7zVMlaLcTEEFOtMiVSlYlL4HKGyOnY=;
 b=AqmxwuQRywB3H2RygPMrvyqaMurrDpdEr+CV/YduWZPqxHp3lGWFoN478d7CPlJaAPh0IsKyQ6fpOC/+A6MWPcpDLJMSz564Nj9iMe6deRmQNtCXnJbPr4Px0S6FQPKHFtX5f4lv4GMXe8QBedFKxkzSjEhzDQJ/Ukoi2yM7usg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 13 Jun
 2022 21:43:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 21:43:48 +0000
Date:   Mon, 13 Jun 2022 14:43:45 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: hugetlb_vmemmap: replace early_param() with
 core_param()
Message-ID: <YqevkanSFly3Y0Y+@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613063512.17540-6-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 120c22b2-5228-415b-c8f6-08da4d85cc52
X-MS-TrafficTypeDiagnostic: SJ1PR10MB5929:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR10MB5929B9F047912E51578D8B8AE2AB9@SJ1PR10MB5929.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUE4tARWRlyFIicNuPdiv6DexDYorG0ObbmlAVt+knH7CjZGt26hdY0WjXggqYxwxbrZr2XqBzHLoQRkxoYDrB0OMIqobDq0r8beDISj0xLCACo8yXCYx3WPFJFmoBBu1HMe3IrebyzsncPL+ZAeuEjHwSquJnJ0OsKrGWzxgbAkA7BQbfLSilI3Htgq7xqaWS0cgD8vjsRW9zBvv+UaxUJcdN3Z1YyoAnbXq/0wgsa57C+UT7b4xzw3xMudnSBIeSmC26SoIdvuGb5ZTm54qgwGNUFvMSg42L/X+fbQTqNmdghs7dR2t9nCcbGKcdPcdm5uCmF35s01EOTWH860ebSbzdiTD72crfLc0B9iTqul+p9jSXxDJo3u7CJPllf5qm9G7xyFfiOwiyGQW0PFnvKR2irGQj2OR86qfnaWVL6cxlI+99s9EGvT8YJItRrXDnXtWIue+Nm4urghjNwtzt1iopJz8EeYOUsB4NDtG6+3D3iun+63ZqMtzbFXA+01VZyoDua+GQQ3vjeAQ2V4dUIBaIZuhWOPz6i/pq9d5dCFoevEozD1pc/wJTNOPf8huSELpceK1NDFEiZ3bi6Di7g0rIjmYml9EcQXgd+RbEDR8dpUDgaHInTKB7wuyV13wsBIikw2TOT2vLS+OeE9rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6666004)(186003)(6506007)(38100700002)(8676002)(6486002)(44832011)(6916009)(86362001)(4744005)(9686003)(6512007)(508600001)(26005)(66946007)(83380400001)(66556008)(316002)(2906002)(5660300002)(8936002)(33716001)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFFekZOVS9XVGwrY3hSQjlKMS9mM256RkowZzE4b0pRTmJLOXRqYTJmdnlm?=
 =?utf-8?B?NnVGWHRuUXluMlRiczhiZjMybmd1b0RGYTFRUEVsWDhFcHpGL3VhRFdVckFa?=
 =?utf-8?B?VTQvbFdLZExxck9xM2phVE1ITXdXQnBmb01jUElLbmdVV2ZlL2dmSmRTWXBO?=
 =?utf-8?B?eXdjbkhSWlBMNEZ4V0RnTXR0a2FJQVJ1WVBtZWZxMVVIVUJrZlVQb3dEYy9O?=
 =?utf-8?B?VlU2a2J1N0Z4Q1hOZU9XWmlmM1hiak56SHFCTEdhRWxUZ2hVTGZYNFZsR3R5?=
 =?utf-8?B?VWxUVU50S1RkUDI2b0s1djA4bUI5NFVCc0VHVU9ONzdEMGtBbVNjUE5tYmNr?=
 =?utf-8?B?Z2JMeUlmZ2FVZW5DaVFOUU90dTR1eUtFaW1iWjlBbjA4NWsxSXMrSFBWcHhS?=
 =?utf-8?B?OEhsKytqTGR2cHZLdjFlSXRmNXBVbGxjYkt4ZlA5ZDB6SHhiWDJaTWpXL1NP?=
 =?utf-8?B?Nm1ha2VQL0hWV1AzMXFwbFFFWHdjL0gwVFQ5dWhMOEZISzVIcFMwN0o2WGxW?=
 =?utf-8?B?Sy93R2l0eTdmckhXRXM2R1dkVFIrRm4zS2N5Q2FwV1B2eW9CUzY3RFg2OFVE?=
 =?utf-8?B?M0d0QTdJZ0FHZm5ZRWp2UGt4elpzUi9rcjJnQlFTTEJycXhvMCtVVWN1a2c4?=
 =?utf-8?B?U01tQ0QwSGRUaVZtZERqTmFXUkhmL0RtbnM3WEFWRSs4NDFQNVVuMWQybGVu?=
 =?utf-8?B?S2hjbzVJUW5ZQS9IZGJFc3lhdFBJbXUxY0RnQm15RDhqNTBOQ2o2NG1Ea3dj?=
 =?utf-8?B?Q0VtbEpPUXVNWkVXWEE0Zk9ZR0YrVFA3QWdaK2hKLzh0SHpoU3JGdDZiTFRS?=
 =?utf-8?B?Qnc4dXdZbWJOSDlLL2pkdDhiRlh3ZFQ3TWVHTDNLTVNOWU5ITDVlSHlIRUtW?=
 =?utf-8?B?eENra1g1UXdLQU9qL3RRS0N2bVhmWlBqejVzMHJjNzgvdTlZMC81T05jUlQ2?=
 =?utf-8?B?OEZHVWFsQklXek4wU0lpMHljbi9mRXkrbklzRDFNZHlvNVhoUng5dGNqYjRU?=
 =?utf-8?B?TUlOWUZoMTZNdlJoME1tQTVsU3Q5N2lrMUlIMU9zSDNDWExwZjVMS29HYVFL?=
 =?utf-8?B?OTBHYWliWksxTG82NFRLdmtBU25PL093aEZiZllvZmVjM3dhQWcwVVNzd0JX?=
 =?utf-8?B?YURVZ1JXTVpETjRFKzJGZFRkT1I3UXltanRuMjFRbzROV3JOSnhSZk55OFFZ?=
 =?utf-8?B?QzVNWFNYS3pCZHl2WTVZTFpJVVd6bko2dHhZbXpidjNLRlVZY0lVeEl3T1lj?=
 =?utf-8?B?aUJzSklXRUlQNjk1bmpVczBXRnFWbmJabGF2TkxNa0t4eGp4aEhkcmg1ZXNI?=
 =?utf-8?B?SUxDSjdsTmhuMTBERzFHdEI3SDRjVml0c0xYSDRYT29ONTBGZDRBTThqOG9W?=
 =?utf-8?B?Q053RzI2dDJmY0xmQmM1bUFTcVM3L0JNSFVpTE9ER1k1OXpDcnpGeXFYZXpM?=
 =?utf-8?B?ZFNKcnE1VnZRc2RXWldjd2NsZnd5STM2bDROU3Eza0ZTOExOYjVCQ0t3YzAy?=
 =?utf-8?B?K1hVNi9lS3o4Ulc2NDQ3TVFQZUpYNTE3TDNrZHFiNkdhaTBNQXYvMEMxV0E1?=
 =?utf-8?B?ejFJTVEvanV3a1V3NmkxU0w3UXB0SXRabmJCVjRvTFlFeVczbkJtV2N5UlAy?=
 =?utf-8?B?bEUzMUI4a2YvTnNJcDg3cldOaHo4Ukg1MVlNQ3lsRlAvRnUxK1dUWGhMYXo1?=
 =?utf-8?B?RXlzRHc3ZFI4M1dLNkdrU242RTB5eDg1TVl2MnA3L3pKNUVYbHh6aFZqcmFv?=
 =?utf-8?B?MFJ5TzZaUzBaVGwyVUplVUhYb2t2SXVvbEl3TWxQZE9hMXRsV3NzL0FXaUV5?=
 =?utf-8?B?Nk1IaituWWg1Z1pac3pSWGRwcGU1bTJTQ0tqQ3VBUWdqUndRMU05UnpKS29v?=
 =?utf-8?B?TDA1N3BKbjEyQ3hVckFZZjkxMWQ4azMrRWJlV3VyWVNWaXNwenJSTlUwczRo?=
 =?utf-8?B?K1dLNFZSMlkveU83b0pvemh1R0RBdVR5NURORFREUjdxSGo0Wlc2OURBUzh4?=
 =?utf-8?B?cTJYWmRYMHNVNHBXN3VZQVFuZW9uOXFSbEtOTzB6MU42OFFJYzltYS81blBT?=
 =?utf-8?B?ZUUwdGNRc3lnLytIV2x3c2NKS1VOWGpFbWMyTUNpeWxwYVZuNGpJY0V4ekxH?=
 =?utf-8?B?eVZEeGJPeGlQdGRGMDhCNGkvVnBtSW1RRDY3Nm81RWdYN2dKVjFZcXNLYnk1?=
 =?utf-8?B?aXEvdWIrUDlDenhzMkZjd1pkdTl1MGlVWUUvNUUvQnlQR0xJQkJJTjdiYVM0?=
 =?utf-8?B?OGxQNC9DazF3VUE1endJMHVXVjJ0dFo5VVdUVFFkUHJ4SHRGMElDNHFSQTZZ?=
 =?utf-8?B?elBWMkhXbkJXV0k3eHFYbC82R2s1SFJWYit3MDRKQnlTSk9YUlVFNEU2ZmVR?=
 =?utf-8?Q?wzJo7sotx1m7CcLk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120c22b2-5228-415b-c8f6-08da4d85cc52
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 21:43:48.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hnE/lc5Pdci4H/E7UfPddZ9/+ncDTa48MqrXDin+4tCqsv3ZMCPtcisehBM+EdlA/g3WcJekY4zfuKt+2nTng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130084
X-Proofpoint-ORIG-GUID: -YMs-xD2W3JKhLiaUdX4khzL0LoFa3jo
X-Proofpoint-GUID: -YMs-xD2W3JKhLiaUdX4khzL0LoFa3jo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:11PM +0800”, Muchun Song wrote:
> After the following commit and previous commit applied.
> 
>   78f39084b41d ("mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl")
> 
> There is no order requirement between the parameter of "hugetlb_free_vmemmap"
> and "hugepages" since we have removed the check of whether HVO is enabled
> from hugetlb_vmemmap_init(). Therefore we can safely replace early_param()
> with core_param() to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
