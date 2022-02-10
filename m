Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992A24B079F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiBJH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:56:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiBJH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:56:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C928BAE;
        Wed,  9 Feb 2022 23:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644479801; x=1676015801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=avnYxGsaTwqChXzODmH4mQT9rsJGiSLNbcTO1PyuI0g=;
  b=TLY2N6nmO78ArLNVorZbUQid0hZFBoztbQXsa1qNW+YltswRHZloTn7r
   ICAVC86ux1lMJlrpNh7fVnQkMMBm2uZJKERTCUqyW7P2h6L6fFMD1WG1L
   YPvbdodxSHisaZI95T0INvSWfC7PY6qR3bj+F8lDErondSVhLgQjC+Nu4
   5d2SdhvG/QB2dIlyoKPDlfbTAPy0v5W5hX/5qj5DdpDJV8NOdcwwgq+Gp
   FgTDWKUb/xATmZbyxAqijZ9oiTlipUa0LVzDl4g5m/ATUn7SwHQEKvjLH
   9wBKaliKyu66V4YsVx6WhJrHmQb+JoM9Wo7yGNjeTD4PWQ3rbFIDrObGd
   g==;
IronPort-SDR: A1FyH6fDksQs64Cp0DKyrpgtbMgogG1P77GDjGm4lT/bIfwZ8LLH2yniElypG23Kg3dx8fZdls
 H8aXsAyRoRNnlttB8duNzsQpIsVhqn/oiFN8Pki/FZ9c5xfT1jSN6u9ikDTCp8JiSZee5bjTvT
 Ema+8/sikWyYoPwfP+kFjcmIWJSvHqu9VT57ZydcQW6fPEK4uN0bNqPTQIxnLkqBYsoapCIKfj
 aC7ZDGhTdK0vGYGlSgTBlmKVkK6u/uuRM4Zb7RP48rpZtmJOmbLtTa1qX/tslvhpeW038eH1OA
 aTHs84bmdoE0FVMvX8DNkFdB
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="148243043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 00:56:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 00:56:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 00:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEDCVtZZZ1LYomwMRxFH5ujtpI2v5vz8M8efUiyshdT1xKHPLusvOrzvZ9WUO23taMYeFYRVqwtRME85oYhpkDtK6oRmdIWkZPnoq4YIZQXlk2+2b1PcqCJGNMhEI7VrQhpDmTEIqxEWY3Xb3Cq1/wkUGGU2m+Zo5iKAOtBd048ufTE8hJreVuIrqov9Dv0aAo4cQkjmvxkTWX8UGFwfWMhND7r5Et/yEzwyYGVtZq8an1iW6lvnBcD6i3NwD+AKj0L9ZJcs9H434lXiV5KRujfkKHJrxUEgJ+5a1phl4p1nCAR1pdWOLfO3oS8xVNepkjKDapLjEmfhijuahYEQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avnYxGsaTwqChXzODmH4mQT9rsJGiSLNbcTO1PyuI0g=;
 b=fQy2dMuBi4snG8ltava50H07ZbvnTNFqOE/vKRVqoYqxVFTBIA/4ElSw+znf1IxyzI9qVL1jhBrL4Gqzq26/3Xm2NQG9D+hqkv20PQMfd6lxBJ7CSdiMAqbV7XcYJIl6Cj4BOA7POag8giWgrnYz59+oKp5wf+RFzmYSmSqIT/iH2BNJpMJjwdGugrZGnohzEVvU1Vv1bLpLl5fUgy+z9ebevGOSBjAlMGkd3xyljGWMxYMqSqjMIBvt3ALwkOA6Bbh0lPnLdz7ttnoDY1tFHiyOUxdQDfDxa2IshYb17sMaoDo+9lW0mQ5WchB3MA+23RKaF8DTHyRisEVHamxByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avnYxGsaTwqChXzODmH4mQT9rsJGiSLNbcTO1PyuI0g=;
 b=ry/Lm9dTVQ5Xh9w7tPQ987k13IFxq8sV2uRxzSCwyw+xYVfKEnO1B/BPXP1eV5aPJhYm0KNd1TKrTYTBaNbogTWJ/sZyYAGnLLEJ4oyoz0yy0FW15nLf6ScsZ8leMtRD8DK6kcvwpEGZwpk/h0jKq2EOz6Zx4Gk90hMZCDhj2m8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB1861.namprd11.prod.outlook.com (2603:10b6:903:125::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 07:56:35 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 07:56:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Manohar.Puri@microchip.com>
Subject: Re: [PATCH 1/2] mfd: dt-bindings: add bindings for lan966 flexcom
 shared configurations
Thread-Topic: [PATCH 1/2] mfd: dt-bindings: add bindings for lan966 flexcom
 shared configurations
Thread-Index: AQHYHlO5/6RuC3XEnkOug4duXIIvsg==
Date:   Thu, 10 Feb 2022 07:56:35 +0000
Message-ID: <18714be2-1265-9a4d-eaa3-612d7fc03f38@microchip.com>
References: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
 <20220210074546.30669-2-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220210074546.30669-2-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b682d43-51b7-4f50-6aca-08d9ec6adc2a
x-ms-traffictypediagnostic: CY4PR11MB1861:EE_
x-microsoft-antispam-prvs: <CY4PR11MB18610025B96A06A6E81DB425F02F9@CY4PR11MB1861.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: saBrLbliLXptI5/pZmYqom9iEo68R58JFvT7iFi4zrqIMEcA3qOcl3EcDjfsqO2P1IDgaoYITwDtkk0obj1YkXuGkPFk6XCBbohzezQ4ZQ3gK//eiN71Y+i/G0Z0FMn9STPOycu4r47NT5O732G3UtUSd5pNPiXpuSK2ZnXFDiARxO5Tw8wBjroQw0I6fh7PwSbvsDjf7GrcG+AmJElAv3KV2NDDWv1mncAw/+4Jv1lJs3ZGKAj2TUc83/gMR9XwY/9x/vtpJLM/QccniU8F2fduFKjTFxfMwt8IhxUAmAwu29c6wt8Jd520gXZje88/2JfhauYH9DmVKuz+hxYDxK6KV0BkOVpmVAEiCBbP9d18d1aCS0pKKV2totGg+lS9GcWdJtoufUBP49Di1e2qMcNdesU30+vWVUkAEQmZyv1xLY0jPZQlx4Tt8YjKGHFfGPKmWiQ4sXG2uD55IryRzC50nxJe+6DW6UHUqeTRkN8e4JiH/ruayVQOcYXjKsmm3JJS4SpSgkcdY/XeiATYKcs5GcYFHMiiBjmgVtNRUgkcmgcNSyPAt+ehYkrmZRWCtDcl+SYGRDyGMczza7NAfQJAcvBUsuKVgMbhjW/IYKXdFiJs5+xH3WMtBP3UN9CnSj8io4w0o8+nOczZf5valDQHHKieXxfXGMryzq9ONse8ueOtqph0eioc/A/pDx5TfALb8nLOUNk48DxKuninZTyIILyd3YEsCBuMUPcUZKM60IWTn2EZtL2Z9xGjDhZD1P3ty9ed8gZUOGMdfqZzq4ZjA90uT1f01zA+43JaBOqwN7jY+GZx2zwFraZKMxGlpUIkO8+P8/M86GOidznRztIB9l1RX32nrBQCf6U18VqiHGmgYFTAGD539DP9jq5TN7Eizyd5QcnySDO1uEiSyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(8676002)(8936002)(64756008)(6486002)(86362001)(966005)(4326008)(508600001)(53546011)(2906002)(31696002)(66446008)(107886003)(71200400001)(66476007)(5660300002)(2616005)(31686004)(316002)(66556008)(54906003)(186003)(122000001)(6512007)(38070700005)(36756003)(91956017)(38100700002)(26005)(76116006)(110136005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm5aYXVzYkFvcTBZWlRBV3ZUZmtyanRsaytqNE9nTGFocXBYS1p1WmNVQ0dR?=
 =?utf-8?B?bXZ0ZmpVVkkwZXU3UEZoc0dmbmNhcHF4NDZmQ2FPWCtTekRjNm12WTQycjBK?=
 =?utf-8?B?MTNlOWk5bGh2YUs1ZllvVHVMdTJCSE9nV2dORGdmK0xpUVdzQ2g3N01rOVFr?=
 =?utf-8?B?TFlBdk5PaHZ5NVFxYnJrMGY4Y0VCR0RJOTdkTFEyUG5tcU9LcUpMQlZ2MXBM?=
 =?utf-8?B?dmRHRlhNa2tBelJKQitSeEE0cm5vT2MzdCtrTTBpVzJlSFNuelZlWCtnTUt4?=
 =?utf-8?B?dDN1Qm5Hb1pQa1BaeHJ3VXFrQ1VEcjBDR0pEaklnS3Nob213RHNYSzc3L0xV?=
 =?utf-8?B?TkRUdFhyWlhJRWN5NW4yQzJzV2RkWlpwRHJ1Qi9lL3JSc1lScTZRb21RWlpC?=
 =?utf-8?B?Z0YrVlVkNWVXV2ZHOWJzRCtHUGxtUG5KYXRyb0lLK2dLR3F1ZExBSFNpbEU1?=
 =?utf-8?B?Nmo5aUNUYW5EaVZ1SUpYWTdLOWRLMi94eGJuSTZ1ekpGYTJ6VUpUQlU2TEd6?=
 =?utf-8?B?YlhLTUU4V3RVQmlpWTMrV2JQQkFmMU83ZXdVa0EyK2ZPOWUxVXdvM0hnNjB6?=
 =?utf-8?B?ZDhHbHVvenM5R3QyOHUyS1N1TFE4SDFFSFBoUDBjejArU3pneUxwV2hWMDJK?=
 =?utf-8?B?bTR0SkJBWkw1OW0wNTlXK2dIZExUbm83U2N1dFVaTlpRYUNmQTBXaExyZjJq?=
 =?utf-8?B?N0paNmM5a2tOWnZNQVkyVFZxckEvZmxMZmpGTU15Q1B5bzNNSG5SL25UeXRh?=
 =?utf-8?B?UG9mbTU1L2hpaEVsL1ZXa1k2S0NZTDNnc21vR3JrUnRUemsrMy92VlA3cHls?=
 =?utf-8?B?RVBrNjNCck9uK0tyRWdJUUtNSGNjMUUyV2huTjRoYUE4THlUYzZ1ZW1vOXdy?=
 =?utf-8?B?MjdpbkR6amkxVURoNEgwUWd2ekM0RG9zOHdSTGh6MnQxNUJRbU9lYXZhdWp5?=
 =?utf-8?B?NVp3RHZMb1U0MHh0dUpRQXAxTE1aSlY3Tm9hRFo4YVV4UWNjMXdMMjk0dmJL?=
 =?utf-8?B?cWpIci81K0t0aHQ0VlVyd0txZjhIT2prV0pYRkxwcFBjSzMrZFJudEw4cy8v?=
 =?utf-8?B?eTQvSDRaMkt0bFNVeHdhTmFSMHZXaUFPRWZNMjE2S2puVmQ2QkJkeE1ZQ2hr?=
 =?utf-8?B?bWRQUk9EY1d2L3FTMXZJRjhsbjRkZTRWYTF6cUdoNGhpOUl1WU9lSVRmVkNm?=
 =?utf-8?B?OTNrd0hrZExsNTFZRFQ3TFRhVjAyaDJ1VGtoMVNxQkFpZVQxcFhITUVhWk5U?=
 =?utf-8?B?L0doKzRaY2h5ZUVjTXp6OXBTbFp6eHZNenVjZ3diL3NtZWtVVjdDYmdHZnhO?=
 =?utf-8?B?cjVwOTVaRHRFYUsxcGNvdkdXbXV4ZDZtRGdxLyt4TlN0QzZoZGFzOXJScUhh?=
 =?utf-8?B?bU1WVDFRUk1OTm9QMXcxME00NFhrZ29BY3BzRVBxS1F0WnVZVzZWUktTcU4x?=
 =?utf-8?B?Z09lM04vdGM3TkFoSXp3M0k3UWoxYlJkUnVHbXBFT1MwNFVGelprSjNXWjB3?=
 =?utf-8?B?Z3VZSkJ1QUZHa0NsWmJRTEJGcjF1MElNK2d1b3FqRHV6TGIvS2pvay9RVjFk?=
 =?utf-8?B?Ukt2TEFIV3gzUktCbVJYUmMvdFVkOXFQWjFNYm1oS0MrLzdFVEM4bktrOEsw?=
 =?utf-8?B?WllzdU9nbjNqbTFzVjdwcXV3U0dxM3MyYTUrUTIzUEM4N1d2SzhmVFJEV3h3?=
 =?utf-8?B?WVJGQ0pOeHB6clZEcGwxUUpOVzRiOHlwSjgvV1JkS0JIb21EZTU4eW11bisx?=
 =?utf-8?B?UFp1eDhrNXpyQW1DTU5hc2xhZGhsdjhqOWhEcGVWU1o1VEtFcllxcEVpa2Zo?=
 =?utf-8?B?b1BOb1RuaWlmd1ZiYXpobFppc3E3UUsvdmgxblE4eXRTVlFicnQ4dnlPMHpP?=
 =?utf-8?B?Q1FaV1dVTmxvaW5KS293OC8zUjV4bkVkTHBNSE1GYTZLdmdPc2ZqNGRqbkl3?=
 =?utf-8?B?YzgxOEZPUTdoY2g0MFJCUVBaV3JSYkNuUlc5dk9MU2xNWGQycHZFZk41by9o?=
 =?utf-8?B?M2dqNFBENlY2Q2ZDSlQ2bWNtMDd0VFBtYVIxbkNrS0thaFpEcnE4cERzL2Vr?=
 =?utf-8?B?YWcwcmRENDFJTU02SE1hdWltdzRmbGlBbDJ1cE1LcGduaFpwTnZjY01XWG9s?=
 =?utf-8?B?RzBSTDRUaW92bWxySmxPYmNqNU5NVGVVL1lIQVlqRzg0RERzZzNKVHlGQndB?=
 =?utf-8?B?ZWZCZ2cvS1k0bW1BcVRFSGxSUElTZnh3S2thQXE5NlNCQ3F0aFlNUFdvelBB?=
 =?utf-8?B?YzMxNlczMy9aVjZJUG5KaE1udkV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <258640F45DD8C84C9B1C627FDDEA270F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b682d43-51b7-4f50-6aca-08d9ec6adc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 07:56:35.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThZtYf6lQpVH6tWx/8P2sk/n7wcP6TyOV/43MVHPI4HvPCbH+10gL36z8Gcn4jv7/Pwru6u6Vm5B/Q0j/N0iYc882AU9BmrGPyG+O+Pd/6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1861
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEthdnlhLA0KDQpPbiAyLzEwLzIyIDA5OjQ1LCBLYXZ5YXNyZWUgS290YWdpcmkgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhpcyBhZGRzIExB
Tjk2NiBTb0MgRFQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBmb3IgRmxleGNvbQ0KPiBTaGFyZWQg
YW5kIGNoaXAtc2VsZWN0IGNvbmZpZ3VyYXRpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2F2
eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNvbT4NCj4gLS0t
DQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtZmxleGNvbS50eHQgICAgICAg
IHwgMTIgKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0K
PiANCg0KV291bGQgeW91IHBsZWFzZSBjb252ZXJ0IHRoZSBiaW5kaW5ncyBmaWxlIHRvIHlhbWwg
YmVmb3JlIGFkZGluZyBuZXcNCnByb3BlcnRpZXM/IFlvdSBjYW4gZmluZCBzb21lIGd1aWRlbGlu
ZXMgYXQ6DQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dyaXRpbmctc2NoZW1hLmh0bWwNCg0KQ2hlZXJzLA0KdGENCg0KPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1mbGV4Y29t
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtZmxleGNv
bS50eHQNCj4gaW5kZXggNjkyMzAwMTE3YzY0Li5hNzY2MjIwODIyMjggMTAwNjQ0DQo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtZmxleGNvbS50eHQN
Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1mbGV4
Y29tLnR4dA0KPiBAQCAtMTgsNiArMTgsMTUgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgLSA8Mj4gZm9yIFNQSQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAtIDwzPiBmb3IgSTJDDQo+IA0KPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gKy0gRmxl
eGNvbSBzaGFyZWQgY29uZmlndXJhdGlvbnM6IEVhY2ggZmxleGNvbSBvZiBsYW45NjYgU29DIGhh
cyAyIGNoaXAgc2VsZWN0cy4NCj4gKyAgRm9yIGVhY2ggY2hpcCBzZWxlY3QsIHRoZXJlIGlzIGEg
cGluIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIuDQo+ICsgIFRoZSB3aWR0aCBvZiB0aGUgY29uZmln
dXJhdGlvbiByZWdpc3RlciBpcyAyMSBiZWNhdXNlIHRoZXJlIGFyZSAyMSBzaGFyZWQNCj4gKyAg
cGlucyBvbiBlYWNoIG9mIHdoaWNoIHRoZSBjaGlwIHNlbGVjdCBjYW4gYmUgbWFwcGVkLiBFYWNo
IGJpdCBvZiB0aGUNCj4gKyAgY29uZmlndXJhdGlvbiByZWdpc3RlciByZXByZXNlbnRzIGEgZGlm
ZmVyZW50IEZMRVhDT01fU0hBUkVEIHBpbi4NCj4gKyAgICAgICAtIGxhbjk2Nngtc3MtcGluOiAg
ICAgICBTaG91bGQgYmUgYSBmbGV4Y29tIHNoYXJlZCBwaW4uDQo+ICsgICAgICAgLSBsYW45NjZ4
LWNzOiAgICAgICAgICAgU2hvdWxkIGJlIGNoaXAgc2VsZWN0IDAgb3IgMS4NCj4gKw0KPiAgUmVx
dWlyZWQgY2hpbGQ6DQo+ICBBIHNpbmdsZSBhdmFpbGFibGUgY2hpbGQgZGV2aWNlIG9mIHR5cGUg
bWF0Y2hpbmcgdGhlICJhdG1lbCxmbGV4Y29tLW1vZGUiDQo+ICBwcm9wZXJ0eS4NCj4gQEAgLTQx
LDYgKzUwLDkgQEAgZmxleGNvbUBmODAzNDAwMCB7DQo+ICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MT47DQo+ICAgICAgICAgcmFuZ2VzID0gPDB4MCAweGY4MDM0MDAwIDB4ODAwPjsNCj4gICAgICAg
ICBhdG1lbCxmbGV4Y29tLW1vZGUgPSA8Mj47DQo+ICsgICAgICAgLyogTWFwIGNoaXAtc2VsZWN0
IGluZGV4IDAgb2YgdGhlIGZsZXhjb20gdG8gRkxFWENPTV9TSEFSRUQgOSAqLw0KPiArICAgICAg
IGxhbjk2Nngtc3MtcGluID0gPDk+Ow0KPiArICAgICAgIGxhbjk2NngtY3MgPSA8MD47DQo+IA0K
PiAgICAgICAgIHNwaUA0MDAgew0KPiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1l
bCxhdDkxcm05MjAwLXNwaSI7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwNCg0K
