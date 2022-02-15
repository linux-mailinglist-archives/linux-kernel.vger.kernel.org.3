Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F874B68EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiBOKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:12:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiBOKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:12:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8CE6C1D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644919947; x=1676455947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+gPG/Utsr0tky39gQNifCQP058d8tvDR/lK/FoK2H3s=;
  b=oHDatTX+w/Tj83I1NlCqNMNYF5f0buL/e1NPU3ZwuLfxqrz+fdUV6oLb
   VgCpKPInBEh4Vm/7W1U2TIz1G3GLzRBekDbkqq7WjhGNBLwn7X5JZaDXp
   EcMGkF+tp9HmRNPyO6Kq8PSYuGrqRn+uzh6W5PqFKsjGtLD8EJcFVcKom
   dI+B/JD6DP4WiVFfca+p2kXjuSRYsibLItpmASHtIYqZ8BRLBp0Z1iS5E
   qxCRuGcUuZP36DYcF6jJIiqBoVWu6IWFzRGl1QF9SFlw5uD4uvvt5qq6t
   +H6ZB2M2zqTkOMZZ47Tk+ehiFZJVKyMMvx/nyXMPvkjrTFeyxwT98lXZ2
   g==;
IronPort-SDR: pj3yIQO2kNh3QB0MCwq9aZW6kcFMnKOsnt8HIb4DBk7TyMvkWAdkFbW/V+87Mc1KQp0kcc+jh4
 R/i7SOgGkC+RAXHyAFeSmi8IKOXhNljSQm1Zrur24s6ctEfjhXO0kSSvM3tP5f75O8GslpA6Nn
 ZoLr1qIQbsCDhHEZs21NEbsLxbuGV3Vbp4jCwgD6kUZwY91klhREdnK/8U54c8zWWuO8F5T5nu
 kG4aYEPSpNrMm3tDz4yYqthTauMCl4CgNFPLQH5/s0Ctq+Vg8BZMXZEu135W+9WP+vYeZXwA6U
 nFqahpt3UVNXYOCw1Lz9Blxb
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="85767723"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Feb 2022 03:12:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Feb 2022 03:12:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 15 Feb 2022 03:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+5bGyrRFDokDmdISYTEelIwE/PqKyXMwSzIkmiPpM8boPhAwOeC76BOcT2XXSteOZsttIeGcCJBo1ThGFsmpVWVwB7jOMMVFJBNWwHJYTG9n0Tu8BF5DiXpfMLnRDIx0OPNP5yUFbLmADd20RkohdIqMyOPubz0tHRfwin/AsKN3Q+u5KAZozr//v1G/qWZMpPjgG9vhf5hY5Wbm0n/PCYqArH/x+CRnNGbxWLgaFWuAyxEeKP9ZYoBzL2GSlKcT2Q4tLNU6c+dfA7mr3ZT3hpiRVH4+XNH6CXlYjG4cIJhwLAWNHByML1X/FoL9lNGna+HcGngw2RgaQ1+vcDG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gPG/Utsr0tky39gQNifCQP058d8tvDR/lK/FoK2H3s=;
 b=GQGdHq/EbKptv9Rb0NY9ONffQ5OD04vTSpkWzEfBs+MOXDHWu61UK8yAWGwVhXacu0q0a7mTne71AP5sSgoG1syxowcLd7uPRW456M4pCEolBnbqlFXEOe/GWT3neiU2+75lnG1J/nb8t/3mbUsLINXQxZjd2uw6nV/WZbnxckUTDN3yRTJd9ir/cBnaNcgokHd1KnfnFb/kB297HGPGIjGx/JaKB5SCwDWnncOO8QoLO6AuMx+nD4q088Fnr2FR7WliB2dgyUOiG/BU/thyzZTcjfd33UNNjGVN0RlLpQU9f3WjiZvFBWv5ldzvpuSZw9iTqN/WSMK/RsWEcxNb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gPG/Utsr0tky39gQNifCQP058d8tvDR/lK/FoK2H3s=;
 b=l40/RMg4BIbUyQVUxRvF4Vyayj54aSVTxEDph6zafnXuOpqErXIIZcZPQWyYZTJgqbf+fz4sVHIdHycltkMyFsqSZRaPN/yylTIdBezzg0R+1yOflWdaijDDz+K8qBb3OGwE1RLMQtrgf9iIWJ4zJnCK66Thm+nc6gNMEvbM7Mg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 10:12:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 10:12:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <p.yadav@ti.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Index: AQHYHiuFz8+evF2o8USFiXwNjUvH0Q==
Date:   Tue, 15 Feb 2022 10:12:21 +0000
Message-ID: <9b389632-66f6-dea0-da96-7d7560ce8517@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
 <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
 <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
 <d76f21dd-4038-57de-f2f6-6afa947b62cb@microchip.com>
 <c3a58de8ee39dd473483dfd0ed8a0058@walle.cc>
 <7d8b7581-4610-6c04-9033-dac9ba27038b@microchip.com>
 <3d5bb9c9480092c64c5574b6551e64f1@walle.cc>
In-Reply-To: <3d5bb9c9480092c64c5574b6551e64f1@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 485b2e2e-f101-4290-75ed-08d9f06ba7db
x-ms-traffictypediagnostic: MN2PR11MB4677:EE_
x-microsoft-antispam-prvs: <MN2PR11MB46775D57B504B2D803D4A4BFF0349@MN2PR11MB4677.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jF372cfO7Q7VrYkpLHKZPU8sgcbNixvAVICaJbnTOJmp7tpN477jUtVB76ENnEG/RITu2sRxMf0puMCHvQTPeI9Zx55UIFaQat4beWQZqdGHPDL6Az5uhsg4mcGN00ohBvDDUCTfRxMp97m3p/RF0NiBNf5SllzzPGQfMYSCym6YzJVvX4zpwyd5wGYOfWxBYyuOSr/5e8z+L9OkwUcOhDrhndy69mJnAz7Px+WgaVJ5diImBXBv79XLZneN2OxsynALXeyoRleKJ3yO9v/H1028CzZXJN98wvuaDwgwWeJlIBaTUFLPqRvH2N5Sh1JqK2try+U/JTXKOkxDm3Qo6wWg+Xn5vLPjVX/5RVvmVKX2L96YK3Fnq8ce9ACy5T26Ol09DC3KVZekOf2Lps/pX0oz8k3qgGm3gcsbCRnGAQvnOL3CxyO40i8QsgEcBtibSzx/Fc12jdXW13zhWSgQ5R76lcyTjeQaf25kXpubNWasykZqwiDpIT24qr4/kmOwuhKT6JrREVdS4a2dz2mg4UBTHGw/kHLgK51BR8fSi3XpnG+IGQ1xUYi3z/p4MvBJJBDQv6WOBJHnrW7UDTar/68HRySMaonU/1p1GVEMYg1b/B6XuTEBgHfVZwjNBIxYPcEgqLWjV/LFuvAZhdBvVRSWh/BKDErT9foxFviP1L9AmEz36901rafogf/B/w6xsFdxv2wlKNeqgRvPAM/2gMU+B2oYVoNBKugnSOngLA5UN5OJFcwWAfk4pBEBwU9DFmwX3xeev7mf8Rbc2f5fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31696002)(122000001)(5660300002)(2906002)(54906003)(91956017)(38100700002)(38070700005)(508600001)(71200400001)(6506007)(6916009)(6512007)(6486002)(53546011)(26005)(316002)(8936002)(64756008)(76116006)(8676002)(66476007)(66556008)(66446008)(4326008)(66946007)(36756003)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGROOW0veWc4SDk5Nm1IK0NvSHhJQlpQTWxsbDZLU25mQ0pramhGa0FvcDFl?=
 =?utf-8?B?YzUzQXZxdFdLSUE1OW9QYm0vcnA0YnhSR3hzalZkWHJTSVAyK2p0RGwra3kz?=
 =?utf-8?B?Y0ZxQjkvc3hBaEZlY0FpdXpEVzUwYzBZQXk2TytGV3FwT05SdHdkdnFKVWVP?=
 =?utf-8?B?TnFCc28vZnJ1OGQ4a21OY1RWMnFaeGg1TTJMRndyMmZrZjhuTWxkK2NWUzhR?=
 =?utf-8?B?aFR5OHp0TUJkT01VUnJhUFc3a2pvYXZESnVkWU9vWXhuWkVKdXpMdW5iM3pH?=
 =?utf-8?B?NWszdmVYZzNLaXBJbjZoalpQRlBRRW9TenFSdVJQSXBNSTk1SFB0czhmakxs?=
 =?utf-8?B?UFFkR0FlVUoySC9pbjR2RFZ0Y2lYeFh1OGU5WDAwMTcwOHdHdENKMGRySHdB?=
 =?utf-8?B?UUhpaWl6TXkrcE4zZnZvZmNDbjM4dEdod2krZlFaU0lZMDZEOVQvRjZDZHpJ?=
 =?utf-8?B?dW4ybFRIWWlYTHd0dnJPS0wwK284STZaVnkwVWdGTUdUVVJDQ0lKTDBGbWVS?=
 =?utf-8?B?aytUMWpnUEVBeGMxVzA0YUkzbzN0RTJJTktucnRqU2h6ZGdtSkpsQVdFaEY2?=
 =?utf-8?B?eGF6WWszdGlCSFZTeUNJS09YQUhjNDVsRm5VMTRYcis5YnNGaEt3cE9jUDVi?=
 =?utf-8?B?dVlzeWpwaEEzK1VadStHUlhLc0ltdklWczZadHhGNXdKb3MzU3V1enBnUUVB?=
 =?utf-8?B?RS9LQUkrVld4dlUwTEtXbE4zL1R0VlphdWpOUTFTRXZSRTBDYzh1QUJGbE5z?=
 =?utf-8?B?SnpMRGJGc0YyeHlRYlZNNkljSkdqSzBPczMyUm9pK2dhbDZFWE1CSG5xSmpq?=
 =?utf-8?B?dFc4LzE1azloQ29HTTdpZUhLNGh2dVdIb1Y2K3RJOGhZdzBzVjVlaGQ0Z3Vs?=
 =?utf-8?B?UW4wWHQ2amU1bWIzRlA3a1NiMmxrcHZNVXNCY3FkVHBiOElDVlkxWUZybEt4?=
 =?utf-8?B?ems5TjUwUklkdUlEK1lLNm14WFpJMnBORVpWVlk2c0FKcWp1SWRqc2kzUlVv?=
 =?utf-8?B?cEllRVZlNk1VSTBRZ3RvOG1lcXVCNEVBalY1Uk4xTW9zcVprMTJ2cXl6YW1F?=
 =?utf-8?B?cW43QVU5UEtsN21ReTh3VDZDZGdHNS8vaXMxamp3ZGREOWQ2UUd6VGEwZ2cx?=
 =?utf-8?B?dGNhWFo4Zk9LS0xEdHVVTDFEd1JWUllUUHZTb0NBSzhmVUJGcG1hK0hOekpL?=
 =?utf-8?B?Wm9LcHgyU01tYmptTmFSZUJJNXVvVnU1T28yRWdTWjNGTkxxaTh0czNKOGNl?=
 =?utf-8?B?M090a1ZUaWtnSVRTQVdCdHp1bHFvbFBNenZFS0V4UUU4eTVLVGlYUWtKa0dk?=
 =?utf-8?B?ZnFoaXRiajRRQ0g4RnUrL1RuVU8rUU1vYkFiSHhGMzRnSGlleHZ6cEF1VFFN?=
 =?utf-8?B?d0RzRFVGaUpjM0ZhY2JXRkIvbzlpczdTZkVsSmtQbjAxVmFVOWdmUG5QY0xi?=
 =?utf-8?B?Q3JEOXZRMy9BK1JiWHRWV04rS3hucUI3a2ZMUkF6bXRvd1V6MXhxaGFocnFh?=
 =?utf-8?B?RE9WQ0IyME14dHdSTDlDNWVWb2xPUWRBOFh4N1VBQkg3VWZDTzJnd2F4SUc2?=
 =?utf-8?B?SWI4TnVFMXVadWhzTzlrL0ZFNTI5WC9MN3F0bEp6b09UTGoxaUNoSlJNVWth?=
 =?utf-8?B?aW5RQzhDWEZVZW9RdmJhU1hDZDVzdUJnMnQwTFNwaTJRSFBTQnRsdFJFTm43?=
 =?utf-8?B?dHNrZlM0T2gvaVAzZ2tPdEpiNEZlV2lHcDRaMmRMYzNmT3Bxb3JseGVQSnRB?=
 =?utf-8?B?UGNvZm1Ud3AwQjRIb0tjRis1TUl1TVpla0ViR1ZDTGdJdGRSakF2OFA2Z0lo?=
 =?utf-8?B?SDk2NDJmLzliOGhaM1M4K3NzR3B6QUxsMTF5MCtiY0hHaGlnbUsrMmNMWlZU?=
 =?utf-8?B?SjErUGJ5L2E5aHdROTRvdnZQTkd0WDNmQmlhZUwxejk4Vm5wbXR2MytsZXVT?=
 =?utf-8?B?SFV2OVFQWkwrbTQrOHEyRlNUUW5VUllsMS9teWxpQzZRQi9RUktYVHRNMmlz?=
 =?utf-8?B?bllvOGl3U0N1c3VXakd6MFhjKzJMcW9ocmJobnlpZ05peXYyU1J0bWxmck5G?=
 =?utf-8?B?R0NkMHY2SGd3WFdkV2lFbkc3cUNHdHlBUi90eWR3VS83K3ZTQ1FKbFQ5NU5Q?=
 =?utf-8?B?SVNyMnRNMjFIay9ZQkRMWGZXcVcxQUV6cnNNdVQwVzFwdFhCbC91N1JtS2oy?=
 =?utf-8?B?YkJTdmNRdkgxVk1KUG1nYXprUDZCazF3bTJEeDJDNEttdzByR2tOVGdjclBI?=
 =?utf-8?B?UUxLdkJrRjhaQVh0QTNybTBhTTlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9BE1EF583A5794EBFECC14BBD69C88E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485b2e2e-f101-4290-75ed-08d9f06ba7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 10:12:21.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6jk9XpU6tCJpHYaNJ6JRKkbCc6TrOBVtEW4eXpKk/QUpYnKpVS77wf6Tue7NezHYwA8w0CRD9eku0o4VcQwxbmwRSLHUkPa7Xke8u0V8As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNS8yMiAxMTo1OCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTE1IDA5OjUyLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE1pcXVlbCBpbiBUbzoNCj4+DQo+PiBPbiAy
LzE1LzIyIDEwOjI1LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+
PiB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBBbSAyMDIyLTAyLTEwIDA5OjA2LCBzY2hy
aWViIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+Pj4gT24gMi8xMC8yMiAxMDowNCwg
TWljaGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4+PiBrbm93DQo+Pj4+PiB0
aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+Pj4gQW0gMjAyMi0wMi0xMCAwNDowOCwgc2No
cmllYiBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb206DQo+Pj4+Pj4gT24gMi8yLzIyIDE2OjU4
LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPj4+Pj4+PiBrbm93DQo+
Pj4+Pj4+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+Pj4NCj4+Pj4+Pj4gRHJvcCB0aGUgZ2Vu
ZXJpYyBzcGlfbm9yIHByZWZpeCBmb3IgYWxsIHRoZSB4aWxpbnggZnVuY3Rpb25zLg0KPj4+Pj4+
DQo+Pj4+Pj4gbW0sIG5vLCBJIHdvdWxkIGtlZXAgdGhlIHNwaV9ub3IgcHJlZml4IGJlY2F1c2Ug
eGlsaW54X3NyX3JlYWR5IGlzDQo+Pj4+Pj4gdG9vDQo+Pj4+Pj4gZ2VuZXJpYyBhbmQgY2FuIGNv
bmZsaWN0IHdpdGggbWV0aG9kcyBmcm9tIG90aGVyIHN1YnN5c3RlbXMuDQo+Pj4+Pg0KPj4+Pj4g
QnV0IGFsbCB0aGUgb3RoZXIgZnVuY3Rpb25zIGluIHRoaXMgZmlsZSBzdGFydCB3aXRoIHhpbGlu
eF8gOykNCj4+Pj4+DQo+Pj4+PiBJIGRvbid0IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBoZXJlLCBv
dGhlciB0aGFuIGl0IHNob3VsZG4ndA0KPj4+Pj4gYmUgY2FsbGVkIHNwaV9ub3JfcmVhZF9ibGFi
YSgpIGJlY2F1c2UgdGhhdCBsb29rcyBsaWtlIGENCj4+Pj4+IHN0YW5kYXJkIHNwaSBub3IgZnVu
Y3Rpb24gYmVsb25naW5nIGluIGNvcmUuYw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gdGhlbiBsZXQncyBw
cmVwZW5kIGFsbCB3aXRoIHNwaV9ub3JfeGlsaW54XyooKT8NCj4+Pg0KPj4+IEknbSBzdGlsbCBu
b3Qgc3VyZSB3aGF0IHRvIGRvIGhlcmUuIEhhdmUgYSBsb29rIGF0IGFsbCB0aGUgb3RoZXINCj4+
PiB2ZW5kb3IgbW9kdWxlcyBpbiBzcGktbm9yLiB0aGV5IGFyZSBhbGwgcHJlZml4ZWQgd2l0aCB0
aGUgdmVuZG9yDQo+Pj4gbmFtZT8gRS5nLiB0aGVyZSBpcyBhIHNzdF93cml0ZSgpIHdoaWNoIGlz
IGZhciBtb3JlIGxpa2VseSB0bw0KPj4+IGNhdXNlIGEgY29uZmxpY3QuIFNvIHNob3VsZCB3ZSBy
ZW5hbWUgYWxsIHRoZXNlIGZ1bmN0aW9ucz8gT3INCj4+PiBkbyB3ZSBqdXN0IHRha2Ugb3VyIGNo
YW5jZSB0aGF0IGl0IG1pZ2h0IGhhdmUgYSBjb25mbGljdCBpbg0KPj4+IHRoZSBmdXR1cmUgKHdp
dGggYW4gZWFzeSBmaXggdG8gcmVuYW1lIHRoZSBmdW5jdGlvbiB0aGVuKS4gVEJIDQo+Pj4gSSBk
b3VidCB0aGVyZSB3aWxsIGJlIGEgZ2xvYmFsIHN5bWJvbCAieGlsaW54X3JlYWRfc3IoKSIuDQo+
Pg0KPj4gSSBkb3VidCBpdCB3aWxsIG5vdCBiZSBhIGNvbmZsaWN0Lg0KPj4NCj4+Pg0KPj4+IEJ1
dCBJIGNhcmUgZm9yIGNvbnNpc3RlbmN5LCBzbyBoYXZpbmcgc29tZSBuYW1lZCB4aWxpbnhfLCBz
c3RfLA0KPj4+IHN0X21pY3Jvbl8gYW5kIHNvbWUgc3BpX25vcl9yZWFkX3hzciBzb3VuZHMgYW5k
IGxvb2tzIGF3ZnVsLg0KPj4NCj4+IHllcywgSSBhZ3JlZS4gVGFrZSBhIGxvb2sgb24gd2hhdCdz
IGhhcHBlbmluZyBpbiBOQU5ELiBUaGV5IHByZXBlbmQNCj4+IHRoZSBuYW1lIHdpdGggdmVuZG9y
X25hbmRfKigpLiBPciBpbiBTUEkgTkFORCB0aGV5IHVzZSBmbGFzaCBmYW1pbHkNCj4+IG5hbWVz
IHdoaWNoIHNob3VsZCBiZSB1bmlxdWUuIFNvIGhvdyBhYm91dCBhbGlnbmluZyB3aXRoIE5BTkQg
YW5kDQo+PiB1c2UgdmVuZG9yX25vcl8qKCk/DQo+IA0KPiBTb3VuZHMgZ29vZC4gUmVnYXJkaW5n
IHRoZSBmbGFzaCBmYW1pbHkuLiB0YWtlIGEgbG9vayBhdCBXaW5ib25kIFcyNU0NCj4gd2hpY2gg
Y2FuIGVpdGhlciBiZSBOQU5EIG9yIE5PUiBkZXBlbmRpbmcgb24gdGhlIHNpemUgOykNCg0Kcmln
aHQsIHZlbmRvcl9ub3JfKigpIHNob3VsZCBiZSBqdXN0IGZpbmUNCg0KPiANCj4gQnV0IHRoZSBt
YWluIHF1ZXN0aW9uIHdhcyByYXRoZXIgd2hldGhlciB3ZSByZW5hbWUgYWxsIHRoZSBmdW5jdGlv
bg0KPiBuYW1lcyBhdCBvbmNlIG9yIGJpdCBieSBiaXQuIFRvIHByb2NlZWQgaGVyZSB3aXRoIHRo
aXMgc2VyaWVzLCBJJ2QNCj4gdXNlIHRoZSB2ZW5kb3Jfbm9yXyBwcmVmaXggZm9yIHRoZSBtb3Zl
ZCBmdW5jdGlvbnMgKGJ1dCBzdGlsbCBrZWVwDQo+IHRoZSBtaWNyb25fc3RfIHN0X21pY3Jvbl8g
cmVuYW1lIHBhdGNoKS4NCj4gDQoNCmxldCdzIHJlbmFtZSB0aGVtIGFsbCBpbiBhIHNpbmdsZSBw
YXRjaCBiZWZvcmUgbW92aW5nIHRoZSB2ZW5kb3IgY29kZQ0Kb3V0IG9mIHRoZSBjb3JlLCBhbmQg
dGhlbiB5b3UgY2FuIGZpdCB3aXRoIHRoZSBtb3ZlZCBiaXRzIGluIGFuDQplbGVnYW50IHdheSA7
KQ0KDQo=
