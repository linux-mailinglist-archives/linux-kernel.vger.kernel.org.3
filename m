Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66EC4F931A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiDHKgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiDHKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:35:51 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 03:33:29 PDT
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417B31C41F;
        Fri,  8 Apr 2022 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649414011; x=1680950011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8SEbYrBgOyIV3v8EU5DTeb3nWg5J3X3w3EGjrrVMAzA=;
  b=VMUqiVPPSxICCa+KVdlScVnp/juRmyifDGXKIn45ecdVFboBEaViJ17a
   wlZFkfHpq6rtZSNFgdRBJ6aRNzzzCfmA15qvbwlhl55uWRTpbRH38qILM
   99VHn2fToap4c5lO3Zweghpi+tHLnFlJK7F43Z6smkM6Ke5tDiTm9xbUe
   2aICdS/goQS30ml2TiMIUzZ/i4Xl994eAh+trqjwTT5JQDhamutTrlFnT
   FEeNU27Wd15bOgD10LVgXBLBUyOUA+V3VVZcu8gq/n+s4qh25gcMF8xAA
   FAXGMNUb7TwoYBnRoB3CRwYZRT0337NmAsNLX+KXfQvFKuzg1/k+5VLDk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="54726668"
X-IronPort-AV: E=Sophos;i="5.90,244,1643641200"; 
   d="scan'208";a="54726668"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 19:32:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhY207AnXWiDk3nsTaFXIo5aQmZaujmtE+/BvKA9TDwXVUAtCSd3vDHJ+2DKYWq5QUHNAWYPYx6p6MM7dI98A9f4EnfcBJDwBJvb/r4JfbI3wVPROJCkz2vPQlpVsI9IqESbODtzVoEMm2dBkvgZb9//RmZgnuthc6TV5ZhpUUkV84mIsyZEMZZjkiPNjA2OyLCx0OekfcjdGExyVGV0WPQGBWNO6k6jf3kf0Pb53XB+Lf5JCeSiwnxbTULj6a5hTzYYgW3MmDLukHb8c2umvvblv20JavkxNy0/lD3+Lm8v2qYIsqKw9zTIbUZ64wqiccWTNiV9Qq1aoQZ+5jo9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdC54XSWxA9wtHjXVTeU06IQDWoCM3hbljZ9/QOYq3I=;
 b=NkV23UEP9qG4VGx8cprA0gsKQ5YD1A9hPYnelN87nEd2dE3JlSN3+q30jNwLlIcM0jaCqE1cWek6BcLGwMmYoLl0x/MQRh/uJBhaI6QKfB/9vSawXQxC0wF508uu7OLQTB8D45p9lKXdhARDVEzm/VMhB7Cy283BY+S5KC3ocNGx8LqVa/G7u23ctOey1j2w1cThmcllzgIWONepJtUM3jmNfNPNCZZ9OCflymsB2GbsplgiBWNwzHJJT8kGtcdByb16bLjJOhlKNXSBNogs6HbXDrQvIOf2RLMq1k25LnGmRVVtuH/8ZkmWbSWJNnJcL4mKabJDWAg1fnJ8qEmrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdC54XSWxA9wtHjXVTeU06IQDWoCM3hbljZ9/QOYq3I=;
 b=Y1B4CTYBcAJWdT5X1tTzTPQ8Fe51mXzlk4WdXai4PP2ZnkwcFd89eXhASm0jfygwNF9JcMB1sT8Z69JqMkeSgDIB8Q12mKlR5KEoHGCQgssnngxirDtpDHpIwM1/DS4gYNMYpeymz2+RGVF9rqvQVHAEVCySXUZl3XFLIu6EqGw=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TYAPR01MB4784.jpnprd01.prod.outlook.com (2603:1096:404:12a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 10:32:16 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::a91e:d936:37ec:f656]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::a91e:d936:37ec:f656%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 10:32:16 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Topic: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Index: AQHYROFUWg6uBlnqVU2NIy0zBQeT5KzZYQIAgAdi+j8=
Date:   Fri, 8 Apr 2022 10:32:15 +0000
Message-ID: <OSZPR01MB7050ED8D47839EAC9B4FC5BFEBE49@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com>
 <YkWVTEG5oFO82GPL@kroah.com>
In-Reply-To: <YkWVTEG5oFO82GPL@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-04-08T10:32:14.684Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 3288d822-e269-7beb-e4b7-24d55e1c63bf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e905fc-2b53-4b1c-2548-08da194b0d39
x-ms-traffictypediagnostic: TYAPR01MB4784:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4784B81B8C06F5E9C772F28BEBE99@TYAPR01MB4784.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+ht22gJ1IYf+dUTJr/gvwA8w4VItbx4VfmfIxtcsn93qTxRqbqOFAEP9YGzpn7v53zi3OeNx4+0q4/FOXZ4WiYpccr0Dwp2tTASr1jXy9a3IPp4QJLUUfsDfLkemAkE9HBbRddYyMVFBYXBYew/bLeoxivPpEVqxz+KklaeQSUDW8Qypw1lQSbE+LanrceYOUezQferkP0lHw+IX950Rfh+M7BPTfWSvBqKCsT7Ym5YnFex7daQGS3UolbOzxUwngUZ87lv+Lyiy3/wMqescaW01+Ph+Xi2xqDUryJWWNF2m0mPwESs3Sz6/IzLK3BwpDTn+R94v1eogQx34dCrVRvK1EZfunGO/4koeru7eOCYXK8AHrjbqJZs2QFe4TDj/mp1vgWHB1o01zC7/o0xZe1SNatkl5O79PN4EB/iCIZtkl2bzHg3Z1anUTo6DNS/ZMLqpIcsFusC2wWXjBRkj3QzNCINBH/BnJogNkPv+MQ4JiUCj6ZgGI8u4SFjzEvoYiUfieprnHjjeIWAERiE2mheiLyCbdtkHMTVgwnXDidd46GdZQGCwSc7nmIFB1XleDwUTFLwGOx8wHgpf7ecVqKvbqm4HyBwNdNgJC+nLszYIofW8tdS83gJE4vQWEJ3kh1l/Hygjq/gZ5IC0cs1XhKd2sKeufsNJ4H1qJ9nuWby5um441rEgYQDGHACA3735H8GZp4aZ+k4N2oK0lChTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(2906002)(8676002)(9686003)(7416002)(8936002)(33656002)(5660300002)(186003)(26005)(52536014)(508600001)(7696005)(86362001)(6506007)(66446008)(122000001)(64756008)(66946007)(76116006)(66476007)(66556008)(82960400001)(38100700002)(55016003)(316002)(6916009)(54906003)(71200400001)(38070700005)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SE9ZVlliSFpXU0dOQXcyTHdseTNyQUZidllqY2ozb1lTTGw2MVl3bGZH?=
 =?iso-2022-jp?B?OFJaU0laQUlDbzBKNHVIOHdlRjJBd1F4L2Q5K3dvd2FTb2ZsU0hmZGJF?=
 =?iso-2022-jp?B?S2srYjFud1Ric1g2SHU1K2J1T3ExSHAzb3lpT0xKRGZyd2w4bUM1dkdp?=
 =?iso-2022-jp?B?RzRWTXpTMXViVHRJV3BHODhRdDdFRis0MjQvZGtYenhSUHQ0M1JES21G?=
 =?iso-2022-jp?B?TGpkU0F6bTN0WEtZU2txRjBHMnNia21aaDhwZnNkSEtJbUprYzcvQ2Qr?=
 =?iso-2022-jp?B?WFVFL3RnbERYSEhYN2F4eGU0Y2I0T1l1YkZsYnYvZk9iVzA5dXk5Zng0?=
 =?iso-2022-jp?B?SFA5RFVUeEhGZ3pLZnZHeVVvQXY4UXNab1ZSb2FFd0ZVNWowdHpoRnkr?=
 =?iso-2022-jp?B?d2lxNkpHWXJKNlYycHBpNS8rZ2xwaVpWVldPSWlIdkcweVBnb3IwOW9X?=
 =?iso-2022-jp?B?bHo1QkhSZGtmUkFESExLdC8vNzN3dUNzd2lqY1JlRlQ2YmdIOGphOEo4?=
 =?iso-2022-jp?B?b0h2WldBYkNXSEh1cjdOY3Z3UEIwVWZralc4dFdycGpncEZjMXFsUmFW?=
 =?iso-2022-jp?B?U0svb2E1dTdSVGo1UklrbjNEN3RSUGpxY2JIdXVFNlBMbVlCMjZMZE9u?=
 =?iso-2022-jp?B?UlBEcHU1YUhwOVJEMThDNDRzekNhYmNtVnhMU1VRWjRueFJzVFFPemZu?=
 =?iso-2022-jp?B?ZmMveWxUZFdWdnZWZUxzOU9NTXJ6c2pZWFVZQ21GcG04QTZGcHhrL2lr?=
 =?iso-2022-jp?B?bkNKWS9qTG1tbENQOUdUZlZqeTFIYUhzR0ZHVnY2WTR4UkdsWFc3MHBH?=
 =?iso-2022-jp?B?QnFiZjFld2FPRlloMjVoNGlHQ2Z0MXdIRVh0b3FPQzNUUlRBVE9HQ0NL?=
 =?iso-2022-jp?B?RU5zTzlzQVRqRXhndHFhb1hieDFWbGxHOVhtaFdSV3R6b25QM2V4YzFh?=
 =?iso-2022-jp?B?TnpvZlNGN1R4Q1BrU0RsRGFTS1RlMUNPa1NXRkhXcXBVR3RqcW1EcGFG?=
 =?iso-2022-jp?B?WVR2c2tlS25NeTIxaTFCYUJzK0IzWUw1QXFoOUY4Zk9xNE9TV0k4MDNM?=
 =?iso-2022-jp?B?WTIzUGNZUHNVQzdLVllTSHVma0EvNXN3RE5RcUlEd3FPTUlyalNKc3k2?=
 =?iso-2022-jp?B?R3BSbVBJT25JWU8ydDhBZ0lOV3pxRWZBZ3VKTnpCRzNMZ3lvOVhJc05C?=
 =?iso-2022-jp?B?dTlheHV4YndhOWZHZnhvcVFSbVZWZVRXRHlLU0p3NHQ0SUZQM0hoM3BW?=
 =?iso-2022-jp?B?YnNkQ01SUUkraEZPSEhWd1pjY0QyMSs4REowbnI1RFdlWFJnY0FmdG85?=
 =?iso-2022-jp?B?ZHVvTU44NkdteEMybDhPUGpPSENxSUtqeGxSVjNMdXBHQy8vV2VnWFBI?=
 =?iso-2022-jp?B?WE1UeFRMSGhjVjVCcWhUVmVlcDd0bGpKUnc0YnN6L2dYeFJVaWNsV1lu?=
 =?iso-2022-jp?B?M0tmSk50ZCt6aU5FeENmWHVHVGdBQmU1WTBnN0Y5WndaQ1laVkp0NkNW?=
 =?iso-2022-jp?B?aTdHaFBEMWxjZ1A2Q1NsR3FDVTVnaHkvd3dDZlA1RWxhbUJJV2ZLdzhh?=
 =?iso-2022-jp?B?RVBXUlhlWStGeHl6MWo1RjE3RVdGZjRHL1JzaTlXbDk3a1Rna0MyT01v?=
 =?iso-2022-jp?B?SkJSNy96SmpWTm5kTFVKazJlWmpsS3ZlcVVZMVVmWlVXQXk0bG1Danll?=
 =?iso-2022-jp?B?SGxjQ1oreVRMRHdoUUlRYUZQNG8wZDNTRjliYWdhVDh3UklsUDFJcjBk?=
 =?iso-2022-jp?B?bEpmdlZHVWtabHZ1NFU2R05vMGRqaWE2ZWNaUDRIbmJLaHB1bUJnTzJI?=
 =?iso-2022-jp?B?ZmRrd1l5dlRCeFdnc09BbThFTnYxcERmcGxMd25YU3g2VS9kZVpZQk5F?=
 =?iso-2022-jp?B?TzJGcldFTEtxNXMrNlMvVHFPOUhIY1Vsc2ZWbmt6Q3psR0EreFNwUng5?=
 =?iso-2022-jp?B?ZXBNZjMrb09hcUZlQVNwWnRkbEowQVE1V1IrS3N5cVBsMEQ2RlQ5YjNj?=
 =?iso-2022-jp?B?Z3g5ODVjTTNnZ2ppTFFNTmlVUTkrcjFLUVE4SUNTUjRDcVQ4cnlYdzNX?=
 =?iso-2022-jp?B?em11ZzZMYVVFZm95NUs5bE4rck1NTGVKZ0x3TmhsQ05kRE8wTWxBOXNF?=
 =?iso-2022-jp?B?NHFwTi9RbU9QNElDYVpqNlREUlBKdE9Xa05VVloxSE1CV1kvOHRrbjdp?=
 =?iso-2022-jp?B?eXA4RjlxeEFDQk9WYVlXSldMNHUzM05DM2lXVlFxMzBHY1QxcXB4QmJk?=
 =?iso-2022-jp?B?RXdCUlpsTHpvQU1rWlg2b2w0SS9ld2Y1K1pBTmNuQ1c0RWdxUHpFWXF5?=
 =?iso-2022-jp?B?V2dxUzlEVzMycTh3eUVzNW10a1hpSXdvR3kzemxaQ29yL0tVMEN4c1VZ?=
 =?iso-2022-jp?B?c3FLZTZLUE9tcGRGRVBIRG9LVGhIbVlPcU54Qmt3MFlqLzlQYnFlUHNG?=
 =?iso-2022-jp?B?LzJIc2ZrZzI1UVlGM3Y0T08zUGE4SGtSNnpmYUZXMXBWSXEydWVJRklB?=
 =?iso-2022-jp?B?VktJU1BpUWdOU0RRR3ZXbGNoVTNjQXAxcnJ5VHJIRjFyblNUTk44c3VT?=
 =?iso-2022-jp?B?eXhkdmZmVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e905fc-2b53-4b1c-2548-08da194b0d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 10:32:15.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHA5+GKU92JM4Sa1RieiwPRKMy6uNzzC306RBOxTiBZLb/IPkAw3LinTI8aRpzya/xNYb8becUKjN86QFVykultsHVP+3cx+B11YFX+UKfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4784
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,=0A=
=0A=
> > Enable diagnostic interrupts for the A64FX.=0A=
> > This is done using a pseudo-NMI.=0A=
> =0A=
> I do not understand what this driver is, sorry.  Can you please provide m=
ore=0A=
> information in the changelog text for what this is, who would use it, and=
 how it will=0A=
> be interacted with.=0A=
=0A=
I understand. I will add a description in the next version.=0A=
=0A=
> > +config A64FX_DIAG=0A=
> > +	bool "A64FX diag driver"=0A=
> > +	depends on ARM64=0A=
> =0A=
> What about ACPI?  Shouldn't this code depend on that?=0A=
=0A=
Okey. I will make it dependent on ACPI.=0A=
=0A=
> > +	help=0A=
> > +	  Say Y here if you want to enable diag interrupt on A64FX.=0A=
> =0A=
> What is A64FX?=0A=
=0A=
A64FX is a processor designed by Fujitsu.=0A=
For the sake of clarity, I will describe it as "Fujitsu A64FX".=0A=
=0A=
> > +	  This driver uses pseudo-NMI if available.=0A=
> =0A=
> What does this mean?=0A=
=0A=
This driver uses the pseudo-NMI feature to perform diagnostic interrupts=0A=
for A64FX. However, I felt that it was superfluous to give this explanation=
=0A=
here, so I will delete this sentence.=0A=
=0A=
> > +	  If unsure, say N.=0A=
> =0A=
> No module?  Why not?=0A=
=0A=
request_nmi() is not EXPORT_SYMBOL. So this driver cannot be a module.=0A=
=0A=
> > +// SPDX-License-Identifier: GPL-2.0-only=0A=
> > +/*=0A=
> > + * A64FX diag driver.=0A=
> =0A=
> No copyright information?  Are you sure?=0A=
=0A=
I will add copyright information.=0A=
=0A=
> > +#define BMC_DIAG_INTERRUPT_STATUS_OFFSET (0x0044) #define=0A=
> > +BMC_INTERRUPT_STATUS_MASK ((1U) << 31)=0A=
> =0A=
> BIT()?=0A=
> =0A=
> > +#define BMC_DIAG_INTERRUPT_ENABLE_OFFSET (0x0040) #define=0A=
> > +BMC_INTERRUPT_ENABLE_MASK ((1U) << 31)=0A=
> =0A=
> BIT()?=0A=
=0A=
Okey, I will use BIT().=0A=
=0A=
> > +static irqreturn_t a64fx_diag_handler(int irq, void *dev_id) {=0A=
> > +	handle_sysrq('c');=0A=
> =0A=
> =0A=
> Why is this calling this sysrq call?  From an interrupt?  Why?=0A=
> =0A=
> And you are hard-coding "c", are you sure?=0A=
=0A=
As mentioned by Arnd, I only called panic () at first, but after receiving=
=0A=
his suggestion, I decided to call handle_sysrq ('c').=0A=
This driver only supports the function that causes a panic when receiving=
=0A=
a diagnostic interrupt from the outside, so "c" is coded.=0A=
Also, no data is added when a diagnostic interrupt is sent.=0A=
=0A=
> > +	if (mmsc & BMC_INTERRUPT_STATUS_MASK)=0A=
> > +		writel(BMC_INTERRUPT_STATUS_MASK, (void=0A=
> *)diag_status_reg_addr);=0A=
> =0A=
> No need to wait for the write to complete?=0A=
> =0A=
> You shouldn't have to cast diag_status_reg_addr, right?=0A=
=0A=
Due to the specifications of the machine, there is no problem even=0A=
if there is no write wait processing.=0A=
=0A=
I will remove constant and (void *). Thank you for pointing out.=0A=
=0A=
> > +		enable_irq(priv->irq);=0A=
> > +		priv->has_nmi =3D false;=0A=
> > +		dev_info(dev, "registered for IRQ %d\n", priv->irq);=0A=
> > +	} else {=0A=
> > +		enable_nmi(priv->irq);=0A=
> > +		priv->has_nmi =3D true;=0A=
> > +		dev_info(dev, "registered for NMI %d\n", priv->irq);=0A=
> =0A=
> When drivers are successful, they are quiet.  No need for the noise here.=
=0A=
=0A=
I will remove the message for a successful NMI/IRQ registration.=0A=
=0A=
Thank you.=0A=
Hitomi Hasegawa=
