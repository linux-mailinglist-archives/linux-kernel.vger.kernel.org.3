Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9555A08EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiHYGgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiHYGgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:36:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA69E887
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:36:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P4RMAX027723;
        Thu, 25 Aug 2022 06:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=CAJCsfFz0LXrV/oEcXxNN1EY5+zjMvFV6rddT952w/A=;
 b=iPxIunmUIij5JXNkAIAa1x+W5gEoklg5Xrp/mMRsFmPVHAUqFErHWiHzbidKNyu5RArJ
 C3IINkOBYrWpniU8ROheNYBn5p+8fcHd25a0nCN/0PXZ+qcKnLE1zbyAv6ylGdnAb23w
 LLiYPMudxayBmDrtqy1C7cHVQKenoSp9gnNtvackI6WXw3POHWlLW99S3f9tD92VhSww
 h4gcrB7Eq+b3ESBgjsHjiTm2xmQnuQ/5vEqOQtW0HDwDqaIv6igAxOuSqL2h/5JnPcs+
 l9suEzG3H9iC68mfxiOs7AbX8UvPgQRPBL40pLjYwqSS43UrUYom8F/8eHhGQ/mJOtc+ QA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p23u9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 06:36:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27P4I8jI008977;
        Thu, 25 Aug 2022 06:36:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6nwfm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 06:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aseglhf42r+bggdY0dlfHx5B1926Rw5xFFCLlZPUbJXTSptJ3pZ/ooHMztPFx+9B6IGCXrdEuVYtPv/2nT/NGK1wR5Cov4JGl2jbEkm3BNWWYlDaoZAgJ98w4RoU3ze5JK1PxqsDvzEBLmTInlSAnD8799Wjb+/+/U5l1lk9v377eUqK+wPcoflGJyiumkJ4rvrQGD5VOru9aGmNz5CbiKQRfWmaG1QuU60aEZ1/FDpbOj6AsibpLEMf8VRX0ZLCqD3sXg9Mwc3F53Jm4MYNGRZ7IuWuhjss22GMRnsnMROnQIcsmlYXJ4A/B8xqyAfHtAoZ10OeAwhrj8lBFG6i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAJCsfFz0LXrV/oEcXxNN1EY5+zjMvFV6rddT952w/A=;
 b=BIff4EphUmL1/ybZmzAMe87UV2f3UPrPz+EdjGTzagrsNWvmGDOjm6sxi3C8VvDdhIbN8ltwgcDjHviBuDB3BsRKlwsaCUlBIADwfGSm6limOFFT+SDePcP5GnzbyQ4a4MLN4xRWzYGoj0nNcqFKvPMp0T5MCrBnzmRv6RyEOZBzwYstJLASm69HX0BC2WTyqHngdlvvI3q5sX71tcwbPBP+JLmhM/FpI1GbaSwXTvNqC7vJwaM4YMB8dTdW+Yaj/K3+op805EzIYtdpCxs+MkiCrNDMhnt68jkBj5aCmHUYMRJ489CWhCzoAYg/aeZrXZnxVut/s1N1FARnzMGkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAJCsfFz0LXrV/oEcXxNN1EY5+zjMvFV6rddT952w/A=;
 b=pTVPi+Ea4xfH84X8MhFMT7hiMaZ/60OXcXCUPgAdVyXr9qSJpSTOt6Ejn/rc09zVmN2YGNZHVdzUmjh0Nt7RjmkOvISg9/00He4wBGMomOrCJGq73bbSHDYDhJRWNx7PTVFKCczePIvpw4R4I13tZPMZNWmj+AfYkuY5Bo398/I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 06:36:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 06:36:25 +0000
Date:   Thu, 25 Aug 2022 09:36:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, martin@kaiser.cx, jhpark1013@gmail.com,
        makvihas@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary null check
Message-ID: <20220825063602.GA2071@kadam>
References: <20220824080350.221614-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824080350.221614-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23af2d9f-ea57-410a-ab79-08da866421c1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iq48OzEVmhPP7v8Jg0o07O+zZMfJB+6b9U5GwHUluzk3IH8Ylla71nKKaPGU2lFRiSLeG/gyD8rCONYRe0uPEy9qQRwvuEIiICUgveVE29AWWHi+8eeSYz/2SNdig3Y1spQjsQI1KSRBxTrsaLYJNLXWJd6ysSbtNpvL3MwnMRrl7kmkdeC6r102BPK/DmdSJzAvcnkQSlQSbYzjpG59Mt0C50Ag/8j3qsZy8Fmsb6E35+OHMdTzl6HXNTguokkJ0kT9yk0w7JQcEmld0hbiPBJeoCr6RyqbCY8BPVQyt+KhVbg+CLeBFXvh8clScmkaMsBVEGp32HWo5fh33oyIefmO2hiYl5u+XCHKa0X/c1jJacdCwgViNF9LmHYo7JuXMqUECXYhpefDDgFbisp941Bm0ZlbAFYHRc66B2WRyv2IOKhtGanF91a4DvcBOW6pyc3QM0bpWI23MRGtVZU2A4gLG8LLuLrRLJojQtkZSs3EaWJg3EDtDwpG1yABKnbHoye+9BbEetSGVR1lXkrr1KegHR25Hal8AOw2LBVNpy1So8ghb8f5mWoNJpBYajD7FHjr/9SdXg7WwZJtXpihwt9NWgf6ZeQEw+1dqHUa1PakSWOszxTBtDMEqq9G0dy3ot+LV7GNOg7qkSMHC1qZHEmTM+aPdlFQS2tcL6uLW/NxjpOTyc7+FLudjhzpTBLb7dHGH22Iyk2C+fenk5i19wv9O2DNQrgXxGKnlakMgpP5lj6VwDx2lDRhRZQCxg16kUK/tvwmsmODmFcHf52CvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(38350700002)(86362001)(83380400001)(38100700002)(186003)(1076003)(66556008)(66476007)(66946007)(316002)(4326008)(33656002)(6916009)(4744005)(7416002)(8936002)(6486002)(44832011)(5660300002)(8676002)(6666004)(478600001)(41300700001)(54906003)(9686003)(6506007)(26005)(2906002)(33716001)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRfqwVBZeD9CmnNXNYM4HZIqF6D5S4kRFBg4VILAuWvx4YD9t3oGJFDK7kMS?=
 =?us-ascii?Q?HFvOnIwyheEF7SBJZ5eJ+PMTWrCxkDMjbkuj4caDgVnoWcGOpcFyw09fg4Sd?=
 =?us-ascii?Q?lVRIDedsv1dW9Q7Yht4KDpsfN3WI+V6hEoVgIGPp8po2ayBcDozcRlaa4QFX?=
 =?us-ascii?Q?0iaPs/wm6CAEQMLFmXWWLyxr3IwZ+NWhAH8PktP1Ryry7RPgh6/aOMRfsL73?=
 =?us-ascii?Q?+F78Eqhh4HbASjyR1fpGyL6WTDYFPlIfgaGR/lRhL1nAFs/YJbGJfdV5Jt57?=
 =?us-ascii?Q?/b3i8Fx1hSMs9B9kxBlsEFe9iiFIYUOV2M3/K7RzMEbuDlMdwkWRHLayBY33?=
 =?us-ascii?Q?JnSQmSgMpMpn6vc0PqcrXO8GOf3Khi8JeuVhktGsHcdMHB6iOR/nsUh7dI/F?=
 =?us-ascii?Q?IBkrHE/C7pRi4Z7vTj77t/N/3ZPzWlryFrkSr1RiGrejbm7EN42fjgiF0oV9?=
 =?us-ascii?Q?MiDwkDBS5eVNZBQS68i9NC6zXfOlZ9GIefROF43YjskdeFVVfDEzhSZ5IMWX?=
 =?us-ascii?Q?/EXBFT/c4kt34URMPknqVFkMUGaoL2aDgjOVEzbYBYS+UFQIvhSpAiQMctKb?=
 =?us-ascii?Q?0uHyO9jqmEFgX0Urf3DNC4TbnfyuFSZGM7FgLA8KHvkxCWgI4uEzf8/VCHW2?=
 =?us-ascii?Q?aO7teTpOEOSHsTp7R5L05hNx5Tp90XALgtVrJ+UAhpV5lIkwSJN++2EOJnVU?=
 =?us-ascii?Q?IBOzFc1fkvh5TTduQQcKWlt9aGgHhYvHSvCBTmJT1pZYOI5Lcq0tIIl9VTeq?=
 =?us-ascii?Q?OlP4U/P+5ay9WuSBBLTxPTed+c9j7Jf/4nO5oaTHXcdJ33yzQ2wrWqUQgQb/?=
 =?us-ascii?Q?BLEr1TF+sScmLN642KUiunJscMn2Z1Ufl749EP6gytoyfohaMlnx78y7ynMB?=
 =?us-ascii?Q?3HrideYJn6iDD8akLpxje5z8+mYHC6ihQ/gZhQt7OxyhERcWON9un64kk9mO?=
 =?us-ascii?Q?+gtvW3tplefxnE2Uf0woEt7eNfRlOIkSLIJko1YTuvjrJAij1FWZRQVTjPUE?=
 =?us-ascii?Q?HuqvZJ13hA17SzpNjNprqbixHedET36O1yhZV7p9H1i1JD7NcdqddZBJP6Ay?=
 =?us-ascii?Q?j0is8aKkGWqFAzGOws4eKEdAj4ZGtfqgVnRYU0vM8DL0z7skyHMY+d/igjW8?=
 =?us-ascii?Q?/G3nBgXgzD1BV5NUYGR3wfeiXXK0xdA1eY19+imMRCoMlBYX3QhhQGHm2tjM?=
 =?us-ascii?Q?NB1zn88eGImu4kGWfFvIPLp1ZAOtMess92NY3m3tmv8LXU0yQ8psL/N6XDnd?=
 =?us-ascii?Q?UzaNF7KUT1UDDTLN6IL6t1EkV3rlX9uxs0f3vKBxXCuJLQarUxH8VvUEaI61?=
 =?us-ascii?Q?lhhMew6+OqRgrxY4agsJbKDOsGw89ANqeRiLVsrIaK7G94WsAsss2zArE+pm?=
 =?us-ascii?Q?y/4n4uMbsakbm6996fhKdQWKT54dmTO+9xuVanBgG6MkvkLAaJq/fYMVDw7m?=
 =?us-ascii?Q?9rTyKsoyQsMWEO17tURc7ziOr4DnTe5cu2cFfY/cLkFGT6d8aP9JJ3EKg1ke?=
 =?us-ascii?Q?4xXQqJGoG21wmqkOQZjcX0pggT2Jl9RfZf/1V0psCJui8KE9ezMMKofXbXy/?=
 =?us-ascii?Q?AHqopDiK1kX45tBjsrbVOA7+BUdbWyauplwd9kSm4dgZ/vLjbsudtmyLJ9lW?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af2d9f-ea57-410a-ab79-08da866421c1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:36:25.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzRtspreXprfvXZqOfgykJ2pFv+incYpKRjyCvop0WqDzFXTdtCQIJ+Dby/6TwcGylfwUneE+A/OOQUiMKPxbJ4oqVC6fZh2UCnvce5mmVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250022
X-Proofpoint-ORIG-GUID: R24fnYf5498nCWNPALw7-BAiu7Xbb3if
X-Proofpoint-GUID: R24fnYf5498nCWNPALw7-BAiu7Xbb3if
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 08:03:50AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> container_of is never null, so this null check is
> unnecessary.
> 

I can't Ack a patch with this commit message because container_of()
*CAN* be NULL.  Here, it requires two things:
1) That ->list is the first struct member of struct wlan_network which
   is true.
2) That "pmlmepriv->pscanned" is NULL.  Which I have not looked at.

It's really ugly to check container_of() for NULL but some people do it
deliberately.  Some people also will add a build time assert to ensure
that ->list is always the first element so that the check always works.

regards,
dan carpenter

