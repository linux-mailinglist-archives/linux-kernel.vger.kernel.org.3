Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF54D5B93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbiCKGYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiCKGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:24:31 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 22:23:27 PST
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012941768CB;
        Thu, 10 Mar 2022 22:23:25 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6E9B1405BC;
        Fri, 11 Mar 2022 06:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646979183; bh=uADPwr1Kj3+Dba8EUuZnUddbV6Pp33anYFktrJ+2Yl8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NO77HvhwiLgPR5hznU3c2zC7n5GKtCTAMZftQzeGC0y9iBoh1/oL2hX2WiTl6PkpK
         V4Vtce3nWFbEEViziJORaXn556R/IvFYdppJGNMobjPJOwfWy6GbRIkR/Hf6fx8kMU
         R1Zwr4WxL2+1ddLPKc2Mvb7OpQh7sZupjoxxLSYd6sENduv6eb9YHCWkTUq+sgeFNP
         B+UybJEoJxx5/eOhmtWwXqw/3YuW5rt7eUNZlocwg3tfSsqORekbLgwAC66Kl833vW
         8Z8EpimcUXkhyFiLodXGo3UidRH8ApU+FI2Ew574//FDEzCbf6VDmBENAV33jmx/bm
         baLUVSR8d6MXA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 654ECA005C;
        Fri, 11 Mar 2022 06:13:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D6168801EE;
        Fri, 11 Mar 2022 06:12:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="V9tKVtT7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCM7cVmsPdsjGEuaOSdJyKTNMkhSiTNrVLaaJXlB1UJFUCkfCMR8Cjb02m4bv9LJznZAG7EUJF0lGicZu5XXPPkyeqAzT7EGK1CaihWYpadLA6GVTr/8v+kr5DM07nA98Dkz3dUefngDjuwUfhWkfykVMbNGgzUssqaPObkD5rIRmAOYI6S6nhh3ZU2LJT5FtqQd1uKM27nwKIyVlBgKMfVPdzhuVR4pyr0mvAS37Vq4HceaGIRpgFG5tPtdzgDp0khqufY2y0Ay+Nue+GrxTeC+Sx1zwYjzCbCm8Ekdd9kV+uft8/aLN4cfHRzqPsuJ62GWI9lTCUw5BNMvJZHCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uADPwr1Kj3+Dba8EUuZnUddbV6Pp33anYFktrJ+2Yl8=;
 b=BxidrHVeAWdRAYRgH/ZFXrw4rx8NqOgvW7RM6ntuGzzYAf1oozwhlDkvpER/e1UZcZYxYb+EU/hHJF4HgVOfGUzsY5aT3H/xjLH+uAsYE3QkqZSX/G7LdBInvlrk5O1Ke1nR610ql33/xH/OD9TEvmezAh2gKgg4fsEtse8cSrvq/tno27lqigxLlqC05KYxggf8CD30Q0EkI2SzY17lfMfXhldOAOxCGesDy6rQP1wOm0mpntyUiPTgXySCmAJCvgtiKn30ttZBx4FN42Ai5WOoDmD9Whud30FiQVfF/5/LrQDvi+PXLAwcWs4DL87cB5MXSi1GcpU/EimJTqU7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uADPwr1Kj3+Dba8EUuZnUddbV6Pp33anYFktrJ+2Yl8=;
 b=V9tKVtT7fvd7ijevE80Iv6a/IBZZTttow+fS01xXwB9VqSCpO6mZcv6BYlvsItFW+bc3xDoQmjG1DKZ+wX/R2ArcAuspe6FRcY3sNiKxgY5Pq8WuCtWBrjJ6UKNdOEW6i8wU6ezo20Pu6x242mhz9n7oXMmoxpplT9k1Zt2zdqU=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 06:12:54 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::3db4:25a0:68a4:c946]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::3db4:25a0:68a4:c946%6]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 06:12:54 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Add missing check for dwc2_vbus_supply_init
Thread-Topic: [PATCH] usb: dwc2: Add missing check for dwc2_vbus_supply_init
Thread-Index: AQHYNEjSYwQOu5jYGUmpnzMSr3/cpay5tYSA
Date:   Fri, 11 Mar 2022 06:12:54 +0000
Message-ID: <916406bb-9025-a7c1-4894-79a539d767bd@synopsys.com>
References: <20220310063328.1581166-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220310063328.1581166-1-jiasheng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c464c2b-6286-4543-a82c-08da03262e44
x-ms-traffictypediagnostic: CY4PR12MB1382:EE_
x-microsoft-antispam-prvs: <CY4PR12MB13823B3BFC1D7132FF96DE36A70C9@CY4PR12MB1382.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WS6ZYfD/aRdFlxx7atHGKWkYVU8Fi4mSubtmKboCmXVYKh/mCeucfHiqVCivv6SQD3DFTtdLOasXI6BRzdIUCZPJjk0YZrX9Sny5JJAz1mmeWr/riT3V4grMKe+m5OKc1jUv0DJcChGh+pxaZB5zM123Z950JeGUdwRTxtecDY7Qgalfcb7Mj80CjR3C6Iiv2tEjs0cARcdGySZh3T16yAJ0jys9oaoQAotCbuhRE7bb+FgPp5d6GWSSgICxsuiwtw7fMIuCpoQHPLVON8GhSmVE07vYC56Ixi1iNmV4n8S5SdIfDh2NgyTkPbaEfDtPZpgLGffQyaKO2te/3GYye0r7kot3htr8GFDHx1Cxt/2c7FRujJQSF8cJCKviIabrDtw+eI19/CbYZ7YPissH4tKyJotjDBOuQ6tOUyH78DbbgnQNjvKlSRsBEUtOWLpdgxNsqx1PnsJ9f8AoQsBFYcOXRKHqzHuZXE669QumDzLyO69dNoiiMUoOOixI7V+Cj9STYvgLRbFCBzl1qZpOxSJNPAobNzwnYRGcSf8AFTYJD5HRMVf55BQgSO41KBOuF0ikyhIUYBEgDshtrMP7skyz56YZa3ZqhPfjA48SoJPKYbwuB4h4w+0RIgkeyPn3SJ7mmLDbHko/5qXRC45/DYrtVmq6a7HJXqzHvFLWB4QPLMILAit2N6e9bMzspKAhfHAZJe8ARUEUUKhOeUYpFJ1JJ7WdsRAL0Ad5dIcCY4LK8ytPtAhLkhYpCeas/I1JM20a2fMQyJIVo73/yeR+8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(36756003)(31686004)(53546011)(508600001)(26005)(71200400001)(316002)(2616005)(76116006)(83380400001)(6506007)(6486002)(2906002)(86362001)(110136005)(64756008)(122000001)(8676002)(31696002)(66476007)(66556008)(66446008)(4326008)(91956017)(66946007)(5660300002)(8936002)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDhVZ2c2ZmtoQjhvNElXSnBEM1ZHTExIaUlnb1BTbi9qVUVlZmtnbVJ6blRF?=
 =?utf-8?B?QTV0N2lkSmdoYXZxVjFGZ01hTC8vdFQ2emdIQjJ4aWR4cWVzR2JucURQejE5?=
 =?utf-8?B?SWtsZjIrNjdyYzFMZmlVYVI4Yy90QVJtY0p6VUdxMC9aOG42QklYZUg5Nm51?=
 =?utf-8?B?QU5KeHBGL1NUZFJ4Vi9wN1kxeHJnbDg5Q0FPZitJU3ZhMWY2ZmE5Z0lhc1Fj?=
 =?utf-8?B?Z3lvY2duNnJjU1ZCVlFCSmJDS2VVUWpoNmpqTnFTUkpsZDlOKzlVRWkvN3Y2?=
 =?utf-8?B?eVp0M01VaEZNWkR2MSt6UHZzZG84SE5HL2pnZWF3ZVoraVZ3b1VHSzhCMStm?=
 =?utf-8?B?TFozdm9JRjd0bnBvUm1uS1JTUjNyQXh6dW12TGFwQXFIcnJnQTdIdDZvTjJ5?=
 =?utf-8?B?Sng1bXVsSCs4NU9kMnRaYlZhZTZSWjFyYVZmSVZmTWMrbE1VU0paYjk3aFNm?=
 =?utf-8?B?U2IwWGpKT3FUTCsxaVQ4Z1gyY0N4OG5RSnBUbE9XRnFtR0JQMmZ0b0FHYmJt?=
 =?utf-8?B?cVB2d08xQ3AxVnVaeHZJRWpKMlBqYnF5T0o2Q0JPTE5FMlNYekRtUEZVZVdN?=
 =?utf-8?B?cTZJYTk4TDFhaElPRmtwS1Q5RUwrVytoZitja3NiVEFCbXZmRS96akpCaTdX?=
 =?utf-8?B?NytWV1cyV29aZFJGUUlYaTVsVTlabHJSUHNtTzhGYlNIYVJHN2lKYjdZMHVm?=
 =?utf-8?B?R3Roa3kxbXdhWndMSnhZMFFYTVlZaE5kWkhWZDlxYys2Q21DQUlEaFV2SmJE?=
 =?utf-8?B?Q3MxVUQ3NWVsVXVIVWFnMTIxSXlSNTdia1l6Y0xiZTdBeHplMTlqclBmWUIz?=
 =?utf-8?B?dHMrVHBkZGwxd3ZaT0ViZFlYalVXMHhrWElpRkQ0SkhSL2xhczhGSFJFd3FW?=
 =?utf-8?B?ZFhINmRGVXozUTg4NTdhK0s3SkdjOC9QdlRsNE0yc3VBV1NCcFZWSXNnTlR2?=
 =?utf-8?B?K0pjL21tazBWSk93bXFOV1lNR2lET3BuL3ZTQzF3NnFIVUhpY0xJK2wycjJO?=
 =?utf-8?B?ZzFjODA0b0gzcEw0UzdoMHZpeUtBUE90RUlGb1lQUytGdUJNNFVNTlZoVEJJ?=
 =?utf-8?B?YWlZMjRJOC9RbEhxcTBXUkMxVWR6dzQxd2grdUVlNFByOGZ6RXUrQVIwRHJV?=
 =?utf-8?B?N0E1ZHprb2x6T3RGbUg0QkdCdU9DQnp6N0ZkU0Y0WjhBOTNrZ293SVdveTNw?=
 =?utf-8?B?MEcxWFdyTTFiQ1NRN0Y4a20yZTVnNnBuV09ETWVSUGlveDNicVdRNWpvRHBm?=
 =?utf-8?B?cE1aUFNGL3hod2d1MVFwYnRiTGdoRlo1ck1EVy85T3lwMUlWVWwyRXp1K0Iv?=
 =?utf-8?B?ejRPMTA1TENJM1I1T0xQSFBIM2NGZGVrRlhDL3B6dGRnakoxVTVTMHVrZHRM?=
 =?utf-8?B?dzJRenU5ZVllcXZXWkl3QU42U1ZmSHZQZXY2R0VYdllOdlJvUm9ERUJtOUhm?=
 =?utf-8?B?ZDhRZ0pQMndxMm53N0lKdXR2amhtN3F2OFJ3ZFZYSmMyNFI1VFZLMUhZTnZH?=
 =?utf-8?B?SmNEWUxocDN6Yy9YdW56WWl6OGhkUlduZzM5dDNaMXhQZG9kOE9QSFFjOVRQ?=
 =?utf-8?B?OUp1aDIwdThlbjZrMzVYTGVIa0ZhT2YyS2YvS3JaOWV3RHBlNVVlL3FtbFlB?=
 =?utf-8?B?K0FuSXN5N3lJOGNkdUZQQ2RSVm44WkFROFR0dm1uWkVrNmsrbkJEVmhjTzNs?=
 =?utf-8?B?b1RZaGsvSnptOTdQVHNNR1Q2TExZcFVpVGdjWC95Y3ZLNEZ6elZSOFJhbVk1?=
 =?utf-8?B?TEpmTWlOSm9vQXdrTm03OG1GSjhZYThtdzFsanBLQ1ZCWE5UKzd1N2NvZy9D?=
 =?utf-8?B?VldPdkpWelFtb1JkQTFmTmZ0TUVyTWFvL2U0c3k0TXZoWGNTV2lNTjdwT0pI?=
 =?utf-8?B?Z1ZHU1NpSmp2OTg2SExxckRBdG5EZjZuUklQSXFiZnpEekdKNUhNaHBhM0xs?=
 =?utf-8?B?QkVhVm95K011ay9vUFRwRWVxMlZmaWlJZ2xGTHBEK085UHNkaW1kN3A5Sllh?=
 =?utf-8?B?QTVJWVJHTEg2RnhlblFoVDNxUUVwRGdvdFV3VjZsNmoyOGppc2JGSUZTWjdW?=
 =?utf-8?B?OE1MVjh3SnRoaDJOTWFPNml6Z0I0Si95eTZkTXVuQ1diaktkeGltSHBvVWN3?=
 =?utf-8?B?KzdYZ2h5dHlTMW1EZGlPQ0tQMFdwamFhSXpPQ3E0eHlycXIwaFpvNmVCakRE?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E7E1ABD4B9B6940BFD982E4F81FF2BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c464c2b-6286-4543-a82c-08da03262e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 06:12:54.2020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXjxb7SKiDLnVu0Ki92+7VGygGVu+VgF+2f/OToKWWhF3+aD1TkWhTpHSdu/pCnjd2pUA5LseNaJA/AEIbyfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xMC8yMDIyIDEwOjMzIEFNLCBKaWFzaGVuZyBKaWFuZyB3cm90ZToNCj4gQXMgdGhlIHBv
dGVudGlhbCBmYWlsdXJlIG9mIHRoZSBkd2MyX3ZidXNfc3VwcGx5X2luaXQoKSwNCj4gaXQgc2hv
dWxkIGJlIGJldHRlciB0byBoYW5kbGUgdGhlIHJldHVybiB2YWx1ZSBhbmQgY2hlY2sNCj4gaXQu
DQo+IA0KPiBGaXhlczogY2Q3Y2QwZTZjZWRmICgidXNiOiBkd2MyOiBmaXggdW5iYWxhbmNlZCB1
c2Ugb2YgZXh0ZXJuYWwgdmJ1cy1zdXBwbHkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFzaGVuZyBK
aWFuZyA8amlhc2hlbmdAaXNjYXMuYWMuY24+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlh
biA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hj
ZC5jIHwgOCArKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBi
L2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gaW5kZXggZjYzYTI3ZDExZmFjLi5jODc4NmQyMjNk
Y2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMi9oY2QuYw0KPiBAQCAtMzY3Miw3ICszNjcyLDcgQEAgc3RhdGljIGludCBkd2My
X2hjZF9odWJfY29udHJvbChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB0eXBlcmVxLA0K
PiAgIAkJCWhwcnQwIHw9IEhQUlQwX1BXUjsNCj4gICAJCQlkd2MyX3dyaXRlbChoc290ZywgaHBy
dDAsIEhQUlQwKTsNCj4gICAJCQlpZiAoIXB3cikNCj4gLQkJCQlkd2MyX3ZidXNfc3VwcGx5X2lu
aXQoaHNvdGcpOw0KPiArCQkJCXJldHZhbCA9IGR3YzJfdmJ1c19zdXBwbHlfaW5pdChoc290Zyk7
DQo+ICAgCQkJYnJlYWs7DQo+ICAgDQo+ICAgCQljYXNlIFVTQl9QT1JUX0ZFQVRfUkVTRVQ6DQo+
IEBAIC0zNzIyLDcgKzM3MjIsNyBAQCBzdGF0aWMgaW50IGR3YzJfaGNkX2h1Yl9jb250cm9sKHN0
cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdTE2IHR5cGVyZXEsDQo+ICAgCQkJCQkiSW4gaG9zdCBt
b2RlLCBocHJ0MD0lMDh4XG4iLCBocHJ0MCk7DQo+ICAgCQkJCWR3YzJfd3JpdGVsKGhzb3RnLCBo
cHJ0MCwgSFBSVDApOw0KPiAgIAkJCQlpZiAoIXB3cikNCj4gLQkJCQkJZHdjMl92YnVzX3N1cHBs
eV9pbml0KGhzb3RnKTsNCj4gKwkJCQkJcmV0dmFsID0gZHdjMl92YnVzX3N1cHBseV9pbml0KGhz
b3RnKTsNCj4gICAJCQl9DQo+ICAgDQo+ICAgCQkJLyogQ2xlYXIgcmVzZXQgYml0IGluIDEwbXMg
KEZTL0xTKSBvciA1MG1zIChIUykgKi8NCj4gQEAgLTQ1MjMsNyArNDUyMyw5IEBAIHN0YXRpYyBp
bnQgX2R3YzJfaGNkX3Jlc3VtZShzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0KPiAgIA0KPiAgIAkvKiBF
bmFibGUgZXh0ZXJuYWwgdmJ1cyBzdXBwbHkgYWZ0ZXIgcmVzdW1pbmcgdGhlIHBvcnQuICovDQo+
ICAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7DQo+IC0JZHdj
Ml92YnVzX3N1cHBseV9pbml0KGhzb3RnKTsNCj4gKwlyZXQgPSBkd2MyX3ZidXNfc3VwcGx5X2lu
aXQoaHNvdGcpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICAgDQo+ICAgCS8q
IFdhaXQgZm9yIGNvbnRyb2xsZXIgdG8gY29ycmVjdGx5IHVwZGF0ZSBEKy9ELSBsZXZlbCAqLw0K
PiAgIAl1c2xlZXBfcmFuZ2UoMzAwMCwgNTAwMCk7DQoNCg==
