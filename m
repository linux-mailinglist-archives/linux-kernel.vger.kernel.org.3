Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8857F5A8CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiIAEqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIAEpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:45:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF313CDF;
        Wed, 31 Aug 2022 21:45:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNn7wH030499;
        Thu, 1 Sep 2022 04:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=nrH0L4SrqeWKOAYnQmqhVSVG2MGXd5MMXwOtMNE61qI=;
 b=YzxMsrMZgJlAAMHoK8aokHyZOdR60gTU8qDzy+7MZyIYMLlpy/uLPLcjCTrvI1f+PISS
 LKpVID8vMHz/xn5hMLE7K5ZJsQ22tzxCAP+F987nsw7zjFf3xANu12HHRYdcE9DVbrZo
 J7q9ER1CPIBaAOpExEJwweZnR72nyO//9/SyfeLeXyP3eGUU9IW8jpddTW2DQz/tAUgj
 DEN7sIZv3DlBYjMMZimgrGWqey8c7D9asFmyAu+t11wP+wpddkWwK+rQ1q/roTIARe0i
 L6GULwnbFqMWEYT447UdJi0MPHl6JinuvRjxwJfyoM5BvdD2LRsc4s4o/LU4XZ3eQgXf Eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22ayek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 04:45:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813i4Se022867;
        Thu, 1 Sep 2022 04:45:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q611hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 04:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alhP0ZMABdLYOaUJU+P9McDf7iSfjhO8q/pHqUYci0bfq3/8XwGv0IV5MqylBFd4nR/q3YwBxYN0E/52voq5INp+Eokz/6f3KfPrlI2mFU6EZIzCZGIRxHpKfIz5DePf3C8UGuexUKqrbOuc6LWKScS6a+1vOUNUuIgiVHi1lxNe9A+IONVALTAdsa4uZ4I1HNwBjm5tiHDITxUxzE6tpCbUETp0b2liI+o+3MHB86g9j5wLCTgrqI+pEmAfQgoIyvt90U7OJRS/bjwoi3QBSl+YxnseHlwyQA2k89gyjYBi6OSjcq6POMVfCYGqi1yEyVZFi/2x9LX92g9fxOx6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrH0L4SrqeWKOAYnQmqhVSVG2MGXd5MMXwOtMNE61qI=;
 b=Bb0WZxroLspoA8kq9nRix9VCAmwVZRIrE1dkTWZF85SiwujuK+O6zu+zgVKPqIZvfRqUAUNqk/T+oqmKK8o1IkGfSPgQAzJpugfdfZ/y2OZKbbepwuHM4oBSpKyHd2y0giUr+7AYo2X4Yx+MyW78hua+Cmes62RATN8UVyjqFam32IHR4EETWGcJTcWkXSFBjQ/tpEEnZGGcQz3mSJiMJ2qzcUcfiuaEXRUyZ8jVv9l8z+WxQGpmaqVvBQ5cqM8zETmebXD1/axsFWmBu7PgG/fRAdfbz5vk6G2jneLBgvbV+by5Yh84Z85Dm0nsEbjyKIF7z/c5NRCNrovnCMroag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrH0L4SrqeWKOAYnQmqhVSVG2MGXd5MMXwOtMNE61qI=;
 b=QI1IOfH8R4oU1uR8TsuHfUM9uuBuNwrOpd6I6/KJjzD7exlZV5psOpCeqzSBgb1dfdHgBXa5HXgpPbeE5pNVKP3a2lRJC18gnaxXpm1gtsOwgANAc5qKa2mAIxngoaSr/oKGsgQuvcJb2aGBnFr4pZYmKUEKWPcZJ2JzqcMH/eQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6344.namprd10.prod.outlook.com (2603:10b6:806:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 04:45:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 04:45:39 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        storagedev@microchip.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: hpsa: Use the bitmap API to allocate bitmaps
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fshbln2w.fsf@ca-mkp.ca.oracle.com>
References: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
Date:   Thu, 01 Sep 2022 00:45:36 -0400
In-Reply-To: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Wed, 20 Jul 2022 20:13:54 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a19b952a-be71-46ca-ff61-08da8bd4d18f
X-MS-TrafficTypeDiagnostic: SA1PR10MB6344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXHu8y+6eMuV2rXf0K50nPIX1Ex8pRdwPPYAaVJeF3MYvseHateVFFc6xTBl9xrbDcB1lF+sP/gCf+jWq4G9E0pSQmh10/fXG5Dfskh/IHpPEMjahktraHVhMNzfD75M6zchT9cSDov8WqVZUPWLu9sj6or58sP5554x+w1Ih9vvxXOtJpevPILYVBAUPBzH2uQoNwkT+IJAVd1HOYjaNaHXoW2WhJGoC2fQu3O3pbfkPdVIYIorEiH4lBA0E5R4qjsxofwCCqU1L2mnV+AepTK7sockj5QLU2WZyKdd1Z3ZTOmrn2+u5SGEBfRrzkZEKAtpueUB74gkAE8uHYs7yG2mKczTKO0NkEuWmpEf0F3PKhtUir31sVF5wskJ7qCQWd1m8hbZ7SougnoD9A8XynfxYHZqUf0QT0zz1TaHLZiFJovZxrqy894PYX5wgr7daVSLrjs7TF777Xs19G03hsGeKMa55kB4Cms3nPCi1k4tbd2iwMlEkI64V9mffg7iUlc5vle7fgHKMcwndA1I8r2LHsX9O9N0uJZV8W+aqFIjN3ZfyqM9ysgr5J5a6EbJh9FTofWU9mARqbC++gPBVedcOFa+C8w9BZBqXCFfcQwAcmZ6l7f4A8Q1J/e90bgdLnwBRVK/G97qbpMff4XUC7HUbd956HUintPzrF+ZC/GlQaT9ZGH31x55sVLxF1N1EKfLPzDlm0s9wZrW72FqmViVg8hUYk59rSndDCEJ28xmQbVvVpo1DRPFnE9mcM73FO4a1jpsvObBU+fElCzaBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(136003)(366004)(396003)(8676002)(4326008)(66556008)(66946007)(38350700002)(38100700002)(86362001)(558084003)(186003)(6506007)(41300700001)(6512007)(26005)(478600001)(6486002)(6666004)(316002)(52116002)(36916002)(66476007)(6916009)(2906002)(54906003)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iugIRvxQugd5gdS5T7Tw4PyovZuadcqeKz31aCq0xXmBaM8xvNRNRQ7wbPc0?=
 =?us-ascii?Q?/4EJHUR4rYTusJ6wei3cty+5Ig4BY5nxMsBBInk6gH0gpDSyn/RJJrAq8NbB?=
 =?us-ascii?Q?3sWeA09VLUSq5BunmWT7ElnAOuegtlAja2zugVJd7BIKeKsvhrPN/3IdU4gf?=
 =?us-ascii?Q?hkQo+kK1twhbT9S0H9iH+MF4OLSn3lNYd/TQWKUZNJFfIxS2fer5TKon4lWZ?=
 =?us-ascii?Q?iM7WHYQzhvqDTwzs9YNvIu7ncW3uxLvDon4tyKZUTv8UpxCpESJ+5iz57spm?=
 =?us-ascii?Q?dKvMjrSYA3TXZ6UU3XKBwZbLItIoLgHh8CO5Oci8usujaMykj4NM4IM9TEDY?=
 =?us-ascii?Q?HlNhgP72Jdzn6v2VV6928Jx0NAYCzDhus18CAJrj82o7P9/VR9FvstdOQGNf?=
 =?us-ascii?Q?/2kZVf38zi96WoyqXsomlbhvVmni1Ier3OzD7HMsO43BNWsrRCqdG2dUB3sI?=
 =?us-ascii?Q?ds9m+odCZ6R8e8tk7V52H9Wisn9SChOIRjuwlnwqNC4yFBwuG/iVeP8x3uwE?=
 =?us-ascii?Q?WGQH4jE8ny8m9LhAjyXMDILoecbyLrAX3kFgnmwNLYJ3sE9NETWqTbZuGt0g?=
 =?us-ascii?Q?mM9V7ry2gvCilZKrT4g1JZqSusu0n8qOQkgRx6jc0LXWCdd7gePBlGM3kji5?=
 =?us-ascii?Q?SNOVyR6fIXfAk1w2q++FXKkpmxQRfRhRhcjF8wA1XbrQTAbDWOuwELF/TFNA?=
 =?us-ascii?Q?YrBZWZNYLRgAZm0ltLqhWXViq10Cq28kjyDpbXQ1bBz0MAisGpb2heFcG8/R?=
 =?us-ascii?Q?DmCdgcFPdpyTBh99kbc5rdkVu8qV3iMLP6L2DppqkejqTbkksbP0SP7SR1Bb?=
 =?us-ascii?Q?DiXH5GV8c+d7fuKlCbWAYR5ZO/OLPIsUO+Nq8ylaHPPR2MTJ7l7WFHDpuDGI?=
 =?us-ascii?Q?6a+4BtE9oJUIWilr3/C5WerI++OeWIODU6sTnIxFLt0D5GVPXpGxrTKFfQgj?=
 =?us-ascii?Q?kvmZhNZDMGRUjOCkPJ/In8b3PEG6dJW+IE7qPOxY5Iui73EHlPv1VO7fFYUx?=
 =?us-ascii?Q?CZ+avKUMi9BVtUDitbpkBReZDq+aPeVX5wPr0DmFIAr4VJzQ6Z3h76mQedw8?=
 =?us-ascii?Q?3mwLDw0LUE/KOCdR0qY/x37q6k2oR+t2pCfwc0WJLt/yUVYOOUkAiUAh2/sn?=
 =?us-ascii?Q?QdIEElIGJuBoP74f1NQ8zc+52zS+5pSajel9i8rwQwgjheZaBhHMd82lbbfj?=
 =?us-ascii?Q?nO1SaoRZlxyVF1ccz3AL9tUvad7XmzArPWAYh0SIH2dPXSvSJwRzNNnfeykD?=
 =?us-ascii?Q?Pk33BzR61mQ0CR8sn72cLiOdduJcsnYyx8DtkGNvJxv5fVTiBmOWU+eEKlzW?=
 =?us-ascii?Q?6v02Ttij9hgsdtsXHZVmqMtc+ULs2g1kFLcxQfP2iuIBj8RP6OXBAbaiJ2Ku?=
 =?us-ascii?Q?K2DG+fJ6tWeu1kDU0JpLL0FKTxY3QnhmWM4+A8CB8JmDjVolEhrF3aOGmVC1?=
 =?us-ascii?Q?aNyx9f2Q9bOIWl4bUJK3Qabk/+lyQcy/9HRKr2MCRUQBf7dbAOSYHR4dEsU0?=
 =?us-ascii?Q?KK2pbQFapJzD64pPCATnCvK3umnuKCJLNB1XJ3HcLVxG8mJAbF86O2hi7vhS?=
 =?us-ascii?Q?YPLws8U540ahge6Yewv3h+WG4w9qidUdW3GyN8AQzqDjxFsRDbQbnhWK4RY9?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19b952a-be71-46ca-ff61-08da8bd4d18f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 04:45:39.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dog6uHGTXkwtL3ovVmFHj82XaW3XNoOvHAF2gURTgVOzqjmpsMVRsDpsiUu8JPnmAONgw23q1NR4G1wo5Qdz7mGSQ0N08UPHQvydBm0T83c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=833 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010020
X-Proofpoint-GUID: dMm0hPmPVwEHEkf1Pf5AN6hZ8Kjgr7tm
X-Proofpoint-ORIG-GUID: dMm0hPmPVwEHEkf1Pf5AN6hZ8Kjgr7tm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

Applied 1+2 to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
