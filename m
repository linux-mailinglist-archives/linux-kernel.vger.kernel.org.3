Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4845025D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiDOGtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350745AbiDOGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:49:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BACB2454
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:46:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F3BOIv031973;
        Fri, 15 Apr 2022 06:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mzV+Y1sirlfOzhuEJd8g7i2JQD48DeVYotuASfEoqkU=;
 b=rhbGxnWG2i5/ou+CR7QUKEx2hMZgRYlTHTF008iJlAhA34XSQf21c22bK5fKLKZAwStL
 flK81Rm7fCOtLV3opBZ62FmXLH1hcAZ3/BEP5m23AXTNraLNQSCLSUNcwGMKVPhf4UQt
 SWFP+X4hlsy9JeH/oGL3voJwZtCLznM0xYURe0mwltPEH7Cvj6bAxjqsXTEvHNAq9Tu1
 sBdAZailnT7DIo8gtl5dulp5sH2OlLQszr5RdRWB/rQ+vdHVq3LA61ftJP7dr9//I1AD
 9Ea+f88TMrRU+rY4Q6xPkOHGW34nt1Ovf1aMJOswfhtvxDQnWCCx5h02BEhdAeymPM1M Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jde5ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:46:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F6WVHo032751;
        Fri, 15 Apr 2022 06:46:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15p84u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzRC+3Lnve8nfitLI1Gi+zq+2VSqa/zc5t/ShCT1K7SKWd/3VEh2Bv7jw4YRsRVEWLdt1cQobegiz22oybIvBn1LT9hK8v+ONecc5pkKhMWrOU/q78EYia/ZapIxMTx5VYm87pNRC3QRaqvubtqKo5oPVlzA2Fh6vnZpSE2Llc8ukjplsfXRdha8+A8Gh5t/xuo1+QJs3bY5RPhT6kU0dsKM9F9UT70Imq6zthd5Uvr08FpyYy63PfeHP0iGcqZvhySwEkehqPv3tFR1bbml3KOqugSqSr2BhZN1kePyKXA2mW8ws6VT67+Wt1t/SrRujZcceXLJpWtRO/n1OAcvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzV+Y1sirlfOzhuEJd8g7i2JQD48DeVYotuASfEoqkU=;
 b=g3U9yhEwWDGDo/4/YVG8uCcakoWYcro36180orUMXNRUMdxr8PZGoDJ1fYjplpfJ6rpLN1jRCiuT0Cg0AK1bTKHTJlGwxU6zpH1AAiGuQv7wKnELTcqd/ExVHkC22QxBizYpvdpNl+UjYUrDRCCIBzg71MXG/7C+JGvHYqGVSiSg7Zx4N2r1rK9PKg0TB4faIZ6/hqMDivWgs3PBKAET3BycoxpK3DT04sXCUgKXZrBLBB/jeFQ8OCyuJIXCqQx0xziLOhDqPuKtnNp/FOPBiUJ7yRbkDlOz3llG+co1CZSRUH+d69TFESesBhfOdn9cTx5hz64FEC3V9MCiUsZijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzV+Y1sirlfOzhuEJd8g7i2JQD48DeVYotuASfEoqkU=;
 b=uS1eeuTayMC0L5sVJsBID35Hx1RaxtW5qep1Sd/aiocnFcrP48fBm0jSlZkGSZLMiXMzVoaxOjoD0topyuCgXROrOtEzL95JIN4NfcdT1yqFZbk2flQZRi5Ib0o4g68oUPBnZIOoAI2LwN6xpdEhbGb0DyIyGyRWSq0GpjKUbB4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2500.namprd10.prod.outlook.com
 (2603:10b6:406:cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 06:46:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 06:46:11 +0000
Date:   Fri, 15 Apr 2022 09:45:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v2 14/16] drivers/opp/core.c:1215
 dev_pm_opp_set_rate() error: uninitialized symbol 'ret'.
Message-ID: <202204150900.qnJMf3Gu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2596fa-b859-4b12-6da7-08da1eaba0e3
X-MS-TrafficTypeDiagnostic: BN7PR10MB2500:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB25008E625CD64DF6AA5565958EEE9@BN7PR10MB2500.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cId81uXPwsjjalUpM1siptEt+NPVVSR40mYzjaWiv3NkgYbbSTC1H/1rjj644lrle9G+PlT0YtPD+SiPmWjrPqFBs9/HGSzqFRyDGynorxqay/jbOzp4HpSqUoNGOdhnUle0c10eii8KNn6dp22ROKLN6IIL7OoXQLcTUTMJSvMaKUrm0o11ZXiMoY3NQVoWE48VQM42DE8a7N5eUwsmSk/sdoikjCHIm7tGPdJQkDBApeqywUztziOAEnI4CI8tp394gjDDfMIfvzNR1hfwIb9xd8qJZUBD2BkRO+sVy0Kpkz3+hFJIOwxN3U4nPdLv5MkH/WQNBZ164XzhOnkfjXGvDLLEJkAr8vCOew0AXYFyJnTwsfc48JoxfFySAWl9NHX/mk5XFj5/b1ost33gIqQko1RGKk9mq+3F4X7/fcx76a2UkX4cfUMoTcRaQ0OSlWRX4KEIFs89+++ms86zcPZjk1zmfHaIRy5C9oCQ167fO3ZPVvbBlE19+fh9wuG3wQyAwwHRq5VF789Fpnlh8/VpWQ3lwtvjhsmMXZTbUK05Wt3o3h+L86NsIpmNQrtp3f2IApS4vkgunsC7EnSzykwkGpBQpv/xR6Ndc3mgJAYp9DXUODKBrLDI9UL4YqmqlDF+JzOdPL7nku7Qmm5f9BzCFL82zgWRalUQuAdgZvxVZAjRl6OBqCQYl1CEs0Z9Q2PLTTqnUoZOIN5nWTYqN6KVc/4Y3Rmz5VwG/GzYPPopqlqCDNvyqNLpIHVQGxucKt31Kq6egRRyOQHsUru/nIwcG1mRed8GEwFvmcnB+WQQkAz3laUTevnKC1kLmO+jcsHpEJiIdvXRKvHXmfqO2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(66476007)(186003)(6916009)(86362001)(36756003)(5660300002)(6486002)(966005)(2906002)(8676002)(9686003)(6512007)(4326008)(1076003)(26005)(316002)(8936002)(508600001)(6506007)(66556008)(52116002)(66946007)(38100700002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aUHavOzFX7lMpvEPotixyrLvvLssiQMFpGb9/V8qjlWWOJGQXxa+Ou3H3t4?=
 =?us-ascii?Q?mdEeAEpchIHbjn2UQYLTqRMrXJB8CnAOmXf/zMBXT5U9ugqB+nrGQsvN8YWQ?=
 =?us-ascii?Q?nih2zxO9d2yTzcQ/M/U/1dzHmBH1hr8ycDeUD/RTRTRC+uGgtxa8UIA/eLa+?=
 =?us-ascii?Q?wSE7gzzWqz4ovp1yXe8PLQKSP/JHtcVCMA8ljLqIAnzlmJzhx2k/5aMNZf/R?=
 =?us-ascii?Q?XIJHmM96umoDmA86ikixyYxaG3GLZQmkiBWRX/7PTSK9BWp5MGpRLFV2pKWx?=
 =?us-ascii?Q?bunZLjWQeIe99+ME/obeHVIj1oMjdUX7MC4NJFCM+tYI0Zxe0/Mdsq5zwBWB?=
 =?us-ascii?Q?i8eXtbUW0yesJhW/RR60JJjOMxQCvai3XRME5fJYTW3NzBAIZUtgSh/4oaij?=
 =?us-ascii?Q?wsjZhS72opooBIVzijQSuCcMnHxd551BWI5JmIQ3RZ9Uek7E7v9IRWSopWsk?=
 =?us-ascii?Q?J+BIZ3/q5fgSTUhYps+LGGGBib4BaE3XkZx2rtBXHQXzMLYSPz3Il6ElMOC7?=
 =?us-ascii?Q?MjJmyVsOdaJN6f+K7kBqUCXRqQN7Swka9AyLcyfy6HBCbLw9MEsYAacRxp4X?=
 =?us-ascii?Q?Ca3tvso9AOTKNbgi9Lqk/FTDoi/CDrgnKkZ7Fl9EYnBUTeVfEFtGlpScd74W?=
 =?us-ascii?Q?tL+3Ucazj6HUZxSjfABjWF+7CvgfLjQgZ7kC00i9JVlWHjwgr4EC1diFP00A?=
 =?us-ascii?Q?qRvVqYn9veIbcns5OjoxJFD9PabsjbqSyd7XHTwQWM7B8udTO5reaGuCEJZT?=
 =?us-ascii?Q?spfdGE+ZetO6D125lhuyH9sl2A0pJv1Z8DtslBobmFqKw0iR9ADYmclPtHMP?=
 =?us-ascii?Q?PTBi0FOdmtpaEMt6vDk0dIIWXklH+8iII8Y6+bSiSj20xM9Plsu/IWhXEb1t?=
 =?us-ascii?Q?jkgsEaS0zhMOwCt45OnYt8KFm/EFKfUjbAAuEv5pa0pLd9QyF72PB+3TyFPV?=
 =?us-ascii?Q?L5f2vZ+3Hr+sBwRIF0W+R+G/Aib7q3d89NjsWnieCDQiGAOjTrYBcxF0HegS?=
 =?us-ascii?Q?qw3PPjvJcVyhAfxEdH/L/po7BIHux3LL5Q42xDLTeutG+qBG/i7D5qMezq2Z?=
 =?us-ascii?Q?77sHcWjWe5NrVrqASfprJ9zGz8g2H4xOuZhmrPRFdoxm0HGb4G8/nPkzKonL?=
 =?us-ascii?Q?8Oo6PtbPOaS4LDzPHAlSY2MYW56PDVIIrNP/nBLGq8POsPSWfe0D0jMoO4Wq?=
 =?us-ascii?Q?x2cDwZmQrJAWUmyrZU7Fu8HHk4UgDnzO/6v8czVXW6S3TxXTzQa95FkwkKdw?=
 =?us-ascii?Q?rbGSEIS0StasSwnD2kZkJNHX1m0cbm4VRhDyo74Cd1gN+MgW+ehAKhRL1Xmc?=
 =?us-ascii?Q?YtQd9UVxl9Lyvz/3cPOdhWllYwhTT/5WgNEmVqCtEAVt/Azm7WuWnKD4qyIF?=
 =?us-ascii?Q?ZWB3ei6h4Xg+ekMwDHyov2WISP4BSkjmSv1BnMqMZfOYJm39S0TuIanP1Uga?=
 =?us-ascii?Q?pxX2WocL85q66Nc3bDdnn/KmdQ4/H8r3nVFeyXVp981yDkRXJECLbSaX4r3U?=
 =?us-ascii?Q?8tVLpcd/5EbOKTGqMc6g5KN+GPqhYZwgdR7uvKPgl21rTCYERHrVx+IgLE0x?=
 =?us-ascii?Q?/Rsh7fUBmnQTaDcOFhxktAU4wIBXSD97Gd4KNuNoqPUfFz2j/jdhPpQb/9bF?=
 =?us-ascii?Q?LUf3aUU4Vg8nrM7ILatLvJSmilcYSY830r9CUNlzPEtI410EfDGsU7NmfJBy?=
 =?us-ascii?Q?GprE/89KKm4yQrIU+TkeH2XcGthnCJeVlnBv0Axf7GAzgk3084KhhAUPju2L?=
 =?us-ascii?Q?SVtnbYcaBaTzVCrRBaQky3yQOIq2olk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2596fa-b859-4b12-6da7-08da1eaba0e3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:46:11.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otg2hZB+bBdeQfUiAFvU0nuz2FPoOjPT4NUZJXJcxs1825EWEg/C04D4leE3Zz6Am9eHtz7yqSe7GOQ6yNt3ZVmKOSG7xyLjSSuZFNxTSl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150039
X-Proofpoint-ORIG-GUID: LEBVxpN6c7qH7m-rN5vdP7QGbnpZsWmm
X-Proofpoint-GUID: LEBVxpN6c7qH7m-rN5vdP7QGbnpZsWmm
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v2
head:   bf7d30c9329c87f06dff42b303a9bcfd2e1f54eb
commit: be46c855d54f763bfb95424e5204fe7496e2ee5f [14/16] PM: opp: allow control of multiple clocks
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220415/202204150900.qnJMf3Gu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/opp/core.c:1215 dev_pm_opp_set_rate() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/opp/core.c:1197 dev_pm_opp_set_rate() warn: passing a valid pointer to 'PTR_ERR'
drivers/opp/core.c:2813 _opp_set_availability() warn: passing a valid pointer to 'PTR_ERR'
drivers/opp/core.c:2884 dev_pm_opp_adjust_voltage() warn: passing a valid pointer to 'PTR_ERR'

vim +/ret +1215 drivers/opp/core.c

386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1155  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1156  {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1157  	struct opp_table *opp_table;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1158  	unsigned long freq = 0, temp_freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1159  	struct dev_pm_opp *opp = NULL;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1160  	int ret;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1161  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1162  	opp_table = _find_opp_table(dev);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1163  	if (IS_ERR(opp_table)) {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1164  		dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1165  		return PTR_ERR(opp_table);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1166  	}
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1167  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1168  	if (target_freq) {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1169  		/*
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1170  		 * For IO devices which require an OPP on some platforms/SoCs
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1171  		 * while just needing to scale the clock on some others
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1172  		 * we look for empty OPP tables with just a clock handle and
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1173  		 * scale only the clk. This makes dev_pm_opp_set_rate()
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1174  		 * equivalent to a clk_set_rate()
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1175  		 */
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1176  		if (!_get_opp_count(opp_table)) {
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1177  			if (opp_table->clks)
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1178  				ret = _generic_set_opp_clk_only(dev,
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1179  								opp_table->clks[0],
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1180  								target_freq);

"ret" not initialized on else path.

386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1181  			goto put_opp_table;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1182  		}
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1183  
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1184  		if (opp_table->clks)
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1185  			freq = clk_round_rate(opp_table->clks[0], target_freq);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1186  		if ((long)freq <= 0)
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1187  			freq = target_freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1188  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1189  		/*
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1190  		 * The clock driver may support finer resolution of the
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1191  		 * frequencies than the OPP table, don't update the frequency we
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1192  		 * pass to clk_set_rate() here.
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1193  		 */
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1194  		temp_freq = freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1195  		opp = _find_freq_ceil(opp_table, &temp_freq);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1196  		if (IS_ERR(opp)) {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1197  			ret = PTR_ERR(opp);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1198  			dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1199  				__func__, freq, ret);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1200  			goto put_opp_table;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1201  		}
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1202  		/*
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1203  		 * opp->rates are used for scaling clocks, so be sure accurate
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1204  		 * 'freq' is used, instead what was defined via e.g. Devicetree.
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1205  		 */
be46c855d54f76 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-05  1206  		opp->rates[0] = freq;
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1207  	}
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1208  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1209  	ret = _set_opp(dev, opp_table, opp, freq);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1210  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1211  	if (target_freq)
8a31d9d94297b1 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1212  		dev_pm_opp_put(opp);
052c6f19141dd1 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1213  put_opp_table:
5b650b388844f2 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1214  	dev_pm_opp_put_opp_table(opp_table);
052c6f19141dd1 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23 @1215  	return ret;
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1216  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

