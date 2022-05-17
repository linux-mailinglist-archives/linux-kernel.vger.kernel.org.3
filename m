Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7F5296F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiEQBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiEQBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:51:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F3628E2C;
        Mon, 16 May 2022 18:51:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKnXYu019520;
        Tue, 17 May 2022 01:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1A8TBJTP6ndxGg4dRRs7oJvrIDM5adSeHZyD5wG156o=;
 b=hdmfIDKuOx66AvMmrZzyry+aHOB3LZmyxeSd6EPyLRzuglWfI+rBtYfR5z7AOJ3X6ka1
 uDtM+a2RGhFo+JUfGpvMdpDOlcfn5ptFB3t9dK+T3Xh0DSFOwhKH61cmF+TjYTagpvgB
 AKYtG1MXG42dh0i458h7ZPCaWjeclg4gXYinevf3kPNWRw3NfcTeg2JsEFg+xljJ0Uby
 ruMSFK91jjuD6s6QSVaGY2iBi291OlpBOnn2O13OysX21S1cTwaQmbK//5saHVnKX9aB
 WjUWqlIVgjoB05Tu78KEUVcZ9NuJSRCA2O5RfftBRWOSUNadbEDkatmmfo41K5roAqRY dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s4uxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 01:51:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H1jdpx038479;
        Tue, 17 May 2022 01:51:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v2a6rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 01:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hluci+2pL9zu5ap9n9ePGuHxCqAzZNsfNL0oIn74p6yOVoHv0rmsy4/lW0/rOcesfuOGEDsv6BYKC3kvj/HdDy++34VvQy/VqXAcssAo//9HPuULXelQKJhDiAM/lE+mbtqJ57INcs0pTa0GO+Vp+tm2ttAo5rtTJXfQijN95QjdmgagfBLUmozmW2KV7kNloFErOyzVM06UCk/YJZTCZStPsErpEY+hW8bbRrckjtfYF+krzkLngyO/uUCgyIZ/2Ntg/44f4UDVXyIEl7y9yBgNY8E3uc+qTx/99zTfidRm3H5xNPEEIVaV6ucpNotbP/kKJP/osJ7GWu4KrIFfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A8TBJTP6ndxGg4dRRs7oJvrIDM5adSeHZyD5wG156o=;
 b=kMa80F0Yska0nu5nhH/iFqGLW7KcAxF9WKUIQPwdLocZzPQMnlvZIfMiBiZiCHrlBqZ6uBQlsYxp6d6uXjYVNpcoVf2FrHBRvgFsGC2fHGGDEIEQBwxoDkTZvHFow7KpHiA3XPEebHGlxzxqpRLOBDNmSfqzgvPURtevRupBAkxPB9QTxGXYyK6SRJ4VFK8ezvgZzTlDPSjSZM8daC5QjNsv0Yb/dTntgK10JjylThL7+4ohhtB64nFnioWzOVqogB+OTiC4VOY27m7kt6eZwBWBzjFjlJmDYvFQbhLpi4PTW/L1+OKtnsyEPvc/I9mMEFgumSNfgwUN1PvMNj0cvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A8TBJTP6ndxGg4dRRs7oJvrIDM5adSeHZyD5wG156o=;
 b=SnOzku84aICCo7kwniWqxERPCX8KBTThhH3fhpIvF2cp4+LWwm/f9o6S24gW712VQaKpixt9YWr9dpWZh3bCN9KVCWWI/kn0CkQo7dSZCh6vNvmrYeqnCPhTZxfh3OEtU8TC33gifVU5BRpdl+j9VUJTKTN3uyDkGv3zVTarq8Q=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3853.namprd10.prod.outlook.com (2603:10b6:208:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 01:51:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 01:51:29 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 0/3] hisi_sas: A device rescan and IT nexus reset fix
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu9pq63u.fsf@ca-mkp.ca.oracle.com>
References: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 16 May 2022 21:51:27 -0400
In-Reply-To: <1652354134-171343-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 12 May 2022 19:15:31 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12a70311-ecdc-4b39-9485-08da37a7c2f4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3853:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB385373F3393582BE8A4B83208ECE9@MN2PR10MB3853.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9uzE4FQ9tLVXYJ4N4Tnk6p4dCLkMytABjjUEumWgQQdPSfIMrsGdBtpdYU4hQUyyucRl9ImyGKCYhfakrzzhDJ0G5XD9GtUD2B6VH6/x0JDdQbDPZdo+g82V+laWvOUj7hwRhfb9UMI3zGG+G8XXlHHBNcoOZ1iP5TjuqxmXHaHyvFCU/zDRh/b/J8+lKrf99Nd9T3s06TqOkYmSoPcQvKpIJVUL84zo7nnUJldi9Nfzp0i9PZw4c5PcoKlPvgy+YQfY4JCHg0fpMr6sqMu73WI5PDWP/7d1vDdQoNOhyw/vIreOC7XsuUCT+u7WsyLUV5a9K6NbFjwxVSYy6CxBHxzeXk0L1ejbWkDKmP955GDMV1HAK9bgDXqsyMtS1qJ/Jw1+XnKJ5XXU94yGshsgH+Me5788sJI+lsdivIdA35ZzCB9f9a+aKyo1hk82yU8lJWPz5HEZRLDvuwHEyNaByBZneeWRTCoG+tbCL/gWQFuh8J4ednDx9plOPfetJNJu3y1std27UAC98mGJSLxoXJQXmoVuaYtK78ADO1iBByFenwIAlWQdmTUfPSVpQeGQ+CuJjWeWPB3RVd7TncBK6MQxYHsbW/8IBkBsMtnmj1nKl1QWv/8l0zP43OvA0IJIrareARQABXykmafE9ep9+/ZJF50u+10bxnb0Y58+Cx1FINmfWqCxxMnwTKtKy3KetwyQbfqb8Ll10J7f1M9TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(186003)(38100700002)(6506007)(38350700002)(26005)(316002)(6512007)(4326008)(86362001)(4744005)(6486002)(54906003)(6916009)(8936002)(66556008)(508600001)(8676002)(66946007)(66476007)(36916002)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HpjL/pwFDpIS0ZftX9/I6CW18ypDIMbR9n6sl4OtSkMvvZfakPg2mkQhw4Fx?=
 =?us-ascii?Q?eB9YaPlWK5n5tiFbSwuE3hvjbItSzVD5owF4uGGf4+RAgnOtf/EqgqUo1Xbd?=
 =?us-ascii?Q?anvjZAg+l2p6g9k7uFUGZ2C4zeudhAbkEgQaf3ea7FALCoB4SQ8F46k5y0cm?=
 =?us-ascii?Q?CysS+bxyPjX9bhjmSgOMCxQDq01G8fI6BfyKrbl2skOEKvvR8KQdxd3r3OJ6?=
 =?us-ascii?Q?EHqIHO7MaKk98EEvNdLkIcFMI6c7v34qaPr2bJ9l2IbxD09thfhAUtyIo8p/?=
 =?us-ascii?Q?UCWZBFD2fWcAlp943Mj2svJuX4L0ZSByk/51Bzc+A+tDx2B6Gp4Gw6gnhTEW?=
 =?us-ascii?Q?hsXK5M6+ytQJenQau0WFB++3IjVG21HlxWJt3O3b/Q9OHpYbTqV/ONFqcK9L?=
 =?us-ascii?Q?tvJB+T9J/XHNspJ9izBjmQNN3x/aSfX0FY+JMBeF4k71gzx7I8PtsTXfqWYs?=
 =?us-ascii?Q?phMhLPnbRjiYWFpQnjxZe/Tkf+ZrIsKbvXm/VPc89XVCenoWKfzlc1WtbcAB?=
 =?us-ascii?Q?uJVZ8GxWneP3JahXy8ZVTrW7Sru20T7yqmLngEEMzxrtaGJA1tPlfbszfHp/?=
 =?us-ascii?Q?ocAXQA6kBdVpYrlEAY9gQ7fWaEomPEgYE8EW+VkO8NPJbtTV73rtRC4NM81i?=
 =?us-ascii?Q?KYbMw1iYyCJYAceR1fe3j5Z+HkeiOfdwFClu4A8GAcQOOwMgewrvp0L8EN39?=
 =?us-ascii?Q?ustrMxyqLREg5NR/wiomox/IV/H7v8S2iQEuGcsSfYXmCjhahWAegN4uboPY?=
 =?us-ascii?Q?252YBk2qW9N8AGyd8B3IYPXvrSp7uxbx7xu0JyccXqK70TbEu9nQlAYRp6FN?=
 =?us-ascii?Q?0aVJrLesnIFeSgnfhUbth85RFyQrxGHlSzNwvrkkCa1DPqIf58LkPdMZq/OT?=
 =?us-ascii?Q?mRvd91o8gZmZWkIlDzMuTTLwUCjII4zC/hSGYEAgt4OGwxhXiABQDk0pOOR4?=
 =?us-ascii?Q?UEMHz1NGgeUSekF6lxFC0kkJMPH39DEInoY6O/2fPJIr4qFAZEj5Cb5qFTdx?=
 =?us-ascii?Q?8caUSPSSm694tRRRpzfwGRIhp6fke6mmYgHMBO8oAgQ0+Lnwj8KPpFSpnn1u?=
 =?us-ascii?Q?t8ua4o+IwgzEa3b/ITvRGWuuRqVcydphUiKmXwVyMys/NG8WO8/y8nwP59s2?=
 =?us-ascii?Q?9IXmd2tURBTRpdr5Q1zGvzms1qvENbGoVRP2PSBrO3sC89JlPAEWAlDNHhTn?=
 =?us-ascii?Q?JfxOCzYsjA4AN42+ri1iBnfIoM4tjsypA/uPeLXHz1FYCU/X9hCMszzSdCyA?=
 =?us-ascii?Q?FaZyR1zB5MZKTzPdRcVOqZC8IIiFEJmxPyBEBcyK18GvhFwuP/1JOtYlfQuZ?=
 =?us-ascii?Q?k2HNLhyfkn4j76omvKD3mB+OdalBq6ntTCgGMfny+zJkzLK1AIpdCUoCSuG4?=
 =?us-ascii?Q?EsgltMXI8Y404IgdkWlfE1d7n7h51fuoc/OJo4G0mkGiol5MY6SyHay16dwK?=
 =?us-ascii?Q?wtwkvpjYRi1q1Jbq6L1myq3s2AUT4PTCyDDZGsIExJlYfc0GvZ5O3mgQflRS?=
 =?us-ascii?Q?qm0VMuu++j96gK0QJ7JgYNy81E+fjmvICu1/JEHZzSxhX7ZVfhLmmybnVJ7O?=
 =?us-ascii?Q?FuKsy3vcUW63rTkgyaDdLu/yK39KDFGVsLmLpnGgOaN+djC3o9XjmHTnIhXL?=
 =?us-ascii?Q?PANFDNnJP5AV1kXgeNmTEgaajAJ/Io6lKzWxD1ypBzuiSXxx4pFqzQtW4YRf?=
 =?us-ascii?Q?lLNazwnPEkBdNuZJB0NUruVR4XKrJzgRpWB9l73SEM/W2mPbMT+skZyCpoSH?=
 =?us-ascii?Q?ymYmEcGBjteFEZ/EhKffgrNjCt8jeOk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a70311-ecdc-4b39-9485-08da37a7c2f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 01:51:29.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7527qe+5UXuMfhfsHANChWT8wOc2uaCPI7DR/BQjiGNOk0SrK+H+RaEiARoV0M7Oe9Gcu6uHjdM0jYzBtrUGDCYIQ7NfOP+OU559vgwdjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3853
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=923 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170007
X-Proofpoint-GUID: 3qGZtspyca9BLZkm-56qcaU2fEmrq2V_
X-Proofpoint-ORIG-GUID: 3qGZtspyca9BLZkm-56qcaU2fEmrq2V_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This series includes 2x fixes for the hisi_sas driver:
> - In issuing an ATA softreset in the IT nexus handler the disk may become 
>   lost as we may issue the softreset before the phy is back up.
>
>   So export functionality from sas_ata_hard_reset() to wait for phy up to
>   synchronize.
>
> - For host rescan we issue a nexus reset to the disk which is unnecessary,
>   so drop it. In addition, usage of the device status flag needs to be
>   fixed.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
