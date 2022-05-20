Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845AB52E52D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbiETGmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiETGmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:42:52 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80114CA2A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653028971; x=1684564971;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WaTVeCrqLIdeN5XOwtTgkf5W/XTGCgnePcdNHTH0EwU=;
  b=zEI3Yd0xSaW0MmHltYJUwiNR8dX/A/lxAQFOECZ+CHSPQxbbD5jkCwEt
   /HZcILqAdFM+kAnC7FEicVYhJFENGEleFUfSypdUGd916nKjBRyOSNOYk
   QezpZ4HFup+94BAfmM2XQHFWteZjYlBK8k0KJXaVnNr1jumLAiSdzKU7N
   Xg8sLF6YLs2SUKVREpSL4Nume6W9k4XLEqjBjUr/Wt+gF15KCtTIg54MW
   Q2n2t/T7/VXwp6UcXYj+m+dOnfdh0+39HrXvRM0UsM5hhQtEzNi2OacUT
   QK1F7ysKg+/N1IW2IgldIb6CDUo0m3i4aoA3CwnXPkEgqh3keDGzXGgvN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="56293931"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="56293931"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:42:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+UU3m87/LTv1WfvEC4cj5APjRhNAyRcDpRu8UJHppdCU+2KG9dGctQtTTvJHtVTYyEj7aILyhnet7Pu5FtJlpyGhrGrw/7+TQcYcYNi+ds9dx7+ps843xzPLH357GynUkxRS2t1pLujN9Df9FmVUazmA2pfuSnf2f+pc/D9JPnkT9yvdYSrnxyX3zLDnDZhOXEviQgUy+mCzBIOuMPXtq8hzjqT1vbiUy9G7fXlijK+PRDVNb6n0sK0DRx9ZT/06CL7PO8WErHJN4uxJOQg5vRyvoYjxWfG+RzqO1W/DjLWRp1LxuZCB6LIquI60GBRqTTrD4tcddH0pVvZSDOVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdSdnw1ZgLkXeuYRuHrPIPaxNpA3+9/REqKJcIH+sLY=;
 b=JJNKv0CVH/8VQ4w0TtFbQdbeE5QBI/r2yHG/dOs5qy/mLkessTvsvjKoOrtCUs5u0pjEhGY556blEStzKccsAm58hwpsMRHQstTrlrpn84CqNmZV4CYWvaMn84tZpY7VUczQkyLAslolb6dzeIpM0RBqltHErYdUbK4c0OUZ/ywY5QINkyKj7DPRvJ3JpCbLSSOItwKApEi708dcRf4+1hxxBV95DWXbP+zTNn37MnC29VWFo3RwBByeh1NN1G5BQkcXlwX3SlL5bcFfrJsOpYxKiBECTzeaFFrgBnCKScoe9GSF1JuCFpH6MnBMJIo4oHp2h7vTex+CtSxFmdYrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdSdnw1ZgLkXeuYRuHrPIPaxNpA3+9/REqKJcIH+sLY=;
 b=RNy5sbXoyXKHcecPVR4eB2mqlZWJW6bMCXyrJU04k945OSoex2VKjbp7t68/bFpn+4dzV6Ti/t6zKXODmTC41FJnk2ZEmVYlyTDHjG3YAzkx5vI2Dd2ZBbOMAUkR8aIHjd60957vorR9F6Gir8vdv8PnuVW6MvI3Qdc2bVJJ3jE=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYAPR01MB3949.jpnprd01.prod.outlook.com (2603:1096:404:c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 06:42:39 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 06:42:39 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/8] drivers: base: Add Kconfig/Makefile to build
 hardware prefetch control core driver
Thread-Topic: [PATCH v4 2/8] drivers: base: Add Kconfig/Makefile to build
 hardware prefetch control core driver
Thread-Index: AQHYaoDmfdWzWZeZ+EySDhUbMeBH060kNhgAgAMd7kA=
Date:   Fri, 20 May 2022 06:42:39 +0000
Message-ID: <OSBPR01MB20375A142383098DC30B187F80D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-3-tarumizu.kohei@fujitsu.com>
 <YoSajCpRsxlrHXcS@kroah.com>
In-Reply-To: <YoSajCpRsxlrHXcS@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ad4e16-40a2-4a69-9350-08da3a2bef33
x-ms-traffictypediagnostic: TYAPR01MB3949:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3949AF561E923BEAE436983280D39@TYAPR01MB3949.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgrKjF4GJ+VFYxOm9jxQjRKBy67zvv4gsiqjA/LOs22ObEGPWhBSV5G0f/JyCSDbxcOGJItaVTTwIF65yRDRk9WHhMKGtOPgRqKSUaG4MdBcMqs2VTCsE2ROAURfT3QpWyO7T8FGcoXElxmxfQq39tX0BRL30YjQAXEJEMlUxzJ13NNJXHh8kHgSlyT5A160NmLpnITyX7BLwdIf6fJ/49XKkgo7T6sWvRBpNZ4u85LDdysq961QeR5NvNOiWtFfedWuk10cEtImv8f8+UXNp+6euMsYS77GhN5Cjw6wp/kefcft4mMGDz6q4fGhff44nlGs4SbLWULLSUTxgvY9b5m7pjj2WwzAzYPsGd4pSf4/7zqLOEbEEE2xyrbQ/9zCNwxj0NTdEhn7MQsxkETLRe/O2tSSyeagMOlRRxo8BZcKmoZtllmq+y9rQDPfMeijJ+F+Dd90nIC0U7bN5f1I9RFFucZMquRWDtxOSVXoCBiyyzj8N8hrep72fvlEXHngpP/zcjWhf9QumHK4so7n/jExeQNn4AJ+3NGt1cfIYQi34+0F5wivMkPd5Mv6IxWlRvrF7s2gFpxTUyE5/gMKFlVaKc7JkgHU7Ju572s5XTEucEomsM8MvZtHNnIGnN+ik1K6yixmGD58fRy1FcilSXoaK/rjRZh2uSGbzUWuhR0XKtzDlP0EYBzC6yh8qoDj3RYf/4U1EnzGgTdO6T36cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(76116006)(4326008)(8676002)(71200400001)(33656002)(316002)(7696005)(508600001)(6916009)(54906003)(86362001)(38100700002)(66476007)(64756008)(4744005)(7416002)(55016003)(82960400001)(9686003)(6506007)(5660300002)(52536014)(8936002)(66556008)(66946007)(38070700005)(186003)(85182001)(122000001)(66446008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cTh2TXU0dE50V3Q4QUp0eklJdDRMcXJLa2MrQVV1SFZxZ0IrRTVFZ2g0?=
 =?iso-2022-jp?B?cVZNdFlkU0M4QUNMSm9RVytsZ2hMd01LdytrTDZjRVBpa3VEbTV2VHNN?=
 =?iso-2022-jp?B?SlRYaHBlUkF5bHJ2NkkreFBZZ2VzTURCQkdsVFI2N1JIOG5BTEcrcXNq?=
 =?iso-2022-jp?B?T1F3alpnbUwzNmtIcE9adjZYNjFGNW5ZYTBjSCtPTEZTY2RrN2RvMTFW?=
 =?iso-2022-jp?B?b05UNXJ5cXhLQXorQk13dUp4QTV3WG03cHZ6eDhVWjhqL1BRUDBBa2hE?=
 =?iso-2022-jp?B?SGNPMWhUdmlDTCt2em03NXYyQ0xhYzF4T09ublRocmdSSGNGRDRlVEQy?=
 =?iso-2022-jp?B?V2J6eVFWWGtSQ0FqVEtydTRPYUhjRFlHREExdXhjWmVCSHZIWlBhU1ho?=
 =?iso-2022-jp?B?TGZPYVVLVmNwNzBhaGZPM0dadHJrMEo4RnNHaUIzRDc2TTlXWWU5SUQ0?=
 =?iso-2022-jp?B?S3k4bnlieldRdHhHQW93d2hQUVJCU0orYXJiMC9BMVdNRXU2V3UvVisw?=
 =?iso-2022-jp?B?alpnVEdSTmhHbUJuTUQ4UVFJNnJyY1RJWlRoZkdNRG9LNlVhY2o5aVR4?=
 =?iso-2022-jp?B?QTMrZXBrclBCTHE2cS9HMk42VzhqL21DanhwekV1aVh5clZoSlhFcWlR?=
 =?iso-2022-jp?B?Z3RrMEhzd0hqYk42ejE1MWdyczNkMEJtMEt5emhXZHNhdFlENXA0VWRU?=
 =?iso-2022-jp?B?Vm1sTlZNWWJDN0tmUmJrUTNGNk9FSTRoY21jL3BIQWVnZWRTTFRQQXdt?=
 =?iso-2022-jp?B?ZXpEOEdidXpUV3Q1VEcrTmFSTnpNcGdLS2toU1BwbVVRbDNzcjBibTVY?=
 =?iso-2022-jp?B?YzdKMXA0Z255YzVvV2tPY1IzcG1hSHE4SndCcHFNWjNSVFk3aWlDd1lm?=
 =?iso-2022-jp?B?dTFpRC9scmljdVRXUFNhNThLRCsyVXBSUWo4VmU1YzdqQ1lqWVdXNm93?=
 =?iso-2022-jp?B?a2UzcU5jcVZKYzNJYjhMMUYzMGl4Z2RjdGRQcURMRGIxNW9zaC90ZUt1?=
 =?iso-2022-jp?B?WHI2MlNEZDNWWno2VzYxdWkxWTR0OWJ2UUtyRldFS2p1S2pwUU5CQ3ZI?=
 =?iso-2022-jp?B?RTNoSFNYSGova3A4bGovVjkrTnhHNnMwcW9vQ1JVV1lEYm9hdWdKdzBF?=
 =?iso-2022-jp?B?V3RlZ1RUWHptN1FVeW9ybWZLS3NpZVdDOTJjdmxCTnI0TkhLMEc1NGdN?=
 =?iso-2022-jp?B?QWQxT0tXamcwaVJ5Q1QzL3d3eFg3OWdYYUtLZzlHckxSdDVvckFhRzJl?=
 =?iso-2022-jp?B?c29FWGcxcFVXVTh3dzRvNThsL0xnOFBLUXNzMnNmMDF3YWF1bktEMHpX?=
 =?iso-2022-jp?B?bEN0TXVoMVN6QzlwTWhZRVR5VHg3UVBZa0R2eUd6QTZMekFBb2w0QmZT?=
 =?iso-2022-jp?B?djlGWG44YXFLRUFNUm5TanZNeXVWcXFsMlUvRVpGcVFneDRlM0g0eFRv?=
 =?iso-2022-jp?B?WEFmTjBua3JMRVBMUWNQNExmS0Z2QmpRV3BWeDRsTlU0NHB2U2RLSi9K?=
 =?iso-2022-jp?B?MWxhWjVpVUxpcysvbWhVUlhTeTU0ZlZMckNCT3VOczMxK0VuZFZob0lT?=
 =?iso-2022-jp?B?MUpVNFdCSWJhd2hkd3VxM0NpMml0VXFBcnM2ZjVIK3YwMldYdEFGSmVH?=
 =?iso-2022-jp?B?VlBlREIyY1ozTThKTWRMTVh1SFl5Y1VFNnpSUThXb2JOd1daYlpFaVRv?=
 =?iso-2022-jp?B?a05nbFlNckdxbG1FeW9RcXBHdnVpQ3Bqb1k3dWhaN1J5M29zdmlGYmZa?=
 =?iso-2022-jp?B?MXdETUxnNW1MUVI0aExtSGRnWWFDU2duYjF6dndFRVdZVWw2R3JDdkJr?=
 =?iso-2022-jp?B?VFdpYkVQMWtsK1VrZU5qdC9nY0lDQWVXOHduUjBudlBreVNGR2w0azY3?=
 =?iso-2022-jp?B?NkdZZlpodFV1OW1ZQWkxNGN3eE5XN1R1WnVhbmc3UER6RnF6QjNTSnli?=
 =?iso-2022-jp?B?TEtaelNpd2RGakFtV1pQYm5pcGxXRm5XcFRoMC9paXhlTmNiQmw5ckdG?=
 =?iso-2022-jp?B?MFpPVlhEbkhPWk8vYjh5WlJwaGFFbzlWNldDNG9IemNvRkFGbis5M0dp?=
 =?iso-2022-jp?B?cWNLUktGenRrc3pyWTlIcjBQd3RnVjIwbEgxVUdXU0IvSlBhRmNOL0tj?=
 =?iso-2022-jp?B?ZWpSTW1NN3FnL2UxN3lsSThCUk9Dck5CVG9BTEppZlU0WUNPRTFldVcx?=
 =?iso-2022-jp?B?NFhQMG1LMmtnQkI2ejRDOW5lSDMycEhxQkM0bTR5WUpPZXpSV2NHN1JN?=
 =?iso-2022-jp?B?MXFqdzQybWNpY1J6V1FLdWdwS2k1OCtlTS9MZDhtbThoUzFsY2xaSjEr?=
 =?iso-2022-jp?B?YjNiazVLOXJITHNENFFIUUE1Wk80Ukh1M3loUlpqOFc4bXBGMlpZSUov?=
 =?iso-2022-jp?B?aFFhTzBGeUVPTCttdklvOVBWbjIzMkloVHpEcjVVbGREV0dueEZDcDdL?=
 =?iso-2022-jp?B?Mjh4ZGloRFFVem1jQTFHTlRoR1lTWjY5dktkd0lsTGFrTGxURVpEdm9v?=
 =?iso-2022-jp?B?MjlIRDFQZmdEQTE3Z3lOTElxb0djM21oaDNxb0ZUS0lxYlRVZlprWXgw?=
 =?iso-2022-jp?B?QXYvNzBVRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ad4e16-40a2-4a69-9350-08da3a2bef33
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 06:42:39.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HS/3lxoxGLdklVVbOHJZZM38xWKfcRSEXiI9eCbSEljdJ4Om+IQFge0eB6kejTAcn1HSbDDew0k4wShDkJ7gaa1tZVT6ussEEJSyhBLhOko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3949
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Shouldn't this have "GENERIC" in the name liks the other generic implemen=
tations
> in this directory?

> But this is not a driver, it's a core function that a driver uses.  On it=
s own, this
> code does nothing.

I consider removing the core driver in the next version. If I keep the
core driver, fix the name and description.
