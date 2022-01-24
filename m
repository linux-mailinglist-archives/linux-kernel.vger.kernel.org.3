Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BCD497E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiAXLiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:38:12 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:32960
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237677AbiAXLiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHa01YOsOQVSk0xhxou160z+axh/3uS3QDXSp3Dp+r4=;
 b=3YhQ47L2UmEohY1gJHOK0gZbSnJ4h7wb19AufWxFDRtnpXNN1/56y1nCgkOcXXtJL1Iu4AS4efKLY/wjk1tOCzitqfC+MkFfwcbalc1At4qa1G4NULXhKUwHchfiZMuNPWAMHxBSzkGorhXomYBLGa/vdU5IME8+0aVo1LQv8zQ=
Received: from DB6PR0601CA0003.eurprd06.prod.outlook.com (2603:10a6:4:7b::13)
 by DB8PR08MB4059.eurprd08.prod.outlook.com (2603:10a6:10:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 11:37:57 +0000
Received: from DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::e1) by DB6PR0601CA0003.outlook.office365.com
 (2603:10a6:4:7b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 11:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT013.mail.protection.outlook.com (10.152.20.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 11:37:57 +0000
Received: ("Tessian outbound 2877e54fe176:v113"); Mon, 24 Jan 2022 11:37:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 36332006b99362ae
X-CR-MTA-TID: 64aa7808
Received: from 5286fc686b33.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B9E88F19-466B-4271-8928-4950B061A8D7.1;
        Mon, 24 Jan 2022 11:37:48 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5286fc686b33.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 24 Jan 2022 11:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcGzwEjUZC9/GTmsbr8szlO2M27x8IATTbsN9GMZOmbGxpYueEPKXVI0HyWsm1f0b5CX80LjeImjAre9T70IWD9gXkX6NJmgEwwRm+YtA7HpogZM8SGebCZhLa858U7hmZcIo9PcMgb5EHUzpKfnlop5QqZUD6t2eeBITzbhznL5XbuEZeIGhvaqfEMSWvjLpdz6xI+6B/ozQ33yyJ9AzHe2iqiuaVT9fN6O6f1t3qLJANOj4m3juHaupmNg2vtwwBWn9BMnCGTCms9s5AWE5BF0yIoILQLCYbwZN+MXVlostPjw9k8J3dkE3u/DbfYA4JeXWRvINZoiZiALonp34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHa01YOsOQVSk0xhxou160z+axh/3uS3QDXSp3Dp+r4=;
 b=GRsU/Yzs40ZGYGAbzfGfB7VmMM+BoLoS6Bl74qO8KWxy7deI1JvfpgAkF+U0o3fozGsBaXwFUaxEkWJ6yh/oCpGC7yaR2HvIz1Wj8v8TS/GpD0oRUiGOdtmGbjrdrVeXYNUOOhvQMlx1AnLTIVFAyRd0efTRcA9z/hPJTwihRQ+2IwgeQ3A6sLtsV3gz4W0VsmTRgoy31eyH22nwszmTIUEPiRn2rsUuqcqvoW8hT0ngETw4tc5lHp4hcv9kvc2t0lt6WMbz47mwGzlcHdiC+SSkJpLBTvo+nO94qrAk8JnTj0tFCFJglzn7ggr42McMjUdhGYtz5LosWfV1Ssu4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHa01YOsOQVSk0xhxou160z+axh/3uS3QDXSp3Dp+r4=;
 b=3YhQ47L2UmEohY1gJHOK0gZbSnJ4h7wb19AufWxFDRtnpXNN1/56y1nCgkOcXXtJL1Iu4AS4efKLY/wjk1tOCzitqfC+MkFfwcbalc1At4qa1G4NULXhKUwHchfiZMuNPWAMHxBSzkGorhXomYBLGa/vdU5IME8+0aVo1LQv8zQ=
Received: from AM9PR08MB6020.eurprd08.prod.outlook.com (2603:10a6:20b:2d6::7)
 by AM9PR08MB6899.eurprd08.prod.outlook.com (2603:10a6:20b:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 11:37:44 +0000
Received: from AM9PR08MB6020.eurprd08.prod.outlook.com
 ([fe80::b09d:a6f2:e90e:1b65]) by AM9PR08MB6020.eurprd08.prod.outlook.com
 ([fe80::b09d:a6f2:e90e:1b65%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 11:37:43 +0000
From:   Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
To:     James Clark <James.Clark@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "leo.yan@linaro.com" <leo.yan@linaro.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] perf/core: Wake up parent event if inherited
 event has no ring buffer
Thread-Topic: [RFC PATCH 1/1] perf/core: Wake up parent event if inherited
 event has no ring buffer
Thread-Index: AQHX6pX8Zbn97L+JjEiCYRxnZUUCHqxyUnYb
Date:   Mon, 24 Jan 2022 11:37:43 +0000
Message-ID: <AM9PR08MB60200FA42FAB6DB843718F0A975E9@AM9PR08MB6020.eurprd08.prod.outlook.com>
References: <20211206113840.130802-1-james.clark@arm.com>
 <20211206113840.130802-2-james.clark@arm.com>
In-Reply-To: <20211206113840.130802-2-james.clark@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f2a74dfa-93fb-13d1-bdd2-7287bd28218d
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 452c86b6-3c38-4121-3051-08d9df2df81b
x-ms-traffictypediagnostic: AM9PR08MB6899:EE_|DB5EUR03FT013:EE_|DB8PR08MB4059:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB405968916F6A13ABA9DE134E975E9@DB8PR08MB4059.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5236;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fgDA/vTFNCSBJtL+9PCh11fIBQn1EutV2NZU50HV7eYPmqOALGoPx7x4owev7I6RRuHRStklcMZqXqAb/t/UCYuYg9niR2T5bY9d2lbT8DWpKPHcCHT7mCORuze4FrVC2rgpTm+/aWfdIUWH8lSKepjAu0PSHhht22z77JCPPr32qOOrhIlRQPxx5FeXHxytNYZo1aHUy4es7uCOCBQeLMpuA07oK6FeK0IGOkouaWydcPbF0uY2tulrqN6o9V+juQGbNXyIi1w0l26gZ0RXVSL1mWplWD+hVCwhcVQqTjNSLRpeXFqQuchGwGnsHvVuiJHihmOzZcQZToWb0dHaaILczq5MnYh/VbMfhjwEOYR8E+ePhUHs6gKO2JB9zpZ0K0gAjxJJo2hk/rFO/TVjE4ixICNmlTZzJJtO5jdfvFjlwkaLViVl4TGFHWkyXP+YykIPnIR/08uZCHnuBPvYXBOeVWDMQRxr7yFQQoe1BN0ho/LKg0bdoFx5cIdRO1s96KYCb+8Z+aPVx0V50GlE4NPdu3c1Ou2Nkf1DpNeF1pxJrBVWZLZVv7zGeHckLHUkqxK/OCDdkiah900l73vqJJjGAHoy9CXsR+WY4/HpXQ0QyzRLlz0wsRT/HLvh2h/WbSpK4bQqoH+z3VQFllvAvAw9P+z7vJy1dWt2JPCnr3zNEcXBIOK7KTGM5e/7f9514tICsI/f/o08oRh5sSfDRw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6020.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(71200400001)(86362001)(54906003)(38100700002)(52536014)(110136005)(55016003)(6506007)(508600001)(26005)(8676002)(2906002)(122000001)(7696005)(4326008)(5660300002)(91956017)(33656002)(76116006)(64756008)(9686003)(83380400001)(66446008)(38070700005)(186003)(66946007)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6899
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1609842b-5fa9-459f-554f-08d9df2defcc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSoURxHarNAJepBgsqTrjkd0cj04UHAO8+nI0S9MGiWwxA1hws3VB6Oc/SYjbumw9su7RlxMIG1zH39ul0h01tTiFZVl/H+D3SeIH7QuoVvCiZ7rZLlqG9EA7D36JoUuxFFd2jhCxKy8j/9fFo33MhI1aKNq6xlPlYdhus61VOBlORQ9ubXApRnBQrvTXrQuXYRJRU7A7TtK7U5xi5SC2fsQIj5DMc77jhPJoKhoSQZ4SsEspaBKiAQKvzWqv9mSHvKvuum2PCzSZC3ecrTkvvxgAkUylieEUmI911X+dGlDWL4tpp56HR3ck5bwz/9iWTjYGj2LGr4lbdCDVyfc0XvCqIikNrkFr6JEoPV3Z9BAJs+jczsnxW4bH2QXr3+/xlCD5vyBx0LoNgYPmnaFe0xmdQMM9RHjTmh2DQIv+b+K6p0cwitbaU5KX7gYK3JoS7KUAhLZsS+NCADp/ZM9X/1gP7AA6/SpDvbw04JlySRJFJcGG+idYJ85YhtpKkVhlq47ltDRy5GDY196ABzS4j3FhYagV0odeB1Kx/0kOER95nWoAA/AF+y5QYafjR+6l99M23o1UxTqxQJ/5+KsWHS0RjNR4IA4l2vBHZUTI73dUM6nnfRUDUfA8zBWVq30lpvP3rgaS/oErwPOecX3zwqxY4FFejEUYw2CFG11MBITP6y7En9JnajBHsCw0f1eJyf+CJeQwH1egJmdonBs7ZU2egu6vCit9zLRVXnqB54A/r24BGu7gPmlfbBqD265tvKrWEoSiWjNbME1lUWEnQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(40470700004)(36840700001)(46966006)(33656002)(82310400004)(55016003)(86362001)(52536014)(54906003)(70586007)(81166007)(356005)(4326008)(110136005)(83380400001)(8676002)(5660300002)(26005)(508600001)(70206006)(36860700001)(7696005)(186003)(450100002)(40460700003)(9686003)(47076005)(8936002)(2906002)(316002)(6506007)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 11:37:57.8533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452c86b6-3c38-4121-3051-08d9df2df81b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've tried running a benchmark with and without this patch applied, with th=
e following options:
 perf record -e arm_spe_0/event_filter=3D0,jitter=3D0,ts_enable=3D1,pa_enab=
le=3D0,min_latency=3D0/ ...
repeating it 60 times with and without the patch.

Without the patch, the output perf.data sizes were: 1.0G 1.0G 1.0G 1.0G 1.0=
G 1.0G 1.0G 1.0G 47M 48M 48M 48M 48M 48M 48M 48M 48M 48M 49M 49M 49M 49M 49=
M 49M 49M 49M 49M 49M 49M 49M 49M 49M 49M 49M 49M 60M 60M 60M 60M 61M 61M 6=
1M 61M 61M 61M 61M 62M 62M 62M 62M 62M 62M 62M 62M 62M 63M 63M 63M 65M 990M=
 i.e. 47MB to 1.0GB

With the patch, the output sizes were: 1.4G 1.4G 1.4G 1.5G 1.5G 1.5G 1.5G 1=
.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1=
.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1=
.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1=
.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G 1.5G i.e. 1.4GB to 1.5GB.

Tested-by: Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
