Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0B5769BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiGOWPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiGOWP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:15:27 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03A8E4F7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1657923149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hdUjvanYRjCcyp3EpPVb7fAQZAkvHUQigGoR/DzZN+g=;
  b=VkKMdvL4O9T4fEE8hlveqb7iXB77SSzQ/xaYQN2QY/GiuFeQ06WS4ZUv
   ZBzxwfgUvE1rpBlneFDKZOB7zSyTwNKdFtJO3cPlHxsQ7WNcKA0KvePSP
   gKRcRgeOFYV98Oqj47vfOnUzOE0ZbXadAYRdKlfiBowaVg9+IrEzW2U0J
   s=;
X-IronPort-RemoteIP: 104.47.66.42
X-IronPort-MID: 75915908
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AkloNc6AOv512txVWkefolNuUFB/EJpYLOzaMY?=
 =?us-ascii?q?LlidIdl5Wvwp1Cd2JxDmaH4ttydWdybY2hSCC2WBv1bdU0K72i8RF4xcFovS?=
 =?us-ascii?q?W+JOj5+QJgfw0ILJJz3H3oYmP6taZZTbHN0kEfuxiCVWfotoBWrsQbfPc4PJ?=
 =?us-ascii?q?USfcb7n1ZV/CQRytqo1AB2V4KrpKTljprSPLde15xfR0pp/noOuabOwFDEFl?=
 =?us-ascii?q?Rie1sz5JtqKJ0nSDx2Dr3N79Rm3OxjryrXzqk8PsAjHEFWWPZ0DcW2OVdwgM?=
 =?us-ascii?q?aN9Z46qHGy8/nZ6mIBl+6BogVdG0zVNFMg/SgpDrw2elgz1ae68+tuiivQnk?=
 =?us-ascii?q?pAjlnZgWinFTjwQ5Ymt3tF+gEJ9EnO6QHc4RxMkmY/QHVFU+eAUJYZYebzCZ?=
 =?us-ascii?q?Qg5dLlXfpS5urUy5LFNoSJyvUl2A2+fYNqD6uSp9RYNoByGQ28qvesarDwvE?=
 =?us-ascii?q?9J5Y1ofCE8SihnqIi4aGZ4iiMqvXK882xkqyKzj3MLb/5xqLTCWLJpI0ongr?=
 =?us-ascii?q?9OX3DjVSxpJYj4sI7o5kEgJU+Jq+NevXGfolueGBAFhJR1aA8CaSXznxmATK?=
 =?us-ascii?q?4db1zNGBzZv7AkkimEyRJHtOzNKsHGfjbi8i8M1umgJKHiaXizIHMm3xPK41?=
 =?us-ascii?q?mopGdV63IoGjMVJptWPABRYKFuZbClbPxUccClaQDtQMkmo6W26V9yrjcONx?=
 =?us-ascii?q?7us5fPZ7g5s4f0+uqumSCu90MkdukV41jiecihX9GWQ2ZK66KIGP54sNufsu?=
 =?us-ascii?q?HQxT9zQotNYN3nGL/2yoqHRNCZccmr9rf/gDKAMlsPdpM5mQpDKhBtyAHJDi?=
 =?us-ascii?q?m+2C1VP3NCfrdeEsm0tBUmUsW8emV24vwoCOc3eeicy4E4rNwGkZSh/aSyCv?=
 =?us-ascii?q?ZwSG3Qqzq2zHrfCXTv/x7VJrQrjjzCY4tMTSOqtzYiEHeTXdBCd7Kh5DIpEa?=
 =?us-ascii?q?xo9D0YudkkJ5uWkJl/NVlrFdAabLfkC6nfK77uzNZO1Lq9RvNftjnIqYdG4H?=
 =?us-ascii?q?0dKLhOlRbsFUn5phmKMX1OoQ4AE+2OQctZsFnSOesIWkqy2nVn1YX2H+WBb1?=
 =?us-ascii?q?9TrCQBBmhCcz88fSHyhWX0idmkEy5P4Vy6h6S8iTZtXo6V/3iygO5ow00CCP?=
 =?us-ascii?q?p3ygna1FR10L3pmF/QlVozImuSj5wkl/HQ7w8bjN/SZnNDQSY5VLUjPG/bXR?=
 =?us-ascii?q?EP359tq541kZTn8SJzyASKPq7o26K1E+HEzcDCqksczk9ODEAMsDNu4GARhL?=
 =?us-ascii?q?dqTu/Ilml8PPBYTR9bU4aXz5nl+oKtmGdGYeMItkWYAyUVKnqfdqfrSC1/Zy?=
 =?us-ascii?q?dSiMZS3idT6iZ5xgYW2VVOSdqmG5+NvL3rz08Xm/KrarDW4XtyEtRC7eqANj?=
 =?us-ascii?q?m0B3JZQRR4BqvGsiHwW0xxGjkFQgskPkCiNrZoIj4veJpvwCeKutQ0wRM4+c?=
 =?us-ascii?q?M12SiOM+MrRr07m+zm9BwgdVrbHOOOJcULdcNJtM8Nv31que4qc6A6TwDdET?=
 =?us-ascii?q?BUMgGoP3mTMuU4gHlvyajFNXUHQPJFse+EK2qY4SNzUzHI1DXkUBMsAsubVf?=
 =?us-ascii?q?OpsqSMCuNpKzu5xgq+Y8c62Zw1KVFVU+dglvdKoak0QR73RS7CinePHoIKrh?=
 =?us-ascii?q?Ga9+kmIajjteH39Pc2cc0ytiLZjLpsM1oXx0UGV8U0F96lpsDnOlD3PLPsYB?=
 =?us-ascii?q?yNongMKbMPUI5B9QgzoUUctPRaKFnxHT2DBM5XB1ijdQRBDRYQoP6b/zl65R?=
 =?us-ascii?q?D25Zwe92COVa89sFIKGAAuZhv/gYs9Id8J/SKKcK+J+tuxkrhbqH1cUZryrP?=
 =?us-ascii?q?N8pD6ZEWKjz4iITa2+lY1RkzdUxYspPgs1iNci0jHpU2NsdcDEFf4H0Q6T9I?=
 =?us-ascii?q?iWIHC1poGVCAfVk/oYdaMjlzD3kogOH166rXR1nIAGHkrzFEpdtrja+E4e/q?=
 =?us-ascii?q?jtZhvGtf9iZDGGpsk+BMfxaxzAbPhnHMd2yVrALgmF4J9+tjjEL7DzGhMs6/?=
 =?us-ascii?q?uR1HgS1+yno7MED+W27PQ1/M7MgM67chErwDumzLz92CL1uFdrlzDISKNV7i?=
 =?us-ascii?q?5ifzfXJ5/BQRl+Da9XHbYBrcPrOZraQJCeVQ/49PWYZR5vMfXbNJNrTYXmDP?=
 =?us-ascii?q?IYoNYTwD6C7fVQlaZcGFuJpBDJ9p5+cVKMaVzxLusUxNWZiT211Te/uqp/PP?=
 =?us-ascii?q?oJncKQV54Qj4a+yYqfdXCjv7e7zkG7vWfLRV4ga/DF4ctUxkXsnGnZSyQ5Wh?=
 =?us-ascii?q?6pNHoruiZJ5Ib2ezH2Ymx0twF9zqVYWbXWHR3XyIu4K2BBzrcQ/mGHOvGOWA?=
 =?us-ascii?q?29EBfaV+ZNr7Xy7pHQe/uGKI1Yw3WGtW1WFS4bndIXMSzrxf1YUuoWJvyp5u?=
 =?us-ascii?q?TxPde/ZjaH6ZgE=3D?=
X-IronPort-AV: E=Sophos;i="5.92,275,1650945600"; 
   d="scan'208";a="75915908"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2022 18:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaQBTafVcp5cx3yKri4n4bbZQlhRj7mEbP0Ga24naozBP3/V9FttTa+ewr/JLOTE678JxDrOS8CJnlFjqa7ztJ7S+ph791nN7ACJh0efDvq/GUNsSe20btXCgJPyYqfmIlV8V9obbFXjzl3aG0JYTEgLpE8JwVK11tJ1GnqQu/UhfJr+Mdot+aK0dLg0oSJqvZ+BLKGpNRKEokkcoE53THqsgIBH0AOr4jYUGdE2Id1Lkss5mYhWZe/aHR31AP94CLLrYd/jv6hqWHuewrwtguIEIRgOjuBui+JU3bimWGsUj2G/PTdGyZ/zbsMV+DVupp443Wwid+dXaQvvW8iBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdUjvanYRjCcyp3EpPVb7fAQZAkvHUQigGoR/DzZN+g=;
 b=Z5vEBs/rI0VO8QZgCChR9Zes6Vsv2NZZ6KZjorqOLmVT9eCVs3b2H+XzK/FFSEzNZ3IFzL7K36ZX0e/4sHbYQOgEUyHwIYGVbeyPqtRmZ+fbEkyUmeliETyEAAnk0wNzYqqAbkHcsIa3cIh0NhAfoPcPWHy+iTmSjxjZEfqrAXtb0hQnVl7A8Ob/X53/pNhMwn+72+5oWWSX7cMJ8NWiOadxF4Kqz2UbPFIZrmAL2TbgKNoSjrZxVIXM2a/S5Uc6IC6T9RCHSzZrHD9XP+x5IU5kpa8swrwFthlwDxysHpMSNPyMMnF+9JkH2Wi5zZtNG2+RJxTGP057rL7Sma5mXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdUjvanYRjCcyp3EpPVb7fAQZAkvHUQigGoR/DzZN+g=;
 b=mSuPCVsr2FyTxEmTFf5XB4QcJG3J6kXgHuUE2O2R+kQxcJLnYDtzt6j6iP7KYCwWBerBilcYHAKs27NeG4t+ZPVd4haUUHvqwpFu/b0lFAoeyhfmTE6TkrJQJBLB+PUepPo1ZyX4upUEdiIDx1gEls1xfhmX8MxWtC+j7QmCSuA=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6747.namprd03.prod.outlook.com (2603:10b6:a03:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 22:12:26 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 22:12:19 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Jim Mattson <jmattson@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Retbleed (RSBA vs BTC)
Thread-Topic: Retbleed (RSBA vs BTC)
Thread-Index: AQHYl+dP+dYch63h+0ykgrKLAesJ1K1/5k+AgAAZyIA=
Date:   Fri, 15 Jul 2022 22:12:19 +0000
Message-ID: <f43c3c33-f8b9-e764-709d-b3864d2bd9f8@citrix.com>
References: <CALMp9eS5pBrKWe=LbWXON6bhTdhbX9rB2aF+c-h_a0=SXfyj7A@mail.gmail.com>
 <f68c283c-cfc9-bc63-5d0f-143295a575d4@citrix.com>
 <CALMp9eSe6dRvSAa6CQp9P_dO5840OqSmhXrS2AabZeCyL_3j=g@mail.gmail.com>
In-Reply-To: <CALMp9eSe6dRvSAa6CQp9P_dO5840OqSmhXrS2AabZeCyL_3j=g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd0ec95d-4f0f-4bde-659c-08da66af15b4
x-ms-traffictypediagnostic: SJ0PR03MB6747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WXc9kouiNEjWTG7yxdNpLE9iR0XQNgtUqk2NRGoy4XpJWNhgm8sTvWS4mK7z9MlIZ+1V1RA+fgwP7AeEBrEgz4q3cXwDB8EvxCtEtE//y9PuKfCWt5LY0oJscIPiaDWbBFZ3RJvvi5otmUmqkWB4aEKjsgTYX9wjBlXjkT23Bv4E9kX5AjbZn5O17Ir/U4+1FJi/MDkk8TI/NTe5S3cA5NYZgc/n03xYP1HEdsPF5OVl6T1pjsavI0OcymxRLmiJR1gidtnmF7OVGe6dyUG9AvPwr3yeOVutlailwwTKU5rAkwa0+rd6b85Lx3yHNsXeFYu9s2OvSXv4xvROjaeeHdgLXrEMRoutIV54zdimUoPp3RzyU/Q8mNi8l40tqBxc+hWigBlCW3V9swTxlPwezWkjGaiU0GqXYCSBSXAIB3sfezrw4ddmoI+qZPO06eDoDdTSm91uNZhgLbxoxYWVVS6alkeTCcXwYBqToZJJojaaRvv1x2gGYnBU6ki4hLP0QIvBieqiuwXYRyoxWNTi3bWqOLpx0thgIuwhK91Cp/gmQucF3Z7WOtu8g9nEgJCe1lW7rRIUWnsnUjgMewt+npF3qPu6fOa3wg48A1C7uETEHcBitruQ0HS9+x4MTDOQEeU6qVWEO0Dk/O5tt9BUttJ/YI2fsue9MYAr5hH4weXbsPZOxO2K6YzbgSx74pnibpImrW/phqBO30tFS23ZQ//4EeUEGeehJOVLcUREuDJ9VF/jgPFMH/Vnho+q8Qarj1WlfwtuvzGKr+alt73imGoMEhtPtSSGO6o+eWrlvsc7Zf2+9ugblq3+ew1YkQr7Dp1kcoFEbev7JESS3A5iV7q9Wq+nNjX3oifpHp17BAn5uj8cAc4l7t5BHZCCCF8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(6506007)(6486002)(53546011)(6916009)(26005)(6512007)(36756003)(316002)(478600001)(41300700001)(31686004)(71200400001)(66946007)(76116006)(66446008)(8676002)(122000001)(91956017)(64756008)(66476007)(66574015)(83380400001)(66556008)(4326008)(31696002)(2616005)(8936002)(5660300002)(82960400001)(2906002)(38100700002)(86362001)(186003)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDlCcStxN2xwVkR4U1BuZ1hIVmp5RTRLOHFkRFhxRHdMQmxmU0IxNlprTnlZ?=
 =?utf-8?B?U1hKQU0yalM0ZDlEUVdMUndnU2MzNEY0M21iZldLYmI0RHh1VFNNdHhiL1RX?=
 =?utf-8?B?TGVGakNVbHpnbDBwU3BxY296SEFiRkJyS0I2Z09QSGZPc0FEV0lsVWY5eFlG?=
 =?utf-8?B?di9yWlNKenJ6aE9XaCtVRldXY0hXNk1XZWdxQjcvcEt5OUxOYzQrMjMxVW9n?=
 =?utf-8?B?MUhWd1pucmtUZXVZdTh3eStXTkNwcEo5T2dpcmsvNHgrV01KbTEzZVc3b3BB?=
 =?utf-8?B?Ukk5K29iM3lxSy9SWU1CY2VpNTczNGVXWnFDYlZBK1ZsZWw4a3hYY2R3ZG43?=
 =?utf-8?B?MmVRRlZjRG5wcnI0R1VYcVpVNTBWWGlVaXBMdnJ0NncyRThHR3ZQMlpsa1Qy?=
 =?utf-8?B?YXkzMmViK2FaMlVhK2dDeXNHNVIzWkVyZzFSdEViajVvVk5TZEpBQkc3SU5J?=
 =?utf-8?B?R25TRTlYbmx3SmhYSG5JRURieXlXUWR2WkFhSDRUVkptUTgvOUNyOEdUOXB0?=
 =?utf-8?B?bDVSMjNLRElUaXlPNS9hUlM0b2Zha3V6Z3JBZFVpVTRDbVhrT1FFSlIzaU55?=
 =?utf-8?B?TXYzR0JYRGY2aGZsaHJVd2dHNXc1NnFQT1ZJaHlNMlp3ZkdqR2Y1Y0ZGNHBW?=
 =?utf-8?B?VmZDZ29zbi9DUXJzd0ZobFhyRGVzNy84VVd4YnF4VlZqcWdKck5ScldXN2tB?=
 =?utf-8?B?MnVBa0FtUjBYTHJ3QS9hR29ZNmVWUVZKNjdnNllLN2huMFNxNzRDN285MnY1?=
 =?utf-8?B?RGtWb3FZWjNHR3E3Y1lsREl4aXlJZHhxQUllZ2dMTGN0WWgrTzNyVHZGOFpD?=
 =?utf-8?B?U20vZm55K3gvUnJmakhmcDFSbE5udjgrNmdJSXlYMUtMU0FIT0tIc1hKaFQx?=
 =?utf-8?B?aUlWRjlWQm5MMjJOSVY5R3RhRXV2WXZreVRIUTExZXZsL3M0cjUzcEdpSmRZ?=
 =?utf-8?B?bktCQkdvZmtuR1JSeWVveDRKTmJMNFdKKzRpNkdpcTlvVXdRcmNhb2Zib1d6?=
 =?utf-8?B?bFBEM2lLSlpPbVlxbE11R3VSaTdKQk1LMnJmWW54dTVvYlE5cU1TRm1sREgr?=
 =?utf-8?B?bmRHTk8xczlyWS9VZzJLeUNMNFYvRG9JSjdEbjdzaTRDUldDWDhhNkJONlNX?=
 =?utf-8?B?eDZwb3Qya3RMLzIrZG9Ea1JpOGh2V2FnL0J0U25hUklsbEF4MzVmczd4QzQy?=
 =?utf-8?B?eGZBcGIvL3VCdmYyekF4aUFha2NENlNtRk5rVjdnSWUvUHdTM09tRVpRSlJC?=
 =?utf-8?B?ZSsvMjVqRkJDY2MvMGpVOEo2WFUweU4vcmlnd3AyeVhpTEVSUmZHL1czSnRi?=
 =?utf-8?B?KzBRZXQvVW0rMU5YUmppT3RodHFYTEVLM3l6ZlN2OHQwa20wamgzZVVUcUdl?=
 =?utf-8?B?TXp6OG1CQTAycnhTN2tEcWd5S29qWGVxRHg5bXgrZkkrTkNZbUZqRnlJMjdo?=
 =?utf-8?B?YUJKTXNFdDZEQnNYUHlGYVVzY1RlZ2VnOExzTFBrci8wYnZpdjZIczh6M3RK?=
 =?utf-8?B?eHp2dTVrd1NxdjBLVnNzMkFReS9FOXVQeTNnWlNrY0R4YXlwYkgxeWthb0NQ?=
 =?utf-8?B?Y3RrdFFhL2dRUkFreERXamozTnFWZFMzbjVId0NNNlhZQ3dyYThmd2pXYWJD?=
 =?utf-8?B?MTM0eGJ4OTQ3WEVhVHB2Nmg3OEdUNmZBaytpcWYwYjYwSlBEd3BnY0dQQlNO?=
 =?utf-8?B?TzNNMGJEOGdaaDdqRnNRYjdKSTN4b1FYT2xYTzJ2QWx1MjZsdk5HWEhvcWt1?=
 =?utf-8?B?d1NGTXZEc01FeTFadmJqUXg4aTRraXZOWE5XZE54MU1IdW4ySDQ5TGdhQnJZ?=
 =?utf-8?B?YmVvcEJCQ0h2bEQwSzJpaG1SdjNVWkhXRzBoeUorbG1FRUdQbVFzQVRpQUJx?=
 =?utf-8?B?MHZ6Mk5QTDRQcy9NOXV5a2lzZzdtVTdGT1VoYzh2eWhsbGQ5UUJHRkVteGd5?=
 =?utf-8?B?ZG4rZjNYcXFtZlcybEdyRTZMamREOUNPWG1LZlAvSHU0L0Zsb20xWTlIZTc3?=
 =?utf-8?B?WU9sREt3czVySi9qaVlraGJ0SmhneG0xQW14emE0K0ZQa1ZIZ0VnZmc0VElr?=
 =?utf-8?B?dm05Rjc0Z2xIQll3cW1ma09xTzdsUzJNTEFYOE1QQ1FNbkxnRkJKczFLejJZ?=
 =?utf-8?Q?HEatGkUT2uzWd99iNIiMmDiH7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34F853E8BD441E4095F134B66D03BB62@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0ec95d-4f0f-4bde-659c-08da66af15b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 22:12:19.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qn6rZO2Bsp07/Vlj26QotK93qa5k29h+9UQ/2akGXmNRb1O0muSfcJR8EwyWKPaUYX1dsW8y7jrR93f4iTz/FFI8yGZRjwphNXpFBPqgBA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6747
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAyMTo0MCwgSmltIE1hdHRzb24gd3JvdGU6DQo+IE9uIFRodSwgSnVsIDE0
LCAyMDIyIGF0IDY6MDcgUE0gQW5kcmV3IENvb3BlciA8QW5kcmV3LkNvb3BlcjNAY2l0cml4LmNv
bT4gd3JvdGU6DQo+PiBPbiAxNS8wNy8yMDIyIDAxOjI5LCBKaW0gTWF0dHNvbiB3cm90ZToNCj4+
PiBXaGF0IGlzIHRoZSB2YWx1ZSBpbiBjb25mbGF0aW5nIHRoZSBJbnRlbCBhbmQgQU1EIGZpbmRp
bmdzIHVuZGVyIHRoZQ0KPj4+IHNhbWUgbW9uaWtlciAoYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYyk/IFRoZSB2dWxuZXJhYmlsaXRpZXMgc2VlbQ0KPj4+IHF1aXRlIGRpZmZlcmVudCB0byBt
ZS4NCj4+IFRoZXkgYXJlIGVudGlyZWx5IGRpZmZlcmVudCwgYmV5b25kIHRoZSBmYWN0IHRoYXQg
dGhleSBib3RoIHBlcnRhaW4gdG8NCj4+IHRoZSBgcmV0YCBpbnN0cnVjdGlvbi4NCj4gQlRDIGFm
ZmVjdHMgbXVjaCBtb3JlIHRoYW4ganVzdCB0aGUgJ3JldCcgaW5zdHJ1Y3Rpb24uDQoNClllYWgu
wqAgQlRDIGxldHMgeW91IGNhdXNlIGEgbm9wIHRvIHNwZWN1bGF0ZSB0byBhbiBhcmJpdHJhcnkg
ZGVzdGluYXRpb24uDQoNClRoaXMgcmVhbGx5IG91Z2h0IHRvIHRlcnJpZnkgcGVvcGxlIG1vcmUg
dGhhbiBpdCBhcHBlYXJzIHRvIGhhdmUgZG9uZQ0KdGh1cyBmYXIuLi4NCg0KUmV0YmxlZWQgaXMg
anVzdCB0aGUgdGlwIG9mIGEgbXVjaCBsYXJnZXIgaWNlYmVyZy4NCg0KPj4+IE9uIHRoZSBBTUQg
c2lkZSwgaG93ZXZlciwgQnJhbmNoIFR5cGUgQ29uZnVzaW9uIGlzIGEgbXVjaCBiaWdnZXIgZGVh
bC4NCj4+PiBBbGwgaW5zdHJ1Y3Rpb25zIGFyZSBzdWJqZWN0IHRvIHN0ZWVyaW5nIGJ5IEJUSSwg
bm90IGp1c3QgcmV0dXJucyB3aXRoDQo+Pj4gYW4gZW1wdHkgUlNCLg0KPj4+DQo+Pj4gRG9uJ3Qg
dGhlc2UgdHdvIHZ1bG5lcmFiaWxpdGllcyBkZXNlcnZlIHNlcGFyYXRlIG5hbWVzIChhbmQgZG9u
J3Qgd2UNCj4+PiBhbHJlYWR5IGhhdmUgYSBuYW1lIGZvciB0aGUgZmlyc3Qgb25lKT8NCj4+Pg0K
Pj4+IFRhbmdlbnRpYWxseSwgSSBiZWxpZXZlIHRoYXQgdGhlIGZvbGxvd2luZyBsaW5lIGlzIHdy
b25nOg0KPj4+IFZVTE5CTF9JTlRFTF9TVEVQUElOR1MoU0tZTEFLRV9YLCBYODZfU1RFUFBJTkdf
QU5ZLCBNTUlPIHwgUkVUQkxFRUQpLA0KPj4+DQo+Pj4gU3RlcHBpbmdzIDUsIDYsIGFuZCA3IGFy
ZSAiQ2FzY2FkZSBMYWtlLCIgd2l0aCBlSUJSUywgYW5kIEkgZG9uJ3QNCj4+PiB0aGluayBDYXNj
YWRlIExha2Ugc3VmZmVycyBmcm9tIFJTQkEuDQo+PiBBcyBkb2N1bWVudGVkLCBDYXNjYWRlIExh
a2UgZG9lcyBzdWZmZXIgUlNCQSB3aGVuIGVJQlJTIGlzbid0IGFjdGl2ZSwgc28NCj4+IGl0J3Mg
bm90IGEgYmluYXJ5IGFmZmxpY3Rpb24gc3RhdGUuDQo+IElzIHRoZXJlIG5vIHZhbHVlIGluIHNl
cGFyYXRpbmcgUlJTQkEgZnJvbSBSU0JBPyBQZXIgVGFibGUgMSBpbg0KPiBJbnRlbCdzICJSZXR1
cm4gU3RhY2sgQnVmZmVyIFVuZGVyZmxvdyIgdGVjaG5pY2FsIHBhcGVyLCBDYXNjYWRlIExha2UN
Cj4gZXhoaWJpdHMgUlJTQkEgYmVoYXZpb3IsIGJ1dCBub3QgUlNCQSBiZWhhdmlvci4NCg0KVGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiBSUlNCQSBhbmQgUlNCQSBpcyB3aGV0aGVyIGVJQlJTIGlzIGFj
dGl2ZSBvcg0Kbm90LsKgIEFjY29yZGluZyB0byB0aGUgY3VycmVudCBlSUJSUyBkb2N1bWVudGF0
aW9uLg0KDQpUaGlzIGlzIGEgbm90LXZlcnktc3VidGxlIGhpbnQgdG8gSW50ZWwgdGhhdCBvdGhl
ciB0aGluZ3MgbmVlZHMgdXBkYXRpbmcNCmluIG9yZGVyIHRvIG1ha2UgdGhlaXIgcHVibGljIHN0
YXRlbWVudHMgc2VsZi1jb25zaXN0ZW50Lg0KDQp+QW5kcmV3DQo=
