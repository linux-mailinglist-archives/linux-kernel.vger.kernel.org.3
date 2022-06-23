Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA755739D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiFWHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiFWHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:10:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1745784;
        Thu, 23 Jun 2022 00:10:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N737BI004652;
        Thu, 23 Jun 2022 07:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=8sIwScupe2IGu3WVNWk9O0S1S+HGUC3C5dmDS0CoEqw=;
 b=PczMzTW4ZP9oStnhI0xuXp5g4kHDgWGeE0hCTzR46loWpK0QK8R/Mruo/9qlfz9tBsL+
 qL28VA8wll8DV5xpbv1ENyRUSMFePWwmdtcxZF4tvG8ypp5tO8fOj06FLThLIFQ9D8qs
 RB4Y478KieIrVtbIMM0ZHxIDBZcsLHtZWJjDc38YbyiAUsdi4JOMsoOuD0O5SQ2tGJiR
 VTgEsIO47+xNVG2mkzdkobAjwFWyqfqGQh/OOLSA1R79/B9ZaIAM/VI0bpS+MQJOIM7l
 GSNL6nHmsPuvlLEWdJ04Ni75c2MrZA4/wjr2sN1t7rqlgo40j74w93kpoYhxylX1UC2s Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54ct8n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 07:10:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25N762vk031837;
        Thu, 23 Jun 2022 07:10:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfwcbmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 07:10:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRlfQ7JJtvTSpUbMNqLP8blLTbZ5p9MJElITZ6f6hVAXhDK67o6XJ8xJ/k1Nva4LDFgRvUqp5ytZ5DSAZGZut0wKZIMnKLwS/Wd7Eg2a8c7czwEkkV3rU4ZO5nkxb+pYURfdxRqOuL2qp3a/GepjAmHdKHPiBnimJAfBKFawHgISTMsZOqXJ6nQ4zBYzqJ3bGY6K6xzQ6t0QSkRkmPEl1sOTWgDzGLML6eIFuXmTI3Puga6rMmPswDOFjjnwDqQ/tbRjhHqkRJ6E2Mm3yD92d3rkQtGyhkxdsf9huNQzJB2Gzh0yIH2uaEm5qZ/IvEt8I3VR8Bt5LnDy7QkUXZaAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sIwScupe2IGu3WVNWk9O0S1S+HGUC3C5dmDS0CoEqw=;
 b=VLQgjmz+4EBmwFN1qvGNR0YhjqR5iSuF5JDQr9ygmEBKlPTMnkqdA8yw412sCP/XDBlHBZOPnRMLHZqQbzuwIpJRfY4hYVrsSs96G9pe6VyW7OVgcHKY1SRgjCiL7k0VMo1fVRxA7T9fGt50nT1M4iTf1T86DrJVD0H5uB8R0WKJiMyTYd5qhU3CpIsLUBAbmai+f7eX7n16XdJ1Ko1eMAIhmMuV8pROapYWrbaZmddAn836leP0atiNuXNQhpSaHS3K7bGpmSVZlCWrmOCFkHPIeQ5CK48cEIzLynBWH49X8WWAqOVyt5L0+KWXyxGJWrNVAeVrELfMvtFte3gRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sIwScupe2IGu3WVNWk9O0S1S+HGUC3C5dmDS0CoEqw=;
 b=jHpEO8jDM9QQJ6H3vjZNCYNJ9nONGQJUnGNELD43gOiKL8w8KLStLSyOv2Xghw1RHn3Q6L30UQTklABoDvzhAPJBFv6WlmvPlvdnQjIPI7rTycYXzHHqwO0X4x0z9Ub1BqYgz+coIFTU6S0p5cAdiro/Ln7AwFAm0jR1UxVZeFc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1566.namprd10.prod.outlook.com
 (2603:10b6:300:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 07:10:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 07:10:14 +0000
Date:   Thu, 23 Jun 2022 10:09:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v36 18/33] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <202206230827.rGKbTxmu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609230146.319210-19-casey@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2642dbf-62a5-4b9e-097d-08da54e76b7d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566CD38BA47427359CA468C8EB59@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOJ5Cwktbm00Da0Yv3yywZELyCDqfXsM8E2ZqzaJRRJRmcuMMUf72QPdo8etkwaT+g34zhq4LwSVPTtoHiv4er6QWQphQcz6H6V3HUhSpKI9qBAXomBChHbhqWEslvq1qFi84BqZF43s7qvZUVfahzVDmj7MoYDtwDQh10vKYYX1YV4/S0EPPs27nZ9NpxU9hvTJG+EW19mIaXynbFHdSX0KFVqqGtOX4IZJ+IVkNi5VtadPe0hYcvmnFqRCzQZqjSejF4Go+JVg4tOyuSW0S/eczuWi7Sc4ZCJNw5foBwP/TstbR6MrEB2l9FPNmvRlvtyR1yPFdl7yhX1osvtpDU01YUQVaRcUmreonCSC1gLjKUcu7623MRNaqc8JsecxsidJ4whAySGwxeYi4IrYBbG+DXJqHaEMONjvsmeTVmXn8XhlFMkM9DURCqXyFi0VKUdv6F+nzKsnirwHSkLsgDzfbz6UktGmIq1Vle/s1aS1fnoHPLXk8vDmYGCngzlP7MLaNtVNuNEbdWy9ka9oNz2wNLn3kSVuz27esg8SLW8TfS1XRPCsATJipkItkMTcBZQ9s8dvXJpzFluvFe6UB+YTDZkdGUDvtzpTAgzap/HlqqX996HfDFR75L7snMrp+hf7t1IXxN5O+/wir9wbrn2e8kuUyxlFZf2AES+P+thx7qC2rBPrEMPEGTpIROgcNv7LbTjwucsJMeNTb5pvm9yVqWGaI7FQ9Kw3opk+8kDWfbkH41rPFNKINuhpTrXIUXyVZwb8A6glE3xEDDLK0gdwPLq4r71ohQVcBfdTdRng+KEp4/LY/3yPJG0QtkeSgAOYyfULyB/rfr6fHOcxCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(376002)(366004)(396003)(38350700002)(26005)(6512007)(6486002)(38100700002)(9686003)(83380400001)(186003)(86362001)(41300700001)(36756003)(4001150100001)(478600001)(6666004)(7416002)(316002)(66946007)(66556008)(4326008)(66476007)(52116002)(15650500001)(2906002)(5660300002)(8936002)(44832011)(6506007)(1076003)(966005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKM/7mxrzP+VpgTN4Sbwr1JyNEu+uMTx0VwrqIAuz3jdCKovfb2QzM8h6rEu?=
 =?us-ascii?Q?dPxLDfHpxuqzOqfhYWAHe+CAPWXeJvwNbt9XJGm2VAQKww1ek0h+AC5ybe8e?=
 =?us-ascii?Q?VcTJ8RyDRJypgjtzvAH8WqAaVa2y4OrNECdkVUEZ9puFqb7OLOzOAdiuH/sw?=
 =?us-ascii?Q?D97VjRYwdcaLBomsOxbyarP5ugqeXs0BLI0NoXbDU7buqhDTK9S09KT4MThB?=
 =?us-ascii?Q?GXgz3/Ut5dOUU+cSdMEQLgN4IDa49REYzvs1Kn8Zr43Lu5ohH6DSd6uqB3EH?=
 =?us-ascii?Q?LogV4YbPV+wXaKChSoeGzPmJugZHriD5em39Ghuyl2kYJ9HaXeNdEjYiMgzS?=
 =?us-ascii?Q?Zvbako7813hM7ixt/4rGE2irFSk9TtmI82JsdnbPWD/U3JzaUkwYAfx/cYoE?=
 =?us-ascii?Q?IPz8HY0poPVtY+baNl87AHoTxDf1s62kbpMSv37bMMPwEYYwfz/BaTAlRb7G?=
 =?us-ascii?Q?LHRnmmzbE+fX9F6znLnuEH4JNcbgazV0+yiqaf2vVz/8+eeOlH9T/CjwaNO/?=
 =?us-ascii?Q?C2NcH9edyUbOHT88eDmaI4Er04XgtNAr2EjvxJgxuKw19x/pgnprzpt11yY8?=
 =?us-ascii?Q?EgHqTrSW+MM3zWAXr52doPWWJl+9TLAPDbAzdtsug5UhujZPEl3R9nukMUED?=
 =?us-ascii?Q?9DP2PRoKmeY+96C1dJs36OdU82d8KoOzjXFNvBMXmY7IxZcVYKW/axQ2+Hca?=
 =?us-ascii?Q?dq50YXU96W3HnxA9Zn4o8WU6cdD/DQex7j2i6teXqTzGSEJAaKc2ATsb1Kr2?=
 =?us-ascii?Q?LQheQp9JSO2uGdimnVbcR8gNZNJ26ofwGwc/cOJ/JFulxvX75kxYtJ/XYxJn?=
 =?us-ascii?Q?64q2QnSrt7fY/1Yx6WLPP46mW3HNfFUgM4gJyL3ncjDFn0HZLXORvgfifdsd?=
 =?us-ascii?Q?7XdvpczzeH082Sv8OYp0gdiOdtjLJHGC91K+IZ7sxtIg+yr/jRIWdEkGAlCN?=
 =?us-ascii?Q?drE2dS2GETWuvuiOE7zoe7DgamPMSNJn9Nr0FY5KIW7g6cwacFHbFQk7Kypb?=
 =?us-ascii?Q?FXuVF/DRRz3lhQK61r3zLd/WD2s5nwhmCnEFH3byZC8IkvPq79rj0afXJ1a5?=
 =?us-ascii?Q?uB4cTm1V3BJGHf5EYk7+nJCm3jpZpmXuZo8RN7nJ2B07+bxpibI9ByslGOx4?=
 =?us-ascii?Q?OSxzV8FdskAeKmc+CEo3rvNLVNIytFK4aZC9mzr1ClS29ytcmL2xOdu+93IL?=
 =?us-ascii?Q?G6KRIlENbN5lR0Yhe/caK6qOybQWU2fzzKwt7ST17Zbyklsq5+gdRX3CyUEs?=
 =?us-ascii?Q?xMaERM0KWkvvc75EiGiaPQZF6d9CF6K2UZjW0y2iNUchB/W+lQrC5t42UzGA?=
 =?us-ascii?Q?5z6EY0JTeLG7eD1+LbAElB+QWAy5PqMrtd2fYZG3pBmXGhDStesJKXR7ZGpK?=
 =?us-ascii?Q?1dkvvY+PKj57OsZahRMtgm3XbsWoSIm1Teu51GlW7RhCU/H8JjNF6lfyFpMK?=
 =?us-ascii?Q?WUM7wb3SGmrJ44kB4bWU5UByM2ZTn6pUZhISCuPJ6Rx16efYlc01Cu9N8vLX?=
 =?us-ascii?Q?6lq/XmYhA1yrk7s9Q5ygz/o0rhq3SoG3QzabsVLTjO4R+hPDlMOJ30hZVO3o?=
 =?us-ascii?Q?eaMXepG7jSi5k0jNA8vl3k5IvzqvRjYu44xWb/cNkzSr+eHMM0Knazne88p4?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2642dbf-62a5-4b9e-097d-08da54e76b7d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:10:14.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtplTeBrgBUJqDtSEFf6FVZSxrne39xF98u591mp5MBXb7SvsSmDzohofJkX7Jzpyl+0OWRpCDYgJoGXBRQ9RI9VyV3SrmHdaSRmGzewuoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_03:2022-06-22,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230027
X-Proofpoint-GUID: mSq6sqN8LRtAG8-Ft7VrYwTJI4RhKNBd
X-Proofpoint-ORIG-GUID: mSq6sqN8LRtAG8-Ft7VrYwTJI4RhKNBd
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: parisc-randconfig-m031-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230827.rGKbTxmu-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/fuse/dir.c:484 get_security_context() error: uninitialized symbol 'name'.

Old smatch warnings:
fs/fuse/dir.c:503 get_security_context() warn: is 'ptr' large enough for 'struct fuse_secctx'? 0

vim +/name +484 fs/fuse/dir.c

3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  462  static int get_security_context(struct dentry *entry, umode_t mode,
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  463  				void **security_ctx, u32 *security_ctxlen)
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  464  {
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  465  	struct fuse_secctx *fctx;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  466  	struct fuse_secctx_header *header;
86d33e271bed73 Casey Schaufler 2022-06-09  467  	struct lsmcontext lsmctx;
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^

86d33e271bed73 Casey Schaufler 2022-06-09  468  	void *ptr;
86d33e271bed73 Casey Schaufler 2022-06-09  469  	u32 total_len = sizeof(*header);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  470  	int err, nr_ctx = 0;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  471  	const char *name;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  472  	size_t namelen;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  473  
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  474  	err = security_dentry_init_security(entry, mode, &entry->d_name,
86d33e271bed73 Casey Schaufler 2022-06-09  475  					    &name, &lsmctx);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  476  	if (err) {
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  477  		if (err != -EOPNOTSUPP)

Imagine "err == -EOPNOTSUPP".

3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  478  			goto out_err;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  479  		/* No LSM is supporting this security hook. Ignore error */
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  480  	}
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  481  
86d33e271bed73 Casey Schaufler 2022-06-09  482  	if (lsmctx.len) {

Then actually "lsmctx.len" is uninitialized.  Everything breaks after
that.

3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  483  		nr_ctx = 1;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11 @484  		namelen = strlen(name) + 1;
                                                                                 ^^^^
Warning.

3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  485  		err = -EIO;
86d33e271bed73 Casey Schaufler 2022-06-09  486  		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 ||
86d33e271bed73 Casey Schaufler 2022-06-09  487  		    lsmctx.len > S32_MAX))
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  488  			goto out_err;
86d33e271bed73 Casey Schaufler 2022-06-09  489  		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen +
86d33e271bed73 Casey Schaufler 2022-06-09  490  					    lsmctx.len);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  491  	}
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  492  
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  493  	err = -ENOMEM;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  494  	header = ptr = kzalloc(total_len, GFP_KERNEL);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  495  	if (!ptr)
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  496  		goto out_err;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  497  
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  498  	header->nr_secctx = nr_ctx;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  499  	header->size = total_len;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  500  	ptr += sizeof(*header);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  501  	if (nr_ctx) {
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  502  		fctx = ptr;
86d33e271bed73 Casey Schaufler 2022-06-09  503  		fctx->size = lsmctx.len;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  504  		ptr += sizeof(*fctx);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  505  
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  506  		strcpy(ptr, name);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  507  		ptr += namelen;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  508  
86d33e271bed73 Casey Schaufler 2022-06-09  509  		memcpy(ptr, lsmctx.context, lsmctx.len);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  510  	}
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  511  	*security_ctxlen = total_len;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  512  	*security_ctx = header;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  513  	err = 0;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  514  out_err:
86d33e271bed73 Casey Schaufler 2022-06-09  515  	if (nr_ctx)
86d33e271bed73 Casey Schaufler 2022-06-09  516  		security_release_secctx(&lsmctx);
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  517  	return err;
3e2b6fdbdc9ab5 Vivek Goyal     2021-11-11  518  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

