Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E02497E30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiAXLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:43:48 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:14895 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237737AbiAXLnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643024625; x=1674560625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bMBEh4/BAdOjbAg0uyss5Y21FQi0zY1KbYDQ+M2zoaQ=;
  b=ZD+v2j0KPgTkoGv5XGR8r6jKDxfG9h5DZa5jMeP72gKM+O77h1j/p+0C
   wXoKS3uh/+PXemBYMVnYWEjnNDfayiKSxie/x+mGsoR5V1yFZ4R4DJqG0
   5yVP3UxJDZbClf4V7ovSFiqFs44aMsUEP7zFQPFIIIO7uAD0RjpPruZdD
   PAf+ra5KnIpJZVoe6D4tEYHQpO5qjPek/CQPQvM4JoDeIGPsrJtzDb12t
   z74HuIUsFaf4/I19jifas0Gq6KfDwnE7fDhIEJkHKRqaQ6LL4OlmHZkpA
   bx2gCzWRBmmKiP+WTuXAVfepHw+FQfv5LVLlPfU/qNhGnnpkRzJc+l3Hz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="48062701"
X-IronPort-AV: E=Sophos;i="5.88,311,1635174000"; 
   d="scan'208";a="48062701"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 20:43:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je1lCbYAKeiP1rly9lNy0l5/VDxqDjKD6so71jPMFiOJhIpsQ9AgJ6v7vzDZio26IePcxvnEKkzrpbUg0zCi7zQgkIMjGF7w7rmy/+Tvr9ztKfMWmKUVAiqRzldcrl16PtXn8uMfXzTMzs0W+VBkuNDzNEaN3/F0VUxvWq/U8Gtm6sP1F1hsP7J8AE/qqnr5NKH+7B+8cZSmJhVYx9dxu2JK1AiSDKDFxAJGo28Jp5h+7ioeFIzLpA02QquLDu/6rrL/fMfqf0xcYXhWM0VbNArWlP8l/IVrEuIlwRx9+q1jkRABmh3bMxPnO7iAQoXKZqiMyanZnvv9HN20mkvw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fOnHaIrKUzlonJsAuoy9cT+fCQv+wEST9fv6/T0X5E=;
 b=ShrjVgS+xATPfx1feUFTcQmDS24AiKydiPf+aUGJ2QE0UyeVLFtPC7HyePojTuAEAs60i3GiARulaPfXi8pZFBlwN3vhoLUMRnmev8ZGn/xPXIOSbXzavIlJdkbu9hq3Y2ctAedTb5QfcUpIpvESOl+LpByblxUNQ2UPHce9Svn1yftvkaGHXro7SbX6NVjjwlV+k/8Cw3XFfoNRCM6HwT7QAbJjd/9i/EpsP9gqK+co6SDnrsscEZ+h4K1xRQCEUWJ6Y0f1+DSnU3CfNl4PJGXO2oGNj/2lYEsvrnTO5FDDMk8aDce0jV/epPVtUjlmSd2Psv8L67/bSVWfq+rtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fOnHaIrKUzlonJsAuoy9cT+fCQv+wEST9fv6/T0X5E=;
 b=WUGajDl4Udwa5k4yzcvIbidbu2N4cXEvQZBAr3pABKsjzM2mVLnMSoZimk8ZTyYOI/bVCVOKDi6bh/dPOKkIl6bKIiiG+RpLsO80WVT69LDMevMy2QU5GxFvVtT63DXRIRNEeTT0He5p6HLHMsPQgF/d15IhUysY/aDzV1fFQhQ=
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com (2603:1096:400:a2::7)
 by OSAPR01MB1732.jpnprd01.prod.outlook.com (2603:1096:603:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 11:43:34 +0000
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1]) by TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 11:43:34 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     Baoquan He <bhe@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     Petr Mladek <pmladek@suse.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Topic: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Index: AQHYBKVl3QVmCewphUe4SBvooFofu6xsF5CAgAHq+wCAAPE7AIADMVso
Date:   Mon, 24 Jan 2022 11:43:34 +0000
Message-ID: <TYAPR01MB650732FAB4E24D839DFF9EFD955E9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley> <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
In-Reply-To: <20220122105514.GA18258@MiWiFi-R3L-srv>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-24T11:43:34.045Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: e3da4bb1-6c09-06c6-472e-d771d233e10c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e002f3-c43b-4b38-670f-08d9df2ec0e3
x-ms-traffictypediagnostic: OSAPR01MB1732:EE_
x-microsoft-antispam-prvs: <OSAPR01MB1732E3F2B61548A575DD9C2D955E9@OSAPR01MB1732.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+IRGRQM1hFhMlRg1ofdKS8Ri3zjqoYCDhFkHeLCLecGgiJE0sXUv4MIyIfgRQwHXsGkfK/A8CczRm+gUCDrjREtzAJT3pNMIQXqTCUIrFPqJIm7dIMX+BYaVTIQSKopSL0GbLwDRvTI4iF0X99ExxaP9z1NZMrIEfRe6oC5hbDjWsEUgLBOwDli9C01Sd1cd9/1fSSZ79ee8On1C371OeeDGTF+RLOk1i2ObhMFOlrexyw/jTaJsnpaoG0iJM8jdzORJwWaSR3/dVgGJWKho9x3i5hrLsXYrPR3qOOfP6fkfBq3eZ65CuwpjDbrHutgvt9lxEN2WH/Klk7hXn5f40s2XSmA25aSgLOF5rNMnxrH4A6AKla4H+K31obFy3pnxs3JSsyB9rzOu3ZDFsX0UpD6nnUAFtQI2yrbeXtwQHYqKRmBURrxcd5OiuRVICbb9VkoJ0QL6mXWKUdAhFAQPSQ6N2kYIqOLabMK2VL9svSz0oweKvT1gJx5FVHEmWUWygxYPE6O9ffJFO+/C439RUOAYGkm8Lub4oTUblMUpRugsYjJiaM/NMf0iraItKZ73RYIMr5yv4pAQv0aMEJLf2RaqG4+BS9xIWwZlAdAzIBfBBazE07sh+3Llp6arvE2D/HsVox6amB9XTfHNBmDAzPTxBS4lvQt/yLEvt3PGGbawPOpmJSHxwlhNbi6dwgfKT1XMclKawJgiGhGD2JTCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6507.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(7416002)(316002)(33656002)(110136005)(54906003)(508600001)(55016003)(6506007)(7696005)(107886003)(83380400001)(8676002)(8936002)(38100700002)(26005)(86362001)(5660300002)(122000001)(66946007)(52536014)(2906002)(4326008)(9686003)(76116006)(91956017)(186003)(82960400001)(85182001)(71200400001)(66476007)(66556008)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ditlZSsvYS9KazlwaGZmZGhpaHRWQ0xhRWZjTm1SVUdrZkVwWVlEbkkz?=
 =?iso-2022-jp?B?b1ZrUjU0RGxHdVUzNnhXeGZHVEhWQW5Cb0trMEdoUmFRelJtWFRibXFn?=
 =?iso-2022-jp?B?OTlUeHNFNThKaDhpRzA3c1FvSkF4cEx4QzlBaW5qOFYvcDdqRlJ1RTY3?=
 =?iso-2022-jp?B?U2RodzJrZmFTeUIxUjdJcHU4RmUvdTdQTERqSXVJUzFOMVBjN045ZXE0?=
 =?iso-2022-jp?B?L05xRkRSYlpQWCtOTzhTc2lIMEdnQnArSFkxZkJBVTFwaEFjNlNWS3lo?=
 =?iso-2022-jp?B?STZvQmRhNCs3QUM3QlNCQ2FjNWF1T1dGMGJuOWJJWFRXVWRDaTNJaUJS?=
 =?iso-2022-jp?B?T0M0NDVJOEszeExvVi9ETFYrNzRIaStKOGp2MndUaUw3Q1k0WUtsTFZp?=
 =?iso-2022-jp?B?TFJRNGJkL0V3UU1xQXJ2VlhHb29VR0FqaFRKc05OSGJlOHhTMHFJWWZ6?=
 =?iso-2022-jp?B?OWxFZ3lXWWhZbWFCelV2NTF4UjRtUVo4TkR5d1JRTEVCYkp2ZDY4ZXBO?=
 =?iso-2022-jp?B?M0d1M3pVK2N1OVkzNTcyeDBzMkJ0ejR4OXFiMHR6RWtCNGxkUlZYYTNy?=
 =?iso-2022-jp?B?bUFQeU0rTDc4MGpicmNnRDc5K09FWm5nbDFpdjhMSW1vRmhOT2NVK3JL?=
 =?iso-2022-jp?B?dFlzYTVEYVI2VDZPR0t3RjltSTJNbEE5aVJRR2VuTFAzNU5EcTZ1OXg3?=
 =?iso-2022-jp?B?Q1gvV0pwM2NUTGhuQ0dGVUQ1ak4zYnZLNzNiVjk3SmFBNGlRd0lMR3A0?=
 =?iso-2022-jp?B?TkdvNDZkeXQ0aDk2djUreDAvUUFGREwwN3JZektDSHVEbi9VeTRxTFBv?=
 =?iso-2022-jp?B?Y2xPOVJJbWU0SytwL0dNNWVGdjlYZ244SWFDWCtuempvRFdSSzVlaUIy?=
 =?iso-2022-jp?B?cGpWOHRNUzMvMUdEemtpNEVienBueTZhR2xRZ3k3M3hDR2tkV05vamI2?=
 =?iso-2022-jp?B?VVJhVTBuTjE5ME1xQUY4QmhLRVU0eUxUNTE0TjJ2TVVTN3JCangvMWpp?=
 =?iso-2022-jp?B?YS9JOVBxZXArczRSa1k5QW5lZUsvTlNFeTkyT3AwVEZSV21MSDhhRnNP?=
 =?iso-2022-jp?B?dmRCbHFZbk1BVjFtcklNMDJ3dDBJSU5UMzNsYkRHOENxZXQvTC94WDh5?=
 =?iso-2022-jp?B?bmptUmwyL0xjVEQxMS9wSkorR0d0T1JsQ3Fkd3lQRkk4QnA3VmJycm5E?=
 =?iso-2022-jp?B?enJBRmtTcTdSRGRkZzVhbS9DL01paVQrbXRRaDF4ajJQS0dKb1pNbUd2?=
 =?iso-2022-jp?B?dGVxeVhJSHRnN1pPMWsxNTM2amFiZXVRbk9IeFc4Q29FVWVnZklZMWVs?=
 =?iso-2022-jp?B?REhZRkdhcS9NVVZyL2Y3eW00Mk9GUURWQzRVSkFlbDFwNjlEVm9rVU04?=
 =?iso-2022-jp?B?TFJyM2hyeHhwZzFiZWE3Nk8xMlhPbjNRRENydHJLOFJxRnpOZFpDclgz?=
 =?iso-2022-jp?B?VXhwSE9ya1Y3VWV6V3ZST0IreGYyV2twdTMxck13bmlKTEV6VFNKbm5X?=
 =?iso-2022-jp?B?U011dFBhTHRqQlFkU01NeFJBQ0YvVCs2bzJTODE4c0J5QTR5YjdEcHFx?=
 =?iso-2022-jp?B?VEZUS2U4NFg3NTIxZHkwNHhJTnVyKyswV0JjcU9WYkRnVVNyUmdkclA2?=
 =?iso-2022-jp?B?U3VlN1dGak1YTVJQdCt1QlRXVmorb0pKNThUUTZXTWY5NFZqSlFxSEhL?=
 =?iso-2022-jp?B?cFZ4NTJEcFloQU4zQUlNN2FSQnJyYU1VQnY1ZlNMSWJtRzg4b0JoL3k0?=
 =?iso-2022-jp?B?Nkx6NG52aEorbzkySGJFWXNtT1U0U1BGcm83emY5RGFkdmFFbEFlQ3Nu?=
 =?iso-2022-jp?B?OEFvdkwyQW04M2l5K0VaMGJQZ1dlUTAxZWVscGQyUzdQKy9tRUdvKzVw?=
 =?iso-2022-jp?B?K05walovUENiTGpuOHFnQ2ErNi9vbUY2cXBOMmlpRnpaeDBhbjdvS2wz?=
 =?iso-2022-jp?B?K2dUbzZxSmM2bHl3MG1XcWhZTnptZmFuR0V6YkNiTXpVUkViVEpxQzRk?=
 =?iso-2022-jp?B?dmVxMjNiYUtnWHJlM0UwNUpVTTVuNVhYcG85V25rTVVxVG5xYlMwY3Jm?=
 =?iso-2022-jp?B?QjkxTEc4V2RvZnhmNjVnQ1VJeFRLQ3dzRVBTSGx5Z3lPYTF1NldqbWsw?=
 =?iso-2022-jp?B?M1BnY1ZGc0EvTWdrZWt1MEV3SmlHOUhURXd2YjJtUHhldWo0N2I3a045?=
 =?iso-2022-jp?B?RExWMklLeVZrMTREOG9UMlU0bHRmMzZFcEVkYUpVdGs1TjNZNTBZMjl3?=
 =?iso-2022-jp?B?V1FuZW5LYTNTcXlsSGJtRE1oVHZaNEhvVWRlM2RxNUFwdFV0Yk00N0p6?=
 =?iso-2022-jp?B?dlJtbXZQQkxtcC9ZbzlrOWxVb2JLSEFqWlhpZkozZUhTNno4NVhBQ21h?=
 =?iso-2022-jp?B?WjA4VGlZSEgwUUdVMWpCTXN3NnBZcFF1ZXZzSkFrTmUzMkdzSnhtQjVv?=
 =?iso-2022-jp?B?UXQ4WGVRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e002f3-c43b-4b38-670f-08d9df2ec0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 11:43:34.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgUPnu/l/Zo1hcpxEjOtFQfSImzYLDClmefbNTgmQuGHVfwutaNmqiYfGz9fNMrSGHcJVgJYmS7r0wH7TnVf7vTkDsnw8ejpW9bmExgU3gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1732
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
> On 01/21/22 at 05:31pm, Guilherme G. Piccoli wrote:=0A=
> ......=0A=
> > > IMHO, the right solution is to split the callbacks into 2 or more=0A=
> > > notifier list. Then we might rework panic() to do:=0A=
> > >=0A=
> > > void panic(void)=0A=
> > > {=0A=
> > >     [...]=0A=
> > >=0A=
> > >     /* stop watchdogs + extra info */=0A=
> > >     atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list=
, 0, buf);=0A=
> > >     atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);=0A=
> > >     panic_print_sys_info();=0A=
> > >=0A=
> > >     /* crash_kexec + kmsg_dump in configurable order */=0A=
> > >     if (!_crash_kexec_post_kmsg_dump) {=0A=
> > >             __crash_kexec(NULL);=0A=
> > >             smp_send_stop();=0A=
> > >     } else {=0A=
> > >             crash_smp_send_stop();=0A=
> > >     }=0A=
> > >=0A=
> > >     kmsg_dump();=0A=
> > >     if (_crash_kexec_post_kmsg_dump)=0A=
> > >             __crash_kexec(NULL);=0A=
> > >=0A=
> > >     /* infinite loop or reboot */=0A=
> > >     atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, bu=
f);=0A=
> > >     atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);=0A=
> > >=0A=
> > >     console_flush_on_panic(CONSOLE_FLUSH_PENDING);=0A=
> > > [...]=0A=
> > > Two notifier lists might be enough in the above scenario. I would cal=
l=0A=
> > > them:=0A=
> > >=0A=
> > >     panic_pre_dump_notifier_list=0A=
> > >     panic_post_dump_notifier_list=0A=
> > >=0A=
> > >=0A=
> > > It is a real solution that will help everyone. It is more complicated=
 now=0A=
> > > but it will makes things much easier in the long term. And it might b=
e done=0A=
> > > step by step:=0A=
> > >=0A=
> > >      1. introduce the two notifier lists=0A=
> > >      2. convert all users: one by one=0A=
> > >      3. remove the original notifier list when there is no user=0A=
> >=0A=
> > That's a great idea! I'm into it, if we have a consensus. The thing tha=
t=0A=
> > scares me most here is that this is a big change and consumes time to=
=0A=
> > implement - I'd not risk such time if somebody is really against that.=
=0A=
> > So, let's see more opinions, maybe the kdump maintainers have good inpu=
t.=0A=
> =0A=
> I am fine with it. As long as thing is made clear, glad to see code is=0A=
> refactored to be more understandable and improved. Earlier, during severa=
l=0A=
> rounds of discussion between you and Petr, seveal pitfalls have been=0A=
> pointed out and avoided.=0A=
> =0A=
> Meanwhile, I would suggest Masa and HATAYAMA to help give input about=0A=
> panic_notifier usage and refactory. AFAIK, they contributed code and use=
=0A=
> panic_notifier in their product or environment a lot, that will be very=
=0A=
> helpful to get the first hand information from them.=0A=
> =0A=
> Hi Masa, HATAYANA,=0A=
> =0A=
> Any comment on this? (Please ignore this if it's not in your care.)=0A=
> =0A=
=0A=
Thanks for CCing to me. I like this patch set. I have same motivation.=0A=
=0A=
For example, when I used crash_kexec_post_notifiers, I sometimes ran into=
=0A=
deadlock in printk's exclusion logic during the call of panic notifiers sin=
ce=0A=
kaslr outputs kernel offset at panic by dump_kernel_offset() via panic noti=
fers=0A=
(although this might never happen now thanks to lockless implementation).=
=0A=
=0A=
The problem is that in the current design, we have to run all the=0A=
tasks registered, although most of them are actually unnecessary for=0A=
other users' requirements. Each user wants to call only their own handlers=
=0A=
in order to keep kdump as reliable as possible.=0A=
=0A=
I've just started reading this patch set and have no other comments for now=
.=0A=
=0A=
Thanks.=0A=
HATAYAMA, Daisuke=0A=
