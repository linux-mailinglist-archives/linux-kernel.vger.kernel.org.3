Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFD559240
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiFXFVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:21:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6A68009
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:21:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O4TmML012429;
        Fri, 24 Jun 2022 05:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8XQbKOyOyQ1us+BdT3t/Vob5HHoZ4nkpIGvPjW/6OyA=;
 b=dSTaA3hTvRamOba2X1G7XkYkBfsO+lwO5bv4Ob8F8C4g4WkQXOgAXabDW66vecv82oMm
 OrkRv3xFo8vLqJ1mSVbkcDWvSe+Lm1wlL1DVjhibpXbWin29GH6ocr+jwJRGWm8JTGfd
 MKLfapxvEOao3twPDW52tu2l3HpHN0QVmInRw8gLhGjeYs8aeajifHHIpJ/z6mMJ8n62
 M9DDcf9aOmZQ1C1aVFP/pei4IjP1Akr7uVWk/oth4jT/vxUiOG4449lEI5SLmosHfIzF
 ZzKuys85z53HLHFwnQrJ23yJ5L7bQpaQEjcukOaJsBqp06ZbMyz1I/XhLD8IQdrhtvWF Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g24yeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 05:21:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25O5Af0u012203;
        Fri, 24 Jun 2022 05:21:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9wwxnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 05:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvX+C+w+EdpmE7l5xAUlNtkx5gQ77RRezpurke5RE3IdwTeOGCcPykswQSBGR3E3heAheJSUcY++k7NeJrF0l7JdE1gtwIFGOTTgDkYRdG/vj6MGQ76FrGDFYJ5cinMUffu7UUzpxEsislmfWTcPZdZxasMAfCiW4mWT97C+JctylkRdcf4xJcGqU8EgR8/z/pwtA5SaMPM5682CUIqzabNU+Z/7mILIpI8BWO9QWhOvQoCksK/H9sUhcwQaOscGSgIYZwEbYQteDAdj52U6yqRwhZQTJ2h3O77XNhL4ahWB6W54QEFgO4kJN8H0myppURw3Gju4A2gI6GVz82x1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XQbKOyOyQ1us+BdT3t/Vob5HHoZ4nkpIGvPjW/6OyA=;
 b=Tx5IBD9+pxHUk1zx1qWLafQTKHBHBhIaHBZEjbLHSoCVSE86d0gOglgnclcT0yfpEY/SkpQGzkuDcV56Kkb02+5TxxzYIsSSPNrq88bqxmWOtXlaBZZWAmeFVDeXJ7fUX5x7nZmltyDtUfgUCKky7FnhPr+/k3HvaPl7DzGq4GJTEpOO32JkV7P0lUwnf5K0icY8k99yVGPUuuip5+m0amOrkXyh3RAS0q4+5zZT7LWMgFUI5XqrZm6my1MFdT3nSCB8v883dEVZ/5r7+5XAOVaWEe2enpBkhR61DEN/KDqCGxpKZItGP1ddhS47I4Zs7xOofdT/7gRejpY+C0AELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XQbKOyOyQ1us+BdT3t/Vob5HHoZ4nkpIGvPjW/6OyA=;
 b=FeXHRy+4K5KjODXI5UGxUGKWnQDRuDQYSQgUawx2NlDbTc/0Lmy42BfpkMYxuMoTXowExJxpqIv5a8pRFSVjbGzB1heM5JdxWYdhYyOK9WyUGooBqy9E28CIR2FjeJi1icXvo+Wlkr2EUuBWN4cCwpy6K3RAR4wgo2N+p3m3A30=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2610.namprd10.prod.outlook.com
 (2603:10b6:406:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 24 Jun
 2022 05:21:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Fri, 24 Jun 2022
 05:21:36 +0000
Date:   Fri, 24 Jun 2022 08:21:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Felix Schlepper <f3sch.git@outlook.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
Message-ID: <20220624052118.GT16517@kadam>
References: <cover.1655975970.git.f3sch.git@outlook.com>
 <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
 <CAHp75VcQcKaYUP_JsmTFOY-pbOR39+TMw=5ADbb2BRGoMijCMw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcQcKaYUP_JsmTFOY-pbOR39+TMw=5ADbb2BRGoMijCMw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7d945c-de0f-4882-18ec-08da55a16884
X-MS-TrafficTypeDiagnostic: BN7PR10MB2610:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3EZsMNJ6GOVznK8yYsO8dWjCKrM0zwLknRB0c3z5gtbNlpQYwhmcsBtShV866MAgzaBY07YaxyR8nCoqd2csfxztHlsGX5JEBjC0Rt/wougnlAE0NXPXNeUscMqUmV635TSDSUbMszPaDJvstCjZKFU3ewubAkVa7SncVWi6cU5epbHDPtVNc4gH1XELuF1GocBhEWQpu4udm1qhC+g0oYGSIj5gcNKAtheGnEvEfkOqlqq5QwEFgnjnGsX6sapLUOf6ukzeRin5F9yDy4NNdc1NMjSpPd+usAQM4bI2l+lFVCGDU9nZVPLHeQSmGmJnOglsdm1CJXkE750KnHQMXFSBetsOZsA18n9DFT2T9Y+4586/QH+luk1MqCNoahLlIkt/0UdvhOavgF5MNwFUrj0bKTAs5iyxVmJV9Hz5p62/GpD9uJKTOXfGmY7k37bMa0YzQoujqmTC3E4ZlfzeJHk46Rc6pIqKRALoiKFXvsgTizgBzrgaCBmSnYxdKvrILlyktQZA4HVk2erqPGGtkDV+WbZTdoz3dVIYIY4rmkhD/UeQYpdYOnjIdYRx1pi5TpTCbh8Z6XizkMTu4JdqHMRptO84fk6/c7Y5pEd1rHMXSpXT7vWq+/d9wFwqsceRhjfV+f0iEV2zWN0elVxuxmayI4T0UT1Zu3+QFHPAZJOezCphTN5SlQRfSBAAmjlF08oIKIUTg80S7lHbdg85XsJboTeWgBEAm/wbZWz1RoKg1OG3pzdbCenLNzK8lCUPHzssgvqIizI/AbLt0zj9cwQU2+qEhiiPLoOQkFg/bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(376002)(39860400002)(366004)(66476007)(9686003)(6512007)(8676002)(66556008)(4744005)(478600001)(52116002)(4326008)(8936002)(66946007)(26005)(45080400002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(33656002)(41300700001)(54906003)(6916009)(33716001)(186003)(38350700002)(38100700002)(1076003)(6666004)(83380400001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQ6brmtgva0SNhkDIL8kunywtfPIDQvBCtYpPywqBu9a6H8htjA7FIXpuwCD?=
 =?us-ascii?Q?bAlUvgrOeRQRW4eF44xxFFucnrRLAMWWl1CprSFqtRnaTv66gmR4sEd380Mn?=
 =?us-ascii?Q?7BH3hbf3B6TQ2hOy9TkPsGR9i7zKUdO158FSPgt39FKaJEo0STSaqI5x3NOg?=
 =?us-ascii?Q?SvToLRfsLjKiXBSN04a2r/Ta9UyERFSDR5ssTD0SzOllNZpPoCvf0i2GMT8S?=
 =?us-ascii?Q?KLQcplw6DaJAX/L5ZFu6ycOH77oyNq2LYi9o4+p//YWuK1yhzvAcxEnQpOtj?=
 =?us-ascii?Q?YQPNrQcZflKYEJvJEGHjRQp+QQ4spD2UO46FBc+Rfq9ltBIulFUOakGoN6+O?=
 =?us-ascii?Q?FHTmOHPtW4er26+vLBgnDTzmEWrJGVoQpmbxDdb4W0vRzw2GsaZVifsS/YC5?=
 =?us-ascii?Q?tLjCBUyIh8k519wvlwLZPTycgkFIAXtHl0DUac7WwKGugMB80aLJsCHO0dcU?=
 =?us-ascii?Q?4q6kuTNalgkoBu4Xj/TapGOnavGVPLMiWWI/u3DRdpC0nZq8hxjz2JVe5KyF?=
 =?us-ascii?Q?SqhI9T0Q6p9GNltQB48FQsLVPeonHRN1XaAV8J6fY58b6TyAp5QmrOUaUvCt?=
 =?us-ascii?Q?/4+7kRtSCWojYXRmrg1L+WLiFBw0h1Ae4VBofITEf6WSVwjCJWQmoUkzZoPG?=
 =?us-ascii?Q?KoHcHcgYJSXEeoZsiHBI2/+nxX1DHFo1F8+Hq4VK7IjPI7VtN6c5osrGTtYO?=
 =?us-ascii?Q?yAj7GmqlxqRA1KM+iKA7RLBeW9fHxL+DyE3wLhWd1u0RtiI4Ls5eiCFy9RJS?=
 =?us-ascii?Q?+HUrKmlhN9lp7oKIic5Abx0zemAQaWopj6QTpemUpZ3nK6Sob6okTBxrk5hh?=
 =?us-ascii?Q?HIom4EsyIh1T1hIv+52RuOIUpbTLz1Z3HGHBSfkYtNdLzu69OA/c4GuS142k?=
 =?us-ascii?Q?ByF8ha0R2TrQtukMmek2mtnYOnt4GURJdLJ45Ku22vbxzNtudxD2zo+E6iXH?=
 =?us-ascii?Q?I2mbcld5Q+YZ10iqtgqUFVW6XOltr0JxZMl8lGrUc3WUyz7y31XFTkWOveXS?=
 =?us-ascii?Q?jQEqXoYB9+V+YGN6iMpSGA+oFmaLoBl/kc3S936pRncINBQ5/+j4ut1CIDTo?=
 =?us-ascii?Q?rXmUSjN8Z+aY2PiQbVrV8goWYUTp43eNlxb9tq+O9PQdujVZYjHc+GAU+T5o?=
 =?us-ascii?Q?3jI3vEsARAKHH3b3HMAWkHyvua8VFxvPMmUmSklcIpq6hLzLW5RDWH6L8+ki?=
 =?us-ascii?Q?dxCwTmRuYxAhIS4zRe2fWag64Y8VXoKKZycofZDsvmfoTjYEF2C/iTu5v171?=
 =?us-ascii?Q?PMIZr1hyQHeZJ9v/M8CoJOFtvt3ISzEtDPUb2w/H18r3tsXDToxPUdOc9lRC?=
 =?us-ascii?Q?bMQinA4aVpqG/p4TrQWZZm+TWb7/nHdbBAT4l9Q89WapN2Mc5zGa27KKBwXY?=
 =?us-ascii?Q?F/tUXkS7Rgl9tncwdd3PhryI1BYlNgaX4ZtABm1g915uu5FN42cWrcVIRQgS?=
 =?us-ascii?Q?z/fqEkEtWzZxY5UH2bNKNOw9EdSPbDFVsLNiyAc4MS5a8cOzkEEwpeXnAek+?=
 =?us-ascii?Q?IS5BlT8VEVLwHdTDbc4yWHI3YUXhtOL9tMHWg27BezLnpYy7cSP3brg85neO?=
 =?us-ascii?Q?W8TIPiK2stJWp6+cSoEIKeVuxwqcPseWPZY2XamsEzuwA+l25Xmd67dPWCvt?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7d945c-de0f-4882-18ec-08da55a16884
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 05:21:36.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvGTik4KwyateqJbXlUxcMp1S69Hne9p4xaRG9on91YpGHATZf8DA957uvTHJw7ILEo/ztp9ZCR33cRdxb+/Zsm+vgazkiVKXWheBKyCywQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2610
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_03:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=953 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240019
X-Proofpoint-GUID: lQqWREJET9mKm0r4Z0fSxLrPdcUJEOvg
X-Proofpoint-ORIG-GUID: lQqWREJET9mKm0r4Z0fSxLrPdcUJEOvg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:20:49PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 10:44 PM Felix Schlepper <f3sch.git@outlook.com> wrote:
> >
> > Moved error handling to one common block.
> > This removes double checking if all txb->fragments[]
> > were initialized.
> > The original code worked fine, but this is cleaner.
> 
> ...
> 
> > +err_free:
> > +       while (--i >= 0)
> 
>   while (i--)
> 
> will suffice.
> 

Either one is fine.  You prefer this format.  I prefer that other
format.  I told Felix he could use either format without expressing any
bias and he chose my format.  That means he loves me more.

regards,
dan carpenter
