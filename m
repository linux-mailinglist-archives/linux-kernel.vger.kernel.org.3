Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14E0537828
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiE3Jag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiE3Jab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:30:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9972D6CAB1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:30:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U7pg7I027031;
        Mon, 30 May 2022 09:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zVpMnCGVHCrREbbVntoQ/G0qJoHS5pbkoDSHdwCccnk=;
 b=D6hUffv4JRWH09onFRi0HrOO/vQXYsasj9uvPwz0bccliApyMzKyT4DCZ6VVQtLwu39b
 8zmJVtyKSpuHAMpMxnp1QHItbYQ+PNKWwwKoZuzPsshka4dSeBq6+6IgKZrMI3N1fG79
 7S/R4EPHQdeT/hkhd2hEKYrwl/BKtqVxf2LCQOXjM2Z1UT68nzZ6NxiBy8E7I3QTQVPf
 tlKN3yci5KVj7jvsT8O56jR8F9QDDhS3SAM/oq4MPRCnKWmlwtYambn8N3ccl8+KDJGt
 +dOOx/sOxbL6N6XE1RJmPr2UCE0iu729QmL5QXldamCW4XxzugqZFYa5noPohx9yNChd VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm2a02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 09:30:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U9FnM8019688;
        Mon, 30 May 2022 09:30:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hqjcnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 09:30:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIXb7xIRsMVpO+3veGCV0nGkrL6fhmMvLGQKbaAV/rPHqCkATzV3WiXOKeh1agsmNXBi+TOgXGYgsrCvHOTIlFDlaNcoEOLaO1V58WH4hkq2i3KoNAR+3WCJP0myNaYjxImBmA8H4JMRRIeSAD+OMb/1bywYdCiJ2ZyEV9FRgyuxUAFxbIk/bwI1zZ+K6Oe/ljqgiNKRq4sYY4ea0qWCSUP0O2JU7ZRlNmcaXS99xFbmpKPvENhx7RdRbejUUytjPT04meszr9RpMaEXRKD1L1bjJAZ26dzYJ3zHUbChnUs5HUNLfv8KoH3EZCYq+/cfqqP/ILSDp+r1pUW2/g2uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVpMnCGVHCrREbbVntoQ/G0qJoHS5pbkoDSHdwCccnk=;
 b=dPZoZUbytFQd1GmgKhQMe649+pDG3W0lHcIf4zlyvdSTrvkT/luIPDDN+GW7TKi7aAsWn6e5vbywuJJgMvk+v7g1UabYzd6YrcUPRTglh9lmmwaCVTfNpEdB5bfFtrhFWdGOEEPvQmSn+rHMqPNt+iPwS4utuyEkjxmxuQYDzq3UgxLCk/sjmn/BZTOAwvbcMdJGwvZ5D6/dYe2FedCDRvJ6/ylxsLL40lqfnKGTrioYQxgRRpYug3Y9xMnH1X21FTvVgSRpCKiISEI3tUU21nBd1H0OOXXwUw+xyZapvl83uozsHAVxA6g+KLfnzpudxIe2tFwKc8pq+VnZuNjYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVpMnCGVHCrREbbVntoQ/G0qJoHS5pbkoDSHdwCccnk=;
 b=mowATc44m7M92gs+r7UuHUKLxNOdScYB43CP8sBbKKho+x6jGO5YaRE9xVkgphJ8GGwhYZqnbgJQY0w9jPsijFKtALHaEVYutW6HVdWuSAkhC92DoOpK/HHoz2xvIy2UiJunMF0Ui4z4eR2TJnTI8rcfzXKQXkVcSQRi4cUkzcs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3681.namprd10.prod.outlook.com
 (2603:10b6:408:bd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Mon, 30 May
 2022 09:30:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 09:30:19 +0000
Date:   Mon, 30 May 2022 12:29:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix pointer dereferenced before
 checking
Message-ID: <20220530092953.GP2146@kadam>
References: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfec54bf-5e1b-4329-c308-08da421f035b
X-MS-TrafficTypeDiagnostic: BN8PR10MB3681:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB368161B2D6ADDC2D70CE5EB18EDD9@BN8PR10MB3681.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKkm6SSg4s6VYFCK/EUCP2Cmgccxw1X5wxDDdODxUZJV+1JM1S30++l6nQBHG16TeavcLeCXoRNtTENfwPLRD5W0RYuRVWuOvebK+t6fUOHXCAOxAwHk+JUhr/jYntFeIbjPZXhmlaT4spZ/Xh5iHaSTmh8DbDCsaetOAngSXxnnwHlV/2YT9UyOxWQpyYqM5lhrOTjf5IfdRFTKWTuG4V0NMLjZBRzw/+REJYyUsCFva+GQRW62RcCGhjaN4ourTpwAHYj9s+5OBA2X1OXpe4nCYS9RXIT0+5M80fOViptjP4f4BOUrlr88eGq8T8XjG/BOyuY9hC/VQx/jeXUk66XIhrACutFHy6OaxXn4G4+ihseR3G/mAEvcKfjAOg5IWsznQ/BBRh4gaT3PONcanC9p6s4AlMCzMVNWLBHdjyFM9Sy2G9LqJe8aepfwXid339iHJlkRqk3T7xGZZpcrkIOZ8EkVjMfs4N4kQJEVF1Hn9neeK74KWt/SPM3qJErL1hauemsaNVKExI+vhvqiIXk3dYU8Y1rjRINBmchJSte8Fqr0bHKR5Fy7MdHjSVCajqZOLAIT8PBCABztiGA9RcmX1Mzw/j7ROLsuevvu9ZIuOh/kbiRvbRlcG29/Z+XgqAnefBoE0Rfq9BClEPrLyNcMKfTaP+jGcSJu3BJ1MJUbhJAs2X7b0C9SMnlQiXAHLZuzlCufNym/HoVLYcWWrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(316002)(38100700002)(38350700002)(6486002)(508600001)(186003)(33656002)(1076003)(86362001)(54906003)(8936002)(8676002)(26005)(9686003)(83380400001)(6506007)(5660300002)(4326008)(52116002)(6512007)(44832011)(66556008)(6666004)(66946007)(66476007)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ax42auwaDk4xbV+bK3hKiEQgeBIHcXQKVAOQyFXu3BjLgQ/rsRVckM8wtmhg?=
 =?us-ascii?Q?BQKexY2IXirw2OJ7ka/4bngpX6tUBPbCr9/DzSXAP1NuLeIboPzC+whoUIbQ?=
 =?us-ascii?Q?jPsMktME1WDTeU90x9hKXXJuR37QHAHJd3Q3p47rcOtgaMT2/UX6lISU+AgH?=
 =?us-ascii?Q?JZubwGtW56Et4h50W6V+CpCvj17Ri3IDdxBY4jlaceKOAzNEx3Pp+kry83dL?=
 =?us-ascii?Q?Umoz/I0MDuWefQaxhfOE1wGLbwEvczXDMTih0fjyizuQiFr7MiVZSfy1GSAd?=
 =?us-ascii?Q?6K7enSSj55a6nk7THUD4EN10icUL0/ijUD2ooPNRCEmut3nBmAAVZg94lKYe?=
 =?us-ascii?Q?ry/0N59yuuHZmW7Bp1C8DpIYgH21cwnYqFG1ymAAC5jw2jqTitZhvQE84N66?=
 =?us-ascii?Q?KaIJtCftC/GWHDi53CgFZ+RgIG0iKVAGzSSZx2ITDCwLNVx952hN9ndOMEIq?=
 =?us-ascii?Q?6peUH/dJRmcbkRqGHvkFOfpi/aLkxzV02zqWUd+MqVkOfda7krP23eNmUqlw?=
 =?us-ascii?Q?DRctSb2+WGOgq2J901a6Im1EFD42jHTwCkABy0XWQTrvg/7C1DJqT9fSDzJE?=
 =?us-ascii?Q?OxgUo9Sizkn03g/54quvIqUi0BhyMxoxXV8ymclwueHiN3WAz5mHKEUKHnvV?=
 =?us-ascii?Q?cd37jTsVGmsSVgjrXSbAjkGhnGqzm7ZsSBHn/5Nl+IEe2/+g0FW8yG/yUaaW?=
 =?us-ascii?Q?Dg/xr82gh9NrLeow6lqAhM1pfUrD3ak3gx7lYb4R35whcnpQUCAa0mZLOuAX?=
 =?us-ascii?Q?qqm+pGgjVxa/KBCBMRx+SNpEVgBDEpze2qgad2MyeVaDXv+s6H66Peh+NeX9?=
 =?us-ascii?Q?SSU2x9Sf64s9OZLxZpG+1ow8Aq/S8L1CW8htfyDv6RpE/riSZ7etYqfcOGBG?=
 =?us-ascii?Q?f+MP9MRGK/+IUACL38TLvS208MlTS3CQLUtnJjm0kGKxxdfL01yOLlcVd9zP?=
 =?us-ascii?Q?MyUQW/hpyj9yvpojS9bWqcuVoJpyETXH+q1nb4c/R1lm6yM5HXIHazhr6/sS?=
 =?us-ascii?Q?vnVNalnr9oJLKYkpmZY4KYhvqBf3BaRyT7mfa42lyx1CfbhLfs4BemHYAf2g?=
 =?us-ascii?Q?e115ZrCeqFevhZe2RcsW7/Ny6PFiHF3RuJWFLeWFnj8bnD1kZneqdeBj8bPz?=
 =?us-ascii?Q?ycuXp1sB/CTAamXjWjevC+yIBvhQPocCBjYhkv5b6NzciFZzLKB60XrK2Bw8?=
 =?us-ascii?Q?rd3nSFoASb+bP5MS55+M+dmdnUZgrTJCSOKcYdOxIrqo23TUao5a3zOSbW7D?=
 =?us-ascii?Q?ZGdWKNcC0EEZ65J5ngbJo+NGKFdRuW2goFD9uNNAha9I1thYXA6ufDjb3Mb5?=
 =?us-ascii?Q?8mvBUgeQdfzafV+9VAex9w+g9LPfwTB2Ul61H/IaO6jFiVtkaEfxFlAfsHxy?=
 =?us-ascii?Q?j9yyDU6xPpvZ7zO96HvVPmnfaAjmOb/TFRpBHqe4VjzdN8tQvNuWssBw4yXe?=
 =?us-ascii?Q?rNe+0PYpVmtN+1CnK3/dQPVERvk3ot6NCOIXedoNghkSMNhM2jmPxrLhiCSL?=
 =?us-ascii?Q?HrmJz4KxWR1pjBZ6BoBFQ29w+gbk57+el9wteQwqtPoruygX6MuHljWcK+Dc?=
 =?us-ascii?Q?SwyrMxFlWvNJ8bzKK3GTG7G/cuUsbtFPqBzwR0LLoAUwMTV0CQ+O1KKM3T7V?=
 =?us-ascii?Q?oJsiPEnSDBfGHuN2p6TI4XfUX/JMWAsQnLOhprXWKjrXx2OEU4oyytITG4sF?=
 =?us-ascii?Q?32nKPwKGpPMd6wV1QTq3nYt+/5qEY/gLockFz40Gx0xLyssvp2TymnfGzzl0?=
 =?us-ascii?Q?roip0dVVvi3Vu1HZcxRlW/ZFzGrDdwQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfec54bf-5e1b-4329-c308-08da421f035b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 09:30:19.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI7Ju+yVZ7Mm4eylvWZAFp0b28QXoJIvbgHzyUw2LKaOPZska5rwJ4cR3i0GOKAr9ekPJsaFPFjeU4Hu+M9oc/hiBoNStb9pYogIbGXRmZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_03:2022-05-27,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300049
X-Proofpoint-GUID: jrn-1Vcfwi1d7Zu5TsJwcg8VV-yS4CwO
X-Proofpoint-ORIG-GUID: jrn-1Vcfwi1d7Zu5TsJwcg8VV-yS4CwO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:05:32PM +0800, Haowen Bai wrote:
> The padapter->recvpriv.signal_qual_data is dereferencing before null
> checking, so move it after checking.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index 7f1fdd058551..8ed94b259dbe 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -863,10 +863,12 @@ static void process_link_qual(struct _adapter *padapter,
>  {
>  	u32	last_evm = 0, tmpVal;
>  	struct rx_pkt_attrib *pattrib;
> -	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
> +	struct smooth_rssi_data *sqd;

This is not a dereference.

>  
>  	if (!prframe || !padapter)
>  		return;

Not a bug.

Also I agree with your other email that "padapter" cannot be NULL so
the NULL check can be safely deleted.

regards,
dan carpenter
