Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67F50B4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446416AbiDVKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357489AbiDVKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:11:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617E53E17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:08:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M7d704011984;
        Fri, 22 Apr 2022 10:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zoVGJxQby71G8/iOxO/+rxbvr4EDRj/RLz5Cup2dz2g=;
 b=MGm0veAhjuWgo1AQqfDAqtLWVSC/fJAHmMi3t325vJ0QCqNdCG8zUmUIOoUUgPi8gP5V
 R4R2U5+13JP00L1Zb+2P/bJ/k2R68cK0iIUwStwm7PSojYI83eD6SEKQmKOfRvCXJU7t
 /AGEYobb3tn3QOfQ51mipI6APiXaAP56RLmQAaFQulsxV76v6y92tg34ynSoqhbyFehD
 gDcfel8zbE4pT1Zu6X2FTB+82PISznPz0In+H7YY76j7zC7g734xVfRUYFh+cP5OgbZ5
 RIkF+7rv/kI+e6mhbugLu1IgqviNXnPkRpgdpuy7I2ZfxZ6PUfCk6itsGHnQn47DQGFT MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbvenbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 10:08:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MA6AdK017881;
        Fri, 22 Apr 2022 10:08:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8d92j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 10:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXyKdQUF6GoJfI5Ktg8r924X0fH4gwHh229GFxkLOAa2GXhS61ZeEQNcVzSLuVO8Ozg4DCnSWFhuo1zLkQpj7VS+utzTyjlwezrmD8m8QJ3sU5uuBeeptqqahlFy6XMyqlYpQ822MCfkyfXrvpnwxJlW9Z7z+eO0XYycjuTy3ZP0DZNyl7wFno1AnYLkhYOIxBapDK6U9QUbwe7TLKPGRummeqtOunEd+tiCT8swfjEy2tSggbJdGqi+njSIDFpNjsq8V3+7xumpYtKR0C5v+WGlPi222CcQQiR+pKeHZ0fiO8xUCU2eY56gIbDEmSx6wxOcaw3kKpyhV7EJgCj3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoVGJxQby71G8/iOxO/+rxbvr4EDRj/RLz5Cup2dz2g=;
 b=dFNRxAjhFwFPrDymGfDtHqTtiLjYjHKZb8U0SlpgfF4u/vpl9poFSvwS+EqeQBGVyC5S5I6b9l/YY91NuP9nyhG5Vhbssnq7GURjRndvB5vh4sCI9DXvNC3pYqkQZGECMf4tnptPZc07i3tD+oQXSKL/uhocCDGZGtUV0EgA/c37HyvlvZasefNKmFTKEY118zD3j/Clx/Nn5Tr3YiDhKavfXcRrfQeKjLuOUM92E302JjtvGcAZNzzG++cWQtQlHCcn6aoQjatBIaJyo1QIZ2nwhqD5SJJ1Mg8XmljR/O/NDzzXmoVRfmKTT+3f63YxgWMrl++P9WyWeps1qfQ8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoVGJxQby71G8/iOxO/+rxbvr4EDRj/RLz5Cup2dz2g=;
 b=aBOk1kIeiJGj5gvURwqRzJgIvV5sM0tUZNmU8hKLi5DG9VK55gsQuoj0pQvbZ2oxNBI1savJRsQzfHmN2bTebiFwf3aU19cwejBzbipG2Chu64k3IxdmjwF15NW0LUSBys+UsZytbyE6bmZ+sweEsfifFzZNECL5L0GaFg18aDs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4666.namprd10.prod.outlook.com
 (2603:10b6:806:112::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 10:08:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 10:08:22 +0000
Date:   Fri, 22 Apr 2022 13:08:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: r8188eu: use ARRAY_SIZE for mlme_sta_tbl
Message-ID: <20220422100800.GG2462@kadam>
References: <20220417102221.466524-1-martin@kaiser.cx>
 <20220417102221.466524-7-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417102221.466524-7-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a022d6-e25f-43ac-6d7a-08da2448085f
X-MS-TrafficTypeDiagnostic: SA2PR10MB4666:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4666E24C565633625F85979E8EF79@SA2PR10MB4666.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFFsQEFybMsxztlL82g8wE1wXQy04hug5AndBKQBtCQ4+Rv894Shef90q8nT/b2B82TTElJc/JoOSwyttq1/Rkxx2roLuqZRKLgKekxWkceDS0ZhuAK5M687wqGvkJaLCjvXz6OVmzAYnIgIK6bHAd9+nQSmLJvQR6If3+14z6H/MNfXtZySxlPiKY6nmseRnbaFOiAKKQ2s25k5CPM+cTNAx9AGn7Acm96q8iBLKB/3c5Q/zy/dXkyVJsgqI4yp26yjN6Irp1Q5GjVy+w/dXcwKEUI7dzYnBTGE5WrKUVuWBjqhhMwI+7v5lGtxyWo7Aadkxt/gLvp2PO9+yxXD3ZZmCFreDBQtFzy40NKvV6464M/T3/W2jhIJmgFe0WsOAF/ul/w6rGfbri7w2zJX6zhgUIaVkmxagjNTyybap3Xl4WhM9ooobsAM4ieFdOf/GDj6qftT7X3lOEIkOXIkxw8tjLj53T1DQpGHcwOo4dyld4SJkJCUPFwyxEpmdUjojK+GINNN/Xp8lHg3jTfgZyxkL+KdVx/qweXsNawFFZwe2R1U+olsGIQsck5HPIzq/TQ4ALqQOcK/44eL+hfU/TpW8oBYT5w7G5SJBKv8g0Y9rPdbxOrVJfqP7n5ZLFO/wHxxl9aKcgUNTAo2Lrk9MXpUdpB72uucn9lq2ssz5SldOYPMXg9gWO6iDhLThDYnT/IHtXfFQhEQ+JGuCQ9HOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(6506007)(1076003)(6666004)(86362001)(38350700002)(38100700002)(83380400001)(4326008)(66476007)(6486002)(508600001)(52116002)(66946007)(8676002)(54906003)(6916009)(66556008)(316002)(33716001)(186003)(2906002)(26005)(6512007)(33656002)(4744005)(44832011)(5660300002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vPCJ/R0uqzrm3VvdjEOEFpTMZihWq9KCcwHgOno5S83LNzeK76VmHZhfqtlB?=
 =?us-ascii?Q?yd5UEJAehnVNqq/8JgdECL0HKcItBdns/iHfGexgpCu7oyEs0PMsvmVBYtyT?=
 =?us-ascii?Q?5DXZj6xP0wbG1VftYm8IqjQ4/d5Dm4xgH4HTrjOnklYdMLlzw2nl4Io8unU4?=
 =?us-ascii?Q?zANxAOC4iVhJewaH3MZUouMVWsA/+73sYeszfhO+uc7zPdHdp4/9kXz0iqt8?=
 =?us-ascii?Q?SY04V7x+mqwycGJC54rFt+tC7eK/yXmTs8Jx8Sig+7PHsEcF9BFwDoHr4UkS?=
 =?us-ascii?Q?L95RiegWeS9+EvjVIoC1wF5WzMXb9JZ20dOl9NQkeDzY/VMPy+3Vu6umRH+I?=
 =?us-ascii?Q?D7gZZ4RLJnnKiLL9nf7qZqeJwUqFvMir/4YFGwtsN1r7w92uHG38KVSH0MYd?=
 =?us-ascii?Q?zcXeL26XTSZeC/lfrgGQNN9u0NDTHu+ulBo3rfoPcPF20eUJ3T2HYqoQsTGG?=
 =?us-ascii?Q?XhbbDYmaBf81l5tJa3t8lpZ/HAkFDvryM7S4fdlhS0Bc6NHVUmDqArzOEL1j?=
 =?us-ascii?Q?hZu6tFZ8xN3SLB9O96meLRJBzdnUuR4Gg88KE73AocZkO03LyKkzSYpkfxm9?=
 =?us-ascii?Q?QEpykEm5sMhljSunMqi4be9SDCqZ4SaYQGhx/6WUDb7ezSU3+hO1wdCjb6cs?=
 =?us-ascii?Q?j05nSD9YaDSbo9lrU+Mi3oUVvBaBQvbJQqC1RNAuk2c6eX+ytDM5yAEJY9bM?=
 =?us-ascii?Q?E2T0XLz/1ZtxrsPknGrOAgcswqlr4v42jqgenSEbEPtJ4CX5TikJ3oRfNWXM?=
 =?us-ascii?Q?VGcQueQMTyzUeYIXHzZvF/Rdt6+ADxqW9Mc0eEzqfH6XlMSiKz20+Rh2CYe6?=
 =?us-ascii?Q?l4kcOiAQv3SY6xrAR5J55Jmwxt+EPtR3ENrGGlzMge0oEersxdSkDa0j7Ud0?=
 =?us-ascii?Q?qLsDIQmymhQa//fl7r20ZpyxPyaEcV+bc5yi/0jmh/+E9D/a2kFAbROyX1l+?=
 =?us-ascii?Q?iUTLNvDx4u/PXkyIdSmC00lHTyGr70Hgbr1VR+4BV6shkwq5hzPChD3AGBQq?=
 =?us-ascii?Q?gwDrhmz5FwngjP0ww5K/foe/SauF45AsSl5l1KCNXfLygYUGQdZKfWvAQTZm?=
 =?us-ascii?Q?E38dgF211OYPpaCZhr2byfuuiifMNapWIMoU99genYgtSUg+dgYgWsEBl3kj?=
 =?us-ascii?Q?JoGe01vd+eRa4SvWW0bdctvxQ4E7bYnA21t7p7NA576QHTsiOE23hHuzlrMG?=
 =?us-ascii?Q?XjcuemjKe3mBympn2qpezZ+5F0WNOPa8kTt+iHWTbdQ00CVghpAbS4/XzG5s?=
 =?us-ascii?Q?MMXplKxTIAYi2zfIGXVMEI0agkKKgW2NJ+qJSV3WPcdHQ+D6TlGap7EvDbiz?=
 =?us-ascii?Q?d/f943YMLB3L1QklAqlIX2soWIcEV56lz+0doUxe4VW5CLIOCnXykqoe/P5h?=
 =?us-ascii?Q?QXbEwUdi6cM2Y1N7oQQETP150Nvt+VpCYua1IiFBMg/orUQToz0REdaI13+z?=
 =?us-ascii?Q?fNKIyx7lV+ISpIhIl6C1YfofQbD01pCoT/eb0st+KUQmFYILxIXz9NF4Ra7t?=
 =?us-ascii?Q?J/y9sr9o50oLDbrBOW67ZQp1xcU8fbOq0BIjKvWt7BDBVvGdnE1dzXHLo4eb?=
 =?us-ascii?Q?T1zOT4fv4V7vZoQomznKySwUCS8gUmUwxoksdmnFv4aOMzH2FuHRgquMaOHQ?=
 =?us-ascii?Q?bN9kKvkcHM848QChLWzsWv/4fO+/+wQsRvCW6/MuDqi7dJy59TxbWuj78D5E?=
 =?us-ascii?Q?TzF5ImUrCSGTCO6OyVhIkk9cFL9X19/lZAi6EZxkUb6emTUJMQW4ZC6/y3jW?=
 =?us-ascii?Q?7adLz5UCLdAQ1SFXasXexHQ0U901puw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a022d6-e25f-43ac-6d7a-08da2448085f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 10:08:22.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhdxO08o6JWBafWvl/1IR2ts6wfDSvfKjNX1+7QpaGO0ephNrrix6DZUIhaRtzeNlqMosxwJa8bY5Q8J5UMEdwG8bJ1SFiHnyYg83R4AeUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_02:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220045
X-Proofpoint-GUID: dK1k4QreOyjI2yQAH3HjitNDTgNxHqAp
X-Proofpoint-ORIG-GUID: dK1k4QreOyjI2yQAH3HjitNDTgNxHqAp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 12:22:21PM +0200, Martin Kaiser wrote:
> Use ARRAY_SIZE instead of hard-coding the number of entries in the
> mlme_sta_tbl array.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index abb910f33c1c..973adebdd69c 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -404,7 +404,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
>  		return;
>  
>  	index = (le16_to_cpu(hdr->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
> -	if (index > 13)
> +	if (index > ARRAY_SIZE(mlme_sta_tbl))
                  ^
This is an off by one.  Should be >=.  The auto builders would have
caught this eventually.

>  		return;
>  	fct = mlme_sta_tbl[index];

regards,
dan carpenter

