Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21F579109
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiGSCuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiGSCuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:50:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E10137188;
        Mon, 18 Jul 2022 19:50:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKZuS3024758;
        Tue, 19 Jul 2022 02:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rrCh1HiN3Kf/FlOzjac5kMje0WE7MFikMpqKO8b0i98=;
 b=g0qirfCgmp2qU+3LtM6dTgx6koAgYv7Er5iR+OPFqsGyri4RJWyCNoA4nqdYWRzt0cQn
 hiuk5DPtt7RjVTLi7rfuskH5HjJw/DeGvUToBlrTHQNgxvq3/GiAOtDmWR9b2pxY0994
 2eDPhi/JGbXXYbP2KSOmfCUpDnFPNyyeF2m8nXpOYcGpoybfUj5lzHBlyjvJWPksFg4P
 MoAR3VQww6yShJctvZPwHhhgPpLUbObhHuJqF1TAt8nfxmiYJXDTzTlWQB1RIWTjSZtA
 JKtEVrug1KbjGJk0sZ/XglZ4YPpHoTaa/PW+CYwgeV5u1s1anbooF53pISEec5gToVC1 ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42cy1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:50:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J0kNcX006365;
        Tue, 19 Jul 2022 02:50:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gg272r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HITQ5JAvPI2znD6/VVRXsd3dhddZzXMUnFhgv77WHT2JmvbHMDNr5OlRQ9DvTG+kvBki1Skw1lSaMiPVJGuotFmFNWa3pIayj8DZQMturqpP3is4QCMg7mAdMnY6FjczzJLKvFXnwZjgByeflk7znLP9qUSP4MnVOhUCVeuxQdi8ygDfzPX9nmNgiggxVVLeAXSCa7v353aYuWZARD2jpCjvFlg1odyDAdh6ZJaCHAoH9V/ZPFpuscaWc803DP2hjaUiazfBm8OKlQFNE+Hu9mhqSghAE+xMeuH3oB2AypnRu50uCR2XErvBYRPgY749n4fEpIoU5LXTF7ioA1j7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrCh1HiN3Kf/FlOzjac5kMje0WE7MFikMpqKO8b0i98=;
 b=IzG2VhzJe6LlfzP5ks6Ea+lxG1X2q+6uxBIWBR1hFrNo1BwNDZMEMcnFE3h+yPBHcTpI0HroJ1BxO1K/PxHy5oKpwQyZ0btMAGMgGlcNUyRCpi/9WxEsV8ueNRCWTNDrMF/kjNAVhdh/x60q4G1/jpP6glCEGG3FMHZwTVwEaRapNJNl9JAPYUblWVS9w9I1DMW85Mj//cnP3gL5NvXqXHJeYTRREfD3TX/LJGaOgLlFiMszqipWl4Lv3n5QtBvgrQFPHLczhHIDc7IdhmKAnSd8GEb8MPLIzAWWjmEGoFAmtxb+wDY6UOd7NTHLWdPzZC4Zpge57I8S6sL5CPlrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrCh1HiN3Kf/FlOzjac5kMje0WE7MFikMpqKO8b0i98=;
 b=L3zAC7Hd5q+vLFvpSHJeKwQnlaPyVG+D4+RM8wGdE4lXbb4kY+NZjHiKv9K/dAXGGNdlyV2UqWbyJ1ur1q0ajxD47KjV4wXwEIuY1Y0g8thuL6VgXHoK4x1mv95oCENtMVzJTBd37Lz4ZXgxIOk+WudwtuYedqLDGjaKi35QUNk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN8PR10MB3379.namprd10.prod.outlook.com (2603:10b6:408:d0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 02:50:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:50:13 +0000
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufshcd: Read device property for ref clock
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsixq0it.fsf@ca-mkp.ca.oracle.com>
References: <20220715210230.1.I365d113d275117dee8fd055ce4fc7e6aebd0bce9@changeid>
Date:   Mon, 18 Jul 2022 22:50:10 -0400
In-Reply-To: <20220715210230.1.I365d113d275117dee8fd055ce4fc7e6aebd0bce9@changeid>
        (Daniil Lunev's message of "Fri, 15 Jul 2022 21:03:53 +1000")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:806:22::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171919be-f0ce-4957-75cf-08da69316759
X-MS-TrafficTypeDiagnostic: BN8PR10MB3379:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XmrtoEA4rqWcwXB0ObcnEvnP3SsmFHL46tKq9M2h6s75UHt5R2KE14KJnMwmHLEHApsL8M739Li2haKK4UjtqeOc0G63HCR2r4qT+yTJPPrUdPdEk9AnkJTj0TLJ+dxG3YtDGiVsHWfZXwmZN0t3Sm1HV/9JmuC+MVn+C0sfruOhWYWE2Fni3G2Qs0ZHn6jemRokL93WStap9eosBMG0dyi7XNStdSemoJYu5Q0qoecG6s7DOcQXUrquOX+2GYr03IQI3sQKa2y5U+z0MJ7fKkuvG8my9GY3x6K4wOLYlkZnTnC/TlDcDhEB3UKjjkiz5mj4jQQoCWMsSeS6H6cf27e1/pXI8SPHgS97xd+9eLikJcvBmWj4W0ESojx0vgnBdp0FWEXgR9cSr2Qt94/8mR9ZeA0TFDgJ4pWbKHZYkKUvXASYM7O/VOXMmsHgearu/ScZj0WVZMYAE9mCYrfFlyEpTQ37Ur4oQcxFM/zZbn6xMVzR76DQ45Q2mbaQSkeAG+PlLe/RwsGsqsKNvY1efdV0ZuuLfTbDK1mpH6qW0coImLdr7/6lZBeWDni3VoY3YQtKnqZRKW3f2l2H0PuJQuf/xXofAM08dG+ELr2nncIhSbGbnGAzYJdXZupYkYWH97bSvmEfmde0hedYW9XFqQtU8a3mXzMKBR/7+QNhBk7aAZpPNH4W/argvGn8TQXZXJoELVPiYiGzafXT/hnQLhcOylcmqt6mRwbtd6up2lYyfMPpU9BMpuA3CxdgF7+iwpxgUuX/6Xw5uz7Lu60BvnweLZuhfw5VbzZBSgrB5pZyBcAg8pVGuh+F2I5zo0i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(7416002)(36916002)(186003)(41300700001)(2906002)(6486002)(4744005)(5660300002)(6512007)(26005)(478600001)(66556008)(4326008)(66476007)(66946007)(38350700002)(8936002)(86362001)(8676002)(6916009)(316002)(6506007)(54906003)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxXA3vqnSCYM1N55ThNOtzgcrSZ6maF4fL5XL/ZH024jLKEXisER0yhqyjEi?=
 =?us-ascii?Q?lyFzXOwPWv37iBKeC5VlOW9wX9s06V1e1Y3du+aNywg/0UtzZKfIYtBBDqve?=
 =?us-ascii?Q?uSt8lsVJSb6qI3PRhLjM5Cj4mOiK5D/tMgj3VTCaxJm/7/6V3JB1wmYj0rsa?=
 =?us-ascii?Q?d5EQ6CtgQ/jNSZgBN4T5zi0b/YmXmiJAxGgkWPRdEKZzCXFziOTaqmh7bViZ?=
 =?us-ascii?Q?HyFvOZ8fnTaW1Og6GI3wPEMxkYhkL4WY3wX51Ity2K8ffjcdy/N4mUBAFtmX?=
 =?us-ascii?Q?n8oerNV+Mx1IpdwZVuipI61kvHsKtrmqcPEuHMCnN3YzU03GgFQz4Ref5v/G?=
 =?us-ascii?Q?OFdSNM4k0qpaBkibC6OMzmLP7qR/xU4hQJopkrGuWA56pmyrM9RnTyosPSJ9?=
 =?us-ascii?Q?PFqB/XtfBBQ8jojD9ZEA0Iv3Od7XG4rfsCFxrdN+6Jl0ajPtBz2Ao1qfEBHx?=
 =?us-ascii?Q?lqjj8zbKM0g0CBw25qTS48yDquTlKSERiqTJlUdjD14Gj1NMWR+HGJiAiLdk?=
 =?us-ascii?Q?w5n0fJjxYvD03YKGsaoZ6Qzkl7jTW8gMDKQ5gX4HHGbXNbTNp2UOla2utTVp?=
 =?us-ascii?Q?5PEaKBgodFXDIBBI3gy0C2e2rYLwfZyswGR042JeFkRkf0rkWGfipXgK4824?=
 =?us-ascii?Q?FyrThB2pIlozX3wYn+fh05V4Y+KmM+iU34WISzf/j0r7DSze9ak1GBsPESEJ?=
 =?us-ascii?Q?t3ewi/sTtMgid7SlUJMEubl1lZ3BPzfbPrdil0Io3wwMIdxpXSaEfD4McYJw?=
 =?us-ascii?Q?C3gm6z6wnEAfVF2GZWEKtfk3fWLg3czzrqpDBSE6MWJBJ91vDAMfvL+th9kg?=
 =?us-ascii?Q?dR8LCYW+T7mHOGof67gBNx86ubd7PZ/NIHaG5+HSbwKqGc+4zsGUwO6P29FI?=
 =?us-ascii?Q?VgvsVi5oQhv9RxaneLSok+Y4w78by4V1sbIpzlIOcBS6wePmIv8cg4UsGBFj?=
 =?us-ascii?Q?ejO8thYRB325sbh4tvIFLOSDZCBjkzUL5kL/wNsbVSy7OQqtF3OsfDbizH+I?=
 =?us-ascii?Q?a3hvXRXlXNf3jzo4a4jHsx/L0l5by7C6/Y1RoWYf5OZoujkjyui609c+WF4F?=
 =?us-ascii?Q?A5gcf2o9xN6/aMV9V8S/0BV5Avd0DHXEl6z/QPu7NClukeXrpKoYpXNlUsZk?=
 =?us-ascii?Q?pqUyYWvzjAiqQRjxVN46JSKGGAtRWDiA+UfgjlakAEIFUl/KY14oHgAeSdFE?=
 =?us-ascii?Q?oU2RzkzC7jnSegsG5eSaKNKdIpvg3/xmbePT3Wu6DPdOq4ECnL5Lnf0aPpnx?=
 =?us-ascii?Q?KtoC8O3b3L2DzLtsqR9ifMWO8umY7qLwNPQljsCB8JOiEs4RwtEdddyUKuY0?=
 =?us-ascii?Q?X0Q7G8stHACAU/sWX/Hw/FRUtStoajwlRqU3hohHZTdG7isr2bR5l4xkmrti?=
 =?us-ascii?Q?XI73nGJS/QglTNstOGEnBZMDyBquUH+Jl8HxMRq7Gpvo0nx5h526wtRApIKb?=
 =?us-ascii?Q?5wvQeQDky5+JDWQ/R0zxbDYEX65oTdyZSgCAnCVm+2pqqj9Eq7EzkrYngzl3?=
 =?us-ascii?Q?Igr4rwxYHpWZKvM03iwpQRD/VSy7M6dBDNqR7s0ZL9dOCNrnf1iVKiBbe/9K?=
 =?us-ascii?Q?hKHHY44sD0Fm3XVuW/Sfps5xdTmVJDns/aKzRgaclq2PoEmvur3xwR4Uv3d2?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171919be-f0ce-4957-75cf-08da69316759
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 02:50:13.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHCNP3v3H9hEy11Jj+ffO81mdsgQQxQbKcIcAPXco8vQoUI92eRr/3mw3ywrg7bk+gfnfsMqS+7XLEcO3FrRKJIcy+X6q6jsi6fAf/F6b9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190008
X-Proofpoint-ORIG-GUID: PS9zIV8O10aPaSiYTrtoC3JnfcA9-n3L
X-Proofpoint-GUID: PS9zIV8O10aPaSiYTrtoC3JnfcA9-n3L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniil,

> UFS storage devices require bRefClkFreq attribute to be set to operate
> correctly at high speed mode. The necessary value is determined by
> what the SoC / board supports. The standard doesn't specify a method
> to query the value, so the information needs to be fed in separately.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
