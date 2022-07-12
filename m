Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E25721DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiGLRjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLRjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:39:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE482CDD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:39:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CGd7d8009805;
        Tue, 12 Jul 2022 17:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BjQ9ZPA1fmhpJgfx7KG6zpz+c4zZG7oBTfZuO+YidUs=;
 b=NkT9WzZhlFXPfhVXHqoY0AVmx4S8dojbisS/XZLVS6FpYnBpmezzPA8mNfTM9/U+vif7
 IR1Q0G82V3GPXdq93p1NhPSkFMbvKcmtkVqAHg0JeSKebtvVZVJa6jxL5tGQ36yBvXU6
 sxTK6kw72jtxc27cUQrkUE3Ai3Y4NJoFVbKmzWWqB4rE7/7KroJmqH4vSOFdRAooHOYK
 7ER+AuWFN82mbWdnPlB4GrB42AGkD1yBKfE0/yw4L1+O8KQy2rWD44xufYbDgLLyZSO8
 yknx42gEje/9IYEY9/UBcJMBYukNRa3D/jskHzuKmKVoBlsHc4soplifki3U3mwnllSI WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sg09f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 17:39:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CHVZOP037159;
        Tue, 12 Jul 2022 17:39:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70441h4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 17:39:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lwp42hd0hGDo24KSur46vOtnn5Yomz0omntycIIWQ1lZPYFyYXEenCMO+Ltz8d++/VNIGvZ8Qkyy2hvDzpmFajlgt+FGB/ga2NU417jz7lcXTvTtqilga+hkvkUqsNBaFVWFD+XqoQwBMO6jB6eYb20p/u5Slp3SP0Y2qXLv0wE0lqCCN/aY5UWebvzLK5Hps/IROW0oYxu86ajpQvfWT58qyB31IpFInc7/muJx/eUKXTDqal76Gchl8H4lRHcNu1+usLkRklPQzNQPlQTqu4Ly/nq2lwP0vQhsukEHCpIkMy13+01jqnQXlMEyco0Ln0e68raUlRDWM4mI+iW3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjQ9ZPA1fmhpJgfx7KG6zpz+c4zZG7oBTfZuO+YidUs=;
 b=UEk7jmgzBrONYizyhubpOPOpsFFXl5p4q6gtF+Lmk5FYI2699NAnKAl/Tsb2eJ3xhxkYr0sBU7X8YByVuUQ+Gi/OYn+YyYE2C7ETgb2UUu1rzeB51pOvN+UQW7hHzLx0tSZtZpZD0Rz5NRPxEl4h8p5NbLRnTt58cFlPeXcom611ghpygWillNWMJZv0xoE+Kw5/9icYTiu0uH3u1u/1Ds11cSD2ESBjIc7ItemNdBEoCE33OlFcoYAAaSSg5ht0E4DtyELgHbJJEMe+HxDsw7RkmZasfIwYG903t7rW/28zzfqxhoh/+H6N9Rony5QnaSkorY4OW6WRhURfLxBEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjQ9ZPA1fmhpJgfx7KG6zpz+c4zZG7oBTfZuO+YidUs=;
 b=wudo4mXq35MflSoPkdGXwtz8pN2sulYswBsJ5GwMgVyAQ/oXdNu4kcx1F7GuP32W2gduiSnX8u7Fh5D1ZKy4i+hQyhlVYBdu5dtcXsYhDU4hrXiNviJnetNVjadHnRohTKK6k/bIj2j344Iz2mzizXHP2V3C18whI0vksv0Iidk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1662.namprd10.prod.outlook.com (2603:10b6:301:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 17:39:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:39:22 +0000
Date:   Tue, 12 Jul 2022 10:39:20 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <Ys2xyCUnqpJt0eIo@monkey>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712130542.18836-1-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c571d1-244a-49db-e250-08da642d74f4
X-MS-TrafficTypeDiagnostic: MWHPR10MB1662:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YdD3KBKXQLLuC15ivp+pMONq7EWyADGcPuxDBB8eYqhyHEfSKXc59fIiREeQ1FHIXa89cDBlO5l3jx3XOmq2DBz2Etd7x9ZAvvlYGd1iuWeIPSB+sIN5SDyipTJIQO4nIrHPREztnU3lPD7HdR+2Njn4d/9tFVlh0WQfXlpjnSuUFPk0dqyjf+FaOq14XH/36cNn5JWyKIjLkTlOHuZb8FFHnGtKBpLe2fjOnau+Z5DIob8miktkPKLmpr7ozGb97wNTTGVSNQA8UE1PDrlpB0NMIAqI+P7KkGVDMW5yBCVjUmX1kQNlI3ISc/bH8RyOued7azUyBib1NX3sC/i3OVHiDkH+/eX9bmHO4CEU6XPEyt3+qdPDjORWFS9xZw0opF3U+at5XIJR3S3hkexzOD3Kqj7biakudQ4olGrtScgQ5hoNNjHWiJsr7YKEjd+mtb1fu+xjTQCBIgwW+36XoMTYHGFAX9vOtMEP8p5PiVbFPF3KWky+/ICZv3rwOGVpJnI2/O5dr6rZvZGEwQv1vFLG0tBG1gneeftt/oruKP2sIWN0gQ7Njg5jP48rdDlTKG1kvqt2OHbn/4ySfuv7a4ThNG41AyOetN3gowzrhqlGZ0Xkg/Wlj9cs7Mo1E9DwqGAuCNzC7WjVnFQh+EDIL9/a9oSIxz1ODiVsPAEa+G3WgKgcWAxDzf4pjdoxrTYlrtwLl8AGp36amPoW08iN+Ncklab3Gi/KhYE5uqkUMrhCtVhRIwA7+be3JGUcA1F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(5660300002)(86362001)(8936002)(478600001)(6506007)(83380400001)(6486002)(6512007)(9686003)(26005)(2906002)(186003)(41300700001)(8676002)(66556008)(66476007)(38100700002)(6916009)(4326008)(66946007)(53546011)(33716001)(316002)(54906003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EO7pX0oFRNfDps9CZjSJHBHWPlNmd3DjNhdKQumdEac6W2fDd9Zgc736WdFe?=
 =?us-ascii?Q?GRyeJhstJuMXoe83l0DxZX0o5hD0RMcw0+eWptu5PLYA2rzs8E7Bz6VRqz0H?=
 =?us-ascii?Q?IDvzl/JWbolovQMGm1PyNG8m7YCDrNxVTvlBYzwoa1jvxLAg0ucBgo40AEh3?=
 =?us-ascii?Q?rYUB5UGXz//B1zRF6pP0WOth9VRQdYy+1vOqMoFsFtqbf6vrP4LSa5nl2YQ8?=
 =?us-ascii?Q?DJ8vWtCJroGZL59OsEGehPpIlZf6YfU/edErAg0ooRS44B8csu89fO0KocJ3?=
 =?us-ascii?Q?iH9wzWj0zD7bbDfcQYe25vUGSIbljdJ9e+hb9uk+92fbXsMLHDtjoVLanjJa?=
 =?us-ascii?Q?Zq+JD1i3TV7JXXKf5z2SZUa9lmc5V3eVO0PQkGi5hdlDrimKmbed+kd536ys?=
 =?us-ascii?Q?HCkcCgjngwakPa7/l/M1H/BOlmGqpMmRCBuL71A7eDeByw/6pEFAtaRcTj2Q?=
 =?us-ascii?Q?hfyPipQqAcdbBGQ4nYZ+x4bUBMZMlJMtDtVo9HL82bJBt/S0bMXhAXOoLz5R?=
 =?us-ascii?Q?wJuBRc2O2mqlkYZ2XEA900QLxEGwIpoGAcrZLaHNag0jC99bPb8r2LMkKW3e?=
 =?us-ascii?Q?RmhQZzq0RNQPW206+KdoEhvfgRz6fQ4hXnO2q08wJqt7sdn8S4QhXooBvCAm?=
 =?us-ascii?Q?F4vQpXJeCCAJnWxPJKNILOauMG+LlzWbLxPw4DZrY+i0hDAobhM1eawgRf6D?=
 =?us-ascii?Q?r3aBGra+1aWauMO1Drl9Sfgd1dHfg57GbFQlZPZ4k37i7kjS89vDTXok4Ao0?=
 =?us-ascii?Q?t1Kf2pI58pq3lsq4KZAvBSNHx5ExBWPgiEA5r2c6GPLz5wnWTfU/cYmbfFN7?=
 =?us-ascii?Q?euDddFSMXPb/2GqYTlGq8Yzi4QTpOr22682W/wNixGhVoV40U7bxYcQqpaf5?=
 =?us-ascii?Q?J76Jtx7fYqPEenl5/mqxCCl2ePd1VoCBADmj3gGSkPgZIwRImhaoHRj1qVBa?=
 =?us-ascii?Q?txzpVvkWM0eeVw6FjXOAdxGp6Uq2/vNvcYhFyT2j33Yn33EXNDaKZsWya9nw?=
 =?us-ascii?Q?dwNXqrdikmpANWIBLO7gskwwZAd3WMt2ccu4izqvnfpn+QB5HBoEQ0PJz7RG?=
 =?us-ascii?Q?H66SF3Y2LwO9sucaGRpjvrN+N0uTio7vWzQXmVM6mLd3BhxVmaOdTy3gbuXD?=
 =?us-ascii?Q?ROzvDXWpvh5obfekjk7rqF8Uy5TmqNaaghB1yMy+Zi4UyJf2JPnjH7cgEMhr?=
 =?us-ascii?Q?7tfHff/ck6nldK2s02IndzXBCVnAOb2cBFc/x/2fmAd/IcDR+jzsOVgNqf7T?=
 =?us-ascii?Q?vJW8ed1En42hvR70r5pnkxwWLUCcCbswwdu2oKQ938EeFqHpoX31FVVA2QTO?=
 =?us-ascii?Q?zzL8QjzrVLrrhAmmfllFE8me6BkoOh5blU/udsQW5IwnUokun2RsTvxKHZE2?=
 =?us-ascii?Q?7LlVBuhSBgb/lWT8ahfBehrZavsUEuJD/xbc8bazEbTzJCPuvI1vmgW97aM5?=
 =?us-ascii?Q?q5SMxkq6261dViGVarvK4xG2U6sZlgoebPiyrdBQHneac8oTWdS+0yRbcqWh?=
 =?us-ascii?Q?IPe7AwntzeUARRIkhIpGyKOhkdzZxWZNzFDOmil5avov+5vU1S3DlNoL11jf?=
 =?us-ascii?Q?SIZtrfqxI3MmIGiaPE8xYC8blnpF02fFxh4OuuIzg9Yf7WRqNTfATGe7XX0D?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c571d1-244a-49db-e250-08da642d74f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 17:39:22.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzzA15jgeuYmZnbaHNM690YKoRqHTvgK0Oz5GNbuy9IKug7+1xYJtgaIMx0bd5wee60n2WEz+WM4lZgQ9PiPfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1662
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120070
X-Proofpoint-ORIG-GUID: -tJKAjEsDhNQc2obYJmroFMhIf3TiYyh
X-Proofpoint-GUID: -tJKAjEsDhNQc2obYJmroFMhIf3TiYyh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/22 21:05, Miaohe Lin wrote:
> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> for them mistakenly because they're not vm_shared. This will corrupt the
> page->mapping used by page cache code.
> 
> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks correct to me.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

However, I am having a hard time wrapping my head around how UFFDIO_CONTINUE
should work on non-anon private mappings.  For example, a private mapping of
a hugetlbfs file.  I think we just map the page in the file/cache and do not
set the write bit in the pte.  So, yes we would want page_dup_file_rmap()
in this case as shown below.

Adding Axel and Peter on Cc: as they were more involved in adding that code
and the design of UFFDIO_CONTINUE.
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8d379e03f672..b232e1508e49 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6038,7 +6038,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
>  		goto out_release_unlock;
>  
> -	if (vm_shared) {
> +	if (page_in_pagecache) {
>  		page_dup_file_rmap(page, true);
>  	} else {
>  		ClearHPageRestoreReserve(page);
> -- 
> 2.23.0
> 
