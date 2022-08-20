Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B752E59AA7A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiHTB2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTB23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:28:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581733343A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 18:28:22 -0700 (PDT)
X-UUID: 190efda416d74db6832ca3792ff414bf-20220820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DMl6mYKZDeeBvKBYtTo7KsQ7kTzQ8VqIM88baoLwJhg=;
        b=YFNNsOG0FrC+7VjjruujLaLY8YWbq7y7t+7TaE6RShuEYnmgPnBeUd0sUP8AprVvSxpZsvGmgEp5UhvB9xrYFQWyfeLJMtPrIZgIadPdQXqBGR6vePNhNYHfTT5SxaQ3Z4qnNTinsE+MTwhIo3RQ4MB21RqHYalDtDYjdy9ZHt0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:57ba204a-94de-43d7-960c-be4c55236b4a,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:061f0fcf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 190efda416d74db6832ca3792ff414bf-20220820
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 687772273; Sat, 20 Aug 2022 09:28:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 20 Aug 2022 09:28:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 20 Aug 2022 09:28:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8w4hFFRoPvm1Y2cBOeUbj1CiQjNmTVBZ7oebCepko9UWH9Rkp8VYE3tMWAcB4yqqW2zAIcpg80FNEobWkOuSPblxiJ7tfitRxrix2nBDwtSduXt3+WWarIdceHNVMaY5tYKc3IH5FxSx0/ldPT+Bk+zKuawbVgwXsPK9/lL5WS6uYvdh2no8ob9fkSL6gEnG0/NIRxbnMN7KkCN0dfa8hr2JSP08WYiMjgW3DMrDLFyDLoEp8i9i6e1OCwrxJSalMxFujpiBPg+88BtBD9aI+RSAvzHfTf4zM5xyC+RgWJNkxA6Q8O+DmtNPRVKMHh6IeQfwYP0mX1LLcUW59tlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMl6mYKZDeeBvKBYtTo7KsQ7kTzQ8VqIM88baoLwJhg=;
 b=BDBy7yOP0Q3Kft6VVKpJEXTz8f1QUIyjsT5o4TYa83f6oLKm6llJbO8/rpMyKLsc7SQIJPQ7ktj30+u+QVe/jXTjTIn10ygdbR+JgGGTEol3dUavei3jqkSdu5PLXhKuLZgSQoph0l2iE+vfE+o46PoBD1lbOkRCPRGUH5bmKvMdpFk3ZrWfAWTq4zOUQciQYQaefL4EuGnpKgtQcoExcuEZ7Nu7mw0UWHA5GSeHz6oOG+Ds2r8o1wFlXO5celRHfChutNBjHvcxwWZOyGw/ggW4aGMTdmu6Fouc2c316H7XuKTqP+X50p47mOX4P39c+H3REtjsY3ivchrR04fhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMl6mYKZDeeBvKBYtTo7KsQ7kTzQ8VqIM88baoLwJhg=;
 b=TukF2Zj5oipjKIzZbKIMVMuAVJ+BLBaqz6YQHcbQh02ZVOifFlv529ehwwDxos4fR46pe9UCXKrBZt7hgpZhtpZ+1RZZJuNTRzS3KExZ7takMAo1InpyZ9jZPABnfTDGCYjdlkMPuCblpzIsNBdLjJt93rv8ycr5BsTauWQ7NqM=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by PU1PR03MB2873.apcprd03.prod.outlook.com (2603:1096:803:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Sat, 20 Aug
 2022 01:28:16 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::3802:80d8:3cd8:173d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::3802:80d8:3cd8:173d%9]) with mapi id 15.20.5546.014; Sat, 20 Aug 2022
 01:28:16 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        kernel test robot <lkp@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UGluZy1Ic3VuIFd1ICjlkLPnp4nli7Mp?= 
        <Ping-hsun.Wu@mediatek.com>,
        =?utf-8?B?RGFveXVhbiBIdWFuZyAo6buD6YGT5Y6fKQ==?= 
        <Daoyuan.Huang@mediatek.com>
Subject: RE: [hverkuil-media-tree:for-v6.1c 3/3]
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:905:10: warning: cast to
 smaller integer type 'enum mdp_comp_type' from 'const void *'
Thread-Topic: [hverkuil-media-tree:for-v6.1c 3/3]
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:905:10: warning: cast to
 smaller integer type 'enum mdp_comp_type' from 'const void *'
Thread-Index: AQHYs3DqUcval3/JekGATstrYW2SFa22WsmAgACmO7A=
Date:   Sat, 20 Aug 2022 01:28:15 +0000
Message-ID: <TY0PR03MB6356EDE648B14226E5A6BA50E86F9@TY0PR03MB6356.apcprd03.prod.outlook.com>
References: <202208190957.uDT8XE6b-lkp@intel.com>
 <427a05ef-44c0-0044-6ea4-e110afcb75b2@xs4all.nl>
In-Reply-To: <427a05ef-44c0-0044-6ea4-e110afcb75b2@xs4all.nl>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51ab89a0-a765-4e1a-1477-08da824b4192
x-ms-traffictypediagnostic: PU1PR03MB2873:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkMLDUtUoJoND35MbPvaTrTu4Xa8s6SRZXo/zJyDX5pOT3eIRVxiDFmGVDkJIRAbOlfXubL363ntdF/QQI/KkzliLl4KKX9CEZ92tjByZmDI60KHmR6qRUwMJklmY4Ra0CN8uDqPWAQ9y34oTbEKG2IRmsXDW0V57trBR5v1/+iroXXvFZmYLM+9IGP8O9ZVWcSxkMX0RmsORhnAkDYVb9ez5Mfdq7Gk4C1JMEqdYzDaXQ9il9KumXb5G8D8djanfgcYUbL8I1xTqxPy8SA7D3tnEt4v3kKkX7rdwT8STkiV/OIEGuYy3p/Wd5RFLDg1AI89dLMDo8Mn+gWom8f5lDME1ZqqY4cw33oTF/tsggpvKP5V2jv4IGGx50i3KFpmlrNZ/KkPpiSJNTjeJ+/tfFxlG+Hv3vzsFg2xqIq/dVjCnqVKP/giWKjW0tsqXoBIk4bMRFjHvYBHtxUe5Em+BWQG7vqNSNeCbTAeoS+aYOqYimVVwj+QOU1Kk174YtH3nSZsEEHTOGnSm6YfePdIBHSQA1vFiJZzMbslMfXk05uQPancisS1V1dQMF06Vc4I8w7x0/XmkNjKmSIPgPfM1IVLjedvLmYZhQ5NbPIPS1TdZIrZgztvBpqgtX3Y64rwKo25N9OfVL6os2LCsUUCQ8qkTDce7gQ/HOXdr3cTJCSVne3ITMAY3S0Gk/Nshwu0hQY7Q/yzjvaQ8Sja67zhTW63O2the920YfJk0pBCAcm/dvsU1Yb9pAOudwAsL+x+44Q66HzXh73sI07bYproTJA9aMtVzetOuI/AxVlM4rtFo9YPEUh8skN1sO/1OzVFkBAeYZRXk6jLBlZVdlXg8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(4326008)(8676002)(64756008)(2906002)(316002)(66446008)(66476007)(54906003)(55016003)(76116006)(5660300002)(66946007)(110136005)(66556008)(52536014)(122000001)(8936002)(478600001)(33656002)(38070700005)(86362001)(7696005)(85182001)(38100700002)(41300700001)(6506007)(53546011)(71200400001)(83380400001)(26005)(9686003)(107886003)(966005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUhEQXVwY3l4cmFzb1NxSlZsU25UTVl5T1hDVURINjJnUm9JS0pES091a29H?=
 =?utf-8?B?ZHVjRzZVakpSdXhWSEt4RU5Dd2QvL09vZHJTOEt4eTVQWWVtM0VGQTFsczNq?=
 =?utf-8?B?T1crdWVyZmVJdGxxZnp2dTQvWEZLejcxSGVpdDFoSEVOV3NldWhac2RWM3I3?=
 =?utf-8?B?YmNuRUMrS0F5OE11VHYzbHduOFFwQXJaNGIzcU1pMktYVm9nOE5nbVhHRU1j?=
 =?utf-8?B?WE5WRnJMMW1udkM1R1VSc1pzOTdMMUYzd0VkKzRGeUZMUlJnNVUwV0g0UE4w?=
 =?utf-8?B?c2RRb0YxMXUwbko2UDUzU2RPc2Nhbm5meHQzV0lHTjRTUFdqcXJVTTZhcGdw?=
 =?utf-8?B?YS9CczFxU09VK2lFTjJ1YW1wSUk5TytUUjNHQ1ZILzZNa1FFV2h1VFMzMVNP?=
 =?utf-8?B?bW5yTzVlWHF1WVlZcjhmdzhPZEFBU3ZJUTVNQThXRndKdzhZb0JMU0p0Q0dV?=
 =?utf-8?B?OGFXQXh5V2hzNHJqc24wcTFVY0NBS2o1T0Y0dW9HR2lkOUEwMjFnbkJjdHZr?=
 =?utf-8?B?NHh5OGF3aE12SWlxeFh0Y2NwblYvbjN1Q3FzelpOVExOdVRod1NRYytnUFU4?=
 =?utf-8?B?bWNZc2wvckZyblM3N24wenRpNURIcCtIOHNHa0o4RmszUlBtbFhVeDdJZmdj?=
 =?utf-8?B?Y0VzeEduSEpYNGJhZ0VYV3ZkU2xUK3p5UDN1UGpEZi9xamYzYlJpZHdlOWV0?=
 =?utf-8?B?dTZpVzJabkh0dXpTcjQ2TDFac3NhazZiZE1VSkNGU0N4cGZvbHNDeXdLUEpI?=
 =?utf-8?B?V2FQbWEyK3YvNGxid2ZRbXA2RHdISU1DT0FQWnNuVGd0LzlYWUMvS3phckRu?=
 =?utf-8?B?dnFaN3VqUVptUzBJVzJlM2o3RHJrQTVndmhOaEkrNUlBWmtDd0dHdWYwM0VE?=
 =?utf-8?B?NXdnZVBvZEFSZDc5VXNQR3ZNVlZDdnRFdStRcXljWHRFRWE2b1k0MWhJQjBh?=
 =?utf-8?B?VytWM0pmYnpQblorc1VBM216RjV0bUlCY3JDc1JINUNKZ1ZZNFRIOXRQejRN?=
 =?utf-8?B?MTJFWGlCekZ3TFljQTRmbXFGc2VDVzQvYjFSRURYdEFBWHhKVE9PMFBBYmFW?=
 =?utf-8?B?ZUprZXZwaTVqcHZrT0QrOFE2ZElSamRJOG9KVFgwb01mY0VQb1FnczFIanYx?=
 =?utf-8?B?d2c3WnRyNVRXWStBVkphczl6a1dnTFZOQ0gySEc4OHpBQXNrL2RaWnhRN1V0?=
 =?utf-8?B?blBaYko0bi9JbkVaN29BN0ZuS1lBQ3UwL0dhTVEyTncyMVRHYWd6aEs3YTBP?=
 =?utf-8?B?WmpYdkYzYTFHcU0xcVBTenpqOGNjZy9rLzZhRHdkSlhSbzZHUmhtV2ljd3Jr?=
 =?utf-8?B?KzVzd0ZoOFNlSW04TWJOM21Jc1ZJYmIwQVNCSDl2WEVuS0pYZ0cwTzRMWW00?=
 =?utf-8?B?a2p2T3VTRU15OHUyNXpTRTZ0NlJUM3o0VmhTa0UxalJLVHQ3VmtGdEtBQ01N?=
 =?utf-8?B?a2NQcTVYTTlyZXBvVUVreUNGUW9oNnZ1SVRQRytGTGZoNldIdEExZnFVdnNu?=
 =?utf-8?B?NXhKRHhoeU9IRzFKQlM1c2p0bm1PU1I2NTVjR0tocXdSTnlZQzZZZmg2dnlN?=
 =?utf-8?B?bU91UGkwUklSOFQxcFMrK2Fvd0llYkEwSmIwVU50L0tIZ2RwdnEwWFNjY1Rj?=
 =?utf-8?B?NHlPWDhmRUtodG1ibTZLU1lzd1Q5bW9za3NSbUlQSG8rV21DeHNuQWpLRmVp?=
 =?utf-8?B?dmNnM1JTbE94NXdtckZMb1dTTEFkVng3allPOGlPbkVzY3lRcnNxTm10a2p2?=
 =?utf-8?B?dUREcG5mVGUzbXd0YTJUTDhxaWlUdXJZVDZBS1JhRWwxWW5Tb3c0N1E2S0tR?=
 =?utf-8?B?bkVuR0pnNUY0MnhCVnF1MXBHQTR5UmN4Ri9HZnBURTZBME1iRTJ2c0pPOFhz?=
 =?utf-8?B?OFBsRDZJTXRlMktaRVdMeHMrbkhEQVRRVW5QOUYrbEsyVEFHeUtQTHYyS0tm?=
 =?utf-8?B?NDdWSVFkQ2h5YzNQTFVsZGNNOVBJdTI5K1BNamdlUlNnNWNFSjR3d21UNFFl?=
 =?utf-8?B?UkE1UGt6WlJTVW9iOTlyNjVlQXJ4VXNNSCtmSUtaenltUEFlZzRJT0pCMzJ6?=
 =?utf-8?B?MWJqaGs4aERWVjd0K0I0ZDJzeDBidkM5QWlPbXlXNGtwa1dhWUh2NExRV2Vi?=
 =?utf-8?Q?4GzkrxAdlGjTXguAkYQ/8HE8P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ab89a0-a765-4e1a-1477-08da824b4192
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 01:28:16.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Esie/2QvzNGwG8lMsI536GW5HF62Yc3V3KEZq1CWp0r+tmv8U+dVGz2V68PHM/PIo83KcbYCgzMUO9TiFpLRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR03MB2873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEhhbnMgVmVya3Vp
bCA8aHZlcmt1aWxAeHM0YWxsLm5sPiANClNlbnQ6IEZyaWRheSwgQXVndXN0IDE5LCAyMDIyIDEx
OjMyIFBNDQpUbzoga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+OyBNb3VkeSBIbyAo
5L2V5a6X5Y6fKSA8TW91ZHkuSG9AbWVkaWF0ZWsuY29tPg0KQ2M6IGxsdm1AbGlzdHMubGludXgu
ZGV2OyBrYnVpbGQtYWxsQGxpc3RzLjAxLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUGluZy1Ic3VuIFd1ICjlkLPnp4nli7MpIDxQaW5nLWhzdW4uV3VAbWVkaWF0ZWsuY29tPjsg
RGFveXVhbiBIdWFuZyAo6buD6YGT5Y6fKSA8RGFveXVhbi5IdWFuZ0BtZWRpYXRlay5jb20+DQpT
dWJqZWN0OiBSZTogW2h2ZXJrdWlsLW1lZGlhLXRyZWU6Zm9yLXY2LjFjIDMvM10gZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNvbXAuYzo5MDU6MTA6IHdhcm5p
bmc6IGNhc3QgdG8gc21hbGxlciBpbnRlZ2VyIHR5cGUgJ2VudW0gbWRwX2NvbXBfdHlwZScgZnJv
bSAnY29uc3Qgdm9pZCAqJw0KDQpIaSBNb3VkeSwNCg0KT24gMTkvMDgvMjAyMiAwNDowNSwga2Vy
bmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+IHRyZWU6ICAgZ2l0Oi8vbGludXh0di5vcmcvaHZlcmt1
aWwvbWVkaWFfdHJlZS5naXQgZm9yLXY2LjFjDQo+IGhlYWQ6ICAgYjIyNzNiODRlMTI5MWM1MjI3
OWVkZjEzYjA4NzQ0ODMzYzFmYWFhYg0KPiBjb21taXQ6IGIyMjczYjg0ZTEyOTFjNTIyNzllZGYx
M2IwODc0NDgzM2MxZmFhYWIgWzMvM10gbWVkaWE6IHBsYXRmb3JtOiBtdGstbWRwMzogYWRkIE1l
ZGlhVGVrIE1EUDMgZHJpdmVyDQo+IGNvbmZpZzogYXJtNjQtYWxseWVzY29uZmlnIChodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNo
aXZlLzIwMjIwODE5LzIwMjIwODE5MDk1Ny51RFQ4WEU2Yi1sa3BAaW50ZWwuY29tL2NvbmZpZ19f
OyEhQ1RSTktBOXdNZzBBUmJ3ITFEZi1FX1dZUzE3NnRFZHgyaGVGSUQ2aW04SC1Lb1JzSi05U2ds
R1FhcTBSUXMxQ21tMWxSaE4tSmdyQjByOU4kICkNCj4gY29tcGlsZXI6IGNsYW5nIHZlcnNpb24g
MTYuMC4wIChodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL2xs
dm0vbGx2bS1wcm9qZWN0X187ISFDVFJOS0E5d01nMEFSYnchMURmLUVfV1lTMTc2dEVkeDJoZUZJ
RDZpbThILUtvUnNKLTlTZ2xHUWFxMFJRczFDbW0xbFJoTi1KanNWZjdVcyQgIGFlZDVlM2JlYTEz
OGNlNTgxZDY4MjE1OGViNjFjMjdiM2NmZGQ2ZWMpDQo+IHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9
MSBidWlsZCk6DQo+ICAgICAgICAgd2dldCBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jp
bi9tYWtlLmNyb3NzX187ISFDVFJOS0E5d01nMEFSYnchMURmLUVfV1lTMTc2dEVkeDJoZUZJRDZp
bThILUtvUnNKLTlTZ2xHUWFxMFJRczFDbW0xbFJoTi1KcW1aeXF2SSQgIC1PIH4vYmluL21ha2Uu
Y3Jvc3MNCj4gICAgICAgICBjaG1vZCAreCB+L2Jpbi9tYWtlLmNyb3NzDQo+ICAgICAgICAgIyBp
bnN0YWxsIGFybTY0IGNyb3NzIGNvbXBpbGluZyB0b29sIGZvciBjbGFuZyBidWlsZA0KPiAgICAg
ICAgICMgYXB0LWdldCBpbnN0YWxsIGJpbnV0aWxzLWFhcmNoNjQtbGludXgtZ251DQo+ICAgICAg
ICAgZ2l0IHJlbW90ZSBhZGQgaHZlcmt1aWwtbWVkaWEtdHJlZSBnaXQ6Ly9saW51eHR2Lm9yZy9o
dmVya3VpbC9tZWRpYV90cmVlLmdpdA0KPiAgICAgICAgIGdpdCBmZXRjaCAtLW5vLXRhZ3MgaHZl
cmt1aWwtbWVkaWEtdHJlZSBmb3ItdjYuMWMNCj4gICAgICAgICBnaXQgY2hlY2tvdXQgYjIyNzNi
ODRlMTI5MWM1MjI3OWVkZjEzYjA4NzQ0ODMzYzFmYWFhYg0KPiAgICAgICAgICMgc2F2ZSB0aGUg
Y29uZmlnIGZpbGUNCj4gICAgICAgICBta2RpciBidWlsZF9kaXIgJiYgY3AgY29uZmlnIGJ1aWxk
X2Rpci8uY29uZmlnDQo+ICAgICAgICAgQ09NUElMRVJfSU5TVEFMTF9QQVRIPSRIT01FLzBkYXkg
Q09NUElMRVI9Y2xhbmcgbWFrZS5jcm9zcyBXPTEgTz1idWlsZF9kaXIgQVJDSD1hcm02NCBTSEVM
TD0vYmluL2Jhc2ggZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzLyBkcml2ZXJz
L3ZmaW8vcGNpL2hpc2lsaWNvbi8NCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkg
YWRkIGZvbGxvd2luZyB0YWcgd2hlcmUgYXBwbGljYWJsZQ0KPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBBbGwgd2FybmluZ3MgKG5ldyBvbmVz
IHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+Pj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay9tZHAzL210ay1tZHAzLWNvbXAuYzo5MDU6MTA6IHdhcm5pbmc6IGNhc3QgdG8gc21hbGxlciBp
bnRlZ2VyIHR5cGUgJ2VudW0gbWRwX2NvbXBfdHlwZScgZnJvbSAnY29uc3Qgdm9pZCAqJyBbLVd2
b2lkLXBvaW50ZXItdG8tZW51bS1jYXN0XQ0KPiAgICAgICAgICAgICAgICAgICAgdHlwZSA9IChl
bnVtIG1kcF9jb21wX3R5cGUpb2ZfaWQtPmRhdGE7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgICBkcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtY29tcC5jOjk2NDoxMDogd2FybmluZzogY2Fz
dCB0byBzbWFsbGVyIGludGVnZXIgdHlwZSAnZW51bSBtZHBfY29tcF90eXBlJyBmcm9tICdjb25z
dCB2b2lkIConIFstV3ZvaWQtcG9pbnRlci10by1lbnVtLWNhc3RdDQo+ICAgICAgICAgICAgICAg
ICAgICB0eXBlID0gKGVudW0gbWRwX2NvbXBfdHlwZSlvZl9pZC0+ZGF0YTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQoNCkNhbiB5
b3UgZml4IHRoaXM/IEkgYmVsaWV2ZSB5b3UgbmVlZCB0byBkbyB0aGlzIHRvIGZpeCB0aGlzOg0K
DQooZW51bSBtZHBfY29tcF90eXBlKSh1aW50cHRyX3Qpb2ZfaWQtPmRhdGENCg0KUmVnYXJkcywN
Cg0KCUhhbnMNCg0KQXBvbG9naWVzIGZvciBub3QgZGV0ZWN0aW5nIHRoaXMgd2FybmluZyBpbiBt
eSBwcmV2aW91cyB0ZXN0cy4NClRoZSBjaGFuZ2VzIHlvdSByZWNvbW1lbmQgYXJlIG5lY2Vzc2Fy
eSBhbmQgaGVscGZ1bCwgSSdsbCB1cGRhdGUgbXkgZHJpdmVycyB0byBtYWtlIGl0IG1vcmUgcm9i
dXN0Lg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KTW91ZHkNCg0KPiAgICAyIHdhcm5pbmdzIGdlbmVy
YXRlZC4NCj4gDQo+IA0KPiB2aW0gKzkwNSBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L21kcDMvbXRrLW1kcDMtY29tcC5jDQo+IA0KPiAgICA4ODMJDQo+ICAgIDg4NAlzdGF0aWMgaW50
IG1kcF9jb21wX3N1Yl9jcmVhdGUoc3RydWN0IG1kcF9kZXYgKm1kcCkNCj4gICAgODg1CXsNCj4g
ICAgODg2CQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmbWRwLT5wZGV2LT5kZXY7DQo+ICAgIDg4NwkJ
c3RydWN0IGRldmljZV9ub2RlICpub2RlLCAqcGFyZW50Ow0KPiAgICA4ODgJDQo+ICAgIDg4OQkJ
cGFyZW50ID0gZGV2LT5vZl9ub2RlLT5wYXJlbnQ7DQo+ICAgIDg5MAkNCj4gICAgODkxCQlmb3Jf
ZWFjaF9jaGlsZF9vZl9ub2RlKHBhcmVudCwgbm9kZSkgew0KPiAgICA4OTIJCQljb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkICpvZl9pZDsNCj4gICAgODkzCQkJZW51bSBtZHBfY29tcF90eXBlIHR5
cGU7DQo+ICAgIDg5NAkJCWludCBpZCwgYWxpYXNfaWQ7DQo+ICAgIDg5NQkJCXN0cnVjdCBtZHBf
Y29tcCAqY29tcDsNCj4gICAgODk2CQ0KPiAgICA4OTcJCQlvZl9pZCA9IG9mX21hdGNoX25vZGUo
bWRwX3N1Yl9jb21wX2R0X2lkcywgbm9kZSk7DQo+ICAgIDg5OAkJCWlmICghb2ZfaWQpDQo+ICAg
IDg5OQkJCQljb250aW51ZTsNCj4gICAgOTAwCQkJaWYgKCFvZl9kZXZpY2VfaXNfYXZhaWxhYmxl
KG5vZGUpKSB7DQo+ICAgIDkwMQkJCQlkZXZfZGJnKGRldiwgIlNraXBwaW5nIGRpc2FibGVkIHN1
YiBjb21wLiAlcE9GXG4iLCBub2RlKTsNCj4gICAgOTAyCQkJCWNvbnRpbnVlOw0KPiAgICA5MDMJ
CQl9DQo+ICAgIDkwNAkNCj4gID4gOTA1CQkJdHlwZSA9IChlbnVtIG1kcF9jb21wX3R5cGUpb2Zf
aWQtPmRhdGE7DQo+ICAgIDkwNgkJCWFsaWFzX2lkID0gbWRwX2NvbXBfYWxpYXNfaWRbdHlwZV07
DQo+ICAgIDkwNwkJCWlkID0gbWRwX2NvbXBfZ2V0X2lkKHR5cGUsIGFsaWFzX2lkKTsNCj4gICAg
OTA4CQkJaWYgKGlkIDwgMCkgew0KPiAgICA5MDkJCQkJZGV2X2VycihkZXYsDQo+ICAgIDkxMAkJ
CQkJIkZhaWwgdG8gZ2V0IHN1YiBjb21wLiBpZDogdHlwZSAlZCBhbGlhcyAlZFxuIiwNCj4gICAg
OTExCQkJCQl0eXBlLCBhbGlhc19pZCk7DQo+ICAgIDkxMgkJCQlyZXR1cm4gLUVJTlZBTDsNCj4g
ICAgOTEzCQkJfQ0KPiAgICA5MTQJCQltZHBfY29tcF9hbGlhc19pZFt0eXBlXSsrOw0KPiAgICA5
MTUJDQo+ICAgIDkxNgkJCWNvbXAgPSBtZHBfY29tcF9jcmVhdGUobWRwLCBub2RlLCBpZCk7DQo+
ICAgIDkxNwkJCWlmIChJU19FUlIoY29tcCkpDQo+ICAgIDkxOAkJCQlyZXR1cm4gUFRSX0VSUihj
b21wKTsNCj4gICAgOTE5CQl9DQo+ICAgIDkyMAkNCj4gICAgOTIxCQlyZXR1cm4gMDsNCj4gICAg
OTIyCX0NCj4gICAgOTIzCQ0KPiANCg==
