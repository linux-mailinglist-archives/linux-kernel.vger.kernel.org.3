Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EA55926E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiFXFkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXFkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:40:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A30C67E74
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:40:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O4V8g0031401;
        Fri, 24 Jun 2022 05:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=21vwsX0ey5vabasqt+VzQTbStEY/+HvIYkMrzwwqHTY=;
 b=TpXP7uF3lj1euLYyhB86jnr98Y8jnnfMVgGAFSFAChbuEpH9avCFvj0tXEWpu1K91eLm
 GP2fH/rkMcaS38YLyn/CK7NbdI3Q0eYa+rAq6Betn5cm0jal53V6k+KQMh+ByiVm4o4H
 826Jpr+lQABaA3zwcx7kk/3vVuRfUkLMboG7QTn3xL92pofuhT6ILzXCHLoZv7lMaXas
 SWonMOoxGoqq0MT4D0Elzv3UwbQ8SgwD7qj0yZ+3g2u8zY+Npo7hjdenhhiaiMBm6/Zp
 vnu428D0RXeWGZhImKPWpHZ+/WvhXj5/8xBX7I3+pk+CthNGKqlp2DrSegmQ1hFmYGOT +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u4uu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 05:39:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25O5acSC018294;
        Fri, 24 Jun 2022 05:39:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth907kd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 05:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6EO004RkYwPWTznXZv1sZFnQkh+v+AnDK1G2SrZqFw5B07dqCqofvGGaYik+HtluEHsBg+8J/YR7K70vgTFQ2x2GNtrhlvYHl5MTPD1j64wAEu4h0pkmj5ShgVJz38vmqGfImbz6KsMLCk8IJNTgeObV7D31XUMjYr25nOHn3aoUs7Avue2zWNtaC3m/ve5eNOeBvOe+SAImPGvilpjJqEDYjffXuL3aHagu3m5TEhb4zr27qqMYWT8DYiSC6BmAS7OECq8MJV6dRG0eVkqnLCKaT2znpskw9SXE1z0vtWjF0BSw795uxEY3ADm8sksHrJReUb5GPtS0ppzSL7znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21vwsX0ey5vabasqt+VzQTbStEY/+HvIYkMrzwwqHTY=;
 b=Vk4L2jG40aL5n7sFlvDpMTsLtOSa/7kD1uv3RFuRj/H6tDt0KcvBT7wViBAt93qeockzjFGMGTfW5/Y62I2Qkw2iVoROWFyuLWANXX4PlilQgLLb5ziZfpeGY5EIVgDDExfZTtvqyV1b2RO6TnzycNYMQUOSZ/e/8c9pPL0YMKt+OE7JIVnolAXGv/coVZwqlpEp2UIyJGC0jNhTTUTnq/2sS53MYLqUOlLIj9avZnKfvWB8XPDQhg3b06YcekE+EYyV+C61/50mxmX6MHuZLEfYx1xKjZ5yip8vk3MPmLt3+d3zbdMr7B477Igb1QGrbqwN44Yft7hDJBCk8g8+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21vwsX0ey5vabasqt+VzQTbStEY/+HvIYkMrzwwqHTY=;
 b=A7n0Tz5GfSk/OVvkv3O9nSZ30lE9BfA4Izf2BsBB7PrJbTthoDFeJ16X/OtDCOBbR/TGgfV+3HBeF2rtb0iZjJEN/nkK119Ri8kcUwDtHYqBHyn/ZGZbsZgF7zy0y//VtZtyR2LICAwB/cM6wAJPhnoNfkP0po3YKOCPYBNK7mo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3485.namprd10.prod.outlook.com
 (2603:10b6:208:10e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 05:39:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Fri, 24 Jun 2022
 05:39:48 +0000
Date:   Fri, 24 Jun 2022 08:39:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chang Yu <marcus.yu.56@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Message-ID: <20220624053930.GU16517@kadam>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220623051404.410632-1-marcus.yu.56@gmail.com>
 <YrQ2Izg1b399yJou@kroah.com>
 <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 382b666c-2ddd-4fd3-6e6c-08da55a3f386
X-MS-TrafficTypeDiagnostic: MN2PR10MB3485:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnE+K+z4Ra3uLzkF8gaZFNNWrufHN/IUIWGs0S2zyL6SjAC6BTzqIUH/S/kqdCVEcj7OoLiTMPhLrWX/hjK9RarwzJ1E/IDq8N+MUDWumaINR98lAsgSzGntOvu6SvXIE3QO3dMCkTb+uJTCBl9IEeBQ0lQDjvKIcuTdye2ANoJg9dUJim83pcZQdTPRLwF6SM44LGgRMEE9VQNx24PQHC5wj6K177eS2V7vFezkqJMUkPB9GBxqZQ5IWC1LaJsMSoDufFQwAC//wTwRd0omuJ100Ti+tD7LIuATPEVNBMWiqw2pXM5NhSL4o5fmVqSetdt6TjmmYiBk6FZIkLEN/14cfCj/GfACbEpfGLP9PzO6dL8tYJBFPDMpnjvs+PqPkEkCVjzafrTEPOC8jshctR/GUFj9iu0eoqmFbhLVr7CtwPatfFHSj/mpH1YQxtl7rlNHgv/b39GfAsbM8K1EGdynQxCh6QRFby0QcL1mRptOjW/F0WiKN1KJm6ETak/Oncyqu1UTfos67tJP1sUmnSaoM3jG9bleTgxLkbxYUm0Dhy0cv7mgZi9ndPnDFhKAfA7IlGv8HYl9U9qdrNPnPrTSOt2clBswUgerPdwViFDopL/KeY9fABH53vp3I80oR5V1HXTM5eMh6jQUMlf2me8rjDJU+udGcSU6z2/6flSxL3rlseOk8jzKAKLF4xSYARkEKdr5TMajgy3iEi8pRP/rz9cazmmREUEcYg19mSNhmd+8OizyON36CcIC4OpQAbfpugWQ+67xiVpJ7n/TAgFE9i6WpkC5DZQmYJAEs2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(66476007)(66946007)(4326008)(8676002)(44832011)(4744005)(66556008)(6916009)(86362001)(1076003)(5660300002)(33716001)(8936002)(186003)(6506007)(83380400001)(38100700002)(38350700002)(52116002)(9686003)(6512007)(6666004)(41300700001)(26005)(33656002)(2906002)(316002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qa6veGI8NYDJsNJRUUVAwToMlxEpHmtNePLwNBK4+L8InG/NikGIRRG0T0OC?=
 =?us-ascii?Q?9XwjbHpu1tDTPaaIwT2A98R3UEmPp+Y0fiKM/E5sYLE4CsaAeTRo+19oViz4?=
 =?us-ascii?Q?C/rARqvD2DhxoTGJ31ZjJF+wh5MlI4V1yeJOYavBH7tvv+Xtw+pMQeCuXKPP?=
 =?us-ascii?Q?GCTPFHNgvS3AibI9xHXOaJ6pV87Va5AoZJb85vAo1xKm7JgJ/OG9A14chRm2?=
 =?us-ascii?Q?yUpPvRp+aF8Fd/m+ZSpJ9uhqadUKazsswYZxDw9qUmSPzYSXPyl8Sdhpo5m6?=
 =?us-ascii?Q?KzPnf598DxuucybKOAM6n4c5KIOT5EAxcK3Z/QpXEUGDQkPfK2Xv1pFv49tP?=
 =?us-ascii?Q?vgsQyVKQwFcVipiaC4ldHm8XxAp3HZp0w52XAMTL3SwKWtejRh8f2z//Q5Jo?=
 =?us-ascii?Q?E9ukml6itZ3dh0TN3t81L1mynsrhaMWSG+16231mGkSsDQNPTx0FsLvNAxAl?=
 =?us-ascii?Q?O2AIN1L+Qpcm0Hqe5aTtEUivOzz/NmBj4GqroUs2e5mpma4VBEqPwIn+KFqr?=
 =?us-ascii?Q?Nn4A9+KYmQF1lBJaxmqQHEPjVPwgezjoCMJzU9ILoiMZ2VbgBIm/H8RuzA9E?=
 =?us-ascii?Q?k3LGT1nOeXuENg9Pjnb7y0T/gY75TMmEc99KXxRB95ucZG9OClTA/AN2iyhh?=
 =?us-ascii?Q?rFlJOTqk+tWrCv70A2uwkRhq7PFILwdL+fXscCiTRiqEMza1qqWYSIhEpdsA?=
 =?us-ascii?Q?Bl76zagf92a5x//V4/QZX4vWXtY5lwmxOlopNTsY29Z1R0L0icd/m2MjzZs6?=
 =?us-ascii?Q?JRXee3sIME9caoVPf/M7FG5w75CxrlyjJ7edDV0VvSQsSKD/03pL/VuY5x7j?=
 =?us-ascii?Q?MVRxs6Ka5+wdISY3AN1uDcweyQDT9hndG+zlK/+715gqfzvUznSn6eJmed6V?=
 =?us-ascii?Q?H1ytinqmN6yDqq9BA6dAg9Pwi6a3OntspmIzZsLBiXWMcKhQEzq/KQVgXpkZ?=
 =?us-ascii?Q?VWkwKp3Q5Q4FZXWUy5jxnrqpynhOU1IE7qemS+BCGoW1e0KZB/QVzu1E4rtT?=
 =?us-ascii?Q?WD5AZkXaKgt2R6azmCsklx3B/IWWdaLDNkAhBC6rNdcCaLlTT/Xtp+l0lPXV?=
 =?us-ascii?Q?LDoZljog8KgduzG+JCCJt9veuMNRnzptwgDrXDDWgUlAcKsO3BMdL3wXqP30?=
 =?us-ascii?Q?HPTQY69uVLjh+VmxJSJQRyQMDCBtERdDJLNHn0QN1u37O9P6vIVe0R08CY6h?=
 =?us-ascii?Q?1/tiuSUvEGJ5E4GqObauvClUTsDJlZZtrNjd4t4HHDWSfI4MDuQlLnqfu/oq?=
 =?us-ascii?Q?95FYkhMgFlHRusMB5p4VnWQxJZ1JFNpLIEC3cCxoj+09mzDhybhPimPrP6d5?=
 =?us-ascii?Q?uHW0zCxDFnHNoQXqQ5KAym+ac2RmBDkfJvaeTqEsOD2K9qTyTS+csKTYl3Jd?=
 =?us-ascii?Q?bRR7sEbd5vbAAP4uk2KfEyUWL7wWux0yUQUdYX2NR6bVQpyNVtvO0E1b7/vm?=
 =?us-ascii?Q?jVrms4EHLAX6P6wgyCXAti2eAC+YblW1RV90dN7nQWQ39W5GfkY3H3hKWxw1?=
 =?us-ascii?Q?nYajmFl83skYYsTWmK30pu42jrxmU12On0zVLQfVsme9sOqQmsiLj931zlEr?=
 =?us-ascii?Q?HauhW+n4l1JPmnkb8WrV3LFqaG359A8NCuY40vYq0TDflujvw2uK6phrjM4k?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382b666c-2ddd-4fd3-6e6c-08da55a3f386
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 05:39:48.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46viGUc/z3Ko6uTc3G9vTOcYq5gnriudtctzWBvpnZ3IXxTuT0IO2Oy5sdWqlb4TyhzgYaIz5+MsCMCVjhsw0EC6qLo/SdHRfEzjmNU1ywU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_03:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=715 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240020
X-Proofpoint-GUID: unQ_Ne6mzJl56QrTLwgc-rve2xhlE2ry
X-Proofpoint-ORIG-GUID: unQ_Ne6mzJl56QrTLwgc-rve2xhlE2ry
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:34:54PM -0700, Chang Yu wrote:
> > - You did not specify a description of why the patch is needed,
>
> I'm not entirely sure how to fix this. I checked the original patch
> again and the subject and the body looks OK to me. I'm still a newbie so
> I might have missed a couple of things. It would be greatly appreciated
> if someone could point out what's missing.

What's the advantage of combining if statements?  Out of all the if
statements in the kernel why did you pick that one?  Probably it's
because the indenting was wrong, no?

Write the commit message like this:

[PATCH v3] staging: r8188eu: clean up if statement

I noticed that the if statement was strange and the code was indented
too far.  It is cleaner to combine both if statements as well.

regards,
dan carpenter
