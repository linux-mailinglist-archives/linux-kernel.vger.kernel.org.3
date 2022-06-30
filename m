Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE9F5611CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiF3F0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3F0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:26:03 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 22:26:02 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F836C18;
        Wed, 29 Jun 2022 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656566763; x=1688102763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=noI0QgSlMUS+1vzaxoUU1t2wftQ8A9X6X6R4NBNNeSo=;
  b=ieAYQupJu8cPLu1ur0rVMYx87hrLCFgOdR7fcnwGzh4ml2yjtMHLm77r
   qES3v69hJF38QFufiyCzNobql9t+spCpfF/yhKDpBSRrng4Giwbb520pI
   sSpmg7MC63G8gLr3EdRcK/K2gctsEnbdspJFsyWxyhgCG6WRVnA5NnvNs
   HyUCXIbKdyoIhx2aBUVDDg/fB20QdjJn/XqNQdcRuAJB61xvFmT7s0iKi
   SFxslgwVXYhmH4L5/ctFbBo4k0zsjHY7xv7Wol8Yt7jJXgD/4xyRfbLie
   1Hwp9CPJhfmt3IEpJ8f8P0ZXHIwTq7vSc800L445IQ8N/3Y+kw/3DvRp7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="59437054"
X-IronPort-AV: E=Sophos;i="5.92,233,1650898800"; 
   d="scan'208";a="59437054"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 14:24:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLMT27WsBes/8PNF7tDTJk8aHE2KEYZUszCQk1RBRJs5tq7o7/xjXo9IwOFWG4wE/iTEOPxlKvDK0YdUMblBC4PXGH+js1akhI8Fdi57CWT/14x4lRqRmGomkQr24prl67IiAwDIk4BpDuIfDr43I/XMFoc4LvsKCVqrZ6LG2ysul5uzviHoq8htYicPLZgG+aWRxBxHG2vGt0hZlnUn0HOZELBJ5Nawxm2ilTCZRAo77jjR2xlO7pwWvMN6KuZzbnkPtKTPvNiu6aGwrZLq2cOS3az2eQGZ5cEeGvR4ajZK16X7qFPP0DL+w2CREneB1/DpDG8zVg9wqEzpSuaz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noI0QgSlMUS+1vzaxoUU1t2wftQ8A9X6X6R4NBNNeSo=;
 b=L8WHxXfa4idF/MsGZAe5H5wejGqPHmO4kwcWwRvgifYcsfV49uBpc/oCYuFDrx9kQk7Dei2bq0fF1L+65u9RuLqcla3OlY//xHhgbBf7rPyvk3FKMiDiJ7Bl5fdAQl2OW3SIy5oDWXmQ6YIKxd8xJgwD0VpatMhjJJnTkOGylgM+Uks0IjuZjZUlM58ltoV5EpCkR0jvOPXduFWDwm4mIVGR3u8WqzTSzxdCUSBl10Pz42Y1l6hevmdIlvOtI8QyrG8UcjcVnSJSs8JcDVeMAv8v/Br7fFkDManRw3udEXgURVNro1/nGGEc5OodFJOTnt21bqMIWdkv/VQjfB0NFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noI0QgSlMUS+1vzaxoUU1t2wftQ8A9X6X6R4NBNNeSo=;
 b=KyuCQsBzrLL+cpYseV24IjzO8qQvM9HKx9pGmzApP+d3X3qx8dBS+vSmRM0NZ+pb+EIrK8Z1Apu6NGJ06irOoag9xESpU5D0zfavgSV0CJi8ED7gOHA3/GP04ooMVLT7XkUI/Fr0ZOZKTVGIu2Sio9GDjKmPYtcTwILJ3XPPdKc=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OS3PR01MB8400.jpnprd01.prod.outlook.com (2603:1096:604:193::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 05:24:46 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 05:24:46 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     "'Luck, Tony'" <tony.luck@intel.com>,
        'Linus Walleij' <linus.walleij@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYemckLVPNFhFQbU+IAdEo3cwBO61IoUEAgAYyEhCAAA4dgIAEfPmggA+/dICAAdapAIAAMfOAgAJluEA=
Date:   Thu, 30 Jun 2022 05:24:46 +0000
Message-ID: <OSBPR01MB20378E5F3D1C2394434F0E0380BA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
 <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
 <OSBPR01MB203739DD69FB8C50990C356A80B89@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <c2fb1376536d471f88b58ad82859a183@intel.com>
In-Reply-To: <c2fb1376536d471f88b58ad82859a183@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NzBjY2M1ODgtNDljNi00ZGUxLWJhMmQtMDIyYzBmYmZl?=
 =?utf-8?B?OWYzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNi0yOFQxMzo0MDo0NFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c8ec98-0d19-4a69-fa7a-08da5a58d89b
x-ms-traffictypediagnostic: OS3PR01MB8400:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IrOI8kSRk931Ku/VZewazcQD2iaDs12iclKtX4+hIS0GTWu/lG1SnWfEpx9jZ1Ka2LrBqzqeWi4Qlb0U72TI9OwVJHmDWix2Yth9PQFKxbA0hnZ++d9V/FmjlT63XAN66f1OIRZdjSYMDODdGdMmis4KQ82L/HSHoWVyh1GRbhFyIkoXcN02jhxMjUNbc1mJevLJpWxL+PMP7Ns2JAkTUKnZothMXHcje6kCUYxGJ+gQldVu4/iDQcjOVj2tLrwNhtHY4jwSSEUJlDrIGhaJpVYdrBZiOJqBMCh2BIaQFYaE4fBZgbdIVZ3qY3smEVpCfWhuHjtRwq8xsBsilgA0x9xBq9pGFIz5y7dbXKoPeE1ahg8TXpgT9dybsffA0KJL+i4b+f78+zOwTZg/Z0ZEhm392RXaWQycnqg+ls1Q6TH/3KbQytyZizT/rM2IuE5XSCHOaHvn93KV4aRCUkmTec5uhoHYEpJI4rjwA0kcWO5rHrEZHxYJHghtSToEpl3m9RZFCFGj9YBgFc4onXEiVcEj282FYScmaKtAlPyp26OVpE3aFDfaOKu2b1Uek8lG0ZpJ4tjLF0f3SvMyNloach2zYVXiFsbuNtni3Xe7h/ukTQyIKbjd0o3p+4fhM6vLU+Z9JUcIM9z84TfUGRiEoI+P0zoUTpoNa2YBpyrvMJVaops4tP0rwHrgy3nt5EAI1AxvB7CPhbA37P8AWvC9RMqIl4aGP+SYphrSGvnNIP+INQ9Rf2vzrKbVJ6Hjd2t3xeE5bwJrIheY0hp98DCsnlvWd4sMsgxe2hJF76XMwKRkrEJk07jN/I6PRtMDSGc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(5660300002)(478600001)(7416002)(52536014)(4744005)(316002)(54906003)(8936002)(33656002)(122000001)(26005)(85182001)(82960400001)(110136005)(66446008)(66946007)(71200400001)(76116006)(66476007)(8676002)(66556008)(4326008)(86362001)(64756008)(6506007)(7696005)(41300700001)(2906002)(9686003)(186003)(38070700005)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGxuYUI5T25OQW4vTFpKU29MMWNwclJLUWt6Y0xTOHA5UTU5RlNiYWhERTFQ?=
 =?utf-8?B?bFVnbXFKc0dlUE9pVHVadm1vM2owRFFWZHBienVoT0RncS9pUDNBLzBheWpy?=
 =?utf-8?B?UXVXM215M2E1N2JHb1pEU0l4WExtdHRrZ1hYZWUyc1hLYm9PeHJMR1FRd2sw?=
 =?utf-8?B?U1RHL25MRUZxSno4VXcwcVU1ZXhzTS9XUWdrV2l1OEhwRk4rTm83eFV4dk44?=
 =?utf-8?B?SXp6N2V2a2hINUFxVHgxelRtQ21EaVYvSjZ4VHI1L2E4T2piM2RxWXJWSTRV?=
 =?utf-8?B?TUNKV0EyaTlqcFd2aC9FNllaZU1BTWNoWms1VnZVTG9hTUJBeGxnckt2Z3JR?=
 =?utf-8?B?eGNzekhlODl3eklCNW5wdFdiWXU5eGpJVE5yV1NXN1YxTFh3all4SzlXb0lE?=
 =?utf-8?B?N1N3dlB1eVlsa21XOUlSSjVoVC9NM2hERHg5eU5FVzZuR014ZjVELzZzdlJV?=
 =?utf-8?B?M3NlSVhyS3NFVjNmQWRyMGh2UUFUd1ZGNUU3dmZQeFQzdXM1T1Z3MC9KZytl?=
 =?utf-8?B?UUpZeUhPYlk5MWNtZUdnVWpQNTV5UDc5WWFaeEVMaFZQWHZBRzRycnNvaFRx?=
 =?utf-8?B?clJxMVhVWFhSQnhRS2l4RE1URHhMVHZ2RU1mNGwxdmpDMGdRU3NzSFplcWVr?=
 =?utf-8?B?TFZhbEhWeWtXZ3ZhbXJGN1V6NE9hTGdGdXZXWlY2RE5UZ0diOUpSZkZTNW9E?=
 =?utf-8?B?TFcvNkk5eDYvN2Vma0FKTm5lNm9QeXlsTUFvQ0kwRFpsYjdZeE5LYld1UHlJ?=
 =?utf-8?B?MXZuTDIwZkxEQ3RhZ1pCdHEzT2preGRXakdESEVwelJ3a09kbEo0VDQvSVZD?=
 =?utf-8?B?V2wxM1VCeEpnb0tiZ1g1ZDZMREgzQTBNa3Y0WTZRcFZ3Tm9mdDhzczBrVUIw?=
 =?utf-8?B?dC9ZVVVMNTB4UDk0Nm02S1F1NS9QWVBYYnFZMzllQ1ltSWNHcHM3cFBBdGNZ?=
 =?utf-8?B?eTlQL3h2THZuMUFWRHNId2pyRzNXOExVUE5SalVPeFR3STh3MWZDN01RUFFm?=
 =?utf-8?B?cGlkeVNqUEFxQ2N2SjlpQ0Y0OGIvVm9TUWw1M2YzK2IwdXJkYk9TQytKUXJt?=
 =?utf-8?B?aE5Fb3VZOEJ0WjZ6MWUvSGdzSHNjY0FKUG43QjA4VDdMVUxSUnJLRVAxcTkz?=
 =?utf-8?B?QjcrSXVOeXZvamhMb0x4TUE2MUw1dDNXMnFzc3dTajBxSGZwUkwySUxSemNT?=
 =?utf-8?B?QWQwUTJlUzVjQWVNWjh4Y1ZIeGo4MHBQZkdXQldtS3oyTFlFanpEK0J1YWhB?=
 =?utf-8?B?UXhwZEN2WENYSm0xVG1OWDd6MWhYQmJUU0RkQjBoWmNCU0t0YXhrdE1rN3Nv?=
 =?utf-8?B?eUU0cmlPZXNsaFU0WHpvamRyWitQWTZzalhoVEdsekVzYjIreHdIeU9sUm52?=
 =?utf-8?B?M0FKeVgxbmVkM2FVcy94VEZWamY1MHlteVdrSTgxTXZESHlzdERzbDdUYlhT?=
 =?utf-8?B?Z29WS0FPTVNtV2U2Mmh0TGtjOHFaU0k4bW9GK3lmU2FHV2tHZWpmaHY3NjlK?=
 =?utf-8?B?YkljNUNTL0MxS21iRXNiRW8zWVM4dTNZdTV1aEM4cUhnVjRYa2pkWHBPSVQ0?=
 =?utf-8?B?elMrcUtYL1FJQXp2MWM5dUV6Y0JDaDlKU2htQmtLaFJHVENjcDdlL3EvOFUy?=
 =?utf-8?B?MzllbnZjclE3VTV5WGtBV2JWcFJJUysxS2tNbGg3dmhwZ1VCMXZEbUdnbjYx?=
 =?utf-8?B?dElsZjUvM2p1NEdHVzBheTRWUVlQbWQ5WXd2cC9tUWdBR3k2NXpDenhHSGVk?=
 =?utf-8?B?RnVPUEVSSmZhbElLcGV1ZFRtblFjUkFSZHRaMFU3WjBLeG9LK1F1VXdiVU52?=
 =?utf-8?B?eTFEN3FMZjFJcGFrci81d2I4OGsvL3hteWlXck11ajd6L0cwaTVtVzhvMUxW?=
 =?utf-8?B?bnJ4c2ZBRU5TWnoxalQvY0YydlNNUnRTZjVNNXFNNW5JWXM4b3hhT1FTM0hF?=
 =?utf-8?B?cjkvRVAzVVdvVlorMzZxdWVXS2tQVmx1V0dBblBIbXZyNUNneTQ0aWhrNVdK?=
 =?utf-8?B?UlhaNmNFMk85SHo1S3RRMzA0MnUrMlBKOG00ZmFxNFJaU243d0RIbS9HMXRp?=
 =?utf-8?B?cCtQZW11QnhtbmFwRDFselVRakVaY0FPK2JGMFRuMmdNdTdFME02Tk4yV3Z2?=
 =?utf-8?B?ZHN4aGhIekZ5WVFuZVg0NDYxbThDRHRHNzRLVU5NVGg3T3RzRnFvTWVmSXJX?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c8ec98-0d19-4a69-fa7a-08da5a58d89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 05:24:46.3600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkKVRgw2IXL6+D2lmQQej+bkr9fv0N1Y2yfOI5isJPeW0sLZvn2nL4zUz1GceBtyK6WEg69EdagdsETKxK7mz6bhpZRxVkdxZ4AXlz6AteU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8400
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVG9ueSwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KPiBBbm90aGVyIGFwcHJvYWNo
IHdvdWxkIGJlIHRvIG1ha2UgdGhlIHNldCBvZiBwcmVmZXRjaCBzZXR0aW5ncyBhIHRhc2sgYXR0
cmlidXRlLg0KPiBUaGVuIHNldCB0aGVtIGluIHRoZSBjb250ZXh0IHN3aXRjaCBjb2RlIHdoZW4g
dGhlIHByb2Nlc3MgaXMgYWJvdXQgdG8gcnVuIG9uDQo+IGEgQ1BVLg0KPiANCj4gQnV0IHRoYXQg
YXNzdW1lcyB5b3UgY2FuIGNoZWFwbHkgY2hhbmdlIHRoZSBhdHRyaWJ1dGVzLiBJZiBkb2luZyBz
byByZXF1aXJlcw0KPiBtdWx0aXBsZSBNU1Igd3JpdGVzIChvbiB4ODYpIGl0IG1pZ2h0IGJlIGEg
bm9uLXN0YXJ0ZXIuDQoNCk9uIHRoZSB4ODYgYW5kIEE2NEZYLCBlYWNoIHBhcmFtZXRlciBmb3Ig
Y29udHJvbGxpbmcgaGFyZHdhcmUgcHJlZmV0Y2gNCmlzIGNvbnRhaW5lZCBpbiBvbmUgcmVnaXN0
ZXIuIFRoZSBjdXJyZW50IHNwZWNpZmljYXRpb24gbWFrZXMgZWFjaA0KcGFyYW1ldGVyIGEgc2Vw
YXJhdGUgYXR0cmlidXRlLCBzbyB3ZSBuZWVkIHRvIHdyaXRlIGFzIG1hbnkgdGltZXMgYXMNCnRo
ZXJlIGFyZSBwYXJhbWV0ZXJzIHRvIGNoYW5nZS4gSG93ZXZlciBpdCBpcyBwb3NzaWJsZSB0byBj
aGFuZ2UgdGhlDQphdHRyaWJ1dGUgd2l0aCBvbmUgTVNSIHdyaXRlIHBlciBjb3JlIGJ5IGNoYW5n
aW5nIG11bHRpcGxlIHBhcmFtZXRlcnMNCmJlZm9yZSB0aGUgY29udGV4dCBzd2l0Y2guDQo=
