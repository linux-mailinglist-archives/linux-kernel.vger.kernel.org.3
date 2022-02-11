Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08F4B20C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiBKIzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:55:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiBKIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:55:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8B8E80;
        Fri, 11 Feb 2022 00:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644569744; x=1676105744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BUKF08UW2t0SFt1rfjN5OWWRafTWLIFiwFoS44g0hxY=;
  b=P1/L7vPqMg5iCOqeNMlvTYQAqUVV0/hGQVznfcFoyL3Lc4t06+uDqM2t
   wNs0l5G5GOt5I1fDZcCxoX/iOGFD7X+YaUPb5LR74toRywwfs1Qq0nj83
   dEanw7uamAVaaDdAZdcbXdx52WXiuofa8YxBVFXIMGEXJGXIiRm0uko2o
   t93MRY9aV0IKbLP0zAEAkO1lIjwJ9ohe2/mBZlhgudbY+pelXkt/5KkrU
   Ix9f6xzT4XYBwd9sqcmFkGNBElGBxuydPKruu+W3qMhyzV9Y7CeW4pLfe
   8+oq786IEsAheDtq9PwbdEt8kL/d191didX1XElV1oPsQJRSk2AOyqwpS
   A==;
IronPort-SDR: Sw7tLHaKsPhUNvSva5zTgGpyYaY6a3HozNsxAMCZbNL+emK7T2u0CT4xaVQNwULC6dP28fH2W+
 ineHSRQM/LkZ7CLA/J5QUkTujaxFuo9pdcjNFTPUIQXvCxEX/6icXi2Hl+JFMCb8/icOrYLSfy
 ZdnmV8wYHTsVjX3xcDaxDwz/yhPjmQjrhdML+KxYnEmjGn815L5JJ3anwT1GYXno5dvj+zR0Yo
 yJQn4dw/v0xaFVoK3c5WrB1oDIl/5vIhRtRaa/RwHwiqXsA0K2yHMt2DgG/TFhUe6Z57g5qVVS
 cmL0PMfOhd1o7f1v3U3zQjYT
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="161903771"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 01:55:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 01:55:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 11 Feb 2022 01:55:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqx/mlAmOyE3crm7FSQ2AEQtTGUnEVxKYNErG5eS58+n2lhgmKhdXZDbDLjF8m3Pk0v4zmf5dcw+jP83E9LFZfdxd9gWExPhB1U6M/aXbvD9wVwSstASIDW0shm+n2f4WLVvUfXKwXr8Msdkk6nX00dyo2hxp7Aiqrd/s53Rw1OwwrQHr7qls4AdUsSOwD9UhSmqcSt04+dkQT3vHUns38qnx6oRC+z1zTXtjMWxubS7KXeRLnDcdnB6AlpyxesMqWzLxfpdkR8dFc9dAcsolpMn8+HA0V89LkRkfB6zEDCyArZqD/vYTxVjCvq2/F6Nj/oe4WC/oiBghgXqlvMqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUKF08UW2t0SFt1rfjN5OWWRafTWLIFiwFoS44g0hxY=;
 b=mseiwhzQlw0yG5jPAdL9VnF89NZB8xhW588loYul51dxg9bcdOtqCILTQg6BpbjoWhgEN66jmoiPgo9AdgxRVp5QJ1G5j0a6/6SXxOn6CQOKKMndTg4NQSZaJDrGSp9x8gKlPtQmW7dDuPVM+tNirEPKuMbvBFJdLELrdUs0XAFo0z+Y+gyVhomz9e8gJ334s8PrSMlUXi1hN0i5ztUxIwqcW69pVDv9gMkG2Mbm+FraaVkNzaeUL8nxTPXEdpRprox5IOw/7GnwMVhLPiaeSmS3gIUvaZjHjwnXJGX6tnXT2fa4ZKMO1KdEowSl6xJyMktJctEz9nR6/q1q0axsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUKF08UW2t0SFt1rfjN5OWWRafTWLIFiwFoS44g0hxY=;
 b=GuNHhVm+VAd2XiDtgBHKZWF25y4VYTH3tb/KfVKsz8QlDRpeZ7oX6iVNf2dtGNnzo97lRi517RfWQ4DOQIpFkxncBYimMJzm9arSkZYnqMVs3dvG1mp6nVuAnbHGb2XvsZDSwbU2IJTLlQN28KmlEH90xKh0l1jSI5Nv8BfNzqY=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 08:55:33 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%5]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 08:55:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <herbert@gondor.apana.org.au>,
        <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PACTH v3 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Topic: [PACTH v3 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Index: AQHYHyUg1kMHhfwweUa3eaqVUXYKRA==
Date:   Fri, 11 Feb 2022 08:55:33 +0000
Message-ID: <edf01cb9-c887-83db-fe2c-4e4198ec93f9@microchip.com>
References: <20220211082114.452911-1-tudor.ambarus@microchip.com>
 <20220211082114.452911-2-tudor.ambarus@microchip.com>
In-Reply-To: <20220211082114.452911-2-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19c2a3dd-7307-417a-094a-08d9ed3c4360
x-ms-traffictypediagnostic: DM6PR11MB4611:EE_
x-microsoft-antispam-prvs: <DM6PR11MB46110F1C6DB9D8D85403F1C187309@DM6PR11MB4611.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOUlQNQ/19ZSvU0TWJzY9IgIlMwLqHSz9chdr5vWqG5yR0hnxlE/vlbA7YluIGPTTypoUXBgc4CmOqP/2qQEklyh+aRXJg2GjYmrunTVuyUp3fSWEuAME0v7hIuGoht5GUwAo0OU1tZ5sv/ImXiDuSqCbrj1rdazbsekZgQrIRn0N4zorMlUfU5esJx94xWqYBdZ7zvcGGUA4yoAZYxoimojNjy9YKpDFn2w5TtI2riU5GzSm1s2e2MWdOeYMP2gqLpjaz3lagbIzuwWZS9b1qd8MfpSlHaOS2XvRqFi2ZBD+bouutCK/b/BOxiDz++fOEdhHebdEoL/fWfJ0rVjSHOHDoNJXd5xvRydF7XkmUGUiYYmxwWOz9t8FpT15f1mw1bioHeaLGykZHd5Anx9Pfd1Z7enVoda4aceioTGpO3tCA6TQugqEt4qlDq86fDlT1OhLxPkNTK4LZyzLOaHxwvJzw9XZ3wosd3pummD4CETDtHgrgQc/qPioRMLN4GxDxs/qumMPufNrdr9DKWZBa+hjiGQnW0im0Kdpk/mVamyRTMdTsWXUEETbKrt2dxqY8ZT5nwo7gQaCMBNgMRZ5+oobVMXoy3l2fzpgqHGm219uQW09rFeeNBSYUMOnB57iA/AyBciUqLPiLyqp4AQ8dhJx7P/lSw9xr/B+c3l9FsntEu9RfnZs3Ljt4zTBJPBS4eC5jtRD4hYlQ1fVtLkqT6hVOst76Vt0ALYTRI2tP4FHlbbNlQ131y1DxHJvJi2437+02rrfG93XhtScDrxgDERxDYslX+m3M2n682qoX8v89A0U4NK0lA9NFc6lQtMASsRHCXXISFOMRUFu9oa3/edd9yEzmm3fLTgW3JYZwLTm4CDBdFjcPwvDRvC5tyAkAEBQ+0DvQvRRXW8dfH1Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31696002)(38100700002)(38070700005)(122000001)(71200400001)(8936002)(5660300002)(508600001)(66946007)(91956017)(2616005)(53546011)(110136005)(54906003)(316002)(966005)(4326008)(36756003)(66446008)(66476007)(66556008)(8676002)(6512007)(76116006)(64756008)(6486002)(26005)(83380400001)(31686004)(6506007)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllGZlF6bnNJcFNtZk1PQXZmZlJYNDl5aTk0YklZSjY0SFdiNXFRbzdkQUpV?=
 =?utf-8?B?dmZod0IxSkp0V0JjRU5xR25BZ21Bb2JIdHNFeno2eXJLTU9DaDRsOU11MDk4?=
 =?utf-8?B?TWhDek13VTRmMzZpVWlVY2Jua2VHMXlyeW1jT051bVZyOEgyeTVjaXJ6aEFw?=
 =?utf-8?B?cEVaaGttd0o1V0cvZzRoQTZ3Tmh3ejZWb2NLZnZpcVlrRkVCbXd4QTZiT2hn?=
 =?utf-8?B?bi9kaFpOcXBpYVZGaGo4VWlKSmN4aXNmTlNLaHJsc0YvMTZ5TmRxMzdkYnA5?=
 =?utf-8?B?U2tpenkyVXA1dnZaZmpUN292SS9NWm5WaHhITElKRkR3c2x4UXhDVS92ZkFi?=
 =?utf-8?B?ZjJRanZZU3hwZDA1d2VJS1BZTHNjTkN3Q1RSYVNrbW1OS3BKM3ZWMW96dzhT?=
 =?utf-8?B?aGlhZ2M1K2JYOEVaWEtmSDFTTWI4cWMxUCtHZ1hVb1V1QVBKUlFvN2puaDU0?=
 =?utf-8?B?QVRKbFMreUtQZFJQcWdIa25sNTFXY1BXZFc1REJ6Q3dPREpwc3JkVTZ2a3Ru?=
 =?utf-8?B?YktYNk9pQmdRQzRRNXY5dmFFV3BQNzYzcStmN0E3anBuUFMrMXpjd0dxWjV5?=
 =?utf-8?B?UjQ1WVZuVnhFQW1WWmFYN2Vmc3F6Q01iZm1xVWdseHZWQmVpdzB6ZlNNY0Rq?=
 =?utf-8?B?RTkvWVZPU3gwTUdJY0xHRG1ZaVRxZzM2d2tXU0JWcHlDdTIrc0x1NTlmWU05?=
 =?utf-8?B?TS9wUDN0N29SR2xib2c0UmJQVFNBbDdQTDVDb013SFd3dTAzbkN0RVZlY1Na?=
 =?utf-8?B?N21MRVZZNU9oM2kvMVV4QjlZV2FHZkVtcDhYbktWYThYckgrSEVNQnFEVlVI?=
 =?utf-8?B?bldYeElGZmRIdUJYaE5BOTdhZ29NNEx3bWg3RVltNCtJdFdvRDhJbTR4Z3h4?=
 =?utf-8?B?bU4rTUxBOE5jYUNPTlA4WTRJaWx6K0tGMytoU3hiZXM5UzBuMzF2QmRKd1Vr?=
 =?utf-8?B?WnptMkY4SENzYWkvQm1TZ21nZk5zdnYzbDBFcEJCcFFDUWZaVmhUc2FpRkdy?=
 =?utf-8?B?RW5sSkhaOTZocWxqc2ZFaGJyVWFFRkI3UjZ5dVp0SE44eGVVMEhzekU2amg3?=
 =?utf-8?B?Y3hLS2w1SzBURUxvaHE4aUlpSTM2UGNYcE9GWHZKKzdtUTVXQ2lMU1c1aEgz?=
 =?utf-8?B?QldlaVVzdG5MOXUrMndQalB6M0VRbWc1Z3ZYZlVraGp3YjM5MHZYSlJvbU1w?=
 =?utf-8?B?NWxPUC82MTNveTFIVGxtN0FKY1RGMkZ2N3VPSGo1aGxrUHVMUGpqU2ZwWFdk?=
 =?utf-8?B?Qk5HT2dkMjNKL1pZTTRzb1EzNkExVzBndjFCUzg3U1IwRkpZdkh2U05VRHc2?=
 =?utf-8?B?c0hma0RGTmM4eEl3cW8zSkZkeFcvTkNVcWNrLys4SUdOSE15Smg2TFZLd010?=
 =?utf-8?B?WmtUZ2xrR0VEWUFJRXVNWmhPU0c0TmdKR0NheWY2V1JmUlRydjh4UGFYOTky?=
 =?utf-8?B?YXAwQ0JsV1FjeWpEaDNpZm5QOFd4TjJBSFg1MWRHeEtyRjBJUm5IR05OK050?=
 =?utf-8?B?STlYNGl2UjRuaHN0d0l2MG52K29aK2kxL0R6TVhSQjlkRThQRUZXWkE4ZXFz?=
 =?utf-8?B?eXVMbFdqN05BTjRvTzB2bmVlaGtzZzQ0WjZZendEM2FBaXBUR2p0cWgxZnU0?=
 =?utf-8?B?bGFXWVV6MlRUK08xNE83VE94V3A0RVgvNTFnT2RnTWdQcmVPU1RwS0YydEpu?=
 =?utf-8?B?VDlmaEpjamlWbkp5bGhablZ0R0hqaHBvbmpGVVkvclIvLzZkaDZQRjgyWldY?=
 =?utf-8?B?Y1RSMWlmZkJyU0JheXY5TlZkNWVTYUltZ1RYZzNkS1VLUEtRalBrREVsNHF1?=
 =?utf-8?B?L05MaFcyYkpQUkxWeEc1LzRSUEp4MVYvQWZsQ1p4VjJUQXRrWG53aFMzOTZ5?=
 =?utf-8?B?UkFEZEx0WktSS3c1dlUyRWN2ZHkrZ3cwRkRNckMwVmV3UXM2Ynh0L0VXMzN3?=
 =?utf-8?B?UDZraWt3c3VXU1Bra294Y0NtUFRZalBCUEkxZ3I1OEZORXRteUF0L2VLODBO?=
 =?utf-8?B?bHFHTnlDM1FDdG5tTktOWkRNbkxqcUZ4d3lMZ1RsaS9FM3k3bGpOMG5qV1Ro?=
 =?utf-8?B?V1piVmF5QWxaQzlTWXdyNTJ2S1JHVmV2TnVUeUx4UGFzNTJsRFFzRFBncTl2?=
 =?utf-8?B?QVJ6cTkvWjZUbmF2cHUrL3gvbjJnOW9XL2VvVUFmSWIyWDU0L1NpWG5LekJR?=
 =?utf-8?B?c0draFhMWkhQOUhzWDI3SG5CQUl3ckh6NkdpTEpKQzJPKzJKM2oxeW92S1U0?=
 =?utf-8?B?R1drVzRNLzR4SERaS2pPVDkya213PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4901D8949554242922F2BC06F6B77C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c2a3dd-7307-417a-094a-08d9ed3c4360
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 08:55:33.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPg9RKIFZEzP0npZ86GcggXD6xFculEnyEM4YjocbmM7qVHFQ0hzWwKeDo+EDzPjXkLa2SWujMSCIs86QR0m8FGbhR3qrcK5Twi4VbUJKak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCk9uIDExLjAyLjIwMjIgMTA6MjEsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+
IENvbnZlcnQgQXRtZWwgQUVTIGRvY3VtZW50YXRpb24gdG8geWFtbCBmb3JtYXQuIFdpdGggdGhl
IGNvbnZlcnNpb24gdGhlDQo+IGNsb2NrIGFuZCBjbG9jay1uYW1lcyBwcm9wZXJ0aWVzIGFyZSBt
YWRlIG1hbmRhdG9yeS4gVGhlIGRyaXZlciByZXR1cm5zDQo+IC1FSU5WQUwgaWYgImFlc19jbGsi
IGlzIG5vdCBmb3VuZCwgcmVmbGVjdCB0aGF0IGluIHRoZSBiaW5kaW5ncyBhbmQgbWFrZQ0KPiB0
aGUgY2xvY2sgYW5kIGNsb2NrLW5hbWVzIHByb3BlcnRpZXMgbWFuZGF0b3J5LiBVcGRhdGUgdGhl
IGV4YW1wbGUgdG8NCj4gYmV0dGVyIGRlc2NyaWJlIGhvdyBvbmUgc2hvdWxkIGRlZmluZSB0aGUg
ZHQgbm9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFy
dXNAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAuLi4vY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2
LWFlcy55YW1sICAgICAgICAgfCA2NiArKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vYmluZGlu
Z3MvY3J5cHRvL2F0bWVsLWNyeXB0by50eHQgICAgICAgICAgfCAyMCAtLS0tLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0by9hdG1l
bCxhdDkxc2FtOWc0Ni1hZXMueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsYXQ5MXNhbTlnNDYtYWVzLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2
LWFlcy55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
ZmU1OWFkMzBiMTcxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NyeXB0by9hdG1lbCxhdDkxc2FtOWc0Ni1hZXMueWFtbA0KPiBAQCAt
MCwwICsxLDY2IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5
IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyMgQ29weXJpZ2h0IChDKSAyMDIyIE1pY3JvY2hpcCBUZWNo
bm9sb2d5LCBJbmMuIGFuZCBpdHMgc3Vic2lkaWFyaWVzDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0K
PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jcnlwdG8vYXRtZWwsYXQ5MXNh
bTlnNDYtYWVzLnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IEF0bWVsIEFkdmFuY2VkIEVuY3J5cHRp
b24gU3RhbmRhcmQgKEFFUykgSFcgY3J5cHRvZ3JhcGhpYyBhY2NlbGVyYXRvcg0KPiArDQo+ICtt
YWludGFpbmVyczoNCj4gKyAgLSBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgY29u
c3Q6IGF0bWVsLGF0OTFzYW05ZzQ2LWFlcw0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVt
czogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAr
ICBjbG9ja3M6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBjbG9jay1uYW1lczoNCj4g
KyAgICBjb25zdDogYWVzX2Nsaw0KPiArDQo+ICsgIGRtYXM6DQo+ICsgICAgaXRlbXM6DQo+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBUWCBETUEgQ2hhbm5lbA0KPiArICAgICAgLSBkZXNjcmlwdGlv
bjogUlggRE1BIENoYW5uZWwNCj4gKw0KPiArICBkbWEtbmFtZXM6DQo+ICsgICAgaXRlbXM6DQo+
ICsgICAgICAtIGNvbnN0OiB0eA0KPiArICAgICAgLSBjb25zdDogcngNCj4gKw0KPiArcmVxdWly
ZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGludGVycnVwdHMNCj4g
KyAgLSBjbG9ja3MNCj4gKyAgLSBjbG9jay1uYW1lcw0KPiArICAtIGRtYXMNCj4gKyAgLSBkbWEt
bmFtZXMNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1w
bGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNv
bnRyb2xsZXIvaXJxLmg+DQo+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1j
b250cm9sbGVyL2FybS1naWMuaD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2sv
YXQ5MS5oPg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9kbWEvYXQ5MS5oPg0KPiArDQo+
ICsgICAgYWVzOiBjcnlwdG9AZjgwMzgwMDAgew0KDQpBZGRyZXNzIGhlcmUgICAgICAgIF4NCg0K
PiArICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWc0Ni1hZXMiOw0KPiArICAgICAg
cmVnID0gPDB4ZTE4MTAwMDAgMHgxMDA+Ow0KDQphbmQgaGVyZSAgICAgICAgICAgIF4gIGRvbid0
IG1hdGNoLg0KDQo+ICsgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjcgSVJRX1RZUEVfTEVW
RUxfSElHSD47DQo+ICsgICAgICBjbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDI3
PjsNCj4gKyAgICAgIGNsb2NrLW5hbWVzID0gImFlc19jbGsiOw0KPiArICAgICAgZG1hcyA9IDwm
ZG1hMCBBVDkxX1hETUFDX0RUX1BFUklEKDEpPiwNCj4gKyAgICAgICAgICAgICA8JmRtYTAgQVQ5
MV9YRE1BQ19EVF9QRVJJRCgyKT47DQo+ICsgICAgICBkbWEtbmFtZXMgPSAidHgiLCAicngiOw0K
PiArICAgIH07DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY3J5cHRvL2F0bWVsLWNyeXB0by50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvY3J5cHRvL2F0bWVsLWNyeXB0by50eHQNCj4gaW5kZXggZjJhYWIzZGMyYjUyLi4xMzUz
ZWJkMGRjYWEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9jcnlwdG8vYXRtZWwtY3J5cHRvLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLWNyeXB0by50eHQNCj4gQEAgLTIsMjYgKzIsNiBAQA0K
PiAgDQo+ICBUaGVzZSBhcmUgdGhlIEhXIGNyeXB0b2dyYXBoaWMgYWNjZWxlcmF0b3JzIGZvdW5k
IG9uIHNvbWUgQXRtZWwgcHJvZHVjdHMuDQo+ICANCj4gLSogQWR2YW5jZWQgRW5jcnlwdGlvbiBT
dGFuZGFyZCAoQUVTKQ0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRp
YmxlIDogU2hvdWxkIGJlICJhdG1lbCxhdDkxc2FtOWc0Ni1hZXMiLg0KPiAtLSByZWc6IFNob3Vs
ZCBjb250YWluIEFFUyByZWdpc3RlcnMgbG9jYXRpb24gYW5kIGxlbmd0aC4NCj4gLS0gaW50ZXJy
dXB0czogU2hvdWxkIGNvbnRhaW4gdGhlIElSUSBsaW5lIGZvciB0aGUgQUVTLg0KPiAtLSBkbWFz
OiBMaXN0IG9mIHR3byBETUEgc3BlY2lmaWVycyBhcyBkZXNjcmliZWQgaW4NCj4gLSAgICAgICAg
YXRtZWwtZG1hLnR4dCBhbmQgZG1hLnR4dCBmaWxlcy4NCj4gLS0gZG1hLW5hbWVzOiBDb250YWlu
cyBvbmUgaWRlbnRpZmllciBzdHJpbmcgZm9yIGVhY2ggRE1BIHNwZWNpZmllcg0KPiAtICAgICAg
ICAgICAgIGluIHRoZSBkbWFzIHByb3BlcnR5Lg0KPiAtDQo+IC1FeGFtcGxlOg0KPiAtYWVzQGY4
MDM4MDAwIHsNCj4gLQljb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05ZzQ2LWFlcyI7DQo+IC0J
cmVnID0gPDB4ZjgwMzgwMDAgMHgxMDA+Ow0KPiAtCWludGVycnVwdHMgPSA8NDMgNCAwPjsNCj4g
LQlkbWFzID0gPCZkbWExIDIgMTg+LA0KPiAtCSAgICAgICA8JmRtYTEgMiAxOT47DQo+IC0JZG1h
LW5hbWVzID0gInR4IiwgInJ4IjsNCj4gLQ0KPiAgKiBUcmlwbGUgRGF0YSBFbmNyeXB0aW9uIFN0
YW5kYXJkIChUcmlwbGUgREVTKQ0KPiAgDQo+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KDQo=
