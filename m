Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32A554286
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357109AbiFVFye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiFVFyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:54:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6088D2AC6C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:54:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0J0jd004468;
        Wed, 22 Jun 2022 05:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CVPAaXRtTXkkDcB4gkId5/4fpqJmkwZXzq8+DsFztBc=;
 b=GxUKFXMErK3Ih3f/VLeBpNzFUqaeTdNUDAIpVE3GZSCv65/jgT1c8tXgnErje/p5vKGa
 DiVj8PGSdiIpLeMF73poB7qp1AfuH/k1hG6310TQ/A18Y60h/Nk6Tw/U6eG5pdD6AOWQ
 aoku1qQIN5YrybiQf84IGwYqJBV8UQapiIqqlQT4tyszD1NziXvmJqzEo3NpDisPaGAl
 Mrcfv/EIqv1qZ5Eag7xpSC2Zprbr8yl8GuWQV2aR5hLMID41Ii9V+ODkD7/Yt49AhLND
 E5xrDI2KeADQeiv4+3OtnpU82two/wZEufVe94ubf0CpFKBykqpKltXOTz767ek4gjTh fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cqec0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 05:54:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M5omi9026944;
        Wed, 22 Jun 2022 05:54:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5d7e0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 05:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWKI+S5aphiQil3eaLeYpxTvCxKLuPSlAR5wojFCkaPLqorjDmRSkHjbnPC40EUNq+XUCvaBN8+JlVLuOtoa4Xa3/s/wL/PhCrMH8+eCXiGNHMA1adGnzwCeZB/vUiHGpKajYckAkMANyinNuqKTsKdvMP9jqgUp2ewJWLyI7qy7mgbPyDUcTq6GaiooInKbUwknjqnXuOuuOlwz4ECCbGD9tP3j7DDEW7W+ja4hRGsNyFsiITfyrqggsoVixL75a7RyMyYqeH/c2dh2wP7l7bYBdOiwMJrrfml6xGD2ja6mfwoIdZqyj9eX+7iYGPYbinyeIZh9cFlsHguvcuhIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVPAaXRtTXkkDcB4gkId5/4fpqJmkwZXzq8+DsFztBc=;
 b=dcoriy/kyx84H9TwdaPZH2nVK1JJnKqw8L8OM93ZgUWHkWBuwKSGi9sP500zO4aaJOOSOW7m4ElYYdLzI/iRTozL2y5xu/QxFlO3aat41JzuB0oFYX2e/dv4opUelXNsMcDPXCir4OjYGADzl5DHPqxI8ADCbnQaZXSpOjla94/teK0lbAnvYFeRGihD3n4Pu71WOp7e91wSR+Zh6WzYpKMghbo/u3QHXzE6pT4Q0l0xbzfldlI8aqS2abqFWL8DjcnM4GtLmD6dJ0wV3pYD4zrvr2TJtsPTK4Mt2V3IQ8UhvqKNnyP9fiegHD57CXZYkUVbGDeSJR6OhXjVVqUvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVPAaXRtTXkkDcB4gkId5/4fpqJmkwZXzq8+DsFztBc=;
 b=rskXye2YMn4T7dqtL1b4pECSm/pzC+SED4GCtYrt02iUrvbSixk8t+UVCeVJ8rADf5laLEck3Z5yp8LKoSVFDt/hV7gF4M2cNtndUw0b0fkiC2T+ajpsRWY/QKMsY1/gmjejKha0QsYGoLTdBP0ZAHrrbcoFAVKjHSOJUEPyFck=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3863.namprd10.prod.outlook.com
 (2603:10b6:610:c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 05:54:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 05:54:16 +0000
Date:   Wed, 22 Jun 2022 08:54:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: rtl8192e: make sizeof type-independent
Message-ID: <20220622055359.GM16517@kadam>
References: <AM9P190MB1299AC4FCE60C59C35034DCEA5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB1299AC4FCE60C59C35034DCEA5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd01dcc-cca9-4e50-c3a5-08da5413a40b
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863170A2792C7D1E56EE5088EB29@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OJVmL6rHXUwaRUsD6iE8PHz+2nNIXpnmuWzXzAOL1ifCCd4X6aIcTRPSZCJZdM4qSgaZhZtKjrSbMATZkuhTTOZ0LMT/d8LZyI8xpV+xw+fF2R3zY0uNUH31/gXH0yhVle5i6/NSQ5TEuaJiy6IXhN+q3svFLc1DWpz7ZqH4eNw0TxRVdciigQXPkDeEpzFpgOaiFPF0G1Jv1XPknaq4sRkLyjzZczc6wYy38Crjag6Wdl0lXGqP6T6lrMIzryDWPXpxfiGq76p9EovG/KD3L40f9P+l7LPY9u7sVTgK8+gVdS7nX4G4o1fS3WNeCJNCe/8I9AYOpOkj9vwfLVCSxnTP9FK9Ej770yu72ZvIN675mU+S8u2TTlY1X+WPSQHjB3HB9j1fVMFEw8PfieboiwRIMJMfSd1TUyYWAjtGjVJyv3xuguVALdxm6oaCl2D82Gmu+gLBLBmARI8naas0OqLDQRR1wwFpqWMOUIs06KyTpsYotob1MU32dWCqptWNxuITD1fL71VFDZ70dV6gugrGq9KQrrdwx9WKQ2hrIHOomdd//dv+8ZXOo8uR97AZ+VqABC+iUhqWMYK3a6ODM+V6MJNv0fF+95K/ohshDMHm17SFzOv+2a33YNJwz3AV501ji0JaSsu7U4kcW69ZCDkZBU8F8QhQf2Y8jfzY4wMBPkxT5tW+SVEvoQhQgpshDyJUbkNUgcV3yfXRK9mQBEdZaQ/btsoQzEpfn4VRwd6A/GXrMzxdm4+jXucarULrI3YNs+BgGeglKBDuWbXzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(41300700001)(26005)(66476007)(9686003)(6512007)(33716001)(83380400001)(8676002)(66946007)(4326008)(316002)(66556008)(6916009)(86362001)(38100700002)(8936002)(44832011)(33656002)(38350700002)(5660300002)(6666004)(1076003)(478600001)(52116002)(186003)(2906002)(6486002)(45080400002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlehjJHk4WokzbPKpz3QD7WBH9KM8wECk9YVfPKQ1gxQzkPnSk5LuH4zzXqh?=
 =?us-ascii?Q?wMsaBxOYvt+J2Wv2liNy73es8yeXeFobLgn08HE61Zir0Lr/q7A68eFogy+Y?=
 =?us-ascii?Q?SqxKTem2sP50W5Lcczn6u3tgFa1/DTWzSHN0zsZfJB1ZQrEmQJFcRO9zUE5/?=
 =?us-ascii?Q?nVMVSdNaqvJc+002H4sARwUAoEuEr1o83VDD0Hn1MP0SVIZO5IevmLYNg9mw?=
 =?us-ascii?Q?IW5PzxqOaDHJqDX6OkhnRIbTfdrXiL3ifIf1WnE9t4az4iTZC7Dfgcxovag9?=
 =?us-ascii?Q?enrbS08zR4XdsbTuhgMye3NHc/QObZ+LVfjUaAcdiQpsPw5MwZifXXOplYKx?=
 =?us-ascii?Q?5dMciCOhYB/q5wMsvSvp39GFzF/+E6NQNAqhevE3kaC4zMEssd/TywDot9kE?=
 =?us-ascii?Q?cc9v4QjErfc7+psMNPaNzHMNpkPiu+q2OPFIaodiOmt5I6Nah73RrlZCwmko?=
 =?us-ascii?Q?NHsW1cRuYhTgA7CQ/F6dHHk6bjX1+3eonaxJ5TTlYYYcqO5vtT/yCpxedauX?=
 =?us-ascii?Q?AdkrpAgEf2pj05zai07gXWU0y7gQyz2V/1gvpTshsNJdNWLhrQQZ6HtKgQjy?=
 =?us-ascii?Q?oTCR+0oo4Riq9rVWNROss1U45XhpRuUk0WHbEIzwRFmmMx0S9MHmm+9OfggF?=
 =?us-ascii?Q?jm8hFCtYAkPHbFRFZEl5n0rUm/SSQM9rrlU8Oy7RRQdbeUpKnDExfWaXQLdI?=
 =?us-ascii?Q?yGMD1/ZsjasKKrA2QEWtMNya/3kJUNKJmOscOTDGrEKfgZkaikv0Y1m50TV+?=
 =?us-ascii?Q?hejiS9p9Vv2i1qtVeB4xOBaMynfMveQi5S+rcltrgRtKeugAdX0R9YfNMFqB?=
 =?us-ascii?Q?x+q16PmxqiM3T0aOOInxKcGn41aIS2D8NdH3N8cEAYbDi8O1BR3EuEYJHdWN?=
 =?us-ascii?Q?KMG6pAlp2L0KqSr9VgglelF5NVJzyvockcYdIidSLf9HRxMXdrouVd3b9iLv?=
 =?us-ascii?Q?x2TN2rDWsWVVYKJA2KQDjEp0maC18WyVC1q51Ew2nKKHPSspBhSQqSW1vJio?=
 =?us-ascii?Q?O2INWwTZ4ef7MAEvs5ARi3NCjl1MRx6ozDAoFhiuvb6Yl7qxDkDVuCnsazD4?=
 =?us-ascii?Q?+N1CLk2HNEfXAQzXgmx05YM99PNuXFF81tltEi+r1Yyd3tmfsIqIpPBzNEXK?=
 =?us-ascii?Q?EfxHGfA1Mp/khuJr/eEZt2n09QDqltehoZfGMmG5YJ70EgiKdbQhFbZ2PCGy?=
 =?us-ascii?Q?4r7aycYLPfDJTuvDwFgOzjzLdrs04eoUZ0BPUwGab6zQYLMBHjReP5eQibnC?=
 =?us-ascii?Q?k7BgM7y1EmFVpRC85uSYE+3pPezu3LwpxEKCAjaCP2yp6HtsFGIFtYzq8/MU?=
 =?us-ascii?Q?F+gGdu4bimzdVtoD5s6puPpvL8bPy1JhwyEcuDAYrdJBnGl+ybC+lfTWRaYB?=
 =?us-ascii?Q?V+yPRjIvlWOciw+nSmv3QAYA7jKe5mid9UJuQy9znrudMGPP32FAJ/OXxZ61?=
 =?us-ascii?Q?AY9ixUQP5ZhFP2JKTa7vSZACLZIFgscgQgAPKgsrtgakUc6Vt7P6EP3E5Wkg?=
 =?us-ascii?Q?FWoSs4rMV3SyGOUWlaoJ7YPHjiZz9vpNAjWTr924ZN5jsh+vUmMRboYaUhCz?=
 =?us-ascii?Q?jyJyI24ryvMsbUfzEttNIWamdn9mpJLY/8RAaNmsQo7PmndbvdC7YaZvQ5rB?=
 =?us-ascii?Q?DhgjpYPpL0GoOsXMc+ldycmM7BZHvEnVlTdWq6LkhWN+Uq1ULyXyp2BO3NDb?=
 =?us-ascii?Q?LcgPFBnpDZ63r4grY47TIx0glrqk7XkkYIblWSJ25UTfZ0Dj/vaV4xHOE+O0?=
 =?us-ascii?Q?5PhI2P87kDZFnvHj/yNNwDHo76sh12I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd01dcc-cca9-4e50-c3a5-08da5413a40b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 05:54:16.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y75iNdz03ZzsrCg5+2yHIFDRSrJ7gNUTiBZkCBoS3YL6uAj+OvmyH8BKu2OG5h2/iMClR0vxelxksFdvtwXzNEVYLs3qKbupH28zYu139Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=820 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220029
X-Proofpoint-GUID: Qx6g0HPsdp292cudn6OAJxHfoyj2qEJw
X-Proofpoint-ORIG-GUID: Qx6g0HPsdp292cudn6OAJxHfoyj2qEJw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:52:55PM +0200, Felix Schlepper wrote:
> Making sizeof operator type-independent.
> 
> Reported by checkpatch:
> 
> CHECK: Prefer kmalloc(sizeof(*txb)...) over
>         kmalloc(sizeof(struct rtllib_txb)...)
> 

Hi Felix,

The subject and commit message are out of date now.  But you're doing
too many things in a single patch.  It needs to be split up.

> ---
> Note: First patch, trying to follow kernelnewbies tutorial.
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>

The Signed-off-by needs to be before the --- cut off line.

> ---
> Changes in v2:
>  - replaced kmalloc with kzalloc against memory initialization defects,
>    thus also removing a memset
>  - made error handling more consistent
> 
> ---
>  drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index 37715afb0210..bcccde91fa0b 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -205,30 +205,28 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
>  	struct rtllib_txb *txb;
>  	int i;
> 
> -	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
> -		      gfp_mask);
> +	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);

Patch 1/3: use struct_size() is one patch because it's safer
Patch 2/3: use kzalloc() and delete memset

>  	if (!txb)
>  		return NULL;
> 
> -	memset(txb, 0, sizeof(struct rtllib_txb));
>  	txb->nr_frags = nr_frags;
>  	txb->frag_size = cpu_to_le16(txb_size);
> 
>  	for (i = 0; i < nr_frags; i++) {
>  		txb->fragments[i] = dev_alloc_skb(txb_size);
> -		if (unlikely(!txb->fragments[i])) {
> -			i--;
> -			break;
> -		}
> +		if (!txb->fragments[i])
> +			goto err_free;
>  		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
>  	}
> -	if (unlikely(i != nr_frags)) {
> -		while (i >= 0)
> -			dev_kfree_skb_any(txb->fragments[i--]);
> -		kfree(txb);
> -		return NULL;
> -	}
> +
>  	return txb;
> +
> +err_free:
> +	while (i > 0)
> +		dev_kfree_skb_any(txb->fragments[--i]);

Patch 3/3: clean up error handling

But can you either write this loop as:

	while (--i >= 0)
		dev_kfree_skb_any(txb->fragments[i]);

Or:

	while (i-- > 0)
		dev_kfree_skb_any(txb->fragments[i]);

Either one is fine but put the -- in the condition.

regards,
dan carpenter

