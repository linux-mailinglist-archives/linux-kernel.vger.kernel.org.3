Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5E49C9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiAZM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:27:26 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:36644 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241262AbiAZM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:27:24 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 07:27:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643200045; x=1674736045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OFAtGKajsQisICOD77aDydL4d5I1gzw6+q3/UZpyCTY=;
  b=YJI8gxs82xuh2eLerucSOUp8uHcCH6/Mst6jJhnm9ZoawH65xrhq41dJ
   yxZT74KkR6BELgofujgKykb1ldU0Xc5P5PU0/HOBeATjBgx8gf2j5lKyp
   d5YypKTPntRMpDwf5OZAjzNEXFOhbyyy2TeHaFgvIjurDiCiuMEIkZiJk
   KKhUUt/U8NvjkhVEFjizUPIKjS4MuFL8FmpGxuld/KPcDPKjbC+KJdlSU
   SsKnhDKoj6oeuIbZ1MS46v7zmnLXkX7GgtdXARwctZ7w5XcctfyoZv15l
   OOUXdL5cn1VgX6Lb49e+0T6mvVW8tAdZnpR9wqTxLkS8iB6LEYUfwwswB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="48556420"
X-IronPort-AV: E=Sophos;i="5.88,318,1635174000"; 
   d="scan'208";a="48556420"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:20:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTYkIRM2IusWsvT5VL3OvjI14zVxsMhPos7Z4EoGiLFHTD9ikGL24SNEb0fIVaefIrsg3B+xWctgJMWdCXWzJkxeIfBTo1nRt5DBxA4mYt5ZDdspZmoFW+eHtVXsC03quKr90Foyo7GYMORFGAjH9d/F6UqDc1i3IyOUMOcC2AsrMkAuqqUKcObgExRc5zXKVbt/thH3n6/ijjJA0ynyxI+c0QxaoGcYnD+UbfB5EDS2TAJDVeC1DaUN91YJltHQDUUeGUt5YmaNfOBbZdVUfJL85ZFXgke7FYZKF/l3e7RKxttmpmkVvOXqAhU6OGLSOlwBhBeOIQcQxXm6CINUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFAtGKajsQisICOD77aDydL4d5I1gzw6+q3/UZpyCTY=;
 b=O/ICUokRladdCgXlU3cnPVdVyxGaAr1EzKezD4HIJQSo6GPIiOW3b9awDjhk20QUAH/alXyhUkqqNMag6RPPJm28GKvh0XRPfIRopTMwvLERxPqeXoeRhbKXEfIpYZPTR9f8KKUBJ6lDvCx5Xz6C7l0qHCdm+5QvLYuUyc/teWIJraRHejH6Qn8CgFLhNcmfWBc/KcTP1PWDh5O8Q7CTw60IDOZyZ21UNxVrOGFb2lON/zpsecfRop+oPNWbBQGPdB4km7zEIbYG74i3rIoxA5FNxE73U5YhJr3RdMcoB0JSFrEQrinboBOrDLSS5K4bo5b2otCMDCKRbo+U2lRR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFAtGKajsQisICOD77aDydL4d5I1gzw6+q3/UZpyCTY=;
 b=iEuHoBd6W7s9mSyNseTcA2VGxo0mACNuwnrSTn2EbeMu4OX1DR2gIEEnh9qigB1gN8YBO9vhQSJzJcKTVaYhlyNmQIY05bHPytvJEi8oJ/mQPVgstJbNsT1GBtu2dIefdHpD89/Nl656hNuxkaWNKYY1t0QLZLkheu2wjDqPOQA=
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com (2603:1096:400:a2::7)
 by OSBPR01MB2614.jpnprd01.prod.outlook.com (2603:1096:604:18::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 12:20:02 +0000
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1]) by TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 12:20:02 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     Baoquan He <bhe@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
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
Thread-Index: AQHYBKVl3QVmCewphUe4SBvooFofu6xsF5CAgAHq+wCAAPE7AIABtzOAgAGg0QCAAA3jAIACYZ+AgACY89k=
Date:   Wed, 26 Jan 2022 12:20:02 +0000
Message-ID: <TYAPR01MB6507D068393A20E075F041FF95209@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley> <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
 <20220124135902.GB8305@MiWiFi-R3L-srv>
 <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
 <20220126031039.GA26064@MiWiFi-R3L-srv>
In-Reply-To: <20220126031039.GA26064@MiWiFi-R3L-srv>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-26T12:20:02.180Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: a393a557-82aa-5524-be36-8ccdcc540b47
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03150210-10f5-4377-d438-08d9e0c62de5
x-ms-traffictypediagnostic: OSBPR01MB2614:EE_
x-microsoft-antispam-prvs: <OSBPR01MB26147568EA0229A5B8A7B9F495209@OSBPR01MB2614.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYrEp2VDU/gqAxhlE3KaiwPfKGxyY24fgwGvjcS8gF6SBZtPhUtPr3KGQFnP/yy+W4oFgVK5ZBL6jZWwvakGiK3HVrG9ntTn1JuU0aEZ6ohZZGwmX6QecsKr/FS3/krFDx3Eig4iVjkQE3TbwYnXnNxtI4+zYOn1GLSDqujHhv9/JbT6hVseZfinL79gMl5vhI31ujfKiRmUS3xHpetfcAce1zyo6oZCvxAtJGXttYvzHEK7scHA/iwKt3fuGCSPZAIEBftSfYDNpR8EunlsdaanytAlYxPgpJh/NThgx9UWOCT4XimCGWzWbYFmAN06DcM8zjhHqGsi726UX317ppeTCeHWwbiGNjzKTQyfxENBk5k8yocXoFHVRmgZLBCKOLW3rFIGYUnpcpzJIqKHQ4vRA8MfiV4hVHOQG5S6Hf5a8ecAFb/wc/rkLDGo6tqJiYpCyoLalaWStZlxBfNAN+qeYSO1pAij84Y73mGcoI8uwtpcyI8btrvaM0ixzBD0uDEjHblutu61dneSBbeJSbwcZOsxyL0J7iZv3SPWHcsQUEYYtRolGLTZB7gRkEjZALrojAlv65un5f5Ea9jHWImDCCyVZTwAV5XpWLwt0CICh1DE257utkThriBNwnpEMJ/aiNbRFbiEbQA+qjO6moSC0FLCukksV9VGxYDfqMhz0PmkIypMnLKlFlkLYnozcmvpBj7jQs9sM2j3iPJr0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6507.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(71200400001)(6506007)(66446008)(91956017)(66946007)(107886003)(110136005)(8676002)(54906003)(2906002)(316002)(76116006)(508600001)(85182001)(64756008)(55016003)(66476007)(4326008)(8936002)(66556008)(52536014)(122000001)(7416002)(38100700002)(82960400001)(86362001)(83380400001)(38070700005)(53546011)(7696005)(9686003)(33656002)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WTdCSWNxUmI3Q2ovMFRoSHJLMnJIMlFkKzlyVjU1a3g3WVRNblZmSVMx?=
 =?iso-2022-jp?B?ZHIrQTFvVWtiSzdSaVJoNENRT2ZmQzhEaDVlSXNlOVRSdFhWdFpocnA4?=
 =?iso-2022-jp?B?b0dnbFgvZ1k3emE4bmc0S0Z0cC9scWdNNk9aSjRGd2pXNElLWnFMMEdT?=
 =?iso-2022-jp?B?QU1aSXoweU82UWZraGlFQU4vVnZJeG00N2tQeGdVQTUxaTdaYlJadVhL?=
 =?iso-2022-jp?B?UXQ1VE9lMjQ5QzBldTBPYXNNaml5YlNLdUxsa2JFd2c0eE8yZTdKZG1w?=
 =?iso-2022-jp?B?Qlk1c2VoSFhab1NvRHExeEJndzdibVpxbFQwMzFXNVI4OUFCaUJ2Y09W?=
 =?iso-2022-jp?B?YlVibTFkWXlMaHQ4NWlkU2h6STBXd3MzbHJxZDZrOW95V29RR1ExVWpl?=
 =?iso-2022-jp?B?QXZ1eXEzWWYvZms3cGx2bTYrcFVtL0ZydC81QzRlbENMRVUxSldlMzNx?=
 =?iso-2022-jp?B?YlU2bU43MHY4cHpoRHplaU0xWlRWVzV6cDAzb2d6R3hrUGxwRk16OVFr?=
 =?iso-2022-jp?B?MVNJdUhGakV2YisxQlJtZUppZkdIRCtCL3ptQU44d1BRQ3VjY1VjWjVo?=
 =?iso-2022-jp?B?K29nQTNyT3d5aXhoUnhMS0tjRElHbDh3bUVDaDFaUnJWbVMxRlRSNWJj?=
 =?iso-2022-jp?B?T3hyN29JT0MrTy9Wa3NVN1k5QUJUMzk5NVE3OWxxRzZzZ1l6dFMvRCtS?=
 =?iso-2022-jp?B?NGhtVXdYMVNIS3ZVNzh2ZUE2RzVxTU8rU2hGLy9zbE92clg2WVpucG1s?=
 =?iso-2022-jp?B?MzNkL1loR2YwS3JFQVQyYXRIQzRMTS8veklPQ04xUzZLdWpWSFdTNEhD?=
 =?iso-2022-jp?B?VG5hRllGeHNTVWN5bllXM2hLNFo5c05tSUcwNVNLY2xaZlFPNUZJVlpD?=
 =?iso-2022-jp?B?WXo5Wkc5Vjd4S2hZMElkS054L1ovQjNreGRLOVN6NU1zZW43L3ZmeEwv?=
 =?iso-2022-jp?B?RUh1SlB3U0tyUEJjbGQ1TUo4K2IxQWJHbnM5ajhkNThhWVZWUTdvRFFr?=
 =?iso-2022-jp?B?SElEZllkczhYSW5GTXFmNEtCNzhLcTRXaFQ2d2hNRjRNQURvV3BZbEhN?=
 =?iso-2022-jp?B?SWVzTnlVUlNiZlhFdno3cWVZVEVoaGFxLzAwbk9sbGN4dFVST3ZHSW9p?=
 =?iso-2022-jp?B?aGt6aEdiSlgzVnBzcG1pcU9GRjVwOG5kbG1DZlg4WG91QnZvZUo0Mklj?=
 =?iso-2022-jp?B?eEdyd05sR1dQM0IycldTb28ycHBrdEJjNzhPSm4rczZhM3VvQk5Edlpk?=
 =?iso-2022-jp?B?K3pQaE4xZXhjems5WlBqZHNpV3pIOHFxaVd4V1pEai9QdVlQMWxwN1pU?=
 =?iso-2022-jp?B?UndvbFZMM08vTFAxZGphLzkzTjUzdXY3cERzSUhLNXAzYjM1TjRTMWdu?=
 =?iso-2022-jp?B?NkhyRjhJTTR4YUI5U3l5cVk1bzc3blhGWkNJeGRlWEtLWjR4VnUxY1Rr?=
 =?iso-2022-jp?B?V2sxbVNOaVZzM1h4WXR5TkxERlU1WWFPc2ZhbUxxZXhGSFNTcWhiLzZw?=
 =?iso-2022-jp?B?amFBem42WGd4UkMrMVRyMmZqamNEb1N4OUZhQzVWZkIvWDNCSVEvNTdR?=
 =?iso-2022-jp?B?S25yOHNpTEdCY2M2ZmZNQnQ5c0lwcmxEYnVQRGJ3bCs1Rm1QZ090R1lM?=
 =?iso-2022-jp?B?a0RObUVGNjVwNHBNdXMrbW56NlRvaHN2em5vbEVMV2ZJamQ0cEM0a1Vz?=
 =?iso-2022-jp?B?OVc3cEF2TndCS1JCVWpyeGYvUHBXR2gvYkd6dGY3VGxvbnQ5ZXVmRkNl?=
 =?iso-2022-jp?B?bndvSVVUV1hlcVZQYU1NdDdHbmhXSHVyMnI2aGVaU2ptM1kxRTIyaDFO?=
 =?iso-2022-jp?B?UjFRamFzeHduY00rWWtuTjZiRy9OQjZJajBYeU5JT3VFMHJpOVFKUS9z?=
 =?iso-2022-jp?B?VDBpMngxSEIxdzZpb29yeEFkUFB3d1ZCUEdBR3ppclVxM3p3SUtERUZU?=
 =?iso-2022-jp?B?VytXaGNNbmQ0c0EyYlZQWUFPblFTUysra2tEZ3FpeWljVGdvTkR2VDhZ?=
 =?iso-2022-jp?B?WlQwMzZuU3NqZzg1NWJQZER1OU1lV1g4QlhoSkYvekpvTkJJS1RJRk94?=
 =?iso-2022-jp?B?YTgzakQ5UmdnQjNPNGhvK0FZQk5nYU45OG9HY3JkNlBIWnRBMHoxN3ox?=
 =?iso-2022-jp?B?YUNhclhwNXZWb3NSWDRBWUdjVCtqS1hRMjhxV3JydTZvRFZZWU1HWkp5?=
 =?iso-2022-jp?B?ZGsveDdTVG1KWndpaWcwaC82OUJPSzJtRktlMWQ3d1JLMVB0cmQ2RFNo?=
 =?iso-2022-jp?B?emU0cTdFR010MXprTHdsRklETGZNcmRaVnpFRmJtajc5OEJqRmV0YmhK?=
 =?iso-2022-jp?B?SU00QThpeS9DMWVuN05YK2l2STgzUlo1R3EvMHJYK1I2LzgxOXVYbWpL?=
 =?iso-2022-jp?B?MzBJTEJJL3hnZEpDdlIzNC9lR04xc0RXUVV2TzBVMk5tYUNDaFhXSmhE?=
 =?iso-2022-jp?B?TlA2SjR3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03150210-10f5-4377-d438-08d9e0c62de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 12:20:02.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlbSbddV6XGhfwqCjrwNLFHkArEuvg+YAFryLhhbjjM+ZS7/IOuCYWcbUw0diM8mG1eRyga1nO3z61gHgOOUyeh4sNol3Eszk1xrNkqg4Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2614
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 01/24/22 at 11:48am, Guilherme G. Piccoli wrote:=0A=
> > On 24/01/2022 10:59, Baoquan He wrote:=0A=
> > > [...]=0A=
> > > About pre_dump, if the dump is crash dump, hope those pre_dump notifi=
ers=0A=
> > > will be executed under conditional check, e.g only if 'crash_kexec_po=
st_notifiers'=0A=
> > > is specified in kernel cmdline.=0A=
> >=0A=
> > Hi Baoquan, based on Petr's suggestion, I think pre_dump would be=0A=
> > responsible for really *non-intrusive/non-risky* tasks and should be=0A=
> > always executed in the panic path (before kdump), regardless of=0A=
> > "crash_kexec_post_notifiers".=0A=
> >=0A=
> > The idea is that the majority of the notifiers would be executed in the=
=0A=
> > post_dump portion, and for that, we have the=0A=
> > "crash_kexec_post_notifiers" conditional. I also suggest we have=0A=
> > blacklist options (based on function names) for both notifiers, in orde=
r=0A=
> > to make kdump issues debug easier.=0A=
> >=0A=
> > Do you agree with that? Feel free to comment with suggestions!=0A=
> > Cheers,=0A=
>=0A=
> I would say "please NO" cautiously.=0A=
>=0A=
> As Petr said, kdump mostly works only if people configure it correctly.=
=0A=
> That's because we try best to switch to kdump kernel from the fragile=0A=
> panicked kernel immediately. When we try to add anthing before the switch=
ing,=0A=
> please consider carefully and ask if that adding is mandatory, otherwise=
=0A=
> switching into kdump kernel may fail. If the answer is yes, the adding=0A=
> is needed and welcomed. Othewise, any unnecessary action, including any=
=0A=
> "non-intrusive/non-risky" tasks, would be unwelcomed.=0A=
>=0A=
> Surely, we don't oppose the "non-intrusive/non-risky" or completely=0A=
> "intrusive/risky" action adding before kdump kernel switching, with a=0A=
> conditional limitation. When we handle customers' kdump support, we=0A=
> explicitly declare we only support normal and default kdump operation.=0A=
> If any action which is done before switching into kdump kernel is specifi=
ed,=0A=
> e.g panic_notifier, panic_print, they need take care of their own kdump=
=0A=
> failure.=0A=
=0A=
Sorry for bringing back the past discussion, but how about=0A=
reconsidering the following design?=0A=
=0A=
- kdump-specific notifier list within crash_kexec()=0A=
=0A=
I don't think that the current implementation of=0A=
crash_kexec_post_notifiers is ideal, where panic() and panic notifier=0A=
are used, which contains the code that is unnecessary for kdump, and=0A=
it unnecessarily decreases kdump's reliability. The presence of kdump=0A=
code in panic() also conversely makes panic()'s code unnecessarily=0A=
complicated.=0A=
=0A=
I use crash_kexec_post_notifiers with the understanding that it=0A=
affects kdump's reliability to some degree, but at the same time I=0A=
want it to be as reliable as possible.=0A=
=0A=
I think introducing kdump-specific notifier list will resolve the=0A=
issues caused by dependencies to panic()'s code.=0A=
=0A=
In addition, as I already said in another mail, I want to avoid=0A=
invoking any other handlers passed by users other than me, in order to=0A=
keep kdump's reliability. For such purpose, I think some feature like=0A=
Guilherme's panic notifier filter is needed.=0A=
