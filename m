Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E6575ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiGOJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGOJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:51:21 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 02:51:19 PDT
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DD7AB21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1657878678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e3bbx5rylSNKU/LPywsvKq7scNIXTXJNf/37NymovyU=;
  b=UF4H/gJGnHyCltVPCorYh2SB3737YcAPQtBhdB8UECP9IM0pFNQeo5o+
   e5kOmBo9Vee5/8Q0Gc63zMLJIE9V0d0WsygI/ghg3TvY2/PWRkWr8/3Md
   wmUW2r8bWcvzOBF8qgdVK5ef8Od7MpQKYZ0iU/grfQW9vvisA9kY480dc
   U=;
X-IronPort-RemoteIP: 104.47.55.172
X-IronPort-MID: 76298642
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:UyhfnK7LY+DKRILfXb37BwxRtBfHchMFZxGqfqrLsTDasY5as4F+v
 mUaXz2APfbZYGTze9pxPtnipE1Q7MCAzoBmTQY4/ylhHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yM6jclkf5KkYMbcICd9WAR4fykojBNnioYRj5VhxNO0GGthg
 /uryyHkEALjimQc3l48sfrZ8ksw5amq4Vv0g3RlDRx1lA6G/5UqJMp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VSKlLgFVHmZkl+AsBOtiNqtC0qupvXAdJHAathZ5dlqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJGEtbZco4953Ozlx3
 PYcFwoiTTeyhv3jldpXSsE07igiBO/CGdpF/1tGnXTeB/tgRo3fSaLX49MexC03ms1FAffZY
 YwedCZraxPDJRZIPz/7CrpnxLvu2ia5LmAe8Q3PzUY0yzG7IAhZ+b7hKtfKPPeNQt1YhB2wr
 WPa5WXpRBodMbRzzBLarCj91rGTx0sXXqoOLL25yu9422e4mElJFA0ddX2nuNSm3xvWt9V3b
 hZ8FjAVhaI17k2wCN7mQwe/vmWHrzYbQdNbF+B84waIooLQ4gCEFi0HQyRHZdgOqsA7X3op2
 0WPktevAiZg2JWXRmia7ay8ti6pNG4eKmpqTTMLSRst59jlvZ0piRTOXpBvHcadi9zzFjbY2
 T2GrCEiwb4UiKYj3b2T9FTGjjT84JTEJiY57xvaGGKs6Bh0YqahZoq1+R7a6+pNKMCSSVzpl
 GhUxeCd4foIAJXLkzaCKM0NBLiB9eeZNyeaillqd7E67Cik8XOneYFW4Rl9KV1vP8JCfiXmC
 GfUvQ5S/5ZVMGGdcb5sY4mxBsIpyoDtDd3gEPvTa7JmZ5h8ZQmK1ChrbFyX2SbhnSAEk6syJ
 JOaesaEFmsBBOJsyz/eb+wa1b4tgCM/w2z7RJbnwhDh2r2bDFaFRLFAPFaQY+QR6KKfvB6T4
 9tZL9GNyRhUTKv5eCa/zGIIBVUDLHx+D5amrcVSL7SHOlA/RztnDOLNy7Q8fYAjh75SiurD4
 nC6XAlf1Ub7gnrEbw6NbxiPdY/SYHq2llpjVQREALpi8yFLjVqHhEvHS6YKQA==
IronPort-HdrOrdr: A9a23:e7Ezd6CVM6jEf/LlHegPsceALOsnbusQ8zAXPh9KJCC9I/bzqy
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
X-IronPort-AV: E=Sophos;i="5.92,273,1650945600"; 
   d="scan'208";a="76298642"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2022 05:50:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRSOFA5rYVHwIJXfSWY7ghHRTfCd2bZucz8hX6HSkzKSYGhz5AGXkyTkhzKQmTuU1DvdQS9tDe/aV0/aiOR4ejkeXIN04xipd0kxmnLjuDcpcbmPqzvnrJABkPbDkKT9VGY70y8TZ+Pago53ajpjv45hNgdgf1iP3rmwIkUJOs6ZcsF/yiuM3HUlP139ksXywVqjaDhE750SIUfhlGoQsfO1gJZ/ZJhF2ANRF0DZ0+lbqwRe0ylDvzBHlf18To2OJocjGTqwKG/T45ImNT7jZCj73U00mnq+qddKWZwVWw5TTwSGUKIOAtvkrx6Wk68GFgIKdFcY90xof5BS80XLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3bbx5rylSNKU/LPywsvKq7scNIXTXJNf/37NymovyU=;
 b=TOEgel9hJgapPoK9KESfJYdoTc/u96uokVbZ9j1xRN5qdAecXajsGef9yvbCD16ELz4A4isA0+KAODnU+Vw0DBVWsG7O3IJXiHJ9hJxk+0PEzqO6H90mOS8LiOaFrkq4FjRany8oHWnkXoe8anXGbKxD/fIkLHLs/xNOVe5e60rZFbsi6+SDkL+lPw/oN03lV8H60g0ULJlxZmp90AwVwlxgt/GkKuyU3Muc7kPF9E4ACsHVLRHxiFDUn9UYWMwz+nJVu2uZS3UhfY1xGO8EeOU6P2qsJwM5e2CpkH6grccGO0TTUYZM4rB3Z5tlRPhqqAkgOG04Cov5f4J8b0L9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3bbx5rylSNKU/LPywsvKq7scNIXTXJNf/37NymovyU=;
 b=MzPVriiUTKxOTk1rZe3HNRVG89kJJiAclFBII/KeVjy+ngGI952a5Wf/qSE1tD+s7ZuXVH3Hz08/lBo506NQLbPr9thfZlSQA3mTU81TBDHwkoZALx/fvQRRiSoMkgzove8kVOEuzr/rszdIfR2j59vaH/q+wu1XgiUSzZdM4y4=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA1PR03MB6339.namprd03.prod.outlook.com (2603:10b6:806:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 09:50:12 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 09:50:11 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Jane Malalane <Jane.Malalane@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYlToncjhzapb0rEGq8Bkg0N3t9a189b0AgAImuYCAABmhgA==
Date:   Fri, 15 Jul 2022 09:50:11 +0000
Message-ID: <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
In-Reply-To: <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277626c2-9149-449a-da80-08da6647690d
x-ms-traffictypediagnostic: SA1PR03MB6339:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yfUbqdCwEuFpgWQ+dB0kWaTumNVtG6csgg4ZHxxK63gmxP1WlkjJp/mFqjIyPH6gPUzwS5K6TCmgeUuSRg4JKSzpUM3nsmK/ZwOlSrKX5lxtUkMen6jgeBwTHhxmQhfyIlmFOl/jKh4wbfs7Bg4TCSyOtn0jrl1+F8W2db/IgnNsNl2MDAz0TdQPrPk3RwpX9RaWCpktVvlnZ5G30EmI4yZQjp72vWr8urpw9fma6XQhh2Bfpw38kTr+2txTO2OsKLTrfqyjahH61p85J+04AlMQUJPoeAz6WhBvt2KugWgZjckJ4j8VGaceEeI4AbKaNl/gsmJgUgl/hWOWX3VEmLoETD2WxVE4fr1X/FTjoDISGrB7p39zhOLxSXoqeXWJvXqdvBNFV85Diy4v4q+wtNk/PdCNVeN+JBllV/8mAgArPu3ZSti38LM86TRzqZSihPVXKEj9dSJjv8EW5727QnWnyyEv59UfdYXJwXqvkaUrJzuRsQ/CeFj9VB+N39IKy4b2Kv4DUbZDX1KUOpzQbG3C2l2NGCdN8jz0ffKQMfCp8CRbwWYvrIBllCpd7y7izhrdYzxE8TnQuC4l7tRJaOmC7jHCufZsoynpfV2O3OWXEKpixbdr/KhxlY5/yiNiJyAcLEGMGttLGukRtdM5J+eIDgc2zx8Yf81Gwk5MQbXsR8dackI4oKgddIlZaeGG5nI8UxHJLbYuoSLC+g88O9azZrhIivC42HUv+UDrTsgLVg1meaXBsTFbXtOOPKtIcioV+m83Ig2dw7WL4+uaiIuofzTs2yjV7v9jy7kaGpkSJVh9H82nVMHudhCNZzwLtkLdIRhx4abTnLD83O0u5qxWKOUY8SHwSebeXTB9fxJJ6sgiUPZSgIBGwuYpAy7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(82960400001)(54906003)(66446008)(110136005)(316002)(4326008)(83380400001)(8676002)(91956017)(66556008)(38100700002)(66946007)(76116006)(64756008)(66476007)(31686004)(71200400001)(122000001)(38070700005)(36756003)(6486002)(7416002)(6506007)(186003)(478600001)(8936002)(5660300002)(26005)(86362001)(41300700001)(2906002)(6512007)(53546011)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDY1MUxGQTRCSytoeXZOZDBtdlZUMy9TS3dLWWZwcHF4VDdKY3NnS1lxY3Nx?=
 =?utf-8?B?MDhkVnltY01tYWhacnVlWlNrWWtUM2wrdmRYM1pMaHNDUDZNSHVCNG9ZKzl3?=
 =?utf-8?B?c1o4Y20rZ2NMeG01bzN2b0V5NG1ta3h2YTQvYXNzSjdmYytIT29vWUQyTlQ5?=
 =?utf-8?B?cmk5a3BUUDJBSmNnaHFsWHl3Z0ZIN1ZpOGFPOFFIZHdvZHpJbHAwOHZmUkRL?=
 =?utf-8?B?WmNzYlN0OU1Pekxycy8wWHd1aU5FMjlsU1A4WlFJdTF6dFZFTmJqQ2s1eTh2?=
 =?utf-8?B?ZUNRR2w0TTRYU2g1UFVia1NUeFBHbSt1M05SN1dQbUNja2lwdjYwT0xHbHZ3?=
 =?utf-8?B?Vi9nTFNxUkYzUWF0Q0RsbFREMUF0YTZPbFlPZ3owVGo5aWE4SGVCVzhDUVVL?=
 =?utf-8?B?R3lTTnQ2anl5bkhlUmVsZE90UTJiRVZmWWtvb0hyb3ppYXNDcVJyaFlZUDc2?=
 =?utf-8?B?RzRiY240MFBWeC8vOG5BUkdxUDBQSTYvU1V6cThHaXRhc2ZjWDQ3QWVYZ29v?=
 =?utf-8?B?ZUVESEw0U1gwcVdJZVZ3bmRGeTRZUGRwK3ZFRXBLTHltaUszbGQ0bkExa21Z?=
 =?utf-8?B?clE2a25lTk4rcmlVdS9XblhNWkhJREd6RUFUODIyM0VORkNNS2YxOGNHNXF4?=
 =?utf-8?B?eGtETlNUQlVlTWhuMWU5dkcrN0JHd0Z5QnczVkpGSEdmdzJxTjVzRUpHZUtJ?=
 =?utf-8?B?V0F1azRsRjB0UUNkN1FXem9Zb3FGakVJbUdqOUZKaU42MGhiNHJOd2dnUlpz?=
 =?utf-8?B?ZGZvcVh3MG5xZUx5TVVQMXdSMllteStEc3VKVjZWbmJRcXAwaGc2T1NwK2NU?=
 =?utf-8?B?cWt1dDc3d1dwMVdGTzdZWTNZN2xRMWU3WjRXci9TUlVMOE1rbmpLb2pBYjRH?=
 =?utf-8?B?QTJtc0ZtWW1qQ2QrOVZsK3JGNjNMN2VWNVRhK0pZWWlpK0tGM3NZUjNTbnNx?=
 =?utf-8?B?aWNsckhBTzJjNXU1c2lLVXZRczQ2OTRjYzhESHV1UFNWWHBTcUpGZGV6MVIr?=
 =?utf-8?B?ZVY4eFlNTGxLRlg2R0s0bG5VdzR4bnl0bGduLzdZU0lKVWJBN3cwRmtScUNP?=
 =?utf-8?B?cklVdjZ6VmZjWjhqNldXRThhNzRGYTdWUGh3WnBVekw4UVpPamJwVEJsUnp0?=
 =?utf-8?B?Y0Rkd2l4Und0NGZ2c2hvd280WDJhYmlzU0xzOGpHUjRrVGlZUloxa0tGM3ds?=
 =?utf-8?B?dlEwT20zbFVxN1p5bUZLanNMeHU1RE5qcDc3STlmWXFmQUZOem1SZ0dhbkpD?=
 =?utf-8?B?RVAwSlZqUUw4UEs1bHRlL2JjWHJhR0dZYlJKL3B6bFczTGlhSHdCRWRMazZa?=
 =?utf-8?B?M2FMcEpkOVM4eHBndUl0S1F5c2JSMHNqNUptVGFzZldyUjh2TDliK0tnQU1j?=
 =?utf-8?B?b0VhVko1Q0pibVoxOTlGaGJTYXhwWU9Vem5GcHlVTms5a0NqYXltTzVGdCt5?=
 =?utf-8?B?eGZoM1JKbTdDMC9pQnB1eTZYSG5Hbis5WnJZY1kwM3VEZkI5dmxCYmZCRDVJ?=
 =?utf-8?B?aFc2dVI4dDczbDU1N3pTSlV1dlBxc1JXYjFqeXFSRUdPVERNRUUwdzIrVnps?=
 =?utf-8?B?ZnFiRWZmSmpHSFBTcFQrRnFJNWtQR254Z2dUaEoyTGFybThvM1hsMjg2eFlo?=
 =?utf-8?B?akRLZ0RCUzNaMnRBOXB0Snh2RzE0UVdIRndPWWVXTkxrSHJsZGtab0R1RUJP?=
 =?utf-8?B?L0ZiMXBidThoQ0ZVNmdwZEpWM1N6WkZjN2x5UU9ML3pmREdrRkpaM2RQNzhR?=
 =?utf-8?B?VTZiK21FTHRBY2RqeXMxeGpidXQxTGdCVnFsTDM2VEk5anpzdVRuOXgvdW5Z?=
 =?utf-8?B?TkFWQm9MNkFVWmtTQVQxaGNsT092OVg2ZUVOV0twVkh4Um4zQlhrNThpY3VH?=
 =?utf-8?B?a09zS1h1TUUzSDBtOXM2Y1dKNVV4bHRoejRSV2haa212VXlEWFRHOE1zWkVU?=
 =?utf-8?B?UTlsdTRJeFc5ai84WkcvS3pEZGxmbVRoZlQ2Mi83RGhXWGZZSzdua2FFNHNi?=
 =?utf-8?B?QktNMkVPSEhhMWt3bTlkTUpoQXFxdjJVZDU3b09GRlB5ZTFRL3plemhHcFlW?=
 =?utf-8?B?STVyTitNTk4zb081VU51WWVzWDgvSVhhOWlad25sRnZsa1dUa2xBQkNsRHpQ?=
 =?utf-8?Q?3KmlNRgoPnYIyEkTJIElg3Eip?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE2E370D036E0745B1857A0736A386A2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277626c2-9149-449a-da80-08da6647690d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 09:50:11.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C86w2ArmZU3MMUgvnT2clwa4A9a40f8Oewr+JBs+7gkWgXcTvBN0v5z8DAtURLvqHFMqWdTBE8oNXeDocpJhrnSvyVnBlxrqajCd2YqEJEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6339
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAwOToxOCwgSmFuZSBNYWxhbGFuZSB3cm90ZToNCj4gT24gMTQvMDcvMjAy
MiAwMDoyNywgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPj4+IMKgwqDCoMKgwqAgeGVuX2h2bV9z
bXBfaW5pdCgpOw0KPj4+IMKgwqDCoMKgwqAgV0FSTl9PTih4ZW5fY3B1aHBfc2V0dXAoeGVuX2Nw
dV91cF9wcmVwYXJlX2h2bSwgeGVuX2NwdV9kZWFkX2h2bSkpOw0KPj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni94ZW4vc3VzcGVuZF9odm0uYyBiL2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+
Pj4gaW5kZXggOWQ1NDhiMGM3NzJmLi5iZTY2ZTAyN2VmMjggMTAwNjQ0DQo+Pj4gLS0tIGEvYXJj
aC94ODYveGVuL3N1c3BlbmRfaHZtLmMNCj4+PiArKysgYi9hcmNoL3g4Ni94ZW4vc3VzcGVuZF9o
dm0uYw0KPj4+IEBAIC01LDYgKzUsNyBAQA0KPj4+IMKgICNpbmNsdWRlIDx4ZW4vaHZtLmg+DQo+
Pj4gwqAgI2luY2x1ZGUgPHhlbi9mZWF0dXJlcy5oPg0KPj4+IMKgICNpbmNsdWRlIDx4ZW4vaW50
ZXJmYWNlL2ZlYXR1cmVzLmg+DQo+Pj4gKyNpbmNsdWRlIDx4ZW4vZXZlbnRzLmg+DQo+Pj4gwqAg
I2luY2x1ZGUgInhlbi1vcHMuaCINCj4+PiBAQCAtMTQsNiArMTUsMjMgQEAgdm9pZCB4ZW5faHZt
X3Bvc3Rfc3VzcGVuZChpbnQgc3VzcGVuZF9jYW5jZWxsZWQpDQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHhlbl9odm1faW5pdF9zaGFyZWRfaW5mbygpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB4
ZW5fdmNwdV9yZXN0b3JlKCk7DQo+Pj4gwqDCoMKgwqDCoCB9DQo+Pj4gLcKgwqDCoCB4ZW5fc2V0
dXBfY2FsbGJhY2tfdmVjdG9yKCk7DQo+Pj4gK8KgwqDCoCBpZiAoeGVuX2Fja191cGNhbGwpIHsN
Cj4+PiArwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGNwdTsNCj4+PiArDQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIGZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgeGVuX2h2bV9ldnRjaG5fdXBjYWxsX3ZlY3Rvcl90IG9wID0gew0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmVjdG9yID0gSFlQRVJWSVNPUl9D
QUxMQkFDS19WRUNUT1IsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC52Y3B1ID0gcGVyX2NwdSh4ZW5fdmNwdV9pZCwgY3B1KSwNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Ow0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUdfT04o
SFlQRVJWSVNPUl9odm1fb3AoSFZNT1Bfc2V0X2V2dGNobl91cGNhbGxfdmVjdG9yLA0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJm9wKSk7DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogVHJpY2sgdG9vbHN0YWNrIHRvIHRoaW5rIHdl
IGFyZSBlbmxpZ2h0ZW5lZC4gKi8NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWNw
dSkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJVR19PTih4ZW5fc2V0X2Nh
bGxiYWNrX3ZpYSgxKSk7DQo+Pg0KPj4gV2hhdCBhcmUgeW91IHRyeWluZyB0byBtYWtlIHRoZSB0
b29sc3RhY2sgYXdhcmUgb2Y/IFRoYXQgd2UgaGF2ZSAqYSogDQo+PiBjYWxsYmFjayAoZWl0aGVy
IGdsb2JhbCBvciBwZXJjcHUpPw0KPiBZZXMsIHNwZWNpZmljYWxseSBmb3IgdGhlIGNoZWNrIGlu
IGxpYnhsX19kb21haW5fcHZjb250cm9sX2F2YWlsYWJsZS4NCg0KQW5kIG90aGVycy4NCg0KVGhp
cyBpcyBhbGwgYSBnaWFudCBib2RnZSwgYnV0IGJhc2ljYWxseSBhIGxvdCBvZiB0b29saW5nIHVz
ZXMgdGhlDQpub24temVyby1uZXNzIG9mIHRoZSBDQUxMQkFDS19WSUEgcGFyYW0gdG8gZGV0ZXJt
aW5lIHdoZXRoZXIgdGhlIFZNIGhhcw0KWGVuLWF3YXJlIGRyaXZlcnMgbG9hZGVkIG9yIG5vdC4N
Cg0KVGhlIHZhbHVlIDEgaXMgYSBDQUxMQkFDS19WSUEgdmFsdWUgd2hpY2ggZW5jb2RlcyBHU0kg
MSwgYW5kIHRoZSBvbmx5DQpyZWFzb24gdGhpcyBkb2Vzbid0IGV4cGxvZGUgZXZlcnl3aGVyZSBp
cyBiZWNhdXNlIHRoZQ0KZXZ0Y2huX3VwY2FsbF92ZWN0b3IgcmVnaXN0cmF0aW9uIHRha2VzIHBy
aW9yaXR5IG92ZXIgR1NJIGRlbGl2ZXJ5Lg0KDQpUaGlzIGlzIGRlY2FkZXMgb2YgdGVjaCBkZWJ0
IHBpbGVkIG9uIHRvcCBvZiB0ZWNoIGRlYnQuDQoNCn5BbmRyZXcNCg==
