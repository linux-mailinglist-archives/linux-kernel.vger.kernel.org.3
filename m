Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02F54D398
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349391AbiFOVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349202AbiFOVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:23:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3526136
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:23:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHYAGu029747;
        Wed, 15 Jun 2022 21:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=F8JIYrkaVmQb4CrAG7kyqwPeqlPh/NVYD7B+L9Zo6EI=;
 b=BIS7R45Ymh0fHiBQ+OxpfEKV6D9yPBAi/ARZ+8M1yFWINGb7fPKL8H4tCW5xYkdg9F+p
 4zk/GaO0NQFwYU+iFThEO7+HrFDIOREeDk5cn0xcQc/fNdNDOP62fn1tw17ZazkAyFh1
 nWkBCXHIbYdKwbDOGNlRF1UNQmUw6K5xV72zdXfia04nEtTtT3fb7Mh4PBqxGNbhdKmy
 To5iAnJ5hpxAkqzxw33RYucV4GU5q94sVc2fHhnJovoFPP0QY2lxnZvz9jYJ0He1wCmM
 quRWhH0ARFvOASzWQFLSxPely1jMB3UcmrPg1hQcsGTRChacBCFczJALh1p0483R5Dh+ ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9hfmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 21:22:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FLLcop035727;
        Wed, 15 Jun 2022 21:22:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwbd7y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 21:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2u1rCzY3iBGzJO5V4RpsalgQ8EMoakdljn1fc022LwbEB4Xvy7Xl1PE6h9PPXrTGvIrNVcqBGnEH6iNWigmaMNqMo0NJPOCMqxcNBJ2HNMYY9Y/NDqrOTq2oxDhcz6iEqK9MPFZYGimDvlK/3rEpkaozY2dlMVmgs4Ct4Ev2d7DIYOes8vL0PETKda+Snkr8kd7LBQ6GMVmpyq2cB2ELszflxC+p3gsMv+fJLgZ5bZ0F8KQNG5wH+kXKSVf5dwUZMTOiHa1ggXqCwJ5yX2unjJI4kem6bE/e7kcf1hMiz0c5+jbpmu5OqCw3xxrYNDol0s9nCtNguc2BNZviqM8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8JIYrkaVmQb4CrAG7kyqwPeqlPh/NVYD7B+L9Zo6EI=;
 b=BQDn5QNinwib8utwMjL80RWhrC7Jug30Rz6V1FdxGX1Bfq0NjCzS6SygURrl0C5zqNAPDZHZZnkIcfu8ru3UbhsP/ncD19SoNY0qx3bBDKdQnxV46SAeOjxg453KZiUwVZ7vS+SEzKeQGXBH9q0cddWlnWwinfxsNfskGkm3REUmtgz945WqxsMOWU+5BLsVUvdWRE/uQth1+MPqRNloJiP9tfxUTGqkkoYn7GI5DJkp31yaw2/HxOLYBdcLKAiNcGb5J5kpNO8zmHMxIT684RLNmmnsJ45lu4WzfdQ0psrh82YXC6OIuSb4H0MZHLBhX+ziWaw5UM/v+8TjgwlhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8JIYrkaVmQb4CrAG7kyqwPeqlPh/NVYD7B+L9Zo6EI=;
 b=dvzG0nprhSt2+7Hfdql8GBkUAjz/mhFDsQuLVFdgakVME3ToKd6ofGP6hXWmIGhAJKHdnJoeEpZoPPvWygfMjGkxMK+wKnNyGtMBNhd6WLIUOz5nAuW+MBBxKVqjwIvIOFidTgoo3J4FY3pOSLy6B8ck8esg3OFk7QVeJBkWD9E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 21:22:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 21:22:37 +0000
Date:   Wed, 15 Jun 2022 14:22:34 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Message-ID: <YqpNmsLrbCowS1IE@monkey>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <437e45c5-c46a-46f4-f9cf-d8c2397c988d@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437e45c5-c46a-46f4-f9cf-d8c2397c988d@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea2a71f-6e5b-47f1-725c-08da4f152b8b
X-MS-TrafficTypeDiagnostic: CY5PR10MB6143:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB6143A39433B142071FF24044E2AD9@CY5PR10MB6143.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrTlPq/vHF0G9idtmJ1SRZaSur/HehucmynxOJfREUu1P93352QiY5XAlZjqtVYCqDztnG5JkRMuuRtbMnu08vSv+Io1qL++nQs1uG8lxe62KG4kz6ADzxdNe746cy6hyI2ftfR2tvBYsAkpaNxxvQJPxdvC+GtLNS5zWYY8e6zBN8+x5gQ82vnQuMmtkco6t8iM7AzvHc671dJ71xz6XGFXNlnvxWUH/OJ1eCkebjPYqg7XTSUGyA7aTAYPzhZgrhH5Mp5ynwGQz3kqjVe0dKKI9BC070lxH3e/Gs2TM80dSAe0u/CsgAQLy1hfRBYF7dPY9+NUrJ6i5RKolI3jJ8zMHdRiDf53UvedXuhHnpDtSotnQH40ALcYaqMmbJOJD5PncjJ02OBTdr0gulfddRZlPwMxaIzoq5fwfFeEhRzl8rWZIsKnnbrBJ8JMJBlsuuzr6w7M1ugwpQh5T7q84NtndffrYlwmufm6dQ2wtFjCFAl2MRj92OIcIi9yWSNDrLh5IEuLPrj49/C5NVYv9QlUi2dKvxws3JMuBAneGciUtdcvA/CBkHX0F0d1cXnOScqXKYQ1Ta1klywT3YeQy4VlTz0Bgb+4IeKa2uwEpJJPm4k5cRTaOWBMUjlt/yrY5/CXjKwrCQr2YFTNzwjT5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(33716001)(66946007)(66556008)(66476007)(54906003)(8676002)(508600001)(8936002)(5660300002)(44832011)(6916009)(38100700002)(316002)(7416002)(4326008)(53546011)(26005)(6666004)(9686003)(6512007)(186003)(86362001)(2906002)(6506007)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PH4fIS+wlQwK+yIU51GOYHaPdK3unjtQogXTrUx6AuEihJRayfag357Fr7B4?=
 =?us-ascii?Q?rxhdKpizrU6e0Z8MUwamXLr1b3R0OSIrLp3KE0bVqri7nFpnU596+IJY5MBv?=
 =?us-ascii?Q?o6GOPtQRUYBRYiJlXQtukrtUke8S0Tt7e20SCmO7Y34j9J/RDD6Yyawk/BAe?=
 =?us-ascii?Q?6yTpOifHQrvp8F1PVFpNnWcSg5ltx2dlPMf65zoGpeaAybUrs4HECtoc8pKf?=
 =?us-ascii?Q?veDboPfhQqhldFwsUxttt/raiXbeQSWBVX63K1yvikiR4nHc7wScQoSuf7Dm?=
 =?us-ascii?Q?fZHHOpjwuYmDYz4V2mN6DBXGaKTwy+m1TNVYN9qUTb+Rm5a3WRU402qNZisQ?=
 =?us-ascii?Q?7h5GI/nvo0T11SThcKg2lW7zKDXc2eeZFA8hMPs/Snx4j45B+7rAqZFY6YQO?=
 =?us-ascii?Q?EKQcmoAJDg9z6KQZjxFCgliprK0U4roV1W2SiiUSb/xn+qRxbLrvfbm7NLtR?=
 =?us-ascii?Q?6bhI8bauTB2CkG4U0ba7s8SUL9l8and9rAurItOT6Hdc2P7Neau91vlysxlw?=
 =?us-ascii?Q?Kz95qHESGZ/WnjI2lCuvJCdulmcznyh2LP53t+QgHzoXE9hll5nzHv64Vag5?=
 =?us-ascii?Q?csOr3x/z4Lz/j+eAOTaWrVmOVrFUXiMQegqapxpjll4mVjlBxz60OFr6oJiq?=
 =?us-ascii?Q?8y+pIB4IOy/H5kvvGcVhVGbWVsnUNGvBrV02jiRgNDC+B3Qu6cCyAlQBENEM?=
 =?us-ascii?Q?/LhJO9wywmwjiv46Kr56WZd2XNnyMWuIJVsliGjitYdqwQihtvvqQjf5oomN?=
 =?us-ascii?Q?zWdQdyTuPdmKSiRCJuLZ7PyU/3WBVORhTgLNSRWjb2ayWPNinidfJbAFq3Xl?=
 =?us-ascii?Q?FpMWqt1Txs7RndrL3DslYNw4XZd5lKUvgihSfRgAbclUdVaqIruHBwbQhdQK?=
 =?us-ascii?Q?jUDmJPGg1FSx+0WxXXUluv+z+HLJPOfU+lISlzTLkKxnQxrJBSThz9C+ttj/?=
 =?us-ascii?Q?jJb+5G+rQXGifppVtM7psoRzolP8xlge1M0XVUeqIDc2bSZsR5FIbOQQAgil?=
 =?us-ascii?Q?RCZSlacS/t5R4Bdp8aPwpCFbT5KfdwMbl7/v1mG3whDp4rH3fIQivt8HevW5?=
 =?us-ascii?Q?XSaga8J+8Zn15w6BeSkaoIpgw5oMXCno7XD9vJKZnri/J3IhvpiDBpveJDPy?=
 =?us-ascii?Q?gw1ME8M2GPz152U1ybO+UxuWU5OesKVXpbt4v8zRI9+X2/fAlxzJAW1MEpZr?=
 =?us-ascii?Q?3lqc62/bNYVNpqyCx/ahwIe4Y5A6IgX/7A/eyI2Uk6yabbzrD+VsTbRBcIos?=
 =?us-ascii?Q?a+6+yodEOWxNacXec8A2jSrlcs/WrSGc1AkxiN2uk9/IIPIYKTKklSNwF8js?=
 =?us-ascii?Q?Ks7+Rm+YlhsnyA+oYgREtv4jtfHXeXMG+lA9H0iMHeu+7VGVyYaoaMPnYIrx?=
 =?us-ascii?Q?BXHnT2Y40O8Wrj6DLGN2C7UYhnh7k0e4cZNDhGsrSijgYlyDW60m4d5mZ1la?=
 =?us-ascii?Q?6FZzqbNb4c7xd8JIWA0Mz2FgGq5EbT2p2Vy4lJZtPbu24DUcJXmec9ZwEbhD?=
 =?us-ascii?Q?KapobY6uNOrCTTTf2w7g52F4cwQbCFBJqGTIDV/svRieiBSVyTDOBbeHWx+R?=
 =?us-ascii?Q?3MYq5XH9Hq13VKpwMACTkLXH5fQ6hlhw1AxKquOaTao3VB60NpHdqpPeANu2?=
 =?us-ascii?Q?BcTW47exMS00gmfQ31v/I2mOiJe4iktOlC2VrSRTUKSgArPhR7t9PcQouD+B?=
 =?us-ascii?Q?zRBnPWzxZpZSZgo53oyjlg1jFIQTrprPSO/QaDdXzeepMUbYrIeffZMuN6dM?=
 =?us-ascii?Q?7MTrqiPM4Et8lSB5Qz1vH2EuyHlLZ68=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2a71f-6e5b-47f1-725c-08da4f152b8b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:22:37.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHGvMlOti9MHwXgqGVjYOEyW8UK41YYPDuatWWPG3PRmo+/L9qtNYaU9jCmtXkyWfvx9972glDtg27++hXpEJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_07:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150078
X-Proofpoint-ORIG-GUID: o2wpD86B-g2YzpTQCLZJvwiGfvNw_z2q
X-Proofpoint-GUID: o2wpD86B-g2YzpTQCLZJvwiGfvNw_z2q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/22 18:10, Baolin Wang wrote:
> 
> 
> On 5/28/2022 6:58 AM, Mike Kravetz wrote:
> > HugeTLB address ranges are linearly scanned during fork, unmap and
> > remap operations.  If a non-present entry is encountered, the code
> > currently continues to the next huge page aligned address.  However,
> > a non-present entry implies that the page table page for that entry
> > is not present.  Therefore, the linear scan can skip to the end of
> > range mapped by the page table page.  This can speed operations on
> > large sparsely populated hugetlb mappings.
> > 
> > Create a new routine hugetlb_mask_last_hp() that will return an
> > address mask.  When the mask is ORed with an address, the result
> > will be the address of the last huge page mapped by the associated
> > page table page.  Use this mask to update addresses in routines which
> > linearly scan hugetlb address ranges when a non-present pte is
> > encountered.
> > 
> > hugetlb_mask_last_hp is related to the implementation of huge_pte_offset
> > as hugetlb_mask_last_hp is called when huge_pte_offset returns NULL.
> > This patch only provides a complete hugetlb_mask_last_hp implementation
> > when CONFIG_ARCH_WANT_GENERAL_HUGETLB is defined.  Architectures which
> > provide their own versions of huge_pte_offset can also provide their own
> > version of hugetlb_mask_last_hp.
> 
> I tested on my ARM64 machine with implementing arm64 specific
> hugetlb_mask_last_hp() as below, and it works well.
> 
> Just a few nits inline, otherwise looks good to me.
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index d93ba128a2b0..e04a097ffcc4 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -376,6 +376,28 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>         return NULL;
>  }
> 
> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> +{
> +       unsigned long hp_size = huge_page_size(h);
> +
> +       switch (hp_size) {
> +       case P4D_SIZE:
> +               return PGDIR_SIZE - P4D_SIZE;
> +       case PUD_SIZE:
> +               return P4D_SIZE - PUD_SIZE;
> +       case CONT_PMD_SIZE:
> +               return PUD_SIZE - CONT_PMD_SIZE;
> +       case PMD_SIZE:
> +               return PUD_SIZE - PMD_SIZE;
> +       case CONT_PTE_SIZE:
> +               return PMD_SIZE - CONT_PTE_SIZE;
> +       default:
> +               break;
> +       }
> +
> +       return ~(0UL);
> +}

Hello Baolin,

Would you mind sending this as a proper patch with commit message and
'Signed-off-by:'?  I would like to include it in the upcoming patch series.

-- 
Mike Kravetz
