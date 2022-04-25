Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B30450E8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbiDYSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiDYSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:51:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B589306
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:48:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PGaZPb013187;
        Mon, 25 Apr 2022 18:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wvWfc69D4m+sR+JnEhy+2pbQvbuSalzFXI7+abYft64=;
 b=ZB3tiw9ayEMXfIiM7mMn0OYrMJQ8vMWEEGO3bEFs+jt+K4ga2M7I2ORkKKulsYO+GKwu
 8rF1NGhE4UFbAuKA7FXPDR61NFv8UPPDS+Yubu0A9/xqEPeabBBrsXAaVTx9MNi3kTYM
 y6bQhrHdWN6GBaNA2Uxo+ZN5oLKTUJv7Woo0s50X/UpPoZcG53K2ZMZVwPuIQc4N18AL
 R0gbstycaOpHBrzeKIP8aav8Pf7Da9AxjyVSU1q+W5tcH+sHy1liLnJsjWOuMTy5fztH
 z5rT6FMPY78diKzm63cONVIfpMVCNpjN6MHJFc1a5m0upvhmy3e7LA0wPLEU8YVIoqgH 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9am35e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 18:48:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PIU5Uf017205;
        Mon, 25 Apr 2022 18:48:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2vuyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 18:48:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCNXSTxENdhmkB1ulA25LM9A8Kzs2lDntAHaM4+TzLIV5VsmIW98SlvtvCohoa9T8k2RbcgHIek6att8uxyV+bqWrzvzRv4cGAeaheMh2t+cQt204fW3i7M+qW2w0oP074gj2ARbyuYV+HQZMYVEuW2Odw6DkzWqpHlJSillKOG3LYK6zttC8JtObtagBHnuWHhyGiywpKKCFoOyscbknKSMVLyO5KFCwF3TwqcprIHAw1WA977CcnZVh2KazIlgu5lJ52l0++Y/k2rF/K/g4KUozY7T3qLNKzXDg1TgrIitOaxnCA3UNgkZ2NH8IqLs8ueDVx/kjuLwWzdLKjuAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvWfc69D4m+sR+JnEhy+2pbQvbuSalzFXI7+abYft64=;
 b=f72NO6Ddej/J7+TsdwaGca5T7TkUucJtx7OOltREgtX2fumbKyYGQsIV0yxRAW7iPgYMLwhiQLcMoXjqpP/ZkGKhXoaHFeKlsup8TmNvwnVBuC50H9ZCG2L3PQ/3H+Tnu/iudfU/JUzfVZiaHkq7C6XE/Rp8yzZAM/tWcfAHWmvLPdVbfoRXtDrwLp0881DMnXhMwa0++NQ39pRHWC7CZ8ERAEbpdYb9uSWxrN7G1kDcACG65GS0sbLYRX+OvoscZfSNC36z+jsFS4RN5czseBr5DthPh21hcDMoUb7Ilf7f9b/rzSk9S4FoJM7dk9D2NBp4ggOl4swzz3VdELEjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvWfc69D4m+sR+JnEhy+2pbQvbuSalzFXI7+abYft64=;
 b=DAtGgwZ58uYDUJrQy31Kyfftz7XNZv586f2QvYDTCZbLC/psWnEOP0yaGtLXXP33OelNU545eChI4udf8/+gkwXY6cYiKcSd6S4aX8XpPtSd4eOEzQYV2foZRc9tRZRn7svC3mlC+uTv13Odk1gJSQ36fMXmWXs/smTImOZXAXU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4929.namprd10.prod.outlook.com
 (2603:10b6:208:324::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 18:48:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 18:48:34 +0000
Date:   Mon, 25 Apr 2022 21:48:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: fix null check in
 _rtw_free_mlme_priv
Message-ID: <20220425184822.GR2462@kadam>
References: <20220424163132.37007-1-makvihas@gmail.com>
 <20220424163132.37007-4-makvihas@gmail.com>
 <2e4fa41d-cd06-75e4-17ac-120127fe9b2a@gmail.com>
 <CAH1kMwTT7kEB5O6ZvCWEJk3RGzkRek_fzaNPUnUpFFKq_fhGvQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwTT7kEB5O6ZvCWEJk3RGzkRek_fzaNPUnUpFFKq_fhGvQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0022.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aadd0a9-8b00-41d7-84a8-08da26ec3331
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB49296A904D8A7BC942CC0CCB8EF89@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAZpn2Y8stzBnYKOOp/bWsDgtgI/WHDLGYr0OZnB3Yl0LX5GZXp+qMl2EdY+zccSd8kMGqRhXKaWXNjJFPlXns9vCrmXkEA/pWQ2AAyC01F3hWfWEipmyezm+ZgeDVJpker1b4mxeCCBe0PdqxrDeaJHNN/MdJdrJozeghxuMSAObc7B4ahcLDjDMSYyITjhoMJVnYt4ZYobX8RCG+0b16nADkUh7io8EDHYflJG32LgsCZin4AoOor994LkW6yyHBTyVbzSqmR4mQ4gaDKTWtBUqbuDqMlqnFq9VbVmo7vpIWhE9rO8LuDOp/g3nT4ftxfNKd7aHMkvbKM9gd2WzBu3POnEWvntUIgRDc6ROSpfx9j+L94a407L5ffB5Ir/27+8ycz/lvA+JNG7PbgMqzd1NAhEhq3e3Qa9308rOw9I/iYUdyq8Riy9tQ6AjI4XS/+kMlC9P+ohEngp2b/dnjUDtN5gt8gz6WVsTtXMf/KHoYzzJwOAuN4E4z1y/5OIOZM7b1zlZwh7j6nIcftkP8bqUXAi67eQTbjW/GePMIwoxPHl0ZYk1nJQSfsqrhJ6FReBsQim7xUxqfIj4eaZvxmM96VTYKDOV3UdjYdrmI2v3SUJEUufSXVhGpQJGwYyV0XCYI5DQhAMYZ2m2V1YdJqnLaqluFKVHpW85Ec899vczq3KSvkoeACgtW9KSW9bjg1NFhlkG1hPJPoHdcNfsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(316002)(26005)(9686003)(6512007)(2906002)(8936002)(86362001)(53546011)(52116002)(6666004)(1076003)(44832011)(5660300002)(33656002)(38100700002)(38350700002)(66556008)(66476007)(4326008)(8676002)(66946007)(33716001)(186003)(508600001)(54906003)(6916009)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZsRE5mVD3fKuwegVyU0nKE8phrcgqihv1xs6Yf+rLwdk3VQG11+Kuja3nhf?=
 =?us-ascii?Q?f50WupQpgMPHmSYcXeSofMgw+J1gpunMec8svIEe+geczcx3CAHcWe+3ln7g?=
 =?us-ascii?Q?Ky9VHXEgWvKGeBZyY/4k+Dq8VLxkSdo0S27+DISu7ZH0iW5EsMxoY5PXrSjr?=
 =?us-ascii?Q?fuxeYL+za+5msA0xJh0WYssqOOdV7UAaDYBoqtBJ5znD5BGEDqq5xgllwSJw?=
 =?us-ascii?Q?9ZqpmwHBfE0EcsVoWr+vGhdyWqvMQJ0qA4O/1WboJziAEM/L7WeBNj4HLSMq?=
 =?us-ascii?Q?kAVGr7D7duKU78EkugPk9hx7dneXgNmW6umt3ysYDF+46uggxA6W/vEnrIGa?=
 =?us-ascii?Q?K/QRQfJV00ZGepkmSN3Em5yLXbW/NKdZ6B/DcuQePKew2f6VxXN15QewQ9d5?=
 =?us-ascii?Q?qEGZFryFd0LxXllbbnXHm96TvQBgkSBSJwzOeM8N/BiWwBgcY7ELmIcsakeZ?=
 =?us-ascii?Q?1tHMwoXuMFOAM7inbc3qdG3as2UBYxaSnA1aS4D7HxqH0fe4hTnOVSt9S+5h?=
 =?us-ascii?Q?tWnS+2+fCGXGJYExL24OdTaMq+9OTbtOV0dKx8q9Rlt8gF/dXKM0dBS/nevx?=
 =?us-ascii?Q?hWqvq6hveOorsY/QZ+nGLLgHoO/Pu0qJkwJ8cqbSs4rIUPcXwonaaNMP2WyM?=
 =?us-ascii?Q?4TEJS5fDBpkqXOhNg3UhQFtw9NCcSYxAnWXKgFJWhWj2GYE0GphD9zMRQEjy?=
 =?us-ascii?Q?p2BanIYxJBPYT8dMaoxZHFJdt+fqzfinS27xejtxpgz0jY5z5MKqO5FBGLUi?=
 =?us-ascii?Q?6Z3TUdXWs3iok2eO2vfgwe5s/mMlhVdVE2ceGSfOKdTRGYIeYdKbr1hwBGC1?=
 =?us-ascii?Q?c6ziQySVnh4SesqHm+HwXULDmj0dMul8vomfmXdrRmTmNQbwjWiFZ4ATGUAc?=
 =?us-ascii?Q?AMnMFygqRURWF/nAPJzCAAO1gwCY6K9HaHwry+r7C1slcqZAWNpitl+z8/sy?=
 =?us-ascii?Q?zrCEhz0UNufxbyhLXjN0u0yz8xl7lTBdVKiRWHNosSZXpMWWVpfAQrCflYMg?=
 =?us-ascii?Q?qK5XzuQK6a3QUg8pBwRNB85uJbqC+67YDVgijvWe1f/KmERfhT3Rn7jcJ9AD?=
 =?us-ascii?Q?TyF5usEpdbKhlcz8ThszXehNIKrdFQDOCEcMnZ6/xus/kUx8Xl27s1Um/ERh?=
 =?us-ascii?Q?bSBT+DCzfS6BsoEk+6HwAlMtdyvnHccUFyMS/9pI1IZgu38dxYR6ZyKWMXwA?=
 =?us-ascii?Q?KHRsLV//76VhrXqrhIjJgAqurZBZpq9U0pM0IHidKpDilqym78m+xfa8JZwV?=
 =?us-ascii?Q?IgRKPMxh9LC/uNmKOfYMaHRi8nEVagghPaGujHrx6zDl6GbSsCCimqMTX6Jr?=
 =?us-ascii?Q?6+tkqov7z7HIFUvpERyWAfjOaHm+sdO8o3bKRcEixbl2qoMH5xMzq6ivFGUh?=
 =?us-ascii?Q?SlieFbOIPGaqv/qtU9/z1OulYH6jAEhRYn6inUroTmRhwvuU0TOlRxaV4H0W?=
 =?us-ascii?Q?q/ojLa6sMpDdfOioU2IG0CmtDWRyFbrWyjZH/2CnUohEz7vhAP50zJHAu3sV?=
 =?us-ascii?Q?9qW9KP0+86al9p8nq1M3ZVPFUK0AQ+e676okRLLvGMDh5GUMdDiSsguKvhCQ?=
 =?us-ascii?Q?UDQYiJ9QBnfmBy+Jz1NU6AEhs/UHQV2+wVDkB6UvSIdfNcOUWtLf9Dhh8p3M?=
 =?us-ascii?Q?6AWcmd1XnF2gUAVgfDUXLZWxrx0CftA6pAkpMTWiuuwFMXlIZw3UNtq0KKJR?=
 =?us-ascii?Q?BqXOyXEQ5sDmJx18+dw31as+4X0RxvvYYQ6sQVDauMYIVL1pkTAh70/+W/9T?=
 =?us-ascii?Q?4TJI7zQi6ZMzsBAK8KCF7ll4rpbVnsY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aadd0a9-8b00-41d7-84a8-08da26ec3331
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 18:48:34.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We5eMMh5KfgdoyLH1sWPlgS/szVtZdmfooWPJrwDv9qATaSRHi2R6ZWWbPAz1MvmqadOX77IUyIFRiL3D9FpFA6gm2aqlp7bacr9pwtQO3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=881
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250083
X-Proofpoint-ORIG-GUID: XCpykQU_pOeDiTqtbnJVun2tLnQVnexM
X-Proofpoint-GUID: XCpykQU_pOeDiTqtbnJVun2tLnQVnexM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:25:32PM +0530, Vihas Makwana wrote:
> On Mon, Apr 25, 2022 at 12:30 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> >
> > Hi Vihas,
> >
> > On 4/24/22 19:31, Vihas Makwana wrote:
> > > There's a NULL check on pmlmepriv in rtw_mlme.c:112 which makes no sense
> > > as rtw_free_mlme_priv_ie_data() dereferences it unconditionally and it
> > > would have already crashed at this point.
> > > Fix this by moving rtw_free_mlme_priv_ie_data() inside the check.
> > >
> > > Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> >
> > That's good catch, but looks like the check is just redundant
> >
> > This function is called only from it's wrapper called
> > rtw_free_mlme_priv() and rtw_free_mlme_priv() is called from 2 places:
> >
> > 4 drivers/staging/r8188eu/os_dep/os_intfs.c|531 col 2|
> > rtw_free_mlme_priv(&padapter->mlmepriv);
> > 5 drivers/staging/r8188eu/os_dep/os_intfs.c|579 col 2|
> > rtw_free_mlme_priv(&padapter->mlmepriv);
> >
> > _Very_ unlikely that `&padapter->mlmepriv` expression will become NULL.
> >
> So I guess either we should remove the check or mark it with the
> `unlikely()` macro.

The likely/unlikely() macros are only for when you can prove it makes a
difference to benchmark.  They hurt readability, but they're important
for optimizing the fast path.

Just remove the check.

regards,
dan carpenter

