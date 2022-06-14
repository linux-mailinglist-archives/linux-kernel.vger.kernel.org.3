Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51654B3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355050AbiFNOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiFNOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:43:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8F1A395
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:43:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EBYGvv028312;
        Tue, 14 Jun 2022 14:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WZLWm2GRDxVCnTzecoazH8KRURQbZ9zm2EbOl26CxGI=;
 b=g/NRIjRogFWKhLGHwl9dMyNeQ2M+si73k9m5ZwQGmDQU8FfKg/T64BPxdgyMsvRw9vPV
 QZEm7KAXXUE3PhxSfxNsZ0US7Z1xmpeD68G/pvjIOyoB05Q9qnE2A+JcsAs3KOZTZKJ7
 ak1hdZm1ZwIHGc4+Wv7XoGUKH+dG4TosRpti6dGXd426/BeGIoVQryJMXn9Hj7oFPMDr
 lf44Uti5l9NyZxHhP/WyxwI7ct30SwxunE9I3gQi/0yNWc2DWv455HC33ECN25Je1G3j
 euuLOBGFLDVvjKyceLrb28LNa+AdoWpBJqNNF1m9TWUT/HALV8V6pg3KdrmBX0hP4fSD Fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns60ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 14:42:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EEaNFT010415;
        Tue, 14 Jun 2022 14:42:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr296y39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 14:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmN6wYvzChi37Ht9NCabYjPS7UoywPUIOQSiycT9Q97EfckEyTxm33jOLBpn6Wi56MwWXe7dFwB6Cm+VqcNTAKJvcLJr1xyFjvkUSO1H6/7ZmH0ROSyLXnOCj5YQZJj3KM4BNVOENqveJbpc2hgoxEAvfsNOlcLp4p7gqdY+ggaL69n87wUJpY+RSwsynD8NS2X80Nus/7Cqn99r7a87QYU+Ip3aesezeK0Gz1UpudI+7b20DlTjvmCBnXndiTkaCTPn68J0mndQtI5rA/lEzGAVyYQyCAcvs3zMrd36/B0KW3CzzYh/yUOJfz69u5tOGUPAxD8BA2qXIM9vP/gOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZLWm2GRDxVCnTzecoazH8KRURQbZ9zm2EbOl26CxGI=;
 b=kZubjUKTqVSxiMor1VARR2ZRRMoTyrKx+L1x/5BGXxQ5V+X+r4pWGa7dq2EDFG7Vrf5Qv3/bSPiMqQNaRfh7CYBAEU5J0WbJiv+1lNPWsLQNGB+Vzuw+GSuuUwB1oAFlDD3gfT4T4yYKYQn50uOQg/82Pd9Nd+1EnOlBAWd4JcsaGqV/F883or83YSI2V68DjQNz0FOxC2Dn4347OnxjA7JCWDoe88QME9Lqlhs0wrfnHonhW2vm41iQwPF4UYXvkOvq817v9JhY6saRm4YBp+AVntL6oBkAffpqEf99gL+Uy8NNkDgEcKa193UaO4Hp3ZwnaXtxa/kLTKjcwED3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZLWm2GRDxVCnTzecoazH8KRURQbZ9zm2EbOl26CxGI=;
 b=RKEjf607994JyEPOdiJDO5uBZCZOS8q+ZkFVfjsNkIH4oF3lnVlaaPc7QVgjh7pL87d9YKwFfDd2wSwrdNvb/XKjB3XTd+u1AdKFq74XGFbFjCDQFU3n6+UaFqolFL99YoEz5kHoUOAaxnB6JNs4RcCfBX9cXE8uB471HeXI8Lk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5244.namprd10.prod.outlook.com
 (2603:10b6:610:d9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 14:42:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 14:42:57 +0000
Date:   Tue, 14 Jun 2022 17:42:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: r8188eu: remove leading '_' on
 _rtw_IOL_append_WB_cmd
Message-ID: <20220614091654.GI2146@kadam>
References: <cover.1655171591.git.ozzloy@challenge-bot.com>
 <a1596a62d8e63afbe6a645919a349a8402277c5f.1655171591.git.ozzloy@challenge-bot.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1596a62d8e63afbe6a645919a349a8402277c5f.1655171591.git.ozzloy@challenge-bot.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b59a3c-ab21-499c-c1ee-08da4e142bd5
X-MS-TrafficTypeDiagnostic: CH0PR10MB5244:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB52444E7D104F396A0B05ED818EAA9@CH0PR10MB5244.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyWKkepCFDrBzORNGu+VsR7u7iS3f0/K0cm91ILyVtT3M3g2RWwx1Vv6PHjiqNNMTOiOOS/wF2Xm0VOISShtoliJS6bjhWa0dAnaQTJnpfqRSuuSIn5lJRpZPMH05FsMZ8kob39x26+aoBe/en7HBjZsvypr1Bot/eeQdZTdubzIvjRfQhiz0N4Irjf8sCbwLZJ1ac796idmFTTUwN2PcAJTXrI3IzO/MItD/2YhERdiCwZd3lXVUbxOekF8CU1TLykgUfAcZam3vIbGNR6tN8Z3NWHl2SpRbMXpfkyXFbijJbUOkg/meNtyrixQUREM5nXCYpBnMIHuylVpbPJhXvQWA5bjlgYvdPKHiAYini/B14EM9womBoSOrM4QyWyL7NIbRvEhAxCwiUPU5zFuPVNRwC3vXiII1irzuxZzgjPnacvl0zjyOqCkkndMRqKHCdZR+WLJkp4Nn7oS0jHLKBw2RZeONurnQISUexChyYEzsGkEpQG6xAXSdW63qoLtbCQ2zqBAhhM78UI7vMNfl4FJM9fmVLEJ6ImbrSJ9uTdXF0DaHJjxxrhpWGUrhd4Y2/gsaruXg1iqiytL0Ak/VVLI31KopJeNVTxS018r+B/smpBg5+H7thpswYSaQ5VzF3HMpXAK6pj+fxCrQuIN5+VY7Jg8UVUjTzkGBpbCCEHCNHc5MZ54hKs63+1oPyx6XLDuDDvs5oG6t6A/KqMeHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(26005)(6512007)(38350700002)(9686003)(6666004)(38100700002)(6486002)(66946007)(6506007)(83380400001)(52116002)(4744005)(44832011)(5660300002)(33716001)(33656002)(6916009)(66476007)(2906002)(8676002)(54906003)(316002)(1076003)(186003)(508600001)(8936002)(4326008)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vOY+3IpMOqi5Jmyn6H6u6gOx11mOmsWZwB7quZf5cMvA0/SlBMRb0UtY6A0h?=
 =?us-ascii?Q?OkVGBKzdCdHUOJKFeHjJW8GaUyY+GIL73w6bUr908GxLNHeU6zRhbCLNqmXs?=
 =?us-ascii?Q?Is1bsRfMhb0EFBTE7yAIyAsvzv1CFBzuA1CF8qA4UBODiiJOIZSmOQsRP2UR?=
 =?us-ascii?Q?Bqfd/PrcCkkWrzJ7Oc08G2RsZkw5xpD7a0YX/SklIlm6bK68iRupG9qvDsoo?=
 =?us-ascii?Q?3eC0xhbhX4WLDDaYs780TTvjQFxW7aoyR3vOG92DUYNJU2ph6DQSgTTT9PHo?=
 =?us-ascii?Q?jaz7LASKEpJvhvERSzazvFriqAUybxufeBGxJ+RfJQYkTKahd65TjcWMua9o?=
 =?us-ascii?Q?2LyEzwgqh2b4WybPMuPiNlGsSuFEBgk8KyX349scoZkrwesZ7wip7lMnRHbd?=
 =?us-ascii?Q?/ozb8btb/NnH5Q8djQYCEQJ8kcaTbWsZAXN/sn9R3nqgFALQmK8v78YAB4rt?=
 =?us-ascii?Q?WR8k9Uo7Z+IuGaxxW6+2VQfu8TMXbEu5wjZgZsAP3zrfaQVr/8qcZa/HlHr2?=
 =?us-ascii?Q?6XtehkuzIOqAJSbKHdmDiSzZcja+eWi5G1Ei/0OMZ9mdIf9KbKMylpDOY4e5?=
 =?us-ascii?Q?a4CDZj5rJDFwzxQoGb36iCNaNyaTPuU/WzH9fVVwYeZTJjq04l2ItkBrMEKr?=
 =?us-ascii?Q?1/rhtwUYzgJMdR/ilO5mNraFJfH3gooDrCViOQ4HNJmLMxbl7zAXrxKw79cO?=
 =?us-ascii?Q?fqblST/ailCqh9jucUB9eBbE3bQydG2tJFfDybfW/BSDURc+XTRbK8TIoiU/?=
 =?us-ascii?Q?3nQRw3noR36St8Vu4YOkSfsLCRGwhNLka9wni9l0fbyIPMU76IUGA1Rih6DI?=
 =?us-ascii?Q?eKUrk7niWTWuG2Xj2nClWWSpXV9DGXUBLFZaBw9x/kaqoZjhAm0We7KrfOAN?=
 =?us-ascii?Q?Kd0mFxeNNGX2rY6+Ay8TrgB6ncHGk6halKoNEs49Ydtr79DCGtzu/S/M4scZ?=
 =?us-ascii?Q?DrVoixvu+FCTJI8NEWiEtTWHEcIr1uEndtLVLiWzz0MZsSQ1klaRdqqr1bL5?=
 =?us-ascii?Q?EimPgR0Js2/qmf3uzGK7o/G9fFPoULbjhDiaBpZ84o9KThiwYeRKOC2ieSnK?=
 =?us-ascii?Q?VH5lWie1C8pRfOgbTEvB54aMFhC7T9CTFxGSE0qSuFrVVF9EWeYkb141I9Hd?=
 =?us-ascii?Q?nmsHtElj8TRrh9sfniQz5W9zV47rIdft7Le2PyvtbG04N0YhTENMGGBc6iGW?=
 =?us-ascii?Q?3qtMyWhz/Q61MQHQFgfWoRHAcdbyDJNGPUciJzStdO95FCmJoOI06zVh6h9B?=
 =?us-ascii?Q?YUpvvrA+I0it+YFsgb3jcaYz7Oa32dW+jO6IHCaqoG4ge14vzzpsQInvcJb6?=
 =?us-ascii?Q?kUMXb0gSvAAb7uxNvrT5hC5/P+Kd+Qf0eYYM3lQI4YvAeDZOrjaLBdiyw1k8?=
 =?us-ascii?Q?oAcSEPe34bD4w7acVMeXtgAgyPG8SCkMLEBZC9lEfimyYJuZ7L5Ve5Xaf+Td?=
 =?us-ascii?Q?SNqzjoMkwQrA81ZjaGkiau+jSGoHHuCPzgLoceAR+5kq6tTR4PuCpOPBRZ7e?=
 =?us-ascii?Q?ntDaryYtG1rb1mgetjq5ezuiPfUTyoybrqK2SfdWZWj/Komjp7bBZ92qjKQ4?=
 =?us-ascii?Q?ff5BjPt6Sebfo5Ty/+6ItLcgKtHqVHnX7QZyhLJ1eOfFWP+UHbIMlHJGdI2d?=
 =?us-ascii?Q?SXDbkaJ9OdhyxSlbIsXnm0ccRhYSEno4ZdxgjZVI/4RejfnENVYzfeKVgKI5?=
 =?us-ascii?Q?uS8dXI4fn8ruV5oJYeiTkSC926wfxwH8w8ROE8U5I4yML9YgJdXGOZh9t5Km?=
 =?us-ascii?Q?27XB1xnXcHtq2As1nZGmerwTLlBlbpQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b59a3c-ab21-499c-c1ee-08da4e142bd5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:42:57.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSGvaoR6cMe/MGTn3h0K6jTnC/E/vThTZC44txi/rQCn4Pz02Eyr5Tt8WU8hpaBm0OA9qBmKT56phRzjKOaBOwwrQAdTIpDNysooBOXRcfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_05:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=836 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140057
X-Proofpoint-GUID: RkPOlgEbnKYYTo1-zlr7YCKx5CfiNiN5
X-Proofpoint-ORIG-GUID: RkPOlgEbnKYYTo1-zlr7YCKx5CfiNiN5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:07:30PM -0700, daniel watson wrote:
> From: Daniel Watson <ozzloy@challenge-bot.com>
> 
> name the function rtw_IOL_append_WB_cmd and call it directly,
> instead of using wrapper macro
> 
> delete wrapper macro, which is not needed
> 
> NOTE: code compiles, not tested on hardware

Don't put this kind of comment in the commit message.  Put it under the
--- cut off line.

> 
> Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
> ---
  ^^^
Here.

You don't even really need to tell us that you compiled the code,
because we take that as a given.

regards,
dan carpenter


