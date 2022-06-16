Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7754E8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiFPRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiFPRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428B1263F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:37:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFqaBi029748;
        Thu, 16 Jun 2022 17:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bwBguB5KvaAKS/M0RK9Bqwk0R81NzEp2L7b5GzHEGXE=;
 b=Ot7iuoz5LLKQWtm9xl5khNP4ne8GAjhx4cAFYhV48sk0N+ub6qUrQ1vWLUUvmOwsthz1
 SqwtcoNapcgbHyfWsqcoXixkUJRQhL1SIGIxJ64Wdo++al+CpfU0gHxfZOPiD44t3EjJ
 RhxZtYQTQXwZ54c7rN+Xi9N53eEr0lWqPsbpe4DsL/TH/JIkq6C5Ijvoc99PjG61h8/v
 YRNPkePBd30E3bc2fH92l+vpC4Y8DWW3bj5/RJStJX30FhVl1iZMA8sbh4zmWbMb8ApE
 +KgiFL0ic5fpvl/eD5fJ8V1sf+n6Rzt1lBUauBplgvHwYA4dtj+fO4slEWl+3mVUE/x6 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9kp9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 17:35:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GHC8HG020535;
        Thu, 16 Jun 2022 17:35:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwc9r15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 17:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6c/Hb8FkOLoVgjY55hTkjHf7UsZpytg4R6QB6SFE5g6bEHr78qcNXfpgtCRGHtjFvj8yl7r9AR6iJZbClJwm8Qf/8a2pAjaGbvqhIevwyXgVoOIdlRE1AZPpgIT2Xb1USipv5pQRHEuo10Pe0W/CDqj0TKh4YExxpzG7jJQ0RBiPdKursLMKoNHHQ/K7aXLApvZcFoQ9rZKp+Ju064fX+z1iFyH7SiLOyIrp3B23mjaOz+UIBeNh2oeZPo1kYxTX67EBoEowcZoK/LCwHy1hs3rZxMA5p1X8M05W0yL82eZMiKmUOElY6NApBnEZRnSlmKhDDgpwHi+BIBoTHKgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwBguB5KvaAKS/M0RK9Bqwk0R81NzEp2L7b5GzHEGXE=;
 b=HjDegHbXN1TlpXNY90R2u77obHqtPpvdnLbNvNT8RUYZllkqfdayC22CPf19vAR6Ln/DimlT1ncfV1cM5d1w+yXWcb/SrS+EI+1bfV0qwSLrvLFG/O+KSjElOqfMGTVX3IalAGyDLjB99/rVcKkRt/jrFfYD6uEBhBPk2vFB20cXthTOsxjTFguOmY+oRtK/UjrqIjU11huZKCRpFAr2HxmxqYwO/n4Ur22AZ3b7l8DQROhid2E0pHIgFWgg4eu7fOlYhOcowbuSO93qisp7OLsiqwdCJNMlih13KH2BQKAZ6qCDiTAcSsPY5u9sK26B1mt7ulifewKcS9Dj5QGyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwBguB5KvaAKS/M0RK9Bqwk0R81NzEp2L7b5GzHEGXE=;
 b=BVaOik3xrOiFluxdnWfMzSiAxkKi1RUGhWugN1zESxyyuvJ9FdblMMKVp/BKyOL6wgyqKIqndsmFauEnNyLHOyhyIx0lS21mMFBcVFR34kLLDOdS8ss8X0MYxy9napM5CX5dz+GNIe0JvT3GBgi0akkDXC+F7oI8CPGvC8MIbp8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 17:35:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 17:35:25 +0000
Date:   Thu, 16 Jun 2022 10:35:22 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm64/hugetlb: Implement arm64 specific
 hugetlb_mask_last_hp
Message-ID: <Yqtp2hA+5pRiFskC@monkey>
References: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
 <Yqscbw0l9dL9Eldd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqscbw0l9dL9Eldd@MiWiFi-R3L-srv>
X-ClientProxiedBy: CO2PR04CA0155.namprd04.prod.outlook.com (2603:10b6:104::33)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7e138e-8d69-4d1a-40ea-08da4fbe98be
X-MS-TrafficTypeDiagnostic: CH0PR10MB5260:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB52602E130FF589CBD88D755CE2AC9@CH0PR10MB5260.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kD1TSfpsaHAQPSwi/U1e9u6i8oFaGXq+dCyOR47GzWClILfjerpffi4jKxwgzWTPlCK144UoJI9htcmiD2SILxlkYhX5g/mA5dcz0KLzV/31LV3OAbhpEHyHTfbWiOzYnl6W7iWRdjmP2LkLuruuN6C7KGdnaeqcsx3p0KhxuQ6/40VrXoymO90MjbMSDmbS3iHkETpH2Ocg/Wg/Lbrb78CBkKFgwfR8ER0FurhCZse4226smtrUtOFrtQhizNlHuiHluEp+KDY/jjHnoVXHjA5VLRm/n+G6SAYpgkW1B3x6WwC3zKWBPcIwdvhImSDFycJkmaU8tXx2lxHKaa8gR3tWiXeU44LEqoZohewYJ7r2Xz0EUkw6QT3eq0iZKPpo92ss0B7EqvekW9maFKxrkOZ+DHM/wdH2OraDcAzKNinTxmqMQFxf9VGyx2MWvLJcNO/6OFpiGM1LqWtexMZU4+Htgvja2bQ4DhxKRrFJyB94gdUImdxUNR2Su9IjVY/ZvYJQy5knMotOuhIxmGEXmM9oGn4fsiUY4A554FqkwCzaMUN+eXk+m+v4thKYYjfYHEQtBqWS4J2SzIpRw+6vz1hiCzbzBuM4dP7xxjh8b3xElWgpyIQuV+8E64MALXTXvgRFTjg1F+WBU0fky+8R+t+HHkmkwZjjn/PKz2mn4qf9NDpsHC8I89lXEMLBLhb5i8x4HJJ7KBU3d4kMvuaY2sX7mWOIWfMfo/zUVaxtkB6Z0yMACW1OA6Qol/H5KUhEIgMARsiYMJcFcUklNv4XXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(2906002)(508600001)(186003)(86362001)(26005)(9686003)(6666004)(44832011)(6506007)(6486002)(966005)(6512007)(5660300002)(38100700002)(53546011)(7416002)(316002)(8936002)(8676002)(66556008)(66476007)(4326008)(83380400001)(66946007)(6916009)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCffQUG+Jb/WoPNRyIGmK4qZeXxDBg0wRGU220m2jp6hOiKGfoWz7mZtU8hY?=
 =?us-ascii?Q?dPU60J7RlnCvNY2d+8EJva2oS/RtLUMDVICnhR+VKeHoU8xgUGCwWMmUDjlG?=
 =?us-ascii?Q?35qxd+6UFHmUxylnqQXRQUQ5E/JxRQkfWSLQibKcgfd+3egIjNlw+Zh6Hooa?=
 =?us-ascii?Q?rO0sAoxrFVSts+XzPQs8feAGKQeMheJZMD68VMTLA1QbWpYw1zFJqLx5Dch7?=
 =?us-ascii?Q?nRU5Hgpl3415F1tNWPpaj+hK99DQyNzPA8Zezn2iLmxUFsiHPi/mr0mz4Sfy?=
 =?us-ascii?Q?BgNXuEzpMacUtYHZW2T1SzJ3zmJ6GKs4g52c4CdIckqVH6SR9xoCG4eInwe/?=
 =?us-ascii?Q?EeYoAvGjAJzMuf1kWOxzF1FYcvFES1sAeUJHjentwIdIx0m/gvJJZm92CHyc?=
 =?us-ascii?Q?is1smC8k5ZpRmlHuhmExP2r0ZrT/h99npEzGGHv8xNLVcwJhctLq6idjmRKj?=
 =?us-ascii?Q?DLMj0dXDAm0GGlxd/XgLJdVvN67gr8/pj1Ziszcdn2rrjnLD48eykHq5iNAk?=
 =?us-ascii?Q?RTKNLj9uzWM5ZHX9HE1MXxsvw/SxAyjYc9V40wgRi4uysCtuOb7zYBSus8lV?=
 =?us-ascii?Q?BZooSqHFZW/o4jHNUhrtT/xKuZ0gFWuAo7FwjCUI5D+iFioU2WfuPlAFSDF2?=
 =?us-ascii?Q?vkEghNHaUWGO8Qx4yZABjHam370mfgnG9fZ0UPkbdP2flohGL2SyskYnac7J?=
 =?us-ascii?Q?pMOj6Cw9MVwAmUqrqQDMG6jToJq1TVYZw+5QW7V0BPKSvJL4HGRn4bODKiSq?=
 =?us-ascii?Q?niv3qrZq2twH63ptBN6qCBASErkuT2kwMDaOjSSyMNLT/vqomFwkBAS3c7pJ?=
 =?us-ascii?Q?iSw40Ub5uaF4zcJlrtQ/epxuZqw6EjHcWLzKhOREdFL8CH961yWTNPQY5nIr?=
 =?us-ascii?Q?kHSDo3Y/xUvSyTY3IZS0CWtaq1oDoeouIdVNvfVxuhd0+M8LOz0s+X25lVok?=
 =?us-ascii?Q?J5uiXf9FWI4PnC9Jya4ECQpU0ZsAp8zBIuN6m8bkFj9X3F0aGzkzdLw/jCSz?=
 =?us-ascii?Q?tyrd8jswgpk4WF4KY6fjMnSQPR9owt63dj0KppG2XKckpsv6qh2Xs/ufQ39K?=
 =?us-ascii?Q?iTDkyxHS0nJhSVbeSP3DWJbzbstFxZFsgzpAAX7mdBQTug7RFC3XFzwAzpDb?=
 =?us-ascii?Q?rOlUVnmVsPivf4fXak3TivlSjdRitzkhMOmOImrb2EiMP8OzxLb6xALgSpNo?=
 =?us-ascii?Q?B0wwbam+giKiyo7CiqPfJ6saat7HvfxvWwbSprs1CDR2orFJBES4KLePEzVn?=
 =?us-ascii?Q?a9Er9hHS0naqZIYPrFdrA8q9lmuuGseVLxIJaCVKnpZbv1Vg/I/ziehesDlt?=
 =?us-ascii?Q?1EubDhsYO9EBzNVgaHL3/UQBHWjLLncW1tYL7wrN0bbt9P8HgLwTNPxLiB/Z?=
 =?us-ascii?Q?N8uo1mNlu3Zb0mbsfYriO/dKsrhTOd2Oy6si2WSkHmDVyvMQKa1mf0HmFLM4?=
 =?us-ascii?Q?a1gN2wPpm9qNZjAOQ76UOq/2MxeLJtXJHas3KxXCXANqkI7moIrPKc6mZtar?=
 =?us-ascii?Q?z1jaJvOyr5kJfjcOloo/IpThJ8ruHGI/xa8ehPiTRfbK3jItKYWkh8juRsOO?=
 =?us-ascii?Q?nB6yF6uZGyUsjQfcT0ivMBCcnkZrPtmgl9RgrPq4+TuBrzirVm18FNgMbHPI?=
 =?us-ascii?Q?TxeBzT/1edzX+bdA3u8fjQWpXEz+MRikHyXBV4paXtg0iwC1CSuhgA+O26XK?=
 =?us-ascii?Q?G6eqdJW2zC6C90UglHHSQMe4NyjKYDbg1IpL/p8ZlTUMTWqDPrkK9wZLpZ7b?=
 =?us-ascii?Q?JN4h59/QUpyIXqqope887V3h0PUGKHQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7e138e-8d69-4d1a-40ea-08da4fbe98be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 17:35:25.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH56k9J37nIRLGGyOlva8PEz/jKufM4xWsUuoRcQdig8FWUhEYNfT0hbW5q324i2lqpjw5LXqQYF6jrGxcsrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_13:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160072
X-Proofpoint-ORIG-GUID: o_k82QBJhUwUWBclHMLThWF7B66HWJ3q
X-Proofpoint-GUID: o_k82QBJhUwUWBclHMLThWF7B66HWJ3q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/22 20:05, Baoquan He wrote:
> On 06/16/22 at 11:34am, Baolin Wang wrote:
> > The HugeTLB address ranges are linearly scanned during fork, unmap and
> > remap operations, and the linear scan can skip to the end of range mapped
> > by the page table page if hitting a non-present entry, which can help
> > to speed linear scanning of the HugeTLB address ranges.
> > 
> > So hugetlb_mask_last_hp() is introduced to help to update the address in
> > the loop of HugeTLB linear scanning with getting the last huge page mapped
> > by the associated page table page[1], when a non-present entry is encountered.
> > 
> > Considering ARM64 specific cont-pte/pmd size HugeTLB, this patch implemented
> > an ARM64 specific hugetlb_mask_last_hp() to help this case.
> > 
> > [1] https://lore.kernel.org/linux-mm/20220527225849.284839-1-mike.kravetz@oracle.com/
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> > Note: this patch is based on the series: "hugetlb: speed up linear
> > address scanning" from Mike. Mike, please fold it into your series.
> > Thanks.
> > ---
> >  arch/arm64/mm/hugetlbpage.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index e2a5ec9..958935c 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -368,6 +368,26 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> >  	return NULL;
> >  }
> >  
> > +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> > +{
> > +	unsigned long hp_size = huge_page_size(h);
> 
> hp_size may not be a good name, it reminds me of hotplug. I would name
> it hpage_size even though a little more characters are added.
> 

How about just hugetlb_mask_last_page?  Since the routine is prefixed
with 'hugetlb' and we are passing in a pointer to a hstate, I think there
is enough context to know we are talking about a huge page mask as
opposed to a base page mask.

If OK, I will change the name in my patches and here.
-- 
Mike Kravetz
