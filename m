Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD651C5D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382517AbiEERPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiEERP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:15:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708C5711E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:11:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245FAQUm027785;
        Thu, 5 May 2022 17:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=l7rffdqKSckGyhReAhvwzF/1gdDcTpY6/bol4zuXbCg=;
 b=qyVcgnmqQeURreSCnPQEkKLp+M1D9hQ/n6i1UAEwUoNvYLTF4oaB6OAHKwn+ew85nGdY
 9AvGhOXIPx01pkxttUc/hiviPCQAO+hKhAtTpgy4XpkrR6uxPjL4KjSzZ5NPOTj1Hrt1
 Bt8Dv8fSxj0Ddf1IWtUN+TXVpn8in99v0Y51mONkOu5rRA8xQ9BmAl+iQz7y/06gSWm7
 prNWOy1Wq6VcSd+Z7M4uLXSdBKOazJD3dsgEGk+b0Ot+nyzDKnTKaq4sEu5IHFGAkUlx
 IrHrGQXRQSZOn+Hg2LnGaDmWYiB6bKnKEgkxwgoIXzyHhZYgEITOYj8QQEndQReCbTRB rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2m0n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 17:11:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245H1bI3019013;
        Thu, 5 May 2022 17:11:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusah2e4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 17:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfT5HbDlNvLOzePsMHgWis2y3/3RjMetTV5Y9Mncfp3kuNdyG8nCPavdLP7i8GiKtXLsD7lpyyGNNjgEnc8cGysJJ360kYZSt5yajckjhozgt/FmIGup8mO0JrBzEuJwa5EA2F41viilZaxw45DE3nU0CUmGCJhmHpdEkjrMYjCi+tUgU4BdJXYXEu1NS1uju00ptIU9RCaGlQr7FvadKrKpUrdpUbqEXF37sxSJyvMn2CI22n5e+d8gRmMipkSqeJy8qilvu1kWqpVALrRxZz0yGHF71q+M20c4HnRe7I0quEiw5R1yQeYQBCPoqxHZ7W6pHZPZGr7LlwJJMCk1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7rffdqKSckGyhReAhvwzF/1gdDcTpY6/bol4zuXbCg=;
 b=ZRSrN+u5e+RuRoXXv3MK/VJudIVfbgayCe3dEu4V8Qxko7nNum+G5Dl53kNaZJYQ6Zvwan6/n4E345FIo03aDIp0PGCfiHBJJ3pRZubg87b5j4yABEcj2CcgwzZGmjt1D3atdwjBqWvymWLizJpBO9cYWZRuTkNjoqfimW6wGstA2doYeZOk8fk0Wlsc0mnFdIAcn8G9S+9PRDH/pag2ibUJ8b24VcJHeuWw97tkLJJtz0bOecuG1ch9OGxVhxQvLj/cFc0Y0KOsOo5OYFPXqJUBIrMdKbEJdnzF/M2GuORuzyOeQcfPhkEyj6Nj/JH6ICoAdleBntE95DK8fwUSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7rffdqKSckGyhReAhvwzF/1gdDcTpY6/bol4zuXbCg=;
 b=X1+sfL/45ekHpTM16tRkLR2bejsOBvi5uKKATtj01FyZvASf6DSAieSbHHnx8EHTw/J0hQaJJwisNOH8rJJJguemSBnvNGqans65bpje0DN2MM45Nxd92AlNEQ6OZqwfew7cTCTJzujgdz/cEWzjWEagOZYpD/22QeF7wbu5FcQ=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BLAPR10MB4850.namprd10.prod.outlook.com
 (2603:10b6:208:324::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 17:11:16 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 17:11:16 +0000
Date:   Thu, 5 May 2022 20:10:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Saravana Kannan <skannan@codeaurora.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [chanwoo:devfreq-testing 2/5] drivers/devfreq/governor_passive.c:346
 cpufreq_passive_register_notifier() warn: possible memory leak of
 'parent_cpu_data'
Message-ID: <202205060035.FycydyMZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc18ab0-fa15-4785-730b-08da2eba4374
X-MS-TrafficTypeDiagnostic: BLAPR10MB4850:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4850CCF716BEFD68ADA35AD78EC29@BLAPR10MB4850.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7y0Mvk89QjkriwTBHF8tWV6GihFkRcdb6K3j4gP2GWOwq0DqGZAmZey/M9r9Hf/WQAhBHsydBlvQYOtcSgiaErW0/OsD4PNKgkg9gfT1IWw9HjuvOHqcc9afadqIlE/GN0y11P0PI2qbMGkmz0u2v2VPoBijH8/fKVLsA7NLyB8etyYya8d1SaA9ocHa1k1Wdou4MYutnBjVg9NlZhA/2tvUvepHiAaGvqJ4rsJPUiPUGH43jlN1e9EVzONz3lDSLQlq2ZUVFRdeUPvlPJJse60fQKPsQA13AZY43GkSypHEp3qgaxbFsv7fRY3xPRta2hAJYgV99jcojGvPBI8oAq+dG+xzg9jjiPFJNZxfD1hVGVDIljjreYFOd/WizJZWhGiXV2VYf8diEGdofnjdOruIsFbFqPSzX3//mhmAqkgyRK5pOCamgyEJZZIxitIpr+3FJ5zqLk7h+HziMAf45+88E9T+kfWGm/q/n3sWie6aX5nuzjs45kGBjVkP8ITgk5Mv/zQvNvfo3pLsQTZw/YPgYcVM7n2nQv/NvFbubatzBfK6Cp7cXYYFhMH/dEhLHcO4FFL/9bjI+zmA3jGDPueBLwuf6ukZk7wWEs/dwwl1oivAAm6ly8C9lUkuAdrrTUNa38cYDhzoC+zPsnjerW0uUtH1KQdCt3oBNE/mMUy1nowKXlPpXH5sZqUsx2C8yKpOhMo039PfXTOgSvORrTs9Ia1kWymTrb0JJbyGkb4Oy7/GaVAGM3RvJz2e1DHoT9rcfVnuKAqmr1hyqwlAYYQcFl1bagG5/bjkfAoKd8demXO3fGejo/329GLxtIbwZTBqs9Q5juVFKz7SC3dOIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(8676002)(66476007)(66556008)(6506007)(8936002)(26005)(6512007)(6486002)(36756003)(5660300002)(30864003)(508600001)(966005)(4326008)(6666004)(44832011)(9686003)(2906002)(316002)(54906003)(86362001)(6916009)(186003)(1076003)(52116002)(38350700002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?En9vybvTGDhjk4Nop9Y5aZqR3bKIjzd1nJ97tUdx/ch0IMW5q+Dj1zdkRuQh?=
 =?us-ascii?Q?V/RTQkx/qZZlb2Aggv+bPqa9vAFeQHAzkm1ITwPG8s7vX3omFX2LeBRWWcwX?=
 =?us-ascii?Q?bfIKY6Zys8XrJp2NTAQysCS5tHFhupAt2cdww0ZCi6Xnsth9+ujf7zIeC3lw?=
 =?us-ascii?Q?4RxQ+tIy8ppeIdoDtnqiNGHbHerDlp2dbVhgdpDMOJk8VzXnse10WL4HlKkv?=
 =?us-ascii?Q?pRAOK5/n21XqVU54nZLoD6gur7kPCTR4eHZJLvDklmPoxJi2QBRylz40GFnM?=
 =?us-ascii?Q?WkgVh74rZs836o+Or4j/OpkXnZkE62E0rpktOdHcJ8UOQ8I57rKAVmvfveOw?=
 =?us-ascii?Q?RLvnyCkq4p6EjqjdRqpHHCsr2v2F4btwZEpvZK001rQfbUZ/0Auc8DAfMPDQ?=
 =?us-ascii?Q?XdAg/py7yjLmTi4iIi+LOGJnTaTHhCHYgmAAKhkrxGb0XQcx76HuYjF3rtu1?=
 =?us-ascii?Q?9Rdgb4q5yjZSObkQWABgs3Iw/IVoDplY/cyPdWK1TFrn/NKeuFXt0BFoxQK/?=
 =?us-ascii?Q?Et1TBsYpbxCuyLldKFUaEtp/2j06/1S+Hy9LtD/HRpBqwOGnoWJTU/+Z4CzQ?=
 =?us-ascii?Q?O4d57u9l/6qcQ1otLfC9WGbVEwWgCFUux/wQD+tl/9OS8fPQu1Z0oAxPJoDS?=
 =?us-ascii?Q?BUpPotPpEzbAMJ3/iANDqfY9XVFSmNB4xJoPPwu06CKnr8cBcN+38FtJF2Rj?=
 =?us-ascii?Q?EkSXvHLY7QKVBjbOU6jH5/ISmXe1mHAgaVhsjzjStUsypBjT4hzaVoSasQ1B?=
 =?us-ascii?Q?h8QXmPyAggIuM8yUOgz4egTj365iZWZ0yVDbE7ze61vN7iiP12FW7KLAZ1TZ?=
 =?us-ascii?Q?nHaoubHb+2hhr6YrY6TLd3PpCyGCB6EJxuoQ/u61IloF9h1mxIRPNHMgSHNt?=
 =?us-ascii?Q?rSQhU/sHTpYjutXrZmWqP4pMxfMXy0yFEJt3tRDw1H64bHCB+jWv3Rv/njVC?=
 =?us-ascii?Q?20FapucefLXRcQ9n8R4mCbXwPDUns2zZCKWWjInBWfwioLYyyHhuEKAlgQ8I?=
 =?us-ascii?Q?3IxGFe44dfbtzyJsNV8Efj/cFkFlhWKJ2z+dGMkL/ZyHzM+styW/xAid/VNJ?=
 =?us-ascii?Q?TgZgW5VW1RGZMhdjsOSBBEpOeYv5XXG+8YDeolQblR512ye1wyuab4hexSlF?=
 =?us-ascii?Q?HOI3y5ONWznysXsZyQak/Dj2ZlUtcEaLBO6UmB+5UCZSK11H6Be6PM0oog6n?=
 =?us-ascii?Q?NFS7S7hcJ7Cu16WI9O63pTddlYgRnlPs2acG7PP4y6PjuUn4d+OIYt8whx/e?=
 =?us-ascii?Q?6MHQB/x7Bf0uB9BMus5+EyKryFtpfk/wmgBgbf0kmNpiNRt/R8Srv+jjCYDE?=
 =?us-ascii?Q?DTFUMMtKco+jJs4laxxWVfVozQBvv47uSsYxYS+yXvM2ZQ2RtPkJhHLut1qG?=
 =?us-ascii?Q?AEfP03uPZOfCYqUheoHi2BRvQcqSeBXQBGv8rsHyXPAVE2zvQmTJ+lbplPNC?=
 =?us-ascii?Q?FLVaVaEXbe+TC3zK8yv5qokRuR8YCloJiarJHidl+ewS/I8iWNwlSYBbZfCV?=
 =?us-ascii?Q?Am3mv0qBfp36OQo6VKCr2rWhBh7dI+gIOpvJDp2IUNxJ7xiGc1rdV7zjkwre?=
 =?us-ascii?Q?g8h/Z0+BDn4PmgExPQcPiU/qPyhH4yVX1Fae6sz1jNOx/gO4PGbRrPEw+qEH?=
 =?us-ascii?Q?Tz21H8GjrOsMABGrbZdgdxH48eb7owg5gpRNs+NfevWY32CmhlVwsQure3hZ?=
 =?us-ascii?Q?f2ObdRNUKXUh6H5ZTB/v0ejSzOwRQFQDAwOW6P7Nx7oZuQMeO717k18kzR+c?=
 =?us-ascii?Q?Jqg5nnxkmYGwBVlYvMcoKSX5nNwbk9Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc18ab0-fa15-4785-730b-08da2eba4374
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:11:16.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/xjGtl2zBtSg5O1q/DlmV3UBquutsR0xo/lbZ02LycGBzxJAoR6jIodb6Ux9uMhx3i/Qmtk5Jhdp22GBqMPjEZctMhuUZM+fd0P0SGtVcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4850
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_06:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050118
X-Proofpoint-GUID: 70UQOseygoE97DfxZD0mCOrXMjppaTxV
X-Proofpoint-ORIG-GUID: 70UQOseygoE97DfxZD0mCOrXMjppaTxV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   f8605f8ed725beedd71e89872e49178b930250d4
commit: 009cb1af01de85c190ffdb84b1944a17a624e493 [2/5] PM / devfreq: Add cpu based scaling support to passive governor
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220506/202205060035.FycydyMZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/devfreq/governor_passive.c:346 cpufreq_passive_register_notifier() warn: possible memory leak of 'parent_cpu_data'
drivers/devfreq/governor_passive.c:410 devfreq_passive_event_handler() warn: variable dereferenced before check 'p_data' (see line 407)

vim +/parent_cpu_data +346 drivers/devfreq/governor_passive.c

009cb1af01de85 Saravana Kannan 2021-03-02  269  
009cb1af01de85 Saravana Kannan 2021-03-02  270  static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
009cb1af01de85 Saravana Kannan 2021-03-02  271  {
009cb1af01de85 Saravana Kannan 2021-03-02  272  	struct devfreq_passive_data *p_data
009cb1af01de85 Saravana Kannan 2021-03-02  273  			= (struct devfreq_passive_data *)devfreq->data;
009cb1af01de85 Saravana Kannan 2021-03-02  274  	struct device *dev = devfreq->dev.parent;
009cb1af01de85 Saravana Kannan 2021-03-02  275  	struct opp_table *opp_table = NULL;
009cb1af01de85 Saravana Kannan 2021-03-02  276  	struct devfreq_cpu_data *parent_cpu_data;
009cb1af01de85 Saravana Kannan 2021-03-02  277  	struct cpufreq_policy *policy;
009cb1af01de85 Saravana Kannan 2021-03-02  278  	struct device *cpu_dev;
009cb1af01de85 Saravana Kannan 2021-03-02  279  	unsigned int cpu;
009cb1af01de85 Saravana Kannan 2021-03-02  280  	int ret;
009cb1af01de85 Saravana Kannan 2021-03-02  281  
009cb1af01de85 Saravana Kannan 2021-03-02  282  	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
009cb1af01de85 Saravana Kannan 2021-03-02  283  	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
009cb1af01de85 Saravana Kannan 2021-03-02  284  	if (ret) {
009cb1af01de85 Saravana Kannan 2021-03-02  285  		dev_err(dev, "failed to register cpufreq notifier\n");
009cb1af01de85 Saravana Kannan 2021-03-02  286  		p_data->nb.notifier_call = NULL;
009cb1af01de85 Saravana Kannan 2021-03-02  287  		goto err;
009cb1af01de85 Saravana Kannan 2021-03-02  288  	}
009cb1af01de85 Saravana Kannan 2021-03-02  289  
009cb1af01de85 Saravana Kannan 2021-03-02  290  	for_each_possible_cpu(cpu) {
009cb1af01de85 Saravana Kannan 2021-03-02  291  		if (p_data->parent_cpu_data[cpu])
009cb1af01de85 Saravana Kannan 2021-03-02  292  			continue;
009cb1af01de85 Saravana Kannan 2021-03-02  293  
009cb1af01de85 Saravana Kannan 2021-03-02  294  		policy = cpufreq_cpu_get(cpu);
009cb1af01de85 Saravana Kannan 2021-03-02  295  		if (!policy) {
009cb1af01de85 Saravana Kannan 2021-03-02  296  			ret = -EPROBE_DEFER;
009cb1af01de85 Saravana Kannan 2021-03-02  297  			goto err;
009cb1af01de85 Saravana Kannan 2021-03-02  298  		}
009cb1af01de85 Saravana Kannan 2021-03-02  299  
009cb1af01de85 Saravana Kannan 2021-03-02  300  		parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
009cb1af01de85 Saravana Kannan 2021-03-02  301  						GFP_KERNEL);
009cb1af01de85 Saravana Kannan 2021-03-02  302  		if (!parent_cpu_data) {
009cb1af01de85 Saravana Kannan 2021-03-02  303  			cpufreq_cpu_put(policy);
009cb1af01de85 Saravana Kannan 2021-03-02  304  			ret = -ENOMEM;
009cb1af01de85 Saravana Kannan 2021-03-02  305  			goto err;
009cb1af01de85 Saravana Kannan 2021-03-02  306  		}
009cb1af01de85 Saravana Kannan 2021-03-02  307  
009cb1af01de85 Saravana Kannan 2021-03-02  308  		cpu_dev = get_cpu_device(cpu);
009cb1af01de85 Saravana Kannan 2021-03-02  309  		if (!cpu_dev) {
009cb1af01de85 Saravana Kannan 2021-03-02  310  			dev_err(dev, "failed to get cpu device\n");

kfree(parent_cpu_data);

009cb1af01de85 Saravana Kannan 2021-03-02  311  			cpufreq_cpu_put(policy);
009cb1af01de85 Saravana Kannan 2021-03-02  312  			ret = -ENODEV;
009cb1af01de85 Saravana Kannan 2021-03-02  313  			goto err;
009cb1af01de85 Saravana Kannan 2021-03-02  314  		}
009cb1af01de85 Saravana Kannan 2021-03-02  315  
009cb1af01de85 Saravana Kannan 2021-03-02  316  		opp_table = dev_pm_opp_get_opp_table(cpu_dev);
009cb1af01de85 Saravana Kannan 2021-03-02  317  		if (IS_ERR(opp_table)) {
009cb1af01de85 Saravana Kannan 2021-03-02  318  			dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);

cpufreq_cpu_put(cpu_dev);
kfree(parent_cpu_data);

009cb1af01de85 Saravana Kannan 2021-03-02  319  			cpufreq_cpu_put(policy);
009cb1af01de85 Saravana Kannan 2021-03-02  320  			ret = PTR_ERR(opp_table);
009cb1af01de85 Saravana Kannan 2021-03-02  321  			goto err;
009cb1af01de85 Saravana Kannan 2021-03-02  322  		}
009cb1af01de85 Saravana Kannan 2021-03-02  323  
009cb1af01de85 Saravana Kannan 2021-03-02  324  		parent_cpu_data->dev = cpu_dev;
009cb1af01de85 Saravana Kannan 2021-03-02  325  		parent_cpu_data->opp_table = opp_table;
009cb1af01de85 Saravana Kannan 2021-03-02  326  		parent_cpu_data->first_cpu = cpumask_first(policy->related_cpus);
009cb1af01de85 Saravana Kannan 2021-03-02  327  		parent_cpu_data->cur_freq = policy->cur;
009cb1af01de85 Saravana Kannan 2021-03-02  328  		parent_cpu_data->min_freq = policy->cpuinfo.min_freq;
009cb1af01de85 Saravana Kannan 2021-03-02  329  		parent_cpu_data->max_freq = policy->cpuinfo.max_freq;
009cb1af01de85 Saravana Kannan 2021-03-02  330  
009cb1af01de85 Saravana Kannan 2021-03-02  331  		p_data->parent_cpu_data[cpu] = parent_cpu_data;
009cb1af01de85 Saravana Kannan 2021-03-02  332  		cpufreq_cpu_put(policy);
009cb1af01de85 Saravana Kannan 2021-03-02  333  	}
009cb1af01de85 Saravana Kannan 2021-03-02  334  
009cb1af01de85 Saravana Kannan 2021-03-02  335  	mutex_lock(&devfreq->lock);
009cb1af01de85 Saravana Kannan 2021-03-02  336  	ret = devfreq_update_target(devfreq, 0L);
009cb1af01de85 Saravana Kannan 2021-03-02  337  	mutex_unlock(&devfreq->lock);
009cb1af01de85 Saravana Kannan 2021-03-02  338  	if (ret)
009cb1af01de85 Saravana Kannan 2021-03-02  339  		dev_err(dev, "failed to update the frequency\n");

if (ret) {
	dev_err(dev, "failed to update the frequency\n");
	goto err;
}

009cb1af01de85 Saravana Kannan 2021-03-02  340  
009cb1af01de85 Saravana Kannan 2021-03-02  341  	return ret;

return 0;

009cb1af01de85 Saravana Kannan 2021-03-02  342  
009cb1af01de85 Saravana Kannan 2021-03-02  343  err:
009cb1af01de85 Saravana Kannan 2021-03-02  344  	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
009cb1af01de85 Saravana Kannan 2021-03-02  345  
009cb1af01de85 Saravana Kannan 2021-03-02 @346  	return ret;
009cb1af01de85 Saravana Kannan 2021-03-02  347  }
009cb1af01de85 Saravana Kannan 2021-03-02  348  
996133119f5733 Chanwoo Choi    2016-03-22  349  static int devfreq_passive_notifier_call(struct notifier_block *nb,
996133119f5733 Chanwoo Choi    2016-03-22  350  				unsigned long event, void *ptr)
996133119f5733 Chanwoo Choi    2016-03-22  351  {
996133119f5733 Chanwoo Choi    2016-03-22  352  	struct devfreq_passive_data *data
996133119f5733 Chanwoo Choi    2016-03-22  353  			= container_of(nb, struct devfreq_passive_data, nb);
996133119f5733 Chanwoo Choi    2016-03-22  354  	struct devfreq *devfreq = (struct devfreq *)data->this;
996133119f5733 Chanwoo Choi    2016-03-22  355  	struct devfreq *parent = (struct devfreq *)data->parent;
996133119f5733 Chanwoo Choi    2016-03-22  356  	struct devfreq_freqs *freqs = (struct devfreq_freqs *)ptr;
996133119f5733 Chanwoo Choi    2016-03-22  357  	unsigned long freq = freqs->new;
b4365423bb7adf Chanwoo Choi    2020-10-07  358  	int ret = 0;
996133119f5733 Chanwoo Choi    2016-03-22  359  
b4365423bb7adf Chanwoo Choi    2020-10-07  360  	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
996133119f5733 Chanwoo Choi    2016-03-22  361  	switch (event) {
996133119f5733 Chanwoo Choi    2016-03-22  362  	case DEVFREQ_PRECHANGE:
996133119f5733 Chanwoo Choi    2016-03-22  363  		if (parent->previous_freq > freq)
b4365423bb7adf Chanwoo Choi    2020-10-07  364  			ret = devfreq_update_target(devfreq, freq);
b4365423bb7adf Chanwoo Choi    2020-10-07  365  
996133119f5733 Chanwoo Choi    2016-03-22  366  		break;
996133119f5733 Chanwoo Choi    2016-03-22  367  	case DEVFREQ_POSTCHANGE:
996133119f5733 Chanwoo Choi    2016-03-22  368  		if (parent->previous_freq < freq)
b4365423bb7adf Chanwoo Choi    2020-10-07  369  			ret = devfreq_update_target(devfreq, freq);
996133119f5733 Chanwoo Choi    2016-03-22  370  		break;
996133119f5733 Chanwoo Choi    2016-03-22  371  	}
b4365423bb7adf Chanwoo Choi    2020-10-07  372  	mutex_unlock(&devfreq->lock);
b4365423bb7adf Chanwoo Choi    2020-10-07  373  
b4365423bb7adf Chanwoo Choi    2020-10-07  374  	if (ret < 0)
b4365423bb7adf Chanwoo Choi    2020-10-07  375  		dev_warn(&devfreq->dev,
b4365423bb7adf Chanwoo Choi    2020-10-07  376  			"failed to update devfreq using passive governor\n");
996133119f5733 Chanwoo Choi    2016-03-22  377  
996133119f5733 Chanwoo Choi    2016-03-22  378  	return NOTIFY_DONE;
996133119f5733 Chanwoo Choi    2016-03-22  379  }
996133119f5733 Chanwoo Choi    2016-03-22  380  
009cb1af01de85 Saravana Kannan 2021-03-02  381  static int devfreq_passive_unregister_notifier(struct devfreq *devfreq)
009cb1af01de85 Saravana Kannan 2021-03-02  382  {
009cb1af01de85 Saravana Kannan 2021-03-02  383  	struct devfreq_passive_data *p_data
009cb1af01de85 Saravana Kannan 2021-03-02  384  			= (struct devfreq_passive_data *)devfreq->data;
009cb1af01de85 Saravana Kannan 2021-03-02  385  	struct devfreq *parent = (struct devfreq *)p_data->parent;
009cb1af01de85 Saravana Kannan 2021-03-02  386  	struct notifier_block *nb = &p_data->nb;
009cb1af01de85 Saravana Kannan 2021-03-02  387  
009cb1af01de85 Saravana Kannan 2021-03-02  388  	return devfreq_unregister_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
009cb1af01de85 Saravana Kannan 2021-03-02  389  }
009cb1af01de85 Saravana Kannan 2021-03-02  390  
009cb1af01de85 Saravana Kannan 2021-03-02  391  static int devfreq_passive_register_notifier(struct devfreq *devfreq)
009cb1af01de85 Saravana Kannan 2021-03-02  392  {
009cb1af01de85 Saravana Kannan 2021-03-02  393  	struct devfreq_passive_data *p_data
009cb1af01de85 Saravana Kannan 2021-03-02  394  			= (struct devfreq_passive_data *)devfreq->data;
009cb1af01de85 Saravana Kannan 2021-03-02  395  	struct devfreq *parent = (struct devfreq *)p_data->parent;
009cb1af01de85 Saravana Kannan 2021-03-02  396  	struct notifier_block *nb = &p_data->nb;
009cb1af01de85 Saravana Kannan 2021-03-02  397  
009cb1af01de85 Saravana Kannan 2021-03-02  398  	nb->notifier_call = devfreq_passive_notifier_call;
009cb1af01de85 Saravana Kannan 2021-03-02  399  	return devfreq_register_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
009cb1af01de85 Saravana Kannan 2021-03-02  400  }
009cb1af01de85 Saravana Kannan 2021-03-02  401  
996133119f5733 Chanwoo Choi    2016-03-22  402  static int devfreq_passive_event_handler(struct devfreq *devfreq,
996133119f5733 Chanwoo Choi    2016-03-22  403  				unsigned int event, void *data)
996133119f5733 Chanwoo Choi    2016-03-22  404  {
996133119f5733 Chanwoo Choi    2016-03-22  405  	struct devfreq_passive_data *p_data
996133119f5733 Chanwoo Choi    2016-03-22  406  			= (struct devfreq_passive_data *)devfreq->data;
996133119f5733 Chanwoo Choi    2016-03-22 @407  	struct devfreq *parent = (struct devfreq *)p_data->parent;
                                                                                                   ^^^^^^^^^^^^^^
Dereferenced

009cb1af01de85 Saravana Kannan 2021-03-02  408  	int ret = -EINVAL;
009cb1af01de85 Saravana Kannan 2021-03-02  409  
009cb1af01de85 Saravana Kannan 2021-03-02 @410  	if (!p_data)

Checked too late

009cb1af01de85 Saravana Kannan 2021-03-02  411  		return -EINVAL;
996133119f5733 Chanwoo Choi    2016-03-22  412  
009cb1af01de85 Saravana Kannan 2021-03-02  413  	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
996133119f5733 Chanwoo Choi    2016-03-22  414  		return -EPROBE_DEFER;
996133119f5733 Chanwoo Choi    2016-03-22  415  
996133119f5733 Chanwoo Choi    2016-03-22  416  	switch (event) {
996133119f5733 Chanwoo Choi    2016-03-22  417  	case DEVFREQ_GOV_START:
996133119f5733 Chanwoo Choi    2016-03-22  418  		if (!p_data->this)
996133119f5733 Chanwoo Choi    2016-03-22  419  			p_data->this = devfreq;
996133119f5733 Chanwoo Choi    2016-03-22  420  
009cb1af01de85 Saravana Kannan 2021-03-02  421  		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
009cb1af01de85 Saravana Kannan 2021-03-02  422  			ret = devfreq_passive_register_notifier(devfreq);
009cb1af01de85 Saravana Kannan 2021-03-02  423  		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
009cb1af01de85 Saravana Kannan 2021-03-02  424  			ret = cpufreq_passive_register_notifier(devfreq);
996133119f5733 Chanwoo Choi    2016-03-22  425  		break;
996133119f5733 Chanwoo Choi    2016-03-22  426  	case DEVFREQ_GOV_STOP:
009cb1af01de85 Saravana Kannan 2021-03-02  427  		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
009cb1af01de85 Saravana Kannan 2021-03-02  428  			WARN_ON(devfreq_passive_unregister_notifier(devfreq));
009cb1af01de85 Saravana Kannan 2021-03-02  429  		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
009cb1af01de85 Saravana Kannan 2021-03-02  430  			WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
996133119f5733 Chanwoo Choi    2016-03-22  431  		break;
996133119f5733 Chanwoo Choi    2016-03-22  432  	default:
996133119f5733 Chanwoo Choi    2016-03-22  433  		break;
996133119f5733 Chanwoo Choi    2016-03-22  434  	}
996133119f5733 Chanwoo Choi    2016-03-22  435  
996133119f5733 Chanwoo Choi    2016-03-22  436  	return ret;
996133119f5733 Chanwoo Choi    2016-03-22  437  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

