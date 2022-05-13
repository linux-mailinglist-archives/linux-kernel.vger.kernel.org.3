Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E19525C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbiEMHSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356439AbiEMHSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:18:35 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FF58E44;
        Fri, 13 May 2022 00:18:31 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B4F3D405F5;
        Fri, 13 May 2022 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1652426311; bh=KCkZdml6A01N6Dbs+1Bd8kZ/lT8zZHnep2tB3pkfImw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hHwACrHZ2tVAsAraVbfX8kL7RcF0MgmYWmzhETecSbBo3CJgyc+DlFALN2Lm07F2K
         3/fsgs6HRXjN/qfb5PhQ7sSO/EWr5enF2+NsFk2Kr0Jf+e8Sb84t81X2MXNRR6w2Og
         j3W/i8ISnqIznIt3q8XH/pUrQccv3QhswmIiev+lGXPxNhPXShzIfgJRHJ59ieNwrQ
         W6q4oB5R09Evg1ztUAaUWVXKIZuWxbM7kDLO+p1W3Hg6E0uF9XdaqQNn2OAsXS0HcO
         BZf41VN22qrUMPlV9hnB2vr4S3j9xMpO3DA6tg3nb6ePXJSMp2wu10+BKmkKpII6rg
         OSXUuaxISimLA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DAE11A0070;
        Fri, 13 May 2022 07:18:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1484F8012D;
        Fri, 13 May 2022 07:18:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nHCLClvY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Xe5XbzUUTuOsMJKsWEzlRotKpjP1JFmenegaicUaN2D4mzy177dXqivKPqwQFu8wgz/54aVDXEbOGdxPf8CED1a0zv4i0dHuUInZ12O+jEBXPQiilExGL9jlP9MB+c7ezzlnuu5s6OfcJeQKhg5X0eqahtuZy5UJVh5eK+EOoKkFWbOCmGferYj2JdSUpA2CgEtFCFJ82dLgRfplAuhvlzkuagKI69lPp+qMLf+agWd6uheMJsbk0AkyDzcDGqlWEelpQyEK4L6nMEmZ3tH0bbyWfc2zmZTIUk6ZvXRnEPHdXhxqGJdTBKYW7y8rVUEnUdNnB5MEC/i6suSoJkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCkZdml6A01N6Dbs+1Bd8kZ/lT8zZHnep2tB3pkfImw=;
 b=LLASQ79teXlSKumQLJd8fwldbW+XJBy+m28ZMs0t5jzZ+fzUvYBHlOLdPdPVlpjAudRa+F5e4myO5yP67WiIiQzWzHNTaDq4GXlGxiPYtlXrZG/pD+vm8Ccv8OesgPDsW9caHBgYZl4/cbMRSJiANxFAweaa60iIljUN4x8vKF3leDX7wQtM4V3bp9etrrAWqvWjjBJ9EsXEv64mi5bBonXAgCWXKLMuCoAFEwNY0Vce3K3Xy9ctbKjxgpMeJ16t2OfBhg20StRU3FCRA999qyrUR5R09IRxxejnMKyKx5n6TqF49JIxa1gDkhGzRxUFJq0YAZ98LYKMjirlxUh6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCkZdml6A01N6Dbs+1Bd8kZ/lT8zZHnep2tB3pkfImw=;
 b=nHCLClvYS9na2kWF+D0Ng8ogcSvuNCTPvjCpOT5PL9FIAVO56XIbUaFvqArt3iihG7o4r9UOFNiP58Xyu/fhi7ISfJpX0zvacaNjz61mMxAfV5hdyrWdkf4tfWe85d9QwwwEhBpnDu6NJHwb459a6XUPnCJHtwMS5QcwE2/6uR4=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 07:18:19 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::383f:f351:6ad9:9967]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::383f:f351:6ad9:9967%6]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 07:18:19 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: dwc2: gadget: don't reset gadget's driver->bus
Thread-Topic: [PATCH] usb: dwc2: gadget: don't reset gadget's driver->bus
Thread-Index: AQHYYG1mrp3Em42o60Wtc6z85hdJCK0ccmOA
Date:   Fri, 13 May 2022 07:18:19 +0000
Message-ID: <40bf9f88-ec75-4049-412c-fd489c384205@synopsys.com>
References: <CGME20220505104630eucas1p1e3797aef5ed7f54f861bf3622b542713@eucas1p1.samsung.com>
 <20220505104618.22729-1-m.szyprowski@samsung.com>
In-Reply-To: <20220505104618.22729-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0dd4d7a-b358-4cbb-e517-08da34b0c1c6
x-ms-traffictypediagnostic: BN9PR12MB5241:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5241BB513B926BF997B01795A7CA9@BN9PR12MB5241.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSP4TfsXcKCOBGwRYP8eNEVhIFzPzaRY+sKOuuompw+cQAack6T+ZTi+UhDSuC7U/44/IREN13or0kQgnvgEacE//QJIGdkr0WF8lGeT0c5jDjc9l4pzxGh1Kd+jT1NMCgdaUFU6etbfb7fUxGF2CEi6GAHcUrCtCNOgJbRJlIlfgtVGJjAbkglNFkO9Csbk17D/AjIE05MMDiPKRJi8UJHcYhgh3OZQVraXsPDeWVfaP0D8vlvUFW9R902Sgdyuk3aJ4ViAFLTYkcTAEyxQkjFzeq4NUyZbLjwtrBAiUd9dP3M+unwwpZ7kIuQo+I8GT+n3xmST/simeiDgN8P5EOPiZX/aHBkwOEd5ypbGORxNcclKZEn7PtmCz8RU4epbC/9BWO/v+ftAP+RetHsITpNKObKq4K5oDhz9+oCWlVaoE33JM6Pj5fUmjjnkskaachmmI5uUU24ViMStvaoowiFvi7kf0wIAOBFrb11SPH994/TNWiRfAkyduaF3f/OIv7sODx/YX6zdZWx19uqDQk/fAAlvVXW7+eoG4uNIeRFrH3pVAPF2IEzeRbt5tJSOXk3WETn4lsIFM3MF7URzazWtUx+oNQn2kGSBeQg3Vct1aZ9YQNLZMI9FcwjU8tTvewLMGewDR603bfeX3WcP3GcastDtRYtFipzu+TeHMv5idbc7QfVaX9ySzN5fm86p5Lq6GYj5p6OsMKfO8ZoX5ZKzAEmdi8GH+tKvWl/Kud+2sxdvnDYqU8mOqhVPHu85EKf/hXDnRDzFua62I/zlwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(71200400001)(83380400001)(5660300002)(31696002)(86362001)(64756008)(122000001)(2906002)(8936002)(6486002)(508600001)(76116006)(54906003)(38070700005)(2616005)(6506007)(6512007)(38100700002)(4326008)(31686004)(66556008)(26005)(8676002)(66476007)(110136005)(66446008)(66946007)(36756003)(316002)(53546011)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05vZVdzZThkaWdFMkNkVm5lMG04OVptamptOTV1OUJsbGtLNHBxYmlsSEVD?=
 =?utf-8?B?bjArSmVDMk1RUlhGNVZNeGtabzN3ZGtiMjRyWlBXSkp3bEsrY21uWEs2ZElZ?=
 =?utf-8?B?QWRXUHcyK3JuRHI1eWZlcFRiYzZNdlg3YmF2Q2xBNXBDU0hrN2NGUjROK3hj?=
 =?utf-8?B?K3FPcmZsM3cvOG56T3d6R05TaDczOS9UNS9sWm4wSktRWDQ3YVRBclpMUStv?=
 =?utf-8?B?bnlVRkdOcUhCalVyTW9OWjRpR1pjUnQzajU4UnBMNEtqU0RLbFJsMmx4SGdm?=
 =?utf-8?B?UVU1dDdWbGhnOCs1eWl5ZHFHMFZ1UDV3RWxqcXplNHZydmtOWkFkVnJxYmlx?=
 =?utf-8?B?NmNpUHNSQm9pQ1FMTXJLWmhydWx2NmladS9wcW8vYW05Z2d2bEFKYjA2SkJw?=
 =?utf-8?B?RkJwaWJPaFVaT0pxWWYwNHRIRG1BdERNZXRjQVZOZTY2UzM5T3kyV1c3dXFl?=
 =?utf-8?B?OVk3djAwSzM3ZXZ4ZVBUT2ZyNWU1cFB4V2IzeEUrcDIyaDI5SFI3aFJBaWZD?=
 =?utf-8?B?dlN1My9pb2NGWXlBRmtxVjN0U0tIbFFrbWRacFcxVUo2KzlWMTkzbHZ5eml2?=
 =?utf-8?B?TXEzNEJjMWpjYXFCR2toOU05bUlTNUFmd2dVMUdOS0gycC9oSEM3dTJrWk80?=
 =?utf-8?B?SWN1V3d1b3ZjZm1kTG5yWVdnWUdjSGhOSk10WHdtWUZuQzI5aGcxZktWUW9O?=
 =?utf-8?B?S3k4c0NWZGRMQzZ6SkRJTTFod1F4VzZ0d2R2ZVhpRVI2NmZEUmlJVnpTNjZB?=
 =?utf-8?B?Q2t3bWZEb2NqcVNTSnpsdkFLckJhQVNxZWlZY3NMUlY1OFhBMHh0dUU5RWhi?=
 =?utf-8?B?cjFERXRBWlA4dU9PbC9vQ3N4Z0dpWlYzVmNsM0Z0T1hHdUhsSU03bnVWOXNH?=
 =?utf-8?B?aFAxeG82VERkK3hEeGo5K1dKU0xWSDZQbDhidE1nMmp1QnJaRE9iYTdWY3Np?=
 =?utf-8?B?M0NvSU1nOHh2TGoxMHB6NnBDS3RTb0twRHBlWVVmYjc5NlNLYy9QN0lvVzBi?=
 =?utf-8?B?ZGt4eWhSZS9zbncrUGw4Vm5OYlVsUkY4V25udWt2cFZoaTloRGxWanRqakxC?=
 =?utf-8?B?TmYzNlIzQm5xTWZYZ0t1Sncvc2xPN3VocUV2VGpUV3lLTjg3QkNHY05YTEhY?=
 =?utf-8?B?SjRsVUJISlc2RmZXU3lPb0tFWWtid1JRMmQ5c2I2M2dUQUZ1ait4b2xYdmln?=
 =?utf-8?B?VW5DSjdGdkxwRnBWY2JFajkyNDNicUdIajJKbTcyaGZZWEM5cUgwQkhVanpq?=
 =?utf-8?B?NmpHOFlpS1JVYU14VUhHbUZyczdwSVZSUDFpbW41UXpNTXhaVmxCUURFL1pJ?=
 =?utf-8?B?LzVBRzFOQzlFTGV2Nk1DMjBTOTRhNHFYYTNlL2t2VGwvcmM5M3BsM2dtN3R5?=
 =?utf-8?B?dDQ0bHFNemhtN2VIY0l3U0EyS3F1dUlrNHExTmZoZGJRdEt4aTQ5c2ZSa2dh?=
 =?utf-8?B?ME5qcjdNOGw5V0l0ei9tUzV2SzJSSk85cXU5ZGJqNGZPcjJZcXJHbllRcTBC?=
 =?utf-8?B?U2JReGhxS0c3cWFPZTB1TDhEYnVGaTZOemxvRVJOOUNoOHRFRS90YitZQ0li?=
 =?utf-8?B?N3cvWitIcDZwSHIwd29ZTVRoeDl3aHpDT1I2R2taRFBQdUJkK3d3UXhUajF2?=
 =?utf-8?B?MTdNTytWZmpjNHhTbVVZZm1JdHc4dXA1bU9YaWg3YnU1Mkl5Y1pLN08wU0VV?=
 =?utf-8?B?a3ZWbFEzbmxrcTl1NG1VdzNjRGdOQXkwK0thRnc3dGlOL3RQWDgvQ0hsd1lC?=
 =?utf-8?B?emo4T29nNWFKMXRNb25SUmVWYUwydFRDNHI2dXp5QXZTTFhTd3NWZFYzcDFk?=
 =?utf-8?B?dVBrNVJMT2tUOXR5SU81NTJSbkt0Qkd3RllFdUZWL1VNd0E0MUk3VzFZQXVi?=
 =?utf-8?B?cUJydWE2aEozMVpDZDl3WFlkVGdtUkM5QU1ONjB1Y3hwdXJrYWJ5a3IzcnBl?=
 =?utf-8?B?Q0pWWmx2bjZ6NUJZMWwyMnhNaGl2NWtaWEx1Tk5BaHQ1S2FhS01wdVZqbzkz?=
 =?utf-8?B?ZGdDcldRN1BOVU9LcW9mazBOZnNveTZLZU1FclN5d29rNzhkbkt6WHowZ3Rh?=
 =?utf-8?B?eDNqRzB2SjlrSDlpQkNmMUllTEUxL0Q4WUR0K3dBTTFXdjRQTjZpK2J3bkRz?=
 =?utf-8?B?WlY4czhhVkprUmFJK2pyekdvV2ZHL1FZTUNNcTQ1THhPOGo0QmFPNVVxakpw?=
 =?utf-8?B?K0JQRUJMN3VoT2Y1UkJWVjZ1Y2hSZHRYbTYramxkUWwrTVdhOHlaQnE0dDV1?=
 =?utf-8?B?aTFDajg3SGkrRzRqWmZSanRyem4xT1JUQlQ5eGlBMURZQ21xcnpaTDB6UzZG?=
 =?utf-8?Q?v8rju4VB1fT17OWpK4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94DEBEBB06A6074196C47492C712D45E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dd4d7a-b358-4cbb-e517-08da34b0c1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 07:18:19.5959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7snsHCh3MvOL7bE/5QxRXVeXoJuegOLLqT9CNY+n+Vfo5bwz/CUlFery7ahOWDNFzVF0ymt9kSaRDb3dZJq0wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS81LzIwMjIgMjo0NiBQTSwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToNCj4gVURDIGRyaXZl
ciBzaG91bGQgbm90IHRvdWNoIGdhZGdldCdzIGRyaXZlciBpbnRlcm5hbHMsIGVzcGVjaWFsbHkg
aXQNCj4gc2hvdWxkIG5vdCByZXNldCBkcml2ZXItPmJ1cy4gVGhpcyB3YXNuJ3QgaGFybWZ1bCBz
byBmYXIsIGJ1dCBzaW5jZQ0KPiBjb21taXQgZmMyNzRjMWU5OTczICgiVVNCOiBnYWRnZXQ6IEFk
ZCBhIG5ldyBidXMgZm9yIGdhZGdldHMiKSBnYWRnZXQNCj4gc3Vic3lzdGVtIGdvdCBpdCdzIG93
biBidXMgYW5kIG1lc3Npbmcgd2l0aCAtPmJ1cyB0cmlnZ2VycyB0aGUNCj4gZm9sbG93aW5nIE5V
TEwgcG9pbnRlciBkZXJlZmVyZW5jZToNCj4gDQo+IGR3YzIgMTI0ODAwMDAuaHNvdGc6IGJvdW5k
IGRyaXZlciBnX2V0aGVyDQo+IDg8LS0tIGN1dCBoZXJlIC0tLQ0KPiBVbmFibGUgdG8gaGFuZGxl
IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAw
MDAwDQo+IFswMDAwMDAwMF0gKnBnZD0wMDAwMDAwMA0KPiBJbnRlcm5hbCBlcnJvcjogT29wczog
NSBbIzFdIFNNUCBBUk0NCj4gTW9kdWxlcyBsaW5rZWQgaW46IC4uLg0KPiBDUFU6IDAgUElEOiA2
MjAgQ29tbTogbW9kcHJvYmUgTm90IHRhaW50ZWQgNS4xOC4wLXJjNS1uZXh0LTIwMjIwNTA0ICMx
MTg2Mg0KPiBIYXJkd2FyZSBuYW1lOiBTYW1zdW5nIEV4eW5vcyAoRmxhdHRlbmVkIERldmljZSBU
cmVlKQ0KPiBQQyBpcyBhdCBtb2R1bGVfYWRkX2RyaXZlcisweDQ0LzB4ZTgNCj4gTFIgaXMgYXQg
c3lzZnNfZG9fY3JlYXRlX2xpbmtfc2QrMHg4NC8weGUwDQo+IC4uLg0KPiBQcm9jZXNzIG1vZHBy
b2JlIChwaWQ6IDYyMCwgc3RhY2sgbGltaXQgPSAweChwdHJ2YWwpKQ0KPiAuLi4NCj4gICBtb2R1
bGVfYWRkX2RyaXZlciBmcm9tIGJ1c19hZGRfZHJpdmVyKzB4ZjQvMHgxZTQNCj4gICBidXNfYWRk
X2RyaXZlciBmcm9tIGRyaXZlcl9yZWdpc3RlcisweDc4LzB4MTBjDQo+ICAgZHJpdmVyX3JlZ2lz
dGVyIGZyb20gdXNiX2dhZGdldF9yZWdpc3Rlcl9kcml2ZXJfb3duZXIrMHg0MC8weGI0DQo+ICAg
dXNiX2dhZGdldF9yZWdpc3Rlcl9kcml2ZXJfb3duZXIgZnJvbSBkb19vbmVfaW5pdGNhbGwrMHg0
NC8weDFlMA0KPiAgIGRvX29uZV9pbml0Y2FsbCBmcm9tIGRvX2luaXRfbW9kdWxlKzB4NDQvMHgx
YzgNCj4gICBkb19pbml0X21vZHVsZSBmcm9tIGxvYWRfbW9kdWxlKzB4MTliOC8weDFiOWMNCj4g
ICBsb2FkX21vZHVsZSBmcm9tIHN5c19maW5pdF9tb2R1bGUrMHhkYy8weGZjDQo+ICAgc3lzX2Zp
bml0X21vZHVsZSBmcm9tIHJldF9mYXN0X3N5c2NhbGwrMHgwLzB4NTQNCj4gRXhjZXB0aW9uIHN0
YWNrKDB4ZjE3NzFmYTggdG8gMHhmMTc3MWZmMCkNCj4gLi4uDQo+IGR3YzIgMTI0ODAwMDAuaHNv
dGc6IG5ldyBkZXZpY2UgaXMgaGlnaC1zcGVlZA0KPiAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAw
MDAwMDAwIF0tLS0NCj4gDQo+IEZpeCB0aGlzIGJ5IHJlbW92aW5nIGRyaXZlci0+YnVzIGVudHJ5
IHJlc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93
c2tpQHNhbXN1bmcuY29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0Bz
eW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDEg
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4g
aW5kZXggZWVlMzUwNDM5N2U2Li5mZTJhNThjNzU4NjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzIvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBA
QCAtNDU0NCw3ICs0NTQ0LDYgQEAgc3RhdGljIGludCBkd2MyX2hzb3RnX3VkY19zdGFydChzdHJ1
Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LA0KPiAgIA0KPiAgIAlXQVJOX09OKGhzb3RnLT5kcml2ZXIp
Ow0KPiAgIA0KPiAtCWRyaXZlci0+ZHJpdmVyLmJ1cyA9IE5VTEw7DQo+ICAgCWhzb3RnLT5kcml2
ZXIgPSBkcml2ZXI7DQo+ICAgCWhzb3RnLT5nYWRnZXQuZGV2Lm9mX25vZGUgPSBoc290Zy0+ZGV2
LT5vZl9ub2RlOw0KPiAgIAloc290Zy0+Z2FkZ2V0LnNwZWVkID0gVVNCX1NQRUVEX1VOS05PV047
DQoNCg==
