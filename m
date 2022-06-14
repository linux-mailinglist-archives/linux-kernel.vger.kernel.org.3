Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6454A695
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354701AbiFNCZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353837AbiFNCU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:20:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF53FBEC;
        Mon, 13 Jun 2022 19:10:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1N0rN025679;
        Tue, 14 Jun 2022 02:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jzE2Xk76CHcxD+PGiXGxA0FT6EOzdI7tu2tgy5uPGUQ=;
 b=hOvT+0ZQiOBLha7OwsKAWWF3yRf4sWYkdFR08VYPUZ3iMr+tK6IhIWEFrzfhAhIzHQuJ
 94rMCXlsVQxaP/t7fjIrkOueE//z64/zU2kzXgw99TDz39gVEs8fomMH3W6rCV+qE0tK
 UZAsDvgFrQXFuXdGj7DwTnUlFpvuNQL36/7KJ3DQYdj4OVh3hb95wRHtdy3DE34F1hEA
 XbzR0A2UeSvfMNRVHesJuxRDTj2ZA5xqy9eKxc7HRmzjLaV+jvug6Js362wLlev63abR
 SEcse3akMKYx7h/20Fsgq57Jsjcbi+JzbkVuqPnlIV/nFNdWKn2ZuXWCNE/GaSuwdkwL wQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9cg9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:09:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E20hq2034749;
        Tue, 14 Jun 2022 02:09:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gph5xr4kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ60hUBqrT04zzPnh8QN9DVyuqY5lj/wFVpYeeTmn7xbOREnIjQuvC3UtSw0LHWvQ6LTkNIchhKxBx/qgi+j+H9EGXzw16iKRFFMnQIEQzB5g1myLRasrwzX5z4aUOsdduviFSwupUeMBTo+pH2tP0zipU/8GLkNctkRq43j/yey/HOUm2nUn4nGKuaMxevk7FLmZc9BBZ7WoXdNtcX+2FxVxTE5pT6Xj7mEPO1+1TTcWojIuL5/fP4Gihvl+Ym71iWoz375eGSja/r2FucFwT+fpXC8jNgYlqh7MCkd9rAop3qWu2s+gDoyaK/sKLMwo1rayesYtGcDBiQYwBdw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzE2Xk76CHcxD+PGiXGxA0FT6EOzdI7tu2tgy5uPGUQ=;
 b=KHHDOJbR4GJuhKaC7GKUQ/jQANkVWK2nOJpWEcuXaEp4/AJEtimfBq6YGmzmP8QhAM1ex2pXolXhxBALbpFsqVKB1HKcH1/5MBU1RIqYCbGM5HoLvjTLOCf4jt0MHCFEDMLTGj3Ggj2wlwlKS2ynIuiHP9JinUgZcvzhOy6VjVXvcRdMXfGSqhV4XBiPph7vwJXl42rvtGYl+7bBwUEjqP4NWJyDErcyLrMyP/5b0eajXs7I+7edxR1xZJAXXNczQCn6x70syMmrWwE9PDuhXttv1gHnHjK1LxhjTf6jdfSOaBip6YRH9Mcz9lEgTn9P8GxrSEmLFBFAdiPd5s/leA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzE2Xk76CHcxD+PGiXGxA0FT6EOzdI7tu2tgy5uPGUQ=;
 b=BfcN0Xkg07Nk1zKlqkW5OFzoah/JXiquYomqhbIbA7gaQIyHpIhIs6RwEOLR1mX82oY4cQDFI3PbLaHRjqcap43JHnz8yC7PkF/vatZ9KXBkWvuWvSa1st5KG0lqcT7TZxn+qNjrHe6dn7VfKtTchLSOBQMDSO4hScu12lyra7g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR1001MB2251.namprd10.prod.outlook.com (2603:10b6:4:2e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Tue, 14 Jun
 2022 02:09:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:09:52 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: exynos: constify driver data
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu8oro5z.fsf@ca-mkp.ca.oracle.com>
References: <20220613101429.114449-1-krzysztof.kozlowski@linaro.org>
Date:   Mon, 13 Jun 2022 22:09:50 -0400
In-Reply-To: <20220613101429.114449-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Mon, 13 Jun 2022 12:14:29 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:806:d2::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c53eb0-993e-4316-5a38-08da4daaf7a9
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2251:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22519F764E5D1C9CAD6F82368EAA9@DM5PR1001MB2251.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjtGpLlqeGieftMmtgp11Eokkf5nVkRl0GhwYd+CCTL1cAa9UNCs3ptx001fWu91YYak3gmTaxPn5fnw7TaJyLR5NcgVDJxp3IZeln+YwKkx4KEDFJehWWHSrMMB2a/SHDmXB6pwuqZmh1zZ/0FhXnG/wnKREY3XVGT5/hLfnmdzYs0M1HwCfZP0GIuW/+kI/BeEVFDpnVJKUAByLXlcU9w8N5+MyiYhN6X8SGZtyupO7SmHfAHMy50mmLlxifsVe7pseZ/oj1WOEizSe+KwESwkm/kdQCR6SAAXcCRzy5edfLefFqLDaWNn4G6q9TybWikZ//K7vtlpUQ/RXWUxnIUEsPWEEeOcVw4TLhFHm4VheydD7NExt+Gz2mAloI226X7tCb9fc+AHo33mKE0+97lirrGpDLnPHeDYWCCx5gy/dKqir1jCL3gXgf2SJE3Py4JTzm4+evTnVWK+C+LExYYgUPxpQ/O/poB3LpXQAEPbGR9EjIzGVpvLSDA46SqLl2mKT1G6JUTBD2BSEOItk9krLvULAXY1bsFtxqcbDie+VWs0DK7UJrgK4BWN2wsGYLBs5EpvYVYRcBjWf2dPKY5WxWpz3iiaY7gQrZ6CzoM01D3sZZSSfr3cxtYzQ1Wv3rmS9GyCuIjlaSU+HPureGi37tGFCoxboV5cH+aoB+M9/c21J0PlNO76A3UNiWQSL4hDkBvCuavNq5OhS41afQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(508600001)(5660300002)(4326008)(316002)(8936002)(6486002)(52116002)(66476007)(2906002)(6512007)(8676002)(86362001)(26005)(6506007)(186003)(36916002)(558084003)(38100700002)(54906003)(38350700002)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bI6gKyW6LWZRRLse8Y17z0xhNYPuCQzQkmM/i3sJA3n5ESbHBdQHQsDt4BJ?=
 =?us-ascii?Q?1Rq3ZpRXNHGM7RMoEJ5BvXOy2AAfc98Hcl8M9czUzcnSEtS/wiLPAWKrXGRn?=
 =?us-ascii?Q?TbPxD6YHY2IKZv3f5L/j8BdbRRClD7LI/+3Z/gtQHsV/w3NXa4iVBj0eZKkq?=
 =?us-ascii?Q?PAYE8KtwyKeGQJAZLmKeawfQSoffDoygoa0ILqsnAUEsT/y44b+GiRM30NHe?=
 =?us-ascii?Q?9ZOst8f6iqo1bc0xSRN68vhjLaKqCVvo6ZzaO6vdhKSeCjsrkqthDy+BqXhx?=
 =?us-ascii?Q?pURpnmKj9MNAdmNOEb9zkYNPburDDYRs3TWz/PM0JmyLIRRXvGEn0NOck7kI?=
 =?us-ascii?Q?AyaaM4M/23MuXdYebrfDrqaKx83Wa7aue0508ufQNCtVra7yWBiAXPq62OTC?=
 =?us-ascii?Q?DLjl7eaaH1hsPFQ5TW03M7BasL/u9l4za3PGlmTWMXWF5lSeOWlY5y4pGxAM?=
 =?us-ascii?Q?jAq3qk6O/uMJ78u6MuWqK8tyUA8coU7fHOGqUXfXqB6KRIl7aD8y3Q2VjxbI?=
 =?us-ascii?Q?Ov4ae6N1TlcqYf5KJWgGQdjvN2noQIP6FxRGK1B5TwCrCFoS0Cj8uLzPU2rs?=
 =?us-ascii?Q?nd4llhybSeip6WNVyUb1RAjzY6aPWYXfv/yrMkjrwn0x30rnt8+hm6rUmtVS?=
 =?us-ascii?Q?ZUUegubHh8kEUpIv7EJGWfM6ssVh6sjXS1Jm18TrMFOJ7HiyNIDAZWqbFcYh?=
 =?us-ascii?Q?/SEL2WBTeayfuOkcJdCcFRBwEUvMrXaX2rqHllPDJwsUXjJthzfoBUp6NJgs?=
 =?us-ascii?Q?d13pXBlnR7K3pouZ6juQCl1L75zPjAx9t0IDo5G/qKqs5IU9lxALA7sGKXK1?=
 =?us-ascii?Q?bWINhdvdLkB15EaK9kUifiZvzL43bigpGY0kNDnxLJ6POew1A7MCi4abt0kU?=
 =?us-ascii?Q?AIKZixe4ZGxVlqhOExXrfyGTWv4Te04E6/tHfHAbmId4X2QmjP6eXshiKXQF?=
 =?us-ascii?Q?m2RmsAhf87ADPggj7whVRp+RipGo5StHyRQefNzzkE+ciLyJlmjEz3RIjiFa?=
 =?us-ascii?Q?GTLcJ3fnRVrz5pb6OsxeqxtniIusjj9kR8Rzxepn52ekgl0EZoOTgBbPdh/M?=
 =?us-ascii?Q?TqQkU3jpe4rvAuDl+JySW4R1mda4aJcvKi3YOzbTHCiTT5++mFrJa/ZTIZi/?=
 =?us-ascii?Q?yZmYuw4MS+VD/UehDgFudyOf2OqK+Jdo9RpKh+qQT853/X3M3XGiXcJXKxoi?=
 =?us-ascii?Q?A6vnaa1wPO6NSv1lxjX5/VEH2vtu5yR3hssTvA+wotrBlvrCMKHIs4Fy7GJt?=
 =?us-ascii?Q?l/TODy7HsZPaKTWoxtCiiWMV1em1fJhf+OB81gOIXuiWZxLY4//K5UPhvyGf?=
 =?us-ascii?Q?LqCdugQZLyrsxKNuTC2e/9YC4hYxaGwYAyNHF7M6eHW3JasFkva9X7HrqzOL?=
 =?us-ascii?Q?a0tOUvb28vPwLkV2vSf4ZIio9fyEj6Vx5tKO9vUiCyou/8adVA7W4Cg3OYTN?=
 =?us-ascii?Q?PLt7oQCc2m0H5mnI2QljuAkJax6n64TTbbJN9y4Kg+96Pnt1zJUsKFy52+fn?=
 =?us-ascii?Q?faDHLLqmcBro1Z3wghpkunMLypxIzmmh3AttcAoWDpQp34lbO/KBUbPgRO1d?=
 =?us-ascii?Q?VikeeYfxPTyYDcskL570GZbNv13dHAWdZ7l8bq18hb980hkHjZ4zMVH4r8ML?=
 =?us-ascii?Q?1gqWhsSyjuC+HKIuUb+e8eHFx7EqmcyOG6931BIgpCjh4wIT6M7v/XgBUunB?=
 =?us-ascii?Q?z+4J9RomAFlXVzTC/pae7Z5NLeGClzrcCiOlIYgpKTFzs05LutMDlBi2UmWg?=
 =?us-ascii?Q?u2iEfd5iNf4DwadClEdPpk5tVrTEJso=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c53eb0-993e-4316-5a38-08da4daaf7a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:09:52.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOfP3sedFbEgqGNWfXYwK0SWXwm8bgeGwgXexdrBZH00JmVdHQi8LWc0P+VqxWQm7FkfhmZPicB3UXVWFJIOttnMWkOq9cK84fq55/Ldkkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2251
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=690
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140007
X-Proofpoint-ORIG-GUID: 9GsAaghv_bCZhX7qHxmlJTB_DfpXIMWP
X-Proofpoint-GUID: 9GsAaghv_bCZhX7qHxmlJTB_DfpXIMWP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> Constify the drv data because it should not be modified (used by
> multiple devices).

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
