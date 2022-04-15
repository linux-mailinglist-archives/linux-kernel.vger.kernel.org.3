Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320105025DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiDOGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiDOGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:52:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F863F328
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:49:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F4WAEj014133;
        Fri, 15 Apr 2022 06:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OSibx4SVmEgbkxIARod1TrCsW2tRv+aMeNMJh+gWqw8=;
 b=scP5ycEix6laF1YPqJssaQdhFbTI29C3jqkDe/YSyAfiGysU8RLvexywQ7Vmp/8qreHY
 SGVozIxoCf1KQW56vYlIziCRCsrj0G0eOCxXSnrabD100cfbbmMnt5zccMbCRDt3jj/g
 vvCKqpc5JqR4KJite892Oz2v4SNNlqZ/jvMalasMEBdwZI7cNESPHhppo+0S8XASYY7Z
 +S4MZf+IAtgpHthU850mm3cqgOvASS8UkuGP2aWtK9ZsL90Y0uXXia8AA85ulZUbagne
 aUYiGbFVHLXS7v9b4RgXUjjm0Xams1Qru+n+GwfJsFnz/S255lAxdXpzwnzvJ/atj0j4 jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu6ukr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:49:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F6WPeA003831;
        Fri, 15 Apr 2022 06:49:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9mfnkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLMK7oW4Wez9SHqtaKxej5gnBIHn7GpqOVCIEvMXoqCOgbgBerx6Gyt7ErEDHv8oviGnPRGZw8bhhY7Qa18iTIfYuJeX3J1A4YAcyYWCRUIpe1Bj6RkF4VkmF7QSZrJHsP8wQTRxXEnWzSM5DxQDxoFi9O/g4GCpsutIQdvi2Us+Au21lNUOsCfV7qJB+6INQjykOT4gZEhLXwRut/PDB+etmjHgNNw1TLp8dvwUAyKY3NiJzEeu+G0lqOXRuMkBBxuLyR4Ms0KROd0pgNly4LuOFeR7su++o2NCAEZEEaR4FfSIBlsgZbEro5HaLwnxxL847zclIP4PxLMIMvASIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSibx4SVmEgbkxIARod1TrCsW2tRv+aMeNMJh+gWqw8=;
 b=Fq+DJIA1JYVxu530oGPHP0tv9Sb6dlmtv0QZiKSO3Ra3ZIBCQjNagNctfz/jPz6Pdr1tpSXX8AiexWRo1BOASudmVRnHF89nLOe3neL8jXwiUQhytZTpSlktE4A+Hzwy2Feb1+i301fb6WHW7JnrPWIA5v53zM7qZsh0C6ZUhQUbzdWRP+YXSSbePjIJBFIUTJ9ou8BYTcYLRiJva+NsWQJmQoP0443svauJOqz+UeyfbwGjwLmS/WIcdu7TMRz+2fFgNj34pLFJrgQ4Dui8qrdKUpoFBy1K7h9/+YjZ4Eo7JMPPtpFNAY7/tLVaj8nbsvK9u/Af3Z8/wFRxjmz73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSibx4SVmEgbkxIARod1TrCsW2tRv+aMeNMJh+gWqw8=;
 b=V0kki6YRvunPjhf7tlinCIpKPbXZkuif81NSN6egb7TOw0mcOnaQGdfQ06SaonA9CNTAI2yL3yGR026YO2nkhI4Ntsm47LduFNZw+e6XU/NfsU5fF6dfDsLzO487JOwxUOszFZKzyaRw1cVzpZqIKhP9DcA8s+3ofB37Ml97w1Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2317.namprd10.prod.outlook.com
 (2603:10b6:301:35::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 06:49:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 06:49:51 +0000
Date:   Fri, 15 Apr 2022 09:49:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [krzk-github:n/qcom-ufs-opp-v2 14/16] drivers/opp/core.c:1215
 dev_pm_opp_set_rate() error: uninitialized symbol 'ret'.
Message-ID: <20220415064941.GF12805@kadam>
References: <202204150900.qnJMf3Gu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204150900.qnJMf3Gu-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e2a7e48-7367-47c4-d8c6-08da1eac23e7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2317:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2317F65358DEF0DFDDB80D458EEE9@MWHPR1001MB2317.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwVIehKGD5dWUH0eGWT2sSaTnRQ6twgeM3SU5MprEaqNQRJA/tWHIE3KNSO5pRd2sI5yP/S6Lf3SS/pB7wFa2ufXsk5r8VIy2qAWUol5gM9SAr0NHnRvMjy5ci4eE8hSvrH5NrXrjrNkDb8D/H6pvr0NXlxSjHmIQC1yF3STgx7A7sOfqAJvQxrlVyIx3KFmeopIH57PiLXsMWGKrXG6/BD9BJ804JgRU9dBDV5CInORgnGDmgeP/dmVPWm9E6FSRRDSNLH19/M7+8gh9y4vMYoz+AlmPFmi2jtxCjcXqlnYKzuHWDjaXNdqLeQoQoyeicVw2FzRw7YRzcEeJ2SGqK+6QL0Uf3Ub4IF3YhvNNJBCZWYWE1UFwDvqSbgqjPYcR+dD/zMeVQYhJo2fpKngGrdWk90IdzTS5SkoWttO507Aw7KDeO9BG7QKcTE68u4O/sCkwxPqrwVJHTofsvTYjTm0rYvGNnvFPTzsldFcfqvGGKqnnEMbMrPYBmHOnQ13X8lElIC3xEhlCI7gdbcIXAthrQKqTj20mSywEUs37YrjQz3telY4a++OYiR3jJzCFOYKHI8hWtinO3zDYp5J59OhFf6gHNjj5ZsK/WFY7I1yTwR6yvbv3NHmyKg5dprEZh83mkN0XxGK/mu867aYEYWnG/K5bvsvdHU0ADF25/5iYKcQijBAxyrfwuvXGfIFSHnS+4j0z0rxZDVI49l46WUp02X4gtEnzgV+0hn7S3GJaOJ0R8HW0B1AnXmfEu4oww0Mv7swfuEU/F7xUe8EWgpe0uYIjMqgPFVtOwCPk4uyTyS5oq+AgMHPyDgR70k9e7F40b2eb3ZjBWKjmZ5goA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(52116002)(2906002)(8936002)(5660300002)(33656002)(6666004)(44832011)(86362001)(966005)(1076003)(6486002)(4326008)(66556008)(66476007)(186003)(8676002)(9686003)(66946007)(6512007)(26005)(508600001)(6916009)(38350700002)(316002)(38100700002)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dL/7vsmVlZHEoszUU/s6Wi/hhQMGo3Dl67pSalqJF+aOGhvwXUdNi1yI7RN5?=
 =?us-ascii?Q?mJYpilPc1LJVF85wjGDHBr2OfcAW1avskcpZDzBtlYsLDQKw09gRW3mkSWCL?=
 =?us-ascii?Q?b1YwrGt3NOemF/tf4u/yaNLWSkVey6Usoz39BtZ7NcDhEO5hIn3cNHdrCcbH?=
 =?us-ascii?Q?O2zOXdSzf1bG4JwRpBL5m/4uKIzF3DfbRHNEcldz+oKSs5jukJoTKkQUgaQp?=
 =?us-ascii?Q?ZPGHWF2Z2tivEpHCL0INe44lC6AnLfRUgGuD5QKqEvLe/O1jdJ9YngXN6Zwg?=
 =?us-ascii?Q?s8jGCG/txP15FMKCY8mFuq5Wccf8JOag9w61DUQGu7KUoLYaWdrgZeH9w834?=
 =?us-ascii?Q?IDj6KKWiWAYdPfrF3FU/W57DTxsFz8snN5+D2dY/B7B4JxcxLm+dJLcsX+i/?=
 =?us-ascii?Q?8pFl3fW6+lH7gkQqB/+XFoVjPoTcQFocazkykyzNMGgjJA77eFSQW1BXZEXP?=
 =?us-ascii?Q?ejD3DZJViaZy9XKTP2cV3Xtuc/L+s7EulVoFELtk2v/7w+siI7rl/ed53PKy?=
 =?us-ascii?Q?638v+lzedpM7GR0WLva9cvhkYlI3mBntwa0lls9w4koNqd8OexVeGHSbZpcv?=
 =?us-ascii?Q?NHnYNSwmsaMEfq/PllC6QEv8lvINMyyxppOP5qHlrQYLidp1U59zVBKYOW57?=
 =?us-ascii?Q?Fp5JDcvoV/nB+icboJpTyUuSS8l/nyZUGarMibiWg42JjUJXoe4SJJFgvehN?=
 =?us-ascii?Q?JAZYw/TTXeuOLH5ytm/qz1n3YknrxU5vsm729eJ7nFd+BdmYLFSkJR6f3NMt?=
 =?us-ascii?Q?Dhb7xLs2jPHjM+kbWZkYU4cfN0ac6Oc5pupdFYOi71bXM676o3NRaibHei+4?=
 =?us-ascii?Q?apfz3YtsbzpJaYMVAG5IIDEPBOr5HSzswm+AG6XcyvTYvq4y+6G3ZJy3KN3O?=
 =?us-ascii?Q?5qv+p8Ozb4GhEpaWpKKKtln2KfWMB3Azy6U9Tu+U6z7pkU8Bj/RpdLdIGCjm?=
 =?us-ascii?Q?u5SgxAytD3BxG/baU4yWpymVdHapY2Xmn2K0DzMoSMcydbzajcYWvqrYBbo/?=
 =?us-ascii?Q?KmOGkEnDMqdHtM3g1SXZmYUg+2L9Cf2q85Hvs7YcpklSGvWX0GmL7lFZyzqk?=
 =?us-ascii?Q?skgmIb3Ot8SojvmqIYnHzfb5pofbmDKhuQN/p1PJJFISkXB5CMd0jcISE9f2?=
 =?us-ascii?Q?vC1VJZYvdJcWkAG2UDyFlpLkepOV0AwQXR6Y9H73AZdCXiuIXF0HbehqfBKa?=
 =?us-ascii?Q?h7j0QixWHwCZmH+00CtMsnKBn9l25WL6UH1j/5ocbOurmVNhzlThX+SNnBtr?=
 =?us-ascii?Q?oztuS3VgtgC+UpnU3ChhDKcBSJANCMkZpKvxb2snx4OEEu5ElX1r8P7TJ0Pg?=
 =?us-ascii?Q?uzOXY2LgXQqEbXkUSROncxb1IDktRCe6tFXvll6oe9wJXy9qPr7ckDcb+PRm?=
 =?us-ascii?Q?+4Kipx/aeAM2cEPyCYPqOwkDapD7mppVdsdtFYQAsytuOq8cMm/bh9jLbzAo?=
 =?us-ascii?Q?x5mF8NXjQ7N1zjuBnCj8qWDmzEfYROnwsCejkZ+aHMbstB7pdf8PWRlio8Hk?=
 =?us-ascii?Q?xM6ucPVSN/jdPw5pzekDaF4BB/GYfFrVvis98GJV3le2ExZUd1wMFg9pFur+?=
 =?us-ascii?Q?Z5UX7hELvUGmC0SM8KWwRCYCy2tDUJwcOxpa48iSOid10//n3HNGS2XAzrHo?=
 =?us-ascii?Q?WAs4+VE0pLlCV1D2QS5w0T+rZtoesgQpxt1+TScN/kNFJHwkMNUterG1mxa1?=
 =?us-ascii?Q?linC/MPDT1PmRw66HFtC1pIeubMNRvka7g4PfZnJrjTLnAmYR5od3I5da7C0?=
 =?us-ascii?Q?2xtJmLW3ZEeJlW2r97rIrHomMgsGHZ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2a7e48-7367-47c4-d8c6-08da1eac23e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:49:51.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sQqHtOC9Z2EhbfuAF3QTPI07ilqBrndKghaRqnZIDDHL8B8JmcZ3Qc/vt8XrKlEe8xISBNBPOA8aDXw/pNrQvCj+Wg5iO9MOW0ZOBz7mW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150039
X-Proofpoint-ORIG-GUID: lWT29DgN5YIXlxm8AFzw7XdCRAaneUvW
X-Proofpoint-GUID: lWT29DgN5YIXlxm8AFzw7XdCRAaneUvW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 09:45:47AM +0300, Dan Carpenter wrote:
> tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v2
> head:   bf7d30c9329c87f06dff42b303a9bcfd2e1f54eb
> commit: be46c855d54f763bfb95424e5204fe7496e2ee5f [14/16] PM: opp: allow control of multiple clocks
> config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220415/202204150900.qnJMf3Gu-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/opp/core.c:1215 dev_pm_opp_set_rate() error: uninitialized symbol 'ret'.
> 

This one is the warning I meant to include.

> Old smatch warnings:
> drivers/opp/core.c:1197 dev_pm_opp_set_rate() warn: passing a valid pointer to 'PTR_ERR'
> drivers/opp/core.c:2813 _opp_set_availability() warn: passing a valid pointer to 'PTR_ERR'
> drivers/opp/core.c:2884 dev_pm_opp_adjust_voltage() warn: passing a valid pointer to 'PTR_ERR'

Sorry, these are false positives.  It comes from Smatch thinking
pointers are signed on certain arches.  I've been too lazy to set up a
cross compile system to debug the issue, but I really need to do that.  :/

regards,
dan carpenter

