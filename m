Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCBE54CB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348709AbiFOOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFOOZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:25:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263D38DBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:25:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDrsXw015214;
        Wed, 15 Jun 2022 14:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7DpWtECQWU+ljtQ8V0PD/DqW/kLTG8LxgpC/EMdLilk=;
 b=HEZfsiyhnrXalU/Bfk50gmWqhMbEy9v7yyFfpHQ+TbrV4iUm+XcHpI0Z/FdQsj24wwKs
 GS/2AXmyiw39YTL6NEwt5FSO9/MICXibi6R0CSM37z3RHS50SVPsiMubr+J7w6VV+Qpa
 0RiEXbprnzy5V/q8a0Nqc0/+SdnhCqgSLvreTuR81xGG/TkVA+pFVbBccw5wUhC+pVDP
 bg/yjqqTosMJ6bMlPNLyIm9ur7WY6JbqXqwVjdBhUmChlVJi3a14u0nYvekANwJROTeO
 RJKH+O/M4nIVjn4Ei+/z2yL/mGJLYONYB+MIruULpUdMr3C8qCZUC4bqtf8gxjjJER7X 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0gt01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:25:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FEJwPN006813;
        Wed, 15 Jun 2022 14:25:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25uvt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeHNzQ2e9mQQRn7R8q8w32DcGSotwUFa2kuT9FuweKq4cPpvwqODfYh/ZPMxrG6rLo6HEPzTyCJr/gqVauSxSiG0TxowWDW62tVgYrhGGNliSuEQBL2oB6iepqH1ChKVqj6B0uqYQxCUrgf48gzJsNCaPdG2lOFy9GRnBxdHOgDU188/Hfp/sABhCFP4Q8ZWARwVM5aDKEeIIijx4NK5zFK+XxWAKSvL4cEpLb74sj0zJSh211YNf24VY7bHXezY95DYFG86ksR+unQS6bYqUIgEbYluaHhU0dDtpaH58KbS0rYDkHNHWZGOyXwyVgEUdFqG0fcEjx79THkb0bCVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DpWtECQWU+ljtQ8V0PD/DqW/kLTG8LxgpC/EMdLilk=;
 b=I1tBgKp/7Wgz69B+FS1RZGQnj8EPHN8/HksGAtLepchGQx01bToCxtlhWNA6r8/uBKfkkLUTz7GQx6VU0jq6eQ/+0cVVDtHpIzocIgHPMdQOHzu2mHjw2tyy4aliZ7mJhhEkDYT/bfLmxkway8B0JrrdlTrXaePhY0aZ1IUivU4BnufgFGhGTKx/6nd99HmJfg/kkL/kPKXdrcSFVyfcBqd44djvsFxc/LvJN7tAPxvc7VUsPktTs8roxfeYqZDG/DlA+6Zmr5SlvyXkGrhtJMXYT2h8kBIRASUdDzKDZ9LXt7BYz18eaBaDFtxY8+oRpdReSDj5eSssAc4O1ltaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DpWtECQWU+ljtQ8V0PD/DqW/kLTG8LxgpC/EMdLilk=;
 b=ePpBcQOD4IKYqBjNC5KB5UwVUlLMGazvnFub5q0arjkEq1o4s6+tD0CdUfLZ/ybDAMJlqRvBOlHBqkaahVq0V/Qcb/MP8k3Wxaax7ORUPFsPjYggrCHyHIgjp2t4fB4YoHJTEjHchpqTEcAXR+hQx3yt/vJtuG5Mb32kltR5f+U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 14:25:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 14:25:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCABc0jAA==
Date:   Wed, 15 Jun 2022 14:25:18 +0000
Message-ID: <20220615142508.mtp65w6tdiurtvcn@revolver>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-13-Liam.Howlett@oracle.com> <Yp3udPy0vuDK8khc@qian>
 <20220606161940.fh5edq5nyz4jru2u@revolver> <Yp4uD8uWB3rit/Ee@qian>
 <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
In-Reply-To: <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e97ece8-dc4e-41c0-e9b3-08da4edadfa3
x-ms-traffictypediagnostic: SN4PR10MB5653:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5653690F1514E9A855BEA0F0FDAD9@SN4PR10MB5653.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0D7/bzf6sJRhWcROkHHIj3h7Zbz8WZDNEqHMYSAUly3sdhfHCoT1gkM+DgKGpX0NK+TDhV33gUzWmr7MNM4DvT8vc2mKBvp0A73tMmKzTc3RX1HsEImsslomiFbLPYyur9BnVsaW6FzGDk7g/CiW9PcIj70S1Ugjd2Da4sj2d77stSUOQWGqBUtaIMLjDqUTgminqcVeXkyNz2Ohmrsewe/zba6OQ7XY+e+lVAeSbbzOXcezHN2R4pkJ4ZZnba2gZFgx/STDex081CpioDfQIjpIgkc8qTknT7zUxIGoW0bhY1C8zWcw+EXKqfHGiNVHMpBt40rud3YTx+dlosq/WHQvT2hjo8LpjxZMAQcFA2u7SFPJ1cJQ9K+d+ty22/TFj8sVDbA4AzOXOTzHJkH4Ew89epyaCOf2p7Mzu5JtblyiWNx7Ym/E6BtJPUOLNZNye8AxyvGuEV8O54zjn/ICfrWgQ3D3PmBjOQQ/rHEKfhWzchY8si2hXWF45k0arIh/ZQAnvvm7wmNDsjNFln4Kbekv9p/tueo0TgS2W3PPjqYAHQYv4+hbGiXWTZ8KrPMwZNvzIk3pj4LbZHS0sSsJZIt2JGPgHO2lkkhPCgHK90WeoGdQw6ZLjhO3a2bA8ox0MdLlo78OLTI39rgdvmWPEMY8ErZRwROCwQIVEXD7E09nyzOPXPDtGDxFVTeGgtOpHVkgg4bVZ8TIE7pTYFyeLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(9686003)(6512007)(54906003)(33716001)(6916009)(6506007)(53546011)(91956017)(66946007)(64756008)(8676002)(26005)(66476007)(76116006)(66446008)(66556008)(4326008)(38070700005)(122000001)(316002)(71200400001)(8936002)(508600001)(38100700002)(5660300002)(2906002)(186003)(44832011)(1076003)(86362001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zh2ZMPXiZlMag6FGTJGoAP8PkGNGvNKv4MWm2eG+0Su0RQti2VRWyE+1s2VF?=
 =?us-ascii?Q?I3v7GzYxhEozWWz4pyl7a1H2RLyixDV49rXn9y8hzkCEDhkyYyRp/q3Qz+F1?=
 =?us-ascii?Q?Ivl6mkpkVlk2mv0Q4oHkOJU8r4Y3Ie33tiLoVuMMH/RuDDgmxVec4YnCAcFG?=
 =?us-ascii?Q?as8qI6qokX6yBLn98v2Av71vBqIXlkt3jDGCFcXjlADP+5ZfiLL/O7uycOsK?=
 =?us-ascii?Q?O00RoFY2xNau5YJvht1vZ7fyRR0aat+Vtc9RFCHOoMiIVBwTfQFd9uc+Bw8H?=
 =?us-ascii?Q?/SgOgO4hLGgtADV3asAuxfKyh2wEYcvxPQRxjKuv39iQ9mCpPzKQe1X12SC/?=
 =?us-ascii?Q?XKbAw6z/baFOMhXK4IVUvuiYxuldR5T+GW7wYqdWAl8iN+yni5KiBi3RJOru?=
 =?us-ascii?Q?87XqiPPB927ESQ/i4A7DTquLdWUknmQautGYmh01czbU7X5iDuYp4PoQqGni?=
 =?us-ascii?Q?oYalxLHfrkCZz4tuB2awMs539KRSJldNCE4wqAdndM9y8drkXw+hbZnv7cQj?=
 =?us-ascii?Q?iVjlai4M7fEo+BRdOswUxaCP5fc4FPnur5adpYBLDzTJO4V3+Wk326vjWVut?=
 =?us-ascii?Q?ujiOGA5GS02iSKXQOIOeq6Ap9h6JSbNKAD67F1rhW67arX8UavBKYlvXUIep?=
 =?us-ascii?Q?5dHerrdLIzzB5sdaJtlG+vNgSqqkhM4/EeZrXe4fU5MfguDRFvsxxKrjgndj?=
 =?us-ascii?Q?pK0VzKdqpv/tcShbqpL4kXKe+jXWx/alTBppFOniwE2WpEgDkX0tIj2Td5Xb?=
 =?us-ascii?Q?U5LNrOgnFPC2zcdVNfwc6xxBOfUxXJfai7tOnnvYROeJTkAuTg1PW+UCaGV/?=
 =?us-ascii?Q?yv/zJq+Z+CPiTAFcRErOrmib/O6SCjQwo61HsoJIOu73Cikdv4Ybtqi5dpSL?=
 =?us-ascii?Q?WIZj3ZLOhWcXIGw7FTC6O4QzR3mSpZntFB6jMAklY/5UpqEkmsmBrqRhqyPc?=
 =?us-ascii?Q?wY/lXdWE/Ps1K1F73oy/dNZ22SWY3ecq/0HUTZ/zYB/T/+RniVByCKVyjJF8?=
 =?us-ascii?Q?Ay5G2pY7E1SQncaKXfXvnSuwqKdwWRnJ+0X6al4XNlD9MYKtQLU1iJry2L7o?=
 =?us-ascii?Q?g1MJw4WXFtRwLnRsqAkWg14ngLx2W5DsPx/gnyqElLBgPLeKHx8J2IYPFwM4?=
 =?us-ascii?Q?wh3QFPiFAKrAQhRxf9u1ZLgHqep+qqUXsG93pWCYdd5KYwgP1GR/UVxcav73?=
 =?us-ascii?Q?FJ4kyFLl0J8FTq+4NMmq6wvNvQPC8WnL+Mw+Nx3XxOQ/AogyBKnLPaT7x77D?=
 =?us-ascii?Q?1iB/eCPNiInGEb2OHUCRTSfgdnfgvJNO2nrLTSKAxDF4D3W/MVZHj4h4vnzQ?=
 =?us-ascii?Q?POaqJq1wTpcWiwtbftBro1LI/K9Nm0DK3jqGsc0qmjdVt50boWGqiXc2H6un?=
 =?us-ascii?Q?yOegrGYixobIffQXOOoqc0ATzUL3Lim5TRGilhIdGzqXuGbUDgaRrw7BIWDh?=
 =?us-ascii?Q?R3u0k2mk1Bd6EGYdnjMEH3sGfRwZ1kWIoWvLTHK2lpW/+Jn6EYWLobBoQuhz?=
 =?us-ascii?Q?DlRrtvO00vuBvryOZPSFf3DUYGyuPtapM+Nz+PI62ZH7t/M2D6WQZliGimnX?=
 =?us-ascii?Q?ekleYGpVov7L0q92ZUSdQZWrcqJ9iCaDeu1L9o7On/5yOoj2fR9AqwIgawJw?=
 =?us-ascii?Q?4BgY1t6lmRb6JzjdZrDBEjHZ19uGcA0JWPMOSco52/yoUO4F8hztS45UKM4a?=
 =?us-ascii?Q?jdweRX7ShhDsEi7mzypr327AHZqWtjyp04EJvGET9GPT1BcD+peu7QQtuDLM?=
 =?us-ascii?Q?VL2j9/EvdovnuXKnuwYTx0TfCnStcr8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92C48EF06298324892ABA99B5D700802@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e97ece8-dc4e-41c0-e9b3-08da4edadfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 14:25:18.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JupXXSGlEd1QwczR2Hus8vyASIbIj3p2MwM7UTohrPROgwgABO0DG0mofKEEDK7oDP4PHFnLZBeqXgUAfi3+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_04:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=901 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150057
X-Proofpoint-GUID: ohzofVcUoK9-QKc03HsV1JtiX5VoqSBJ
X-Proofpoint-ORIG-GUID: ohzofVcUoK9-QKc03HsV1JtiX5VoqSBJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220611 17:50]:
> On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wro=
te:
> > >
> > > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > > Does your syscall fuzzer create a reproducer?  This looks like arm6=
4
> > > > and says 5.18.0-next-20220603 again.  Was this bisected to the patc=
h
> > > > above?
> > >
> > > This was triggered by running the fuzzer over the weekend.
> > >
> > > $ trinity -C 160
> > >
> > > No bisection was done. It was only brought up here because the trace
> > > pointed to do_mas_munmap() which was introduced here.
> >
> > Liam,
> >
> > I'm getting a similar crash on arm64 -- the allocator is madvise(),
> > not mprotect(). Please take a look.
>=20
> Another crash on x86_64, which seems different:

Thanks for this.  I was able to reproduce the other crashes that you and
Qian reported.  I've sent out a patch set to Andrew to apply to the
branch which includes the fix for them and an unrelated issue discovered
when I wrote the testcases to cover what was going on here.


>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461
>=20
> CPU: 66 PID: 18461 Comm: stress-ng Tainted: G S        I       5.19.0-smp=
-DEV #1
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xc5/0xf4
>  print_address_description+0x7f/0x460
>  print_report+0x10b/0x240
>  ? mab_mas_cp+0x2d9/0x6c0
>  kasan_report+0xe6/0x110
>  ? mab_mas_cp+0x2d9/0x6c0
>  kasan_check_range+0x2ef/0x310
>  ? mab_mas_cp+0x2d9/0x6c0
>  memcpy+0x44/0x70
>  mab_mas_cp+0x2d9/0x6c0
>  mas_spanning_rebalance+0x1a45/0x4d70
>  ? stack_trace_save+0xca/0x160
>  ? stack_trace_save+0xca/0x160
>  mas_wr_spanning_store+0x16a4/0x1ad0
>  mas_wr_spanning_store+0x16a4/0x1ad0
>  mas_wr_store_entry+0xbf9/0x12e0
>  mas_store_prealloc+0x205/0x3c0
>  do_mas_align_munmap+0x6cf/0xd10
>  do_mas_munmap+0x1bb/0x210
>  ? down_write_killable+0xa6/0x110
>  __vm_munmap+0x1c4/0x270
>  __x64_sys_munmap+0x60/0x70
>  do_syscall_64+0x44/0xa0
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x589827
> Code: 00 00 00 48 c7 c2 98 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff
> ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 98 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff9276c518 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000400000000000 RCX: 0000000000589827
> RDX: 0000000000000000 RSI: 00007ffffffff000 RDI: 0000000000000000
> RBP: 00000000004cf000 R08: 00007fff9276c550 R09: 0000000000923bf0
> R10: 0000000000000008 R11: 0000000000000206 R12: 0000000000001000
> R13: 00000000004cf040 R14: 0000000000000004 R15: 00007fff9276c668
>  </TASK>

...

As for this crash, I was unable to reproduce and the code I just sent
out changes this code a lot.  Was this running with "trinity -c madvise"
or another use case/fuzzer?


Thanks,
Liam
