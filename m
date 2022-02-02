Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46A4A6AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiBBEj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:39:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37396 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242010AbiBBEjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:39:25 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212068Li022144;
        Wed, 2 Feb 2022 04:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=csrS+M/Injb0+3Ws/oxyQawk+rx2efWHaw8z9GNOoT0=;
 b=eGEFsOGirzBMQmXqq/LD9vPuXEBEXbB3xzAl5lo6kNPK9xMvl1U6wwre5zGGbxXucotB
 de03z6IxdwsROSf3t0gQwJWJoHZ2jTpIVB2vFQAkjJ8QG9dIpsncmsnk913PdzAs6HD0
 90zgw0kjbNxB876lATrKbGwcgEnFOUuloyTGV23+LNOeaiLvxAoOfovJ6/Lw/hT2lUVf
 C3gN1XJEU8ATGJZMMkT/lwlqSC3UZbrGCKHOkBpeX9NjSvTTFa5vbmYSmxkrmt7vkQK2
 7Y22u3VaTOho0uYbrUS3QVObrixpOWp1HYJfUz3avAqvfvIei7HtkOoc5EK6X81kiWqV gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2mbmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:39:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124VdQ8091868;
        Wed, 2 Feb 2022 04:39:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by userp3020.oracle.com with ESMTP id 3dvy1rcn74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHFnZHYH04tVirlkhF6S0eFOkpEtsuaypjKOPMb/va7loYnujQZkVKh2nMw7BJtG8H4z99SrXqQ+5khtKqRUVLAZ/flOrH51Sc3l7hEIWRFHr3c1XATlthAQSdUI3/5seqDchkG32CTI4jyK8OqiEnVVKo0HTq7ZK8d+ocDpoTwoEf5cD0/p/fLGrS4dg3UhjStLXyfn3Dn+xI8gxc5z+T4KtGSvHiVAyBRWwAyHrtx7B+h3+vpiBXovGRCWRNIh0/8V6bXNqOyEcugAQoScNe57IqHmIweI7dMNh540A8vR9SBL4gh575ccwHSy+iMgQghmLkwzIo3sB/YBlpkwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csrS+M/Injb0+3Ws/oxyQawk+rx2efWHaw8z9GNOoT0=;
 b=YbKjnQi8rZTiXC/b5rYV42pMXayQvZ3QAwkbjmRW0nTpK6QbwXXwHnUP3yhfL0S13TOiUxUcobRknspmKWk9JjHbExpVlREa/dE1cMa/hoBmuxZRqfO9+/HICXVoz5zqbPt0L6VVovBIdyylRsyspRIAx2eg5dejYRhLSkvhDbJ0p57EYikMrfLiBtEU/INfgRXjQy4OXyke3sKVN0KGRY9GkeNaMZTLS/ksfG1m733JYYyaMlAVZhIYnR7xMZUmcVxmqQdeSEwOuvypVpdgmt8PvR7sufnS1PJRXhXJxu629b4PEG5pxC86Tkj/w67hqc0JQjhPycmStkTPLh+dtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csrS+M/Injb0+3Ws/oxyQawk+rx2efWHaw8z9GNOoT0=;
 b=hiUl8eXcm+rU2laI2P+c35TFoVyMoE6a9qkCnlWNrUOAkTs11MFN8z/96AhdZTCpuVtS8l7FpxuBMkeNeh2gEoM1c0UN+R56FryHrdXio2y8JLkCvP2OO6YmM5FEyoPsk5yPTKzYAaiQrLAYDUcrfZSmP9ufm8cpEEvci72G+jc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO6PR10MB5651.namprd10.prod.outlook.com (2603:10b6:303:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 04:39:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:39:13 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 2/7] nvme: allow integrity on extended metadata formats
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o83p51cu.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-3-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:39:11 -0500
In-Reply-To: <20220201190128.3075065-3-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:23 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d17cac3-1f25-4ebe-39da-08d9e605f6a2
X-MS-TrafficTypeDiagnostic: CO6PR10MB5651:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB56516632F4F16A273DFD64348E279@CO6PR10MB5651.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh77APNpkHKThlOqIhtnzoS3oZg45A0uMRrExpo65TKuB7XU4UtM1ocJzJ2RGPMaH8Ic8ZaMeGbgTQtfMhkellBx5MGS2b50mbUQRlcSP5mo+4ia6/Ek4j3KgKvRTstsvZbTiovys8DvpgQzl3ldoKSLjAbFMuy8NYpU6nXT3EcoBCCzF+IlBg/vVlYtrE6myPiAE5gtxdh9kqYgcgfFEEIacF7TzBo4BFWMjn99GzgXvmwK8UMx8O8YDF4oh2hyQpvadS0TtbykP+4eXczAfvUYReFzuyqwvAE7ES/j+O4asC9As/jPze+GXafLTbLEAt/9ixCtzYZhHOLpbMCtK0sFiyUjIhXBoXW5OWJUhK5S0IO0BpW4q+RuPDNMorXJLUPY+yiRLQDOYveYbLUA5Y94Nm+oZuhN6REoAxM7OPs4q0IbkO2EKO1X09DAU2vXIGccZwRlvaY7HwS7fUXIy+MDBzFZggAf1fh3aY7e9rlkGfHkHnCNyG2B3S9M4jAPq9Apk81eqXdRqFaxGSkbGpFvhj9IouQOEsj1EIfUtnfrgUNRmWEXlZWi8qZVGEXIbQt6eFzOpgEcWyHD58sC0RCRdSVtqM7TmNE3esg0azOl9r001C3BwIBiAbW9z3F4Yr7VWnWvp2pzcsD47792DOULHjXUnpoflY0xAgQLe6fFKO892gBJK9tWCrw2zJtbkkZkhxh7xgjvuHzO+G38KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(52116002)(26005)(86362001)(8676002)(6486002)(4744005)(66556008)(4326008)(2906002)(186003)(83380400001)(5660300002)(8936002)(66946007)(66476007)(6506007)(38100700002)(6916009)(38350700002)(6512007)(36916002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PqxgdEpQHO0+fAa5fYOrVAW6njurqidwj3Tnzs19J6+oFuW2EamaJrTTDeYD?=
 =?us-ascii?Q?C5RxHfCVG3WXeMUmQxiXOdLKLzUBpp4q0+bLA94+w56l+Z46JC+C9fcGtSE/?=
 =?us-ascii?Q?zplsi6c61eWE0xb+8SVtegcfGctDatx14ASopO4G+78S1z2xMkz776K5ZI1v?=
 =?us-ascii?Q?wpRQ1w7pISqJVIiZih4p96pFYR/ucZrIRbCYIW4stVbC5caWClJubRjwPps0?=
 =?us-ascii?Q?xWCaYLLBCpTXQJQFiKXDnBPZzI1eoir1mNQ1Y1k7fMz2BcR+81u05YQzG7M2?=
 =?us-ascii?Q?V/W1tmjg6T0xDgBS/PHGeA+XtaRQivAzIR5ksOs3SgvkB23yilMxvM34jZti?=
 =?us-ascii?Q?c99PjlwwAAxeUKf/gorGyDwx71C5loHbSy9jX99ArNmeLMHgV41IYIBfOfWF?=
 =?us-ascii?Q?Jyzo+GuJRa3cJg1st120t8hhGGseQGFCTIOSlwUr8AjvsiHhpKaVs3x/fTav?=
 =?us-ascii?Q?Znmz5quseTxTodTXm8bpYbFDwHBYVKbAoHNxjHGK2lSM01J0g75UijyGi/ZK?=
 =?us-ascii?Q?5KG54ZUeNyIUUGia+YELft9yXtGSDk0N8AzQM/E/l7hqlYKA6wqRKPcH+hYC?=
 =?us-ascii?Q?snr09s95AqitSunst0daRLG24rD5qI+ECCYAXN+4ocRNW5EbF5dfkYCibFoL?=
 =?us-ascii?Q?mqFsjrlfmNr+XNEAhj10E2Ko6HWC7KdpmzkP853NDtP1zPCuMNyboQMIsVvL?=
 =?us-ascii?Q?ybPelBE0MFtGYL4UlNbtEbiSDhcDlON8DAfEABG7qAUDtHnNdb44L+aqdx78?=
 =?us-ascii?Q?nZwQ1CliQoC2n5T74ynMv4ruts7Q6CatDFmZNOBEWA2MTSwQd2F4+Q0BoU76?=
 =?us-ascii?Q?/mlhu811RKjVa0V7TaOmm4LXcffbkYw5rO8BqLH2XfadkCRhVAiv4Jb4SyuC?=
 =?us-ascii?Q?il5q/vKDHFe37uAsRQD8sDb3N9wJvRLaI+rIkbeZFBr0FWyfHMLgQN1La+PZ?=
 =?us-ascii?Q?hcxi9ev4pUBiJjin6GqWau84qeJhYC/0XRaIXrzFcflqFdxP68P1g13eMYUF?=
 =?us-ascii?Q?ykyp3ar0He/gtF7fk6N5f58tGqjXaU0MIXscPRD0DivQKw95Zbyboob6a3b9?=
 =?us-ascii?Q?xTb5p4YqyVbIaFyOn1/jeJLQ2FpX+RZARsYF8uL135gQTtE4IUs8Y8oyvg4l?=
 =?us-ascii?Q?4QTaGzKCgK6evXhpqoWwKfXLxDRmHlDws/keINkHRk0khcWOTdadh5sKpgc4?=
 =?us-ascii?Q?ZGddQ19i/YXnoq4rgceHdLyeccWrPf3SpERXrAwfxpfTk1ZPTx2rgmq0hQMe?=
 =?us-ascii?Q?yH1Ap5NhCic4QWugCNqmbcSGTrZpqc4lBNbkVr3/O3zmTfvW4Hyzo57+LEc/?=
 =?us-ascii?Q?Wc0mx1Cuvou09XnP3k6oJEe12qAJmiwLezyrqHARLK+RAh99hIKrs8Nw77yQ?=
 =?us-ascii?Q?A12701O7C1PtBDtcmkNJ4kOLDPVrSkhi5ShNWPvC2oMTmyrb5zGi/kGgzQHn?=
 =?us-ascii?Q?7o3z0bEDExGDxT3kaeTU0YTBfyrQqO9R2q6dyp0ejc0nM/M0Tg87Q6RUNR1S?=
 =?us-ascii?Q?F76yp5+akxO5Esq6ZSPkrYVMBOc75d6SaW5CwuaM0rz4dmPXlt97Gj7tKoYb?=
 =?us-ascii?Q?fx49SxQuf0OUppHyi5a4tCS7zTNFH2xBLPSKT2EnIRWvgQUPEPCxQn3Eyneo?=
 =?us-ascii?Q?cxO8/sEVxkDR7UlqhGwwcayJxLJRztYSde+EC1qLNXI1wGGfsi24yDwu7C4P?=
 =?us-ascii?Q?b7Fdef49X0g3XGUUvUenbByMdaw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d17cac3-1f25-4ebe-39da-08d9e605f6a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:39:13.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GZQherG6DDkocgONAWNDZTRa7KBUkhF4BIu66Fbrv9LRHirUZPXWkns3iqPwXZqLH8B04iER1YCykIkKun7Ne7KK1wHfgehFCRT4Ah6ohw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5651
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=827 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020020
X-Proofpoint-GUID: gGi1CtDGBc6hwmpSKXRjvm72rPByGjm4
X-Proofpoint-ORIG-GUID: gGi1CtDGBc6hwmpSKXRjvm72rPByGjm4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> The block integrity subsystem knows how to construct protection
> information buffers with metadata beyond the protection information
> fields. Remove the driver restriction.
>
> Note, this can only work if the PI field appears first in the metadata,
> as the integrity subsystem doesn't calculate guard tags on preceding
> metadata.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
