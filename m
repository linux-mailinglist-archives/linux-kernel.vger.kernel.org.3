Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F35514F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiFTJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbiFTJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:55:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46213E12;
        Mon, 20 Jun 2022 02:55:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K6XHVY026764;
        Mon, 20 Jun 2022 09:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7KepXjbMpLqPRss+Tr9LRaJMQ/soWqqKGfG1NPOYoHY=;
 b=T5k8v0TZle8jXla24chg/drV/5BKONmXa4BalbvR6iaL7jX61B443igXnYJvHeT5isq5
 oQnGa/YeMrBQ3dR6b1hNg/qdNaRjJen5kypLgPytrMpcaa89NKAuvWBJmv3ZWgY42NWd
 0cS8fSwfKw9APEgOq1ARBl1Sck7uU5P0NJE7c4+pwPANfilKQVfjXZxweWyKlkKG+CQd
 CCOZqH0Ogslt1gA8seBIhgkoyJnVSPeB7x/xb5BS396NoiM+PuqmiRObdZMwNhaw2LlV
 YT/nebJV4pBQduNL4l/LaYCr6nF40aBz34zjza/NQoqzNryyfBtN8clCWmVNI3QdKNad 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf2twv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:55:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K9oR8G035647;
        Mon, 20 Jun 2022 09:55:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3u1aw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr+es9XH2oK1kT0SD8hRjcErJoIzZt2mP55RkXzzWTHOeukVKjLKFfR8M5CoKMvez7URBO87OWP4S2WWlLLmLN58KQiXHgJLOwPu0pKrw3LtmTwUKj2AbeAiqsV6BuJbhGt934CLGeYJmR2/3QOci899bFXkpRP5xBv/iCnFhA8Vljfue05/HmAxfhHEm/+WrKZb8yvVNceYD29LPfc23vF141AfpNUftUsPSfd230KA0YOJz4YedCsF1nSYpfPVo+RWvkNZFTSqSBZ+A/T2KNhdozYbFAhBCmhwbhIyVVE/DbZ6GCs+8YtuwrYzFT3kFB23VvrfBe/uqkVOLNivoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KepXjbMpLqPRss+Tr9LRaJMQ/soWqqKGfG1NPOYoHY=;
 b=Yi0b0SYRgtx8CkvHuPflpZ9pnIRiSp+WlUSG9zwfzy4/1j2JYRMbA9j8gnv+RgYbeqLn+TbvLth+fFuHNtcB7l+K/uJGAwRjqFH4vKhNu4WZ68LH2f0tGKBOqhi9ceDaMiUttbdlvjsZXTFiaJFVYcOG41MUeNeuS9MDINWC7VC/pLcXDcf//5+JglbOTOKTVEZQaKOy2UH8dKWmSkKPJuZq7VmZjsefYSXD5gk6b7haC8dGeHrTNBylmeKgXH+TU+HBZJaAo5K1PfV23nH6D5T/ePJcSO4XoqXpNqnuJdr/bhu4mi9ZatEQf15FdjTWF1StJTqCwZXgf0CElSTWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KepXjbMpLqPRss+Tr9LRaJMQ/soWqqKGfG1NPOYoHY=;
 b=PTS80O+EXtNQY2+8zLblTaVzcOLSoXZOmsfF5LJfcEnRkrqJRjLTQCamNmIpg3aOt3hADqnnJITcbSaQeBnp5m8fAUmNcIkRjzRsuxBCObR4ynPhhqw/2fz0B9MUxZSiJvw7Tqywxy9e3A8iJoO9wlnw5qeuhxtXNjB65qci1m4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5248.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 09:55:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 09:55:21 +0000
Date:   Mon, 20 Jun 2022 12:55:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-staging@lists.linux.dev,
        Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Allocate full pwep structure
Message-ID: <20220620095500.GI16517@kadam>
References: <20220608215512.1070847-1-keescook@chromium.org>
 <38d31460-f3e0-1260-05c5-406a05d9fb37@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d31460-f3e0-1260-05c5-406a05d9fb37@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdfcba86-34ad-4cbe-ed32-08da52a2fccb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5248:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5248118242E6EE9250914ECF8EB09@DS7PR10MB5248.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzY2u1VAo3Hkb0ToQ2TlUoR7izTnLL7Pm9YvKlhDaBPYlMknlWogsicFhuZiMj67tIECl8Nxtu3VrCZ1XnYi6Q6MLWgPpdYgxSwqlPS1b2Lfv7eWW0F5cGwiq6QhYgApQnc1Jl+vNEb0yy9S2gy0f8LShPeIVgG52LLcfK0DPFkXJ2C/aWnK4urGoFx/ZWwwXJlNgirLnyYYptqk8m4w9N9NbELtF/tdQn9gWtLpP5dd7T6IsaFqNlKuK5He7RaIIOGqV6OB596EZX/Bw7/rFMrA28ITBe/I+7BBV1w1HX0UhZ8SqA39xxTvjCT5kXuuEjPm7SlyWJ4DvV14WsUCzQzZnJ3oAI4P93KRif+snwrN7sfnJdulN3hwm3+IWFJ0ThWQxKZWVOW2B/255b2k4YefMfdI8L/Ykx0KiNX+kBEXWS0xVcoX9BsvEeB3vsinLx6ypc4cO+i/JDvkQhDPPp4+UunPnUlVljVoAeOgvapmWZbbcs8T1bZQjQrQRFW2hRcBduoSwOmnLNCdHKFYNkr8WrDu9jZAhCisWkzHUU/zFRYuESbT2zkeJCEj2xw/rQ4hsXVbarUf6WHE5AjHRn3hdAuDhQXIW3PsyRBpElfHAeM7iU3Pl7YhjtIU7AxmD2stEbOqyS5/b7f3EC03CUMKV81vFuIzCgyF9SrGv6VipoEMxqNcRdagz6gCETK9oEZdn6pM7ImnGpWXeOOl2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(8936002)(86362001)(2906002)(316002)(5660300002)(66556008)(7416002)(9686003)(6512007)(26005)(44832011)(52116002)(6506007)(6666004)(38350700002)(38100700002)(6916009)(54906003)(66946007)(186003)(66476007)(8676002)(498600001)(6486002)(83380400001)(33716001)(1076003)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+gn0NYgRkyrroBjnseMG+uiTH09Xsx0TFSG7HzBr5MyBwbGBW3XlOmJAaAl?=
 =?us-ascii?Q?W1oN3G2ESlepa+svOqmk4CbJP2ddECkYno2N6cDkhTBr3hgheencdm0b5QLo?=
 =?us-ascii?Q?MxtvCk9U5RMYvALcPzzDd+D8wsEzUdfWBo26C2VfVzfg4EgmaPvIyC7bCVCO?=
 =?us-ascii?Q?VdahnOz8IGgEyv6XPPUXn3f2MbQqdy0CM0zSZRHs2kHzORwAUb52yYD/6ZuD?=
 =?us-ascii?Q?qP5FK/3vcdPcBqoXwldFWMIC8ff5mKtxbHub6T3POQKr2unH6UZKKceSSiNi?=
 =?us-ascii?Q?Kv16kdZOraTzKqbnCPXgsIcphVIC+Az4sXAf4vWMdcZ/sQv3+EAelp/cS0gC?=
 =?us-ascii?Q?2uJCluJtjWldNFdYYQbe5Hvnfkp9Es7VTk4lCm5JQQCPipEoi5ERXVb8msVo?=
 =?us-ascii?Q?BixWbEtqsde96VUhjdEdjgrzglo7OZXjUdJ8nNDUQYN2OTcM0iQVOKZEBQnf?=
 =?us-ascii?Q?QcyIHwEEmil5iHS6DgM4M17kuGh6i7Ra7oWDnvfua2gbX+g109ZoEiVWkhzf?=
 =?us-ascii?Q?tDWalGeZGFcGOgz2g/vym4KKu2TwhStJbD+VQMBBVJw2GXVNgTHSXuBGFv+C?=
 =?us-ascii?Q?nieZ39n6Ma8rit2cMY59T3t6evVJfd7BOlGM+VcuZy5vJqQkZoClREa5hBKW?=
 =?us-ascii?Q?QTthoswrbHYVbBqN9JXxFdYYFHUizuQ/jowSihGRY/ayd3Ce3B5oaNpKbWEh?=
 =?us-ascii?Q?ytPNpjoYoTtRVCMwdojJtPr/fRqASdBa9o/n9XqE73Eo4w93qHsYT/k+FNAi?=
 =?us-ascii?Q?Ww2L7dRO9uB9rVOTtdhLwaUuYoH2sprTMQej5Zx4TIFzqMQerrmF7d9KiyBb?=
 =?us-ascii?Q?lwrbZeDQ17v31/pZpD/xSLjgbCVsiyLZio+5NP7XtI8jCr/LZIszzI9NwNDp?=
 =?us-ascii?Q?60uLHAcH7eXZrHfsuvu1SB3hBAURVGRDE4YyEbWTg8ZQuK6efPSJaYkjfA0x?=
 =?us-ascii?Q?3JNTPGd/6zfvymZEl3ZwGZ49Sd8EvUTVVk+y8XGRItGvX4VQ0JZxx2cwe2oK?=
 =?us-ascii?Q?LjVKzuyxtdN/DUoI9j3VtsSM8HfyyN87cPaa3O57QnVt75UeCZeyOkN1YJWA?=
 =?us-ascii?Q?jNcrFF15WYv7bJ5iqjzn7ZxGRPnfRqUICu8G6egc8aua8zfqAQsKTuaKsvWL?=
 =?us-ascii?Q?BVEUtswiwkvECDdVFXeTwTt1BGVuIq1MQFVIH5KAichUjc01AhM5q+JFzkHG?=
 =?us-ascii?Q?OOEe+BOiheVrff9LmN+J5qYML0p6FKdJTCUtxhHkgV12i9mtd6l+ZncOsGlU?=
 =?us-ascii?Q?uGJiGUI2e2abggzUZBAPKwGqNJ30zm65CbPJunkROs6XLkR5BmFFezoSCNnu?=
 =?us-ascii?Q?Fm/Anoq4EYhGwJhlL+jR3VGAuTUISwipPEBvzgP5R2ca3cy2IaWFA0RsS2DV?=
 =?us-ascii?Q?f2sh2faHivIIaOihe0aXX7gAP6mG0HL70VIjmE91P1YqlJMdCexHXfRWduU3?=
 =?us-ascii?Q?tgAL09mdoZTWKFcFC5HgJNWARtSlQVrp/yKzdwqqJof5WhjTJX4EOauOdnVy?=
 =?us-ascii?Q?LPejojsgPd9sxxFNgSbOqHz+i81nB8QaI1SaKpAxgN2oV4W4RPnjZvEvuNHj?=
 =?us-ascii?Q?AgJYELqqayZgsyyUbo0GPq8FZ7W5Y44AWltZMrRZSWIeS7NdCVIefbeExBLc?=
 =?us-ascii?Q?iPOjOp0PIuaAGvWrf6J8aEtliEQBntlH467Sso0vFTERyigxfzP0r7CJBYGv?=
 =?us-ascii?Q?+XOHYkrV86MWsLmGd0IafOh0efW5ojBvQB2OmfAVex0+EBMBD/5ND2hZcB8t?=
 =?us-ascii?Q?tYyPwb6JmbtkvTXW2auB+RiQkbbCjjw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfcba86-34ad-4cbe-ed32-08da52a2fccb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 09:55:20.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9HQOhXZEl2fPLo+N/ieamWAp+Cb/+69kx6HaKx+2padEHwrUZiy30Z8GaLtxHEVkHP2+gbviqSEAR2EAIs9hnL+Armcs8aJFB8zhbKqgMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5248
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200046
X-Proofpoint-ORIG-GUID: e2m7zHGvwzuWS04f3v8cvVaw9dzrv0GM
X-Proofpoint-GUID: e2m7zHGvwzuWS04f3v8cvVaw9dzrv0GM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 09:51:36AM +0200, Christophe JAILLET wrote:
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > index ece97e37ac91..30374a820496 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > @@ -90,7 +90,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
> >   		if (wep_key_len > 0) {
> >   			wep_key_len = wep_key_len <= 5 ? 5 : 13;
> >   			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
> > -			pwep = kzalloc(wep_total_len, GFP_KERNEL);
> > +			/* Allocate a full structure to avoid potentially running off the end. */
> > +			pwep = kzalloc(sizeof(*pwep), GFP_KERNEL);
> >   			if (!pwep) {
> >   				ret = -ENOMEM;
> >   				goto exit;
> > @@ -582,7 +583,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
> >   		if (wep_key_len > 0) {
> >   			wep_key_len = wep_key_len <= 5 ? 5 : 13;
> >   			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
> > -			pwep = kzalloc(wep_total_len, GFP_KERNEL);
> > +			/* Allocate a full structure to avoid potentially running off the end. */
> > +			pwep = kzalloc(sizeof(*pwep), GFP_KERNEL);
> >   			if (!pwep)
> 
> Hi,
> 
> while at it (and un-related tyo your patch), I think that 'ret' should also
> be updated here, otherwise we return 0.
> 

Too late.  Smatch does catch that bug btw.

drivers/staging/r8188eu/os_dep/ioctl_linux.c:409 wpa_set_encryption() warn: missing error code here? 'kzalloc()' failed. 'ret' = '0'

regards,
dan carpenter

