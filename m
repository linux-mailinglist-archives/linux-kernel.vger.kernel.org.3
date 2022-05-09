Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F251FAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiEILFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiEILF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:05:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AED2297CE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:01:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249ASx4p010429;
        Mon, 9 May 2022 11:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ANVJz6qDS8WV24JJkFTIBXI7N9GuJ34NDaTkpzw9DKQ=;
 b=yNEPsfF67DaHxboJwnZAzq14qmIqiXs0DnygbqbFbVZIhucqmAh6rJpshzOAvUxZT7Zb
 Goa0esACIimdufmhsqy+m2dJkf0fE5mWJDKI1AJcU7/RGF0TUfTW5zZhKanl4KCB0sAV
 DvuOr4s2WeGMbbomMC8fw/JdNE4Gia0af+PaEHcPXMoIMcQ2+ndk3wN4YP1PZfpSDVAU
 qKr3xBRw8EMRAVvtZTzhPOw/DdlWa9J2ylOTMUKtk+h5Pd4E0BydYSuETLy0WdJk1xao
 gxEG5oz563aCGJD5VZgBeDFC3PuEHr+dHJg+zgNA3K4xzHaVyKKgpKS1VNiPKFD6JxNB qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c32wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 11:01:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249B1F2I036638;
        Mon, 9 May 2022 11:01:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf70sy3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 11:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ55VYyYG5LMuR7NADrvVN0kT1WgYeSWXIO8umvSsv0GhxkdSpQhAo9O0COv7cM5zCZBLA16sFe0eFGKmDNHgRfNn5tmGyuVjoVDl5LJgWr4ZY9vDoZzlcMyS/3TgWHQvAOc0+04HxSCTiyvUXLNOfU/XsTNc14HTAA1VLf+PTGSEb2dlyLjRu2LC1I2y2wdqAduW33TGL2JB3G8ZpOEM+3LVugLZFxLB83yT1/dL1IVsbpi+5hMIGLWC/tiK0H0ps5Y94ZljsUgPg2J7VwpvnGuVrUB0lo2XvkuINbiafsSlY/Nr70FKWAqG6sqc3TiZDfRZQnjcOI+RosGJeY75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANVJz6qDS8WV24JJkFTIBXI7N9GuJ34NDaTkpzw9DKQ=;
 b=iP3YvufPRHlL7ms8g2+l9T+/PRBwBUxbHO+CR4qMhL2jr3sDiv6MdbJO5mRqXnP6MycpPJJEHiE6OiAmKqGloPAKu0ujDkGPpq9OxnTzhgISjVQGLNwSWmeukt5DISh7YH+0yJls2ytIkGIHDNDlqS/u5Hrb+yUmZCytWiSludsu0H3zwD6O82CF9BAX5zLYgsjS+Klql4Z/f56oPSrYFBxltboqjrfRH6k6r/g8oBgKmy94DOEGunrgE4Q/e8ZeH+vu4OuTtfu83h7xV69Bu8qSAIX+uo1AI+r4tfkEGkSTKX/zPEn+PiqCOJUDoJzd0FSVUrq2jYRVWLkFCKjNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANVJz6qDS8WV24JJkFTIBXI7N9GuJ34NDaTkpzw9DKQ=;
 b=CGEEp03fOuaIz9rrJH4VAX79EPaXe6LcDEIZ3NJ+5ZsH29kSIrhslLSH9cYCFpaqMrD7uvafGKln8uSPl62e3E/yWzmrUXnkYwXqM7iTCCdad/QZN75xir710+5TXwIhT+UavcRqKqikOqKh9TDn+vG0d/isJhF47VNJ4OZGt/E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5745.namprd10.prod.outlook.com
 (2603:10b6:510:125::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 11:01:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 11:01:14 +0000
Date:   Mon, 9 May 2022 14:00:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:fix-cec 1/5]
 drivers/media/cec/core/cec-pin.c:1291 cec_pin_adap_free() warn: variable
 dereferenced before check 'pin' (see line 1288)
Message-ID: <202205081847.EPfgN3uq-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d58ae50-fb61-4c82-2007-08da31ab3bb4
X-MS-TrafficTypeDiagnostic: PH7PR10MB5745:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB57455952757E7C1E5957A0878EC69@PH7PR10MB5745.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Lf4zDNHLJWnJwSJ+OOPyCbzweFsIjJao60mUxirZ9keIkM51ld7r8pIr8jM1K1fUuMG7u4JB95SPdr+qsQEw/4WD3YebRmeMzj2C3WMGWu1jtFhfao84SQUJezKPza7gf8kyTCpdJ1Lhg+NxVZ19H0fPg1ot+JHMkJU9OHK0yUT4CZ39G2SqpPCyoNCwPXzaG+F+B1BBAQWhUTHxnnTb4OL3Y+mEHAJ7zrpC0HZQDy/gZMk1DPkRmAv4gtoInblcU77bpmIDypnK62zRgslW4QWNk5OrFEKamTFf14lKvcJ0Zv/c74IlSTmgYqQnd0m9E0HO1AWzs5mi3IU+xfcRZ1DzrpGCk98J3J6giVcQar7TB8SBqpL7vsNWOjQBktLir7i5RdanNFHHhs/CgtCgEVxE01iblw9X/P9yzGiVv1EscVqqjpGwd4aoZ/JdkC7UusH5o1VatbobF2aDPnuP7x9QAk3xQvkHWQLQ3mNhR1PFJWT5hdVRX7eUPdXUdy3g50d5umrHiryssBj4gkTbNzrsIbBWiMJatpPBD1EhofUPrM/lkXG2OoCfqW5cEBc+AljrpN6pk+qCEluQo6MogXzTfmnWf8Pur0oeD4EGGTtTgl2D0QILdIWJgS90k1pW2lq2aQy/cMNZiD+RfGhYP0AV0xm1H9XYQ5nWH/JjFgkFDiXjUQzUJ2vl2HfF3InO1IiiymEmhsjLT1QKoUyagNpnxchSGKMxT2GqDuh9Xck3aJaYqctvrKcsTEvF7rcsexSu8dMNlDuXILouu0MaKniymWOYt1O70spP8pFpl2YlVI8XplXjtjPXfxZPypFF3JEPDQizRYNOcNiU276Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(6486002)(36756003)(1076003)(6512007)(9686003)(2906002)(52116002)(6506007)(44832011)(26005)(6666004)(83380400001)(5660300002)(186003)(966005)(8936002)(508600001)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2je3nmcTv+d9Ou81sv3XUbvF3saobYC4MO6N7bqubOuOcxaCMoOhlsIhQpq?=
 =?us-ascii?Q?s0z+jQVww3noq+dk327RsTBu0UWRNnRmNZnXyN1+DRKlP50Bf4Q7SUWvs9sh?=
 =?us-ascii?Q?ZX9CJ4mTcjbBgmBUpJYB8NduCvpXM2YiIUT8DFjiWhi0+Ut1X6O6Rbt44n60?=
 =?us-ascii?Q?sk/As46/N8qVgMl6eBZNaBh2DhwS2HnU2MB5xNqjBxuiok+EKw3Sv2TeoY3W?=
 =?us-ascii?Q?8ww4+Byg2nxmPSkdu+UvlyV/w9Qbd5ESpS4jIsuAxeJrwDtm3roAuNUD8qJI?=
 =?us-ascii?Q?PG7ja+DgINGPcEt2AqzsCu/5UH0nPiQ6gnp2OPLhE56zI+GUrb6qd9o6q1pv?=
 =?us-ascii?Q?/20zyDGtqY3umz9QkWVJff4i44hpgEhAPelma8kbBuElfn6KGcu4ONoB/PS9?=
 =?us-ascii?Q?HI+69PeOI3KcD70aPXehQ/ZlxzkYLB2UYhLIFSwlFyZ1Gz2ij8y+DKAIm+Rs?=
 =?us-ascii?Q?AVU/14l5B6g0xLlQLDEomXZ2rfVf/JGBmgqbt0Iq4ER3vORzmLjPuTsCihnl?=
 =?us-ascii?Q?zRzcf9JHycYtSE3yyhO2dZwlMDV2/WdcVSNwTRJ9rPERdA5R3gc5S7OInbU4?=
 =?us-ascii?Q?/n7MvirnHUvzUk0/yDp3eVW/FRlJiNw/bKyWwJ9NYM9Jbcv+B/Xf7A4Dtxkr?=
 =?us-ascii?Q?EjaeD2+3OoTsc+xJFyMXckT1Voud1VYBe9+sc4V1IbPEED/V22fFLvpK54xI?=
 =?us-ascii?Q?VyqZ6EjPnH+8o4WvzRYckxNAOxywv5RbIP0HZgSNhIGR8ZMleYcIJRC3stDv?=
 =?us-ascii?Q?DLhHInLhWlxHqbDsgSx6PaJJgYjAEmhL63ALd0+x5rh8K5aYk4nkgN9zNFFe?=
 =?us-ascii?Q?s8dbikoXXvR8EqVNb4D4/G2Ifeo4hUt9UHF+JFcs+v4h6f/onWrHeHKu9sEh?=
 =?us-ascii?Q?JjQAJhpXFWAw1nQGMAs9Uc9lTD0f4CZhoFlBgKKDEXR7BsoQ0M/Efbgg4zlu?=
 =?us-ascii?Q?QxcGIhSzkUbw6YDjoLPyoa/RXQOEIm1sQZXJOa4yrddzkh/+oALta5BkJIhk?=
 =?us-ascii?Q?I/27ulg3/5Kkbcs/KqL6zXFKAgn0XNQAkX5VA3faCXXJlzJIssABQvnKnGqE?=
 =?us-ascii?Q?ithKhsTR28OkutVxQr+qnxFNAuWTMh0oA56niK0q+cZo2F/DgGRGbTGa8ot7?=
 =?us-ascii?Q?F85mLKdCJQMdlHIU7LcG9IOUco0pBXyJjBIh3QYyA/IPNhT3ecl4UKMZWwOq?=
 =?us-ascii?Q?6gqaROFD3JlZstGUuvTEytM5gGvDEYRsXVXzLZEdne7lAOBX9nYLswbk0b2m?=
 =?us-ascii?Q?5WG0QRyVP017AZsxZVQoMosmErVvfWM9uoE+4yVY9K0JcZoeoDCSrnK4HeGp?=
 =?us-ascii?Q?x/IHWyJ/BllZP8e1cpABFqiTh/moSZQCHemeANfWh4I1NmuTIMyF0zE3Yat/?=
 =?us-ascii?Q?9J5KjL/szLxldOe1O2CsDPSltD1yxsfdPv4oPUoUB+uGqDTLMQlp08jjQ9Lh?=
 =?us-ascii?Q?XInE7tJgWr/LjvSY38T5qxCLwXqlWE9PCawJV2ZMDUhfpQpKG69ky83MoFiv?=
 =?us-ascii?Q?SHeBp3OspYW6zaMVRlQDWL6HlEyJ3rkIK/tyOUqfv9ukxEd6X0uapYJVwYQG?=
 =?us-ascii?Q?LMAAQhHKgxxTdrrQkXuG+/uKu7F1AVLkYQP1ZnxpXNsW2MoCUbnGgp49hSxU?=
 =?us-ascii?Q?cfq936pGIQPklY1JfcW20jtidIp5+qXSNYecQp3lP4u+c+LgoXqlL2H/HSf5?=
 =?us-ascii?Q?FSi79l8wO1Us4fFlQzQz/S8aWrp24CZk1XwvPeoVmj7bq+0SmErnshTa2XGh?=
 =?us-ascii?Q?I5TyrbH2E+dtH2JcwdE0mels1g2kcNc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d58ae50-fb61-4c82-2007-08da31ab3bb4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:01:14.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLFWT7APs2AxMV4cuYBVVM4DPZ8Cv7JSnkjG0IxMMcqn6pYdOruxKy/uqDIh3uzY9HVIy3L3e0Yi+VTxmsetPLfVk/YZ8ZhoAwnD407tSAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_03:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090063
X-Proofpoint-ORIG-GUID: IEZ25X7HBsRLA8SxNl8ip-wtDC-SttWz
X-Proofpoint-GUID: IEZ25X7HBsRLA8SxNl8ip-wtDC-SttWz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git fix-cec
head:   dd36bee1793249cb2548e9a4b6c10a079a10037d
commit: bb541e5dcec111915f565b0cf8c3313f38bd72d8 [1/5] cec-pin: disabling the adapter cannot call kthread_stop
config: openrisc-randconfig-m031-20220506 (https://download.01.org/0day-ci/archive/20220508/202205081847.EPfgN3uq-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/cec/core/cec-pin.c:1291 cec_pin_adap_free() warn: variable dereferenced before check 'pin' (see line 1288)

vim +/pin +1291 drivers/media/cec/core/cec-pin.c

ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1284  static void cec_pin_adap_free(struct cec_adapter *adap)
ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1285  {
ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1286  	struct cec_pin *pin = adap->pin;
ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1287  
bb541e5dcec111 drivers/media/cec/core/cec-pin.c Hans Verkuil 2022-05-06 @1288  	if (pin->kthread)
                                                                                    ^^^^^
Dereference

bb541e5dcec111 drivers/media/cec/core/cec-pin.c Hans Verkuil 2022-05-06  1289  		kthread_stop(pin->kthread);
bb541e5dcec111 drivers/media/cec/core/cec-pin.c Hans Verkuil 2022-05-06  1290  	pin->kthread = NULL;
e2ed5024ac2bc2 drivers/media/cec/core/cec-pin.c Hans Verkuil 2022-03-17 @1291  	if (pin && pin->ops->free)
                                                                                    ^^^
Checked too late

ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1292  		pin->ops->free(adap);
ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1293  	adap->pin = NULL;
ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1294  	kfree(pin);
ea5c8ef296681b drivers/media/cec/cec-pin.c      Hans Verkuil 2017-07-11  1295  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

