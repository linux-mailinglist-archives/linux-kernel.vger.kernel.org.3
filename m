Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA644F90F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiDHIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiDHIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:38:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528AC2FF6CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:36:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23875nUA024505;
        Fri, 8 Apr 2022 08:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6GOyExoSZi6ELDOXmV1I+QVRMAup//4wie9IDBv8Q2A=;
 b=S57mfo9C1Jzm4OSTmReRwWUDrbi+2YYFqcZ63NXVK83Lmquw3eWy3nuFc6zdWgEALGwG
 x0TQui157IsvAbXZZqc6XSZ3EOEfjU2C1gKocLVYzORz6IMEnZtfmPda1fuTM/lxgWfB
 xkTEqkkXhPPO0OrTWmplP77uqIlhLLP9iXLjknrOl6uoYB3W41VXO+afENbCrlD8DUmA
 F/MLwIpt/B/PNFwC7OhrAGJf8aJuHigYu5XbnM8NJKEZ/af5r1/hSPO1NjkloYDc+RKh
 6OP1ogg8h+KzTMjVQhv3lLkqDsZvMjMcGLDFngjcfjoNhogxhvaHayF/EJwkFaoY3b1r Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1temj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 08:36:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23883JWA013740;
        Fri, 8 Apr 2022 08:36:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tub23f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 08:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgauFvfEvk4oltG4arWSe4k6PxMZCEabL6mkojCRC3kO1zKmkIPX//DfGQMAcghtFlsyAgPM9HLJHUdEUPPFeTwXoecdkXVmF16NbNEehz8NL39X03++Mx7QMM7UGKtgkjXnfh/KPov5LY1A5yYsxSZzdpZi1Pq/0/Rk46JRJkI8FzCpXAfE64KD+qBS2TMjofSi96Cgj4YT/fdUFp20DYy3HrXGp5vl/yixBrrMTgdHJ4GpC1+dfAq0lHrAt5zqrGQ2AUvdzuSuHLJ+8E/EVLIkl8hg0YGk9zfCK8B+xgeyKCVGM+o7I37HK6RsSfjE7iTTWbhiWPlklDNN/cyX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GOyExoSZi6ELDOXmV1I+QVRMAup//4wie9IDBv8Q2A=;
 b=KKkl96v1F4ZPk61ARS1cqIcV24RMCMMMge817NhJb+uy9je7RFIQEipiKiZUaGUt4Cs4uPC2ydcTCAD6SQ0eI8zTRI0V2u0O3Y9fAOHSVr3CW0J7o9G9gThQt7Xzy78k7ppGh0vAfsNPmg+FA2I4XcbNPdQTmucdquXQVFuzfsrse+YLoE2jVWq9t5eaEbV1x2q62BDVO5b0/MpCgk5L5N4suwb+0nLrsFqz0daYxRsw2QsXJchL3b5S3qu7o7LMWP8JcYKZLzwd+MYscf53wRlCaKwfk5prPtgJOTAJa6w9604D/0d/msOT8y7qy7mQuNXhN26+SCOBHsUCXP90cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GOyExoSZi6ELDOXmV1I+QVRMAup//4wie9IDBv8Q2A=;
 b=cjuvco49s4FPTA7WamW91cuU4Mh1TT3ZuYoxyTYv+VrwFEhiqX2V0BOx6dEdGDv2ifq3THPSnFJHy4gHPHvQ4rMZwNL0Ibxdayc7QpwFxu3/tMRKQNpji260VUP37iTN30ViUbZkX9B8Q2XJH0IeTzKSY/ZbfDhCvEKy70nwta8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5198.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 08:36:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 08:36:09 +0000
Date:   Fri, 8 Apr 2022 11:35:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Rebecca Mckeever <remckee0@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8192u: replace ternary statement with
 if and assignment
Message-ID: <20220408083538.GR3293@kadam>
References: <cover.1649378587.git.remckee0@gmail.com>
 <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
 <alpine.DEB.2.22.394.2204080614400.2199@hadrien>
 <20220408055732.GO3293@kadam>
 <34d0ad73f44ff4990f6bee49105ac49bb55352a5.camel@perches.com>
 <20220408063133.GP12805@kadam>
 <e1e0a871d1a991980ffc9afe7198775b27833f6d.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e0a871d1a991980ffc9afe7198775b27833f6d.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810b5954-4a81-49e0-3d8e-08da193ad46b
X-MS-TrafficTypeDiagnostic: DS7PR10MB5198:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5198073D0740946C80F3B5EF8EE99@DS7PR10MB5198.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfFC0QWEqxShcfvuEZVk0BzaSa4hlvjMKKCEbMgxMEkWa13SqJx40odUiykhuccCx+BNPv0Gdoz10nRzwAb9zQwU6jX7PD1lIUIZJf0jEUHhKITbWmlAw+dw10UiCgyoFuGvnh6l5Hkz5GCzZkCMLe4Pii7fjq1L3U+ZbCO7Mx06Z360g5kNq3ac/MrFi3pxSlm/2Soz3y0KitompG6NqpEbQ7Dwa6+2Tg0u9+/nDAMhsQgiB+Pzi6nXzTBXrSa0Jqp0gdVO/KEIESxjP/4gB8xIGa6BFTQtYxOc+Fw36hbBD+B/+J1oU6LG+KmWgn+sEXnUxUxkV2Q0JewmDsziPmMk+CtU921lGPnm+254JGXiJ4s15lAC1WVzyrtFrIvAFpJgmablnd7UiGWxUfPTVQVOjJH48BylXBELeKZZ5HCALwmKkJKkpBECXmzXcege2CZIWx4qtvnUpe14Qow1iGzRvytq7hZTFsNSpWtUvEao7Noee5KyxxJ0hzsVoXegoH42jkMHMdtMowCaWWtGWgh2+/05DuzgRYlvliTv1PmMexfJryAOkXobmHjWFP8BepHoe2k0Ura5zfdZ8uD20wu8VKw8FIDxYEiO6bwfaap1TnyQjRc22l9oSLKPYBr3nXiCiHsC3qOfwnyMMaHjL+EbZ9BfqhBetA2KZ3sViFOoHFPHc6NLHHENjFQaW3KgI7SgOUYPAHb5pjHNrIOl1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(54906003)(33656002)(6916009)(8676002)(6666004)(6506007)(33716001)(66476007)(6512007)(6486002)(316002)(4326008)(5660300002)(508600001)(66946007)(8936002)(1076003)(186003)(2906002)(38350700002)(44832011)(38100700002)(86362001)(52116002)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRxsv2K2ZN3GOQVchunw3Hds0oyY9EhpJHZShb2ot5rFQRelofa8qsvymW2j?=
 =?us-ascii?Q?pFFF1tcu+e50FKGlBFL653ZguS0RfG97TYya0EGIFBvSmq+XA7pnzeClqA6O?=
 =?us-ascii?Q?2632jWlR+vKUOtCyhlHUs88rnPEh0Ov6wgD12GC9gmIX7rd6p4kItv6T5UUX?=
 =?us-ascii?Q?xGtZGRPb5hUPGQLJRz474UPVJShF7OM4kwMCUyCE/0NRnJGgLmwqbmb3nL1D?=
 =?us-ascii?Q?zoD5NPSHHzKMKenQyFr9Lx6wyQ6ek/bs8wrxy1F/AUOEHw8e+1CCSXy78Pt+?=
 =?us-ascii?Q?9e+VEsYcj9pfjFGo8/AJtAmuBgvca6m+ENxazYXKqOHihMeVfy9bfOXXxW1C?=
 =?us-ascii?Q?NYagOTTg8x7XC88TPlbBS+/MRw6w18BBhTFfD7qhue1aKnniEgS5o45n0jbr?=
 =?us-ascii?Q?PInAWtS9OJBGnFdLFqF6e820Y9xe/D7fPFEYaV8+r5CmHsz9KiLFCotF69+8?=
 =?us-ascii?Q?1efZnAA9aoyygdCr7W2zdZDzhv0CuHtQTQ9R8eOutgrJ5Jkf0n9ILrw4aBMq?=
 =?us-ascii?Q?rL7uUZLsi+4be/ns1FC8Ob8RaoPESbgeZbsbA+vaxZzxXLdrHGSDWfd2FZQf?=
 =?us-ascii?Q?izLZNcek3eZI6wz+tefbtVED0RbIPsQ0SoQFyr6vFVXSuzyzZKejpcn4qZng?=
 =?us-ascii?Q?uQAm6sLh3+9OzrPy+tyvSA676aR79dmjROl7fA+lbmqXLDY7OEyui2sjcCbI?=
 =?us-ascii?Q?f0afi2j/zxk5OEeR2rHfiYEahqzxjxoZurEhr9YQL02ESP0sMmGDuEsaWiAx?=
 =?us-ascii?Q?8hG/IUSzsnHbNlYMD2tuBWHX6gtg2ljaiJWtjp024NfnTjCNrWMPwfWt1Td4?=
 =?us-ascii?Q?I196+8ezCDl/cUNmMnqcpviv4Ix8ZzSWsnoarFMEgyihDNvcHmXDEv/5MOHK?=
 =?us-ascii?Q?dI0Zq3fAo7ul4RRdv/77C79IWUs9CekWv/QVqo3h2eeXGHKvPo78XT4SlNYU?=
 =?us-ascii?Q?mRXlfgsTm1tMe4+LEEUBRWjO5tPj7C6pY54aqXpvhqw9qkgh278rAtxp5yO1?=
 =?us-ascii?Q?fWwyFyu/5V/IfAr/ZF/X14G4qlFjkUxw01StIKwGqugvSOd/7yhCtageRIk+?=
 =?us-ascii?Q?lWYq/UO6wjpWfOj77g9bNp1mt69UEOcI4OAiZZTDJL80idrLOrEcpyXUDUub?=
 =?us-ascii?Q?Mcw07Jr7I2qx2H4vO05+oJ79fZdYoReCkciiw4gYbtAgVOe1WG8pAR0B7R9a?=
 =?us-ascii?Q?NP28KO6H0cSUt2T2ZM64GpiDD1q3CoJGCL0wRI1oWlIFiCwg5Mdydh6+n02I?=
 =?us-ascii?Q?nKvx8LM/VBhQMpCBnXiSwkz0w1RMdusk95tHJv87+qaKvUGqzrmEiNG3g5iU?=
 =?us-ascii?Q?JQ479IxR/ZXfo8qUiR+gl3oa/wiMJLNffCZb8MJ4k3gCUgX2//jTVOGxgA/k?=
 =?us-ascii?Q?C1bUPaY70SLN0deI9kXqZl84JuaVbIveExgbzHGf4OV7WZgQ21Fc8ptMAwwe?=
 =?us-ascii?Q?x5ux02/cEomtbyTcJ/5a4DknJHQGuRIuvi2TOspTpXxfRrS/oWR6DYWO1sJS?=
 =?us-ascii?Q?Fl8PskyLSKKssi9QSnP4x+gpww+AVu/L/V1LPMGY2Gz7WPp2WDLVcdh8rkB+?=
 =?us-ascii?Q?5VsYDLXGs5tDSobFHaCEe6UW9z9BtUwxS2FNn6ez5nIfLg2tiV12R5UZCthj?=
 =?us-ascii?Q?nqpRhzOPdW5G6cfyrtSBY0ZHmk1+HMHjr7q+f4H5TyxW1gszkgD2c4WriWQU?=
 =?us-ascii?Q?WqJ1kvivkscCEbqoOahyOf8n70k3SB7fTbE4gt2tyHlDdMxZE+XnAhl0B8c6?=
 =?us-ascii?Q?4SJHTus4mu4PJZIzToKJ9E0cSUzBzNQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810b5954-4a81-49e0-3d8e-08da193ad46b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 08:36:09.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8vfwicYDR+UtCDHaB/EASt2ijPJK6zG/pGGvW6TIxl2ziTARiM8xnj4dliXoX3GyK0YfE090yhHbyBN4IIZa0sePmgPMGnDvCPaMF3ZRb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5198
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=953 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: TP_TXimnwBRjT4_B5s1klutVqw59qNoq
X-Proofpoint-GUID: TP_TXimnwBRjT4_B5s1klutVqw59qNoq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 12:19:01AM -0700, Joe Perches wrote:
> On Fri, 2022-04-08 at 09:31 +0300, Dan Carpenter wrote:
> > On Thu, Apr 07, 2022 at 11:14:51PM -0700, Joe Perches wrote:
> > > On Fri, 2022-04-08 at 08:57 +0300, Dan Carpenter wrote:
> > > > On Fri, Apr 08, 2022 at 06:15:14AM +0200, Julia Lawall wrote:
> > > > > On Thu, 7 Apr 2022, Rebecca Mckeever wrote:
> > > > > 
> > > > > > Replace ternary statement with an if statement followed by an assignment
> > > > > > to increase readability and make error handling more obvious.
> > > > > > Found with minmax coccinelle script.
> > > []
> > > > > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> > > []
> > > > > > @@ -470,7 +470,9 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
> > > > > >  		return 0;
> > > > > >  	}
> > > > > >  	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
> > > > > > -	erq->length = (len >= 0 ? len : 0);
> > > > > > +	if (len < 0)
> > > > > > +		len = 0;
> > > > > > +	erq->length = len;
> > > > > 
> > > > > Maybe you could use max here?
> > > > 
> > > > Initially Rebecca did use max() but I NAKed it.  It's really not less
> > > > readable.  Better to handle the error explicitly.  Keep the error path
> > > > indented two tabs.  Separate from the success path.
> > > 
> > > A comment would be useful as it's not obvious it's an 'error' path.
> > > One has to read all 3 get_key functions to determine that.
> > > 
> > 
> > I'm so confused.  Negative error codes are the common case in the
> > kernel.  We don't need to comment it.
> 
> If it was an error, it would handle it as an error not set
> len to 0 and continue. That's why IMO a comment is useful.

Yeah.  You're probably right.  My understanding is that a zero length
key is a special case where it uses the default key?  Which I guess is
all zeroes here.

	if (len < 0) {
		/* No key data.  Use the default key. */
		len = 0;
	}
But when I look at this some more then there are three ->get_key()
callers in this file and only this one checks for -1 returns.  For the
one caller that does this:

	ext->key_len = crypt->ops->get_key(ext->key, SCM_KEY_LEN, NULL, crypt->priv);

then a negative return would result in a buffer overflow.

So another option would be to just return 0 instead of -1 from the
get_key() functions.

File | Pointer | Function | Static
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | (struct ieee80211_crypto_ops)->get_key | ieee80211_tkip_get_key | 1
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c | (struct ieee80211_crypto_ops)->get_key | prism2_wep_get_key | 1
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | (struct ieee80211_crypto_ops)->get_key | ieee80211_ccmp_get_key | 1

Changing it to return zero would leave ieee80211_wx_get_encode() behavior
as-is.  It would fix a buffer overflow in ieee80211_wx_get_encode_ext().
It is a behavior change in ieee80211_wx_set_encode() and I think that's
a bug fix as well.

regards,
dan carpenter

