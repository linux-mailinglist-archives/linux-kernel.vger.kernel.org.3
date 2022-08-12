Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE63F590BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiHLGXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiHLGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:23:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83FA50F9;
        Thu, 11 Aug 2022 23:23:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C50UTO006674;
        Fri, 12 Aug 2022 06:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=AxJKmXQ7V/LQSlFusqMwQRPnHsQEEDZ1Lf8TCJk88RI=;
 b=cLID5aaMxUMLm9m+WMc48FwC+/HzW0v7uPjAek4Kvpt8BjrKo0E5uZN8hRPwfen/ktk3
 9juRF0fyAQWmozmYxlC2NagvFI70T/ElJC4S7rkMUr7+3Pn1lpVq7fOZ43YyKURUcmE9
 qOEfMmI5cJQg4Ji/CeX9dYweO8Ol8idATdxzNgCnYZdB4AvEjBXJJvH+9NDM9zmBXA3v
 HETQfos8HEwB2YvntkjZry1B8/ke8PRGu2tPxY+skNqow+vc8OLwOrHq4+9FQPPHBw3O
 7MNDIAqeQdHvf9/Uskqju8coMnyEU2Bbsm3ZGQsdBRIwAkl6ltyWR42R1B3NNa2anniS sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdxm9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 06:23:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C4g8m0004950;
        Fri, 12 Aug 2022 06:23:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkcd7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 06:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/wDXKyN3O1HF9+bbdu7jtdC6O8qTJrCkRMKdoffFVMR0wWp9gjJLECWV7Gt0wl2IXw++WGuwC45+y277IHgpwYU6q0tsouqrgQ863lDEw6U3ObBQRM4lyaqKR4ofksqCzJ8Fs/lSEg4xXY/k7+U5xArYxw3ssugWvaTRptmUwIqtAMdLFhECQv5/i5xZDSte8sbUsUrQQpZQCRcVUAu4+xleQk7Ys+aZlvCB2hie2bn69lddgUFvUJ7VWJdo+VJmYjOhPab+JfJQnzQfyOveuxZyE5hFFhKlUdkKbYgpqGMYBZVsm0QsFwthZyz/r/5Y7CRZVdomgckVAm0rRNN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxJKmXQ7V/LQSlFusqMwQRPnHsQEEDZ1Lf8TCJk88RI=;
 b=m1iLFZz2Z3sGoxxuBAslX6banhxf0mG12cTYogJJZ9cyGaaICaJe5JS/2bLNJKULJHQQMla/3YQ+aEkFbNniQgPjXnpIsA8MXX9iSB2Q/Jc+vuYUjRqwhIJYdsqJ+crPoEvD8YEaNfyw6az8P9HpZ7iaFXpADbTfbB/bQCluQl2n+DNUKcB1eR/NStwJgq6eJPVnE1GRWzDYRj4fQF50SAgsgB5A2z3Cd5dMIL8nNFc4/c8lV9cXWfRhFtNY7NpAxNJR7fBExZDS3PLHPbcjx0b6D76T/djVMHAXyuO+JKoj+KBiW6jT5vHqm6BblYDTxqfK4nC9yyQdlz0kQEas4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxJKmXQ7V/LQSlFusqMwQRPnHsQEEDZ1Lf8TCJk88RI=;
 b=hNs8mgPSaRegN3oOZwjKImcYe6KzterXFbNAUvq4Gk6DEW1/wnRgnjYx+pf7qLhlbJWZLfd+rNi8+pBkOA0MuMEquagp4yqml0LfkyWfcZUyv6kL3d2z78KKjCxZ6danb+NpREODBngeNt4IrJ2en/ODJfJsSRKK5sMfOujfJxM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4962.namprd10.prod.outlook.com
 (2603:10b6:208:327::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 06:23:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Fri, 12 Aug 2022
 06:23:12 +0000
Date:   Fri, 12 Aug 2022 09:23:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Frank Li <Frank.Li@nxp.com>
Cc:     Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jon Mason <jdmason@kudzu.us>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip: imx-mu-msi: fix platform_get_irq() error checking
Message-ID: <YvXxxGHIf1amGV6p@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0a0246b-581e-4245-43e6-08da7c2b2224
X-MS-TrafficTypeDiagnostic: BLAPR10MB4962:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYYbviWryw1kI9J3+DtObvQ44f9YWSnW5EkmtaW8QzFes/8hXcd70SiksgDt0iyYvEBgRebVvEqgxqkoiMtOOGi1dUfWmkR0q2gzDK4GAOi2KL6BXVtsVzEPR3sJLguZ047S2FT1YyrKR/iPoLGcjK5Am4T1cUQNiL/d9SK9mrZyLLH4uNqYwOeBXVrhLHfpAxTd/A6uuO2GXiECzrTyGvWZfWk0OhE5R3aF0Sa15uSJtq/X8cdBw/dYtf74YnsFWRKF332/pHmyZIgHht6rn0zqvLlwqEcdJ/tZRhEnVHjlm3AqfZz/Tl3PBagMIC5Nd9uYg5U8gE9GKhImOTgjhGcA5vzjlJ4KI/bNxhNGmZpYyFeUsRFpFwJ6PRpI434BzRT9yZ3HakmBKAUV79gTfjSDHK0nN+YhkHYB3N0TSIyU0APF/2OaJ1LRwYFvS1LUk6OPq9KN7jKdvduy0akL+l9+QOgGKyNmHxF3NmoibhGh80WMb9kb9cgIkO1Xhsx64gCAugpYE+NKYYEB1nPBjaroBOsR+m6Q5cdKoSgwAZgx3wuXQ7boieu5xI1PV5e9ImUzg+yAe3xs1GozOUFmGlunzBgn4qaiJ01qEUribNt3AkjOVLk5V1rvt3VX5zka58uznxGBeLdnyjaM+rIkepUC1Wdl2qWxf0adf8hsn8OeH9u4Jg5KWCUevd96XPfm0FbeevVQSYEL7d8Jh/BIkuUvwhaxj43WELSNVFOxo56Ia5d2zxt9eLOk41ZP+DI6HGtaiNL5aPvhQ5U9miGVEJjfGk9AjerfxsO28LEh3Uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(186003)(83380400001)(33716001)(38100700002)(478600001)(38350700002)(6486002)(110136005)(66556008)(6666004)(41300700001)(316002)(7416002)(54906003)(44832011)(5660300002)(52116002)(6512007)(2906002)(8936002)(26005)(66946007)(9686003)(8676002)(66476007)(4326008)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nlxMrEbV3tPs5PwbquGRG0VIFH+dLze2yh94b5QVNQ54o+pjwLKZ8+jzKICC?=
 =?us-ascii?Q?IKs1jfraNeMchRCL4cORswKgnyezBQoZ0gHyl+zViNAQ6PLm9dyEeQIEuNxm?=
 =?us-ascii?Q?jKvX+NUKlRvJUYWRMnyaGyfq5jN5WO/uK8RheHbBgsbuqw/vNV83T3F+/Qoe?=
 =?us-ascii?Q?XFxra3qOKwpghkKNq8PJLqTVTEZvqxnO9MnO/eFQjd5O9cVdvDPA36siaR3x?=
 =?us-ascii?Q?WQqDHzhPw4tLCrZyCkMPx/ec2ydzIKRx1gBOiGIRC1PzPo2Ks7B0eaLPAHu1?=
 =?us-ascii?Q?teJ4lgm0J0hDUh3ch9UZAUUoaazmg0XxGDoBQceoNkiUzpyiyF/CIFgj4dP3?=
 =?us-ascii?Q?IBFofEIcHJ/mjg1kFwSI0Ulhl5zEVKClo1srro0jH2exs79Kkfg9EPQcsFrA?=
 =?us-ascii?Q?G7pX2fn3/Zfyr0Xbi0I7LAB3oBLTuddYH8ypfTl5knr+78budxoa4UOpzmES?=
 =?us-ascii?Q?IgiX0AsZw0ljGo/jjyggJdp2/qAgNanI77fGe16fIcAlwsD1ZIJjhJlSeSMd?=
 =?us-ascii?Q?kmgaZHBYHXOEqQ15mFAaKpc+qel5QB0nPVceEaRGaea672B+qtgjv5zFtLAG?=
 =?us-ascii?Q?0C2iLWXERY+zmMLuub29/f7wnllk2B+v/rKdTQoklfrcOLJP4mhWTJ+21XV1?=
 =?us-ascii?Q?Y8m/LK0H7Poury/pWqSitQ3e3LQA7MLYWPmIqbA0HRp9WwVlo9JuzYDy04ht?=
 =?us-ascii?Q?g846AlrRLb/hZ6mKdTx8ooLD6OXjcVuWZnkCQ11EFLasYs984ywGGhhycgUV?=
 =?us-ascii?Q?/P5wK0bYTxxF72QaU0PaCMXKAgR8WAEYwV+Ju6TVTPUf5KZaI9tM658vDxuB?=
 =?us-ascii?Q?yELQXLsR8Ichf8m3RMfhFtaEv5P4AOG2UOSXOfOnx9DMTOIOKjJEEM/kot48?=
 =?us-ascii?Q?piJMGvaczZoFiy+Fd2k7MtI4ut2bT9LCI/KoBSRzl4aVyOZ1pq2obZynRtpK?=
 =?us-ascii?Q?doa65WIGtCf7rzVEwXdN3822TVZhjs/tz7QTTdQniH7ZAeROIAu8mcQF14cd?=
 =?us-ascii?Q?5mhq7p4tvx4kTbe+dhZODsv7n0R7FzCVJ36rJ1u8p64TLALW8JgT0KExHL8m?=
 =?us-ascii?Q?T0uLOjRGKHdV4VxAMElXTj58BehIhf9oI7JsoV3PXwTY8SWovYot2W8WlnO5?=
 =?us-ascii?Q?Wic4H8uyEWOrB/dekLwfXR7aJqniJIleJQSHFCO7znnR5sK7pWuPp630BMoq?=
 =?us-ascii?Q?12UrwvoiVjALHIoCWm/V7909IADuNfZtRP/0mvCcLhMDe6zcmpCk2pBXY7jz?=
 =?us-ascii?Q?iBuFhT34Y9K9AC8pdzV5N1P2E+nAD8L4tL/qiNr5QbxLLuLUGTYQbNjdogfG?=
 =?us-ascii?Q?pm03N+Zj61SGCpG1qMvOsFl5Hz50IFgs57s4SuWpSdbxVmj8liaHuV1wsLxa?=
 =?us-ascii?Q?Z1aa1u55O+HMNe9TXBQxTnJrGpM/Gxq9w56ZdSAC5B9kstgXzseebcrYOn8s?=
 =?us-ascii?Q?B5AS6az7QxgjCSrL+VFJa21rwP2Py1MyKU0oBRlacUFDN0a8osTGxbBQBbdJ?=
 =?us-ascii?Q?2c8aYZRqzhnYREbCKbWY5UygQ83/nRofOIYYQlukBHkZ7MjbsFqqBTFMtMlV?=
 =?us-ascii?Q?43EY//lUm4ZyMaQn+vs/buCk1DxtFbAEZZo4/t473zbXNhhIBMeIHnHCuYOl?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RUtg7KcOus96JB09zEfYJSGoDPx+04ObJx8NKK7K6oRlqbUbsEOXU1cHa/RN?=
 =?us-ascii?Q?8sv1i42O+Ne7Ml1iWD+MxlJvPNkpZZZwst7keDBsMaZsfrI8YSrv/m2A1QgA?=
 =?us-ascii?Q?t3Ee9zqU1WUuZNc3LeKGVLiw/BNa5FjMFcNvR7h2yrgIbkNPxg1VJrzd/liz?=
 =?us-ascii?Q?gKLUqyjgokVYJoxg4PhgIaU6XxHPe9aKg9k/nvDSzJOKzu+dZinlFSt0PRnX?=
 =?us-ascii?Q?Wec1EsLTMMXnlnOhOYMaEh/3KUg9o+e+Z166whSnXRyBwg4XzevYpxS3hmM3?=
 =?us-ascii?Q?66EOryzWLJXINe7MLb01j+qGzBeoJMuAmZdz6Ce34Z1h2sASmul7Y2Rdo0uD?=
 =?us-ascii?Q?Vwfzq+YyNd6YUvnAlrpTJLWgWTj0jZe1PEJeAcExaYWYOGoiQq9Xi604CuoX?=
 =?us-ascii?Q?G1xEc80+D2FEXGi1wMQkQxx9gjx7kTJWfWArtcMwvSO0+Lp8nxhSFASpcanp?=
 =?us-ascii?Q?VfHgWvJ8+kSjh+uvh8NiDDiL422er/K3kNcUomZ55lxW6npPxwrxtU+7VR19?=
 =?us-ascii?Q?aYk6uAEU8dst93TaIPiOG+5UwpA/UdUOGWIHgRSLDfBTX3qkfMQlDE0J4hX5?=
 =?us-ascii?Q?BUsVckLMTQGJw7SMOUoVIRGboGWoB5BiQBYlCvyj9TxYHx6sUkyKS6qMvOdA?=
 =?us-ascii?Q?hkkuQ+bpDYmb7GtAPXXgaKOKewXhHXpOsbVljaY3cXMWbioy/B5xDcqmevj4?=
 =?us-ascii?Q?RxjAqCpESuV14QPXGbps6QSVJDzIvjqJ6xFOeIKVQNCpXo/BffN1Ecvi2WfE?=
 =?us-ascii?Q?gG7SZGAD1XVUMT6yaGs39ffL/7m/xeDeSZRrvcz0YkGnhUOvhTVYoqzE9lvt?=
 =?us-ascii?Q?sfPiHarmjGBcKnOzvonKyWJ9yXI7QBayuGj/f22q7yTFVVKQyc0Odjjl4Z//?=
 =?us-ascii?Q?MPhSaJAzt5IT+BsA+gZeckAGyMDPtFzKD8RiBd0tkGDxyd+KNjPlfg4wsKT0?=
 =?us-ascii?Q?yGlFgXhddF9iQsGHV725e1QepzezNjpVk5MRKZJeuUo6Cb1fJc3yWs4L9O0j?=
 =?us-ascii?Q?ZmDfYTMtLTfeUjv3aeqVvyq1GwaoFZgGxwLI077GTDPxGUPPP4N7wa1t5KCs?=
 =?us-ascii?Q?ccEunkk+8AokLGeliMXh8I/ZFsI4pVtTScIa1ptX1WJ34AImy37xqDQn9hzc?=
 =?us-ascii?Q?F/Udk+wuLTBVz5j/rZmn7HKNf4XnKeUwVJG3Zkih/qr7yJaSVAfBvm8WKSv8?=
 =?us-ascii?Q?7VFZk/juGimJbI5SumrM1Q8FbNIw1Kvq1NWgpVEWYJah5k6ZE0IYStGq6e08?=
 =?us-ascii?Q?nsS8y4vOkvgaaxNtEJNF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a0246b-581e-4245-43e6-08da7c2b2224
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 06:23:12.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qd2VKD9FAMvI1H76muCSvthII6X5FQ3CAKpFleBL9k4GM61kKROPa8fkBgPgjUuJ/qfnOHMc50sO0AltgDBZ99bNlylMzSX5gbrRYKl9wCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120016
X-Proofpoint-GUID: gv57pwnolbjA_tjxHywLWY3mIZLNr746
X-Proofpoint-ORIG-GUID: gv57pwnolbjA_tjxHywLWY3mIZLNr746
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() function returns negative error codes on error
so "gic_irq" needs to be signed to handle this correctly.  Also change
the "<= 0" check to "< 0" and preserve the error code as the
documentation for platform_get_irq() shows.

Fixes: 893ae515ff8d ("irqchip: imx mu worked as msi controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/irqchip/irq-imx-mu-msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index f7193a6c1245..97f3cdab8f58 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -80,7 +80,7 @@ struct imx_mu_msi {
 	struct imx_mu_msir	*msir;
 	u32			irqs_num;
 	unsigned long		used;
-	u32			gic_irq;
+	int			gic_irq;
 	struct clk              *clk;
 	struct device		*pd_a;
 	struct device		*pd_b;
@@ -355,8 +355,8 @@ static int imx_mu_msi_probe(struct platform_device *pdev)
 	msi_data->irqs_num = IMX_MU_CHANS;
 
 	msi_data->gic_irq = platform_get_irq(msi_data->pdev, 0);
-	if (msi_data->gic_irq <= 0)
-		return -ENODEV;
+	if (msi_data->gic_irq < 0)
+		return msi_data->gic_irq;
 
 	platform_set_drvdata(pdev, msi_data);
 
-- 
2.35.1

