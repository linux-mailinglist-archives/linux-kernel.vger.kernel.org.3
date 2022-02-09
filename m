Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B64AF10F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiBIMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiBIMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:08:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE8E011149;
        Wed,  9 Feb 2022 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644405035; x=1675941035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ktcKULmkTdW6fhm96EupO/VJRoZu3IOmtDLyY9H5TLg=;
  b=n6wm9Ij04S0Y6zp+lA+W7Wfvn7FjVok5r9lgZcWZPDb5/pvsipcYEzBw
   ZtC8/XIBB9HztS0sdG/XNM4SW5/zpBO8hsIpXKY9CVg11FSJvJ+MpBNJo
   /9x/8O3ydcRu6VbP4y5uLPyPvT7X1ZsOLEZokfq56ToCU0deJOYFVMJuo
   wJJEbPwLQgUfWJJYeU0Q4OPxpu2RDl84bruoCtPAfMGaFLW1XIT2ZFVzJ
   dHwKjx2vCwrzvi6yZQbUEUcbp3wK6nmsEx1dlVKXtn7Ygw2PtZlelyUi5
   zdE8W1bM+JaMADqMjOVJMe9EGz09ABp1Vc0ki7SpqwgACIgblTVXykVL9
   w==;
IronPort-SDR: 1yCPZajY9yr1+9PWzrir0aSDCE8jGj3Q/zi65nQR/YNGt6zRqYQvmInOvfDJIy3h5zh/1YgNV/
 i1OWHq3h/NRXumeCdaMm8gl+UVvKrgrnBD8Qmcm9+wx5OIiHR/UY9phFKomBcmzD34Hhs0uoVF
 O8QJm9IsjhPsyE16AyukcWFzTg8aeHUOygpbfYtVYc1LXCnD16JRa5EElYeZ2li5swG5Irqa5X
 HbRNdnvlVLCH7cKLegMh7qR5dI8uJQx0wCNVe3Xf+1DYv5HnG/ez1FvWTDM54kOWRdHWjdc2Pu
 lYdk+1pf1krQpkPu4d3T5lt4
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="85140878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 02:02:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 02:02:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Feb 2022 02:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJguWQ5t9cGKw4M7tiNHnlKDa+bHYlZLw/trPJA/GiRUA6tBbl/U0gu+lXq4v545/MUG1OmeypzUqhagc2KR5DS7OtEyHRwgcDootqz+q3ebRUDiwJLeol1BeaPeWu+MlzcpLZCwRVgcobORAyvxY153DU4FpcNuU5O6ZiMF2XhXBkfowTR2BESSHCDr8yCHuT452CA+yLfzHsmv1tq34OA3JBEmpjYP45kucv2lPyKc9myI5ouOPbiEB/TVMmRD1szI1onKCpytj12uUZhMRQmT/2MBVI4nTCUey0m7m5jWHuWAw+akev1Mdthotgjc/Mj6VCA+N0jC1xYmT8Wunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktcKULmkTdW6fhm96EupO/VJRoZu3IOmtDLyY9H5TLg=;
 b=EAPVnyFMLGOsbsRr9nJnLG8q9/xX9KsuJ7Za13RXDmCW9yhIU+EB0k54NDhUJgmgyU2Z5nByFo0Wq+2zuJjnOCq40Ufb3wV9kbtToXv6uIEHv9ck4t6maxxFFt3klrOs2sKJboEdUEt4V3vkq3kCy/8QwxyCMVIojXQc1TF0NvPi0OMnne/wshqV72Vp6Vu2jFCsVJBdVkYOdGmPJyy6/7RjIKdSSbrQLS2hXzvvjCV+YVAOJ7NYejtmXUbwz5NQx7qGm2h1WdolZjJyRcllqtWFDNylkzwAO5CGQngg01hz5TKWrnWeiKQ06ZDruT3Pl0S6bwpKsFiRCEHP1YCqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktcKULmkTdW6fhm96EupO/VJRoZu3IOmtDLyY9H5TLg=;
 b=Big1j0PDrnye4waFqhcGSZP9R3wr6nvgzTgQ468xAq5Ofq37eP6qIl2WqI4+MXfXLPVajpMz4N+SGMThwsh6C05EOA5e9GY5KJEU/NybL7vZx9XPjhZUtpFXzioxeqziQSpMG8yF+cwCgMJrAtu5GCwS/KFVqAeM4h+Y7ysStkg=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CY4PR11MB1944.namprd11.prod.outlook.com (2603:10b6:903:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 09:02:20 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 09:02:20 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <arnd@arndb.de>, <Nicolas.Ferre@microchip.com>
CC:     <olof@lixom.net>, <soc@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Topic: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Index: AQHYCFO5ScMFg2Rm1UOuhcbekcFR86xgn+oAgClbpICAARgxcA==
Date:   Wed, 9 Feb 2022 09:02:20 +0000
Message-ID: <CO1PR11MB48651C0D73189AF010407F9B922E9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220113080017.30155-1-kavyasree.kotagiri@microchip.com>
 <f8b83cf0-7ebf-1ecd-b544-f0d0079d9dde@microchip.com>
 <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
In-Reply-To: <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34704de9-0c1c-434a-b246-08d9ebaae12e
x-ms-traffictypediagnostic: CY4PR11MB1944:EE_
x-microsoft-antispam-prvs: <CY4PR11MB19446F1A04C999D643041F54922E9@CY4PR11MB1944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFjJvTPaFst5mRxMIr3HNHc+fBAwg9ULaaDD8+4HpGf4/3OY7J4cy/7YKdooJx5avv+FIqSCvvW6i+1vc3kMHxY0hVPwpPj7Ml+xflWenkgg98NpyocQEyx0KgooZW6ZbHFx3AAyr1rAOxZMSmwo6b+6sPmiB3VgtnyuDrMzBgMDiKgs8hd5rdtCDHaN1I8m/RF8rd2D3lDzfFWwgEeB8xit4+05WtjDxT/CM4NLOqma4DcdgEsXUE1WjlLzaA0EmD5BbxKWvMk2jyZ9G2Cq+emw2V7c+qajOUznEdA0MQTXjpEQAABmJpqa5kD8aesBGkRN0KzsVe3fkuJuo3NCxNq7/DomHHsJod0d6pZ9CcycUCswg0XWZHikN8ChKHPnUzskVduJggvtYqwr/iR8azN1pm/byunjhWYdE3QqIRu7jJK2jWgenoJKrsXj455sfJ8sgY5iHp2ODkUNOhgT6TuzeVxsPSxzXPq1oXK2fpT/OpEe9Uros0hlWbfAPIsxQT74aG/bt8Tw34L+GGRH2OZnEL2FfE8C76jHVXAIUDnvh1Yy40d2/EGW3sxpMu6uSDsjUAukoB4J7U2vkv9wHt7etP2xnENS9N6RYp7k5LG3vIgbX2dR3N1HGVpg4HCPGYEzAJJ5rO8yVfZVnlwP/m1EokynLzvqmj1nKQEC3ph4GlQhILrTrm7dntnT4s8EjfAjpKGHBpvOx0kaI2y3k9gR3lNC00Dk+WbyfdTR4gc8NxLEJGD7V1DQw5Bvp0u1b7SWTukrOXwG5gzKWP/a3ypAtUrbsr8z/iNKkfwqGds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66946007)(66476007)(2906002)(186003)(54906003)(26005)(33656002)(38100700002)(110136005)(8936002)(52536014)(9686003)(8676002)(6506007)(38070700005)(53546011)(66446008)(6636002)(316002)(4326008)(66556008)(55016003)(5660300002)(64756008)(508600001)(86362001)(71200400001)(122000001)(966005)(83380400001)(7696005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW1vSDQwaG9IVHRxdU9qbGJGS2luaUtacjhtclRRVGN0VWRodUV2YTNXOVlU?=
 =?utf-8?B?UkVPQy9MU3libWVrTGNGSVpqUUdaMFM5OEkzNWJRd3E4MWdjY2JmdkQwcmQr?=
 =?utf-8?B?ckU1c1pkVXFOYlZISzc1NUE4VVQ5SjFLRzdFZm1PL3VRQlpBRW1Fd0tSbGVM?=
 =?utf-8?B?am1YYTBOdDFXY3AwSDVyTG1FUlFRR3NWaldRYVNTajdDckFPZHorampmbGtu?=
 =?utf-8?B?aVpuMXFYRllOaUR1QjUrNk40Zlp4cVd1NkRocjBjT0xRb2FyVFBjbTFtYXlQ?=
 =?utf-8?B?aTBZQTZsbnJuYmYrSVNxYmJWaHFleEU5Zi85TnlIamdYdElxMTRGL1NwRVNq?=
 =?utf-8?B?T2JOV3JiZlpYMDF5YWhWYStrbUxvanB4UkVTeC90bHE4cm43eW85dGlKYkQ4?=
 =?utf-8?B?QkIzOTY4VVNaeWtyWG9xTnVsZHphVlJjMmVoaThIdFBVUXBXWm9yMWxIL0Ez?=
 =?utf-8?B?djhYOU9iZTRVc0R5TXdRdHJPcEltM1hZVFgzYSsxbXJtTm9kYjFseVJMWE5I?=
 =?utf-8?B?MUQvL1IrMlo4d2I3b3d3Z1VWOGpUNzh5eGVxMHIzTmlua1hzajkwSW83byt6?=
 =?utf-8?B?NVJidmUvditmUmtsYjBGR1BqcEtxYWErRlVIbCtvZzBOS1lhbkt4RGdsOU5q?=
 =?utf-8?B?U2pkSHdyYmhqT08wY3NGd3pXTjdIMkN4dnJQSUJmQW5tRDdsSExzekpNQmJ4?=
 =?utf-8?B?VmthNmlMMWtSZTJwQ1ZZSTZ5LzRvN3llT2tFSkVLSC94UU8wUVVOUEQwSzBE?=
 =?utf-8?B?Qk9QNWI0bFhGbkd2a0M2Yy9MY1paOGtoNUJsUGJteTdBTTA4aHFQZFJ3Z3h1?=
 =?utf-8?B?QkUxQ1FIOG1FaEFDQUsvYzR0VkRVRC9ZQVlzclp6TGVYRUhKbHRHcXppbDFK?=
 =?utf-8?B?aldSSFBlWG9qRlhLWVNHMDJXZDk4LyswSlJmYVdkc0ozaytCRkZyc3hxbWJw?=
 =?utf-8?B?VGRnaXN2ZXhobWlpcXZxMFNkVjVVbVU2RlY1YWlmNGdFYmxwU25xaFRXVW1F?=
 =?utf-8?B?U1k2czhBUUFSdEdBYllyMjRDc0FjUjBFMXM2ajRmNG04MUg5MXN6bzVWMjhZ?=
 =?utf-8?B?dlVIN2Q3NkYrQjVTaVl0SmY4RWRNZ1M3clRzQUs3MVE4TGVteDB3ejhma2cz?=
 =?utf-8?B?YjZ1UmhZNmVoYyt5YUdUTXFYNWdYbG12N2VVSzFVN1lKUTNKZFB2NEc5bW50?=
 =?utf-8?B?U3N2dFBHTDVhcFVTbW04NGRobHpXMmVYbE0rbnNHeERrOW0yZ1VzaFpTdzFi?=
 =?utf-8?B?b2F1VzdEM1V4Y2dzZlN3UXhnczNPclpVcjNXYUhremNKOVNFWlBadko1OWdK?=
 =?utf-8?B?ZGZkRmYxVk1FWXZ3eUpVbjFmUFdEaUpxVXZzV0E1V0xEdVN4RmR4ZElySURa?=
 =?utf-8?B?eFllMkFESDFoelFxbzd6MjZDVG9ONFYvTGVBTnkzaTdrM2RGVFAvKzdjV1FS?=
 =?utf-8?B?eTcrYVl2endxazRtQTI4czVnZ0ErNEJyR3NGdkZjbUtmQzFibHRKamw2NFBC?=
 =?utf-8?B?NnJHbXlNWkpmcGFuVlh4bVZzTHgxS2FzUFBNbk5kMXExMmtrMkVHc2RqbWd1?=
 =?utf-8?B?RXl0UGpISVkyY2YrWHFYSGZtOXExU1ZBRkdTdzdDWUcrL2ljbUdBaUlTeHZm?=
 =?utf-8?B?WkdCUFRaVTVCRERudlltYmUrckJnNmVjVmxTbEM5ZHZaY1lyZ3hrbG42U0Fl?=
 =?utf-8?B?akg2alVabDFvc3lSaHZ4WHY0MVArSVVKY1FldTMvbFY5WXFVY2xaeGE0SUpq?=
 =?utf-8?B?R25UNk1lSHROM1BxQlVKclhnb1VYTTAxWjJ0cUp4WGdiMG1xMGhjbkpxbHVL?=
 =?utf-8?B?UnZIdEdZMnl3cjZKUk5Tcjd1UEtCRm11K0RETEVRZDkvN3pmbDVET2ZkNHpO?=
 =?utf-8?B?OU5OcUtVcWx5OUNvSHJBVDlpWDh3Z0c3bDF6MTA0cm8zVFlJTXhwSmd5QWk1?=
 =?utf-8?B?ZTdzaE5oY3E3NU9HSzlJTzl1WGdsWVNIZnF1cm54MG13ZmkzeWp1d1RNNFk1?=
 =?utf-8?B?RjNteUpHWHlwUXpFejVPMEVlQ2RBZjhrUUl6bURJVDAvU0RpN2trYUZnRXo1?=
 =?utf-8?B?QW4zeFNqajBsZkdtYkVXenRMelRyZUxuTzcvL2VKYWdBa3hHYXZHMWFjTnRR?=
 =?utf-8?B?WHhBWnJ1TjY4SjB6Y0xQMjFZSTBLTjl0TTErYTd0ZG5yN2JYZDhML0N1WC9t?=
 =?utf-8?B?MWR5RjI0bURPcEpPNWdxQTNjc3U5b08vcjNYNjBKVG9Ud3J2cS8xb1l6N00z?=
 =?utf-8?B?Yjk3d3d3OFZKVU5IK3ZkTkRUM29zZEJUQzlmQS94dkNyaEZ3REphd01UMk8x?=
 =?utf-8?Q?c7l0dT0NZEkCpXVwvZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34704de9-0c1c-434a-b246-08d9ebaae12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 09:02:20.3131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /d3T5Yp+hdM+S9+lriuwliaM3hQj0ybzuuh798nOmYYR41DwCleVsf2M+x5q1wRg76NFlz0plnlcwwqwsQ29mg8Giu1iMmgKYO2rF3oqNFik9pZdwrrtMbSYYm6j94rV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1944
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IE9uIDEzLzAxLzIwMjIgYXQgMDk6MDAsIEthdnlhc3JlZSBLb3RhZ2lyaSB3cm90ZToNCj4g
PiA+IFRoaXMgcGF0Y2ggYWRkcyBiYXNpYyBEVCBmb3IgTWljcm9jaGlwIGxhbjk2NnggU29DIGFu
ZCBhc3NvY2lhdGVkIGJvYXJkDQo+ID4gPiBwY2I4MjkxKDItcG9ydCBFVkIpLiBBZGRzIHBlcmlw
aGVyYWxzIHJlcXVpcmVkIHRvIGFsbG93IGJvb3Rpbmc6IElSUXMsDQo+ID4gPiBjbG9ja3MsIHRp
bWVycywgbWVtb3J5LCBmbGV4Y29tcywgR1BJT3MuIEFsc28gYWRkcyBvdGhlciBwZXJpcGhlcmFs
cyBsaWtlDQo+ID4gPiBjcnlwdG8oQUVTLFNIQSksIERNQSBhbmQgd2F0Y2hkb2cuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdp
cmlAbWljcm9jaGlwLmNvbT4NCj4gPg0KPiA+IExvb2tzIGdvb2QgdG8gbWU6DQo+ID4gUmV2aWV3
ZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gDQo+
IEknbSBub3QgcXVpdGUgc3VyZSB3aGF0IHRvIGRvIHdpdGggdGhpcywgYXMgdGhpcyB3YXMgc2Vu
dCB0bzpzb2NAa2VybmVsLm9yZywNCj4gd2hpY2ggaXMgbm9ybWFsbHkgZm9yIHBhdGNoZXMgdGhh
dCBhcmUgYWxyZWFkeSByZXZpZXdlZCBhbmQgc2hvdWxkIGp1c3QNCj4gZ2V0IGFwcGxpZWQuDQo+
IA0KPiBJIGNhbiBhcHBseSB0aGlzLCBidXQgSSB3b3VsZCBub3JtYWxseSBleHBlY3QgYm9hcmQg
ZmlsZXMgdG8gZ2V0IHBpY2tlZCB1cA0KPiBpbiB0aGUgYXQ5MSB0cmVlIGZpcnN0LiBJJ2xsIGRy
b3AgdGhpcyB2ZXJzaW9uIGZyb20gcGF0Y2h3b3JrIGZvciBub3csIGFzIEkNCj4gYWxzbyBoYXZl
IGEgY291cGxlIG9mIGNvbW1lbnRzOg0KPiANCj4gPiA+ICsNCj4gPiA+ICsvIHsNCj4gPiA+ICsg
ICAgIG1vZGVsID0gIk1pY3JvY2hpcCBMQU45NjZ4IGZhbWlseSBTb0MiOw0KPiA+ID4gKyAgICAg
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2eCI7DQo+IA0KPiBCeSBjb252ZW50aW9uLCB0
aGUgJ2NvbXBhdGlibGUnIHN0cmluZ3Mgc2hvdWxkIG5vdCBjb250YWluICd4Jw0KPiBhcyBhIHdp
bGRjYXJkIGNoYXJhY3Rlci4gSnVzdCBwaWNrIG9uZSBvZiB0aGUgbW9kZWxzIHRvIGJlDQo+IGNv
bXBhdGlibGUgd2l0aC4gVGhlIC5kdHNpIGZpbGUgZG9lc24ndCByZWFsbHkgbmVlZCBhIHRvcC1s
ZXZlbA0KPiBjb21wYXRpYmxlIG9yIG1vZGVsIHByb3BlcnR5IHRob3VnaCwgYXMgdGhleSBuZWVk
IHRvIGJlDQo+IG92ZXJyaWRkZW4gYnkgdGVoIGJvYXJkIGFueXdheS4NCj4NCk9rLCBJIHdpbGwg
Y2hhbmdlIGl0Lg0KIA0KPiA+ID4gKw0KPiA+ID4gKyAgICAgbWVtb3J5QDYwMDAwMDAwIHsNCj4g
PiA+ICsgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gPiA+ICsgICAgICAg
ICAgICAgcmVnID0gPDB4NjAwMDAwMDAgMHg0MDAwMDAwMD47ICAvKiAxR0IgKi8NCj4gPiA+ICsg
ICAgIH07DQo+IA0KPiBQcm9iYWJseSBhbHNvIG5vIG1lbW9yeSBub2RlLiBUaGlzIHRlbmRzIHRv
IGJlIGZpbGxlZCBieSB0aGUNCj4gYm9vdCBsb2FkZXIsIG9yIGl0IGlzIHBhcnQgb2YgdGhlIGJv
YXJkIHdoZW4gd2hlbiB0aGUgYm9vdCBsb2FkZXINCj4gaXMgdG9vIG9sZCBmb3IgdGhhdC4NCj4g
DQo+IElmIHRoZSBtZW1vcnkgaXMgcGFydCBvZiB0aGUgY2hpcCBwYWNrYWdlLCBoYXZpbmcgaXQg
aW4gdGhlIC5kdHNpDQo+IGZpbGUgaXMgcHJvYmFibHkgb2ssIGJ1dCBJIHdvdWxkIGFkZCBhIGNv
bW1lbnQgZm9yIHRoYXQuDQo+IA0KT2suDQo+ID4gPiArICovDQo+ID4gPiArL2R0cy12MS87DQo+
ID4gPiArI2luY2x1ZGUgImxhbjk2NnguZHRzaSINCj4gPiA+ICsNCj4gPiA+ICsvIHsNCj4gPiA+
ICsgICAgIG1vZGVsID0gIk1pY3JvY2hpcCBFVkIgLSBMQU45NjYyIjsNCj4gPiA+ICsgICAgIGNv
bXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjk2NjItcGNiODI5MSIsICJtaWNyb2NoaXAsbGFuOTY2
MiIsDQo+ICJtaWNyb2NoaXAsbGFuOTY2IjsNCj4gPiA+ICt9Ow0KPiANCj4gSGVyZSBJIHdvdWxk
IGV4cGVjdCAvY2hvc2VuIGFuZCAvYWxpYXNlcyBub2Rlcy4NCj4gDQpJIHdpbGwgYWRkIHRoZW0u
DQoNCj4gPiA+ICsmZ3BpbyB7DQo+ID4gPiArICAgICBmY19zaHJkN19waW5zOiBmY19zaHJkNy1w
aW5zIHsNCj4gPiA+ICsgICAgICAgICAgICAgcGlucyA9ICJHUElPXzQ5IjsNCj4gPiA+ICsgICAg
ICAgICAgICAgZnVuY3Rpb24gPSAiZmNfc2hyZDciOw0KPiA+ID4gKyAgICAgfTsNCj4gDQo+IFRo
ZXNlIHByb3BlcnRpZXMgZG9uJ3QgbG9vayBsaWtlIG1vc3QgcGluY3RybCBub2RlcywgaGFzIHRo
ZSBiaW5kaW5nDQo+IGJlZW4gcmV2aWV3ZWQ/DQo+IEkgZG9uJ3Qgc2VlIGl0IGluIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsLw0KPg0KVGhpcyBpcyBzaW1pbGFyIHRv
IHRoZSBvbmVzIHVzZWQgaW4gTWljcm9jaGlwIE9jZWxvdCBhbmQgU3Bhcng1IHBpbmN0cmwuDQpG
b3IgZXhhbXBsZSwgc2VlIHVzYXJ0X3BpbnMgb2YgZ3BpbyBub2RlcyBpbiBiZWxvdyBsaW5rczog
DQpodHRwczovL3NiZXhyLnJhYmV4Yy5vcmcvbGF0ZXN0L3NvdXJjZXMvLzg0L2QzOWI1NDM3OTBm
ZjI1LmpodG1sDQpodHRwczovL3NlYXJjaGNvZGUuY29tL2ZpbGUvMzMzNzUwNjM0L2FyY2gvbWlw
cy9ib290L2R0cy9tc2NjL29jZWxvdC5kdHNpLw0KDQogDQo+ICAgICAgICAgICBBcm5kDQo=
