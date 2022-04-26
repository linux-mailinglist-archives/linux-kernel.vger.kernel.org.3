Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1424D50FD12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbiDZMfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349970AbiDZMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:35:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF827BB08D;
        Tue, 26 Apr 2022 05:32:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QB4QU3008853;
        Tue, 26 Apr 2022 12:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0Xkvw/mDq6Smm39Y1oEhR7A6juK5FbgjN961jtxDNEE=;
 b=XipDe+jil91Bmavp7d9saWmu314iUHGr7EPie/1Pklj2QaV/MvjR4AnN5iOEgCOBCYJS
 fhHmFJwdMeRvynM76y/RoaKFRTx4aMpvmMyFW12l+F2GRyUOi+RJtqwlQK2qzTLjFfog
 srFfRqfUHYgUpV/WIjnQP9p+eAgK24LgsiWsw/7hdi0LQ8YOgnmflTPpdmIJtm3xA9j0
 JGu1o3+VVvyfZfOceyOzr+6aRQUO1OK4ExwSx8mvYCKKSUh4EfH5jFAjm3vc4mlaxlJN
 0meuqjCWQdYx7D+h/ufVZTtJGLtj8In1iuQJWcxTf64etKS6c2llSLbG+H4obODsDbOQ tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0ywpst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:32:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QCV4hr015960;
        Tue, 26 Apr 2022 12:32:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ax0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv3uptlgHkGFUnzmsYdjcKJndybjpQ7ULfnz1Wh4OYmdNyqyC/xFGwOzIcSJI8UFBjm8qn188tomRqhZOrei0wFx3KR7fvO/mf3RvTImV9liUPdCTjYxXuS6yRhgzTuUUGCUPf0fIDGhzETUjvnn0eWwYs6JCHcE4TYzAyTU63PzHCCLKLHN2yw6QXOH1UYRwJ3xiYmPWWhCftXOISi/QmsEDylcSoIytSYDPmYkLBVmxAqyVENCaxrtFKfbhWXoGFqig2G/KuiZ3xtChjY7oSiSVpXlj0ysh0XuZu4EdsaSZpJIUvdtTEEdfUZdXsY+IGangs9Z+u6TYqN1qZRjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xkvw/mDq6Smm39Y1oEhR7A6juK5FbgjN961jtxDNEE=;
 b=Z0NewZWsnMgYP6xNeJsKfS6Mw93fwpVmtlP9yHOr+8lGVjmMCQC4RCl/qNYl+DrVsiNy7+ziPFMxMsV0b6y+UgHG5kxoazkpRVMG8wBAR7jZ0Dscub4edNVTkdIdYw8KDp1uBq9MheDnxyuG7JwtyY+39ygjf3d1kk+XqT0chCRXuM353pNa3v0Lv6n1G7aX2LHjA/asVDncNY5iqwKVNhtCC9Id14CqoYreFhWc7nPdNFIUpJoiPhWzMNGJa6w8LHF7CtCnAYwBmF/R/YGUc7qlO4w7OFIr7wyasn6nhay0WfiCKaQobz800Ts8okphDSl+a+2kNX+Ey3fkegdSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xkvw/mDq6Smm39Y1oEhR7A6juK5FbgjN961jtxDNEE=;
 b=ENSvOw6zwHc9mMJZFSlPN5ig7a85O5el9qjxFlu5LKmQcEYoBcDLtAgTA1zrQ2PJqhTpzlvUs/Un0xZKgXWGuu9eHdvQ4WUmkSVoIIfKW2DNixIkEoQ92yDlyw7OvHhzSiQ3cgIZATLs2/btb4FzJgzIRgh998aqdj6Aqry0z0s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5263.namprd10.prod.outlook.com (2603:10b6:5:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 12:31:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:31:58 +0000
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: Remove duplicate include in ufshcd
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgk8t497.fsf@ca-mkp.ca.oracle.com>
References: <20220426104509.621394-1-wanjiabing@vivo.com>
Date:   Tue, 26 Apr 2022 08:31:56 -0400
In-Reply-To: <20220426104509.621394-1-wanjiabing@vivo.com> (Wan Jiabing's
        message of "Tue, 26 Apr 2022 18:45:07 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94e282a-084e-480c-c511-08da2780c1c2
X-MS-TrafficTypeDiagnostic: DS7PR10MB5263:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB52630005F0466229ACA3A4C58EFB9@DS7PR10MB5263.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcxNlyLfq7Jsd9rjGqhVSFODLyHcFk+1qcJQ1L42SroNsVbgep9yxFOoAzAqAa9kon62L1Y5VS8zC1328nO6i3IOvJ/MF3Xae1XRiUFxBrdSR4Sow9lozjcxCPqnH61RDMneq+qJFFodTsBf6DUPYghqtkoGkx0BgRiL0m3OYtvmWUyZdcOMDoC/j5jU9Pfg2yERC2rsiFGvqeLss0mH7UIpTF0Mk0Sh8GJaDKmjekVlPxzh+2288Sw8qubO4BEa3MIgXX/BzCJCQewy8Ff7gpNUpE+urLJaC+/Skcu4D16sdJiAyxO+VS0AnotfhQ1R1VGZ2dOw8Cxr1Xi53ujEM1wqRUFVBN9WktZZqSVdS7NbgfWmNfEiILBjpIkc76YpKvYPt2cOcVjW0lMnqwrqXcT6wSvPGWAser+ZRIttL/2HS4z89wThEco6JKwOFg76siMKJX2hTIwG51Ut+k2/sG/iqSabKzhJCjErH6zmnHeYJMohUEv0M9H2NHIrsqGkbgt+PLEumxvj9Ac6clWwfLDBBH3rj1lC3V114vuaKa2dKOE44eihNO9YLhlkRi2lM21BUOefmD5/jCbCaNR9ahbd08rWD8Uf80ZCUtmxKgb2yh5Pp7AcVVHp/2EcOkcAXsG56ZwC0GP3IubkFL1+VCgM/YWMZYH4cvSSxETmL6FlZBPV8auL88mWYeWfpe0yxN5SzGpd5ElILiTlUGiTtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(8676002)(66556008)(86362001)(66476007)(54906003)(52116002)(5660300002)(26005)(6512007)(6506007)(186003)(36916002)(558084003)(38100700002)(316002)(6916009)(38350700002)(6486002)(2906002)(83380400001)(4326008)(7416002)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRHqU19dpJmrLAkQsy05DFaaCIb7ci8TJuwyp+ocNLL3iWi3E1Tv1cmPpkAa?=
 =?us-ascii?Q?cyAuLqi45y/X0Svsr2S14Pjeu+guQlSxk4ArVGWRBbpiH814RpZvCxQyIdOk?=
 =?us-ascii?Q?wlLr2giZCoFu/5So/NpHX/mjr/6lW60LdhnNH4w6pBQho2G0YDmAvEfIVvqq?=
 =?us-ascii?Q?GOfQn+fRQqN3UW57PHKPIzCJAX5FubE3giN2nCO7OYU22kJnTcRudt/mcF3H?=
 =?us-ascii?Q?zewiBuoA3xLx7AydSgD14dDJI3IVhfQmFpt+xrcEjjtiruHED05C8/sJfxIL?=
 =?us-ascii?Q?zS1skbdNGxgOq8f3qlSVfENAtF32UnCE2DJx5XLW7I4opiGHhynTMUapJHzl?=
 =?us-ascii?Q?+pDAdgEJCWR3Z48DQJx6MiPPecP6jmmE77PPDdg4wqUM4clpov2n6N81DSNX?=
 =?us-ascii?Q?8Mb01W0TTEbK//MFmEcMirOidGkj0Q/Cgl5c0j6tVyoOIIahlmkMMmxdUrH4?=
 =?us-ascii?Q?wdskAFE6N3i8uNlXJ/sjBE/rfg6IIoLirm/h7lL3owh9m4qZYCVVB8t7XQYO?=
 =?us-ascii?Q?7twkn4r8ptEfTIbmCvj1SyfOWsae9ln1jC7H9qo0mq/bqWLwrN//jWHeD0+i?=
 =?us-ascii?Q?Msx31edkbSq+c94c13sH8BbIRayoE7wOSPOXmGl43/7I0UCW7z3dsmvet9Fk?=
 =?us-ascii?Q?udNNezVnXDvcgFvle4hqVog9PChlK68r8dC8Ks+0RWD3lF6r/6OnOqaeearX?=
 =?us-ascii?Q?heOyVrZS5Dy33RWR6Zv+H7BAhi02AWoMskxJ2UM0dIBA1CFFXj5XiqYvHTiK?=
 =?us-ascii?Q?63jJ6YAXiRpIGbRJN7g2a859/HhQOH1wlgBh0kyaLYWqSDUBlTwo8THAH/F7?=
 =?us-ascii?Q?TiMjRvRMgoqjE6m7Jy5/v4ubTV+mAYXelIkRlqu8gvIxk0JumBUQxc3ximUm?=
 =?us-ascii?Q?3zsSF35byOPLymrNae/7uh1K+cOjjhNP0zSxM/r0aqvapo/+ifik6r2Ei3n+?=
 =?us-ascii?Q?pRxHddxkbfYhdHc6zYhf8SRoIDRyd1ahpPy//40qVDqxf1HQkj/Winm3jHNf?=
 =?us-ascii?Q?yAw6yN2T85BF82xAVyPUodO37arm6u2AxqTMzlHBJZx4A0GdE/Ou10XzGLuT?=
 =?us-ascii?Q?LE2+pUnSsPHHS3+ZMIw2Ivb2YyJDv1TyPlKXtK8Asw+ng3sMAZfSi/AEYk+y?=
 =?us-ascii?Q?n6IWB6itRfTDDHz1l6/hUSg5ODSEKrM69mJoWAHFa3t2srY1sAVrat5yw2mR?=
 =?us-ascii?Q?4PIvsUyK+ltRBxDIrthcQhF00Bq/hjt/fjJRDEchYn/yoHkwU1z8MNiFP01j?=
 =?us-ascii?Q?rogczuU4Ch9wUMiSLQH+6Gz2vjzR4ZBaqbtxFw83XqsT+uxFbj7pnJpi+Qvc?=
 =?us-ascii?Q?WLIVDoFRnkJMgOKns2ujWItZT2ttk2mCqi7VwK4UfGmXBA4F25iiou9muhaX?=
 =?us-ascii?Q?84JAMdB8XB4eFmOJtYbWfHmhWEjwuwTMSDCsAdvwt4AXqdRV1nsnK/MpKVGB?=
 =?us-ascii?Q?J+zk+twNNvvMOE7UgN4GvtT2pjPESt9n2t0lpFPhIINo+IAtGjM/rwUSJmw9?=
 =?us-ascii?Q?eljKHIWPFfzTyx0+F4rfl/D+Ro0slLo+1TAA0eLxUrfC60vdhbByg3/oxjmJ?=
 =?us-ascii?Q?wGvqjJkV4+XSV5xTbzsLIj1LkuTqhakBq2eMlJ4CjNt7FOVE1Gmrm7td4y8z?=
 =?us-ascii?Q?YsVwX1Wot1NFNP3urFs9yqX5HRfozpdVjbYBHWs+KGzJoolo38JMJdprhGvi?=
 =?us-ascii?Q?eLjMdpJxbr843VUWzx4kCNf+3E/XcBxN0xxmFlgQSf5OxP3lwiqihTfk3a5J?=
 =?us-ascii?Q?S10Haefe9qUSDvnRhWjFt09vhLX0Fe4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e282a-084e-480c-c511-08da2780c1c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:31:58.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3quR409dCU5tmDpQ0vPgGzT7MCZnEJaZRKXGiwTHwWxap9nTGLC72JEW764EHGT4lf3eOvu3gRb9cXLS7fjwONBcWnHugWd7lUQaBzA4DC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5263
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=911
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260080
X-Proofpoint-ORIG-GUID: V5d5SMbDZmpMvuTHczcxRIRUToAnT9XU
X-Proofpoint-GUID: V5d5SMbDZmpMvuTHczcxRIRUToAnT9XU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wan,

> Fix following checkincludes warning:
> drivers/scsi/ufs/ufshcd.c: linux/nls.h is included more than once.
>
> The include is in line 14. Remove the duplicated here.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
