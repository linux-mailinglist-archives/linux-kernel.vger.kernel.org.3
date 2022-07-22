Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C857EA13
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiGVWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiGVWzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:55:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094F215FF9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:55:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MLTNMR002855;
        Fri, 22 Jul 2022 22:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6HzxXRCMPU4eUEV4OxSOI0M+s95XCJIWHIG1xnstNJI=;
 b=qBsQX5Fgu+vffsoDM2LDtuL4EiDDYRZdR1rHFV6VjQUkrQ2r6GjZ5nF3nwboKOJtQLpC
 0LEKMIbanQ5QiiezZgFJ12yDNLw4M5svdWUaeB7zSeeJV0h2pNoxPb4pBdQmp7ULAx50
 rzCd2XTyq2wXCyanjPavfbAoqvtVodqzDV8e43mjGsib1fCdQeSEXfT7OqbcXwZr4XX6
 /GXEqAB9Nj2df2HjUVbB6wk8GjjTZTTkXxAb/U7KIuXUwDtoHQt0KgyAR1KCUuL3osyx
 t0jSbgMLVQBtpVITFLwQtTOzWqgpxMB+byDLEZbu/7wED253NNpudJBc5PxLr1O4Koln FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7agan5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 22:55:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MM0hE4016442;
        Fri, 22 Jul 2022 22:55:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1eraa73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 22:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVMtm2zic0G9m62sJbJj/soosL8h8EAnOdR+75kegXy3NA2W7QcD0dWjSqhoqFGOX3w1T+E4tCiLIahhw1Q2EaZpGx+iSeuqYfCpxdmcxoTluLbYBHeM7BbDE0lRbGO8Lu0ciTNbvSEABDwaRb5cjks8hdiuXlqlnySQOnW6L+K9q7Ue3CK7Vg89tBCiBx8x0ikXpcYhxbJYVxJ+aG20S4duNZGCpU1bNsDwVoLiq8MVF2JH1LdnkU+DP3Dehs9mT5/dRv6qTveqjlankZpQRnlUras1POycmcGL/w72fekz6UeBFl4IECIwMPhqCHu1P3+hhJB194m3PRghWD/8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HzxXRCMPU4eUEV4OxSOI0M+s95XCJIWHIG1xnstNJI=;
 b=Ly5dWHbm4GbNwrLMRCo93+lMKPZXPjfBXejKrPp7C9FnqDCa3G9EGALohbIIZpMUrNghaGJFxcGp8eZkDJAfCnVCW5j/HyEtlHIevGgUP8aW0aSWBDAREfQcm/kACtY0diD4lRdFg8aY7Go+LkwqaHodiiQ8Opi98EaMCkNiedmDTcldo6g+swnmuYbEL4/AIddXfL+IIK/M9Rx9JRt9wbLrQ2NmoZSRMt4ogpc9m858mxrQV0xZALzPl2/tQF1kyC5O3msBxOzljQg15HBgxzGc4CmHHFBHpi51bgEA35XWyEVPz6BM3Tz9wI7FFW5vJhivv5jmmXQIOF14OWU2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HzxXRCMPU4eUEV4OxSOI0M+s95XCJIWHIG1xnstNJI=;
 b=zZhfq1a/ESPe2EhML5/d2V+XdEAZMry1hQISxOtaPvC5xOTCsPOlBRvaV1QtHc4YC20Ez3WRO1tIwzP+L7K4n+1EiDTZhR0sQHaTb/MNvBNdSfAqdBZ6fvxkVE/5GZ/o/BZv9HQjzTYuduFYSScorjOFfKpkvhe3hJlMpS5hEXc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3806.namprd10.prod.outlook.com (2603:10b6:208:1b7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 22:55:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 22:55:40 +0000
Date:   Fri, 22 Jul 2022 15:55:37 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] hugetlbfs: fix confusing hugetlbfs stat
Message-ID: <Ytsq6TEsXzyedpH+@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-6-linmiaohe@huawei.com>
 <YtnvFBn8tSm7y/mV@monkey>
 <f277d8ac-8091-78b4-e168-5dfd87314889@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f277d8ac-8091-78b4-e168-5dfd87314889@huawei.com>
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f03928a-3fec-4c2f-3a63-08da6c354cea
X-MS-TrafficTypeDiagnostic: MN2PR10MB3806:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBUwtSp8C0GXdZ4acdbjKH5uA3lXSGzVEKo+pLFpm5MXMw47caE3bL79lnu9gofFfIFMPaSJhlGs+oEjuHib6g5n3tADzo0L75y29Z/5+NQbwvjgzbeD7kgq6zI5NlJG3AkxYKl5GiPBBmqNEeRwTMWigwtFrkPhfD6PTGXxlqldzWN7MlZTQlHILcJvgvZ6ui6ufP5GmpY5sgt63kn2gCR5Xiz009fv1KAOE22Agdutjk1LOHOBwK5kdukAhK8+ekpKccY1Pwqc9CvsqutsQE5qJmlBgDAEO+pzsEGiqExyzK3EkKEaAAxI1CXS9PULAXeiO9ZI5F333w/74O+iOoIHtfP2ZtpnKjQrvSaJkGkIbNO5jHmd67VNC+KXSBsPKlWEnWvrUViu2kWvwkokO/2Sv2UA0CodAgaJ3KeTEiwcXvWGFXdwzxGnaOvqhzoxXScTL0ST4EhBAMkSjbnDr0fhOE904BYw9M3eRxjoyk4RzE5W/zclrkW1BUJBXdMt3cpTJuSEZc47SfF2dH1d9Zu59t3m/3+bZcUURqdkZ6STvFF23H/3j8FauEom87z/P5pFOH/gUV93/5cGo7MivryiXeOvEcAH58AD6xiWsGiwyKKkR35Her3/wDWqpUMOUI5jtTRdnv3taGxLU3EtVrNszXC+UbH5swTcD4mxD24oayUos1e2NJMjy53vBAR8VPRQnX64AtntlaWSm6BZjr+blyu4tE9VeGL5Kd7TKWRZnHvPnQ7XG2nGetMAWzit
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(346002)(39860400002)(376002)(396003)(26005)(6512007)(9686003)(33716001)(41300700001)(6506007)(83380400001)(44832011)(6666004)(2906002)(8936002)(6916009)(38100700002)(186003)(478600001)(6486002)(5660300002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(53546011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZ/2Hu3dNBq6Avm+8QNdGZu4rHN239Ei/P90WPepwILMeCVS0IsQzgLrVvW1?=
 =?us-ascii?Q?odIxlMJOfRtJqjfuAYuLrTl/ZpqSqilD6iZ3W+OmWPkIeJKE25gOYBMoWO+3?=
 =?us-ascii?Q?K3PiBAwftQKpdbGDLcxhYwQnjZccuqy9EUADfc+mL7XHp77UDlgkMEIu9NIJ?=
 =?us-ascii?Q?gtV53jMlF//StzovKdcdXNL3XEUeXgr+NvFCoELBkx5nbjep+hPFHwSf2qdR?=
 =?us-ascii?Q?7j07dZVyeJd7c711eRXuqMOU+z6OhfUuzfYMiap0TVabaH1pnM+9TMA/bDJ/?=
 =?us-ascii?Q?kgNM3zjd403JTydQ5RrDU8K4relDZfg6gkYlsgXZJuXtzJlhFTB2Z6V48woU?=
 =?us-ascii?Q?k0XNMvFmLjg0gd08xCMU4gOaiuPWG/Z+bd/xF44glZS3hh5Wttd84PDBZAS4?=
 =?us-ascii?Q?8IOy8kC8Iy3Xqdu9lPxrufWERj4syp0wgTQFDjEuHfmitrlEdFxvYgZht7zS?=
 =?us-ascii?Q?8mDZGeymf5Rcf8k1ke3StBjVcs1pANKBthEWgnXdMAc8DTRnWXOdDgFAXZAg?=
 =?us-ascii?Q?mhuTlAj2whtUfgTjByntKJSiGBdusxauww4qZAprtETBwz3PXt9XdiWvZEMu?=
 =?us-ascii?Q?4LG934TfMQi1DyFgXlVWMqr1mGR60RybwMMDxCJHaSVybvwKVbngeQ96IKDS?=
 =?us-ascii?Q?F1PmOheEqKK0hI3KiBBU86s3TXbZsrV8TpCpqZqa9HPbNa9dZKa4vOdvUyHP?=
 =?us-ascii?Q?LWvoQ/0EUKPoxO5BSSUiaWDMDGz+DH0g5znfHMvRSlm1DfYsNqFNl3SYJ1XG?=
 =?us-ascii?Q?d9AyrO3tNMPCgsLaoZ2D5gOnPE4HzphZIIw4631pH6UoEQqff4T5VnAZ4xDr?=
 =?us-ascii?Q?lFOiKFZVP7VkBZB4CLP8HxyqyMvr/KKVJma110yvWCoSfP550xcCDAhox8Ee?=
 =?us-ascii?Q?8FCIrJRAV73PFbakffFA+G1FLRbEdTceHUmgfn1eHhee+kjafRcNuqZRrTQL?=
 =?us-ascii?Q?YYBtN75cqz2e7ImLKASoLREo0mD8s2IEl2tq5Wr4mhed+vxCmadlw4lI+GyS?=
 =?us-ascii?Q?Bg5AwHaYuupkacAxRlq2w9SM//tOlDCz96a+lzr7zUqtZUXBdKNh89RtgeXU?=
 =?us-ascii?Q?xzc8Yp22XTGn3j9dFiiVvk+TDftqrgBCDKfOmgGNLnWYJKx5B5GKWoqLhi/x?=
 =?us-ascii?Q?GopTmCAdODn+IFU/3v5e7wn1He6GdBavHrHolouGCwyRgcGrB3wAFWNMzAr9?=
 =?us-ascii?Q?r6QUnASh2MM4e+dc0gqJUtiM0AdO7M6OjkJoP1X8RhwVPpywqvbD8uc2VeDZ?=
 =?us-ascii?Q?atkFvQ6XnuK/TlHVQDHU/vhoxxk/4bx6yP1KVZ5/ycP28hG14iRCNVoKjC/P?=
 =?us-ascii?Q?nPwvmf49FIL65C/nRFXqlbQL2VwLfr4SJXh+sMy3TM1Jkl8ZhJuVBJcleSS6?=
 =?us-ascii?Q?I9iqnTqJJybIvY8bH+iVVcwb+fm48B7RqA9JkmYjc/8wKnZyYRh070KpcHLD?=
 =?us-ascii?Q?hA6+NDQh8mHPQZbjEDli7gUOJxw+b8pbDKHXyVpADhVyIe+2aBYReqHE8TqS?=
 =?us-ascii?Q?BZi1xWktL+tyGIn1GokByzFC9WxFCLdJRrzMCYOFhW5PtHfgprWf3y1WbO5u?=
 =?us-ascii?Q?DFjTMPRfdMOGgphzmi/8JHKTsqAv0UKe8A5z62hGBPJWmCGNsnKD8IDdNQRN?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f03928a-3fec-4c2f-3a63-08da6c354cea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 22:55:40.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbTnCyhiXdtVW/d/go3GQGouaWej3yowSVhJ70VI30+ig8Iph24gAeG9gRoKA0WmvUMm6KZL3OAhE0P0fGmhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220093
X-Proofpoint-ORIG-GUID: kDIWaUCTdoMZnK8Rdw5Xm2vYCQ9Y_QqI
X-Proofpoint-GUID: kDIWaUCTdoMZnK8Rdw5Xm2vYCQ9Y_QqI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/22 14:38, Miaohe Lin wrote:
> On 2022/7/22 8:28, Mike Kravetz wrote:
> > On 07/21/22 21:16, Miaohe Lin wrote:
> >> When size option is not specified, f_blocks, f_bavail and f_bfree will be
> >> set to -1 instead of 0. Likewise, when nr_inodes is not specified, f_files
> >> and f_ffree will be set to -1 too. Check max_hpages and max_inodes against
> >> -1 first to make sure 0 is reported for max/free/used when no limit is set
> >> as the comment states.
> > 
> > Just curious, where are you seeing values reported as -1?  The check
> 
> From the standard statvfs() function.
> 
> > for sbinfo->spool was supposed to handle these cases.  Seems like it
> 
> sbinfo->spool could be created when ctx->max_hpages == -1 while
> ctx->min_hpages != -1 in hugetlbfs_fill_super.
> 
> > should handle the max_hpages == -1 case.  But, it doesn't look like it
> > considers the max_inodes == -1 case.
> > 
> > If I create/mount a hugetlb filesystem without specifying size or nr_inodes,
> > df seems to report zero instead of -1.
> > 
> > Just want to understand the reasoning behind the change.

Thanks for the additional information (and test program)!

From the hugetlbfs documentation:
"If the ``size``, ``min_size`` or ``nr_inodes`` option is not provided on
 command line then no limits are set."

So, having those values set to -1 indicates there is no limit set.

With this change, 0 is reported for the case where there is no limit set as
well as the case where the max value is 0.

There may be some value in reporting -1 as is done today.

To be honest, I am not sure what is the correct behavior here.  Unless
there is a user visible issue/problem, I am hesitant to change.  Other
opinions are welcome.
-- 
Mike Kravetz

> 
> I wrote a test program:
> 
> #include <sys/statvfs.h>
> #include <stdio.h>
> 
> int main(void)
> {
> 	struct statvfs buf;
> 
> 	if (statvfs("/root/huge/", &buf) == -1) {
>  		printf("statvfs() error\n");
> 		return -1;
> 	}
> 	printf("f_blocks %lld, f_bavail %lld, f_bfree %lld, f_files %lld, f_ffree %lld\n",
> 		buf.f_blocks, buf.f_bavail, buf.f_bfree, buf.f_files, buf.f_ffree);
> 	return 0;
> }
> 
> And test it in my env:
> [root@localhost ~]# mount -t hugetlbfs none /root/huge/
> [root@localhost ~]# ./stat
> f_blocks 0, f_bavail 0, f_bfree 0, f_files 0, f_ffree 0
> [root@localhost ~]# umount /root/huge/
> [root@localhost ~]# mount -t hugetlbfs -o min_size=32M none /root/huge/
> [root@localhost ~]# ./stat
> f_blocks -1, f_bavail -1, f_bfree -1, f_files -1, f_ffree -1
> [root@localhost ~]# umount /root/huge/
> [root@localhost ~]# mount -t hugetlbfs -o min_size=32M,size=64M none /root/huge/
> [root@localhost ~]# ./stat
> f_blocks 32, f_bavail 32, f_bfree 32, f_files -1, f_ffree -1
> [root@localhost ~]# umount /root/huge/
> [root@localhost ~]# mount -t hugetlbfs -o min_size=32M,size=64M,nr_inodes=1024 none /root/huge/
> [root@localhost ~]# ./stat
> f_blocks 32, f_bavail 32, f_bfree 32, f_files 1024, f_ffree 1023
> [root@localhost ~]# umount /root/huge/
> 
> Or am I miss something?
> 
> > 
> 
> Thanks.
