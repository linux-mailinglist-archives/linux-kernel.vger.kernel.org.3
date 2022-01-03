Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD348317D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiACNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:42:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60434 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiACNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641217361; x=1672753361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oLB3D2NU9ELHHRvc602tyU70abtXts+eFsaPpj3xsvg=;
  b=1EZ3LdKvoHmrkB7AhhFgtBsMtc0YReAZW8co84NC/wUqwSSWUcaspL/N
   8lI0k4G9MJ3jC7C920/0BTM9kDV/ATK2AYc3EvCjmGDNsfpYJffYFpD5e
   hoJvbgso3jbrsTFJa6zeUbd54+041UxB/jG8RVdQTVQ+wGyD8BXWlJZ8E
   gbm+OqytIi/3BnUT3uHIZqJttyYj2tVxEG0f/cqQvn21FdvF30fxS/x9+
   ejCmTe/sNM1WBM4aaA+FqiFofi+W+vkaRhLJXjp2nymy7uSEFT1j8QS+r
   CQzZWRQtSkmpz1s1dHuBiSeUwlXFEcaEaMzikcbeXYdQoCkpoQ2finplO
   Q==;
IronPort-SDR: N7YUaroiF2ElXAwlrijpHm+MWmzfam5no9Ly+ReBZl8hEz3+K11lgoalQw2AkISGOR8IHU2IBl
 QYH1dIAZJyrdSQEH+0GpDuIKFqTzY3nGPUgyYI/F3OIvzAhTVzHo6vKLBQgRPD7R6+37b6tu0k
 UGAUcr68SWp/oX9LK7B4w6c0j4eeWzLbozGTBA6p2sIc9HHsmvMdpALg3h3l7OJDuhb4LMmDDz
 PmAnawNSZolZsX3XrUoovB5B2JEhIiwZTYr8zBminyuKi1YWw9tTBZ0lSTcPT5OVoH7GUSRNiD
 UaySdEodriKyxSdDoNxf7jSq
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="157330065"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2022 06:42:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 06:42:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 3 Jan 2022 06:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKYpsVnntvG6lvOGXa3MAjYrqPv3J1A7bXo7/Wgy/V0GeLIixKsHBABhzUzhkveKMPZcUQMEJkpGJBepGadItWrXzikly8OrmMxZtKuzXRPDUdxbeELCGJkKCWPtAS98I0a6T+ezmvFWqocAEOHqkz+YUTZMsM91FvjOkheS2fv5pNxyEhJ9+4Ut+lUai8LR/SBrlMvF6HTS/PBF4Azm7ci1HB64XvQ9vQVGekrLqZh3avqWZY9uoDB1O/yNluvL5URgpTieoM9g7qC8YUbpO+RcGKRCI7l9bZLmgrQxeANcwphc5VGOra+4yHNacRSL8aKX9G6kCrE4KDH/yKcEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLB3D2NU9ELHHRvc602tyU70abtXts+eFsaPpj3xsvg=;
 b=FnC5Tc5rRBudwmTdSvQAr8T64wecFIy7mDblY6BkK8vCr9EdSuf2wxE1bvBMsZqh/Cb+hR9S7AqD5hRRqqz5eNO8iP1wVed6wUr96QP5O8GAvqyQy15+7Y0D6U6bt9cuYOv/mjVcZPfEZcIOKX0ihfIEdwJztAxW68T7056Hs64OhGQhMBx7bHFxCKnm31H7WbeYrXo/xmUj34T3392YnrV3PoVXkR0T3MOvM9vnQY1On+lDIXUZdvhzaQk0thcScX0c+o86chX9VcSkoBW+s/nDkAwHIFCSofEZCrAKYS+QaUt/srbaTKov8l9mN8uAWjzopX8V2BN4lPRmoCpFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLB3D2NU9ELHHRvc602tyU70abtXts+eFsaPpj3xsvg=;
 b=efFxmgvnbqNTDdoDevc85Q1PASimQu0rrVaFtxZ1zVRgumiS4yEdQ0nkkh2DgJPj5o3XeY165R6v5AYJE6s2XcVcJzHkjmSIRCuBZvcFmjOnxp1UCErGIbNXTev0W6pLiQ8VLpGgdt0ytSpKtOxXi1nXN7itgHPl1WfzvAN5RoA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2944.namprd11.prod.outlook.com (2603:10b6:805:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 13:42:31 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 13:42:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <arnd@arndb.de>,
        <olof@lixom.net>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Manohar.Puri@microchip.com>
Subject: Re: [PATCH] ARM: dts: add DT for lan966x SoC and 2-port board pcb8291
Thread-Topic: [PATCH] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Index: AQHYAKfBxAy1YVWf3k2O2unIgNc+5A==
Date:   Mon, 3 Jan 2022 13:42:30 +0000
Message-ID: <76804bd6-00e5-02ab-59df-d32586a55422@microchip.com>
References: <20220103124857.24351-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220103124857.24351-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b55664c-ccdc-4588-7a42-08d9cebee3d3
x-ms-traffictypediagnostic: SN6PR11MB2944:EE_
x-microsoft-antispam-prvs: <SN6PR11MB29445AD8F69B9BDB029C3AB5F0499@SN6PR11MB2944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4Cji4Xs/7HL+esj2F5tW9x4WhO9CB6zEfGlwCbqg31sF6EV7UityXTOTkFpZ9z8aDBWVzYXJ9FYjvzkNqpDVPN0F/0+BHCknxt3mIwym4Bd0JiKfDibjRtRa/aFa4w4pjAn95lcO6Nc+9mTjtEHCKJoG/x+iE3f+eTXHAsk3AzaqoOoBf8jymtMbLtjjSvsTw6jtF3rahSIRD3ChvmXnenRtlDDgqBS4YV2s2vOj987XuzlJmod2KC8dkxBGCSssIjBdMykZIBG8oUpGammnWv628yIv4k3ROoInKuC4adrCno7hr9Yds07EmEWK75aWEPuZ+aUXiXJie3hLGjviva46N8DARwxa1J0uBZOGXOPZwzzTPhnwwQrdvK/Mogm3vZyj5hoXVtYTnmw59DWm1R6JcXI3FK0t46z8Ao94zKHFPmC+vf3oDtTW5X5XdJcVXZU4DBnkxok2n8LQFoICMM8VP8eopIXhcAmlXYL/jMA55Be5pwYNuA2a0/E1mtX5jOrVjTItmhWDFwUBEKis8vJp3moNJ1ZnnCXnyrkeF5R+C96LuHDSuERDNTshCagnhzkryTpHibSAuFzi9VWgyBF65kOBa2Hw8Xnlrwyj967OkcGmuaP0SlOdWKDERH8FFVu8Ey2Xkcp4sg4zhSzwBWBMEca1F+/IrzrptGHuIYcQZSfGWxlZX1fua+BB2aL+E4CI3VQiZN+qef8P6mqkoasX9GhCRk0nshF7osUvMu0sD2VpSHb4Au8U8Cs3lOtN/Dcv7codHnpdUUsFTQLtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(4326008)(186003)(6486002)(38070700005)(71200400001)(36756003)(316002)(8676002)(86362001)(2616005)(31686004)(26005)(6636002)(107886003)(53546011)(91956017)(64756008)(6512007)(508600001)(6506007)(76116006)(66946007)(66476007)(38100700002)(5660300002)(122000001)(110136005)(54906003)(66446008)(66556008)(2906002)(8936002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akU2Z3FuQzY0RGhFc1VSUitnc3huNGhDVXlpZis4a21RMUliUDVqcEJ6aGsw?=
 =?utf-8?B?ZFRabGN2anZRZ0ZoZWw1YjFpUG0vck56VUZZdzJlTXBLVmtoSEZGWFcxUjlX?=
 =?utf-8?B?YjkxdXJNNlJicmg1STZzSXBtblBGWHkwZmdMT1E1ejVDd1BKQ0R1UFNHcURS?=
 =?utf-8?B?QkUxZUQyb21NelpBMzFBejYzS05Kd3NxNW1RYmZTSllDa2hvWE8wUWhJZmR0?=
 =?utf-8?B?ZVNXdFhmVk9kYm82ZkVXejNIOHoxN1Fqem1OaHkxaGFyVjdwdFNJd0U2VTBS?=
 =?utf-8?B?T3RwNmZQelVUTndDTCtzQWlZUlVaWlplZ2JsaUplbGg2Ui9oNldrNTdMWFk1?=
 =?utf-8?B?Ui9aVXVhNDFLZDZCVGY3eHM0T1B4clZucWlMMjBFZlN5U3g2cEVQYkc3S0I3?=
 =?utf-8?B?ZGZnaU80TTYzd3VaQlZTYTZadFlkWG9lZHhmZzVqdDl5bUhveEx4NE5NZGNH?=
 =?utf-8?B?OU9OakpLTmZoSWIwUVJoNTZxVGtyT3JMb3J3QVhkTDgyaHZUVmVOOXprS1d0?=
 =?utf-8?B?RkdxVUhGOGk5bWtSUCt5M1EwM1dEQ3ZJMzVRTjdxRjFONUVnNHM3aUlXcDdT?=
 =?utf-8?B?N0FEV2VXSUgxaURQQlJ2WlpwenNZT2xPZW9UU0RBWTdFOUlZOVJMQnhDMW4z?=
 =?utf-8?B?UEZ6SWdKMVhXOVFUUTBWdXJsZCtQcGpoSXZFTVRmTms5R3FmVHNaQk53RjMx?=
 =?utf-8?B?K3JuUnl2U3VJTXkzN1gxK2JvY25oRlRoOVAyOVZZclJ0ODMvQ05keHNyT0ZB?=
 =?utf-8?B?enRGSHpSUFVZRWxVVE0zV3ZUK0lvTDhtQldRVUpDcGFmQjdEVkxqcWNVcHBj?=
 =?utf-8?B?SXFBcVNiMVhIVzFiYndYWU40cnhWV3htNG5WbVJoNTN4aDBkUEJ4SjBNVXRU?=
 =?utf-8?B?T1hrcUI0OGVsUnpadWhvLzhUa3BQbGpsVks5eXFVd2FvdWtaZmhiYmNoUDRv?=
 =?utf-8?B?T05XUUQrQkxhUmN3Um5BTlZiN3pWKzVFOFZoM0x0bzYwVnQxWThmSFgrbzU2?=
 =?utf-8?B?bkZXSU9ORHJRdVZuWTRtekFiMkxTZGpqY3l1QW1WT2ZWVjVrVjZaSDkrcGRV?=
 =?utf-8?B?Tm9QbkZLNGJZUitSbGVuWldmQjI5OFJwaGFiazJpSGl0eUxtcnRSenZISDhH?=
 =?utf-8?B?WjBBZUhSUmg5Y0F1QWc2VWY3b2J2RzVlbm1zVXZUWFFhNU1KSHNGRDZKVnhN?=
 =?utf-8?B?MWVPVFg2V3dVTGVBMUVlbnNFcXowVUZJcFJKSFdrdkxUbk8yTDJBd1hwU2hT?=
 =?utf-8?B?WGJHdERDa280Tk90dW0wK1FTQzRyKzUwYTc2VVpoK3pxWmJ0SlFhK1hXTVE1?=
 =?utf-8?B?RDBxdVlwbnZkNDJreC9Gdko2RjJVcFRiZ0lwaUlDcEdIb2NsQlk5S3J0d2hN?=
 =?utf-8?B?Ty81MEYwNXVSck5Id2oxVEkxWUxEY3diYlk2N3JnLzZuZG1RQVB1RnNNMFM0?=
 =?utf-8?B?dWRaRFNSVCtuUUVHdzRKQ1lxZ1R5Q2U5cVRwd0pJR1ZVVlpjWWxTMThPTG8v?=
 =?utf-8?B?aEtKWHBHa2RZRFlBZGlFcXJneW5sMEN2ZzNZd3NpVk9zbnFmNGQxUWxvZHA5?=
 =?utf-8?B?ZVcvWXlpazk4bDdxQStTaW5MRmpnMEQwTmE4ZUZSSXJFNUc2WFFTTzlSUElD?=
 =?utf-8?B?MnJCWnlBL0pQUnBIcmVJMWR6cHhZRVpRMGhqRklvSUVJSisvekdmd1hJcGFh?=
 =?utf-8?B?aFdLWk1ROE9jSVBGVGc1UlVLcGhjSXA0U0tqbjV1S3AwT0dJTXBxZzhkT1ZD?=
 =?utf-8?B?dWdSOWFWTWVKZHdiSFJieTdLbWNqVTdIVmUyeHlTNmNKaTRuMnliRzFPYlN5?=
 =?utf-8?B?VXFPTkg5dXZodGNJeUowV3I2aXdQVFoxZkNrZ0JkSWpPT1hHOVNuSEdvRmRo?=
 =?utf-8?B?QXg1YytmaENLdVdhZUp3ekJLMW1KQ3hTU0lYaFY1ZVZjMm9TczBVTXk0OVlU?=
 =?utf-8?B?MHFyYzlsdmxFRWpUMTdSWlRRZmZGZGE0N0JLRzV6WHNvMWhOOUlZRTR6NldX?=
 =?utf-8?B?Z1ZpeThEYzV3M2syVVh3SFZxb2wwNDYwWm54dE9pZ2FKcjRvanNUdmo0L3E1?=
 =?utf-8?B?ZEFWcXNRdE9rUGxyaDR0WjNlLzV3NDVGQ2dYQjBEeXVVZDdxUjJWN3RIaEtK?=
 =?utf-8?B?NGxPMkxJTlRmdFdjTzlFTGpVUldjRXVEL2VmOVpaSFUvTU9HR25HZHRWSDFu?=
 =?utf-8?B?d0JrMkxqMmhkZmNZWjYvWG45a3hIS2ZBY3Jvd0U0VmhyVWVZZ054YkYrUGY4?=
 =?utf-8?B?ekltVkp0M3lMOVpQNUFVK1pTRWRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D39107EAB28E054F89650A803275859A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55664c-ccdc-4588-7a42-08d9cebee3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 13:42:30.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vys8zmyBwmO/6VpBFXtgJks7CBkfPNYyz3Zgb7pTW5IJOMd4O1Atg+8GlhaX4c7XesZFwjBXTxjEUF9UVnibI57+GFATdwxsiHuoJNJnZFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDEvMy8yMiAyOjQ4IFBNLCBLYXZ5YXNyZWUgS290YWdpcmkgd3JvdGU6DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4X3BjYjgyOTEuZHRzIGIvYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eF9wY2I4MjkxLmR0cw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiBpbmRleCAwMDAwMDAwMDAwMDAuLmNkMDQ1NGE3OTVlNw0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnhfcGNiODI5MS5kdHMNCj4gQEAgLTAsMCArMSw1
NSBAQA0KDQo+ICsmZmx4MyB7DQo+ICsgICAgICAgYXRtZWwsZmxleGNvbS1tb2RlID0gPEFUTUVM
X0ZMRVhDT01fTU9ERV9VU0FSVD47DQo+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiArDQo+
ICsgICAgICAgdXNhcnQwOiBzZXJpYWxAMjAwIHsNCj4gKyAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0KDQpUaGUgZmxleGNvbSB1c2FydCBtb2Rl
IHNob3VsZCBiZSBkZWZpbmVkIGluIHRoZSBkdHNpIGZpbGUsIHNvIHRoYXQgeW91DQp3b24ndCBk
dXBsaWNhdGUgdGhlIGRlZmluaXRpb24gaW4gZWFjaCBkdHMgdGhhdCBpbmNsdWRlcyB0aGUgZHRz
aSBmaWxlLg0KDQpDaGVlcnMsDQp0YQ0K
