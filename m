Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037CF48762B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbiAGLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:05:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59641 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiAGLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641553521; x=1673089521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qEGvffA41jHrHTeh/gtkCR5f3qc980XU5HCxKlIN0b0=;
  b=HX4w0uHnxXgb8qSyqNOnNbtLZ7xFaUMynBLBUpH9cav0gEQxg4U8g7Tb
   qdykfjiwJJyqxPK4BXjQEKm1TizGEKivB9lsa7A1EKn0psw6a6zpDZ/9G
   /UhUjd9s8eT/NuV4kYwkSLlI07C306wFtclP7Gm87wKAA1NKCV1fHd+wH
   4cjng+yjvdohReMFJZ0fSUCyIMNx64w4c9vt41hYZF66cViX0g8FQk8On
   PbcSuribb9yRve+nP4Wv5FzxYH1VJkNUjEJU3tJiY/1ooTyJinE0KMfLa
   XfAHEL/IjBDBY9cR7STx5lqwoua/+H31oj4HsdrU8VZyjDbCa7mzwpy97
   w==;
IronPort-SDR: zU3oBGrv632pISOElqfAH/efuXoTSg5Jbcg4sTWKCW9cqDhZa4lJo0+JwWns2MBPdkq01i41SK
 HrQANnsSjq56njqG8NuCnEOaq0+2n9RswdBXOz8zFLUVGgPNRAzlMsKR3nWPftu7BUBR8g6Vkb
 xljbZRLEaOLiZAd3UqR2209YGoUtvvIQxrlFh22WDyAdmZ67WsApcsc/IeWqjhIxzbQUQ9ycXH
 srUY+YBHGKyttOd+3EmPc/NjwINPW5HdXZiB7c1LVIL8dWsevYO5HxSiOsVDDGXlrgqPHOLuV2
 6aKKT5eUyYuDHhCv0db++r3a
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="157854468"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2022 04:05:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 04:05:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 7 Jan 2022 04:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI3Qpt6sJMoipIXxD3N4tIjAaKwKWrKvll+utgV7/K1qtyTx332lMj5mBnUumGUtq5uCXKt5TZMD9RWBQJN33dL59LYasUaSdliimcB0A9jSuWjUTdAxfV4onoK5Ih6lPQn+QWYgyIPgEij/4lIUq2OkCPT36Rr4duAKrJfybfGq0Q9X32aNZjK20QgOotnSHJfrOFLrO398LJkHF6yYZiQ9JPTVtYd66OS24XEj9YsaIqVWfeRb2mvn38baq7BU/wOAE1P9GjAcea8aq6NWQaxmYBeID8dDUaFnMRHWo0kn5WBsUt/0gQoR/kx1wBqFuA3LPhrLplLoYHz9rmhpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEGvffA41jHrHTeh/gtkCR5f3qc980XU5HCxKlIN0b0=;
 b=Z629Ju1Cw+ZcPyTt4o7uChYhdZ9wLuXryJ3+2hTlTzT2099V86D73F+jzFaR17JaVssOvVKXo2zl3fyVQudEvJ8fTrQcv44TKaQhWl4H+Xyb8wII1Qy0EvZMDCjA3y1nQHGB7M7RigYoBDFnfY7mW8bOAJeILjnas73Qx2pzx5aTNLb0gSi9Tm5iiSuQzv/d0egWuyBq2J/8Tgd9muD4UclKWmKMctsA1sTTlHHbaHiqcKpbqt1nYZo8oQCcixjwiTFkWcHQVKnzNJUhE41JeCmfcvanirHCYW9kS1xFMeQH3IWkI9mm8DfVLiSyqYomPV0N0l2ctKNecnyhQPo3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEGvffA41jHrHTeh/gtkCR5f3qc980XU5HCxKlIN0b0=;
 b=NIOMRYBctgTRPk0bRyKqKy7pH8pwcAZtgyfr0F8D1DlTiM+RiPWSWRpSwzkUB3bMVChSVdy0dCXB54b3XNPfu8bgWWk7qTQtkQO3nseoB9s6DZafpkPEgHWlq5sj3YLeKJbgNp3Y0EcQ0+ngJd352RD1OX5MgjT+BHKTH5lon3E=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 11:05:17 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 11:05:17 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <john.garry@huawei.com>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <Viswas.G@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishakhavc@google.com>, <ipylypiv@google.com>,
        <Ruksar.devadi@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
Subject: RE: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Thread-Topic: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Thread-Index: AQHYAZlqeHDSesDCREuHsBTTpgV6WaxTz00AgAB8JwCAAah/EIAALjAAgAFFlHA=
Date:   Fri, 7 Jan 2022 11:05:17 +0000
Message-ID: <PH0PR11MB511277B25F17276D24A1FE4FEC4D9@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
 <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
 <2746563e-28ce-b328-3494-f91ace1599f1@huawei.com>
 <PH0PR11MB5112F9E9BB9F029DB9A67739EC4C9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <c19c2b0b-d502-b393-db8a-cb5c57c00feb@huawei.com>
In-Reply-To: <c19c2b0b-d502-b393-db8a-cb5c57c00feb@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e3dd9b7-67f5-4307-b48c-08d9d1cd96be
x-ms-traffictypediagnostic: PH0PR11MB5925:EE_
x-microsoft-antispam-prvs: <PH0PR11MB592592B660BE5BFB214AF650EC4D9@PH0PR11MB5925.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwRJlpraKmkb4BsgHbyj1yhA3ZREJj1cK/8p8otWR8503hRnDM3O78Su4yBE2EmV9rvYSsAf6xwB0a92D7P7KbrnpQJl2umvZQRV8INyzCgWKNSmhxP4lXeSJtTNOHPjMOedZyzuwilXLqw3Fvqn0K/ySsuI3XZsQSRNdH39+E6ldDxIAncfKx4e7us4M+234FSMAl4i15SnPlEQhNoBuN9cwybx033P4bZfs/W5r+1y3n6eH2FIXGOX2KivljauhG28GkOyWVNBMpyIDLAKu8Y9t7ItxFr4x9EueNZtDfyD10qRe7F9yxSfB8q8rEOvmzjGeoQm9T6Tt0MstlhJyAJkGuRSWHpV41yqBtnzFCWQ3a9szd8uENcG1j2xX8DYwUWw1Y14VjB3zroZe7lzaad5QaTnpedJmMmNe81OtX1B574oWvYNLiVDf6zsDufDDmi5rf+o0Rf5SNVNodXPatih8WdXsbwW8pHWP7AQdvrmWk5mATe964dWCD/eq/CL0T5OIAmoTTDPCtS7xitHcGE9n4T8AcQGAH+el5zC5aZSkCgPX6gqV0cCvx6CkZClG3mgG0BUxBgUFthfUzTy915wLHmlPHpxWvbLnPAA7M8nMNYub9BnEEfgurnSrUlh3wj+5FHaigml5E0jAz1IjHOkpNrrDKbWJngoGxi9NWXgOTXx4nmgvCKGL4738d1aUV5cf0XUpvGcUsMF0jZpzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(76116006)(9686003)(66446008)(66476007)(53546011)(186003)(33656002)(110136005)(55016003)(122000001)(26005)(52536014)(5660300002)(8676002)(8936002)(64756008)(86362001)(508600001)(107886003)(2906002)(54906003)(316002)(4326008)(6506007)(71200400001)(6636002)(83380400001)(38070700005)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1RPNThxK0pMQ3I4bVh1N2JvRFRYTWU4YWI2cTgrcjA3bUlEOXdnZ2JXbEM2?=
 =?utf-8?B?cTRja1M1dWNHcXFNNGFDWmpPRjBZUmpMb0FyTFBxRDUxZm1vWUFDaWFUUlNK?=
 =?utf-8?B?RUIrQllqOVl5aFhkbFZlSEppUU5mSDVwRENNZi9nTmpiRWlVN2MrdmZ2Skcx?=
 =?utf-8?B?c2VwNG5YQ3VoVFh6U3UyVHFwUCtCTnpLaWN5VSt4ODRZc0NaV0RNNEpvZndN?=
 =?utf-8?B?KzBZQkdWVDRJODVaLzZ5SE0rTXdHYnpsUlh5SlJWdVlTekJhREZ5TDBRd2Rq?=
 =?utf-8?B?dnRtKytEOFRJMWpPNlAvNWRVU01FMWJLMzBNMUhhQ1VXNkpCb0dZZGNUWHBC?=
 =?utf-8?B?SllOeUdBVVhNd0dZaWlLeWVhbnNGdzdTcktMLzN0N094SGNQaWlWYWRIdFla?=
 =?utf-8?B?ZTBxVjFlYXp2T0VXTzJyczlaVlFQeHNxeGZCMjlNSnRSYStLRGhkL2ZwdFVa?=
 =?utf-8?B?OHBVcXp3bVBodGVvWW9rWHZqaWV6Q1Z0aW9icmhpUzMweThUUUovWWtrNm1m?=
 =?utf-8?B?VDZxalRQbURJS2ppM0MrbmQ2ZHpwNGp3djhZQ2o4MGRENjQ3K09HMlNXcUxw?=
 =?utf-8?B?Tk5vLzhKbUNOQk5XaUhKVEl3VS9MbVFsSEowR0YzTWdGU3FweFBJQjJpVmhO?=
 =?utf-8?B?K01VSldCNit4V0dzVFZwWmtFeXpraFJWT0F3RUxaR3ord004aElLM2RBaHRE?=
 =?utf-8?B?UHRBSkpTaVRqamhUMzZQNGx5NlNpSEE4cUxvNGdJZjV0WXRpQlZiampwMEp5?=
 =?utf-8?B?eVFMbS9iQ0MrWTByZy9CVkJXQ0VQdmhacVFIRUcwOVZreHRrbmMzTURlUlBP?=
 =?utf-8?B?RUphbkxvWXh1VVpmSmdrRkVWVVRCeS9UUWR6UkVVSnh1RE55Zm5ialJNRlpk?=
 =?utf-8?B?N1ZXeEcyZ3I1SzJmaXdLWXV0dnVZTmZUbklUQVhpU2RLVk1qWjc1QXFaQkNU?=
 =?utf-8?B?eXFxS0xpeUJ2QlhKTjByZ0ttalM2dXlMNWV1OHhrYW5TMkgwL2xLeXFPdjhV?=
 =?utf-8?B?ZzNxVTU4bjIvWnYzY2ZDcisvQjNHM1JsQVdnNm9sUXF5aWRvQ0tMc3BVUk1q?=
 =?utf-8?B?NWJNbVRHVUs2emNoT0NXME1mMzRWNHNFamloRU9nMStWVTNsZCsrVVBFVUJa?=
 =?utf-8?B?NjlXV0s5bHBxWC9ocXFobzJQczAvWHNSMTFHMmZMNlBSZElRM1ZMRngzT0RQ?=
 =?utf-8?B?bmR1dHZQWmN5ekliK1hSZkM5cVlJOWJRMm4rYjFmYmRFUXZEeGl0TmFRWEFs?=
 =?utf-8?B?enRXT0xacityMVZhOXZaSGRkYzVsdUY3S2E5L29Db2hZanpPWkJaSGlTSUJq?=
 =?utf-8?B?eVRvWmZ1WE03VkMxeVFQd0NPVGkvR3IvU0J1U0V3TUtDZVZTbmNsNThaOVVQ?=
 =?utf-8?B?RG8xNWtnZUZ3OW1lQjRMZWRlVlpVOTZCK2hFYzJHcm5kWEw2MmRCVnZYV2xs?=
 =?utf-8?B?azVVZWZxYzF5dkdrRzlBTDB1dE1QRnJ5NmhUYXR2RkVWTzRUc21KWmRQblls?=
 =?utf-8?B?eEhLTXRzejcwOTV2cGMxYVZYMUw4QWlncStneDRXSGpHdTVURkkvbHVSRlhq?=
 =?utf-8?B?bExhR2lTa1h1ejJzZnV1NnNwWHRiTUpLdHpUbVlYSDBXYmdOSHNSKzhJdGRD?=
 =?utf-8?B?dVBiaG5oQVlKcW1UbWF3bEpidEp6TFdoQThzWlA0UU4yTEh0SkM0SWNaQzhk?=
 =?utf-8?B?WHVRUGg0djNTdGhmUS9kNmJpcW1ldnFmOWpVMXdxSzMrc3gxYmNrTEU5b1Z6?=
 =?utf-8?B?emZZaEJ6a0JxelFzZWRSSEcwbXhEQzVSWmd4aFhXb1FUckxSd1JNQkkzNmJV?=
 =?utf-8?B?Ylc1QnZkZlhUMFR6ODJQTm9sTGRrU21iMndNak1xSnloRk9MMjdYUE9wTjZS?=
 =?utf-8?B?TllpQ0V2T1NGZjc2dE0vSVo3ckpOeHZPZER6eHVIYksycFlQQmpVYW5XQ3Mv?=
 =?utf-8?B?TVk3RlZCMERsN1dLbVFxaksrN2owT21iazdnUHV3NHhSUnFBcnlDaGRlZmVm?=
 =?utf-8?B?bHhZdHRScHpaVjRaaDlialhpVDZSd2RLNnlHMCsrUVR1aXZqRlBiZ0dKMytJ?=
 =?utf-8?B?YnMzNW1FMUYrVDE3OTE4bmwvV3hUTmhWcHliaCtHUU1UNm1oKzlWUk5ITzU2?=
 =?utf-8?B?RWRVSHE0TFlock1kZ05JZnJkeXFtTzlTNys1MnJOejNKc3pZRXFtV3VwL3Yv?=
 =?utf-8?B?blBpY2tuVlBoTnViM1VkbElBelB4dW12dTIwZ1hxSHNhNFl2Vit1Q1o2bHlo?=
 =?utf-8?B?eFVNUjI3ejNtL1JQUWFSaElMdGF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3dd9b7-67f5-4307-b48c-08d9d1cd96be
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 11:05:17.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muh0ORP3XybnyY/spk+pGemif8Z8UnoDpB9rBdnHluU0P/9fvqhMdS3wt2dSPk5QBu8oFSQdWaRg1F1ECsfKcAkN2ZVBjZI76FDnLT4sGfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obiwNCg0KPiBPbiAwNi8wMS8yMDIyIDEzOjAzLCBBamlzaC5Lb3NoeUBtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPiA+PiAgIG9ubHkgYSBzcGVjaWZpYyB2ZWN0b3IgYW5kLCBhbHNvLCB3aHkg
d2UgY2hlY2sgYXQgYWxsIGluIGFuDQo+ID4+IGludGVycnVwdCBoYW5kbGVyLg0KPiA+IEhlcmUg
aXMgbXkgaW5pdGlhbCB1bmRlcnN0YW5kaW5nIHNvIGZhciBiYXNlZCBvbiB0aGUgY29kZSBhbmQg
ZGF0YQ0KPiA+IHNoZWV0DQo+ID4NCj4gPiAxLiBDb250cm9sbGVyIGhhcyB0aGUgY2FwYWJpbGl0
eSB0byBjb21tdW5pY2F0ZSB0byB0aGUgaG9zdCBhYm91dA0KPiA+IGZhdGFsIGVycm9yIGNvbmRp
dGlvbiB2aWEgY29uZmlndXJlZCBpbnRlcnJ1cHQgdmVjdG9yIE1TSS9NU0ktWC4NCj4gPiAyLiBU
aGlzIGNhcGFiaWxpdHkgaXMgYWNoaWV2ZWQgYnkgc2V0dGluZyB0d28gZmllbGRzDQo+ID4gICBh
LiBFbmFibGUgQ29udHJvbGxlciBGYXRhbCBlcnJvciBub3RpZmljYXRpb24NCj4gPiAgICAgIERv
d3JkIDB4MUMsIEJpdFswXS4NCj4gPiAgICAgIDEgLSBFbmFibGU7IDAgLSBEaXNhYmxlDQo+ID4g
ICAgICBDb2RlOiBwbTgwMDFfaGEtPm1haW5fY2ZnX3RibC5wbTgweHhfdGJsLg0KPiA+ICAgICAg
ZmF0YWxfZXJyX2ludGVycnVwdCA9IDB4MDE7DQo+ID4gICBiLiBGYXRhbCBFcnJvciBJbnRlcnJ1
cHQgVmVjdG9yIER3b3JkIDB4MUMsIGJpdFsxNTo4XQ0KPiA+ICAgICAgVGhpcyBwYXJhbWV0ZXIg
Y29uZmlndXJlcyB3aGljaCBpbnRlcnJ1cHQgdmVjdG9yDQo+ID4gICAgICBpcyB1c2VkIHRvIG5v
dGlmeSB0aGUgaG9zdCBvZiB0aGUgZmF0YWwgZXJyb3IuDQo+ID4gICAgICBDb2RlOiAvKiBVcGRh
dGUgRmF0YWwgZXJyb3IgaW50ZXJydXB0IHZlY3RvciAqLw0KPiA+ICAgICAgcG04MDAxX2hhLT5t
YWluX2NmZ190YmwucG04MHh4X3RibC4NCj4gPiAgICAgIGZhdGFsX2Vycl9pbnRlcnJ1cHQgfD0N
Cj4gPiAgICAgICgocG04MDAxX2hhLT5tYXhfcV9udW0gLSAxKSA8PCA4KTsNCj4gPg0KPiA+IFBy
b2JhYmx5IHRoaXMgd2lsbCBiZSB0aGUgcmVhc29uIHdoeSB3ZSBjaGVjayB0aGUgdmVjdG9yIGlu
DQo+ID4gcHJvY2Vzc19vcSgpIGZvciBwcm9jZXNzaW5nIGNvbnRyb2xsZXIgZmF0YWwgZXJyb3IN
Cj4gPg0KPiA+IGlmICh2ZWMgPT0gKHBtODAwMV9oYS0+bWF4X3FfbnVtIC0gMSkpIHsNCj4gPg0K
PiA+IFBsZWFzZSBkbyBsZXQgbWUga25vdyBpZiBpdCBoZWxwZWQgaW4gY2xhcmlmaWNhdGlvbi4N
Cj4gPg0KPiANCj4gU291bmRzIHJlYXNvbmFibGUuIEFuZCB3ZSBvbmx5IGRpc2NvdmVyIHRoZSBp
c3N1ZSBmb3IgODAwOC84MDA5IG5vdyBhcyB3ZQ0KPiBoYXZlIHRoYXQgKHBtODAwMV9oYS0+bWF4
X3FfbnVtIC0gMSkgdmVjdG9yIGJlaW5nIHVzZWQgZm9yIHN0YW5kYXJkIElPLg0KPiANCj4gU28g
bGV0IG1lIGtub3cgb2YgYW55IG90aGVyIGlzc3VlLCBvdGhlcndpc2UgSSdsbCBzZW5kIGEgdjIg
d2l0aCB0aGUgY29kaW5nDQo+IHN0eWxlIGZpeHVwLg0KDQpBZnRlciBnb2luZyB0aHJvdWdoIGNo
ZWNrX2Z3X3JlYWR5KCksIHRoZSBjaGFuZ2UgaGVyZSBsb29rcyBmaW5lLg0KDQo+IA0KPiBUaGFu
a3MsDQo+IEpvaG4NCg==
