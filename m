Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53853BBA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiFBPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiFBPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:36:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901162A5D70
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:36:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252DvR5d008735;
        Thu, 2 Jun 2022 15:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=dPbOSSpeSHu4PlSVOUJ8ncv8I0iMnAMe2nepZ+X2PpQ=;
 b=B470PoayjUA1opwb5irx/duF8x824JaVQV/1sKPbAwWgpRdM8V/IEaqLMfF9ZNvE24/x
 3bg2txqzh77mbOIjEWdOBfzlhfvm2TeKGX4dSivMr0A+LId9T44jsG8boXiUXdYGitQI
 5pCq0++SRTb+SQhNVnyGP58/B91J2IQ+amhAplW3Zp17aGHKGesz46ZxuD4m2Uo3LQTr
 UEvxU666OaGCBxlxW4g7ZuZzONT1kDdb/5GkPx8aJwjdPhRUywY+1llNuaV9+OO5hKfQ
 w5XnijIM/fTkVpWQ3PjjpP/4WzzeyJiVcb+OVxHG0ts4AwwUOWTmglVOV7fv0wNhzU/S Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xtuy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 15:36:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252FaIGx020408;
        Thu, 2 Jun 2022 15:36:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hy9qvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 15:36:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+dsIIXBfa4Sww+fY5MJwjsh29ucOKvh4ZejvdKXM5MFKx1huBJbV8Z18CEyUSMEE/pRfrVCB1fF5iHImQqNrLPFd73C5xieVje7kw4VeLOb/puYSQTwW2BxM/G9uNhI1481SQzGaA3wNCYEsz6McLhpUspf5VP73gIFNxHNcKFbC3i5oOkP52CoVnz1fI7tT8NWe+VP8oAHIIGWg1YlpIAn3A+7yuLgul+bc+iE0y8yawNVvUki95exgz/MsJ2zGrmpnL+vVN/pqtQ8XFnxSEFs7fpjnamYAKf6ZaVi6ubNEp1e0xMWf6zs0hHEzX+D3LCMbIfXh0jdssWhkH8d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPbOSSpeSHu4PlSVOUJ8ncv8I0iMnAMe2nepZ+X2PpQ=;
 b=gptLXN1KH4hvpf9Unp5E8ZVvv0DMAur3yqNSC4Dbm+7Yl5R6yONISj2oge/j5jo5YMIqC92hglwVAsytArqaIPNahrihNr66AKeVV8DUDOvRF/4xblNkHaWqaqP4VZQGUnqBka1m8uwQ1ObrcpS5Zv8+C6Apyt87rI/9DOwQhY/B+TdBPotHicrZrgDRZHZf6Bh/+RK4p9ITLAwmhhT9dfuGWO7wd+uoMjLIrcQxWWwyRfkc/gpuYM6PMNlfWSbuc1aR77ZLzx2qq+32W6GbaqV0461qwnTWlzrPc1H5lbsgDpUR7kGlq06i1AWtLtlnG15e3v8gQbQg98qK/Dukog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPbOSSpeSHu4PlSVOUJ8ncv8I0iMnAMe2nepZ+X2PpQ=;
 b=Ynv98hthomVmNqgDUa1I/euuFbLILNHFLjrPvrsaZ9f6RBG8t+fLeGD3XMsG0EbLZ83nMo4qRPyokYubn9RlyTgzm26kp1pdCSAnJQbkpXzTpO4NbLniPb1hPfF+y+TCD7Lt/aXQFJrodZH53iwHcp4VDLd6vxKDuw9MZlyTTZ4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB2963.namprd10.prod.outlook.com
 (2603:10b6:208:78::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 15:36:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 15:36:14 +0000
Date:   Thu, 2 Jun 2022 18:35:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Darrick J. Wong" <djwong@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 150/401]
 fs/xfs/scrub/nlinks_repair.c:80 xrep_nlinks_repair_inode() warn: missing
 error code 'error'
Message-ID: <202206022146.2RgP2bEQ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f3f881-37e0-4e61-51de-08da44ada09a
X-MS-TrafficTypeDiagnostic: BL0PR10MB2963:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB296313565347EE74CFD727848EDE9@BL0PR10MB2963.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg1/Z2mWmOIh3e7lzDH0HAaR0+LJY2g6hzgZXfhEUStQgg/trg6zrKa5iigqlyNrWRnLMfYwQF1vZc9Hxlm7CDhtQCyKX4uvmZboDkiAlzCV2UqP3Ydb0iMYxN4hMq3kj23dBqxBR6l01Oiz+6Zmcxv7e/rlUJ97wL8sqwRMpnNiXzzU4FYKiHq0WX+T3xkDvpcDTO8WPi1hzZwiUKvy3SfPPkKlxWp33EVPMwg3h24qc13W14Yj0lsL2EKU2Tjg+kPsEl4chRel6kkyItomMlDS3iNZS6wRHjIMFWhyXcsifHsr05bSmdIEU7BX0J4YV1WRcIGnIlPol0/sfq8nu0DQ7abht3DhehBy2ANZN0B86KkQAjASIiwmVmad8/3DeoY0B8dWf7uqucmK6WWeUu+N1aR1Zu3IoOH5Iw38XmcRQJBVNya7MSs6wLdPqDm1ejUXw0zYykF/oWvwf4hw/ddeATFO8n7f4mPC3oip5hl/2LKYIlYljOxeIVA/fk2liKyn5gh/0b9Ow+214mnrN8Ayz2SUxgjJuXoetDIUp2S5tYCQ/tcdFwbty1J7gjpp9t+abvPkktg6jw6GMRIVBggKa8Px70yfncdLxxu7unU00a4/7DvgajmXzxhp1c324plFFaOosZj3PW5jsGLJ+Fg04IvwNcpjTXNG5IfjEvxRKDK1fZxdx0+slO8dSsHbVKc4QNq758rYsJcOQ0sebN5JesCVEvNTFkTmzEsy7eDNtmKpeI9++dQad+DqmMCh3JcUhXH2ticVwi3abYndj2wBQNIHQaVUbtjC0uVCcpzZOniAaBo6FI639IJh16trZzgqEeMx7Fpktl6LnPJtJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(186003)(26005)(52116002)(6486002)(2906002)(83380400001)(1076003)(6916009)(966005)(316002)(9686003)(86362001)(4326008)(66556008)(8676002)(66946007)(6512007)(6666004)(8936002)(44832011)(5660300002)(508600001)(38100700002)(38350700002)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rb6tFkb52JP2BZJQawznnj7UtJQzWbimi0G4n8LH8m9f/TXDnKveTljduxfb?=
 =?us-ascii?Q?f/06/dx5KEfXtevTBYAYKxjbfK2F0S4sf1Y3uxD94pW145+PYcF5JASAof8U?=
 =?us-ascii?Q?AIKT1g++HgmTu9zEIVI4Fye95dmYdp+28s7Jl5SZg6y4NUbMJr33l+u7Ozc0?=
 =?us-ascii?Q?GnpmdjptTH0Q0d81W24YLgHmW2rwVCELIneWvMhv26E/jdpjhmdZexZ7caMy?=
 =?us-ascii?Q?RlbV8tyVfadUhUBOekIZnNkDX+u/LfiHmQA1hcjZAqawx2iDOaUZrUJ3U1kQ?=
 =?us-ascii?Q?1nI0nd6XVIGGthphmk3IoTRw0MeauAy6rAk/NQbgNh3TpwcuGVwKkxLmnTh1?=
 =?us-ascii?Q?egfgdQ3QEYpABlW1uf9r2qgdEMbrTv6kYhvQ24hjKxQZNeZKlmrE6PAM8nPy?=
 =?us-ascii?Q?KeUaF+LZoeIChw4zMFqBMmNAuWuQ07uZ2YqOroOFJ5oH1e0+aaPl8T4fg2kp?=
 =?us-ascii?Q?eseEm0cUf8kTRVA0JTCW38TeXXyAeM0/88eIGz+XYYpy4qd+WxxuNJGnMbZ5?=
 =?us-ascii?Q?uyQTIPHvP/6/yHcSfZBwosZqOj88vgB+Y5Jw8ukRwRAekIgoT3ZaN5n8JpOw?=
 =?us-ascii?Q?YYoDzPNxQ3FO+fw8QhS4M0glx6fHLJvHJEyRccAfnijyn920YiyuqAvuueb+?=
 =?us-ascii?Q?ZQNdD4HrKcHOGdYp2Jy8Mdn4IRMR6koCSWgjepuJfmvufCL6xdwuUcSZupva?=
 =?us-ascii?Q?sWVQ3OFbAYBV+syo9WvFE8Lt+I1rohHPdA38vvbTXZcvjrlnz6A0AteJ0g3o?=
 =?us-ascii?Q?4/+qXpxB8vAodfOzXOxH9sHVEc658YOoEhymZuYG3oRNLZroa7ZLcolH6qdh?=
 =?us-ascii?Q?JrDL/YNyC1mZrdbpzztHOkw9wWwnk0o0wNUstbGtExOpxjotCL/TIcJiZIx8?=
 =?us-ascii?Q?MHGTco2+9yIntK/Mon+TNBHwT02ja73CJdi5bJj+5TIC2oCfU1qX63c7yrZ0?=
 =?us-ascii?Q?hDHUvyueObNu/l8zZDPGHARd64ajsTrapRYarehBhH38uQUQuxHCDgePk8e2?=
 =?us-ascii?Q?/beK5azqCu1Nyh3iWlY3SXszy6QqJ4fd7NSqGMFLYa7fBy3d7RBO0w1y2nBC?=
 =?us-ascii?Q?rRdAWkpfoCVDy1Yt2YTgjZeygO7sRwyO945wiD+Urc+mvZedF64iqG5kXWLi?=
 =?us-ascii?Q?Gqi5/2JgxYswYcZnu6xbSOpfJNWreCPk1uWQbhxPIb35M02d7nFy45Of849W?=
 =?us-ascii?Q?0Uz69OrZzpILJ9Vh0kBnPRQZmcnW8M366fldaSaPululcSbNvGB+KpxXUZRU?=
 =?us-ascii?Q?WDu5Y593OMNehV/OPZCfT3wNXynFHf8xqrjBno4rAa+sYJgnl63uN7qNlJec?=
 =?us-ascii?Q?XpRIPYdaWvAY3QQo5sjoxje60ps9FwzYHCtr67eNrIlnSpRloq3hDR5bvoWF?=
 =?us-ascii?Q?IGxbYV1DInALZVuQsGb24c+30lJ74PvdIelbzch82tK7otVBbdcbL+E5kDA0?=
 =?us-ascii?Q?bnVTfuyfsRF3fMpewiayDkpb+HCTm06/WJP+5T77i9TPpNJGOGmJGSjJgAvp?=
 =?us-ascii?Q?XnjMGugvlH76T1wviohElGShSRn4Pnb10z/3wX/GuHPU41b3AMoeKOxdIyX1?=
 =?us-ascii?Q?Nztgeg6ReDmi5BivDBJUjng6FgznK8qvKpOmozz/afVNuCKhaLzWvye5SPBk?=
 =?us-ascii?Q?179InfBwqZ3uROzNvWw4AbTTVruyAdfhVwI4w3sWIjwpitRs7nDs1kOX+WZE?=
 =?us-ascii?Q?EkA+tERMBSRSdgPq7uJWuoOrSqf1XdgZfDtU45VENJ7GePNMd9D3j1PnQcyF?=
 =?us-ascii?Q?b3tjUgSV9SDEh+cuzoSuRkqMhN/u/KE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f3f881-37e0-4e61-51de-08da44ada09a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 15:36:14.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1ND/iabC8HeTqm75t8ihT9suVTV94GBystiM6rbZt1083neBEVUQ+o+JLBYgUR6kbVZjjZ5Ep7rxBHYvQ+alyDktAK5GYpgyURi5ED43nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2963
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_04:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206020066
X-Proofpoint-GUID: h-Fc8W1-E_IcG6ZOVbhd7UlhXazZEsYp
X-Proofpoint-ORIG-GUID: h-Fc8W1-E_IcG6ZOVbhd7UlhXazZEsYp
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1fcd9cea011a657d62ee332d161966c1ec92ffd5
commit: 75be7c3d8d488788289ec6e343e138db5a2b2440 [150/401] xfs: teach repair to fix file nlinks
config: microblaze-randconfig-m031-20220601 (https://download.01.org/0day-ci/archive/20220602/202206022146.2RgP2bEQ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/xfs/scrub/nlinks_repair.c:80 xrep_nlinks_repair_inode() warn: missing error code 'error'

vim +/error +80 fs/xfs/scrub/nlinks_repair.c

75be7c3d8d4887 Darrick J. Wong 2022-01-06   42  STATIC int
75be7c3d8d4887 Darrick J. Wong 2022-01-06   43  xrep_nlinks_repair_inode(
75be7c3d8d4887 Darrick J. Wong 2022-01-06   44  	struct xchk_nlink_ctrs	*xnc)
75be7c3d8d4887 Darrick J. Wong 2022-01-06   45  {
75be7c3d8d4887 Darrick J. Wong 2022-01-06   46  	struct xchk_nlink	obs;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   47  	struct xfs_scrub	*sc = xnc->sc;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   48  	struct xfs_mount	*mp = sc->mp;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   49  	struct xfs_inode	*ip = sc->ip;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   50  	uint64_t		total_links;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   51  	unsigned int		actual_nlink;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   52  	int			error;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   53  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   54  	xfs_ilock(ip, XFS_IOLOCK_EXCL);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   55  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   56  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_link, 0, 0, 0, &sc->tp);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   57  	if (error)
75be7c3d8d4887 Darrick J. Wong 2022-01-06   58  		goto out_iolock;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   59  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   60  	xfs_ilock(ip, XFS_ILOCK_EXCL);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   61  	xfs_trans_ijoin(sc->tp, ip, 0);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   62  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   63  	mutex_lock(&xnc->lock);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   64  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   65  	if (xchk_iscan_aborted(&xnc->collect_iscan)) {
75be7c3d8d4887 Darrick J. Wong 2022-01-06   66  		error = -ECANCELED;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   67  		goto out_scanlock;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   68  	}
75be7c3d8d4887 Darrick J. Wong 2022-01-06   69  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   70  	error = xfarray_load_sparse(xnc->nlinks, ip->i_ino, &obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   71  	if (error)
75be7c3d8d4887 Darrick J. Wong 2022-01-06   72  		goto out_scanlock;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   73  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   74  	total_links = xchk_nlink_total(&obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   75  	actual_nlink = VFS_I(ip)->i_nlink;
75be7c3d8d4887 Darrick J. Wong 2022-01-06   76  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   77  	/* Cannot set more than the maxiumum possible link count. */
75be7c3d8d4887 Darrick J. Wong 2022-01-06   78  	if (total_links > U32_MAX) {
75be7c3d8d4887 Darrick J. Wong 2022-01-06   79  		trace_xrep_nlinks_unfixable_inode(mp, ip, &obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  @80  		goto out_scanlock;

Needs error code

75be7c3d8d4887 Darrick J. Wong 2022-01-06   81  	}
75be7c3d8d4887 Darrick J. Wong 2022-01-06   82  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   83  	/*
75be7c3d8d4887 Darrick J. Wong 2022-01-06   84  	 * Linked directories should have at least one "child" (the dot entry)
75be7c3d8d4887 Darrick J. Wong 2022-01-06   85  	 * pointing up to them.
75be7c3d8d4887 Darrick J. Wong 2022-01-06   86  	 */
75be7c3d8d4887 Darrick J. Wong 2022-01-06   87  	if (S_ISDIR(VFS_I(ip)->i_mode) && actual_nlink > 0 &&
75be7c3d8d4887 Darrick J. Wong 2022-01-06   88  					  obs.children == 0) {
75be7c3d8d4887 Darrick J. Wong 2022-01-06   89  		trace_xrep_nlinks_unfixable_inode(mp, ip, &obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   90  		goto out_scanlock;

Here too

75be7c3d8d4887 Darrick J. Wong 2022-01-06   91  	}
75be7c3d8d4887 Darrick J. Wong 2022-01-06   92  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   93  	/* Non-directories cannot have directories pointing up to them. */
75be7c3d8d4887 Darrick J. Wong 2022-01-06   94  	if (!S_ISDIR(VFS_I(ip)->i_mode) && obs.children != 0) {
75be7c3d8d4887 Darrick J. Wong 2022-01-06   95  		trace_xrep_nlinks_unfixable_inode(mp, ip, &obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06   96  		goto out_scanlock;

Here

75be7c3d8d4887 Darrick J. Wong 2022-01-06   97  	}
75be7c3d8d4887 Darrick J. Wong 2022-01-06   98  
75be7c3d8d4887 Darrick J. Wong 2022-01-06   99  	/*
75be7c3d8d4887 Darrick J. Wong 2022-01-06  100  	 * We did not find any links to this inode.  If the inode agrees, we
75be7c3d8d4887 Darrick J. Wong 2022-01-06  101  	 * have nothing further to do.  If not, the inode has a nonzero link
75be7c3d8d4887 Darrick J. Wong 2022-01-06  102  	 * count and we don't have anywhere to graft the child onto.  Dropping
75be7c3d8d4887 Darrick J. Wong 2022-01-06  103  	 * a live inode's link count to zero can cause unexpected shutdowns in
75be7c3d8d4887 Darrick J. Wong 2022-01-06  104  	 * inactivation, so leave it alone.
75be7c3d8d4887 Darrick J. Wong 2022-01-06  105  	 */
75be7c3d8d4887 Darrick J. Wong 2022-01-06  106  	if (total_links == 0) {
75be7c3d8d4887 Darrick J. Wong 2022-01-06  107  		if (actual_nlink != 0)
75be7c3d8d4887 Darrick J. Wong 2022-01-06  108  			trace_xrep_nlinks_unfixable_inode(mp, ip, &obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  109  		goto out_scanlock;

These looks like a success path

75be7c3d8d4887 Darrick J. Wong 2022-01-06  110  	}
75be7c3d8d4887 Darrick J. Wong 2022-01-06  111  
75be7c3d8d4887 Darrick J. Wong 2022-01-06  112  	/* Perfect match means we're done. */
75be7c3d8d4887 Darrick J. Wong 2022-01-06  113  	if (total_links == actual_nlink)
75be7c3d8d4887 Darrick J. Wong 2022-01-06  114  		goto out_scanlock;

Success path

75be7c3d8d4887 Darrick J. Wong 2022-01-06  115  	mutex_unlock(&xnc->lock);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  116  
75be7c3d8d4887 Darrick J. Wong 2022-01-06  117  	/* Commit the new link count. */
75be7c3d8d4887 Darrick J. Wong 2022-01-06  118  	trace_xrep_nlinks_update_inode(mp, ip, &obs);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  119  
75be7c3d8d4887 Darrick J. Wong 2022-01-06  120  	set_nlink(VFS_I(ip), total_links);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  121  	xfs_trans_log_inode(sc->tp, ip, XFS_ILOG_CORE);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  122  	error = xfs_trans_commit(sc->tp);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  123  	sc->tp = NULL;
75be7c3d8d4887 Darrick J. Wong 2022-01-06  124  	if (error)
75be7c3d8d4887 Darrick J. Wong 2022-01-06  125  		goto out_ilock;
75be7c3d8d4887 Darrick J. Wong 2022-01-06  126  
75be7c3d8d4887 Darrick J. Wong 2022-01-06  127  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  128  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  129  	return 0;
75be7c3d8d4887 Darrick J. Wong 2022-01-06  130  
75be7c3d8d4887 Darrick J. Wong 2022-01-06  131  out_scanlock:
75be7c3d8d4887 Darrick J. Wong 2022-01-06  132  	mutex_unlock(&xnc->lock);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  133  	xchk_trans_cancel(sc);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  134  out_ilock:
75be7c3d8d4887 Darrick J. Wong 2022-01-06  135  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  136  out_iolock:
75be7c3d8d4887 Darrick J. Wong 2022-01-06  137  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
75be7c3d8d4887 Darrick J. Wong 2022-01-06  138  	return error;
75be7c3d8d4887 Darrick J. Wong 2022-01-06  139  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

