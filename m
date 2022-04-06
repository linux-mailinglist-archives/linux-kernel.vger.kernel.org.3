Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84AE4F64A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiDFPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiDFPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:52:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF43DBB09
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:15:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236ChiH2024455;
        Wed, 6 Apr 2022 13:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=TxbKxo4Ymy0SJASSUm00qOsMawOmRpsZmcrCUdEqILY=;
 b=IH8FtwZ4yWnBt8ogL2sSvHqS6nc/RiSGScHzrx6gmImexLGcTe/nOWaI6yHD82c01kFH
 AuJ5LXzHzzPEd/sJIAPVW2gibpG/uIEPnAqlypLSrqwiq3tPswAciwn4srIFu4tP+Skk
 B0k/BTrpqQXUVZiHqIm7vJ18jBV0tdnpHi1pOiqPlbq+e/dGEJXejM3VlUxTUvhLt+Eo
 aB2+U6+CYuOjPYkX0Fxz9Z7OdRxULED7LStg73HFfWHIpaf5TKsRBT9GbX7I/cScKyc8
 hTBYaIs9yDfb7QfpHMfwyJ75CjYQQYWInv8KDV9VWwGhNgJu5H0CyvHDDMeeAP1j+LO3 uA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t8xqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:14:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236DBXH8003603;
        Wed, 6 Apr 2022 13:14:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97ts15g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6/gdqapARt6oIrb+Yn5NxrLih5uW6NMVD4PJ4mO21zwMDUsLFIIsLvg7vIiaNPfJsGwN2aHafiE5Yp8cpmhOlIcSUS5GMyDSYNvLIitOS0MYCdoo2SxOt8qytXMkF6iN5p4I5+EuNafomiOOYYXP4MovDrow6OOPt0tDK46QKFsgot/gnfBpXpSNmy5uh0utFLeY7v09iur7UKW/IhRYWstNNFUQWIUWB7H4gackKCTQnQE90RvoYgEyL23ALHONsIAmBlNJ3G758WW5VFpvq3vTl40zKclDrF6qzhP8um4ePCsmv0A1Vo/fDZW+nV0WBhiUyf6UV90KXOAc31b5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxbKxo4Ymy0SJASSUm00qOsMawOmRpsZmcrCUdEqILY=;
 b=K+vK52nKOgdnRfYelspjpB/L9Qg+GIbMeKXoPm35BdARMUO8+KqTiyTuKa0CcQ2cxKfX8BNEBaNYmAEOdgcHH4sEif6cnA0RvH9ryMDMpxUX5MhiTsQNHvquzxw1SmsMA4pTQXIh540SqwRb1Ls0sZXqokdbtFPpBWsjJIqBg6L5kRnNoq1awtfLMPEF1zY4DxxOsXHWP7yHlcdpdQP1CZtm+MPw0lAsWRjbWCqPbACC5TCXscY68Q0dpA6kmQPfCCwCPgNgPhukkEocT1UQvigx64uLkgWicWACZ1VSQ0Wr/vt89OaRZ6nfTpHAuMxdd6v22qymOXFl/gPniUn/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxbKxo4Ymy0SJASSUm00qOsMawOmRpsZmcrCUdEqILY=;
 b=mtq+tI3RPCS4cFuQf6/WfaN4uSaQ55oxTjy5cgdKnGXXXA1IyGfF9epf8Pk/SIPmLW1iJ4iS8HpMU621aG3oKWO7h2ceEVkpI4Um0MHZtCTVtc/wyxXXp792pXJwkH5qRs7t5TdnSLMXRJwG8OSltAT+M4bFljtpPF+cnQUtEPg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1737.namprd10.prod.outlook.com
 (2603:10b6:4:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:14:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:14:47 +0000
Date:   Wed, 6 Apr 2022 16:14:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        straube.linux@gmail.com, fmdefrancesco@gmail.com
Subject: Re: [PATCH V3] staging: r8188eu: Fix unsafe memory access by memcmp.
Message-ID: <20220406131426.GH3293@kadam>
References: <Yk14tpZCOFCsvtup@sckzor-linux.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk14tpZCOFCsvtup@sckzor-linux.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59704edb-ee97-46a9-a3cb-08da17cf6bf8
X-MS-TrafficTypeDiagnostic: DM5PR10MB1737:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB17378E7698AF5BF0E45A92818EE79@DM5PR10MB1737.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mdbWUpf53ev8kCSmPGo8Fei1UlAplepbd6Bmcf+LVvvW5Z+ZZ3scA3AQBy4za4dQSTFmyyvqw/JVbTWQ4WqqodW8+FfAefKXTj9fKpcpDJwChtOjyGZoGum5DfF7+Fd6WhAJ4GJNr4NrQor7j74iweO+KlUUUesu5INyYmw4r+YViEPZTqTL+nIWMSyzkVhrgoKNm9lbtK6uRCh0+H5UW+WqSVIHp8X8v/nmuOh+PhAMqDMrSfuUiXgRnxmy6aTytKR3BwmM3eTQXrRumlmfSTV+pxUt9n8E6rxAeK8NdWXTjKxYepk6JzgZsTAxYyPcXS2eprPG2MmYl4kGEg3IWi3QeqUgC/Sn7vd7uG4nXCHjtqauklhMOcSJ40HSQn7vLPpqzoS4CPqkuOMBVKnWDqMIyRJ+0WKD4t4L0OyuOetyP0LmM70piWyrAr99UFFmzTnNNAk9NX/4fhqqBCG6qSZ84eeKG2VrUP9eHcHeRtho+D+3Fha3sQSo8jeI0PPQ1pskJVmYXLK8ji2n8hBFuClf5bIEPNMlZJVmgcXtqHkgoKoDK/wcXTt3K6PDOuM3y7h+HSHewROj9oQI3GBUQk8tiJUR1Hok2+/SWhOGtD4DgXgPWIehgJ1rLfT/knnjXQBR4G/EgOfrfVcTuAEiireCV/Bx8IH6EQGr7Yoi/aQsqOsyg70NFSkOJY4B/Ff0HuI76Owi7a48OzTDC5bn29fNbHXtLvyV4hqyX0w/m6pa+YxjT9r5s3MKSIyQupV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(9686003)(6512007)(6486002)(5660300002)(8936002)(52116002)(2906002)(6666004)(38350700002)(44832011)(6506007)(508600001)(86362001)(38100700002)(26005)(186003)(1076003)(33716001)(83380400001)(66476007)(66556008)(6916009)(4326008)(66946007)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZFnZpZEJgJUY6rj68HmrYQIBDyYszXQOqFiyw1tmBuzP81wvaWC9abcp408?=
 =?us-ascii?Q?M/eIrHKqxYzxo4Ekawy3iwac8g1/JGQZeVXiS95j4D9aVKn4NJQqsKLSeKgE?=
 =?us-ascii?Q?UkxasmCWWX3wtqdlcHRAnCaOTfr1ASYrx/lS1HyLGwWm8p+8s4Ag8IzAp0W+?=
 =?us-ascii?Q?iNX8Rr4wRFCSBVK90PMNUazjGGYMB01ddEPRLARNP/P0baYVjqhQelLZKKHK?=
 =?us-ascii?Q?lmt2Khwl5W87uqiRYR+tkrCsgu4SFxPVAq5nBJBV+UrW/dE8ZwWdVVLpRcDe?=
 =?us-ascii?Q?foLvP3jQPxyESy0U8tCnnzyX33mn+x42wkL2wnnOv0h1/7Gu/tahaphPDjM3?=
 =?us-ascii?Q?TI8J4iwbcX9Rm9ieLAcLVxeNwTB3aDQos8YJg9pV0tMR08pJIcovzo9fCyjz?=
 =?us-ascii?Q?WYzrBoDWILlsBXQBu5qD3Ijte5J8J+tDHamnbgKQVex9ustIeGfSwDcikQc3?=
 =?us-ascii?Q?yq/4VUm7MlSBlrICDAWI+6Wx3v+B0aZ7oWmZVOV7uuqSr2A0Pg9uTDz6Ng7y?=
 =?us-ascii?Q?J3Ik7p9dLwR7XX2RG56CTz8nSOhYqHox9chG2v4wpBZfCyEo3BFGTRnyrYlR?=
 =?us-ascii?Q?wPvor8EqP4iqYnmYMllV1RMNh9sK0jwX7m0dS5oidzI2yH3DsEXEHt3aFhEo?=
 =?us-ascii?Q?sqxgoUus5ZNJjDuYS3XywZYhV47f6QHb/2Gd+/+FnZWwTLpHCFsN8E7nEvdd?=
 =?us-ascii?Q?3RypEM5mIqGild15TXsnLnOojN40Rh+Hl/2X+/li/+XWjAVYunfvKwgAkAG9?=
 =?us-ascii?Q?IjRZci82GtmrbXm5tiUOWudnRmmoLMnu3hwJ0W7FVfAy5lzcRaXH4JP0jEMX?=
 =?us-ascii?Q?DPcIj8VVqady3n/AYRtPA1qzp/KCM2FzaECnsayGKKZkkh0CfVclwRFMMKte?=
 =?us-ascii?Q?3F0ttvwkcMiQlll5e5fnOVvWqfpdeJa9fn6H3oppAoJcPcoZueCeQcefcUiF?=
 =?us-ascii?Q?SERSIAfsPqRslwXkpYl8QEzL17ZIvgEqrQauCxcgV0SuL6t74s40JWJSXwDQ?=
 =?us-ascii?Q?dWObgcNF3i5HmJ6ELJSrPUMmag/kMQ5C6PiTJAj+Hmce8mFbSQ/NmImQQvIT?=
 =?us-ascii?Q?FY7wWKsIfIPKElEVVx13WPufkQBtLKiuhJB34c/IeKhm8CDMZPnqe2mACpii?=
 =?us-ascii?Q?NJFne40hHi76JJadjY+evDz0/o6bRuV/nGqWXO6quh3EB8/Afh48M57CxP3C?=
 =?us-ascii?Q?p37I3xRQCqLo4BHL3Z9Evd67vJzF5Dwdpb3K7g+D+hqWJpEm2TpIaFAEIxpS?=
 =?us-ascii?Q?HFgCjIDuvUJFBvzNlkTiogxq18lUWvKIssZzz4gIh6aQvXKnzV/oqLv6+dj/?=
 =?us-ascii?Q?ClLaY25GPUB4nSrFJ0epmkQsuwA2OxqFEqhgt3eSX8Ssr6Q6BiADFZpAFr2b?=
 =?us-ascii?Q?ZYENRM8bstzTk2RwXtOCj86Acd46ZMy/4YlbleK4kdPtwH1gSUStPC1ziqzM?=
 =?us-ascii?Q?GNlg1OMlM2JUoIPiXvWQhgL3Uc7HO3XpCx7nm5SUx4l4X7f5xOtNt4a5Gc29?=
 =?us-ascii?Q?2OKAjgCTkLOAxBgh/+XS6+8KaxG6oolojhLYHnhjH+th46EDSpX6Ja9P3vrR?=
 =?us-ascii?Q?44jt8bXmtHUp3PcJ6+2ENIU2apmzCvxkhMaWxhej+kmobnu0OriXPkhRYN5P?=
 =?us-ascii?Q?WgZ6P8uqsGqY8G2DCfgp6be4J9qnLKtYBAmvXG6+TNM8+f7CAp0Qnju7P4nQ?=
 =?us-ascii?Q?7TV6jyjm/UzKufVVNygLXUzFY/vUBMRMQ/qtcYtE4gwRanUWuUlahyF/PglG?=
 =?us-ascii?Q?nCZCPxozcDlBjo2qFQGliJFEqhWdRRA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59704edb-ee97-46a9-a3cb-08da17cf6bf8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:14:47.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjGZiDslSA3UiWsNQlrY8cJlKGj27VoAD+V3vAl88AvBdU4lKOLbdmT264guYYYeY/MDFGupMtv/4AHFlN2feJZ30LEBmZst5KmD2ZwbTQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1737
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_04:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060064
X-Proofpoint-ORIG-GUID: NmFGL-lqybjNlrWA2lxcG82TnKZXHQ5H
X-Proofpoint-GUID: NmFGL-lqybjNlrWA2lxcG82TnKZXHQ5H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:25:42AM -0400, Charlie Sands wrote:
> This patch fixes sparse warnings about the memcmp function unsafely accessing 
> userspace memory without first copying it to kernel space.
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
> 
> V2: Fixed checkpatch.pl warning and changed variable name as suggested by Greg
> K. H. and improved error checking on the "copy_from_user" function as suggested
> by Pavel Skripkin.
> 
> V3: return -EFAULT from the function when there is a memory error while moving
> it from user space to kernel space and fix incorrect subject from V2
> 
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 7df213856d66..9f2182b8e451 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> +	char wrqu_data[9];
> +
> +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)

How do you know that the user buffer is passing 9 characters long?

You're fixing a real bug, sure, but you've inventing a new API and it's
a rubbish API.  Just delete rtw_p2p_get() and the associated code.  It
has never worked so no one will miss it.

regards,
dan carpenter


