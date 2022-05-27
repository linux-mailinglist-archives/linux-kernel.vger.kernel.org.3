Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE453593B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbiE0GVh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 May 2022 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiE0GVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:21:30 -0400
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5A2BEB;
        Thu, 26 May 2022 23:21:26 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 24R6KuDk012337; Fri, 27 May 2022 15:20:56 +0900
X-Iguazu-Qid: 34trDeo70RkrM4jdwE
X-Iguazu-QSIG: v=2; s=0; t=1653632455; q=34trDeo70RkrM4jdwE; m=Dj0GaWD39d4HtlvCC/1obBuGg3SVuLBI7BFjToPu8DA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 24R6Ks4n019063
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 May 2022 15:20:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in8VhaCaLyT9jQQGNt/DQsn3Wen0Gk6LrhXQ0MHeFevXLXkoxMkS63ni/jNGhtvpvFirBX9GQAha+fHIiCQ8sMLQCAx02PzSCP88UJtiLkK2Ge4DDqLOXVGpZy1iyCw9eo/VKgLTrR0VWU00OC+/Q190x5xXJfa0lMkEvOzZcjljlWU9PG/fYAsrHa6vsApj4Fr0mGuIlHhsTvi9S50+0JiQQjPgd7ptRQlwUFUGiOC9CDkXQpBqel+arjLiIJihFZF1EJrdlYmRXcfHD5u5ubZQyV9XWBE9OABjC41IR43yvw2urw1JhG8sH/FtgaHSARQxHM9r9RQLo6U8IsvzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot2eIOzGt+J4ZN0QxIm1X5CBQgjAs2JDclMOxpH0KC4=;
 b=E2IzsmjIborfjfTopYQ85g6r/CBqWMt3ch/Z0ganxYk0lMDjocSqu3pVa1iOqbmSHDMGK09dDQubAxiqLvi3OItnh32OuI8u0l5oVVeXpe802sXrC3K3CPfj4M8SHtWqpHbHozOyWOzUfIPUMJLWlWliINAZeIukENZBDAz1wGIEqgU6XE5SAzHpnZmcjOyJpD1oy6sNAwCsMR4auoanWwYLi2UqUAQ/DAwnKl6nhA9jKKTDSTn8cSQqfl+BR3ZPng9RuZ2Knz128mOqW8ecVVdK7iQBvkwL5Ox9iYvzxZOLlJA1a4j+Pea5uThcfhCPnqYZeUuOJFK++X2BBxnp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] arm64: dts: toshiba: adjust whitespace around '='
Thread-Topic: [PATCH 4/5] arm64: dts: toshiba: adjust whitespace around '='
Thread-Index: AQHYcUGstuh17vVrdECO4INqvR635q0yKHyA
Date:   Fri, 27 May 2022 06:20:49 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94205D3C70257E28F691D05C92D89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
 <20220526204606.833054-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204606.833054-4-krzysztof.kozlowski@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b644b8e2-18fc-463e-3fe4-08da3fa90b77
x-ms-traffictypediagnostic: OSBPR01MB1765:EE_
x-microsoft-antispam-prvs: <OSBPR01MB1765468A2CE6997135E7308A92D89@OSBPR01MB1765.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtRZcLSBWHDw1ZamOkpLzjxLXM5zAACB7bxxUKpvTQX+jnKqgkoSi2Z3iT/37ttNcwTkpOXU+pNRo2VqMAAUp9w5qdIpSROjrtlJ05WmZkxp2Op94A7DjKsfdanpMwfAwknsXLyL+vFg0AF60r2kz0TLIcuWz84rBDxVrVc4CSmF5k5WKBKqXZ3gzEjGJ/cWXTd00v5AmeXSMfkghl4qG/T7x4QgdWYTY3i4Jqh3zOi7elDQl8hILwplGuHF5Ob9Y8XqyQaYWXuTYb6nNXmqLNnPdLSq4rEkV2/zkztk+eEBYK0WA5mqp+kcga8i/7szzGLpjhn7HtER6veyjZlgwVkgsKewTTAvBl3wOO/9hFFF/2NYVldoGkpojTXZ6UgwxbmojfLUjytXKZ5B88+KgEZvOcMxzBSEKadDVHFxre45NU0RLKjkR3OSPjyYtXxw4YmJXiDMPD/py4vjdAMtXCQ+VI9CctaNBeDkYABudNDSR7hTXjPHh4WbbB+yQa0cbb1KDNblHSIiL80iXcPBkHDzLI7WRXFQtd9fU6i6Q6h9pAYXASTmG9mlKzAy6jMVxoOHLGFuAMUD9KLw5065fSL1jqFtRU5zfeXiDKrwwxJp1CqkK2LG4NKpFksxJmOAeVDZPJYW1LzUJ+VMBpvMh00Lzj3dPtrYP9y97P/TD2pww200xhtpyzPdGsaQMO75yCCP4Z+0916MYjU+WVHuBfcVueGjoAQlL0pQh0ZdW24=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(8676002)(38100700002)(2906002)(110136005)(55016003)(86362001)(33656002)(83380400001)(186003)(316002)(508600001)(8936002)(55236004)(53546011)(52536014)(7696005)(7416002)(9686003)(6506007)(5660300002)(921005)(66946007)(38070700005)(66476007)(26005)(66556008)(66446008)(64756008)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Rk5ZakJiNGN1amZEei9ZN0FMS2xjTGtsT21sU1UwSU5SS2ZFeSs4bUdE?=
 =?iso-2022-jp?B?NjNFNUhVZ0pNNHpGRFowZnBkZGdnUVZlK0dlYkZaVStrL09SUnpISyts?=
 =?iso-2022-jp?B?RUY3M1Fwa3pBTjdySkEyYllhUFpnVkM5RzJGN1Ztc01IZjVjVHdDbWwy?=
 =?iso-2022-jp?B?dGk3RkdlSk03RmJPOHRRb2NrNU9OMUhid2gwSHBPRHlRekVDbHJURnAv?=
 =?iso-2022-jp?B?ZTRJbjN4czNnb1F3U3lrcDNxZjRFbk1GaW96dHM5bGREQkM2U05jWkpj?=
 =?iso-2022-jp?B?WS95RGN5Q0RwYXdCaDJDLzVOdlhQaDRUUy9IM3lid2Q4bjJ3Zk0yQWVU?=
 =?iso-2022-jp?B?Y3l1dU1rWDQxdVNodFlhSzRYcUhKV0dkL3NleVdIcFFqK3AxYVM1MFdM?=
 =?iso-2022-jp?B?VGNCbVQ5bnV4YkhiNk5LYkVscGRLbmdhYjFMNG9GM3JiRGFqUzdseTJH?=
 =?iso-2022-jp?B?T3hOWXk1RGtDZWhkVDRsdzRIeUl5L0JzV09VUGZZSUErR1NsZ1ZNdCt2?=
 =?iso-2022-jp?B?L0R2NFVpUWlMU0pvdHJRMUlNYnkrekg0c0hLMGpudVpkOXpwUGNManFk?=
 =?iso-2022-jp?B?Mnh2SkozVGxIV00zbmxtUS85bStZTkVwczJyc2JqZ1NSdktyWFZwMWQ2?=
 =?iso-2022-jp?B?UW9IQ0dkR0dkVnVvVkpnaHRmbUg5ZUNJL2N5dkh0TzU3dHBaVE1hZXYv?=
 =?iso-2022-jp?B?YUFHMHVLdVJST0F3TWs3V2crbDUzaVRtSjExNWlZeTg3dkpMSnprb1I3?=
 =?iso-2022-jp?B?VUlMWTlKVzhpL0s4M1JvV3hGRFdheGxKUHNodUV6WUJFV1VjSnlWeHFK?=
 =?iso-2022-jp?B?dDVsVjlQUUlwcFRXNTljM3dJbTltVjU4b3V4L2NMWlJHQnJqOUMwbWZ4?=
 =?iso-2022-jp?B?cmsxWDVJNDVBMWJwbWtsNEtNZ0hVdE1BYmlHMjVhMml4ZnlFbXlXNEpG?=
 =?iso-2022-jp?B?c0paTlBabjNzQXdLSE1iUVRHYjJ5b21aVXNNdHBZVlZvM0dCdW1rOTVv?=
 =?iso-2022-jp?B?QW12Tmd6SmJoZGR2VXc1V2M2cmFPVVE2UmQ2U2dlT1VtSFUvNWZuM0V3?=
 =?iso-2022-jp?B?UTh0ZFlnVDZvcmQzYWVtWDBUWlZ5NjVobXpqY3ZsSW1VZFNiM3ZMZ3JI?=
 =?iso-2022-jp?B?MmZBQ1pCeUVERU5vaWIxQkh5U2xpQU8waHUwbVdleXhGK0NxQUdtSGxm?=
 =?iso-2022-jp?B?TnhsZktkMmRoL0hEYXFGTjRFZStjY1hjdFFydlZ4WUJxUm5YSHV2R1c2?=
 =?iso-2022-jp?B?bHBUK2dIL1VRc1R6OW9FeG9FcUF6Qzd3UFdtM0s4SFpWOGl1YVhDK2pX?=
 =?iso-2022-jp?B?MHZXd1FZOHVKRmU1YUZJVEtVOXlKRm5wM0hTN092WWxEU3BkK2hUSGRl?=
 =?iso-2022-jp?B?WGthR0k0d09VQk1uSHhGbHFOZi9jYlVCZXJKM1Uvd3hxcWhRSjJmZ3dE?=
 =?iso-2022-jp?B?VlJTMyt2dXBSTFdNY2R4b3lib3FZZWpzYkprN21Wc2s0WTM3MlZ6blRS?=
 =?iso-2022-jp?B?V3VQa0NkNG1mT1RwTDMrNVRTd3pKd0pXMmRZcEFkMnNDWEZ2eGVQbzZj?=
 =?iso-2022-jp?B?UFgvWms2T0tmQVJlN3RlZUwydWpRdDg5czZyeFlzZ0hRQ0Vrb3NaYWhT?=
 =?iso-2022-jp?B?QW80SStVNHljazRmeHEvSUlKdEkvRjg4WEdNUExoUDRRaDNuREZRZSs1?=
 =?iso-2022-jp?B?aThKNHdpK3h0N3ZPRmRKdTZPUTFRVHVidVFrdTh2d2xRVzhaUnJYMHdK?=
 =?iso-2022-jp?B?bmVRMmUxakhXbXV6eU41VHQyRW9iSjJJbkpybm8zWGxVbDltOHk1U1gv?=
 =?iso-2022-jp?B?dUlaZDZXWUFGc1JCcUd3UVNWb3N5UDJFeUcxVTVJMWJFT1JXUDhiNHN5?=
 =?iso-2022-jp?B?eW9pdjJUaGczSFhETzhuU202ZnJ6VzFyT1ZXN0xucXNZV0R4SXFna1c2?=
 =?iso-2022-jp?B?ZXRFWUJzeWZOL3Y3WG1KRlh2VWROaTkwclZsQnMzOFZyZS9pbWhuekhu?=
 =?iso-2022-jp?B?UU1sZHg4S2lGc01iSjNuZE9qWGpVajRhcldUMy94TkxHRXJHa2hUOGJq?=
 =?iso-2022-jp?B?bXY5akFTK2ZYejdBTGJIcWk0Y1NVTjVVSkxENkpoMkZpYStqTWhYWmZi?=
 =?iso-2022-jp?B?SjhETFc4SzUvaVZkWE1vZXNTZmdHU3gzWU1aWUM0NSs2VzRodXBDZXYx?=
 =?iso-2022-jp?B?bE93QXRXNUliS050bitKL1JxMUx2WVNMclllUXlQbWRIY2xhdEVrcVdi?=
 =?iso-2022-jp?B?VCtFbFVOSlh1RGVEMTBIQXAyb3FXY2VBMkRDZWNVRklPZEJBQXU0emg4?=
 =?iso-2022-jp?B?Nk50L3ZlZWVJekgxbnNHOHNlemxyQ2Q4VitHNTFNTEZmQ0xrQ0drbkJ3?=
 =?iso-2022-jp?B?R21PcUx3MnJINllYOHpHNHo2TVI2MUZWY1pJOHJENjMxV25BcnRMYWlO?=
 =?iso-2022-jp?B?UHNSMDkvL0xCYXoxcFhnM3VGS2xhaE1ZZ2hXRGdZNjNpZVMyYlNSOUV6?=
 =?iso-2022-jp?B?VVpwU3F1MGZuYXN6bXdmVzBxWi9BMnpvRlluR3RwUWdKT1dvUGZpb0pp?=
 =?iso-2022-jp?B?enErcW5kYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b644b8e2-18fc-463e-3fe4-08da3fa90b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 06:20:50.0109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL8GNC07PhcAd42gxTs1Bdu2DYgl487fEGpAaDZiZm//AjnfbxI73hlUzkCxI2ZCCEg4y3wC42CGKphlWhK8v/5mrdhVHxyLzMqUaiUY+Dq3uhrpKR3tOvtmJI3vhM/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1765
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, May 27, 2022 5:46 AM
> To: Arnd Bergmann <arnd@arndb.de>; Olof Johansson <olof@lixom.net>;
> arm@kernel.org; soc@kernel.org; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯Ａ
> ＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 4/5] arm64: dts: toshiba: adjust whitespace around '='
> 
> Fix whitespace coding style: use single space instead of tabs or multiple
> spaces around '=' sign in property assignment.  No functional changes (same
> DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Thank you.
Applied on visconti/fixes.

Best regards,
  Nobuhiro

> ---
> 
> Output compared with dtx_diff and fdtdump.
> ---
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> index 0fc32c036f30..b04829b3175d 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> @@ -485,7 +485,7 @@ pcie: pcie@28400000 {
>  			      <0x0 0x28050000 0x0 0x00010000>,
>  			      <0x0 0x24200000 0x0 0x00002000>,
>  			      <0x0 0x24162000 0x0 0x00001000>;
> -			reg-names  = "dbi", "config", "ulreg", "smu", "mpu";
> +			reg-names = "dbi", "config", "ulreg", "smu", "mpu";
>  			device_type = "pci";
>  			bus-range = <0x00 0xff>;
>  			num-lanes = <2>;
> --
> 2.34.1

