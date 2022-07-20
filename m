Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE057AD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiGTBcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbiGTBby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:31:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE326F7EB;
        Tue, 19 Jul 2022 18:22:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K119fI017919;
        Wed, 20 Jul 2022 01:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=doc2d8mhpsqoRGrZVC+BXSmk1BtM5h8fQtRDiYYU6/k=;
 b=IjaskViD1RPVq4djl/TAaoMxdzuDaCA/tGhyhAwnAlomim9xdxc4+w8FU+KxCG2Q9FAH
 N9X+DgKPTEMKwaPxwsM6s3qKJgCw2rnFcAyJTx0GRUwL5MZOkVA7ZUh9oN4K9jww8k1y
 hrn4LwNg07hbjsh7FqvBxBcbdk+Y0Klej5BuhcY/nSNolqsKnuj7OY5EFm8qklIsRUkY
 NcO9wGwgqaiDjOmU8nt1K3xNKtCnAoRDwxEHWPxWx8o7VrLItNSrtLGPeTAytwmGjyba
 Hp1I33x7PuQaby3s7YDygzd4FsjKN9r3JEp4H6IQGwGmsOpk8cyQcHEaZmT6MXSDYMtu ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx105m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 01:21:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0YMxd010046;
        Wed, 20 Jul 2022 01:21:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh0dp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 01:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcV+juG4k+Daw3IRvJH+zrszV3MHppcn59jqbfhL7it9P8c1YCCcnn0driWFgebPcfpJZkIm9HIG6htHtw9Ww4WIqAkUaTVkr66+2X0ZyIZYst3zpW3mSAmZuYR7YESbSUObFqNRlLs0FnUeGFsDoy0h2TUWoY/zw2hiGcETh7wlzECV7Zazr4cqulpEX9PziZrqiNw8T76yDa/DcmCOWemXczTRbICiwKhcMfFqRUm1Md1YqCszvBbT4FJWMLbUJ5zgzbn0Fx3SHvJ3ch3L0KM15r3suZLaCiVIRLs3KZlZDIwQRrvIu5VWN+kGkbw0JHBYgESUm8lS2WYVzPGrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doc2d8mhpsqoRGrZVC+BXSmk1BtM5h8fQtRDiYYU6/k=;
 b=hGxhhz2vA876xcWgIZoWsSL0F0+xc4e6PjnOeXZnTKADSCpf35hqjMOI9L9qkAyMOfc+PbV4tDAQgPoPCy5g+e5nGbWdctD1b/XlE7YClv9e6cwu2ZqCIqKWAgk9/3a/GUq7i7RH6yr9IDxBQbvGu227H/7OWNpWen1kIQa044ZpN83FBa2ZPlcWtdTy/poeltToENFB291kvP8KRlxMGhzFe4H1TaLct8QM6UrpgpCNwxvGkjRfd4cD96uYxfVY4fFDmo18D01zkdhqu87R58cBXK1f9aIz/o+mga67faChZxuODPASQU6AQguGVC0MrEKvcezVpBqieuP4XdUZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doc2d8mhpsqoRGrZVC+BXSmk1BtM5h8fQtRDiYYU6/k=;
 b=UQIUz0XnENhkhQySVtcBJosnpLbjvnDm6L824JoCTm6R1l+m8aOYO0R5xugxkdN6ZLJzgHGk60l2X0NtsD3jk9lIvrKRrayzU20HAI8Jn0ulSb0UAJV4OXNnaKo9CCA6nyHVBDhE8zFV08KwylK8sAiPT710C+iAAgv/riX3AMU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3052.namprd10.prod.outlook.com (2603:10b6:5:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 01:21:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 01:21:45 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH] scsi: sd: Add a comment about limiting max_sectors to
 shost optimal limit
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgh4mvem.fsf@ca-mkp.ca.oracle.com>
References: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 19 Jul 2022 21:21:42 -0400
In-Reply-To: <1658224264-49972-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 19 Jul 2022 17:51:04 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef98f886-b189-4173-e717-08da69ee358d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCdMnJNqkUEuuO3gIFPKUsBITL9EDRsM53FMnvj2GvXEP9zAp9ikmkwrwJx0pPYwCcgSEkSnlT/1nBQJxR/lpekCn2EYiLauG2ST2Xo0z/eDUVcSrfBPLAoWJ69PcpgLCkzWLQoXcOgF5F1oKvdj5rf6A5LQkmALHOxZd88KyxlXBgbeOuPw+rXzihLFdhPm5WevoozFv1SHeUhXN05COz6MZxFGfIfGB9mrM4O7fivswvknuT72RK8tKDLjz0mC0Wg4HmSRrwCqzzueHkkz8fpFR5NeZ+w3mt9rP3JKcUMnHeXYlggxlKnuuNfr0q8fjmlQpAirQNPC/FUV2fG3CY+nX82o/ekE3dKtzE2T8WiLofjYleUgvlZ1YgrIRYAkWEnYiIHQsP6UWHlgvQwOQQ+XTqUkbzwOeNp/CPCEqNFTdO2lMHpxLM1HkGoPAObFvsb1OX6KKMx15rGvhQXsZgTJcmTi1jYZfvW5kEiSeGFFJHVz8YZXmFUD4uMny5jn0tAQBW2Yqzi7ulTl2OdNUK8TfLRxDjohVsLx2zwUxB9VlRat8sHhq/Aec5wrn76kL6Xh2+L+TCi2KHzoa+wgI6KJG85h2By/1Vbphx108MBm018VMyWrs7vPl2ax2k1rgMQXt7072PTjX0pbsStimG/vkcTTFPJYL+hP85FDDwhBR80j25TjRG1BfFLlf4DsDWvuVQe7+LlKbM+jYq0P+Nb6vWr4RtfnHa2lkx1xE7dHSE0vX/MLce6SEDsHd/s/8q3/0kVsn7R+CSstcNLS6kNfDCo5N9uQfnD9gVYCpOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(396003)(366004)(6666004)(478600001)(41300700001)(83380400001)(36916002)(2906002)(558084003)(86362001)(6512007)(26005)(52116002)(6506007)(5660300002)(8936002)(6486002)(186003)(316002)(38100700002)(38350700002)(6916009)(4326008)(8676002)(66476007)(66946007)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ge/I3ET6Guu0VHbYGRicIsgJZfNRFR8EgTD52rCWhvXk6WaL28vJretam1tO?=
 =?us-ascii?Q?aYhQV42swGOAJaBHckgTLxM4zagH9VpQnA9PA796HBLd6zgYbav3yO1fGJbp?=
 =?us-ascii?Q?pocAMACqPOWqUUmQLK6wwvAKyAcmj1HwzIsVyKrAcHp/SGPTuyDjKJLKr5zJ?=
 =?us-ascii?Q?Pagdcm/Jq0eEzPlWDcT82l1MlsuentB7ctqB+o13jsvN9ZxNVSoiXvKllNi4?=
 =?us-ascii?Q?DOH5s8bAxv7HW3sVXsxKlylStR+N+HIYCL1QVZ7VaTGU7urp9UVwwlJJGuk+?=
 =?us-ascii?Q?edADPHcGPBXBgJ91RmaiJghtRchDmyfjx/BrDFiWLnXKCVCYvOjmNjG4qgjs?=
 =?us-ascii?Q?KjHWm8KMxGf/8dE2QzQQZuPdnMqYDQABYdLGQICT1BiJzuvJReHy24qzWtg2?=
 =?us-ascii?Q?HFN4ltnC7w+CpUrqiZ3sWZmw72GSuL9qM5Wx09hmmEEOXnIBnZq1OxVuGLIg?=
 =?us-ascii?Q?Y6u+mciU1SaiPQRf9X9Wy58nC+an4SfDZJU5mxBqZcrQk8aa2Aej4pDlE2VL?=
 =?us-ascii?Q?WzzelhFCZ7jSTMYsGCBkAMVtXOx53bjlc9tO8EFnULlLj1GKNNGUsXk5I7SR?=
 =?us-ascii?Q?w6QISXBRZ3lNhTprGVS5Bx0DI7pAWgWgDuSgCyAWtMfftzJopY51xVFZc+0i?=
 =?us-ascii?Q?BdrrN8fqjUEAlQLsTWjygLDs1nQ68dsXmkUPDeN8DPykN46OjYKLLKEQoxtg?=
 =?us-ascii?Q?Q6sfGxJq4CvtcMvb8iC+2lSaDBYs5m/97YAK4XsJWmlfqW1cEWd+I8pMOmX5?=
 =?us-ascii?Q?jWGqxBLG7MisdEUbv6JEz14GghfXfYinNQxAndDR6s35yJLWiI/uesWX2Pap?=
 =?us-ascii?Q?h2gDQIpBUHjGydeHXe1LT3tsV1KrYUuNgLVtvxQwDs6/ehyNMRSTaDfC2/Dj?=
 =?us-ascii?Q?GCWZEKjnZ8sNLMVdkdjPLrpOcpb3lYhOMBKmdjP6ETOIRfE+AjCgpUHgGSs6?=
 =?us-ascii?Q?SBZdkV2ZwZ4IP8ouGpzHn9Hi5MrPpxNIn5gWtJAfuVDU7cLN3GZW4XarjN/b?=
 =?us-ascii?Q?tusLPzJ4ZsmOO6TWzj3yeDryngNn0ASdME/ZFE/174VBiRlBOp7qAEejCLOk?=
 =?us-ascii?Q?quO5pP6/ra5rmlF+NN/+b4zD30RRWVqu7Xj2/JZLgqrMuAeiP2iuPP+ysBTv?=
 =?us-ascii?Q?fcDBEJM6UYR2CaltCpYgL1T2goNOzplaWBFJ0JM0vfNgUyMa/uGml80bBQ4M?=
 =?us-ascii?Q?g2flN9Df2hd8zTJMLKaIeCyQKfi5e5y86H189+NXfDnPHQg2exmjbW1fRQYz?=
 =?us-ascii?Q?aIbwJ4I7irp26+OQgyHjWwEJaPtP5BayBnP5u0H7/CYPtlIwupkTXFYznIof?=
 =?us-ascii?Q?lfzqKH6G5DL/Z3hEQF/erK37zXyl0B8PyrjUZ6faDkhsobqPeuJ4cEnaYcE0?=
 =?us-ascii?Q?CEUll3yAKas9bFjpW0XSGpvLWD5nrzkDYBI9Tl5qCOCZCx9szg+5ny4jGUwo?=
 =?us-ascii?Q?zC3IBX00rtz5UFIp8bQB1fopLxDk7kjbecGjyklZgeDwr5WK5Z4RyoidvOwR?=
 =?us-ascii?Q?2D4BAKIP7boU/xykjzYMYD3FCqTXFmFLbdPxYHIR5zguryEqWWHua9ASUbiT?=
 =?us-ascii?Q?rpjFAgI3zbld/G818W+o9He6+kMfpCiugJlVlJGTUaNYWHJDdEcV7hKlp8Z6?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef98f886-b189-4173-e717-08da69ee358d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 01:21:44.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Sw8iZsuuT+fpi1iiYTmyU6lh+VasXXfuQyiNgAQYUAhnNXANJ0Yi+F78Im9HezRxBOFCjBzCqly+qotETlEMfGwPuOmmvT2HDlqctL8mlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200003
X-Proofpoint-GUID: IMq5UYxV1mzw6CpTMPLJ8XwZq2DSjPA2
X-Proofpoint-ORIG-GUID: IMq5UYxV1mzw6CpTMPLJ8XwZq2DSjPA2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Add a comment about limiting the default the SCSI disk request_queue
> max_sectors initial value to that of the SCSI host optimal sectors limit.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
