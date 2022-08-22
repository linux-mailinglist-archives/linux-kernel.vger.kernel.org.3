Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0117859B8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiHVFIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiHVFH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:07:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9213D16
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:07:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M4nPMg019552;
        Mon, 22 Aug 2022 05:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nNWTDUoFfSwReWHJ30QxwIrmsbh4ilsFt3l2Kk1M9wg=;
 b=0hYZRluCoopOdxQR82k8poKcBuU98SBhpRGOxDGu8eQ8x72WwoLRUyRhEb/p3qeT2BVc
 pt63KnZbFtqDapFIpFDPSvzz9xezLfZnd1jK++7/hyxYhVVvvWm476x8ATM19Mt4Qv6a
 gvNCxeIgzVKDIgunUnpXdi/bEsVLybAxeQ5Brs934p8XLlHnB4lySaDQSTFwXpB9XYMa
 JhONVt3xzA/zYq6aVWwL0JMnVJLVYmnDFJETtT2n58yiUXxV4a/Yle0y0FnCVi3Ef9bc
 Sypb77etRWSLABEkaFOUi7f74jECaZQxLiuVV2Ga7j7YIK9w5TVhaed7Ro6OhMqDX0h8 Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4341g0uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 05:07:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M553N1011276;
        Mon, 22 Aug 2022 05:07:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm7ur42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 05:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLETH7GX1to6owSJcMgltHqfVQs/jka6Odpx0c+bqDJcMklXTWyZpyXFvtltSlFgryuyKr8q5h4S9X2cwyuO2a4ioBdHF+482mbtzAs3HVo9N4dW7/Sw+HAIR9gY5CBZrmihNIY12QdgE9F0EdxxTxvSNgTYexTSl9pd0Rb3xTwWLHoRl5suSdkgfFZkpXXVlKQzJtRrazL6khsvm5bdAgi77vJXdRpBcZDAIs+D4VE5E1TXIOAzscbKxcqwaVBNa4pBWAYdJSOB9WgWfrcZYILMO+e4jtTmBHMnWf1DXhlfDUPuG7aoXV3kKuzmmvpEz+cW6VooxDA9ilEk2rZQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNWTDUoFfSwReWHJ30QxwIrmsbh4ilsFt3l2Kk1M9wg=;
 b=hPwRsqTDo1wNLq7E4DswI3nLExCRl4EAJbJOj90wjunc+EvNtw+buW8Ac1n0VPn0+WzVdtRWSt5/sy+KhpmGj2gmVkgQg7TX7M2cfsKI50r11c2UUI3slw1bjuDxSqArCKx13WtJPbVzlNIcOZY9ahPrVkOcz1AuvAV5XzaK4i/J0WSephnSia4KTyQreRH/54YxuJ3XIUjms33SW/Mgziakzv73PI6MiBuiSg2HmkoUcQTe2rd/G1HIiguYbFYBkpu4q/9rIYmGJjeP9mss+fK26VQq7Hy2JS59mdapPAOy0NcG5RLKCC0ailcdupZxEPTTnPPqr2q6mwfRgzgg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNWTDUoFfSwReWHJ30QxwIrmsbh4ilsFt3l2Kk1M9wg=;
 b=lW/0h08duhLtujhHOUWYV1B4phI6/rZM2Z+THtNy2XOpGeHQhq2wASsOqP9eXkL3IZ6hqPDVz3H1fWCIghHiwXK7bIqNDytSb+5pAgEgFF+M+zL+ixWEVINJT2x/r5w4288kxnUZSgSObwtod82rVMg8TbEQBwfB8W9BEED+iss=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB4101.namprd10.prod.outlook.com
 (2603:10b6:a03:120::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 05:07:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 05:07:51 +0000
Date:   Mon, 22 Aug 2022 08:07:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v1 01/19] mailbox: bcm-ferxrm-mailbox: Fix error check
 for dma_map_sg
Message-ID: <YwMPG38aLAKjO/69@kili>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-2-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819060801.10443-2-jinpu.wang@ionos.com>
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2babcedb-8b06-40ec-1572-08da83fc4338
X-MS-TrafficTypeDiagnostic: BYAPR10MB4101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kl79QxLd2/TZwN7z+CgDk2hFSKozU1+vbvyErRSastqxQL47CM4Dx1Nbbo1VLZ8FtTNWS3Sb1UyYZMKkvvJJwa/kr9Q7ItNuPlQ2S91KXb3MLrmUgqsQHcTIqvS9Lc15n1iOenT66Sh0UpqDpGDuEBEt/otvjtBp8rZch2SapuPbn9+PyFpmPfGLh5XVqygHFg6ZUiJOVbj5IRoY5jywv/8xTi1ad1BrewHmkF4GOANCx7zwQZKtlB4iGpgx84G/36ELWbLWW9ckOOeXGr9GibIHfxbzMHsRy71F0T7GsZngXDBxKTn8rPImGNRvQqL0wOnM1qqJpNJV5RPx5PaXxfczuUdLSuEBEmEW2tKHx4RF2WChqD20gU1JwZAss/EI7tgGnjs5DDFj6otArb8I6iLd30iI3DUwQx6dgqI8cS46td5pd9MrA7DpvJsFSCg7jORrS39evQJKVuO/MchkXQG7nmcd8LQ5wEqMjNK7tYMR8u64JLPxhMFmKZ1aPdf39c4Fdh9gRL6mxp2b0Pmm6m/HtKG53UHGx9sX+IzYCvdXn/MBQQSoKinP9pSfUYuv5EQFzD9X8bGZVxLvzqWcF3J/vN5w7lnPup2rWQFCY/B3h4DeFN/VpBzA6dtOrGPkXXsiQpntf5nRa+oZvxl1nbpxpdgdHgWnPNjvf8sdYCQy+QPfxHLd9pXl8UqfO3gWqpS3ZE3Ju43mNI33ztqhuLu2Z6AZcEkQuONS3dPvi2BVrYk7hkKtCKWIDsSJcpQTQET9LIj6TdTPbxhrWfmVBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(39860400002)(376002)(136003)(4744005)(26005)(9686003)(186003)(6506007)(6666004)(6512007)(8936002)(6916009)(44832011)(86362001)(316002)(41300700001)(5660300002)(52116002)(33716001)(83380400001)(478600001)(66946007)(66556008)(66476007)(6486002)(4326008)(8676002)(15650500001)(38100700002)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mx0gWM+uxA592n1uX0BkwNdfrvOGaEFt60d0wOuJY7obNxZka7yJYPivG49N?=
 =?us-ascii?Q?o9vDb8EPYnyySueoaRopXnAZkZAql8aizFx67zzDxbXzvri9HkIcduudtv0e?=
 =?us-ascii?Q?sp0tEdthP0QLj+4t4eetpCl6qmu1TXABUPKdzPGygLVpBuiDpPsTW+w3yuJs?=
 =?us-ascii?Q?chQRq2qbsmzW8jOsf9m6cOdQORJvYBOfEL/0ktzv515ayY9ySLesyfZOPo28?=
 =?us-ascii?Q?Gqzgj0cO/3O8Jwdop1UwzjBBznOGAftChmeE+88kD/4WqM4XMnViC4aPUO90?=
 =?us-ascii?Q?/V7zHBSUeInERuhnIpQRRqIMaPPDcNH2MwKeUBndJfpZ9pBNey4Enw6PyhUs?=
 =?us-ascii?Q?9cHW/e60dx17ElcGn+TReJYC7jatK9ERLtk7n5SFegZI3y9pWMK9jCCxiJhw?=
 =?us-ascii?Q?MdHAVs1qOmgxE9WigamhnChuTgfG/fyOmYknM6XQGFZ/3Wt1bv9fLCF9xmYx?=
 =?us-ascii?Q?VJZnd2HXKOQ5uZQW9W8JeCXB9AOFS1GQ5wFOAr/K4uuIRqB83db5gMkmeiIA?=
 =?us-ascii?Q?FN19a4VzPAcM45cyCGCQbCpy9QZ3RVNEzDRF3ALuPkAAQYhxXtB2EqWZox/t?=
 =?us-ascii?Q?GWRgH9cKObewwxqwHnJ6HQ34bBBrvtTg9zNHnpjNnR0Yk/1YGDuMxTcoc6+B?=
 =?us-ascii?Q?FxxHrR71j88PUl9rTPaJYzfBng6igIRlAXse+om8wfh4M2N6/rCIQKjgubpp?=
 =?us-ascii?Q?+7i2/+lzwjMb39Wi6x/fLj8Y+eA5rAKn8yazQH9zDa1KuDbxOWTheuXP08zS?=
 =?us-ascii?Q?AyzrZCLjaNhzVX9QnzpBbb9JoFPj3sp2RkyJHspF1YBYCCXRr3MNIKCUWB9m?=
 =?us-ascii?Q?isMZ98GJZEUuRVCozkyuRk3iX9vxO9AXYemnoDxISJ/dWQ1TVEcW5u9IMI1s?=
 =?us-ascii?Q?027e24nCKrtYilLXyR/WMEmwZQk+j6qshHl8BnBBBT4r/b40vLitDrY03Uxf?=
 =?us-ascii?Q?D8RcAlpREaKNU6bCWf76VS3MMLjQZ8cW0G9pjABzeGojCNPhVmfKfXf2R4qV?=
 =?us-ascii?Q?nR5LSmA78T1N1SzlA7WpQLa5v7TugZw5UPJcDt4rvUVt5A8cv920CehM2qxD?=
 =?us-ascii?Q?LNBRNNaEKIlW/QRTQBj7TAq7eFdMldicFfP1hVRz/nD+HtX+pnKxAcUWZEeb?=
 =?us-ascii?Q?ThY3J74XZE+7xRT+4lcom1XXaZFOUACgAfXVgxy705d2m0PmAvuGWGhN3yIm?=
 =?us-ascii?Q?i2gwqpkAuAQd7rSjwZj4vhS7FGoQxoJfOs/S7g+0YlnDn0OoUGiFAAc77Ws/?=
 =?us-ascii?Q?I5UCivntDMevt1xaGj5J/ZG4XagSLZUTPUKhysc+l6Mjs34XTFL0bFQNJruT?=
 =?us-ascii?Q?TCPPacIN0zW/N0vZDW/lEK5YUm5ahB9ngq8jXMNquAGtnbar+5Bsp5/u9L7c?=
 =?us-ascii?Q?lZ6LerzQPkJeE7yfvOGBFlvEXdNEqhznHJK5yxSzqGw8J0aMVuqi7gtOFncl?=
 =?us-ascii?Q?JZOufmcsuJ4CQQTUDTMU16AaHBbC5clQU8opS8RqaoifVd2LwYF6AKulru1z?=
 =?us-ascii?Q?ZU81Cb4vUVqELplMAMIJpipKKRlFZYkVQmkkc6zLeDRcpzROwnhqbQ1r6SX2?=
 =?us-ascii?Q?yfbdXgp5/EGEsC6z2pFLFP7ozF/Cps53UO1D5Vwv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2babcedb-8b06-40ec-1572-08da83fc4338
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 05:07:51.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmKsmLcfnPME+TWiPjTAAvdRD2u4g1xmS+IY15o1QtNlf3uzZq5sIlOXXasiIdY9iLJU//Hbbv02NGXSCSeg9vGlqc8KwsbqT9mqTfUxCHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=905
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220023
X-Proofpoint-ORIG-GUID: 0Bg4JIuoFZwhnw6Y3BeuIaoNSzbboe_X
X-Proofpoint-GUID: 0Bg4JIuoFZwhnw6Y3BeuIaoNSzbboe_X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 08:07:43AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error, fix the error check, and return -EIO
> to caller.
> 
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

This needs a Fixes tag.

Fixes: dbc049eee730 ("mailbox: Add driver for Broadcom FlexRM ring manager")

regards,
dan carpenter

