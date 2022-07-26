Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6885816EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGZQDr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jul 2022 12:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGZQDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:03:45 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B1BF140D0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:03:43 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-v-DuqpjXPFiBtxSJDWkrog-3; Tue, 26 Jul 2022 18:03:40 +0200
X-MC-Unique: v-DuqpjXPFiBtxSJDWkrog-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0246.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:37::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Tue, 26 Jul 2022 16:03:37 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%6]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 16:03:37 +0000
Date:   Tue, 26 Jul 2022 18:03:37 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Message-ID: <20220726160337.GA41736@francesco-nb.int.toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
In-Reply-To: <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a00a230-24d3-4880-7595-08da6f20668b
X-MS-TrafficTypeDiagnostic: GVAP278MB0246:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: OwqtWOdrQOybZ14QQjP8WJWRqzsbOkxxiNrYWuuPZ3YbxEhNcWVc2Nuzhs/C0y205YUcPLREun2YkancoXSF2ZOgy/xvmOSEPPmdzCiMR3Tlwugoqz2x2NjBkaOByAO/chN9q+Gw9yekJSjaH/vCb2y5yBnZlsKxFxUILRkglJfzicd1Y0ESIl36X25BsifQX1zy9PPbJoNYvu5QAGo/1eK38BKJ6CtjxMTbT3ImAfy2MYNzlo9MBNYfClx92TWhMVbLh/7Q6/mvaSZbGUWL2FEc9ozGzmR5V8eZVucc2vtcGZWtPCtNAdO276+3qU9q2ougZnOtB7JqE4mvy0e5crqplFvMfrLSKT4cmzvbTpm4fKPkUtSjGDuKbqD2d56/LkpQNl+5jCYD2C2EvtWXXzb3qj1q/IsTdxJKXKhhyJfFplTH1yvs25I5XChNqfRvvGGTcQDGBQFHwmTTjxwH2tN/iWp1s0CWtJTUUoZ+BHWX7yet3WWNBoUkB1bJvp3jekhTEf2LjmWlzHqmfwwuuHGvwte+z3yK5XGVhHmJza1HO6zY7Vph2jCMt9PDjWhvejpdUCX2QPE09/fHwvIKzyoX0YkYq01G4UckiIqvKpd2xiX0asSCn7DLwKI/1VENZH1jIzu0hlpgdmSSAtiwYwFqWKY/2erTuFq78h4tXltkg7A7jnwO9ytcXCbHaQuwEG/7rnavHtQf5qJ3UiuZirRLk8Pc0DPvsozsrjs6AbwzF9ExtYPkMuJNtFFW/xL4L/yBkE+blxZEjsTW9VBXxdnnARQPh4AFcmR5ssooJ9EFFJIEsGsoZe6OMJd0Pz58
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(52116002)(6506007)(1076003)(6486002)(478600001)(2906002)(44832011)(41300700001)(5660300002)(33656002)(86362001)(7416002)(8936002)(316002)(54906003)(38350700002)(38100700002)(6916009)(66946007)(83380400001)(186003)(6512007)(26005)(4326008)(8676002)(66556008)(66476007);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?io2KSHXvK4sE6MW4ZTPVba+iYfW94eZUsG3ixr+43+NTI82ARdx1KUe5DTef?=
 =?us-ascii?Q?Zx83BLHmDLqdDWWkNypOoMrsq+7JCtZHFel1kWKcdrgK5opTCl8tnj38tMbl?=
 =?us-ascii?Q?kq4zsV59seP5zfKy26kgVvMCUUR9VpZ9LB3IqEoXidesmPb41P9Al7yrlyRu?=
 =?us-ascii?Q?GGVr+8e9fjhMrOCY3KpNcZ7EdR4kjtMK2S1P2IdzhLbXZ5JKaXBJUbOaFYdL?=
 =?us-ascii?Q?uxPW/C0Ln3ihAQyomshj2y/wlIHvPxrZl2c6scSwah73yoVQRdAO6OIA0yTG?=
 =?us-ascii?Q?W4EncAvmLoLFtxJqaUTnQ2TDFgrDpHXhZxbla0iDAuoPbySvI+3WhqB1ED2P?=
 =?us-ascii?Q?IsKBzaBCq5m1NxdjmZUfLyE0fIDsVhplBTk4oEbU3XQwvnxAw/gk7aK8uEdw?=
 =?us-ascii?Q?sODt/GluoHmsCeeLgFn8cnrOpWxgx3+DxYImB1sEKeUoovrhUHEQ8L4Wa7WG?=
 =?us-ascii?Q?XkPgt24ckpd8rlQb95NRT5PvhYVh7oq1rN1egZIcZ2p3LexyZRvhMY3Wx4id?=
 =?us-ascii?Q?WpUJ9c5G8VN/Q7bbrVKHAMu2KJEOIMrkowvKOzRai1julgXYbgon2qIOHk4/?=
 =?us-ascii?Q?fxggyb9s+HnwvmREEM3cY/jJdVGfi9DbJw0m8zSxlIck6O4ID2/CIg5GL358?=
 =?us-ascii?Q?r9ZHtwQ8bVZ3mWXnd5sBwqUbQdlNGdo/WtWuT3zZXHvQXTzsB0U4y1A9TZJ5?=
 =?us-ascii?Q?5gID8Oh5stC6WZtkPuD2qVgKKzyM5Ghiyepux3LzxyMK2IVxswj4aP23jfp4?=
 =?us-ascii?Q?CtVb+Cl+hL7RyZ+NiBAyq8hpJt4h0EN1+++vfZXUlB6yom9VzcrMXtw/ip6N?=
 =?us-ascii?Q?aK2VX2xDKoCNqS9LVbBk2Y51mTq4DGQVyQ8IGut77AAxR+UT2f3WjruSOi0N?=
 =?us-ascii?Q?VP/TxSKhe7qximdRgz7lCb0tOQeC9oM5A9zfZN2wFkxwGvqfN85RI43T7JsN?=
 =?us-ascii?Q?lrinwv1yy1avQtXRqRnJZBT1EbaXBYU0eZFEPelIF3BQ22oZoUPLMTglaEyA?=
 =?us-ascii?Q?X0wzLYNlgyYihju7aOqb+ZJ0WbLhiE6xV7UUWZwulmxOI/pqEtDKvh03Cbs4?=
 =?us-ascii?Q?tLEHZ/8ETFv2VWaJZneNC0uvZ6Ju70b/SJbu2mI6C8GUXlD8tu4aLPHs055L?=
 =?us-ascii?Q?Rls3FFRomIUJpkxtLnrPLjN1anUbnVFx9ysiDzd4rS/2M2GrNk5G9+sEAIu1?=
 =?us-ascii?Q?PkDTW6eU9Yu/1sIrHHOM9DdeU2JBn09O7+sEgfxQDOOVK2mlZdTVMinnkpoX?=
 =?us-ascii?Q?0zoa0P8q28jhE5355SW9IZhbg+Z1c0IZb/6O3TSJOgG7isK4zca88f1WJg+F?=
 =?us-ascii?Q?n0jiOkvafh3bL2669Xxla2YfHc/Io0IDpXewh4z1Y2wdrnujV3NdCR8jv1N5?=
 =?us-ascii?Q?G8QQgW3iYRZCH3Y9C3/rZEm0CZ+UqXq1ueXA8t5diYebUssClANHh/ZEWEyW?=
 =?us-ascii?Q?5FTYMjV7QwWuqMGAnuJbxp1ij55492Nk3CFBM6mERMeaed29C/jnUKTO5rlm?=
 =?us-ascii?Q?ebhq1GHq/IM/txJWMHkKDOqI1pxyIioycJhYpJQSf1zr2mvE3CLhOnSq3LnE?=
 =?us-ascii?Q?gCZIWdx1xXaWr4XEQnEjDpab0zyr3COAAuTX6SldAEhJykbz5jadjNupc+HU?=
 =?us-ascii?Q?yiejicLG60rJEuk/VJzgSQ4=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a00a230-24d3-4880-7595-08da6f20668b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 16:03:37.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kzfuW1FBMESeUvddNC0/o9wezGO5bDj9HB8U3wEABqjrB/3PsdNr5WKwBmAJmBUUBk+s8TgW2iPWHNuq1MbL2xtdbcu+JuJEu9OrIXd6rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0246
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ulf and everybody,

On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
> On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
> > So our plan is to explicitly handle a (shared) regulator in every
> > driver involved, adding that regulator capability for drivers not
> > already having one.
> 
> Please don't! I have recently rejected a similar approach for Tegra
> platforms, which now have been converted into using the power domain
> approach.

Just to quickly re-iterate how our hardware design looks like, we do
have a single gpio that control the power of a whole board area that is
supposed to be powered-off in suspend mode, this area could contains
devices that have a proper Linux driver and some passive driver-less
components (e.g. level shifter) - the exact mix varies.

Our proposal in this series was to model this as a power domain that
could be controlled with a regulator. Krzysztof, Robin and others
clearly argued against this idea.

The other approach would be to have a single regulator shared with the
multiple devices we have there (still not clear how that would work in
case we have only driver-less passive components). This is just a
device-tree matter, maybe we would need to add support for a supply to
some device drivers.

Honestly my conclusion from this discussion is that the only viable
option is this second one, do I miss something?

> If it's a powerail that is shared between controllers (devices), used
> to keep their registers values for example, that should be modelled as
> a power domain. Moreover for power domains, we can support
> voltage/frequency (performance) scaling, which isn't really applicable
> to a plain regulator.
> 
> However, if the actual powerrail fits well to be modelled as
> regulator, please go ahead. Although, in this case, the regulator must
> only be controlled behind a genpd provider's on/off callback, so you
> still need the power domain approach, rather than using the regulator
> in each driver and for each device.

Francesco

