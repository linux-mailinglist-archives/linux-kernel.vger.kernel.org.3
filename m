Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3556AD10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiGGU5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiGGU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:57:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27D2F03B;
        Thu,  7 Jul 2022 13:57:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCTdm026380;
        Thu, 7 Jul 2022 20:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bafqSdPEybs/KXT8iS+H6dv9oFB39WPBn7e41fDxGOM=;
 b=ifDGKsKNsQK740S6gkQpG3w//ajdK2E4SQMukBUYtq1x+6DnK82S0tDpl+jwojfmDsBB
 mFwMa5f/55uFeXRl3zofzMcB4czccLyw1eppfl6Oh8NsVUtyaRQVi22AuaYeObx5LIJn
 ywDWno7BccXyZ+cqRZDYRoKn/7OKbdk8hA0rHF/l0qt9dBjZAi4dEzPToFjn97M6y9ms
 wF3l55+6OJWIeYSdAGUfAHOLdpAV4FLVxwx7eKLETby/iv3Lhgqkd/J2xClb6SVcGSAr
 NvA4St8iBBRQL+bWON/KvpfysajdwYtQccUdI3A7k9UbaGwy2SkT2K+KRBl4guzVaYJL 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubypdd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 20:57:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267KVVQ3030482;
        Thu, 7 Jul 2022 20:57:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud65yhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 20:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIP1m5z8korLvcB7Tip7SQyqCHwD1+HwPQCiBdd9ef76taPIdfjpyzu3ikDqro2GUBv/7vJONk/xm3Qb+psjFTZxaqWZAo+hQpl+lX79vaezSipm8ZuGjmkL7QQjrV2LDyIv7pRmuRKW/SVm8Kx5aiM/UKLhdYhtgc5gSZ8/1fVIk1sifsjGoMXhUnqg4TqRIA0wErIgMj2PmH9hBF+KyyOS70VF40XCTcfKkcIHY8+VWAjMZ9ISc+vRCpfP9P9WO5QRLCVOrskY5abfD7M7tZ2hdxDvOMt7hSj42AQEruhW9UueB9nbjIm9xeplvoALe+HT7dF+nTnxJ8U3kft5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bafqSdPEybs/KXT8iS+H6dv9oFB39WPBn7e41fDxGOM=;
 b=A6XB81nhTYQv0e0tfjwEU5J3huxCusxZn8omEFQZjq0g9XbW3qYhOAx7S32/TB8Tw35oLmzeenrv8ttHHziqSRHXaNWNdeJ9dAnJW8osPQ9XxkN5p2CRnsCihZOxPeIZPpnDIzw73XT0pW0D436yF8h1YkiEnkesyYOdCHZgJ8miG1eqGyJzooHOOwpaS1AABLwznyVGe/Ui1iLD8fZjYNzXhAN2+EP+4bS5RXtdfRbgo4cpX6Hl+Z8UJP6jVn04vNH1ZHv/laKLuT/UgtRXrbe+X3vj7SKkBziFOM2GtDKuDYIdBa4Tkj/ZARM4YFoZ9rtIYhkfUacG7g9gZEXmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bafqSdPEybs/KXT8iS+H6dv9oFB39WPBn7e41fDxGOM=;
 b=B3ienAEyqylVAJ7E4KmJn+irJZ6HSHYwWdh7Ovy/+zXanhb3aF4K+QsKF4QQvQLr5TTNmLIRf3yowa2JbUfVsTDCadm0C9nE/i3tMj9D2FENG6Mk8MoR0JoztlhUdKgTYIfAQ802oWcXE1HSqasiOU7F7SaMd6/QJIYm8OSdfj0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 20:57:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 20:57:35 +0000
To:     lizhijian@fujitsu.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH] scsi: Shorten too long warning messages
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yk87ia5.fsf@ca-mkp.ca.oracle.com>
References: <20220630024516.1571209-1-lizhijian@fujitsu.com>
Date:   Thu, 07 Jul 2022 16:57:30 -0400
In-Reply-To: <20220630024516.1571209-1-lizhijian@fujitsu.com>
        (lizhijian@fujitsu.com's message of "Thu, 30 Jun 2022 02:38:11 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25393932-26be-46a4-a939-08da605b5144
X-MS-TrafficTypeDiagnostic: IA1PR10MB6170:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYbo89Uq8tLpFgEFJ+BhRnKcTdjNVNkJQgzpPY5q9FN4L6w/sQIwRs4mLGacBMLWfgtFVnEQQIAPiCcO9N6RYw2dbuIfTnkZlePwkRQg7p0DispDSQe2VdANXEgZrFVTHRMhVEJa126nUUsddgBxz/FaU+wJNlLQqvz48mYWPVGJgDodWr+LrSBSDHW0A7+I0okE4+LaFY8c8lyNolx2fvJQoMMZkN5cP4pogPJN0N0zZ0iJCw3PGUfQGlyvzZHKcAk2uKrSSyy/msARd1zZIwL47fqRZNEOseygvWH8qwiymvgLAZD296Y3RbpTJkVvlFlQzpaYss/P+/qGmPuqq0Wav46ZDARzTFXpEgnVAbxOu5d7vItwaSBbeImY2FK0uKgOqp0Ug9+OpvBvwxie1A1XyFk8pMGexx6vkFKq4Ry4SfLXeAvADIN8Oi+a8Q9ZqBj92Q1IxmucsRvYwlb4IWVgdVmvafzFOkAtuHBMTuYP2aSc65FBlYFhYZOUTGfOC7NgPogMI+YAiTRDXNCLb/M2bTPHxi74p2x5chChKlVDFnbocxytxx+dqqgkPrtABzTsrILwCPJ/534J6JJGc0816zWggN42exL78jgoyOJB4ndOmKvqU4SZpGuioXFlZmlNLPAw6H0CRW3iXNkN4EZEow5l7/DwqAWBRZfMWCJEePS9l9KMvIRCMtv9/yn+3DQyuGmn1BoQghfGMK5jwGN2Fag3lOU9XjjMQtt3CkxHB5EPDt55rWv/ERugnFeDe+dMznHToCpfPFPRmd/wVUvziDt0216jrYzC0/e6bQ5YqxbW6F/tvKGbQSVigCPX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(2906002)(6486002)(478600001)(15650500001)(38100700002)(38350700002)(4326008)(66476007)(8676002)(316002)(66556008)(66946007)(6512007)(26005)(4744005)(5660300002)(52116002)(36916002)(41300700001)(6916009)(6506007)(8936002)(6666004)(54906003)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xZ3rWHt01TuVQCDjWucUgnxpPRukz5MdouFd6IZjc01DlCKq4vETbCEj+1hd?=
 =?us-ascii?Q?NZWn4bMycYIWotLqYK1CpykCEl0FNeRMsxVhPHEx72J3dc4XNYCcvupNkl/w?=
 =?us-ascii?Q?IkBqiHZeFQCiaEx9JhPHAk0jkKL9D6KsNJQj+ZzrrL7CgVhwdiWImv/S8VCv?=
 =?us-ascii?Q?XLHdb73GySXW5VP4Rxla8BveYP3SkgeOhbPQLZPJtFNYwMgQRLqGQcmrYyUq?=
 =?us-ascii?Q?NOwkg0Gon2v+7lVMtLaYb0edWqWNr17LNnyNCpGbtWSDZZP8Q0qmzrI3Pb2p?=
 =?us-ascii?Q?4WksOQwtyF8FUa4Qg59nhyvTSJ6upaui0z3ZistFj3TgEvqQRhDU4MMMJQVv?=
 =?us-ascii?Q?uBlmPSJ35jmQi+MgG3OfJKLgNEYByd/kYJThbSzuHnpGf/SC8GW7sbVQQrcE?=
 =?us-ascii?Q?tIiXYg7XsPNF1UAI7MXgtF87ZqrwZAvhJdZyxBCEuOLPZ+bNpOd/AlyIuQHr?=
 =?us-ascii?Q?fqOK9oe5+fNpTamDQJ7muHza4rJsT5CJ9mAVeDtLNftC4BkGgKWCngufG7Wo?=
 =?us-ascii?Q?/eLKtQuzn1w5DSSu07Qds9CHhX8RbycXKvtU8OfsrhzHXqov6JHztUKcNZBH?=
 =?us-ascii?Q?Wofy4zHPIKdYKX4g8NgqscbSJICgZXll11KbEJSWUwG9twws3GxnhSKiH+SV?=
 =?us-ascii?Q?4VHyobvnCE6oA/K4MscW/iySEKgl/GTq8fw3vAt5y6Fs8o04p2iJ3ya6R1iZ?=
 =?us-ascii?Q?yB2UFXMUs4BWzn18Zj3nBNNsVZFUAZiAWnGOfjDGNp3BTULlShHy7kKRM097?=
 =?us-ascii?Q?sYexnL7qMtobnLVbDh4xCHDQznnvYyAPwWaDuR2YKNMHTzZjUv5H6G0FTFPG?=
 =?us-ascii?Q?NKwxTvKpvKE6HUVY6RD/ScGMcxEVdPPcdD2TVr6vidc7DfrGfE7r5JkRSg63?=
 =?us-ascii?Q?OGQxz8y5nPtYW0f7tL0EstzzVesBZjQ/kIk8n6qDXKzDqsVraXS/xg8k130E?=
 =?us-ascii?Q?RPjLfSXpQnaSYlgHA1M9ZMR6DeqTuilMZwcaSdGCJ5cfCyEmfd1M7Aa9WBS3?=
 =?us-ascii?Q?8hrhIoqe2nipQnSRp2ZOJ8ZYQtPH6fEWYB2lelkEBIi5b7hQvBHLk+41v5Qj?=
 =?us-ascii?Q?BLfTu16TaYcKw4ei8fo+b/Y48l6x+GOkxDYwirRsYu58NvHpLSahJIidOxrM?=
 =?us-ascii?Q?rhKFCS0mOrQgfJACrki1DccK2YuRKAfmnSn1sswi0VLwD11PIN33lfXc8iKW?=
 =?us-ascii?Q?0L9Erk8/g4MjRpNlms/K7ZfClc4F6PQksOpQ0D2XKTQsX5zpskQXt3EUi5xM?=
 =?us-ascii?Q?fHCH8wBjvpwjI7M5Z9tc1mm6A9lS8vbbexZf+CpJcH8yT5muSpy/ESxHt+uc?=
 =?us-ascii?Q?FgaLnees1gw7w2FrHuz5HMi5mip7fmCS8+KO9afWrbfsJY3kWHnE7bnJXR/v?=
 =?us-ascii?Q?myw3NKZ/psG811v7aRkjgYB2pcb4gNuZPRIWupvBLxcJNoef5kQ+GuHIqc/8?=
 =?us-ascii?Q?B4WSrtCNt6oyliXrE1aHS8KtnkWo6GCiNpjuf/+XZAt2MjX4GhgzfyPNpKdH?=
 =?us-ascii?Q?5ARfgJxJXKwMn1f8LqvuIcD0YGnos14ByBnBDYhy5ypczCiVo+jZhliB5ZsS?=
 =?us-ascii?Q?UCXzMkf8q5NUuM7gxkQm5ACt9se6iujB6bNhcN6bNgWmRCLCn3GS+2vVLS2i?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25393932-26be-46a4-a939-08da605b5144
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 20:57:34.9653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtuOGfBALQ79/FNqKGlT766G49nTrZ90Sn2OvyaBOMFnr0zRn/MnkhBm/7GoxeC1pb4QqcHqdpHW9CGsZ0w5BfY7R5cDxB9yd0OZsE0njIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_17:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=674 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070082
X-Proofpoint-GUID: _zgl6ITDkZ4td3hQl-sHxYiWS3Fk-ZSA
X-Proofpoint-ORIG-GUID: _zgl6ITDkZ4td3hQl-sHxYiWS3Fk-ZSA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> sdev_printk will only accept messages less than 128 bytes. So shorten
> the messages exceeding 128 bytes avoid getting a incomplete sentence like:
> [ 475.156955] sd 9:0:0:0: Warning! Received an indication that the LUN
> assignments on this target have changed. The Linux SCSI layer does not
> automatical

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
