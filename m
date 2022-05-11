Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85F522FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiEKJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiEKJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:45:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D4177065
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:45:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B7W0S8013766;
        Wed, 11 May 2022 09:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=X0Yww1Kg7PeIBiDcmdjPt6BGf8YbzC4XLqtbgO82sQs=;
 b=StRa3YB4WL1VVcYH6iAFoj4OKv7TfRwOn436mobm2HsmnxoGIfjBrNyGfRmEK1P2vVVG
 jsWZIjk+OAk/ajj0GgQ3cVdcbzgK9fXk9bZRB2eik5Es6ACtMcTWc4Y5jJOGkgC3WFQT
 92nkjswkF+YYk7iMdA4bhN2qJwLz7/u4VnVp3aJlIIP0Uh/BfCTG75XVkyHfrJ74QJf2
 Ld/BAIvAMSsIDqh4UfZHp0BmxyRt/l7jCl2hXCFy68TgdQoteRx6C6OvVALWz7mZi4W7
 26PMkixGB2X7e3soXHmh/RzikfWJM58JvDLOnh4XsCdWxo2ViyLiW3q0xuqTwZo+jJqM Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9rvfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:45:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9fKOt013923;
        Wed, 11 May 2022 09:45:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6ek4rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4owZlQmAYMuWa9Fr0bpAi/InRIHqs3VYoc5U7pUfIDdpBpRg4tFlTaYFrB0zXCFG9bvsOOnyFNb1Xk5PGoth386H8dfpaKNx692lP39Q0OCoW5yuPDsDACF5hNob2OXBbI0RYP1lP8DCwxJjmNwjqoX5RCZZfXevWt9dFLHIzYntN41Gc1N3uumZn0c1IFXH9p65BYjWzJQ0kIOWSAcHALBV5cQz2BzDxZpia6WTYHv8wkC0jAREsNi+qjc2sZKUWf3cG8pj4+hcDYKXSAmttBqtdGb11bVLmlVzja4Ux9asIjVNmIESt+wLgYejRl0TR6+Fam54OVHSvnrPIj0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0Yww1Kg7PeIBiDcmdjPt6BGf8YbzC4XLqtbgO82sQs=;
 b=EIuTObCUAD02hzVZilQ0+1zrN8Gi6vv82AxYptyKeMGUL0PDA3KYeR2/gpF8j0k5cU6pSttBXRAWNXCZIe0LdrNyU3Hw7nvcG7uSy7D0273iNOukT6KfqjTWGzMw6ABC8WiGVjT9gzxXD553Sag0JY9s9jVd8UeF7B+eODOUtAv1/H28pWxg+CoVDA5MMJRsGCQMTL/oDXc1pHdKpRpiqsTHPnrfGjVLI2YyKh7/XragUAO0XB9vEVbjJEWp+yXr5arFJKJINvB1MzWOqfA/UdKsnXVhMNi3MmaVuEXlqztzsy0WAzchwUeu0NqEAi5e1AufkJkBTL19m3dk00yd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Yww1Kg7PeIBiDcmdjPt6BGf8YbzC4XLqtbgO82sQs=;
 b=oHjOAOd6tH8jVPDuvtIULBmuKWiduu/6wCplHZBryI7LkLZp38p2WkMUBg7fvONVPmmO0zGb7ejwsF1ID/iULTBsKLIYXRw+qlUi0w7lbXUbUhroU0SO33zkxRUDROH7BXxGYD8cQymZiMoOoMVDh+oCRUv+kcIdn/1bEW3s9xE=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by MWHPR10MB1455.namprd10.prod.outlook.com
 (2603:10b6:300:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 09:45:02 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:45:02 +0000
Date:   Wed, 11 May 2022 12:44:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v3 10/13] drivers/opp/core.c:1335
 dev_pm_opp_set_rate() error: uninitialized symbol 'ret'.
Message-ID: <202205101034.m9Hf56oV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bff027b-b2a6-414a-1632-08da3332ebaa
X-MS-TrafficTypeDiagnostic: MWHPR10MB1455:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14550DA343B3D0D48EE1C8618EC89@MWHPR10MB1455.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGC5L4ixx45hQK0mi1QoYkMa6b6TlADUifJUUiNpd1h4z5DXVeIXWPEQmmg3lrjqr/XyP0gK2tjG09B/RwHbcNLbAMtMTwLcKPxsK0F/mM/0/JCM2mpZN1hrtbl5ML4FHXaYsapM9xwx9ZbZGAbdtgecPcO+uD6r/fOOXjUDIIBoIDbGhzPsosKNCtkJhWH386uEVYG5kMOEhGlIXS0m0FhL7L1eWEgn0JmaEcp6yg1PxKbxlt1n/wagNDQTWbvWNunbJKmIx+OaFRMeh2olr0Ui4MsdcPrsQ2aePvAvBhdc+ZmLSYt1VZ23lIwwUn7ElYBuwplATBnTUAK+lEWfTs5YfpRr8KXBaLjpuTnjUyMIVi52QpCOcJN0wktSHrYb55QHNUTC6cK0qKRbrK7smzboi5AiQ8py9aTYVzG5IfQaI5EdO4rVCUe0JMnC85Cy0308wF0rsnkBYYaAoJSYgrlimaBpFEdYHP/IcYyu8fqn7JfKSKNcetlm6JnDhjEbQxJXlyq+FOXR5QX+jzKpdTFf0he7Ro4eT8FPPnRz44YnLcFfCD3BqL7dytpk+B9kGnWXHr6YivHqvGb5M7PriPhc5rtgLQraGw5ZhkSSkZVyAun3t9iuFrFdmP2qmNTu50wvmEzgT4zlI5D0DmWJQmFosAwT1fMROZDXYVhF0xviVU/WO72ysV85xMWziZLrZkWFyKsu1eQXXN9omOg6bhFNcPNttV3TcOl4tM7w5Z8JBUZK958Ja6D4N4RJGiyr65IQHfO8oZjxH6CZ12nZZEOH2+c+Qucvkr+X37m9Jr0MW6vMyLf0VvYT1067ayTx6kmnarH5ebflwxkoPGiJwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(36756003)(6506007)(8936002)(38350700002)(316002)(66476007)(66946007)(66556008)(83380400001)(6512007)(6666004)(5660300002)(8676002)(4326008)(9686003)(26005)(44832011)(86362001)(52116002)(6916009)(186003)(966005)(6486002)(508600001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L6BfmpUmcKEPpQD86l2MmE2jKP9bKRi8cnlfWuyThyP/MmuwybEbwKibri4l?=
 =?us-ascii?Q?4I10WjKQKtbhy4LG9sbjviYQpa5O99ljZ5vw8TDMUMbU4Qpe6Xa7S++9vXzP?=
 =?us-ascii?Q?B4hPYMEu7CEvLrGWaP+kfXkUSN5TDF+IlbyHJgUJERvkxlttM/osukJn2sQo?=
 =?us-ascii?Q?UnVuKCz8WdkYs9AzKX+Bb5j9D02Xg/Zq3fZj31tu5ACrSNdYnCRB3q7bZoAb?=
 =?us-ascii?Q?r85/bPEKo8lkR+lUvPScywQqMaSYE2REzXUfvXymWQsMNCWki93Dax0ks6+9?=
 =?us-ascii?Q?gGgoaMuyFHHLOENSJWg/OtGJQKNZNmOb+UYVthtWHVABxlP/OS0VnwUIg+XQ?=
 =?us-ascii?Q?Zh55C/221sWrBQ/UP9IFrPCG5Z4Jn8c0ArGrhIqGMwyZtqfKZLExkww+dNrN?=
 =?us-ascii?Q?hp47Nff2Hta8/8PhcjXhNTpS+/8858blRuFCHcmx4y7UKa0ssBKgS9ifLQcz?=
 =?us-ascii?Q?1rV4eZT9gBdQm1CxFbnw5rkdYKTq0d/TohlIpdQ1pzr7KLPd4kcY7aA0DqO7?=
 =?us-ascii?Q?5rtifs2KjRWl+EuZFbpQc3YhK9o2b3CPFJTgECsaDvaQ9jYGK3vE+HUeSsKT?=
 =?us-ascii?Q?FeWSxSlHvaF5+dzkTZRtKlpO1zNDRQN1BfhEuOUpUdaKDMcyvgwgDziMcyOj?=
 =?us-ascii?Q?U2bpLKGU1tacZw4tHq/P6ksesIbFz1zDIC+MmQHkMDIQl6sNL86w7+tGV8Mn?=
 =?us-ascii?Q?nwM3t3h6jYjRMD+tEHEUhSTmk4dcvjTeO7uQn2P14XuL4Thd8aezqtMNEaME?=
 =?us-ascii?Q?xh4jc8XRaFblbTl7qE/XlI49NKIz6otYgmvsIblCtF3wk8JqyxyOwdqRYPwh?=
 =?us-ascii?Q?hbVqtdMeR3NNwwwcGm/QSFkIrfslFyiIkZ7LZYi2YThIma2n1PjDRTMDZ4iE?=
 =?us-ascii?Q?MdNCwaUvyzvmRQrcGsksWUjZNblIj/+pTtIiFzjqPHd+J+/W3juBeiUw0UfE?=
 =?us-ascii?Q?qzheqk5ryppfeS872j9MX2XLWXYAxynt/MmSYOUJT0y9iOm7ihc57khtBlKa?=
 =?us-ascii?Q?axGsDiKdLQXsPlK22vR9r7pn7qVNpVZrq3Bro0dKw79phz4qK/ih1FcFbXpO?=
 =?us-ascii?Q?kswpyE0Tn/n9KXuoK4xPEjUCL5h7wDRPYWW13oBBSZ69XrZmz8Nn4vjJQPsM?=
 =?us-ascii?Q?rNYN5ogt3973m1io7JXms3zyJHuUM9rdvRe4MTorSwFG6ZEVHUhUkrsiIJWT?=
 =?us-ascii?Q?OMq5wtL1GcLllitsxsZeFIyXMAy51dbmaBn9EhjFRdESlN6bxJitqXVyWixl?=
 =?us-ascii?Q?/URTCf+9Dzxvl/jnLw28D/tHCc33zvIGpn0uRFxm0yeFlltE6agKHLWC6TxN?=
 =?us-ascii?Q?U12u0SjZdWn/XVOa8ieMk4PHI+0ozurQ+TqPLYacz8xM/XZuS0vLQCYfvfwn?=
 =?us-ascii?Q?8AdLs7YnBJ716smUCGzYPPCsdXFRa9ttIMLFCi5W1RfuV/PwZCLQcjQpJtkH?=
 =?us-ascii?Q?QRmYSwHQmJyx0IghsmBtmcsHprA/QssC6tkeWD3/bzpOgYk8rFDLtswZ9J6J?=
 =?us-ascii?Q?ycDqJW0XQ0VoeH63R1hCr2vtrOzD390jagmRv+2/tPYwqODi5TcyNVG3DLR0?=
 =?us-ascii?Q?U3G6MfFT/8HbV3ECbatpHWvm1jWnVI+AlvpWR5jQKbe/B2VjSjLLx4SuNnJo?=
 =?us-ascii?Q?oXz++5foBnbWIrBDrMMlryg9Qo7WOBCY2mdzGuTctwTZR7B61GmMDljZnONL?=
 =?us-ascii?Q?mNgxkz+p3wE0n8YAFujWLKXpvH0fKXV8xRfox4OyxXferpovK2ouvSv5dkHy?=
 =?us-ascii?Q?wFhpLt7HoAs0HqX1mVdMMBQWLmcHDmk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bff027b-b2a6-414a-1632-08da3332ebaa
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:45:02.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz0+lzTUJ9vBZxilVrezfjxVigQBXbdnA+96z2nVALHjJ9iE3peRop7ENtGfmlsDo7UYMpOwMGPS6BixQaoUlwlto3HgYjgbv7HzB+k1rtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1455
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110043
X-Proofpoint-GUID: UmHGYT-S1YvPEYuF5M3Rjv72RleAJDtb
X-Proofpoint-ORIG-GUID: UmHGYT-S1YvPEYuF5M3Rjv72RleAJDtb
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v3
head:   22a49fd92d5e31234d4174cdf1fdade79f38ae3d
commit: ff3c34983e1cca80d8c081ea99e0117c5c38c6c3 [10/13] PM: opp: allow control of multiple clocks
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101034.m9Hf56oV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/opp/core.c:1335 dev_pm_opp_set_rate() error: uninitialized symbol 'ret'.

vim +/ret +1335 drivers/opp/core.c

386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1275  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1276  {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1277  	struct opp_table *opp_table;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1278  	unsigned long freq = 0, temp_freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1279  	struct dev_pm_opp *opp = NULL;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1280  	int ret;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1281  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1282  	opp_table = _find_opp_table(dev);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1283  	if (IS_ERR(opp_table)) {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1284  		dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1285  		return PTR_ERR(opp_table);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1286  	}
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1287  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1288  	if (target_freq) {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1289  		/*
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1290  		 * For IO devices which require an OPP on some platforms/SoCs
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1291  		 * while just needing to scale the clock on some others
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1292  		 * we look for empty OPP tables with just a clock handle and
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1293  		 * scale only the clk. This makes dev_pm_opp_set_rate()
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1294  		 * equivalent to a clk_set_rate()
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1295  		 */
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1296  		if (!_get_opp_count(opp_table)) {
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1297  			if (opp_table->clks)
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1298  				ret = _generic_set_opp_clk_only(dev,
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1299  								opp_table->clks[0],
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1300  								target_freq);

ret not set on else path

386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1301  			goto put_opp_table;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1302  		}
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1303  
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1304  		if (opp_table->clks)
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1305  			freq = clk_round_rate(opp_table->clks[0], target_freq);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1306  		if ((long)freq <= 0)
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1307  			freq = target_freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1308  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1309  		/*
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1310  		 * The clock driver may support finer resolution of the
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1311  		 * frequencies than the OPP table, don't update the frequency we
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1312  		 * pass to clk_set_rate() here.
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1313  		 */
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1314  		temp_freq = freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1315  		opp = _find_freq_ceil(opp_table, &temp_freq);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1316  		if (IS_ERR(opp)) {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1317  			ret = PTR_ERR(opp);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1318  			dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1319  				__func__, freq, ret);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1320  			goto put_opp_table;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1321  		}
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1322  		/*
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1323  		 * opp->rates are used for scaling clocks, so be sure accurate
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1324  		 * 'freq' is used, instead what was defined via e.g. Devicetree.
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1325  		 */
ff3c34983e1cca drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1326  		opp->rates[0] = freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1327  	}
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1328  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1329  	ret = _set_opp(dev, opp_table, opp, freq);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1330  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1331  	if (target_freq)
8a31d9d94297b1 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1332  		dev_pm_opp_put(opp);
052c6f19141dd1 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1333  put_opp_table:
5b650b388844f2 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1334  	dev_pm_opp_put_opp_table(opp_table);
052c6f19141dd1 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23 @1335  	return ret;
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1336  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

