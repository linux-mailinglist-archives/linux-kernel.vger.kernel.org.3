Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E957C4F0871
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiDCIle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiDCIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:41:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2049.outbound.protection.outlook.com [40.92.98.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6F31EEC4;
        Sun,  3 Apr 2022 01:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKXk1+Gr+OlX2J2u5I70SXsrPyoarkwO1xH6oyXeTE/vetE0TVtKqURUnAUxSa91SVIl07xPBz9MW7yMc4ssyQY0PV4TzEA9xEoXBtJ49xUq/15z7q3fZgZfv7NhZN6lldQXVOMrTzlKINB56da9NUolROUFo/9vuxmfLzz4hv7PSwXhyAKopOTOp554zBcl9Rw260LqC/2dhndqA6qzqiNoJ/6ZDdL5OJXjhsqtnBaZ+PVpYIchkyutyqf4PJkXDNT0+mkno59MRiC/ONZhPHaPFwbAGBTGGAMxxbgkwFFygfdweJhPqyHxXW40oX0On4r4Fx7E1LbBIX+87jMlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDzGQQoVO5uPxphhwP5gUoiVPzfgyt49EQyPv/e8LBk=;
 b=k6RQ91Mp4n4ZdZ5ObtRlP0bkcU7SzIq0k32dPfCsleAo/bDLcsz2gavGdYC4CbfvP6F4bG5wrksEqFF/DeSutMnyUKcdJ4nIqjBIEM6wnDudmdD76CNCoJiTVWM1vlHE4z4nV9dfMs8sgREKC6S69FB2joLnvQF1arnUcT4ZZwYMVSzzkfLtLn3Tx9gpvrF7zZ9g7jFTMX3J4ILG6yQPccPx4kqoErY6mfkqnNLviG4ayfSSOV675wsLDwUMBWSSOJWbT5Swo3cV85IV4w+gFO/oTHpwlpV9P0zzAtXgZ+tleWfmB6B9cfE9KsV46joM2uZd29SCsXVLNtjcfWDHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDzGQQoVO5uPxphhwP5gUoiVPzfgyt49EQyPv/e8LBk=;
 b=ivI/ir9/cpzDwZjSzm+1NOu18pjY3L3/Jj9w/lTLNUBdSCPkvTufv4EjmLAhD9z3C5bN2lkliTbMMKa/2rXXGkJwCsuK82hd47znoWGADAY/HX00Iv6nYaHJjRjRidGr6rvy31KuLExUKhtzCgZb0NvoHpQ7xoIN4HoVdX8Na8aF+DkyRpLJSjc6nWpwqa9KsnK5rKnp6DyoHChEYC5Cq/x0xCkIwJCXZxbpGb7r7uHwW9hEuaB2iTQ9seXkUauL3wPLOBeocNYrYPt0Ujt4s6m1ebjfZNjTYVEHyzESQYGE8TapkCFx3sw3+ChFFlPX0aR/EECFV8Ca39ixEtANkA==
Received: from OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16f::10)
 by TYWP286MB2763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Sun, 3 Apr
 2022 08:39:36 +0000
Received: from OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6c4e:9cbe:7dbd:b301]) by OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6c4e:9cbe:7dbd:b301%5]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 08:39:36 +0000
From:   Cui Alan <AlanCui4080@outlook.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "konstantin@linuxfoundation.org" <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How can I post my patch to others
Thread-Topic: How can I post my patch to others
Thread-Index: AdhHNV/JYqqy1AV9TyeYDDdYtzkthA==
Date:   Sun, 3 Apr 2022 08:39:36 +0000
Message-ID: <OSZP286MB207841D32B0578BC786B927EADE29@OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [vmuBNNWvZKb7E+GUoIzV7rv8qIXnTMGeozR1+70wPvo4Bw/u/67JCyTbhjLIxp1id1JDuRBr6oI=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db50a8f4-4fb9-421b-9354-08da154d7c07
x-ms-traffictypediagnostic: TYWP286MB2763:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoCKvZLwM5OyL6XG7D/Md5fmWxscQXhXY+Zal2bNZVXjjsnCn/GvdDAXs4VG2Fkpv3CAVbPkJ4Csp6wfKLvHwHt9+ngcn7UDYAEvtARx7RIxZmoiMHJv+LffwX4Mg9IIhJYf12wopStv1vBG7eBzwpje+DtOTEWKAXmOucx/EJk1/YKiMRZAXYfgtKMi0A9GRaytB/JZ82m6LJ8y9gJxxalBIDzdkyHnwxVwIr3CFQKhU34x2cdXlaZwyIK2XEpxi2Hw3Fe8Ah+zaC84JMNdt8BmoA9/Gd1EgAVFIXNqgrK60hkVDIMb6iTJd/Jicszbu9rRwJIZ+vCds0n0JzmzJ2Scm8ncSKqi67vPxO+sKaLBmdDyn36xgPlooEdf/rf3/vgElDNT/xzrEFKiJPDobzrJdl0v2Ga0kWsZ6GksfVR9Nn6wiACp6HzYIOi8q5iyXBPN3irdt6bdEAo96HUjtdR3c3E0QqkZSB4zWWimaEWTJe1biWW/vhKhE6hVciDu6Ao0apG3Tq+0gEtJkNx1lXovgWNtetauXcUR1wrajYZAXf3/dT80Sy/Em62nKhKWqF4oyRYZdwIN/+rkchP0HA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4DWZbhTRpxjeDX96efd2ed7ai9EF4K2mkgmJPQsz08BWoUy/Fk2ilWwn+exe?=
 =?us-ascii?Q?a3D6AdzYSclDLsw3wyINthPD3iJS4R3NqImvroRqdlA5wqjwGs7hp0VpyGfJ?=
 =?us-ascii?Q?LFEdVfKvrY6tthK7BZ9Wqmidy/cH4ing7ka8P+KNjsSvbLpYdMijVffIgLtO?=
 =?us-ascii?Q?HWiKZ4OI6j0rUzRJk/k2HAqTby3dOEe1E/5zX4hQhSNSF77SLbjntCAXSILz?=
 =?us-ascii?Q?8Yn7aCQSl+ZXPAMN+wx/DMFPcrzsuimGHicxFjgq4BFo7/AaoZdRFnd6kROl?=
 =?us-ascii?Q?79dZWz6uSr6QfjQ9k5zpSTWMiRmMItuhEpBm+iWjfsAy0bM+/fCN3zDE6sva?=
 =?us-ascii?Q?CU3vkSf9Bez5ulPTWsgp40GDyd4BLT5yIviIQkCtMJUNcAGNeFAJ9peProCP?=
 =?us-ascii?Q?j06BRvE1jyHfbwA3cpX6dKGIT3x7+dPRNCKWxIpgIqj8CpvWMTyRhKOQbvwV?=
 =?us-ascii?Q?fO76302HpgH53fUQjPKM4tbtdUGDfBlIQPJx7G4UIdD+fCnqo10313f9H28i?=
 =?us-ascii?Q?193WZ2Ldf0zFv2dmYlaiG7CoaoHjjRFLs1fPAluQtvJXhtZoFoTVQVfPyNro?=
 =?us-ascii?Q?TLZeHRjV/m0QcBqtBfrrMGThXten+qjz1RPZIynvR/+8gA08UDxQ85Jr/i5K?=
 =?us-ascii?Q?5kJ6zEPiNSpww4Nfj3WW6TWJCW2IiogMfd2Vsgj7O0qfVCiBUUZOKUcSw40K?=
 =?us-ascii?Q?LVNULyv45Y+OaJyDD6rLl4Qkomw5hmoWqC9bScaoVeTEJwuVqflzDtBWz82V?=
 =?us-ascii?Q?35OjuMusV0g7rKMimRORGYEsEVNA54L8ALOo9tczfx7Ql7nIsG0Pafpgowiy?=
 =?us-ascii?Q?RGM5M5puaIWjVdt3CEiU3w+zl5HVqk0jhdpwn+vkNfZjyPkc6ItgTxenN2Y2?=
 =?us-ascii?Q?YQp595rJBC1aaMTwycEERus3TE8OUJ/u9RPYADNmt7KgRlBwwL1+xtJvpSHE?=
 =?us-ascii?Q?9sUosK/jFTjjfUSry62kcY9Dv0rstEfhh0Iw8Yx3x34Ekube1CsDQ60AIzq0?=
 =?us-ascii?Q?ShcUILiRTgXVyx+VPcOAk2LenOs1cddVdvttZ28wpJk70BnQg/EE5ZktY+uR?=
 =?us-ascii?Q?BVA5Clo3rwS5j5NpMDwYsXJ7a7Ozdi6YIaWfoStco3KzsNXIj7R1+7bwbu1F?=
 =?us-ascii?Q?G7lj9FNXNn9R4ajTowv0MIFh0VDtLr0Hy5orxfoaJCTZRiC7ZYQ2u9HEoLE3?=
 =?us-ascii?Q?NFBCePNoVmLvP2iIxWqcyu1DeIukLB6q1zz+EJIO5A2WUmD1z8FtxJBJkBZm?=
 =?us-ascii?Q?0W9ucunQ9Gjs0LJC87q7D1/2MYSOJgQwREXGuRokR0EJes1t5F60OpyMCa7Q?=
 =?us-ascii?Q?HimHbmCltmbaMtc3KCFnZgADJV76pq2fcMUkoq4kX/BPtg9+KNEvX8V87/BY?=
 =?us-ascii?Q?AeUYpxMWlMz7M7jDl5pmgC7y02OpW4rKXJGGrIBQPnfh5Rsf0D2Ino5y+egI?=
 =?us-ascii?Q?X6PGItjERTd80G8qUHBJJA8K1pf0a7kiypXtWXcBBHSEmdcK3RBSQIeFmyMD?=
 =?us-ascii?Q?eVi1XieMfaIPjpc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: db50a8f4-4fb9-421b-9354-08da154d7c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2022 08:39:36.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2763
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Thank all of you.I''d rather not receive more.
Alan.
