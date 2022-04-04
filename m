Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE454F127A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355515AbiDDKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiDDKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:02:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB73B57B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:00:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2349wb4g025977;
        Mon, 4 Apr 2022 10:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3l67xC8O7359cezHMfWEz+PIOYK2CRL19KB0zwMx0yA=;
 b=0k3Yn/QJaRWj+2AdGb77T7DO5dDG/EPw2tSJ3dWpkGrmUuhqblW8zT2lA6KphCb3hu+e
 woz1tbBzETklry0vqI31yOl18AHD/DT6L7FKfLYin6rXZF9sHSodX/tA7IvAtj5UK2C9
 WD7zzrr3sUizP2KUGddev8uBOEoV561XrjtpcZmTRYZ1QTrgtfKWLDLO2TiZ6jTFMTi5
 kLh9sX1TvCJfQ9npBfktH1WCdgdVW8bctMEPbWrQCmB0SvBqXBqgIzpYEpsXAhRi1vON
 7em8POCX5HBOwzXW6cQTfeRK5GEw46wdsmRg0yp5zmtCNePIHRY/zk52xRx/f8+a1ErJ qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcapmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 10:00:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2349qIEj026778;
        Mon, 4 Apr 2022 10:00:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx22hsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 10:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHi1MTi/k5bPBXU5LlnsB/k9pWi8Bs3m+VejRc3LXee0Vslse73FgJROIK28hWqAAeU2EqSKLYXzjxCjkIWwyF+m/XUJoWLL0DM8JKuDk3DT/hhqWxNp/tafGuFagJcFPLUrwqhwm39SFR8yCRkmF61uLuM6Z8RouHH1B2kWB8ft+so8REoydIouRNWURzdFiAKrNg3vsVG1AerXKeEgDIfpsXO2ZTk52JQsCdjzimkdxbDebw5rLdJ902GXWQLexyMjX6i2z0n1TwRsj7gQtrKtPvhHwnt3zuyBom1imICAFUChI8OR9lMERDu8rdmujmDWhkJYUhbYSissCpCgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l67xC8O7359cezHMfWEz+PIOYK2CRL19KB0zwMx0yA=;
 b=iKqFZ4lKPbV0eZydOdi0U1ACGYOjU6auijoFCnOwnSzxOHUUgduEvk4FhzdpaVoGBe3VGYLTa/Jevpjq7qu+hNkDW+W4s5iIDMYLJucj+WKyMj6GlsyKQ6AlaAzMKiTyrcHaUKeWC5bEIIHklb5x53As92itImuwivr1e89+0Oy0M7G95/+HiTNHbKFedeGVNYDvU9J2QEzCjMdVY6KJ6yrbnZR2jKwkS5mCKrXRV84iSi5cSELLEVpFKMkiB6/QFSDHd9fyWcsDBKae8Sev5G4ZnzIF3y67OgGBOzyZcj4sdH0TR+oYMLKLO0+lGJWeGdNAN+7O4+lHd/GYLHG/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l67xC8O7359cezHMfWEz+PIOYK2CRL19KB0zwMx0yA=;
 b=J48JA85/jS7+UGn7IHvzT/hGJ6wjI5uBjNooOccLfZpH2EQVpYe7UJj/nU3J2huOvspBYC3qEkcrltxdHo2jQRTqFtGkhWgWNLbQZthSU7COP0GpdrCBZ63Q6sF2z7iBM9szxEpMMD3x+IQ/Cj0ky1dR3cE7RuO7Px5mz5eWT3Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3806.namprd10.prod.outlook.com
 (2603:10b6:208:1b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:00:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Mon, 4 Apr 2022
 10:00:09 +0000
Date:   Mon, 4 Apr 2022 12:59:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: Remove goto to no-op exit label
Message-ID: <20220404095957.GW3293@kadam>
References: <20220401183513.26222-1-fmdefrancesco@gmail.com>
 <YkdjhGtMwnbJcz+P@iweiny-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkdjhGtMwnbJcz+P@iweiny-desk3>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::30) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69af3f12-749a-42f0-3d1a-08da1621e74d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3806:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB380640B287B2688838EF622F8EE59@MN2PR10MB3806.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EE/G3FyBetE6Nz8IQF7VJrnsZByJMp0pvULvaqGwz0Y109+iqEkgHnZYKep/d/92cZfly35nEUMZdCzmc2JwYN30AnetxPJhQeBN/+cSk8Mqfo/L/yQzLQ9onPJhdqAQEj0ZGv/cdavlWkoFaDkVpVdhzfUkQhwqiFL89Od/wbwyQLKJ0bcr/AVrGmN4Ry6CoHpPjGvkivTJMFa+sklGMOZjVpxOILBGFS8t55HuYYQYG/0hRAKM/5CEIOS1R5UfHNp0chdokKWaSXN03ubCD3/hxiB9A28+wtLNePTno5wWCm5KsEWU5bOylWL32URN+fs/wIf903rXE/sIgd1ASgzKvJMtvcKlNtZaohfGrW+LJXWgHoca/72YJTm2pUkZ5sVa/Vpx6Q5t/HVoJIZjlY1JKntpUbupZoMlSixYtu516k2y44/ow70ImVACjhU/fv8j2BKMpNgDzZr7I44PGEddwJGswwsxboMBwJ5/JbaAVRu/V7pmbTZYDsfA50xcNWc+RAppUPDh9/LH7DUxBHL646hnLjHvTVQKZpG+YjS3wuLW++3xT3OW7dba7RJ0TuzsPaMRoGh200px308+Hs1JnF4J/raNRuzP9RvZXpiHrqlFssq+JGl8OFcK/bkqk+l0G5/sueUIKoLBDfsQ14P3ghhlDDj8U6y4PXudg8lcxPHJrUQNZ1kAJ4c5wrqwMBhZb4h6Q6JwwlzQAUfcIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(6512007)(52116002)(316002)(6506007)(33716001)(26005)(186003)(9686003)(33656002)(6486002)(54906003)(508600001)(6916009)(83380400001)(86362001)(4744005)(44832011)(4326008)(66476007)(66946007)(8676002)(66556008)(2906002)(38100700002)(38350700002)(8936002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIa0RxWW20D1FPGgkCBLh9FpyjcowyYBJMhyasAVkOort1FsFS9GKbKXux/i?=
 =?us-ascii?Q?pSxtdvUtUewUAyewIj8wK3a6IkEGAiAiepPL7ngrzPwSkAmwwaWGlvEEfdab?=
 =?us-ascii?Q?OZ9MUml1dQSQaoyROvo6/0Kcln/63PaipDekRVg9BsK5yRTRsAilu++o7WhX?=
 =?us-ascii?Q?/zkol9/OKCd44+GkfDbVDHhImvPZZiNuoMsFl0AYJIp6Rkv/SDdB/xRMJA/l?=
 =?us-ascii?Q?zAHTqLX6ArVh+f18e/KDEKggv8VAM6f1ATgMRf5wwignVOusNOwwjkl/ybWX?=
 =?us-ascii?Q?k8N+a0nltqjEkio2QzP/1doxICie4ZsltF+WIsIA3XC/u+R5kRhDfp3iNtmR?=
 =?us-ascii?Q?Q0CAo9Slhb2FluljPFZ+UoxzkpiPyScKoWYMEYRJh67aYT//gNbpbucZNLLQ?=
 =?us-ascii?Q?UQ6yjXGjKJ7Ar9HBwpH49C2+4NkDnCY7jma9yRi2H8RC2bvP74lwL6KCc0ME?=
 =?us-ascii?Q?GXpWO0YqLPC7LG6Cd8JJi/IMRFuZl1wr0xpVpf4KoS0ScxbVgWZaVtCTe0cs?=
 =?us-ascii?Q?qsB+tcEMqmDJs0H0iShxdRVCknMnnobAw4Tceo9z0k1h4CSvKGFp8T//zGMh?=
 =?us-ascii?Q?/DoFtD0AqUfxJkxXQje9NFQhX0fiW/9lHf3LPlrwgxdrz9/qmLPQL14D+Jbi?=
 =?us-ascii?Q?DF8aiTA9lCT5YWzDzd9N73KvvEIVCyltjD/fYUcr1opKENHlyIZbdzVW6qG0?=
 =?us-ascii?Q?ApXwOp4FNTjUsOxcJizl5sTwmN9nJkaX92QwDKwm4kjftNnQt0iuX2Lo2XHR?=
 =?us-ascii?Q?6oIx/nDDUisz9jjrZqap7QTrxvrsD6Q6RRQiv4+G3JcNz12r7yCW+Z2Ro/li?=
 =?us-ascii?Q?SKQ18BurxETSmQz4Z21LO/Kvg/OX42WILrQH/N/AnbkwevZ81WhFcqwwKUk9?=
 =?us-ascii?Q?DR7MiE2tthEIJx3kmZEoGB7wxW+IgG81yaZvQk8RpFlTzXIhwMMCdRP7HBlw?=
 =?us-ascii?Q?KJvd9JgXR9F9rX3F6owiUrz1ueztY5XkK9Db5JMAMNmnVCXPr8L1SwtXAFJX?=
 =?us-ascii?Q?FY4EEFMTlzlBuO3Vpg6v8e5FqNuLSusnMm7KX5v/h3cf9Ioko73PUkYL4Mf6?=
 =?us-ascii?Q?H4Y47xREmD6Kl9CZvZ9pX/II6TVkCVnGxXXwZcmjwo9fuXZJRW+/1g4BhAml?=
 =?us-ascii?Q?WgqVk71xVsocAS0309hUll0p3xYS78vb+JilbPHSfHb5PbndkpCyByM52MUl?=
 =?us-ascii?Q?y80zJV0YABP1Y12DbMYccQQpyOVyF3zvB29uPOpFf1o9rpSe5sHVtaKWaijt?=
 =?us-ascii?Q?NeKouuBgHwcLytcB30m87MUrEOfQJ2vZjRQyOtynDttyUH7aQs2NY89yukEM?=
 =?us-ascii?Q?4umZHD9HUNNR3dxvhKGTSZCAUXR2vk3YjBij5Hj9rkQy3mC6rtTi0U1naXHQ?=
 =?us-ascii?Q?+d2LcT/b1zYD/8Ryh7yA1PLqJg2/nrhZ/5KHZSexNpJR5J0m4kW71s+cc9fQ?=
 =?us-ascii?Q?S/oIKH89jynFHKW5QhkTIocdeIkMjFsFSWR9NTYHvuPGPaJ8jhHMSxv23gBu?=
 =?us-ascii?Q?rDK57a49lK4+Ie0rv14cOxYiAb1B2DdcoFk4dXAj/q1aZ/veugsBK2xVqY+Q?=
 =?us-ascii?Q?9JEOExRVhMsL+jSoCpqpNjmJQ3Ve9MMMx3lbgIlzzz55NSBFR7SZS31LJK3W?=
 =?us-ascii?Q?s3yhPw8YtXF5PRzj/R16Ooo3i54Rhyx+R2hsUYNoSgdEVfUkxi9TwSqPb+hZ?=
 =?us-ascii?Q?gqOuMIYAk96WyLZ1xhz/lpE5yykPM094UZfTCsvNwjIuTViASXo3gH7ldUjD?=
 =?us-ascii?Q?sNO0+eDDB2gE+LuTVRxVmjjS0m1xNoE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69af3f12-749a-42f0-3d1a-08da1621e74d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:00:09.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMolf/MkYFYNvFFX9GbCv93XhffWgsr5Pz7UsnWbEITa58518Doui/BiOw31xwoL/0grhiiYeQsAh3k2KgEQRSIfjuU7Q5Pq8bE7VzTuF+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3806
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_03:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=885
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040055
X-Proofpoint-ORIG-GUID: BcF6VMCI23SE4d1q15ymQqR1yGKO3CU1
X-Proofpoint-GUID: BcF6VMCI23SE4d1q15ymQqR1yGKO3CU1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:41:40PM -0700, Ira Weiny wrote:
> On Fri, Apr 01, 2022 at 08:35:13PM +0200, Fabio M. De Francesco wrote:
> > In function rtw_free_netdev() there are two "goto" jumps to a no-op exit
> > label called "RETURN". Remove the label and return in line.
> 
> Thanks for the patch!  However, A good commit message lists the why and what of
> a change.  I don't see a why for this commit?

People, stop belly aching about commit messages.

"Delete no-op goto" is sufficient justification.

regards,
dan carpenter

