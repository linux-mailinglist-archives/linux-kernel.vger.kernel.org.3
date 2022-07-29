Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2586584C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiG2Gsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiG2Gsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:48:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA579EFD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:48:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T1Xu9r003141;
        Fri, 29 Jul 2022 06:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SLvdZM0x2WzlSg6uoMVLl+ZyfKICboJlgiaS05Gy2Rw=;
 b=e0GSg7BI+JrpHfImOaQSMU4CRUyT8RL9rMPk/hqWpnb+PGBTfquBa8YbivAOPukn8JG/
 jkJcruasYY7DZeCc2f7qvZe5KnYHkaF+Vp0I/V4pW+N1W0jIcHInxi9ZJ3hzuVIDbGqK
 5wbBsAHePRatL5MjzmmY0+5sTg4N+NRG+28vBOO25tNWPWUS5eIumFxKzfK9/Bxfryp7
 rg0sns/1rxEVy61lP0OK1XNQs7jtDqgiYpMiBG3Y+jvjAhcjH3gmCCSeXMgiZbzxUB1g
 Jfy1iUxcxjq6sAb8CZEMsYKg5JwAi5Ir17NAbMJTAwJ5hacKSvbWt+TJ/agvQLFh/8jH 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9php2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:48:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26T47Aw5009129;
        Fri, 29 Jul 2022 06:48:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hm888ajs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YErMtlWJntqChHDIwwca4/JsOAWDNQMqzw5OPP1unEOvuOj/jt6bYDH2QTPxJNZ7HIUixZ2j0LDkHMDd0Y0SAa71xuqEG+hRmZwHSHYJvqTI2HcZcMrsT97Y4nPLYGb3mE77FFBKbxScx13F11wzMDF3t1eDuJTxO8qNtu9j9xb0pUNCIiaEmENPkugdBPzMzSNE21It7wt+rghUq6TvnGd/1yfXT8dnlD5+qpoEFp7PDToXug/pvDK2ViIHOU9rkTDEd4IK6ur3NNf+em8uOdrC2GLsZ32DN74W6ZVZMXQBL/cflkHCnIRSlagdU1OLHx399Uop0WodIx43nI49Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLvdZM0x2WzlSg6uoMVLl+ZyfKICboJlgiaS05Gy2Rw=;
 b=CHLRtRcUabkb1tew+N6ahwNaSn8oz9LUksTtYHrsfNTOWglDhUcW/PKB616HRHMvG26mvFyrUWRQkjarKEB9Cc2Strjshm4LAsqshEJV/HjXwTTRKvHxkaCMnpNjaFPtl1joJ/4hPWieAlq8dtJVvuazp1FWf4BRHbP2DtVSDzWc962CmRbTtfjOgvc7t/h0VsqLs9UVIV1bexR9GWPb54TfjhsIRPLqjLUAsH66FMk9u2oub2cEJ2EMIByaePxOY6fLKf5UyKhgX9EXb54bwIlbmkySVDaILhTFjeFRRj8gpJcn3gZLRhc7mK+sAyg1P/0YSTXT48kn0znEltCR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLvdZM0x2WzlSg6uoMVLl+ZyfKICboJlgiaS05Gy2Rw=;
 b=BkDzTQE0zWWdSeKhRAKabsqiMj7O7MsOck3id1sqS+/c+xNJ1/R/VdIr7IWxvv+5P/OE8Gr7J95SwhoR92OGMImaQUY96Tc7EwO1fJZayxx+5Zo1Hs7yJi0JUBmyfovDz5PeRnEFvu/5fJMjVH3lrD0F/LlwiWG1KBVBoupG+go=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB6397.namprd10.prod.outlook.com
 (2603:10b6:a03:449::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 06:48:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 06:48:16 +0000
Date:   Fri, 29 Jul 2022 09:48:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Message-ID: <20220729064803.GT2338@kadam>
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728231150.972-3-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0087.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5408cadf-1bc7-4336-eac7-08da712e50ee
X-MS-TrafficTypeDiagnostic: SJ0PR10MB6397:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv1GW0Sl1vKipUVYyhjj8jDHPEhwl4pkNJtTIIncxFsGvm5l0LFR3w/7yMHTxVqMVtDB27N3CMmbTN2RSsp8lB3JMr89n5+K2fvmNmUXYm5YehY0FP4nmDKGMTlkDZcn5Dc//+HZCkrd03sIhEHT8EDFdlfH+9ZR6CqxA9Vlz2wNPQVtFZ615GR3BAgXMTbEhOBuI+k/pHOvFMOpy5xDyf89G2rXgHshiab3w9DDyJU9T3YVNEcRNCL4oypJkCBhVPUgOCQHNqbnbGZFJa4zNY1hBjHx+nYWCBN1VsPEn/Cn9MYWjweXaixXQQIp7CLBpul5iOUZDREiVtgwd2MR2MU4GdiTOuyr88vEXtsXy17WRBUM5sYt3I0yVD90eZw+GsCwl/rk5oUMG/eFYq3R2yHlqmA1B8KR1AuHsnNeKkuB2WERZG/lUE31N5euD8Yyc9zFXgJ5WBM6oZBGMWEqKJfPhwdnq4YW2kHgVs6jIqGfRNJYxpDRw7YYYeHZ9PhxGdpp54a0jIRxbzGwGh/TvB26H0Oh5/IIPVvvxsbEOQqV8P4fG6+4fqLXs8N95RPCbxuUlJ3CWOuXAZFbJzpYfR2mhVpNZr5J6+Q1+Miepg3m3PWAymwIegIEwIcZQH1ES5vdhJFsm4jy4hqJU8LFMxc5AqNayutsly0GlkhTdZ3FfGFEZr+/dSpnu42L7UyUCIv9vjObopk97gdP8KAWAod5ycWn4PM8y0YBT8/007DRZ8RwTDoVLJtUQ0yeSTCcx78jTok5TFRUlArvL7kweVRKly1x/j/Bz+vOFEdJJ9dorHQ3wP3KpafkHGSQ8GzKS8ASqZgsjohTRdJI+iDlZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(38100700002)(38350700002)(41300700001)(5660300002)(7416002)(6486002)(8936002)(478600001)(83380400001)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(1076003)(186003)(52116002)(6506007)(6666004)(6916009)(9686003)(6512007)(26005)(44832011)(2906002)(33716001)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtbDCFHwz3ulrX0QG2sRWH9NhAsybCloAPPfjRwF8rmpLcp5J+utYGAJ5EUl?=
 =?us-ascii?Q?EmohMCIQ+6qxbJ9nK4eDvNPz77DQLJPLrQhdQBiTpk3X3mLblray7R7qkPb+?=
 =?us-ascii?Q?GlhVrz00RYAq1MPWvAO1dZOQvr1wL7/dOiAlQ3ko4XiKcMZSCbT/qI2aLYlj?=
 =?us-ascii?Q?xEVOYFJxWAJ3o4ymFWG4hkR83pVn+8+Uf2+B4EkedAJfjDAGKAT2duQC0WIb?=
 =?us-ascii?Q?2DMmMg8Oalr7DTAkqNHh3k7g3Vm99xnfVA8cVEp9Xe6Msfd2VFyJEisySRHB?=
 =?us-ascii?Q?xhOUtMs7QeihRu6j/9Ck0SyEPq56MATHh/jNjzaTTAjtIkLwKlQHxpbQ1cqP?=
 =?us-ascii?Q?lp1XC4B1Alcco0xgJXdbdt/gaJA+d5/VpWe4ICe9cZ35X0EJEiylmmAV4t5j?=
 =?us-ascii?Q?g3Hsc5ku30H2qZKo3rtpYIgHkWLSnVNYbGnmUhA5jSAaH3523oTOJjI8gsET?=
 =?us-ascii?Q?axMBc6Eba/TwXvw9gF/A5LPuVRjsSHbSwkqNSuQcsRHxwhJDfpA4l2XHUnBF?=
 =?us-ascii?Q?6Sx19UhmnDZyhiEVZMdmXo1gfF9tCIqR5Gpqd+oeYEm6lglro64Utpa+NVUC?=
 =?us-ascii?Q?oRqZgDnl+ILCqAqk6NN7qqjofqKzwoqdwK4CN4aMrEiBJzMpEDNfxbKN13SO?=
 =?us-ascii?Q?g63S56OAN+HWA+auvo0Kjf3TlhA924TwkzbmDKWUk8o29XdNdBqkF5qcgDPP?=
 =?us-ascii?Q?IUSqT7tZCU2yD8HEDS37U/mrxdrPdpbpc+Eb8TORewrx9DmYonQd9JWa6yal?=
 =?us-ascii?Q?OOFZGpfCVXgL/KJc0NeyHIsCyQ0VLpUbxiIsxEGhNi9y1OyWuMymOg8JoYoP?=
 =?us-ascii?Q?FfjM/MrsgKnOm9HCqdQx4L1s8PFRV71s4/BHDaqej89Q/ljPFkNNPKfyb9/A?=
 =?us-ascii?Q?tAGs2ICGEhyCfPdCU4eC3Cjum3p8Kkvdd6tRU07FV7oJ8+/FceO5L1wIBhHF?=
 =?us-ascii?Q?+vBL3/iBIzjIGyJE+VWQxVu6qJDi8nZcQ7Z6dISvdsm0WF5gw9iv/za2LsN2?=
 =?us-ascii?Q?gU6nOwcjoqTvWTsGoBha4ean0znfVbeACzFXdJkKU+5oItOEEk3ee3Vc20BA?=
 =?us-ascii?Q?uXKP/VVle0GklWkEwjKS5aaC3WD6UzvBfnltPf9PGG6081cBUINKWS2zyWto?=
 =?us-ascii?Q?Rf5kE9N88XWmQMohfN7usoWU9oOguxoreLfL5LSb6WulIroWFKFHsds3biUs?=
 =?us-ascii?Q?EVbs2DSvUJQ2aq4ckXPuCPlSZuF5H2U+cGAV3adxrxZbDOOEnW0sAncG+zvo?=
 =?us-ascii?Q?sYiYW7ah6meB4bwMm81AfNJmvqtcR2ajVVaCcFKBn92nGAA5INRlf+cWYKFT?=
 =?us-ascii?Q?9dLxVKBwOVkVRnjmtMn4jDybPEdrRndk0Xky8LaZ/DCc0pKg0YXuzf4bmRon?=
 =?us-ascii?Q?7PzzBMQo08/OD0aKMBwVpSfjzEsPFp0JxWXERLDDHw3UMQy9XWWlLL3yg383?=
 =?us-ascii?Q?k9tcZnjaOLxyKnFOT1Ji3Hnp4qG92RoqVeOgCKkjhEHlr5zI74kQbPL00mek?=
 =?us-ascii?Q?jq6DW4jdWHnGtyvfkvWHSVxHIhfDQYlq2HyxQKAncMvs6xoyxM1adzMzmugQ?=
 =?us-ascii?Q?z4e5000goJ1eZ4le4lWA5crzpGThIFQc4h3kUoba?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5408cadf-1bc7-4336-eac7-08da712e50ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 06:48:16.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq0K7ro77RpQvK2aJ8Nyqs2wWhA1nkD07xR/MY80H3fULfgBrmLxZCGIAG+hQ4up9pZjhX1lWZkjj3acD31cXQmIEMChUMU5ieAbbftdYJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=943 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290027
X-Proofpoint-GUID: hPWIwUwze7l_5kuqTyGBR-BEJx81Hte6
X-Proofpoint-ORIG-GUID: hPWIwUwze7l_5kuqTyGBR-BEJx81Hte6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:11:50AM +0100, Phillip Potter wrote:
> -u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> +int rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
>  {
>  	int		keyid, res;
>  	struct security_priv *psecuritypriv = &padapter->securitypriv;
> -	u8		ret = _SUCCESS;
> +	int		ret = 0;
>  
>  	keyid = wep->KeyIndex & 0x3fffffff;
>  
>  	if (keyid >= 4) {
> -		ret = false;
> +		ret = -EOPNOTSUPP;
>  		goto exit;
>  	}
>  
> @@ -424,7 +424,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
>  	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
>  
>  	if (res == _FAIL)
> -		ret = false;
> +		ret = -ENOMEM;
>  exit:
>  
>  	return ret;

No, this isn't right.  This now returns 1 on success and negative
error codes on error.

There are a couple anti-patterns here:

1) Do nothing gotos
2) Mixing error paths and success paths.

If you avoid mixing error paths and success paths then you get a pattern
called: "Solid return zero."  This is where the end of the function has
a very chunky "return 0;" to mark that it is successful.  You want that.
Some people do a "if (ret == 0) return ret;".  Nope.  "return ret;" is
not chunky.

regards,
dan carpenter

