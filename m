Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C98593F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiHOVUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbiHOVLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:11:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01470D9E81
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:19:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FJ4QcN029344;
        Mon, 15 Aug 2022 19:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9kw6DW4dbnyP4x+0xjrfE76jfPl7u7VgYSipMLdtUKE=;
 b=0R7k32Bfq2bfbLFR0kOIH7LFwuFqWZDnpWHyKhP4UXMagRx38Wn1KSWrR/mxj0S+e0gT
 azZ7drzuNCpsbX6hnJxxw3c+UP8FRDlwTC9mEPSunoqc3s0/VufZm1F71j68sqgIwhRD
 zs6rpjGGeAAK9NhvutfKo9HHbFQNxMu+G9A/hOdy+aXP9AJ8ym1oo8kMk4A2bGEf2wjY
 U4UA+L/yUw3jUaEcUAmCEq8O3Kc0+/AhiS3lnBUowlTkwWxDRh7szdrsjP+AImEt35xW
 iY5gEWN6+MVeVRu4xpo556WEEKnGd9X3v1IWAeV4imMR68/mqFgj7UdCMlqZwdO4kQEv ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2j0kuty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 19:19:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIj4Oo035023;
        Mon, 15 Aug 2022 19:19:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d7p6y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 19:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPQgrOLksi88jVxA2bHkGlWR3xiWY77jtB+kVGla3n4CiNk9pBEGQanHGXcDMNHDR9wi7V9AxGVDWCxsQ+OJIfUfnDnipO7z2imrSDegiG5n8gsC2ahxK8MUpZs4YDG0c4sn8hvToVfo5RB/ctqJSsFByOEMhSoiH/k6b60PouBzixT3UyoEbK+Qn9zfFjCAsOe6qFwOUg5ikKTAYhnpaIWgc7h1pdELqUcdh81nl2iN+fsxXv5Wt8GPVgGDWMK3QxiuJwCdJX+8b7jVgJsXWTHw1xbfC88dohJ+SJcYbf9IjdwafeJ+D55yQ0LWm/RlzPPIPjWpN9Ikuz0WxeqZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kw6DW4dbnyP4x+0xjrfE76jfPl7u7VgYSipMLdtUKE=;
 b=SSfvnZuXf9KgGPLLVwEe5w+EYikDNwkGyhe30lOksuLy5NhzFObJq4WLOCIX2A3Rc/x9v8/moxff0JXuMzxlrYlDO36xEiu4ounAdvELcdJE4w+ymVOTpGKhIQwbA8SqlLC5kGPVPwTEMQQDD3j5jtu7WGd3wRHMT6xivKM9/8LJDG0Jno/iU5V0SKzUUDI4JuuxX0kr0ZDTMRb9pH872qEA8JBEjuKqDZzjeFPgdhcDmJSywLWMZRPuSuXffGka7Kc45Q1UG04SEbDr3JX+ucx1e2HH2IkBp0Ntm0EjUgPpmsfExtTkJxxP/YYfPksbv50131rvLpEY9DbsOTOYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kw6DW4dbnyP4x+0xjrfE76jfPl7u7VgYSipMLdtUKE=;
 b=O+KaUylLAV845sxPlTSCfeLq7ZCTyHymQ8Bt0k+tY2XvjMrOfI6pe/LO31tnVsYXoqYBN/2Ki/p2ON8f/uIEVRnzorKxc3O6xbsqJehpzqVss549asP8yv+y1FqawQPrZfmlTgsOwymDmYJGR+FW4XRow99otxBZRkFx8Oa/pa4=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by PH7PR10MB6177.namprd10.prod.outlook.com (2603:10b6:510:1f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 19:19:05 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::ec9c:8101:99b8:9d57]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::ec9c:8101:99b8:9d57%6]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 19:19:05 +0000
Message-ID: <aac4a43d-4999-1da5-a617-b512ae0b3982@oracle.com>
Date:   Mon, 15 Aug 2022 12:19:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
 <YvonlUOgMbla6dSh@worktop.programming.kicks-ass.net>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <YvonlUOgMbla6dSh@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60117c0b-1c85-4c2c-b38a-08da7ef304d1
X-MS-TrafficTypeDiagnostic: PH7PR10MB6177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEQtLM13ja3tzOl/AnzPMLVMSfxOs9Ifytomldn+ufjnflzsdd3KyGfvz7Zm3P4Rd6R/vRP14BDRPd2bRRmOCNFyzbWGqaAdz7eeu3af+TK6epCR89hJOKlO4Yw0du+U7bHezbvc227dyq9mk2WXH4CccXlRXplGm3fNSwCrnAsgyno2+8ZqOMYhrMSz6V9cAicb6WrjNA/kf/z9lcVH3442XHSfTQ01XrMMWgtx+qm4BTTaB4diUF0Sr6s7Jniy98aUFp6mEOl6E/5b9AerRTy0/Wr/L8eIgUhTGIMbwpBRvLAOOITrWCpJ26NdOogpY7bkyz83GZzEHJj0+ZT3HaoOBFshOGP3GroeYVN/R82Aspg+ZNhYrvOfjYRBon4HIp6zbKbW/PbVaBq3PatThlC6dDpjL2d1R+sCHYq27dWJdLDa3Com8pr04jF6l4fVyy3AMBGGGcU7psI8ciMkOPuqROg21TAKR+iiLAuRoDJi3nji3Ft9SjNKLwzb21l4Y7PCfsnU/fOy/NjrPUfRfuAmIdziKkzLj965nPU97T8/Mj10oaZBl9/Bc6zpM5r1GThA7EzTyzNTk831yLEXa3VhBLrBmqwLSTvbxMQtaLE5EZxdu+fTLJqfxMupbhb03e2wzxlrYnGdE68w0IcAf9Zx6YV0pQympgn0bY+Lr1Mx6e1p1FQq3fs+ZQU9enswIrYG51AF7Lbr5ZDVxCWd+vfxD/zSRit4QyknMmWB4W7+MHIVG143laTsgZcZsZ/hd3CpbvM91JealiJLFMCdC8LkH98WCwDFL3viaXg0Yql6u3b0z1Ey7o/LBq7cQmkRhES5rEszylK+jWw0OLyqEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(396003)(136003)(66946007)(66556008)(38100700002)(5660300002)(4326008)(8676002)(66476007)(186003)(107886003)(2616005)(478600001)(52116002)(53546011)(41300700001)(44832011)(6512007)(6486002)(6506007)(6916009)(6666004)(83380400001)(316002)(36756003)(8936002)(86362001)(2906002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlXTDY1b0V1QVRQYWhLZVo3N0ROeU9YOHRjYml1UXRsRmdWb08wL2IzQncx?=
 =?utf-8?B?cllZVS9UL0Z0SXF6dlJ4VkxuVThrVDRVUFVrbk0rNWRLdlBDTnFLYVU5S2Jo?=
 =?utf-8?B?cXpCQ1dBWWJzZHRPeDlML1Y1RVFlTDczYy91dThQMERBQi9pYlV1MXZUWWM5?=
 =?utf-8?B?eXpPRmxIbi92a3V3WHFoUDVycGFnYzJjTkJ6dTBVdTZDY3RHTWIzYVduT2lG?=
 =?utf-8?B?YVM0VDZhWkkzV3UrM2RKbGE2ZGpaallPcmRMS1hkMjgydW9XVFJhYWhRVTRx?=
 =?utf-8?B?eHROU0t1WHJqZnprblBDTitld2srdDg5bFB2RlE1cUsvMHRQb01XdVhyMjRP?=
 =?utf-8?B?M0JrZzFKUGZHdEV2MkRGdWlXM3U1aFFXa2dYWFBWS3hLS1JLcVBYbHdSRDBQ?=
 =?utf-8?B?dENoL25MaDJ1Q05LL1A0N2krVGFjcXdmY1Zhb0psaXhKMmxtcXB3R2s5RFg1?=
 =?utf-8?B?Mm1DbnExYW94bnpHTmtycmU3SWJkdlJVQWkwd2pQU0FNMEcyU2JGb1RPYWwx?=
 =?utf-8?B?eVh4Z25zQS9EQ3BzcnRYbE4zdCthUTNQWWxMeEdVbnpvQkFteUE0aWFtMGhJ?=
 =?utf-8?B?Q1gyQVJUVjVvMVdNNnZBT2tMOUlZb3ZsSnVJSC9JSDArd3U1L0pLN2NNZ3Vo?=
 =?utf-8?B?Wk9PTG42SjRESGVQQmxTVzdvbVlOSG9ScTZzRjY2eVVORk52RlFteGR4bEVZ?=
 =?utf-8?B?djJmS20zUlk4elNYdHZzTkJUc2xuNndvT1IrWmJHblNNQ1NPMkFuRzJ4Vkp0?=
 =?utf-8?B?ZmJSUnRsTzY3Ky81UVMweHhVVW9vTjU2b245d1pvcXNSYVN4TXNoZkJ4TG9y?=
 =?utf-8?B?MFJSc250NWFaV0pXTXVha3g1cXJMWTNTeUdrN1dGcmhTMHVCVlBGd1NUTlI3?=
 =?utf-8?B?dFdGZFRjeGI2eXd1b0VoREg3ZjBrNzFla1lmdU1mTEdIaWZaQWlLeTh2Uyts?=
 =?utf-8?B?UmcrUXZTUDc0bHVPUU8wZGdjbG1pMW1qUndtZTNIcEdVSmdIUTR4Vnh5KzBr?=
 =?utf-8?B?M3A4bW5URWQ2ZUFaUlB6c3YzalZsRklWN21GRWJucVlnaDN4cFJCcEJmTXNr?=
 =?utf-8?B?emVnTkp3UThyK1QrQzhLMXFFYkVNTTJNQnd0UFhGalEzZlVkM3JBbmM4R2wy?=
 =?utf-8?B?N3I3cGxaeHB0aFIwbnk3TUZxeG5uYVdBOGdBbVRwMDZ5cnRpS29mbmhRUU1u?=
 =?utf-8?B?Wkx4UTNyUVNPbzRBVTZOYUo3Sm1kS1gvR2c5blE2NS80UXVIakQzZjFKQUJN?=
 =?utf-8?B?V3hCSm9wRTI1b296NmNHaXdwQjd5OHo3K0NnQTJVOXhJNnJIa0tsbWx0dytT?=
 =?utf-8?B?NUhiYUVtWVZURkVrZ1BpVjZhdUNncGtWQnVvTGNtSmxKTDl2eFdzWnd1WXZK?=
 =?utf-8?B?cnJ4Z1NwNnloZkZEaWRwcEV2SjIwbDRUaExYR0NraGZvWEp4RExxNTdESzcv?=
 =?utf-8?B?T2hJb2JsV3kvcWNmL0llZUlWcHcyRlA5NlR1WUNLOEs3R0ZHb3h3VTQ3YkFZ?=
 =?utf-8?B?RHg3UzFKQWoxanVCbU14Sk5NS3VVU0VFSFV6UEpzaHRtVm9OeGxaWTlDN0xY?=
 =?utf-8?B?aTRRcDZFeWgxcnVXUk9semZ6MU44VXRQbUFRaVNuM0JQNE1jSW1ya2pQUDNv?=
 =?utf-8?B?VGxacVFLSmp4Nkx3WnhsUVFNbXp5aEl4MEN6K3lLcUdJL1hJdFJVTkFWbXhM?=
 =?utf-8?B?MjZIQitBd0xPWUpPd2Y4MDF3K2tJb1ErYUp3cjVMR2RzZ01lY1c4eG1IZG1x?=
 =?utf-8?B?VGJ6eUd3OExPUVBaUEllV0RTRmNvaGtBTk9ob2xKbm12a0NwM2c3SmcrWUpZ?=
 =?utf-8?B?RW1jNlEwSHV5K05HNVQ0YWNsM0xSNVdma1llaDVYMk5HRjhQOG1RWTBDdy83?=
 =?utf-8?B?ZlhBNGRxZjg1L09ocldNa0F5TWJmSGZKUHRVamhSNll0cGo4anFhdTI1Q1Qw?=
 =?utf-8?B?bUNnbUp6SnJ1M3pkQldQVHlYbzNFQW5ya0t3Nkx5NWtvUlQ2SDVzZURPdHAz?=
 =?utf-8?B?elc4amt1RkN2NjZDNXVISkRvbGEvUDZkUS9TcElwZ3ZDK29rc3ZoSUNpZkNh?=
 =?utf-8?B?QjJZZjdSa0hlMnRsQmZSZnB1VnpaM0RGWHdmaG1Nb0VBYkxPYU1wMkU3NndL?=
 =?utf-8?B?MG9jQU43MWFGSmE1YjBVVFFicWZEdjhlc2F4YzN4WmovYTBxYzJDWnp0UXNO?=
 =?utf-8?Q?buH8ga6AZqgVmyfUO2746ZI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L0tNVGNFM0xDOXY1MU8vTGkxeitQZVpDK1JmMHhxRkpiejROSWgydlhoYXhC?=
 =?utf-8?B?OC84eC9DaDNiSU95eXcrNmtZcjZBN1VsR1B6bG1zSW9qdlNrV2NZRGwrODY0?=
 =?utf-8?B?M3NwbkVlUkpVSmxydlVnZzRQQTU3UCtuSUVidnJZN3MrdnJ4b2ZvaE80YlFQ?=
 =?utf-8?B?N2tqKzJTbUhvTERGbG1DNWxIYU42MUZSWFhZNVNjckY3K09NU3N4VzJUaHBX?=
 =?utf-8?B?SHhFZnJDOXYvRWpmZzFBbE1vOUQ3NTBkWDM0YWliUk9lY2NJRTJKOHpjU3pU?=
 =?utf-8?B?dDJGaE1nSXJ0RVVHWnNMY0dTODBXOWx6TmhHTDVXZmpXU3daT2JmTnYzR3dW?=
 =?utf-8?B?OVVUdllxQURqeUp5bnFacGJYaFNwUldPcVdnZWxNYUdUcEtJK3NFUklucktU?=
 =?utf-8?B?Y3lZaW1sa3BGd1dkNC9PNTRzeDJUUXBPUjVENUN5YXlmSFdOZDU0dmNxMW5C?=
 =?utf-8?B?d1N5K0gvQ0pJRTh1UGhvRVFNWklpL2tVbVQvNXFrZlZST09UT05JaFFSbEsz?=
 =?utf-8?B?NktZMTQzNEtheTlDeUxsNkFtdEZmYllBZHg1Z21OV0ZVVm1PbjNYSTBVdDdy?=
 =?utf-8?B?ZVE3OHE4ZUVzMkY5ZW1hQnN0aDFLK1NrQzRWU3U2dWZ2MUQveHJJbWYwU1pD?=
 =?utf-8?B?UTE5bTNzS1YvOUpSR2pNVERFemlhNmEzc0tFUHJXRjFLR2JrNnFCTjdOS0xj?=
 =?utf-8?B?WTRpdGErSXZHWEs3MERRbndEeVJieUhmS2dNTk5YWThvQ3NkdUtkS0FpZklz?=
 =?utf-8?B?dXFTc0dqSGVFNzdMT2d0Q2NMMGdocW82MWtac2NIcDdidytrd012U0p4ZXJF?=
 =?utf-8?B?TDJjOWRVVTJIUnM2WEtKNGpkYU94cW92WWRNYm5NZWt6UElKaVIzRkVVc0Zx?=
 =?utf-8?B?SnFrKzBxa2drTHBRZ3dHSzVLWFZUbjdaUlpmUEhHNElOZHo5NEJVNXlpUUxR?=
 =?utf-8?B?S3lpVFgrZUkvU2RleENUelRaUytpbnFOQnFqbFpoME92TVd4M0NRM1JIY29S?=
 =?utf-8?B?MS9BOWxiQUQwRVVrQXdMSFR3SUVDUlMrNGZ5MmlYaUlRSnlXMDdYVk11MnN1?=
 =?utf-8?B?aXB2MWZ4cW5tQlU5UzMzVGUzT1NaU0pUSkhUUXdMMDU0clJibmdrUi9oQ1lY?=
 =?utf-8?B?VzBsSGRURi8xQW1NSUVUcmI2OWc5aUJHSEtST3BKU0FDU1g2UDROKzh3dGxz?=
 =?utf-8?B?M3hVZnJWOVNSZDE2aFc1K0xVaVdTSzQ5aU5GaFRBYk9JSFhab2hudWI1aVNt?=
 =?utf-8?B?cnV4bThGMDM0dERLZ0VXK1kva1Q3aDF4KzVTU0NpT0QvbC82UDlHS09XNFp3?=
 =?utf-8?B?M2pHMnptWjFVMXdhcU4vR1hwQ2NaeUYxWlB0WS9PVHZPWStYSVJEYWY0SGVx?=
 =?utf-8?B?Ym1kUkZNL0VJWGhhZzZWMm94Z3pyY081bjAwYUYrYzVmejZ4cVlFQWF2V0Zn?=
 =?utf-8?Q?EHC1zM29?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60117c0b-1c85-4c2c-b38a-08da7ef304d1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 19:19:05.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJJWEJokAwvFezssPJuCClLDMP7ntUSgIH8YYOsuoS2KFMj87jG8L5XPWthbu1Jg0uqTK1IGmJg137hH5dk8qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150073
X-Proofpoint-ORIG-GUID: -mRl_wcgF48clhsVPr6oaVdEC-goWKu2
X-Proofpoint-GUID: -mRl_wcgF48clhsVPr6oaVdEC-goWKu2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/22 04:01, Peter Zijlstra wrote:
> On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
>> There are scenarios where non-affine wakeups are incorrectly counted as
>> affine wakeups by schedstats.
>>
>> When wake_affine_idle() returns prev_cpu which doesn't equal to
>> nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
>> in wake_affine() and be counted as if target == this_cpu in schedstats.
>>
>> Replace target == nr_cpumask_bits with target != this_cpu to make sure
>> affine wakeups are accurately tallied.
>>
>> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
>> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> ---
>>   kernel/sched/fair.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index da388657d5ac..b179da4f8105 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>>   		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>>   
>>   	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
>> -	if (target == nr_cpumask_bits)
>> +	if (target != this_cpu)
>>   		return prev_cpu;
>>   
>>   	schedstat_inc(sd->ttwu_move_affine);
> This not only changes the accounting but also the placement, no?
No, it should only change the accounting. wake_affine() still returns 
prev_cpu if target equals to prev_cpu or nr_cpumask_bits, the same 
behavior as before.


Libo
