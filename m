Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167F4F5863
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiDFJGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbiDFJCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:02:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E745C208
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:05:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2361urIF014702;
        Wed, 6 Apr 2022 06:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tXIT100Ruq4AEINcCSs/Om45jl0kSMv2L5MFzfwXdfM=;
 b=Mrwkeu+9rJiv9aVXF1yQMC+GtzeDh1Mhmt+9JSiYp0Y2YnxtF+1rX+2ZLm+vD9C8kr2W
 Jz0xDBdPI8aJq9KMK29ZopkpG0tzNavS3arF89C4I0deYaSroBHyWZmeXU17btMP/7kr
 anSBVUXdAJ7wQ9XFL1GQL0+rSD9Jwxw08gfVNPA6Iblen+YIAlLXO57UHwMnozX1+lf0
 ekD380+8UpEeM9GHGXDsb/sUZ/S452Jl976161w44Gce+mxmMFJEHUlWquooChKtmzFE
 EORxASXCuO9idRlfrooUaCVLjV5x9z3S6ggd4VyfJIYrA9FYrSkzMpuH85yizU1TI0tz ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9qqkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 06:05:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2365uOi0036008;
        Wed, 6 Apr 2022 06:05:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx46sa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 06:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyywT15hoxoQuvpd0Yz5z672IuRwNPxYsgGRIIghAhl+N2As41C2FQ3fVaQryA+XGB2U+VN6QqpBBzLw91xvVbdWngl+GPlgEqMyj1ZMNCMKRQEbonfeAqOEbco9DOFiuhRI4NpmGlP9LUKr/Q5QkLziXczVDjkXBuEMyg37xA16KDLaMuewqySZzlz3Ns36ZbslWdi779odk6GkyMtuRPNDVz4sALG2FvKnBcHc9ZsLs4Pk7h78r8CQSbCaxX3bpQyWAkpMvLgGF9ZiMXjSL/lB9Dp5hrRYkjsWcgyPDuoRt3n3/S1zCzafBs8Y+bEaIbRSv/QrUDiJcYZdDC2Jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXIT100Ruq4AEINcCSs/Om45jl0kSMv2L5MFzfwXdfM=;
 b=bGEsH1LXGCq//wdsB1mFxQ4uqUL7+2goHHnR6z6/R231sd0177axRk9V7Oy8LZ99hluMLmDsNhqxq76U+6fUulOFhWytE2fPqYN0A4ww5WarwGBxmhqeSLZXSsl4rU6/rRacpZ2mLXt3KNagwNLlA4hSkIqOHCwX5DYWNZg7BtUPMFMx3DKe/yH1e2q4cVYQFNKTEcDaa4sFMyE8Ff8xqh6S05L9stYpFUwq+2DmPQjt7IHYDda/IJI44wSQ3Ap7B9NVWb883lcegF7egzVt0IiQ1foMlGLSxr6ZGH4VwWvZ5SmFlnA03uwJQUvgfF33kB41WxHxpnG24S9RSSi1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXIT100Ruq4AEINcCSs/Om45jl0kSMv2L5MFzfwXdfM=;
 b=Ctnbdp+jrlKDJ1KJjCTVoFuTOmAfr9aefcfSsV7+K4VeGHcY5izFIelxhLkVxIRgfilsC8+CCVbtP99z1Ey1C3A9YIuz4rme+EgerwT0UG5H8BU3QAgfEfvG7vl1rZ6zc4jkikYioplJ14u2eJYt9wn08HqTJlHUL9snJ6w0WFY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4116.namprd10.prod.outlook.com
 (2603:10b6:a03:203::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 06:05:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 06:05:46 +0000
Date:   Wed, 6 Apr 2022 09:05:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alison Schofield <alison.schofield@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:pending 3/13] drivers/cxl/core/mbox.c:223 cxl_mbox_cmd_ctor()
 warn: passing zero to 'PTR_ERR'
Message-ID: <202204060533.8RYu7zFU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0033b0c-cb19-46aa-c175-08da17937dea
X-MS-TrafficTypeDiagnostic: BY5PR10MB4116:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB41167D3290138EDCB946DDCD8EE79@BY5PR10MB4116.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gos5gnCTHRNahTL8P3k6tqUeJUKU2CUckxuGIsc866P11baX7g1ZSYAWzPLDAUYHsQTq0+hiw5EOFazCcdeF4x00YLKWPhT9fym9ESGa2CX1y/wquSr1KgII9F6ZRLUwaDEvSrhjORQcczkwmtELq5xCoH8FjyvGxniD7QE9AgaB97tjRBRXsm5q/4Nc2HNlBQG9Xl/Pv/cAH1H7I63mgJsiRxokIdy2nkI+LRtBpPBBoSs2cC+ljpHBstd9N9Edizv5D++s2YnGAGs3HxkRfsudR5FbreE3x98jE2ha33kIveiK1N/pbgy2o1lwsf6Xg38tOGd/Wt/dldBJVguBL9VbKSVveziv+sePJ1r4bdGaz97d5WXM9F1dh17+CjyaWRNs4W5E6KiY6JD46OBw6jcgwn9TB+viTvS1M9bjpH5ly4iOPbZCudNxsLsRjgQ854SUWuEAJ6h/DyfcFebD/Sbp2lAZLVr3FveS/enF0+RscLufhgTxM7UiJ2pttG6FXIYBKmVW6BdgpTzCYgOwo/xziiKNt4V++dj/H1if+RxfIzajR12i6HaNfNZJ8mmX1+OC7EBEAdT1lAqSqcn+wNv50K/OqFUwGEQk0GO0GVpQ1TwHpzlqAkiYaGkbdbndK4DKOrpS61+Jq8rn6Lpzr9fkZ9G3HbVbkGYeIg+8fKCPzf6ES7ft1cP+DoldslPcWlYICpqL9bEo5+nz8pMmeVdo48CZUCtoLYktjgb7xlklhtk1D8180VLVvbCIJd83nUPaC85h7yvAlJ1udsInPsEmFYQD5ERdEj790XWWELs4iMZqN/nrcmb6iRzhu0FB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(8936002)(36756003)(86362001)(5660300002)(6916009)(6512007)(66556008)(38350700002)(66476007)(316002)(6666004)(54906003)(37006003)(6506007)(9686003)(1076003)(52116002)(8676002)(26005)(186003)(508600001)(83380400001)(38100700002)(6486002)(966005)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVWJd/J/LOeEZHFLrlyaqMDg4z8zMN+A+STA7Lqp6x8hkkgm8p+Os4iLP6RR?=
 =?us-ascii?Q?wDVcVVDTB70uW654Bm4HJPWsVfJz2ry2kJqSlahbYlNpdRxtbMt1HUgk45DO?=
 =?us-ascii?Q?lz3Ll0GYue2lszaR1j16bC/6a+rv43dI7aubcmgk3xXjwcPedANgJ1Uq0R75?=
 =?us-ascii?Q?hj7vdI+5DkWSn6OqosKGAI9JY2JUdfhJur1IHnkYoAfUVxS2sXtmQ/3RkC5J?=
 =?us-ascii?Q?VAU7Q6ByU/siqbhwh6WsnBS3QcL6k1zm45k4LfVbpBh58avYweGMTyY1uac8?=
 =?us-ascii?Q?iIruMfqX3L/4k/9HKSfSHhdHve9gK7C2WwS6slBiKWH2aUUWGyvAaTPUOTvl?=
 =?us-ascii?Q?NZvdk9YR4XgZEgkW0epr1ay92CmnTEOWKYlxs6TRJq4db0WPPQFv099D3AWl?=
 =?us-ascii?Q?hDYkj+K//4fpvLMAOm+w+oY+uV2YwbMHkIdjLlVKCKbNzNIrGUDngLujY0M1?=
 =?us-ascii?Q?/Uh/87bNRzk/biGmwL5Cme0zLl9FpiA4PA4Cwe5Oo0U8TCds1ycdAUZWjRR6?=
 =?us-ascii?Q?6b0h3zh+o5upMLZyOOPJQrjfgKk6D+63n0+g52NfkIO1+/QNPDUGe4PjUjd+?=
 =?us-ascii?Q?TGtIJD+0XtjY9GDbCZfjv3rH8I3ov9R8Ot1/fX87NfGxWrjjupQ27P/CvHiF?=
 =?us-ascii?Q?yz8luA3NtsYTjEOfcFfM69NPbXihHvDBx8q3wwlN6FX0U+jgs6Mj9sr4ucmg?=
 =?us-ascii?Q?Wkx86KFTwa2vALinU7g4G/Y1BqLZY22pd3d2ivfpLLvkBGV061haLIJ7pC6V?=
 =?us-ascii?Q?SgwJiEorYZ3E2QI5KdShhRCnWlktNQjQHsQugoEZSGstinT57Yrtc3m5fw2L?=
 =?us-ascii?Q?0+P9klcSQZ8FkS/ARca0Q+2DJz4v4V976fOccEfGD5WXh7vAiXdzZS8vqHpN?=
 =?us-ascii?Q?7xtHDWgyIKmnlUKdv2EsBHebpPVDip1PZxIAc3VZKFFB6ok64eV9FbQBYN46?=
 =?us-ascii?Q?/9vjGoxZUaiXNnGbpzKTD1nCIrdd0twk8wNWfbI4j7c2P8Az226Vafj/bZ4W?=
 =?us-ascii?Q?g3/SgzVYDWdjGSAIFZOOICRMj3EKrlxOm5TZenKXILuuVcJNjBRbK05Mi2sJ?=
 =?us-ascii?Q?jnQWFyrqNsSdjVBHmNI1MzTp+eVpQcioJBBwWfObHJoPBJA+JcK8/YZl/FUx?=
 =?us-ascii?Q?SivYdAbDI+biNUlCqjfg3h/zyF+wW1uQ7l5gST0YAjKEn8NzghpUYE4a6BO8?=
 =?us-ascii?Q?P1ENgVtBfW0rZI5NNdzMuUYuuK7faTTjfPnY0Gb0dFgl04bF1wxKB9FwutI1?=
 =?us-ascii?Q?fYGelssfMeJAQ76AjceteP7M8QkbFe79KNTyIsiRq6l3ki5YvRfk/W5D1XVN?=
 =?us-ascii?Q?d/62BAISLqm7h8+/pmmDI59zEkbaktyc7IlZOrO/5kJ1Rj8drtTSomhtZ+g0?=
 =?us-ascii?Q?nTTA3PTOHtFuudW7n8irZ5+Xvxz5BlHkFsjOoYxyzVFRXnluLCk+UAy/IhnV?=
 =?us-ascii?Q?mlANFWUDAa004gKq1HxBJB4QGMV4RsDQkyB60e5BQU1lcsakg39Sv6SqU3zn?=
 =?us-ascii?Q?BXAq3W4SO/GYvCe6AGZIp42uGxbz9jdOTmzg0HBBUh/oA6f3z20isMiuwn2x?=
 =?us-ascii?Q?4arjptGYB2vh95oE9MmWbTdENmTK7ot9p9OkBcd8YNtVCdByLJeAYYpl3vNU?=
 =?us-ascii?Q?CnedEEnDrQFs5vdt/rUbaD5suMbw511Gd3tKbAMylYmiLEpDTgnoSlxuN6u9?=
 =?us-ascii?Q?EF+uF2SIrvAjFOCvEascNyTbfpRqN48ut5sQwHqDOkbanAgTT6yTtwMAorc9?=
 =?us-ascii?Q?7jwLjMC4t4HcVRGcNcvvOtYOZA48Lh0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0033b0c-cb19-46aa-c175-08da17937dea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:05:46.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1nIyaCU9UqsLPLpUt7aA0NTnqERxVbl9t1vLIFcFRqnf4aTK4vaYhIx4zX+cqLeaeyHEXpdEf96gLSpWgtJwP1OnSS2u8ZFN1ctUNSUWXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_02:2022-04-04,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060025
X-Proofpoint-GUID: LhDFiVYzoIUQZo8rS-sR43RSr68dLs64
X-Proofpoint-ORIG-GUID: LhDFiVYzoIUQZo8rS-sR43RSr68dLs64
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
head:   7dc1d11d7abae52aada5340fb98885f0ddbb7c37
commit: be0d0ce77aa3b93c40e2f72bbcab5df883bc0cb6 [3/13] cxl/mbox: Move build of user mailbox cmd to a helper functions
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220406/202204060533.8RYu7zFU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cxl/core/mbox.c:223 cxl_mbox_cmd_ctor() warn: passing zero to 'PTR_ERR'
drivers/cxl/core/mbox.c:227 cxl_mbox_cmd_ctor() warn: unsigned 'out_size' is never less than zero.

vim +/PTR_ERR +223 drivers/cxl/core/mbox.c

be0d0ce77aa3b93 Alison Schofield 2022-03-30  210  static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
be0d0ce77aa3b93 Alison Schofield 2022-03-30  211  			     struct cxl_dev_state *cxlds, u16 opcode,
be0d0ce77aa3b93 Alison Schofield 2022-03-30  212  			     size_t in_size, size_t out_size, u64 in_payload)
be0d0ce77aa3b93 Alison Schofield 2022-03-30  213  {
be0d0ce77aa3b93 Alison Schofield 2022-03-30  214  	*mbox = (struct cxl_mbox_cmd) {
be0d0ce77aa3b93 Alison Schofield 2022-03-30  215  		.opcode = opcode,
be0d0ce77aa3b93 Alison Schofield 2022-03-30  216  		.size_in = in_size,
be0d0ce77aa3b93 Alison Schofield 2022-03-30  217  	};
be0d0ce77aa3b93 Alison Schofield 2022-03-30  218  
be0d0ce77aa3b93 Alison Schofield 2022-03-30  219  	if (in_size) {
be0d0ce77aa3b93 Alison Schofield 2022-03-30  220  		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
be0d0ce77aa3b93 Alison Schofield 2022-03-30  221  						in_size);
be0d0ce77aa3b93 Alison Schofield 2022-03-30  222  		if (!mbox->payload_in)
be0d0ce77aa3b93 Alison Schofield 2022-03-30 @223  			return PTR_ERR(mbox->payload_in);

This PTR_ERR(NULL) is success, return -ENOMEM was intended.

be0d0ce77aa3b93 Alison Schofield 2022-03-30  224  	}
be0d0ce77aa3b93 Alison Schofield 2022-03-30  225  
be0d0ce77aa3b93 Alison Schofield 2022-03-30  226  	/* Prepare to handle a full payload for variable sized output */
be0d0ce77aa3b93 Alison Schofield 2022-03-30 @227  	if (out_size < 0)
                                                            ^^^^^^^^^^^^
Unsigned < 0

be0d0ce77aa3b93 Alison Schofield 2022-03-30  228  		mbox->size_out = cxlds->payload_size;
be0d0ce77aa3b93 Alison Schofield 2022-03-30  229  	else
be0d0ce77aa3b93 Alison Schofield 2022-03-30  230  		mbox->size_out = out_size;
be0d0ce77aa3b93 Alison Schofield 2022-03-30  231  
be0d0ce77aa3b93 Alison Schofield 2022-03-30  232  	if (mbox->size_out) {
be0d0ce77aa3b93 Alison Schofield 2022-03-30  233  		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
be0d0ce77aa3b93 Alison Schofield 2022-03-30  234  		if (!mbox->payload_out) {
be0d0ce77aa3b93 Alison Schofield 2022-03-30  235  			kvfree(mbox->payload_in);
be0d0ce77aa3b93 Alison Schofield 2022-03-30  236  			return -ENOMEM;
be0d0ce77aa3b93 Alison Schofield 2022-03-30  237  		}
be0d0ce77aa3b93 Alison Schofield 2022-03-30  238  	}
be0d0ce77aa3b93 Alison Schofield 2022-03-30  239  	return 0;
be0d0ce77aa3b93 Alison Schofield 2022-03-30  240  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

