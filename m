Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357A581D73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiG0CKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiG0CKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:10:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047BDD7;
        Tue, 26 Jul 2022 19:10:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QKnE27009464;
        Wed, 27 Jul 2022 02:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2nRUS7JyFZ0prjEX5NF0/x6Jq7uDSKzFpCTfpn1TbXA=;
 b=ceLAfB/y9VF90sbC0lUgTh0faJfslXlmuEskSXnPHnYfD6s6Mse6l6Q6aCREDrpIvHER
 DVMDSdela9Msd7wV73L1fDZV2DvPyXLBax3qQ0dbjJWvU7G5K4IaYYAkEsJrJiX/Lkyk
 uopbl3jW6kNa7yFjBNWVKPBLt77rlvlrhXXysn3MaPMLfpkZ028iArKCIcE/WJYT4G61
 k0xduhrSCIPs+2DgRT/1HhyTRjI/+ItaT0WZaUCa5qhiCVn2wn6uefz0PfUD7xX0zyKW
 Dr6rAaH9ortGWg7yyvA6FNm2Q2U0ulwQcNry2NLHom8/V6fwzRDoHQINsNhuHfbtZae2 Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4r5h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 02:09:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QNtduN006455;
        Wed, 27 Jul 2022 02:09:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65c9g97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 02:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPDJlXTHAlIYMZEIPQUXsCKSklb/qCfgQiuuQ0UeCQtgB3samMGmuJH+KPSjvT4FVBYvKdBeNmvSPNJu7HsshZ6t0/Y5xDsAG6RJrGim2Wnfi1bhgCa1y+15mjS4IQhRedtnOIk4UjceqHp6aRXRGpjDpbp9s2ZgAv8Qh8dZ3eFDPaofvd0+hwa8Fb7gUZqMm9xt46T0svedywknois65V5DzCjFsSdedp24wSd+t6h0eeL3DzmRE6uo3OaCZzakUKaexXqZTi/5EreqCJAM+9635ZV97WT+6mrgXAk3SQsMoB/x2uzFwHLmTB8r50esqtsjtrCD0iXMrWiNTS796A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nRUS7JyFZ0prjEX5NF0/x6Jq7uDSKzFpCTfpn1TbXA=;
 b=O242NXNCVzhsWd5+SVBuUuJEDnyEFXtfvporeRWUBEVq291L/Ei8ShFiNNO4GIr95smzPM45tGY5F2oCWLuZWOoMTmRzsACeO/vMHbADXXtAlNuauyqBImeJ3fU00nxOmTr/HkR5uuOkH+l3srjHkYliX6DmXbs88+cdef79C491/aNtw0c9xn8LOoYzjXItbwDLuA/H0gd3fSm42xCNA91BF0JI6C5k9ZD5js+kM6Ilrrkml1cTfz1go0FfpWERha5a5klx8idmYH/N7yUIU0dlXCSDG+d0I9e61iR/O670tjlvRi6/TDAfl0591bf3uRplQsA31RLx2LsGFkFtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nRUS7JyFZ0prjEX5NF0/x6Jq7uDSKzFpCTfpn1TbXA=;
 b=nU1n7KurZkVpug6SFFS6ceodxk5MFQkL8Xw8gMNvkhtsMdTc9zxNgWC+sar95Y9+3HzU224qgyeWm2qV5oJwIaiDJS+7+uOcx8rA/nx1fGfZItj6QTvv7h/EttHnY27pTV9GNwKo46biIy84GSmKmkSaYGri25LocYsS3MFnX9M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5064.namprd10.prod.outlook.com (2603:10b6:408:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 02:09:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 02:09:46 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: ufs: core: Fix spelling mistake "Cannnot"
 -> "Cannot"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmhrcnmm.fsf@ca-mkp.ca.oracle.com>
References: <20220719110649.759821-1-colin.i.king@gmail.com>
Date:   Tue, 26 Jul 2022 22:09:42 -0400
In-Reply-To: <20220719110649.759821-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Tue, 19 Jul 2022 12:06:49 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:a03:100::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6de38d-be6d-48b7-96d7-08da6f7513bd
X-MS-TrafficTypeDiagnostic: BN0PR10MB5064:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL9xu+ACuqQ9GAdq9BJFi59p0NUvBEMkxTm0j7QHjDfgPaQt/10h4DyS3g0q2PeQyi6wqBMW76EeAcAs6utiBTKkTYIjvUOpGzv/eoULEPaBUXXZFwM3ysAU3kkebWMxs9tInoGk5cEMuP92VBtAeNoROcSNufc2vj/iH+JLKl3JrmukRgROsr8Cv9MQievWNB41lCFmvg/souWDicbenTyqUOHxSiigEJIUmAy/9yzDQdhwG+358P3UqnBHlAwmxrCWiy/LX0QJF59xJCeCBnxgx8O9JFizRxE0arsEzS5nCNIJrIZtiEzQ15TjsD8av4atg9QlxcWXzT0OPOUAZ/HDhO/QfHva0DbE6KewYhxFOI4HCA17FuP1N5SMQwI2/a52fzXgkn3qHNOeGMmpV3Gpv7wSmIhBZvoUxOpHphPOcGLBGTyQky1WuDTAys+4snhJqQ+2Do0AkYKjFDHQZxiTBtuD90n6wrqZL7KWgAFvqfLQ0P82Z4TRBUY6hk71qerl8KQiDgnaWN8VccMbTYiKreEfJTEZQMelbItjNKae1ZdAiye2PYjzLRvFTwxLoBB8jUrL5YvNy9VrJJYnG3Ix/B/RMNKfgfRXmfOB15OYSyP0zSypKQAVBlE7a/1wXzOls72tVtgucCH/9xEUhqR6V80l4sk5jXU0KXj1CQGf+CMGj3zafWCjcJdz0ckSK2L62eooxHuC4qVkTf+3eXRGEIYEIovfuHm/0SAoizjXk939U/yexlQdNTKowfKEbEMo+9XZeRfKYE1406h8SeTsK3xaTp30ebw5ZCQYUCL1i2CXN0ZS2c3aLALwDtni
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(38350700002)(38100700002)(8936002)(66556008)(5660300002)(83380400001)(66476007)(36916002)(186003)(66946007)(8676002)(2906002)(41300700001)(52116002)(478600001)(558084003)(6486002)(316002)(26005)(54906003)(4326008)(6512007)(6506007)(6666004)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7451TEj2/kqPtizQuHSMpRjC50X3vyJWUqu2MP7NzP0t8xkStOGvb6v7kisP?=
 =?us-ascii?Q?5F5zrWpNZCPXj3NCZ3IR/eouS9fZSNHFaYGeflm+fetscjNEnnXpq1Zxz5EK?=
 =?us-ascii?Q?yBGRsTrMH0CbALRuKq2G7wnApRttcEYIdBbbR75iSh1vchc/XDZacj0invyr?=
 =?us-ascii?Q?EOjL1r7hWqwwGsGkhtTiGplP8WgugOwl747gLJB8M/wijZo3R5aQirTzWEUL?=
 =?us-ascii?Q?wbXGJacavlGuBj6SpYrs7kWqFWk1cDI4WbEuGD56NDT6t8NrMUSVjuTTTeiC?=
 =?us-ascii?Q?ZVA0T3ViuOhvLA3blqpjO8JxLCjosl2iLOsaBCpNNJ+3KYWuulEzb0tdYNpE?=
 =?us-ascii?Q?5J+u108ncYSi126076vGXttqBsivEUkjazgi6KkB9xVLGOVzf/tqN8hOxSL5?=
 =?us-ascii?Q?ahytjCJ5zmKH06+azqWIns9Oxgp9YxVFKHue/dTXAJ9JbKXjb+6rRvGR7cpZ?=
 =?us-ascii?Q?DbcliNZ3r9YpixDnuChMy6GFOxyOpE1taKx3+kPfY33MGU3HaTh8mB5auTVi?=
 =?us-ascii?Q?qOWGwKrk87DI1YM64TYatFPG1rFQ/W/huIR9YctqXsVh09k1aTrXnynvwYBY?=
 =?us-ascii?Q?5fHFDCP6HWj/LJrzJvg5FbuAvZ/5qaslhOCbQxT+kEr70iw8V/Qj+WmxFbZ6?=
 =?us-ascii?Q?nHM0MD+0PXhfafNHMMM2Vm2UKU8d+IBD9M4+bB+rJRP953dPhoznPdzP47bQ?=
 =?us-ascii?Q?MrKjOsI2dgxRugUE95Xo+SNsHWDsSdpoa++dqtkIodZgGAwEJN/CWQvVbBQT?=
 =?us-ascii?Q?9LKd1YwFUD3ha60XNjKePQGQYzs8cu550E43yzPBeLLsuV1DkgDz+I3Zg40K?=
 =?us-ascii?Q?W08mAtqg28FRegqv1siaFgoA9T7D9LAYuZNc9OtVnhpmXlOxpuaIjogJBkzK?=
 =?us-ascii?Q?hED8uj/ACqt77v2/l3fsYllEUbHZRh3p2GV0UUKYdvO84eO3hjmCigXyaBjT?=
 =?us-ascii?Q?y5s76uq0i183NWJ/A18I5l0YHALR1QsCfohnrh4hkm8159Q7DcmWamL01usl?=
 =?us-ascii?Q?UHcX08MCXdyCS2tyjJBf8YHvPteQdhNdCePLVnlXmtGWaLQgFd1UiRyQskqz?=
 =?us-ascii?Q?nQHwQb1zs/MdzzfW8htlpx3ggdc6aE/WvYzxEhGg9Z9hod4roFXcjpUZ4Cea?=
 =?us-ascii?Q?IMv34zxM5GyPNfnZNkpysvDL52kJciRuzR7ys9ySciN9jpsauKCzgmDS7j5y?=
 =?us-ascii?Q?ryWE8Mg7tBGoxaCqDwkVsZpeVidOGpTWh1acXadzAPqjTH1pAsLt15gKHBo/?=
 =?us-ascii?Q?dzZq08NaDvG0SsJChJfgFf9kJ3NFY3bLrR2Sf3zOquLOkcQHiI4fCAwX9m7O?=
 =?us-ascii?Q?n/H7F2dJMfkWyLiCEQ9Y1GSHKzWnSPl1I+7JvyGNjI1VCadbAkw1vU8aqSaw?=
 =?us-ascii?Q?a/GRmHiKAg3n2gzwBIyXacg5vancq0M7EX9wJ1RDRczzPT6hMzZepqyWDEX/?=
 =?us-ascii?Q?BPV+AYT/ytgUzUcaXjmTT/8cLPRXnUebiAwScxc9SgOG2lJbxKIFYxF4OKx4?=
 =?us-ascii?Q?fBPwopkGrzJPdzqIaGYgKOgfWZA45P8m2517o77iDcVgwBNsLkQr8ueZKW4C?=
 =?us-ascii?Q?hPZ6my63OU/vapNw7/37+JQ4Cep81E/w4IMdb4iZdVNizqr92ncnvhj5QdAC?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6de38d-be6d-48b7-96d7-08da6f7513bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 02:09:46.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tg8A5Mes3OAqlzGzNwKqjv423jGwO0AG7IlvvEvqPLbx6Zo+FBvVEcfpOdLDkJH4frcuC6RF2QMv5dIHF1ETcIncSGZ5e0QzLCaMivU2MrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=968 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270005
X-Proofpoint-ORIG-GUID: xrZ7OfLsi28M8r29RkI0EZeoZ-KXhTHK
X-Proofpoint-GUID: xrZ7OfLsi28M8r29RkI0EZeoZ-KXhTHK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a spelling mistake in a dev_dbg message. Fix it.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
