Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12866592B94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiHOI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiHOI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:29:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870551F62F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:29:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F5Cfrm010596;
        Mon, 15 Aug 2022 08:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=rUIcj8URP7RCWdtsjsHPVSixjVMvBpuwiutr18tMGs4=;
 b=DT4WcSgQJ37wOuIeeN5gG1DDVlZnYSVRWDeh+WCg3ngcVQWvwKZXObHbZhe8aLFSAXCA
 z+aX3Kwn1KpLJTZKiyzTSIT3yiLgRsTsndNhdKs29aJUMc2qVOph4HYEwZkldj2e7COn
 fJtk1E/NbEPilvlVDS4//3/TMHfOMK29TLp0RwHj6E4nU/8oKmzY+QAeGFCQG5z0bM1x
 fygvGGLWbqYgMLC1x065hl+k6Tx9sPmoPyklFnldOMnSqytG6Fi5NCD3zPEppAy060Le
 C7rJQRWDmzcro62jzs3pXdbIiaauEE6W6gBbll4gw9rvj9fvjqbypvtog8kmruRTvjEb uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3ua2cnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:28:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F8LlNh011548;
        Mon, 15 Aug 2022 08:28:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d17a66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGPHRxBPMAyn2yfFvgl/meoIQn+CqWEFmxnAHp1k4ZqluItaAqq67Y/+P7f0IwoAH7RroDEZFeYog1GLuQStKmY3dV/VratK9o5RVdrJhlbPg7HlgAdC56xb1c66HIpZed1+MylLa5WQTFEcS7s29+CV9PbSHpUoZHdKcxCAMFsOiRU2vqZamDPYc1mPMLyGt89PQcPpzPvCVqC3S9U9mKRKnH3ZUlstdCaTIDOOp3OA6pWJnI2a6Y9YcwoBS6piwnpGC1ho4Er+7TELRGZHWasqiUZ8PyQqTfsnab6xBwS2lZq6UbvITuF2+t0i1w8kU4PNHspKvmmPHTiLBsl73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUIcj8URP7RCWdtsjsHPVSixjVMvBpuwiutr18tMGs4=;
 b=RmUm21kqPd8hFcjyq8Ugl2w+A3dGQMuQhBJRT5f7MwHHmXkgtRfgmIj3qJ1MagSsmODPjt76OHwFZ6BUtoeTELlOfR35LYBDeDUXaZylUQ62SlCOvjklcPkT/NMnTF/uGlLEvrX1AQLweAvr5T22NvHiDsVb8tOjQ7mDkLaYFHR9fiz5CNAFeUdXmC27LS9LV+8L5W7ADjQEHJRA5ZYMwE7PFb8jYVrgdWEIIwh5bHyjZXlwX8/ERnQxqz3fnfSoqVLu8c9JDgOvvsEuc+3tQWVaRY/Ea1VJk4Xt5wpYkzRb2DGTmi3pJj6r51kD9Hp9ToTrOOhccMz6wge8NG/MEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUIcj8URP7RCWdtsjsHPVSixjVMvBpuwiutr18tMGs4=;
 b=hD8FHEW1DVx95FtUv2wP8xD1F1Hv2bjCt2n8NhCyDYwUOWwAAyRx6RR+jVMO1RAynbrJuRQQCe/QqS+BL5DgHl3B9W0N0CU8llOBZPX/qe3VXe1Mz3quzxjDXgKa/uVR4hqgGIMyp9ECO1TqCbo/Xs3FQNI3l8D9Wv8oYgVuB/Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3056.namprd10.prod.outlook.com
 (2603:10b6:805:d9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Mon, 15 Aug
 2022 08:28:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 08:28:34 +0000
Date:   Mon, 15 Aug 2022 11:28:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/afs/server.c:406 afs_put_server() warn: variable dereferenced
 before check 'server' (see line 402)
Message-ID: <202208151006.5QHVQK8p-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0052.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85517f01-8c53-4779-dd08-08da7e982482
X-MS-TrafficTypeDiagnostic: SN6PR10MB3056:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Y+8/mhkz6NqsrW2TfHYMGNMUbc7ldz6Mupweu5Lm3JHYA0h0aIhD8gZnMnbCxvvAnreTm3p+dmlnSpZ48+wwtp9VKqpI4x798GlHct3tz3JGJ+xk6LbY/wDkvROy3onMA5xmgyI6S8TPiQgmhCDWswmIsp7f6eUHWeA6NnBTAZVCWag1rZTrenaMBCBsc6Rrq9uYvTnYB1puV/fMDAjQ+52mNLpN6sRj1uJN3eKWmQGz0YmpEhEac4Z+U+QOogVTsDkm9LqO/xrE52bz7CFztej8wrUmWSEnZOJAkgr/00JdM8/eee6xC7jY6FWKwlmhYZsJvXg58moylcvV/Ss40eP5Q5vUC6zshilhqpzgRSVC2r2NPR6t3ty7lGngjdqWGSWOBZYJMhy44XO5/nWD42iyFdrsFYFCzriD+oDGMLUAaVqsaLvGSkFxS3KorW0MXnI+xuS68cVULWeCkAakDOqFs4KoiZ/CXqJ3EUiKpD3HwKarwdSGWvb+Ju1iXFH+SGR0NmZ6GYNzj+Z4qEqpwI0KQXOzzpX1Z4xNnpN2ATz46vX88XdEpkS7ed4mmtjooIUPnS56rZWVWzTkn83NVee/sXYrpVhxNC7rq30eLzJYGshZkQ+gjRT6oMXOTlkyp+yaGVlXgePSVTXltl/rSuzhcO5pJbAzeyomu+BFd9NzlpHRCycg/PAyvKnOQIqJ2dtHPsoNGFGfTG6t6Bm76RRINm9Dx9lbLb82cmdyfhfbsDH/Mf6Cd+x+lL0NwGUsHd2Frid6Gf5JXXHujaoNuHBa5o+VJXlklsky0aWxybuUBfcRV6L6jIsFpF8zvY2nG3V5oiNVb5L8dy4CaXCNzby3roOvGao//1Ii8pRdKDDFwd2MtWYNu9CXCarqXn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39860400002)(366004)(5660300002)(44832011)(36756003)(66946007)(66476007)(66556008)(6916009)(316002)(8676002)(6666004)(86362001)(83380400001)(26005)(52116002)(4326008)(6512007)(9686003)(38100700002)(38350700002)(966005)(6486002)(41300700001)(478600001)(6506007)(8936002)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSZxjcD+xvm6mPd3/SgbkSHUACQiWDySDuHM65Waqqfg+R6fsbU8QfzYg13M?=
 =?us-ascii?Q?uTVlBlLLVdQMqYE0aLA+C9Fs0M72M2RpiMucg2WeBmGbLesXRPE7U7FQWbSH?=
 =?us-ascii?Q?o90iFg7GwTTcIiV6/TffywlKqrkSIyqSg9BHeW7VOMatiBTpKibfupqHWlEp?=
 =?us-ascii?Q?JWKjd2PnuwqWhoC5sTA/7D7kuyANFwMoZzcZzqttUcWkwhrcDpcscNzqp7RQ?=
 =?us-ascii?Q?PJymXZaPRDqvvr7ItAOCffG5AxN+BQJ7En+a2hw+WilPnCFhJhV+1jdHvjDg?=
 =?us-ascii?Q?+Z+cHla11ppIidEMLLJGnULhf9bXdurlg9md/10gbdEK5PK4W1NYCazNGTtq?=
 =?us-ascii?Q?8aHDuy51ABiFiqbPgKQpxLPRgVhYMZ4I/wUaDf5eC45gP6wV4IJkZMoqQQF/?=
 =?us-ascii?Q?0whSogrdsOS5HoIm5lbWLQiRvffwLg48mJaldB3PNb2UxwUTlmXy1oL4p/SD?=
 =?us-ascii?Q?ywa9QRvRMr9bWfAqwXRVDJfBOzL31Ji//rdlSyVRAjHmjQida6DlU/buc6E5?=
 =?us-ascii?Q?6xoDd36htbN++JT4Fb/KmqDj3PTRji0CciqJrNYb50GxqAV+xlr7iCSXE3Cc?=
 =?us-ascii?Q?A5i4sihqHuu72HhzgnEbFnf3ho9z8NJueOf9odSQvggIoSgDMD+sg3DvgRpu?=
 =?us-ascii?Q?z9IP6BOV94E0m9ftirGW+z+X6MyJ/d85DaJ/xnHw7yKwWRzbeviggnHbU9rI?=
 =?us-ascii?Q?c6Qe8qq+y4jOg6NnDawCB33YI2CpcSNMpwOu/iIOzPfZ0cdoIfJNWSfyFQpa?=
 =?us-ascii?Q?/eXP9EvIAQIPwIGPMT5Uvb1HwoVLA+HonHCOxFOaTwR7wBqdw4XzXe2yJIFj?=
 =?us-ascii?Q?SMKelDhd6jSf2YYUhgO7iJtKSlu9YtQ/ybx77ci4UyYssFKjHMcfSO3AeIYe?=
 =?us-ascii?Q?pbP4uReMTedeW49k5yIbsr+y9gvozdjBHJUvPmVF8h3V2kefiKTdhOmGcs8b?=
 =?us-ascii?Q?tjvmZ51rTFRjoRIh6332z1BHQ94PKPYwvaJts2o4JhUTwmnAvVTDMNJXn+4J?=
 =?us-ascii?Q?R3KXBsLH114N2uJqzs938osvAPVfiqP96zzW6X/2DirVxz4dkPD/TaJTFdJB?=
 =?us-ascii?Q?4OWNVx2Z27ZGI1DzYudhY06OMQ8o6jPWwAQZnvSqESnOOLwcONlrhM4Hv0rS?=
 =?us-ascii?Q?PPiRO7Dq0hkW8yhEXGEs6qpGSkaTH4TAPxHcoIHA/AlKQti68wfknibxclr9?=
 =?us-ascii?Q?u9Jc+acTtD77IxWNOhiQpcawR5eBDxqqaK8HYhn4roBmVFHhT3wjnBtySFX4?=
 =?us-ascii?Q?IMPtBuH01d2kT0TLPXbry77/b416AuoOvK0vjFWYd68vt9rgqXo/0BVmV58c?=
 =?us-ascii?Q?lgpqHPGRDEGSg+5wWHrzWtivbOz1ZD/JWdscyFjz94KC+UlOPR9JX0y0eish?=
 =?us-ascii?Q?RbA4Q3fEVZ6eWr9Voif55lza8AlQ28drYh90hClmXpgTXKJ+cwSWpCiqy15e?=
 =?us-ascii?Q?rjCGK4bOulwYoh6FtkRg5+RfcHg/mU7OL4tsENJe8DK5Uu0aoDh1VSp0KJno?=
 =?us-ascii?Q?VYCin9K8zPUIz7xL0BnjOAjcqi3iwp5CYGA5k2f2ebvDux6h8/M1PXprZg0W?=
 =?us-ascii?Q?7r8TMLuMxTYcDX1H/qsYOpQgb5Cjc4aO0JZSi7uIKPz1x1w4Jxq5VmFERsa/?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GljZzQhmjAQlI9fTjcegzTZbuAL5UfTwsx/QcI3ESrbNtg7hSscpZHFFLS5P?=
 =?us-ascii?Q?idWkHIaek67XSYvP/8dhZmjziMjabObVMajmjkMvup5+0zNJN0jMv6OpkZmf?=
 =?us-ascii?Q?JWQ5kzfkUiENcWUJWyvaILDqtJsot8bbGG7TekdyTnLZRaPemWKPboHKLmLZ?=
 =?us-ascii?Q?6yM4SDSlVSDmqKWbWd/b6NgHryegUMhG7RHFVqyYWWmFLTbYvFYPlXiytsxx?=
 =?us-ascii?Q?xyl8jgb8pBcXWt46vHn2nxq1kYX8MNs7cY8D+9p+N/2hxVeoyhlRcLWyaPYl?=
 =?us-ascii?Q?C0CUl81dFMCgKU8eY/rQlA+bfcpa9vX7Uvuo5IAsGwbcm0dLNmDBUhLs1HD5?=
 =?us-ascii?Q?7/l5glIc2K1h1Zd3ObYRYVJhFKpTEeIwIJGAS8kY9MPE/Sx6/5paVrkWou+u?=
 =?us-ascii?Q?RjqYbGMn9BMOD57PXQjO1TGE8ol9Oo3DGOoM4UIL0DFnhM1fEa77Hr1LteW1?=
 =?us-ascii?Q?Fq1MWeTUwHvRis5d/aFhoqEPQpWx9TGD1SJuU2izz+VBc2i2B8Bf5qstlk69?=
 =?us-ascii?Q?hu7BeiFzIBXlD0l8L0HGc2f/ZohEOxiAVeVDMSrrr9nYld10mU36ceqSgTqm?=
 =?us-ascii?Q?IT5w3O+tV4ax4+PnFzrG6eWqV1WWHRPFBuWwdr0uGohMFFJnjLWGJAiDNxnf?=
 =?us-ascii?Q?NOF2xvbKNoCGcgTzC/BIdAzWeKEz7gkRfqHf4VzMJH6gNya4e1BcDTSS7zjd?=
 =?us-ascii?Q?hZB25OrTCboZU5nEhb7qs7HrSAnrxF/yT9eZHT/MDsHCpOeOYe/cYKrF8m9q?=
 =?us-ascii?Q?oNWMqsUnCjq+1cqnkZ46u/Auu/hNgR0kI3e8BqKpUjC7MyrbH/qfyjvyhHbO?=
 =?us-ascii?Q?JkVnLkqQwYNRriaNptuQS29gbT6hkDLCUxd7D8DOr9a3qoHxiB9KYyIn+WVW?=
 =?us-ascii?Q?QJeGN60tyQXmUljiifg9lnMzAN56s3jlzZmlqvCiO2ZxFkZmgLx8WrsXqycI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85517f01-8c53-4779-dd08-08da7e982482
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:28:34.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvGcxOlKxQbVaG8XFDDAks0mzZ+Fmrgs751ffMn9KShvSS7EhDAnvH/194QmoN0nWQZZ1KSMJDjCdPHLRofwQG++KWBmRK4rlHjnfyRxJ9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150029
X-Proofpoint-ORIG-GUID: IVFh8Gw2c0Q3LB0GCtm8hJlEnlxZ0Twb
X-Proofpoint-GUID: IVFh8Gw2c0Q3LB0GCtm8hJlEnlxZ0Twb
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
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 2757a4dc184997c66ef1de32636f73b9f21aac14 afs: Fix access after dec in put functions
config: parisc-randconfig-m031-20220807 (https://download.01.org/0day-ci/archive/20220815/202208151006.5QHVQK8p-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/afs/server.c:406 afs_put_server() warn: variable dereferenced before check 'server' (see line 402)

vim +/server +406 fs/afs/server.c

452181936931f0 David Howells  2019-06-20  399  void afs_put_server(struct afs_net *net, struct afs_server *server,
452181936931f0 David Howells  2019-06-20  400  		    enum afs_server_trace reason)
^1da177e4c3f41 Linus Torvalds 2005-04-16  401  {
2757a4dc184997 David Howells  2022-07-06 @402  	unsigned int a, debug_id = server->debug_id;
                                                                           ^^^^^^^^^^^^^^^^
Dereferenced

c56f9ec8b20f93 David Howells  2022-07-06  403  	bool zero;
c56f9ec8b20f93 David Howells  2022-07-06  404  	int r;
d2ddc776a4581d David Howells  2017-11-02  405  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @406  	if (!server)
                                                    ^^^^^^^
Can this check be deleted?

^1da177e4c3f41 Linus Torvalds 2005-04-16  407  		return;
^1da177e4c3f41 Linus Torvalds 2005-04-16  408  
2757a4dc184997 David Howells  2022-07-06  409  	a = atomic_inc_return(&server->active);
c56f9ec8b20f93 David Howells  2022-07-06  410  	zero = __refcount_dec_and_test(&server->ref, &r);
2757a4dc184997 David Howells  2022-07-06  411  	trace_afs_server(debug_id, r - 1, a, reason);
c56f9ec8b20f93 David Howells  2022-07-06  412  	if (unlikely(zero))
977e5f8ed0ab27 David Howells  2020-04-17  413  		__afs_put_server(net, server);
977e5f8ed0ab27 David Howells  2020-04-17  414  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

