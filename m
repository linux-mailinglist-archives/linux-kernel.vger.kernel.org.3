Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9955719ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiGLM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiGLMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:25:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80EB1859
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:25:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCDnN7009255;
        Tue, 12 Jul 2022 12:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cHt6uQ4F5qfK2EMpjPFi6QtQrULwClp+JiIc39C2DR0=;
 b=fPKgJ+lgNC1aBg4olCMxyD064A4Ae/RMDNrQimZseLR4B/0KFgD3Xh4tH9DkXIKsgIR9
 1NsQm+NAt4AY5ka3vVSb7U6wo6Acwu+h4jYc+qpF+EyRmzuE4iisZRPFZjr4AQ0m83xu
 D0v+gwTlydCX8dOLh9WfTTIbLCHllJIimuc3OnK8XlsLRASwXJbkl8f1pWQlSHiUFlYo
 dQ2M48XNvDQ5GPXjO2Mu0rEMXMqrPYjhdUHmgO0308EPurONP3W124cKKpWCJhMDVbgt
 qvYLsPZfuCF8mHfC3mzJ12t6kSkjzeIdeC1XPRQ1v3gF3hTr73Q8NjREuZhz+1/El1Al qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgpamx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:25:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CCKcfe035269;
        Tue, 12 Jul 2022 12:25:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042w6dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIRckGKHgtV+Mdj/QnA/hSUg6GWK4teYx6YuUPDnjv+ltWDZunTDOZYPyDGLTU+tiIYVTDNuJ4Esp8EC4aHbanqzUrbhnpM7NO6JZjqBA8lQfeGHyXDnJ22DMJiNFEI69TSn+ZCe9PGIzFTgkhSp6nLS/EwZ1X9KqG0yH88zRnsTL51jn6aJdCD9lOixtK8oTe+3x5D0llDNzFtj+MMnI8FkqtK8xa5xME/MaV3if/g4XZsUdJU4FqDXgnzJvMkhnbmxc9wAM+nWQqzm3EmxJyUXmLBfzfp76m0G/hNuFp6NO7WN9tQ+xkw0bLiZdHkZM+ysHgT4DWw1Nocmaghr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHt6uQ4F5qfK2EMpjPFi6QtQrULwClp+JiIc39C2DR0=;
 b=dTAXT5oF0s7kexbZtr7YNsjrv+XdpBameTkEUGQnIuIVSO0O9lRL2gZ0+L6vDyvfGoVkxWHzAOOs+W+Ozwn76wwBjq40urzzFG0JRphA7cjpptYKfvk1B9BOZOr+dlZZCE0/wgBeDf8iWyL2mnyBD4yEFs0D1B0GJW5nh+JxAQXXgbrnK65H76Nl8SX850/sAWNcRgDuKRBDpiYFks9payLHjiEs8ClPs5gUuIlMJKVbAIRBoYEHUOpz+A3hb/bgxS6S78mzfbBY5ArplmTs88XsqPFwadn/+cI2cuA8ZRMsvfY1C+C/ZpffOPZjsu4U5nzv+fLkhrg1FnXMpDxXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHt6uQ4F5qfK2EMpjPFi6QtQrULwClp+JiIc39C2DR0=;
 b=dC/YHrCh07Id0UwZZgKwJ8tPgu0bWZf2zgt8NfBvOk6cVmU3xa5J9rMUt+V7gDTHbx7wO73xPcwQs5NUHjEggi7WL3C/nIitqtUcmtUeHjD1oRnuVx+5Q9RnHZxl2NWq5VAdY9QGh8kKvBepXoo7sUe4BwF++YDn6pMu1JXW4xg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3454.namprd10.prod.outlook.com
 (2603:10b6:805:d2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 12:25:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:25:31 +0000
Date:   Tue, 12 Jul 2022 15:25:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] staging: r8188eu: use a local buffer for efuse data
Message-ID: <20220712122507.GN2338@kadam>
References: <20220709171000.180481-1-martin@kaiser.cx>
 <20220709171000.180481-6-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709171000.180481-6-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 605d7074-f6e0-431c-ceda-08da64019c29
X-MS-TrafficTypeDiagnostic: SN6PR10MB3454:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eA0aGAwxhK0fRRgmzg5r7u/MOG0ldiPyn6m3ZjVNyh6yzsHi/6D2iQ2PN9yp7zBd5UqCouZJRqi7zqH1p4wwWqKDrAUxvgmP23bsGwGFnAc+D1v5k0KkJIfaYiT8Xs4SYRctMsBRNxqnan4bPEpBfZmlY2sTWdUS+kmw7dai8DbbB6aMSBe+Bd0iR1byKrFh/U0eqh8z8PrYoFCkKCLg4mnTPNgFOQf6RunxivQeLf8DZEHaqquoHNFCTf8gL14ajqlgCP89imPtOMem0NkQ1+36L7Wvc1bZvNQzzjn0t1jfWaYdKa3GuSeamLHodO09ABY+roJh5BnyIB5c7mZs9AuGBfPOvl1WWREUhp7M3ZoZS4iHNfsDBlUQuSl0+KdvNFBcdaAvyrMalJYp7qlBrnQ/aheZvwTDy0ofrBrLKu1ZLUHPJvZWzWkF2BYEozB0mt6+pMUtR/yk0zEiDE6viiuquJdOv+1JD8wiiHJz6/thai+ju3JmZL6KUjMTQ18L68cmJlQ0w2KhBzX/jjXq0LlTYzfl/IaNX1Glpk5F2liomZ4SBqLXBEwMsFMiA12EDiBy7O3lqqqWHOGLGJ5/m5TVSXvxTXSvOji2jjXSSqAfd6M765HszUIGr9rZfCKl1ymq0Ba8DAyjIonWn2w2c/qoeNceVroznJQWt7lg8V7rK92rhXWSPqpgn9YPgsJgDkLG10LhuSeEGoMryzl13WYJz3Xbi+z07Az0BWAQ0hOMe/KZdqwTEsAvbnG4Nk3JcxCs0c227XHsPgAfWYfsj19NVKlgivh4tJ6IWEBVSg9jjEpRXb+dsW+u0nr7pyQe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(136003)(376002)(39860400002)(52116002)(6506007)(8676002)(4326008)(6666004)(38350700002)(38100700002)(5660300002)(33716001)(86362001)(33656002)(8936002)(26005)(2906002)(1076003)(83380400001)(44832011)(186003)(9686003)(19627235002)(41300700001)(6512007)(316002)(66556008)(6486002)(66946007)(478600001)(6916009)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xulD4sJSv9LdPnc6juhW+tHFN55WG6RGQzZ05jlR174vru0JA7Le5s8KEDTo?=
 =?us-ascii?Q?gbKvBlUnsbFyCUWsbVkwnFHpI1bcqXn2NzPIohd2iUiedokhEC5fARu4ZKDm?=
 =?us-ascii?Q?TN/odLvifp4Wz2j5VDPMUU4yQnrs1S7LdRlV41bvQqdR9WvmMaHgHWg/pcvR?=
 =?us-ascii?Q?i2T7wmvw8T5CtHU18IsCI8wALNM3GETN2SiT0c503W4GwghPFk1SQ1AwD7Gu?=
 =?us-ascii?Q?33zF0HQTkdjuc+HH2dMhdSQWarGWB/fwvs4auWqqyTUAfjtlRx/ZToK7v59H?=
 =?us-ascii?Q?dmtp9iWgdlgVUTDNFepohuLP7W87LsgBY3hpiCfL7x+XgpnWfWB9nUYl1QxJ?=
 =?us-ascii?Q?7zYerisxK0o4NDmqdzSaZ9UBd5wpWZ0YXZXPXI5uFiXPwBv9c5avQB3t0GJ5?=
 =?us-ascii?Q?of/j3YA+srVO5VOAp627HK0NSzTj5jwWkdUMTZzEoqbOvPyprYuH1w9Igkvp?=
 =?us-ascii?Q?vETcldqcNABSiiTgYMdwbYGWD/5y8aRt2lsd8CTMv3i/49pJJq2T4Daff7B8?=
 =?us-ascii?Q?fPdSlPxMVsRXNKO4goZ4XIaZdfv7G/UDJOqxr8erE6smivpcvHqg9pkOgwDi?=
 =?us-ascii?Q?unINusJv3fXxFJkVu9l5hIpIRHVDZYnHXuJqqVzOWqaIKaHAhlgScQhLvn04?=
 =?us-ascii?Q?Mq2hUXFXXdZfv3DHbmPzG/FuZ9+1ltCsEMI1iZ5pm13gthlpRQ5hgUx1R9l8?=
 =?us-ascii?Q?if7Km6xj3aha4s+UAYJhweDqOrHLQ02ThQUccFeVJiHcXu1hDb7O2gtEwFFQ?=
 =?us-ascii?Q?ajv3HcW6KmPVhWDEml2FPPfB+Yvq2NxtLvbDFYx9UBQjQ6SvD4j5BJ3vdMkz?=
 =?us-ascii?Q?VImHc031mv9RsCFwaQA7vWd/o12EvB/Y1vJmvblQgZ+O5pcZpA1JfCyHwPMq?=
 =?us-ascii?Q?93YQCZo6FdVC8CUT9KHqUls54u49vO5TWBwXPdXtOtn9QaY7Bhwy/7BYvkNH?=
 =?us-ascii?Q?XquGWMIMseBToRKTmXuX6ECrk95WtNlsG0bQ6N2uQucrUT6zXFhFu61+naL1?=
 =?us-ascii?Q?TYuSy5FNTWdme7nh1It9I9Vw4ZsWU2oSyb4xoyiOFEpghXVQaClC2/gTYhPo?=
 =?us-ascii?Q?Uh8bfN34iU8SVjGAwIjx3fQRdgY9q4wN44T1+BDp847mAGOcPdBcWEmAVft7?=
 =?us-ascii?Q?AdoEB650ZDvs2Q011Kl5lt+qkjUIE2UDtlm7AOeOtguxB1dUMyC5JOZ9GT4Y?=
 =?us-ascii?Q?qQY4T8Kc23XrbK515g+Cbd12o1+3GnZCRcdWAUZM7JJBzKgJQCshyBW16pX0?=
 =?us-ascii?Q?kb3A1v/0Rjc4Zk39kojNLnudLqSdNYtuOhEs0S/5gJG7ffENLhTwxYBWD0Wu?=
 =?us-ascii?Q?IqorcpF8McxVuF8cJNxkNQOCTGNDd7DHpPHjH6522FJEk0texqs9CcVRNVb3?=
 =?us-ascii?Q?tcDOpaQpe5sPyZjtB/7oBGtNbLFHzvPgmx0ckaowOgGCDxodJc0tdmwgfnBt?=
 =?us-ascii?Q?e2UKTwQEZgCxShzid2fPTu+k4/gneY2Ah/Bwevfb+nNoTt5oinwms5U0jUim?=
 =?us-ascii?Q?WaC1M8Y9WhgeTUfvcFJlqttLsVvxxwXeiibiwcNLUshzExbvoeT1Ys2CoDb+?=
 =?us-ascii?Q?GTAwLnfJY5fhaKBSmYDpmBu3Co3Brixsn0kBJqpi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605d7074-f6e0-431c-ceda-08da64019c29
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:25:30.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziO4i0+plvxnQwN1wd5x3QX9Fr3WeRQjLJOyxD17J/kbm9lRR1fEk2xHscRxdphsv4Qs2kjNrGrNSgweo1bEciGiwYuEqslgoBu5UWZ83Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3454
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120048
X-Proofpoint-GUID: -222AL0Euoa-4Q7ZwC525ezrKsnDPrr2
X-Proofpoint-ORIG-GUID: -222AL0Euoa-4Q7ZwC525ezrKsnDPrr2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 07:09:51PM +0200, Martin Kaiser wrote:
> The efuse_eeprom_data array in struct eeprom_priv is used only by
> ReadAdapterInfo8188EU. We can remove efuse_eeprom_data and use a local
> buffer instead.
> 
> Use EFUSE_MAP_LEN_88E as buffer size. Its value is the same as
> HWSET_MAX_SIZE_512. The functions that access the buffer use
> EFUSE_MAP_LEN_88E for its size.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_halinit.c    | 23 ++++++++++----------
>  drivers/staging/r8188eu/include/rtw_eeprom.h |  3 ---
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 18c2817bf1e3..807d8ce8cbfc 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -929,6 +929,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>  {
>  	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
>  	struct led_priv *ledpriv = &Adapter->ledpriv;
> +	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);

This is 512 bytes.  We used to be slightly worried about declaring 512
bytes on the stack, but I'm not sure the situation now.

regards,
dan carpenter

