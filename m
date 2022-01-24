Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D790E497917
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiAXHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:04:47 -0500
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:45152
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231725AbiAXHEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:04:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIgW0lWwpVHm9Zd8GLKaNe/+SiWaM/bdjC7k5nyogsZoD1nc0pFRVyJrrwr/LB/I97mVmM5kmbAPJQdM/MNdjHkwa3BWMjWDrg27HlKJ7rEADWAhTxi7j8IusvSiVT1PRawVhslNKJMzD2Bu5pfEQpM4nH4lL/9FFB+vNenx4E5GR5o7MKsuBw4ANzrdvZV91Ljt+9x6VhwEZpABL8WxcRxWjF38OogFpVcwA6aoFdd9xLAjm+zOF9xaGCacXZRD0YUMfu1ENqUUIAcxi6X/qnqOZ3O8+9OjjynGsv3QOIq+8zdLC7dc4+JpiRMonuhWLLpA2JOHRPNuMm+JU0gZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hexWf9TJRKj3TVmJ8t2sqDGDrPhsy5VAohI5XlP0mqg=;
 b=Sex+0JuedT9hfyMTbOnIf8AP17jUaJAvkA7eZBzdMqT8OIzKREcBmhSYo4583qmM8nfRcXBNH19VIFbNUo+B6c+4XMLrjZF/VYLfLN0/lWTwKxxYQ4uyvqV3ofCHiKcdJuHVL4KfwbxpqnZvEK6JUSh6qfAkyuQHAK+TLtk946NYdMd+uSgQlgsFgvq8y/IASX0Mb7svK3B8tBXZcr4H0yYNEzMlyM05zMxoTNgJ3LDSDkbJLdtFJbPvTETa3hHS5wN+Pltt0pI9vYbRs7eH/0o2yHnR6gtb8TKdANyFdfa7JY39vdVaUW98VHVRWvtgsOoPOSeT4M2hQ+AFBYiZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hexWf9TJRKj3TVmJ8t2sqDGDrPhsy5VAohI5XlP0mqg=;
 b=H8GPDrrXhQHquhCB6kQV2zyKPlXBMsQj6EOOk66v1W/m8TTl3FJTHC64NdQwPYsX0f9Bpclpjxxc3srIV2U+N1P0bIq2ZA8oEvcwjdm0U2K7MzZkLG18dV3FBpRshf9dpMA8dMqZXzM0ao4kO60jv/Ijb6zqehkZpgOVM3A4gew=
Received: from VI1PR04MB5342.eurprd04.prod.outlook.com (2603:10a6:803:46::16)
 by AM6PR04MB5318.eurprd04.prod.outlook.com (2603:10a6:20b:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 07:04:42 +0000
Received: from VI1PR04MB5342.eurprd04.prod.outlook.com
 ([fe80::6ce7:82fa:2a42:516d]) by VI1PR04MB5342.eurprd04.prod.outlook.com
 ([fe80::6ce7:82fa:2a42:516d%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:04:42 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Petr Benes <petrben@gmail.com>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Benes <petr.benes@ysoft.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robert.hancock@calian.com" <robert.hancock@calian.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW RNG
 failure
Thread-Topic: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW
 RNG failure
Thread-Index: AQHX19neHowqaTNf00Kheozf5e35Yqxg5qfggAAANICACzIlAIAGFSXg
Date:   Mon, 24 Jan 2022 07:04:42 +0000
Message-ID: <VI1PR04MB53422CB749DDEB6E2CF5E628E75E9@VI1PR04MB5342.eurprd04.prod.outlook.com>
References: <ea3906acc2c8d6fb56eacd94b9531c18fa7cb4dc.camel@calian.com>
 <20211112152705.90513-1-michal.vokac@ysoft.com>
 <DU2PR04MB863088F218774551FA254EB795539@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <VI1PR04MB5342237C91A2ADF239B05711E7539@VI1PR04MB5342.eurprd04.prod.outlook.com>
 <CAPwXO5ahsSfo6WH295YPbXEHD3tf8uiL6AMaSCPV6=c1EqpoGg@mail.gmail.com>
In-Reply-To: <CAPwXO5ahsSfo6WH295YPbXEHD3tf8uiL6AMaSCPV6=c1EqpoGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1702805b-08a0-4d27-ea84-08d9df07cbbc
x-ms-traffictypediagnostic: AM6PR04MB5318:EE_
x-microsoft-antispam-prvs: <AM6PR04MB531836C2398E4E6F192853AAE75E9@AM6PR04MB5318.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Dg4o5JZu6nN2beQefk7YrUK1oWMCQhFxRDUphFPe00J1tLomEKdP5przM4wKOraOpMeiBiL16bogG58GcLX43dbK7GxZvQlYACyFu5RVVKc8Gylz1QgnKHuCLJS4cdamoe9vziJjzFfdCkjplCwwu+ksTJKWneAUDN4nXVy8jrr+nNGxGnvk0Vcapos1lArZdfyTGPYFHvcFey0mszd6iWWzgW57WxZNe1UEniRRfVw6uq3IEvO3ni73dZtTztJVngyNYVwZJhS8ftkAYLKKhp8XuEfbduBBSJUS4MnXgMQcMftSzaE4yvpxitF1veqgQf7e8Oui0dPtoNUQ1ovI/AG75wzvvRXNohhSVpycTCxfe0ROg58IK24qRAccwgVVXjoagdkkZWT9MyOlSn0QIX/b7UkuVLT8Q79zZgjmrzkcBmSTHFt0EytBCMDm9nMSqXOMwz3QxT66nvNWbkZgcPTTMXyweS7JSWlRVKiLwOnLdO3bGzqd7Dro0Q1j9Cki7oe2LFczGhPE7/xnIgaI5zfzk8X9//MLvw1I/k/1RvCplAd+fqko2VqWfMT2ZZrSLhrjL7JErN3+qcByGk99H2xPUZGmbyZZQArmdba0EEjXaE3ddvPhNxx8IBAkn84ipRTw80UCw+4A/KZsxXWWyjzL6JSHrPCLMQNy1mhS7QH9nEjhQZ17BEtkfMHnrPpqVhDnTErFqlHL1dqDBiYK+JYtksMIwPgZW+CG+11gKdr8rOz+QGhJ72cc6DxB9Q75jx6dEfoUtBeSaxxW7dD276iC+N+gRtZqnfmJHaQ+8EVAks8oGMc+NPhJPtYkuIFA6LCc/5f+n4U1cUvobwiZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(7696005)(316002)(54906003)(5660300002)(9686003)(33656002)(4326008)(55016003)(44832011)(52536014)(71200400001)(2906002)(86362001)(53546011)(8676002)(26005)(76116006)(186003)(83380400001)(66476007)(66556008)(64756008)(38070700005)(122000001)(66446008)(45080400002)(66946007)(38100700002)(6506007)(6916009)(55236004)(8936002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?cyRMhf738vm2ntX5WzQvOpMf5MwX6aMkiwyVzzfTJXWXti+IfL0fSD6wjO?=
 =?iso-8859-2?Q?H2ew01VmpiY/kfYUKxxT1t6YI0ZlKg3Kvj/aH/f9VfoPzvmEguW3Q2TRs/?=
 =?iso-8859-2?Q?RVNFLv3/B6Y0TBjrMUDwHb1evcQE6S99TzkKkUa0QohVusM5MOF8quKAK4?=
 =?iso-8859-2?Q?uarTUIAFaPb2bZRHUBbpGzAouGAOEP5hkN4ZH01PfH/qttoRTBBRTrXd3/?=
 =?iso-8859-2?Q?eUrcPI+GLWzD+MmECOvsw2BhYiH6wiU+YoCjP/sK6FwY9DeCFKbedCGysw?=
 =?iso-8859-2?Q?cM+GqG8xXyvJEs71PaQd0dRsirqoORYXYBGJkMsf3l/BnH1Fv5ijfvmDxv?=
 =?iso-8859-2?Q?mkHnBCXouU52UlrCTA+BL1Euyf5RWuhR7P95C3EoZf4/B2A3qyTB92NfCJ?=
 =?iso-8859-2?Q?AOhP8n+R/C6V8uI0+7fxHJ4P0ngt2VhgRmbh4jRS4ZxLl/PVE9uEc9srU7?=
 =?iso-8859-2?Q?HPj1xnZ/lAqOCD8jqLbCp5nXmCzaIRcWIOqQQZ9O9pLXbrbH3qwSQyf/Qy?=
 =?iso-8859-2?Q?oQZTLddOkgTwZatE9d2p157gIGxSHL+cTrmdlUVNMGB6y4OKDtCYglefiK?=
 =?iso-8859-2?Q?tYTju3i8/bRTutmoPMX3YH/nOmPOvQ6Vy58QdIyQ9O9u7BPJfriYXsoI18?=
 =?iso-8859-2?Q?FiLL5gkoyGCY8ZZcT16pyqd9dyhbeRldgy1eIJUIESr4LO7FI8RQzkc3v9?=
 =?iso-8859-2?Q?Qt+E5LJHzN/+It5WkgzgfXUx0lODZJUA0uN5DJvpa9LVi+uRebLHX3Qdqg?=
 =?iso-8859-2?Q?YpCZpC/toewKqhmhpHwZQrFGNKqp8C9IOKlI1znh2WiTBXHelrDQU+/wRF?=
 =?iso-8859-2?Q?T04jw6HKx6BEEXbII811HJkO0z9D/5tiwfIz+HhWR4UKy2DuRbdMeIolnp?=
 =?iso-8859-2?Q?6cf2wLSiv26EHSDmJLfbBHz3J+0HDbP/u50cVpgWKEdcrn5ynuILbgxWb8?=
 =?iso-8859-2?Q?9PAFj+f74zIGs47GxHdbYATCNWUG0JfKQP637i/t3sQab59sMiMNfxvgv8?=
 =?iso-8859-2?Q?HSTNtA8Y5MY57Pac2Oh2rcfYXhGi/N7CoodAlT1dkaVKE10umWcIGK5sfN?=
 =?iso-8859-2?Q?GDhSTfx37fJydDo3DRkfOEBBm+ez1n9Y03j07r3o+eNG17dzGDx1UKgtlR?=
 =?iso-8859-2?Q?EeFMsMyHv2jNGONne1zqkVANP3dvDNMJhVkuHS5d/s+WZsYATgcOgBdlse?=
 =?iso-8859-2?Q?CSiqrY5lrZqKi7/UXvGRB1AxI1ykXZlqDiywDKFOnkzikl6R+3RBD765KD?=
 =?iso-8859-2?Q?ex4m43N26rngQF40iYv9EDmpmN1vqiYeGTmx1RRrXnSo19rZps213nbVea?=
 =?iso-8859-2?Q?22L1CsCVvvtTB7V0jlqY8lFfpu7nsRq4pz62+cZFmkzHk1V4lG7KY/IH4u?=
 =?iso-8859-2?Q?P58+XUEnBK453YYFW8PUIAM3wUwM/HFAJhxFs9wmxfgM1eL0X7x/zCWDCa?=
 =?iso-8859-2?Q?DtxxYoXVrVviplRcYiUeSqQXJqj9PIlJeFaJ2EyR4nKWhVmuaJMXAkrQDl?=
 =?iso-8859-2?Q?QhZS/QBWLSZlKDKo/YFWeLWGEnjEDNZo9bSlpcMBM33TRWezYJzXb48GRr?=
 =?iso-8859-2?Q?MfewGF+jrxpLE2oWKFzom7M26qYbG+RQ1pTeApmmFbxqsQ+dejkDxlO5A1?=
 =?iso-8859-2?Q?CSqER+53uyDjmdOme1eUVb7Qw1QrOFBgAQkRbud/XgirSpLK6BUs4UgwWZ?=
 =?iso-8859-2?Q?rZEK7Ft+EjQIewh3Z2w=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1702805b-08a0-4d27-ea84-08d9df07cbbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 07:04:42.4150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnLerxOSfmAHHFxE429h373G1vlAlmBmcF9Z6urnqIJ7MFJCi/1xBbrcvWr8+zII26y2nTPSGkctpwXy9167yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5318
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Petr

> -----Original Message-----
> From: Petr Benes <petrben@gmail.com>
> Sent: Thursday, January 20, 2022 3:29 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>; Michal
> Vok=E1=E8 <michal.vokac@ysoft.com>; David S. Miller <davem@davemloft.net>=
;
> Petr Benes <petr.benes@ysoft.com>; l.stach@pengutronix.de;
> robert.hancock@calian.com; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Vabhav Sharma
> <vabhav.sharma@nxp.com>
> Subject: Re: [EXT] [RFC PATCH] crypto: caam - restore retry count after H=
W RNG
> failure
>=20
> Caution: EXT Email
>=20
> Hi Gaurav,
>=20
> I've tested 3 i.MX6DL devices over ~day and got these results (decimal va=
lues).
>=20
> RTMCTL: 12289 all cases
>=20
> RTSTATUS:
>=20
> device A
> 1 x 49152
> 10 x 32768
>=20
> device B
> 13 x 32768
> 1 x 49152
> 1 x 1024
> 1 x 2048
>=20
> device C
> 1 x 32768
>=20

Thank you Petr for the register dump. Looks like statistical tests are fail=
ing.
We are internally looking into TRNG configuration which could cause statist=
ical test failure.

Can you confirm if you have reproduced the problem with the patches suggest=
ed in Uboot?
Link for the same is http://patchwork.ozlabs.org/project/uboot/list/?series=
=3D280725
With this patch series TRNG is configured in uboot. =20

Regards
Gaurav Jain

> Regards,
> Petr
>=20
> On Thu, 13 Jan 2022 at 08:23, Gaurav Jain <gaurav.jain@nxp.com> wrote:
> >
> > Hello Michal
> >
> > >
> > > -----Original Message-----
> > > From: Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> > > Sent: Friday, November 12, 2021 8:57 PM
> > > To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> > > <pankaj.gupta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: David S. Miller <davem@davemloft.net>;
> > > linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > l.stach@pengutronix.de; robert.hancock@calian.com; Petr Benes
> > > <petr.benes@ysoft.com>; petrben@gmail.com; Michal Vok=E1=E8
> > > <michal.vokac@ysoft.com>
> > > Subject: [EXT] [RFC PATCH] crypto: caam - restore retry count after
> > > HW RNG failure
> > >
> > > Caution: EXT Email
> > >
> > > From: Petr Benes <petr.benes@ysoft.com>
> > >
> > > Each time TRNG generates entropy, statistical tests are run.
> > > If they fail, RETRY_COUNT value is decremented. Once it reaches 0,
> > > HW RNG returns an error, and needs to be reset.
> >
> > The least-significant 16 bits of the RTSTATUS register reflect the resu=
lt of each
> of statistical tests.
> > Can you dump RTSTATUS to see which test has failed? Please dump RTMCTL =
as
> well.
> >
> > Have you tried to build this patch for armv8? For me it is failing.
> >
> > Regards
> > Gaurav Jain
> >
> > > RETRY_COUNT could be programmed in RTSCMISC register and is set to 1
> > > by default. Hence, we are left without hwrng after the first error,
> > > which could happen even under normal conditions.
> > >
> > > Cc: petrben@gmail.com
> > > Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> > > Signed-off-by: Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> > > ---
> > > Hi,
> > > we are also experiencing this issue:
> > >
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > >
> > > It is happening on both i.MX6S and i.MX6DL SoCs we use.
> > > On Solo I can reproduce it really fast. Sometimes it happens right
> > > after the board is NFS booted, sometimes I need to stress the HWRNG
> > > for a while (generate few hundred KBs of random data). On some
> > > DualLite SoCs it is happening at least once a day.
> > >
> > > We are using the v5.10 LTS branch but I can confirm that this is
> > > happening on all kernels since v5.7 to the latest linux-next.
> > >
> > > We also tried to increase the RTSDCTL_ENT_DLY_MIN delay as suggested
> > > in this thread [1]. It helped and the issue never occurred since
> > > then but we are looking for more universal and permanent solution
> > > suitable for upstream, hence we came up with this patch.
> > >
> > > Any comments will be appreciated.
> > > Thanks, Michal
> > >
> > > [1]
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
k
> > >
> ml.org%2F&amp;data=3D04%7C01%7Cgaurav.jain%40nxp.com%7Cad793bd423a6
> 4f2
> > >
> b03d408d9dbfb842f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 3778
> > >
> 2695582123236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2
> > >
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DPlPYDNHg9%2
> BCL
> > > iZrcdmOx%2FPdbAZmFpPZFvLe1jR4YhEI%3D&amp;reserved=3D0
> > > %2Flkml%2F2021%2F8%2F30%2F296&amp;data=3D04%7C01%7Cpankaj.gupta
> %40
> > >
> nxp.com%7C5d6bf460b260415aeda008d9a5f0ffab%7C686ea1d3bc2b4c6fa92cd
> > >
> 99c5c301635%7C0%7C0%7C637723276775699794%7CUnknown%7CTWFpbGZs
> > >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > %3D%7C1000&amp;sdata=3DVxN9MqDFbISptW3OX9XTtZ%2FwQTsEbF6dETxX
> B%2
> > > BHrywg%3D&amp;reserved=3D0
> > >
> > >  drivers/crypto/caam/caamrng.c | 42
> ++++++++++++++++++++++++++++++++---
> > >  drivers/crypto/caam/ctrl.c    | 13 +++++++++++
> > >  drivers/crypto/caam/ctrl.h    |  2 ++
> > >  3 files changed, 54 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/crypto/caam/caamrng.c
> > > b/drivers/crypto/caam/caamrng.c index 77d048dfe5d0..2be5584ae591
> > > 100644
> > > --- a/drivers/crypto/caam/caamrng.c
> > > +++ b/drivers/crypto/caam/caamrng.c
> > > @@ -21,6 +21,7 @@
> > >  #include "desc_constr.h"
> > >  #include "jr.h"
> > >  #include "error.h"
> > > +#include "ctrl.h"
> > >
> > >  #define CAAM_RNG_MAX_FIFO_STORE_SIZE   16
> > >
> > > @@ -113,6 +114,35 @@ static int caam_rng_read_one(struct device *jrde=
v,
> > >         return err ?: (ret ?: len);
> > >  }
> > >
> > > +static void caam_rng_retry_reset(struct caam_rng_ctx *context) {
> > > +       struct device *ctrldev =3D context->ctrldev;
> > > +       struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(ctrldev=
);
> > > +       struct caam_ctrl __iomem *ctrl;
> > > +       struct rng4tst __iomem *r4tst;
> > > +       u32 __iomem *rtstatus;
> > > +       u32 retry_count;
> > > +
> > > +       ctrl =3D (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
> > > +       r4tst =3D &ctrl->r4tst[0];
> > > +
> > > +       /*
> > > +        * There is unfortunately no member for RTSTATUS register in
> > > +        * struct rng4tst and the structure doesn't look stable
> > > +        */
> > > +       rtstatus =3D (u32 *)((char *)&ctrl->r4tst[0] + 0x3C);
> > > +       retry_count =3D (rd_reg32(rtstatus) >> 16) & 0xf;
> > > +       dev_dbg(ctrldev, "CAAM RNG retry count %d\n", retry_count);
> > > +       if (retry_count =3D=3D 0) {
> > > +               dev_err(ctrldev, "CAAM RNG resetting retry count to 1=
\n");
> > > +               clrsetbits_32(&r4tst->rtmctl, 0, RTMCTL_PRGM | RTMCTL=
_ACC);
> > > +               wr_reg32(&r4tst->rtscmisc,
> > > + (rd_reg32(&r4tst->rtscmisc) & 0x7f) | (1 <<
> > > 16));
> > > +               clrsetbits_32(&r4tst->rtmctl, RTMCTL_PRGM | RTMCTL_AC=
C,
> > > +                               RTMCTL_SAMP_MODE_RAW_ES_SC);
> > > +               caam_reinstantiate_rng(ctrldev);
> > > +       }
> > > +}
> > > +
> > >  static void caam_rng_fill_async(struct caam_rng_ctx *ctx)  {
> > >         struct scatterlist sg[1];
> > > @@ -129,8 +159,10 @@ static void caam_rng_fill_async(struct
> > > caam_rng_ctx
> > > *ctx)
> > >                                 sg[0].length,
> > >                                 ctx->desc_async,
> > >                                 &done);
> > > -       if (len < 0)
> > > +       if (len < 0) {
> > > +               caam_rng_retry_reset(ctx);
> > >                 return;
> > > +       }
> > >
> > >         kfifo_dma_in_finish(&ctx->fifo, len);  } @@ -145,13 +177,17
> > > @@ static void caam_rng_worker(struct work_struct *work)  static int
> > > caam_read(struct hwrng *rng, void *dst, size_t max, bool wait)  {
> > >         struct caam_rng_ctx *ctx =3D to_caam_rng_ctx(rng);
> > > -       int out;
> > > +       int out, ret;
> > >
> > >         if (wait) {
> > >                 struct completion done;
> > >
> > > -               return caam_rng_read_one(ctx->jrdev, dst, max,
> > > +               ret =3D caam_rng_read_one(ctx->jrdev, dst, max,
> > >                                          ctx->desc_sync, &done);
> > > +               if (ret < 0)
> > > +                       caam_rng_retry_reset(ctx);
> > > +
> > > +               return ret;
> > >         }
> > >
> > >         out =3D kfifo_out(&ctx->fifo, dst, max); diff --git
> > > a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c index
> > > ca0361b2dbb0..e421f8d1982b 100644
> > > --- a/drivers/crypto/caam/ctrl.c
> > > +++ b/drivers/crypto/caam/ctrl.c
> > > @@ -339,6 +339,19 @@ static int instantiate_rng(struct device
> > > *ctrldev, int state_handle_mask,
> > >         return devm_add_action_or_reset(ctrldev,
> > > devm_deinstantiate_rng, ctrldev);  }
> > >
> > > +/*
> > > + * caam_reinstantiate_rng - reinstantiates RNG. Intended for a case
> > > +when RNG
> > > falls into
> > > + *                         HW error condition. That happens if TRNG =
fails statistical
> > > + *                         check and RTY_CNT value set in RTSCMISC d=
ecrements to
> zero.
> > > + *                         It is exported to caamrng.c
> > > + * @ctrldev - pointer to device
> > > + */
> > > +
> > > +int caam_reinstantiate_rng(struct device *ctrldev) {
> > > +       return instantiate_rng(ctrldev, 0, 0); }
> > > +
> > >  /*
> > >   * kick_trng - sets the various parameters for enabling the initiali=
zation
> > >   *            of the RNG4 block in CAAM
> > > diff --git a/drivers/crypto/caam/ctrl.h b/drivers/crypto/caam/ctrl.h
> > > index
> > > f3ecd67922a7..26ff5a49a865 100644
> > > --- a/drivers/crypto/caam/ctrl.h
> > > +++ b/drivers/crypto/caam/ctrl.h
> > > @@ -8,6 +8,8 @@
> > >  #ifndef CTRL_H
> > >  #define CTRL_H
> > >
> > > +int caam_reinstantiate_rng(struct device *ctrldev);
> > > +
> > >  /* Prototypes for backend-level services exposed to APIs */  extern
> > > bool caam_dpaa2;
> > >
> > > --
> > > 2.25.1
> >
