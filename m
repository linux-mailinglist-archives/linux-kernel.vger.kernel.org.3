Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7625867C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiHAKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiHAKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:44:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED572BD9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:44:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271ACh3F029375;
        Mon, 1 Aug 2022 10:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RXfc5IvYdrkYClnP5bh8AdfKM8yaCN8U5KobACyMiPE=;
 b=QZqCLaXRvyrB7uo8Y1UXtu0NM8hxaqQrCMGNnZd2OnqLbpGZjPAGY/Tw3R+N+ZNJm41i
 m0KaqfwDFyl7wWxBHs6R4QsIwiSbxHKuy3cYsaUlweu0IiChkweT0rxIO+ZO063iPz4y
 eXvciFVLkye7nBl3sO6Uhvx8/M7Uv/eoTKEMqWk3Et0iB/K3g7KMKj003B4ywW7zoaXS
 Ob3vKwWB/dr2sSSTSD+0ui3bkFFV6IEydchDbimfCWyCgZx+n31PUs844O4FIxuHdslC
 bLy2AV9qyH69C2zIw81Ms2f2b2drEFkx31isTyZ0IOYhqbud43GuUsBXcR9qXO46XkBY Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80uawe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:44:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2718u2Xk007473;
        Mon, 1 Aug 2022 10:44:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30wjw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZumGy87kpGeLj8t89tDuLl34Wy5qEB1KS4XMD9x7zuBg6EKljb14F0cNbLNUyGcKt8bPmcjQ7yE7HpZwOpyeo6d/Pzscxlm1FXhzXW3yGuWp441UXNWP1a5bZbdPqoVthQIsGI8Vs/zXL0GVulqzJQVRx2xR+2ynEggt8a+DTvEVIgepI+VX3PxUghP/I/QJyGVYqtfpsquCSNSazghsw0RSNs2F0eNar+hRCbLLeBVcEoVwLDf3ZqNzkCGnXYLH8LnuS9KgiY4CYWlK0SDC6t2kyyRF8pDjjMlQkbqj5InqHt4JfRItBeIPUXn9YvezmzjY1hMeCTiCPbFEwC3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXfc5IvYdrkYClnP5bh8AdfKM8yaCN8U5KobACyMiPE=;
 b=MwC8KOlNQ07JqI5E4fk4DLNXH5CbT1eR1LV0Kl3SVrDvcYrGC2JN9qDBNND1wxaru15ru4o852slNb7EXXq29LDUcsosul4Wh3hT2IiLXD5iZnX6iZcM2wfkln0Hw5eoQs00EWUStMTl+viOl98gcLY1IMbK9CH81Z+eukiF6A/A0M2NfjnsTHokAdi02io5ejHzWyp+TM/cpvWIps8TFWNO6pSRqzJkLnnYRNipter56U+rH50yr/6zfZSvJXxGPutBfHY/Lw5pX03NobgCmGAKi+oQw6AVmV1NGBcAeJVM93INCeaejf7S/CK0ArxI7bqiwpo3+93oOUoT5mXSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXfc5IvYdrkYClnP5bh8AdfKM8yaCN8U5KobACyMiPE=;
 b=Fc4PjyVoMz93c3hSLk2eEGz/SggktX88D7LtINZSA4pfD2meH1Dgewyk6IGfY9X8rY0nrTgIrKPRBz/aE3jC8H8Kn9VZz+3JOs5VZshXf2XU7JucB9UEMc0rZiWbuJhT9NPwjtrYzK4Ti/NoUZWR2DJcSj61XDNaFQnKkSjzR68=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5226.namprd10.prod.outlook.com
 (2603:10b6:610:da::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 10:44:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:44:04 +0000
Date:   Mon, 1 Aug 2022 13:43:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com,
        khalid.masum@aol.com
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Message-ID: <20220801104343.GA3438@kadam>
References: <000000000000bbdd0405d120c155@google.com>
 <20220730081246.4567-1-khalid.masum.92@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730081246.4567-1-khalid.masum.92@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959c43fe-f33f-41cf-3c93-08da73aabff5
X-MS-TrafficTypeDiagnostic: CH0PR10MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L/5jL1cNV5j6+77+15GvXmR9tRJu6BvPsYLZ7qme4j5NaLSj8WIvktzmHxlEmAMSd7+4wUE2wUO00qZ93Ohcc3RhLdhTnVslBl46/bI3rUu17yNS8D4AaaEwaPJWdHc0ftpL2WscjWFA+HMbPyhI6iaG57eZecHzY1LD4H+cKp5RoGQkc1IY4cq4y7l7HGvL/fDQM2gM1Crs3BY6Ubw+NHvtlCEj7yjhy+mqZnWmU8WxKtMW0uUDJdRMGKTblSX+mPd+j046PlkdWYAwzg5BgzAc8SJA4j5Qy/0hB0aYH96DHDAEz4nWs2jmh9XtqLS3mz7xjTikRk2JAVayXeO6CwleEsSv3EmjdJ421cUTmJz9AgWApZj6nXESAu65UTeLcG4eRpK35Lb0pKLYmZe8Bs7jnMFf7E4e8HX3MDPAYeRdLxtqEro5T61cj8QqwwOHiYCmIiatKhrYYZMS/eKcgDimEEHXKzwDBUUPYk/A9ZntgtMsD07HSL+W2zY9edR/OHK14dwmSe6ySLqHxw+c5YzbjWJjo6cOBuAoRnvbGA2minP9RVMVQbjMwwQpje8C7moKnUfGAY0Yj8hUcSVOtdVFZxcN04Vs14CDWFshMhUHOX0M/MJysy+ewg4B0wPI/punQTOI4KHSaFOKy9z2bwelYm3MWwhyPTlM91pJ5A1xr6F41rrT+stpOX+FrXPpb6t1wOCc4cAa+8bzswCTxr2hoYR5AElO4ktXpn0BjDAfzEZjaq7f+0uL4hGMGAbqpITIK94gXGweP7un9wYG8SsPFa5f0kVaslxPBTxAF0ew4UrG8KY4ArFpUzEpeRgtiYRUfRt/oZNW13twnHe1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(83380400001)(6486002)(478600001)(966005)(38350700002)(1076003)(38100700002)(186003)(41300700001)(6666004)(26005)(2906002)(6916009)(9686003)(6512007)(52116002)(8936002)(33656002)(5660300002)(44832011)(6506007)(33716001)(8676002)(316002)(86362001)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cr9N+5ShtzNtWmMcZMH1523aL0Hci22v0mDCJ4mPQv9ogeeEt8WpSYJajCjV?=
 =?us-ascii?Q?5UX0ZdwfKZNIjKZU0lH0Pptrg5Gjk3/W7HwpWqzSC2y+A1ULX5KalvcLAihF?=
 =?us-ascii?Q?4mftFlExsWt9AHib0H5GefrHhBsdJHrS/kntZoPMPIuDu5TCiGfwG2OG/e5H?=
 =?us-ascii?Q?Jv2LuiEnO10ceOC8am7dE4gzRgnulPzGi9BoE9NAHaBvVh2jGkq+2dBBVy9W?=
 =?us-ascii?Q?swrJkDRngnEwZXTWgX8ptSyAt2zBdtwADqsXSeYpZatTpr9L9a/IeZvVF0bT?=
 =?us-ascii?Q?/iNu54oelYBCX+MdzxUfDFPjlt6+9/1RMdEeJMJxu2X4reXq0Zd3OvHpRHPy?=
 =?us-ascii?Q?MRMAOBuLsXrdlSuk8b9At8vYmDSPwf8nv/ganDELvPlWo3MXm4nCEKynTTwp?=
 =?us-ascii?Q?8/LvSEJ9xoBU9wF7lY5TOgw1+EM2rz6Bq0+gDZhebYMBp3N96eR4DQTQBYUo?=
 =?us-ascii?Q?uJHk0oHizZaesqAy8cNck885lCM6ePzfjJ4iuca/f9EtU38+ZOigCK+mfZfj?=
 =?us-ascii?Q?oUYlR0qQTpr+nTfL2XCqosRBg7Yhhiu6l52ophC/TUXwlfRbJEGysXHFQi2c?=
 =?us-ascii?Q?25M9o5S7Z90tA4U/N2KzRxfKV+tlThm7mR1Tl5Xnjp2c2L+AdokviS53mNte?=
 =?us-ascii?Q?rIFgbVCR9YxqtyWABO2YAMmDR4kLuBq0yS3knacJ5SeHHxAgDETcTgaYRA8d?=
 =?us-ascii?Q?Sm4qtPrrAaazxwiuftp7bDVe3tI1fPOEiGPShhLYo0ehxCzdjdsKOa+Q28Sd?=
 =?us-ascii?Q?oDZLoVkM4YN/c5d4jGLJVqbPtnNf8x9GHYNhc/cbDAPDTWLkkiTeDpaoYeMx?=
 =?us-ascii?Q?+TA7ObsHNpR/mejtk+bLWPptbHwcZuJFGpEiAgB/7KGB/iLAbZZX1XFjGbx+?=
 =?us-ascii?Q?WNAhuGm+Qx1c83F55q9DLzzGxCGdwWXrNYPqPzbcGvDmCAZ1b2fLY2a2VhJD?=
 =?us-ascii?Q?/3SXTl/LXEEbW5Pv/oClBpbiJvotSlW3uXm4mgkms0Nn0kMM7StGExjmExmd?=
 =?us-ascii?Q?cRK2tJV43L+dKZeYVY6yvtI8Su44mrNVqwayVIg0T4oJxjsGH/BWyxbW99yI?=
 =?us-ascii?Q?tHzJ8RlLTq3dOIjnoaO7I0Hb0LkhV7Lyl/F/A5C4OC3MZqy//zIM7aschLn/?=
 =?us-ascii?Q?93mSIDQCvZ/7VUOPJji7kj/Yb2OqBNE51q3lbXc2gA8hv/zes7lfz/gmle1R?=
 =?us-ascii?Q?uj+T1H8+6VKpK/n9E4EA8GH0t+xfzA5c3zP6u2xhw1IpsbMkA3ugTtew0vXy?=
 =?us-ascii?Q?ytLrnv08jTrBvuD2kw0zk/PAh1T3EVLHRzfDjcAmebVqI1tbPWEzysRNJJIt?=
 =?us-ascii?Q?g/79AEh45Nc2MTXmBeByPhejKCOPR6JiX3I2b03s+Ctx540tC93nIVkx7wsF?=
 =?us-ascii?Q?TYMn2sIDR+4yYiXyG/DuWO2H+alE2wDpdJxO/HWNghmu3mNdZJLhqAZMJASu?=
 =?us-ascii?Q?GYfR37d+KpMFBqhMS0RLlTKQKkkdXLIGq5GqxWrtgHAcKm+2KmYUMECmzKSL?=
 =?us-ascii?Q?ZIbCLwp86P5u5rjUjD4o/mOk02//VRCkzeSTaWV2w/vTQgaErJGLw+7itShr?=
 =?us-ascii?Q?39MFKCpXQ0nfCtHfjlXP41c8z8IUtS8g63p6aBS547UrymQRzVsHN2tyJO9J?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959c43fe-f33f-41cf-3c93-08da73aabff5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:44:04.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0DFJL2Ta+XCOmuZafctp5Hu4Ea4XLbDX6XLp9gTerE8poSLHeHkN7pEMs3GO+NwymjQCcy5CaQVDSvKH939oBptVtE1SE3p0of5dvDDLZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010052
X-Proofpoint-ORIG-GUID: Aao-EZCokPxwS94RM_PeI0AkPVSssYmf
X-Proofpoint-GUID: Aao-EZCokPxwS94RM_PeI0AkPVSssYmf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 02:12:46PM +0600, Khalid Masum wrote:
> Currently the if block's condition has an unhandled case, where the
> result of ret might get greater than vc->vc_scr_end, and therefore
> the corresponding handler in else block never gets executed. Which
> eventually causes panic in fast_imageblit.
> 
> Add this extra check in the conditions to fix this breakage.
> 
> #syz-test: https://github.com/torvalds/linux.git e0dccc3b76fb 
> 
> ---
>  drivers/video/fbdev/core/fbcon.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 1a9aa12cf886..d026f3845b60 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2591,14 +2591,13 @@ static unsigned long fbcon_getxy(struct vc_data *vc, unsigned long pos,
>  {
>  	unsigned long ret;
>  	int x, y;
> +	unsigned long offset = (pos - vc->vc_origin) / 2;
> +	x = offset % vc->vc_cols;
> +	y = offset / vc->vc_cols;
> +	ret = pos + (vc->vc_cols - x) * 2;
>  
> -	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
> -		unsigned long offset = (pos - vc->vc_origin) / 2;
> -
> -		x = offset % vc->vc_cols;
> -		y = offset / vc->vc_cols;
> -		ret = pos + (vc->vc_cols - x) * 2;
> -	} else {
> +	if (!pos >= vc->vc_origin || !pos < vc->vc_scr_end ||
> +	                             !ret < vc->vc_scr_end) {


These are precendence bugs.  The ! will be done before the >=.  Write it
as:

	if (pos < vc->vc_origin || pos >= vc->vc_scr_end ||
	    ret >= vc->vc_scr_end) {


>  		/* Should not happen */
>  		x = y = 0;
>  		ret = vc->vc_origin;

regards,
dan carpenter

