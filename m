Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602654CEF4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiCGCES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiCGCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:04:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607140E5A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646618601; x=1678154601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M+vZLYdPmKJSXJU6eGEVtTNXMRluqMstsoZAWyGN0Ow=;
  b=P5NgzQUbirdITRH9d/Mlnwn1yH3oFvAs8BFS5ewyIw/WdKf+Oh1f0uOo
   7gZb1OELggMnd+yKzaGlttcLnHBxfKOLce0JgKzzGQt/SfmBZtRgwXz9I
   jyZuJNN6fxI33paYauoyliq+pmq8fqKFGEQhCLWLOXlrY7vtIayf+I1rR
   6zA9maeDW/rRr4oW/lzxWabgQ7PpBCH0KE2jziC2VlLItoLn7NNg83c0T
   4cHHBZLqiswvi380gXW1j/3yNYhEwPCiNiNt7fjg17/PyUVYLSHWjqpq2
   ee3mIK27NLTe6fZvCzd4QLvV8gnTul5FIvT+tPuqfz9KTGe5NivZ+S2bD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="317512651"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="317512651"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="577434988"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 06 Mar 2022 18:03:20 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:03:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 6 Mar 2022 18:03:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sun, 6 Mar 2022 18:03:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKF4jg+M6mJOsHL/lWEdJkPfWeZy6sQbAXZ+MR8xkU5k6WTDvs2KdO0Gz61xtuPEJwrZdRytWbfiUcJIPF3rp5xiwKcJvI+UJNZo3TcoZPg0aXyBbuJjwqEKGKeLuFgxbP+0qGxzxDsUtCuKywkPHO7/Dq+23MgP7tOeY7Cigyw8+j7xGg6SBSeju/PsfSiG56YomAD44MyKJNvnhfiknQq8vBR4L4dy8/OU9fRROk9EJrbpP5L8wyoesSartvLOOhD3UyM9GVCIXCQW76HLgg6fCi5zH5azyulhE6iI2H9u+kP/V8kqdRF/u9FeiBIa7scVyMzNQXJl7fA4LHygoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+vZLYdPmKJSXJU6eGEVtTNXMRluqMstsoZAWyGN0Ow=;
 b=H5241xoaSEZ4nJ2UW4KBpCr9vc6SzvUfHdMRLES+ro6mrEQuzGCu3eGhDs9hA3hTFy2x5Sl9vMcNEnwmGfiX7FBXqdeHjC6h/wmovySJimDPIuZDkFPXDIEaRVRVLb1B/UKXr+Gf8P5hmOmjLVXdoEp2rRAOzKja8eA3KJf/9A4gE13Cr6ldiTAURgEPyjpGCwd5ZfovQ1PKSCx9C1z4/3cptile9T2dxJjSFP8ZAEjaokFyEYGYXm2J/vGF6pMXBZEf5ncdJVgAliFaQOR8HNLKSCEReamGmD0eg+6zD2fe60Eocclo5cSr1u24Vx+LXCelkS7qYbMCbvr5vhIo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB2041.namprd11.prod.outlook.com (2603:10b6:3:d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Mon, 7 Mar 2022 02:03:17 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%8]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 02:03:17 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Only boost rcu reader tasks with lower priority than
 boost kthreads
Thread-Topic: [PATCH] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Index: AQHYL6nedKu+SJDFEUmZSHHikE8cTayvGo8AgAQNpZA=
Date:   Mon, 7 Mar 2022 02:03:17 +0000
Message-ID: <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
 <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
In-Reply-To: <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
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
x-ms-office365-filtering-correlation-id: de96629a-00aa-4638-4ca2-08d9ffdea5c1
x-ms-traffictypediagnostic: DM5PR11MB2041:EE_
x-microsoft-antispam-prvs: <DM5PR11MB204194908765703EDF44D573DA089@DM5PR11MB2041.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJMOwhccM+6lmr87zVy3D89zoEoUSujTh2qALAVgvkfAfJZDzKnW6DqTAOEDw5wbE56vf5YiYXcReCHw2G7Gfa5353ggoj/VCNV1YYJMcXmxQj2Mgr8YVtjJFYL6Jfgx6VpVzkLqBbh/X/zqoZO1yOkLm1OELgyWuNkoYkHsTCa7BICxIzIovg8BXxYBpdm/vcoAsrNi1gnsnTI6FR4gZ20HN3ANRHKBksIH2JyBSh0luNAAjP5xjQRfbJ/beeZOuDQ2QYhmq0CTPPdWY1pwbUU4zW0Upbk8FmtEwSTBi5zA/04doJbAoEziNqc/7vXpf7GBQOL/hiUwqYutiSRk47N3zplYtQ7YeUZiqHsoY1WsKnmkeYsyVeXsAtiQBY+0CZrmFO+D76T2vRIqAvbugMUvkNYn778adY8fKGN6r5/Ocamt6du9PCaG0UvQRFAurNxVaQ9dJ0x1IpEQ8pUISZj6I+ox8bObEz/nMDSZMWYXbku5qzIRZu/c1pH2PWhGBsud/Ih0GZ0fViP06mkE3wsLNCid6kXlWwmQDbqfKXJujPmApIcpcRRIJwL35SK8GHADOO9ml6OuPVZN7m/C8w5d/9CYSqycrhwL/OyqjlwMAucxTqpTRtMLio1plydsdCqMrQA194VFMKts7Ui5VpRHeFoN1dPPIw/o6Tl5MTZVG/FRZ2VH/9AcVMrYUDuxhTjXGbuFbi8z72tkUegUcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(38100700002)(8936002)(33656002)(52536014)(4326008)(8676002)(66446008)(76116006)(66556008)(5660300002)(2906002)(66476007)(64756008)(83380400001)(86362001)(55016003)(66946007)(508600001)(316002)(9686003)(122000001)(6506007)(186003)(7696005)(26005)(38070700005)(110136005)(82960400001)(66574015)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXUzOWkyVjV4RXEvUHQwWlNBdUJxMlFHSGxLb1RMbXNQUXFFTjNLRERXN0Iw?=
 =?utf-8?B?bDVZUkpjWUtISUwrclRzb1FKYzQzMUFvWTgzVld4UUlUTWJZSWFaeU9UQlZN?=
 =?utf-8?B?NCtVQVlrOXNsSDcxRTROMjdEZVVMb1hIYmlwU1dNVzBRSFR5TUM4anZqTmUy?=
 =?utf-8?B?NE9GWE1rNjNjeW5HUUlPYWhpSFZFeENwaU0vNm5lbml4Y2tpUzNkUlRqeHBm?=
 =?utf-8?B?QXdhQ3paU3BxbFFHSU0rTDBnRW5wdWRJK2lNeW5mTUlld3dpNWFDblZOVDBV?=
 =?utf-8?B?TURjc0NrQWRrOGdpSWhnK2VnM1dvNE4yVzYxNEdNaklITU1ka3llYlVSakR2?=
 =?utf-8?B?bVloUzYyMVZaR0FnZWhSYngxeDR1N0FxSWtZV3F1NTlLUWlOOFZYSS92S0Jk?=
 =?utf-8?B?YWpqamRRR2dxRm95dUFNM2hmN3cxRms5QkllNXZoZkhDR0l1ZUV3ZVFUem95?=
 =?utf-8?B?SklCTExaWlVBb0pYVkNZdjQ4QytTQU1lcXVYU3FReE4vQmhHQVZ5QStaVFpZ?=
 =?utf-8?B?M0RNUXJjTUZtTHB4YTFpd0JNTEVPTWFTcGsvRlRieGEwbjk1TGxUaXpDYklC?=
 =?utf-8?B?LzJiRzZHRXJ2ejRKcnNicG5tbDdqNWZYdDBSZkJZNWMyN0Y5SWV1clRCQzQy?=
 =?utf-8?B?TnRkR2g0KzRrNUNXbU4vZ3VVY2Y5RVRsRnA0anBmb2cxV2dxdy9SY2RoRzdp?=
 =?utf-8?B?SjlJZ2FrRVl3SXc3TkJXa1c0cE1YNFpJQUJreU91MHY2cTMyOW4ySU96NGcx?=
 =?utf-8?B?NjFkNlp5Y1NxR251Nlp2ekxVbUdyWVhBUG1NTUM0NUJmMmFTREN1aU5wYk0r?=
 =?utf-8?B?ZzIwRHR3bkFnVmJROEFta2xxVTl3TW1JVWJmaCt6TGoreUpHY0RvN1ZDR0I1?=
 =?utf-8?B?cW5IWDhiNllUVlRKZVFjV0NNeU51K2VkQ1BiaTMxVmhCNWZoUk5INHRsaUtL?=
 =?utf-8?B?SlByMTVXNXhIeUllM3Q3ZURHYXlpMCtwNndxM1JwSUhaY3hBSFJRN0VvNGNn?=
 =?utf-8?B?eTVBcHVWbjBVamhPS0Fhcmo3WU9nWC83RkdmRUZWN1JtazJzandPYUsvKzNQ?=
 =?utf-8?B?WWtQbExGZW4yNm9tSi9xMEhKMUpKamUrTU53cklDQ0pNSHhnZVRLdGdoaFM2?=
 =?utf-8?B?VEhIZzh3UlBNZDY2Qk81MzdVR0hrS2NzVzV0MmZzZXBwZ2d3NVVqRUZrWGJn?=
 =?utf-8?B?dS9hOHpqajNvVHNQKzFlaCt4c1F6YjM0eXJYZFRGZXdDVGlDTHlqWXpUWk5F?=
 =?utf-8?B?SkxSR0xrbVZubzRkV1BrbFIrNWVuTWlqMk9Za2tLaEVZRjhER3RRSVVycUU5?=
 =?utf-8?B?c3BubG8wWGtHY2dtaU9BS2RQMnZ1UzNhMDFpVGpvV1N1UEx3bjJnMk00ZDJV?=
 =?utf-8?B?YWJXR0F0dVZ1SW5kT2EwT1NpU1RUM0hSUndwc2lVd3RjWE5XcVQ3dVJjNjRy?=
 =?utf-8?B?NGNVS05wM3FTTm10Z0YzU3hvZUhoZzRGQ0J4MlB6cDQwbUI2RExHa0JGQnpD?=
 =?utf-8?B?UmZHZzJ6ZjVuTklKdWpjb2NuM2J4eWVSRngwRDE3VU1MWGpqYk1oSkdCUEEx?=
 =?utf-8?B?ekdTdUM2ejc3dXlucTRuRkZvQU5Sc0w5UnNXdXV2c3pNNDdvblhvZGV6WW9z?=
 =?utf-8?B?SjdPVER6MnUrZEsvbElVQVVBaHhzVlVrTzVNdUVTSzVmOTFDNzZHM0VJUmRP?=
 =?utf-8?B?RVhWQzNJemREbmFOT3h4eGluYWJLS3J6MkM5VzRIR0ExVGQvNnhjdXE0NXY0?=
 =?utf-8?B?Y1pvNlBNbUFHSXB5UXI0cmg5VlBwdWxFa1RTNmNaQnBEWXRKVFNlbFY0QmRt?=
 =?utf-8?B?RnZYcVl3MDJzWG16US94YVJqZTZMdjFTOGJlRGU4RGFDM2UrTGhRaWJHNE8r?=
 =?utf-8?B?WkV6V1Qyd0J5SmFVYS9IeE5Hdm5maDNiVGZuQ3RneGhyNGZ5V3phSE9nVkFN?=
 =?utf-8?B?Nnh6Mk5neUNodlk5SlhVS3VQRFoyVHNrMEMvMThoZWtNL1NZT1p2ckFDdEVR?=
 =?utf-8?B?ZWtub0VHL1g5eStRMG9sb29IQjBLWDRDL2ozeEZYWjhaVWNiL2wwVk9nZjdz?=
 =?utf-8?B?cExUQ0tuNUt3YTdtbStaRjg1YnRKcGgvaTZjUU5md2lybGJvOTNxU3d2ZjFX?=
 =?utf-8?B?MUluUUJ2TjdKY3Uza1Qrc282YWtQYVdvcEFsS3VzbGFqMEhocXd2ZmZIa0wv?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de96629a-00aa-4638-4ca2-08d9ffdea5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 02:03:17.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luRYHMDHSCDa2lhsHJYmxxWGwiuQtdleG4plsMZ/NArRTS+TZmcKgvc7g1hUjHSqKGYvDjoJZ+8LJ+CsWW2J4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIwMjIgMjo1NiBQTSwgWnFpYW5nIHdyb3RlOg0KPiBXaGVuIFJDVV9CT09TVCBpcyBl
bmFibGVkLCB0aGUgYm9vc3Qga3RocmVhZHMgd2lsbCBib29zdGluZyByZWFkZXJzDQo+IHdobyBh
cmUgYmxvY2tpbmcgYSBnaXZlbiBncmFjZSBwZXJpb2QsIGlmIHRoZSBjdXJyZW50IHJlYWRlciB0
YXNrcw0KPiBoYXZlIGEgaGlnaGVyIHByaW9yaXR5IHRoYW4gYm9vc3Qga3RocmVhZHModGhlIGJv
b3N0IGt0aHJlYWRzIHByaW9yaXR5DQo+IG5vdCBhbHdheXMgMSwgaWYgdGhlIGt0aHJlYWRfcHJp
byBpcyBzZXQpLCBib29zdGluZyBpcyB1c2VsZXNzLCBza2lwDQo+IGN1cnJlbnQgdGFzayBhbmQg
c2VsZWN0IG5leHQgdGFzayB0byBib29zdGluZywgcmVkdWNlIHRoZSB0aW1lIGZvciBhDQo+IGdp
dmVuIGdyYWNlIHBlcmlvZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpo
YW5nQGludGVsLmNvbT4NCj4gLS0tDQo+ICAga2VybmVsL3JjdS90cmVlX3BsdWdpbi5oIHwgMTAg
KysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmggYi9rZXJu
ZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gaW5kZXggYzNkMjEyYmM1MzM4Li5kMzViNmRhNjZiYmQg
MTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KPiArKysgYi9rZXJuZWwv
cmN1L3RyZWVfcGx1Z2luLmgNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICAgKi8NCj4gICANCj4g
ICAjaW5jbHVkZSAiLi4vbG9ja2luZy9ydG11dGV4X2NvbW1vbi5oIg0KPiArI2luY2x1ZGUgPGxp
bnV4L3NjaGVkL2RlYWRsaW5lLmg+DQo+ICAgDQo+ICAgc3RhdGljIGJvb2wgcmN1X3JkcF9pc19v
ZmZsb2FkZWQoc3RydWN0IHJjdV9kYXRhICpyZHApDQo+ICAgew0KPiBAQCAtMTA2NSwxMyArMTA2
NiwyMCBAQCBzdGF0aWMgaW50IHJjdV9ib29zdChzdHJ1Y3QgcmN1X25vZGUgKnJucCkNCj4gICAJ
ICogc2VjdGlvbi4NCj4gICAJICovDQo+ICAgCXQgPSBjb250YWluZXJfb2YodGIsIHN0cnVjdCB0
YXNrX3N0cnVjdCwgcmN1X25vZGVfZW50cnkpOw0KPiArCWlmICghcm5wLT5leHBfdGFza3MgJiYg
KGRsX3Rhc2sodCkgfHwgdC0+cHJpbyA8PSBjdXJyZW50LT5wcmlvKSkgew0KPiArCQl0YiA9IHJj
dV9uZXh0X25vZGVfZW50cnkodCwgcm5wKTsNCj4gKwkJV1JJVEVfT05DRShybnAtPmJvb3N0X3Rh
c2tzLCB0Yik7DQo+ICsJCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlX3JjdV9ub2RlKHJucCwg
ZmxhZ3MpOw0KPiArCQlnb3RvIGVuZDsNCj4gKwl9DQo+ICsNCj4gICAJcnRfbXV0ZXhfaW5pdF9w
cm94eV9sb2NrZWQoJnJucC0+Ym9vc3RfbXR4LnJ0bXV0ZXgsIHQpOw0KPiAgIAlyYXdfc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsNCj4gICAJLyogTG9jayBvbmx5
IGZvciBzaWRlIGVmZmVjdDogYm9vc3RzIHRhc2sgdCdzIHByaW9yaXR5LiAqLw0KPiAgIAlydF9t
dXRleF9sb2NrKCZybnAtPmJvb3N0X210eCk7DQo+ICAgCXJ0X211dGV4X3VubG9jaygmcm5wLT5i
b29zdF9tdHgpOyAgLyogVGhlbiBrZWVwIGxvY2tkZXAgaGFwcHkuICovDQo+ICAgCXJucC0+bl9i
b29zdHMrKzsNCj4gLQ0KPiArZW5kOg0KPj4NCj4+Tml0OiBtYXliZSByZW5hbWUgdGhlIGxhYmVs
IHRvICJza2lwX2Jvb3N0OiIgPw0KPj4NCj4+Q29kZSBsb29rcyBmaW5lOyBob3dldmVyLCBvdXQg
b2YgY3VyaW9zaXR5OyBnaXZlbiB0aGF0IHRoZSBoaWdoZXIgDQo+PnByaW9yaXR5IHRhc2tzLCBp
biBnZW5lcmFsLCB3b3VsZCBleGl0IHRoZWlyIHJlYWQgc2lkZSBjcml0aWNhbCBzZWN0aW9uDQo+
PnF1aWNrbHkgYW5kIGJvb3N0IHRoZSBuZXh0IGJsb2NraW5nIHJlYWRlciBvbiBleGl0aW5nIHRo
ZWlyIHJlYWQgc2lkZSANCj4+c2VjdGlvbjsgZG8geW91IHNlZSBub3RpY2VhYmxlIHJlZHVjdGlv
biBpbiBncmFjZSBwZXJpb2QgdGltaW5ncyB3aXRoIA0KPj50aGUgY2hhbmdlIGZvciBjZXJ0YWlu
IHR5cGUgb2Ygd29ya2xvYWRzPw0KDQpUaGFua3MgZm9yIGZlZWRiYWNrICwgIEluIHByZWVtcHQt
UlQgc3lzdGVtcywgdGhlcmUgd2lsbCBiZSBtYW55IHJlYWwtdGltZSB0aHJlYWRzIChtb3N0DQpv
ZiB0aGVtIGFyZSBjcmVhdGVkIGJ5IHVzZXJzIHRoZW1zZWx2ZXMgKSwgIHRoZWlyIHByaW9yaXR5
IGlzIGhpZ2hlciBvciBsb3dlciB0aGFuIGJvb3N0IGt0aHJlYWRzDQooa3RocmVhZF9wcmlvIGlz
IHNldCksICBmb3IgcnQgdGFza3MgIHdpdGggaGlnaGVyIHByaW9yaXR5IHRoYW4gYm9vc3Qga3Ro
cmVhZHMsIG1heWJlIGl0IHdpbGwgZXhpdA0KcmVhZCBzaWRlIGNyaXRpY2FsIHF1aWNrbHksICBt
YXliZSBub3QsIGlmIGl0IGlzIHByZWVtcHRlZCBieSBhIGhpZ2hlciBwcmlvcml0eSB0YXNrLCAg
SWYgdHJ5IHRvIGJvb3N0IG9wZXJhdGlvbiwgDQp0aGlzIGluY3JlYXNlcyB0aGUgYm9vc3RzIGt0
aHJlYWQgd2FpdGluZyB0aW1lLCBhcyBhIHJlc3VsdCwgdGhlIG5leHQgYmxrZCB0YXNrcyBjYW5u
b3QgYmUNCmJvb3N0ZWQgaW4gdGltZS4gIG9mIGNvdXJzZSwgSSBkb24ndCBkZW55IGl0LCAgdGhl
cmUgYXJlIGFsc28gcmVhc29ucyB0aGF0IHVzZXIgcHJpb3JpdHkgc2V0dGluZyBpcyBpbmFwcHJv
cHJpYXRlLg0KDQpUaGFua3MNClpxaWFuZw0KDQo+Pg0KPj4NCj4+VGhhbmtzDQo+Pk5lZXJhag0K
DQo+ICAgCXJldHVybiBSRUFEX09OQ0Uocm5wLT5leHBfdGFza3MpICE9IE5VTEwgfHwNCj4gICAJ
ICAgICAgIFJFQURfT05DRShybnAtPmJvb3N0X3Rhc2tzKSAhPSBOVUxMOw0KPiAgIH0NCg==
