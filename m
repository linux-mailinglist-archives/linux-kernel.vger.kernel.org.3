Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6A50819F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359573AbiDTHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359557AbiDTHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:04:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7198C39160;
        Wed, 20 Apr 2022 00:02:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K2pws6009531;
        Wed, 20 Apr 2022 07:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=6ZobqKFNrbpxVMzbRiBq3C5NW5VcyRSnVKauWNLlI8c=;
 b=Vqhu/fRxf3dF4gzrPUwZbX3eXxe0sMOSKxGy3EBEJUJDfjFgWIJmMJyUXoNHUK2CghIJ
 UoI+NE27DcOfwvmGcphzoDS0fPAeUqZ+tg4/TzKUgCKT8NrRrm/T1AZemBwm14EpAGQ/
 B6uv9V4dmGPkC/4AviobD1+1v61HIRUPfG1sDOXobDIGO2/ux5Ri8pzIQCkGN2WPOy1L
 MMFTDvOhhaevIQw9VfsxUV172CMkOgRDZXj3AMVM30ZUxi4cHfuR50oEtiUK7yc1VgZ2
 6SyOEARv8n3XsXlRTFHwazubbZ9T1fs/lRqkylQIJpSn4dCpvARuThnNj4gMTzkoxfh1 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2r447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 07:01:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K6tgK0031270;
        Wed, 20 Apr 2022 07:01:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88ytsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 07:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g59ItvOWszLshtI9xxjUk40KL0q8Md9bkGE8qAeTsDpzf8eBdi5/yaE/wBUbLFnPe1pKslFh5wE0BmEiK3TZGRCNflOgijxTpYI9x1+4hn1v3e4WcLny4ZsCEEd5lXHmvoy3VO+fNGAXCItPMsBdbibQnV0MnlobuSnGNUuwwcJkBr1Fe2GlcqPrOtjb7DAalTEfv4mM1OzJAWC8c8tUMW16BP1b5JCJ/P4n8UkSlj8uRu/1EykXOkhjx6WwFKjlr9hVjCYSZME9bp9/NO33yuZgSu3wk3NWrpAjPUMMT8kS7veQEgIVdzHzJyzi5mXkSv0TRounYvYiO5zwGAZhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZobqKFNrbpxVMzbRiBq3C5NW5VcyRSnVKauWNLlI8c=;
 b=jZj/5p45qnCeNca7hR9NHcRpWPkDX+6Mw9WlZ8/bn+e59VYZa4qxpQn7pudP9mIYwZfoTNLulSPo5t5fE7mmI9EZzCp+5kU1I6XtLZMLZaVapeuUkbQ3SMvFTHB4bP9Nsbs1/HxMDilbpb3BNiHkGPMEovaGc3O3zj0vdNXCEgxRw5KVXmsMSGkFOA7Uefj/H3eKf1mRBn5H9xZ8NfAAaSKA66coonNr8snypA3qn9OXvxt3fjNYb0yissQ+Ry4pl25js8oqMsIXcK/BQGCiBPJEyZDgyMDjUg62/lROqgRs4Gn3ADEsfujGyZu4mxx9e8q9vOx7mPLU/h7/PXM2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZobqKFNrbpxVMzbRiBq3C5NW5VcyRSnVKauWNLlI8c=;
 b=Rs3iUmeaEc1IdzpHLF7uv448tVb7vbTZqK+PIc9GlH6zMU8CbsnUuKJ5mKkgssopE9jReOL4uzu9pHfwJCuHDvnsYwUPx+wNScKoDdQcm4IGfgti4zZRR3nTXNULNjsgnMotozu8NnB1eFI2/cO9moes5tp5iKHpDhJm1m/Bfz0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3569.namprd10.prod.outlook.com
 (2603:10b6:408:bd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:01:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 07:01:49 +0000
Date:   Wed, 20 Apr 2022 10:01:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Keerthy <j-keerthy@ti.com>,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, kristo@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, j-keerthy@ti.com,
        linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Message-ID: <202204151117.NLsoANXl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412101409.7980-5-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9827830-248c-4dec-fa4c-08da229ba3c6
X-MS-TrafficTypeDiagnostic: BN8PR10MB3569:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3569FBDC8A845A75383324718EF59@BN8PR10MB3569.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJT0RrwBxxdTM8f4Ylpgn/yV5+Qzix9VUAFjpfkMnXDuosvfe/1+8K+lz1Pd7HvGyIYQ5xzwS96azMdv3A4ImpmwOqgLY/fag/yAEyJQBRcMt1SL7RWBMWgWnZMfrRebPOlN3d1DgGN4REnn00Hl2fhyggMsk08SwQZN0hPivbEkZJboaeyD1iud3bBT/feM3OO3qQw0nI22Jq6SPOgqMkOC8JXKuLjtSOEv84cKF9mq5k+nsnUPkeKVKajiH+yN9RxrMcl+hqFd9zIZbA2fWWWNjjC0nP2MIH3EPUZnqWivOksSgJK7jJq/VZG/fjMK9xZMgq3Ky0lgRNNIv4NXV1qkmpaX3HuDugr2a5MuEd0kflyQHFkSFjtjf+kt+QJML+o3iGJ0V/J3ksw8KN2SEAkU+uw+lOtCkGvg3EHfvDh0NNrBGOwxmT9oWeuw1Vd2dE+yQUZFftlNZTPFLTylGv/OsPvDCaPS3P0RFAfVN/uH14ffDMV9gF0N4GsNH9O6enlQY+zKiRE3vNNpTJoArkn5xYdqKJpvebn6cmgBSxsUCPecZV9FYKFLXnBLZJH+GkX9onN11YeTirB4UlR43YhkUT69BglOLwZx1z9gqzX9kTSYQjaMrEcX9yKp3DiXgJrTfYdEY27egAVdx4uQ6C+Wj87waTTyOWSr7T84LFP7lpo7qmdukCgORk55xUXojhso5U3+DuZDl+UlaIhRFxfqY+nTR5yoApAJud+zRw0weR5T+5uEsaE49cHALHmDLk83UlIWjemNLbcygfPjuCYTnIptPfFOiqGi2aHlpLUunZ2l4zmKNC2LcMzk6zZT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(966005)(508600001)(38350700002)(4326008)(38100700002)(83380400001)(6486002)(86362001)(316002)(66946007)(5660300002)(1076003)(8676002)(186003)(66476007)(26005)(44832011)(6666004)(6506007)(7416002)(6512007)(8936002)(30864003)(2906002)(52116002)(9686003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pOeuAADtaiwmPLP33oZWveJ+GDiXoNeWiL2e+a/XGebKpNbmSZPlm7OYDwEk?=
 =?us-ascii?Q?TnloJVlivWU7pdGa+qym+CE/kHtUt/qlc4NNC/rxK7ncvss2J90tZP2133QP?=
 =?us-ascii?Q?stQKA/+ed6zXXnpfVtzIKTyJRbdJ8JGdyXyRU339IOA946S7ZT71El34VASt?=
 =?us-ascii?Q?gAz7FpEvS6oxQpc42m0z/Yg4qxsMtRbd4gUGMnCguQL8BKPNapYV05fS12c+?=
 =?us-ascii?Q?9vNJwiV72ACx6w/au/8di900fj2ibQ0GwiPSNiFL2h6ybcSawRIpR8pdSNg1?=
 =?us-ascii?Q?kiIsGqBEpuYKIP1XYni9GCzAvR+c5+WCi9PgQrRwSjvB2ejbaMDy+NkSf8cJ?=
 =?us-ascii?Q?NVIrTr/QNwCom82I33GzWrYLZwgD2T8MCLcFyP7s/08XyiFShDLVl/9nWh5u?=
 =?us-ascii?Q?JNKWsJGE8eSHW2/bjgWU7IMgkLKt5BSn3GE8LqcGKqR/3vPf1rfqKO/v28+R?=
 =?us-ascii?Q?zxQg60q+tvn8A6pAz6YFvjOwCmnoTLQa2pM88yaG1AejpfRs+ucjT6oq5/2A?=
 =?us-ascii?Q?8LQ4O+CvDW2VCE+gqgEJYCSmuY9dNKDoAysrdom6IGV+HxI/PHQtHly+SVXn?=
 =?us-ascii?Q?aIurmNpFYeFp7KopdCGk/KA62DWeP7n2h6DPuPwosSOQcBIPnRtgJ90KMsno?=
 =?us-ascii?Q?KSrjju0kacFhGRPf1e5pMq0TnTOfGlsIUy5P4aAyzGLkz+yPH81A6e1d2QkY?=
 =?us-ascii?Q?y2x9+3PbYomY22RZskXFxa+HdEApxmMqfH5RmD+w9VSzr7W3uE8nndyP79Mw?=
 =?us-ascii?Q?IINoGwDRcUlJhvolgM0C6bvs31yrzj37oGjLKRn9poH4CT84R/0FgkL50hAF?=
 =?us-ascii?Q?5R2buzQjisYCUT+h7GWad00mTMlu+B1kMjpDf3UnYjXym8TqIRy2aPO9DW1k?=
 =?us-ascii?Q?U94pJKaGbRgoFnS76K4sBqT4Ky0ZkT25y170OHsyW07kEWryZ31N03EJflyM?=
 =?us-ascii?Q?mfGY2sPmZiXc9UkYumOHhkVNfu2ixlDXbwVvHkRlkHQ5QPjB8ZgFZZAkhoxZ?=
 =?us-ascii?Q?ZoMKDGHN1eNrrTTKB2xz/5MmwkpORRIOaCoOmT0sM9OZ4ZoTYEefFv+0mPhG?=
 =?us-ascii?Q?mIYV9uCiZhEnSrF9w315rWy86+3g5dKGOK+O+XUeLig5R2T+IHyGn4SrvLkv?=
 =?us-ascii?Q?AX1U7pgVuneyyej7Kzl382wlKi4Qp1LTX6H9jgxTTDQjVZDyCqjnRHtvQyaC?=
 =?us-ascii?Q?CzErOBIh0ozAhUVMYooXi1WA1EAmUiccw1s5TH9YKhpX9O5NQCLLL/i0m5of?=
 =?us-ascii?Q?RFiWUHZmCKEGZEgg7/4a0+WsKNN+s4T1LKMLCNrcz99ZR+Qnk/YB9s5yPHHJ?=
 =?us-ascii?Q?COZYE7VMY7sMXowsDLjUtm6knX/UHmNFDP25qZhlXeQbln+0rSZiwsUQHFXw?=
 =?us-ascii?Q?Brl47spH6x0bVjzVRJUcDSNcg5G2ut6/O1rJYnRWMUZ4y/NtXEF6C+S6qVrV?=
 =?us-ascii?Q?tBM1zIzdTACuFEBoCYuYPs6mpw6GBKnYMqTWouHq4xI5Rfg8DuAm+6i2cE8x?=
 =?us-ascii?Q?fzYC/LaZWD6XuOH94FwOT/n/FbIobyiDfd0jBNs/e6ng7xVO6f9mCqigLebx?=
 =?us-ascii?Q?4k0RqtKu4GY3n4RC4Pk8wUYClbztVTFc2NucGITfkwzxhaHUIDMJhfmpBzF3?=
 =?us-ascii?Q?C7SLvb12BHT7hfGNJHAnsDETgovS5247FLUyQFxvJeZXDvQIGyAs1g00YVQx?=
 =?us-ascii?Q?zWfIF7hw5IB7/TTrKMBpWx6Yze3dj/u5+dVhhMOdbTpubX+NZx5lyxEVfhVB?=
 =?us-ascii?Q?67wWgc7K2O0wRnmvm3pp7YSOBTQwa8c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9827830-248c-4dec-fa4c-08da229ba3c6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:01:49.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wvp2qpjpeXjapGeUTjcjOLNdL1pV0MgxuD1ka4JhTYVRmv0L4dHbv20ouUo3TJdPJ/CMunmaJOOAU/4c1C8QfbGr0C/dQxqZY4M/OLS/YGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3569
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200042
X-Proofpoint-GUID: -wR-Lm-Aa0i24fnPlbFbhE7a3pocP7-k
X-Proofpoint-ORIG-GUID: -wR-Lm-Aa0i24fnPlbFbhE7a3pocP7-k
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keerthy,

url:    https://github.com/intel-lab-lkp/linux/commits/Keerthy/thermal-k3_j72xx_bandgap-Add-the-bandgap-driver-support/20220412-193526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-randconfig-m031-20220411 (https://download.01.org/0day-ci/archive/20220415/202204151117.NLsoANXl-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/thermal/k3_j72xx_bandgap.c:570 k3_j72xx_bandgap_probe() warn: passing devm_ allocated variable to kfree. 'ref_table'

vim +/ref_table +570 drivers/thermal/k3_j72xx_bandgap.c

de47884b9759d9 Keerthy 2022-04-12  411  static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
de47884b9759d9 Keerthy 2022-04-12  412  {
de47884b9759d9 Keerthy 2022-04-12  413  	int ret = 0, cnt, val, id, table_size = 1024;
de47884b9759d9 Keerthy 2022-04-12  414  	int high_max, low_temp;
de47884b9759d9 Keerthy 2022-04-12  415  	struct resource *res;
de47884b9759d9 Keerthy 2022-04-12  416  	struct device *dev = &pdev->dev;
de47884b9759d9 Keerthy 2022-04-12  417  	struct k3_j72xx_bandgap *bgp;
de47884b9759d9 Keerthy 2022-04-12  418  	struct k3_thermal_data *data;
de47884b9759d9 Keerthy 2022-04-12  419  	int workaround_needed = 0;
de47884b9759d9 Keerthy 2022-04-12  420  	const struct k3_j72xx_bandgap_data *driver_data;
de47884b9759d9 Keerthy 2022-04-12  421  	struct thermal_zone_device *ti_thermal;
de47884b9759d9 Keerthy 2022-04-12  422  	int *ref_table;
de47884b9759d9 Keerthy 2022-04-12  423  	struct err_values err_vals;
de47884b9759d9 Keerthy 2022-04-12  424  
de47884b9759d9 Keerthy 2022-04-12  425  	s64 golden_factors[] = {
de47884b9759d9 Keerthy 2022-04-12  426  		-490019999999999936,
de47884b9759d9 Keerthy 2022-04-12  427  		3251200000000000,
de47884b9759d9 Keerthy 2022-04-12  428  		-1705800000000,
de47884b9759d9 Keerthy 2022-04-12  429  		603730000,
de47884b9759d9 Keerthy 2022-04-12  430  		-92627,
de47884b9759d9 Keerthy 2022-04-12  431  	};
de47884b9759d9 Keerthy 2022-04-12  432  
de47884b9759d9 Keerthy 2022-04-12  433  	s64 pvt_wa_factors[] = {
de47884b9759d9 Keerthy 2022-04-12  434  		-415230000000000000,
de47884b9759d9 Keerthy 2022-04-12  435  		3126600000000000,
de47884b9759d9 Keerthy 2022-04-12  436  		-1157800000000,
de47884b9759d9 Keerthy 2022-04-12  437  	};
de47884b9759d9 Keerthy 2022-04-12  438  
de47884b9759d9 Keerthy 2022-04-12  439  	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
de47884b9759d9 Keerthy 2022-04-12  440  	if (!bgp)
de47884b9759d9 Keerthy 2022-04-12  441  		return -ENOMEM;
de47884b9759d9 Keerthy 2022-04-12  442  
de47884b9759d9 Keerthy 2022-04-12  443  	bgp->dev = dev;
de47884b9759d9 Keerthy 2022-04-12  444  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
de47884b9759d9 Keerthy 2022-04-12  445  	bgp->base = devm_ioremap_resource(dev, res);
de47884b9759d9 Keerthy 2022-04-12  446  	if (IS_ERR(bgp->base))
de47884b9759d9 Keerthy 2022-04-12  447  		return PTR_ERR(bgp->base);
de47884b9759d9 Keerthy 2022-04-12  448  
de47884b9759d9 Keerthy 2022-04-12  449  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
de47884b9759d9 Keerthy 2022-04-12  450  	bgp->cfg2_base = devm_ioremap_resource(dev, res);
de47884b9759d9 Keerthy 2022-04-12  451  	if (IS_ERR(bgp->cfg2_base))
de47884b9759d9 Keerthy 2022-04-12  452  		return PTR_ERR(bgp->cfg2_base);
de47884b9759d9 Keerthy 2022-04-12  453  
de47884b9759d9 Keerthy 2022-04-12  454  	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
de47884b9759d9 Keerthy 2022-04-12  455  	bgp->fuse_base = devm_ioremap_resource(dev, res);
de47884b9759d9 Keerthy 2022-04-12  456  	if (IS_ERR(bgp->fuse_base))
de47884b9759d9 Keerthy 2022-04-12  457  		return PTR_ERR(bgp->fuse_base);
de47884b9759d9 Keerthy 2022-04-12  458  
de47884b9759d9 Keerthy 2022-04-12  459  	driver_data = of_device_get_match_data(dev);
de47884b9759d9 Keerthy 2022-04-12  460  	if (driver_data)
de47884b9759d9 Keerthy 2022-04-12  461  		workaround_needed = driver_data->has_errata_i2128;
de47884b9759d9 Keerthy 2022-04-12  462  
de47884b9759d9 Keerthy 2022-04-12  463  	pm_runtime_enable(dev);
de47884b9759d9 Keerthy 2022-04-12  464  	ret = pm_runtime_get_sync(dev);
de47884b9759d9 Keerthy 2022-04-12  465  	if (ret < 0) {
de47884b9759d9 Keerthy 2022-04-12  466  		pm_runtime_put_noidle(dev);
de47884b9759d9 Keerthy 2022-04-12  467  		pm_runtime_disable(dev);
de47884b9759d9 Keerthy 2022-04-12  468  		return ret;
de47884b9759d9 Keerthy 2022-04-12  469  	}
de47884b9759d9 Keerthy 2022-04-12  470  
de47884b9759d9 Keerthy 2022-04-12  471  	/* Get the sensor count in the VTM */
de47884b9759d9 Keerthy 2022-04-12  472  	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
de47884b9759d9 Keerthy 2022-04-12  473  	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
de47884b9759d9 Keerthy 2022-04-12  474  	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
de47884b9759d9 Keerthy 2022-04-12  475  
de47884b9759d9 Keerthy 2022-04-12  476  	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
de47884b9759d9 Keerthy 2022-04-12  477  	if (!data) {
de47884b9759d9 Keerthy 2022-04-12  478  		ret = -ENOMEM;
de47884b9759d9 Keerthy 2022-04-12  479  		goto err_alloc;
de47884b9759d9 Keerthy 2022-04-12  480  	}
de47884b9759d9 Keerthy 2022-04-12  481  
de47884b9759d9 Keerthy 2022-04-12  482  	ref_table = devm_kzalloc(bgp->dev, sizeof(*ref_table) * table_size,
de47884b9759d9 Keerthy 2022-04-12  483  				 GFP_KERNEL);

This should be allocated with regular kzalloc() because it's freed at
the end of the function.  It doesn't stay for the life of the device.

de47884b9759d9 Keerthy 2022-04-12  484  	if (!ref_table) {
de47884b9759d9 Keerthy 2022-04-12  485  		ret = -ENOMEM;
de47884b9759d9 Keerthy 2022-04-12  486  		goto err_alloc;
de47884b9759d9 Keerthy 2022-04-12  487  	}
de47884b9759d9 Keerthy 2022-04-12  488  
de47884b9759d9 Keerthy 2022-04-12  489  	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * table_size,
de47884b9759d9 Keerthy 2022-04-12  490  				     GFP_KERNEL);
de47884b9759d9 Keerthy 2022-04-12  491  	if (!derived_table) {
de47884b9759d9 Keerthy 2022-04-12  492  		ret = -ENOMEM;
de47884b9759d9 Keerthy 2022-04-12  493  		goto err_alloc;
de47884b9759d9 Keerthy 2022-04-12  494  	}
de47884b9759d9 Keerthy 2022-04-12  495  
de47884b9759d9 Keerthy 2022-04-12  496  	/* Workaround not needed if bit30/bit31 is set even for J721e */
de47884b9759d9 Keerthy 2022-04-12  497  	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
de47884b9759d9 Keerthy 2022-04-12  498  		workaround_needed = false;
de47884b9759d9 Keerthy 2022-04-12  499  
de47884b9759d9 Keerthy 2022-04-12  500  	dev_dbg(bgp->dev, "Work around %sneeded\n",
de47884b9759d9 Keerthy 2022-04-12  501  		workaround_needed ? "not " : "");
de47884b9759d9 Keerthy 2022-04-12  502  
de47884b9759d9 Keerthy 2022-04-12  503  	if (!workaround_needed)
de47884b9759d9 Keerthy 2022-04-12  504  		init_table(5, ref_table, golden_factors);
de47884b9759d9 Keerthy 2022-04-12  505  	else
de47884b9759d9 Keerthy 2022-04-12  506  		init_table(3, ref_table, pvt_wa_factors);
de47884b9759d9 Keerthy 2022-04-12  507  
de47884b9759d9 Keerthy 2022-04-12  508  	/* Register the thermal sensors */
de47884b9759d9 Keerthy 2022-04-12  509  	for (id = 0; id < cnt; id++) {
de47884b9759d9 Keerthy 2022-04-12  510  		data[id].bgp = bgp;
de47884b9759d9 Keerthy 2022-04-12  511  		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
de47884b9759d9 Keerthy 2022-04-12  512  		data[id].stat_offset = data[id].ctrl_offset +
de47884b9759d9 Keerthy 2022-04-12  513  					K3_VTM_TMPSENS_STAT_OFFSET;
de47884b9759d9 Keerthy 2022-04-12  514  
de47884b9759d9 Keerthy 2022-04-12  515  		if (workaround_needed) {
de47884b9759d9 Keerthy 2022-04-12  516  			/* ref adc values for -40C, 30C & 125C respectively */
de47884b9759d9 Keerthy 2022-04-12  517  			err_vals.refs[0] = MINUS40CREF;
de47884b9759d9 Keerthy 2022-04-12  518  			err_vals.refs[1] = PLUS30CREF;
de47884b9759d9 Keerthy 2022-04-12  519  			err_vals.refs[2] = PLUS125CREF;
de47884b9759d9 Keerthy 2022-04-12  520  			err_vals.refs[3] = PLUS150CREF;
de47884b9759d9 Keerthy 2022-04-12  521  			get_efuse_values(id, &data[id], err_vals.errs, bgp);
de47884b9759d9 Keerthy 2022-04-12  522  		}
de47884b9759d9 Keerthy 2022-04-12  523  
de47884b9759d9 Keerthy 2022-04-12  524  		if (id == 0 && workaround_needed)
de47884b9759d9 Keerthy 2022-04-12  525  			prep_lookup_table(&err_vals, ref_table);
de47884b9759d9 Keerthy 2022-04-12  526  		else if (id == 0 && !workaround_needed)
de47884b9759d9 Keerthy 2022-04-12  527  			memcpy(derived_table, ref_table, table_size * 4);
de47884b9759d9 Keerthy 2022-04-12  528  
de47884b9759d9 Keerthy 2022-04-12  529  		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
de47884b9759d9 Keerthy 2022-04-12  530  		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
de47884b9759d9 Keerthy 2022-04-12  531  			K3_VTM_TMPSENS_CTRL_SOC |
de47884b9759d9 Keerthy 2022-04-12  532  			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
de47884b9759d9 Keerthy 2022-04-12  533  		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
de47884b9759d9 Keerthy 2022-04-12  534  
de47884b9759d9 Keerthy 2022-04-12  535  		bgp->ts_data[id] = &data[id];
de47884b9759d9 Keerthy 2022-04-12  536  		ti_thermal =
de47884b9759d9 Keerthy 2022-04-12  537  		devm_thermal_zone_of_sensor_register(bgp->dev, id,
de47884b9759d9 Keerthy 2022-04-12  538  						     &data[id],
de47884b9759d9 Keerthy 2022-04-12  539  						     &k3_of_thermal_ops);
de47884b9759d9 Keerthy 2022-04-12  540  		if (IS_ERR(ti_thermal)) {
de47884b9759d9 Keerthy 2022-04-12  541  			dev_err(bgp->dev, "thermal zone device is NULL\n");
de47884b9759d9 Keerthy 2022-04-12  542  			ret = PTR_ERR(ti_thermal);
de47884b9759d9 Keerthy 2022-04-12  543  			goto err_alloc;
de47884b9759d9 Keerthy 2022-04-12  544  		}
de47884b9759d9 Keerthy 2022-04-12  545  	}
de47884b9759d9 Keerthy 2022-04-12  546  
de47884b9759d9 Keerthy 2022-04-12  547  	/*
de47884b9759d9 Keerthy 2022-04-12  548  	 * Program TSHUT thresholds
de47884b9759d9 Keerthy 2022-04-12  549  	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
de47884b9759d9 Keerthy 2022-04-12  550  	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
de47884b9759d9 Keerthy 2022-04-12  551  	 *         This is already taken care as per of init
de47884b9759d9 Keerthy 2022-04-12  552  	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
de47884b9759d9 Keerthy 2022-04-12  553  	 */
de47884b9759d9 Keerthy 2022-04-12  554  	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
de47884b9759d9 Keerthy 2022-04-12  555  	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
de47884b9759d9 Keerthy 2022-04-12  556  
de47884b9759d9 Keerthy 2022-04-12  557  	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
de47884b9759d9 Keerthy 2022-04-12  558  	       K3_VTM_MISC_CTRL2_OFFSET);
de47884b9759d9 Keerthy 2022-04-12  559  	mdelay(100);
de47884b9759d9 Keerthy 2022-04-12  560  	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
de47884b9759d9 Keerthy 2022-04-12  561  	       K3_VTM_MISC_CTRL_OFFSET);
de47884b9759d9 Keerthy 2022-04-12  562  
de47884b9759d9 Keerthy 2022-04-12  563  	platform_set_drvdata(pdev, bgp);
de47884b9759d9 Keerthy 2022-04-12  564  
de47884b9759d9 Keerthy 2022-04-12  565  	print_look_up_table(dev, ref_table);
de47884b9759d9 Keerthy 2022-04-12  566  	/*
de47884b9759d9 Keerthy 2022-04-12  567  	 * Now that the derived_table has the appropriate look up values
de47884b9759d9 Keerthy 2022-04-12  568  	 * Free up the ref_table
de47884b9759d9 Keerthy 2022-04-12  569  	 */
de47884b9759d9 Keerthy 2022-04-12 @570  	kfree(ref_table);

The first free of a double free.  Get rid of the devm_ and add kfrees
on the error path.

de47884b9759d9 Keerthy 2022-04-12  571  
de47884b9759d9 Keerthy 2022-04-12  572  	return 0;
de47884b9759d9 Keerthy 2022-04-12  573  
de47884b9759d9 Keerthy 2022-04-12  574  err_alloc:
de47884b9759d9 Keerthy 2022-04-12  575  	pm_runtime_put_sync(&pdev->dev);
de47884b9759d9 Keerthy 2022-04-12  576  	pm_runtime_disable(&pdev->dev);
de47884b9759d9 Keerthy 2022-04-12  577  
de47884b9759d9 Keerthy 2022-04-12  578  	return ret;
de47884b9759d9 Keerthy 2022-04-12  579  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

