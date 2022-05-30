Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE07153781C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiE3JZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiE3JZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:25:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFD76280;
        Mon, 30 May 2022 02:25:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U89O3U019288;
        Mon, 30 May 2022 09:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2W4d/EtQ+5iZ8jm4E6Nv2NbUQfSumhi0VRloNmzu3U8=;
 b=bHbBD/k3DozY2x19xCmQ6p4B844t1Uxu4XKZQxZCcRO4xfmujJaHn7JUT1OOd7OOWQIt
 aX0lsfGAQosMvjhHBsLty/YPUENatVeTQEhlJhnOkeXt/EAeo9EExHlkU5IQHV0jSygM
 BHFT8ZcWqwHFUOrvrBOp6jvWnYYsug8Oswnnqi54MYC7civ8HDbF7Xz4phqi9SZXWCPj
 t3byxmPMToipK3rUJnKoBn8s3vI/EDR1RZ51g/tMVQL/RAUn8b9SjVUeLlGVInYmogLo
 S5MiBQK7Ni3trwi9yFtonAtxq3DCV3DzgJy1qAKRpxgXgP5N6keYXsKe7d0mvNPmRceQ hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahjk9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 09:25:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U9FSRS027968;
        Mon, 30 May 2022 09:25:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p0jyna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 09:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBfex6+p+yFg10wkIJk6d6dnfGoi30cGI7k0yjJQR6dSaDOkxfLsowKdCF65UnLYnEMrzSGP9800An5u6HditronG1sW1gvRtXPbD5SIZwSegqvTp3LLOlf4Btfku3e2z6i0BQ4Tv4Bjmf//NKP3x53wmqTyGRMKiVxvXB5fApegaGCDSSHTHtdFenTwW6VFlO2EzOkJDeR4lskF1rTPEZL3DaIBOz4fwAHPlwqO5PE6JGgQPM75RWhe+39r3I83+QK2jizh8QebS0P16qQfxLYw9pYdH5z8VujbRKjmKHAa7sd/uiGLyaSVHxTw3M0umBSwUNg3ej3SHqBzQZJMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W4d/EtQ+5iZ8jm4E6Nv2NbUQfSumhi0VRloNmzu3U8=;
 b=jVlqJ8EterVLKHaPTWfRiQjxA0rgh5G0OEUk5lGCkoOuRZfFxU3hUuvtHrJ+oV2zkUQVVPN4AmunyuNPdPZBz4OlmCN/czhXuUBaZ23q+C4XoEc2sYsMOo0+gB50tfx9NDDrJMc8kNVFmdf6mAMxHW0yiY/ymnpvTJJk2Q+g56IinSOuBOW755KJPEHvvp+P0JJgG/yz4O2q+hDVBWoKT05G3u/pfnTSx8xX+7a44mC7sK/jTRT5Eokxh8dGKdNpzY7UoSu9v6T0Bf8iqCwidm6tbzLLo6XxER3qw74tPXPGFoIMDLftqRG8YbckF30lF9AzRv7mjbSp1iAiHwXygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W4d/EtQ+5iZ8jm4E6Nv2NbUQfSumhi0VRloNmzu3U8=;
 b=InrchtD6+HP03RywwqKzIRsPJPh4Yxtnq6sTkasYwYB6nouuTqbGngFw5Z6UoN9OWu7ganlRoqfhh7Ofj9rHCf33azLKaGL9NeLYOO9z3zbMahTG9+kOH/iLzCvF1fX+RclorRctd8jfI6A9UE7/ivOq66BPv92//X7ebZJMJr4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3681.namprd10.prod.outlook.com
 (2603:10b6:408:bd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Mon, 30 May
 2022 09:25:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 09:25:40 +0000
Date:   Mon, 30 May 2022 12:25:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp-mt9m114: Fix pointer dereferenced before
 checking
Message-ID: <20220530092520.GO2146@kadam>
References: <1653897481-25681-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653897481-25681-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a622034-b8ae-4649-3fec-08da421e5c7f
X-MS-TrafficTypeDiagnostic: BN8PR10MB3681:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3681753CA8FCC7B7A60D1D738EDD9@BN8PR10MB3681.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rzUBbvGxqj7b+AUWq4EuCinWEfSeYeZuBoMM2BRFFkPiF7GWx6VugY8YhBKFPJrCF3uXdORybk9q2WVFgMvc37TjA9y7BV+wcQsCsmjrW0KK5W+q2i+LozcbYE75gLW0eT0nkc0JrZAG/BlvJFi27Om5vbO1FLFJV1bencmca5FGj3ECvPtTdDDXixh0prjrisO+2ZjM9RYyHAfjuhf9IPmVukGxsfaLMVb9La5u1+AoIUYBTcNwHxn9km3lidVDRYH0I85BLyKL42stfUXYgzkLWXr7prq8daWJuQZDkL5iUgacye9VGklAyZMwy00xN/ECVPBOFn5P19j+14ZM578HpNP4pDNZRJdoy2/oVgfGxP/jNxswmrxD2Qh8X8rH0xXLVXjOvzp92G2N/SjOk5YeqLLEUFFGLeqH2cMFJKguKJAjsHMQ3eBWARxljvzNFvJxh43Ymn3qGDVQNnT/oIPsI5hNLSgjlKoyDZoC9Cw08rlEkPO7trNNmmoOadTCaRch5XDOjQnFDlgtPRZtnT4jtqs6IodZPeqEQOIDXO8MrpljEWp+SBWNAFUp5i0BVYV0JQO5UPnHs497uQNXIovqzm6Gqh/rdzLYDCXoTPc1Nj2taucW7EeCAepLBU428dwGwXNx6UydzsjMaO3nE3z7+FRaiUG3iQoyrgkx77cTZ0GZkBU61U8ohZe9IpTZT94SnPjOY4cS8pH/2EGqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(316002)(38100700002)(38350700002)(6486002)(508600001)(186003)(33656002)(1076003)(86362001)(54906003)(8936002)(8676002)(4744005)(26005)(9686003)(83380400001)(6506007)(5660300002)(4326008)(52116002)(6512007)(44832011)(66556008)(6666004)(66946007)(66476007)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/4eHXnqQrq0Fww3115eVHJAx7KqZ4dbdRx1XqoShBnoYfONXNhejP5lbf3+?=
 =?us-ascii?Q?NoXy5NDztY/6b+QWtjRQG0Zn2pmETAO1BYXFG/AQwsRpkzzhF34lurXDI4/+?=
 =?us-ascii?Q?HnEvsXS5TxzbxpTVkeVb5dl782DmzKGRL+rJEEQRumzer0egN97H0shgz1Ht?=
 =?us-ascii?Q?56oDpSv1MCF1TnBOaX6bMnj+nbY6G0URpl3v31ql/hmbaqUvs9QN0LtPDrSI?=
 =?us-ascii?Q?toebLqzrcvtDh75ocxnOlOrSIN4eIHJuXWzUSSEX/ZBa+zvqKjmxJr5JUgV1?=
 =?us-ascii?Q?Yf7cEksrcmQb0gHpSVh1c2bwiYUcRYJoTuzRTZXXGMYc9TCLxqntRYBTwYku?=
 =?us-ascii?Q?9OtyEuUHIvYA9r9IT5PFAia1OoY3NlFotIaW0y91m0ZYMdI4Hw6tacLlLZmS?=
 =?us-ascii?Q?2XPYxzPu04V1w8+d9CkbFnqkwLRhKDOHmXoSH83WLa/t6nCfTx6PjqAFE1j0?=
 =?us-ascii?Q?AmxgcPBMS1f7IEE7e7oXWAJ4Gxf4N+hlwz83AUgRXtuSnRMNmf5t7U/2cj0d?=
 =?us-ascii?Q?SrmXNZzjmgb4fi5TA9khXCironAwDcFjy+uInstg/82xcPH8ZxerlBXkK3v7?=
 =?us-ascii?Q?yqKYqqYxfm4bM4v2hiZpe007AtVQLGLggiXhcEf+rHt+Pu/GQWONBQHdeGEK?=
 =?us-ascii?Q?eL/L5E6zwxFfoWhHib4eWpsLQd/KgCo3rOk0cNYU3oAllTOGOwKIO1Z+KOfj?=
 =?us-ascii?Q?9Ku4IECQA8J6wbJwlGRE8I6D2r6jwp/j9WmN+utWyWY8sAoJ43BxXC/NEFFF?=
 =?us-ascii?Q?Iu2k/lvpEdjEkiL6n8uEo91/WN5vIahIKLqRIeR/LwapK7oHYmxfyG9upBXL?=
 =?us-ascii?Q?VUpHKsEbkAnShu9dYekBziLAEw+kqEFmkp2fcwnM4sSLi3bRDEHPKabz1RCH?=
 =?us-ascii?Q?6B7Ey0MD4Cq6z8hgzeEH+4oW0rG2FRpSW4TpdFq/7JXJ3o16FSRV5arDUyVZ?=
 =?us-ascii?Q?MCk9l34u5TNMPRXE5zpkWJrRlhBaZ52eclgJXQQ8asiHzoza7yOb8AZ8NHEK?=
 =?us-ascii?Q?UroVXmbzrkFcGYfVcS5VRXHYYTrfta1bukfAzy8SqLwRSjfUn+76KaD22SIQ?=
 =?us-ascii?Q?Njd11xIWBNO+3c+Jp/woIzkCtXrej4ZMOu3NLNCC8c/LxCTaR3GQHytNScFh?=
 =?us-ascii?Q?kY8kqkvnTbzm6vDKEC1dlA3/0SttHQ5MDnGhngQLtMg2k1Qf0YvALWOilwKo?=
 =?us-ascii?Q?+Vh0ebF+qmwd1pWyyLmQi1xxrxpAi2dkT+iITOBuVIiCLMbUiZXBZ4ma3SVp?=
 =?us-ascii?Q?TN8Z2qi7u2ThPQmMXIKCyEvhTFbvHWbfIVvdzdpfe0hJV1reokVTZiSuzwqv?=
 =?us-ascii?Q?NgjQ5HMF/UoieUz1zse1R2/fWCdAW3Zq+5GmMAZ1E9rKmGzXmryQaPiC+N2u?=
 =?us-ascii?Q?7NWcctdXQgS4mtfej7eNNCtLQ24q8zJts+D8JbbC1W7mNXWpFmFnS1CniK8D?=
 =?us-ascii?Q?MYvpwcmMbrEp7zk21tqYyblslsGzOJ0yjvzxdJNdoruzbYVszhDXTSKXqmy8?=
 =?us-ascii?Q?a8fdyospJt3DEPOAmSvTDUHOvWZ3ZVJeqBE3pQyUWSEvu8loJh+m/JYzBw7c?=
 =?us-ascii?Q?//X8K0lM9IWue2RLP1ppH+/m8PNJK2NP5mBojyIT4mA3Mj16OzD+f1fPd0sQ?=
 =?us-ascii?Q?IhttGOMC0R5DknQi0KKf4yuVgtwlbBBsMsk6bktw+dW8Zu7xFopAu9rrSnU5?=
 =?us-ascii?Q?OVd9njTz9y2SBCcZCcjcP2hiInu03fAJjUrs1Z5XClUWlgPbLNejCJJ1JMZc?=
 =?us-ascii?Q?RnDb610zhzZWT4LgbYJ0UKFKYkzUwLs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a622034-b8ae-4649-3fec-08da421e5c7f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 09:25:40.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/ydhpZfqDmIg5XofL7O/65uvr1w50TYtJv2/jMTxxD6Drk8lCdVD5qVvvnNUxX2NgoNGLC4gzoz6SQ64KSkjFhWWikh8XE3U+7Rjwiz56o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_03:2022-05-27,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300049
X-Proofpoint-ORIG-GUID: BkIx6aDmbns1gG7rPIZUTxWTO26KT-u7
X-Proofpoint-GUID: BkIx6aDmbns1gG7rPIZUTxWTO26KT-u7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 03:58:01PM +0800, Haowen Bai wrote:
> The info->data is dereferencing before null checking, so move
> it after checking.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> index 00d6842c07d6..3c81ab73cdae 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> @@ -616,13 +616,15 @@ static int mt9m114_get_intg_factor(struct i2c_client *client,
>  				   struct camera_mipi_info *info,
>  				   const struct mt9m114_res_struct *res)
>  {
> -	struct atomisp_sensor_mode_data *buf = &info->data;
> +	struct atomisp_sensor_mode_data *buf;

This is not a dereference, it's just doing pointer math.  Not a bug.

regards,
dan carpenter

