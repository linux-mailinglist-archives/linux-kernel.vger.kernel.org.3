Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F54496A65
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 07:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiAVGOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 01:14:45 -0500
Received: from mail-cusazon11020016.outbound.protection.outlook.com ([52.101.61.16]:47342
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233460AbiAVGOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 01:14:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kyi1JA5aHjM2NtkZNNY/rTOh+RJBJAJIuOwL95lcAx5gyLz3PdjCWA0qcyM/Vc9wFI0dA0O35OC7jCXAyX/q0fREGHB3sGI0o4raqHJqfP3POkq0y1svIUhs2yrOGyMOa64q7cCyGY2Q3lyAFKL3RJEqanpYeWl33NZZC8nTwGyQnVME1WGBNYDXmyfaDBpUynDQUTcyW24kgGZH17x4fmvLAP0gzzKB9t4E02wnUoPsewXD1PGOQ/b4cJpwi3KqSKSW87PeM8fQ/89LSqRYPxY7eGcXI/pM7RARyPUL1pQpmWGWwX38iaYwNG+tF/ukuvlKXGl6wkwMIoJMc8lE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSVJ4vlkHSC5/XwvduOciDWd8nfwXhO7kyN/O9A+jEY=;
 b=kD/3qOvK5oioL7S4lJDlI5OEum0QuIRP9KH9uaZOZwcWTRlwh88v27g58CIBDbyai1Xza6AZttUGeGu8+T1LizhI72vBwJLyDpe77wdra4y6IZoXfX1KjvTZgN1WERfrKuU/+RMldVNTuFeLBYvOaJnu2t0nQgEb7/XoHEYpZWo+io0KwaZh6MEMUyvlhyJUORONrsXuJ0zCRrBQJsvtbeGwCYDvjGPT8gZ6U/BvHYZmcXNYQ9TjD2Hll8wdeRej1pVWQCQZkpk8FwwU0WS0P+ZqtP9UT5jsr8/hoNhNmKR65bzso2mWgUvx9lxHvK4egu1rhhWml4aNx/yRbZBw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSVJ4vlkHSC5/XwvduOciDWd8nfwXhO7kyN/O9A+jEY=;
 b=F6uflq72oQRVyonyUpNOqa296iG/PhswrtGkXhGX5NJPdFhwkWCtcJvWPRqLAiTNG6RU5+tEESi5qVjpuBUWgaCoagkX3kM8VvvPCGdnDm0a4QRq09aN/PGYTbCf0NRfmg8SgW2CFgGwiaE7Z10Cv8La0Z7plQhmREZ4wEdWKq8=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by MW2PR2101MB0987.namprd21.prod.outlook.com (2603:10b6:302:4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3; Sat, 22 Jan
 2022 06:14:34 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::f57f:2d2:a927:e29f]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::f57f:2d2:a927:e29f%8]) with mapi id 15.20.4930.009; Sat, 22 Jan 2022
 06:14:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Oliver Sang <oliver.sang@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yin Fengwei <fengwei.yin@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        Rakesh Ginjupalli <Rakesh.Ginjupalli@microsoft.com>
Subject: RE: RE: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Thread-Topic: RE: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Thread-Index: AQHX9OjnI2iGAQwSWUqnCtF9yw5sM6w58EYAgADmHHCADSP+ooAmyATg
Date:   Sat, 22 Jan 2022 06:14:33 +0000
Message-ID: <BYAPR21MB1270F7AC484CBDFD94B10726BF5C9@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
 <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
 <BYAPR21MB127067C16809209C019BC83BBF7B9@BYAPR21MB1270.namprd21.prod.outlook.com>
 <27973649-193d-a485-1ca7-983a53c7cf78@intel.com>
 <20211228134926.GA31268@xsang-OptiPlex-9020>
In-Reply-To: <20211228134926.GA31268@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f700892c-76ff-4635-b077-305f0a059b71;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-22T06:05:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a663612-7fe0-4ac4-2633-08d9dd6e75c1
x-ms-traffictypediagnostic: MW2PR2101MB0987:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB0987EC504102FD83961BF247BF5C9@MW2PR2101MB0987.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3hWk6Ft7hmIsH/CxfLR1Hk3eQ9PkiBhQD5aEoviNKUziDMGqhSXEuMJxuC2ysO4ry6Bm+twTusKD+1PzLgxZvQhHiOsHxXi6d4jiFrktw3FWLumBYwQmoxzCYMof2KwnRRK2SSPaLIJndwxYLjw2geTDuf4UYhNpNdv57qtlFAB4P1Sf3xmO6IIsZgT9/YnBGU/3jYLHahAmUJ16O4FkO4wT8RBSgkwsDnnF3ZPYimodqN0z+8gImAJ8jk9Uu5FWFSAI2gDhvokJ1x/YxbKgwTYDXtj659dCT+fxzQyHPn7zMEb9l7OpzxHOF875PaDj+kQKNjh9SAUsqTF0dWR1EAtwL/O+xD7hm6c6Q558MEaJIF4cs4mfICgAxRcz5G9Np10+xWAiAlFkFBTuj+0Y2w7qKX96MAobyCNb9Qlcq5bzjwdiXoDtxTeSDCgmeKVWB5eg1xEyWe2oJ4E/8upxxCK9oCavC+zkDatYdU0+a9hkk6d7yULtjwEcAfsdKQVmGsSuX1TOLGLPtRUzHW0E44ntSy6+JnGYzS0WbmBUiestYMDEiQ2cNPu0q0gjIVMf3MKMInfGUHNYIR7n5UpOHCqlsPBMikN9YSK6Yzt+5G0LTvtO4o8UVFqPeKcazppGPcqoThzMuXYzv5fTmRcccJ/r75w6ioNQerSO8G6At6oNvzreIweNeU1tc1uca8rtx6rP+bDMxnP/I8nhmL+g385/gbkfxjavZrkVyVRy5x9M5A9gJODAW/SRoAKEmnmmXT0VM28ZPbd4uybgjbTJO2b6Hh+nHr7UnSQiZ3fFeGXOIAYU70qUY635az5GI8sVrmjyHEvzzMox5tOAM9oUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(8990500004)(5660300002)(122000001)(38100700002)(33656002)(82960400001)(2906002)(83380400001)(52536014)(4326008)(64756008)(8936002)(53546011)(9686003)(76116006)(107886003)(82950400001)(66446008)(66946007)(86362001)(8676002)(66556008)(71200400001)(66476007)(54906003)(6506007)(508600001)(55016003)(10290500003)(316002)(966005)(186003)(7696005)(110136005)(26005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6DO6LcCh1hzxVsDgVZN/EhALi8naZhcsIIws/7GkhP2Lgb8d2H5Fic7+oMf?=
 =?us-ascii?Q?0VynWfQCpM21A/KxySVzqQuN5ThVjycnEbDaeMQdEoczXnESols4cKN2n2fO?=
 =?us-ascii?Q?4kLIqlrtu0nh3zpzKWxGszB8OzulNWobxLSGkTT3Y7VhC5HPigwfnDWkopyL?=
 =?us-ascii?Q?J7eV0o4P/s0s9egC4jAsImb2zJhxW9kpd3Jk4/64e0OfBQNhKT4Cbsq/y9YW?=
 =?us-ascii?Q?o4fcjViepCHHo8oeth9JksHl1wiQUODfN2Rhn+Jn0BClf4b+wVnqXRt4oZnr?=
 =?us-ascii?Q?C5t61U4XW5Hwx9O84DBpm4KyCS6LSRkt5EuvXo1wVeEtlVF0EWoAAE/oZLkD?=
 =?us-ascii?Q?DV5fapqoWfvOFv/kQeagrqopYG2jlhbMuD80IKhuYwzB6r6Z8E1lI7FkQixb?=
 =?us-ascii?Q?5pxm44GBMb9H9GbnVRN5qiG/KlrWtTg2IvEvmlIKEk8h/x542mN1HH515EAx?=
 =?us-ascii?Q?8u4UVig8kcYEsDqAhO6jcOXsVxEJ+831qbhejOxO0yKG+VJOZTJ9cg+zR+oB?=
 =?us-ascii?Q?cIn/o1y50mig1TyJdpTNytyIYmI0fhhkiPsU19RAqestX3lHhPcOKIQF9+rK?=
 =?us-ascii?Q?DUMEa/lgBuNHMqC19XeQ5J8Ur9mC2bOfVHgFXcSjZnbscqXC1ZcXJYYsqFYg?=
 =?us-ascii?Q?lJpj+GI5W1uTREoB/taiu1WdsM7DlC2yLWBZkWeyt3Q+LkrD0n6TNNJ67dJJ?=
 =?us-ascii?Q?dDM2uDvuz9+fB5bACn7N7aU1qKfjcKPh1dBnrewDOnpupLsb/KGYTOrqM+W2?=
 =?us-ascii?Q?rU9ewO2BcnXStbh9mrP4ZfIfps0PPP2idYiIKAZN2gWGQG8+CVZ78Ky07Fug?=
 =?us-ascii?Q?e4GHQXNBThBb5T4qdKJhDapYzqCIarrJsoIrc3eqtCHm+LOg/YFrmlCKiv3S?=
 =?us-ascii?Q?Y7qPrrCKmnmeONeTs4XDlat7Fg8LwuOCUr1KGjAgP1pUPTa4+46tzWlFgFUh?=
 =?us-ascii?Q?APJsLaCgoYQaxzYTy2I5eOAicEBbybmNehGtxrCRjSguIszFPEtQPP4j0qbI?=
 =?us-ascii?Q?AHGQkSWF/ypeO/t/QGbeOUr3LSJLzhRTW43OtLaam6EJJBIRliP7v8kMKz0C?=
 =?us-ascii?Q?gSlRcdW5EzdjQexrj8qZPRxnJ/HIIhrkEGvRTcSud9xNdOPePRUpK7nViDsY?=
 =?us-ascii?Q?iMQ2RqQlt4XpRFnfT300kCFHKuD470IkO4T6BcanIrN3+zMJ8WDvUs/q16ln?=
 =?us-ascii?Q?pXBQLWSD29EvYFQMQvVcffAcHqRZHvvBX4PZ3AGrh+NkhgutIUz8adk1C1je?=
 =?us-ascii?Q?6VLcOf80tW+rBcBeWA2wTrVP3HhQ6ngZPKtgq9h9hfc1OOSO7oMTUR06J63O?=
 =?us-ascii?Q?XYFEiVBWZiyntFc2EMbIAEyPNaC7prjOOiYZIAkA0ax5I0XwMxaL3fHw4S77?=
 =?us-ascii?Q?x0gNo6zuHbdtmU5vFvzThGeH4fsc5P0kefgyPPeS628QTsWKLHnBvPVtKon/?=
 =?us-ascii?Q?9CHOir/xapwrQYNpO42jezipbYlrPXvcL2Z2dvy8VpKzrAjWYefBETRwUa/4?=
 =?us-ascii?Q?IcOQLBbOOsKIcWH8GzWZON5W7SfGa6Xn5fkXBCJSMuDa7dHY1E2XKxk/NAgK?=
 =?us-ascii?Q?sQ67rqeFS2YfFavyXDv6PmYwhKuPbMxkRc+0OICAMnxhNJzuljRVQnetEtgN?=
 =?us-ascii?Q?+eksICXp8rFWdL7Plskv1zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a663612-7fe0-4ac4-2633-08d9dd6e75c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 06:14:33.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCsBYr1vxoeZp4FveNrlNQL8XpctdKXJIGSMrrx9gTYvm80nB9QwnWI7qUUO299KBqrW+6++M9VZRYpItHqJmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0987
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Oliver Sang <oliver.sang@intel.com>
> Sent: Tuesday, December 28, 2021 5:49 AM
>  ...
> Hi Jens, Dexuan,
>=20
> On Tue, Dec 28, 2021 at 10:30:43AM +0800, Yin Fengwei wrote:
> > Hi Jens, Dexuan,
> >
> > On 12/20/2021 1:15 PM, Dexuan Cui wrote:
> > >> From: Jens Axboe <axboe@kernel.dk>
> > >> Sent: Sunday, December 19, 2021 7:28 AM
> > >>> ...
> > >>> Dexuan, can you test this for your test case too? I'm going to queu=
e
> > >>> up a revert for -rc6 just in case.
> > >>
> > >> This one should be better...
> > >> ...
> > >> Jens Axboe
> > >
> > > Hi Jens, sorry -- unluckily I lost the test environment.. :-(
> > > I pinged the user to set up the test environment again, but he's
> > > on vacation till the beginning of January.
> >
> > We hit this issue in our testing env also and will help to verify
> > your fixing patch. Thanks.
>=20
> as we reported in [1], we found cb2ac2912a cause big regressions in fxmar=
k
> tests.
> "[block]  cb2ac2912a:
> fxmark.ssd_f2fs_dbench_client_4_bufferedio.works/sec -66.0% regression"
>=20
> By applying the patch supplied by Jens Axboe in previous thread directly
> upon cb2ac2912a, we confirmed the regression could be fixed:
> ...
> > Regards
> > Yin, Fengwei

Hi Jens, Fengwei,
I finally regained my test evnironment and tested Jens's Dec-19 patch
(see https://www.spinics.net/lists/linux-block/msg78065.html) and it
also worked fine for me, i.e. no excessive CPU utilization even with the
default dm_mod.dm_mq_queue_depth=3D2048.=20

BTW, Jen's patch is not in the mainline yet. I tested it using the linux-bl=
ock tree.

Thanks,
-- Dexuan
