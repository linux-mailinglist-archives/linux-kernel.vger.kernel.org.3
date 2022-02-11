Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF84B2039
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbiBKIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:30:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiBKIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:30:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9858E55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644568251; x=1676104251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JjmXcqVJlU+pYnVbaT9SmKOhkMx/8Dvb48WGxdulHkI=;
  b=10iCMvZ0TzlGtNiIdqFZ/VFu/vLNVzN/+oP9KFsiiOxaeqS6N1tZfdtA
   gUqebLEo/u6aPx/VQW6quhnbO4NVk2cguBtgZSlBymRLRIYK1zM6dTqb2
   JYmpkQxiM4D8vjZQMBNzlSAgud8wjr2sJWjX8ieCGzR9KgUBSzzQQpn25
   CLbMSjQn1Ts1bDukYNrGStLkFbyxtRoESLwvdyWhxP0oWBkuwYkYKMEXR
   r7qQ+w730RSTUMMu2j6gjX26SVh7J+0DjH1tZcV95zNagmOgXDOH/9U8g
   muF/mjDyMpWgJbQBsq8p2SRwqbLw+FC5g2qSz5HMhg2bx5RTIhpWwgEp1
   A==;
IronPort-SDR: XRElKnc+C3zHqQ2oGfgtUi1MCQaduMWhTEJLKD6Xf2l7Or8IgYV+7WS45yHK5oZVp1AxCcLc4D
 AaCPoc7OtpyIwjqtzCRpfrKST493jf1mwy/sZ3j49zVpZIcNVVYuSAhgoR584ccY5C4vrdqAZR
 hKGaVcHIJ5X+D8nRN6BPsPuOCokVkpxCXzQBz9G/ghR9lplWt9ktrhJiGIJ+Qb4NfDwAOen6D6
 LZa8t0sbWyPAL70TeG103koltoXEIWTPT2y7q3Twvtf1dmPsNbILQl0wAmdEB8bBgWgJJ45i3L
 We1lT2xQWNtLEGpg7bdZ0s2M
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="145641903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 01:30:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 01:30:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 11 Feb 2022 01:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuUT7Pza4vg45suh0hzBhpKVmVz0IAOeQeNNEfPPPPP7Ylfjz2aklA8qhQDYRIyTS8VlkbUuiQ8FRjWQYRsPOrwn2dJCaI2qeECsgAQsO2lCg7sxzaZVRqx6c7zElhqGckWuWQCtk1VuYve6lLlgJ7DjYWl469s+fFA23RZOVYafLjkPHVVADcJ1N5BbdXyGzKACslqdYbVzNwJfQWXETyeiEpuy5txYoDaVJ4Mh2jAR/ZO3SAWrIgtrnG4Ca/7NsKM+xontwbaDlQ6gfB5uL5tA/OGBauYn8vBbC1xazezK+sMwSaRJ3VVoSwh+q6sKAu36sZRHMiVnYdrjYOn1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjmXcqVJlU+pYnVbaT9SmKOhkMx/8Dvb48WGxdulHkI=;
 b=im5/qEZMJNAmWRL2NyV3nwyiWcXv0ixJRNL1IumiuWjbhJ38OY4kuvkcfNs0mjtZYF/TAgICMFWQv+apq4M2XuxFFo9BASJHbmoaV2BnXsyzhpcLPzWeKSCQbULpv5bB+6cc0XfNbskAJoFqIJWBu5QrhM5Gto1BdYGbNFMALEWJx8kexKevhBhvkz86bN8EQ8p6ySfgN2khqibfahC/QCXsNDeYAVru1cH3X6l9EpUIBMILV/u9YsBj1QXCv5POF8qiADiZ36IwEEj+H166eiCElreA+8Jek2pn9PQJCEd428lOSg5G4gIsDq6iNVbp339vO6nPP1ke4THOPFE8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjmXcqVJlU+pYnVbaT9SmKOhkMx/8Dvb48WGxdulHkI=;
 b=mTyNoGHPAiHbimWsjDOhFYRsg+NQpWifAE2xTk3PRrOAhXz2jViUwtR4ulefCUnUrC9fkl89peGspbrIQbZhDCTe5/IrCK+sJoP3Wf4uQDcpz6t3qB59CNUb0FgORmjtyOKTcWKmDnT2e6J5E0Ej0AFBe8HKxENUbQeUGXZ8l4I=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM6PR11MB3067.namprd11.prod.outlook.com (2603:10b6:5:6a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 08:30:48 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 08:30:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [ambarus:spi-nor/next 1/15] drivers/spi/atmel-quadspi.c:1202
 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'
Thread-Topic: [ambarus:spi-nor/next 1/15] drivers/spi/atmel-quadspi.c:1202
 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'
Thread-Index: AQHYHx4uP4UO3ffEVki2/D18oA/kjqyOBRoA
Date:   Fri, 11 Feb 2022 08:30:48 +0000
Message-ID: <5f2ddbf7-381a-870e-e533-5261bbc9337b@microchip.com>
References: <202202110830.1OGwXRWt-lkp@intel.com>
In-Reply-To: <202202110830.1OGwXRWt-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13c3464b-f0f3-4646-b4da-08d9ed38ce5f
x-ms-traffictypediagnostic: DM6PR11MB3067:EE_
x-microsoft-antispam-prvs: <DM6PR11MB306797BCBCDD11CC915410CEF0309@DM6PR11MB3067.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4q23XV4FSYwZ5BoQcm2lS5AcP3Daht8aHAO6J5BmJ5NlMpytlRdM8UqDI27sHMx+ZzBRiEsMLjR3RhgzUsVCgYXxz5R7DQjO763sHhFI+X95yG2wMhNOi5jMR7wWx2U0QEOhbiNimEMr698bPVX6qm8wSuzr+2RgGB+HIyonD/rLBQ9aRLsK5Hb0t6E60mrDR2LztYiApzJVthc8CV4qJb/QofQk9juPxwiCfQifc5Di+aD87HV1uH7tND5SFSmXLEZfQVJbFzvgmTNVLKr4RrnKa4KHUjwFcgYbBSh2bdgVCYC5xAqyYqvI1Lcs2Pca0OV0AnIAAyuRpAFPlm5mBjalNz4kYVDBCafvjjH7UKiU7FAty2yXcnHcaK8feixAsBueufKYFXTSqImoSXdgu4dnTyf4O+wUU+e78jI/P1oUP6cDWXepNeqPgDLs3/YlNzMTq6bzBTX6Ivuv3wvTkc0F4ukglNKGhYljp9wRDSm1NwLpK3f5Yu9PUCUAH8pW3s3/t7omChowDYQhZd7tPKHId+TrY2ifM8auMVdJ9BEMqv+bFEG16dQcrpiKbnjzavgkeKn0helRiVeKUQtmLMGEUa7Ry8lPubj3ijyTr61HlYD5qnH76dewCjYxw5dC3Whb0E4t5LhGHspGCQBj7+ne3I3KTFxTVs3zQv65lLCEPkYYcbY0eSmxeKcccs5SNZOUfQX1U9oM6LwbqqOsG49f8Mu/AoBhgYQ/Hq7plXrDdY6A25S/mGIdGAaA5RBNb8PWhs4W5BYVtU4r7bPqDzT/CfvW62OdUXR4q7Z+0E6qnNVqorR/k4FQqSRT/BDp7ke2XcurfOX/SJUmMk7xrTPLkH21m8eqHnebBlRJH8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4326008)(2906002)(86362001)(6506007)(316002)(6486002)(966005)(38070700005)(31696002)(4001150100001)(53546011)(110136005)(6512007)(54906003)(91956017)(83380400001)(66476007)(66946007)(31686004)(122000001)(76116006)(71200400001)(5660300002)(66556008)(66446008)(2616005)(36756003)(8936002)(64756008)(186003)(38100700002)(26005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtDbHA1elNFVDBVTkM3R3hZcG5jTDlpUWVkOXhyQ3JDS0lOMGd6eFFCeHdk?=
 =?utf-8?B?VlFCNDNBUnVRKzNSbW5yMjlGQVF3NWxGT3VOVHFYZ2JTRHZJdkxzckpaQTUz?=
 =?utf-8?B?VW9HMDBPbmx6dmpDYnBpbTZ3TWQrTTlKZ0ZJNkErYlV5d3FWVTMxQ0d0dnRY?=
 =?utf-8?B?dnB4a1BPeFlMcXRxMlNFTnErUWdFZ3hvVnU3Mm1WOFlldFhZZHhGTEczMTdm?=
 =?utf-8?B?L3JpSFAxL3I3UUhnOXFYTVVCcnRIWkdNc0pGRnBQQU1ES3loUFhIUmlmTUpU?=
 =?utf-8?B?QUtRUmNIanJza0tVUlNNcjBZNmtWQjdDQy9jUE1mdnhkTkI4Q1N0MkxycGZk?=
 =?utf-8?B?OEo5Y1dpZ0V2L0dCRU5KZjAxOFg0aitNckVhSWFqVk5Sc1NHK2pMaVVRcnVL?=
 =?utf-8?B?TDZjS3NoSVhXc0I4Zm0wZ1FvaUp2dldpWEhNQzZOeGdZYlczQjd3YUx1WTdh?=
 =?utf-8?B?R2VERk5BdmZBOVAzWjRuUjFkQXRhYnpMUmx0K0hqQlpuOG9WSy9yRXNnc2Vq?=
 =?utf-8?B?RTEzSkVyQW5NeG1JZU5mcnFBR0RxREdYcjJvb2s3LzlEODhTTzhtalRRVGtW?=
 =?utf-8?B?dDdFcTRhNFRsSGRzbDdKeUVzaDNpTS9rL1NGWnAweXp1MmhTNjl1TmE4OTBM?=
 =?utf-8?B?QlhuRXQ1THNjUlZDMk9sZTlOZUpXa3YrcVJkR0NCdzM2VjRIY1g1MDQySElZ?=
 =?utf-8?B?MzFvTnd3U3BUVVBxREZVdExNYkhMWU9QM0s0N1phUjJQN21lNEFuamVLdStl?=
 =?utf-8?B?OFBQZDdNbG9mQnViRXRnZjg2TDhkYkd3SGorelIvaGJ6dVpqamRvOWF2d3RV?=
 =?utf-8?B?NlBOTmtFNmMrb1MwR3pLNG91RytBM0xLak5XZ1R2T05zQXkxZ2xsZzRPN1A0?=
 =?utf-8?B?N0p2ZmJRL3FYS3JNYXEyYTlrUjRxY2dYbmF2alRUWVJYSUdUTlRiWGx6K1FB?=
 =?utf-8?B?TWJKN1crWmxsQnlKVWRtbFFWVmdYNzY4MXdMMjdYcGZpclB6dHprUUI4UmM4?=
 =?utf-8?B?OXdoazNSMWc1WlJESUdRaUZIZzN3ZHBqVk1tUEtMY3ZvVVN0cDhPUkg3SUhy?=
 =?utf-8?B?SGw0STRycGxDNFp1QjZaM000SjYvVXMvR25xQUtscEp3U3BaMWU0WkZoUklE?=
 =?utf-8?B?OWllazNhL1lEWC85SnQ3UzQzT1BoVTFxVm1QU2hzTzdxdmo4QS9NNi9kWThG?=
 =?utf-8?B?eVE4ZzFmQ0dYTkNDRG1kK0hLQnBxb3k3RnJ5L1hkSUcrTDF6bEVmZ1pVb0Yy?=
 =?utf-8?B?ajdIc3UxcHRvYVlVcVB4RitCOTg2aU4yQzAxeEdzaklaYWdKWmpYYVYraDhO?=
 =?utf-8?B?S0NDKzFiUmEwb0M0dk5KbzZTQUlvREE3QzdQR1JEUGp1N3RRd3lkMnQvaGcv?=
 =?utf-8?B?VG1aRUo1czBZeXVxTHFvV3RwT21qekhqYkxQOXgrRmhGZzM0SVUvRG0vZmpv?=
 =?utf-8?B?RUNyV1JTLzdCRVM2UVRqL3V3K281SEo2TVRzOEgxdGRYQ0pkZjhFK3N0T1Jl?=
 =?utf-8?B?UWJ4aFVjTEhFVklTVzFDNnlsanBnbWpZR1FjRHdqODdxQnBsYis0bnJBQnBq?=
 =?utf-8?B?dzF6T2syVlFZM3FMcEVyQ01NYnQ4eXAvZTgvd0dqSm1PakxHVkUrTDBoNWpx?=
 =?utf-8?B?ZVppQ243UnB6bUF2KzcvV2FzeXBreThvUlVBbkVaRGFPWjRFb1pSTjkwTFBh?=
 =?utf-8?B?M1hFbDZ4TXFkdGdJaTA4eTZjckhHTExMY3RKdUhuSzlEcXN1bUp1T1J0dnVZ?=
 =?utf-8?B?MTRndGNsenVSR3YxY3kzTWVpWTUwNCszM1RCSE94b3ZvS3gxUFJHMnNUblJu?=
 =?utf-8?B?MzRvUmRIMVRjUFhPbDFPcWQrVHRGTW1ubGNwMWhBeFVEbytjRzVmVXdrN0NQ?=
 =?utf-8?B?L2JKUTVDZlFncFhrMzcwQ3c5L1M1RG9HV3hkVGlFWGc0TEV2VzJSZFplamtF?=
 =?utf-8?B?dk5FS2NYeTFycE9GQzVGRTJPZFN2NWhYdDY5YWRpbkxjUzZvcUNxcHowY3pk?=
 =?utf-8?B?NGhCTTlCNHdJSVN1ZDN5Snh6VisyYStxREpJeWhCTUJWaXRHUndSeWtFdkNp?=
 =?utf-8?B?Q09JdXZzdHNCRzJST3VRdHA4Ui9LRXc1NTRtQUd4ckJPSXVNcHBkTlpFMDZk?=
 =?utf-8?B?TVNweDArdHYxTkNlck5OMm9SRHFzMmZIeklwVHFlSDJ2M3ZkVWxjeDRvVUlH?=
 =?utf-8?B?YVVJeWNOaXZNeEM4ZGZkUzh4NHRCV2NTMStGN2xjWWpJNlcveUZlZnI3QTZq?=
 =?utf-8?B?SERmRFVaeGEvdStHWkt3bEZrZUF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B10DFA60B4EEE44CA99813ECF90590E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c3464b-f0f3-4646-b4da-08d9ed38ce5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 08:30:48.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zaMtEkjFVU5oL4WOJRN8UAWNCLQGrJJb5RpBkPOfwbMABiaBghvbcuzWdEii5lELPrD4Kj5rHdYfC5PdceP8jFyBMWwuga4vonfWo1B3Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3067
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMS8yMiAxMDowNCwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiB0cmVlOiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9hbWJh
cnVzL2xpbnV4LTBkYXkgc3BpLW5vci9uZXh0DQo+IGhlYWQ6ICAgMDM4YjNmYTJkODlmMWEwMGZk
Yjg3Njc3MDRjZGI3OTlhMGZlNzQ2Yg0KPiBjb21taXQ6IGZmNTFjOTY2YTNjNTE0NGFlOTY0Nzk3
MzQ5NzQ3ZTY4MGVlNDdjM2EgWzEvMTVdIHNwaTogYXRtZWwtcXVhZHNwaTogQWRkIHN1cHBvcnQg
Zm9yIHNhbWE3ZzUgUVNQSQ0KPiBjb25maWc6IG9wZW5yaXNjLXJhbmRjb25maWctbTAzMS0yMDIy
MDIxMCAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjIwMjExLzIw
MjIwMjExMDgzMC4xT0d3WFJXdC1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4gY29tcGlsZXI6IG9y
MWstbGludXgtZ2NjIChHQ0MpIDExLjIuMA0KPiANCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtp
bmRseSBhZGQgZm9sbG93aW5nIHRhZyBhcyBhcHByb3ByaWF0ZQ0KPiBSZXBvcnRlZC1ieToga2Vy
bmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVu
dGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQo+IA0KPiBzbWF0Y2ggd2FybmluZ3M6DQo+
IGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYzoxMjAyIGF0bWVsX3FzcGlfZG1hX2luaXQoKSB3
YXJuOiBwYXNzaW5nIHplcm8gdG8gJ1BUUl9FUlInDQo+IA0KPiB2aW0gKy9QVFJfRVJSICsxMjAy
IGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPiANCj4gZmY1MWM5NjZhM2M1MTQgZHJpdmVy
cy9zcGkvYXRtZWwtcXVhZHNwaS5jICAgICAgICAgVHVkb3IgQW1iYXJ1cyAgIDIwMjAtMTAtMTkg
IDExOTQgIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9kbWFfaW5pdChzdHJ1Y3Qgc3BpX2NvbnRyb2xs
ZXIgKmN0cmwpDQo+IGZmNTFjOTY2YTNjNTE0IGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyAg
ICAgICAgIFR1ZG9yIEFtYmFydXMgICAyMDIwLTEwLTE5ICAxMTk1ICB7DQo+IGZmNTFjOTY2YTNj
NTE0IGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyAgICAgICAgIFR1ZG9yIEFtYmFydXMgICAy
MDIwLTEwLTE5ICAxMTk2ICAgICBzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEgPSBzcGlfY29udHJvbGxl
cl9nZXRfZGV2ZGF0YShjdHJsKTsNCj4gZmY1MWM5NjZhM2M1MTQgZHJpdmVycy9zcGkvYXRtZWwt
cXVhZHNwaS5jICAgICAgICAgVHVkb3IgQW1iYXJ1cyAgIDIwMjAtMTAtMTkgIDExOTcgICAgIGlu
dCByZXQ7DQo+IGZmNTFjOTY2YTNjNTE0IGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyAgICAg
ICAgIFR1ZG9yIEFtYmFydXMgICAyMDIwLTEwLTE5ICAxMTk4DQo+IGZmNTFjOTY2YTNjNTE0IGRy
aXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyAgICAgICAgIFR1ZG9yIEFtYmFydXMgICAyMDIwLTEw
LTE5ICAxMTk5ICAgICBhcS0+cnhfY2hhbiA9IGRtYV9yZXF1ZXN0X2NoYW4oJmFxLT5wZGV2LT5k
ZXYsICJyeCIpOw0KPiBmZjUxYzk2NmEzYzUxNCBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMg
ICAgICAgICBUdWRvciBBbWJhcnVzICAgMjAyMC0xMC0xOSAgMTIwMCAgICAgaWYgKElTX0VSUihh
cS0+cnhfY2hhbikpIHsNCj4gZmY1MWM5NjZhM2M1MTQgZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNw
aS5jICAgICAgICAgVHVkb3IgQW1iYXJ1cyAgIDIwMjAtMTAtMTkgIDEyMDEgICAgICAgICAgICAg
YXEtPnJ4X2NoYW4gPSBOVUxMOw0KPiANCj4gTmVlZCB0byBwcmVzZXJ2ZSB0aGUgZXJyb3IgY29k
ZSBiZWZvcmUgc2V0dGluZyB0aGlzIHRvIE5VTEwNCj4gDQo+IGZmNTFjOTY2YTNjNTE0IGRyaXZl
cnMvc3BpL2F0bWVsLXF1YWRzcGkuYyAgICAgICAgIFR1ZG9yIEFtYmFydXMgICAyMDIwLTEwLTE5
IEAxMjAyICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKCZhcS0+cGRldi0+ZGV2LCBQ
VFJfRVJSKGFxLT5yeF9jaGFuKSwNCj4gZmY1MWM5NjZhM2M1MTQgZHJpdmVycy9zcGkvYXRtZWwt
cXVhZHNwaS5jICAgICAgICAgVHVkb3IgQW1iYXJ1cyAgIDIwMjAtMTAtMTkgIDEyMDMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIlJYIERNQSBjaGFubmVsIGlzIG5vdCBhdmFpbGFi
bGVcbiIpOw0KPiANCj4gVGhpcyB3aWxsIHJldHVybiBzdWNjZXNzLg0KPiANCg0KSW5kZWVkLCB0
aGFua3MhIFRoaXMgaXMgYSBwZXJzb25hbCBkZXZlbG9wbWVudCBicmFuY2gsIEknbGwgZml4IGl0
IGlubGluZSBzaW5jZQ0KdGhlIHBhdGNoIHRoYXQgYWRkcyBzdXBwb3J0IGZvciB0aGlzIGhhcyBu
b3QgYmVlbiBpbnRlZ3JhdGVkIGluIG1haW5saW5lIHlldC4NCkknbSBub3Qgc3VyZSBpZiBJIGhh
dmUgdG8gYWRkIHRoZSBSZXBvcnRlZC1ieSB0YWdzIG9yIGhvdyB0byBnaXZlIGNyZWRpdCB0bw0K
YSBidWcgc3BvdHRlZCBvbiBhIHBhdGNoIHRoYXQgaGFzIG5vdCB5ZXQgbGFuZGVkIGluIG1haW5s
aW5lLiBNYXliZSBieSBhZGRpbmcNCmEgY29tbWVudCBpbiB0aGUgY29tbWVudHMgc2VjdGlvbiBv
ZiB0aGUgcGF0Y2ggIi0tLSI/DQoNCkNoZWVycywNCnRhDQo=
