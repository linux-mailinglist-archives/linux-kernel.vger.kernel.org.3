Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49407535913
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiE0GLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiE0GLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:11:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A8EC321;
        Thu, 26 May 2022 23:11:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R5ZdRY001684;
        Fri, 27 May 2022 06:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YdRWQw/IrXF5mYQgG1SdGaHBNgMqXKQS4CNHg5LizDg=;
 b=xfqcpLpuv/Ho/LtCoOMFN5tYnhwRgXW9587PnDrxrl7Cmiqcf/F0iylnTGOCAQk3snch
 kry92eYHBtVWzm6ZR28krA+jx5iLJQFVkEYQaL9AIDDXnkwBYvGW+Z3Hh+6rMrGWGTfj
 Yr6HSTlUhmmlr1OlQrzsu7s0vYVwoxbT4YxmyDI08N6OV5ymN9Cr07it4vX7L+K4d2lT
 IouKrUGHyIp7cqQF//nDqeOeiMQyutj7v6LCYoMfKM9DvFqO00ALcXY2W9LR+neby/2c
 onQx3EWrNnQXsWfqz78/3B3ZAligPx26BFdLi9M3daAz2sMGGLLAWo5GTpS9CkQArW20 qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9xf2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 06:10:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R65d9l030987;
        Fri, 27 May 2022 06:10:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93ws5bgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 06:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrWC4bFuaay/7fCAiBnXWD7G7GNSbpR5FkZekiZPwPfyJM9FJbt5dnlgNKYbxrRv8DLXep57I1ZzDplhc04/FDaZI075co+HBtFgiDwKa2eXJI2GcdR7iajBvdVEZyhybiBVBJ11gyoCJTLu3qaaA+Gx3T1YLe6qLrx6BXef4oEbv6MVAaOnkUZaaa1hF++t/n2aRCE4y7GvidJGKhv2kbSaKjlCpsxgj95OLlkVtYJFUhTacfCdq2ynNu0FqvatB2bxjTHZf5PdQLDcnt3OwwiM009XznF2K+s8GK+uUeQl91vQDJRsp11rNkEJu5nv9L8yZrB18yzMZRNBBtVUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdRWQw/IrXF5mYQgG1SdGaHBNgMqXKQS4CNHg5LizDg=;
 b=EObVHZ9lthhFLFaM4g74NyUEvipceD4WxEycIljEpntNZs+EVTo8rb8TxA9ZL2NLnN/76h6lBTmKAciFuxkbakAywpERXWXZ5D52opjO9oeH2F3W7OtKp1v1S7ZwNkjC3B4zPSO/naWoJq6H6Qt8eNdYzW8Wc2NSOTMkUh99mCV63Im6eeyia5dK/XqiRmwgb/uGNDNGCqcbLqJqmCQKZ29W1W8lcrnsHJSaw94VneZtl0gXsx+R9YxvcbJrLwKBv23w1EdEdsmXsGpf0jplaYdg9CuznIyiqJaLtZ9E45sS2S+PESa9N5DiJTWzCPhMGmGCICLmiFJBPOLUQVlCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdRWQw/IrXF5mYQgG1SdGaHBNgMqXKQS4CNHg5LizDg=;
 b=vOJZ44AOGYq7O5QgQ/cdIHyX21ExfKRSaxTKLP+rs/Wy/rR/udySOrMkz4QgU+CmAgkgV+t+h+wYdyCVj2HSfILARDxQLQq0+4xwbyZhdBNHdIFrgQ76LbkFSKWxowKbIFZoJplDKxx9u4n/0LbskY4y0a/QpSzM+Zq2pkH2Oao=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5645.namprd10.prod.outlook.com
 (2603:10b6:a03:3e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 06:10:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 06:10:29 +0000
Date:   Fri, 27 May 2022 09:10:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] sched: change printk(KERN_<LEVEL>.. to pr_<level>()
Message-ID: <20220527061007.GJ2146@kadam>
References: <20220526091031.3741819-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526091031.3741819-1-yuzhe@nfschina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a06fed-ff6c-4a6d-fa24-08da3fa7995d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5645:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5645E13F403CDD6449623F2B8ED89@SJ0PR10MB5645.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBQJctH++LS5WSytWRYuOOGKtQusBKRrDB18OD42B3gvkVL2gNUdf4HctZJSlvFWzev29jkAmFE+9s17A2/rQyq0M+iodXGlsI3G9+Yqb1n4g/5uxh4VL8DoZwLxGs3k+nML9p4ayBDefvsP3aaJpfFlzxXV61MZWWzIR3ssj3/+AB1PzQtb/YvujsSUYOU2GDGD+MpeRWYJdYZfvVcv6akFS232frqC6R6eH0cbkEweWBJxdMcRFmxYOyzrDNVXYCKiiek3xhiUkfeucSXYFtoinyF2/2uo4+odbWzn1BXNG1Hm7S3KVWnQ8plumg2pDeyc0Gcn+BSxMYHYz0XiYiTl4vmRE4MxgOUP9uX9FjaJ758QyLHO+Tm5/Q5lzD9KFDegOMf50wGUf1Zb9q+m6woBCJ46fFBjxRdXLAyh69oLIuiNwI5yjoDFGN2ynN38IlqGGRAKiZVmrv9FhwM9OVp7bhWE/H1pQwRuMW437QxdhdLlhnLev0n4Vmsxz++Gi4LctKBElffcSZGyj2onBG8jGBdBIr9nmX1RvIIrcZG339IIzCZFxLmJNWNaFgydczgxBXNBj/f9oaDEEuNux5HIXMurPzfcAwTfRIQJh4Gep+8AOhFiaO/OWmrXhhP69xwb0mMqaz/iaK5dJOTyb0VEhdFpWDH86BdMkTkhwv4qFC7/c3WIIfS5H3vY0Hpai9yKTD+Oox1eq4gcaYGTyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4744005)(7416002)(5660300002)(52116002)(6666004)(508600001)(1076003)(2906002)(186003)(33716001)(6486002)(33656002)(44832011)(6512007)(9686003)(26005)(6506007)(83380400001)(8936002)(38100700002)(38350700002)(86362001)(66556008)(66476007)(66946007)(4326008)(6916009)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4n0mTVyF8IOgx0PUSDRfHhfqgHunopGFWG5S2arhD/aW/tIVdsZFcC9j1wzb?=
 =?us-ascii?Q?nwHmAtwMZ5eqZuAjafEkxF89ckwbFZygEWPrmvyEQGC/wnbcXduE7ArAUGwc?=
 =?us-ascii?Q?PlGajynGA2YFwERiLEyrBSiO2ItUDoimTaTtlngGKL6fbszRQsStRQPBfCI7?=
 =?us-ascii?Q?xVTWXDgRyrx54W4GfRE1bRYwhvFFtQRVf22WjA/S6zjvIa45btXUemBDzNGM?=
 =?us-ascii?Q?CpoY7HbwQjS7keBsltuwIlk++VOpObLd4Mmp3NXZaI9myYrcCnweE4GtmrqK?=
 =?us-ascii?Q?z4i8ihNmYmnC63oQz/aC4RdidhBY8KhbXnuMIrIKjNkh5sFI935BMYFBEdiU?=
 =?us-ascii?Q?1nxrrPsTX2Fv3lNjCT0/R883BekzRvnIpntJXFUuf83Je+/MTbS6T+NVDYK2?=
 =?us-ascii?Q?yM4ulrsfDafT+HQHR1TrBFJC0Tp5A8cdllGJWyJ77TeXggOj6PMgPgZ3xybY?=
 =?us-ascii?Q?zyk3aUSjgHpn8Tla9Mk/VTIbMv795oeX6IPumSVcq9Qp8mYBy/ZerQ85+1Yv?=
 =?us-ascii?Q?GfS/fGBCmxScfSMuZfIptHrDHEYYkoDuY2rynphJooVowdQzJqm72D2rAzXQ?=
 =?us-ascii?Q?63ngEtGWCsRvtILmM+XvR/lumQfqec6SEMtGKYtBmqZbE0ANBeLBCe5SZxml?=
 =?us-ascii?Q?PHgEpUqe2kkIvGTtk2vQDXqsOAXCpvx1T7rRFWM5avIZ3rIrWAC+Rjzh5ldR?=
 =?us-ascii?Q?lRBHyR96SFWvrhmz+jHcahg+b/tqpLCfCohUKUqI569EDUwVx/80XdD8sE9Q?=
 =?us-ascii?Q?nRAwyAND8h+q5LkGJ2u5C+Iqjt8h25BopAR8WitP4GHFWp9JRmi4opYCgt8q?=
 =?us-ascii?Q?2XUEEaqFxrsjIHliOC8h/qy9qoqeO9Xj/OusL2pUuZxmW1EoHjYZgwhCsbpg?=
 =?us-ascii?Q?UiiU+uIKkr3wk84YDHXSp2NqdMBJAIKSvF1Y6qp7SAqKM+0hGkuDspWReBDD?=
 =?us-ascii?Q?dkHJAVApKPOSQjO51Pnr8JRxStwIIw82w/PrIjSBJ9ZBDNvP+mjVX4g67Z+s?=
 =?us-ascii?Q?UIk6CrKHa7mvEYvf6xVzTMhQ0SgUOEhKm+DJnxyHA+fg8VdISomO1ltlCq+y?=
 =?us-ascii?Q?F0mNT6eB+nppRG83qk6fcT3ru2yb2jvfxhXCiw9LRO8C6AfiSM2mF3RAaXt/?=
 =?us-ascii?Q?ygwJi1sMV8Ywq5C4tvdlTuZrx/jgG57qOSOwWWNfFmtzxwFKcCoSlBrQZ3a3?=
 =?us-ascii?Q?tAeyQP0dQBsoe/2n+fGmayX63S2zWn0wrDFN9ke4XFalb/rZBcnCGejT1E4W?=
 =?us-ascii?Q?MPmyoaSfhwDvfQW0Dw8ggfqf1H+MYcwgFJ/YStYvp7HadTsJc+lnf+2lFjBD?=
 =?us-ascii?Q?1XNr4At/lJ+qw94dQNHsE5NmvTjoH5m+aWbesQkdZdUQjlBLTGwHLxevf4Fn?=
 =?us-ascii?Q?vCCcYpQAeQxrspGAuvch4WHWbpFEtzl0N3uMJPmlABW0p+QUYm3XanBJKFmH?=
 =?us-ascii?Q?xuPl7SZVVgAwmNf6KfyxNvVmDyqAU47WRLbYOZE9t/uH6OpTAx984gA+aftg?=
 =?us-ascii?Q?ITBEhWa+GNH7SFFcfnEI4Ep7fkPbfhoxJoP7TG+z97mr3RW4OIlJUD7gXGjq?=
 =?us-ascii?Q?PCYTWtuC1QFbjKHXVoS/XvYEm/aTmnNyILtfBQeeGquRH29aIZA5gdueCcfR?=
 =?us-ascii?Q?xNBx0SlIxZOvW1BjpBYISPl0iMycS4YXWOlVV1v5Xmdiqcj+tMCM83AAvAXe?=
 =?us-ascii?Q?/1Y2jqyY94IPkDwCn38cZC0+DzdBf8GO93IyE7dzkXhNTDbQjCGJ4b1Jm/kE?=
 =?us-ascii?Q?k5QkqAznmmJoHJn3rbpUTPm6jkaBccI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a06fed-ff6c-4a6d-fa24-08da3fa7995d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 06:10:29.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42VOe87lc4AQlLLNfvlmiDrjPtPhCJ4Gv01fYOrHwnsUFrbLidbPOOwMTFdG6sZ9+vcFfXySkr16ou9ECGp3zxFSAp8Ta5IMFtEFgs05yjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_02:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270030
X-Proofpoint-ORIG-GUID: FKkL_Iv7uMhS3eaj8Oj69BDkCacLo1OC
X-Proofpoint-GUID: FKkL_Iv7uMhS3eaj8Oj69BDkCacLo1OC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 02:10:31AM -0700, Yu Zhe wrote:
> @@ -9370,7 +9370,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
> +	pr_warn("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
                                                        ^^^^^^

Your patch is wrong.  The code aready has loglvl but as a variable.

Don't start sending checkpatch stuff to kernel/sched.  Better to get
some experience in drivers/staging/ because Greg deliberately leaves a
lot of garbage code for people to clean up and get experience.

regards,
dan carpenter

