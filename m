Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42015026B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351079AbiDOIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiDOIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:36:12 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120040.outbound.protection.outlook.com [40.107.12.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF52AC078;
        Fri, 15 Apr 2022 01:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/HBpHW2fkkjkkXMvWSibbYw/XY86RKlJmoKXAscSwERcSp+A9PNe7EDIUj/ZDGoshIUXk2FtYE9ROg9r0ggQiZHclRpTbfU6RVZXcQFjb4Y6VhEZIXB+nDSVKhgqjHObg+/FjMJx4r1qey+9nTNtBRf9APUJ80UvcT/btbsbQDkHPvd5Pake5LJvJhx39VKBs0razyGI6V5mSy5khoLzrQ9QlbfVaPLncLJ9/wRBOvSH4g3vt3JlfiVsf18pVc/7C8SeV7i1YmMP/Wza2jOltQFe4/glUEe2lOwupH++TVOD78UGpi/MFJnBKc9b4amhtHXwcXl3XPugzbUXtfkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXgu3GIW1/nKYV87zFmbft+M4TxMAemA2yRxtl9lcoo=;
 b=HVoLIwwR2yuq6bgAY0z0zJPrhKxxbTeenHzy214NS6NGZCr7QjNeYyroZh1G3XFRKfm8f4D6ch542RlWhdSi9STuzY1u5fwl5bN+zQeL26qURuWKzDK5bnherbMwTkDXArMp1CN4YCFC4N/MHUxyM4lOBj1/kWwUBkGA9dOx0VzdDJsyUQxnqmyhoZEX2nw/bz+zmSSe2Z2Vxl3YTSaaeXWXamZfNNSpDj6XrA05A/Sx2sRikq2l2OguzYyNsuBQw/N0NPOpYVTAj58vm46Rin3A4FtzfEQu0ZbqW9r4PKpjEh6VplIREiJb/DdycqO85haMkhzNPgk7mWV66ySX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2948.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 08:33:40 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 08:33:40 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: Prepare cleanup of powerpc's asm/prom.h
Thread-Topic: [PATCH] usb: Prepare cleanup of powerpc's asm/prom.h
Thread-Index: AQHYRntxUFmUlVBigkW649y4naKn+6zd4s+AgBLXPgA=
Date:   Fri, 15 Apr 2022 08:33:40 +0000
Message-ID: <0de4f957-d86c-cc86-2d11-f9b4b4ae3808@csgroup.eu>
References: <d9193539d7d079d70fc3480afb1b413f4694ddd1.1648833420.git.christophe.leroy@csgroup.eu>
 <86bf7aa0-cfcd-33f3-30c5-a944883325b3@omp.ru>
In-Reply-To: <86bf7aa0-cfcd-33f3-30c5-a944883325b3@omp.ru>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ef96bdb-895c-48fb-782b-08da1ebaa4e4
x-ms-traffictypediagnostic: MR1P264MB2948:EE_
x-microsoft-antispam-prvs: <MR1P264MB294841E060970C620D2B72DFEDEE9@MR1P264MB2948.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8at3Gg/NwINAAuh7tHh9BnGz/GogpkdQyGpxiWioeXe4HFzryNP4ZEQeZGa2XDAG+fmCBL9xaahE1j0KK8sgAHwt7PKr1WD24Edfc2uGbqHa4xx8wmyzcpR8gs8IPExZhlQ9aOzAdtesibbKl33JTizGO84gdfJZv2WVTPm6WlYFWLk4D6M5o5NWY1xHjREYGJTnqh+VggY9z2+qK4310Ujcz2cqvf2EAATWCXkEIYtDjHJNXnUP7LFcPE96sRnxMq/LbMnDPqAwYoWlP38M9p4yCZKJBTFkPzIjaTL+UmlI4Evc2DmF7zIGrzjp14RtO4xB4B/mS1EQLnqGOZU6wHwf8WsBS+gC0B0DLd72HU1lmhuZmG8dFBhmt8XYp9JnXeOhh41w5Z2kmyP3dWSMcsi3qz2XVaRqF75QEy8FU57Lns/9qeAtYUIyYWaHHiWPDpfGswOlCYJSsGS+jVyQ1UTX7dUsljyb+MFprfZhKKj/AXFLBmFZdalDQm3IoC8iYPK0EB0n5t4nbkRCNzpolpHuKTZYJeV+HfWM2w5iJ/6ytabDshcVXlrMkvOjNuwhilaycUISocVcSGRFbRi9Yh4STwE0qa+EbHFSe9n/Z9eefdUI6iZvbF0vZsLpNxRWtB7H5l6hdD3d0RdVE1mmqrjzH1bfFAMDBucf0y5UovQcWB+o+MjhjsbOS2K8xQwOM2LW/See3paj8bTpYFcGD8v0/XjvDPo894tbGbvUixHElsdNFvccaSTrVl+aWbBQZiRKQ7hueb0POzRwEwZLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(122000001)(8676002)(66946007)(83380400001)(31696002)(66556008)(76116006)(66476007)(66446008)(38100700002)(54906003)(36756003)(110136005)(53546011)(6512007)(2616005)(186003)(31686004)(71200400001)(6506007)(86362001)(91956017)(4326008)(26005)(38070700005)(64756008)(508600001)(316002)(6486002)(66574015)(8936002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUhYVlFCVzVGWlUzVDdQSjdKNHBGMk92SEVlMmEvY25FTGo5OFlyRmN6b0Q1?=
 =?utf-8?B?QWJuWEFqQjZDK2dMeDlZTktzdUUwRUtNY05XUkdDeUZHWmoybS9mWVB2TVZz?=
 =?utf-8?B?MHIyOVA1MVlWMmk2Z2cxdzcra1I2aW5uNXN1eTBpWWxKR0tSRkV6R0Rudndo?=
 =?utf-8?B?b2VjUm9Bb0NhQk5Md2dzb3RQTXZ1eCs3a3VvR3VTbzZ2UVcxSmxBaDBUVEdX?=
 =?utf-8?B?d3pSYlFiZjVyQ1kyQ0RWOGtjcUV3Y2ErV1R4cC83Y0doQUVoS2xTMkUrMWhC?=
 =?utf-8?B?QW9CMlhRa3ppK05LeVI5dlRuMHFJcDJ4ZEFqSEFIaTVxbVVwVklmRlp6bUNF?=
 =?utf-8?B?VWFlUXJydzhSejR0cUpVNEN2MTd1bFNGamZFQ3Q2RHpZRUZwRkoxTDZTb2la?=
 =?utf-8?B?cjNhSXJhbXBSV2pGU1lWQzROOWxTVitkWlN6eXNlM01ZNFJkeHMyaTlsUGNH?=
 =?utf-8?B?YzMrK3Q0RTlxd2dWNUpYZGdGVFVBU1FKYXBBeDBUaXE1MHVzVXI2RTdXaklP?=
 =?utf-8?B?RUhMMzd3TnVwREI0bmpjSEZ0eXNZNHVCV252ZXF6OHZ0K213WFEvS3ptdjBm?=
 =?utf-8?B?Znh2WEdFWE9RdzJlVTQyU1U0VFlxL2ZFdkxNZmVtQW9URHVYYUN3c1VkMFJo?=
 =?utf-8?B?MkVXWW1kVk92Vm9kK3ZGZURuU3IvY0JtSkQ1MG9aRms0WEdXVWo0ZDhHNzY3?=
 =?utf-8?B?OXp6WFF6bmw1ZTFMekc4dnk5VUxzaHM1RU0ybGRrMW9oTWltNTkxSFZJVkEv?=
 =?utf-8?B?QWtKMkNYN3FKSGc5L2RDS3BFWHRPTkpTVlloaEp0M1FUbHBYQ282cXBjSVQv?=
 =?utf-8?B?dEo0L3Z5RW85UEhQTFh2MlcwRjcwdTdTTDUwTnJMaEtZRXFxdzZINUZITU5q?=
 =?utf-8?B?NkNQa1laamVjaUJUVWdma1FLdlE1SXB1M1YwS1JoVmlkTFlYbkdBNUUyWTV6?=
 =?utf-8?B?VnNDblhMWnJ1NVF5U2lVTVNBbFFKRHUxMmxvN0dQSWNQbThkOHpSbzRseEdx?=
 =?utf-8?B?WkY5cy93T0Y0Y1Nlei9pUm9LWjRUcVlFQTl3YkIvbFVEc0pUVGNLQkRtaWpZ?=
 =?utf-8?B?VHJpQWlrUU4xZGVmWnpjeFQ0SUFpNWdjOGpKWTBhZ1JJVkdrWllCeXd1WTZ3?=
 =?utf-8?B?VkVDS290cFV3b0EzOGMwa3BCNkl6aEVZTytnQWY3MDVmWEY2alNOOUZUSUN0?=
 =?utf-8?B?UHlNVGw4Ym55T1lVbW1LTmlpWEN0RlAzQWZONEt4UkllR1BVUzlaUHNGWVBB?=
 =?utf-8?B?bG55NGN6RVIzbnlYendiZFJFQ21uMzZjQ2hJbkl6U1YxUlNYQU8rZUk1TGFS?=
 =?utf-8?B?Tk9Ob0Z5L2lwMkp2Z2VQSEp5WTJ2YlU1aFhvMnVJYW1zSnJjWkQ0SXg4bDdM?=
 =?utf-8?B?bzZZWk40c2NiYmE3TVpzdUJPMVo4M2xoLzY2SmFDTXg3c3JaMWFnRm5RWWZa?=
 =?utf-8?B?WjY1ekR4MldMbFFUOWNQNTJVWkw0eGd1UlhwUjdVMFhBVGU0S1dLS2JoNDcz?=
 =?utf-8?B?OWRzTnJmbDhmanNNOTFaTzhDeDg2ZXVJYWF0VGtBQm1oREhxU1VSMTZSMk5Q?=
 =?utf-8?B?NDBDN29uVzNDZkdqalpKMHF6NVFUSXlGaUJqclVkUTBaNUlFRU1yUlJGL0t4?=
 =?utf-8?B?MmVWQlNQN1lDZGN2ZGdLY3hOWUs3RTBWY0syd2pRelppVHJjUWF6MS8waVRm?=
 =?utf-8?B?ekVOYmcxS2FXKyt5SThNbVZDalM3S3owMk0rVjZ3NHNPNkRmdFNsdGQrMzM3?=
 =?utf-8?B?am11bkppWFJFSU03QVRlUHFhZStEc2pZMXQ0bW9nNDFvTS91dHZXdjFpcUsy?=
 =?utf-8?B?SXRUWTJKdk1GTDdqNzlQYVFIRTdxVkdReFhvZFBIRWVVZEV0aFNvMDMvUzBQ?=
 =?utf-8?B?K1BhUEVndVFCK3gzYzBGREpjSk5CV0NYTytJSlk1cmdwSWlrWHNNV0oyMWQv?=
 =?utf-8?B?STdoalhMYzBOang2UW9URDlxeE40S09DY1IrMEFyMEpDM1hmZWNnamVHYzN4?=
 =?utf-8?B?bTIwRTkrS3QwWktPOStXZjkzYXZrS3pwcUIzVVZzZDFwTDRCUm5kYmdMakN4?=
 =?utf-8?B?bndXNEpPVjkxZGV5L1V5Nm5ING5id1cySGpFY1FaMkJHd2RBTjlQajU2OEI1?=
 =?utf-8?B?TDFUUmY3ekF0QlFwUlpscTVnRFNJdnJERUpON1hMYnRhMGN0Qi9uMG9haDYv?=
 =?utf-8?B?d0cyMnc0eXc3eERtNmd6RFRMcGR5anlOQ3BvQk1OWHlQRndmYUFmazZaaFd3?=
 =?utf-8?B?TDNrTDQvYnV5S2xiK0JqNHg2MFlPdDkyOHlpdXFYYmxjc3VDUFpFL2lBZWRT?=
 =?utf-8?B?emVuTW5NN3NRdVpVVE94cXFjK1NNSUgwUm1uUG42QlBTTXRQZWJxTGVjRWVU?=
 =?utf-8?Q?yF8xRv9G6ONRzqJGQ4fIg5Sk2MpXmAyco+HnO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1A554D46A86014998D8EB528E533A7D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef96bdb-895c-48fb-782b-08da1ebaa4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 08:33:40.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkWaAMX6P7Kxy0XQ3TVIhyQ7RldPUzxuOrNQjiFUXrByfMcJl42/w3k4I+Rq+0TPNfSLCeEmuB8OynbB0EeLQhqQcS8OWwqoCEIYd+/8QtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2948
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAzLzA0LzIwMjIgw6AgMTA6NTAsIFNlcmdleSBTaHR5bHlvdiBhIMOpY3JpdMKgOg0K
PiBIZWxsbyENCj4gDQo+IE9uIDQvMi8yMiAxOjIxIFBNLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiANCj4+IHBvd2VycGMncyBhc20vcHJvbS5oIGJyaW5ncyBzb21lIGhlYWRlcnMgdGhhdCBp
dCBkb2Vzbid0DQo+PiBuZWVkIGl0c2VsZi4NCj4+DQo+PiBJbiBvcmRlciB0byBjbGVhbiBpdCB1
cCwgZmlyc3QgYWRkIG1pc3NpbmcgaGVhZGVycyBpbg0KPj4gdXNlcnMgb2YgYXNtL3Byb20uaA0K
PiANCj4gICAgIEknbSBub3Qgc2VlaW5nIGFueSBoZWFkZXJzIGFkZGVkIGluIHRoaXMgcGF0Y2g/
DQoNCllvdSBhcmUgcmlnaHQsIG15IGRlc2NyaXB0aW9uIGlzIGEgYml0IG9mIGEgc2hvcnRjdXQu
DQoNCkknbGwgc2VuZCB2MiB3aXRoIGEgbW9yZSBkZXRhaWxlZCBkZXNjcmlwdGlvbi4NCg0KVGhh
bmtzDQpDaHJpc3RvcGhlDQoNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95
IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2Iv
Y29yZS9oY2QtcGNpLmMgICAgIHwgMSAtDQo+PiAgIGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1wcGMt
b2YuYyB8IDMgLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY29yZS9oY2QtcGNpLmMgYi9kcml2ZXJzL3VzYi9j
b3JlL2hjZC1wY2kuYw0KPj4gaW5kZXggODE3NmJjODFhNjM1Li5mMTkyOTI1Zjc0ZjcgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9jb3JlL2hjZC1wY2kuYw0KPj4gKysrIGIvZHJpdmVycy91
c2IvY29yZS9oY2QtcGNpLmMNCj4+IEBAIC0xNSw3ICsxNSw2IEBADQo+PiAgICNpZmRlZiBDT05G
SUdfUFBDX1BNQUMNCj4+ICAgI2luY2x1ZGUgPGFzbS9tYWNoZGVwLmg+DQo+PiAgICNpbmNsdWRl
IDxhc20vcG1hY19mZWF0dXJlLmg+DQo+PiAtI2luY2x1ZGUgPGFzbS9wcm9tLmg+DQo+PiAgICNl
bmRpZg0KPj4gICANCj4+ICAgI2luY2x1ZGUgInVzYi5oIg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2hvc3Qvb2hjaS1wcGMtb2YuYyBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1wcGMtb2Yu
Yw0KPj4gaW5kZXggNDVmN2NjZWI2ZGYzLi4xOTYwYjhkZmRiYTUgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3VzYi9ob3N0L29oY2ktcHBjLW9mLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3Qv
b2hjaS1wcGMtb2YuYw0KPj4gQEAgLTE5LDkgKzE5LDYgQEANCj4+ICAgI2luY2x1ZGUgPGxpbnV4
L29mX2lycS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4+ICAgDQo+
PiAtI2luY2x1ZGUgPGFzbS9wcm9tLmg+DQo+PiAtDQo+PiAtDQo+PiAgIHN0YXRpYyBpbnQNCj4+
ICAgb2hjaV9wcGNfb2Zfc3RhcnQoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4+ICAgew0KPiANCj4g
TUJSLCBTZXJnZXk=
