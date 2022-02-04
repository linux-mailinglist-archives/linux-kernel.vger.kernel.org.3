Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1424A97BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiBDK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:28:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22207 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBDK2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643970530; x=1675506530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wbFldrKnX9kSFCgL9Gdq9w8qSs7dY4scqMnLQacIdnA=;
  b=Wn06AgYViiNgkgBtAkAUHhW3ahfnEijkXyqxkBgWTPfS5GLjdLJeE0YW
   s7sYVH7j/uJPMcmzGZhdYm9wm7g840oxTBOv9jj0lThQsno2tbN3yerG0
   r6aYRNx8mbKK+xHsmkZal22EIjRfgdwOQ7r+h9HurDj7cbmopots5kf2a
   5KVDJBHx7szPBPIJ7h1WYcyTmkZ/1CiaTYV9yBcgN6r7KnaQBu7+xBvMJ
   7IKoZgH2Fb1tW8ahR+SCB1r/f2ULQv75Zki615zVodnG40xXOZ1HHe2Rx
   NYrZRX1w6uMHAxfMsfug8lzwts03qYK30sD1QYb48aMx6tfgoQnnyDuK3
   g==;
IronPort-SDR: IMq+20mc76ku+nPTEo1z4AWawPfspNCD6ZIpZ4CgGNyc7FPHllKfNCQeOxGzLcnmCjUYYKhDNU
 e/NoWQiKICWEqARr1IfmXsgqKIclGEfOX5rS+RbdyV6ztFInviglmDuIfV7VS7HCfYTOu34+ly
 RIieKufzWFDPlP6I2qvD98KypCMK3sCm+xTU+JiTr/zZIvbMxoAf0rsuVzWkP/lr92lOSlcjkq
 YrxN+9HBeqQUES6pGCNj08gJHlbHgHE3r5ueuyBAI+5+t8xIO8BhdI40jvneoWFDaAYY4KP4Eh
 c81zf3QZvvRFFZUAo3YeCqtu
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="84675859"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 03:28:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 03:28:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 03:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir5jeimtpgk0G/S4Vo9JJAL16Ykn0SBwUY++Ggzb+/TRx4TD4cPchv+148XUFvorl1wYvHx1h/WNClwEFgjuj1J3ow6VcDdUTjAhZakHiDO+fowfHsBb/wRvAM1cDAKGsr0MaDkKE1DA1Bye6BYLbmR+LjFwFdpNc8qQtV9WN4Ggh6LFiqIOhW1ECiolDWgVqV4KiadLFTlWjr9g4otJacX6HG1iFZo9BtLaWhN7IalfHcNysfcbPbEMIwnazLGl7OPiHEpLgFdLXgupNzfvIVZbJ84ajmDfmzpscbeBl7Kr4Vm0rb/TkxRuY0Q8FTi7xpxpZtP4D724TSQEZrMADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbFldrKnX9kSFCgL9Gdq9w8qSs7dY4scqMnLQacIdnA=;
 b=evCiJIy6uGiOxF8yz0X8BCXn5FjTwdxQKR1ZqyzCOCmg1oIkdq0QqVppt4ktGlVcWuJuxswZFGl05eHbDYtZX4MyS2qlGSG2Hju8X2QsexuckMMqINoE1yOh5qIgA2loQ5AEy7KDIfT7fKws/d8kzYc5ZnDgYFTexNlzwC1o63jLzIQeFK+D6kz5cSl6TtqV4c3xqpGpEz0lc2YBJlOb+L5Ho9quXBxNfzurQD2F+y/iCi6rNYR4v79euZ11F+nZhgQoZQ2r1Ql2doYtIif9rkd2dxrVI8RGc45wFuBC6BArHLLy/w1PIRyG5VmLCe0gtbW+VdQJkekNIk3JTbNwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbFldrKnX9kSFCgL9Gdq9w8qSs7dY4scqMnLQacIdnA=;
 b=YSwhtoIT91EN0QFLEeRQswvf2zc/f1sDooUrl+PquvtdZihSf0/xx21SQc70yWxQnVHfRiS3UvjxjICLB0HinVhdVCqoT1r+9kmprHUD/vO57MGB/RaCLmgfxzFAFG2Sy9H1gKwwohuG0U0oRJEV/ePz++oQQP5NRoC28QqELck=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by CY4PR11MB1560.namprd11.prod.outlook.com (2603:10b6:910:4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 4 Feb
 2022 10:28:43 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc%6]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 10:28:43 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <clement.leger@bootlin.com>
Subject: Re: [PATCH] dt-bindings: microchip: atmel,at91rm9200-tcb: remove
 mandatory interrupts property
Thread-Topic: [PATCH] dt-bindings: microchip: atmel,at91rm9200-tcb: remove
 mandatory interrupts property
Thread-Index: AQHYGZ9XbnmSOZNZMkmbpWM3wZkU0KyDJNoAgAAL3IA=
Date:   Fri, 4 Feb 2022 10:28:43 +0000
Message-ID: <e939a0df-052c-43a6-8be6-51848d3fe5e5@microchip.com>
References: <20220204081446.474991-1-eugen.hristev@microchip.com>
 <Yfz15ta50G5WC158@piout.net>
In-Reply-To: <Yfz15ta50G5WC158@piout.net>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d73abc-94c7-461e-1c51-08d9e7c91e7c
x-ms-traffictypediagnostic: CY4PR11MB1560:EE_
x-microsoft-antispam-prvs: <CY4PR11MB156082E6A4EC063112A6F346E8299@CY4PR11MB1560.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6GuVrg1SAI1NLcgoY+VyYaPtM5VhwMa1TK4MY5uVJ51p2LM7qTFj1JOhJ+BHJEGHVguzltYAEYc/Hk2ioNWf82E9FPJssiBqhZgLROPGdsO6Kb7aguekPxT3gqJNZ/7QSxJiBaT2v8DKnYufTtDm1BPkngPm5w7PW+Si6ikyFloJ0imdcNjuwddzgtgT1oBHHQZ9H8/byBZymi3J3is19U4uPa6aHLXnGxgGwHUbRYYkAbAx9c8h/sTaV9wwT/vfW1xSJoW6vujW9XnvikzCYD73v0BW26HBBazEHpc2PXIQX8Vc/BcPxC/KBMPBimc0m3PzYFmQX2qNBHbLT0Hj2IdakF3wd0x0hFdR04zeiG3L9bMeKQ2qU1B75ET0tU4Ts+OEKYP0bPexTOlfSTCmjzRo0XR3cHpfrx2Upjr3d6BxsHPi9xdsnuOxsJSwmWRqYUaKK/xU8s7aJfYgziFNejLcFtu/TxSwOdtO2y7y2tix/etYmvlGyWoKJ0M/sw7fXDjEZuEBLB7laJgn9jSIEEvoXccd/K4XlwwA8DI2oGn2sOvd9CbqLn+io4UIA2G5/TGMX9iGMdzLsEpaGD+XBA2Gmk6gpKyAjlt6+mA7GTqb5Fv38Ss/zDf7pL2V58xEFrGauMcAbAFAiP4+EeAgQN2DNkntiInOFjd57eTIfcuQqmh5n1rOU+CzSP55SySIZXK+MkK8ZZwjqelJ1YI+NUzOouruPxUBvaf0fwkQtMjBo4ExbE+BueVxRPk9M7JTE4TUhtolT1upScDOLdt+D0srdU9t6vyMY60m+inQqOw5xlnmx7wNQ0Pkwhyo3ENa2wYo4lFVOZZKT4MJr39twyv5nwJVIRBCFZrwtvAbJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31696002)(86362001)(38070700005)(122000001)(66556008)(91956017)(66946007)(76116006)(8676002)(66476007)(66446008)(64756008)(8936002)(54906003)(4326008)(316002)(6916009)(2906002)(5660300002)(186003)(26005)(2616005)(6486002)(71200400001)(508600001)(966005)(83380400001)(6506007)(6512007)(53546011)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJSemg2STdPV2dQaE1pVGtQejBqTXZtRi9PYmxZMnJQTU53TXZrTXdNWWNa?=
 =?utf-8?B?dUpiQ1hzNmlpejgweGxYTVpYMVZ3N3JxVmNNMlI2QTJnVkx1WkFPMFFRaUJx?=
 =?utf-8?B?bE1GWEdoQWozLzFSUmFRRWozWThvYkR1U0NIWUlYbVBCUzZ4Q01UbjhFV1Jw?=
 =?utf-8?B?Mit6YUplenk0dzB2MEdneXllcUw5TWhvS2ZGNmJLYWxyR3Bpa3M3ME5YSG0r?=
 =?utf-8?B?MjY0dURZZzBZZUpiby9Pd053V2c4NFFYNzlwNit1R0c2aE5mbmVISXlLbUdO?=
 =?utf-8?B?NEsrWEtVeUZVcmEzbHFKWmJBN1VkeXpvaXJKWGlhaW5STVdsd1RqcmtsYnJu?=
 =?utf-8?B?R1hQNTh1aWVxbWZ6bGhXa3ZqK0FHSWtCNEZtSlJiWW1BSlZVVnl2T1hQc25C?=
 =?utf-8?B?alhhTWRVMWlMZU54Zjdab0dRWnJJejU3bENlbjlUZzZsZjl4ZWVmc0Z2a2gv?=
 =?utf-8?B?VmRYOXRKVndUOHVKNEgzYzVLRzF0aDJnZUFTMllKenUvblNoSzhoOVFqYk1X?=
 =?utf-8?B?VzM3bHkycHlYMGpNMi9tcjNjR2tqSnJSU0RXNGFEeGhaaUo2dkoyMWZnZTRE?=
 =?utf-8?B?T0FXOFhsOC9sODBGUTFjSG1Wc1lLaG1SdGRoaC9JUTMyOUMwc1RpTXV4UVdL?=
 =?utf-8?B?VjNYcnFZaTB2NW02VWk4V2hLd1FCd2pHWnl1RDZHYncvRldueElsQ0dPZEln?=
 =?utf-8?B?bXE0N1VpczY3MzFaUXZxdy9yMzdveDY1dS9iYnZRV0tTREVhNFZPTzdMaFdT?=
 =?utf-8?B?QzNtZmVxdjA3cmNGYVorN05XQnZLVVpnNGF0QmE5ejQrbldwcEIvMExvc3Bo?=
 =?utf-8?B?QVV1emMvYUNGZHNZYjZnR2lUQm9wb2J3NEduL1VuRHU4anVrK25kU1F3QjRZ?=
 =?utf-8?B?OHVwWldzczM3MS91VGplMzF0T2hhVW9qb1AzWkZrMktIWVFGY0dnRTNrSlJv?=
 =?utf-8?B?VWFtUWlkRUJzY2FXbUhFcjZGOVE0ZGlNcUpUWGh5NjlINUdyTWhvNnJUbFRQ?=
 =?utf-8?B?eEcvRThUM2tyUTZOWFVRNVFNazRQdDJxSjZOdkp2Z2Rsbk9kZUFIVnZBc2tv?=
 =?utf-8?B?ek4rcFovY3dxemg5YVhQekJKYnhHS3ZsdnJVK1JHM0xGMmRnMUtSQ3VIT1dm?=
 =?utf-8?B?SUlaUWRTMXIrSHBvZlVXUkVFYVcyd3BLYWVWVzBqZTluMFc4MkhMOGZvWER5?=
 =?utf-8?B?TnIrUFA5Z0svMnA1aDRvNlBrQW9taUVTWkFscUJodXh6L2ZaL3ZYRWNyUEY3?=
 =?utf-8?B?VUN6TGNaYzNCdHh5SjgvMnVhcDA0VGRJVlVpc2xDd1lIMDVDUDBUbGdpQkVO?=
 =?utf-8?B?Zzd2MVE4TTdnL1ZpV053dUwyem01dUxjTWJ5WnE0SmlnRFV3SENQREo4WFE0?=
 =?utf-8?B?OGtrZElGSHN3cVZXcUd5NWVnUFN5Ty8rc1hFNEFpL2llRTVBcEMycFE0b0VJ?=
 =?utf-8?B?Q2pxUk43dEF2WGJwZnM2Sk9leXdVWVMzczMvQ0JGQUtKWndwNm8vaDNVaThr?=
 =?utf-8?B?K1lGenc5SG5RTGhiL09RbTJScFhQR0VQTUlYdjNPNlpUSTFFZEw3OEV6aG1x?=
 =?utf-8?B?WXdyczRBc3k1U3pGaXZWbUNTanNKZUhMZno0aU5wLzBnZXM3SmE3MWpxMFdI?=
 =?utf-8?B?bXdsVkdNdSs5ZFlBZys2VGUvTTdMWHRCTUZPOGFnU1pmVjRyKzR5SXlrOU1n?=
 =?utf-8?B?UE9DWW9nZUo3dDI4emxFWDl1OUFVNmdoeXpXaUp2Zll5VklKOURBbnBUdEgy?=
 =?utf-8?B?ZWluTzFKQUM0WUpYcW11bTBUeE5ONWpmNXBtT0cwN1g4MnI3RVdhcnorM2Zp?=
 =?utf-8?B?ZXZ3VkFXWk1ySjJNOWVNRWs2MjJHOFRwcmhvWXBXak8xOXYxQU5NUVVkaU1i?=
 =?utf-8?B?SnpRcTF5cENLN0kwQzUzQTZPVXBpV3ZWK1pBaUQ4ZjVJSkltSGM0K1JCVkIx?=
 =?utf-8?B?Z1NMK3JwNndsRDYxMG1BRUlFdlhkcXhKT0VEZDdjRWFkZHZ0K0xOOGxvQmMz?=
 =?utf-8?B?cTcrZzZmenY1NzRZamFsVUdjeWNxR2xLemx2Ui96K3I4RXhkN2JtWm9Xb0VD?=
 =?utf-8?B?SjlTUU5zR011L2tXdGRTWVhJMUZPclZFUmFXVmRLaHlVK2NlVmFZM2pBZVdU?=
 =?utf-8?B?NytMZ0Q0bndHMkMvSmM1VTZScmVSekdmTm1URlI5ZVZ2cVBQVVRlNVNRdXQ3?=
 =?utf-8?B?Y2F2VkZ2ZDJkcWdGVXpMRkR3Z01iOW95OHFNbVVCaEw5emdJZmpFYTUrMUF1?=
 =?utf-8?B?ckhMTldjV3VLaks0L1ZDOU1yaTBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A969E8E8DC43634A93C43980A69A3525@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d73abc-94c7-461e-1c51-08d9e7c91e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 10:28:43.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uigv65AOX/M2hOptj1ejZfw9+PjSLrmuULPIB+ucCKmCfqcpC3LVVGICLGUBr0Vx+ZthzMQq9MGwy6YYPVUwg2z1umPIQh5sFLCKT2Ab0xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1560
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi80LzIyIDExOjQ2IEFNLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4gT24gMDQvMDIv
MjAyMiAxMDoxNDo0NiswMjAwLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4gVGhlIHRpbWVyIGJs
b2NrIGNhbiBiZSB1c2VkIG9ubHkgdG8gYmUgcmVhZCBhbmQgdG8gbWVhc3VyZSB0aW1lIGluIGEg
cG9sbGluZw0KPj4gZmFzaGlvbi4gVGhpcyBjYW4gYmUgdXNlZCBieSBMaW51eCBsaWtlIHRoaXMg
Zm9yIGV4YW1wbGUsIG9yIGl0IGNhbiBiZSB1c2VkDQo+PiBieSBkaWZmZXJlbnQgcHJvamVjdHMg
d2hpY2ggZG8gbm90IGhhdmUgaW50ZXJydXB0IGNvbnRyb2xsZXJzLCBvciBkbyBub3QNCj4+IHdp
c2ggdG8gZW5hYmxlIHRoZW0gKGUuZy4gVS1ib290KS4NCj4+IEFzIERUIGlzIEFCSSwgdGhlIGJp
bmRpbmcgc2hvdWxkIHJlbGF0ZSB0byBhbGwgcG9zc2libGUgdXNlIGNhc2VzIGFuZCBkZXNjcmli
ZQ0KPj4gdGhlIGhhcmR3YXJlIGFuZCB0aGUgcmVxdWlyZW1lbnRzLg0KPj4gVGhlIGludGVycnVw
dCBpcyBub3QgYSBoYXJkIHJlcXVpcmVtZW50IGZvciB0aGUgdGltZXIgdG8gZnVuY3Rpb24gaW4g
YQ0KPj4gc3BlY2lmaWMgd2F5Lg0KPj4gVGh1cywgY2hvb3NlIHRvIHJlbW92ZSB0aGUgaW50ZXJy
dXB0cyBwcm9wZXJ0eSBmcm9tIHRoZSBtYW5kYXRvcnkgbGlzdCBvZg0KPj4gcHJvcGVydGllcy4N
Cj4+DQo+IA0KPiBUaGUgY29ycmVjdCBoYXJkd2FyZSBkZXNjcmlwdGlvbiBpcyB0aGF0IHRoZSBp
bnRlcnJ1cHQgaXMgcHJlc2VudCBvbiB0aGUNCj4gSVAuIEhhdmluZyBzb2Z0d2FyZSBiZWhhdmUg
ZGlmZmVyZW50bHkgZGVwZW5kaW5nIG9uIHRoZSBwcmVzZW5jZSBvZiB0aGF0DQo+IHByb3BlcnR5
IGlzIGNvbmZpZ3VyYXRpb24sIG5vdCBoYXJkd2FyZSBkZXNjcmlwdGlvbi4NCg0KSSBhZ3JlZS4g
VGhlIGludGVycnVwdCBpcyBwcmVzZW50IG9uIHRoZSBJUCwgdGh1cyB0aGUgcHJvcGVydHkgZXhp
c3RzIA0KYW5kIGl0J3MgZGVzY3JpYmVkLg0KSG93ZXZlciwgdGhlIGludGVycnVwdCBpcyBub3Qg
bWFuZGF0b3J5IGZvciBJUCBvcGVyYXRpb25zLiBUaHVzIGl0IA0Kc2hvdWxkIG5vdCBiZSBpbiB0
aGUgbGlzdCBvZiBtYW5kYXRvcnkgcHJvcGVydGllcy4NCg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4g
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAt
dGNiLnlhbWwgIHwgMSAtDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWlj
cm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05MjAwLXRjYi55YW1sDQo+PiBp
bmRleCA1OTdkNjdmYmE5MmYuLjI3Zjc4NDU5Yjg5MiAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAt
dGNiLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mv
bWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4+IEBAIC0xMzQsNyArMTM0LDYg
QEAgYWxsT2Y6DQo+PiAgIHJlcXVpcmVkOg0KPj4gICAgIC0gY29tcGF0aWJsZQ0KPj4gICAgIC0g
cmVnDQo+PiAtICAtIGludGVycnVwdHMNCj4+ICAgICAtIGNsb2Nrcw0KPj4gICAgIC0gY2xvY2st
bmFtZXMNCj4+ICAgICAtICcjYWRkcmVzcy1jZWxscycNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQo+
IA0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgY28tb3duZXIgYW5kIENPTywgQm9vdGxpbg0K
PiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxp
bi5jb20NCj4gDQoNCg==
