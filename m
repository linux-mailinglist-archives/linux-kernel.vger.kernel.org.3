Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1504EFD07
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353376AbiDAXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350461AbiDAXQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:16:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7803123F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648854896; x=1680390896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ioDGD5NX34+zEQE+sNbc+PDt2a5ut+eURd+5vAGO8fw=;
  b=FIaoPcc8Z6aI0+lqICd3jMKvT27KwE7uoVNdX9c/1alt2G9gtAYs50vD
   h/j4hmQsn5Tx8o5BIbEOD9Z5uEbzArn9QvnpylhdneDEf4RPbaXnBZitH
   ecthnscD3ZjGCWLJTH1zHmDA4+WJ/XsSpBmHx9khCbZlzlrIlAZ2+ObUw
   Aiu0AV2wr35D14Wfa5dmobT/GsgyB8Mypxeioc64Txo3dK2LSrmL5C9oY
   EJO77boEROBD6WDOzJ95QFnMzt1Xgu3m+W9xdnZ8g/Dpz6uibAdkqh/Yn
   6fhlBpabA/Hgqzu8cAvWZOjep7jIXqGsU/40fbim9PZNjkBcotZc6eSyB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240838345"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="240838345"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 16:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="656106242"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2022 16:14:55 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 16:14:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 16:14:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 16:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYbHmjShjx2LDVZG/zI91oR0JTO8XVvg4l3o/O1teCkwAg+3ZoVJqBHDXby6S6+70IpZEgVklUHUdVSimaqJsYVv2hCp/EavfR/ib6rxPxg+GcbJRImJRYOj5sdWBW6QZn5BgWBJ9UCMkkWeCOox4WwSvvFb11Cd4s5ZvVRiVM/Xamb0JwZ8aiumADpPQpJlSd+LWt9/NfydaAjKAIk6RmkVLbhk45I6izr9m0bBkW9rFNJhd3kmccpc5I3qDh/5+2LMYddfgkIfRd+VDS/secTcy4HTzKL2W0h2HCFM9rMyPb5KlJh9VqVYtRjy4SygbM3Sdb3/3vGYy+sAdNGthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioDGD5NX34+zEQE+sNbc+PDt2a5ut+eURd+5vAGO8fw=;
 b=AphoWlWCj80nCHXASG/4jjj5YutseSYUn/r3tpCb51TJGw0GH2OwnrQMr/SRakApVrvm0cWfXswKB5wnOJmrjdLMoiIWBz/GCNyJbwC9u7eSvEp8ERwfs20kir0D5t84S5V1tQ5ppLLH1Cv5MAZFMJH9CcchQHzq4fvLv+WRgZ+q/M6CZeWHxzJf3LZolaYPCdIJQezR9005bXcKP+b/QbX6hLNvbDAW7+Qt/wUlUQWEm/SO9tt2c1R+NBowRZIXoVUqtdtxg0zrZAf/t85cQTAVHUkXQALuaNS0IN67V7jxbhaL5KPISqNiL2DvkCUYDnpBEb7xIcHNeCLHiZaZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MWHPR11MB1664.namprd11.prod.outlook.com (2603:10b6:301:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 23:14:23 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 23:14:23 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
Thread-Topic: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
Thread-Index: AQHYRc7zp74DBEdkEUK28aFOHFLlt6zbOVYAgAB1GPA=
Date:   Fri, 1 Apr 2022 23:14:23 +0000
Message-ID: <PH0PR11MB588000A40081EC48536CA7A3DAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220401134649.2222485-1-qiang1.zhang@intel.com>
 <CACT4Y+YrKd=+uJT9UN8QvctPUGKnOgcReYfX41vNuVC0ecWXcg@mail.gmail.com>
In-Reply-To: <CACT4Y+YrKd=+uJT9UN8QvctPUGKnOgcReYfX41vNuVC0ecWXcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6271626-8697-47b1-ce1a-08da14355bf9
x-ms-traffictypediagnostic: MWHPR11MB1664:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1664C87494689B21C8E4935CDAE09@MWHPR11MB1664.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Z8Yf/BEIkc7/3fKWePm5KrpH9Ujn8r2ep1XSRWZF36hK2NV4cr0DOu1YjzFW4C3o/myAFkTuRY+F7LXKyEOr8aaaDNnM+T7iJTSwSjeZT9BsJGyQ+t9Fb7KGDIDATSLuZc6TWIalRHFV2kvAtrc2/janPYIR2I6BGTI8rETv8YT0QG1Xq8T0XmQnfeLBPU59KSF/EOW0ug0KJJznv+06ZKv1cgj7WYZm93m2pAMjHCg8O0H9371X3qzZD0plkaoqMFLqeg9TbwJv9RyYvFgJ0BYNM7rlfr7QUhDry4CmGprU/hoJUDEhS8iQKL0BBPq6/XpScrxtCiPqvrMVu7IV6hyoSYLpTbUdF3CVdOGxzyYF8kB+5DEtOCPfHj6Y6MR7/OIaV7nnGp3r2X7i7X96VXklv+q9YLCAd9dvpr5BLv8b9ILqB3oSpPZbVA5ukIOAFIC3EN1Q8V8b/GH/7bxHARbKnC21goeoFmnaUvgcytMxWbAkZTmC44cEQzD1a0mVjJLDaUFWNeQ+/ndOEFrfgPsayl2r5i8ON8HL7r+KgrAutmg/DXdNzAKt9kEsve7Rcgm9wyBjyhmyClraL3fQzJ6mjzW86VoXZMAfQjrH3SeJeA787qgAhGm8qsQsG33WWY7Rux1uqwUQ5WkQVhWE+BaZPuDCp9iyoFKBSOaFiHMFGi0E6Eh+miJ9/FT3FfminaNyPZiGRj9rUb5MpBGqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(9686003)(7696005)(26005)(54906003)(6506007)(508600001)(55016003)(38070700005)(186003)(82960400001)(71200400001)(38100700002)(316002)(6916009)(83380400001)(122000001)(2906002)(8936002)(64756008)(66446008)(66556008)(66946007)(8676002)(33656002)(76116006)(5660300002)(52536014)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2tDNEk0aVJQUDBZM2Q3RUZnOGQ1QkdYbmxxNlNlSE03SmloM0liR0Q4T2sy?=
 =?utf-8?B?QnhUWVRLTmxLaktxNVUxeG9qek9MRnN1RlJ6VGtKTG4rN3RLVU9HdVBOTnRy?=
 =?utf-8?B?eStsenNIYzl1N0J1dWRoUzdKUFp3RmFFRUVYZ0oweG9oQ2Rub2ZCSUF6UFl5?=
 =?utf-8?B?QkMzUjV0L01qM3JsOWI1Z0dqT1JFSnBTL3BiK0FTbHY5d3d2QVE3ZURwZ2Nk?=
 =?utf-8?B?OFQ2ZHFwcUpYU2pDNk9yV1hoRFBtdnQwTGVwc3o0b1pWVnRBaGJOOURZOXJ0?=
 =?utf-8?B?TFlpeHAvM3g0Njd1WXBVT1JKNHhKQU5JdnFyRHowa3RWVjdneTF6VUNDRWlF?=
 =?utf-8?B?azd5UlNHL3d3MVpSOHRMcFplRURiMi9lbnc4WDR2S3o3VG9nd3c3SHZXazBh?=
 =?utf-8?B?SHFHKzFDcWE0OExpZldMK2VJa1BNa0J4R0t0UUtrb1hhaDVSb2dJQzM5cHRY?=
 =?utf-8?B?Ym1xRGc5OFBOR0R6U2lLTmk3T3JKeTM1eVYreHNFSHBrdWhna2t6MGh2dkZU?=
 =?utf-8?B?ZHFvazNRSU1MK3QrT3FFSVhqOWhWRW5LM3k4TnVuRCsvNkZTcXRCRnFWajVo?=
 =?utf-8?B?bVI5OSt1Y3ZvcDJUUFI5SFZPbDZtTzkxOVFXOU01LzRha2tzdFA3emxsQ21V?=
 =?utf-8?B?REJRb2J1b2ZCQ1FsS1NOK2syMHBzRlArZEtXS2N1cUNnTkZSOVF5dGtUZTFN?=
 =?utf-8?B?RVlUaEpua1pIdklVQ2o4YmNHRUtXZi9jKzc1b2htNm5kUitaY0VRWmJLcCsv?=
 =?utf-8?B?cEdzNE5tcng1REtrUm1lazVncmQ1SDJRelRyNm1DbjRZMGkxaUE4dzZpZUFM?=
 =?utf-8?B?L2Mwang2U1U5QzRiYitpeWMzSWcvRVpIeW5KOXhGK0JWMmhhQW1NRjNEYWZm?=
 =?utf-8?B?UlR1L1E5MGVxRThVWEFGQjBtcXpsMU1ZeW9VZ2hOM3dEcGpwQkliNnZrOHVL?=
 =?utf-8?B?S3hlRWZ6ZldyZkg2c2R4TnhFTC9MdlVDcnZ5Vi8xRndwUTM4RDcxL1dXeG5q?=
 =?utf-8?B?TEFCTHVhNkEwZUZzVldQS1daVHFlSG5hUjk5TFRTSVpQSWVnb1h3dHhtZHAv?=
 =?utf-8?B?VlpSNHhQeVhWN1FWS3dHbWxPb0JSNVNyUXhvNkdTSTBDcnljcXk0ZHNzTitT?=
 =?utf-8?B?OForODZIOUdWdEdSZ1ZESDNDSDlpZTd2Mk42S00yeFpLZ3N3YkI0a29SbHU1?=
 =?utf-8?B?cEJNL3hhdlVjRmNSS2Y2ckd1YlExSFhLdDBBVjF1T1ZRL0ZqK1NkNnI3Z1lU?=
 =?utf-8?B?M2R4SGx6TklKcmNRc0J1Y1R6cHB3bVJ2Q1RocGRpWkFkaGd5bFNxb2FndGM2?=
 =?utf-8?B?WVd2QjZid05qcnYyNnR3aTFlb0xEVVo1dDJYTmluM2JXSmd0eUZ1SDNUZ1hq?=
 =?utf-8?B?bkx1MktrWDB2WWNWU3AvSTE5QVA2em50eFJiV2taT0t0dmJzcVRuQ2JzTEhx?=
 =?utf-8?B?NG9zeGRXNy8wMnZ0dHVJQ3VIRHlqMFd6WEVkOER3TDdNdy9pZWg3TWRRT09M?=
 =?utf-8?B?ZmUwbVgzZ3BzRkliTXZxSURzMC9PVUJDc3ZmSEdjQk1NVWN5NkRrc201OGpG?=
 =?utf-8?B?WjFieGRwS1kvR1BxRkhrQ0dIUUlQTDZKakN1VEpGK0hVTG1xZmJPdUg2eW5G?=
 =?utf-8?B?MGNPMzQzSWtSQ0JRalFTR0pCZ2lIS2lOUW1VM3lYK1VybkNqSE5KYlJURFBo?=
 =?utf-8?B?eTF4VWdCdHgrQ1hKUWxMc01ESnpiL3FQajI4cmM3ZmVOQ0tpNjdPSWRaeUZF?=
 =?utf-8?B?Z01rYnF5WnJ0SW56VWs5OWtBUlhqWXU5ajR4UGVoa0EweWtjRXRLUWphZjlU?=
 =?utf-8?B?WnFvYnFPaW9YdUNDMUFVKzhtdlY2U3hmSmZ4YXowODBCMkNnYnVPU1dxRGFD?=
 =?utf-8?B?ZU52QkdhLzk1QWZpemIrMlUyWUlTektkTzducXE3Ti82SW9aOVdqbHBsVVBH?=
 =?utf-8?B?NlA0ZkZZNGQzdWc1MmhLTEtSZExoc2JackZFWHJLcG83ZGwyNHhPY294UFQ2?=
 =?utf-8?B?ZVpNZ0FlKzdYTmdONUhqOExDTmxNVUlnUVlOWlZEbWg0cENrSXRXRUNGNDJ6?=
 =?utf-8?B?bGM5ZmxjN2FjOUNZMWp6b1BuZFNJeDhxWnlRamxrVDh1OEt2N29wajQvUkY1?=
 =?utf-8?B?UDZpbDFCV21zTVdwZHJnNys5MmNXWXBGcS9GZFVxY0Rrc29TOGlEUlFxc0Vv?=
 =?utf-8?B?K2hwRmJycU1oVWZ0SkVDcHlPWnBEMmc2dVV0NmtiemNCa2ovUUpiQ1ZVMExJ?=
 =?utf-8?B?Um0zbmtmZU95M1ZQc3hlNk9DT3c5VGVkelNYUitZQ3hoVDlBZjVCY2cyRXVs?=
 =?utf-8?B?RXZEejhRODczS0pUWEJxNi9EMFNYY2U2T3ZQbmVYYWUyUWJwNEY0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6271626-8697-47b1-ce1a-08da14355bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 23:14:23.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4My9nPf+j1GFBmmef11qjngTVxAI7f2fkVjKIemzrZPzo57N7UPudSkvbpASdkW84+itmVFx3pOW2WCf+RxuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogT24gRnJpLCAxIEFwciAyMDIyIGF0IDE1OjQ2LCBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRl
bC5jb20+IHdyb3RlOg0KPg0KPiBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGlu
dmFsaWQgY29udGV4dCBhdCANCj4ga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfcnQuYzo0Ng0KPiBp
bl9hdG9taWMoKTogMSwgaXJxc19kaXNhYmxlZCgpOiAxLCBub25fYmxvY2s6IDAsIHBpZDogMSwg
bmFtZTogDQo+IHN3YXBwZXIvMA0KPiBwcmVlbXB0X2NvdW50OiAxLCBleHBlY3RlZDogMA0KPiAu
Li4uLi4uLi4uLg0KPiBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA1
LjE3LjEtcnQxNi15b2N0by1wcmVlbXB0LXJ0IA0KPiAjMjIgSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgDQo+IHJlbC0xLjE1LjAtMC1nMmRk
NGI5YjNmODQwLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQgQ2FsbCBUcmFjZToNCj4gPFRB
U0s+DQo+IGR1bXBfc3RhY2tfbHZsKzB4NjAvMHg4Yw0KPiBkdW1wX3N0YWNrKzB4MTAvMHgxMg0K
PiAgX19taWdodF9yZXNjaGVkLmNvbGQrMHgxM2IvMHgxNzMNCj4gcnRfc3Bpbl9sb2NrKzB4NWIv
MHhmMA0KPiAgX19fY2FjaGVfZnJlZSsweGE1LzB4MTgwDQo+IHFsaXN0X2ZyZWVfYWxsKzB4N2Ev
MHgxNjANCj4gcGVyX2NwdV9yZW1vdmVfY2FjaGUrMHg1Zi8weDcwDQo+IHNtcF9jYWxsX2Z1bmN0
aW9uX21hbnlfY29uZCsweDRjNC8weDRmMA0KPiBvbl9lYWNoX2NwdV9jb25kX21hc2srMHg0OS8w
eGMwDQo+IGthc2FuX3F1YXJhbnRpbmVfcmVtb3ZlX2NhY2hlKzB4NTQvMHhmMA0KPiBrYXNhbl9j
YWNoZV9zaHJpbmsrMHg5LzB4MTANCj4ga21lbV9jYWNoZV9zaHJpbmsrMHgxMy8weDIwDQo+IGFj
cGlfb3NfcHVyZ2VfY2FjaGUrMHhlLzB4MjANCj4gYWNwaV9wdXJnZV9jYWNoZWRfb2JqZWN0cysw
eDIxLzB4NmQNCj4gYWNwaV9pbml0aWFsaXplX29iamVjdHMrMHgxNS8weDNiDQo+IGFjcGlfaW5p
dCsweDEzMC8weDViYQ0KPiBkb19vbmVfaW5pdGNhbGwrMHhlNS8weDViMA0KPiBrZXJuZWxfaW5p
dF9mcmVlYWJsZSsweDM0Zi8weDNhZA0KPiBrZXJuZWxfaW5pdCsweDFlLzB4MTQwDQo+IHJldF9m
cm9tX2ZvcmsrMHgyMi8weDMwDQo+DQo+IFdoZW4gdGhlIGttZW1fY2FjaGVfc2hyaW5rKCkgYmUg
Y2FsbGVkLCB0aGUgSVBJIHdhcyB0cmlnZ2VyZWQsIHRoZQ0KPiBfX19jYWNoZV9mcmVlKCkgaXMg
Y2FsbGVkIGluIElQSSBpbnRlcnJ1cHQgY29udGV4dCwgdGhlIGxvY2FsLWxvY2sgb3IgDQo+IHNw
aW4tbG9jayB3aWxsIGJlIGFjcXVpcmVkLiBvbiBQUkVFTVBUX1JUIGtlcm5lbCwgdGhlc2UgbG9j
ayBpcyANCj4gcmVwbGFjZWQgd2l0aCBzbGVlcGJhbGUgcnQtc3BpbmxvY2ssIHNvIHRoZSBhYm92
ZSBwcm9ibGVtIGlzIHRyaWdnZXJlZC4NCj4gZml4IGl0IGJ5IG1vdmUgdGhlIHFsaXN0X2ZyZWVf
YWxsZnJvbSgpIHRoZSBJUEkgaW50ZXJydXB0IGNvbnRleHQgdG8gDQo+IHRoZSB0YXNrIGNvbnRl
eHQgd2hlbiBQUkVFTVBUX1JUIGlzIGVuYWJsZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFu
ZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gLS0tDQo+ICB2MS0+djI6DQo+ICBBZGQgcmF3
X3NwaW5sb2NrIHByb3RlY3QgcGVyLWNwdSBzaHJpbmsgcWxpc3QuDQo+DQo+ICBtbS9rYXNhbi9x
dWFyYW50aW5lLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL21tL2thc2FuL3F1YXJhbnRpbmUuYyBiL21tL2thc2FuL3F1YXJhbnRp
bmUuYyBpbmRleCANCj4gMDgyOTFlZDMzZTkzLi4wZTMzZDMwYWJiOGQgMTAwNjQ0DQo+IC0tLSBh
L21tL2thc2FuL3F1YXJhbnRpbmUuYw0KPiArKysgYi9tbS9rYXNhbi9xdWFyYW50aW5lLmMNCj4g
QEAgLTk5LDYgKzk5LDE3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHF1YXJhbnRpbmVfc2l6ZTsg
IHN0YXRpYyANCj4gREVGSU5FX1JBV19TUElOTE9DSyhxdWFyYW50aW5lX2xvY2spOw0KPiAgREVG
SU5FX1NUQVRJQ19TUkNVKHJlbW92ZV9jYWNoZV9zcmN1KTsNCj4NCj4gKyNpZmRlZiBDT05GSUdf
UFJFRU1QVF9SVA0KPiArc3RydWN0IGNwdV9zaHJpbmtfcWxpc3Qgew0KPiArICAgICAgIHJhd19z
cGlubG9ja190IGxvY2s7DQo+ICsgICAgICAgc3RydWN0IHFsaXN0X2hlYWQgcWxpc3Q7DQo+ICt9
Ow0KPiArDQo+ICtzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGNwdV9zaHJpbmtfcWxpc3Qs
IHNocmlua19xbGlzdCkgPSB7DQo+ICsgICAgICAgLmxvY2sgPSBfX1JBV19TUElOX0xPQ0tfVU5M
T0NLRUQoc2hyaW5rX3FsaXN0LmxvY2spLA0KPiArfTsNCj4gKyNlbmRpZg0KPiArDQo+ICAvKiBN
YXhpbXVtIHNpemUgb2YgdGhlIGdsb2JhbCBxdWV1ZS4gKi8gIHN0YXRpYyB1bnNpZ25lZCBsb25n
IA0KPiBxdWFyYW50aW5lX21heF9zaXplOw0KPg0KPiBAQCAtMzExLDEyICszMjIsMjMgQEAgc3Rh
dGljIHZvaWQgcWxpc3RfbW92ZV9jYWNoZShzdHJ1Y3QgcWxpc3RfaGVhZCANCj4gKmZyb20sICBz
dGF0aWMgdm9pZCBwZXJfY3B1X3JlbW92ZV9jYWNoZSh2b2lkICphcmcpICB7DQo+ICAgICAgICAg
c3RydWN0IGttZW1fY2FjaGUgKmNhY2hlID0gYXJnOw0KPiAtICAgICAgIHN0cnVjdCBxbGlzdF9o
ZWFkIHRvX2ZyZWUgPSBRTElTVF9JTklUOw0KPiAgICAgICAgIHN0cnVjdCBxbGlzdF9oZWFkICpx
Ow0KPiAtDQo+ICsjaWZuZGVmIENPTkZJR19QUkVFTVBUX1JUDQo+ICsgICAgICAgc3RydWN0IHFs
aXN0X2hlYWQgdG9fZnJlZSA9IFFMSVNUX0lOSVQ7ICNlbHNlDQo+ICsgICAgICAgdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gKyAgICAgICBzdHJ1Y3QgY3B1X3Nocmlua19xbGlzdCAqc3E7DQo+ICsj
ZW5kaWYNCj4gICAgICAgICBxID0gdGhpc19jcHVfcHRyKCZjcHVfcXVhcmFudGluZSk7DQo+ICsj
aWZuZGVmIENPTkZJR19QUkVFTVBUX1JUDQo+ICAgICAgICAgcWxpc3RfbW92ZV9jYWNoZShxLCAm
dG9fZnJlZSwgY2FjaGUpOw0KPiAgICAgICAgIHFsaXN0X2ZyZWVfYWxsKCZ0b19mcmVlLCBjYWNo
ZSk7DQo+ICsjZWxzZQ0KPiArICAgICAgIHNxID0gdGhpc19jcHVfcHRyKCZzaHJpbmtfcWxpc3Qp
Ow0KPiArICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmc3EtPmxvY2ssIGZsYWdzKTsNCj4g
KyAgICAgICBxbGlzdF9tb3ZlX2NhY2hlKHEsICZzcS0+cWxpc3QsIGNhY2hlKTsNCj4gKyAgICAg
ICByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc3EtPmxvY2ssIGZsYWdzKTsgI2VuZGlmDQo+
ICB9DQo+DQo+ICAvKiBGcmVlIGFsbCBxdWFyYW50aW5lZCBvYmplY3RzIGJlbG9uZ2luZyB0byBj
YWNoZS4gKi8gQEAgLTMyNCw2IA0KPiArMzQ2LDEwIEBAIHZvaWQga2FzYW5fcXVhcmFudGluZV9y
ZW1vdmVfY2FjaGUoc3RydWN0IGttZW1fY2FjaGUgDQo+ICpjYWNoZSkgIHsNCj4gICAgICAgICB1
bnNpZ25lZCBsb25nIGZsYWdzLCBpOw0KPiAgICAgICAgIHN0cnVjdCBxbGlzdF9oZWFkIHRvX2Zy
ZWUgPSBRTElTVF9JTklUOw0KPiArI2lmZGVmIENPTkZJR19QUkVFTVBUX1JUDQo+ICsgICAgICAg
aW50IGNwdTsNCj4gKyAgICAgICBzdHJ1Y3QgY3B1X3Nocmlua19xbGlzdCAqc3E7DQo+ICsjZW5k
aWYNCj4NCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIE11c3QgYmUgY2FyZWZ1bCB0byBub3Qg
bWlzcyBhbnkgb2JqZWN0cyB0aGF0IGFyZSBiZWluZyANCj4gbW92ZWQgZnJvbSBAQCAtMzM0LDYg
KzM2MCwxNiBAQCB2b2lkIGthc2FuX3F1YXJhbnRpbmVfcmVtb3ZlX2NhY2hlKHN0cnVjdCBrbWVt
X2NhY2hlICpjYWNoZSkNCj4gICAgICAgICAgKi8NCj4gICAgICAgICBvbl9lYWNoX2NwdShwZXJf
Y3B1X3JlbW92ZV9jYWNoZSwgY2FjaGUsIDEpOw0KPg0KPiArI2lmZGVmIENPTkZJR19QUkVFTVBU
X1JUDQo+ICsgICAgICAgZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsNCj4gKyAgICAgICAgICAg
ICAgIHNxID0gcGVyX2NwdV9wdHIoJnNocmlua19xbGlzdCwgY3B1KTsNCj4gKyAgICAgICAgICAg
ICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmc3EtPmxvY2ssIGZsYWdzKTsNCj4gKyAgICAgICAg
ICAgICAgIHFsaXN0X21vdmVfY2FjaGUoJnNxLT5xbGlzdCwgJnRvX2ZyZWUsIGNhY2hlKTsNCj4g
KyAgICAgICAgICAgICAgIHJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZzcS0+bG9jaywgZmxh
Z3MpOw0KPiArICAgICAgIH0NCj4gKyAgICAgICBxbGlzdF9mcmVlX2FsbCgmdG9fZnJlZSwgY2Fj
aGUpOw0KDQo+DQo+SSB0aGluayBub3cgdGhlcmUgaXMgYW5vdGhlciBzdWJ0bGUgYnVnLg0KPkkg
YXNzdW1lIHRoYXQgYnkgdGhlIHRpbWUga2FzYW5fcXVhcmFudGluZV9yZW1vdmVfY2FjaGUoY2Fj
aGUpIHJldHVybnMgYWxsIG9iamVjdHMgYmVsb25naW5nIHRvIHRoZSBjYWNoZSBtdXN0IGJlIGZy
ZWVkLiBJIHRoaW5rIHRoZXJlIGFyZSBzY2VuYXJpb3Mgd2hlcmUgaXQncyBub3QgdGhlIGNhc2Uu
DQo+Q29uc2lkZXIgdGhlcmUgaXMgdGhyZWFkIDEgdGhhdCBjYWxscyBrYXNhbl9xdWFyYW50aW5l
X3JlbW92ZV9jYWNoZShBKSBhbmQgdGhyZWFkIDIgdGhhdCBjYWxscyBrYXNhbl9xdWFyYW50aW5l
X3JlbW92ZV9jYWNoZShCKS4NCj5Db25zaWRlciB0aGF0IGthc2FuX3F1YXJhbnRpbmVfcmVtb3Zl
X2NhY2hlIGNhbGxiYWNrcyBmb3IgYm90aCBBIGFuZCBCIGhhcyBmaW5pc2hlZCBhbmQgc2hyaW5r
X3FsaXN0IGNvbnRhaW5zIGFsbCBvYmplY3RzIHRoYXQgYmVsb25nIHRvIGNhY2hlcyBBIGFuZCBC
Lg0KPk5vdyB0aHJlYWQgMSBleGVjdXRlcyBmb3JfZWFjaF9vbmxpbmVfY3B1IHBhcnQgYW5kIGNv
bGxlY3RzIGFsbCBvYmplY3RzIGludG8gdGhlIGxvY2FsIHRvX2ZyZWUgbGlzdC4NCg0KQWNjb3Jk
aW5nIHRvIG15IHVuZGVyc3RhbmRpbmcNClRocmVhZCAxIG9ubHkgY29sbGVjdHMgb2JqZWN0cyB3
aGljaCBiZWxvbmcgdG8gY2FjaGVzIEEgLCBiZWNhdXNlIHRoZSBxbGlzdF9tb3ZlX2NhY2hlKCZz
cS0+cWxpc3QsICZ0b19mcmVlLCBjYWNoZSkNCldpbGwgZmlsdGVyZWQgYWdhaW4sICBvciBkaWQg
SSBtaXNzIHNvbWV0aGluZz8NCg0KVGhhbmtzDQpacWlhbmcNCg0KPk5vdyB0aHJlYWQgMiBleGVj
dXRlcyB0aGUgZm9yX2VhY2hfb25saW5lX2NwdSwgY2FsbHMgcWxpc3RfZnJlZV9hbGwgKG9uIGFu
IGVtcHR5IGxpc3QpIGFuZCByZXR1cm5zIGZyb20ga2FzYW5fcXVhcmFudGluZV9yZW1vdmVfY2Fj
aGUuDQo+VGhlbiBjYWNoZSBCIGlzIGNvbXBsZXRlbHkgZGVzdHJveWVkIGFuZCBmcmVlZC4NCj5O
b3cgdGhyZWFkIDEgcmVzdW1lcyBhbmQgY2FsbHMgcWxpc3RfZnJlZV9hbGwgZm9yIG9iamVjdHMg
ZnJvbSBjYWNoZSBCLg0KPkJhbmchDQoNCg0KDQoNCj4gKyNlbmRpZg0KPiArDQo+ICAgICAgICAg
cmF3X3NwaW5fbG9ja19pcnFzYXZlKCZxdWFyYW50aW5lX2xvY2ssIGZsYWdzKTsNCj4gICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgUVVBUkFOVElORV9CQVRDSEVTOyBpKyspIHsNCj4gICAgICAgICAg
ICAgICAgIGlmIChxbGlzdF9lbXB0eSgmZ2xvYmFsX3F1YXJhbnRpbmVbaV0pKQ0KPiAtLQ0KPiAy
LjI1LjENCj4NCg==
