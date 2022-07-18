Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27F578D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiGRVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiGRVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:47:20 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159A2125D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658180838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kPBJTEFC6KZXPntz4IBG1R1v5Ghjxau49iFig9dzo08=;
  b=R8gbFRQxwy0Ig3kGnOfcELOwnxhQkGBI6AWKH2a2Xgh+oYpWun9XyTxT
   ZPnm2NwJM91f8+1/v5dOjXMmoxf/US4vz1MswA4C9aZCbLV52R7HEx9RA
   E3NWXMY537Otixp4SFTcI9imuQw3G4hYdoMmm9y8IZGXMNlMnRMoErhzt
   0=;
X-IronPort-RemoteIP: 104.47.59.176
X-IronPort-MID: 75894838
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:HZI4MKIIfi0+nHsVFE+RwJQlxSXFcZb7ZxGr2PjKsXjdYENS1GZSz
 WYeCzqHaP6Oajb3ctAkbIqx908G7cXVmoBlTgRlqX01Q3x08seUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vraP65xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOd8iYNz6TSDK1rlV
 eja/ouOYjdJ5xYuajhOs/3a+Es11BjPkGhwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDX4pZiYICwgwAqm8AH+v1T2Mzwy6tgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE2/90IGA9D9Ij9OsuAE5Ey
 M4CeQAoYUXW7w626OrTpuhEoO0GdZOuEKZB/3ZqwHfeEOosRo3FT+PS/9hE0Twsh8dIW/HDe
 84ebjkpZxPFC/FNEg5PVNRiw6H11z+mLGMwRFG9/MLb50D6ygBr3aerG93SYtGQHu1en1qCp
 3KA9GP8av0fHIPCmWvZoin87gPJtSC8WK5NU5qxzKFRr1TO/mU1VzIOeGLu9JFVjWb7AbqzM
 Xc86CM0q6kt9EusVvH7Qxmnp2SAslgXXN84O+k77hydj6nZ+QCUAkAaQTNbLt8rrsk7QXotz
 FDhoj/yLTlmsbnQRXfD8L6R9Gm2IXJMcjFEYjIYRwwY5dWluJs0kh/EUtdkFuiyk8HxHjbzh
 TuNqUDSmokusCLC7I3jlXivvt5mjsGhotIdjukPYl+Y0w==
IronPort-HdrOrdr: A9a23:rdvoSqDEZvl9EyXlHegPsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U0ssHFJo6HiBEEZKUmsuKKdkrNhR4tKOzOW9FdATbsSp7cKpgeNJ8SQzJ876U
 4NSclD4ZjLfCBHZKXBkUaF+rQbsb+6GcmT7I+woUuFDzsaEp2IhD0JaDpzZ3cGIDWucqBJca
 Z0iPAmmxOQPVAsKuirDHgMWObO4/fRkoj9XBIADxk7rCGTkDKB8tfBYlml9yZbdwkK7aYp8G
 DDnQC8zL6kqeuHxhjV0HKWx4hKmeHm1sBICKW3+4gow3TX+0WVjbZaKvi/VQMO0aWSAZER4Z
 7xSiIbToZOArXqDyeISFXWqlDdOX0VmgLfIBej8AfeSIrCNXwH4oN69PxkmlGy0TtegPhslK
 1MxG6XrJxREFfJmzn8/cHBU1VwmlOzumdKq59bs5Vza/poVFZql/1owGpFVJMbWC7q4oEuF+
 djSMna+fZNaFufK3TUpHNmztCgVmk6Wk7ueDlIhuWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKah9GOACS82qDXGle2OFDEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiIA/nZ
 zQOWkowVLau3iefPFm8Kc7giwlGl/NLAgF4vsulKRRq/n7WKfhNzGFRRQnj9agys9vcPHmZw
 ==
X-IronPort-AV: E=Sophos;i="5.92,282,1650945600"; 
   d="scan'208";a="75894838"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 17:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW2cct1XPRr+9SVY2QrqNi677d4D+fhsITtseDSy1b2AjsyWCUtHGfrVejef0ewE7EPdxqnHDd0jVAF+Q3x7bMXOVpGT4rYeYYpprDu2QxdMyZbf2SJmUn9hszkKzDSCb7okibieVxcdjKA3zD2UfL7KPGpyrIQkYC/rmZLo66Z6K4Gl+lU+GjzM93RhCGdgt+ke/s3PWsoQoIkYnKoO/ChVaiRHPUq7qpIdvmOlbIlakYYL4Lam/V8q43C9DC4ykhjbz3xSLydAk7BcipEgkjO8iqiTL0630+8dyuijdxe2Nn8JCoh3bHX+2XOCVpIOtxczPxp70NcqHxhUBv3Q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPBJTEFC6KZXPntz4IBG1R1v5Ghjxau49iFig9dzo08=;
 b=Fp0yRnuMGDcq4wx9jRmz5NjG+kOFbuhaI9/XnK0sKNd9x9t90e6LY0tL78gQSVYw5tTInXaHa5kLasy8nstrSuwhpQt2ZHoAY+NBkxLcNbPwSfoO7p/hcQgH+VW98scQ5HXV9BSo6lWAnY2Lt9sc991B1DxZopSRYHS3uCMw+LLnQPCkH1tGhWznxR842/+3j/9cs8EqlOVvP/Gc60bQgK+Krl5llqBr44YqC/r57WvM8Ycv0FPzV1cpWn1Bn4v3upup7i10fHq2VqLxgfVEfkMlZ4f2DH0gyz++61bZLWuT8aQVZbHUjkuQ8Xcb9W2na1sxrkU5tPdAe5ZtymMgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPBJTEFC6KZXPntz4IBG1R1v5Ghjxau49iFig9dzo08=;
 b=liQmP4ARrKI7POr07gzSz2gRAPsJ+B//xC+LUOshFQukneQ2HoLDkgZNhL/MWaTvkSbW4+w4qzBHH2kBKq9TIotI2L+G6ASPByxhuM8qALXG8fCMHb5/Vq7mOxgqeClYom/Ddxzqtwzv9KDXmmzpl4W+Lw4uNxuIUG4u9WJGJ04=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB6159.namprd03.prod.outlook.com (2603:10b6:5:39b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Mon, 18 Jul
 2022 21:47:16 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:47:16 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Ken Moffat <zarniwhoop@ntlworld.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: Retbleed, Zen2 and STIBP
Thread-Topic: Retbleed, Zen2 and STIBP
Thread-Index: AQHYmu5nJue0S81uxkqshAmtSMae5K2EqgaA
Date:   Mon, 18 Jul 2022 21:47:15 +0000
Message-ID: <63cbe83c-aed7-48ae-978b-bb85c211b28a@citrix.com>
References: <YtUXda9ymAI0ED7n@llamedos.localdomain>
In-Reply-To: <YtUXda9ymAI0ED7n@llamedos.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e86f1806-2f3b-4db8-acf6-08da690714c7
x-ms-traffictypediagnostic: DM4PR03MB6159:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnM2WbH2I6sO7WaixK+LQqlysfP6+WJs3Ku59x3cHz2RR6LoDADaou/f2gmQbTiUOjiGgQBaoDfIbxycNd0RCNkl83wKci6hUEwwTJ7EKXnKa0bhvCq1YoJqX9WR0oKSbGpzLFSZ+hT0exZvu4+Q5Nkk8wNnnWKb7rpwhQWXpOR1qfT3b/W/gGa5VtQZ5+FLxFctZZUMJgtb0thBX/1kWJ6mWFCdtqNqtMrpFuei01iTzq0JdL5O9cnqbewNe2BResTJWclFwm6A4kXHvl92+a7Iw2sgEZLTXyvBlGWjs5e1SL0WfZDI7mJRThenqx4G33BLRR/sOG0QXotn635VmtXkqq5M0N2Vq8M7MNmRGH8Yh3/J9f2qDGe6HfhWVFlONTlU87Lyx+eZFvkzgPM2nftWUiwYaq2jp/TqilXsOSYww75oPOBgVA90KQL3jhQxVfKv30FycRObr4Wviwwzxs8U3GWPl/RAjNCNYdw88RbhpwhKjpw22TCIeQ0Un2IdW52yQj3WeFiOZqLAPq/HoN/uh2tg2QLTMUWh6GaXph0fvBJQdBBVqckKs7sskR3i2RJojopGBUSWKsZeVBYD5Ydvs2lRnRaDaT9Biawd9dpMxU+n4j78Ajulg+3/teM9njztO/r79BXRABBVAn7AQGW4iPP1evZihDTVW5DUQ94bcF5bVvgTx6S+jyk40ptTK/jtb8x/O6HbCZjqr2QQobkoWugzZoO/eyf1TaAfB+QDsIbDjhINd3e9DgqKJzHGlDgTatOirrNFK7fOsfwFGADOXwRbYCTKi1JQbDPUWhIb5tUwoZEFARmGkktjywsN1GpePKz69451hNHsNvbd3Z30B8YNzw151IIQYaY9Ab2SJl4cJX/ynYujGhXMgvkMiUbPEyROF/r42axuPfYVaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(8936002)(5660300002)(6486002)(966005)(478600001)(6512007)(122000001)(26005)(31696002)(41300700001)(107886003)(86362001)(2616005)(186003)(2906002)(53546011)(66574015)(8676002)(110136005)(38100700002)(6506007)(66476007)(76116006)(64756008)(66446008)(66556008)(66946007)(91956017)(38070700005)(82960400001)(31686004)(316002)(36756003)(71200400001)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNSNnhWOXhyZUdpU0M5dnpnVXFkTXg4SjdGaHdlcXArUGZadDBkVXVoa0My?=
 =?utf-8?B?Um9BeUNoR1FoQWZ5bFcvRzhPdytGTThXL05rVmhZMjNPR0tzK25iWUpJMXdL?=
 =?utf-8?B?NHp4MmM2Ri9ERHNhT29tNldNTnVLUVRibGNhSnlyVUM5UEYzcGNkdFRDS0ZG?=
 =?utf-8?B?V1FKNDZuMnRQc3FudlBCT0Y0dXpkVUNiR0FCWnRXMDV1UlExTTIxYWV3MEpN?=
 =?utf-8?B?bUZwSmM4NnhSWk02L0FpbThDZTh6Umk4QlUrTEJjcGg2a045Zi8rUWJxeXRk?=
 =?utf-8?B?WUhPbDBaWXViakhKNjFLUTNrejFuUHpySy9DaHZod1VkVmhIUkMxQmlFaDNa?=
 =?utf-8?B?ZmlEWGVSaHRUcWE1MFN0bkNVWG5qL09yQXdxbHV2QmZQajNnTnlOZGk4b1FR?=
 =?utf-8?B?YTRKTGZlMVdGSDdVdlJmUzdvcUVtWElnRU9ad3d2UmVZUENtRnUxb3FkWDhr?=
 =?utf-8?B?bjFhU05TMnlKTHVRRzNlUXpPcUlremdnVEtSTjBVb0Zmc1JMeDVBZWxNSHhZ?=
 =?utf-8?B?YjdkQk1kSDNRMUdyRmZBem8vb0dGOFFMeHFhSUxZVlE5bDEyZlcyQXpibUtl?=
 =?utf-8?B?WnlJczVONDk0K1NqT2JRV3RqVHVBWnRnaTJVdzJoYjlhb25QcGVLd2Z4UFJL?=
 =?utf-8?B?ZG1xZmdZVVNseFVNNTI3NnJmcGlYVzFKbkpSOXUycEZhYndid2czN1RwSE1R?=
 =?utf-8?B?S2Q4YVpRbVZzNWlDa0pqa3Mzd2dHTG1jVy9DOUduTzhlZHA5S0lRR2dhRldp?=
 =?utf-8?B?QWdtdVlUKzVMeXJWTk1CUUpsTEw2amF3SDhkVml4ZmdMYTJ3MWpnWmdIYkpX?=
 =?utf-8?B?dXZZUjRQbmJkRHd3OWJkOGREcElVY2RBc0FlUGlUR1FTdTJHc3A5UXpmbmZN?=
 =?utf-8?B?c0dLQTZyQ0xYaTJBZ0l0RnI0S2NUQlBPdFlkd1lQUk52VHA4Z0xGYXhXc2di?=
 =?utf-8?B?RmZZOGQwMklJWEFHYVRHU3RoVTRSL3JuZytkTk5kWk9yc2duUW96VjUvUlZy?=
 =?utf-8?B?Y2xYc1pqWnAzR1YyU1pVQWt1Y2ZRdk9EZ09hcjk0dGlTVUJ0SXovVUFBZUdJ?=
 =?utf-8?B?cjBPdzBPNjcxV29KZXZSVzlueHpwcExiOFBBZ2wxRHNKOGZSN1RBd0k1RXEz?=
 =?utf-8?B?RmJKWmxKWmdhM05ycVRzNm1TNlV2SGxPRGYyQkgxaHRWemFPR1RjV2FHRkZI?=
 =?utf-8?B?OWVoRFVXbTJZbEEyZE9sTy9uanhmbTlKU3Vld091aDYxZVBxbFpOeWFnL0xs?=
 =?utf-8?B?WTAxRFhCQXdrRTB3OC9vaW1GTXV5cEttOWdHMzYxSzNqSVhzandKL0t6QUlr?=
 =?utf-8?B?Z05UUk5xVDdSN2hCVkFGaWo3YUo4UEJmN3pHMmcreFhGZExGWUhBRDVLbjhE?=
 =?utf-8?B?NS9EOWNWQkdvQnl3YWhRRlRzUU01K0RlRjk4OGpRYUx3QmRKYVY4OVh5Yzlv?=
 =?utf-8?B?ZkdZNFFLLzB2NjJXSjJUc1drZmN3UitET25wZkQ1cnc0SnpIYUJlN09xMEZp?=
 =?utf-8?B?c1RPcnZFcWU5c25tbmZLaUJLYmxUNlFTN3BlK09UVGRJMlZjQ3F6L2FxVTFR?=
 =?utf-8?B?TWY5WlZydXdsTlovY1BsYzZjMzhKcENyZStJS0kyS1gyaThlTFY4ZjAyVkRR?=
 =?utf-8?B?dFlEOHd1b085YlVWUWZScmhlZG5rSFNsVnR3aDNvRVN3UE9qRU1zT1FiSlhF?=
 =?utf-8?B?UkpxRi9tRlVjTWlFdkhsWmpXSXZpTnFpNEdJOFFTL3RoRUorb3VzcVpiTXF3?=
 =?utf-8?B?bFl0ZGdJYmNqTVdUMlRNazlGc0l4V1MwRTgzK0pvaTR4akt3di9DMDl4eGNK?=
 =?utf-8?B?alBYKzZpYjYzY2hGVUhEQk91Z2U0S3phamZMU2s2WndCdUFhbVJIaXE4V2R5?=
 =?utf-8?B?N0IrMkNDY01BSnJRMTFGMG5LWjRZay8vdy8vby9mdkdDNlM1QjlLWnhEZ0ds?=
 =?utf-8?B?SzJUMFBzT1RWVUxJYWZDR0Fld05lV2xDL29ucE84ME1TRWxNb0ltT2xERmVa?=
 =?utf-8?B?dWx1clpkV0w3dDdLdDhlYjZ5RDJ5YUo4T3J2Z2xnWFYzMW1pb29TT3JBakov?=
 =?utf-8?B?RDJOTEg0WGlnSTUvL25tTnkyNHNiVUxzNjQ0MjRORXdkN3NOWm1iUEdPN3NZ?=
 =?utf-8?Q?h9qtqElkL63TDS/P8ppsVNddS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C356214FA6C3F4080309D9C79B2EE7C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86f1806-2f3b-4db8-acf6-08da690714c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:47:15.9883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gyc4hgX3EWcsnij8/bwW+bkDWQ+2GsGFlg4wRoj9sHz745niztB09tH6PoUeKUCjJ0ZOSGFnQdzmIbBRSK27VFzHCyIIfEqjzYNozsADfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6159
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDcvMjAyMiAwOToxOSwgS2VuIE1vZmZhdCB3cm90ZToNCj4gUHJvYmFibHkgbGlrZSBt
b3N0IHBlb3BsZSwgSSBmaW5kIHRoZSBkZXRhaWwgb2YgdGhlIGF2YWlsYWJsZQ0KPiByZXRibGVl
ZCBtaXRpZ2F0aW9ucyBvYnNjdXJlLiAgSW4gcGFydGljdWxhciwgZm9yIHplbjIgdGhlIG9wdGlv
bnMNCj4gKm1pZ2h0KiBpbmNsdWRlIGlicGIgb3IgdW5yZXQuDQoNClRoYXQncyBiZWNhdXNlIHJl
dGJsZWVkIGlzIHR3byB0b3RhbGx5IGRpZmZlcmVudCBidWdzIGJldHdlZW4gSW50ZWwgYW5kDQpB
TUQsIGFuZCBvbiBBTUQsIGl0J3Mgb25seSBhIHN1YmNhc2UuDQoNCkluIHRoaXMgY2FzZSBmb3Ig
QU1ELCB0aGUgcm9vdCBidWcgaXMgY2FsbGVkIEJyYW5jaCBUeXBlIENvbmZ1c2lvbiwgd2l0aA0K
UmV0YmxlZWQgKGFuZCBTdHJhaWdodCBMaW5lIFNwZWN1bGF0aW9uIGZyb20gcHJldmlvdXMgZGlz
Y2xvc3VyZXMpIGJlaW5nDQp0d28gc3ViLWNhc2VzIG9mIEJUQy4NCg0KPiBXaGlsZSBpYnBiIG1p
Z2h0IGJlIGF2YWlsYWJsZSAoYW5kIHNsb3cpLCBvbiBteSBSZW5vaXIgd2l0aA0KPiBtaWNyb2Nv
ZGUgbGV2ZWwgKDA4NjAxMDZoKSB0aGVyZSB3ZXJlIG5vIG5ld2VyIG1pY3JvY29kZSB2ZXJzaW9u
cw0KPiBhdmFpbGFibGUgd2hlbiBJIGxhc3QgbG9va2VkIChhIGZldyB3ZWVrcyBhZ28pIGJ1dCBu
b3RlIDcgYXQgdGhlDQo+IGJvdHRvbSBvZg0KPiBodHRwczovL3d3dy5hbWQuY29tL3N5c3RlbS9m
aWxlcy9kb2N1bWVudHMvdGVjaG5pY2FsLWd1aWRhbmNlLWZvci1taXRpZ2F0aW5nLWJyYW5jaC10
eXBlLWNvbmZ1c2lvbl92DQo+IDdfMjAyMjA3MTIucGRmDQo+IGltcGxpZXMgdGhhdCB0aGUgcmVs
ZXZhbnQgYml0IGlzIG9ubHkgc2V0IG9uIFJlbm9pciBpbiAwODYwMTA5aCBhbmQNCj4gbGF0ZXIu
DQo+DQo+IFNvbWUgb2YgdGhlIHRleHQgaW4gdGhhdCBwZGYgaW1wbGllcyB0aGF0IGF0IGxlYXN0
IG9uZSBvZiB0aGUNCj4gb3B0aW9ucyBjb3VsZCBiZSBzZXQgaWYgbm90IGFscmVhZHkgc2V0IGZy
b20gdGhlIG1pY3JvY29kZSwgYnV0IHRoZQ0KPiBhbW91bnQgb2YgZGV0YWlsIGxlYXZlcyBtZSB0
b3RhbGx5IGxvc3QuDQo+DQo+IEFzc3VtaW5nLCBmb3IgdGhlIG1vbWVudCwgdGhhdCBJIG1pZ2h0
IHdhbnQgdG8gdHJ5IHRoaXMgZnVsbA0KPiBtaXRpZ2F0aW9uLCBpcyB0aGVyZSBhbnkgd2F5IHRv
IHNldCB0aGlzIGluIHRoZSBhYnNlbmNlIG9mIG5ld2VyDQo+IG1pY3JvY29kZSA/DQoNClRoZSBt
aWNyb2NvZGUgZG9lc24ndCBtYXR0ZXIuwqAgQWxsIGl0IGRvZXMgaXMgYXV0b21hdGljYWxseSBh
Y3RpdmF0ZSB0aGUNCnNhbWUgYml0IHdlIHNldCBpbg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZDdj
YWFjOTkxZmVlZWYxYjg3MWVlNjk4OGZkMmM5NzI1ZGYwOTAzOQ0KDQo+IE9yIHNob3VsZCBJIGp1
c3QgYWNjZXB0IHRoYXQgdGhlIGJlc3QgSSBjYW4gZ2V0IGlzICd1bnJldCcsIHdoYXRldmVyDQo+
IHRoYXQgbWVhbnMgPw0KDQoidW5yZXQiIGZpeGVzIGhhbGYgdGhlIHByb2JsZW07IHRoZSBSZXRi
bGVlZCBzdWJjYXNlIHNwZWNpZmljYWxseS7CoCBZb3UNCndhbnQgSUJQQiBpZiB5b3Ugd2FudCB0
aGUgZnVsbCBmaXggZm9yIEJyYW5jaCBUeXBlIENvbmZ1c2lvbi4NCg0KfkFuZHJldw0K
