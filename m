Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769D4B07AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiBJH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiBJH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:59:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075F1089;
        Wed,  9 Feb 2022 23:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644479980; x=1676015980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dIDWWOnTSfIsDa8xEZiyPWlT3o/TEV22gf7gMJhNquw=;
  b=LocJE8kW2M9fWHcDQ+mkhqJisKt2x2Hdob8SQ5Tw316BCo2MDRye56to
   bDL4OVK5Oa/SDtObBXXqgBN1pCyFS79I5M1TQhOfM06cghxUPbhlm14zI
   KNDSuKGU3zK73z1ftA9DFpWpwevJxdeZCEg6OSeyo63KCn1QHCnf6Xi6z
   Ka8tfeX/59JUrS6ZvkwdabRdBZaE8xTcgfGkbN+SpK67LRmMTSwc/M7xL
   l5pkUz2NK2xYdCO3M7gPEEARkIen4LeHzVeaJnPUXBH+aZI0UgbZiQQQK
   jt+kAYT9bTEd/2HOBnUr8SfLLlY2QxNbqgXhYfN4BdDY4R+ouMVYwnDQb
   A==;
IronPort-SDR: ez5kcHOEppF1XpoRKqTmC4REmPo6gqQpAEvYutQ6WwK6nAG/sYNQunr+M9Ymy0zdl7zcDboUhM
 Z8lAKvM/p3A0EUWGITzbSwFgMZnMByfzFcpOYyVx3Ika7izmegmpdAWs9AIK8VELiVZIK5TLQX
 IJB0qUFgOn1dsCWDjXSyfNGIj13Fz87kXthsPdUGfLq6e5Jte0OgznldhOphpumGbkZjOqlKpo
 4E2aOuzxeUm7gvFB8Smn9+t1/ZLlIo/TLRJqGOXFd5wZOvqppb7EnqB1aJkBrx3Kt0kJxUcbKR
 9+ZLmIhFiGk4r54lMNpx/k8i
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="145502994"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 00:59:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 00:59:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 10 Feb 2022 00:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khREwMLInTF0xNSMzpyRlfXqj/mcdXD112kmOsmLP1OCffs+gDlwdKrym/3UsznTUmgUq2RfRC/DIYlHSfoXbZS1tb6NMW8lDXabC2aXN0ZLiJ5P5nAgQojKCaxheKBfZtcYqqAqFyh+KNxF7b3X4OpXkWJNfIkAh/xUxtX0qu34VQHLeDpz4yDM0f3ka5VVNIV+FtPyxkvtiL1omugIHJ1ksxIqxQ+0V0uu8rGhUs/tWASIXtZJJfX/0rbqscKMye6jDHOC6EQYr/tTRVMKTu3k8/8INRC9OiDWnFWpSVZwE3iMs1MfSuk8jwk7zJ7x+TgV/EY76/zOeP4EdGEnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIDWWOnTSfIsDa8xEZiyPWlT3o/TEV22gf7gMJhNquw=;
 b=kGapj1o2bbJ0U2yLnoA4oOk6+YWI8QFwD23sMiKKZ93xSxTFCxEOcy0wqz8h5iMg/wIfbzNo6aIjMkBpBPHbtiJ9ufJmZtgA1sSYjGjy9f7AMPOlUMM0WGv2j45Dz+QNe+ZpArHiS3TBsMfpZk+Wl9WLATD288NELBz+eciQSK3OdyZ/ntMMqdmCCyHKodw4blZSCuOHTkmQ1KLtGszYuHXzKCrBTxPasfb+dGlhxCjDAOXclEWPeBqGEYgF9pDRoc01w654A5A/K5bNg+Ke6NZCsSmSigiMD//FbbzlCx8ZtynVami2jCwETsEkNejY8zpqCwRjlDpFWtCbSHimWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIDWWOnTSfIsDa8xEZiyPWlT3o/TEV22gf7gMJhNquw=;
 b=q8xMT792cm7CKofAMFP9q3/leVyeXXz/ckkxj2c3XG6g1FC5YYHIynAVlHh4fVqg/n95lQIGAh1597BudI86OpWcWiRskosgy0yyBmI6c1z8AqDcoVUXNu1dqs7kOTyzhZfTa5y5VOv7f9jsssr0g6QMgy/0KCWkAFivTcybEIs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MWHPR11MB1807.namprd11.prod.outlook.com (2603:10b6:300:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 07:59:36 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 07:59:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Manohar.Puri@microchip.com>
Subject: Re: [PATCH 2/2] mfd: atmel-flexcom: Add support for lan966 flexcom
 shared configurations
Thread-Topic: [PATCH 2/2] mfd: atmel-flexcom: Add support for lan966 flexcom
 shared configurations
Thread-Index: AQHYHlQk4PtwvZJB5UakqiQAvCx1NQ==
Date:   Thu, 10 Feb 2022 07:59:35 +0000
Message-ID: <e5533bed-79ab-7d72-b0e2-47b038bdbbeb@microchip.com>
References: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
 <20220210074546.30669-3-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220210074546.30669-3-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 123d8368-9103-449a-285c-08d9ec6b4792
x-ms-traffictypediagnostic: MWHPR11MB1807:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1807DD60AE79FF149C09029EF02F9@MWHPR11MB1807.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ZLZOYcBb+/d5J9MTBkdoVQI60CyhHpACzMfapwFpiy2D1YdDBK8afDo6JgKlJlO14rjzBliavZNYBr8db57obC4QGqpiG6fphCE85QtncYSklueGlSGcdZmdaJKmlO/n2KKL7EEABW5HSsR78AiNjXURJQDJcihX/P+5cngvfx+ee9c8Ee4zr6QEURHQjCwIsSc783EFLOK/xaIEyYhDuthEUs/BLOxTktqWpO5IUDgP7ajdDYWez6iMpGB0AlxRZrjcaKd8FoTGleFW6GR/3nYFdxDqLBlb8OeB1MYx9IMaz1oxStPVT63/Ka/RCO1CqNDg4uEEQgtv8PM0rgQlTjKStfOIOMLG6KlZf2amcr1sx18Qh4ZJkS37EM/HBpvTBOReUQXwWL5lS/Lo/bm5vfMzw9XQ+6rKuJVorsF7JqMiTdBvYBu3i/vgZMuv3Mtr0hTX3Bj5OoOI3W0HSEDCrALKXR1AICJYjCdzHfgSGKFEy0nwWXBC6/3OHEIQhIUNae+zGCtLU/+ngaTk4j6tB4T2iCT1efWonc2tbTslEgahjmjuLC5jsvekLB6SDrOsqpQr5GppL140Y4kPdJHxOi+QrAsOKrO3T/gVjM67jJaJ246dE1cdLUgU5Movt0rJiPsgQEfaEEUYQGGLuPTNGTyZaRLSyT2Hc+GW5+bLMbaJP3y60zbL4kubg+RA6WEgzGDDIxziRon+ad42bgUg4fpUHUedY3EJKbgmCea4yFQK5zKkJ5IqKeRUrZYLdPUuiLp69N7irqu2A13Adp7loq1Hn1uJXsDPqDSw64H+8jYOhrUB0NZxMDV4lh72SMmXz/kcF8q+BuXfxra9Lce/T9iAIO/GpB/1T8FJtFWOyA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4326008)(86362001)(316002)(6506007)(2906002)(31696002)(6486002)(966005)(38070700005)(53546011)(110136005)(6512007)(54906003)(38100700002)(64756008)(66446008)(66476007)(83380400001)(66946007)(31686004)(122000001)(107886003)(76116006)(71200400001)(5660300002)(66556008)(91956017)(36756003)(8936002)(186003)(2616005)(26005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmN3NkFWemNESE1rOUllQytBS2VsK0lWTWFCUFZPTi9vNWc4dmp0dTMzanJZ?=
 =?utf-8?B?TGcxK3hPZEg3WTRvekZLQzNPUHdMT0ZlVllrRTd0THhISmdqRjY3SFdOTnJ5?=
 =?utf-8?B?dXE1YkdBWEpseVZ3WG9GNURNdXZFMU5pRXoxajhwbTNYL2d6bDk3N2IyS3lw?=
 =?utf-8?B?alZ0TGw0VndCSXN3UTZsSCt3bzh0WEVpS1M0dlhoYyt6czN5dis0WEwyUXlK?=
 =?utf-8?B?NUs5a3ZEVTQxSFlOUEVpTngrbXZacXd1LzRFQ3FOS29oelFGUDl2cjNmRnRK?=
 =?utf-8?B?WmRBcUxFRFgxNm9iUG83ekhRL00rdGw4ZXlaMDNwalo0Mml0bXhaQWlnS3Ex?=
 =?utf-8?B?VDlyN3ZtVlp0NjdRSzF6UytOSzdSeURpbFZ0WXkwcTR5VHdMMHBNVDU1WmNj?=
 =?utf-8?B?QytqQjNqUnpPcHc5eUUwUURXMmRDNThwN3M1cCt1QTJXM09qemRNdDlMYkJB?=
 =?utf-8?B?ejRIcmo2eGRrcmFFTUhjV1I5Yk1reTAyN0VGbkdhK1NrZUptODY0dkI4TG1p?=
 =?utf-8?B?eXphcWpvQ2E0MWxRWEUrVW5mK0FFTGpMMmVrUXlWS1VacGczNlQ4REp5Z1Ba?=
 =?utf-8?B?eFNQWGVyeGxwT3IzQnQycS92L1Zpcno4VW9xVjdkU3ZFMTE5cDJweWlqV0g2?=
 =?utf-8?B?NTJ6MjNpdjh2WU43blIrZG1DMFB6TC9JcFZ3cUJJYTFEUmM4Szd3WWJsaHNE?=
 =?utf-8?B?aHlNMHRMbjJKanN5dTJYSi9TWUdLMnZpMTdjc2o4ZW5kbGZJUEVJdU84ZUhC?=
 =?utf-8?B?MTVjZzNJaVAxYzdWcWN4dSsvclNSR0xjdWlkWFZhRittS0dkL2c5WVFhTEZv?=
 =?utf-8?B?TVJkd0hqNmVwRDlYWldFZGtNYmlXN1g1SmoyWExUd2lvZnI3cU9OYmh6dVNH?=
 =?utf-8?B?NXZiTnNaKzljRkFicWhtQkdmTGk0WGdlMmJKV2VrZ3Jma1BIT0tWOTJFRUFP?=
 =?utf-8?B?VmdLa1kvQU1SaFNmTXdabXJESTRnb2xpTm1rS000OWtoYVFmcXRCbVd3a2FL?=
 =?utf-8?B?L2h2RTRXR1JlU0lMc1RiWEcwYkRBMjJTL0duN2h3TzkzT2VZNzdycmxRZlhY?=
 =?utf-8?B?TXlrNnNzWUNTcEF4eG56WGh3QlBPaTJyMkIxcVBaVWtPZXVjdkN6cXdPOThX?=
 =?utf-8?B?dGRFR1FlOE1RdXJTSVZiVElkRW9IZDNCTlIrcTFIa1h2em1STVY1T2dLRHVZ?=
 =?utf-8?B?QmFOUDlxNTJITVRmcXBNWjd6OHlhNm9zTjl0TGdtQTZtZ3BtbXZmTHZmUHNE?=
 =?utf-8?B?QW11MjVmY3Q4amVTNTlqWTZsaFdjMEgwbStqUXZuTHljSVFMNDNNb05xNU51?=
 =?utf-8?B?ZzBuWU9vYW45MmJCYkl4Z0prZllJSysvVmlCU2lPOGNFSFdhc3c2T2xrQnZy?=
 =?utf-8?B?RzBCOHBvY01WTWhnendzcTJ1Y3liSUdVdE9lclI1aFRWQzVuZFdQOHJvYWlv?=
 =?utf-8?B?M3hsK2FqQzlMdHNXZHRUb0RQZGdvSlpqMmIzM0JScW9CVk1vTjRWd1o0a29z?=
 =?utf-8?B?d040MTg1clNYOFNrZWgraDM4dTFPUXJTTjFjK2p2aUlMbTNmV0JyeVRySkR1?=
 =?utf-8?B?UHNzZDVjMFFHZVhFdXBIbVArcVBsTzdrTnZ4SWNDTHB0K1hWTEZYb3JWSFF6?=
 =?utf-8?B?VXZ3WEtveGxvZGxQNGplVVA1bDJXcDFreGx1dXh6QTBQdUxrZkt3UHlMdFJG?=
 =?utf-8?B?SHY5OExYb0xoQjVFWDZkTW0zYzd3NkNFZVJ0ZzUzRDlFM2ZCMnlDL2NwYlZG?=
 =?utf-8?B?WEJEL29LZXVkVytRZUkrbVZWaUNENGxremhEU0dIRUNHSlpVVVlCZ2c4TDdZ?=
 =?utf-8?B?cGpMYmVERUxQa05hZzk0bEJwZmVCZXdWZXRVbzZLR2ZVbE5JSVc5bXZBajZH?=
 =?utf-8?B?TDFnNzF1cHBOQldzNTY1VDdXVmZESDd3dUpseTgvcFBUYUpnQUtnNFZXcWh3?=
 =?utf-8?B?WFRqOWtFa2hDQmtGbm1MVS9QYWd3dHU3RmFDWFRtU1lESERvUTZlYlNQRk1j?=
 =?utf-8?B?djNteC92U3A4aTNlY1czaUVvT3JxZVpTVUVveUdJellWRjU3L3Q2NGF3cVE1?=
 =?utf-8?B?d0RLWjJIRjR0OXJ1a3BPRW5RWXdoQ3pQdXRseEQvMDJINytTdWVwNFlveko4?=
 =?utf-8?B?M2NBSGI2bjlibkljNkpnNkpjc09RQkYzSDdkVDJ3cUVnQkgrV1QvbTdFd0l1?=
 =?utf-8?B?a2t0T3Q0SnNTeXpydkd2QTN3QlNSNEJ5cmVaSjgzdm55ZEpoMVMwclRnUFhs?=
 =?utf-8?B?eTJXQktwbytuQWxHMXpVb2VyZDJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FF9749DBBC3FE448D572971122812CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123d8368-9103-449a-285c-08d9ec6b4792
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 07:59:35.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fM7KHtxJ2X+a4QmAXyRM7dFVJWG2bg/XR7efN77TJol6V98JrsGwa4xgXJlfDjd6xWDFvXo/aWPRwykkciP3Cqya/z8e2CYN51k6qbLm7+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1807
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMC8yMiAwOTo0NSwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEVhY2ggZmxleGNvbSBvZiBMQU45NjYgU29D
IGhhcyAyIGNoaXAgc2VsZWN0cy4gRm9yIGVhY2ggY2hpcA0KPiBzZWxlY3Qgb2YgZWFjaCBmbGV4
Y29tIHRoZXJlIGlzIGEgY29uZmlndXJhdGlvbiByZWdpc3Rlcg0KPiBGTEVYQ09NX1NIQVJFRFsw
LTRdOlNTX01BU0tbMC0xXS4gVGhlIHdpZHRoIG9mIGNvbmZpZ3VyYXRpb24NCj4gcmVnaXN0ZXIg
aXMgMjEgYmVjYXVzZSB0aGVyZSBhcmUgMjEgc2hhcmVkIHBpbnMgb24gZWFjaCBvZg0KPiB3aGlj
aCB0aGUgY2hpcCBzZWxlY3QgY2FuIGJlIG1hcHBlZC4gRWFjaCBiaXQgb2YgdGhlIHJlZ2lzdGVy
DQo+IHJlcHJlc2VudHMgYSBkaWZmZXJlbnQgRkxFWENPTV9TSEFSRUQgcGluLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWljcm9j
aGlwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMgfCA0OSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDkg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhj
b20uYyBiL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPiBpbmRleCA1NTllYjRkMzUyYjYu
LmI4ZmM0NzZlNDExZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5j
DQo+ICsrKyBiL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPiBAQCAtMjcsNiArMjcsMTIg
QEANCj4gICNkZWZpbmUgRkxFWF9NUl9PUE1PREVfTUFTSyAgICAoMHgzIDw8IEZMRVhfTVJfT1BN
T0RFX09GRlNFVCkNCj4gICNkZWZpbmUgRkxFWF9NUl9PUE1PREUob3Btb2RlKSAoKChvcG1vZGUp
IDw8IEZMRVhfTVJfT1BNT0RFX09GRlNFVCkgJiAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBGTEVYX01SX09QTU9ERV9NQVNLKQ0KPiArI2lmZGVmIENPTkZJR19TT0NfTEFO
OTY2DQo+ICsvKiBMQU45NjYgcmVnaXN0ZXIgb2Zmc2V0cyAqLw0KPiArI2RlZmluZSBGTEVYX1NI
UkRfU1NfTUFTS18wIDB4MA0KPiArI2RlZmluZSBGTEVYX1NIUkRfU1NfTUFTS18xIDB4NA0KPiAr
I2RlZmluZSBGTEVYX1NIUkRfTUFTSyAgICAgIDB4MUZGRkZGDQo+ICsjZW5kaWYNCj4gDQo+ICBz
dHJ1Y3QgYXRtZWxfZmxleGNvbSB7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPiBA
QCAtMzksNiArNDUsMTAgQEAgc3RhdGljIGludCBhdG1lbF9mbGV4Y29tX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9
IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAgICAgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAg
ICAgICAgIHN0cnVjdCBhdG1lbF9mbGV4Y29tICpkZGF0YTsNCj4gKyNpZmRlZiBDT05GSUdfU09D
X0xBTjk2Ng0KPiArICAgICAgIHUzMiBsYW45NjZ4X3NzX3BpbiwgbGFuOTY2eF9jcywgdmFsOw0K
PiArICAgICAgIHZvaWQgX19pb21lbSAqc2hhcmVkX2Jhc2U7DQo+ICsjZW5kaWYNCj4gICAgICAg
ICBpbnQgZXJyOw0KPiANCj4gICAgICAgICBkZGF0YSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2
LCBzaXplb2YoKmRkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+IEBAIC03Niw2ICs4Niw0NSBAQCBzdGF0
aWMgaW50IGF0bWVsX2ZsZXhjb21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICAgICAgICAgKi8NCj4gICAgICAgICB3cml0ZWwoRkxFWF9NUl9PUE1PREUoZGRhdGEtPm9w
bW9kZSksIGRkYXRhLT5iYXNlICsgRkxFWF9NUik7DQo+IA0KPiArI2lmZGVmIENPTkZJR19TT0Nf
TEFOOTY2DQoNCnRoaXMgbWF5IGJlIGJldHRlciBoYW5kbGVkIHZpYSBhIGRlZGljYXRlZCBjb21w
YXRpYmxlIHRvIHdoaWNoIHlvdQ0KYXNzb2NpYXRlIGEgY2FwYWJpbGl0aWVzIHN0cnVjdHVyZSBh
bmQgdXNlIHRoZSBjYXBzIHRvIGF2b2lkIGlmZGVmZXJ5DQp0aHJvdWdob3V0IHRoZSBjb2RlLg0K
DQpDaGVlcnMsDQp0YQ0KDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBGbGV4Y29tIFNoYXJl
ZCBSZWdpc3RlciBDb25maWd1cmF0aW9uczoNCj4gKyAgICAgICAgKiBJbiBvcmRlciB0byBtYXAg
Y2hpcCBzZWxlY3QgaW5kZXggWCBvZiBGbGV4Y29tIFkgdG8gRkxFWENPTV9TSEFSRUQgWiwNCj4g
KyAgICAgICAgKiB3cml0ZSAwIHRvIGJpdCBpbmRleCBaIG9mIEZMRVhDT01fU0hBUkVEW1ldOlNT
X01BU0tbWF0uDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRf
Ym9vbChucCwgImxhbjk2NngtZmx4LXNoYXJlZC1jZmciKSkgew0KPiArICAgICAgICAgICAgICAg
LyogU2hhcmVkIHBpbiAqLw0KPiArICAgICAgICAgICAgICAgZXJyID0gb2ZfcHJvcGVydHlfcmVh
ZF91MzIobnAsICJsYW45NjZ4LXNzLXBpbiIsICZsYW45NjZ4X3NzX3Bpbik7DQo+ICsgICAgICAg
ICAgICAgICBpZiAoZXJyKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0K
PiArDQo+ICsgICAgICAgICAgICAgICBpZiAobGFuOTY2eF9zc19waW4gPiAyMCkNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICAgICAgICAg
IC8qIGNoaXAtc2VsZWN0ICovDQo+ICsgICAgICAgICAgICAgICBlcnIgPSBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMihucCwgImxhbjk2NngtY3MiLCAmbGFuOTY2eF9jcyk7DQo+ICsgICAgICAgICAgICAg
ICBpZiAoZXJyKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiArDQo+
ICsgICAgICAgICAgICAgICBpZiAobGFuOTY2eF9jcyA+IDEpDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsgICAgICAgICAgICAgICBzaGFyZWRfYmFz
ZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01F
TSwgMSkpOw0KPiArICAgICAgICAgICAgICAgaWYgKElTX0VSUihzaGFyZWRfYmFzZSkpIHsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2RiZygmcGRldi0+ZGV2LCAiTm8gRmxleGNvbSBz
aGFyZWQgcmVnaXN0ZXIgY29uZmlnXG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIFBUUl9FUlIoc2hhcmVkX2Jhc2UpOw0KPiArICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsg
ICAgICAgICAgICAgICB2YWwgPSB+KDEgPDwgbGFuOTY2eF9zc19waW4pICYgRkxFWF9TSFJEX01B
U0s7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGlmIChsYW45NjZ4X2NzID09IDApDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHdyaXRlbCh2YWwsIHNoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NT
X01BU0tfMCk7DQo+ICsgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHdyaXRlbCh2YWwsIHNoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01BU0tfMSk7DQo+ICsg
ICAgICAgfQ0KPiArI2VuZGlmDQo+ICsNCj4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUo
ZGRhdGEtPmNsayk7DQo+IA0KPiAgICAgICAgIHJldHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVs
YXRlKCZwZGV2LT5kZXYpOw0KPiAtLQ0KPiAyLjE3LjENCj4gDQo+IA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
DQoNCg==
