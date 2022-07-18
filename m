Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65A1578176
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiGRMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiGRMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:02:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E94A22BD5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:02:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB3xLN024701;
        Mon, 18 Jul 2022 12:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=NNFu5CW88NwyNVNms9xIz3EWm81HcLzbxnQb8+9wYtQ=;
 b=0R3RLa4gGnDqGsg0LmOnQaiXUani1Qp0TRvyQQk0nG4vWy7mr18QMD4VswMI2o/SdzWF
 bFb1C7FyYoIx1gxczJJdmSMGGcPGbpGzt5vXDljDyjIjqrswQkdzGxIgHBQC8PR3CLQC
 HhP16yTSr81vFS++JjC6dD7cfdgBp1mGYySFRG6nLLQy5nWjchnwEQzA9TmEtIe0jece
 Xbk6tPqgLZRabvdpxBcnPz8Q2dpeH+CapwMLkEBPVOaqwPhlVKMKxMOAmFz4diVZbkPq
 rpJgJ8HmKRfVSalkQlH/xI1kUuVflKwe84L2bud0Yv1mXfCzLCCG/pVSXzTDDJRH3aWU +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42b23g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 12:02:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBS2w4002395;
        Mon, 18 Jul 2022 12:02:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hqx9sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 12:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ83G8KL2AcOP8Ze2oDVD0FD9hFfaCVZXueZJylLd5Iea/ZHyCruk07mA+op1SoBt7HZWzGiSMq37su/U0hECyvoPyhG4Rx6Lm5gKS4ju9eEoYpwKMIpQpnX5IjXtoQqzMIRy1V8/JE7w4nMn0HYpuz/CeyxG65nlQ0x0/tOrfnekbsIhv+Gm8gLkwTNOx5uUy/sZWaySa+lgWhcd/F/PuLBs28qmyitSTOMc8lw5jX/2OIZ5cY0j9V1ozg6qeBvy1+JsqFDBuM9s5myBJ7PqtNTJojBhQkEQkAKYhYe6amqsULUoCiUDZA3C0F6rGOtEXEhmN+Wr7iDrF9mcXoxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNFu5CW88NwyNVNms9xIz3EWm81HcLzbxnQb8+9wYtQ=;
 b=JZSwkTmJjewLP6YU0EE/RyycykghnkVWf6PeqnT4u1NtbZgeRVXtSi7WJpGh+Gh67cCAxODqj4kPOB7ylEa/11nMP//epDuo/W7in/dj4//XD02GqlsdalrRlwoQ3peJBiEz3pEu90t/CbhQPybNpyoI1GFguCR04NLzqpVTvn6vS+x6B3c/Lx9B+kSnrO9017FjNas/TmsvdlI3Q/N+qSvqpXvS/r+9xfAywYu3d5W/LYy75kwVw2hfAPgWNV21JHT1gNCK/XH/2uX9TjpvdCbx6vaCBvB1aPj2/MrAILjkExyWmT51mDgrVwpabQ99PLRBj8kzJChwWHFOH74s9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNFu5CW88NwyNVNms9xIz3EWm81HcLzbxnQb8+9wYtQ=;
 b=vkIXE9yRdKOfkCm2KfM7yJggzqj5wkqTqHxHhbjMrSrcD9TYpG0nargespM05FMZTFo+DeYMBZ5WXu3n4WEOqviLqkQrekX8MRoVyDrrF0hOjGJmF8t5Y1eOwRVXMHicqaIPAXqO1swUSPDxE+Q7u0eXEDoKnd1ooCzyu34TkZk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3387.namprd10.prod.outlook.com
 (2603:10b6:5:1aa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 12:02:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:02:00 +0000
Date:   Mon, 18 Jul 2022 15:01:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
Message-ID: <20220718120149.GD2338@kadam>
References: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
 <20220717070204.705878-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717070204.705878-1-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69011e93-321c-4007-cf6a-08da68b55233
X-MS-TrafficTypeDiagnostic: DM6PR10MB3387:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oz/MRRR7Q4sak3sspXE+hCPCpKcaO9k4K0PaOeWukWl0hntparVkthvCLuzsq/A1ZQQIVRjqmimuZP5qlBI6jNFl3H6cYIufmIJCslDtVeUQw5n+WwYRF4Su5UYP8DQa6/kAapZxPLnvYfSUhH9bOMF9/e3NgE6CS1a5rFhQvUSLtXtOrdL9a2kxhGQA3AhZ78mqz8OgDxDkHS75ojeEM/83ALxyioSAwJt25qgr+BGIF3uEjK4bVeMGnJohEHLb/dUssSlNtIBhvonH4q/vm4Rf9WNHhI8Kvx1x2iIMj/kBihwmtH0lPsrwF4kwChkdbzpDvFxVsFIXAFM96s5MKAvqLNQ7Op7BNxwKGn9gqblDRPlJrRM43ryHdvFsnVpZ7etd+DEFmgRsNMkueo0bzwHdi/TZAB/OnLPYm02QknKgK0UsOXNaqkj9glFsNBQQxa8aP4yOHs9DNMpQQPu3YQSJ7Btyum5099eQOZOccs92e02Xl5r18eXv9tFI36cTu4OX+zjXWTu1dAYn4EPz77xPsq0k5As1vMV558kl4xH3EltfanTNcf8fO6b+cGdBBz8sZU/Yph5Tdy2JO9R4EoIPlW/hzumAEYIbxcuF/yskGOhTNfEjEWGEbPGjoVe5kJ1yy9erCtixs6OjKYjZKlz51TLtnAC4FEMDcnVyADR3YxyJqmSzqmhMZak3UiKGavQk+WWFkTawU2TXdgGa4ZlMNOd3tEOd76ptCFaG5Z6pWS2rToH+uwRaYtyPtNizaLlP4ambdPxNDs6JBd1x6aCLDNaoIFxE3gwnrfCWIlEzzQqpXbLFVzP2DOz/TZt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(366004)(136003)(346002)(396003)(33716001)(186003)(83380400001)(38100700002)(38350700002)(66556008)(6916009)(316002)(66946007)(8676002)(54906003)(66476007)(478600001)(6666004)(6506007)(2906002)(8936002)(41300700001)(5660300002)(9686003)(86362001)(6512007)(6486002)(1076003)(52116002)(44832011)(4326008)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d4ip/f+lrKcWvPzy3LIoF6MvAecrvjbdXkClDq287Qaw/xyWz5O0CEGK75fm?=
 =?us-ascii?Q?OlASYpLUOyycbrXGYxbCzjIkbBO1h6lqChw7oAcWbLL+mHgsOmb/Gg8W0I2h?=
 =?us-ascii?Q?UrfEgqaZ+xcGPdCjg1Ve2hXbvYPZQQor9HmkaFepn+dQ0hM8pPuMGnKZigAN?=
 =?us-ascii?Q?kr86cRwp2RLvQR2V6qVVmagDpPVAUUNUvB/yhgvchu0JVFNXku1oI2EFsutR?=
 =?us-ascii?Q?bWSQqjyOU1mu0XAuea0LT59EqXFqqgfJD/CYLgIE/UW7Wdmn6JA/PDXzq+GU?=
 =?us-ascii?Q?5z/GkmYbMit2EsdETHnnBANEIIQ+ow4ynUJbpRKVubNx2a0Ft3HkUUha7mQH?=
 =?us-ascii?Q?63rlusyICiCf9zJ0H710aclrroJI4NFuLsr6L/fbbcfK/j76/MR00M0uDR+6?=
 =?us-ascii?Q?S7ahBGHhAcS/lLLDecth+EyxVxgiJx7z9cnkc5pP02jNSKsjtZtJmne0qijV?=
 =?us-ascii?Q?Z614n0DamKcuiIGfcHF1xECL82asamI8k8XblLi3B5qvhJfIKMC5NDYQ7359?=
 =?us-ascii?Q?eGk0lU1JA5FmjicbmDskd1f0bR8ZvoMFybf6GG4IZXiiMbWSoD/29DYumKvP?=
 =?us-ascii?Q?cGA3wpK3H9EB8gRK5VaMXkyRlUY4dun+IBqf3Id2MoI9YOQ5sA/9cX655hvH?=
 =?us-ascii?Q?ijKbkingg5IigGRYfk2lsrapy+D9/KjpuZTMY30O5T9oL23Y7gJs+rLk0ABC?=
 =?us-ascii?Q?GnIE3g9WMF0cmJVFpq7xOkIa9AC8surZiQ6jzyZ1gadE99pOMgdHvPqYgYCz?=
 =?us-ascii?Q?dVcpexzBRDMiL+zkitDRyKwQIAkThNw/e8GQEh+4yTh3wubxThDUfKU5idvE?=
 =?us-ascii?Q?5RGZ0cqTBN2Ed6wG/o+BhVNuc3El1Bme6DiJfWU9y78lHMhSHBs78NfEFBJk?=
 =?us-ascii?Q?PiKtKlu5rv7g2sAOWTUvdbuoXFsSCf9wzovrR/1HJ47vviTtREF9WsHz2nnC?=
 =?us-ascii?Q?GS628S+UoCaI6PgRUWg1w+WZl7ttYy6S2Dzyq/lyrmzvPJ5z2L42q8nv7sh3?=
 =?us-ascii?Q?3/3brwfNhFXPxf7URNgH/uvLglMiaVHlHB4mGRbONPiC896FYSsBLrBTuk3B?=
 =?us-ascii?Q?Mg+iDqQi1uI2KiT2axh3+VPjNk80SEjFwrGYV7wmNhRi1dfPz4j+Q35OK2tn?=
 =?us-ascii?Q?hZy8slcZSki0W/hXmPFudozYejrmld+yARBjpYcD3apzZSlWvW3RSG8RNXWX?=
 =?us-ascii?Q?kTKn11f2IFb9y991aiFX4bL4m+oPTWzfpyZkvJWYdhiDgijhgz0L/o+gPZit?=
 =?us-ascii?Q?sB9GRoCePDCBRPdsHWizRJ7MtluqM+re+5RZhgRoSyjKCWKZge2F2dHpGc+4?=
 =?us-ascii?Q?apYCjiaJpAuleigbNRhv4O1ZmVYxE6w2wgLbJBvYPLeb6PKMKf49utLbhrGU?=
 =?us-ascii?Q?fkzB9w9tJMDnjfsPji2AYBM0Ej7ST4F5hwicmyG4FaBj+LbVdrZiIAz4aeCY?=
 =?us-ascii?Q?37WwwdB5xNnN4NQ8yWz4+y5BtqoV06tC59Cg8BoNeauzscVTWH4Vlbp1MfvD?=
 =?us-ascii?Q?aPw5wcgMGHMCO3wsUAV/RrWalTVQ4gT4Flgub9x0pKogFE2cj/u0t+pizf//?=
 =?us-ascii?Q?pKYiBdyIrR5ny9O1TVjNKijMsFdKx9wrf4VV56l8R4un4F4JGxdMypS37uC2?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69011e93-321c-4007-cf6a-08da68b55233
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 12:02:00.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OUT715XhofBM3pqt8qurq66+umJIgRV1aydIl+MdhFtqHdVCE4ACR3WtAAmWaXcBa/MjJ/X6xykxuzcgmBBPC9zutHP4TO8PVYhnVxy7iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=881 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180052
X-Proofpoint-ORIG-GUID: 8oghklJucchcuWI32xKMoMHsgvHrCmKS
X-Proofpoint-GUID: 8oghklJucchcuWI32xKMoMHsgvHrCmKS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 12:01:57AM -0700, Tong Zhang wrote:
> +static int rtl8192_usb_netdev_event(struct notifier_block *nb, unsigned long event,
> +		void *data)
> +{
> +	struct net_device *netdev = netdev_notifier_info_to_dev(data);
> +
> +	if (netdev->netdev_ops != &rtl8192_netdev_ops)
> +		goto out;
> +
> +	switch (event) {
> +		case NETDEV_CHANGENAME:
> +			rtl8192_debugfs_rename(netdev);
> +			break;
> +
> +		default:
> +			break;
> +	}

This isn't indented properly.  Don't forget to run ./scripts/checkpatch.pl
on your patch.

> +
> +out:
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rtl8192_usb_netdev_notifier = {
> +	.notifier_call = rtl8192_usb_netdev_event,
> +};
> +
> +

Here too.

>  static int __init rtl8192_usb_module_init(void)
>  {
>  	int ret;
> @@ -4788,10 +4638,14 @@ static int __init rtl8192_usb_module_init(void)

[ snip ]

> +void rtl8192_debugfs_init(struct net_device *dev)
> +{
> +	struct dentry *dir;
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> +
> +	dir = debugfs_create_dir(dev->name, NULL);
> +	if (IS_ERR_OR_NULL(dir))
> +		return;

In olden times the debugfs_create_dir() function used to return a mix
of error pointers and NULL.  But the idea with that function is that
most people are not supposed to check for errors.  But instead of that
they added all kind of *buggy* checks.  So then we made it just return
error pointers.

This code *does* care about it because it uses the
priv->debugfs_dir->d_name.name in rtl8192_debugfs_rename().

But caring about the debugfs dir and creating a rtl8192_debugfs_rename()
function is really unusual.  And normally when we have to do something
unusual that means we are doing something wrong...  :/

Anyway, just check for if (IS_ERR(dir)) {

> +
> +	debugfs_create_file("stats-rx", 0444, dir, dev, &rtl8192_usb_stats_rx_fops);
> +	debugfs_create_file("stats-tx", 0444, dir, dev, &rtl8192_usb_stats_tx_fops);
> +	debugfs_create_file("stats-ap", 0444, dir, dev, &rtl8192_usb_stats_ap_fops);
> +	debugfs_create_file("registers", 0444, dir, dev, &rtl8192_usb_registers_fops);
> +
> +	priv->debugfs_dir = dir;
> +}
> +
> +void rtl8192_debugfs_exit(struct net_device *dev)
> +{
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> +	if (!priv->debugfs_dir)
> +		return;
> +	debugfs_remove_recursive(priv->debugfs_dir);
> +	priv->debugfs_dir = NULL;
> +}
> +
> +void rtl8192_debugfs_rename(struct net_device *dev)
> +{
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> +
> +	if (!priv->debugfs_dir)
> +		return;
> +
> +	if (!strcmp(priv->debugfs_dir->d_name.name, dev->name))
> +		return;
> +
> +	debugfs_rename(priv->debugfs_dir->d_parent, priv->debugfs_dir,
> +			priv->debugfs_dir->d_parent, dev->name);
> +}
> +

regards,
dan carpenter
