Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3304E474E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiCVUPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiCVUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:15:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2060.outbound.protection.outlook.com [40.92.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51234E084;
        Tue, 22 Mar 2022 13:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcliExBMkOmk5hs6PCFreLYPLB5Fury1Ljhz+m0+Dv1YGzCc+LZnrTIYDpX34Yl1m+B4s75AlTpB2EobQEY4PMWkTcT2bJKG9Tw88TV/SnKEdZZU/03q8kxwt4b0RYrTVxyBYCqZB1fydc3Dl8X/Ad21gYuw+A5wbvqtysQZTNnmbYYgYyV1zM0Oc9NRxFM0hiMAdj7ac4tNON4g3TQWX+GwFLDUqunPeOoLnajpOUgRM9kYFBaf3M9MK9k2yqjC/Vz6yFyPd7VeSQPldJhz+sf5jVGCcRuhv/c0MP+OkwSJFyQ6EeQeecHblCGPwDAFKFp5U3Be4KvQLp332DIu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDaL7ddZ1/etRra8Mk/HJzC5cq5iMdvg6aCSXdnZfGE=;
 b=dxXl01v6Rek9Nt9XT+6JV0K23jeNqrus1QobvMumxFlqzx7EqsHswGOdUf5x2Q49CDMLE5xlkzDsYrPfysaK9+cQrVLYRJxDWegFeOvs6LLzJ1/sbenBaukihmyKuglBgZnF2uk2sM0o95+5BICbROw1rM64ica5e2NJstY21lVbdyE4TlhnisSPud7jn5zJ3Y8VgCl8YCQOAUqxiWjSJ6KogUaQkOM0wCDMd8+tf4H3bUROxSfidMjzESRHs1uCEbrp2KN+VZ1KQefvnArB4TSzHNMqenzXsMA3EqLB3uNGvHm3zE+J+GjELC0UW9JuX0iP2lKuu1Fn4MLs7sRxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN6PR04MB0660.namprd04.prod.outlook.com (2603:10b6:404:d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 20:14:17 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 20:14:17 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 0/7] ARM: dts: s5pv210: Bugfixes, features, and improvements
Date:   Tue, 22 Mar 2022 13:11:37 -0700
Message-ID: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [/tFiGYUTJpR9E41DVPyPQ0IqJGOc5YzunLU9jZDWajdeKTikKkZWsk2Db92xHm34]
X-ClientProxiedBy: MWHPR17CA0094.namprd17.prod.outlook.com
 (2603:10b6:300:c2::32) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220322201144.20320-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5d531a-dbfd-40d0-75c4-08da0c408a96
X-MS-TrafficTypeDiagnostic: BN6PR04MB0660:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nPbVRSBM8jbqhoFP4WrOu0QHwymPCZnvJHxS1Rgm20vSY4mxunf8Dmkt/nWS1AQlKsOTwE1/t30zNUjLhdgYCvKhebEu0PbHfSpiWaPepApd0vKKTB8qlDrbnX+0HtdGLdMJHoysBIR8NQhq3sy51mzLNtg/UtXcMsqHJD7pvQu10vdU0YEqFT54fFhMyMPO0Cnn44rWvDCqlX2Z94oiYKwQ/2DXs2TaTMK+8awZNHq3Kg2cZ2rgyG1SScGHxtmVhjQU0mmQX0ckfCSmhqaesrSWI8tPN0eS9B7x+TbiZ7HHEQPbf8+cw08ztXmyiDtln7cGE2PP5Jps31CdqP2eS1ZPgOuvQDu/WjVxdysboDYcwQs1tniT4mY9l4hDwdhGDwlcQKSHNfst2nTLf7nxp8NgSF4eYHimCcVy+RJ9OPW0mvsmFWz+YRlw5AD/ftjB6bya7v/PmXM4ooRoxPSsYAvGoazNIK+00Q/Ot5ZSidvNJqsQHcTUI0/clMe6S+cmmLqwclzYVanZXpWFt9t8DUGUTrXNGhY9pa7BGOQrh6x/LT9zTDmC5eM7bXWr0+vLRT8rNq4WvRoYZpJY7yOUg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/yIthz6WTa019gnKpEcgX18qN0yDyqEsWYlVnNcMA7VKQFY7rkgOHRGzPN+9?=
 =?us-ascii?Q?i1zsdAAWIm0eq2NIffE90HA+u1UanRMwXO+97SIHtFa2dQabGcgG+emTOXZm?=
 =?us-ascii?Q?igwd/IGwuLatErfrwc1Oa1tqKoSgFQIQ4w9HHr5d+WlJElS4ieq5LimCtdwU?=
 =?us-ascii?Q?qDvEOe7geFMnz8J7Fn9vZXE+NAlqel886z7/JAlN0JVB8qtxwV8Goz89FQdW?=
 =?us-ascii?Q?VH+Ohq5/Tyb4Z80zjY6Lw/X31BpI+HWK+Gq3zcDDuNbIY5mxh+MkHE90nG1H?=
 =?us-ascii?Q?6r525y/HmhnlqVePrLTQcGQE7sxD+6yrR7I5/hjjT0nquhTWkPoQfqzS/vSO?=
 =?us-ascii?Q?3kefLYXu2bL8nMsNwXh8reRyfATvoVeBdvToP9EtoKb8JOHwjbD9YcboAvSJ?=
 =?us-ascii?Q?hZMBu+JtTn6HfoMhLtgA2mTaYa7zx74Pa+jm1rw+RZh5Da53dYphEu1KCKF7?=
 =?us-ascii?Q?cCFNuKllnTt39gG+ZXG7clpYWbYtrkeLTmIuPplu3gLI6HEBfDU2szeOygOA?=
 =?us-ascii?Q?Z8dPDQ4SAslyUjQIVwIk3N+IiecDgFoCcDj5VYFVX2B7Ss8CD9qEd4gLKWi4?=
 =?us-ascii?Q?LSm7GqreIZytOHTP+spYGvujmdbeGi7XFh5MGn7tPNHnuVYrfs/yQFWJFls7?=
 =?us-ascii?Q?EL6XBs5grtPThSy0eF/cL9S2T/WsFVEklCy7IsnbLr7xsPvLlV2fNU3FjCel?=
 =?us-ascii?Q?RLvCXF6sLZ+MARmCS4M8S5Kjhx/eOu4ZeXd7gAXuV0gWwEVAgnGhrYkc46gU?=
 =?us-ascii?Q?65rz9ORcz/4zoc2sA8LgL0j/gI7Js4UH1dPMaM5IVeYfxj2e364e9aXXFBw9?=
 =?us-ascii?Q?zldkI0HHzCaw0LwNeO75Ul25wZPGobrzRvXduhn6dYP0OG1uR37aDSy9Nl4v?=
 =?us-ascii?Q?tU/7E2RdLJBizcP77ZsaPV7YcV51ouy1KVB7vcqeqBlWPgctvh24DID7pZOx?=
 =?us-ascii?Q?TDg4uEAQmYeapjlR0Ovc8/QsRZ/vkNX6w0oEq5w7ik9i8PcWvWc9x0blFDsG?=
 =?us-ascii?Q?IwH/f5YJ6xW7U2KnesoHswUAhsBPgyZSf7E5EzNjoqTXEltUJL/MVfXxXwVV?=
 =?us-ascii?Q?X/HqMhguP6NmVrIMBYxil2FWeU9vhd2i+8FbwxGjbLzClFTDnfqjfV0nGgEa?=
 =?us-ascii?Q?ym2ofKWe8T6VileR8NgjAdGP+7nDmFfTu6zuUJObBlPlsRTZeCQxFLtpLJHl?=
 =?us-ascii?Q?yL+x94Itc8isp7OSb58NiNcB3NT7H+emRUeaxQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d531a-dbfd-40d0-75c4-08da0c408a96
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 20:14:17.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0660
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups to fix warnings when running make dtbs_check are included,
as are bugfixes for the panel CS pin and bluetooth interrupt name on Aries.

The new feature is charging support for Aries board, note that the galaxys
(i9000) and fascinate4g (SGH-T959P) have slightly different batteries,
and so the DTS can't be shared.

Jonathan Bakker (7):
  ARM: dts: s5pv210: Split memory nodes to match spec
  ARM: dts: s5pv210: Adjust I2S entries to match spec
  ARM: dts: s5pv210: Adjust DMA node names to match spec
  ARM: dts: s5pv210: Remove spi-cs-high on panel in Aries
  ARM: dts: s5pv210: Correct interrupt name for bluetooth in Aries
  ARM: dts: s5pv210: Add charger regulator to max8998 in Aries
  ARM: dts: s5pv210: Add charger support in Aries

 arch/arm/boot/dts/s5pv210-aquila.dts      |   8 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi      |  25 +++-
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 162 ++++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 144 +++++++++++++++++++
 arch/arm/boot/dts/s5pv210-goni.dts        |  14 +-
 arch/arm/boot/dts/s5pv210.dtsi            |  24 ++--
 6 files changed, 354 insertions(+), 23 deletions(-)

-- 
2.20.1

