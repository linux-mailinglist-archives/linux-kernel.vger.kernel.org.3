Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4994AD645
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiBHLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348233AbiBHJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:49:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ABAC03FEC0;
        Tue,  8 Feb 2022 01:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644313760; x=1675849760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+chmDD8jtf0IVStKfP0KZ6iXAQijgoNr4T0r/wm0uHU=;
  b=MFaKPPsYsCKhyl86x0mTTqDq7SFBlqT6P7chgsOl1W/YE4gLdLlm6Lj7
   Rbt0G1LueW08QvZNwqKO36lPGlokVSFuRPG3DtG49xshvnoVT0Id+czve
   s8tjined5LvhFOBUO8ctYkpfx0nvPxABSMFMgZaIPRvFXyAPMZyeehMwa
   bXOi0ku342wU6XT22xRlU5Vd3KWNqlB5rPwWPZ4KP32taYkyfRi+io1Yz
   JDsLW7rbehTSre6iBxwqrvg1kyorr8TibcNcPk46LAXjRY9d/X065kxOH
   TDBsISHNE0LzFGKRHtzajQxqmt0xjdgsIsRBIF/hg/rPEnqTJAvA0Y+Ys
   A==;
IronPort-SDR: PvghNCsLmnAvdKekfEAkS6KEiboQuEKXWzInV0dYlAvauae6HTY4txo6B0gKOJma5syIQRSxGd
 rxcfLLa2LFJf67kok47AHyqljXk42fRUmtFbuz0KOynHCKLXaTzHkNHY4f8FOf/Lmowm41g5Ii
 3g7lSFOLLrjJVU4p/CqKL1uBy7hhl7+NnIhHFsbdoAxk90EwwebQitPtlWc3IaHE1zjxYGINDI
 IUqeuMyhWxy1tNtEuac6JDEg9iFya8Dxii8Y92bWutGNc3OZzmnXFA7L8A9Rb2Y3LP1cMJ5VS6
 ziSyyAYrsHshVTpD9qXlgHER
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="161454621"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 02:49:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 02:49:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 02:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBjECbBOiKCDcYf6AZpMpy4CCLyZBSNK3B2zbO3sbykumbHdBtx83Ig4CEhlCCZ/T0+56LtXIpFvZgC7SGLWvzFhqCkqoybHMoXItrHiutgXF27vunUzO84OKewCwuVVjhJ6W4L2rGgN4dReaZXB6R2M3qKIpWWVR1LYNnXunP2GEZKjwT/xylzVRJG2N7SfXpwbfEnaimW4z4KRO1f6yWJGX7FvhTv66DtEMz9cszMeLjqe1JQB4L1yLszakLPPKIrD7oWR8Qo9wGVNmPR/5pAUVQP6xjy79C7YAbID5jLht6VhFOaHjSQExsqcHPTjM6PrsQWZtGGi3tyDAy/gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+chmDD8jtf0IVStKfP0KZ6iXAQijgoNr4T0r/wm0uHU=;
 b=Q5O+CHBOMuV6H6pM+3gaJFUE3aBrpOZoh/z+QwB+fCulczqVfEQp/bDPgjqZh7mz1I6dGLjhNs8hyAThreDXLyR/T/FI+5wQ91njoFZLvn1i8wqPN/tvOYxYKv+xAYPFElbM7biFxLLz4KZc+IRIMEZT7sFQ8Zze7F0wCLcl2uh/oP6U8L7q7ZPL7QTNV9IN7DrdvUANDpRPA+gh0GHv9PMAeeKlc53KJbXDb4Py68onEzPkGFwjq6pSQqTwalk3mMN4b7+27XxDgmRXYVsTM4Fpw5eNpyITOSWxFuUIu/tf5Sl7zTEblzr1Wn86p1/GB5Xizjsk79nhIF4Kr38huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+chmDD8jtf0IVStKfP0KZ6iXAQijgoNr4T0r/wm0uHU=;
 b=sQrU7p2qVNcF6kToqv1gdJkNC0KGp9YUomXPbPGV7WNu+NRa38OZGQLqswciCGiD8xaGwkHMeTgOdFCNwOk7w09QIxoXV45bWoOlBhA/DURU+wrDjVDUIQokpZiOTJEdBfNBRhvccWMSbCVEM6ASaF8Q4Q0QIsMwyAx+xA3CZew=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM5PR11MB2058.namprd11.prod.outlook.com (2603:10b6:3:12::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 09:49:14 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 09:49:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Topic: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Index: AQHYHKHL8qImLgFE70qvWtR3NAgIig==
Date:   Tue, 8 Feb 2022 09:49:14 +0000
Message-ID: <eba691b4-e75f-f3ca-5359-9dc8b3bd3558@microchip.com>
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-2-tudor.ambarus@microchip.com>
 <f8387f12-24f9-4a39-e9b8-3b83f1de078d@canonical.com>
 <ec358f0f-e3e2-a97b-e09a-d397edc65c72@microchip.com>
 <7b787aee-ceea-d035-38b1-02ba0bcd3f21@canonical.com>
In-Reply-To: <7b787aee-ceea-d035-38b1-02ba0bcd3f21@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2ac3562-1eaa-4b7d-7974-08d9eae8441d
x-ms-traffictypediagnostic: DM5PR11MB2058:EE_
x-microsoft-antispam-prvs: <DM5PR11MB20581477DADD2E6009C72545F02D9@DM5PR11MB2058.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APlOMr/qbVP45P5r2mSO/0m6o7lH/4GpczcYQe3O8S0T9EpqdFGydTposPmXelZHV8w9rfhiRw7zeq5PJ+R0fxI1CzjC/LdwjX3fPU3XjNs1bDBP4V8ekOW4aBQbNEDSHW1njS5BUzhdPjULolTMA0ncOiUqgRVQ1ekmLNer6AZwOMWp3ojVzdfCDRS9t4+ohWV+bcz8veMnuwphXV4sf5WU0uK2fZzJ6tCuin3YGW5advsvCVNllQ7n0zpzKP296/RhFIiWNlAErBTEicosbh4Lugb69x4mpmCKuSTIRF60SoblzwzYOriSJvwa+iw+oU1Vq11av57PcDw7CW6JeobaUHbTIFTbipZIcBqG+rYtbfLaO29BjCmqzO1j3IKsf/2lX9Mo4vDI63xCV2M8qIfzwMixrFyb5mCn3/991T3TwyEc/n0LiDfwDPpcrOZZ+QTfbvHUI/+8oIX15CZvad/C28osrCaRDnbfjvBiOsMixgqrqJ9R4Zc1BtaN3bIrwMs0d5RoYaTzlAGZSXXpmkX8wjqHnNf8zRchE1IniERVHR0hG9DAx341XhlQeSuP1/s/nNhMyP4G24UIL2lBVP0hIS9K+ZymNSdyPmKXf7ZmdYYZDkCqH10uwDd5DaYPhRm3vtW8jkRZ6RWxgXEFx5bQxowybdCt3/rpZ8QbU7QH+k8n+76c/OPGJz/VVR2cz2JOE9gE1D3ywdq63oC71LibRIYNTTUzNtbTlrnHU0tsnKbeiKfmHVWmyJbdnRx9tRJq3AMJR154BuubO1ztkPneRs9pBmHiU72r5gs6EEN08Z8vEVRGDpo8xNh3hQjB6NiuMhyqJ6ishDVzPzmvG9fH8MI1vpj4ars4bqEshw7o7z6bWU7ZW00ZLrY/Q7n6T/o2rpoeNkGC31bpByiBYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(31696002)(54906003)(5660300002)(316002)(86362001)(83380400001)(53546011)(36756003)(6506007)(6512007)(66476007)(26005)(91956017)(76116006)(38100700002)(8936002)(8676002)(4326008)(66446008)(66556008)(66946007)(71200400001)(64756008)(122000001)(6486002)(31686004)(508600001)(2616005)(966005)(2906002)(38070700005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bCt6Z0p4ZkR5dW96WmpjUTBtOVdXdjgrbWZ2NG9QbmtDR1NRZVNUM3VmQ3BL?=
 =?utf-8?B?dUlKc2c5MjB0Z3FVblhzS3k2WGxKcHVERkRIdkN6eFAyZVByWVVjVEc1c3dz?=
 =?utf-8?B?VkRZM1VGQS9tckZkZFNhRTlrVGhLRGhmcE1YS2t1c3QrZi9CcS94aG02eWVU?=
 =?utf-8?B?UzdQQUtyVTV0cEFVT1hWZWM5ZlB0U0ZHU2YrUWwyMGs5T2t1Q2tvRHZYN09v?=
 =?utf-8?B?MFBVbnJ3NUpkaWY1d1JTalNGYzM5d2FRNkdERjQyQWpuVGs5aEl5Y21oUmF0?=
 =?utf-8?B?MDRKM3VWdTIvNzhZY05FN0c3aDBNQzZLNmpRbnBOSEs3aEk3Y2ViRDdiZEVk?=
 =?utf-8?B?OGpLMGluaU02eURjUEdYeDZ5emMzTUpkRm9KYnkzZDR1dk5HRlRId21xeXdw?=
 =?utf-8?B?TCsycEZucWpCN1Jhb1RPcWMzNXhSeDhnSElvRm1JWnBlQ2p6cERtd28vM04y?=
 =?utf-8?B?aHp5c21vYUNRNWhjTlB6RnRzVUZJL09EbWhSZ2lPNzFBcm1UVG85S1VxYkJQ?=
 =?utf-8?B?cFZWbDhUNEIwbVJ4a0VEMHFoelp1TktCMHdDeEwyeWo4NEVySTFZMTFPTDRS?=
 =?utf-8?B?T3ZOR1dXSDBhSElwaTZOYUU2ZjExSlVPbW8yVkZlQ0M2L1BDUCtwd1RHZzF5?=
 =?utf-8?B?OGR5L2ZXK0hyNTJKYTBlNTZkYTl5RUNZUm1IQys0OGRGbWxEaEJzeXZac0RY?=
 =?utf-8?B?a1BvaGs2SGp3bjlpV3hpbjhJWElOdndEcVVrK2VaK2FrVk9qaldMWG9ENDlP?=
 =?utf-8?B?Q0lkQjhHNUh1UUJ0eEFsUXlGcm9GVGMrOVhiQVRhM1VUVThzZnNqd3JkMjZZ?=
 =?utf-8?B?R0ZRYjIweEZaNHFqdXJHd1hLYjZMK1hMa2ZnYzF1NmNaVjlrTnNGeTk4d0J6?=
 =?utf-8?B?NUQ3RCtmV1gySUNCQzJncW4yZTVhRTZWUEhaRytQSzFSTG8raTB4WDlxamhH?=
 =?utf-8?B?L21tK0JoYzl5bFFGTGJFYS9xWUhzTHEwZGZ6Mlk1RnVNY2Evdm4zK29qbTJa?=
 =?utf-8?B?KzlUWGszUHVLTUJ2MEZRZWljMWxaTlRLcUs3S1AxUjUzbGN2ZnNPcmZ4cGN5?=
 =?utf-8?B?QlpnZXViY0dkMDcvKzB5UDJjOEhoU0UreFAwaEJiOXpwaDh4eGltNmtiT3VF?=
 =?utf-8?B?NEtwallENWpVWTU0T2VEbnh3RGVBaHdPMTJwMUV5Rm1hS1ZyMHh0eHFIdjh5?=
 =?utf-8?B?MUFZald3bVphM1E4UlB1K1paaGM2UmZyMGlGN1ZwaFEwekVNQWRLSEo5TkJD?=
 =?utf-8?B?Q2dnOW1Ld3I5NTh3RmRJUHBidVJ3TForb1IzN3gyNTlUVkRvV1pGVDlBcnVE?=
 =?utf-8?B?YXJLVytKQ0hPTEdYN055RUpveDU3Y0xKYmtCdHdLVExuZ1JZbUNGNFZJeitH?=
 =?utf-8?B?YWVrOWNBZG1KYW93TTQ0V1ZiK2hKRW9Zbnl2d2VBT0JvRWhXendDK3B6b3Vt?=
 =?utf-8?B?eno4R2liQ0RJK1JGWHpzU2QxdTFJL1I3UEFYZk1rR0xyME9KanUvcUhvZ25p?=
 =?utf-8?B?ZVBIYmJRVHFlekJHMXlvdDMrYmtHZ0FpUml4S05rT0F1MXFGbk5JSnlRSWlV?=
 =?utf-8?B?ZTkvMjQ2KzgxUEcwYStoVTYxZnVaR1FsWFBheWpkTi94dkpURGpjOGlkZGwy?=
 =?utf-8?B?RjlSallqNmp4eGtzVGpBOFlrOUNPM2NPOU5Cb2puSGVyWU9EZ0hYM0pEN0JZ?=
 =?utf-8?B?eWtMeHN2SFlHVTg0RDF0Mm1yOElVZzFpV084Q0NROTBmSks0YS9SRUJIbVc4?=
 =?utf-8?B?VFZUNmpNRk1ZMUFkbE90dU5uTGhiMEdYbThDVjNGYnBNUmx0SHk2UnlKWCtq?=
 =?utf-8?B?VEU1dkRmcDBVTkpaVmdEV3k3OGc0eE90cWdUT2ozWWtDQ244dDRMdXNpTUxM?=
 =?utf-8?B?bVJVVzdhNE4xY2FJOHZGUlhQQ1FOUVpJeXdvMzBIRFBPaUQxOVZLd1JDbDcr?=
 =?utf-8?B?ZjB4ajJjV1NidW0vNzVDWmcxNXBwUkljSEsrVjlsaGVEaUc4R0haL2hSTXlU?=
 =?utf-8?B?T1VUQUc4WUpEOVBnaWZLL1Vvb2xmYU5vV1N4Nld0OUZONWIvUllTMFJXdzh1?=
 =?utf-8?B?NkdzaTNQLzU3WVN6NVVFVUtSaXBCN0tXMGJ2d0RobFlzWmUybVNCZThoYjJT?=
 =?utf-8?B?RWF4OG9oOXU0RFByUGNkaEJiTVVJck5naHhUZ1RWa1o1YTl6YlJ2cUp3TnFr?=
 =?utf-8?B?WTF2THI2R3lQUGEyN1NhOTIyU2g0RklzR1ZNUlo1ODJmaFgySGpxdHE1MXl5?=
 =?utf-8?B?dnI1UHpTNlVmTWwyT1VnRkhNNDd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <465A7F0D460E854EAB7CFB60FC1F8877@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ac3562-1eaa-4b7d-7974-08d9eae8441d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 09:49:14.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGewukT7qFQYb/Fz2Cmahdqqy9AJHMF4TkwaEQhQUQ1Vb+w75MFevx/G1ms0JuG93Zz9QeFrBpQzAAbvUq+etcHhJtTSdjjElhL3zRQOKxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2058
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzIyIDEwOjU5LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA4LzAyLzIwMjIgMDU6MTAsIFR1ZG9y
LkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpLCBLcnp5c3p0b2YsDQo+Pg0KPj4g
T24gMi83LzIyIDE3OjU2LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMDcvMDIvMjAyMiAwNDoyNCwg
VHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4+Pj4gQ29udmVydCBBdG1lbCBBRVMgZG9jdW1lbnRhdGlv
biB0byB5YW1sIGZvcm1hdC4gV2l0aCB0aGUgY29udmVyc2lvbiB0aGUNCj4+Pj4gY2xvY2sgYW5k
IGNsb2NrLW5hbWVzIHByb3BlcnRpZXMgYXJlIG1hZGUgbWFuZGF0b3J5LiBUaGUgZHJpdmVyIHJl
dHVybnMNCj4+Pj4gLUVJTlZBTCBpZiAiYWVzX2NsayIgaXMgbm90IGZvdW5kLCByZWZsZWN0IHRo
YXQgaW4gdGhlIGJpbmRpbmdzIGFuZCBtYWtlDQo+Pj4+IHRoZSBjbG9jayBhbmQgY2xvY2stbmFt
ZXMgcHJvcGVydGllcyBtYW5kYXRvcnkuIFVwZGF0ZSB0aGUgZXhhbXBsZSB0bw0KPj4+PiBiZXR0
ZXIgZGVzY3JpYmUgaG93IG9uZSBzaG91bGQgZGVmaW5lIHRoZSBkdCBub2RlLg0KPj4+Pg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVs
LGFlcy55YW1sIHwgNjUgKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgLi4uL2JpbmRpbmdzL2Ny
eXB0by9hdG1lbC1jcnlwdG8udHh0ICAgICAgICAgIHwgMjAgLS0tLS0tDQo+Pj4+ICAyIGZpbGVz
IGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPj4+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRt
ZWwsYWVzLnlhbWwNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsYWVzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGFlcy55YW1sDQo+Pj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjc3ZWMwNGRiYWJlDQo+Pj4+IC0tLSAv
ZGV2L251bGwNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Ny
eXB0by9hdG1lbCxhZXMueWFtbA0KPj4+PiBAQCAtMCwwICsxLDY1IEBADQo+Pj4+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4+Pj4gKyVZQU1MIDEuMg0KPj4+PiAr
LS0tDQo+Pj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2NyeXB0by9hdG1l
bCxhZXMueWFtbCMNCj4+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIw0KPj4+PiArDQo+Pj4+ICt0aXRsZTogQXRtZWwgQWR2YW5jZWQgRW5j
cnlwdGlvbiBTdGFuZGFyZCAoQUVTKSBIVyBjcnlwdG9ncmFwaGljIGFjY2VsZXJhdG9yDQo+Pj4+
ICsNCj4+Pj4gK21haW50YWluZXJzOg0KPj4+PiArICAtIFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFt
YmFydXNAbWljcm9jaGlwLmNvbT4NCj4+Pj4gKw0KPj4+PiArcHJvcGVydGllczoNCj4+Pj4gKyAg
Y29tcGF0aWJsZToNCj4+Pj4gKyAgICBjb25zdDogYXRtZWwsYXQ5MXNhbTlnNDYtYWVzDQo+Pj4+
ICsNCj4+Pj4gKyAgcmVnOg0KPj4+PiArICAgIG1heEl0ZW1zOiAxDQo+Pj4+ICsNCj4+Pj4gKyAg
aW50ZXJydXB0czoNCj4+Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4+PiArDQo+Pj4+ICsgIGNsb2Nr
czoNCj4+Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4+PiArDQo+Pj4+ICsgIGNsb2NrLW5hbWVzOg0K
Pj4+PiArICAgIGNvbnN0OiBhZXNfY2xrDQo+Pj4+ICsNCj4+Pj4gKyAgZG1hczoNCj4+Pj4gKyAg
ICBpdGVtczoNCj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246IFRYIERNQSBDaGFubmVsDQo+Pj4+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSWCBETUEgQ2hhbm5lbA0KPj4+PiArDQo+Pj4+ICsgIGRt
YS1uYW1lczoNCj4+Pj4gKyAgICBpdGVtczoNCj4+Pj4gKyAgICAgIC0gY29uc3Q6IHR4DQo+Pj4+
ICsgICAgICAtIGNvbnN0OiByeA0KPj4+PiArDQo+Pj4+ICtyZXF1aXJlZDoNCj4+Pj4gKyAgLSBj
b21wYXRpYmxlDQo+Pj4+ICsgIC0gcmVnDQo+Pj4+ICsgIC0gaW50ZXJydXB0cw0KPj4+PiArICAt
IGNsb2Nrcw0KPj4+PiArICAtIGNsb2NrLW5hbWVzDQo+Pj4+ICsgIC0gZG1hcw0KPj4+PiArICAt
IGRtYS1uYW1lcw0KPj4+PiArDQo+Pj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+
Pj4gKw0KPj4+PiArZXhhbXBsZXM6DQo+Pj4+ICsgIC0gfA0KPj4+PiArICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+Pj4gKyAgICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPj4+PiArICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9hdDkxLmg+DQo+Pj4+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2RtYS9hdDkxLmg+DQo+Pj4NCj4+PiBPbmUgZW1wdHkgbGluZSBmb3IgcmVh
ZGFiaWxpdHkuDQo+Pg0KPj4gT2suDQo+Pg0KPj4+DQo+Pj4+ICsgICAgYWVzOiBhZXNAZjgwMzgw
MDAgew0KPj4+DQo+Pj4gR2VuZXJpYyBub2RlIG5hbWUsIHNvICJjcnlwdG8iLg0KPj4NCj4+IEht
LCBJJ20gbm90IGNvbnZpbmNlZCB3aHksIHdvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBtb3JlIGRldGFp
bHMgYWJvdXQgdGhpcw0KPj4gcmVxdWlyZW1lbnQ/IFRoaXMgSVAgaXMgY2FwYWJsZSBvZiBkb2lu
ZyBqdXN0IEFFUyBvcGVyYXRpb25zLCBJIGZpbmQgaXQNCj4+IGdlbmVyaWMgZW5vdWdoLiBXZSB1
c2UgdGhlICJhZXMiIG5hbWUgb24gYWxsIG91ciBTb0NzIHRoYXQgaGF2ZSBhIHZlcnNpb24NCj4+
IG9mIHRoaXMgSVAsIHRoYXQgd291bGQgYmUgcXVpdGUgYSBjaGFuZ2UuIFNvIEkgd291bGQgcHJl
ZmVyIHRvIGtlZXAgdGhlDQo+PiAiYWVzIiBuYW1lIGlmIHBvc3NpYmxlLg0KPj4NCj4gDQo+IFRo
ZSByZXF1aXJlbWVudCBjb21lcyBmcm9tIERUIHNwZWNpZmljYXRpb24uDQo+ICJUaGUgbmFtZSBv
ZiBhIG5vZGUgc2hvdWxkIGJlIHNvbWV3aGF0IGdlbmVyaWMsIHJlZmxlY3RpbmcgdGhlIGZ1bmN0
aW9uDQo+IG9mIHRoZSBkZXZpY2UgYW5kIG5vdCBpdHMgcHJlY2lzZSBwcm9ncmFtbWluZw0KPiAg
bW9kZWwuIElmIGFwcHJvcHJpYXRlLCB0aGUgbmFtZSBzaG91bGQgYmUgb25lIG9mIHRoZSBmb2xs
b3dpbmcgY2hvaWNlIg0KPiBBRVMgaXMgbm90IGdlbmVyaWMuIEFFUyBpcyBzcGVjaWZpYyBjcnlw
dG8gb3BlcmF0aW9uLiBUaGUgc3BlYyBnaXZlcw0KPiBleGFtcGxlIC0gImNyeXB0byIsIHNvIHVz
ZSB0aGlzIG9uZSBqdXN0IGxpa2Ugb3RoZXJzIGFyZSB1c2luZy4gQXRtZWwgaXMNCj4gbm90IHNw
ZWNpYWwgaW4gdGhhdCBtYXR0ZXIuDQo+IA0KSSBzZWUsIHRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0
aW9uLiBJIHdpbGwgcHV0IHRoZSBub2RlIG5hbWUgYXMgImNyeXB0byIsIGFuZCBhZGQNCmEgbGFi
ZWwgdG8gaXQgYXMgImFlcyI6DQphZXM6IGNyeXB0b0BmODAzODAwMCB7DQoNCkNoZWVycywNCnRh
DQo=
