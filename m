Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B914EEAA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbiDAJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbiDAJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:45:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2711D7B9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:43:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2318jOox014843;
        Fri, 1 Apr 2022 09:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=la4jggkM5xAMCyR4dm34w6/gLBH3kQBLYUGi/VNgpcs=;
 b=KnDoq72ouXhf1MNfX/n11itqGcZp22pirllhUcbe0GyYbSnBE9LicXfEslNAjI3phCY6
 5CZ6FKZifaJTkpTEIkr45q9BVi+z8Hta9IwlIBlT+NIuKhzQVHa9RowPFiqXDDuTfpLa
 PFTYdfEusK7wiVzREyjeyGJoyReBZwMJBGYSm7xlXLEA7k4kvU9SsGwMQXMo/sHEcsV2
 yKHMMVpUz4/WbPjMNKvzhh0Enqjenj728FEhEG4HhC2egq1Kl1PIfgQ38oxtmXjazS8M
 0CvECvMqsJVhnrbYvU9Oy3dByuDzA5yTULsuoGz/jGaQDfdEWiFZ+x0iYxT4I+G0NDgP RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2pngr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 09:43:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2319VNpf025522;
        Fri, 1 Apr 2022 09:43:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95v3nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 09:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZacSKkuuizAlFcEVyh8rFPlRZFVHQywGfX555RF0auq1xoUBtfyR14EmdKOO1S82WB6CwGn7EXOnHp/E/bI5MEoU7NsszXhL6VeaUpXhiD3hxQpS9QAgsNQLy9CxXsBiNYdD2nhMbUfAlzc7Zzd9M8IHihJijrO1Kzd22SlNdtdI2RfW6TFa8vSqHT9pWfj/ZQ6auelycfL71fvz/wADdMAmSXf9oqLzrYVpW8/j62vicNSn3CPeCT3fo3HLj9mkSkeSAc8sdUo8QlaZmGPBK90uGTwYshaynhiQdltwZHS/WQJAJJGLDKi5LZq+LPuLwjo0c8p1RSTslcJZ7VyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la4jggkM5xAMCyR4dm34w6/gLBH3kQBLYUGi/VNgpcs=;
 b=RmJrcrzNoyLfWbF6Q6Lt5QcByld4BYTLZZgJ2EoOTniO66PGjGZTv2rZJ6AUwC4iuEZ2xnFicTY0MkDjmFbUysbB4pdNROrR7CR0Iu63z2tvpNPKV1wSfj5wn6sRjqn2D/Mi/PVvwwIusbkhjGrVlQixh4ebBIFwszC/rpcyhpdD3x8dAnDYAWjWu2TonrorkbKBQkVE1y7BUYK+fPcbJFC+c7kjXSU0tq8PAmH8VEBqCco8Ge+Dmusr6SHO72h6SNoi1ptmOR8xCgiBbFiC/66tqOATPh977eUk0VELUhVD1DjwTLqw1AAJJD40XygM0FGw55bu8ceSSYYA1oWOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la4jggkM5xAMCyR4dm34w6/gLBH3kQBLYUGi/VNgpcs=;
 b=BXmrr8pE1PvNChZ/wVhH//J4uU7XyT80rHvdOZoOyCCNvMvoCQirTSJt0/RU8jOhnQ3isDGPbxsYEctzpljvsQwlN7hyGFuoyG+VOHBQRC4BrQcq4pzHwkXviYNWDSrnpw8x6ZeCFA65l3JCcL2l8I/RVIbdOzaJrNqZ11ZxYTs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5721.namprd10.prod.outlook.com
 (2603:10b6:510:125::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Fri, 1 Apr
 2022 09:43:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Fri, 1 Apr 2022
 09:43:08 +0000
Date:   Fri, 1 Apr 2022 12:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8712: fix potential memory leak in
 r8712_init_drv_sw()
Message-ID: <20220401094248.GT3293@kadam>
References: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
 <tencent_F3B552EEBF1CC810B36CEE23070BC54BF806@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F3B552EEBF1CC810B36CEE23070BC54BF806@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7970056b-14ba-4f37-2ca2-08da13c40716
X-MS-TrafficTypeDiagnostic: PH7PR10MB5721:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB572161592253F2FEBD43F2158EE09@PH7PR10MB5721.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CU3FNn+WhEqoITm9Zf1hPaep0dr9OttEvYTd8UjzwvKxu5ZAnsgVt3CwvzA8ClWlDv8Zqulk0l/Q5oNmEr5L5WxY2vDzyX67L+gcE7AWDXEBbVB8tPMP2SoA2qZMzkSwtS4DumUL4t3C+ArH2PCuvdGO2xED90UujRr5MQM67TtZt2/8VF2A5Z8xnlH3VjRCQzM4WfQskUkhoaxYJaB9jSaO5ALa7lgq1tmsFqi5j2Yan8tba+SM0YcQlyfrbLBBSqnLwTmSgqetAPdS+ARx6LAVGi1XwVxTjwCN8EQPLY45OGaRnMMXpiTz9zz3xiT9XzEa8q1/FbPYvRW9PdczLal1m47Q3ESbwcKFhrcg/kf7TGIvXQpf+wJ1s1Wjiy3XrhQ2pEcYJRJoYN+sBn2SrlEubaJ/VXUni61URt/HCvWrZ+ewnZu65WsHMQwp6Bn+hy7u9HzyKD4QFf3qFk/pS2A94FhHNoo+PwRgOzEEbx1ipfDvLD2NvIKliAlcUBQM/LHCAPe0Kd4KOaCWhJLJT1Dcw20aohvtVPnSsg8UhbmkwF36pFQuIt++w4+cDaQyZCGHo2qVHnVwP1Qg/hyl01lkheIjOu5yx6kHf4+kyXMKvm9Odo0YbUz+ljFj40b8zJ0NSzBUBcmif7fKsPMk6rQC3h2hZSbDjfxUY83nyneDG7NjUEaIH3ZF7i7aQAhx8LZ4TX5ZLYnvzuEZ8a+5Kaj+XjBkJ3n4HezbS6KV5Aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(6512007)(52116002)(6506007)(66476007)(86362001)(33656002)(33716001)(66946007)(4326008)(6916009)(8676002)(9686003)(66556008)(5660300002)(26005)(186003)(38100700002)(44832011)(4744005)(6486002)(1076003)(316002)(8936002)(2906002)(508600001)(38350700002)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Rj5xEZU1XJoyR1GlgqZo43zBEbEuuyGz6S05US+bZi25Vj+aMPdwWN+XxPb?=
 =?us-ascii?Q?0hxFl+8JzJpw/l1ACIzUU3oJYY45jLh8YEySh9twCLlflrEWFZZRbUigIe2m?=
 =?us-ascii?Q?c8sQHFJGaqko3+p17uq1fPCfhT9Cvqi4Nz1u88b/MGxUAOUECHYod3+iq15D?=
 =?us-ascii?Q?0ZGZPYOJQB8Pjg6V5xBQZewyt8Z7tocTvI3GgfWcvQFAgaFoqimz+ZH1PuNH?=
 =?us-ascii?Q?VQP0KV1/5+x3OGQqdMl8HIsQQAtHb1Se6egy23rgCuj4VQKqQl07ZXxwQv1j?=
 =?us-ascii?Q?o/LhBRKlBpcpHWu1XWLXylI6G1ei/pbfFlN6VF1NcN4ekfe+MezGhY2aUqXA?=
 =?us-ascii?Q?9tcLaob5kZBkk64wCEkeHP/J6mgVZdSjOYkcyMozsvJIecYJuOfK3CQy5gyW?=
 =?us-ascii?Q?mN8PwWtPy+tzTgLPC1T6mELeeNh8TNoCCjdFz0gnBOQ4Bl5bibLiydzkVPYu?=
 =?us-ascii?Q?m9r7+gTxLyQzFyQwU0144sFxCvKePFEAZp3sVDLBQFp74RYXYRzNBVH6ambF?=
 =?us-ascii?Q?I8HM8sp4QQjg0r+Q2kH8f1YpqK6Xcu/PaABk5ZFsAasTn7FAAlHAxPc5BOKx?=
 =?us-ascii?Q?l9sZw3cDhCxsvfiaoEhS3VvWeNYcBic4OI9gZDk7vBaC7a6Mf4UBm9zMRjHW?=
 =?us-ascii?Q?bHZjWhz6BUMn1Bv+6mAdrl6DzUuR37X7IsLt0kCALkUpYduHQuN8pEI/qlNx?=
 =?us-ascii?Q?iy5s6Z0qj4OwA/e5aHWMzoEK9Jx7VFOz1asEI7LB1ciElmCy78YvxXmergM3?=
 =?us-ascii?Q?uxoI1QOQ4G4vhefjQWycPlhVJkENfyma1FakZx9F+uR8wXfTxX0SLHdj/toU?=
 =?us-ascii?Q?ZHd90eE/AFRY29K68OQwInxAHvFefbepKIVaAdW2iP5oPzEPxJG2il0rVEUM?=
 =?us-ascii?Q?EefrX8KEOpWVUgY3Y4SS7J0LY/KNOF3vxFQ6RcuINJ5qouKDtgSTsUm668mS?=
 =?us-ascii?Q?uyh+LqTiZTlahx7FxbKZNUKpKgtSZP3mPxVYbzlG8LHaAEYaEkkCfoJ052MS?=
 =?us-ascii?Q?5cC2dvgXF4gEOFX9FRP4V/BSnk5vItcvFdriUSV2KsBwCfFGf1r3b3ZMrWlR?=
 =?us-ascii?Q?muRICTlsmBchF7SKRhFdIXNYcf28Q+uq5LF25kphL4/6gFLySiKjbEi9RLF8?=
 =?us-ascii?Q?2hGzKOj8SC3KcfWueiEr+1qeThBvH2BFwqamfeu7LUtv3CsZH91KjtPKPy8q?=
 =?us-ascii?Q?B1DnucBnZOYv5fybWm0e/Qj04LQtRxFO1YmTHCfn4nS/dUdaJYwIxT5qUugn?=
 =?us-ascii?Q?VlqCUZ6sjKdMBJ504MGWuVjFvbOZWr/nL4bWh7c+CK0Pbm8mhjjlflb1hgtv?=
 =?us-ascii?Q?JgNU7cQ2GH7KUyWKVI6+q1g71ibUZazJ3wDgsuNXKY73bMf5B4vRXhfPk2DY?=
 =?us-ascii?Q?X03TUVbX/VlILikr/OlvKGVyGkfuLf2hCjloICY4A76P6mP6yILhbyDQNYm0?=
 =?us-ascii?Q?gkC2FOTnVszk0+WyRzj60nZqnK9+MfL4EYHnLQcrCySBAL8VA/SL8m9gmaI3?=
 =?us-ascii?Q?i85WxZDEY8ITDEhCD4g2u+UayrK3mp7Adsvz2gtC7Kp3y8Te+xEqfYdofEA7?=
 =?us-ascii?Q?wIvxMfPA0cc5OGtXroTxNS4glWrapxhdyq13ORPhKu12f1WlBkVxefO+KD73?=
 =?us-ascii?Q?/qn9i/I5incxMyf0FOWjL9oztp5xuqnKyHaml6I5k7uaSHJc5Kep50PrW3wM?=
 =?us-ascii?Q?eoMdyWNzHUhdxRW9khh4xUqg9Fwt7CKvcFK7VzLGTpIzNi8MvleYlVU2hpgy?=
 =?us-ascii?Q?9mbB4zVznprOt3jue/q+hD2Jovj34lw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7970056b-14ba-4f37-2ca2-08da13c40716
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 09:43:08.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhNt420xipNFF9BE42z7+k9+qzKk/mp8MOI97lGYrOctNXN1IvxBPyHtQzHlm8h787TIPXcZni05EZf5Go0uIXzoZ65efRi35VRJlnwmJsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_03:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=851
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010043
X-Proofpoint-ORIG-GUID: DCacM2kK7wnJ9QuumBhcQ1BBW52NkURX
X-Proofpoint-GUID: DCacM2kK7wnJ9QuumBhcQ1BBW52NkURX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:08:19AM +0800, xkernel.wang@foxmail.com wrote:
>  	ret = _r8712_init_sta_priv(&padapter->stapriv);
>  	if (ret)
> -		return ret;
> +		goto free_recv_priv;
>  	padapter->stapriv.padapter = padapter;
>  	r8712_init_bcmc_stainfo(padapter);
>  	r8712_init_pwrctrl_priv(padapter);
> @@ -328,6 +328,18 @@ int r8712_init_drv_sw(struct _adapter *padapter)
>  	init_default_value(padapter);
>  	r8712_InitSwLeds(padapter);
>  	return ret;

Not related to the patch.  (You didn't introduce this, so it's not
something you need to fix.)  But this "return ret;" would be better if
it were "return 0;"

regards,
dan carpenter


> +
> +free_recv_priv:
> +	_r8712_free_recv_priv(&padapter->recvpriv);
> +free_xmit_priv:
> +	_free_xmit_priv(&padapter->xmitpriv);
> +free_mlme_priv:
> +	r8712_free_mlme_priv(&padapter->mlmepriv);
> +free_evt_priv:
> +	r8712_free_evt_priv(&padapter->evtpriv);
> +free_cmd_priv:
> +	r8712_free_cmd_priv(&padapter->cmdpriv);
> +	return ret;
>  }

