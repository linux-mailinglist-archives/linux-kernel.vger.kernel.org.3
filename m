Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE174B257E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347674AbiBKMTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:19:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiBKMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:19:29 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0DEB0;
        Fri, 11 Feb 2022 04:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644581966; x=1676117966;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=jL5Uq01kiosSNM97rM4IUqwPdNATuI3xWB8twXYYQiQ=;
  b=YXYzXG5Ug3UQ5rqRIfe8ivwY+k6uOTso1MrhbAvevDKyXacZz6rQyyX4
   oEMuJ7D9poJuP3dz90zJIe9fNJAPbtEhQhLdBIE87FkbWz5yZfZOwQp9a
   DHVQyUdnk4TLh+1UrEpWKajNyb6+RV73qevAOtTr3Gh8xK50RdMfYimyi
   QxYsRRpLU/YPDP2dtnR1WhWjtldy0rOTRPW3/0l7cpXJh3/60fW7ZnBr/
   it2osA0zkYc3LiXn9ei3+WYOWd0hGRyzkerLquThszgTiJsSEiM5WSBGL
   eqcc5AE3h9TTa12DAbb1DRgvazs6oxY+enuceLZpJy2ODlaDXPgsb0+NE
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,360,1635177600"; 
   d="scan'208";a="192690606"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 20:19:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5IcJ8Iqegn/+3Al+/tP1FJQgjYwFwyMR3C7XwF46tn5fWbqtfmLhXpA4JmZFboamax5Xs/dCIIqJjc8XBFCITOvnt3kF9t52Uwe9o8e5Alb7KwzhHA29v33SNME42OmFDtnUnFT6BftRX4QVcenfvLHLLnFmIqsxY4kaNOXTq0yVbI07B7aR1toXrJAARea2CceIIvhJFps1i5E205TohM7I44hgxHqgJnMpQU4S5L3s8TiERkF6W/kVrt02Q8wqBqGA5ElK60Ffsnl2Uw550UWKhQm0QXM7aeya2Fhv5CWDHgXmWpyqN/aXiH0BrUQxV401oqqr/hQlQF0B+7hTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL5Uq01kiosSNM97rM4IUqwPdNATuI3xWB8twXYYQiQ=;
 b=Qx6szm7whJxOduBbDAkGbCtCI5Ouecc6HuCfwgnNSaXOMfP7SUYXNRVHp9CFHO1Im+O0NaDX/SwL0gRDBiyNb0nQ6Hti3mENUlDJbY3hLu+ZOTMY18sHF72xDojtBq5JE6deDUYjxkMY8EFD4/hCgcldfep+YW9otSGIajZVEk6sRNj2HbSimZSq8sNBcnkhLuncPVLhzXXWnT366pGEVu+WBW6j69Uc5ig4smz0VgdqTfRf3z1JJIz/dBZVGAuR/+csU8N5A5wd/zLodiuajm5fTn4cQGP/7UcLzEyDwqZiaJ8SMYsoLEJEh7K6l1nNhXlULun4wFIhDWCRpGlAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL5Uq01kiosSNM97rM4IUqwPdNATuI3xWB8twXYYQiQ=;
 b=ev9UR2dBF+kaveNzg8os2sZxeVogE5rJ6lOLDKX30V9NjM3fCxkXsCeXDTPlxPgLYKGFEPmcsHcxbg/Ma7sVZVTShHFDjqrI1y8tXVLK8DiypLRnKHhKtK3QSuYW2Iag4jXi+sTVV8WkBfPXGd5TZxaE0mmYTRQKwTOqSe0p8wk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB0437.namprd04.prod.outlook.com (2603:10b6:404:96::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.16; Fri, 11 Feb 2022 12:19:24 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 12:19:24 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "sc.suh@samsung.com" <sc.suh@samsung.com>,
        "hy50.seo@samsung.com" <hy50.seo@samsung.com>,
        "sh425.lee@samsung.com" <sh425.lee@samsung.com>,
        "bhoon95.kim@samsung.com" <bhoon95.kim@samsung.com>,
        "vkumar.1997@samsung.com" <vkumar.1997@samsung.com>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Thread-Topic: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Thread-Index: AQHYGmPQ8Ff+rACVsk6i/i0BNavg3ayGLxRwgAd2vYCAAKg24A==
Date:   Fri, 11 Feb 2022 12:19:24 +0000
Message-ID: <DM6PR04MB6575CA688DFBCAF84F39F9D1FC309@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
        <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
        <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <007101d81eed$4d120a60$e7361f20$@samsung.com>
In-Reply-To: <007101d81eed$4d120a60$e7361f20$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 467fc05b-0d52-4844-504e-08d9ed58bdb1
x-ms-traffictypediagnostic: BN6PR04MB0437:EE_
x-microsoft-antispam-prvs: <BN6PR04MB043748C429C1DDAF26727BBDFC309@BN6PR04MB0437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExR2+JKjlgDUX6s/P0qlHQVxKS95JaVyPeb4KSUydi3iuTuPMtLW3WuqQoCeYstJacXVL99eFmGowgeHxjMAI9eEfFxztzm2rGM0JQvvacLye5Jdpq06I8hPCCe0dLZhupqvG/CKNglCweOlPm8ZSJCkk41dOLxcAH3UHj4lGttOxv+COfLivH79PIl6ahNJlDajqdF2+hq1m8DF/rt1n1v37lEZ/ezR+htOdAlALtS9aKwf4itjvwdi55lL9tu68sAtWUdBpurVvaCBo+tBRVzFs06cuvE7R3cp+YhE64kaBAEsoADxPSzSbNBtiDjD7x4ojs0UBr1zd0TH5UBEcuXkPpMEtqsiwIqeC3CYuPBI6iZibXlDb1yZpOQsCisYUYcRvBOih6bUv07yW/5B5DnAIgmno1eq9XDgNtPyIeCzSpB0M66LVDbU70iIODNu28EZ2eEYttJzTyMTJh7aNOAta8liGDlnX3ERI/L72+eidQNohgghuTuE1S8Ki5yh1ohjQVPuyv9f88pfinXuoDDlwPcXKEGDpnv2ThqffPWm1sBsxreNgwPWci/jNPPD4P4/2A98ST6pgYK4gaIx86lmxgXW0XtBSPc9SaHvFTkh1dFN47KpT6q+Jm6fWT7Ds5FSmECitrUXWQ+nrsDPuCwbT5QYF6XMo66ZYAl+HOb6rdsyMyNeIi4jpbu5zyZd8KKASFcJ8m/O1ryudIAcEbg9Q+87hT91Zl7ia4azlj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(4744005)(7696005)(6506007)(316002)(83380400001)(5660300002)(86362001)(33656002)(38100700002)(7416002)(55016003)(110136005)(122000001)(66446008)(71200400001)(38070700005)(52536014)(2906002)(8936002)(8676002)(186003)(82960400001)(508600001)(66946007)(66476007)(64756008)(921005)(66556008)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm4zY2tTTEdEVVBtYXowbVdzL0duYnBvVHJ2WWVlWHdpbm5IVUYva21UN0Ju?=
 =?utf-8?B?aW5LeGt2aVZURHZ1Wk5Lam5OOHVTakoxTElnRjZYMzFNT0FWYlVML2ZiRXF0?=
 =?utf-8?B?dmk3L1ZjTXZUcm1rVjduUXU3a2J5TFlkQlZqME52bHhSVUN4R21CVkFCSE1X?=
 =?utf-8?B?bXJhdlRvM09yWkRZak81SDllK0s5RGRkbkRxeXdPWXY3NHRkUk5KdEhIUmxl?=
 =?utf-8?B?Zld3NjBLZ25qenplamNRQzhneEt4THFRREtxay9sTXAyWmF5ZjVXK0E5cHFI?=
 =?utf-8?B?VDdQVFhsVmdZaE9EeVRSZkZEeVVHVm9leW1pRVp3VkFvSU16YzBuMHQzMGEz?=
 =?utf-8?B?d2xrdFBNa3hseThkWHBUNzl4QkNkWXIzbmF2S1RVb2FxSVdXSUVFdmxueDhD?=
 =?utf-8?B?c3ZVb0Y3QTJlaExQbnFBS1ZDUWM1bFN4MFo3clk1bFBkMnJJcTlrZlUvRUVZ?=
 =?utf-8?B?RUhuSE5vOXZKbnBMaW9EcEFHS2tYa1ZWbUxLS3NpL0pmSmE2MGVUbXBDWUYz?=
 =?utf-8?B?dkRDS0tpOVkzNm9oelAwWnM0UnVqRmNEZTlzMkNwZFYvWGNLM1pIaTVCamg2?=
 =?utf-8?B?V1Ftc3UvL2dJSS96MnZ3RUtqZDFKbTZYbmdvM085NFZvUlYzTENqUjRicnF5?=
 =?utf-8?B?K0VnU09UZ21RdWJSS3QyTWtPMXlPeUQyODBObkF5T29ycmhWZ3ZUdS9lenIv?=
 =?utf-8?B?Yk92QWYrVWFJNUdlU1FoWVAwbDA5VHNoM29RWmNVY01aQ2lDbjVjRmwxcERQ?=
 =?utf-8?B?azg4dWtMK2gvSStrc2RWU3IzdC9KN1p0SGNYcWFtL0NaRURWd1B2SnFmVGxD?=
 =?utf-8?B?akhEZ3BzcUJPVURFNjk2NE9yeWJOQWh0MGZrSVRzUVFhR2tOUlgweDVhei9s?=
 =?utf-8?B?SmVaQnlNQXJkVENvWFkxRXpYZktubk1ENmg5emRVMjltLy8wNStJQndYZjNR?=
 =?utf-8?B?YVI4bHRFblJURC9wYklza3FhN1cwUTdYUmlnMUFDTlU2Q0daaUxPRkFERjJI?=
 =?utf-8?B?TkxSUmZadm5sVFV1MG80elpCc253QkZkUTVOcXRCTXI4VnVvR1NKNU4vV0p4?=
 =?utf-8?B?ZG1UZXhuR3NrdjIvYzdzR1doS20wWmx1WWtjNHBsUk1TLzhPaTNQNEhzQVBN?=
 =?utf-8?B?ZWRkSHJ2eFE5V1VjUXlyRFdMcVFOZTM5UmluVmFwcFhTUUtkdXBiNWF4MTF1?=
 =?utf-8?B?T04xcnNmMGlBZGtXSnJjVFJ6M1UxOCtYdVhDV1VGZnU3SWdDcHNCS1d0YXJZ?=
 =?utf-8?B?K1VlRVJHNnBEQzhqZ1J3czVOWG1lcUF1QzRHWG1HQnZxNlJ3QW1va0F4ZkJU?=
 =?utf-8?B?akhVUkRXZzdXZWF4OVlsc2ZvQmZBS3ZJb1A4V0hramtkWnpXMko0WjlDcVow?=
 =?utf-8?B?QzNnYTJncFN6am9DcTRua2wzSHMzeG5OUzhXN2NDckkzbVZTd2Y4VVVXaWZ5?=
 =?utf-8?B?TWVyeXFkZDRwajk2ZGtoMVVBcVBmcVhJc210dTRyMmZ0amQ2cDUxWDBGUzZJ?=
 =?utf-8?B?SDcvT3Nkd0VrZm9CSldNN3RIOXFGZEp5MTdnK20vVkFScUR5Uzd5aTBsUWtC?=
 =?utf-8?B?MVpkYXJMeFBFRUExZEw3aUN1R05SSmZXK3Nsdi9hU1JQZ1FIdHZSUFZpNVp0?=
 =?utf-8?B?Tk9jU2cvUEU0bEtVSGpKVGpVbWlFSk16Qk5tWnRtcUUwNkRzc2ZGODNxWTRB?=
 =?utf-8?B?dkRFTGI3ZE1nRmZDM3Y2VjV5WFg5L3lLTEN0bWdsdVdGNU1yeVJHNnZhbXJn?=
 =?utf-8?B?T2tmdmVGcmFMTlBlWFJDNjJEQmFWVWMremkzNTViSnVhdlZIYThneUoyMHY0?=
 =?utf-8?B?dHYvSjh1V3dsRXlBREdGdUlKa1Y0RW9DTEU3RDJ5WjNiQnJnRk93SnZBajNh?=
 =?utf-8?B?TlZRbURrZS95eFBJZEpucXJCTGJhT0tzOFFkVWlGMmhyem9yOGdYS0o0NlVr?=
 =?utf-8?B?eWM0TWJXOGdxRVpNL3BFanBVaGVzYjJBVFIxL3JUdUpWTWI2UWJRbnNCOVl2?=
 =?utf-8?B?QUFidm5wYUlocFBpdUJoZHFkRDFkNWFLUE50bHJkNXhWSjNWamR1Y1BEZXl3?=
 =?utf-8?B?QU84YUNpUG4wUDFVT1hTQzdTdVowVCtkYWdEZ2FRUUxXOHVnanJ5NEtlbHY3?=
 =?utf-8?B?dzBCbldZYWhmZ0FJUzR6NFJRRDByVWgxTzdnOGJrcytwQ1J3L25vUTJkaUJi?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467fc05b-0d52-4844-504e-08d9ed58bdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 12:19:24.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kk4v7Iw6wG6qoqAXYm4UEu4pqNlwW86XtiRhuZFaU3pdhz5jJEXJ1TQulzqIvsnfhJ4L04/1uUTmzXBdHjP5/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0437
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gSSB0aGluayBpdCBsb29rcyBoYXJkd2FyZSBzcGVjaWZpYy4NCj4gPiA+IElmIHRoZSBm
ZWF0dXJlIGlzbid0IHN1cHBvcnRlZCwgSSB0aGluayB0aGVyZSBpcyBubyByZWFzb250byBwcmV2
ZW50DQo+ID4gPiBmcm9tDQo+ID4NCj4gPiBeXl4gcmVhc29uIHRvDQo+ID4NCj4gPiA+IHJ1bm5p
bmcgb3RoZXIgZnVuY3Rpb25zLCBzdWNoIGFzIHVmc2hjZF9xdWV1ZWNvbW1hbmQgYW5kDQo+ID4g
SXQgaXMgbm8gbG9uZ2VyIHVzZWQgaW4gcXVldWVjb21tYW5kIHNpbmNlIDU2NzVjMzgxZWE1MSBh
bmQNCj4gPiA4ZDA3N2VkZTQ4YzENCj4gDQo+IFllYWgsIHlvdSdyZSByaWdodC4gSXQncyBqdXN0
IGFuIGV4YW1wbGUuIEkganVzdCB3YW50IHRvIHRlbGwgdGhhdCB0aGUgbG9jayBhbHNvDQo+IHBy
b3RlY3RzIHRoaW5ncyB0aGF0IGFyZSBub3QgcmVsYXRlZCB3aXRoIGNsayBzY2FsaW5nIGRpcmVj
dGx5Lg0KT0suDQoNCj4gDQo+ID4NCj4gPiA+IHVmc2hjZF9leGVjX2Rldl9jbWQsIGNvbmN1cnJl
bnRseS4NCj4gPiA+DQo+ID4gPiBTbyBJIGFkZCBhIGNvbmRpdGlvbiBhdCBzb21lIHBvaW50cyBw
cm90ZWN0aW5nIHdpdGggY2xrX3NjYWxpbmdfbG9jay4NCj4gPiBCdXQgeW91IHN0aWxsIG5lZWQg
YSB3YXkgdG8gc2VyaWFsaXplIGRldmljZSBtYW5hZ2VtZW50IGNvbW1hbmRzLg0KPiA+DQo+ID4g
VGhhbmtzLA0KPiA+IEF2cmkNCj4gDQo+IFRoZSBkZXYgY21kIGV4ZWN1dGlvbiBwZXJpb2QgaXMg
cHJvdGVjdGVkIGJ5IG11dGV4Lg0KPiBBbmQgYWN0dWFsIHJpbmdpbmcgYSBkb29yYmVsbCBpcyBw
cm90ZWN0ZWQgYnkgc3BpbiBsb2NrLg0KPiANCj4gSXMgdGhlcmUgYW5vdGhlciByZWFzb24gdG8g
bmVlZCBjbGtfc2NhbGluZ19sb2NrIGV2ZW4gd2l0aCBpdD8NClJpZ2h0Lg0KDQpBY2tlZC1ieTog
QXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQoNCj4gDQo+IFRoYW5rcy4NCj4gS2l3
b29uZyBLaW0NCj4gDQoNCg==
