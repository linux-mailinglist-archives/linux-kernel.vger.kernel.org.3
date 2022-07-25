Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9E57FC82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiGYJfT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jul 2022 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiGYJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:35:16 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ECF863CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:35:13 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-VU_KPirEN-y7CV25nVlp2Q-2; Mon, 25 Jul 2022 11:35:10 +0200
X-MC-Unique: VU_KPirEN-y7CV25nVlp2Q-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0373.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Mon, 25 Jul 2022 09:35:08 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 09:35:08 +0000
Date:   Mon, 25 Jul 2022 11:35:08 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Input: touchscreen: Minor colibri-vf50-ts cleanups
Message-ID: <20220725093508.GA8620@francesco-nb.int.toradex.com>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220712101619.326120-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a838bbd8-1917-4d96-ebd0-08da6e20f6ec
X-MS-TrafficTypeDiagnostic: GVAP278MB0373:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: XP/SEAJ2WZTwKr0cgUR4Rk8bqwskzU1jlat5YPhzFcj3uhAjVT60BdQgQwfs1UrJzBqxWgDbQW/UWPA9trHhpw/GflWu9rGQ1LHKNfvj6lmxrXJLYtwBHt9+6qOP0KvReizFDLzur9794yhjIzdLZBRqA6wNh0oCIBg5zynK1KS8qx8/MsTzyHwbu7SS1+HX8p9jsx4cmtq8qBNvc23ke1iBMD/06S0t2SlYu7EOnui3ZrPhKn+bajB2NU5YfiY+F2oF1Ox9W1WwDpCbf8Jv0dySQ8ESP4bWJDgSAtHm5Lfxe4eNQsZtdHqmsMybuiXoINMOop+rudL1hBohpncm4EqEgjJZfPE288nWITku0heZU5OpB2UGsvpPTEkwAv8R73SM/HAI8gJoztpV1Yh+oIPFMG6ask4J0Q7Cfv/SWn/2DNnC8rIcaBYE449yIv/jZqkBfx9/DCA2hjk3x1GTMlhtXgrVIeU2kJjAylPMS0vNFa+LpFzxL4wEfOThh3MJisQM3OE/ejQmlwCGy0rqou9NNQXnhbhPH0yNc6uZXEXcBB9umH/tUBeE/gjHX30n9viq7IIcAs/QkhLxhBTx99x6GKM76PIzvmA70PBmPlSIvq7OGk0y3azIi0D7Kls2vc8kMXt0NSideon/1wBblMVm41ENRRHYSkofHhUIDCJ37cWVwdtdDvxxxvZy531fOhBW1IcSSvgLfu+YQslMGTnOOyRjb5C1UDS4tHl1XfZAHDcBwtYM3/VPjKO9sGB14r7/tu3aF1do85eyMyDfMLlQu6vZtAQfZ/bcGj6z6tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(54906003)(6916009)(41300700001)(316002)(6506007)(478600001)(26005)(6486002)(52116002)(2906002)(6512007)(66556008)(44832011)(66946007)(4326008)(66476007)(8676002)(5660300002)(4744005)(8936002)(38100700002)(33656002)(38350700002)(86362001)(186003)(1076003)(83380400001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KBMW+ehO0FQAqoSWdnsvvsZRabgNR5BTyJhxgu4je2ecxKg5zfoTsj6DdhnY?=
 =?us-ascii?Q?t6b0BdPgrd6ImkU4eOFgyKQcR+dTJUrxq4ZYFU9HBSijhSeaMYDi3TzndgsJ?=
 =?us-ascii?Q?2Kvs7DCbqdw508atxCp7q/rF/8rvNII8SKN68VtaFo/q2jGrFIiPYdHZeFb1?=
 =?us-ascii?Q?WDuRqfH10Bi+Yt/wvtGBvaJ4LbDtBWlBCNw4VYwt7MlIh3ZWvRugW9u97KFI?=
 =?us-ascii?Q?VR//hCENFQFi6BfE9odC0W1Zv8jB0v01WIXcUYOXORvQ7CkcI+Kv/rr13UOI?=
 =?us-ascii?Q?AQWCwF/QI/O9M9RVYs8MNekaMvxZQs0x4Mh6dbEnvBguZr2Xnsd+MnfpDnRr?=
 =?us-ascii?Q?1bkorkwGGGwn30Xh61TrG4p7sf5aYCJgoTWP/5jwAqBEUUSup7mCOjB/Ply4?=
 =?us-ascii?Q?v+oX6D2K84m7CUeq2V2AfUCjsN+OtkR3uMbZ7xFX/WzUCkoCx1Tx0y527HJE?=
 =?us-ascii?Q?X0LVHwSEn8qDvCqYDYT4e4FjFS7hWV0rmt865AP15OxFRHiOp/ypTxDkxITN?=
 =?us-ascii?Q?/i9W0FXT0M50/gNZiTYZDcs9pkup/ybX5blE6t2OFW52/39t8Zco28woCBYi?=
 =?us-ascii?Q?u5uFNZMnwGsrevMNE80YiA5WiWXrXR8UD2pOiTsGNx++5KM6Pi8+7QxIk4ma?=
 =?us-ascii?Q?6DLlclBYclkGbMtPFYLKMoycEr6myW1PzU7ZA/y+AEtB/HHJubVpS3b7F55a?=
 =?us-ascii?Q?lfyCRGErvBlWjUpEqKS3WPUXUsb/YGO758MuQMQRTSWBSFbGNQw8egbNvyxK?=
 =?us-ascii?Q?4kB0OX+TkX/vg8STg77hhClxOQEZUb6gf46EgurCLD+nmD6lIdn6xyw0mqrt?=
 =?us-ascii?Q?gPlDDzn88wv/grhTYQ8oZSJ5bkTwoZQSR0gaBb6hTC/+MSAJwzC4JARgLaLZ?=
 =?us-ascii?Q?zNp3AdGtLHagzsVekL3KuuUyfkuDD6DGD5TyOz+Ux7G1c2I4oOQjqoy20XdZ?=
 =?us-ascii?Q?imNMgH+s0jrr87+KiKt+Jaxnvjr171srXDqPlJw6NS50VThCgV12dtGtwky1?=
 =?us-ascii?Q?/QXDEbmfvSCT2jxkU6ulbrSDlhRLwjIMxX7kTPu4YWfmEcRc2Mvp1kRvMGCc?=
 =?us-ascii?Q?tsjAaEv+9XtB75f0yGSBN9slFTWDSn/Mw1zzLqlRFA0/QhOuz2mWoeyocNYS?=
 =?us-ascii?Q?bcZ6lXXdctQoXtXAxQ96Hvk7XhpW4r3q/g8QcrBuZBDAnJboVI1Lq7lrbyFe?=
 =?us-ascii?Q?xcg9re6/VNEDBfJsSyk9dg9aylK814UcmaSdU2M/l5vel/4p1qqgJkXbxnGN?=
 =?us-ascii?Q?b0h0s6g0x3p9bkft7PBXz2YugKEICWODVqCYXW7HQJxXthY+2xnxk1Ghjzo0?=
 =?us-ascii?Q?jg6Yv+a+ti29L/55ngf4F2LuMTSBu0GHHL/L78F9Te+tQSN312xI/8WTX9MS?=
 =?us-ascii?Q?UsAgQmIr35lIm2iV+TIpmPA1qMALHhmpNu3LO1qlE3HCsn74huLAH0R0PXxT?=
 =?us-ascii?Q?31MdjEM4c3ahKDW8RBto1YfMSxkzkTMxBgS38VqgSwMDNP+kIAyXv3NP/9IF?=
 =?us-ascii?Q?0D5Wpwq6HpgxWG/KeWZfiKEuZ+BnVGRm/hmZaXpvJsum+W8fTceBAnJyoy96?=
 =?us-ascii?Q?qbjuY5LQaWpb4EQcLkAMSYYm8zwTFxOqOw9ceGUCstsVwzK0jhyXyosBHUF0?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a838bbd8-1917-4d96-ebd0-08da6e20f6ec
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:35:08.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/hAhVBx78VY1KNrLSJJF9b/7JBWQbuC92Up3m9yCRA0//dIFv36VhHn/Q6A07nG/0FS+00rizPczeTI1bTK4XuE0tszUwa0rK2YX/j4fY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0373
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

Hello Dmitry,
just a gently ping.

Let me know if I should change anything or you could just pick this
small series.

Francesco

On Tue, Jul 12, 2022 at 12:16:17PM +0200, Francesco Dolcini wrote:
> Hi all,
> This series introduce some minor cleanups on colibri-vf50-ts, allow using it
> with any IIO ADC input and fix a couple of mistakes in the dt-bindings
> documentation.
> 
> Francesco
> 
> Max Krummenacher (2):
>   Input: touchscreen: colibri-vf50-ts: don't depend on VF610_ADC
>   dt-bindings: input: colibri-vf50-ts: Improve documentation
> 
>  .../input/touchscreen/colibri-vf50-ts.txt        | 16 ++++++++--------
>  drivers/input/touchscreen/Kconfig                |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 

