Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD158EAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiHJK75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:59:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4D75A3C8;
        Wed, 10 Aug 2022 03:59:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8i9bD012174;
        Wed, 10 Aug 2022 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=y1q+x4sxm3QeMzw6qmS4j95T0ZD8MloI7k1O+7p17j4=;
 b=iHCd33EahPq3WkZad8b7/6NbRxmXc1zyXC29Ci7XPD5KjUH9h819JsUDs+Rd/PK8oNcA
 hoU05ROVflQmwk4GpqjV7NAES5kc1eb0pWYsyfcZ11B+ziso7TyvrRxVjjQ7bmf5IaLU
 yRSHncsUICTeTBmtBv7+wQ7E1s+CS8ffl5A6llbIhi5OuqCb+8I2HKoC4juUPv9sOS1W
 0YNcAh0+eINg8ij6QjAUAlrU8bb1WqiXxgi3UP+QK/KtVmYt7v3jxEvoQUnKw7ldRYPr
 acStSgR9ZoHY+cEwf8Kk5XQvs/sPYtkFSJjhYs471LV1F62X5oH1Wh5rqt4H36ij0iA6 zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9hh3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 10:59:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9L5PF036848;
        Wed, 10 Aug 2022 10:59:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhhnxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 10:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0tWcEElx8iYpK8zeeL0ft+ctfnadEl6je+Qckhkb281F0ryNWSdnjY3H9hEXix7VmeTKmB2uuxdv+YAbI92+H5DDu4XjpfSVNmwtq95LuaPHGuz7N10fvQixIJ7v/2COsVioaHuBWW+Gp1GU5BzmEib4NbAAYbE7/OUTPJGxoa91kdQ215k6muFWU7vfzMd0QT+qx0Z6UGctpLaZGjYmeFdl4B2r9lxNXaWEgzWtSWSZCpbt3LvNHUEl2CPP5JgLk4vbItur/Rh359cZoxezquckIM8i0co5Nrmfx0fSNT+nTqwDDoXEthBa4BLuyo5PDKHmyg7taUy395rMO/xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1q+x4sxm3QeMzw6qmS4j95T0ZD8MloI7k1O+7p17j4=;
 b=eUKSDez3BDhtKuTuOlVgaYTcVOWp5GwDbK122I6j4CCb4Bid9HOwqTrosd2LFp10+5qFmCpO5JL4e2UnrPcWsfy5DMgsUDb4DcpxbvZLdCOLTDqaPa1uC/erHmUsXOy+z29OaIhIw+pnr6z6dh+ebZFqnc7mF1+KjfdudSp8h4rJ2ij2Aq/HBolL8JsT6Aqb1g7LcxEmSvi3QbcpGSvVMmvf75ZhcQVqn3EB6OKmxr+IgkdTMXqaBBFYgM1PD4ZZ8aZ5pBgU2fNARq10MUSEG7iqsaHgRZ/9nfxgN8/mRwstr733Vkez8zrAAz61M3lGvHFJnIO6RGsUDl9NyLamRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1q+x4sxm3QeMzw6qmS4j95T0ZD8MloI7k1O+7p17j4=;
 b=kZJOM1pIjHbC2b/VpXMImWtS2b0TFK/vyN4QCQDLVHEw1HOZnC6FGEOvrOo9dY0A2fpTbX4EOAhOBpZ96pUyhzSRUwI8bYIycmkKWg9AykKuJ0kSDFen8KbI8+sAHHgrdi5xu7spE8rXbAhWpA01sYSqYEoHQxEfxj+rZJhuyoU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4365.namprd10.prod.outlook.com
 (2603:10b6:208:199::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 10:59:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 10:59:36 +0000
Date:   Wed, 10 Aug 2022 13:59:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     smatch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Smatch v1.73 released
Message-ID: <20220810105926.GS3460@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e7a75c-aa3b-4b67-6bf1-08da7abf69cb
X-MS-TrafficTypeDiagnostic: MN2PR10MB4365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hprY1LIs1IBVNLKAKFsBRA68jY5eqKCFPBYTXXOvW8yRnK4RIywNO/8Srw16aXEE+q2TICbsnvBpticLF9ekaWJaMyN7T6JesRjiv+Q0APT8jQBDK6SaCazT8VVztN1YNTl8/naPmruocxTGX/yoSVo07MVKGJOGqvlo06TDhNxBa8Zd4pU1JNdD2/HemopZ0V8wg4JsXpfk/A7MUQ4T/bZPgj+S6vsHgf/270j/Yje8y4yxGU+o5VWSsHwOWKMtqjXlenMj7Oj3uf0mEEW+4SmCwu5ul6v0c8ku3rLF8doc3oCqeHzySdtjt4MKszjT1ZCNTPRY7BntlrrTrfsxsecUluHFNFHih8ADEGLoGEgxjwqfN8JA9Vxi0bi5Wt0+ynM87gwlfRj+gg+BpoZ4diECmV1rkqpwrj1a8zTX7M6nqk+5rrMNrVU5j13pSdo4kOZpNAryKY/c0IBvqAWx9jM7XYP6JlV7GUvxUqTFJf9h6y8N1AhaxRccKnjMzWxiq6046nphakUyFk4cOxoFxBoAipn+BPo9mFquPqaPZgHuHV3U08YHwc8AQBKY4n1svR6GwAkCNYfu9u04xIS5sKyPSvzuux06g9OMXHV+lh+TTSdH7Iu31R42MvYAeC998aalJLvG8Tk42zqxrEqCSD5IKn85m0smF6Ei8ThQdD7Tu81t5CUzVWJ+6+bJHCrwdXdkJKOf7olk+7u4GqNBVBvYUwt7uvLU/JHfpR4bXJQeVPO4S9UAvr4kRjJnz0uzjTcuqWdUHKDGs68fJxTwn9rawLhFV2GnXl19jcxRvALQg+STo2Bf/h5Fq6dgHzz1o470XIeyQIPX9REXMMOVuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(346002)(376002)(136003)(83380400001)(86362001)(33656002)(33716001)(38350700002)(38100700002)(4326008)(8676002)(6486002)(966005)(66556008)(66946007)(66476007)(478600001)(316002)(6916009)(54906003)(26005)(6512007)(9686003)(1076003)(186003)(44832011)(41300700001)(6506007)(8936002)(5660300002)(52116002)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pRLfh48vmxBeDuXQBgzrJ/8huSVZW0ZqqNeuImYKrBkNQYRoXo8d7WGfWy/Y?=
 =?us-ascii?Q?Ax+NJuju6yJCT9JHqA7GjvRv6oVweEGMiU+xPUQHmfTPoqGd96bt4ZgrSV+K?=
 =?us-ascii?Q?9+y2a+l4YfFKS/iKYN1BGao78S/9m0z/HlzrBro0cAILsq8Yq3LxgldwZ5XC?=
 =?us-ascii?Q?pUY8wup0SrW3jVwn9w5SfavQaDrjmMpSm2SUXzwJnk3bxYCFUt9RccPT+Ipi?=
 =?us-ascii?Q?U9j7zZeEwBoDOjdZwzImQ1+h9ZMWEsDCo6Q5J/WlxxnplCc702yCjfUmvXVb?=
 =?us-ascii?Q?gTvAYX1U2TwTMQtOiCqQNNtOhbH47wo/qSZIli5qKu4j279xsG+5p76jmbAZ?=
 =?us-ascii?Q?LYfVeO9IU5YuB0oXPxF+TendMSLk0WBDZgbAqJlz3/Xgu591Z8TXvmtwQOlU?=
 =?us-ascii?Q?PqWOIa7+2jwfYBGom97TpPV36bC3ngI1qGRELuSllh0rBSE0PWlO7Sjy2OVL?=
 =?us-ascii?Q?HdXbg7NaFNkffCgukCAGHb+1XsC3YD48hGU15r0JKhnf00mhV5v6rLQ8UYrO?=
 =?us-ascii?Q?zc8fBDbMHW+j4x/8ROS/7Vxacro+zHtN/1U4xyjMsClNqoCBKNPFVszTL4kL?=
 =?us-ascii?Q?M4xFAjPvdanNLzUOrDimUHxClcX++DFXepfwcN4JwmciztFrBULZMqY0KSiF?=
 =?us-ascii?Q?Ruke49EHZx9jkSkC+3HDAZTIWZdqhODV2Wla8XDYo7FwCwuqVzkqz6fqfrWe?=
 =?us-ascii?Q?kXkjq35JldNAA32rFFKw4Q3T1slgbD80PJNg1bBDWdknclzitqzbW299kCKE?=
 =?us-ascii?Q?7wmvwjJ6q0o1IOBA0sokHiuWMsTwa2SLzwl18ZiJWyGpjZgUtYyAuaEykTI9?=
 =?us-ascii?Q?6vvWoImIwA+1w5u28WqRNaJHZDj7Hd2SKG6KMpgLYYRczoougA9QqwAeInvP?=
 =?us-ascii?Q?i2fY5ynrx2ateBLcOWkbNvLXr8jAXvkWwWfKVJWEkJtYJWXDtKtXj4iA72ER?=
 =?us-ascii?Q?NPRj/cZh9MpwoDihRlRWOzIjHbm4tG75Ou4DoRSoEYUphglVWAgAplhAhPlc?=
 =?us-ascii?Q?3o9R6wJx/4PlULGF/dCwvdDvDhoSn55k+oMjmm96LtE9Ev8u5Q/mvXv8ZCHK?=
 =?us-ascii?Q?GJ7qdNyh5M5wClSc9SowvPS/x8dF1Vx48kW3sU2aInbz9oLPybfwkTF3EffW?=
 =?us-ascii?Q?wx7wMQKj6q1oI3g3GFoal5DOHdV4s+LdVITrsTOY7Vtw8kVaEAdK6IBSb6OH?=
 =?us-ascii?Q?3+sXnpKGZEMXIOTjtUHyZ7LrZ/829a0udp/BhuJmOLg0R1WiuYK+Qg68Wjml?=
 =?us-ascii?Q?y8g/ok6K2kW2u+edc09oxNkk157AzwTjkKp49SIuike9iy1SdA+N5HTQA1/2?=
 =?us-ascii?Q?9HDzhIx/hVlpL/Xa6AohNRznGVum4aiyhi01X3JWoh1lqJkRvT07WP+6+Xqy?=
 =?us-ascii?Q?B/jimmISCL2dmVJFDA9Obsx++XcW5t+CCDrcJ1oZyd0xnuECpARYYduSIwDC?=
 =?us-ascii?Q?BwxNRJ7q7oG38BnmqcGL13x3x5R5SKC91oyu+TgMbswNgEcs1OKeKG0TIaqW?=
 =?us-ascii?Q?MACCKw1cDxp2cDhdlbkuUS5UXhqXzS5dq2mt2dMC4vPiSntqMS8YPdyxENa6?=
 =?us-ascii?Q?mHTDdzGigbhBJEbHqdVlEhf7nkc6yl1CyApG49ls+ZVaP1IZhk8En4TGpi/y?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e7a75c-aa3b-4b67-6bf1-08da7abf69cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 10:59:36.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvqeWzV6BAKlQZ4EkdzQ0wnXwDoguKg9xr/hXCqMPHldAgPMg4ctANaObC8dGAagI5y9jVqqpgZ+SvlRH2NWNw5fZTZ/8agyJSWP+MGHRb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100033
X-Proofpoint-ORIG-GUID: dwiCJ7KZMRCp65yUc2ffN_41ECsraCzB
X-Proofpoint-GUID: dwiCJ7KZMRCp65yUc2ffN_41ECsraCzB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch is a C static checker with a lot of kernel specific checks.  You
can download it from:  http://repo.or.cz/w/smatch.git.  Or if you prefer
a github mirror, then you can download it from
https://github.com/error27/smatch

It's a simple process to run Smatch on a file in the kernel:

    yum install gcc make sqlite3 sqlite-devel sqlite perl-DBD-SQLite openssl-devel perl-Try-Tiny
    make
    cd ~/path/to/kernel_dir
    ~/smatch_dir/smatch_scripts/kchecker drivers/whatever/file.c

Overall, this release is mostly small fixes all over.  The main
improvement is better tracking changes to container_of().  For example,
there are a lot of kernel release functions which free the container_of().
The next step is to figure out the correct free function to call for
put_device().

Special thanks to Elena Reshetova who wrote a new module to track
host/VMM data for confidential computing.  And also to thanks to
Christophe JAILLET for a bunch of fixes and updates.

Please test and let me know if you find any issues!

regards,
dan carpenter
