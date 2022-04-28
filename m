Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E7512966
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiD1CTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiD1CTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:19:19 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88AF2AE09;
        Wed, 27 Apr 2022 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651112162; x=1682648162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t6JV6epg/EdnRPgFx2es/mvRjvehhv4gGAfajY+Yd4I=;
  b=CYii4OsTycQjDsOARakqM1mD2s+mhUG8dvCYBxgehpEwswB8pB9ioHQE
   aomh2XiBAQnybnAds3AEhgXGjavwCd/SiILxm1oxDqGivX/BKpWdImTCX
   Ru02q9q88g8X5F8406p/jj+vzB5cRGe818iHmvozJ8XRu9Q14yzvL1RmW
   FOfB1qu7lK7Weo6uk3ATfilP4sP/lvGKW+OOiGCm36g0n6iQlO3xlH98D
   5zBUEQRYS3qjIMd+BcvyJAbeQlGUeR1LNQtWbD8d+pFb1sobI+KdQVusA
   IdyYY2wVLvPw7QezpFvN3fE012t0ffe0P+r4tA324+YKRxoxsey4+yUDt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="54495986"
X-IronPort-AV: E=Sophos;i="5.90,294,1643641200"; 
   d="scan'208";a="54495986"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:15:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGhJiRlrC/n3KvYYHMsz8sNhuYXiD5AkM1IDXyRGvxq4u92D+maKF16GmiCoNBM7f5XJQ2z2MPZZht5Qc8Td8EuJLCVjdWkFs3Q9gnqky+v94SJw1NJjNJK2h8kEIkQRaBnrjRmkeHQiqWicf/cGccq68dFvXWp7qG1WcvOROB6bIUi0UqDLIPcgLUitq5+q9ad21XSRZUSv6EO0BcYlmVclIjEBMAd+K+oX7STp/GwWGNJ3CgQlPgOvbKVkfEsYWEDuAhLpN0dkTSROlW8mT7QL6plFv6uJZaFdxN1Q7PtlwQw6su4JQgH3kyjvp1rHk6hZ0CX0qOhv0J5YoJiK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6JV6epg/EdnRPgFx2es/mvRjvehhv4gGAfajY+Yd4I=;
 b=Zu4KLzM+LqDYGB06cJQ29bZY19z0V5MA065VOXuq7Jtq4bqSiJ43t0/7yA9Q8ICYWfuoc50G4i7yZsZ9cvz39PYn0PK/HUubyBRp+34aEjn7Ww3LFfqHDqjcMjp0NgPxHcdY9gUvaAq4r1LK+vZVjgGAGYeCMR1EYVc0Hw9HMlCqV0/wLvBA2NmENUumcsA14HqVzl7CqN1URRNTgLpEJob5fEN1oc9BYMj/llf5XRXPeceEMkmACSrJTIdjqk4n7i7Dzv5Ka724ShNbn4eRS+iNJq1y9t1gcp4h4ObmitigOphrpx3AgjfAxyd1tSdRvrCe8qx2XGrV/jSzQoJ7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6JV6epg/EdnRPgFx2es/mvRjvehhv4gGAfajY+Yd4I=;
 b=X7JyuAbTSM7+n4qtxmoDF1C8690jgASGv/Tw6YHqHr5R6pJuejPfE7+hj3TlseLmNOugOfd/hMqAuBcOevVj5be2qWbW8gQq8krUOdoiZA3o/FxYKvCXAyRJfSbch/i1vAT+2B9uF2JjdiKryk+n8svg+iqK5ZWPA3sFvPZRQKA=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TY2PR01MB4571.jpnprd01.prod.outlook.com (2603:1096:404:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 28 Apr
 2022 02:15:52 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::9d45:c509:9a59:4892]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::9d45:c509:9a59:4892%7]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 02:15:52 +0000
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
Thread-Index: AQHYROFUWg6uBlnqVU2NIy0zBQeT5KzZYQIAgABBxICADG27AIAADG4AgAABLwCAAAfUgIAAA38AgBDcmG6ADblsMw==
Date:   Thu, 28 Apr 2022 02:15:52 +0000
Message-ID: <OSZPR01MB70504BD8347355EB51F7CCB8EBFD9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com>
 <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
 <20220408133246.fyw5554lgli4olvg@maple.lan>
 <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
 <YlBE6hZHmLo9/wrU@kroah.com>
 <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
 <20220408150202.yhn3qppqwm7wzmo3@maple.lan>
 <OSZPR01MB7050BE18BC9E8DA05C00F478EBF29@OSZPR01MB7050.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7050BE18BC9E8DA05C00F478EBF29@OSZPR01MB7050.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-04-28T02:15:51.578Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 8a37b14a-46d1-109b-c6db-dfb2335c3d63
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d7a06d1-5fca-40b7-49a5-08da28bd04d5
x-ms-traffictypediagnostic: TY2PR01MB4571:EE_
x-microsoft-antispam-prvs: <TY2PR01MB45717A0DEA7C1697E0BBD975EBFD9@TY2PR01MB4571.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGI6iAfLRQVTz4ozT/TZNzEYQ4svWhmVsx5PzFnfp5iXMv19EpRDkaKhGoHxMCmcMcow5O+AKkSEql/nJZ/K9fcKOmB4fh4Uwy5bI5/mXrFGT2gLaKAt6rU4/3aAHInyebKr58K82cs7TUyg4nPf8svROsy64UcsyT3wNYAjBxf5rECwL5lQiih47YjabSBP7On8VIk4LgetRmss1TVFaD188K6ziMjOkpMXejZXdQZecENP2v1JO7gRQk116cTMw3L2mzky2WxcyA17q8Fm9zRYb2Ql2UHcN+QwbtypQAbYPrgQsD4YAle+gYdmGRBwdOcpCjSwkUxDXTIuoy7zZps3i1NNE5pn7lB/5IRxw6BC1bO42ZKB4cjggrLKsTRHKZMH4j5Ip8QZ//uMzbFRQHhvFp6SdG/hW2yFUrnjOWVDeY9FPmhRlTHC829pPwVhMyM7T49gvGprafriEUg9G5Wh2CM5zfIoqqqSPoafvFoA/bG6lSXjknWbvJ1OAJabSuW2QGRbjRgFhQWgDcoA5uneUeeAeP59f02l0SHM2vyKdkOOS3fDchXx2B4c4GajAHO6PvVdquSQtC3XfWstuZDZYmvkB6jfm9jTwaCMCsW6w/TC+RnO2OXw9Tyang2zKfj8AVVm03lRG+9RUNTNShB1P82eyruBkFZToFWb+TsqsbKLL6LhFzXMRRrkw5GWcg4NIitq8BaEk50xJrXIUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(66946007)(82960400001)(64756008)(9686003)(66476007)(66556008)(66446008)(76116006)(8676002)(52536014)(122000001)(38070700005)(26005)(71200400001)(316002)(55016003)(5660300002)(110136005)(508600001)(8936002)(85182001)(7416002)(7696005)(86362001)(83380400001)(4744005)(54906003)(33656002)(2906002)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SDFRdkhsVnhnc1g2TnBsQy9pcURLUmVWckpwZkNwVHFyT0RTcTd5MCtC?=
 =?iso-2022-jp?B?Z3FnVVo2SkpvTXIyWjNKbkdwSlRDaDNDUUI2djR5eGptRWVnMUZMTEpn?=
 =?iso-2022-jp?B?bFNzS2c2Rno3Qi9YZmJjU3EzME92WWZEeHdDeWFBTVhpNGNMNUF6eUk5?=
 =?iso-2022-jp?B?RE1HNlh4WTZMdWNxenlkcTl3LzJ2MjVJS2JDMDBlVnNqdkJVaDc2aFJJ?=
 =?iso-2022-jp?B?QXJaTklGbjh3L1hCRjRKR0x5TW5MdFRDWFVqM0pJMnFJTGNycGlyaXpY?=
 =?iso-2022-jp?B?ejdJVDZmWERvQjlxTDdTUXlGS3puQ2l0N2NxSWZpTTV2NHRqejF4N0gz?=
 =?iso-2022-jp?B?REI2OEVoTDhwTGhKUXZrZlkxNjI5dlVxelRqM3d3Y1NTdmdTRVMwakk0?=
 =?iso-2022-jp?B?amtVNFE1ZHhWOVpRYXN0TlUrWEcvUzBETXRLcklQYlhxVDRoNFFMS0g2?=
 =?iso-2022-jp?B?ZktCQVhGTU53TDh5T0dTVzRtaVN6UWp3WWRZeVhzK2RPRVJGbFQwRzZx?=
 =?iso-2022-jp?B?anB0WDJuNWJGSHZHV0w1Z1FzZXhSS0pkWGJXVk1kNXpHaStzcGRPZlMr?=
 =?iso-2022-jp?B?KzgycGg0MXlzTGpWcng1T1RMa2VNNFJlaFVqZ296OFA2czk3ZlhROU9L?=
 =?iso-2022-jp?B?dER4ZzNOMk1Seml4RHh5VWM0d21nOTFlZGQ5UGxtVHEvZGFUU01yd3pu?=
 =?iso-2022-jp?B?SUV2Y3ltWGNzQnlvSTZNUjJFWXVnaGN0ZTJHVzN0U0tGZ0FFSTFVRGpp?=
 =?iso-2022-jp?B?Y0w2WDc0YUNpb0xKYzVyRnhxVTNiQjQwZCtxR0ZmL2VvemdIbGN0VkRn?=
 =?iso-2022-jp?B?MVptc3R6RThnU2RkS09reGhoNlorR0U2K0RRWS80ekpBUlZvRkFZek5J?=
 =?iso-2022-jp?B?MFd5WjJQMHlabWgwbGZ3cE9zM2NTNzZYOVR1eU8vOHBYOWkzT2NPQWpN?=
 =?iso-2022-jp?B?VUpLd0JiMmozSXFrblUwbDNQK2FaTDJWMlRJYU5TV1ZockRSOXFhUFB2?=
 =?iso-2022-jp?B?Q2RBdG8zMHVkN2E1eG1YOVZmZERweXFoTUlaTzUvVmQ0V3BjVk5hcDk1?=
 =?iso-2022-jp?B?UDFrdGlYOU9FNVU0VHA5M2FnZFpoOGd0cmJqQ1EvbXBwbkNibVBPWXVV?=
 =?iso-2022-jp?B?YmY2ZTNNVXMwRTFmZUx0NzRTVmhJVXM2VkdFZzZFenRJcjJjajEwNlZl?=
 =?iso-2022-jp?B?ak5xcXh5TkpTVjRJTlE1NWNrdkR3WWoxZG9yN1o1QnRyK0dpSENSTmV6?=
 =?iso-2022-jp?B?TWMvY0xTeGVWaDlGM0hDRWhMUkhQWkNqUTRkVFBxMEU1MkRSM25ZK0Fj?=
 =?iso-2022-jp?B?aWdMMFBNcXpYU2lxMUxoWG5CVGdRQ2QveVgzRUpqc3BDV3Q4MDUxT2Y2?=
 =?iso-2022-jp?B?T1dLb3d5NHk3RlN1NVRxYUkyK0dBdGlxQjU5TmtIR0JjUitPdWhKcUtK?=
 =?iso-2022-jp?B?dnJyS1pEOTVNZGlWUnFIaTl2UkZIMXNFdHFGTEZBeHZNbkQ3VVp6Zlg1?=
 =?iso-2022-jp?B?NlprWDBBM2NTWWNkNURnNnE3cEFpSHdINks5NGh0L2tLZWpqbEZmdkow?=
 =?iso-2022-jp?B?Vm84SGNQMTdxN2hjd3YzVU9Vd0Z2b3U5bzM0RnU5KzRyazUrcmkwaURE?=
 =?iso-2022-jp?B?blFCcVVncDZsQUgvT1dVOWMrNmdXUERjenBaVEpMaHZhMXh2UHJobG1W?=
 =?iso-2022-jp?B?bkdHU1YyVFowUExVM3ByUG15eTFBTkVLOXM5aUxzSWVKR1FuRFZTL1Iv?=
 =?iso-2022-jp?B?VWRCOERWS1JrQldSQnVveURSVGVJSk9aVWtocCthSVdVZmhYWFpuNmNZ?=
 =?iso-2022-jp?B?YXdCWFc0NThkK1dYR2FmWFVERnBYSFo3UHRSTWFPSkc5ZG51K0xVb3lo?=
 =?iso-2022-jp?B?SWJRQ3c0RElWSnRzbHlDWUNHcXI1Tzk3UzdoUERwV2V1anUrUmFidkJu?=
 =?iso-2022-jp?B?dXdQVHlQd0FPelRRSWtwVUVOc2ExSkM2RVF6Qm9vNVBMU1FaQTNEVTRk?=
 =?iso-2022-jp?B?aitvTW1hSjBCcGx0VjhkcDZnSkxGWlZtc24xdnJGNjhoK0pBR0xLZUFD?=
 =?iso-2022-jp?B?RXRJd0FLSG5rcFpqRXludGFJQUQxSi84TE9iMkJmQXZudmN3V0xGdGNp?=
 =?iso-2022-jp?B?T3pNK1BhMWo1V09tUkJWQTlxTWExbFNTdS9VSE1SL3JKSWY4THB3VzhC?=
 =?iso-2022-jp?B?WkM5NjVLK2NRWTR6c09QTTJJRkxWM1VzVzdqSjk1L1hEekZBd3ArTmlk?=
 =?iso-2022-jp?B?VE9GbHQrZUNBamtYTFJXdGRJWGxkTXhqMTFNYXREQWNGRklCejNGbGNr?=
 =?iso-2022-jp?B?NDNwM2JkOFB0UUt4bHhUNW5qMXhmK0lBdXgzb09LMmtmMlJzbGd0Y0Vi?=
 =?iso-2022-jp?B?THpsN0FERTJLRHlqQURwMzh4NWlHQXRSbGpzdDN2M0daQ09xNTdpcTl6?=
 =?iso-2022-jp?B?Z3RNYk0yakEvV0xsRWRMNkNEQVJvdFA3V0p5MEduTUFYOCtYWG0rNzlk?=
 =?iso-2022-jp?B?MSs2V21CbFlVR3hGNnFGdkZ3bjBlWWtQai9tL0MyZzQ5Y2VEZ2JOaVU2?=
 =?iso-2022-jp?B?ZXpBWkgvVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7a06d1-5fca-40b7-49a5-08da28bd04d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 02:15:52.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aND6LOc0JOe1clObh7qKDUQSPYLaIYP4tNuVaDq3cgSt9lTfhypnI9pcKJqH1K9z8pS2IcXPx/mrwrAHZMSOyu1KkinNSHeuInTuXAxUy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4571
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Arnd, and Daniel,=0A=
=0A=
> I understand that it is not appropriate to hardcode c.=0A=
> How about using __setup() to add a new kernel parameter and allow the adm=
in=0A=
> to specify the sysrq command when booting?=0A=
=0A=
I have received a lot of advice regarding sysrq, but after some considerati=
on,=0A=
I would like to change to calling panic() directly as in v1 instead of sysr=
q.=0A=
=0A=
If the administrator wants to request a diagnostic, I think they usually=0A=
expect crash with NMI like x86 and take a dump the kernel. It's not common=
=0A=
to handle diagnostic interrupts with sysrq now, so I don't think=0A=
it's necessary to make this driver extensible at this time.=0A=
Also, A64FX's BMC is not possible to send sideband data with the request,=
=0A=
so it is difficult to take advantage of the flexibility of sysrq.=0A=
=0A=
If you have any comments on this, please reply.=0A=
=0A=
Thank you=0A=
Hitomi Hasegawa=
