Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD27583D58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiG1LY7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jul 2022 07:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiG1LYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:24:38 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066DC6D9DF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:21:59 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-MHe4Dhz4PGKyOG5UwCOXOg-2; Thu, 28 Jul 2022 13:21:49 +0200
X-MC-Unique: MHe4Dhz4PGKyOG5UwCOXOg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0061.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Thu, 28 Jul 2022 11:21:47 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%7]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 11:21:47 +0000
Date:   Thu, 28 Jul 2022 13:21:46 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain
 provider which controls
Message-ID: <20220728112146.GA97654@francesco-nb.int.toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com>
 <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
In-Reply-To: <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 130c06fc-4095-48b0-ae5d-08da708b5c22
X-MS-TrafficTypeDiagnostic: ZRAP278MB0061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: s+Huj2TBbpcnfV3tF/zirVskkOUnGmNycCLLF3T6c1fgztYIJN51+rSltAKzJ4r35uwqbQHmHvVhxlMoZjz23vZ7DuI3c64HDsYo2OBEhDGTH51AsF57BY8cbBKXlOm8+/SfmsQ3vzMh7O1U2Lt8bYRVDatnrlKK3i2ahsv2TnJviFkEZgVu/FaqzYTtet4INzwmSndakR+uAd23vCcFBwwnz7vH2WKGavGuvlWilBtWth+/m5TOkBJS4stVJiDkQ1hyKn1DrVQ7hU3HszvqSBPiVh+jEcua6LgUDpA6QGZYO2sM2U27R38HXCwjOrlmXLOrpxBLeqsuOIxXUki93TOoBlAUDZDx9a9boYV97K6QPN8GVsAFutqKuYIeQ3FhKdAV/3a6tl+4qlvEsl6RRNXq/fSA2T/rB4wgjK24dJkWuvB01a9T8z15/Vzu44ymWkkdEHXQ3wxGpqBHP0rk7SJ7+WyqgHbXBWmaVSQCNbayVoUy1W2LYNn7jnZNQfiSPVxbEbM0tuK9QMhYKmRA0MhR5DBut/Atki/fh4hK74irazkVeSPxprUSzeFcj5jAh+QtYhCxPmdIK6z4QleMh+YtWDL03NI1xIwtpSTvP4ODYPk0xv0kIW3s/jXf9yg8a8IzFmqUR3i+8JPeQDoeDWOJ24eSbbeJcq8giW4BWWYlkj4995pWw9c2CzrMTRd7Pi1egPP1WDrtPS7yvSsaxx9XMfN0OLeFUBOPDRdvG1+lghKpUM/wzUgAEUP6h/rRR4nATw2gYaZNFqe4T1GRnEmYDC+/9706EBgrslHGtf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39840400004)(366004)(346002)(376002)(136003)(86362001)(83380400001)(38100700002)(38350700002)(66556008)(66946007)(8676002)(110136005)(4326008)(316002)(66476007)(54906003)(2906002)(44832011)(26005)(8936002)(6506007)(6512007)(52116002)(5660300002)(7416002)(1076003)(186003)(41300700001)(6486002)(478600001)(33656002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yah7az3GoUO+q1/qmV2l/aA3JP5Fx4lk1lC3qnj+Ubit69+Tmk/d7yFvwTcn?=
 =?us-ascii?Q?1DLd/qL1cjfMfDP6abCSPUL25xW5XxGGRNyxmx8+Qcm2xGMUJJmxUIzvSaRm?=
 =?us-ascii?Q?BxdCmvgPy4YL93BJvw9B6Bam1OIQntKoF1aJO5ATlOT9aKuqHlGYsNWRTHXU?=
 =?us-ascii?Q?Te06uPAk271IKuiliA4Vp58RND1hAIPC+ioYTwPjaAPOCo8hf+vQeXrfv0JP?=
 =?us-ascii?Q?8+6uKOjKZmW+kgOktCKRiuzI0Gf02Iyu4BLb48mFPGVvKHaXM8Y+lS5ymhIT?=
 =?us-ascii?Q?ZqeRItEGIZmL/owwy823ZprV6qk9wyz1eKyhgaOJoShun0ZtintZG0TYs7sI?=
 =?us-ascii?Q?5qKjFGJQfaUC1BrW1e9lViwB90dytpDpAEUuPCKwRy8qIqnUlrGufa6x8enC?=
 =?us-ascii?Q?re/QTNusjg1iNi8wYYnX8TtQCSE+Vl1mGRuByic18f6vhy9OIwFtFeiJkT4b?=
 =?us-ascii?Q?tvUQqqCNzndyLWFxKdGNWgy0GEvPCSLOt379RWT/gEqB4EkB/jw6We/K2FRW?=
 =?us-ascii?Q?7ff/kolvzde+ptHzXX5JoMMUDSRHh3RBbihzyKvpQcDgw2iuAysS+qnJHKkN?=
 =?us-ascii?Q?hJYcU1KM1cStW/gFPrwhak88zhErehWsBNw0iP30LkKdP81Gqu5lLmiQ2leg?=
 =?us-ascii?Q?zG+rUhl5VXk+cKTIHQAHBsLoXZyVmnwZXgLwEAcYIHxyBoAUYvMr5iFcKLpA?=
 =?us-ascii?Q?yJ4ktLzOX7ewvk7zXKmW8O12LuIVkof5CBjxVFXcE1rEFutnZnvTOxMhnjHb?=
 =?us-ascii?Q?39GWEOfTvmOmhKjgrw1SpCMkPmV3RlS7NcyJ3uwlcSnV3iwFs52FHJdXzdBj?=
 =?us-ascii?Q?U8BH4Dxt9hNqrTTXe0CqqXjDPlICS/M972lnCv7XMMtOqKEiFxr1NW4zTzxc?=
 =?us-ascii?Q?1V+G8gUi85InkaazEBNvjtqkSB+oTm/LSWRYCPKOoA/HIZ9XzJskJPjxdG0B?=
 =?us-ascii?Q?nXFZeeP8Zd2128YkEPrqsjYBexe8rMtw3t+/LWmPDBdV2rkgsFOajMzKE5jZ?=
 =?us-ascii?Q?NwfEKA+h3TD2eBz/jh193zOm3cLPUuIND6mW1u2qgbH2xjHbXY0kIGcSDDfS?=
 =?us-ascii?Q?u+ZCwH7WznehsRLMNUdXFwF8Ajx2bvB4trFNoOVwW8aS0G0hqwmarmT7debi?=
 =?us-ascii?Q?sYjK7TesnXXgFAaZrkHRvg3YLIrmevZo8OdmpAqTHY++yYOjiizzsvzuQB03?=
 =?us-ascii?Q?8ZUFdo43sanjy2+m2YO20/j0N6qzwz2iZqpGPYxodAAj+Abe0ktLBwg3zd36?=
 =?us-ascii?Q?N/oztIBN3/2ryvGFK18eAqhQvx73vMmQj89w+A+3b6aztz085HkHvBAvq97y?=
 =?us-ascii?Q?r3C+F2xazPb+OnnI2XrZZuAMmq1pYdY6QdiQmkb0QatDC6+92el4ErK3RljO?=
 =?us-ascii?Q?lrhrgsNoBDQGgseLklpCLGXAg+qrIKz/04D4sWKE80P/GYSFXlID8EQedm/U?=
 =?us-ascii?Q?IGAHqZC8CAM3zkOTR2lLYObBH512O2wZAoKeNWM30fatyIB0B8zmN0vMBkVb?=
 =?us-ascii?Q?pjWDkxcKhoVKw82b6L7rD6DIjWB/lxAmE0GOAxzceBVS6mblKXLZ7QvXQ2GV?=
 =?us-ascii?Q?BAI8NM3O2wReRaYOni7ZlY5W+8IsX4UhttoKApjGHyGWumDSbwnf5LLhJ6rO?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130c06fc-4095-48b0-ae5d-08da708b5c22
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 11:21:47.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEsLmRarr/Cve+WjF8jGCcvPEvdc/zAEH3U9b80Ipzd2z0qqQPKc+RZQi+el+V4HZHHKaiI2sC1zfBtRuuCOtsUUZPqI7LOTarIUeucXN6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0061
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:37:07AM +0200, Ulf Hansson wrote:
> On Tue, 26 Jul 2022 at 18:03, Francesco Dolcini
> <francesco.dolcini@toradex.com> wrote:
> >
> > Hello Ulf and everybody,
> >
> > On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
> > > On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
> > > > So our plan is to explicitly handle a (shared) regulator in every
> > > > driver involved, adding that regulator capability for drivers not
> > > > already having one.
> > >
> > > Please don't! I have recently rejected a similar approach for Tegra
> > > platforms, which now have been converted into using the power domain
> > > approach.
> >
> > Just to quickly re-iterate how our hardware design looks like, we do
> > have a single gpio that control the power of a whole board area that is
> > supposed to be powered-off in suspend mode, this area could contains
> > devices that have a proper Linux driver and some passive driver-less
> > components (e.g. level shifter) - the exact mix varies.
> >
> > Our proposal in this series was to model this as a power domain that
> > could be controlled with a regulator. Krzysztof, Robin and others
> > clearly argued against this idea.
> 
> Well, historically we haven't modelled these kinds of power-rails
> other than through power-domains. And this is exactly what genpd and
> PM domains in Linux are there to help us with.
> 
> Moreover, on another SoC/platform, maybe the power-rails are deployed
> differently and maybe those have the ability to scale performance too.
> Then it doesn't really fit well with the regulator model anymore.
> 
> If we want to continue to keep drivers portable, I don't see any
> better option than continuing to model these power-rails as
> power-domains.
> 
> >
> > The other approach would be to have a single regulator shared with the
> > multiple devices we have there (still not clear how that would work in
> > case we have only driver-less passive components). This is just a
> > device-tree matter, maybe we would need to add support for a supply to
> > some device drivers.
> >
> > Honestly my conclusion from this discussion is that the only viable
> > option is this second one, do I miss something?
> 
> No thanks!
> 
> Well, unless you can convince me there are benefits to this approach
> over the power-domain approach.

I'm fine with our current power-domain proposal here, I do not need to
convince you, I have the other problem to convince someone to merge
it :-)

Maybe Krzysztof, Robin or Mark can comment again after you explained
your view on this topic.

Francesco


