Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DD959CFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiHWD7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiHWD7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:59:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0854B0E5;
        Mon, 22 Aug 2022 20:59:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNxDXX012127;
        Tue, 23 Aug 2022 03:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2trRNPvKfh/0HmIIzMhAw9bVsxPQt8uQBGRkyHVdDZk=;
 b=YCfd1ZTRSS/omsHoP8cuVnF3dm66Rh4C75EZJBPjlpckmU2bLdXJqwhCO6HzB8Xsyt4d
 +skpL5SSf0DKqcigZpjrSRCL7gRURnLdJkYcU82nSOjUiS1A6duGzHjLUuKl7x0L1z4J
 op+vuyKCGsmI0ZmhHPen56XBEYP/UJOvFhL/HbEw0DVjxsCW6s42+a829tfH26LtEAxi
 lesI8SSb/0YrEDMp01GrgL+pmqPdtxHdyGme3gmd4ggslY2meYW8XuArGkPHyc4KYpJR
 8+NEaItdM0u4+2u9MUafSDGZfnpf49g6meNR09C+OrL8ji7Cp0PnjkTkOD4wYHm7IgKx 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8cs0vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:59:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27N3IcFO037828;
        Tue, 23 Aug 2022 03:59:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkgpf88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2qyHLcJpgjCV9xXUAHUErvmcwMtMUsdmLEXBkLmEXog5PVSHGTNIx8TssX6/zfOjsaGm9/9+ih0BYC7fBPNhuwzXPaJOjjdfD00v1ocbbo+G7B1Q5uqitGgVUPBI2N8ZXpE72vG3w4xn+GRss2nkD9vg2a+2aDTryKPtgjpm5HXdQnPEIGX7qiKO29qhoB9artPTUnEcmXKMPZKkzumDxw3TZ5oknFl+MBrvJta8f/Pyzgj69C+UNvvPfpFNCUP57td+QkinKKgKZbAOWLUy5m9emAf0QnnvmX7jZlcq5rWiW1F+rM40Uv1V4NhO/QpGK/3gCtBLdmxL3PpOLPd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2trRNPvKfh/0HmIIzMhAw9bVsxPQt8uQBGRkyHVdDZk=;
 b=duf3xUnmxKVANc7ptOgDuro4ymxWVTU3fC8VpPD2twb1NW83bt5op310si9r3GX3obGzFPHJeZ0Dk8+aC7mvRWsR3OsWLXsOPXSs5T01dZKQg1OpvBHichks5Xmgz5ZxdDvHXEfe2N1PpUwZgPOOugYuNlnDD1blvErS3W81tK0TNyKIDc9QMgGZ0qU9MYdfti2FOMjSNFmWwlG1HbLPObOZU9DW01TBKBGfuuHdv9aSEUSXsJGfxl+wMKyFnOwFOe/g2wO82uf/aUC/fuwkSIukB1srXYetSQWcwWReQP/MHVPH1IpCFu2BOGwBalS4w/XFc6Ca/T6dLZsthgLJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2trRNPvKfh/0HmIIzMhAw9bVsxPQt8uQBGRkyHVdDZk=;
 b=FGwiRlN/9VWz4I3WI5RN4+f9uRgOkuP4WiAG/PkOZySSfqggQpZ5cE/RL6EnvXa1sNauhZrMbeyyUwulZRm3aA2MDMB2OsW22Z6+cmFeTiGzFtmmRToxmwaHIWYIB8plNiiYhoKw8rJstk0AsiSsugyjSinGjiFb5/No2sDaiWg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN8PR10MB3697.namprd10.prod.outlook.com (2603:10b6:408:b3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 03:59:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 03:59:24 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Replace one-element arrays with flexible-array
 members
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k06z8vaw.fsf@ca-mkp.ca.oracle.com>
References: <cover.1660592640.git.gustavoars@kernel.org>
Date:   Mon, 22 Aug 2022 23:59:22 -0400
In-Reply-To: <cover.1660592640.git.gustavoars@kernel.org> (Gustavo
        A. R. Silva's message of "Mon, 15 Aug 2022 16:35:19 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeab3503-ae7d-4f4e-f01c-08da84bbde13
X-MS-TrafficTypeDiagnostic: BN8PR10MB3697:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2M/wPU0t9Zg24CjLmtaz1KUHuTsd/ZWuwNa0rm0yXbmQ5vJKHToMiRnFG+U16neEDHsIwdJtZTf0QFKtOKUlC55yn/Yu4wy7Wizfs41I8EEn+WiKh7p0F7itQ4TyJOFuzPznyaSlX6fi8g8OkerK6SXy6aTLVhc/gJyqI3J1EJ2hGP7z53/MPgu0KGRIE76oo00RjybTMJ73TV+sMPcDsoX41EVkW18TuIyGtZRyzAa+7OLlWADILsbVKB9rT+VC0ivGZd9pv/jmSbLMdnaeifKlKj8WDbCg1RDaE9kXeCH0fXczEMExyvngIybbHbXDv1/zawDHLuPvg7WGhX3g+EDTvgjBZIB8DEbFYkLg5QVSyeUGq0YGK2smRcMAu+mDRk+9UAq3+cnPsljAFqwaXCG/xLkyvj3QalTfj8L0A/PFdAGbTuTAyHwge8UkP7zDWNLsPpqDracRzpvEVI1pCg0QrZRgvA+bXaoKzC5WZmfBey8d/hzshEg0HEDY0J8x0k/wF2N8WqtCxxY4ICXKSma9iyxHAvBaTp28Iju1aZiOI1ISllnlYd+YVSXL+uBw2lJUoyPZ2aobnOt7VTRq9elvN322s3frU9mrQLOH6BZqZhnjpudP+J1OAe8KWgRQosXgtUeFv6zSB34zZgKQsnRwyLPKLXBcECNGk+5Z7avVvbnT+yO70WU7ONWSFrcHub4I30Abr11BJ5gVFY0Qn89bzwbBGrMzQesdgy6GZCmR6ihXrgGzgXkB/wuoHF/xp1lkObk0GpUIFREkwABdQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(558084003)(38100700002)(38350700002)(66946007)(66556008)(66476007)(8676002)(4326008)(54906003)(6916009)(316002)(2906002)(5660300002)(7416002)(8936002)(6512007)(86362001)(36916002)(6506007)(26005)(52116002)(186003)(41300700001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7txtctn2tbv8oYHcZwg8GVnYfjFezBXgNwvfqyxXepdlQcCcO9CAT7U9dJHm?=
 =?us-ascii?Q?MQLmHFnAWzzQyav7LQRrWDLDrhxJ25L6C+uCnV+HRNXi4HAnmS82PAzBVvd/?=
 =?us-ascii?Q?vwfIgP/ROths1p8pzHhR3MBI9zfOlVZ5KoTyeA5bDsapfWgP3S9wGTAwDqwo?=
 =?us-ascii?Q?EmnHXVd6ezLa/SCP4wqXmYRxPDGQNQOSDiBiKM0gdK9owreHrA9676TZT4SE?=
 =?us-ascii?Q?FDUIOR9BhVqrpPiwmGBQ5QW94JV5oX2izjqi3hnNhZSYGEquFSmPhKlMVu6F?=
 =?us-ascii?Q?nhNmuZteRuBhnxZ3EahphB5bVn8/TYqt+0djI1fRrkMOF9tZpWpLjKrO85/J?=
 =?us-ascii?Q?JnVRAOiMctKht0/oPgZBsTHTVurne4MgKZD76apNrYQj6N1LV8mhCgka5zjm?=
 =?us-ascii?Q?hvRvURn2Ac63Rb1RZWENhKUxZK1X/T6wEZWTkBkUPFfgsPeRgxEx5MvpXWQj?=
 =?us-ascii?Q?rMgUteNjG3Dl26XTJiYWFLSfkRkBCXaOW2p92Lv65Yqf61GQLmswsdX35VcY?=
 =?us-ascii?Q?ox4eDaGsqRxk213o6jCPxpUDfqHACch0qr+N3KbiKK8bYfBMEWBTbjudQwlS?=
 =?us-ascii?Q?GLfZ9S0TNlePp410aEMdYkwxkx/w6zWMAtj+uOAJsKqtdCFqEYLUOWCFmV2G?=
 =?us-ascii?Q?d1VcIIHgGXqI0oQRYNNpUaYSE5V4V1h7+nqtlvNnHs8MPo8N0QA2do097idl?=
 =?us-ascii?Q?amHiiYdBT9YM88c+NIS/bXJJSxMvz1YNpSAkUnYWmv1+t+9TEDXI7B0oczbb?=
 =?us-ascii?Q?k5ZK7woxAZsW+hCtbeotWiLtA0qGqt42z+57GXfjJ/4FpqsZJ3upgleUTuwl?=
 =?us-ascii?Q?a/SI5DMYVA0DYqN0ybJmFNm7lGnFJIf34iDC7KDcb5NgrUwYojC1lehplooc?=
 =?us-ascii?Q?BobSKHEQdP2pcuZvSflQ8qTHMHQqjTcGnbb081Cdo1UQYooPWMNumsSuNAzq?=
 =?us-ascii?Q?72DOJUjhVCBE/boU5BQg7AqqrWv8d+XR0thIaS1uRw3l11h35U8sx4mePzya?=
 =?us-ascii?Q?goOINHyM/PVhupaYzybt89w9jyLClR82suMhzk5LIMAmcld28G/zddHQKB4T?=
 =?us-ascii?Q?iPRTO4vxWLDF+6Sb2f6BM6s6qUkQpWBQHb1K9ICM3Mt6iB7HhhD6rxpfoEXC?=
 =?us-ascii?Q?k+Z5og2FH0x5rpqZ7Ke1rFtezmJXIGr/dNtfw/6Q6iCVHHxFAQ9cgsn3wiaA?=
 =?us-ascii?Q?cemCGyRhUZdLdRYbFRbD9/HQtHY19ow+A9DR2vp70R7jXJoJrMtClfkGS9pG?=
 =?us-ascii?Q?F1XRbpi+7Pk8mqLiIQAkyPHj4IwPuKGyVw/fbt1LuCGKaybrY1+xEjh1o7xL?=
 =?us-ascii?Q?ox+Ze+ubh0emnYrAivQkygKXY2hlBX3TjOBCpXLUTdP3WYcOjT/jq/I7Ai70?=
 =?us-ascii?Q?eJhHyJBYjyehLQfks62rNhHbprShicEK981FGSbMhG9bf1HSHZahuOlS/IIm?=
 =?us-ascii?Q?gCNwf4PBOYCEITSy8e+aIsFtCmo7yGW1yby14Kxxb+e78fwdhVKm0Y/BCluw?=
 =?us-ascii?Q?l33xg9ZXAqCdBe1CBUqZohwZlxQPmR2BT0LIAJ1enjDcMvFw5xm4nccvkDNm?=
 =?us-ascii?Q?PH9DrXvoSfWZkm9+ZeIw7CCogMJHDcjbhjWZUOG1oNkfUoDrnzGcnv9Y0p3T?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeab3503-ae7d-4f4e-f01c-08da84bbde13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:59:24.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSz/LvTi2w4EfYq9CbXz0k5bmq+Ht5by+PoLaNZpEXFpWjzuCk1TWvUpEOBpXLTT9OGv6dJzFSlIWN+N89IM8V6pIrY9CoUQWwpZwVeq2nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=640 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230014
X-Proofpoint-GUID: WU4MPFlPHrmkRscX-yisI7o5JUb8kQT8
X-Proofpoint-ORIG-GUID: WU4MPFlPHrmkRscX-yisI7o5JUb8kQT8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> This series aims to replace one-element arrays with flexible-array
> members in drivers/scsi/megaraid/

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
