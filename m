Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA365532119
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiEXCml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiEXCmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:42:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84103A5E5;
        Mon, 23 May 2022 19:42:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMhufe006485;
        Tue, 24 May 2022 02:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oTV71mzj3vpkFCfQLMhqeVhXnAwGLQCF7CcXXyArTVU=;
 b=rLtfSpf1OZCW6KhBtgm/d7opeRDK4vBJoG8OSoUDvig1zk5wG+ny8cu0l98cKp/1IJ48
 Un2SJd//c7NPT1Bs5En/HDkuIlcVGjwv2jdLF2AISs0ynfHOgu0UZtu3EFoZLK3aT8At
 RB4xzRohFa4rB6NjMxy4zz2EGksh+DrpyiGZemuAhYKPtRGYpugSgiwoWKue0QQmvoXB
 oKkphETxjkY6mKhbdZWMDCfozUCOmXwpANJFDgiKEnzR8HiubvrKqHm9iNvkp3s3IXyQ
 WFKSWYdwgZhFNS4GDCm6/+3OrBr4hxpuGj0eDQ1GwFYepKjBI24RQCuPzYhCFmt8nU87 og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pv256p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:42:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2fKe2022851;
        Tue, 24 May 2022 02:42:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph21bqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaMSFT//vHtHnIKsHzCP4m1qaOzAvFJa6L9qNGotBDZdlj6TiT8P3wmnmQBpgLCSxXKY0tkE9Qm3KgQDm245jaXfEt1au5Br7iTwDBLyFZgbgyRIC1PvUMG2oo9EG4rsGOnDjJbLytpmJG5eyEXn9lVNhhPZqy4f3qLc9Xoz06Mqig8beYne0HupETdpxvo7QFTNTNNkyBWP1YqbNKDf7V0/a8i+AgwHUujUkHzBPnXwvAyPPXPwvbnzj8/zGX7KG6cl1SNRp6Hz4INt8aE9T5wC1xOVAJkLvH/b2gVoBHXrHQo83AorNuMaAMU+Q7BvTxQiALKM2lD6t+nySjLH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTV71mzj3vpkFCfQLMhqeVhXnAwGLQCF7CcXXyArTVU=;
 b=SgAweo11QgALPoPH3ypd6tKdZkF3VfICel3XtvRr79zhaibY7GSnQseP/5PkiczpAnnK+p4pzt9feYnnIuY/sweceKpmz+3WBfXuGPz4QFoizPU8wN1MzOhvbJ0Qn+4RWAUDUvNUTV+OOlmj0VGGsBHNJjLgIzYSQ47b9iPn1eckVwxiRkzDxXqRhTq9BK6jkLP8BR2iM5HbViAJxAElyNuv6lHyQCA1/GErhOtJR453Qwk24RniMY0PpC7UfmAfwZWO4L+aOl8XtFo4Qyh4N5WWvSaqXtL6cjN2UasEImfKCnrXVA0b4kppAeqtKM4uWRyqzqNpUwe2r5TKakcsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTV71mzj3vpkFCfQLMhqeVhXnAwGLQCF7CcXXyArTVU=;
 b=Ib5h4/3DKz20ZrE3fEq6ZiUmKm+QYnsR5G51sEc06OXmEl0cHYDGrz8WlyXE73VKVaAEggWGqJ2lEcF9rzzLE8JjsluI3YarB4QB4E0iV8yuOi5UDj4t3+IfbW7WDf4aOPmbXKLcUJKuZ4nkqr9YcHISa3w2urQ1KDwXNrLDRm0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN8PR10MB3155.namprd10.prod.outlook.com (2603:10b6:408:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 02:42:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:42:01 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
Subject: Re: [PATCH 0/4] DMA mapping changes for SCSI core
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu9firdv.fsf@ca-mkp.ca.oracle.com>
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
        <20220522131345.GB25785@lst.de>
Date:   Mon, 23 May 2022 22:41:59 -0400
In-Reply-To: <20220522131345.GB25785@lst.de> (Christoph Hellwig's message of
        "Sun, 22 May 2022 15:13:45 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eb1ba75-ad13-4233-2691-08da3d2efaf9
X-MS-TrafficTypeDiagnostic: BN8PR10MB3155:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB31557834D47154A20F03B07B8ED79@BN8PR10MB3155.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUAHBZxgQ6sV5g6w3Mcnh3uciRHQdEnodVgzMCgvwmurGo5n6xPkV5Ut9mXnI4vMocJD95Qy+ToFtJrKdKDQQlPgdD3/tretzV1tj8ag9WiqlhyRTfYQnQqX9O6TshHtUSvCvqO5ilbkTpfICNtQjhaTt4Z4e12RQTY9na2CwyYlB8W0Xkp8jm/jhVIgskG5CIwRBlwOBRS+iNAW5OKk8zneUuE9QmHUHzYQPRaKVE8s1GldAXIAQcCOl4DMSqGQQuUhrJfXtR28+y6d5OBc2DB6oPyRqS3MH2Ip9LlgChaKscJjIxE5cHXiGyi03fA58G2ZuUQWJ8VyNOnsK3D301O6V2yzGqinZbugCs42/OmI6CIBrKjRUJA4HHM0T7lCRXC8VHDF7gVNBumIkVFjaAHjjd7GGMLXbV+Ewd0MbiYifTnXEAYXjsw+lGfE9eFy1EEhYRMpiznsbWqxkEY97h8m9OnhOGd/+2LvlVQT4ufnDfhz5chYH2vI3qBA6uJmnOzGeAegmb0SekAtclTZL9CIpC864HXOqQiGPni4Cgon8t4zubBBfem46r/8pXBA1/KxQsIPNnyFMcRT2UhZS1FIh9S3e4rljQvBlOxblTFY5ipzN7/Lv66tJ7qFRuPgz4ugi5Qb1BP0QlGi4hPoowyXe7zs6SWK4txFLUObcQSxm6PgkQBO41x9AgcIpMf9W8CU7wlNhxNUt5K5yoQ2YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36916002)(52116002)(6506007)(8936002)(7416002)(5660300002)(558084003)(2906002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(6486002)(38100700002)(38350700002)(26005)(6512007)(186003)(6916009)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7kHgKzT5EoTQjtLXCx99FOmMg1r7CpzJtcQeLqFrnmM7xy9ZfKWsBhBLfVGU?=
 =?us-ascii?Q?h5iAdWG58KfCgxJejlv2X6o4JbI26/u8Mu/UKrlrdoC80IplilxqQ7joYm3m?=
 =?us-ascii?Q?4bvexUePevKvC7eDznnBtHhM9t8V8nQEyWcDN8pKp12HVNWzi7OLkiQGdIvc?=
 =?us-ascii?Q?aFPCx9HgQNb7XB3E3unvSVKvQNLrmoVGnaCTZi1PLrLIoxdyYsvvF1l7SyCh?=
 =?us-ascii?Q?dooiIFhBfYEq6KnCsWvPNtuds/AMYGM8pSLNCkwjKzIfwfF9J90lCUmz+wxe?=
 =?us-ascii?Q?wLU1UHcRHaDU9DUYWli4L7fBL8lay6nA/QNrYiLLzZXJW2By+ux4xC48pW52?=
 =?us-ascii?Q?ryL3bTZqgWb+dEIvVD390yTVoCaugrpLPJcPbw+FOsaycrCm9JgrtCGRg0SO?=
 =?us-ascii?Q?uqLku2+Dpbq8BARv7Gt9WN25lXWUQXDhJQrtMiqSXMaQ65t5VbeYsgTgVTHz?=
 =?us-ascii?Q?ZKBI3O/BOqmi4Sam+NpiQgN2PZokcPcuJxjk2fhOgIzSP2de/iaHc2BhbJGK?=
 =?us-ascii?Q?xwr5x0OVVRYdAXCJX076srsBCtmL2EC/C3w+sAXSbLkEFR0cL5Ahnriv/0gO?=
 =?us-ascii?Q?T1AEFw/OlxSuOrIT1WKUV0GemLtz0IE3X+V+p36QF7vUgbTH1d5tmGaBAcw3?=
 =?us-ascii?Q?uCP+qfjSM4Y+dTURqfyKJmmbxH8syajKs0q8gYZ3E3OMEV6eT9+fQIpx8MNU?=
 =?us-ascii?Q?Qa6NjE9bJqII95O4B62+sLLUfKWfHWJRx93z66ZjH8mbztAv84SRfOjdtxii?=
 =?us-ascii?Q?tWCzakNP+zXRQv2YJDwGpjX8Coj6H2mu+bmaMvhCfGTIoN6qQJ3IxaCs/ja9?=
 =?us-ascii?Q?WN/Gk02PkUocpzS/Ueam5ULlyt37AUPIGWCvVGn1igVHgKh8FP0IXZ/4FGlx?=
 =?us-ascii?Q?RvJ7rb/46r0iU0L2gmez2rVtE3Engtka0qwz03Bp/Jm+SAXfMoN+d3z7kfc0?=
 =?us-ascii?Q?8cw3fnzFhem5S6cP6vmIYeN/kRGKCcrxrX22HdZMVxKPXiMfXUI3EmEDuIEq?=
 =?us-ascii?Q?my1EJOD4vn02JFkNvejKxo0K1UNq4mtIqaphCd1DFTcueaAM6VuiigWFK447?=
 =?us-ascii?Q?tdzoksIG3nwZ/kd/L1oiWQY1Xe3WlWoBKxg/xO1cDeZfY2TLuZ27JrbzUnJz?=
 =?us-ascii?Q?CUp61w2mHhoohGAI28UvYu0JmvJ5P05xUb4XqBZeXNse0AwZ839PT6nYKOjZ?=
 =?us-ascii?Q?m0Fn2Ov3CSY7djxbJ/fTHh0lT7r1Z8nTDfwclgpgeBItrqcL0lMLLmJ13Svm?=
 =?us-ascii?Q?ZIozgmbgBPjik1Ey71w9oAVfUOxJ0rlriP/zG3vJLBsIGflw0NqZgZQG1y0e?=
 =?us-ascii?Q?YNmp/gdvXa3MemmNCC2BISEJkU5JPz9vsl7rKdFmxttt7hOkuTm8h0fOx3bH?=
 =?us-ascii?Q?tT0UVBjVQPEi8WeDeMpin2xewP9mo+jqUxedTV6dQ+9jnWoSGUKIAZcXH1z8?=
 =?us-ascii?Q?d+jFYik86rWJNky3aAX5JXkWv00YTL6vnqgaStEXlnc9GWb0W/1F5G6fycKE?=
 =?us-ascii?Q?PL+eG/Be9dgXVA6EtwRqzwRDn0ydP/g7lhfLe2yVh1NkbpJs4kNfiTWmy5yX?=
 =?us-ascii?Q?wE56IDxLEiy8eEfpauCsHAdCeqTfMV2VGChPgu7lUxZDp2Fz5iaR82GUzN+8?=
 =?us-ascii?Q?Bp8ASaTCKy+achkf96d0xfmM031ehwb4eKmd7q2PgAG2oL/NhS/ViLBmihCr?=
 =?us-ascii?Q?Yx/Kuv6BK9acEVn61ZzO8kDFt1kczR5plxIaouVjCF/j1UmwL36//Ql3VhPc?=
 =?us-ascii?Q?zH+vjhN+WnCZCPOob6O35raqX8VqAaY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb1ba75-ad13-4233-2691-08da3d2efaf9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:42:01.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0eTWCkoLhq/BRnFOWTEDMHEt4XT4xRGWLshtMPimyJW/MnFV1fmXUQ9Mbtx47Bb8FpfOkYgJpcD4nLOitaRWWB4wp6TlA3yuaOHJ7c5JrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3155
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_10:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240012
X-Proofpoint-GUID: PoQRiLxp8MW2fbHfoUUw7G619aac8lJY
X-Proofpoint-ORIG-GUID: PoQRiLxp8MW2fbHfoUUw7G619aac8lJY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

> The whole series looks fine to me.  I'll happily queue it up in the
> dma-mapping tree if the SCSI and ATA maintainers are ok with that.

Works for me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
