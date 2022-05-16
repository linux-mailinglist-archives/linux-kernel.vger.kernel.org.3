Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0C5282F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbiEPLPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiEPLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:15:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBA30F76
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:15:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G95BOL017756;
        Mon, 16 May 2022 11:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=z0av6gPpzwOcQNTvXlfwiKMppcKxjvz2nEV8o22FiKo=;
 b=Kn2O9WqchiBZut80z3J4rdHl9cIIgEYdTi6db7LKg8vXuKUKIDNvsl4tB4f7aTau/ax1
 Ojhlqsq/cZAWLfOh/plj9+PVrrTl10GNIL4JDGCcxK7AghKhyuOtqNyNDODXAC3E7/bo
 D+Lc5OnX4x5oZDcCds5XaBJrNk+HIwSKbv5rehcbl3LVmoUIhoyB5D9DcYgGwpl0lKuN
 OKPe3XfewnVL2pi4V0+dNsNwe+4fBa47xqW9bXGl2icTxIGdZSDs7N+QFNgleLLAp79P
 wG/wIvmZJhQnH0zoORTxdaqfzSSuFZvjwoMbnSVbOvWvXQXYPhipL/adjCN0p9fPVIJx Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aaax0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 11:15:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GBBc9r022040;
        Mon, 16 May 2022 11:15:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cnq88c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 11:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB0cR+K+SFEZXFzkM75+vAKi5fI80q8LvYdd2rSQm4sonCAYIbed29xHC4T/SPlQ9yAWMkzdDQSN1qPrkbICGWX8ycrLu1BIq2ymDExu3QomAjfZyFsGCDe2gsfY0AgyRmz3ipzM4kkM5d4sotPAVXtuRQH0eylG1AWDJs97FMpL90AS+dJqUGBawuSZZOTzLt3Zsei0FPSeG/LeLAMCwn9ESAjFlLVxAOtYJk+fkE3C/F99QqZgH0iKuJ5U+CSWdbSiqdEt2p6zBBLDxDHHh5WVmoy52UOe01wAX3EbDoSctnQU2m6IEHFM1lrQPAzpABiwLUUf7PY69hHZkpHn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0av6gPpzwOcQNTvXlfwiKMppcKxjvz2nEV8o22FiKo=;
 b=FL8XTiAY7AH/G8ttzBdTKxA5qsWYw3bSD9VQn/FYBGhizKofgcFVHc36urV1eH0r4fhzqBvHsIO0khSG5Idrsk+GLgKJHBM1fsaPkm1iShptE+i/JpJ1F8SDkSDNYln8n6q0oRSIG9RRAKzy+GSitUZrhCD197OiAr9hCGH5qRW6Spdq0/jyHtaCAfkLLzHKc2csoFo0s4HI70vDTR0sz7Sop7DPxf83iUpt+UpCIT5y91/p+TevZecTBCYvbCthxys9lJN5p7RsJ/WMUvm8OdPEq6YIRFblt7mTW5rsiB0mbKnEYCL4DSVzvc/aB6lRElYxITQFUMu7oG0gNQONyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0av6gPpzwOcQNTvXlfwiKMppcKxjvz2nEV8o22FiKo=;
 b=sdr8I7uEcuHmSlGpkzkoTyqCxNTbZ04LcATTRnmoJ6unQP5s65+jjf5C1jtlJazyKE1YSJzy0SBnhDS7wO9kNxOeLhYuBA0BsGPQ2XYAs+UKxNsSQyNA8dxSykLOAu739z7V06r+sQJ5cW2ccmGI9EgveLt3mrfeFkoBpdh1BU8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1616.namprd10.prod.outlook.com
 (2603:10b6:301:9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 11:14:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 11:14:59 +0000
Date:   Mon, 16 May 2022 14:14:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 48/67] drivers/cxl/core/pci.c:302
 __cxl_hdm_decode_init() warn: ignoring unreachable code.
Message-ID: <202205130114.DpEOzjJn-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ceb3bb-588e-4579-cb4b-08da372d5084
X-MS-TrafficTypeDiagnostic: MWHPR10MB1616:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16162EA389E3E654B4C9A2388ECF9@MWHPR10MB1616.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7xqekg3707yAw8sreK8/+TrILXcq6zBmykEK0ADVUkzhgoWGNKfBfY43L76T841zjurOYxj73T6MEyV0m1O2ansACdkyt8QZ9dYXklX03xdQQu259FzUfh3UE7QwaUr4HPNO4yBkwG++EWgdjVixU27em0HNVYCIeyLYAgIy41QFcDq2ncF+e/iMN4iSDDJTSnjSh+uf/fu+uXJhM9o2l08qNqnLz9VCcF/ARuLh6XXxbEPlWedukxpHLNOX0D2m9ScIlMFyAUjJYt9tAvBNvkCQDUy5gkSN9pxysVr2MFpqBDDP5kbOgWcJbANHyWnYxMvDdDYIceT8Q+b0w5reRPiL+MK458mKV4i8eqQne51bR928vjV7UFXLVus3klbaDNNNFy4xdbR6fmd2etzPYySrPuBP+J7l6TNv60WXOpQmXwm+bFGYX46I89sJQcHZTUNb+0odWeW0h+JpzIL1b3TgKa4YJPewZKODJeGDPg4Yf8I2X4BoVRBsPc+en4V2JeUPeAjNZ04EhqtwxWwiYTXVZlhP+13s1dTE1G3SbS8P3XuYP44MJuAPOkbJHvyAXCuHCE+LwU3V3IxHXXS8vzliYxXnKDMJIZ3j99t1gVvRIJjw+hJh9TQyFLEDseJ95bN+3NTfOkV6aYqdoitqMigbc0fH7gcb76fvMCM6HdvouKP+D/8efAjUvHroVdeAemm57/HY/+haOXPXHx/dHrF7yZTtvKh7lvWmvqh9QPWl7Yw2pEvd2zBoSsmj6jOheqAgywYAFwCq6cYZdKBhxKIASdL5qTxs0rHCP4KYKdT6tfSHXSYak6ub9wHw08gZhHuC2i/W3odIMlFIIGJDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(38100700002)(38350700002)(5660300002)(44832011)(186003)(1076003)(66476007)(66946007)(66556008)(37006003)(2906002)(36756003)(6486002)(6916009)(6506007)(966005)(508600001)(6512007)(316002)(86362001)(83380400001)(6666004)(52116002)(54906003)(8936002)(26005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6IqZTybSlfNJ92A9YSZG4jw4pz/8EMDq7KZynEiYfPiN5WtYTJR6YIoS2IbH?=
 =?us-ascii?Q?2+qufHq98Oy7HYtUbut5H4OYAngItOhnZu5pupDmWk4OSH8Ak/4a0eItMXCD?=
 =?us-ascii?Q?UFqISYOXGUta8JkGy8CJsfzLatwimb2irDiTzccri9a2m6JF9oqFI0oU/aCE?=
 =?us-ascii?Q?hR7pMpViAsUOVue59mwxY6q4mc6OOBVR7FzHgtS9Ff/HiFdC8nW2GUj+jz9g?=
 =?us-ascii?Q?4IuBT3DNzIzZYiZXFYdfy26QvN/xBkJko6x+NgwLJooo1mXeNM0jpcceTOYL?=
 =?us-ascii?Q?Kgej9Okwe7uNRDthUpxDD4DU8N6kRIAcBEIPMt8XF5hFsmljAvqtw80S77Cg?=
 =?us-ascii?Q?F0ky1e9SwnbIAPEn07na/h+Q4B0cw3nUq6eehBoDMRuQdKQ1kTcw4AeuNTEr?=
 =?us-ascii?Q?t75tuSN/udQY1X+PIEno0QWKRugbMYBs8eDovfGXkBO9GeF1fMFBWO9wW3S5?=
 =?us-ascii?Q?QDUZmB2Bu9pzHSU3iPDiko5zuU/jZS1pzGLbBCicZbYPA/x5K3iCO0d2vpns?=
 =?us-ascii?Q?yo/+Z/Q+yFMLPO5AeYQmsnYYbMLoNwDArQYqsPt6YokOFHkeKDu+q4Dhj1Wf?=
 =?us-ascii?Q?GLT8dzeNrdJ5O2J5OHitAZcZYv+yO2N7VUi2TKO5lv49l3doMlqpDyYoBm99?=
 =?us-ascii?Q?Pc7vNUpdCozlk8W9x7YEM2rKWI3DdMh2qrqKfA120eaV3aggCcZEislYHYz/?=
 =?us-ascii?Q?sUAJCbIKGi8AGTWXWV7hdFxr8VEYm/qGQ2sBfeoeUKzuybp/IxdwV35aFf/Q?=
 =?us-ascii?Q?a4rg95Vs+fDrdHQzJZkflf/ttjGh9FCV3ZM+JLP0D1yNX+UToF8fir4jhR0+?=
 =?us-ascii?Q?1ntiHnbB8Wir4e3+yxeUh5NArJGQ1DdMYw4zNy/rgGW2IsM2lzk+S9QuieIj?=
 =?us-ascii?Q?mtxXXwAOmOJvMS3Q+kjzYPF4iJPH1pj0WaC5x3KGdibINUNtJuBtTOYlc8FB?=
 =?us-ascii?Q?dD6w5UuCjGk+JPEIonTPLc5M0//iDBuRRVtBnuKhNtudVkfKCUWiWBs1zSRD?=
 =?us-ascii?Q?LzlXxIm+5n50nIYcCAang+CoHS3tTB1CRAsOAhsZ074VJ9oGqmNiFmCsnxzo?=
 =?us-ascii?Q?R97/fQppfLRUAL+riy7wiS/FlcCtplHUrsJhYP5XRjD2skbfpQM8sPNx7NWB?=
 =?us-ascii?Q?PvHDz7UgHD/ByaOT3Vqph6Pn762cj2ru5xGBf/+E+31KIikYRi2xv6Kq09co?=
 =?us-ascii?Q?/D6NPSxRcrJL0163A7UisaKUuLQkZ6lHueRDePJjbwUd53SYs3SGZpdiF2Qf?=
 =?us-ascii?Q?nTVXPqpqFUZA3KTnlICMQQWCovkJ2rKPGcdAatnGLn4LXEfAqLxXiH/8Bh5O?=
 =?us-ascii?Q?/P+J4Pl8auWtWVVmxM9LYTXccAYQwaIR59b1e+mhj3ZooPD/rKGMjgTbePRs?=
 =?us-ascii?Q?lSnm/tyFLvq0I0vZwXzmQ1wMPneTWjUrW4/4+K6Ws5przg5KY9QYR7TVuK/w?=
 =?us-ascii?Q?e4stVyFxpMvoq5fbjsMv66HDUqs1ouX2GQOT7xP4pcTM7vPrdXrLa3bJLMlm?=
 =?us-ascii?Q?m9WFfLHOkQeY2es5BcBl6kD0nJxPeECRW8p13UWOhjM1HbO0ytG3heACfG0v?=
 =?us-ascii?Q?ZqujTiKs2rrLMEmpq+hJqddBHzFS/lsN9c3YhODGXF/+YhDgJp/GsLZcaNaI?=
 =?us-ascii?Q?FFky4HnesAvxs1R/eOh9UwX7Gb4JPShGy5rLi/lJFzDN6FdGhtasVO2NWUVa?=
 =?us-ascii?Q?wUER/6E9xB/kcxL8fcZUWvdSTX+6Q9NX5QvlQcDXx4UAosMQVZNhgoYyW75t?=
 =?us-ascii?Q?BC61ahCFRbwqJukjeOKSted1aksQTxA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ceb3bb-588e-4579-cb4b-08da372d5084
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 11:14:59.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiMr1saQbUk0FDYlX+f7WQWUdh+w8kptpYRIuMXSSOX6K47IuqXVqFAX4T5tbPac3/kp3o5pZ2NFADEOU0JRMBFtiYteFgkvml4WB5f37A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_06:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160066
X-Proofpoint-ORIG-GUID: yeBcm06KyO5vDCjeUDjkBtEGG8hGP2V6
X-Proofpoint-GUID: yeBcm06KyO5vDCjeUDjkBtEGG8hGP2V6
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9c642abd8b31d895f34186bd72b7360083b58492
commit: 2263e9ed65887cc7c6e977f372596199d2c9f4af [48/67] cxl/port: Enable HDM Capability after validating DVSEC Ranges
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220513/202205130114.DpEOzjJn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cxl/core/pci.c:302 __cxl_hdm_decode_init() warn: ignoring unreachable code.

vim +302 drivers/cxl/core/pci.c

18e7a07f5d584d Dan Williams 2022-05-01  270  static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
9382da4f1fd2c2 Dan Williams 2022-05-09  271  				  struct cxl_hdm *cxlhdm,
18e7a07f5d584d Dan Williams 2022-05-01  272  				  struct cxl_endpoint_dvsec_info *info)
18e7a07f5d584d Dan Williams 2022-05-01  273  {
9382da4f1fd2c2 Dan Williams 2022-05-09  274  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
2263e9ed65887c Dan Williams 2022-05-10  275  	struct cxl_port *port = cxlhdm->port;
2263e9ed65887c Dan Williams 2022-05-10  276  	struct device *dev = cxlds->dev;
2263e9ed65887c Dan Williams 2022-05-10  277  	struct cxl_port *root;
18e7a07f5d584d Dan Williams 2022-05-01  278  	u32 global_ctrl;
2263e9ed65887c Dan Williams 2022-05-10  279  	int i, rc;
18e7a07f5d584d Dan Williams 2022-05-01  280  
9382da4f1fd2c2 Dan Williams 2022-05-09  281  	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
18e7a07f5d584d Dan Williams 2022-05-01  282  
2263e9ed65887c Dan Williams 2022-05-10  283  	/*
2263e9ed65887c Dan Williams 2022-05-10  284  	 * If the HDM Decoder Capability is already enabled then assume
2263e9ed65887c Dan Williams 2022-05-10  285  	 * that some other agent like platform firmware set it up.
2263e9ed65887c Dan Williams 2022-05-10  286  	 */
2263e9ed65887c Dan Williams 2022-05-10  287  	if (global_ctrl & CXL_HDM_DECODER_ENABLE) {
2263e9ed65887c Dan Williams 2022-05-10  288  		rc = devm_cxl_enable_mem(&port->dev, cxlds);
2263e9ed65887c Dan Williams 2022-05-10  289  		if (rc)
9382da4f1fd2c2 Dan Williams 2022-05-09  290  			return false;
2263e9ed65887c Dan Williams 2022-05-10  291  		return true;
2263e9ed65887c Dan Williams 2022-05-10  292  	}
2263e9ed65887c Dan Williams 2022-05-10  293  
2263e9ed65887c Dan Williams 2022-05-10  294  	root = to_cxl_port(port->dev.parent);
2263e9ed65887c Dan Williams 2022-05-10  295  	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
2263e9ed65887c Dan Williams 2022-05-10  296  		root = to_cxl_port(root->dev.parent);
2263e9ed65887c Dan Williams 2022-05-10  297  	if (!is_cxl_root(root)) {
2263e9ed65887c Dan Williams 2022-05-10  298  		dev_err(dev, "Failed to acquire root port for HDM enable\n");
2263e9ed65887c Dan Williams 2022-05-10  299  		return false;
2263e9ed65887c Dan Williams 2022-05-10  300  	}
2263e9ed65887c Dan Williams 2022-05-10  301  
2263e9ed65887c Dan Williams 2022-05-10 @302  	for (i = 0; i < info->ranges; i++) {
                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This only loops once.  if (info->ranges != 0) {?


2263e9ed65887c Dan Williams 2022-05-10  303  		struct device *cxld_dev;
2263e9ed65887c Dan Williams 2022-05-10  304  
2263e9ed65887c Dan Williams 2022-05-10  305  		if (!info->mem_enabled)
2263e9ed65887c Dan Williams 2022-05-10  306  			break;
2263e9ed65887c Dan Williams 2022-05-10  307  
2263e9ed65887c Dan Williams 2022-05-10  308  		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
2263e9ed65887c Dan Williams 2022-05-10  309  					     dvsec_range_allowed);
2263e9ed65887c Dan Williams 2022-05-10  310  		if (!cxld_dev) {
2263e9ed65887c Dan Williams 2022-05-10  311  			dev_dbg(dev, "Range%d disallowed by platform\n", i);
2263e9ed65887c Dan Williams 2022-05-10  312  			cxl_set_mem_enable(cxlds, 0);
2263e9ed65887c Dan Williams 2022-05-10  313  			info->mem_enabled = 0;
2263e9ed65887c Dan Williams 2022-05-10  314  			break;
2263e9ed65887c Dan Williams 2022-05-10  315  		}
2263e9ed65887c Dan Williams 2022-05-10  316  		put_device(cxld_dev);
2263e9ed65887c Dan Williams 2022-05-10  317  		break;

Or delete this break?

2263e9ed65887c Dan Williams 2022-05-10  318  	}
2263e9ed65887c Dan Williams 2022-05-10  319  	put_device(&root->dev);
18e7a07f5d584d Dan Williams 2022-05-01  320  
87aafd75cc537f Dan Williams 2022-04-30  321  	/*
2263e9ed65887c Dan Williams 2022-05-10  322  	 * At least one DVSEC range is enabled and allowed, skip HDM
2263e9ed65887c Dan Williams 2022-05-10  323  	 * Decoder Capability Enable
87aafd75cc537f Dan Williams 2022-04-30  324  	 */
2263e9ed65887c Dan Williams 2022-05-10  325  	if (info->mem_enabled)
2263e9ed65887c Dan Williams 2022-05-10  326  		return false;
2263e9ed65887c Dan Williams 2022-05-10  327  
2263e9ed65887c Dan Williams 2022-05-10  328  	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
2263e9ed65887c Dan Williams 2022-05-10  329  	if (rc)
2263e9ed65887c Dan Williams 2022-05-10  330  		return false;
2263e9ed65887c Dan Williams 2022-05-10  331  
2263e9ed65887c Dan Williams 2022-05-10  332  	rc = devm_cxl_enable_mem(&port->dev, cxlds);
2263e9ed65887c Dan Williams 2022-05-10  333  	if (rc)
2263e9ed65887c Dan Williams 2022-05-10  334  		return false;
18e7a07f5d584d Dan Williams 2022-05-01  335  
9382da4f1fd2c2 Dan Williams 2022-05-09  336  	return true;
18e7a07f5d584d Dan Williams 2022-05-01  337  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

