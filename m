Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2187C5AAAB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiIBIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiIBIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:55:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5743E42
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:55:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2827cMxt024967;
        Fri, 2 Sep 2022 08:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OKdnW6Oo5Wiv5jcZIPkQzd8AUeDkAdsjBcQNE4aK+EI=;
 b=Ayl2+kWJKmEZTJnqoXTQ6kDgPbZ+e2z3AkdpPPUq0YUjleVEU1QkeT9LnSMJdSyl2Dp8
 Sx8Ct81MSJadwdo1c2FJlE04/cYH/6MPFbkVsHV5MFtvFt1CfD2fvMxLXkHb5QRXXvq5
 gNop6eFu6XchF2yliqzk7PUsBw5XtL6ey4k7tSp71NIAUV5O5tHdXFc3MGnxWTgfnbEW
 HM12oXK0ongyzSv9Y1O9fOuHlwBrlP3ZlSw7Z536bq4OhoOD6BjJSohQdjL/lg5y+Lok
 1nvxjRNJdx9odbwYH+l/GoFBrVPeq6KNfzi624EH2bAzqQmMQwHxDtLfx180a3I16nYG dA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avspnxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 08:55:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2825dEek027719;
        Fri, 2 Sep 2022 08:55:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q74nes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 08:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mipoM9eTzr96KhRLSstTAGKWrU8L4KuuVp/YxJlmVROlJ46CyzR6U/hS2/R/7SqekDpJy7RDliVqIazK5vN1N/J27hWarDyGiyw/MdDUfv4uLbIKVbq7vm7YwCz1et4WuRb6NWinVeo0p1KcW1wiBA8c3FCdFU3sXtR7WaqYJByk99uqJNpbke/VKLTa7VusT3SCpV6Qu2r0fixFzC7y2bg1wm+R/AJTqqQxTHa+O0SosADRybaA/hYdCQIpavenJKzZHqb0VJzySPh/TaSic6gnc+Nx225OvcaJdjXKpGa1hLrCqzGF+xH+nJXmXARb5r4RXmF3euWUBSJJ1+Npdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKdnW6Oo5Wiv5jcZIPkQzd8AUeDkAdsjBcQNE4aK+EI=;
 b=URon1xIdtI2Wrgnynl8f6eTo6f6VWrzjU4N/f/xippEixM+gH6B/ZQ7mc5bbAg00vvVcA5G/S1Q4ZVsP8JRGTAZ2YtjjW/lj3D221hphGYnbzZ5mFX10LtfLql4eyhU5fLrrUI9ojx30uUdtf+rqOwQK4pGQcH1I9dB+MB0/nS690WQd4zkWz8muMd5YhmXXO4+jV+QX7FQ7tJ+0qgzuTaccZACRypYEbZQ0+Zv6EI3Bmny4eDG2fjIjvlQnn8veHy6lSp2/qCM9f/HmCih6vf4igNoGIueGCf7GcPRoC9CFsJJEXCs8XRNmQJHD6rWP55DekA2B6aZEq/2CtdywVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKdnW6Oo5Wiv5jcZIPkQzd8AUeDkAdsjBcQNE4aK+EI=;
 b=OeChlbEn5osL8SUgwOWtVX8GmDQ1MCT/Kwyb51/RTjtIsgE/uYK2D9lXZ09yCtZoo/SG9PUglPO/FC/BgN1zylPsoBsFdtwq1TQtG7aZMIIt+Ei/CufEBxeNcbpsuqAKE43yrD9jKeCkivQN0bNMnUZkAF90d87eBsdBFCDWFVU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6481.namprd10.prod.outlook.com
 (2603:10b6:510:1ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 08:55:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 08:55:06 +0000
Date:   Fri, 2 Sep 2022 11:54:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, martin@kaiser.cx, lu.fengchang@zte.com.cn,
        makvihas@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Zeal-Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Driver: r8188eu: Remove the unneeded result
 variable Return 0 instead of storing it in another redundant variable.
Message-ID: <20220902085446.GN2071@kadam>
References: <20220902032628.316333-1-lu.fengchang@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902032628.316333-1-lu.fengchang@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72abccea-0d7e-4cd4-a99b-08da8cc0d52e
X-MS-TrafficTypeDiagnostic: PH7PR10MB6481:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amrjMyetUuFR6wX1I+i87rtQKcuXGehjUDipE+xnFA4LWTpFnAU1q3iP+Y5AR/YQcF77NWtYIxM7wSbO2CFcSKDtO2mokm0QLXt0ZlxvDDQCnJfHx7E8KxzM7yNaKwseRqQz9xJnk2nJtNCgHL9BACM6rb7hhSmRl3tZSnFOSVgFcGz60Dh6fW6HLsqUECq44lcGFOvf96PxTQzq4A9fFNiooNHb+J508XSl90w9DK3vxcU9GOOV0Ta+pWrS82u/ka8oMX2uPvdycnTqT9C+UF6lkyCRZXIc7AxzWbwh0Sb7wwyQq85umUGJVjwLWcZhGhxdE3OReQMOBvZYsuGt+D8T2FTkyMJZp8fX96QgP3+kQys4RBPa3iuX5G8tLtNanURfavdR67rmhVbJ50ejMZ/w98IU13p4vixGXbWNMDTPSqJcMpc0mk26tMNFw4+SHJowjCRrpkAv0F//4+nLr/jv/FwfPxsmhN4xq36LXcvnZf1gJDqBn2tRdSlRdVs3vBd9nEI4ypds6JDx+ZDs0r7v43KlWjiAf8FXbsjvaUaAy+n9/QmNuVciXr6LQZKiFPzh0Kz4gNxgFnNI7RcDF68FekiffqvuESj/e6uqEmAii+ErsSMHhicFaa0sHHQpjHTwplpasToPvqOK3sEV7mjULbcEv2zZbr9bYAWsIaJeyrvD8SROmP6LkFmZhkmFucZuppF+NN6exieOhTOwUqxYuHrFqaqmnuuvaA0iOVuay2FdjaGQqiHuaeCcWNdGo3GF/ivbXbuZgN+eGnSqUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(39860400002)(346002)(396003)(38350700002)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(6916009)(2906002)(33716001)(4744005)(7416002)(8936002)(5660300002)(52116002)(44832011)(6666004)(6512007)(6506007)(9686003)(1076003)(186003)(6486002)(26005)(478600001)(41300700001)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjnvDErbmuv6YobmHjr0gX5HWN1SqeMloktzEDXf3uoNlIhB+ekQCqAe5mg1?=
 =?us-ascii?Q?chLmoVw7pgADp34lozT62HoVfdm2302gAcJHB4PsOf6RqoMr8hd+YHpzjQW1?=
 =?us-ascii?Q?jnAeKy/YQg0/kkg+SXwm3Hx3hxFm+dVMLLt+djCfFlqCWoLWxooVJOhdOrkH?=
 =?us-ascii?Q?iqRWFHyZdaVK5gXsIgLIjNSlgfFkWO5u+LLmGJGHR83Jp4TiONn9ea0AwI2U?=
 =?us-ascii?Q?xCypNRk1lSLY30b2VyzhFmvfAkaGUhqJiyFWI8VF/d0P4G4mDp6yG5xqRUFs?=
 =?us-ascii?Q?rGzLvwkBVndsxxwDTcYOFWTsJYLuv9etXCc2VH5yBxVTIpqFQpLuJpU2+Oib?=
 =?us-ascii?Q?CD671Y4WV5WskpQUnQ79n9dxkrIeYKakmMv3rOSkwc18kEvwrevCYgxt4c5N?=
 =?us-ascii?Q?lOamTun3nrEsRS3P/heaH+cVHNPJdjq48W9YA0wOtmNLw7J3SzhvlXLDvaUQ?=
 =?us-ascii?Q?w8i6D17WL5Ee/s35ncNFfIewhk9RgUq9cdTa6L5bKstDumgyP0iVPbHhQUvi?=
 =?us-ascii?Q?m09r72VbiWLY0u/bqU8Y1TGidJdKoQsT6cjoKGrJhXg2Dh0U685EChfC9Cem?=
 =?us-ascii?Q?INWM9MljZoO+Mm65p10Q6eJ5dToeVDY0xp15ej+LToQqLPfVHGCu+g1oOfwy?=
 =?us-ascii?Q?nf+v0aEcjIul+0AT62EotuDTxN6SJW/DnIeF8Nmz3JcW1et6seP9svZGptyW?=
 =?us-ascii?Q?5e9JQcdOK+I8zCzeImgauvsdcJJVMI0SAU8LrpjJzUabPhDkFqs/aWvNgO0O?=
 =?us-ascii?Q?qlDpmImBTprzn6SIfjtS6LMZcFfBrYUdgxbOV6COFMkgnAiPSqnxoGCuA6yl?=
 =?us-ascii?Q?QMaV1jrpR3r9AlVQGkfSuVJr/ZQG+xZiW5qwtSpQ8KHRBQPzIWYj7sjjsqDb?=
 =?us-ascii?Q?PzHi6XA17OM2DsiSrVQGNtbdAZM4Bbv4XuvE274G+nrv1QXWVzWhYmaBsYiU?=
 =?us-ascii?Q?3s9NF2hKvOmyrpVhLDpZT6pE4aLr5daZ1amjcDuqwZyZcJhovU02b6kMziSU?=
 =?us-ascii?Q?L31+SoAw1a4i95Oh50XqhELesfhPvhStLzY/b16fKtjxYnMeUwxB3G7MYsPk?=
 =?us-ascii?Q?OFtr5wEgaiwI144juWtCmRyx4mP0gOUzzz5EgmmRo9ZRND4CUPqXujrdZmnC?=
 =?us-ascii?Q?jWjL/8zKfCKYcviGiSSZzWEG/DlwaOo2UcK/L5fl1HJTLBpldwrPG9he6LH8?=
 =?us-ascii?Q?w9nMOkF/Wn6ACwtAZT15W++ji4kG7coNF93HXnbi/1ZObjcNBf4UySUOK4vv?=
 =?us-ascii?Q?t+etSnGBCZhJvYpTfcAploq0T8TLJVwW+2CHTBkNln+2QP0iz7aRdrJ64ByA?=
 =?us-ascii?Q?uWFB8oXMriKK9bXnHqAfCSpHsljAsyUdVALcN5kujx4Q2QgtYx9dMzy4VjH3?=
 =?us-ascii?Q?Ne++10SCmrE3iu7CRnTvthW9Mqe7zc9OpgINcLDjnKbBC887FfmFYYIXXWtp?=
 =?us-ascii?Q?Vg6qGEWYgQ7MHCMYLHApmlCirYvPkaZqDF84qiHlw0D+2GB+P0VkPP6L4Op3?=
 =?us-ascii?Q?qwzfmRcJ0FFrUnZHDE1IC3WmTQ7y8GpK67u0asxXrzayrhKDQwvzsAHb5+pB?=
 =?us-ascii?Q?ngnQtWGIQm0Ak9QYw3YgfXXUxn/BJnXDIiZmIUn67sjFyGgKEjkaTCLDqRa3?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72abccea-0d7e-4cd4-a99b-08da8cc0d52e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 08:55:06.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPx0XXZVLVq0SOM5YKlUJApiTg3JuT+R4OzLzLg+dNwwxpio75zg1ddgkTMG8bCr0Yt7CR3o0t45d0iKcXCXeE+9+oPfQuYlJwzVrusq3aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=650 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020041
X-Proofpoint-GUID: f4kl0-j37UFlFGQZgcN6kVEwzoXiUFdg
X-Proofpoint-ORIG-GUID: f4kl0-j37UFlFGQZgcN6kVEwzoXiUFdg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:26:28AM +0000, cgel.zte@gmail.com wrote:
> From: lufengchang <lu.fengchang@zte.com.cn>
> 
> Reported-by: Zeal-Robot <zealci@zte.com.cn>
> Signed-off-by: lufengchang <lu.fengchang@zte.com.cn>
> ---

There is a lot wrong with the format of this patch.
1) The subsystem prefix
2) The blank line after the subject
3) Line wrapping at 75 chars
4) Your name is not capitalized
5) Greg doesn't like Zeal-Robot tags.

regards,
dan carpenter

