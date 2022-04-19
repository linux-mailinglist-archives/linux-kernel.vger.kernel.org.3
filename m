Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0426C50705D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353328AbiDSO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349540AbiDSO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:39 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251827645
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1650378356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E1/McT8rCeGGCPtHkVKInE6GXMkxR9fg9F7EF0SmErE=;
  b=OwcCp+W6v5RPEnJamOGErPo8E3NbeSGbGepsa1XoRnms2pQVb6gUlTY2
   rmMaeMUytYh/E6Rq1CkJojA+Bc/ZUJYSif6nkrQ6SxGLmnOHJv1490BsM
   q6294SQgJzV35EBm/lkMlAS2f+V6NvhXOEnRbmIC12qD3yuMMYOTTLfL6
   c=;
X-IronPort-RemoteIP: 104.47.73.171
X-IronPort-MID: 71836638
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:z2k1rqM1xcdf3XTvrR01lsFynXyQoLVcMsEvi/4bfWQNrUol0zwHx
 mVLCm6BOK6NY2qjLdB1Pty/o00C7MfRzNc3SQto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKlYAL/En03FFcMpBsJ00o5wbZl298w2LBVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Zl
 dRC6LOaYDYQZIrsgNRAAiVyEQ9vBPgTkFPHCSDXXc276WTjKyep5so0SUY8MMsf5/p9BnxI+
 boAMjcRYxufhuWwhrWmVu1rgcdlJ87uVG8dkig4kXeFUrB5GtaaHPyiCdxwhV/cguhnG/rEa
 tVfQj1odBnaODVEO0sNCYJ4l+Ct7pX6W2IB+AnL+/Fni4TV5B5w+7TqLYPXQNvQY9VolVaE9
 mDW3XusV3n2M/Tak1Jp6EmEnuLTkDnpcIMUGqex+vNjjBuU3GN7IBQTXgrlieKjgUD4Xd9DQ
 2QW4i0vqKI1+WSxQ9X9VgH+q3mB1jYMC4R4EOAg7gyJjK3O7G6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq1872Zqz6pETMINmJEbj1sZQEC+dj45oYokgjIUM1gAYaylNT+HTy2y
 DePxAA8iK8UltUjzLig8BbMhDfEjoPSUgc/6wHTX2SkxgB0foioY8qv81ezxeZNKsOVQ0eMu
 FAAmtOC96YeAJeVjiuPTe4RWraz6J643Cb0hFduG9wk6G6r8nv7LYRIumghfQFuL9oOfiLvb
 AnLowRN6ZRPPXysK6hqf4a2DMdsxq/lfTj4as3pghN1SsAZXGe6EOtGPCZ8A0iFfJAQrJwC
IronPort-HdrOrdr: A9a23:2e4LV6+By//r7KHiRNBuk+GBdr1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZtFnaQFrbX5To3SJjUO31HYY72KjLGSjgEIfheTygcz79
 YGT0ETMrzN5B1B/L7HCWqDYpgdKbu8gcaVbI7lph8DIz2CKZsQljuRYTzrcHGeMTM2YabRY6
 Dsg/avyQDBRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1cjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3bRY0eTFcZcso+5zXQISdKUmREXeR
 730lEd1vFImjbsl6eO0ELQMkfboW4TAjTZuCKlaDPY0LDErXQBeot8bMtiA2XkAwBLhqAC7I
 tbm22erJZZFhXGgWD04MXJTQhjkg6urWMlivN7tQ0WbWIyUs4mkWUkxjIdLH7AJlOJ1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGcl2E+pgEy82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TmbNXRXPOmSPJkmPLtBNB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8XU/fkr/YPf+q6GjMiq9NFlVcQ6duv22vaIJy4EUbICbQhGrWRQpj9aqpekZD4nSR+
 uzUagmdsPeEQ==
X-IronPort-AV: E=Sophos;i="5.90,272,1643691600"; 
   d="scan'208";a="71836638"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 10:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmtZxo/EjEurIGkSSmPA4n6k1QksYHWwVBrvlR2nOqVrfNZU651ed3/jYo7VMqvQCD4CEZ7Q3V8xPp+0qFmgFapZw4quOxKvsN27bBbTvc1ZIj1IfhShkLdqsOLvLtpPnyOXvkA5xPJbJ2TgGlH0odUw1HyP1znlNcOGRwLLU8yOTNSYdq0wXBKRl/1D1P6iTvG8XR8P0bUd6sAcaYjSqBdPE9opYD2oB7DSGrDDsMnPBHn3V8ZsdR79+G/XCpEcG1rbGK83hyZAN2NAOxsfY5aGdWoosQkl28P8SJf8ad+0MCG9W2CrkQ+VwwKrqsjxcVMBXD16AjyWZgWfYA9DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1/McT8rCeGGCPtHkVKInE6GXMkxR9fg9F7EF0SmErE=;
 b=OjWWKS/6mfBDVJsb3+9yQDceYBEEVqlSF6+dIZtTpE5jpAKtR634NMsJl967wr5LK9dOMOUs0AdJT4BEvy1Z66OBCZtQP0qQYb8YUoGKjV55c+qFzpgqkpuyiH436X3BIgkkHHCWQsVyinHzsWzawAZzYr7Um8Nistel6GCiID/lAbK8RqSMDrPblhb+1MTidRcqNs26gK8PE6vTYCu0R1UnsPqSoPFvgFagp16cS0pnawcqstBLorzrv7reOEq/okFq7sRrTL85PA0Mu87i4pxJSko8idgRzs/Bb5PonlthrbslAGx+UdNTnvNOE2rE8EjJfTLBicIWv7qUu7tfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1/McT8rCeGGCPtHkVKInE6GXMkxR9fg9F7EF0SmErE=;
 b=D5ulUtPJaLyEEUU8gyqUqQYdVNPqQiFhXc19+q/f0PYpVeBBEUkXbkxs4L6ZR2FepGD6bJNutcaT6JwxDoJU7htB7gTy0X8rbhj9Uq5caiD0Vq19Y2JGhee+XKns5Q7Obe09rt8APfZ8vg0DPsD/S2jtwPjA3+mpAwQu4VOGjL8=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BYAPR03MB4808.namprd03.prod.outlook.com (2603:10b6:a03:137::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 14:25:53 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::ac51:a410:14d4:de37]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::ac51:a410:14d4:de37%6]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 14:25:53 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <amc96@srcf.net>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Thread-Topic: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Thread-Index: AQHYU0SHTqWJMApeME+vJqcoJU7NiKz3HnsAgAAET4CAAAQVAIAAEEaAgAAVEAA=
Date:   Tue, 19 Apr 2022 14:25:53 +0000
Message-ID: <77cad36d-0b02-cb30-496a-e7738ad52206@citrix.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
 <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
 <20220419115737.GU2731@worktop.programming.kicks-ass.net>
 <8fbbd4ca-54b1-8c1c-19bc-3d0e6044ff5d@srcf.net>
 <20220419131029.GV2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220419131029.GV2731@worktop.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beea1e34-cebe-45d8-1940-08da221082af
x-ms-traffictypediagnostic: BYAPR03MB4808:EE_
x-microsoft-antispam-prvs: <BYAPR03MB4808184702884949E9491C5DBAF29@BYAPR03MB4808.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc/eK32nFCvXFtUcq7ctLeEZ+PWtomf83ozh3LLLH0GcCOho1ORHBP4xY3S723soM3nhdQP7PdOGSqAWC25wzKdvoKFXcZWkei2B9HA2Xeq1nhmWQlC4Qxx6d1Y2Q8GmGUBr5Poq5gCtTBCQ1/q6iJdurAiImX9kU28lpNJrx+EHn6Mf/mtabBiq3eRHJgRhr9OvnT+HkDEeJZ7RZmMKajyNFxe3IPqqMZ+RZ+JApBaSoHfLDZsOar6qZPwL3FIN/tWdg6z5mpID2g7P+V3FxaC4xfirvtKMywtFlbariGCS9CxPUVuL+JhSnT5ciEtFf1IAA1a6gIyp6nXESdDiMn9INbgWpPXR3BfsKcnUdGJYfQojQnohS/ipS8YZ3BGmKfWnqToSOUCdw7CqgRSTx+Tp43W4BElDON5M9KW8Jz0ybSgXT/FkBMXSVd90JjbHephWb6Ij9SApnIMHXC7zAB8V/NCmy9+NefP3LcZQWJJf74WTnyCHcPU/AtuGY4BWGTnIfPmd5gKiVMnPbtG11NITDc2c6tAzUfpalboi7Su8Yt32W8rriawFPtmV1unWmbh9CwUYMdno72ROgrkRHgMkfj6WrD18vLL1VF8QxJs6yHbcD7nfRi5Y0/Is38Udpo5NNLp8wBhn1kxJ8vACPZHf2jFkNzcOsCvKAobpQ6by61oxhU7buKKysU11zOM7j3f7AVICrD1RjPfoMDlthGayY7zqTZyn4b6t2gNHYMzjcNZgAvBo1eUoi593gyPKopWnypxmlNWiv0iSJh0Hp1pObKGATFEZvZu7UbdIFgt9LKo7hwhk9bRFRlatfOJxruAvtye4rb9wTuiCVAGk+rxt8lI1ARy5RQ6RqQaPJG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(82960400001)(2906002)(66556008)(8936002)(6506007)(6486002)(38070700005)(966005)(316002)(508600001)(4326008)(31696002)(64756008)(66446008)(86362001)(66476007)(6512007)(91956017)(186003)(8676002)(26005)(66946007)(122000001)(38100700002)(53546011)(31686004)(5660300002)(83380400001)(7416002)(36756003)(110136005)(54906003)(2616005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm5ZMWNIMzYyeFl0a2QwaytYYkltdFZmWnNYR2ZqVEllYzlubFVVNG5ZSWta?=
 =?utf-8?B?aHdkUkZHOHB2Q0t4UWNEOTJTSU92VGs1QzNhZG53T1loWjliaEZycE9tQ2ts?=
 =?utf-8?B?VE1HOFI0c2lwODRNaFFrNDRRSndwRVJBT3pzV0ljdU9DNXU0MktKSXBPVUVj?=
 =?utf-8?B?WlR3MWNScldCN1R0a3Fiem82YXhsWE5DeVQzQUc1T2NXdnM1YWtkUndtVnUx?=
 =?utf-8?B?ZjlDZGJVVmRDbXNJRGVka1ZpUnBtZTNENDdMalZvMkpUbTFsdGloR0Jldi80?=
 =?utf-8?B?VlZPaXcrSS9qNjRidVVOU2NoNnR3Yjh3TjlIQ0x4TnBURjB0aE8vR2hmSG9Q?=
 =?utf-8?B?L1pSRjlGaWdHMDVOZkVkbmVYd2dkZjFXcEwzWjQ1K3JUUmVFMDdVc053bDc4?=
 =?utf-8?B?L2NhTGJYRTNEMHpFUFJDdVV4NUNKY1c5aTJSOEU3a3p4NVphenpHV3kxMVVm?=
 =?utf-8?B?QVFlSXFROVIrSWRBSFFncldabEFaSi8yTVpmWW9adFFjQ3p0cXEvNzlsT0Zs?=
 =?utf-8?B?QjNZNi8rMDNyZkpiUVVhQmM2SzJ2VnJXSzlkaE5DemFDa084RkRtQTUyUU5D?=
 =?utf-8?B?NUd2cmZ6amFzQkN2ZERPaGRLUERabmQ5MFRyU2VveWhpSW0vSGlEOGxqQTNs?=
 =?utf-8?B?NGxBSWVYVGtuMGNRRTZRVCtMNjVKV2loUU5tTlUxMG1QUHdSUWowL0tmSTA4?=
 =?utf-8?B?QVU0akZrN1YyeldkNzBvSTFsTVpSQWhxVERkdWVlZkZoWExJblVlVmZpQnZr?=
 =?utf-8?B?WXFGYVhmOEE2TERsa29vTk5tTlJESGRUMWozK0theGZwaXdsZ2hQcGxxQVVZ?=
 =?utf-8?B?N3ZXaVFwSXVPWTF1Wk9GdG02clM1aXg5UDJlSXBJSWtRTzd1QXF2a3ZKYmVU?=
 =?utf-8?B?WGREcEQvM3R4a2N1Y01wbHUxODFseW4vVml6OWxBMU4wV1NpYlhPayt3cEs1?=
 =?utf-8?B?YllFc0hwc2ZLbGFBTEVNandobW5aUlcyMVJkS3RwUWg1S2xDd3ovWkkwNGVx?=
 =?utf-8?B?M00yMzV5SkpTUzV2NW5xMkJ6dUNsMy94L0lhSnkxZTErRWR2U0ZwMUFjck84?=
 =?utf-8?B?eVhZQ2l5djNyUUliZHhvcEZFN21wdjRDbWkrMEhycU5rZExwV09hZjZSN1lX?=
 =?utf-8?B?MnpMV3Vwbm16ZXVFV0YzSnh5dkthb0t5ZHdwa2EvZ0o4RWZDV2NkbFIwVUNM?=
 =?utf-8?B?NTNQb0xFVnc2MUhiOGFCREkwM1p1VE5mQVN4RmtiNE1UUzlQKzU5bWNJSWxG?=
 =?utf-8?B?M3FSRys4Yk5DZWZjTDMxUHlMWnlrRHpoT2ZmME5XTkh6R3hHMXFEb3k3dkNt?=
 =?utf-8?B?N2E5S2xFa1dqQWhmbUZZOEV3R0c3S2FBYWxmZGZmTnBmZGx0UTlQZE5DSjQ2?=
 =?utf-8?B?Mm1kMzdBSXJQd0NZaUIrUDVSYjZZRTZNYXpSK0RrcFRiLy83WHZtMWdRSkJt?=
 =?utf-8?B?WUpNaGx0U2VYdUxuUjFpN1ZCcUVVa25qVmRlNjlZMHc2U0ppZlFxK3dWbjQ2?=
 =?utf-8?B?c2p6TWlWTEsrZnE3NktDNXBvTjBKTklYSGk3RW1rcldiL0kvUUM0UGw0Ri8v?=
 =?utf-8?B?eEtwMlVFendvMHZIa0wwNUdaT1pxbzVYb2Vwa0JlSmVRd1FFdlRueEk1aTJ5?=
 =?utf-8?B?aXhvTTRqcGtUMENJMU4xS08waUMwZVM5eHd2UklWazh0Z2xVOXMrSS9DTEVx?=
 =?utf-8?B?RWNiTUNZU0xKTmQwY0Y4NXBNclFtcWtpUGszYy8xUlNCanhuS0xCeVVaVDZW?=
 =?utf-8?B?clRYNEhWWkFLOTVRdy9LRXFJNG45bUh5Qm91MGk5WDU4ODlnQ1F5UVZwbDdz?=
 =?utf-8?B?UFQ1VHd6dVYwakFDcW0yL0ZPT2lsTkUrV2NOb1hqR2hzMEprL1g5cUMwVzN6?=
 =?utf-8?B?c29VV1VEZUtuYzh5WWJkVXBLRWlQclZHKytSVnhTY2NWSjJGejJOc2ZENno3?=
 =?utf-8?B?RDMvTE1RSi96eUxKUElZY2VYZ3M0K2VzUDVNRUJxblRGTXd4SC9zbWh3b2xF?=
 =?utf-8?B?aDdEZnZkTzBwRk5yang2R01FbitlK01GV1prVWdDYzQ1L1I3LzUrK2tXbDNp?=
 =?utf-8?B?WXVnRTJOUWEvRHhHQUZkRW5Vd3RwVGZsWmNYem95dmR5OWozSWtCL3J1bUVY?=
 =?utf-8?B?b00zQzhjYktEZS8xR0R3OEU0UzM3eWNXNyt2NmRqRENTN0tqallaZkRkbE9R?=
 =?utf-8?B?QUREQ3dJbkl6cVNYOUZqRTNHaEhBZXUwNEJiSGMzak82VWhsVC82ZU9uV2Vj?=
 =?utf-8?B?V21QdklwZExLdUtJTUdld0xUR3VyQ3Y3L2J5TFNuL1dvbVpJWkYrVjZWejlk?=
 =?utf-8?B?bWY3ZmVBWmtuQ3M5V2VZallLTk1zb0RLYVBvTExqMXpKZXc1SVZodz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FD537FC682F1D45B594F73A9BCE5FB4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beea1e34-cebe-45d8-1940-08da221082af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 14:25:53.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSiIyinfF9msLJxN1gxCmxxFRN2kmUhbbCtTHy9+ztnG6pcmLEjXbwNpjMT5q9DmayqvE7+HrTEUV4fofnuKOvDX3mnSCoY83sVQNEJpMuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4808
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDQvMjAyMiAxNDoxMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwgQXBy
IDE5LCAyMDIyIGF0IDAxOjEyOjE0UE0gKzAxMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+DQo+
Pj4gU3ViamVjdDogeDg2L3hlbjogQWRkIEFOTk9UQVRFX0VOREJSIHRvIHN0YXJ0dXBfeGVuKCkN
Cj4+PiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4NCj4+PiBEYXRl
OiBNb24sIDE4IEFwciAyMDIyIDA5OjUwOjI1IC0wNzAwDQo+Pj4NCj4+PiBGcm9tOiBKb3NoIFBv
aW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4NCj4+Pg0KPj4+IFRoZSBzdGFydHVwX3hlbigp
IGtlcm5lbCBlbnRyeSBwb2ludCBpcyByZWZlcmVuY2VkIGJ5IHRoZSAiLm5vdGUuWGVuIg0KPj4+
IHNlY3Rpb24sIGFuZCBpcyB0aGUgcmVhbCBlbnRyeSBwb2ludCBvZiB0aGUgVk0uIEl0ICp3aWxs
KiBiZQ0KPj4+IGluZGlyZWN0bHkgYnJhbmNoZWQgdG8sICpob3dldmVyKiBjdXJyZW50bHkgWGVu
IGRvZXNuJ3Qgc3VwcG9ydCBQViBWTQ0KPj4+IHdpdGggQ0VUIGFjdGl2ZS4NCj4+IFRlY2huaWNh
bGx5IGl0J3MgYWx3YXlzIElSRVQnZCB0bywgYnV0IHRoZSBwb2ludCBpcyB0aGF0IGl0J3MgbmV2
ZXINCj4+ICJicmFuY2hlZCB0byIgYnkgdGhlIGV4ZWN1dGlvbiBjb250ZXh0IG9mIHRoZSBWTS4N
Cj4+DQo+PiBTbyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2F5IHRoYXQgaXQncyBuZXZlciBpbmRp
cmVjdGx5IGJyYW5jaGVkIHRvLsKgDQo+PiBUaGF0J3Mgd2hhdCB0aGUgSUJUIGNoZWNrcyBjYXJl
IGFib3V0Lg0KPiBSaWdodCwgc28gSSB3YXMgdGhpbmtpbmcgdGhlIElSRVQgY291bGQgc2V0IHRo
ZSBORUVEX0VOREJSIGJpdCwgYnV0DQo+IHllYWgsIHRoYXQgbWlnaHQgYmUgc3RyZXRjaGluZyB0
aGUgZGVmaW5pdGlvbiBvZiBhbiBpbmRpcmVjdC1icmFuY2ggYQ0KPiB3ZWUgYml0Lg0KPg0KPiBI
b3cgYWJvdXQgc28gdGhlbj8NCj4NCj4gLS0tDQo+IFN1YmplY3Q6IHg4Ni94ZW46IEFkZCBBTk5P
VEFURV9OT0VOREJSIHRvIHN0YXJ0dXBfeGVuKCkNCj4gRnJvbTogSm9zaCBQb2ltYm9ldWYgPGpw
b2ltYm9lQHJlZGhhdC5jb20+DQo+IERhdGU6IE1vbiwgMTggQXByIDIwMjIgMDk6NTA6MjUgLTA3
MDANCj4NCj4gRnJvbTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+DQo+DQo+
IFRoZSBzdGFydHVwX3hlbigpIGtlcm5lbCBlbnRyeSBwb2ludCBpcyByZWZlcmVuY2VkIGJ5IHRo
ZSAiLm5vdGUuWGVuIg0KPiBzZWN0aW9uLCBhbmQgaXMgdGhlIHJlYWwgZW50cnkgcG9pbnQgb2Yg
dGhlIFZNLiBDb250cm9sIHRyYW5zZmVyIGlzDQo+IHRocm91Z2ggSVJFVCwgd2hpY2ggKmNvdWxk
KiBzZXQgTkVFRF9FTkRCUiwgaG93ZXZlciBYZW4gY3VycmVudGx5IGRvZXMNCj4gbm8gc3VjaCB0
aGluZy4NCj4NCj4gQWRkIEFOTk9UQVRFX05PRU5EQlIgdG8gc2lsZW5jZSBmdXR1cmUgb2JqdG9v
bCB3YXJuaW5ncy4NCj4NCj4gRml4ZXM6IGVkNTNhMGQ5NzE5MiAoIng4Ni9hbHRlcm5hdGl2ZTog
VXNlIC5pYnRfZW5kYnJfc2VhbCB0byBzZWFsIGluZGlyZWN0IGNhbGxzIikNCj4gU2lnbmVkLW9m
Zi1ieTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiBSZXZp
ZXdlZC1ieTogQW5kcmV3IENvb3BlciA8YW5kcmV3LmNvb3BlcjNAY2l0cml4LmNvbT4NCj4gTGlu
azogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci9hODdiZDQ4YjA2ZDExZWM0Yjk4MTIyYTQyOWU3
MWU0ODliNGU0OGMzLjE2NTAzMDA1OTcuZ2l0Lmpwb2ltYm9lQHJlZGhhdC5jb20NCg0KTEdUTS4N
Cg0KfkFuZHJldw0K
