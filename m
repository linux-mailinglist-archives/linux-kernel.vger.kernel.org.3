Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9C50670E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbiDSIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350091AbiDSIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:40:38 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 01:37:56 PDT
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3E13E08;
        Tue, 19 Apr 2022 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650357477; x=1681893477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/T3J+can6BmES4HH88atCk0Rf14VisLPpkrqYb9YOd4=;
  b=Oa6MDmXUIP6HexCJvsP52wRi3iXYho1JQTGW9x0DB1IaXc42RG8JRAWL
   +5m6FdAs4FJnd+JnhzPbYf95gj9tKO6G7HVOM3BU4U2NP1GK4Y0888uQo
   BLUNY4Izw8AZysbVgP9vxT1EZzk2mj8ByWzAMSrrESDNdTYCNTBYXdPt3
   HBAtBsqKbQQdgHX4jPFH27CAcAem6Q9JEqBUlYm4BEs//JU5bNjSBPojo
   Q8+HiTFzxybX7RK3xWjYgeoCjh+0YueFO7mRz+gbgT+1LecpRaojHcOB1
   lSwAJfSaAPEYhVkXYVONDJcJBsqN8qF7O+bokx/SIeV4X9gJEy2I0xhVW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="54213277"
X-IronPort-AV: E=Sophos;i="5.90,272,1643641200"; 
   d="scan'208";a="54213277"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 17:36:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSDDao6TCHoXNMMrPk/KdW2WlvCcwIxCJvzHFfvbKWkkcW5bS0h/jsClp2f2ktjkEzKiW/gXUvjKLgZIe76RycjdawQOLAd6iGb3R3OyeeXX0g43qXJ+trhbgWrUHPX/GsCj4DTUevaVuPePtsLIfNdI++S3y6Z0vh0KXVwyaexiU80DpolyO9ic/C1ZL6EainWTivjAs8+63fzz6lejJERnUHqA9ptM0mf2BbVPdUGBrzatPJrkfDgU1dJ3LmJoV5OLfRC+C+XWzH88iTcX5CDBaMbI25KZ0I6wLOJQb/D9st7FFfSBGu5IRyc5PFaWFSM16R3f+TlkDIMZaplqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETeXn93AVQlIbpKq9y/uHMq/VVQ0mz5Y/9SpIMX/92w=;
 b=lUw/HlReMDt5Mf5t5LogGA6BTi2RsAz3ZbOtd+6uUYEZmJC66V1sEj62caDSsraFMNubL+cr/oW6urr0zJUvaPikEMDsK1lMyOAOCIr/R2Fj44fZT6Llid+dpBbRff5Omh4bX7YtV9Do/58sDynxEelztZNzd6bTBVWuhU1XtFd1jZl2KsgmuK78mM/+tIv5zF+zAsfDRE6FsZXQOuRHXm5Q7LSKY5uBQF6FvQhYf4w6aqq5Wc6Gt2os2oSwCdfszFGpJ32TToN2G8uwE5nM8jmgHmqJNAxrf0mYGz47snX7SiFAJeGu63xOkluNr8KrambUAXARE1NtgNF2Ou/CoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETeXn93AVQlIbpKq9y/uHMq/VVQ0mz5Y/9SpIMX/92w=;
 b=HslR9D3W7dNE3U/l1ODkSmNOdXy0jMQpcScH8nPLZRN7UefcTEyZRSY0RPoPCLcs/rHItJN18+Yy9YPvVyxLXN8jh4iBrcW6rAMrNNne2zwe29WMKqHk+HQxdVkHW9V2RX09Piec+eQm4QmmPoijrOIEKYDuukF5oBWdGKK40f4=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by OSAPR01MB7543.jpnprd01.prod.outlook.com (2603:1096:604:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:36:42 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::a91e:d936:37ec:f656]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::a91e:d936:37ec:f656%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:36:42 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Topic: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Index: AQHYROFUWg6uBlnqVU2NIy0zBQeT5KzZYQIAgABBxICADG27AIAADG4AgAABLwCAAAfUgIAAA38AgBDcmG4=
Date:   Tue, 19 Apr 2022 08:36:42 +0000
Message-ID: <OSZPR01MB7050BE18BC9E8DA05C00F478EBF29@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com>
 <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
 <20220408133246.fyw5554lgli4olvg@maple.lan>
 <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
 <YlBE6hZHmLo9/wrU@kroah.com>
 <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
 <20220408150202.yhn3qppqwm7wzmo3@maple.lan>
In-Reply-To: <20220408150202.yhn3qppqwm7wzmo3@maple.lan>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-04-19T08:36:41.167Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 194ba67a-7e59-e6e5-8924-8374800f0446
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c08f67e8-2e41-404b-e636-08da21dfbafd
x-ms-traffictypediagnostic: OSAPR01MB7543:EE_
x-microsoft-antispam-prvs: <OSAPR01MB7543B230AE58E8CC9629FCEAEBF29@OSAPR01MB7543.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/0G+jUw+UB3IVPlcepLsZqkljSIX1uzMaMyTmgsmWFW6RGFLkLCJoiOfNypjOP46NLcOONQucbbH4xVolZDSpXi87i3DVVvgd2+vCzfAvxJjOEb1Iu/xYusOcCh5dIDPaSsk57PKBnfCohXQEZQv86Sv2lxVzEIvLpJpgva17hhOmwdt5vI5E3Gu1XT+FNzcw/Dckmq5JmDF/GFMQRNIb8ScNdDnk+cEcKHiRuyTqF4ABZnkB8MK+CWLH7QmFuXnwG4hH8BnGzC/IAw9ZmL9ogwCuSyjbOpy1R/uWtvtA72Qg8DCoWCXg+PrZHNbbAhC7Hdmotz9ysNyGlGjhsY7UPokrqP0fptEKn4yzfnChdXH+UdLDsLV+C0LvYqCY994TW7HidwFUdtORKyg8IjQm1eMN8sUwM+1ZUuVI0643U1+cWslNMZguVinnjvvrYmuQfzZwx8PyTN4yeDeYuqnp6qsPrsq8bNrUPa6fdL32OtXwlgHn9KeX/PZPyimSGI1HdI2yDEyY31UgkPFshb36+HifMXfZBgqL5n1o7Dg+Z+6wJZTXOhK+0Ezo1k4X3s9kawAFkeflujxCc3aqX3rUN6GisbvvfEMDfi3/PCeHFobYeG6cyyvbIfnCPVOMWU7ulcc8kcjhZumeFkwn6F9Yqlu+vpNDPXyDo3H3fYPyMQndRcQKgZO3Hf0rq9WwqojXYMUWHFki//Lphp2mNlo4TezbAOwlzF1KXRKf/oERvrB0Hh+kST04MLNAZQjG2Q7Yk3MSqGOCQCzBcBGCYr+XZlsv+vTTFfFReEZwuzINU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(86362001)(66476007)(966005)(508600001)(38070700005)(122000001)(38100700002)(64756008)(4326008)(66946007)(8676002)(82960400001)(26005)(83380400001)(316002)(54906003)(110136005)(76116006)(66556008)(71200400001)(9686003)(7696005)(6506007)(186003)(52536014)(8936002)(5660300002)(85182001)(2906002)(33656002)(55016003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YXJ2YmtWZUF5cVo4aUUzT0sydkJvSWxlcUpLeHhyTXhqK25XUXg3RlFx?=
 =?iso-2022-jp?B?elVleWVjOS9qL1Z3dmtxbFJpdk90MmlPbU9jeVNTK2FEQnhPRFdCbXNT?=
 =?iso-2022-jp?B?dTV0azR2Vk9YK1dKMitaZnExUU84L1l6dzYrVXVWUXJ1eExSdVR0WnhJ?=
 =?iso-2022-jp?B?d1ZySnkybGIxVkMwcHlmcjgyOGt1cWRvaEx4dytzbXdUVEVZTWhwb1dD?=
 =?iso-2022-jp?B?TjVSSWdJSFB4NzZpckZTNTNWYzgrYnpLVkRJb2hVVVgvNjBQMUdNR1ZG?=
 =?iso-2022-jp?B?N1Rvdldld3RIR3c3S0YzRk51SEw4Rmd2VXdFVlZ5MmtaOFhXTElTbmlU?=
 =?iso-2022-jp?B?ajliYUxnclA2OVVQQ1ptU3I4QVVJM3A5dzhIUkpCc05pc0VPY3FwcERw?=
 =?iso-2022-jp?B?Zm9qWnkyWEZIUmNaUldCZ2FNeUh4RVVhY252MXhoekU3cjdhNVVlbmZm?=
 =?iso-2022-jp?B?ZVF2UU1QNldBdEl5ZkM3Nno5SlNwR0xQU1ZiNlpkZHpQSUpjZkQ0Z1V6?=
 =?iso-2022-jp?B?TGgrTGw3OHZZbXc4SFlyNldSd3JCUkdxM3MrU2pTRWFpWXpDbFFQdWVB?=
 =?iso-2022-jp?B?b0dKbG14cmlhblVNSE5PL09SV3NJTExLYkpyRXpoeWZCdVl4eTUvV2t4?=
 =?iso-2022-jp?B?eWdnbVkzeFVoTEVMTjBGU094YXVZeDMvR01UQ3NBa3BrU0ZiTTF6d3JY?=
 =?iso-2022-jp?B?V3I0aXBxc0lsS2hab2IxTkJxOWJoZnhvWG5nRmYyTjRqeTIxeEJVeXkv?=
 =?iso-2022-jp?B?ZndKQ2tIWGZaR2FoUUQzbWk0NS9TaHpmNGtnc2lSVjRHSXJabC9TODR4?=
 =?iso-2022-jp?B?aVRlWlZRR2Q5bTE0NEpTYXg5TnRuWUN3RHkxQUNZRlFPd1kxb1VrUjQ5?=
 =?iso-2022-jp?B?S1U5cG9ydjVhQUlzK3dZVDU1MXFtd1FjdjRaVGNoWTZIb2VPUzVERy9J?=
 =?iso-2022-jp?B?eVEraW1sUFpnYXJWRy9OVnRFZWFkU0lEb1lLZWRiL1BmQ0lqdjFQNTgy?=
 =?iso-2022-jp?B?V1dVM2U0R1JYd3BRMit5L1hVQlRIMDNnWFlFanRucWh0bFgrRDJCTmU4?=
 =?iso-2022-jp?B?QVRvYi9vZEs3aUV2MDJaZUZBNGt6ek1OWXE5c3gvdCtmcXJTVldPdmcz?=
 =?iso-2022-jp?B?cXZnQm1YSUNOUUtxdWgyMldQeGNZNzFBR0JzdE90MEhwRkJXeGt6V2Nm?=
 =?iso-2022-jp?B?VEZMSVk0Y3g3SmlRZDdnb3lOK0xSUGJ4NXpFZ1kzWk5oQ3U1dEZRVVhh?=
 =?iso-2022-jp?B?ZlU2bFl4ZTNVUG5Gby8xbUtYdHZ3Y2h6NWo5VlVmRWlBNFlOU1d1dGdW?=
 =?iso-2022-jp?B?Q1Z2bkxyRHBTMjJqcWFZTmVET1kwVVYxTWRIS3Z1UHBKUHRMU0JFTi9O?=
 =?iso-2022-jp?B?WnM2amovQmxaOUl3cG9JSU1tODFPSW42dWZpL3g3a0M2bGNKN2pLNHJS?=
 =?iso-2022-jp?B?emRaRVpjQVVRUU4xQVRUWDF3aDNwRjY3SEJSWUo4akJBSklQVlREL2hx?=
 =?iso-2022-jp?B?ZFR4cVFEVnBLS0c2UCtCSUlZOUtKaDV2cGlwUnpRNGV5eVhNeS9CTVV4?=
 =?iso-2022-jp?B?R0hvNXJKTkZkTTFsMXFaSGJqUXUweDloTWxQWXpKRlhneUxnQlRtWko2?=
 =?iso-2022-jp?B?SE5zQ1Q0TDg4eWhCZTA1YmE1T3dJR2g1YkxjZExud0hkK1MzbCtLb2VZ?=
 =?iso-2022-jp?B?ZG1tbVkrN25USGc3VFBoVWhUc1huZm1JQm15ajQ0QXBFNGhLZW4zZXMr?=
 =?iso-2022-jp?B?enVwUkVaTjJnK2k4SDRNRnVCajJEZk9IRUxta3dHTEovTy9UdEp5MVds?=
 =?iso-2022-jp?B?dDV5Y1Q3RHFsR09zOExyMHdvanVVM0hwZ2RFamZwWjg0UFk2bWErOVRD?=
 =?iso-2022-jp?B?dXlGZ2loOVZSYWVDUVlnS0VnbzAybk15WVJlWWZRalFONGJ4MTlEY3Ri?=
 =?iso-2022-jp?B?a2lOSkJ0VG5oaWd0ZFV2aXNVeVFid2NOOVJNdlNITkMrWTlxdFVJODM3?=
 =?iso-2022-jp?B?eGw5UUtLWlFUdm1VK0tmT0dpa2tZTURCUTNIZUwwR25uUENoS0YzWnVs?=
 =?iso-2022-jp?B?Vi9xZ1AwanBuVmFQaUU0WTNad3Zxa1Z1QjBDN1VXejhReGxzSDZEaThH?=
 =?iso-2022-jp?B?emFkOXUzNDNiSGZ0S3JmWVVvWVF5K29kQ043MFRxWU5PZmxVSTB6YVBm?=
 =?iso-2022-jp?B?U1RsVWllaWozbHk2YU11a3RJOU1xTUFEU09pZXNtZDRaK1p1V08vSnJm?=
 =?iso-2022-jp?B?OERZOXN6U0hJZXB4MnIyZU0zWlRjS3R5TGxqaXA2Vi8wdTlNYVhjUFRE?=
 =?iso-2022-jp?B?aHlaRkNsd3laMVY5Tk0vdXNXYVRwUS9uYmxZM1ZFVmdzRkd6MlYzS1BK?=
 =?iso-2022-jp?B?OXNGQ1A1RHRGMHQ0TW9lWlM1ckpHdVVGT0VmalBvdXBmYkM2TURiaEhI?=
 =?iso-2022-jp?B?anZXZ1Y5cWJSYkU1cXM4L00wQ2hZS3Z3VW8yRHlaTElzb053OTlDVnl3?=
 =?iso-2022-jp?B?cjhsWEhVRUJmaGJPMXpiZmgrajdLWDU1Mlp1Y3Blbm9lYWZOd2Rrak1i?=
 =?iso-2022-jp?B?SVliMU9Waz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08f67e8-2e41-404b-e636-08da21dfbafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:36:42.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl78iFSXc7KrAcIf0Ol6Q/H8I8WrgMpQZxZWyZC0JHjD1GZPSwi4SKlV7YoZ1+OQdHSpM28qgvQfoCXN7F9Ap2MWZJDPnfyLzb1eCc3LbLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7543
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Arnd, and Daniel,=0A=
=0A=
> > > > > There is some prior art for this sort of feature. AFAICT SGI UV h=
as a=0A=
> > > > > similar mechanism that can send an NMI-with-no-side-channel to th=
e=0A=
> > > > > kernel. The corresponding driver offers a range of actions using =
a=0A=
> > > > > module parameter:=0A=
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/x86/platform/uv/uv_nmi.c#n180=0A=
> > > > >=0A=
> > > > > I don't think a hardcoded 'c' makes any sense. With a hardcoded a=
rgument=0A=
> > > > > it is just obfuscation. However it is certainly seems attractive =
to be=0A=
> > > > > able to reuse handle_sysrq() to provide a more powerful set of ac=
tions.=0A=
> > > >=0A=
> > > > How about a module parameter that allows picking a sysrq character =
then?=0A=
> > >=0A=
> > > Module parameters are so 1990, as this is a platform device, why not =
get=0A=
> > > it from DT?=0A=
> >=0A=
> > This machine doesn't use DT. I suppose the same could be done with an E=
FI=0A=
> > variable, but with a module parameter you get the added benefit of havi=
ng both=0A=
> > a boot time kernel command line argument, and the option to override it=
 at=0A=
> > run time.=0A=
> =0A=
> Pushing the decision on what action to take into firmware (whether that=
=0A=
> is DT or ACPI) implies that the firmware is well positioned to make a=0A=
> decision.  I don't think that is true here.=0A=
> =0A=
> To me, it seems more like an admin choice... and admins are conditioned=
=0A=
> to use kernel arguments.=0A=
> =0A=
> If these type of diagnostics request were more common then perhaps we'd=
=0A=
> be looking at a sysctl and call to handle_diagnostic_sysrq().=0A=
=0A=
I understand that it is not appropriate to hardcode c.=0A=
How about using __setup() to add a new kernel parameter and allow the admin=
=0A=
to specify the sysrq command when booting?=0A=
=0A=
Thank you=0A=
Hitomi Hasegawa=
