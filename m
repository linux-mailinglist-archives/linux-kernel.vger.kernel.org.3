Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404055283F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiEPMNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiEPMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:13:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A327B0C;
        Mon, 16 May 2022 05:13:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8amtr014196;
        Mon, 16 May 2022 12:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=6zJUKmITLPSWHQBbRpNBCSzWQlaOIkDWjE3o8xb5RWw=;
 b=a9mgBUrDIzfOgDDQHYgXrR5Z17aseKTy32zw5DNgEpm2m5QTB+caKztJZV7088+s4w+y
 o1Ej9OA6dhJAWgmShcqsLbx44kCeMMD+tCBCJcJmhsHLNoQHK9QROhub73yR5ZkWiZPA
 /ycziVAlFCK4PP1bNSlyFdnWKOf/+FtyWlDbcDTaTXI6C5z2sijACoxXJXnkEbjsm8un
 Tr+3+T2VXIob+VcsoSmsazeZveY4XE76bjtEDZiQ+/j2JOQe3RsRt0NIdpoNKR06U3bI
 9ctnCT+nizQZ2PxTzhGw1g7Tsek6Rc9GeB2Ej1iqznw5G2PKacK8oAd8RRnF87xZKN4s Vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371u4j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 12:12:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GCBRan017359;
        Mon, 16 May 2022 12:12:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v1k078-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 12:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9Y1yOgbT/zevie9ZpswUvLx0ToN4pmblMykJzvxTV+uYo/5mDKLefiuWCZPMF4M5iKV4hBBQYbIblcNv0D4wBImU8Xk+taS12XBQuRgBMo7XA1Foa4doA6LRD2olv7jkEHvmCjA8OHccEKyB79sogNS5L4gGPXNNsrSdUCaag8I5+4nIoMFa3QXjjVc6FFPbsUsDtMD2Gzynf6GhSofxnOS9ibYao/v0+8fLWyfybMPO4NOuNF7YnvfbzYgaTvMR23EViHrNad9m6MTzoBf8kSgEgejSzLL3i4C7DbvXyCzV6rmKSIWovpMMNgGPqCNIEYz0x1OeH1Y6GJ8g9rSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zJUKmITLPSWHQBbRpNBCSzWQlaOIkDWjE3o8xb5RWw=;
 b=ahe4Y8rnaZ15v3og2QKb2C/W9K+/tt+C9tXPP76WkAA/ykGC/EZPYvkSmJFWjxpTH4y98gk5UBRlTkG4cXg/l1yNiuR5yLaBZASDX8SkJVD+S3mm6A9V6sbV8/HiYudP/XYACVDzY6ZbbJSiN4s3A61ZAo4GT3JPXlQkJiqfgm9lxBlCrieZknNi3liE4l6p7vGtneIrrcJF/uQS9SZglD7TKBP46f0IcGHDjZaIKOCMhDbfq1Ac18QR5xotwdn7um6J8OinR3v3D/KbidQvrSQvz+zTbGV4HDTmzivu5ulo09Gm/oW9smL0ZjwR+6/X6stC/y9OtmkoPLbht3vtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zJUKmITLPSWHQBbRpNBCSzWQlaOIkDWjE3o8xb5RWw=;
 b=egm2ugbdgOzIrAzljjVzhM7sZNm1bTRoBnq5sq23ZApV3SLjxhRzkd+4i5RdsX0UXqcHrnE+HtxPWYKoASxtGMQ7voLRC25RO2akUU0LHCPgKk9lcnErCHr7e2z1GZC2TTqSoU/blJtfAH0y4yW0HyJaNvyP/0+Pcn7Kv/gQUU4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3596.namprd10.prod.outlook.com
 (2603:10b6:5:150::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 12:12:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 12:12:34 +0000
Date:   Mon, 16 May 2022 15:12:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V12 7/9] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <202205130908.O31s3mhc-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652275113-10277-8-git-send-email-quic_c_skakit@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50be5399-5195-43fa-d7ff-08da37355bbb
X-MS-TrafficTypeDiagnostic: DM6PR10MB3596:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3596F027F22DFC66BABA67F68ECF9@DM6PR10MB3596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg2njbBlyTAEPYR5QZXr9A/cclypNt9kOpqLVfqXMNd5/4zhCSAmbqemExQDstPLQP61cJg7ujbQSR1OyKmLMNHRpRGlgYGOAtl+lUwfoNBJY9Jj5G13OgxCU5uwi1BD59QcdCzTAXMDpTpxMp7AeOtK8zoTETV/i/KNkzaqz7nvmK7SNK+LJvYFiwim5xTRtgt5pJz+Vggd8K4WOpfGvD4IEmC/u84oczb+zA0JEl96R1KUdbpS80wTQkFJf+2Iv8bhPB5gdRqtn3RQ6ZCWZ++sXb9fziY+RAIlAgl3dRt07L+WpwnldTetd6QdfHCn6fpXJtFKSmGRCOcTJSTfAz7F3F/fBjbyPTVaGZUtA5rBfod2zUNml+QnIoGPybJpBVbM7IXvgQpYh3pO/CRnCGmTJ1HtZKGDx3EF5jhlZqJGk8PbAodUF1MfKMWnSXiexGFVIVmVbr1IGcInzGxMdR09IbaLOxKeu+jkLiCWmTBl/iHEYIHhqQLEBxiNvLeJ0TMUqaBYcJDWgRezHNNxSuQ8UB4in1Ry4MJbbfvtXTH/1uElhcZ135bdd2WvY7brQtsYxXh0RLCVUvc09MYNhXYD/umdnVOZOSORdEDjdOt3czfSnrNHM8WnP7pp62Qt729ptBtp5rAfM6kSAcM7eEDT08yWyYbu7529ZAs2v/jB9UBybbjJmHITeuvnSBHs9gZldWZg1eXqT1gwcQG7SFEPWCCICe0Oa9f51tFBvQPx1yNAhUWqMQNqTkv6BQyejhatE/KwGaCGT5jgiO8C1DuuCkn6VDxcjx4Yzfyu1WSlSMptZHEwB1mUZtnzzY8CHf35B2W1vVS9zbHkSDr0pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(44832011)(9686003)(38100700002)(38350700002)(508600001)(110136005)(54906003)(6486002)(6506007)(86362001)(7416002)(966005)(36756003)(66476007)(6666004)(2906002)(316002)(5660300002)(52116002)(186003)(83380400001)(8936002)(66946007)(66556008)(1076003)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3a+Uc9+GCkIeIgS5Oh4fvEK5qClsI5Q3MEz5IUz6HjtPdD+30aYe4D0KEcy?=
 =?us-ascii?Q?ddNPoQtXfA+G2DWd4PRCP/WOHreQ5I0KNY6z9J1xgPLAyWht2Wp/gnFoXllq?=
 =?us-ascii?Q?B5UB/j15HSlMW5mK1qG3VGuSiA02imwhjd06GYekRr4gzOU725ZdJ77JfAFZ?=
 =?us-ascii?Q?JnJPQvn/X204unJy6jLd31KHfu9PZxcFs7P4cSJdRDapU00SBZpaCZb7PDSD?=
 =?us-ascii?Q?YElS4GEpLk/mQ16T0JC+TOisXXoVMxqhILH9sjtApS8f7t24M5XMsrdGi7WY?=
 =?us-ascii?Q?6nwgDGLmJ5PWZILdGnozQuazryc6n0XHGLJRMmQGC/KdF4dt1HYiMwrW79SL?=
 =?us-ascii?Q?lQNYcnbbtL3tam6eNmlht5Iaf2BB3RLIXcFtxBPtbY9V202tzL7X0P4bqPGx?=
 =?us-ascii?Q?To0Yl3RbczC2IYvm2OMYh0cvWqe0nRJ4eRZzIVfW5cZdkOMB39NBUjOQDdjL?=
 =?us-ascii?Q?ndS7fjLVR8SErlndMP/dZm3m6DKUhTj9kG9oEpfRdszx6S7ad3vhyPOQaL+3?=
 =?us-ascii?Q?FsPLLqpVJDWmfb3ho0ilvgV4MRVeoDW76rqSb3sDkD+MYMmDXIdpPDAu6al0?=
 =?us-ascii?Q?6/uWIjnRWsMcqlcPiJV5wGihuU9ltCVF/Rxcy1EWTbTEL4DKd0/6rOwBVmCP?=
 =?us-ascii?Q?TWwa0LIbaly660Tf48oWRQzkKPWG7qoBRbY0jHHfLJbQkx5Bc2aOIiR2gp1m?=
 =?us-ascii?Q?T5U46HtAevB/HGnjoon4GKeWJYrJxsskcPWCinrUW2iTzR7Qc4LMRTLk8CGK?=
 =?us-ascii?Q?99VsLOlJxvuV5nMDuP/1zMucy58HDpH2eihB7CdRQHieYOKx/ROy5//ws3+d?=
 =?us-ascii?Q?nY4YM/DIptY1rj9HFUuHyHEEou1juEhXkJYiQa0Dk87GmiZRANEbcHHWP544?=
 =?us-ascii?Q?VRfb9uU8WPWfpugvADM15Ltf4MEF2OgqT79aU/FwZhxxcuHbqEogSG3PQCQ/?=
 =?us-ascii?Q?cZXW+LqSaQOe5nXdOqOHeeJI7LLH+cdQDJ3O1aTe1X4DDzUG+trcNo79pyNF?=
 =?us-ascii?Q?5mqHfIDblSRHsa2WsT1h6SX7UdYoQMqm6i1H+1CUBFLiAerENqIWYhw/4Xt2?=
 =?us-ascii?Q?62EaMamc24T2SWQ7KSNvwxuBa/hEUMux8DrWeNoHUm5oEKiDbY0l4ItM/3Ye?=
 =?us-ascii?Q?Qh7SFlFyVZ5uB07z02x1eiYt7bxRXqIfsM3Ebl3RRyxkyMV6zuW8t8P7le93?=
 =?us-ascii?Q?6wjPlQp+H0JkduNmdEMXHijcTkntETd0HiJKQw3FmFunmfzRW8WNNVmKzSGO?=
 =?us-ascii?Q?HLMo8wduc8cqdUm3ssAHOu8KHbM8rx3wfzPMkfC1nTl02P/gcAZw/Un4Fp6m?=
 =?us-ascii?Q?ZKAFkF4GxBLfdgBt3oIzkE/livoGeMPxGh5JvNSvXe6hDanUjODe9VbEzsWT?=
 =?us-ascii?Q?nOY+4sdgwnXZnfrGSV9JqMTViFOuAWiJdPeNOBxnBXCQKAFPSrnuC343RENG?=
 =?us-ascii?Q?Ey6SMneABDaqmIoSZKY769gtBIfwYnHPrErQWSTURlRklJmWnEqXQq39NRs7?=
 =?us-ascii?Q?786ZW0KSw+ZbW9HagYzrqfI1ZOwWfHA2fF537QP9Rx2NCjkUrpk+E3CDzQoV?=
 =?us-ascii?Q?gH+diG8xTe8o2ywsaAxDSUSEU0PRgvBo3qRSDtflN5ynotz/yYugdlO7rBg+?=
 =?us-ascii?Q?l2rGY2B2a4Bb+p1LpHxblfGlibsExGCqpHy19yd14xObzpRiTM/J/8R8xpJv?=
 =?us-ascii?Q?voLnD4zq2QkyOnvhyTzLg72bo1qAsFQutV1Knh0EOclpTSExJvl5xRhSuLA2?=
 =?us-ascii?Q?e2iZH7FHDx8OAsjYFM2tq5YGmlqe1+A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50be5399-5195-43fa-d7ff-08da37355bbb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 12:12:34.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueW2/hdzO2kg1ch1Jh1YSyF9xIy5ZsJzLGcEjg1w/Ig2Bf+TSl+OxlEqx/ZQFCsA9RUy+WWI3pu+6kqDZDr2vYHUQnK3QznKm2nkuWCEM1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_08:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160069
X-Proofpoint-GUID: jUpHw1f9ReNzsFkj-QUIPDG-MaMqxD90
X-Proofpoint-ORIG-GUID: jUpHw1f9ReNzsFkj-QUIPDG-MaMqxD90
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

url:    https://github.com/intel-lab-lkp/linux/commits/Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220511-212136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: nios2-randconfig-m031-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130908.O31s3mhc-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/regulator/qcom-pm8008-regulator.c:174 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)

Old smatch warnings:
drivers/regulator/qcom-pm8008-regulator.c:175 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:176 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:178 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:180 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:180 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:182 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:186 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)
drivers/regulator/qcom-pm8008-regulator.c:196 pm8008_regulator_probe() error: buffer overflow 'reg_data' 7 <= 7 (assuming for loop doesn't break)

vim +174 drivers/regulator/qcom-pm8008-regulator.c

3337142527c77d Satya Priya 2022-05-11  122  static int pm8008_regulator_probe(struct platform_device *pdev)
3337142527c77d Satya Priya 2022-05-11  123  {
3337142527c77d Satya Priya 2022-05-11  124  	int rc, i;
3337142527c77d Satya Priya 2022-05-11  125  	u32 base;
3337142527c77d Satya Priya 2022-05-11  126  	unsigned int reg;
3337142527c77d Satya Priya 2022-05-11  127  	const char *name;
3337142527c77d Satya Priya 2022-05-11  128  	struct device *dev = &pdev->dev;
3337142527c77d Satya Priya 2022-05-11  129  	struct regulator_config reg_config = {};
3337142527c77d Satya Priya 2022-05-11  130  	struct regulator_dev    *rdev;
3337142527c77d Satya Priya 2022-05-11  131  	const struct pm8008_data *chip = dev_get_drvdata(pdev->dev.parent);
3337142527c77d Satya Priya 2022-05-11  132  	struct pm8008_regulator *pm8008_reg;
3337142527c77d Satya Priya 2022-05-11  133  
3337142527c77d Satya Priya 2022-05-11  134  	pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
3337142527c77d Satya Priya 2022-05-11  135  	if (!pm8008_reg)
3337142527c77d Satya Priya 2022-05-11  136  		return -ENOMEM;
3337142527c77d Satya Priya 2022-05-11  137  
3337142527c77d Satya Priya 2022-05-11  138  	pm8008_reg->regmap = pm8008_get_regmap(chip);
3337142527c77d Satya Priya 2022-05-11  139  	if (!pm8008_reg->regmap) {
3337142527c77d Satya Priya 2022-05-11  140  		dev_err(dev, "parent regmap is missing\n");
3337142527c77d Satya Priya 2022-05-11  141  		return -EINVAL;
3337142527c77d Satya Priya 2022-05-11  142  	}
3337142527c77d Satya Priya 2022-05-11  143  
3337142527c77d Satya Priya 2022-05-11  144  	pm8008_reg->dev = dev;
3337142527c77d Satya Priya 2022-05-11  145  
3337142527c77d Satya Priya 2022-05-11  146  	rc = of_property_read_string(dev->of_node, "regulator-name", &name);
3337142527c77d Satya Priya 2022-05-11  147  	if (rc)
3337142527c77d Satya Priya 2022-05-11  148  		return rc;
3337142527c77d Satya Priya 2022-05-11  149  
3337142527c77d Satya Priya 2022-05-11  150  	/* get the required regulator data */
3337142527c77d Satya Priya 2022-05-11  151  	for (i = 0; i < ARRAY_SIZE(reg_data); i++)
3337142527c77d Satya Priya 2022-05-11  152  		if (strstr(name, reg_data[i].name))
3337142527c77d Satya Priya 2022-05-11  153  			break;

This code assumes that we will find a match but it would be more robust
to add a check.

	if (i == ARRAY_SIZE(reg_data))
		return -ENODEV;

3337142527c77d Satya Priya 2022-05-11  154  
3337142527c77d Satya Priya 2022-05-11  155  	rc = of_property_read_u32_index(dev->of_node, "reg", 1, &base);
3337142527c77d Satya Priya 2022-05-11  156  	if (rc < 0) {
3337142527c77d Satya Priya 2022-05-11  157  		dev_err(dev, "%s: failed to get regulator base rc=%d\n", name, rc);
3337142527c77d Satya Priya 2022-05-11  158  		return rc;
3337142527c77d Satya Priya 2022-05-11  159  	}
3337142527c77d Satya Priya 2022-05-11  160  	pm8008_reg->base = base;
3337142527c77d Satya Priya 2022-05-11  161  
3337142527c77d Satya Priya 2022-05-11  162  	/* get slew rate */
3337142527c77d Satya Priya 2022-05-11  163  	rc = regmap_bulk_read(pm8008_reg->regmap,
3337142527c77d Satya Priya 2022-05-11  164  			LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
3337142527c77d Satya Priya 2022-05-11  165  	if (rc < 0) {
3337142527c77d Satya Priya 2022-05-11  166  		dev_err(dev, "failed to read step rate configuration rc=%d\n", rc);
3337142527c77d Satya Priya 2022-05-11  167  		return rc;
3337142527c77d Satya Priya 2022-05-11  168  	}
3337142527c77d Satya Priya 2022-05-11  169  	reg &= STEP_RATE_MASK;
3337142527c77d Satya Priya 2022-05-11  170  	pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
3337142527c77d Satya Priya 2022-05-11  171  
3337142527c77d Satya Priya 2022-05-11  172  	pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
3337142527c77d Satya Priya 2022-05-11  173  	pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
3337142527c77d Satya Priya 2022-05-11 @174  	pm8008_reg->rdesc.name = reg_data[i].name;
3337142527c77d Satya Priya 2022-05-11  175  	pm8008_reg->rdesc.supply_name = reg_data[i].supply_name;
3337142527c77d Satya Priya 2022-05-11  176  	pm8008_reg->rdesc.of_match = reg_data[i].name;
3337142527c77d Satya Priya 2022-05-11  177  	pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
3337142527c77d Satya Priya 2022-05-11  178  	pm8008_reg->rdesc.min_uV = reg_data[i].min_uv;
3337142527c77d Satya Priya 2022-05-11  179  	pm8008_reg->rdesc.n_voltages
3337142527c77d Satya Priya 2022-05-11  180  		= ((reg_data[i].max_uv - reg_data[i].min_uv)
3337142527c77d Satya Priya 2022-05-11  181  			/ pm8008_reg->rdesc.uV_step) + 1;
3337142527c77d Satya Priya 2022-05-11  182  	pm8008_reg->rdesc.linear_ranges = reg_data[i].voltage_range;
3337142527c77d Satya Priya 2022-05-11  183  	pm8008_reg->rdesc.n_linear_ranges = 1;
3337142527c77d Satya Priya 2022-05-11  184  	pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
3337142527c77d Satya Priya 2022-05-11  185  	pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
3337142527c77d Satya Priya 2022-05-11  186  	pm8008_reg->rdesc.min_dropout_uV = reg_data[i].min_dropout_uv;
3337142527c77d Satya Priya 2022-05-11  187  	pm8008_reg->voltage_selector = -ENOTRECOVERABLE;
3337142527c77d Satya Priya 2022-05-11  188  
3337142527c77d Satya Priya 2022-05-11  189  	reg_config.dev = dev->parent;
3337142527c77d Satya Priya 2022-05-11  190  	reg_config.driver_data = pm8008_reg;
3337142527c77d Satya Priya 2022-05-11  191  	reg_config.regmap = pm8008_reg->regmap;
3337142527c77d Satya Priya 2022-05-11  192  
3337142527c77d Satya Priya 2022-05-11  193  	rdev = devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
3337142527c77d Satya Priya 2022-05-11  194  	if (IS_ERR(rdev)) {
3337142527c77d Satya Priya 2022-05-11  195  		rc = PTR_ERR(rdev);
3337142527c77d Satya Priya 2022-05-11  196  		dev_err(dev, "%s: failed to register regulator rc=%d\n",
3337142527c77d Satya Priya 2022-05-11  197  				reg_data[i].name, rc);
3337142527c77d Satya Priya 2022-05-11  198  		return rc;
3337142527c77d Satya Priya 2022-05-11  199  	}
3337142527c77d Satya Priya 2022-05-11  200  
3337142527c77d Satya Priya 2022-05-11  201  	return 0;
3337142527c77d Satya Priya 2022-05-11  202  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

