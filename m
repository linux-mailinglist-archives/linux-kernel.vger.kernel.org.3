Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CED51D411
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390364AbiEFJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390359AbiEFJRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:17:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2763399
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:13:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2466apuH027626;
        Fri, 6 May 2022 09:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3kO/3mlWjEKxc5NBxP92DBb1+KZQpS0UQvrtGbYOf40=;
 b=NZkGyTdX4V4YR/2dZs3rx2u6nPoVEnaX7HJmg0uFtb/pkmdRKkj5j0DUI0uCEfvqebjl
 Dn3y29vDYCP7WAMwNJDrmETtB1Y4c5xO9bm6ljfS0WRe6SXYOQvjWUCU1i/xJmo3aZva
 ZjtNyEG/IBEYZnXDNa9UIJqEcGcr9iTJ45rxoxD0L3AmzcUqpMVJH0QcGkmnoCBOCJ9b
 mLbjrr1Ke+b8HN2a/NvTh6mripVJ8lUrGvaPDU0p0WeHztY0KTI9xlxRgvwv08TnQfJu
 pZOgy34MUKo43/ClYb+7rEVDPi+HDyq4Xw+XhbYEy5MvtysQaF8XwfJfIRUhIk8y+SXR kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2nku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 09:13:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24695P4x038945;
        Fri, 6 May 2022 09:13:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a84q8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 09:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbx5WsUGQxPVl4gKxmZUg9VR+Sh24mmbQWM/wgNPVqJzr/nQqdzeAJitL1UxAgoGvRVYB4TUV7s18+ZXvQqc0rb5aYsgm3L6CHczfqhYB9sCMB9ASzYK6Z+THR0qKHyg5h3Ldc67HC1oEDbBFCfKkupkBtIjjdYA9mQ9b3tccybJMsmCY0ZFIoZing/gRBkEx7OBDaUIbxTApFr+X+8CNXTWKb2ZvJ+cjvI7qryeoT+haHplPwd300FiqmMWQjsiv43ASsAupUkCaBG+bbot0EnF/NiPU4LY3kIE5SsTrihfZvfEGhB38ET8oIkx3pt88SWzFbBQsxB/AzlHvfRTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kO/3mlWjEKxc5NBxP92DBb1+KZQpS0UQvrtGbYOf40=;
 b=KZIQ0dQZsaDlwkiPkZ+GYFbKGV9v365Q/0eEPbhyCOQuAvpHxe4Q6sSM4snaKIV+/KewiuxSeB0/0/hh0hbA9cia3Ck8ycu3ftmUG2+M/6ZWexgBJl+Q0nHrBM2c0bTw19cqmyCmz4Fx9NHnilLr0zzJeorgNRaMcV49hjF35iQVFhBMXMztiDEPSkSdDJ6lisG/N/WZn6vD59MHIzuBlf2Ilc7G1m0MbQmRWyQypCUnkB6yNRV5EjMvdV9G5q2JnaUAFH7T1eARj1xjBtCxvPCbqH1U/yJKSnIQx2kH34M7VfVfBZ166ma5gCQwueB8wZFvNGglPL4pxfJSAR1/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kO/3mlWjEKxc5NBxP92DBb1+KZQpS0UQvrtGbYOf40=;
 b=tmDqAaI3/3nuQ/njYxK/LL8B2LFypNdvCjww2UhpQW8nqDk6SEvbftLcRxzYKgdAHsmym0EBSpuu6FX18qI1O0r12JWKkqMlKMEFRrniA3la/sygT70hUhCRrEXLTaWPPDzAdPFFh4+OCpZ20GylFDybIR9ee8Oyx1XOlhrXvzg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3388.namprd10.prod.outlook.com
 (2603:10b6:5:1b1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 09:13:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 09:13:48 +0000
Date:   Fri, 6 May 2022 12:13:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>, kbuild@lists.01.org,
        lkp@intel.com
Subject: uninitialized variables bugs
Message-ID: <20220506091338.GE4031@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0102.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c57a2fa-d5cb-4427-902e-08da2f40baa6
X-MS-TrafficTypeDiagnostic: DM6PR10MB3388:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB33886C3F390B1324F9A9B29E8EC59@DM6PR10MB3388.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5Mcdy/auAYNX/rsB74B/LP0YGawrFshHWw9ijea16FIiaCNzAvPxIB3FrDrOhMt9+nzVHNpw7J0WA+r5A4p1swBxW3DxXN4EabUPOrqwYZfmXgjeCSJqQFcRXQ05QY0h6/fS8w1Es7Liay3JJM66kuZq0igIHiFy0emJBwpZ0BEW1WZHN8SGtX+sqVedSymghzidiyOT1Ke7PKqiL0MJWhsbx4bagEjkhOSRvPaR7JTKQfxlNvmEGvTPsZkD11IA64lWQ+unEMClT5Y6A8dECUdtQcds8qIPkCBbqFsQGMn0Y+brLq2gOsCCzg8S5AR1f72LGvcLd8l2b8V5YY7i0C8Rln5ENM7YlvthmAnBUIdUIE/u6xgbjdhe8AjMYDLqPSnoG4f6B4X1fVeNmZoEU8fZnSFwyoZss4hp2mj8JOPEfvBS2WMAMA6dNpbncj+pKGLpTGrp4T+JgU3wDHxMNPWCBGrx7AFhpYc8jnCKShX3u+IT5KTZMBjfU2CYwthujTvjdhkWDTVZUpy51ihlwfOuPu1IWOw09tlIxUjCoNvxQ+jZpTloOJqg+uiat761U+5pNF+27gd/Z4qKiOdk0awU+5WdsbuBzarcjVZKOkLYTe5kZ6aqOhOzkSyoYVsRgAri+wgMLVfi1Spbuw1gITB0K1bvWdUi5/ppbkuAMtWyZ01OiY1BSsue+rTdbveiZeiRXQHTbwSNABi4luv1QKBn+WEuKNc2A/9t1/XhngFzTm9Th/S8Y5txtSsrMgmvWDWsWNwYJTsupkHBnqWwDLL8Wim63S7Kpf2K6ZbIqe+eY4AMdPWGJBZLng7Dmur
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(1076003)(9686003)(508600001)(38350700002)(38100700002)(26005)(6512007)(6486002)(966005)(66476007)(66556008)(8676002)(4326008)(66946007)(316002)(186003)(44832011)(6506007)(7116003)(33716001)(83380400001)(8936002)(3480700007)(33656002)(6666004)(52116002)(2906002)(86362001)(133083001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioAA8HyOH4X9T2RSdtevL28CWUwl9S/zzSgsG89vd7xhjmJb4fuMviyVXiSK?=
 =?us-ascii?Q?uyZZ3sFszbAU2QjkCKhu+RJ1AoMagp3Hr1Kn8UUhQDA9yEGw7AcDd/oKlby9?=
 =?us-ascii?Q?h01fvS+WQ2ganu1sF1Pi8fPM6WHwBDANLOv74SijLI5h4OvqgftsjC46cwGn?=
 =?us-ascii?Q?+ZyDcqbj398f9R2HdBF83jn9ASDwcqC0KlgYPw3pipXChtBrw1q0GKE13JmK?=
 =?us-ascii?Q?VNql0Dxc4X2YJmQIzPofy3JmqOojmXJvMNN7WTvbv2wBiz1rb+tm6oj6v7Lp?=
 =?us-ascii?Q?RIPPMJiF+cclW6X2/7CIWo7Yu2FfbEXYL8a2c/goWR/z8me/Vc3kOHm+DwhH?=
 =?us-ascii?Q?ypBcHREaPOIHq6u5qWMd16u6l2R1VnN5RTvYSMyikPbP1o2pUmniNQsqpQ5G?=
 =?us-ascii?Q?CFt03FnIEOEwy3qmzxTB5oYZfFtuKB04KQ6gZtTPnftyiFeWadYQV1iCJqO8?=
 =?us-ascii?Q?xVijkmmC4vz3wkgbtsVf2aS5CisV/XR9TG2UtBEyuAQ8M0P4tskpS1NAyx2i?=
 =?us-ascii?Q?ygQuv+GSSqbw4WEf/gIM5SzXmLeIIZ8vWLKksbmCXOYZbGE/uOk0ftv3tNf4?=
 =?us-ascii?Q?tdWqMdXcJNwS41FwlbDo47xzD0uOcLuVhc1lNjoaiSMwQH5qS4+dmLazoIhq?=
 =?us-ascii?Q?EV+ykW7ogEBb7kw3HgCkzb/QlaFALYINvhDPiEps/4EIG/9OC4RhHw6d57GA?=
 =?us-ascii?Q?XViBBvMyLYIQNmWF9TTxsG1U4gAunXEQXEfBqs3KVzCTE6QEjr2NSE/H+5h8?=
 =?us-ascii?Q?e21gXjTsShFbSGF76PMPYMxHcrhtU8mTAdvzI3+WMqm9Sncw24jmWRp7almv?=
 =?us-ascii?Q?XZ0VRXZKwczgoNC5qxHQJyYyVI69yGUpX8OgqEk7CHLuEP6d9UU1QfRFuHNq?=
 =?us-ascii?Q?Chmo/g2cpCen9Ff5pdTf+PweeO0de60Npcq96909zK16YgjanWJMmO0QN04J?=
 =?us-ascii?Q?AYYLzMtwHrN6fr9plaD8CC19wQKiV7InL9uPPp8ghNCLEcwjhlgyNllov0sJ?=
 =?us-ascii?Q?s66TPFhcsk7NYCegZet/ijzntAonMWAlWi/8k8l5gSNLnVYfv5sHu8QEdkl7?=
 =?us-ascii?Q?xQruoaH46LGTeudcm88mBcrpn56CEN8nrp26VIhoFWBzK/Jbgc4lpLnmBABP?=
 =?us-ascii?Q?3k6VvxjQUHDxXVUtj9zUITzPg9vn+ptegTJxM00ZS8ZZnykEMAeJS3LikQPM?=
 =?us-ascii?Q?SPLoNOxkfinug6jyiXfe/al6ajxSpTIweut0m3kxCtGOYpCHHrFAwK635uRn?=
 =?us-ascii?Q?wQloGie7Wno+ZMEKRAHQAcVwA9RcYx4DTHV7BBxpBHl6CDFDAuyV3ywXTE2J?=
 =?us-ascii?Q?jB2efWc9rbnsIkDflnCSFeL0PYxFjuhf198T38eP6ePnSVvPy1KQW0eevmxL?=
 =?us-ascii?Q?DZZy9Ip5W0KK3ofuVLidMmAriRyj9+TJUtGon39erhEkjnLzUGTftejHepZi?=
 =?us-ascii?Q?Bb4cXR6LdYNcTUxANPxBEBCWoUEE+HNDqybAvDeheLqXsoIa9nTe8HFWv1A5?=
 =?us-ascii?Q?U+EC051/DBySaf/lEYx/XwEEM5a9dUT4/PaY0FPvaNYtj3ypf8Ef9qCQnTVL?=
 =?us-ascii?Q?W5k6zZONsQrPU6VkUgkKeuj3jx2kZ9GH3O37FUPZVLJMnajB8n3bBnlmiVZs?=
 =?us-ascii?Q?uSFEXFcgWAQ5jY4zotKSon3j+7Qk962SrM6/SGCSRj6ZmAgNzSf1Pfl9K7xn?=
 =?us-ascii?Q?Q3A9MbWeTXqoVDe/qJ4nqaJSjBRxfgyhMpuLqm/sHNI7+yt5f3tUmJZW8Rq7?=
 =?us-ascii?Q?vMXYF/12vZcFHSP20H4QtI0DDELU8Ao=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c57a2fa-d5cb-4427-902e-08da2f40baa6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 09:13:48.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpxSrv9ZlyPkhKqqal5XYa6LIRos+jZ96HxuODByLTiJ3MtiTKl0ofdy3txo/6ZVClt4y0paZspBHvt7b/Ma6tQ5PV3f7ZRsTVaEXxv9VWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3388
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_03:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=806 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060050
X-Proofpoint-GUID: 1wUKhEZbXeLw-OU_hI8hrv8Vxjy_Tkfi
X-Proofpoint-ORIG-GUID: 1wUKhEZbXeLw-OU_hI8hrv8Vxjy_Tkfi
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since commit 78a5255ffb6a ("Stop the ad-hoc games with
-Wno-maybe-initialized"), GCC's uninitialized variable warnings have
been disabled by default.  Now, you have to turn on W=1 or W=2 to see
the warnings which nobody except Arnd does.

Disabling that has lead to a bunch of embarrassing bugs where variables
are *never* initialized.  Very unsubtle bugs.  The bugs doesn't reach
users because Nathan Chancellor and I review Clang and Smatch warnings
respectively.  Also the kbuild-bot reports uninitialized variables.

It's a lot to deal with.  Uninitialized variable bugs are probably the
most common bug I have to deal with.

It's frustrating.  Sometimes the false positives are hard to analyse
because I have to read through multiple functions.  A lot of times
when I write a patch and a commit message Nathan has already fixed it
so it's just a waste of time.

It's risky as well.  The Smatch check for uninitialized variables was
broken for most of 2021.  Nathan sometimes goes on vacation.

I guess I would hope that one day we can turn on the GCC uninitialized
variable warnings again.  That would mean silencing false positives
which a lot of people don't want to do...  Maybe Clang has fewer false
positives than GCC?

The Smatch check for uninitialized variable was deliberately written to
be more strict than GCC because GCC was missing bugs.  So I think
leaving Smatch false positives is fine.  There is a trade off between
fewer false positives and missing bugs and Smatch is meant to err on the
side of finding bugs but with the cost of false positives.

Most of the Smatch uninitialized false positives are caused by loops:

	int i, ret;

	for (i = 0; i < bytes; i++) { // <-- what if bytes is zero?
		if (...)
			continue; // <-- can every iteration hit continue?
		ret = frob();
	}

	return ret;

There is also stuff like this which is harmless:

	uint val;

	ret = read(&val);
	*p = val;  // <-- uninitialized variable if read() fails
	return ret;

Btw, here is how to run Smatch on your code:
https://staticthinking.wordpress.com/2022/04/25/how-to-run-smatch-on-your-code/

regards,
dan carpenter

