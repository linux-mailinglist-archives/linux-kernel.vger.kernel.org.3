Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1536E59A990
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiHSXly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:41:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B210363B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:41:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JNJZ0V032063;
        Fri, 19 Aug 2022 23:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=lxE2SWypBtnKMgiO5I2i8T+EheGgHXJncacb8vGFiXM=;
 b=a/WcayJtdXPL260njafKZlfe+rhUBgu3N3dQMRRHpAwTPGiPh5XNJ7fjj4WitTVSs0Vn
 /0K+TgvMmJ7hiTkq08ZWWoU9o/C/RW4bb/GYbDKWKHMX+hQlyokAnFODFFpal4kv8C4z
 7DJEz4VBSYhYgTh3mN2iPlQ0Rxq2HlZQlybBK3klc90UZTzsym43tSEWM4NLhGBryMrD
 JcWbLMuBkxYIvQ6toR+5+7L2FZaAElP4ME94hOQ4XK23kiN2HBKOe4W064UrRu+wPTfi
 6itl76DgTpz26jPPrmswuiEraDsVmuWBmDac3mxrM2RLOxreLryUn+AxCSnKi25SJVu/ VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2m3c80s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:41:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JJi2fR007855;
        Fri, 19 Aug 2022 23:41:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2dby0fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ+hHp4R/WsxrkKuDppYr4OqvrUZpBodW9TPO/Alh/59vSJsrNvQ4i/ItytulTTzVD2IRPTxIATA8oZ1O6NGUL4pGAwmi79QgbgTu3w/YFiZVJiJOl+oSbCE5p/mbiW7jejzCGkkN22G8H9zStv5grkepDaXiRaoV1yjZCbFq7DRsTTOxLvF76lM+u8S4h9BwxWUiRPRYvRkRaYP6twXtGocg4KMA+Z6fVJDsmxJ8nGsssFKDL0ERRnQ1KY2GeBlqoSBHHAfTsUSrOqgBqmnWkVEy+5lbNE0SbHbXIQ8r+58ED5zn2uzyRuqxNnEYmAKTqZ0AuSN9KOZtbnVMT7LNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxE2SWypBtnKMgiO5I2i8T+EheGgHXJncacb8vGFiXM=;
 b=TxW9y4MfxkxBlabM/mP3+8Ces26PcasP8ADA9jmDql3r4nWp/y1Tykk4VvhAtZpXHsSGhpT/tVaxTsGvWVXjlXJOfYOMfSDpLno4Nui7fy+VZ3cVsg86zS8tsF33ZJuVmcXtwtk4MJT3//gzYlzCI8fPHqb5afv82pzojegZyKaNBLTmv9Uj9245y14J/pGsXQZCPVQcAfwcCFBKMmOLRbQh9+xScImBloxn9eHMWFaPbVzoEo5INZ+hOSl5XstrP/s3KxbJx3utadsVQ3vEZHBTkJiA4ehfVYUQTaXqRu/MC+Xo6AifWN4MGpYggcFPbnbtCfWOWD4cYyTFy52LsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxE2SWypBtnKMgiO5I2i8T+EheGgHXJncacb8vGFiXM=;
 b=CyWUciD25BdKu1CqOEjq94yrGGC2rhuVjo84hjc1GSG59QJCsWhMnFjzph5+VC4Oolrq/AjQkb14xU9QonXR1mESg1OvEXYs0ApHChsDfYi7OgEmsFWT2bzub0bCU0zcXOxpy90EPblCXdkYApsU/IPAp8vYzvNpPd0ekM9SV7Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1495.namprd10.prod.outlook.com (2603:10b6:903:2b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 23:41:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5546.019; Fri, 19 Aug 2022
 23:41:27 +0000
Date:   Fri, 19 Aug 2022 16:41:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        andi@firstfloor.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev
Subject: Re: [PATCH RESEND] mm: hugetlb: simplify per-node sysfs creation and
 removal
Message-ID: <YwAfo/y/4WqVeBZ1@monkey>
References: <20220819080029.12241-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819080029.12241-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13979cc-456b-4499-bed6-08da823c553d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1495:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaMBhBHCvKYWew71I8554LQt/2Rrxm7jnNlJ7SHtT4Ti1uZaSCKeZ1SjvLX49m2KMYtnrOx1q8Lo1JmTpNoGgZ09A3TQGJH6nZbtckWSEVyEUhxmRy3mlSoVxmzcV78zi6DY9nNXGaGgmE8tUDNKi9mDSVwHWOiVVlBUNixjpstb0x7qmLqOLDRcBTidYbmcAdAnbGh3PlexiaRczzK9cNnEeJVS/zj1oHK5jkr4Ixsh3nbncP1vtuRJOw356qKlORutSGg0Z2gM7Zn9GW0b9hOKxqGnqrbPSB+hH0SeyzSI6vpVpSnDc+AxwIPAdRBg6xBScoiip7/V0lu5wFohHUMY75bq6nTY9R34CQlvu2KdvhrsxOBA92PdVRrVWYSDUQTDtj9j5xawCkQ4ZHFHcRwW2CG4lSqWSiFyLUQoV1LQIc6QQHO9aavnRFDL+IVT61FOvigIhnBrGc89r04v8NDHMZ3dAv6Mz/5/VXYVJDzzap96uMO89YZhujZEDCJx0Aj5brjXzwBjPlBnunXXP6SV874qGC4GAVyw8z3+ODR+EhunJ5BH3Hf+pLlCLZgV8IE3NjwWAQtZTmNHy9Gpo7LRJDTwtPKmX6glDJyNiNKuInd3JWRXa7E8BNlWA9aNLDaMtPIUO8EDWKTBGRNQ5Xo8kjK6zOs8kNnJj589J9Votyiv3rVkUsE3twK2q8jvF30ajc8Y7smQlqZAp5DoLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(6506007)(478600001)(9686003)(6486002)(8676002)(66476007)(6512007)(66556008)(66946007)(26005)(83380400001)(86362001)(6666004)(44832011)(53546011)(4326008)(41300700001)(33716001)(316002)(8936002)(2906002)(7416002)(5660300002)(6916009)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdrZQLQggWdrCjqWRemkxW2y9G4/bpYbr+4h9zWJzMdzS4tKk+iJw8bgVGbh?=
 =?us-ascii?Q?lEUzTp51+jJFKE3Qzd5+fxS/MUVQQjaS/pGPa9rESI3Jt4UV0yWj5uuuXiGI?=
 =?us-ascii?Q?UKko5u/o+9CbBJ8fxEdjHG6NlO0scScJ2U/XX1vO0tTeekFz9GUB+bx6UT82?=
 =?us-ascii?Q?UJMsAHWA/jg6FByE6UdRro95a2EnuvdojsozI/9sy8vF1LtuzJ5z1X7VtZha?=
 =?us-ascii?Q?XicEBOYzIKrdPZB0t4bOjFwdRG9XLDr5rvRFnvUiBGe0lNhq76VqwY0zeIxY?=
 =?us-ascii?Q?JL4J7p3dqSaMAheGCbNvbQMtMMXLLhoADIVZuCs29NK0dAq3k51FEbVFEgTo?=
 =?us-ascii?Q?lziYrSrVo3pxOCTFwDb2XwwTmRXRk/7OzU80TLDb64FalWH5YFrpxJkQaxRU?=
 =?us-ascii?Q?IuHOxd2uIdVmaxox7J4u2r+W6XtTb8kE22PkxEerFgN09K1hNwut0sYTLPre?=
 =?us-ascii?Q?6h410FySVF0HG4NVKzO2ntt7qxIldgNEkPygbFPOWYLDDDAzCoyBCuy1462E?=
 =?us-ascii?Q?jpv4KKlsVTP72hm1et5fY9+FVijpY52Vcz4gfIHkPpBPiR44gcQ2iV747MyM?=
 =?us-ascii?Q?DSjjYkrYRDvKPzx+lU4CmHhit1iv2M+fMvjvCJk2sbhHscBNVGLmwiAunEP3?=
 =?us-ascii?Q?VirJqRx6/ONtFK3l9CGZO12Gkc7xpAJIvYvYeC/CrZRPTN8BvOsTkYr+AkNd?=
 =?us-ascii?Q?Z63rZ7mzgexqVYL5TuD85UDDysEAsfDjbDgUInRqyRWuPusEXXcsCoLAjN6j?=
 =?us-ascii?Q?k9CcgzQaSeIx9TylKOo8C9zgJt67QJ40zcBxbtasUezbXet6m9aNEfynNK9C?=
 =?us-ascii?Q?5eb4ko4/yoPfDGcA7EkbOZxi9OYZ2dEaShagULat9V7oqeW+a/7SaqrOWe3+?=
 =?us-ascii?Q?NsyNA+zQ7lM+LhTMXGJfF5TvdIJICTrc7EwnNjl0sNRIHXzalQIUqZT/rxtJ?=
 =?us-ascii?Q?8g2IKRXn28TuqKRlvtwqdCYMW7GkqXiw/yo+Lnn6aw3cYDMQZ7FPeaqB2bCB?=
 =?us-ascii?Q?t+svHIjDXUAEn+UBPbPlHdKtALEN+l4l8WhD85XcHQn1YUYrykMBACylQPid?=
 =?us-ascii?Q?kyZYDXQuzWmmOeWzaj9Rkw5VoI8H4+yBsBWmsR+eTvpzX2eprn1wOr03dJsd?=
 =?us-ascii?Q?UsRacTxLc0pA2jA6VFuNAQxZMLvePPEfFYFV5Y5jBfb6TdOjRziP/SlsuUCq?=
 =?us-ascii?Q?0VCSriWvAFbwoGmVGE13PxxDsVQ1ECZGiiQxFt7bB1TGFV9sCrz8MhicBUxd?=
 =?us-ascii?Q?087YkhNwLLHNMg6I7W7dDAfZ0bCmeS2nVqzLQ6UfhYuIPa7Eb6nt5niVN9i3?=
 =?us-ascii?Q?voTOiiF0ratFiRFG008X9Lntdy0QWbpalHkkffFC4/BkScWLedyQ9VW2ave5?=
 =?us-ascii?Q?CjYxaosbCoiNMuZW5o+jySVOXrivl8NF2/79KxMo6KI6zdU3aZNbVwkTchfy?=
 =?us-ascii?Q?QB+Ts6qMVZ8xXV9pGUgJU/HoiTBfH0ZeR7jyTRprDQs+o2ExhfkevMAOc0WG?=
 =?us-ascii?Q?sD2pxP9Hife7r8YsHdIzWbvhhA7yohuCqs/VVOKopfTJnjwuu+tNWSiIHayr?=
 =?us-ascii?Q?w1iuhOoan0UU7R1U982H2HsIVk5SnE5+whDt28TYYOM2w0SUpyGBPuOfLkeW?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13979cc-456b-4499-bed6-08da823c553d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 23:41:27.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcsOdYF2CHMiAzZ0iW1UVwp2FnB6s7HpdlN+Rd/GlKCOvhasAX9nw0rjjS+rFHX9/CNS31807J33E7Rfo2P5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=825
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190088
X-Proofpoint-GUID: x9B14Q8VuwafqHCXMzxxxXYY8uN6VRFu
X-Proofpoint-ORIG-GUID: x9B14Q8VuwafqHCXMzxxxXYY8uN6VRFu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/22 16:00, Muchun Song wrote:
> The following commit offload per-node sysfs creation and removal to a kworker and
> did not say why it is needed.  And it also said "I don't know that this is
> absolutely required".  It seems like the author was not sure as well.  Since it
> only complicates the code, this patch will revert the changes to simplify the code.
> 
>   39da08cb074c ("hugetlb: offload per node attribute registrations")
> 
> We could use memory hotplug notifier to do per-node sysfs creation and removal
> instead of inserting those operations to node registration and unregistration.
> Then, it can reduce the code coupling between node.c and hugetlb.c.  Also, it can
> simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---

Looking at commit 39da08cb074c, it mentions that other memory register/unregister
handlers use work queues.  That seemed to be true at the time, but those handlers
have been rewritten or no longer exist.  With a quick look, I did not find any
memory notifiers doing so today.

I certainly like decoupling node driver and hugetlb code.  By no means am I an
expert in the hotplug interfaces.  I could not find any issues in moving the
functionality to memory hotplug notification.  FWICT, functionality should be

> 
> Cc Andi per Greg.
> 
>  drivers/base/node.c  | 139 ++-------------------------------------------------
>  include/linux/node.h |  24 ++-------
>  mm/hugetlb.c         |  45 +++++++++++------
>  3 files changed, 36 insertions(+), 172 deletions(-)

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
