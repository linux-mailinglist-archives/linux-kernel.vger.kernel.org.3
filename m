Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33FD4D05B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbiCGRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbiCGRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:50:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290212AE2B;
        Mon,  7 Mar 2022 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcSexPgIX+iWFZHcWHwUG8JK4OHxy3YNcIkaZTV31B4=;
 b=nt2WHBLMKX6HLZGXzmWm0wj/72OmGm1gFWz7phL8RhEou3WYphjV04xkbWRm2Ve7Ohndt8ohXi0YHC06O2l+lZez3dJsFsKT9e6OmkjcTj7SIzbLlBG0vVeuvu80cRZh/N5XINyqLQK6pup5I3VXVF4mM4UZI0xhxTyFFOZVhGY=
Received: from AM6PR10CA0013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::26)
 by VI1PR08MB2813.eurprd08.prod.outlook.com (2603:10a6:802:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.23; Mon, 7 Mar
 2022 17:49:34 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::2f) by AM6PR10CA0013.outlook.office365.com
 (2603:10a6:209:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 17:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 7 Mar 2022 17:49:33 +0000
Received: ("Tessian outbound 31aeb3346a45:v113"); Mon, 07 Mar 2022 17:49:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5fb0cb6a8485fee7
X-CR-MTA-TID: 64aa7808
Received: from 433114a206f8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 34E1526E-C3D8-4728-AC32-9CC3EC030FF3.1;
        Mon, 07 Mar 2022 17:49:26 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 433114a206f8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 07 Mar 2022 17:49:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLt9g903pjcIW63WRtMTqOVSW32ByUIFPIlNTAEeqHkYEU/p8Z05ZsToDdEbUbqyS1aBboeWYEhtkYL8YTkifzonm8Y0rJlVPUXL36esLbCAHIrf75Mcc9Hz3b4LGQdSNlkS8Gd3lHj2FGg3zb0wrfPn7sdZOrGD5y2CBVhIkLINKAP8zlhWj8oYTbFdA4ZJwhGRnMq5h5XK6h+kvU0HvR95NT/f7uzuMy2ENG92fuadOxSC7BM+8W8iTbIBeaxo1tiKhuzt1pvgATd0k53gCoVAW7SQAMoJlINILcQmGI3k/Ah4QmRuYL4xtKgmhRKWgLW8JjPXraw8jxp3A3rLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcSexPgIX+iWFZHcWHwUG8JK4OHxy3YNcIkaZTV31B4=;
 b=nn0EGsAfnkB/fKVUr4GvT/oHwsUevMBP1TjneH/tECqyZ4LULZO6X5vn4n9bH0EOVCOUUJJU1dSkvzvejZ03T1pyaD8UjwjIzPfXfQHFvLVIZFraa8+yswooxhTy6PLCIDUYfogj00qyql1FfIWeMwL7ZQ0LrUhTwX7Mqbi0HNR86u/OO37WR+53PS7i74F8fRD9JMCZB2oZzGNyUdq4cnCQ4tt4aNLWwTTLRYbgapUpamgzRR+hqqPW5JYhOAbQAR7Clm8pAtRXA2c/ZDRjzTOMiFltjoiweBz1eT72kWrHCs1Y+qDPgJKXy+jwc87gkeP4f3i6/r6/mvzMSSSxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcSexPgIX+iWFZHcWHwUG8JK4OHxy3YNcIkaZTV31B4=;
 b=nt2WHBLMKX6HLZGXzmWm0wj/72OmGm1gFWz7phL8RhEou3WYphjV04xkbWRm2Ve7Ohndt8ohXi0YHC06O2l+lZez3dJsFsKT9e6OmkjcTj7SIzbLlBG0vVeuvu80cRZh/N5XINyqLQK6pup5I3VXVF4mM4UZI0xhxTyFFOZVhGY=
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12)
 by PR3PR08MB5627.eurprd08.prod.outlook.com (2603:10a6:102:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 17:49:24 +0000
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::6ca8:22eb:bdc4:21ef]) by AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::6ca8:22eb:bdc4:21ef%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 17:49:23 +0000
From:   Sami Mujawar <Sami.Mujawar@arm.com>
To:     Sudeep Holla <Sudeep.Holla@arm.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: ACPI flow for reserved memory
Thread-Topic: ACPI flow for reserved memory
Thread-Index: AQHYL+tOJpf4ame2rUWZCNdow2wPBay0N4QA
Date:   Mon, 7 Mar 2022 17:49:23 +0000
Message-ID: <D676ADF1-33F3-47A2-932F-40F01D602787@arm.com>
References: <BY5PR02MB6947E939600E244DDDCFF341A5049@BY5PR02MB6947.namprd02.prod.outlook.com>
 <YiJI4fe0tYDj96ob@bogus>
In-Reply-To: <YiJI4fe0tYDj96ob@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.57.22011101
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 665cf956-0ebc-43de-c6ff-08da0062d696
x-ms-traffictypediagnostic: PR3PR08MB5627:EE_|VE1EUR03FT012:EE_|VI1PR08MB2813:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB28134FE6D1752AED02BD21D684089@VI1PR08MB2813.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: i7eDinztgxT/9Jv2RKllwXTDKqsp2HERjA5bKHfsYDgZhD9COkRziw09OTer265yP6lAawFJP9xAxCf+J+ErYQAk8Ls4H8Gw8IaLjtq9Nf+VgiEkJ4fMVhCG12xcRXPHbj7PTVjEbickUI6+Ns9oRz1sTfnN9y5wnu6ZXSAFOLOBbpjrnAzwUTAL2npiqADIWDKUkgwlvnBlSmPd6CxhjeYun69Vb5Usx2SQLtf8nd6xV54GwjJPszdiihJqoEt044Aenm/22AquIShyfHRtnLFyjx3mbB9R5kKqngQzp3XcRcTSZV3llsIuswRj5rApa6sEmkqNmoN+C62yBB8uDTJXSE7RbGcCaPVXihabll+4XhBwnzudF6Z6chg2dBu9OFI3jQbU0rQsJC/zhaiKoGl+Cf4aarTD7mPhVAbTfnIzqmAeRgv3ekv07uS1CkNCAF6ZwQv/OYP5o8ktLgcVCk2RYgEPaPxN51l+RVR8kVFk7qhbTstyMbBxhceQhuNWS990SucBNz4oZUGOP0EpcmxUKwf2cUblmlUIrsE94573kKSPSKtsIEMUx0rmZBjHamybDVivoqoUAY2+nZz8QF6a9XKGEPQ99XYQdPmv15iqfytMhFv0PfZvNZvygCMmTzDB9ohQnA/PeV+fN666qRnNyNdZ1A2smdTD+ynjkRZ7KpxUp14fXh+n8yCDR4sUbk1JWRYg7kHoKw4KH+BsdZYkvU3HGqab3nxYCQ4AAr06bx3PzGqlHn45QR2PF8mit3vq6VvSLJ0P3Ct0aN6hdQgyA6Sqkplb35tRNSfWLDwPGMIuMPIhYSv8h+IGZ4HW
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6806.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(2906002)(86362001)(316002)(54906003)(110136005)(36756003)(6486002)(508600001)(91956017)(38100700002)(66946007)(4326008)(8676002)(76116006)(71200400001)(5660300002)(64756008)(66446008)(66476007)(66556008)(8936002)(2616005)(33656002)(122000001)(83380400001)(26005)(186003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9ECB4A5DACB894890870B018BFF831A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5627
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3addc453-d52a-48e1-6f47-08da0062d0ea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 514+YOOa+ErMFWRQl0pf5WAehrFsbh02hTUSggGd3/LKL5xmtsx/OglL/fgcsUzRUu18gtXaQzY1l51jFDoVY+llODy4EsJ6pWyTwAMVupBfj29Rz353+GtrEC3Fqtmk+sQO/Fpw+1eemLZ4Z8tut036KdtX4MNSy8vzMKqdkqUOOUvlErEeLMofxpvKXZhLtVB5SC2W7iqedy6PBm+8V7JAx2HCsiyv9KwxRU+PjhX93dmqTcZ+4ADI5Zu0gL0ntuiEcS14faiJKugyAzV6iG1W4IyIZ1zurNuE+R/a4tb31p+Js96UATNfnpvoNLh9MT9Q4Y87HZgdCsmI/zgVFxeCsftAvzkrAD0paOVzrWx2a3OEjUah0bR4R5prXbrV6j+m87nW8ZM6NH+yCx+dMDek1adkd+oSTXHt3MLIwgzcOm7c9YfuD4lZ2QOMO2XXdFZ5287Pk593S524T/ztjsEcXWLSBU8tSHa0JqvaoTjYT6zfanDgxZTp04yOovV2gxNdB0vLQfkewXFhdMW8jSrIB3j1wbnvuBWc7rowAarB6gYQjwPj/VcM88u2FVy4hfobkedz42n8fiR+NCfsIksQ2qcnVjO7+PBk5ktlhcvcZaREX2sJv+7/yMGrcKvsWNz4SIBOoVvUDHqQjpupJK177QM3WksX4ioN7zqEwlTwuutWKccAPr8bh4PYe3T5zhMA4IU5SfIyaqipC/Oaz2EkRck0Za0+rHzXoVlt8EHuYBu54y70MwXjMw+EaSeSW5Jtf1PRSsb2Xd/DIjEiMQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6506007)(26005)(186003)(83380400001)(6512007)(336012)(6486002)(40460700003)(2906002)(47076005)(36860700001)(33656002)(36756003)(54906003)(450100002)(70206006)(70586007)(4326008)(8676002)(110136005)(5660300002)(8936002)(2616005)(508600001)(356005)(86362001)(316002)(82310400004)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 17:49:33.1940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665cf956-0ebc-43de-c6ff-08da0062d696
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2813
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmhhcmF0LA0KDQpUaGUgVUVGSSBzcGVjaWZpY2F0aW9uIHZlcnNpb24gMi45LCBzZWN0aW9u
IDcuMiBNZW1vcnkgQWxsb2NhdGlvbiBTZXJ2aWNlcywgRUZJX0JPT1RfU0VSVklDRVMuR2V0TWVt
b3J5TWFwKCksIHBhZ2UgMTcyIHN0YXRlcyB0aGUgZm9sbG93aW5nOg0KIi4uLiBSZWdpb25zIHRo
YXQgYXJlIGJhY2tlZCBieSBwaHlzaWNhbCBoYXJkd2FyZSwgYnV0IGFyZSBub3Qgc3VwcG9zZWQg
dG8gYmUgYWNjZXNzZWQgYnkgdGhlIE9TLCBtdXN0IGJlIHJldHVybmVkIGFzIEVmaVJlc2VydmVk
TWVtb3J5VHlwZS4gLi4uIg0KDQpUaGlzIGNhbiBiZSBhY2hpZXZlZCBieSBhZGRpbmcgdGhlIG1l
bW9yeSByZWdpb24gYXMgUmVzZXJ2ZWQgTWVtb3J5IGluIHRoZSBmaXJtd2FyZS4gDQpFeGFtcGxl
Og0KDQpTdGF0dXMgPSBnRFMtPkFkZE1lbW9yeVNwYWNlICgNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRWZpR2NkTWVtb3J5VHlwZVJlc2VydmVkLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBSZXNlcnZlZE1lbUJhc2UsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJl
c2VydmVkTWVtU2l6ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBFRklfTUVNT1JZX1VD
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgKTsNCiAgaWYgKEVGSV9FUlJPUiAoU3RhdHVz
KSkgew0KICAgIERFQlVHICgoDQogICAgICBERUJVR19FUlJPUiwNCiAgICAgICJGYWlsZWQgdG8g
YWRkIG1lbW9yeSBzcGFjZS4gU3RhdHVzID0gJXJcbiIsDQogICAgICBTdGF0dXMNCiAgICAgICkp
Ow0KICAgIHJldHVybiBTdGF0dXM7DQogIH0NCg0KSG9wZSB0aGlzIGhlbHBzLiBQbGVhc2UgbGV0
IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGZ1cnRoZXIgcXVlcmllcy4NCg0KUmVnYXJkcywNCg0K
U2FtaSBNdWphd2FyDQoNCu+7v09uIDA0LzAzLzIwMjIsIDE3OjE0LCAiU3VkZWVwIEhvbGxhIiA8
c3VkZWVwLmhvbGxhQGFybS5jb20+IHdyb3RlOg0KDQogICAgSGkgQmhhcmF0LA0KDQogICAgSSBh
bSBub3QgVUVGSSBleHBlcnQgYnV0IEkgd2FzIHN1cmUgdGhlcmUgd291bGQgYmUgc29tZSBvcHRp
b25zIGZvciB0aGlzLg0KICAgIENoZWNraW5nIHdpdGggU2FtaShjYy1lZCksIGNvbmZpcm1lZCB0
aGUgc2FtZS4NCg0KICAgIE9uIFRodSwgTWFyIDAzLCAyMDIyIGF0IDExOjA3OjU0QU0gKzAwMDAs
IEJoYXJhdCBLdW1hciBHb2dhZGEgd3JvdGU6DQogICAgPiBIaSBBbGwsDQogICAgPiANCiAgICA+
IEluIGRldmljZSB0cmVlIHdlIGhhdmUgc2V2ZXJhbCB3YXlzIHRvIA0KICAgID4gcmVzZXJ2ZSBt
ZW1vcnkgKGh0dHBzOi8vZ2l0aHViLmNvbS9YaWxpbngvbGludXgteGxueC9ibG9iL21hc3Rlci9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXJ2ZWQtbWVtb3J5L3Jlc2VydmVk
LW1lbW9yeS50eHQpLiAgIA0KICAgID4gDQogICAgPiBDYW4gYW55b25lIHBsZWFzZSBoZWxwIGVx
dWl2YWxlbnQgZmxvdyBmb3IgQUNQSS4NCg0KICAgIEBTYW1pLCBwbGVhc2Ugc2hhcmUgYW55IGRl
dGFpbHMgeW91IG1heSBoYXZlLg0KDQogICAgLS0gDQogICAgUmVnYXJkcywNCiAgICBTdWRlZXAN
Cg0K
