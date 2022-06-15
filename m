Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AC54D13B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349229AbiFOSzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbiFOSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:55:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9339822
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:55:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXrtX032716;
        Wed, 15 Jun 2022 18:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MiYK0BLT7A6xkcLSJBkbPREiH8njjnLw0LEmwdcM8Ys=;
 b=Z4Jl6dyo/CINtTHK6QUhVxJcW+6VCmBoBD3bhlbbkD0hVcxGr1a/JTuddpy/ra0dCajH
 X5pCp0tUQUtlTfzo3KoFNDS/VqKYB3Ke6ZZdnfKhplmXaWUu3gJrTe1XmGg0N6UYDUV1
 eQqldpNBPCYaVB6UwswB1/C4x7QpdtCH3pn5rbnrPZNXlnP/94FJWmPYdoYVSGY0SdgK
 ByfPTPMq2W4bxxNJI76LICFyuiMna2bOOptKKJbyxY+WEpc9IgOBLQYnwTJZJSRVx2PU
 1IEZoiDj3v2iicWhUALfiNIcDVxZl8Y8kAyNdyFD6Jb0KS/SmMBCOPE2jxIkurKlIJfN Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2sgvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 18:55:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FIjx1M011837;
        Wed, 15 Jun 2022 18:55:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr263vve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 18:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIiMIFWNgh9mn4hqmlpYIs88BUmClq28lmfyDXLzelyVnh+GLcJimHMLV5StYhd/JkOcWotKfM7bca9qwpgoi3gc56Bo+iV8klapNtTfzzbsoAAs1E7MmvnmAFIZbug1kSkmcRaPvQtEsBmBu2t4EjACuPXM2sB+U0i+hZ2cj+8vwRAzua+KLxQtcFxgZ4lw43kRWfyy1yb+vilYhil5n+ozHgGOvWWhl0Vp62+GcSOdSc9Vr+BSR8jbHQa99ArubhRTWx/7hPnASIeSxcM/PyHkzmdKZNJvrr3mtDC/3x1gOUGjeFiIv95vihR2iycwa1THFRdcuuFhj7oO9fyMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiYK0BLT7A6xkcLSJBkbPREiH8njjnLw0LEmwdcM8Ys=;
 b=OujYye/H0/I1qPkPLBp1UJImifhL1tio5olGMFqQTf9H+UE+6TDn6ZyeV23B39fCpnj33uxOlC36OMgYEN//jJGGlubVMCqEjtGbxTBsIfDebW3suieMufoDEVQM13S7f4EiY07k0fg1XP3VLSYy1XmGLJLRSabjDnyw0Mz5l8SP+bGhwasH+7rnqeeddfjjtMpzXVRwLSuHjZfJItgFYJlNjlr++Jpz+SPsGzf0DZvJXfJf1tqvY/4YcXMH+vYNKGLtZ4UwsjfPHDiBQQRzcQkQrY3pxS9PHa4m3GRKKDTn4mtMY96bbVa3UpGgvMkrQZIq6pOdkGO42yGXsIQuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiYK0BLT7A6xkcLSJBkbPREiH8njjnLw0LEmwdcM8Ys=;
 b=UFiBjaAlJoQZdc3IKbFQ7GMjiHn2mzadxX2zy7s/TdYu2eTEQzEf7GPM4+GxWDKE+ybLiN5czgiCZvCdjkoVvVJ/JgxZX1LIJiSzAH9hR+BJ34Fqk2iaUxn+5JqzeObrRFO8kei4DjkCwxqmyOXdpdp2g96KHs3fiyCpYWODKqs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Wed, 15 Jun
 2022 18:55:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 18:55:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCABc0jAIAAPjyAgAANPQA=
Date:   Wed, 15 Jun 2022 18:55:18 +0000
Message-ID: <20220615185500.i5bzt7srzm6q72na@revolver>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-13-Liam.Howlett@oracle.com> <Yp3udPy0vuDK8khc@qian>
 <20220606161940.fh5edq5nyz4jru2u@revolver> <Yp4uD8uWB3rit/Ee@qian>
 <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver>
 <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
In-Reply-To: <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e7ec183-601b-4a79-972c-08da4f00978e
x-ms-traffictypediagnostic: SA1PR10MB5734:EE_
x-microsoft-antispam-prvs: <SA1PR10MB573429CE4E282211E3AC51EEFDAD9@SA1PR10MB5734.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHv4Xnd40TMPdtoK+sPat1E/ZhQqV3oM3ElwzTx42TDXDEcCxnFtAzdwrAa9pmMgVq2ckTLz9+7gDottGHGYU6RJy7o2byMRuVtk85lPB8aD+Y7wkNk3JxD7Nh9wrmwZgi28dnX7Ui2lFF17xnHeJ9Tz0719kJuTnmkjplC/my7CNrWYz9MjJ9bQzdfVo017Ge92FkiOqIri7riYBLyZAcaFn99wVx4eFrF68Pnw4wA62/gsun3dfUG8/XFrMyDSdFG4va8zoKo65OLntG00GX+pi1Hu5JY2MGlOYP8VhP1xfjewfEA4gjhy3Tctd79tF0XyPETI1gKVzdXUPMIXczQlQtgyqVh6oBmb7H4WZW9LBqiXQ0D61Y44myV4oAhujoziLm9POQilIhWoyDbCTZeJ3OdnhI2OoLdjefeofF8/LOp4iISJIbX6JinUQtCZh4TrEp4hhKlXyUKH3JppMuLTV1NTucLNIEMdJRHOYjVlUagkhgkOR8JQNukajf5WZnskNbhURfDOr1ts51DaR+BbT2KNiI4HPjarqq0gcCN8cmp3v/w5LiEpWWn7TigXivzWNYVeRfBOrGV6xNmSEXlJFRKWVtA+IXfT0kPmLsJ8HewQ2/wu7/u+EKhFndxTS2i1KRfnq2IlR1O8Ui5j8cmMEQEyk11ErY+KXaZIloTUR4drFDCnFDOqvwLYW3NiI0JqYM8GPba7JmC5lvfz5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(53546011)(76116006)(8676002)(4326008)(66556008)(66446008)(8936002)(122000001)(66946007)(6512007)(86362001)(5660300002)(2906002)(6486002)(66476007)(64756008)(508600001)(6916009)(33716001)(71200400001)(91956017)(38100700002)(1076003)(38070700005)(44832011)(186003)(54906003)(26005)(316002)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T30S6GLl8uDJifbVZikPM7bNN0pd92ZtpXRTpg0zyI/U+SLASTA2ldSYLrNa?=
 =?us-ascii?Q?CCVWNRC/UXO42ZzChjWdbdM2cvD6EYC/LnylPZG6WM7bDLQBCQL+4/pfVYRj?=
 =?us-ascii?Q?GP0EIRLclMpMEK63inH5T7xFevWHFc5dlEi64YcRrsgA30F7qf07cBUFxDYg?=
 =?us-ascii?Q?w5l+KG2TZuSDm25syHOWBwBmr0fqa/Jdn6QhAU+X/aL373t+xlA+oQ4Rdd9G?=
 =?us-ascii?Q?Z6efAzACMjRpeXmLkQvwYxwBAyVC3eDOT8r4KYQOnPTUEG8QLrZZcX34vqQE?=
 =?us-ascii?Q?iCOyYBla1g2O0LbEcdSrZsYwMPqNYsXUS8PNvZVFsDBJmk28JvKKKwtSEiyf?=
 =?us-ascii?Q?ACswzki7EbL95VWdZvhAG/QKEL5gYF846qCk+CzrcdF2OLqrULpzVD7epnml?=
 =?us-ascii?Q?f6z8Jk76cFbmMCreTjdBAtZNVI7Oy8EPxEzJHJQQPpVMFpBhaMy0KB3qh5ji?=
 =?us-ascii?Q?FIjvN5c3FPVsVEnoTK0QsMhyK1inPNWyliz3vbOkg2+PW33PEPjq9GZG2M2/?=
 =?us-ascii?Q?F+UnU3MaDcpL3ISoPfvJAOzUuQaoTbS6asTygUbJ4GrffPSlSSbJyKA24IR5?=
 =?us-ascii?Q?umrcnAmkqbeCOxlwDjEniZvgzm/BR5cG41Yl0Xjz35RogUjkK1v9kL7xZ+f9?=
 =?us-ascii?Q?y8xvSaWVK8s+P9EC816VYraBSQbRthf+gsncMtqSUsp5jDu+m3mWc5yXrF00?=
 =?us-ascii?Q?TTbWnO4FkvTuLtYuVXexGq2/7WjN2nxJsImEKtVcPA7h+enny9jK7f5uYNQ6?=
 =?us-ascii?Q?besYGXW0g/BjbuJA14b9EUmj9t9/DzJn3LBT/GiHejpAghwMLA5ffyjdXs2i?=
 =?us-ascii?Q?1LqVOpKP1SN129Vz7kZbc8ajHAO28d9i67PA8ILc6KH7ydj1NG20V4GRTEgY?=
 =?us-ascii?Q?Xcj6mLsv325hLdMFO0ns6pxaqSMpqfL/VH9ptTEEh9OUEaEs816Fm8PvfR+u?=
 =?us-ascii?Q?v9CWpz0F4IHmEsyLPsUNLCNURfEtafgH7Ni6KY6Uv6dLNKBNkyN+4iVhm5y+?=
 =?us-ascii?Q?qZAe/iu/d41xdnvHN8xIlQp+ouvp1GJohVWYiOFaMyfHW8nP7ISG1wq+eMMz?=
 =?us-ascii?Q?Okc2goTeqJvZ58TK9qsJhPul5w4QnBn4wVc7AenS3liBM4SEt+RmiWVh25Qz?=
 =?us-ascii?Q?Zh5J4jfSvGdxSnvNDZyNGxaZe3yJpVhylsOqvRqHfeW6Kt+B0G6HDV5GfscZ?=
 =?us-ascii?Q?/OJCBmUFI58P9zzPPg2yA7ynxiogKxfmOHwc8on1TjY+9vnzf9KyW+DiJhiR?=
 =?us-ascii?Q?1izm5BTJ8y5D8jZ5tFABJRKMu8hxxUDl5ET2lpCJT2BoKQHO8sPEybdmNStO?=
 =?us-ascii?Q?9eIJfpfhg9NoMxBYWJ75SL6lFsQujMdQmGC8YzZrKCChJ9pQ5I2q772fXwwm?=
 =?us-ascii?Q?SEiXd1BGFvssKzZuGVRoDkrAmJJNXngAwfK9Dodexgdt4f+nOyAyJfBgkNls?=
 =?us-ascii?Q?hjVrZ4qYibd6fAX7NHPVnuSpNtQCw1XuiMhgGSDP6oejE1exqRO/cEpVFx7X?=
 =?us-ascii?Q?pI6/O84PhiJ7Xr1dHggISw0PPyxArcSmGePqhMBcIZ3iOvef1gyA6eQyXY5G?=
 =?us-ascii?Q?BLhu06wQsA3f1qfm99q41PrGLXYf9UdjZTjx1qeX4rir2jgHQuYA5CiQy8Ju?=
 =?us-ascii?Q?RkWAdK4hDLu4A13D9Si+noVgGNizyPPCScbNWtMZRfYIOSDY2+HlwuIsfeFX?=
 =?us-ascii?Q?pR8WiTomMgIa+3TcjTHN/exV/H3/EY+qMXk3EK2G72e+GcZfOTxEtwzcSnEF?=
 =?us-ascii?Q?fmhewpTF6aH/KR66JBjBDw2i2oHQi8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5794A4634BD4A409CDEC7F48541F391@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7ec183-601b-4a79-972c-08da4f00978e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 18:55:18.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RS5ebebsgoDBcrq/opGSqeL18beqhtFRV0CP4gvVPoPdE+Cl5zM6Q0EOEIZ0s9VmVUXOARwEz23Fq4GtxIbp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_06:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150070
X-Proofpoint-GUID: OgEvoPbFO22yuuONL6rJr8Rf1LEm6-Oi
X-Proofpoint-ORIG-GUID: OgEvoPbFO22yuuONL6rJr8Rf1LEm6-Oi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220615 14:08]:
> On Wed, Jun 15, 2022 at 8:25 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Yu Zhao <yuzhao@google.com> [220611 17:50]:
> > > On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com>=
 wrote:
> > > > >
> > > > > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > > > > Does your syscall fuzzer create a reproducer?  This looks like =
arm64
> > > > > > and says 5.18.0-next-20220603 again.  Was this bisected to the =
patch
> > > > > > above?
> > > > >
> > > > > This was triggered by running the fuzzer over the weekend.
> > > > >
> > > > > $ trinity -C 160
> > > > >
> > > > > No bisection was done. It was only brought up here because the tr=
ace
> > > > > pointed to do_mas_munmap() which was introduced here.
> > > >
> > > > Liam,
> > > >
> > > > I'm getting a similar crash on arm64 -- the allocator is madvise(),
> > > > not mprotect(). Please take a look.
> > >
> > > Another crash on x86_64, which seems different:
> >
> > Thanks for this.  I was able to reproduce the other crashes that you an=
d
> > Qian reported.  I've sent out a patch set to Andrew to apply to the
> > branch which includes the fix for them and an unrelated issue discovere=
d
> > when I wrote the testcases to cover what was going on here.
>=20
> Thanks. I'm restarting the test and will report the results in a few hour=
s.
>=20
> > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461
>                                                        ^^^^^^^^^
>=20
> > As for this crash, I was unable to reproduce and the code I just sent
> > out changes this code a lot.  Was this running with "trinity -c madvise=
"
> > or another use case/fuzzer?
>=20
> This is also stress-ng (same as the one on arm64). The test stopped
> before it could try syzkaller (fuzzer).

Thanks.  What are the arguments to stress-ng you use?  I've run
"stress-ng --class vm -a 20 -t 600s --temp-path /tmp" until it OOMs on
my vm, but it only has 8GB of ram.

Regards,
Liam
