Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6675738F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiGMOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiGMOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:34:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92DE30F61
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:34:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDDrgb011695;
        Wed, 13 Jul 2022 14:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=FF37wSiVyFd9IheCdzC3dvN1M+k/88wdNQcyDbmFPuw=;
 b=hp9lESJOESWJE+jTsExb+jXh08lgGeT2A17400tvYPxFjs0n5pZOrh9p7aIv8G7CEuNR
 xAMFfOd1wLdX52P5PHf2u5omd7VIybXkqDr7m7ynDFObtcSAQLtQYahF8eRpRY/ktAHD
 JVdMUOLqn4GVX64XS9zrO1NWODoKWFz9bA/J0Dr7cslRbC7Jk/Er1mM1QiGgdN8/c24w
 hCOp0Cskdbr17TZKQ8wQBOKDpEKScCKXHmFpaEFBB5z0OgHqPc1EprfKQV4BJeYE+uAF
 4PBjGk/gZP0Ne7JGnY6wg+qJes2n4lKG0k0BYqiQe31PbjDMYALzB/3UHSv4CBcSjKtS Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1a28a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 14:34:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DEVORp030366;
        Wed, 13 Jul 2022 14:34:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704541fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 14:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4vVUKN27hnKzgKnB2kvtnjQopJbzNz0+/cCAcREXYXU5a/aXiH1DmESjRmjYtkVuLg0p4SZpaEj2/87FnN33jLMiTCxHths50x1pbD+v1EDiquIhPQY4ar3CC++H6HsaBl98S6Mv8sGuplKO+jR7lLzhXoGiuhKCvApfo2XxYlL4VhTfmjX25R5kktjJ2MNEOfnS7KvZwC8aTu3fsK+Xs6SHHqt5fsPRq9VYuM5swLe17XcqtGiEIranRinKH+KihSq8UHyWPujpsngTfLNbtA/2SICYn/sf4kx+7AEqsfY4mTakezTev6zVfBE631bB11yVz91L3izaEDv95Pb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF37wSiVyFd9IheCdzC3dvN1M+k/88wdNQcyDbmFPuw=;
 b=V8KJrxzaBhDh3LTnAnOoIboIyh64bJeBVBHfqY64Lmc5I/JF7mXf7mea4R73UHwN1/w6UQtBaiZbASbOjQHU431GX9lv3PEOhIc3V99URU1Kp1dXvnXT5YOiQlCiFi9Ya3jm1nTAUN2wFN0GUBlnyY0jP+MZHhhc0R6f7QVDR0dQlA6kU9gfsDVBxrJYUr5UxSkITXmcIbfcO6+6AV3WLXiedes3DdKxCRNXHVCFZd4AQeb/Iy0uRiSJED0zLhPvgfJJYweRrSNgjfOkshVk/oxM4UoKi+nha9G3Uy4ThS46F2O3mii6DvtyPCDAJgGtvnGveH18zmjz/+Ndch7jEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FF37wSiVyFd9IheCdzC3dvN1M+k/88wdNQcyDbmFPuw=;
 b=tAHbeUxeeukRljhA4ahaNit4xLSeoKRiCvgmUIAAiUGZocNBUaKFwgXHN09+rNR/VUn1lU06BNAf5EIWgTS8n9ZKN7CqpXh+mtFPd5+n77azYq0d35WWMshSbGjS7ITnfQMXZTo92jbBW5Xeb0J88RjLv/3O0ffswaVnRDykmTs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3560.namprd10.prod.outlook.com
 (2603:10b6:a03:124::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 14:33:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 14:33:52 +0000
Date:   Wed, 13 Jul 2022 17:33:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: fs/nfsd/nfs4recover.c:814 __cld_pipe_inprogress_downcall() error:
 uninitialized symbol 'princhashlen'.
Message-ID: <202207132125.6mLS6KnE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5837a9-5613-4966-ea0f-08da64dcb516
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixwMux2qaqNkp4F5Wt/ywlff2fm3wIuJoHR04r9gQ7oaZ7hNHB1IQEZuZSxWGv+ZtqqUgOIiy6EQrRdK0DHoZ5f8AmpGr9DLRNfRtYP+mw7Wk45F6TQRIbVF3ekKq3Pmyqo4lsi+tcVsY0EPGmYBhhEitHtmPZOmZhSrZN8R3NxS99VYDgkN4JyVqV3sLOkVHjNG/4pV/rpaT8TrUAz205SYuU3rgfvyfjkZsLUrXObEFeHZjTEshygJCdhYGil1ndYZ/6bGZNyLNMdCHu2TGSU2QAvGYp7Vq7NruCIglLHF3o17BfPf+I0j8jaKjhOYWqISPgEbAAthgGnUC87JptOuhTEpOR9LZrrgeTnCpBPUVC12+koyMvZRjFe5fzEO18PujwPSRIdhMfnafIw+ei5RmfZXv+/Hf7Y7QLlN6l0i3oVZisgJfWlShQQiimEAk0bprV7k/0KZ13TRuQ7/rzKCxHNrHR1TLbcNUwS9TMn+33Mq3n9nsKxYPhKQJ3jizNsseKmFilDTS4vnHc7MkYuZ0wVTtqPYln/Ake50eEpZpHGaRmTVjKmjwkl/b1C5Ue+TEQgpZFidch4BN3qxuAjF2rC9K7GWrE+xnLApLyWPWX+YcV0Rgdc227lNcnrl8qx2uLlmH6qb2EjSt9YVqJ0H4AZs31wiXYumes3ZVwwsfDfGafH74ftaoyntpKus6xJE/7dvmw2Y84btozy/Sh6mnam2MsrhJLZr6aAp/qckv6DmWVrxvtQkTymltp8MAHwKUXj09lZURBGPmVhYwPGY+NEoApNv64dkTaqk/SnCcBXYp58Iz2MNu8t0CQvNv0Jq7OAkCR0lqnd/JmrilIlgniBm1YRk26NGzgOLjFyISImyevfEV3lQXZjQP+D1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(39860400002)(396003)(366004)(9686003)(66556008)(5660300002)(6512007)(41300700001)(66946007)(6666004)(6506007)(4326008)(8676002)(66476007)(52116002)(83380400001)(26005)(966005)(316002)(8936002)(186003)(44832011)(6486002)(36756003)(2906002)(38100700002)(1076003)(110136005)(86362001)(38350700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lHKOE+FhxqWM9k03Ghed/UrVuJPufQsOglW5PZTAn1kSQr7Cm2aPFoIHtPYZ?=
 =?us-ascii?Q?7yVewNTX2D525ez2Ds0cMt/5gYM7eK/Gd6Y8qrxmaaotQSiBGtBNozraKolA?=
 =?us-ascii?Q?bLhJrBKFFW2eUdZskU5R/dyMK/+9na9A+08PaNmVMpeV+nZmBZA9uWn9JwMK?=
 =?us-ascii?Q?PC51M8Acjo9mw6C7hgRHvpPtQHv8YCqctJ8kuTgEJDsLIZo+X2piglGrwQ8c?=
 =?us-ascii?Q?JI2fa6mlQLdBumH4aXYJkhjwg4NYeQg2gruhJpjTpHYaFcFxM8my6wZ3zVHY?=
 =?us-ascii?Q?rh/aeNaWwcsooqBrQr52Yovq9YnxDin5RTEtOXEIramBQSTyB7SoJA6PGKAy?=
 =?us-ascii?Q?GXZ5jxS2//x0mNLk0IB4934MuKuRXQ7KoAw6gW+f52ryvFhH80jzsZvtXR82?=
 =?us-ascii?Q?ejzOvy0nUYGR66Z90EnQ8AcorLAv223arDx24ll7V2FoUfhyZEEbRwANkgBp?=
 =?us-ascii?Q?eTx4tXFzbAkL86htCj9fnbtWTHLAFmI6t82BLdwu6sWejmuwomuWpWDPD66R?=
 =?us-ascii?Q?7aPCOZiGBhAdSp3rpGVLxIE6eEcUkRy+MK32UrZ9Ou5tQe1KmOb5/8UpBNR7?=
 =?us-ascii?Q?OE8k9FZRpiGV4mAPVXzHL+jU4SQQ8g/Xq52JnzVU8o2/h7o9KiwzGSF82amU?=
 =?us-ascii?Q?mkCUtOerWUPMGRr+CHP6f7yBf9UtDNOEk8l2Akm0IBd4zAzZdCxsdCpm4WwS?=
 =?us-ascii?Q?WQ5KyELdLNBFucsNpecEcnlQhrN9zEGKQ4wXXZdyeIn8qe4W/fefAPaSv4vJ?=
 =?us-ascii?Q?DFEex0n0gFXbUWgHrFd/cnPgaw+boJ0lgrfGbavWuQijvZbiK6bWM7ij4VQo?=
 =?us-ascii?Q?GrwkpSasw3OcVGFNHxGbr+1R6C7PQ/86DMgjBBF8mYv9PE7RkL/nlHAX6Nl4?=
 =?us-ascii?Q?rzDHKFPiAmkyu2dwV80CIlayFSOJNJy9ZA9YrptAGgL9qcg3bi6XqyucYKKg?=
 =?us-ascii?Q?kEbLEXm5jH3p7qh6pbJLW66OyP+jXhL4ZIwoyjxKgXlWPrpwbmVpe3dasyMi?=
 =?us-ascii?Q?VRYDGXKkzGvjsDjmSrE4/acd/Bmi4nOvNqN29F26mJnUk5eIGrBDjgFqplgQ?=
 =?us-ascii?Q?LIKcU9o42v9Dt5/KTIMlPg4s0QeJQ8qMMnTMjjAUyrmhHA+5ytm9FimEKAGi?=
 =?us-ascii?Q?jWgTRnAo8DRtIkbEwGxdQAOUhx/Vj9MawhW43GkiKE78wWvd05utkrxeqFUE?=
 =?us-ascii?Q?3BraqhRgecU814m5vMXC52HrxlDuScEOwqTDInTjv0xI7ryZvFe/mjzzxvWP?=
 =?us-ascii?Q?xt/NqtaLyeLP455HREhSglD8FkRQZTBbug2yXWClW2H+w7NF7GJ3B/4DB7YY?=
 =?us-ascii?Q?NOLHYVX7apZ0/uGk9RFtMF5UznsGZLZn515MgczikSSsGUWvI7+5tMSWEQP+?=
 =?us-ascii?Q?Kgc+r70SMLKe34d2OT2PPnEJ0L4ZNToxgpRJ6gPtr9kESk+qnwyUvj/1qfn5?=
 =?us-ascii?Q?/npkQLzcOv9aWY4UxvhtMieKWSr0jkk8gayM5O1XQyBDjNy88s0gjQxTuUNq?=
 =?us-ascii?Q?Y30R72/5pnEat47IQ9+sWpMnVBOfIHW8yaSnikuk9IKbj1EHpSSOTH2IwhMk?=
 =?us-ascii?Q?L8QWANyrYbjJE3njiRB+Uf5TYhcpgqbdV9BHg9u8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5837a9-5613-4966-ea0f-08da64dcb516
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:33:52.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TPOxMP42lucKOLaTYkmQogmZZc7S8HxogVU2wgUfkL5/BeQmYrAvg6sFg0KCo/E7trmK7t/9SF16S48xCGMJkOA9d/jQXIXzvcYJNnd/dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_03:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130059
X-Proofpoint-ORIG-GUID: sJ8a_9urgjJtptdwfeydc7u1pPRDWyhZ
X-Proofpoint-GUID: sJ8a_9urgjJtptdwfeydc7u1pPRDWyhZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: a97b693c3712f040c5802f32b2d685352e08cefa uaccess: fix nios2 and microblaze get_user_8()
config: nios2-randconfig-m031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207132125.6mLS6KnE-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/nfsd/nfs4recover.c:814 __cld_pipe_inprogress_downcall() error: uninitialized symbol 'princhashlen'.

vim +/princhashlen +814 fs/nfsd/nfs4recover.c

74725959c33c141 Scott Mayhew 2019-03-26  789  static ssize_t
6ee95d1c899186c Scott Mayhew 2019-09-09  790  __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
74725959c33c141 Scott Mayhew 2019-03-26  791  		struct nfsd_net *nn)
74725959c33c141 Scott Mayhew 2019-03-26  792  {
6ee95d1c899186c Scott Mayhew 2019-09-09  793  	uint8_t cmd, princhashlen;
6ee95d1c899186c Scott Mayhew 2019-09-09  794  	struct xdr_netobj name, princhash = { .len = 0, .data = NULL };
74725959c33c141 Scott Mayhew 2019-03-26  795  	uint16_t namelen;
8a9f4f41248a4dc Scott Mayhew 2019-03-26  796  	struct cld_net *cn = nn->cld_net;
74725959c33c141 Scott Mayhew 2019-03-26  797  
74725959c33c141 Scott Mayhew 2019-03-26  798  	if (get_user(cmd, &cmsg->cm_cmd)) {
74725959c33c141 Scott Mayhew 2019-03-26  799  		dprintk("%s: error when copying cmd from userspace", __func__);
74725959c33c141 Scott Mayhew 2019-03-26  800  		return -EFAULT;
74725959c33c141 Scott Mayhew 2019-03-26  801  	}
74725959c33c141 Scott Mayhew 2019-03-26  802  	if (cmd == Cld_GraceStart) {
6ee95d1c899186c Scott Mayhew 2019-09-09  803  		if (nn->client_tracking_ops->version >= 2) {
6ee95d1c899186c Scott Mayhew 2019-09-09  804  			const struct cld_clntinfo __user *ci;
6ee95d1c899186c Scott Mayhew 2019-09-09  805  
6ee95d1c899186c Scott Mayhew 2019-09-09  806  			ci = &cmsg->cm_u.cm_clntinfo;
6ee95d1c899186c Scott Mayhew 2019-09-09  807  			if (get_user(namelen, &ci->cc_name.cn_len))
6ee95d1c899186c Scott Mayhew 2019-09-09  808  				return -EFAULT;
6ee95d1c899186c Scott Mayhew 2019-09-09  809  			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
6ee95d1c899186c Scott Mayhew 2019-09-09  810  			if (IS_ERR_OR_NULL(name.data))
6ee95d1c899186c Scott Mayhew 2019-09-09  811  				return -EFAULT;
6ee95d1c899186c Scott Mayhew 2019-09-09  812  			name.len = namelen;
6ee95d1c899186c Scott Mayhew 2019-09-09  813  			get_user(princhashlen, &ci->cc_princhash.cp_len);

No error checking on get_user() leads to uninitialized variable bug.

It's weird that we're only just now catching a 2019 bug but I guess
the "uaccess: fix nios2 and microblaze get_user_8()" patch makes the
function easy enough for Smatch to parse it on that architecture.  On
x86 it's done in assembly so Smatch doesn't track error paths.

This bug is still present upstream.

6ee95d1c899186c Scott Mayhew 2019-09-09 @814  			if (princhashlen > 0) {
6ee95d1c899186c Scott Mayhew 2019-09-09  815  				princhash.data = memdup_user(
6ee95d1c899186c Scott Mayhew 2019-09-09  816  						&ci->cc_princhash.cp_data,
6ee95d1c899186c Scott Mayhew 2019-09-09  817  						princhashlen);
6ee95d1c899186c Scott Mayhew 2019-09-09  818  				if (IS_ERR_OR_NULL(princhash.data))
6ee95d1c899186c Scott Mayhew 2019-09-09  819  					return -EFAULT;

The memdup_user() function cannot return NULL, btw.  (When a function
returns both a mix of error pointers and NULL that generally means it
is an optional feature like LEDs or power management.  The NULL is not
an error but means that it has been deliberately disabled).

6ee95d1c899186c Scott Mayhew 2019-09-09  820  				princhash.len = princhashlen;
6ee95d1c899186c Scott Mayhew 2019-09-09  821  			} else
6ee95d1c899186c Scott Mayhew 2019-09-09  822  				princhash.len = 0;
6ee95d1c899186c Scott Mayhew 2019-09-09  823  		} else {
6ee95d1c899186c Scott Mayhew 2019-09-09  824  			const struct cld_name __user *cnm;
6ee95d1c899186c Scott Mayhew 2019-09-09  825  
6ee95d1c899186c Scott Mayhew 2019-09-09  826  			cnm = &cmsg->cm_u.cm_name;
6ee95d1c899186c Scott Mayhew 2019-09-09  827  			if (get_user(namelen, &cnm->cn_len))
74725959c33c141 Scott Mayhew 2019-03-26  828  				return -EFAULT;
6ee95d1c899186c Scott Mayhew 2019-09-09  829  			name.data = memdup_user(&cnm->cn_id, namelen);
74725959c33c141 Scott Mayhew 2019-03-26  830  			if (IS_ERR_OR_NULL(name.data))
74725959c33c141 Scott Mayhew 2019-03-26  831  				return -EFAULT;
74725959c33c141 Scott Mayhew 2019-03-26  832  			name.len = namelen;
6ee95d1c899186c Scott Mayhew 2019-09-09  833  		}
8a9f4f41248a4dc Scott Mayhew 2019-03-26  834  		if (name.len > 5 && memcmp(name.data, "hash:", 5) == 0) {
8a9f4f41248a4dc Scott Mayhew 2019-03-26  835  			name.len = name.len - 5;
8a9f4f41248a4dc Scott Mayhew 2019-03-26  836  			memmove(name.data, name.data + 5, name.len);
8a9f4f41248a4dc Scott Mayhew 2019-03-26  837  			cn->cn_has_legacy = true;
8a9f4f41248a4dc Scott Mayhew 2019-03-26  838  		}
6ee95d1c899186c Scott Mayhew 2019-09-09  839  		if (!nfs4_client_to_reclaim(name, princhash, nn)) {
74725959c33c141 Scott Mayhew 2019-03-26  840  			kfree(name.data);
6ee95d1c899186c Scott Mayhew 2019-09-09  841  			kfree(princhash.data);
74725959c33c141 Scott Mayhew 2019-03-26  842  			return -EFAULT;
74725959c33c141 Scott Mayhew 2019-03-26  843  		}
11a60d159259dba Scott Mayhew 2019-09-09  844  		return nn->client_tracking_ops->msglen;
74725959c33c141 Scott Mayhew 2019-03-26  845  	}
74725959c33c141 Scott Mayhew 2019-03-26  846  	return -EFAULT;
74725959c33c141 Scott Mayhew 2019-03-26  847  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

