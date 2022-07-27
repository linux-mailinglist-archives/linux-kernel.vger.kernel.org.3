Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878F85829D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiG0Png (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiG0Pne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:43:34 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B3BF5E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658936613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lmlnHnArL5v80qKyMZxUKO3fUF2TRhOSDyN3EhMWdb4=;
  b=EJw0djbGjcmjOY+V3rP7Vb8qw5XWNrjS19sIJkziiJ+AZDmTQcbQBRj2
   5eyw9KRlu1yE5jhYM4uy3zGnmcmXxhb3Gqx3G066ZSKnkT929NUMvWYzN
   9Q5JXhEGVTY/753a54p9Kj1yvnfmG3UJamW7WzhTEptpjHD+fJUIo0DBv
   w=;
X-IronPort-RemoteIP: 104.47.66.41
X-IronPort-MID: 76754590
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AcGuzb6nLvUM3QxzrwbS6JRTo5mJPLRN5O6RN2?=
 =?us-ascii?q?KgSYk/6f7AAGkVYHNDTQj8QOYZgVIWol2/guFWZSjo8ma2h7z6V58zBmKLov?=
 =?us-ascii?q?MHZLz/hCwAjLFrumKVI1MYEijjmPTMeGCDMwYJHjcJ4hTM8yHf7I9go6H95Y?=
 =?us-ascii?q?m4D+coK4wL/vp92hpslD/CcOo0iTCjEeD7LRE03QJR7k4hxYSy2ynPwDMIB7?=
 =?us-ascii?q?Yc2rRYlHjFXn3EHS/2jeaZwGCri9WChcjAt3GOYxiobk9pZHGqom3mgc298I?=
 =?us-ascii?q?9bnPcGthddnImpEkKiO1GxVb+5kiVcUhbufMay+/YvHNhabBeoxqrSjg7gxb?=
 =?us-ascii?q?sBMzdm+6S/PcIv7zb5ueicxYu2GyZe8BwF0WQuKkcaDQBWj7Nb8Rh/LF3RuV?=
 =?us-ascii?q?V/5wrhd/j3STLDlBacXM58wqJsypZ4FjIkaDJ4vmZCD0RD6xwQibBkck/Vos?=
 =?us-ascii?q?8hkQPB36X4vxIUoeMz1++2DBsJbpyemAQVO00Q2cJjmr5JJBi0AL6nvengMx?=
 =?us-ascii?q?8iiP46sZqh0azHr+B9iS9LvvOSfEu6imiuEBVwr1iKD7W2RgCsOFOAw5eUJN?=
 =?us-ascii?q?s+nARPwn5W8l2f8Txk5GymnG1lYnjYEibsZ4dKfZL/tbunkL9FHDFpBCVLDd?=
 =?us-ascii?q?jOoPerY82IJyCm9ekxlMHqhinIA1HvgZCctcHfLAwVVC5Xj59OBvIMhApMb2?=
 =?us-ascii?q?LJQH3MGJ6TY/rhHPZQ43PDaaNbN7/j+NwxU5PQh1+EBC7qpWEIsrEzF0fUK3?=
 =?us-ascii?q?AzZ5xRoGZYmDyVjvSl1fZywir9x9a6o5bmTqcmdTpegJF3OOTore30OHRlml?=
 =?us-ascii?q?4OaQb0HHtZzmF4TsLxQQOX987K1lSXh1VMn6L783ZnfS58ukROhNj27dMyuJ?=
 =?us-ascii?q?bcZrZ9BeLOqMAjy2sgf7HkUBeQ029Z9bDEit1yLWUZoWkQId4vMvbCpGoggn?=
 =?us-ascii?q?Ssl8zE23tsvEmNDAssbzgnaoNevrs16cmNVT4Tig2BZpF0H75ZSDiCunK/fK?=
 =?us-ascii?q?nksORDgXOVlQPNmzaY01TCum3ql8xdJIIt4ULEOXCl77ifSFYzJUfMP7ABzh?=
 =?us-ascii?q?JdVcxlwuHlk2Wjx3V/rJJYQ0EcIu1yxgvLt5wUb6Huk6mefMZrcrZzVqtn/G?=
 =?us-ascii?q?08s6y7Gd72rx8YxD2HZSz6IfD2tI9cyteJ4LU8FZJzBXtOApNuu0Ic1Y1jBV?=
 =?us-ascii?q?0W6NeD82qsq08FcKZe321wAPsijT5szlSGvlgTfY5Vo0p1sanQKWYCeibW7g?=
 =?us-ascii?q?NowFuzfDmySQzWWJJ88GjdLSXs2kFyHabRfqKQq5loe0Klxfqup8fQxpPGbf?=
 =?us-ascii?q?vwDIawbSir2DX80aQE2cv7D8wVUqRlZF2ptXVNQQBiAxXJREkN+vBG7cTQuB?=
 =?us-ascii?q?ZNTRrvz0w+YFifrneM5t0bJDlGVDnD3KWyIS7Pn0Akr8L7J86AW9AeEuXRA7?=
 =?us-ascii?q?asrM3vE4ncsl2Im1XOeh+P7tC05ZBeUWDcYM3hSzWswD9XuFbmknhYJuykmn?=
 =?us-ascii?q?aEYTD0M18PPmWk+ud6+nO32ii3zL/qOhFdqr95VgbcZqGMxHhJU8OVe8TmeP?=
 =?us-ascii?q?ogqG44PMHHi0O5ZX6RiMhsSuJxAdlN8EBVhcYPZ1KRmYaqRAkfElQL4+TGRP?=
 =?us-ascii?q?DPvoRk3gCMPDYbFIbZR7VlwHPfVqhVo1HWz+q7lllPYf33EYyfQyJe50Kn1w?=
 =?us-ascii?q?h9UsV0QAatCswe1sKCWh1Au9dnhcThTT2TP5JaYz/zimI9WOHZaPCEd+g1f0?=
 =?us-ascii?q?YpatYLL+G/vsHcnZrCejK0FZFluIyu4Yio7QH63KXoq4Iopx4IcxmLL9DPQJ?=
 =?us-ascii?q?TdJA8mu3491PVkIi/VHZ3277CWC0vHD0ObI550Joasv60aO//aP8A4fFXVJo?=
 =?us-ascii?q?l5mEyyPJs2iFoVcXL0gSrvd+lnMlfmI70RM3PBd6Cuv3QdYs4eZmmbCYUKNU?=
 =?us-ascii?q?DSL+yok+7d6vJHB8Na1O+pCYmMhxNokBrXW1ZcHA5YFds+mpbWcAOXsxU6qd?=
 =?us-ascii?q?U9HzSYWpOXZZ3CPFy87MQvxfpfrkcFAlNOZhnrqmj9pgdJoCXsDzi32JC0DP?=
 =?us-ascii?q?JG+hebvio8NrZlug3bAEOKDYA06pjysBtlHGKwsFC4HWwncYwJrMGR+JL30b?=
 =?us-ascii?q?kv7uo6LqY6CxA54I5D32+mly3Tn5utEpy2bnQLYmji4NRzOhDy408vVvlSLQ?=
 =?us-ascii?q?DQgCETZgRg3azWFimzxbNwebOxBIAC+B9cUtJXC66LVtobACgwUYJkk1CKVs?=
 =?us-ascii?q?BYYHkYWCOqksSM6Uz06D1bL/Yjv1qDYWeRjUb9YNQOKfyaA8Eb3oKPrL/7bW?=
 =?us-ascii?q?bfuSYc0xMM4Z0NuOuJe64Aa0PtTcRYiJ8UsMWzfsDn7s5Bz0c7ipBBV8RH1G?=
 =?us-ascii?q?Bzm4f8T/KN3lBgfSUR/bVdFY4FHfP4CnrADGTFdigVsCy5pK4IanBbrVMLei?=
 =?us-ascii?q?Rj/U5qyvhDKukvXqNTl3Mth0pztivm/oreZuAbjjTi+ABETBRnrcCuazesSk?=
 =?us-ascii?q?CUHM795D4YTfBfUj4+iqT/dW2nKPgw/WiQV0Mi4kR8GnslyM5Oshu0RjtZ9t?=
 =?us-ascii?q?ZU9jH6AsGq2QG3m5x9AlFS8wXp0DuelkeXCz+G+Z5dK5F8vpMUpAlKcBha/P?=
 =?us-ascii?q?t++g4JjgmYyb2AcwoMR19c7J8YiuotIJhAnLSlASEWtaiZMP9o5Oez2nq+D0?=
 =?us-ascii?q?rOS8EOTZS8PnjFE7m3TQd+yUwkDIAppM0oYWpcQV6/AwkHCUljwkzh0M57Vt?=
 =?us-ascii?q?Wdyv5u3A4cYJjt/5BsIoHaZHD65m9YPA7nw1CyMLZ7cp4IqNoxUdXeaT9TA9?=
 =?us-ascii?q?j7O3dClLiuY2u+V0LmL2LF9wxGGuS6W/oGoA4DBqGLlaSpaJ7aGGW7FoptIP?=
 =?us-ascii?q?TPxwIaDf2I56OkdifLZ3HCiIGbPUNmoWOipiewuwwqsuLaAMnyAX/U6LKyFO?=
 =?us-ascii?q?yF4zyXIlBM7lOt2sE18zDpgIZdir9W72Q9BXXcLwzII48ado0/e1gcyJGJN+?=
 =?us-ascii?q?BgGG0rGKBU9U5kYiFr2khmLwr9wU3NW9PK+yvukxjrIqhBqAr9wS2nQlPImM?=
 =?us-ascii?q?FN1p5CQLZ18mcPi64kMAO+JR1poHxqG+H+a+14BAIzC3tRW8QXSFh1PhGk5w?=
 =?us-ascii?q?/+2znYFRUykijU7fs77glHlUjY75k8OvK30p2HvjFk65rPgGvDJY3luGKZxB?=
 =?us-ascii?q?2LC6diq2tbE9OlqrOB7+Eo1JDV8FaUaZBFOFd4OAMoo2flcbvgcbYFGeSfE9?=
 =?us-ascii?q?I+6vg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.93,195,1654574400"; 
   d="scan'208";a="76754590"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 11:43:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L20fj5+G8DQqAVfiDEDzSA4jJp4ARy59J7N5eThtmCupTHsXJFrrX76RBfECQHo7O3TrRAILkvCYQWKdiK7fRw9/LfKhAfXuTRhme4tnDyPH9kbZQbmnI04GePGSJU2+23xEsMA4CCw/y0rcfAVnxAMmK6FhvaY6LuLmM6+VFJoGDlHm9uchqKpCsqjEUg256GAYPpD82A2gPVFMy/Us+eBctukbUAXFEQx1yP4TnBEPkIWT599eO+Oiab3lGQTeTfn15AvYejptfGc0nftuT58zL+ZfP/6q7H9aj7N/mHNuKSS1wB3Iu+zvOixaAmJjGgNasHRJk3w/9gZ57J4opA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmlnHnArL5v80qKyMZxUKO3fUF2TRhOSDyN3EhMWdb4=;
 b=Z48fT7NFStzGeEWfJxJEminx9rGITdKcHUixM3Hz4rpVWzxt2fGDhNYDiaMxg1fx/02O12LvpOL00UmNMctrDVMteahzO8thcksSY8th9wwf+8eLZwnqN0wBMzHDb8tmOGAIxNTF6OKjk/YnwUcl3+tkFt4mmVFIWpBQNzkXCXN4MzdQDZjcFxgDbC2p3AL24pMeajWeyIZZIOsALlwfAtDv/D7QW6A8/ieObR7pr7PnStJKcrWk90TShSQW0GYmd3o4nxibiMeeGfhF5d/oYw5dwczxrWJxX8XfeRiQ/yqw4lkoCq2aaTP4WZDGgdgEZ8iDcJ3N1Rk/vck3XpWo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmlnHnArL5v80qKyMZxUKO3fUF2TRhOSDyN3EhMWdb4=;
 b=Tu4l40y7jTT2mUK8oRh4fOIzk2cO4apLcYGXs8qY/qzZPPyzsF7TC3xWQpw+jBusXkYg2i3HXcg7Mycab1NpMYvQIMv/+p7whAh0xQNDMdgyphaz8UxBO8ed/cmiS2rgMXwI52Mw7qLhSDSNon+z0dO+9ZIGE5K5wpm2bROAmkI=
Received: from DM5PR03MB3386.namprd03.prod.outlook.com (2603:10b6:4:46::36) by
 SJ0PR03MB6951.namprd03.prod.outlook.com (2603:10b6:a03:419::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 27 Jul
 2022 15:43:29 +0000
Received: from DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f]) by DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f%7]) with mapi id 15.20.5458.026; Wed, 27 Jul 2022
 15:43:29 +0000
From:   Jane Malalane <Jane.Malalane@citrix.com>
To:     Julien Grall <julien@xen.org>, LKML <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
Subject: Re: [PATCH v2] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH v2] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYoO9LZ/coQoD4ekyAV2OZDcw3862SKA0AgAA1ToA=
Date:   Wed, 27 Jul 2022 15:43:29 +0000
Message-ID: <5524b096-e7c5-5b43-eb32-66cc32d9c70f@citrix.com>
References: <20220726125657.12151-1-jane.malalane@citrix.com>
 <51ba135e-a105-036f-b891-e7d9e1bb607d@xen.org>
In-Reply-To: <51ba135e-a105-036f-b891-e7d9e1bb607d@xen.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe9127ba-0b04-425e-03ce-08da6fe6c106
x-ms-traffictypediagnostic: SJ0PR03MB6951:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMTMLfGIU3fwMCGdyIHq1GQviXsMmyr2HRbqgxQPkj0mnZOSBu9GkHUQFFqqmoYCn2pUu2O42Qfo0oAhPUZLs8ApD11YS8LKxWTLkgX6d7vKe50oc4gZ4Bpo2xD7eWhN0z7C8cPfbBrzjHpb6gM1X0gMI2U7xy2WysETedPSQESDbbchrBz0Sen69cyhAgDY/t3qNG/AJXyNavxRzJ7UXL1BaRS0WG4oxQA7qok7GqxgBhl6acc/3w18SFs5QGzugYyVz0+mNRiNuF9zdVuP4ZzeVYrUm0i5Hr7jSPP2JOPxeadP4Wqc70jpblegpFNEHZrDQYT834+QHlAIQMZctcMAqMnwvCgMkVx7AoGHZw7dVTiJ5SP0NrYvCm6ociCC11/hsO+GUYdjK5FUHFnW2mkulD+2q/Lhgm3lLpiFtxztnfz2/OGTZiN6PY0P5sY+/sWxK0B1hoKNUeHz84ybaAcdre0hIt6OzU+v8FV2bOxvq2bcH1A43tF0yrdmCE8MBFdNaMM5pMvhGLbF+n6NwQnQ8MRGeiEbTmyeG/mbEpyYi8wlQkZGV47MazSw1CvbhRq8qUuJAJO8Fsq5ISh7TYnwGtO13MPBICtyTZx5XWG+NWZqO39/5rIBbXyuRydVPHZz6FYfpzL+4H4QJLMXveRtKPoFOgCTgANz9pW3orEzBQplPFLNY7Yf+9eBhtrA7I4obf62qvDasT4JadUqS57Fnv/8zKwXXh9fWaoqlMDCdldm9Alvg0/wn1VDRmmuuRN3JAL6AEcIjafLURj6u5O51wPamiul5DOeRo5Lymlt1HkEFP3yCHFPFUIp0oJzmze1qcL1sZIl8HHC8fVOnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB3386.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(38070700005)(8936002)(478600001)(6486002)(76116006)(6506007)(7416002)(53546011)(82960400001)(31696002)(122000001)(55236004)(2616005)(5660300002)(86362001)(36756003)(26005)(6512007)(41300700001)(38100700002)(316002)(31686004)(83380400001)(8676002)(64756008)(2906002)(66446008)(66476007)(4326008)(54906003)(71200400001)(91956017)(66946007)(110136005)(66556008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THhNVlNIMzR5bmxDZVByRWRVRm4zaVo4RVZyOXgyanptZkdneng2NXRkcDdh?=
 =?utf-8?B?RlJLVVFDSUNRZXFUWjV5ZnhOdC9aK3ZEZXpBWXBjK1JGTEFXdmN5RFlGdmpT?=
 =?utf-8?B?SEFzS05mZWo0TVl0MXhJOTdmL0dZRlNEUlFESjB2QVFLMjM5UVRxQjRTVTlt?=
 =?utf-8?B?NTFTMjZGWkthL245RXM3WDdQbjFmOEhoNlc1VldqdkxpaWpEazgzamRDVU1L?=
 =?utf-8?B?bHNrTkpjYUxEMGk4bzljbS9ZT0VNang2eGlQNFp3ZnU5R3QwQmgxZ2xJL2dM?=
 =?utf-8?B?UU9ZUjhYVHptc2dnMXphSkp6R1pvZnRoMzB4cnJJYlRMOHU3anM2REpoQVhG?=
 =?utf-8?B?T0Z1MW9Bd0VPT0sxNXJtTG9xN29nMExSaG1QdnFlOU5meVducnNmOHB0MTVk?=
 =?utf-8?B?VEI1Mk8wZHVrVU1vQmd2VFZBSEU5Z21DMGhqaEdrNjVPN2VTczhEekhnMEQ5?=
 =?utf-8?B?QjJOcG9FVE1xanhsMGpsVmIxREF6WGg5SGZXbElCWm1LWjFrOFdLOVJWSFdw?=
 =?utf-8?B?SVVUS0prTmRLWHA5ZStoT2NpWDkvK0V0NnhxYURyOVJOZkY3QWJ3a250Tm1J?=
 =?utf-8?B?V2svUVgwWmI3QUtMSEhkOG9Lc3FHWEtqb3N4djd5YXczbG5kMnpTZmdkSGpB?=
 =?utf-8?B?SVlIWVdPaTRncldwNW1hRDlIVXk3d2V6YWJGOHV5cVZUTzdOcXBQRk0vcHRG?=
 =?utf-8?B?K24wR1VUUEtQS09KM3cvWWFxeVI0RlBDdFB3cXUzWDZzajZoQjd1UUhtbElE?=
 =?utf-8?B?V3N1Nm9NUlVYY0RreitXSFJ6MDMyQXEySFVHSHN5d0NrQ2ExSVp5eVJWa3Vp?=
 =?utf-8?B?d2hnQ2hHWW5NUUNyc0hYL3psMDFWajZTdFlua1hrby9WdUFuRFJtMXJLR25N?=
 =?utf-8?B?QXRZSG5IOXp6TFB3MzNkTDBvdkZEL0kvelVndnV2WmlzQ01zOUNQMFFHS1ZN?=
 =?utf-8?B?dGVPdWw2b2kzMVVFK0RRN1RETmNsV01zb0JLQUh2RlhyU0RIZG5CU05ONWZF?=
 =?utf-8?B?dEQwTmZmaENBUVdDT3lCdzZDdjk5NmlQKzlvWW5LNG44dndqT1BTcW5SNCtr?=
 =?utf-8?B?d3ltQTY2YXA1QzloSHhpNHBTWmRiVzI4WnZJSGM3TEJkbHg0YnBjUHUvSEwr?=
 =?utf-8?B?SVdsS0d4Y08wMFY5UXlWenhrQmVxcysrOTVkanlvUnZYcWpyMVhYRXlRVkpa?=
 =?utf-8?B?UGtuVW5UOHJYbWdqRWhRRTNPbzRXbVdBdmxPN0FQNjljZU5OVGdmSkZPaFpB?=
 =?utf-8?B?WHRrMmVaZDdVOWZOaGhERnluaU5qSm1sTmJMZGFtSUlMcjFQWlV4M29TMXBG?=
 =?utf-8?B?UFk2K3B0a214WDUvQmJQMFRhVnFyWlBoQjJhcXFNTHdCVUlpYnV0UDdXZHBh?=
 =?utf-8?B?eWdSRVA1bDhKSjNEOGR3cVgvMllqWFJJblBpT1ZXSnhOcXVRMHA4K1AxakJU?=
 =?utf-8?B?ZS85UlRVcS9qNDJRQTE0UnlsM2VQTDNsNmY1TC9MeUpDMW5kUjl4T0UxWnZJ?=
 =?utf-8?B?cHdmSEppaFJlaDZ0MGZxZ2pibFNLZDlrWjZoUzZNY2V2cjQ4c1F3Y01xRjBN?=
 =?utf-8?B?cTNKbnJONFFtS01ZanRTcVlYbGV3RzVReVpaRnBiTm1YeFJXamtQOUwyeXpF?=
 =?utf-8?B?UjVPSWEzdms5RGlDalBkYTdyQTFmM0VPaWFQcGNFamFaU0ZwTittRkFtWjVU?=
 =?utf-8?B?d3dNL2hzTC8veDhOZlBVc3E5V2hnOFU2THZqUVJpWHUxclU0R1RETnhJd1VX?=
 =?utf-8?B?OUxzcGRHUm9Bd29INVQwWmV4YVdSNjVjUldoaE9Hb2FIL3BWaml5YmJQamUz?=
 =?utf-8?B?cGNVajM2RHprNm1IT25PcUV5SG1PVE5aSDg4R2lqdFFaWFI1UkgvbW00cVBP?=
 =?utf-8?B?eFJZMHNNQ3FHZWNMVVViV3AwTFJ0MDdseDhNTmltcklaQnB2Skk2eCtiVk01?=
 =?utf-8?B?YlNSMnlUN1pqZTBMRjdtOUpCQXdPMU5LdHc5OCtRdzFhWG9GOURkRzhPR094?=
 =?utf-8?B?R3B2clFpbVlZMWxFc29yTDJFZU9tRHNnT1djM1R1RDh2eTR1T3o1VEJPczlF?=
 =?utf-8?B?T3pBZDFBN1BuaFU0TzRhcllOcHIxakpLVGY3YXdSQ2FnVExJK25FKzAxNzBO?=
 =?utf-8?B?cW02dTgvVWRpcTl1bS9hOVFkRkZXelg1dVN6UDFLRlBHU1MvUC9wenlOa2Ru?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFB0CC691C75D94B8E5C079FB2D60841@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB3386.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9127ba-0b04-425e-03ce-08da6fe6c106
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 15:43:29.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDVEaXBpzlGRwrCjJD+220HQTtkn6sSsdVnceeHP+7U4rYPAS/j/2fDDwkm3xW5oUueBVeEbs4yx2PqV2CFZ+XI8Wi3T/+pHsajLBsozqf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6951
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDcvMjAyMiAxMzozMiwgSnVsaWVuIEdyYWxsIHdyb3RlOg0KPiBbQ0FVVElPTiAtIEVY
VEVSTkFMIEVNQUlMXSBETyBOT1QgcmVwbHksIGNsaWNrIGxpbmtzLCBvciBvcGVuIA0KPiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBhbmQga25vdyB0aGUg
Y29udGVudCBpcyANCj4gc2FmZS4NCj4gDQo+IEhpIEphbmUsDQo+IA0KPiBPbiAyNi8wNy8yMDIy
IDEzOjU2LCBKYW5lIE1hbGFsYW5lIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hl
bi9zdXNwZW5kX2h2bS5jIGIvYXJjaC94ODYveGVuL3N1c3BlbmRfaHZtLmMNCj4+IGluZGV4IDlk
NTQ4YjBjNzcyZi4uMGM0Zjc1NTRiN2NjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYveGVuL3N1
c3BlbmRfaHZtLmMNCj4+ICsrKyBiL2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+PiBAQCAt
NSw2ICs1LDcgQEANCj4+IMKgICNpbmNsdWRlIDx4ZW4vaHZtLmg+DQo+PiDCoCAjaW5jbHVkZSA8
eGVuL2ZlYXR1cmVzLmg+DQo+PiDCoCAjaW5jbHVkZSA8eGVuL2ludGVyZmFjZS9mZWF0dXJlcy5o
Pg0KPj4gKyNpbmNsdWRlIDx4ZW4vZXZlbnRzLmg+DQo+PiDCoCAjaW5jbHVkZSAieGVuLW9wcy5o
Ig0KPj4gQEAgLTE0LDYgKzE1LDEzIEBAIHZvaWQgeGVuX2h2bV9wb3N0X3N1c3BlbmQoaW50IHN1
c3BlbmRfY2FuY2VsbGVkKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHhlbl9odm1faW5pdF9zaGFy
ZWRfaW5mbygpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHhlbl92Y3B1X3Jlc3RvcmUoKTsNCj4+
IMKgwqDCoMKgwqAgfQ0KPj4gLcKgwqDCoCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9yKCk7DQo+
PiArwqDCoMKgIGlmICh4ZW5fcGVyY3B1X3VwY2FsbCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIHVu
c2lnbmVkIGludCBjcHU7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgZm9yX2VhY2hfb25saW5l
X2NwdShjcHUpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUdfT04oeGVuX3NldF91cGNh
bGxfdmVjdG9yKGNwdSkpOw0KPj4gK8KgwqDCoCB9IGVsc2Ugew0KPj4gK8KgwqDCoMKgwqDCoMKg
IHhlbl9zZXR1cF9jYWxsYmFja192ZWN0b3IoKTsNCj4+ICvCoMKgwqAgfQ0KPj4gwqDCoMKgwqDC
oCB4ZW5fdW5wbHVnX2VtdWxhdGVkX2RldmljZXMoKTsNCj4+IMKgIH0NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyANCj4+IGIvZHJpdmVycy94ZW4vZXZl
bnRzL2V2ZW50c19iYXNlLmMNCj4+IGluZGV4IDQ2ZDkyOTVkOWE2ZS4uMmFkOTM1OTVkMDNhIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4+ICsrKyBi
L2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+PiBAQCAtNDgsNiArNDgsNyBAQA0K
Pj4gwqAgI2luY2x1ZGUgPGFzbS94ZW4vcGNpLmg+DQo+PiDCoCAjZW5kaWYNCj4+IMKgICNpbmNs
dWRlIDxhc20vc3luY19iaXRvcHMuaD4NCj4+ICsjaW5jbHVkZSA8YXNtL3hlbi9jcHVpZC5oPg0K
PiANCj4gVGhpcyBpbmNsdWRlIGRvZXNuJ3QgZXhpc3Qgb24gQXJtIGFuZCB3aWxsIHJlc3VsdCB0
byBhIGJ1aWxkIGZhaWx1cmU6DQo+IA0KPiBsaW51eC9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRz
X2Jhc2UuYzo1MToxMDogZmF0YWwgZXJyb3I6IA0KPiBhc20veGVuL2NwdWlkLmg6IE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkNCj4gIMKgwqAgNTEgfCAjaW5jbHVkZSA8YXNtL3hlbi9jcHVpZC5o
Pg0KPiAgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+DQpU
aGFua3MsIHdpbGwgcGxhY2UgaXQgaW5zaWRlIHRoZSAjaWZkZWYgQ09ORklHX1g4Ni4NCj4gDQo+
PiDCoCAjaW5jbHVkZSA8YXNtL3hlbi9oeXBlcmNhbGwuaD4NCj4+IMKgICNpbmNsdWRlIDxhc20v
eGVuL2h5cGVydmlzb3IuaD4NCj4+IMKgICNpbmNsdWRlIDx4ZW4vcGFnZS5oPg0KPj4gQEAgLTIx
OTUsMTEgKzIxOTYsNDggQEAgdm9pZCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9yKHZvaWQpDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FsbGJhY2tfdmlhID0gSFZNX0NBTExCQUNLX1ZFQ1RPUihI
WVBFUlZJU09SX0NBTExCQUNLX1ZFQ1RPUik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHhl
bl9zZXRfY2FsbGJhY2tfdmlhKGNhbGxiYWNrX3ZpYSkpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHByX2VycigiUmVxdWVzdCBmb3IgWGVuIEhWTSBjYWxsYmFjayB2ZWN0b3IgZmFp
bGVkXG4iKTsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhlbl9oYXZlX3ZlY3Rvcl9jYWxs
YmFjayA9IDA7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5faGF2ZV92ZWN0b3JfY2Fs
bGJhY2sgPSBmYWxzZTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoMKgIH0N
Cj4+IMKgIH0NCj4+ICsvKiBTZXR1cCBwZXItdkNQVSB2ZWN0b3ItdHlwZSBjYWxsYmFja3MgYW5k
IHRyaWNrIHRvb2xzdGFjayB0byB0aGluaw0KPj4gKyAqIHdlIGFyZSBlbmxpZ2h0ZW5lZC4gSWYg
dGhpcyBzZXR1cCBpcyB1bmF2YWlsYWJsZSwgZmFsbGJhY2sgdG8gdGhlDQo+PiArICogZ2xvYmFs
IHZlY3Rvci10eXBlIGNhbGxiYWNrLiAqLw0KPj4gK3N0YXRpYyBfX2luaXQgdm9pZCB4ZW5faW5p
dF9zZXR1cF91cGNhbGxfdmVjdG9yKHZvaWQpDQo+PiArew0KPj4gK8KgwqDCoCB1bnNpZ25lZCBp
bnQgY3B1ID0gMDsNCj4+ICsNCj4+ICvCoMKgwqAgaWYgKCF4ZW5faGF2ZV92ZWN0b3JfY2FsbGJh
Y2spDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoKGNw
dWlkX2VheCh4ZW5fY3B1aWRfYmFzZSgpICsgNCkgJiANCj4+IFhFTl9IVk1fQ1BVSURfVVBDQUxM
X1ZFQ1RPUikgJiYNCj4+ICvCoMKgwqDCoMKgwqDCoCAheGVuX3NldF91cGNhbGxfdmVjdG9yKGNw
dSkgJiYgIXhlbl9zZXRfY2FsbGJhY2tfdmlhKDEpKQ0KPiANCj4geGVuX2NwdWlkX2Jhc2UoKSBp
cyBhbiB4ODYtaXNtLiBUaGlzIGlzIGdvaW5nIHRvIGJ1aWxkIGJlY2F1c2UgDQo+IENPTkZJR19Y
RU5fUFZIVk0gaXMgb25seSBzZXQgZm9yIHg4Ni4gSG93ZXZlciwgSSB0aGluayB0aGlzIGlzIHF1
aXRlIA0KPiBmcmFnaWxlLg0KPiANCj4gWW91IGFyZSBhbHNvIHVzaW5nIG1vcmUgdmFyaWFibGUg
ZGVmaW5lZCBvbmx5IG9uIHg4Ni4gU28gaXQgZmVlbHMgdG8gbWUgDQo+IHRoYXQgdGhlc2UgZnVu
Y3Rpb25zIHNob3VsZCBiZSBpbXBsZW1lbnRlZCBpbiB4ODYgY29kZS4NCkkgY2FuIHN1cnJvdW5k
IHRob3NlIDQgY2FsbGJhY2svdXBjYWxsIGZ1bmN0aW9ucyB3aXRoIGFuICMjaWZkZWYuPj4gDQor
wqDCoMKgwqDCoMKgwqAgeGVuX3BlcmNwdV91cGNhbGwgPSB0cnVlOw0KPj4gK8KgwqDCoCBlbHNl
IGlmICh4ZW5fZmVhdHVyZShYRU5GRUFUX2h2bV9jYWxsYmFja192ZWN0b3IpKQ0KPj4gK8KgwqDC
oMKgwqDCoMKgIHhlbl9zZXR1cF9jYWxsYmFja192ZWN0b3IoKTsNCj4+ICvCoMKgwqAgZWxzZQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgIHhlbl9oYXZlX3ZlY3Rvcl9jYWxsYmFjayA9IGZhbHNlOw0KPj4g
K30NCj4+ICsNCj4+ICtpbnQgeGVuX3NldF91cGNhbGxfdmVjdG9yKHVuc2lnbmVkIGludCBjcHUp
DQo+PiArew0KPj4gK8KgwqDCoCBpbnQgcmM7DQo+PiArwqDCoMKgIHhlbl9odm1fZXZ0Y2huX3Vw
Y2FsbF92ZWN0b3JfdCBvcCA9IHsNCj4+ICvCoMKgwqDCoMKgwqDCoCAudmVjdG9yID0gSFlQRVJW
SVNPUl9DQUxMQkFDS19WRUNUT1IsDQo+PiArwqDCoMKgwqDCoMKgwqAgLnZjcHUgPSBwZXJfY3B1
KHhlbl92Y3B1X2lkLCBjcHUpLA0KPj4gK8KgwqDCoCB9Ow0KPj4gKw0KPj4gK8KgwqDCoCByYyA9
IEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX3NldF9ldnRjaG5fdXBjYWxsX3ZlY3RvciwgJm9wKTsN
Cj4+ICvCoMKgwqAgaWYgKHJjKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByYzsNCj4+ICsN
Cj4+ICvCoMKgwqAgaWYgKCFjcHUpDQo+PiArwqDCoMKgwqDCoMKgwqAgcmMgPSB4ZW5fc2V0X2Nh
bGxiYWNrX3ZpYSgxKTsNCj4+ICsNCj4+ICvCoMKgwqAgcmV0dXJuIHJjOw0KPj4gK30NCj4+ICsN
Cj4+IMKgIHN0YXRpYyBfX2luaXQgdm9pZCB4ZW5fYWxsb2NfY2FsbGJhY2tfdmVjdG9yKHZvaWQp
DQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIGlmICgheGVuX2hhdmVfdmVjdG9yX2NhbGxiYWNrKQ0K
Pj4gQEAgLTIyMTAsNiArMjI0OCw4IEBAIHN0YXRpYyBfX2luaXQgdm9pZCB4ZW5fYWxsb2NfY2Fs
bGJhY2tfdmVjdG9yKHZvaWQpDQo+PiDCoCB9DQo+PiDCoCAjZWxzZQ0KPj4gwqAgdm9pZCB4ZW5f
c2V0dXBfY2FsbGJhY2tfdmVjdG9yKHZvaWQpIHt9DQo+PiArc3RhdGljIGlubGluZSB2b2lkIHhl
bl9pbml0X3NldHVwX3VwY2FsbF92ZWN0b3Iodm9pZCkge30NCj4+ICtpbnQgeGVuX3NldF91cGNh
bGxfdmVjdG9yKHVuc2lnbmVkIGludCBjcHUpIHt9DQo+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQg
eGVuX2FsbG9jX2NhbGxiYWNrX3ZlY3Rvcih2b2lkKSB7fQ0KPj4gwqAgI2VuZGlmDQo+PiBAQCAt
MjI3MSwxMCArMjMxMSw5IEBAIHZvaWQgX19pbml0IHhlbl9pbml0X0lSUSh2b2lkKQ0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlmICh4ZW5faW5pdGlhbF9kb21haW4oKSkNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHBjaV94ZW5faW5pdGlhbF9kb21haW4oKTsNCj4+IMKgwqDCoMKgwqAg
fQ0KPj4gLcKgwqDCoCBpZiAoeGVuX2ZlYXR1cmUoWEVORkVBVF9odm1fY2FsbGJhY2tfdmVjdG9y
KSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgIHhlbl9zZXR1cF9jYWxsYmFja192ZWN0b3IoKTsNCj4+
IC3CoMKgwqDCoMKgwqDCoCB4ZW5fYWxsb2NfY2FsbGJhY2tfdmVjdG9yKCk7DQo+PiAtwqDCoMKg
IH0NCj4+ICvCoMKgwqAgeGVuX2luaXRfc2V0dXBfdXBjYWxsX3ZlY3RvcigpOw0KPj4gK8KgwqDC
oCB4ZW5fYWxsb2NfY2FsbGJhY2tfdmVjdG9yKCk7DQo+PiArDQo+PiDCoMKgwqDCoMKgIGlmICh4
ZW5faHZtX2RvbWFpbigpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbmF0aXZlX2luaXRfSVJR
KCk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS94ZW4vaHZtLmggYi9pbmNsdWRlL3hlbi9odm0u
aA0KPj4gaW5kZXggYjdmZDdmYzlhZDQxLi44ZGE3YTY3NDcwNTggMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL3hlbi9odm0uaA0KPj4gKysrIGIvaW5jbHVkZS94ZW4vaHZtLmgNCj4+IEBAIC02MCw0
ICs2MCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGh2bV9nZXRfcGFyYW1ldGVyKGludCBpZHgsIA0K
Pj4gdWludDY0X3QgKnZhbHVlKQ0KPj4gwqAgdm9pZCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9y
KHZvaWQpOw0KPj4gK2ludCB4ZW5fc2V0X3VwY2FsbF92ZWN0b3IodW5zaWduZWQgaW50IGNwdSk7
DQo+PiArDQo+PiDCoCAjZW5kaWYgLyogWEVOX0hWTV9IX18gKi8NCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3hlbi9pbnRlcmZhY2UvaHZtL2h2bV9vcC5oIA0KPj4gYi9pbmNsdWRlL3hlbi9pbnRl
cmZhY2UvaHZtL2h2bV9vcC5oDQo+PiBpbmRleCBmMzA5N2U3OWJiMDMuLmU3MTRkOGI2ZWY4OSAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUveGVuL2ludGVyZmFjZS9odm0vaHZtX29wLmgNCj4+ICsr
KyBiL2luY2x1ZGUveGVuL2ludGVyZmFjZS9odm0vaHZtX29wLmgNCj4+IEBAIC00Niw0ICs0Niwx
OSBAQCBzdHJ1Y3QgeGVuX2h2bV9nZXRfbWVtX3R5cGUgew0KPj4gwqAgfTsNCj4+IMKgIERFRklO
RV9HVUVTVF9IQU5ETEVfU1RSVUNUKHhlbl9odm1fZ2V0X21lbV90eXBlKTsNCj4+ICsvKg0KPj4g
KyAqIEhWTU9QX3NldF9ldnRjaG5fdXBjYWxsX3ZlY3RvcjogU2V0IGEgPHZlY3Rvcj4gdGhhdCBz
aG91bGQgYmUgdXNlZCANCj4+IGZvciBldmVudA0KPj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFubmVsIHVwY2Fs
bHMgb24gdGhlIHNwZWNpZmllZCANCj4+IDx2Y3B1Pi4gSWYgc2V0LA0KPj4gKyAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0
aGlzIHZlY3RvciB3aWxsIGJlIHVzZWQgaW4gDQo+PiBwcmVmZXJlbmNlIHRvIHRoZQ0KPj4gKyAq
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkb21haW4gZ2xvYmFsIGNhbGxiYWNrIHZpYSAoc2VlDQo+PiArICrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhW
TV9QQVJBTV9DQUxMQkFDS19JUlEpLg0KPj4gKyAqLw0KPiANCj4gVGVjaG5pY2FsbHkgdGhpcyBo
eXBlcmNhbGwgaXMgeDg2IHNwZWNpZmljLiBJT1csIGl0IHdvdWxkIGJlIHBvc3NpYmxlIA0KPiBm
b3IgYW5vdGhlciBhcmNoaXRlY3R1cmUgdG8gZGVmaW5lIDIzIGZvciBzb21ldGhpbmcgZGlmZmVy
ZW50Lg0KPiANCj4gSWYgaXQgaXMgbm90IHBvc3NpYmxlIChvciBkZXNpcmVkKSB0byBzdXJyb3Vu
ZCB3aXRoIGFuICNpZmRlZiwgdGhlbiBJIA0KPiB0aGluayB3ZSBzaG91bGQgYXQgbGVhc3QgYmUg
bWVudGlvbmVkIGl0IGluIHRoZSBjb21tZW50Lg0KSW4gWGVuIGl0IGlzIHN1cnJvdW5kZWQgd2l0
aCBhbiAjaWZkZWYuIEkgYW0gaGFwcHkgdG8gZG8gc28gaGVyZSB0b28sIA0KdW5sZXNzIHRoZXJl
IGlzIGFueSBvcHBvc2l0aW9uLg0KDQpUaGFuayB5b3UsDQoNCkphbmUu
