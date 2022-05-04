Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B11519912
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiEDIEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiEDIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:04:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2E11FA79;
        Wed,  4 May 2022 01:01:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24428cBJ019152;
        Wed, 4 May 2022 08:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=9ny3+W+gBRWTNRbyoWBQSrBQDw2Jlb2uwxJaSImjmFM=;
 b=APd4kBDUcDnERLUPGuGk1BVimC6gXqltHtXpig5L2TQ1HPjP8I8BT5uPLh8vrWIOxDYa
 LdGH+LUvq8PP2h8whJPjCS17RXcu6KR+B1qCn5Wdc0dlQD6oEcN2tNh8dD9E+QpMxJiN
 B+nSYPrcOIbrR2qxMzHVxnz6FKx9s6tDBjov6eFF77OxDWJHlrlpiP5gbM12Hvi3Gi6/
 T2jR0VTcRWBPmMVRxuZCsnXvnO8ADyziqCxtZGvCYqb3ZhSPLKCZ9LqR6yRdm6Q9waIk
 20NMvL9QEGbgkLcFMawFk5XiFvSIyP+6LNHOlp8PtwDGn5I+FgokYH9e+DWTdK/q+wpT vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0aqfhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:00:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24480oMK001559;
        Wed, 4 May 2022 08:00:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj359m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsWwvJl8mmLERSvPFh/vttMhDVBl6Jyme3ewl4tqsTZGpkUj8wl6W7TTEeSK4gvT6AIqfQqbKIRZZFahAcT3GkQOJ+P0HuVr7h9C18qvBt6MDeM9lDLgABfO/2adufJDOC0ofrusLe4+B0HZspvBdDC4n9XOy4u+plpTJL7UDMbfPU5kBxe6CJH983RbX3McoTCaaXaLUNrk8OkANnwDFYj9scegxXW3mqbvqoJAoIBqXl7EMxL21ciFWQVLZcH5wtYKETEgaV8iaxTdThhdBe/hmb9PqltZQ4yAE7HpetRREN9JDKwBpWHeXyzxYhoZmHTJzM85UqVqjRWzFxlwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ny3+W+gBRWTNRbyoWBQSrBQDw2Jlb2uwxJaSImjmFM=;
 b=K9NHsrmLa1BFH42WrMhtXBOmo8RH+mr5B9cICxtnHzbBSvCwXmcYV19kviWcFu3M+IzdUyMe+3VNPon4GJmH4thDkXWnvyuNKcaMxUg9cdK6UGXu7JEd9Estzj5QV1EKlKLXc95JsAroaob4Vrcw0k1jFLu2jdTIT8YWh6KNY13fX695vQGXkCbXQyBA+LLmXU/CE2oeHpktAfHpKDuPDIoBkU4zKItxUUEgL5+Q2nLNwvCLLK8at3H2ZW7CbEfvSWqWRDVj/c6LlxxdeTuXj3W3/kAZ/W7uBwmo8OLiB2ypoZuwJu+v89LyYkpDlO3hR/E9Mzb/rQ06d/gmGgVULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ny3+W+gBRWTNRbyoWBQSrBQDw2Jlb2uwxJaSImjmFM=;
 b=EhasWD+A1Zxn3b6KorqhtEWCkQAmXNnuGVRZ8zNRF0fHkiu/gBJZkhUGk0SSS4QDHtBxpz6MELYG7/10qHTrfNwG6JstkO+qu8dZc8N87TAoutHCYK+X0TqSDqgM+yXxuyubuL0kZtOIOLP4X2Nvwo3gym0lydN4SmKhZxegfw8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS0PR10MB6029.namprd10.prod.outlook.com
 (2603:10b6:8:cf::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 08:00:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 08:00:52 +0000
Date:   Wed, 4 May 2022 11:00:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Keerthy <j-keerthy@ti.com>,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, kristo@kernel.org, vigneshr@ti.com,
        krzysztof.kozlowski@linaro.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, j-keerthy@ti.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Message-ID: <202205030045.5GxgWkst-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427064635.24898-5-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b457fd9c-b3fd-4534-a913-08da2da43574
X-MS-TrafficTypeDiagnostic: DS0PR10MB6029:EE_
X-Microsoft-Antispam-PRVS: <DS0PR10MB60296222DB877A502AD7D40F8EC39@DS0PR10MB6029.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6J1nLObkkWNaff6bbm6VX229k/3lehTxwtLQHS/LJ+eogiCPQv+KiALX/yuYI2vXOo+KS1R7f2l1yzf8XAFcIDN+7dJXfp52mnevCr8VdOd/gAtHXWGrVb1O6yUt14uH4SMWd7Gx4RilV+vMrsDyHhsaExRk/rn3ay9T+t6pDPsIrTofr+1HwwA3ocp6Gc0jKo+OjSd2KXBu5LH/0biuIdLoX7y27DNHxavLVrQQIN641UuuCE9KLz+ZBhV27TArPHOwS2mN7xDj6ui9YLBmmEiY6ZB/IqGjAwk/BsXnaG2fjeh4T0clNdx0DC8uwniV9JvCX76dzOYMxE7q4KS8WeTHpNUlu/ih3o1pUzLw1wfBVJgS8rlEmNPRY+Ei0f1Co8VIdsTspTGklGWwJNegOI41s9JBx2efNHij2LUNPRUWrBpBrAj3+ztFtpv6xM29egC3khnZKU59nSbaFoyOoswBycj+Tt06YWMEH0ahoJsEtk/3VFiikRjs0ffiL0IjpZP5a57iCmYa1roAJ7B7zKIAYWcBJslqd/XslKgS7OFE5ocElGLdr6XhiNJ3+BUDnObUgi1uIyDze31S2Wh6K6MCOns0J37CxmVAxObKIW/6CCoBG1DcbQpV3RNZ6itpeyXOVzyalMEBs7BU6cqqebq77f/ebnw3qzXfrwh5y4q92hU/8l6+ZaNj/XLSun7EZgP/gz8rXquqWDZzVCMQaFol8p+5iYCcHSgPJw8M9gcl8lc/O39BgoKRE/tI7fjht3g8vht6NymLKLcDfSmdMdFqSq1DkkIvX6msX3IQ9QFi4Kia1tmWVXWJ8LicmhyZBecWqofvchvOFYq2P1K8QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(966005)(6486002)(6512007)(186003)(26005)(1076003)(6666004)(52116002)(86362001)(8936002)(6506007)(38100700002)(38350700002)(30864003)(7416002)(44832011)(5660300002)(9686003)(36756003)(2906002)(66476007)(66556008)(4326008)(8676002)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+Gd9fwb1Gz2TXLXWxMds3LFxEX0wmcbv4ktzgGAQBpo0z/VtzOjy119ypPT?=
 =?us-ascii?Q?Dj1BQXLdzNs8j7AT8o5BFx9dH9luE/RiL7xz3/3esq1+mNX+ECJeh29E6Jh5?=
 =?us-ascii?Q?bz+O2Qg/JJKxg6+REpy3vJ+9juAVmIInz9bg1zwhuxbaRxur2JyuhhatOoZX?=
 =?us-ascii?Q?izQJo+iQwO2nPDUByG1GgfiWRE2cEEdHTbcBwKlVmMDm3lTheLGZdw4hDeqF?=
 =?us-ascii?Q?edAODgX+60DhUFVI76sCyDUnnllhbN9qVvI911YFm/cAEJCfmp38gWe9fOBu?=
 =?us-ascii?Q?kqK7KDpZQjUjr4+vTs9COUB3xOFtkXRBXJ0ZfdAqdXKp9n1tLqImaDU7GnAA?=
 =?us-ascii?Q?OS03yZw0a0cLJelkIKSUlLpYHSxTi1CSpZvujI+avTbVtr1jvp8S7pVsGz18?=
 =?us-ascii?Q?q1TU2g1vHxbreWZ7MlRJiWGg2ltQ/fw5E5LccsRANR92Yg7xvT8YdPzKgCuZ?=
 =?us-ascii?Q?kJLN+bKT5+mRnBCNZt+eMiUFLe0SwuBT2ZP4aDKBWuL4VQP2AkylF0YXODQx?=
 =?us-ascii?Q?1rQxo1nIX+Ip2M6VEIOoni3h61g9h7ZawpNXNKRj+sfCz7kjeqvv/hq67sCr?=
 =?us-ascii?Q?oaR+DGpsldHOvVvmlXkwQ3TnmqyYVSMIj3Htp5rkdlRA6uqNlttPvWUEdHa4?=
 =?us-ascii?Q?iifGjw0uMnOI2Y9RS+rCpDr0Re+WpKx3IQaYz03fL3+bgBZnOKze5B0yr9Yp?=
 =?us-ascii?Q?tIdq00q2Vf6q3D30CVbEUSWFP8bRGF45ESwmjt9AnJ3jw6AY5sdXHy24iyeq?=
 =?us-ascii?Q?2xZnDtUEgCpGLJbAdkIpjUvoEYAGkVsnyYWD49fC6LVuCJ51X0Ov/SaWZK/G?=
 =?us-ascii?Q?N5PRaKzNj91A7zixUdgerhKUlgXIINjyyck2wB8sXkMA20VnxkpJqXo5MjIc?=
 =?us-ascii?Q?lTYwmneQsvYxM/EH5f0b5e2Iwl8NsEsCh1Wwgauq+D6cKoE4cpwX7gJ8e7X5?=
 =?us-ascii?Q?SsAQJs6KeTW2G9esDu04YhUwlob53XLAjn7fYZRpio5SgFfnXZw6iZ5+2JSp?=
 =?us-ascii?Q?+doiUemQ7OrxAmt0iUi/u81wnB/oL/EWz70osdRgoQbVlO1IzN7CLiTIL/o4?=
 =?us-ascii?Q?raydv6ObBj0fpOfN3C3cKrjoGPuyXQOyqiGHEo3ZhlLRHX/xeleciVSEJetX?=
 =?us-ascii?Q?bn2Zk7wNHTgO4CfJ30x1Mei6+4ryvCyryDO2KxZR/6DvXWiMvexLcX1aK6Wn?=
 =?us-ascii?Q?U/Dn38L/+WakfY10oGWu6d5a4WhBG29kxYh14WUNoEv+q/kmFsmPS7SxVvvX?=
 =?us-ascii?Q?ew4IWbvdSx+5kNsKTrmVRPZkqdawmTTsm/59r1Zd9WaSuG7Cv/72VGDRPsXS?=
 =?us-ascii?Q?UfJl2E8RVE3Zak7JLZGIxE8g1d891+EEUObRDjwWk1VWVY7K4leVKHELUb5o?=
 =?us-ascii?Q?VpPK0WCo6Z1JLA1YtK/NpDoyX5two6DcPVdgcWTfCa4f6UuDxYmWwMPhRxYr?=
 =?us-ascii?Q?yUiSmBzK39EKxjhO+Zrz57Fn0nZXOHiZy7+gtVE7DXREe3UMEUiedL6IP7nt?=
 =?us-ascii?Q?NYhbkXNmqxok3u2SBgkqFSA0eGO/oyJLdssVxBAba97TGOC13H3H1sFWYdMD?=
 =?us-ascii?Q?K8gxeti0FX74UDU4obK6RXo7qxp17WVqWXk6iFGaEzsBdpNXNj4xmaVO8OA+?=
 =?us-ascii?Q?cKSq8QDNPvse8/nab1svTYk0CjUNTjhT3zK/YUIotjO2xPVwnxVuQQ6HcVh3?=
 =?us-ascii?Q?2CwmHeTqRfa8hPR9rsqCqrMqS4BosfTgp2BfsqTjcvKe5Q7Z7BWeOng2yS2o?=
 =?us-ascii?Q?soAVOylA7OYXS+eO3o5qyN68NClI+Ks=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b457fd9c-b3fd-4534-a913-08da2da43574
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 08:00:52.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu71p1CQr8oldDfPTr9roVBO1Ywa6ZwApWJVMMa7oOv3ApAnvpXKr62s19ryQIqwX89zh+b1PFIEF4lnx2Wxce3iJ1thRLhWWzQSfkmS+nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_02:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040054
X-Proofpoint-GUID: N1JfyRabyjvZyUfW9CraX3Knwu4RWRLj
X-Proofpoint-ORIG-GUID: N1JfyRabyjvZyUfW9CraX3Knwu4RWRLj
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keerthy,

url:    https://github.com/intel-lab-lkp/linux/commits/Keerthy/thermal-k3_j72xx_bandgap-Add-the-bandgap-driver-support/20220427-144949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-randconfig-m031-20220501 (https://download.01.org/0day-ci/archive/20220503/202205030045.5GxgWkst-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/thermal/k3_j72xx_bandgap.c:521 k3_j72xx_bandgap_probe() warn: possible memory leak of 'ref_table'

vim +/ref_table +521 drivers/thermal/k3_j72xx_bandgap.c

bb7f95a68cbaa1 Keerthy 2022-04-27  355  static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
bb7f95a68cbaa1 Keerthy 2022-04-27  356  {
bb7f95a68cbaa1 Keerthy 2022-04-27  357  	int ret = 0, cnt, val, id;
bb7f95a68cbaa1 Keerthy 2022-04-27  358  	int high_max, low_temp;
bb7f95a68cbaa1 Keerthy 2022-04-27  359  	struct resource *res;
bb7f95a68cbaa1 Keerthy 2022-04-27  360  	struct device *dev = &pdev->dev;
bb7f95a68cbaa1 Keerthy 2022-04-27  361  	struct k3_j72xx_bandgap *bgp;
bb7f95a68cbaa1 Keerthy 2022-04-27  362  	struct k3_thermal_data *data;
bb7f95a68cbaa1 Keerthy 2022-04-27  363  	int workaround_needed = 0;
bb7f95a68cbaa1 Keerthy 2022-04-27  364  	const struct k3_j72xx_bandgap_data *driver_data;
bb7f95a68cbaa1 Keerthy 2022-04-27  365  	struct thermal_zone_device *ti_thermal;
bb7f95a68cbaa1 Keerthy 2022-04-27  366  	int *ref_table;
bb7f95a68cbaa1 Keerthy 2022-04-27  367  	struct err_values err_vals;
bb7f95a68cbaa1 Keerthy 2022-04-27  368  
bb7f95a68cbaa1 Keerthy 2022-04-27  369  	const s64 golden_factors[] = {
bb7f95a68cbaa1 Keerthy 2022-04-27  370  		-490019999999999936,
bb7f95a68cbaa1 Keerthy 2022-04-27  371  		3251200000000000,
bb7f95a68cbaa1 Keerthy 2022-04-27  372  		-1705800000000,
bb7f95a68cbaa1 Keerthy 2022-04-27  373  		603730000,
bb7f95a68cbaa1 Keerthy 2022-04-27  374  		-92627,
bb7f95a68cbaa1 Keerthy 2022-04-27  375  	};
bb7f95a68cbaa1 Keerthy 2022-04-27  376  
bb7f95a68cbaa1 Keerthy 2022-04-27  377  	const s64 pvt_wa_factors[] = {
bb7f95a68cbaa1 Keerthy 2022-04-27  378  		-415230000000000000,
bb7f95a68cbaa1 Keerthy 2022-04-27  379  		3126600000000000,
bb7f95a68cbaa1 Keerthy 2022-04-27  380  		-1157800000000,
bb7f95a68cbaa1 Keerthy 2022-04-27  381  	};
bb7f95a68cbaa1 Keerthy 2022-04-27  382  
bb7f95a68cbaa1 Keerthy 2022-04-27  383  	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
bb7f95a68cbaa1 Keerthy 2022-04-27  384  	if (!bgp)
bb7f95a68cbaa1 Keerthy 2022-04-27  385  		return -ENOMEM;
bb7f95a68cbaa1 Keerthy 2022-04-27  386  
bb7f95a68cbaa1 Keerthy 2022-04-27  387  	bgp->dev = dev;
bb7f95a68cbaa1 Keerthy 2022-04-27  388  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
bb7f95a68cbaa1 Keerthy 2022-04-27  389  	bgp->base = devm_ioremap_resource(dev, res);
bb7f95a68cbaa1 Keerthy 2022-04-27  390  	if (IS_ERR(bgp->base))
bb7f95a68cbaa1 Keerthy 2022-04-27  391  		return PTR_ERR(bgp->base);
bb7f95a68cbaa1 Keerthy 2022-04-27  392  
bb7f95a68cbaa1 Keerthy 2022-04-27  393  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
bb7f95a68cbaa1 Keerthy 2022-04-27  394  	bgp->cfg2_base = devm_ioremap_resource(dev, res);
bb7f95a68cbaa1 Keerthy 2022-04-27  395  	if (IS_ERR(bgp->cfg2_base))
bb7f95a68cbaa1 Keerthy 2022-04-27  396  		return PTR_ERR(bgp->cfg2_base);
bb7f95a68cbaa1 Keerthy 2022-04-27  397  
bb7f95a68cbaa1 Keerthy 2022-04-27  398  	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
bb7f95a68cbaa1 Keerthy 2022-04-27  399  	bgp->fuse_base = devm_ioremap_resource(dev, res);
bb7f95a68cbaa1 Keerthy 2022-04-27  400  	if (IS_ERR(bgp->fuse_base))
bb7f95a68cbaa1 Keerthy 2022-04-27  401  		return PTR_ERR(bgp->fuse_base);
bb7f95a68cbaa1 Keerthy 2022-04-27  402  
bb7f95a68cbaa1 Keerthy 2022-04-27  403  	driver_data = of_device_get_match_data(dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  404  	if (driver_data)
bb7f95a68cbaa1 Keerthy 2022-04-27  405  		workaround_needed = driver_data->has_errata_i2128;
bb7f95a68cbaa1 Keerthy 2022-04-27  406  
bb7f95a68cbaa1 Keerthy 2022-04-27  407  	pm_runtime_enable(dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  408  	ret = pm_runtime_get_sync(dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  409  	if (ret < 0) {
bb7f95a68cbaa1 Keerthy 2022-04-27  410  		pm_runtime_put_noidle(dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  411  		pm_runtime_disable(dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  412  		return ret;
bb7f95a68cbaa1 Keerthy 2022-04-27  413  	}
bb7f95a68cbaa1 Keerthy 2022-04-27  414  
bb7f95a68cbaa1 Keerthy 2022-04-27  415  	/* Get the sensor count in the VTM */
bb7f95a68cbaa1 Keerthy 2022-04-27  416  	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
bb7f95a68cbaa1 Keerthy 2022-04-27  417  	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
bb7f95a68cbaa1 Keerthy 2022-04-27  418  	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
bb7f95a68cbaa1 Keerthy 2022-04-27  419  
bb7f95a68cbaa1 Keerthy 2022-04-27  420  	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
bb7f95a68cbaa1 Keerthy 2022-04-27  421  	if (!data) {
bb7f95a68cbaa1 Keerthy 2022-04-27  422  		ret = -ENOMEM;
bb7f95a68cbaa1 Keerthy 2022-04-27  423  		goto err_alloc;
bb7f95a68cbaa1 Keerthy 2022-04-27  424  	}
bb7f95a68cbaa1 Keerthy 2022-04-27  425  
bb7f95a68cbaa1 Keerthy 2022-04-27  426  	ref_table = kzalloc(sizeof(*ref_table) * TABLE_SIZE, GFP_KERNEL);
bb7f95a68cbaa1 Keerthy 2022-04-27  427  	if (!ref_table) {
bb7f95a68cbaa1 Keerthy 2022-04-27  428  		ret = -ENOMEM;
bb7f95a68cbaa1 Keerthy 2022-04-27  429  		goto err_alloc;
bb7f95a68cbaa1 Keerthy 2022-04-27  430  	}
bb7f95a68cbaa1 Keerthy 2022-04-27  431  
bb7f95a68cbaa1 Keerthy 2022-04-27  432  	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * TABLE_SIZE,
bb7f95a68cbaa1 Keerthy 2022-04-27  433  				     GFP_KERNEL);
bb7f95a68cbaa1 Keerthy 2022-04-27  434  	if (!derived_table) {
bb7f95a68cbaa1 Keerthy 2022-04-27  435  		ret = -ENOMEM;
bb7f95a68cbaa1 Keerthy 2022-04-27  436  		goto err_alloc;

ref_table is not freed on error.

bb7f95a68cbaa1 Keerthy 2022-04-27  437  	}
bb7f95a68cbaa1 Keerthy 2022-04-27  438  
bb7f95a68cbaa1 Keerthy 2022-04-27  439  	/* Workaround not needed if bit30/bit31 is set even for J721e */
bb7f95a68cbaa1 Keerthy 2022-04-27  440  	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
bb7f95a68cbaa1 Keerthy 2022-04-27  441  		workaround_needed = false;
bb7f95a68cbaa1 Keerthy 2022-04-27  442  
bb7f95a68cbaa1 Keerthy 2022-04-27  443  	dev_dbg(bgp->dev, "Work around %sneeded\n",
bb7f95a68cbaa1 Keerthy 2022-04-27  444  		workaround_needed ? "not " : "");
bb7f95a68cbaa1 Keerthy 2022-04-27  445  
bb7f95a68cbaa1 Keerthy 2022-04-27  446  	if (!workaround_needed)
bb7f95a68cbaa1 Keerthy 2022-04-27  447  		init_table(5, ref_table, golden_factors);
bb7f95a68cbaa1 Keerthy 2022-04-27  448  	else
bb7f95a68cbaa1 Keerthy 2022-04-27  449  		init_table(3, ref_table, pvt_wa_factors);
bb7f95a68cbaa1 Keerthy 2022-04-27  450  
bb7f95a68cbaa1 Keerthy 2022-04-27  451  	/* Register the thermal sensors */
bb7f95a68cbaa1 Keerthy 2022-04-27  452  	for (id = 0; id < cnt; id++) {
bb7f95a68cbaa1 Keerthy 2022-04-27  453  		data[id].bgp = bgp;
bb7f95a68cbaa1 Keerthy 2022-04-27  454  		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
bb7f95a68cbaa1 Keerthy 2022-04-27  455  		data[id].stat_offset = data[id].ctrl_offset +
bb7f95a68cbaa1 Keerthy 2022-04-27  456  					K3_VTM_TMPSENS_STAT_OFFSET;
bb7f95a68cbaa1 Keerthy 2022-04-27  457  
bb7f95a68cbaa1 Keerthy 2022-04-27  458  		if (workaround_needed) {
bb7f95a68cbaa1 Keerthy 2022-04-27  459  			/* ref adc values for -40C, 30C & 125C respectively */
bb7f95a68cbaa1 Keerthy 2022-04-27  460  			err_vals.refs[0] = MINUS40CREF;
bb7f95a68cbaa1 Keerthy 2022-04-27  461  			err_vals.refs[1] = PLUS30CREF;
bb7f95a68cbaa1 Keerthy 2022-04-27  462  			err_vals.refs[2] = PLUS125CREF;
bb7f95a68cbaa1 Keerthy 2022-04-27  463  			err_vals.refs[3] = PLUS150CREF;
bb7f95a68cbaa1 Keerthy 2022-04-27  464  			get_efuse_values(id, &data[id], err_vals.errs, bgp);
bb7f95a68cbaa1 Keerthy 2022-04-27  465  		}
bb7f95a68cbaa1 Keerthy 2022-04-27  466  
bb7f95a68cbaa1 Keerthy 2022-04-27  467  		if (id == 0 && workaround_needed)
bb7f95a68cbaa1 Keerthy 2022-04-27  468  			prep_lookup_table(&err_vals, ref_table);
bb7f95a68cbaa1 Keerthy 2022-04-27  469  		else if (id == 0 && !workaround_needed)
bb7f95a68cbaa1 Keerthy 2022-04-27  470  			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
bb7f95a68cbaa1 Keerthy 2022-04-27  471  
bb7f95a68cbaa1 Keerthy 2022-04-27  472  		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
bb7f95a68cbaa1 Keerthy 2022-04-27  473  		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
bb7f95a68cbaa1 Keerthy 2022-04-27  474  			K3_VTM_TMPSENS_CTRL_SOC |
bb7f95a68cbaa1 Keerthy 2022-04-27  475  			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
bb7f95a68cbaa1 Keerthy 2022-04-27  476  		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
bb7f95a68cbaa1 Keerthy 2022-04-27  477  
bb7f95a68cbaa1 Keerthy 2022-04-27  478  		bgp->ts_data[id] = &data[id];
bb7f95a68cbaa1 Keerthy 2022-04-27  479  		ti_thermal =
bb7f95a68cbaa1 Keerthy 2022-04-27  480  		devm_thermal_zone_of_sensor_register(bgp->dev, id,
bb7f95a68cbaa1 Keerthy 2022-04-27  481  						     &data[id],
bb7f95a68cbaa1 Keerthy 2022-04-27  482  						     &k3_of_thermal_ops);
bb7f95a68cbaa1 Keerthy 2022-04-27  483  		if (IS_ERR(ti_thermal)) {
bb7f95a68cbaa1 Keerthy 2022-04-27  484  			dev_err(bgp->dev, "thermal zone device is NULL\n");
bb7f95a68cbaa1 Keerthy 2022-04-27  485  			ret = PTR_ERR(ti_thermal);
bb7f95a68cbaa1 Keerthy 2022-04-27  486  			goto err_alloc;
bb7f95a68cbaa1 Keerthy 2022-04-27  487  		}
bb7f95a68cbaa1 Keerthy 2022-04-27  488  	}
bb7f95a68cbaa1 Keerthy 2022-04-27  489  
bb7f95a68cbaa1 Keerthy 2022-04-27  490  	/*
bb7f95a68cbaa1 Keerthy 2022-04-27  491  	 * Program TSHUT thresholds
bb7f95a68cbaa1 Keerthy 2022-04-27  492  	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
bb7f95a68cbaa1 Keerthy 2022-04-27  493  	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
bb7f95a68cbaa1 Keerthy 2022-04-27  494  	 *         This is already taken care as per of init
bb7f95a68cbaa1 Keerthy 2022-04-27  495  	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
bb7f95a68cbaa1 Keerthy 2022-04-27  496  	 */
bb7f95a68cbaa1 Keerthy 2022-04-27  497  	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
bb7f95a68cbaa1 Keerthy 2022-04-27  498  	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
bb7f95a68cbaa1 Keerthy 2022-04-27  499  
bb7f95a68cbaa1 Keerthy 2022-04-27  500  	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
bb7f95a68cbaa1 Keerthy 2022-04-27  501  	       K3_VTM_MISC_CTRL2_OFFSET);
bb7f95a68cbaa1 Keerthy 2022-04-27  502  	mdelay(100);
bb7f95a68cbaa1 Keerthy 2022-04-27  503  	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
bb7f95a68cbaa1 Keerthy 2022-04-27  504  	       K3_VTM_MISC_CTRL_OFFSET);
bb7f95a68cbaa1 Keerthy 2022-04-27  505  
bb7f95a68cbaa1 Keerthy 2022-04-27  506  	platform_set_drvdata(pdev, bgp);
bb7f95a68cbaa1 Keerthy 2022-04-27  507  
bb7f95a68cbaa1 Keerthy 2022-04-27  508  	print_look_up_table(dev, ref_table);
bb7f95a68cbaa1 Keerthy 2022-04-27  509  	/*
bb7f95a68cbaa1 Keerthy 2022-04-27  510  	 * Now that the derived_table has the appropriate look up values
bb7f95a68cbaa1 Keerthy 2022-04-27  511  	 * Free up the ref_table
bb7f95a68cbaa1 Keerthy 2022-04-27  512  	 */
bb7f95a68cbaa1 Keerthy 2022-04-27  513  	kfree(ref_table);
bb7f95a68cbaa1 Keerthy 2022-04-27  514  
bb7f95a68cbaa1 Keerthy 2022-04-27  515  	return 0;
bb7f95a68cbaa1 Keerthy 2022-04-27  516  
bb7f95a68cbaa1 Keerthy 2022-04-27  517  err_alloc:
bb7f95a68cbaa1 Keerthy 2022-04-27  518  	pm_runtime_put_sync(&pdev->dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  519  	pm_runtime_disable(&pdev->dev);
bb7f95a68cbaa1 Keerthy 2022-04-27  520  
bb7f95a68cbaa1 Keerthy 2022-04-27 @521  	return ret;
bb7f95a68cbaa1 Keerthy 2022-04-27  522  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

