Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FA5023DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiDOF21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbiDOF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:28:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB99E9C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:25:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23ENRDGL031505;
        Fri, 15 Apr 2022 05:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=gWQyNHQjE61cOMMwpRilDQHzk0flXtKMkJ8/c3W0LR4=;
 b=onKssbEI5HCrskrIjyTMH3ZQAMfv3eLkZ/Td+GnvD4GY9mhU4GCWh5XiDTpofpJK0wPM
 e+IVjFThnrYuIwevoIIHvDmI/BRt2rFqywjO/ZBNDBaiBu0e4sbWEXZGpqY+m2O2n1Me
 uoAl5xECTMJAhONHtWf4aWQYR3jgtzb+KM0yj75msUhMy0jh/IC4Z8vGaH8JtB5t5CK4
 LmT9qC1itWe9Rkwc5GXHS1ZodVGOr6Rror/znIsQTxPAGSAJ/1WLJgCbQWzAQjFbHLXg
 J55AzdWtzpxrRhikpGRk49ANS6HkkpStLZtQ0QJ2Tf+fELldxB7XsQTY0J808meYGt0d YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsekua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 05:25:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F5Lfv9025989;
        Fri, 15 Apr 2022 05:25:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k63jgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 05:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRFU1u0TBMJmoeAT6cIJ/pKw2gmydeMRyLTyXJZjL3C291z3FPDJZTwOlSJqURta+XtOKOGF115b8JepBvGHHBDofC6qwXttnrlXtXfpvF1dH23pOla7PnT2T4uj2PgTmUI3UgvXCj2SY2OH4pdmC5I9Rd0LzvXDnGl8mslsCUNhGOz1drlkcnqVL0maeforscKLac5rizHT9jQ27zBbnUoU+RsYmnaZBxD/yCTXg+5tmBqjSwRCVAb3tKCzsxjE3qBlAukdDWYIH39zx1E9ofLbRsBUoOoa8Q9d6gUrloV2dTUUacoBBQ0nQDCyzZ8RSG1NzjIW4devvx+RiNc1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWQyNHQjE61cOMMwpRilDQHzk0flXtKMkJ8/c3W0LR4=;
 b=jxanO/WYyoev1aArtjYF4VhfdavySB2Yi5aQ6SXBO9iXERr7Wowr+e2mVDRb6Ayqce2HzHYtHdTx8OhwK9r+g6w7JI/+5GZilGsZfKRAtiF83xi6Pt+U+uyfALJmh7APg1GzwyL8IUeZ/q+x7rgMNoyfHUA6WmEe4BffgAV7BcUQdDVkTtDNex4XxnYOuCAfSkUa/yuD/NCsJEQaRrmTO/yX2Z0xWNWO3mgxrP5I/i6Q+xtcS8gW0md3qbqxnCxz7SznWTZvC9uEoc39//a6LzWiFc37x7hdn7v+Zk2bUZxUjNaG+q5NU+hD312MpvLasmz7fbb3PKJjyy7qoiKKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWQyNHQjE61cOMMwpRilDQHzk0flXtKMkJ8/c3W0LR4=;
 b=qkLRNhXpWnI2yCgR96JMBveao1YfGAXVt1gsRaZ2LC3I9C+OiDMEE7FUn1wv7nrfI+UDVGbuUHSW1A9nEqAC2tU4t3XnaAlhXpLuM7DqK3skdB5pG+i755E0tu0g5yKesXwI8+RhJ4OGUAbeCoUZEKqA0U0Edl4ahp0c7isSa+Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 05:25:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 05:25:24 +0000
Date:   Fri, 15 Apr 2022 08:25:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net, len.baker@gmx.com,
        dave@stgolabs.net, edumazet@google.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220415052502.GE12805@kadam>
References: <1649988571-19923-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649988571-19923-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0075.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7194ab-fd79-497a-b372-08da1ea057c8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4483D8243F94218126E97B218EEE9@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sw+yIWkBcxI+0//TDfKhmzVpHBI6nofqyNURVBmXFY6xK93ehExKltbkleiMG09qFZ2pTYjmbjt1WvSti+YTnUwcqH98J+LoERohgwkgzYQC+zF9lEWObS+3u+ArTCCYSy3RFOfO/9gYlF+WgXqxK7Imdfj3Qv1liAJLXLobtlTCX82g18rhwRohPRaNxZdraCx9aGsXTh1WAcE3V0g1Tq918HFZaw8456RrXiiViJ1js6t5SSwRSCVGYTrfB2+r0ZIRvYpLpdIdP/I365dgIk3SAaYnxzVGQ7afe9ovZO6orFvGVq53rcfB0Mo9k3xCP5RdASYSPhO2uUI2wPXBqxjPXEZL95a+PF/KojjgFmaQdM9R0IOsbZvIonxaulvDnsD02rm753k/hrVnPAaj7jaU2pUWbsXF4uuez2eZIpoRsQXFBRjoq8hEyidOoUclxH1bcwpJ2YKBtY8sXO2S32+JOw+SPojD2iZhvXMlsoYv/e2facaVGja9UjZcx6Ss1+HYr1lW6E1zW7Q1zuK73P0ClngLr10ZKNSnC79Hi2EOMs6EbwOxwq3f0LPS9PO6JCBUbWbju5v6vxIwCNv9Ex1Mhb2An8abwmUQOXwklOoMKltXqHGKIHMgvnyz4SQvI5SxFr6uLRV9kO01FiB85vi5bjFHu8tGyXyqK34/7NFH3zL/6xAEgF7QrOtPLFt5MTN3xNrq2TyUphLN9vPJqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(33716001)(83380400001)(186003)(1076003)(316002)(8936002)(26005)(52116002)(8676002)(6916009)(38100700002)(6486002)(6666004)(9686003)(508600001)(5660300002)(44832011)(6506007)(86362001)(33656002)(6512007)(66476007)(66946007)(66556008)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vuEvtMZ3Wngh/M6ujhz7dz7kGjYn8uvLJh2q2JNSdCsdkqo7VK/U0ZVsJYL?=
 =?us-ascii?Q?YdHdUmAJU2POfuzwKgRvB1jYrqx/n3eSInBNL6ZNE8iItbJIifV1tqVyuXTc?=
 =?us-ascii?Q?shiy73WxS47e+zfhic7QtY6XtRCZgSNHUDNJZBQ4+61fpo2RE8BDvRqUmVN9?=
 =?us-ascii?Q?2Cs6A0Zf6Ww91ZumsoXfvQspVPJhOa9D+wBxd+8glw9ipzNueYnRIBEPBFSn?=
 =?us-ascii?Q?458KXiPrrFUvSIRpNW6dH8kpZ+AhCZPlCsYz9oBC3ho6E6f0R6y0D8hthjBk?=
 =?us-ascii?Q?zt1LPBpc60ipNMvNbvrB+LetXkLilHwETz8MAMjC5qirr1btl0C5daPUdKXA?=
 =?us-ascii?Q?MLEzPexWR/nuK2sWYXh3iCkK4wc+LBYkRHgLTDPMc+hptNSlHnkwcO4TkUUr?=
 =?us-ascii?Q?rWfr3hH9RUY1D4HlnUuin0SxGtvABwp6+Kz4Socm7fe4J/5uRuA14tY5zWxg?=
 =?us-ascii?Q?kNoAwS3jqC/qZVczWgVWJvjG317osEP0sv7Ka3N2LphLcQqy+fS/+vV36D2T?=
 =?us-ascii?Q?Z8SIWlMTS1XsdHrL2c2t4xKqp/rCaMWuo+WbZV20kSZkMiwAaF/A155LQ/Yp?=
 =?us-ascii?Q?1JMxfiCyHd/OG+/KiRx15bmhb5kDB00jcZcH8zEyJBITtHwI2yvUo4urCf6f?=
 =?us-ascii?Q?CKzN4V3pGBCJfmChOtEHBIHol4D4XPPkxKVBNAdNYOM1cp5J1uAGKxWQKwrS?=
 =?us-ascii?Q?3EhWcvMlz3m/nVWfnK34rj/OdgYemXFi86IKBemYiswkvHxy8Q+/rhahr+Pq?=
 =?us-ascii?Q?I+yZFDf+IRicTSGznAb5YYZCAbjHnlE0F48FVYDN+zP8i0MJW8lQL43EaTG4?=
 =?us-ascii?Q?R0y/wIOfBWODRh2P0EjZ7rIorc9sB34Ye0jye3LuPF9gryIKGsuIFB4lrmod?=
 =?us-ascii?Q?bpnW/2Rj/T2cnlGZbKv85bzI0MEekGCnxqmKXWlq4FFazieCcCbFIYMUcVf3?=
 =?us-ascii?Q?AVFyVu/CmVF3p2+lZbF4pj2aU/lLQCJHObvONkIpW5qcJzZZfmLVxHPi80Wc?=
 =?us-ascii?Q?4BC3sFgR4XzrR/SESly6vruwnZWpXXAWTQN1p5p9kdAuSTS3MP6fgkik8ROz?=
 =?us-ascii?Q?O3BatETIBf0vuqie0PlK1EG2QsgU7T/rAnVx1CAIz8l+EeG4iWgIIhRkNnPr?=
 =?us-ascii?Q?ZW71oX7spBsfzo8zwTfB1pgluKP7HAoDsyFcbmxDKbWgLDJEENzECt3Uy1t/?=
 =?us-ascii?Q?mVBt0U3bQkFyzyeVwpJDKTC6HCS9TKTMp+WQZQiFzUUAhXtyf/+BR2k1N/EG?=
 =?us-ascii?Q?60ug034AAcxTBi+Utxx/0uBetTj56LOtcphTTV2xqeFN5KVxwrFH2eIWw1Tl?=
 =?us-ascii?Q?7ojCohvz/mOzMHV+oUTbc+jxG3R6mehTv1TI6uIWL1PsAVPY9WWJq3Jku4qh?=
 =?us-ascii?Q?b02GnUDiCg4JiHMB/TTW9TC79iX8Yh4H1PZ+n9tbZUBbg4w0H5A3s6u/Ygyw?=
 =?us-ascii?Q?iAFvFYxa++/5M0yV6OF7sKhaS+vV2qScmwtNPQszzlUAtZeLgLVukOpiqcL8?=
 =?us-ascii?Q?PIgiZHXwY32hLPYWTAhvTVItyq4Bs8xEZU0OCGD2howCoJMPHttJ20FV8fJh?=
 =?us-ascii?Q?oiUyArGW+D16WYGjEfwJ6t/pRTyBezo6JlXgfaGKgpVghOhPFXCq7l2yN+/m?=
 =?us-ascii?Q?aIHG02DaegO6p3BrWjLTSCtFrm1mvCDJi0NIxMsI6XUTX1/Qe4M4XG6/IqfL?=
 =?us-ascii?Q?mXGLIKdlt2LEMbcvXBnWyfeQHUGCTyVSOzQd71ww0tpH0E31W0KscXhjMolT?=
 =?us-ascii?Q?yegw1NhEIzp380M2hE4bqfA6401HX6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7194ab-fd79-497a-b372-08da1ea057c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 05:25:24.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuB/OFNzWkKKCRxUpAH6EVfivrhxHKDE/6SRQMkkc38bRhDsmhCa1smNwCdTNOj6CuyWkaKsTMscfnWNRs1ldAV/7RESPIWoowm0+jTQwKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150032
X-Proofpoint-ORIG-GUID: 7ucyCvKkeub4UH_y0nTaYbvgXSmGUZns
X-Proofpoint-GUID: 7ucyCvKkeub4UH_y0nTaYbvgXSmGUZns
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:09:31AM +0800, Haowen Bai wrote:
> function rtllib_rx_assoc_resp () unsigned errcode receive auth_parse()'s
> errcode -ENOMEM.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: reduce return random value; print its own error message.
> 
>  drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> index 82bf05eb1cbf..8a0961e64a8c 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac.c
> @@ -1764,7 +1764,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
>  	spin_unlock_irqrestore(&ieee->lock, flags);
>  }
>  
> -static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
> +static inline s16 auth_parse(struct net_device *dev, struct sk_buff *skb,

Could you make this an int instead of s16.  s16 is always a bit weird.

>  			     u8 **challenge, int *chlen)
>  {
>  	struct rtllib_authentication *a;
> @@ -1773,7 +1773,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
>  	if (skb->len <  (sizeof(struct rtllib_authentication) -
>  	    sizeof(struct rtllib_info_element))) {
>  		netdev_dbg(dev, "invalid len in auth resp: %d\n", skb->len);
> -		return 0xcafe;
> +		return -EINVAL;
>  	}
>  	*challenge = NULL;
>  	a = (struct rtllib_authentication *) skb->data;
> @@ -1787,7 +1787,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
>  				return -ENOMEM;
>  		}
>  	}
> -	return le16_to_cpu(a->status);
> +	return a->status;

But then just say:

	if (a->status) {
		netdev_info(ieee->dev, "blah blah failed");
		return -EINVAL;
	}

	return 0;

If you look up what a->status is, it can only be
WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG which is not worth preserving really.

regards,
dan carpenter

