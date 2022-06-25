Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92DF55A52F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiFYAC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFYACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:02:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541A8BEF8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:02:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ONBSQQ025458;
        Sat, 25 Jun 2022 00:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jjvU3zvEU2Hlic2UblHZwCLYjgHTAsgf76b8lHEvXFA=;
 b=m3K4uIApsbVn+3UeFbvSF9E7GUjBKDF/F3L8lYSVsLAxyPuxi1KIDOlTuOK6J8/cMadN
 v35WSsiimcfK4uRFdYPNGahGl434W1IT9izyPH6FNVoXjlYThc9swQyjbNmUk8gJ+uSD
 FBIwBVP2YKewO/qu35dAsDiRqP5vEKsuc72ZS48f8rhPSrTgb4XXxv4IAyxCddyL1Qb2
 IubZLu+/TMzvJBdQJ4NefdTS66EgtspdUejohilb55iGO5SO+XIoCiZ1Y1qYIgwA8gjW
 SSPgjbsRdB9GJKCLbC5FFx2CtZupe3tG8ZCDyJTkeptEki8zK1CpqWg9662TvGAUXLGt vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cxt31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:02:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P00kBG014757;
        Sat, 25 Jun 2022 00:02:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3ys5v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WojK6AIJ22r5gw0hX7WZ2qpjNUrwf6Jh0Kue2bMyhuvESWKqgbpkV9mWmhUgjYeC9uz8KuYU09zN9V059gVMG6L2cifrK0GhUd1QLzMI7RYdT56Gl1PrVkC2UF0NjuRfU8DwZS3DOaeT5HXaLGjOca8cXDyOBJHnA0PJXiIwlGWKYNEV3cl9LUR5Duja4X/VHrk/seSe89vAV8jx0L+pkeS5ErCBpKRnFGv/ZGv25q+E01QMIGAys7EdrGnGNuneaTDeN53oKfaARqAlpmaryUYzNy+Sk1Wbs0hDLR+OmDCzKQm6NRZULlJ+yXrYfyuMEUs9zhcl6jSISvnfxlLynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjvU3zvEU2Hlic2UblHZwCLYjgHTAsgf76b8lHEvXFA=;
 b=e00Q0j4ul9chnwKuiCZbboLj/eHexs8mXcYn3W0RjABLQmnohBkWgqLCTqYlY6tQGmBnJLWKrKR6yJAiG9Qu2TJ+OoihfXAi98SRG8zvO2wVVZ3fXHYvLNBqsQlSLkfI7VMj+hHBX2jqIOffWNMqFcghAFYwlhw1anfJDxrm9ErevfvYZM86Mqgj6TlM85w+nu/Gm8g/P/jNLhs9dkGzmmSO77rvCBpZ9B7yM9eKmVjXlbEK8HSlUamtUAB1h4p/uE8dRsn1lmnyOmNUJkfaApbD8+syCFtF1S4NQnZOnEYltGliusSn3RBADHH2V9iLvWiWSS3LsHe4Vq7oUDLtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjvU3zvEU2Hlic2UblHZwCLYjgHTAsgf76b8lHEvXFA=;
 b=BA9oh363ac2g+QzD191VXG41SkfCt972xddkdEne6U8V4NL8BrPNdRIp5jMJx5P7G8j5rY36K101C4pFbjiPe3jvNPW3pvBpBf53BcgGdgfvpLWucRoHX6gK9W4ro04MryLx+uMTzZD0O+/B34gELWhADZQKi/zTKENQBBDvL9k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sat, 25 Jun
 2022 00:02:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.017; Sat, 25 Jun 2022
 00:02:04 +0000
Date:   Fri, 24 Jun 2022 17:02:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Message-ID: <YrZQeWnjQlWSjP3b@monkey>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
X-ClientProxiedBy: MW4PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:303:87::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7a9155-dac1-4c25-e8f9-08da563defbb
X-MS-TrafficTypeDiagnostic: CY5PR10MB5940:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/C94MTlYC6Hvw2XJsv1F0d8iND+ju+Z/FmU+ehWV8Zb8oz9UU7Mt7pMK+ynXiu1efHV+3Hn6A7tZsvJi+QAd5n9g567xqrWAGv3bRRNSHyo7HrledGFxYmAix5o5TYvVBJLzJO9pJ1cqBKhI8gD0kzPrQtnhduXPIzE/nF47ZFauREH3eVqSh5/abd995hM77n45yhp9I3IJ5FxJfDr9NQnKr73LHPO9SI7ObU7l+B/EjW55/uyzCshkwAr8v8lCoiWZNSyeUP74+Xp4uVD9qDR/3pMdwpEo1Ut+2kQ+OHqYgpbbmnG7L9yfVd4kCPcEHB9y6bLKkGOUxn72y8WcmestuCcag1ZJiyU3W8BMF4mlacqJuTphpWOY0p6JjO6sQFo3qsFaxbLgXNlLYDa2mZZ8ToHhiIn7TmLxVSXkYvbOJQOd+tN0DFpCO78NpoknQT2V7sFBWjROtAy4M6HumSISC/1h4NjHJR+axnw2l5SpHLf/Thr5AvuCFWijP3l9oZ5gVr/9pYlSbuNRvDN5pEhwp+qscReRPAR25m5G2c4/+KEFtuTdickGBJnfcKNtP6KSxw1h63C0h24b/sZKjhT2P7/DHHv0A9ohL9PKZOnCa+/m+NDrBs5xtRL2KRLtCjOLo9qqdIWZLFzt47twxhEEoE8rV4+jH5+IOLzNazkouWw0D3G2vRF7Q2aFRoK3gvv+9J7CVRit3cAyi8Fj+0JdT9gTFnOv9yw/Hyz19I/7l/8Ck/FhNwumBRrghO4YOAxAc1z3bCDAey17vnmlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(66476007)(8676002)(66946007)(4326008)(8936002)(6916009)(54906003)(316002)(44832011)(478600001)(2906002)(66556008)(5660300002)(33716001)(7416002)(186003)(6512007)(6506007)(41300700001)(86362001)(53546011)(9686003)(83380400001)(38100700002)(26005)(6666004)(6486002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHQfU6IhRcLP/vLIdfqs6R2i+Qg56VeNBL9l4G6eimU3T1UwqIslRkNrzK52?=
 =?us-ascii?Q?zz1Ca1XdCnZiCiuap2/4jXiw43nR/gVPJsUe3o35nEbnA5hTBWrlv6oVjd1B?=
 =?us-ascii?Q?SGzCp7qH3d81owM71x+ln9Z4mOD9GDaro6My48DlgKhKSBnr7FQpijG8bYVn?=
 =?us-ascii?Q?mEGotrvDQM3G3IcMqQJn34Qr73lT8Ru4w7rnNc30MYXA+NYDwADuUJhf3vOW?=
 =?us-ascii?Q?qjDukeCPxUoRzPig2Mccg+mt6t1u5sL2u10ZHqoTebdgfMcgneEOPlsyzJhx?=
 =?us-ascii?Q?BAgWLlVUSie0i72sLY5QUYUFCRA3T0i777RPkYxO8RtI9e4fukKZe7fzVEU0?=
 =?us-ascii?Q?w0DDoQzpRrHfkABMxfyoxmIuVVWwDgczSuVsT4phxlj57bb1VdxNmDba3+Hl?=
 =?us-ascii?Q?sa3eWN3B7EO9b/b152a9RqqOS5BhqkOsMzwaG1Ki4NLYtUkfEiFSxZoOZUon?=
 =?us-ascii?Q?bddBoFUYN83rnXiQiHrb9e7fjFOFwWWW6UpSm7ah16dMN3v+tM7F8J94tzgK?=
 =?us-ascii?Q?VXT7ELCepqONAK95z/CMauo19qqs/eHw64EevIXHRuvETvgsQwqFFXDWQ01U?=
 =?us-ascii?Q?8bBBtDz8RvKGIrYJ/uyqwjAl8S1QR/eh68YICQSoM6SoQSW6LnWn3Yl0x9ud?=
 =?us-ascii?Q?t0fm98nRYXhuVCVj/YPe2lZmCwhJXjKmfdmhOuw3Alk2U8jFgOxnp80fJxA7?=
 =?us-ascii?Q?qdplNCiOvN5IWmmoFFcZTlwWhXJIhuBpkC1D/sqpzX60hFOMigk9y57YTRwN?=
 =?us-ascii?Q?XoMk2N9HM8DDbNU896sIExRyWWxl7s4/Thnwjl6Sc+6EIFbtQwysVNMISVn4?=
 =?us-ascii?Q?Kv3gHWtRFbMjeOhYrh8quiTnrxYRhXcFgh+oT+rPkO/KLJnPTdfWzTWxFk64?=
 =?us-ascii?Q?rk3tRw1dHnMHz6UNElmo1pOlLBM2Ysxb/pCftiRdh2YAonYJaqhwyCUgr5Ew?=
 =?us-ascii?Q?y3U5tfUy1zG48ep2st6PqCKq0UgDJyuSs3FNumx+jOxgqiO5lc6sh5Hw7E+w?=
 =?us-ascii?Q?LFItQ2DsLCQ0gFTwsDmPqsJFktaQfJfdjg/5PPiR0LdNAeBqwEEzePPvTP1k?=
 =?us-ascii?Q?eNtRyP4xPfizFtpzEGpM8Lth27tz3ATM/TCByJjcX5hprNpQqL/duK5wyCw8?=
 =?us-ascii?Q?5kqigz6WbYJxPVbCeEtC0iVM6/Q1xCgACal1iNR5ECKlttoisP1glmzrhKB+?=
 =?us-ascii?Q?jBQVytgJsDMkYKUHPEGo+RH9ewafG+j17aLcYZ+PmglcI3RjXhNse4+3VXWn?=
 =?us-ascii?Q?hFqVX/QfuSEgYKdbcpf0R1pBlPcS/blyYrqylPmyfUMUtOKsLxpEcT7d22C6?=
 =?us-ascii?Q?a9BQVwbf8jpT1Lq/9BmBxLxkUF9twHGzGSqtdbVYOwue4svZPhbYiLXQKyXb?=
 =?us-ascii?Q?U7DYVO2uiYREPf9IJVeMJoDzBpOWAsifMWq50bkufwc5MDgvU2R0H8/N54EE?=
 =?us-ascii?Q?/HDeYYxjgse62r+LNpWNIb/qLCcAFZtI7VjilhVbwoN4dhfT7k6RYNI6Ne8u?=
 =?us-ascii?Q?x7iUTAyVtnixQ8ds/nGS0amSiwiZOcUxylWpluQvukUx4pC+NYhlcmyy3vKp?=
 =?us-ascii?Q?cF4zRLCbB/IaiXxyYzq8VHS3s/dSknuLO2Z4kyOH7MzRTtI0ByUzigdyu45q?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a9155-dac1-4c25-e8f9-08da563defbb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2022 00:02:04.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT/eECsMaj6O0w8smG3g7OrUWYlMSs2T0YffbSjtVncB9Zjvce0LYafZvG9cjhTrmhyJ7v4qu2qRydaezseRxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_10:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240092
X-Proofpoint-GUID: oEAx-cZtdfzK83e_t1I1J78VizWtpxHf
X-Proofpoint-ORIG-GUID: oEAx-cZtdfzK83e_t1I1J78VizWtpxHf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/22 08:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> follow_pud_mask() does not support non-present pud entry now.  As long as
> I tested on x86_64 server, follow_pud_mask() still simply returns
> no_page_table() for non-present_pud_entry() due to pud_bad(), so no severe
> user-visible effect should happen.  But generally we should call
> follow_huge_pud() for non-present pud entry for 1GB hugetlb page.
> 
> Update pud_huge() and huge_pud() to handle non-present pud entries.  The
> changes are similar to previous works for pud entries commit e66f17ff7177
> ("mm/hugetlb: take page table lock in follow_huge_pmd()") and commit
> cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage").
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  arch/x86/mm/hugetlbpage.c |  3 ++-
>  mm/hugetlb.c              | 26 +++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 2 deletions(-)

Thanks.  Overall looks good with typos corrected that you already noticed.
One question below.
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index a0d023cb4292..5fb86fb49ba8 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -70,7 +70,8 @@ int pmd_huge(pmd_t pmd)
>  
>  int pud_huge(pud_t pud)
>  {
> -	return !!(pud_val(pud) & _PAGE_PSE);
> +	return !pud_none(pud) &&
> +		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
>  }
>  #endif
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f59f43c06601..b7ae5f73f3b2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6946,10 +6946,34 @@ struct page * __weak
>  follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  		pud_t *pud, int flags)
>  {
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t pte;
> +
>  	if (flags & (FOLL_GET | FOLL_PIN))
>  		return NULL;
>  
> -	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> +retry:
> +	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
> +	if (!pud_huge(*pud))
> +		goto out;
> +	pte = huge_ptep_get((pte_t *)pud);
> +	if (pte_present(pte)) {
> +		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {

The call to try_grab_page() seems a bit strange since flags will not include
FOLL_GET | FOLL_PIN as tested above.  Is try_grab_page() always going be a
noop here?

-- 
Mike Kravetz

> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (is_hugetlb_entry_migration(pte)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait(mm, (pte_t *)pud, ptl);
> +			goto retry;
> +		}
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
>  }
>  
>  struct page * __weak
> -- 
> 2.25.1
> 
