Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46FC569537
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiGFWVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGFWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:21:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9297721803
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:21:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266J15Ju010481;
        Wed, 6 Jul 2022 22:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=v7ig9vmb4tj4QLaDfvrxf3SB4+4a+knm4qexFB8c2h8=;
 b=TwE4RZI0fi8j9TS0MeThT2PYW0zn3er07cnasxHRMo20iXrDid2G3GoVqRy5fjYsrxu+
 foKZKdVJxZJBkFKe2xAuIM1urxYptZ4VPSnOc4XCS1NoRA7HODVw4eh+HMLz5YkPl6YF
 PDqom5azRTC3AIY5WJWvHKfra1Rj/KcGiztJCrTxTyJWIZ28jTm4TCPh3BDvC7N8B+6U
 vMFviFl3PBcFrbD3+eoQol4q+mXAblpNUDMUA3l61IUXXmnBhrJnRMaBazHnZ8UeeC6K
 Ue4qAQYb0o2vyHAFDi8+garDJGXNNuDdzMjzjEi8+9rQ19RNXwPi1Jn+V0STzeQzzgPl jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubybaj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 22:21:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266ML0jK003437;
        Wed, 6 Jul 2022 22:21:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud16umj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 22:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG4fhgRrENy6xs3svB7heqWB854c/BbbvqSjzE/oEShgwRhMa57UYXq3o1jsZcd4pDxxgCS6GXwl54ibTCDuCOiXokESKD4p6DtakFXihjaOWEw0NUzac6OGYByLzbCRJw8pvSRvrF/6MvLLn92WBzeA7QEBgH65kiwWxvSgZMErzc8Q9gnocXHIL+2Ux6rWQhtvRZvMLeRyGlStCbBoa8w6TlA34OTh+5/WchR1oXDkgg/4yqig93ESTYrjMt7NX39OutWuwxBw61lq88XI85F6uKfU+SgPrvncQBunANNAjBRK1Z9pdYx0NSJKb4ulwGtPexij3f54EvFSIMZGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7ig9vmb4tj4QLaDfvrxf3SB4+4a+knm4qexFB8c2h8=;
 b=O+zK+VdeA3yiF2sIj+VYEoFQ/7iDpT3ptCC/xhDVwu1+Xai5ECpV4oG4mmV+8lwM/NimKqwkGlP+fl7fqihq54uJt7lomVCJ+WJ+W/yaLjvXbYX5D/QCxW+Portc9aaYe5fbYTkBHl/qrvJq5anTilX1/FE7Lqh9nUbQaYCZZoj1v7s9hF0oSg42iHhNGCu7MQTE4xsMdXhZMqjxKiH8GULV+A32+DACyOwpOLvJwIodFEMGQkYyQxkNjxAvV3Tw0OUawvK28DirzZbhIM8I57rt6ywMefIO4fdGtrvLYMtERYmMrOaeHub1ty+Sfp/eo/U8gAutsiViRLtSfSS66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7ig9vmb4tj4QLaDfvrxf3SB4+4a+knm4qexFB8c2h8=;
 b=WcdhYCSintBOilRVNrJ76JgQgqNK6e39TQbdJt1wJcAjuQFW40jTZQForuqaongI6VN9FpQ68mhfT7Fg8wpuqmmaCz6skTvCVKIyPLj9y5U8evqmoqSYuh9w/V7dDQfIuxo1AULfPImJyiWJ42BvjxtXJXC5cUw7oXro6QhAd94=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 22:21:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 22:21:15 +0000
Date:   Wed, 6 Jul 2022 15:21:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable PATCH v4 3/9] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Message-ID: <YsYK2EQVE4wHGzjz@monkey>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704013312.2415700-4-naoya.horiguchi@linux.dev>
X-ClientProxiedBy: MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f29d921-e6c4-4b30-5029-08da5f9dd6f8
X-MS-TrafficTypeDiagnostic: MN2PR10MB4302:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScgWuypJGCU9DA6Agj3JnMkcof+vIri+b1MvNOO5dA5kiWbijraeIc/9EEgJeADoAule5xVh1QpM2KhrzNbkmw3E4PGzxX/GhfTXy6K8KApN1tidU1ZSCy1ZF3NK0O6WkpJCnka8dEpZEGQR5QSBQttzDmlD+3IYHcxD4JWgqE/54DZ350oMfBhPHDl8W5RBmKll+5fXRHfRGmrijNaidl47U82ZAKEQl0uP0fiqISW/Vo7b6K0Vn94wHb127EX5K6sF9a+8CBK2VQWgdclpZicf26yi/KOPBuqL0BiqGENHlT4U4FOkJ2xapjXFeMT8JSAwQqIyJB1OqZer9LLY2ka2HaG0JZ99OPm1PaJ1TtBclX5TI9kyPI1qobMSJAAhcRvxjLRGMtMC8VFgUXBK0XywmkPrjOCChYsyJ2mnBX30GykOqSRApIxqZG6onqQyNcE9s7CTOJaVNifwrw8KsLbhag1bPt36k9S5WiCLDA0Xd/aJ+8u7FDbalJ222h6+mWpwz2XeKqS6gImI0f9P/VwYhNtmbzB8SXP/yoME8V5CQnf7h7fWhkQvdwGV2l0kV81Zt4jVS59L1u9D87jOCqMDx7EEcSVGZDXQTtgdK/DxknWtOuOCH6xC1+UQnEbaO/LJtnqbOl7kBsy0q0ri5hlmpxqiBH3ZRQGTblL9LtAm1/Wa6pRHi4YuDC0BFtmZZeszB+vY0NBY65x9CzN2Re0A45PlOLYbvKEVnKlv1XoBct7OOxCYAUYs36LjcDK7b02Sh+npzsqPUlzpBtPN+C+1dTKqmo/wpe3ORupDMEm1zNQzFQ7Tp2Ht3FHwbWOF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(376002)(39860400002)(136003)(346002)(6666004)(41300700001)(2906002)(316002)(33716001)(38100700002)(8676002)(7416002)(66946007)(4326008)(5660300002)(44832011)(66476007)(66556008)(186003)(6512007)(6486002)(26005)(6506007)(9686003)(6916009)(53546011)(8936002)(54906003)(478600001)(83380400001)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rak+v+X6wpxYSLBDu1VQLTPxDB2R6AtPh/dkKIqRc7l/bOq4LobbwGojJ9OF?=
 =?us-ascii?Q?arZYP3FK14cRC2yS1dd42Ds3ZbeqSCL6xmWKqzd/zWztZHiYkKfZZSWrPMzY?=
 =?us-ascii?Q?rQ2qicxDNAyU35efW9S7S0tfmWklQTSY0fwvV5GarCZZgtRSCCNHcJoJHkFn?=
 =?us-ascii?Q?bl+kEZ9q9lCp8SdC0FQq2MhtnpDhCJvPtnZu+iG0FZttin9tUByP8nEe2pWK?=
 =?us-ascii?Q?cUtnZQyiEP24cC67LCjI0kVXi/mcDf+g9nbYVfh2yG1HQYd7oUTiBPVABQBC?=
 =?us-ascii?Q?I7SYt1SCNTp9vyzFx7j+SxdSgh3mJhDSIOcRtvy4/+dHImXS4dlvmYVxHcSJ?=
 =?us-ascii?Q?ydYyOHO9cryW4+MKS1/eDn2kISALQnbRM5ELIRnBp3el48wAFk9IekdytyDw?=
 =?us-ascii?Q?e9hl42aHRwtNzIm0sGyXnL7LbBS4/AYkzyfuUE6erMCe7RHMRRcDgyKKe7Fk?=
 =?us-ascii?Q?I1HkOUerfMl9vOGkvq8hybQfSA3AQBWLsIGMKEejcOnPBppvOy00KBGka3or?=
 =?us-ascii?Q?NVuwtIPcE2vLDeQ6AesFCmIA/t05OU41dbsCVNLBbivUCJA8rfl2E3pWcVcC?=
 =?us-ascii?Q?LJq5PlpIsumHgfuy0yv7TvUNh63koDIsp4ard3pIoxan66/ZKbDtFd0F2IDv?=
 =?us-ascii?Q?HddyCPGKGe5L9mggCq0jR5AG8O4AGSPKSgZRGLyPKHPSLITbU0mxZHyPbmOq?=
 =?us-ascii?Q?9g4lEixtFfbmZ1pzWcdop8f7ja122aoKTT/btb83SGrPFKNxvcK9/RRNdjKY?=
 =?us-ascii?Q?HCxqYIMjl1w4jrRT+6uDRMB90vBUoEE55zHxEJLo0fvy0uBYC5/c0eRjBadY?=
 =?us-ascii?Q?+065kyh32HXO2F4eC5I4CQ/If5dtwy7P0DitJ+C+lQDOZczAEGZ6h/Tbaque?=
 =?us-ascii?Q?TDT6mCp1+yZjrMr+LOurD7OpAYFOWC6bLi8OoQBl9lYPuLjLFAkInzAMdwwc?=
 =?us-ascii?Q?XhYZCzw9NsAszYP8DDVD7fnxoUOSly5sdAQIJdFMI2wdulTuRKDTZvlLHWpB?=
 =?us-ascii?Q?1FM2n8eKwxXVv9ChHUH8VImv4ZhhiWnhUof0iRw7YYANa4KZtYwxTo8TDn0z?=
 =?us-ascii?Q?QxKizpn8kjQRwSzoDlheeRYG1kFg7sQpwnHo5HkLyIBwlVpJjPqkkpf76FFc?=
 =?us-ascii?Q?WC4/bmhafAvugKR5r8s911Vj6FdWnjBXZZAj/kKfQvfpwadJ1R8buD6ehBH4?=
 =?us-ascii?Q?1vC96+ls62UC8YBTBZdbK5FDv0o3+ZxUbvk1KRJdHrXGMQJ9qO+taVguq5h6?=
 =?us-ascii?Q?Eq+Vi5eqEFvzn12jzJWidOoi7kzLLrwoAJSS+fzGwfOZCfzfDiJU40IwtjAo?=
 =?us-ascii?Q?uqlQG4qGqemYEfDbUKZ8Zyia2FmJsn37H405VYEsTE3IBZiATOeo5/+QCR7s?=
 =?us-ascii?Q?AD4RMIIyjFChK9rnoo5tVpE/GUA/K/bv6Y5g2LYB1CixobwjkIjoSPRlAAJg?=
 =?us-ascii?Q?ufLrldUlNy5puikfISkGXEGVFRinvI8AN0NwOVgXhoVx+6G7w4tRgIS4jqHi?=
 =?us-ascii?Q?tItxumADlXoaeTdZlfnJcMp9uzdzvq7WhRIFONY/iSIfQtTC/cZ9/tb6GUYW?=
 =?us-ascii?Q?6FSPgRKioJHz2+/K7qbJmciVdbHjUyniqkt1OFsuA2f0SY6H9fwod6fuPOEz?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f29d921-e6c4-4b30-5029-08da5f9dd6f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 22:21:14.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USZqvxtfX3PV8uMmqB+tx+pQSHPsCmyhzFYJTpksrJFgjk4i0ukWfO50zAGUCdv1s5p1pMi4CCbUSI7gHW6wiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060085
X-Proofpoint-GUID: XjQhiFnIjhb3SmqE3blXbTUPifvTj-15
X-Proofpoint-ORIG-GUID: XjQhiFnIjhb3SmqE3blXbTUPifvTj-15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 10:33, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> follow_pud_mask() does not support non-present pud entry now.  As long as
> I tested on x86_64 server, follow_pud_mask() still simply returns
> no_page_table() for non-present_pud_entry() due to pud_bad(), so no severe
> user-visible effect should happen.  But generally we should call
> follow_huge_pud() for non-present pud entry for 1GB hugetlb page.
> 
> Update pud_huge() and follow_huge_pud() to handle non-present pud entries.
> The changes are similar to previous works for pud entries commit e66f17ff7177
> ("mm/hugetlb: take page table lock in follow_huge_pmd()") and commit
> cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage").
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> v2 -> v3:
> - fixed typos in subject and description,
> - added comment on pud_huge(),
> - added comment about fallback for hwpoisoned entry,
> - updated initial check about FOLL_{PIN,GET} flags.
> ---
>  arch/x86/mm/hugetlbpage.c |  8 +++++++-
>  mm/hugetlb.c              | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
