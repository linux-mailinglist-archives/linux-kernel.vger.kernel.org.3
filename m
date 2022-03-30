Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2894EC807
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbiC3PTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbiC3PTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:19:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608A9154042;
        Wed, 30 Mar 2022 08:17:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UFBBHw030420;
        Wed, 30 Mar 2022 15:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NYyCP9hrMbIu0sT6ONJVcHCGMX7eveT4zAp0w286baw=;
 b=XC1vf9sz0xsD0/yYSmjoBk077G142Lsa+kC1oZdDuoW6gPz5ACIt+9xJ1bQltt7IIw6N
 uFc9fMYAU/gOW2nRFMF8vcOdR8ITz/kcDk5FTDQ5nLje6BMOEL53+mE2uuqccd0iTqG/
 tAJGAHDIpFhp7rRlZqEqN6C9CNtiGZowb4JTgKMsrHjOf091fhll9U6mzz/5lUuMgMC+
 HMaWqUhKXyq4gW3f0jkIBIthyMDiuB/lbYG2dVGBUpgeXc3r3fQg1lKal1Xk5gC7yFMx
 cZSsdQ9/FBRtOFbzxMUwe8RyE50HL5iRMidyyEC6F9HW1RsNbR8BMYQ4D57iI6z/x0GV 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0hu7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 15:17:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22UFAY8V023376;
        Wed, 30 Mar 2022 15:17:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s948wx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 15:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHNijRMeVt0bziBumIdn6UPr3ByxMjkZrTWeVU9OebDmlt6tqFICb+D2ruwG1JcLweb262o4qQW3nqfx1+pIoq3ZBz5NQ3UY8o9GA/6inmNSNNLs9LzUHWXTYZYt1TSr1I3/fskkWCxuHMT7abyfrdEZ3uvarZ/Pj1wd5IEU0y65qfG/sa/0Jub2kmdXu5E0f0dYdVgzAIRe/VAudP0xzIFVMQFWbRjM9dx5xFPjitI4TkF7DVGb14fSbQCP35UIqV0XrIl4vnTNFWrdZz5CH0GocMhLMuU+PvRMT+Fb2awnByI9Wg4rna1JKtfyYElJ2ma723FxLdGdhBXJKA7wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYyCP9hrMbIu0sT6ONJVcHCGMX7eveT4zAp0w286baw=;
 b=kc+V46RTWeuy5tbwMCbwP+a36dP0Z3ZC13U+JizYCLJ9tNG6sbQxPTGYdQhm0Qz/eoGKKPheimU/Hi2D+M4PxttTbC6luPxL79m5s1vAvhGiacu2kMFpVPwZqiqqbiZsP4gxjDf0899RP++Bn15pwrX1BG1x1g0PoRNxqupyRHeV077KFaDGuDXdbjh/BdplePxZuuyvkhYgk88vIhiFjB50E1El6n4H2TQMBwC4Hw5i7NHAUhDIHfKwJvt6eq7VUEwloX4GcWAWo1LSwzTWUIDgpyEjww/xh/xLXC4AnPQjUaGndFoSSzUr9S1o+r/e/Xj4R07gSoM5AvjKf1cDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYyCP9hrMbIu0sT6ONJVcHCGMX7eveT4zAp0w286baw=;
 b=ILMITcVVqVjgp1uhwr14Qh9eqN8j8BlRTA++CcSWr3vqRr8gyukNXKpxOe3R1skiq2IIpsi0lW2qby1riqXNLKEJYZNl8j8eImDCscYUc7dNs4FX7ynTlZivH2FwCoTpQWO+l4+0uSSozuG75cCX9yrOlSVt2UnNM0Z86vnhfsI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4929.namprd10.prod.outlook.com
 (2603:10b6:208:324::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Wed, 30 Mar
 2022 15:17:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 15:17:21 +0000
Date:   Wed, 30 Mar 2022 18:16:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
Message-ID: <20220330151658.GV12805@kadam>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-20-nicolas.dufresne@collabora.com>
 <20220329081321.GV3293@kadam>
 <f7e5b577bc48ba16befbed47ac96c363ce861f48.camel@collabora.com>
 <20220330051541.GE3293@kadam>
 <ed16a4dcfb0859a284675ddad46ab536008a15c5.camel@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed16a4dcfb0859a284675ddad46ab536008a15c5.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27cd11d1-cc21-4479-07b1-08da1260627e
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4929B88EBC7BE2E8F97FC5328E1F9@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUSCBVJaaghzFdK0hn5ngYurotyiSkPU7xc3CTBKMFerah+c/31VATjRblHY3aEEyuaxSmY8ed34+xZ5wO64+vMk84Xar2ACaIh6+9frGMA1cln1eXkDAlHC7BnjsBWKdWxmVUqxHyLtcODwXKkaZVi6X+bR5CMSbMjOEchby8dR897dWe0GAV5vFNInXZ4SkwY7y3CKQ3y3SfoU2sC9YegYCmdi69jXbXebqBDtp2q/57xOSx+DkJQx3aTiHNvu2s3BsPiWYotLJIMXjlPI0lv2Sh9gBaD4N3Zh/vOmJuyUjBpps/8j9M8W8nH3keyw63Hw/qQQ6Zwkr1kld/Ba6m2S87KJKb580dbGh/5xhmxkJg/MtvS81RZZ8IVK6bHJU3LqTipot+GSKiJJa0xXFlDbhnxEF7uHzHLZ5uKI9bi+wtO1ub8w5LplO8QA2qWvJC4/P3gtBwvG2F9nOGAP4kqYbB8nwk96xtOWTmmSIVrRCKPWUIB7K8M867H92wHeiLGHTOr6Y0uyaY45658UypzrGaAaEkXdfOfa4ei8H8s100tBP9pWKxyYF/hacXjlhuoohrWA7S9dszHFscFV4VRlYxcFWJHVCOZ/AS7M7ZhYbXMP7e5It7AnIakFkNTg8uqBdDpxkhTWV9mW7NuHh61OKlntX8jjT8Fgm79cFNTShNs9t3kPWuyS2Mrr7UQlqhl+u5+maM1+RBs0hEcKig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(83380400001)(52116002)(6666004)(86362001)(9686003)(66476007)(4326008)(8676002)(6916009)(6512007)(66946007)(33656002)(6486002)(6506007)(316002)(2906002)(66556008)(508600001)(38350700002)(33716001)(8936002)(26005)(38100700002)(186003)(1076003)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EyE8DHhamLULGLJ3AIYeByHgUbqBqdU3cBhA5C/2Bb0KTgnYALUus9jTT0Ev?=
 =?us-ascii?Q?jk8nXGbBjnI85z8rLEZq9j3CRSfVJvVQY6uAYhZBxYIXS6v6nl2CXzYWsflC?=
 =?us-ascii?Q?pI9c3pkwBpMmtqYY3TCNGGjTmY7eaz4Mt2zsmce+FglsSwVnW1x/gvP4eCrk?=
 =?us-ascii?Q?iKsUv/uph+GGfwRDczddu0EVFCE+pqrJBRLis4ExYRfY2A9mRfwolIENByoy?=
 =?us-ascii?Q?zCcNRnzG54SuH9lqWU/peo2dgchNh6LtLP2UGruRNgkepUxUqGr4zBW1taKX?=
 =?us-ascii?Q?ogDolOGS35PKFNnVwwb722IPJFibwgE8GWtqFJa9fY4yodk9WvqE7kK6ZW1c?=
 =?us-ascii?Q?GVWN33KSf7rY0fck39Mh7HaGKsUHLU90TLvC1kXm5kxUFaCqMQNnPhDiyqwX?=
 =?us-ascii?Q?LEBcZ8LC0nFv8N0OIPkbCS5EOB4xq9tnAuUs0SGiLpGtdP88Fl1lgXJJPMxE?=
 =?us-ascii?Q?4GswgAk/8rBVR2VDsGQ2LrtuGb89dDroyfQ/GAaB8EAaTjo16fmS+ajPCGKW?=
 =?us-ascii?Q?UcrIszR+7RP/YBgQ8XvLTZFF93XAzXfVVHAurfAKZgZrfrOKuqGVK26IkG4O?=
 =?us-ascii?Q?kofzPjhjvyCTrP7G4OipF7TTv/sSrVisiRLRJ+VbCK2jyAkvZhi5ApZlNk/V?=
 =?us-ascii?Q?WUEaVvpTBt5bDOGhzN6QdzS49+uqM5BLdDWVghtHiFp6pzDdzb4CsS/O4E1K?=
 =?us-ascii?Q?ddCJOMWvFzTRJoItv9IiGmkKAxKTATqPA0iB4JqJY7PWjRecmhjtiBHQGYul?=
 =?us-ascii?Q?BWNJqp4rNDgmnIZvLs5fuQyivHZsH4YDB/YuUYi9W3F6ea6c0idduL3xJw0J?=
 =?us-ascii?Q?e8Xv2qpGh4RnpTVGQXoz5vXR1Darwblh84t8+2PV2QNm6TJKMC2YT7TdHhE/?=
 =?us-ascii?Q?crCzyvinHz1bhoJykwIA/vTpUXCGuLZtNqdFiw8JW3lZ1jawJnajf3X/QQi5?=
 =?us-ascii?Q?fgRfNrWM9YywZ/GU2CcLxJiDSqyxZKDjJ8/g49OJn/gez7Pirx2BKT2E0U52?=
 =?us-ascii?Q?U+rWPmiFa5drvrdPEK4cSxxGRljiT4SLp+Mb43RRJUjds873N0JoD54uRCjf?=
 =?us-ascii?Q?jd66HcAuPAyCSKNVH6VKk18piBK9hTaA5XmrwbrcM4d9r2NUHcfVqDP9zcXi?=
 =?us-ascii?Q?SkNSbCz9IgjecYsUjdCCZB1UD6QjpXA0P9KP/289dWTnrAqjOh4Ogw6nscxt?=
 =?us-ascii?Q?jzXRBS+n6m7r0FSD//p0tUJcL2oOYkg3WGJNNQpNmsqfRXJD+GnqqdikV/GC?=
 =?us-ascii?Q?8sgxCIS4K+O4VWnbUdoWBSFeMFttSxTzBFUp5Rv8OokqzOdlPb/1tEBn6qtu?=
 =?us-ascii?Q?viiThXnsMugWt5LVDuv/t2xy7bQl7N9y4NJvprHn2TCQvHzIHH345ZQ1EC8l?=
 =?us-ascii?Q?fbtsi2V5o3kaPY81HVHaCe1up4IEsYa1oYY76sPHY7evKT1jr94Cr5ZFLBkL?=
 =?us-ascii?Q?fjIy5kqMMV58LhDEYkYMmmrzQlT5mLWGoIbIhpiMRBuNrgVPDBMUM8gdl876?=
 =?us-ascii?Q?F10OAXCsJlo8d7SPSc0HU+RjEs0/HvIN1KYVQzgv/JAQUe/MHKnDqRwJYHnB?=
 =?us-ascii?Q?C0e3BCYmct0rNa/rZuVfy8IQlnoTD1cx8+WjufDbOhxog/OwTOKWD2+LsQki?=
 =?us-ascii?Q?HlB/TB98Wc+WoafrDKXoMa0PxOwFhY6Q5YYUoOaA7BjXl2VBqZjSOotwRVso?=
 =?us-ascii?Q?SgjHA9qNwpeUZJK9eNmgdMVhN7CSHxYdUUWNWMPCUNehMN2JgmgdQU3Kh4Zg?=
 =?us-ascii?Q?iNZyDzTyOMNzOXxH84URWYdqnKSi+hc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cd11d1-cc21-4479-07b1-08da1260627e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 15:17:20.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFqzBsx4qC0pBzKB/nKG8wsc4kDt7e38k/DcLwPO6X3rcncXHjLMxKtg6ReHX1M6vaCFqZDEn3rDsx7BqjiSXJSBEVX0ODEWTd8uTrvk/sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-30_04:2022-03-29,2022-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300074
X-Proofpoint-ORIG-GUID: hYXx7mVGYadNCypMiSheSf7aBFutJapN
X-Proofpoint-GUID: hYXx7mVGYadNCypMiSheSf7aBFutJapN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah.  I'm aboslutely fine with whatever you do.  Some of the questions
you're asking occurred to me too but I don't have the answers.

> > > > > +		for (i = 0; i < builder->num_valid; i++) {
> > > > > +			struct v4l2_h264_reference *ref;
> > > > > +			u8 dpb_valid;
> > > > > +			u8 bottom;
> > > > 
> > > > These would be better as type bool.
> > > 
> > > I never used a bool for bit operations before, but I guess that can work, thanks
> > > for the suggestion. As this deviates from the original code, I suppose I should
> > > make this a separate patch ?
> > 
> > I just saw the name and wondered why it was a u8.  bool does make more
> > sense and works fine for the bitwise stuff.  But I don't really care at
> > all.
> 
> I'll do that in v2, in same patch, looks minor enough. I think if using bool
> could guaranty that only 1 or 0 is  possible, it would be even better, but don't
> think C works like this.

I'm not sure I understand.  If you assign "bool x = <any non-zero>;"
then x is set to true.  Do you want a static checker warning for if
<any non-zero> can be something other than one or zero?  The problem is
that people sometimes deliberately do stuff like "bool x = var & 0xf0;".
Smatch will complain if you assign a negative value to x.

test.c:8 test() warn: assigning (-3) to unsigned variable 'x'

It's supposed to print a warning if you used it to save error codes like:

	x = some_kernel_function();

But it does not.  :/  Something to investigate.

regards,
dan carpenter

