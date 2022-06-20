Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFECA5511FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiFTIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbiFTIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:00:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BC10FC4;
        Mon, 20 Jun 2022 01:00:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K7HIT2009331;
        Mon, 20 Jun 2022 08:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ptsjpVs98c94sCJsKw3ZoxUtQNODCvS7JuqlFxse0js=;
 b=B+HoV0Em0OzZFCG350qsZS1nDWau5R03GECFLASAjE/2tbNNaMM1CdKYMfA+0A/8LLZS
 9d4nFK5mave2BhKEq4AC1ZkWxoGbmQGRTwN/i+PN8CpSWlm180vF2nZpEVXyVKB/erp9
 zLUvyw6l7xSmgd12KSVwLeYtYIm6vvyQklvVm6WlQm3v0FG8g6NSOqDDGkqnu2F17cQz
 2gzgQpolag+30T9WjWuOW0QXAMO0oZtDRamUw/T55hM96D20Utg8oZmTu5pCX29qv6tE
 xgzStl+CIt2wbUQOhBa6NZOB7OQXKXpBEdfh3Rq09KrjfDfO7yxGuyBbFKGLhrYWZGcK dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6astkrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 08:00:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K7uQ4V033205;
        Mon, 20 Jun 2022 08:00:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9t0a0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 08:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhhhkdQXp7rnhXd+KRd6liGvuNgmpKNNvYden9LuvecLLAsS/m2b/eyyReJ8BiWXXy1zRUag5nBirFtJjlUwpyz2ZK/fZo0Wmvf8cyHKWKMsNcPwDSNCd5gB7DuBSXl5pEzAOUWmJEPtJzS19vxOr8tNJpxQKd+wkboH1FbnUw23JL/OjieGPJfDezGZs/59RwZ2yH6Ag5l+3Y/KtoLqjoOusMo2GPBsMgyU3wYlXgkZOk98IEGHCGlGRHyCpKYoRYbCrQNBYWwZaXdflgnSwHjwgxeVWfOYMra96HplWpTkrDEzHs/qsppMyktk+PnG2Qy191DLVbwhXFL8ogO6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptsjpVs98c94sCJsKw3ZoxUtQNODCvS7JuqlFxse0js=;
 b=EGaqm2MjgB6bPtZ+QfSTNdpOMJmnDCS94eQFkah4rab1okAQIh99l0elgiuWnXIJoyt+yYCub1TWcvHdoqAx5IsYcYbNHFmKouiPRdWlw4+txDtRAnzn4ri/3RWBx714u1UBm6ZmQTf+sPTfEXItUJUZQb3fVw/uMOlp9buwW0BPryvA1cshWXXBbHOnnKQtmSXihWSeaBU2hPegvIgJ8m3IgFztSJPNE+ty+YvWpGb2Wu9CnWFG77bnZ4IV3wZxmCf1aObN0zkMaVzBhSTUslN+kPIYAINLQSgP7a/AVkwHCahWMKqnDqmz4bWq7aopUmRfYTBC8e+M5tdGtfACcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptsjpVs98c94sCJsKw3ZoxUtQNODCvS7JuqlFxse0js=;
 b=Atzji6vDmqxQTfFFuZQd74s5ezA67SkQ3m0ChOE9pZRXfIfEPwvTJ7sr8tBq6TlpI9m5t35dYGp+hZq5yPRRsyVrxYv3wBMIIMs+awiKozEYU2xrbIPIpnxXccGVU3ZjSDjnkJsAEfC8jrkE7sxOL10R3iEJBG81JUxCyQ3UT2k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2654.namprd10.prod.outlook.com
 (2603:10b6:805:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Mon, 20 Jun
 2022 08:00:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 08:00:07 +0000
Date:   Mon, 20 Jun 2022 10:59:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] media:rkvdec:Remove redundant memset
Message-ID: <20220620075948.GF16517@kadam>
References: <20220617093925.44985-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617093925.44985-1-zhangzekun11@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6516beb5-56ef-4fae-6134-08da5292e440
X-MS-TrafficTypeDiagnostic: SN6PR10MB2654:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2654096183D60094E9DFCEB78EB09@SN6PR10MB2654.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYdSFXfCfaTJRlW14NeT+infqWiybIx4rb8jfjfESFg6yoaJJaXvzSrs+77zWt3DoxZ2EBxM+0WDM2f3LD0pH3YqJQ6mn0hYIe08X7/krYhQD+ffzsAuveANmKxLcOYDRT+NVEzo0YURvrQxilgHvJKdAMJnWzbTc3t8VBy436u3cIs1Lo2MMXsfZQr8OavMGYHEs1AKbzykaAAHl+fRCTq2OoM43KNp5nFchiY5SsB0u4De5RlNj58BfvSmiqYY4hbgPxJ5AtU3hW1NAUdkbBD4cr/ufvgfp4te3HPA+iU9s/9zDjLHWDE7KfmJ2d7rT8dClKi6/4shEojdxbJlfNTnBgvY5MM8C39ervl15+/4889BLElJnUG7Eu32caLr5ufZpMuMdAzI57W5d+AreJIGjwL+q/kcmNK5bKm3a5YgNQqRNLkS6TohY7dq48Cx+Qdi0NSqQBQp0X2tDs5cEQZav/F+NAs+FAR67km61K4P3H/29m9SwESS5bxGx1nR8woXQ+hPeELsELi5QH6aLXW0QxkihuOh4VNl8hEDIB007yyRfQ9RZzwEwzkOw8jBrFO86bln8t1u4VXnTHvpQNGzYyQvoMc+UFU1om0g71BXDZOxmvUDAunoz++IlFzsyVGERjEbv1m6fhr++V7fgd5vYqhmcDnJqpzM5ACpaiu+rguHwUS7zqsvtEanXjUaN+ROCnEk+3aFsmw9qG+/Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(2906002)(1076003)(6506007)(186003)(6666004)(6916009)(38350700002)(38100700002)(316002)(86362001)(44832011)(66556008)(8936002)(33656002)(6486002)(4326008)(4744005)(498600001)(66476007)(8676002)(66946007)(33716001)(5660300002)(6512007)(52116002)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3OKfRMUaDbxFnfvFcKLAyqCED0M+I/Jhk6VWrha9EdX1KZnzX17fnnY18KL?=
 =?us-ascii?Q?iRQAYxx8jK9NVkmtouVLSVNOh2uwis9KzLGld5QQzbHBqLlvKH883oVc1MOG?=
 =?us-ascii?Q?AKUYnPVy8mmQOg5h04C1RA2j9mSPzVsTI8/lmzvKhsnE1Px0wndwIJ47ur4y?=
 =?us-ascii?Q?Fm0AkrfpzXdPXK/TBSOXRYxJ6n3DJO3z4ZnLZHVh8UtmpnbdTU9w4/ciRsU9?=
 =?us-ascii?Q?tj6Vl3mbBq912bOMQlyrQFIU01d2j0JOWYOMr5rJVuBtZS3UdBL72Ie+Wxnd?=
 =?us-ascii?Q?1+/z5rOXGhW3Qvfl1X1NyLyTH3znAf8QE1OQw3+ZLxHo8lOjqQYXyR37ujJS?=
 =?us-ascii?Q?r9Uxed6JluNmm2PIaLLieZtXR7FSvJrlR/7eRobZBsBlBZdOH8+0zBOomE9A?=
 =?us-ascii?Q?L/eHJJ0pLppxVZcjP09fUFAx81fesAgKi/vlAxrVO7AKA+xA8o4U6LCfxUOF?=
 =?us-ascii?Q?CXtoWakraIooBXzfxehOTjRzwzE0py0q1JbLVKXSDeivyO/qnxzVHBAOaLgG?=
 =?us-ascii?Q?3ve8A2/Gp6MGGwcUaoR+D50NbsweR4eCLz64qOfTJB0Kpu51qKH6Aw7ds+eV?=
 =?us-ascii?Q?HrXh9HrYXHU3cSVUCPnP0BkQ/QfdEYSlL3HZwJRPo2t7n6Lmz+1UGCL4vX85?=
 =?us-ascii?Q?dGOtax0i9Mu/hpkb4EvRcJwElxko2rRLmjX7PkmxarP4nHhvktC+NU5nnJil?=
 =?us-ascii?Q?aixmKo3Ms3HVUm90QIQ5ua3BbPX0cYoFRi/LHiJKYEvHzurL8nleQUrcR/4I?=
 =?us-ascii?Q?pZHfeNXpVeOM1WHt/Ity0zaYU6C0KXzJvRHimUilcl8ziTYFiQeXgB9rXYu6?=
 =?us-ascii?Q?TtN3mA08pcMW0YltDJU+s9NR5dr5J6eje2N5t49r7zrQmhtPCGh7fWD4Sqkj?=
 =?us-ascii?Q?IGE9Da1gl4IdVHg/U2ypZ39bxIbf9toXxn1wVIHfYo51PEKhHLUTdB3s4YC/?=
 =?us-ascii?Q?b4PAfQh533UODeODIOzax6AKvOfBjZ+VgTB/sbZHlfIHUT3Kae8TA9CijVai?=
 =?us-ascii?Q?FStZ4w4PU9f8HTalIV4PEHp3g0sPrEFLpJZO+5hHKN4919N3PXURglOA/ycz?=
 =?us-ascii?Q?o5QztSdqvK08n1MoyrLPxzyL3nZHZjRESuy5KjTeu+3nlIsiQW7z1MIVdzbc?=
 =?us-ascii?Q?XI0WYzNd7VREwIL6qz/6u8r7CNgEQ80KKerKfpkGREmmHFn89OCjbutLe1DA?=
 =?us-ascii?Q?sBV1974H7y9WoDeySUW33WbsuTQKXt18QUk7WFX+BxCeaMptYwmyQft5cB5R?=
 =?us-ascii?Q?bXzsCE3ktd9SduV8C8S7bxnfymx5/Q2pe0nVnnVs3i//wjeOoNHXXNBOJeYu?=
 =?us-ascii?Q?dkoWzaQgUpIeoDCO94tDo8Z1zth1Mbysidrw+XmPumEdv87pBOA70k2EreN3?=
 =?us-ascii?Q?G5ZbKiQ73VQliHJ5ZDsiG/y2LSTvDxBI1deM05Wdd78mM2DYao4rC0Xx0qHm?=
 =?us-ascii?Q?r+iEUEHqCFyzp45KSqSzM1eZR04FYzRL2aYtxjLnyS+KbUYdxebplllPPmyC?=
 =?us-ascii?Q?FVfeiR725yWZwhUtEe4UkeyglOtKB+Pa1Oc4Fzt5dLRGPvXTZwox8A9WAmnv?=
 =?us-ascii?Q?EXBOVBmzcVBdcDZui7miisrTj/3TPGReJep7Ppq0e2gadB5SMHxOFBqsd99C?=
 =?us-ascii?Q?nYPqszTKvrlHbO+Ba7FChP8ifkZE+pWfDk7YkwQ2gRDcV/pqEIqjt+ucG4Nl?=
 =?us-ascii?Q?2zfpZyurxrnSOE5v+XPF15VUwTvErDNNUNcI+2zlfJFLRakEzIFrcPFeYS18?=
 =?us-ascii?Q?WIbcvqp8FkeppjUn+nsWsyyYYwaZ6I8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6516beb5-56ef-4fae-6134-08da5292e440
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 08:00:07.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTHkmF9ejquxMgY4u9LpwWK3JjlzaVRnOAedbJuxJ7pTe5QQeVnvi2DJWGtxQsaPB2vA1lCbCy67jTny/QGAq1qLXYZSMAAKhqjPTfacVG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2654
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200037
X-Proofpoint-ORIG-GUID: EFTYH3W_jJ6JK18BRU6cpyJLoAlmEZL8
X-Proofpoint-GUID: EFTYH3W_jJ6JK18BRU6cpyJLoAlmEZL8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:39:25AM +0000, Zhang Zekun wrote:
> As dma_alloc_coherent() will return a zeroed buffer, we
> don't need to memset the returned buffer.
> priv_tbl = dma_alloc_coherent() and count_tbl = dma_alloc_coherent()
> should be enough.
> 
> -see commit 750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

