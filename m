Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DB535754
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiE0BaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiE0BaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:30:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D4BA56D;
        Thu, 26 May 2022 18:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp1rv5Ov+XL246HYsdwSdUCrdp1zfbQWWc+OBC/N2TtUCMzKxK+1TOs2LZIyP7y/UVEO7HhdpnYI6/9WMtpyYlbQfap7sJs9Qn1/HP+YRSvjdt3cvAjSqAbuOH71x7x+ppeiC+6qxs8Qa9Ku77XBzOj8AvviUnzV3ikXWqzTG3AmtYHCCqr//V6Le2dYM3ixpl139Sc0S/MWFtcu+LNkIvkW+q4XOFLhBoRdxaSRp5RIq36Ew4/Q2HJQ/dzPp1P/QdSGHdt09YFFV4tzMoC0it27Hdt4L1uJf/6C6YwXFjrQAvKGRWpVq90tCoJHJPldwUZ9aTxEs7R40oH9adlmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpriMlHAiL2pyNRwLp2es/eHaj24HXZSgAG6M698UuI=;
 b=jLds+3qSYUKX2sFBgXLueGkInUdDUOVNS1NpxHadvj3s0I5EYnDzDtDQUQq3JNpmkBaaqdm1JCEdD2kyMIkYbH4fS2vpt1s/0dtNtdBkCi+FzEqunC1D/WRXWkV4unsS7A/VI1101F+51k5Y43IfSx9GM43fB6BqZ7yhtrX7wfWoYL5YEo6QcFTM/J4BkK1xKQIP3TNzAmBChCL3qOCDsDjEg2qrEJhDqchcWp3rZ50tRKqdno852e5mrUaHuuhgvuoQKCi8bpudBdnXlAjHqeVpzqKyiu7tahRkQduCiPRe08z7u+d1cK+m2olZkBQvqZipyfTiX5p9y3mHuh2b8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpriMlHAiL2pyNRwLp2es/eHaj24HXZSgAG6M698UuI=;
 b=L9YFXjmUXMFC8NOdL94OIQou/RdMRFAU5jWF769btxUjiFrH0N7UFmX07LJzIWG8go/VbYKkognxf0zlV7fA8Cg8vE4seBxEhJCYTkLLlfqfTkS9mpr0Ag2UFchrLrIxA05LkKljvIp4kr+Z7KuygbIBqvKXDANpPn816bznB2A=
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13)
 by DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 01:30:17 +0000
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::44f6:d489:435d:a03a]) by DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::44f6:d489:435d:a03a%4]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 01:30:17 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: please clean up the soc-fsl tree
Thread-Topic: linux-next: please clean up the soc-fsl tree
Thread-Index: AQHYcWO4rzsGKNuwp0uVRPc8dsAEfq0x76Uw
Date:   Fri, 27 May 2022 01:30:16 +0000
Message-ID: <DU2PR04MB8949398C0EA9FA9F0911B8868FD89@DU2PR04MB8949.eurprd04.prod.outlook.com>
References: <20220527105003.1392a238@canb.auug.org.au>
In-Reply-To: <20220527105003.1392a238@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f8ac45-6134-48f8-d0a3-08da3f80749b
x-ms-traffictypediagnostic: DB9PR04MB8477:EE_
x-microsoft-antispam-prvs: <DB9PR04MB8477AC88A58F19BE23D2C6158FD89@DB9PR04MB8477.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vPbfZZfYmZU+Fq3PgG8jsmXjYdclvNi3jX5odSdSHlkGr0KqOr7mVuP+tH3P5TXMfIqdwBlDxi8eHelJfAcQKFG7DQfnhwKJzwM7QrJJCZ1Pe3t0jsxs6zKtc6s4w+UEsCFbt53ZaCQQTj8Ppv7pCQ3Qj0MPIm2WNw5pGWd7LLn56xGDyg/ByTQjz++XGj9XOCDSgHZogV4H0A6fDkbXmfJPGHOafe8FCNAtfLU4LzJmC+n6K1KK6YeiylBxcFwiDt1svi+jQ0rNeLAQZYZX0/v7Sk4YiP2m7MkKfqdoDwoEqDVUjh8hLGsYfPzPnqu/j3JE2Ofa1nMGtcOs7ytlQ9UBVF8nL2RcFKJHDPe4eUyQkxa454x8FKW0CRI19OBbPS6q2dY/kzLYjOIWN9/evZsz5t8QYb8FpgNB7KpndREi4zEY4oUs9xF6hoePVvaH6FVXKbBCKuRRHZnf39k3n17SGL9AAogMyOeGoPAONYfdYklaMIVCq3bMdy4wkMiW843p4TqkDXj9G+bRc4gMbbAEv7vfNZQdHqk76aLapT1QxVG9PfkwA242mxSVGajGfCIlpId0s/QHm7ete/0jAj0FYjbm3fcKnlw65y2E6oR1GU3lAVCkVBP9fWfgvVRHIrt91bYlX8aOhdqLLCmLYY79Klc3DP+jNNwC1L1I10R9i38FOJpdmEt1xwuprEu0QJsANZPyiod0qE+bdf1Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8949.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(9686003)(4744005)(55016003)(53546011)(38070700005)(316002)(86362001)(4326008)(8676002)(76116006)(66446008)(66556008)(64756008)(66946007)(66476007)(508600001)(5660300002)(55236004)(8936002)(2906002)(52536014)(38100700002)(7696005)(6506007)(6916009)(33656002)(54906003)(122000001)(71200400001)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LICtBQz6qyOOXOJGUi4WMR1l2cqf8mckARMfvcVa1hbu5sL70Lg0VByNqYMN?=
 =?us-ascii?Q?h6Mv0VKTHSvDrBKzmSvtJlk2zVT08apIxYH99gjV966TB/VCLZ3/BIi30ksw?=
 =?us-ascii?Q?kx3Xb+NWyVqpbFnh7HFFkrBhLbkejasnHpxlr3s9FUvuq5mGHo12YOBNsLuW?=
 =?us-ascii?Q?eAQQcBzFxwS7ws8FVhCpaFNfvvHMjl2MOmHDEbMyYelbtLq3TokIuTtyOyWG?=
 =?us-ascii?Q?fAcunPWSR63pNvVv6j4AJ1YAG5uA/njWqdQPxyeMjzTZYQa/OT7+fKyS/1uu?=
 =?us-ascii?Q?Sa+TgHpyzJVge40tHEn9ByO8yypz3H0gt7Ly0YBVo4u9dGkHOcLHIAJPsgaS?=
 =?us-ascii?Q?wOLcwVvN7h5f9W/oZA+EOTEcB92Sjwa1lSZUI0BlC+jZC7ufBTH74Z2LNbOz?=
 =?us-ascii?Q?SY1IV/cKkbV4h8KLYG02EhQ/QwpJg040T8yioSzbDO9G7z4AuDuhNOyqWLEG?=
 =?us-ascii?Q?dnn2L7jU5mtx+0ENccjnnLXtvXVvjnm2wP3wrYPPcLjLAc7WSy6CEAYrdaIq?=
 =?us-ascii?Q?M5NXPdFCiFWVqNZRWj4bva/G3K6wNN1Uak0Um/UJLD+3/ZzzNsCEradh5OH2?=
 =?us-ascii?Q?Vxvs+4LrYeF3MK+2kln2F62Lx2vokm8NC0RBCVokspMwJf/9MmG2k3cGfosK?=
 =?us-ascii?Q?iQAl/SOkOhzNqpR/+NECJjZ1oPKQMXVuhk8i48ZwR2mLg97q2+7L/+3dVxV1?=
 =?us-ascii?Q?P6/hD4eU5JgbrDBrQFdJuF+6eCM5eep2am8/pi9aoFMpDFIgF1cR3xAEpQ0y?=
 =?us-ascii?Q?8R4cWtTsB+cGQY//nD3trfg7mz4izLABJ7962QqDe1GWCrM5gP6YVq96IY56?=
 =?us-ascii?Q?vj24/lES7XOL6A/eVonkyoATpjSrbW5M/M/UsKL5phCkWPK+VnxGo0f6T4Ki?=
 =?us-ascii?Q?OXqh1/vRPBSzgNKTaV3oeidoJZ5O9xWMaiqAdUgQwh+e4ZaDliR5yiDJ9BHG?=
 =?us-ascii?Q?6FECGvF5lp+GxePVFYVzv8om5KjNHb556m3YxLaNHFCpL3dUHoMAXras9fA2?=
 =?us-ascii?Q?y+m3AB88wufchWsLDEHcAxxChavA3pIQIuI425gu+Ut5mW7pXFhOsCCIF4DU?=
 =?us-ascii?Q?UwriZ3fw1sCLLlReZad9A4gMHFDdi1HVpIWftV98xMLxvAlsWzDfTcdDKY+/?=
 =?us-ascii?Q?uFlfhfQPUbPtNP4vpkdHb9QPHVu1zkYMaumxrzwaEfXr35szLESo0+XcPFCc?=
 =?us-ascii?Q?IwQUsbL3uIC2sWKDICm86vp1PihLN/mXJFPWPqiDjx8TgTL/c481xJDl286H?=
 =?us-ascii?Q?hFvIUhKEheIpSxWYGxRgfjeIy/0jlBPe/dXiFQy8r0PwiwrV0jopVhH89ZGk?=
 =?us-ascii?Q?gGqgrb6PGUK+1ssR45rMCPdhtcwetVyNxJE4/Kpwodd8w1wREh/48gDtYAVJ?=
 =?us-ascii?Q?wQnTCJiAF6/4jsD7WxjGwWX7c3W14E0nZRB3dS6qB8f150hB3zXdA3nP0rfG?=
 =?us-ascii?Q?M2JtlBWw3S0oKB5jjVxoxrlkuLyDgZpHx5RvM/6xoVkESZCE5sR3Ouh3ti39?=
 =?us-ascii?Q?JwyUCdMBFWcVh4isr25rdpdcabVc3T9zFrvF5gykH0xnToZT1NE+UfoJQWsk?=
 =?us-ascii?Q?ZiKQES2GC0Q4sbzeNDoIcBz2FSDbtD+juDhMAZsgmzTVk8xaVx6wK9Rzkse3?=
 =?us-ascii?Q?B17muWMa5jDLFPBLmGfuSN0xpIu69NREl7ENeJ78VENJqmID5kwOYAML5hn7?=
 =?us-ascii?Q?4wyweslzFt5yr070VmHc+p4UFBe6QdNCx5oxkkFy/ZaBM3qyluGS5WcOrklW?=
 =?us-ascii?Q?MMUeUshS6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8949.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f8ac45-6134-48f8-d0a3-08da3f80749b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 01:30:17.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvT4MfhPpayDf3Bow4OhtUB6k/lndi9uycenLYSHvFjR6K0vwMc56z5ezLpED54j62PS0kHIis2GF8yyfA+XFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Thursday, May 26, 2022 7:50 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux Next
> Mailing List <linux-next@vger.kernel.org>
> Subject: linux-next: please clean up the soc-fsl tree
>=20
> Hi all,
>=20
> The soc-fsl tree has not been updated since early January, and all its
> changess appear to be upstream (though as different commits), so please
> clean it up as it has started causing conflicts.

Sorry for that.  The branches have been cleaned up now.

Regards,
Leo
