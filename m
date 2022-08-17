Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAC597A65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiHQX5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHQX5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:57:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A372FC6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:57:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HNtt6v006522;
        Wed, 17 Aug 2022 23:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4m3E3mTfakU14vnsENdDISCTCfTIF8cYxzp0aI8ngRw=;
 b=yg4TLvZs17sVs3IFLvnL3GOh979I+6OTgQ8Chkwl80GTaFJX8s2GF1+rmay+WqP50oli
 WQaoUn9JnwV6Tg/z2Ny0XSIOxPfTnTLL/0rhDZ6BF81EjnWo8KsPMO/WmK6LKXBBrCuq
 QVBZlE8n7tZfevN4cNv8BzDNvBYf6z+b49yRKW/+HdEUSgi1G4d9FiAJvt6v5ZovS11q
 khFXYCg+yIEDphBkD7P0Ux3kSxLP8tGpRbKZWxAlnW6I19403SxpMvKcAyeV/PXQz/5S
 K4hX0jXlYXtKc6wWjlG/544qzY36+GQ0cvHXlGdkjZ+eTAjiI4pQKf6LCy+/RM6t4tpL hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1a2380uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 23:57:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27HL5RLm026969;
        Wed, 17 Aug 2022 23:57:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2da120e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 23:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki53xigsCf/a/A4wAtMnMv9VDrYcakUdW8q+ADaS5f48yu96n62ZEPuahvpfaWOhzYp7b3SmYdSyYIjW6EYitjo4955ZbH1vpOIp9X1a8tAmqk8Bvm6Rrv/4axAr+88UC7fvd1r7cu2zzucgRhPw1bOtVkE1p9KyDr1k1u0xq8qb6eEbt5qXesYVdBwDeUzXJ/W5qFME8tez0l7/SrGz9uPGO5FQfx3jt+KvYBQuW21yisfvBa2X/jPWFVlHAKlIN/z+SkEOR2yqjuoa0TJajdO0dpCfvIUtWSC2p1G2tN6JZooO9DIsD59Kg+9AJCrQ/1PHM7Hcx45cb2MbDDD4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m3E3mTfakU14vnsENdDISCTCfTIF8cYxzp0aI8ngRw=;
 b=QNEcWIp4vkfofgxHrEFQ1GStWXUH/y0vi20QT1EKdtVROGRwIUDFU7Szx6MzaOJE9Z5RGj0c/AWVRgGb9++Nfl8bVwy447BvAmi+oh7GuGOCkiqeqQX6kp8ZICHn/iDhV5yQEMGp1tginx+QfCgTpwzsgV9p2zBExy/g/SWPWyLlvsrOqfeYOKnOQcfEpnrAvT44z4hlgBSV4MAn/WBVNT1IHuCpMGd6Sk+sSkWDcSwkj4+jp1hgUDQjA0MwRul+41BfLlkRGZisNryHHDQkY71L1+ZQYk1QCWqGqIHqElOWblDwun1gNmMoCcKfkjrs6/ueiBQSoP3iYynz1aMLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m3E3mTfakU14vnsENdDISCTCfTIF8cYxzp0aI8ngRw=;
 b=QPWf1+WuljolG4B4r4sUzZ6b2uze+tbesDhojpd0vQx0gLlOT2ttMlhvDjOONiM4QT9ws3iwTalt932hY8vakx/oUALimLyTwtS3ko24sI/sKeuED67PJb1rlkV8esJ5jhNeQMV3H+LmtxEoQCImpmWeGLQoAWlN72ljSTEdYss=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 23:57:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 23:57:01 +0000
Date:   Wed, 17 Aug 2022 16:56:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mm/hugetlb: make detecting shared pte more reliable
Message-ID: <Yv2ASz3jGnoHh3ok@monkey>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-7-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816130553.31406-7-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38ecee0-b517-49b1-8ac7-08da80ac2db4
X-MS-TrafficTypeDiagnostic: PH0PR10MB5659:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hA8bqJ81zucJ6YI6rwxUGPOxMyUX1fBJ+uyK3oMmFl7cwyAtdeDjurcfcNoCWFsjz6AyIyPPAbybJVVW6XQ2h7sPNEPve2VtOE36DOyhQFpgu6D9/6DMTpS8dOGNdvgVYtaFamvnLSq1oIupjY9Ghsv4mAaR1Mvy2AczWhtwD04obghoglnalhOXHV8NqqxZfxpZeBlauM8VBpyEbHuNE3cEkajzaq5HN6T4peK6Ce9QGFhxXLATOMtGJNulahygdCYP57GOSsMVW8e8YK2dIdxtTuhfEuCZYTjE1mAl/ZJw0LSR2eW0sqHSaFhnNTi8UliDPbstg/BSu/Ye6wgxfJJzG5wpLZTT0rHCcknE4qOPMzZ51d59KrI198wQeB2iz+MyiBTy++Bgf+oBhJ2nZuEfXXgIplpxu3yw4pKzsM0jvaKF7dz2NcPnVzB9rf5HZiw4EbYPsoUrxfWx/2pUOq/HpFknOVrolqS9PFRbciDm9Ejo3hTy0zxcn/8cm8W9Gl7MYvf3d+L7Yo7vlayROZDplLZT/8aFNcXxl7pkvQvmR/YoEBc8/99nu4A+/LjWgAmHByTCll+8Le4dFEFJngxoslXZbUR+FMsHP50+GXDmHrP7xHbuQqzjKw4Pu+gFkIiyd/rIV9M15ztULqtcTu6Hif/oSC6uNz1Yxs1nZDowOTlopu/QllrgL9hjei1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(346002)(366004)(396003)(376002)(38100700002)(44832011)(4326008)(6486002)(33716001)(2906002)(86362001)(8936002)(5660300002)(66476007)(66556008)(83380400001)(53546011)(6916009)(8676002)(66946007)(6506007)(186003)(41300700001)(316002)(9686003)(478600001)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCdSxzujIvDYeL3Sazs9YF+VnBv96XsWCSd2sltYhG1c+Wl4sV1HnC0h5L7G?=
 =?us-ascii?Q?LX/Uz3aHP+9cyUv8vPS2Tf6WQN3CuwMuul6ccU9/it/OKqtF8YdJiHU6Q0XH?=
 =?us-ascii?Q?hVujITg9cwngY1EIHOJAPXsXhlljWfVCDpOIdlf4HnLlmMKz747tqYfHIU7M?=
 =?us-ascii?Q?snX2e6Ep+7VQv/njWEkNp9PZH56bvMfOw7SUrrAoDk74HTcodtooEOUESCX1?=
 =?us-ascii?Q?DqA7v/KHNZ9MeUilKIhgxFtQW0BlMJZ/9VZF4wVcF5vJi+PL0laXZnt+lnqy?=
 =?us-ascii?Q?qNQf/yATaUlFwRS2eF2t9c4VOXjHhamJubqclHRCRnv3M93BpvffqOadk5i2?=
 =?us-ascii?Q?FEklK54u6jFOKMfLtjBCyKdzEKrgUNcJpa/qnKeqLRi6juNfKfaMV2rk7DwQ?=
 =?us-ascii?Q?0b+BPB43RS0QgwIrXoaIQF3hKjJVwNqc1nDVHkQid+UZcyDry5xDYNrhziQf?=
 =?us-ascii?Q?JbA7fKG3JdsRhHroJa9ZaN1vaVsIwmheY6WIHgmYGiW4DKJ9xII2y9cuYO5t?=
 =?us-ascii?Q?i9HEoYsD/8mPW2M6fpGP6urmI3H5Ra64o6QK3wQtZ8fGdoMmMaSgBdgWIyoe?=
 =?us-ascii?Q?KNbBFgILBxCWGwQqcRUHgr9Bd3MtYAHMIY264o5CTPSUmPg4srhbuxS0v1QA?=
 =?us-ascii?Q?iqYH0GUQHNlnl/66aVLrJBZvMmpGWiwDeeqqUyEDzY97/YUvDw39nnkAn/5j?=
 =?us-ascii?Q?WiUeUiNS8RymuAPAdlphF5bVPpp6qEvPflLgPvxTKsu/lEsnnsewiILSj8cB?=
 =?us-ascii?Q?As6TppW3SlQlTLnwBBKcBLWw6Xyz70EXW66U+62YxzeQayRaQ5pFtvmKGe3r?=
 =?us-ascii?Q?3cTNZxLcjdOPosnW3+CP3/xnqiygMZ/B20JwfgeCeg3dXuBlVQEwXweHyd+y?=
 =?us-ascii?Q?ivol+5J9DuQtJeqbO53zO5PYdBJF+xqBdMHJuSibGeOEwQFQMjFTz6OtfcOw?=
 =?us-ascii?Q?5IdRaFf7nIQnWd9nik0cBk6n3tYhEt6CZ4YAXuIvyzjcC4ziTv5+l8iTBEPN?=
 =?us-ascii?Q?ClSCCd7mJbdUcZWaZXDbSU+6dCdvmTtxF3mSSf+paHqd7XLtca6EAK/ET6C0?=
 =?us-ascii?Q?LCGBUSsxKfaeIk2su4pSgDpFEruJCCAEIbhyC7JxLvmcMcUzVL7KnW+c5puj?=
 =?us-ascii?Q?27ifM2Fc/bdFPMQvJHM99YOs6mr/SE1rQ8wDREC53emfpkq+HOZF1hEYYZAk?=
 =?us-ascii?Q?BlQgcIwdsWXdw516564Oelj3/SgDS6l+oUpjjJ03DqajRVAoTVsU8wGQZy+q?=
 =?us-ascii?Q?RvYtfWNPaMmB2RPyygX+NDp9v2xgZrC6ppd6g0FhDW6XCe2KbzxGhmnYH4YC?=
 =?us-ascii?Q?Ttrw1u3aS0Fk8qgag3X9ZUdOxyxA6WdFA+SCBSYZ2Bot/Mc2HUknWh0uRcbf?=
 =?us-ascii?Q?QjKlC02+5lDdTED+KGiG99TN3gM0pqo2kKBUvNlkTtbTIb2QQ0iR9qM+qg2F?=
 =?us-ascii?Q?5iKCXAHjRZ+WOESsUYnhPaXrukYmeOd/daap7AtLA+osPXan+5u7+t10BMmU?=
 =?us-ascii?Q?ALniI1saxljM9SP4tezT/nqc70cCZ2kNfBCgxFTKTMxMqYTylfBICU9bki6/?=
 =?us-ascii?Q?LNPMGLNz0q6TE3cJqxTgUuIOdglpguXYpBVOpxd3yG0WFFJpR85SQ1mW4SmL?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Z6DLsLQ0dv7PrgsCWA+dyPEjGJZlEZSg2kLAiIWChZIWRUom6WkcnhqwHXnF?=
 =?us-ascii?Q?IAKpv1OTckXtYy6pP3WzvWBes38lmRrHYD4byMMiRI7Jju63WLhgK/jpGWnj?=
 =?us-ascii?Q?fP28G2jFTChFMKyttKlpY+I+7OsB9Qjd5NS1uVeCyxmcS4ugnoxmwVAIRxLG?=
 =?us-ascii?Q?dybVTUUSBTxZ1X9DR20zJnZZPn8GOMXySfCxu1Fl6ePKpLSCXIXc/6sWr3Y8?=
 =?us-ascii?Q?zF+m0nVAOklGQtV6a+/ZxC2Vz0PSqS8sU3o0+0vLNzOJMb1Gwc58s2fSzpTX?=
 =?us-ascii?Q?0ZhHlfiwSMjHz73jhQ6LT5D3WVpdpfNe1cN7tuw7NFGGTlsiiC6LEyzvihyX?=
 =?us-ascii?Q?VaJcKQ3Tuw7Nnzkn4V+fTIXW9d6mG5C249IKsUJKDXH3swnIDqnJrnoBrozD?=
 =?us-ascii?Q?mQiTkmMptEEROPGScnHSAAvC94HFRJLG4jnK1xItGqwHsjj0JNzFbZtgRh2E?=
 =?us-ascii?Q?HRHuX/+8GVYdpnSGQ9uNTX6DxYGdZ1OALLOAhoaNxsJxLrpZ3KyNj+DeUPwf?=
 =?us-ascii?Q?03CqmZkSVjrrZfjbc9NKfS9nPgQbQlN4kjGhvDBmK3PNY0dB0ZxqGovnDWCu?=
 =?us-ascii?Q?Sy0m2ISAkablowbOE18igg+Ddsy8wcqL+e3QZMCvpui8BdNpz43MFWZjGtIc?=
 =?us-ascii?Q?qtD5cyDdcUyjoh6zFk98GKLZPPLYMdqNN028OIVVj8D+1mWOq2CvKEkrRQx/?=
 =?us-ascii?Q?3fEJn6kVJO3+Uhd1rVOZeSJHDrDw1nxeiGDku1PpqKohrdoBQRMTiJX7Y6pB?=
 =?us-ascii?Q?LMwZ474GTcoSf28HIxFe3aYtPBZPXzp684H01V0QEO4pTdcBveCITzlx4kYf?=
 =?us-ascii?Q?jHV99pGLlfmIbj+ST4U2uSdG+kQAnZA8vLgpCaXDUIVV4c6jsMLZtoEIu9jI?=
 =?us-ascii?Q?osQcTZN8gPoamnGE/6wX/nEMATKHPJrvpnl2zV9EIqUzMsVS73pGC1YNKYzv?=
 =?us-ascii?Q?TdKY6xF8gCj8fLyiRa3GAw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38ecee0-b517-49b1-8ac7-08da80ac2db4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 23:57:01.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY5k0ELlvXGiB4z6xP1ELs+FIly5ADiM8YWkoYEfX1qMYrRUMX4lcpaCwCxJZurEvnYMBTMNUxLFsGBFkDz7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_16,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170090
X-Proofpoint-ORIG-GUID: QEtsq79nffCdTrNdC0COkbYzziLXSg5M
X-Proofpoint-GUID: QEtsq79nffCdTrNdC0COkbYzziLXSg5M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 21:05, Miaohe Lin wrote:
> If the pagetables are shared, we shouldn't copy or take references. Since
> src could have unshared and dst shares with another vma, huge_pte_none()
> is thus used to determine whether dst_pte is shared. But this check isn't
> reliable. A shared pte could have pte none in pagetable in fact. The page
> count of ptep page should be checked here in order to reliably determine
> whether pte is shared.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

You are correct, this is a better/more reliable way to check for pmd sharing.
It is accurate since we hold i_mmap_rwsem.  I like it.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

Note to self, this will not work if we move to vma based locking for pmd
sharing and do not hold i_mmap_rwsem here.

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e1356ad57087..25db6d07479e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4795,15 +4795,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  
>  		/*
>  		 * If the pagetables are shared don't copy or take references.
> -		 * dst_pte == src_pte is the common case of src/dest sharing.
>  		 *
> +		 * dst_pte == src_pte is the common case of src/dest sharing.
>  		 * However, src could have 'unshared' and dst shares with
> -		 * another vma.  If dst_pte !none, this implies sharing.
> -		 * Check here before taking page table lock, and once again
> -		 * after taking the lock below.
> +		 * another vma. So page_count of ptep page is checked instead
> +		 * to reliably determine whether pte is shared.
>  		 */
> -		dst_entry = huge_ptep_get(dst_pte);
> -		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry)) {
> +		if (page_count(virt_to_page(dst_pte)) > 1) {
>  			addr |= last_addr_mask;
>  			continue;
>  		}
> @@ -4814,11 +4812,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  		entry = huge_ptep_get(src_pte);
>  		dst_entry = huge_ptep_get(dst_pte);
>  again:
> -		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
> +		if (huge_pte_none(entry)) {
>  			/*
> -			 * Skip if src entry none.  Also, skip in the
> -			 * unlikely case dst entry !none as this implies
> -			 * sharing with another vma.
> +			 * Skip if src entry none.
>  			 */
>  			;
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
> -- 
> 2.23.0
> 
